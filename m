Return-Path: <linux-kernel+bounces-90369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A427B86FE42
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8CB2818E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24101224FB;
	Mon,  4 Mar 2024 10:02:19 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C372225DF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546538; cv=none; b=i3gYO70kfmqOT0SR6WAWWtNWOmNCWO9CzsOr1z4LjukVebIUkNhiPFvDJpSP2i78R3vBVbq3Cy+B5uIAEDTPCXviNDFOdp366sFTEaHKJnpZHX9Wn12hkYYJv59HXujHDY7MVdPObb7traC98SylncoqPfd+/s33ZXLh/327/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546538; c=relaxed/simple;
	bh=fs+dn1KZl06mxOaRXQyIVqpj15EiHFUABl6v9QMnbgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsXmtOlGsRCYKGrLrFnIsNPb3SDriYK1GPaeahjtzLTgGjFkxfpUC9Tl2yXLh53Ha84CqXiJgfocrIfeLsdvf6QLuslmnkhrCDEntHKKvDHxEl8i2e22McdgfPeOaQUb28odFkBAj+Vbsv+dumm0Ql1VyCXhbFA+jqjHupTE6pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp83t1709546464tu9e1xsu
X-QQ-Originating-IP: kh9aUmyxjyUl4zwZL1fChSvzQIYaeJHkGEmOd9fAvBQ=
Received: from localhost ( [112.22.30.30])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Mar 2024 18:01:03 +0800 (CST)
X-QQ-SSF: 01400000000000505000000A0000000
X-QQ-FEAT: +oIWmpEafD8OVAQfNNpTjIHw8qZhJIYDRrXOZUtmxSmzmlacXcINFLIpaIMVt
	huQSSluLBpbnu7UeOPiaU+D5ZRAiHAYgyNlyp8yb98m0dzevjhiPyzPdWF4x36miGPHU/a+
	iG2GmJlMxZwNtfhbiFn5WDklX23pYbAIaTD6RLCUVnDthdxk4nXdqZmZJdLBvm2Yg/q8rz8
	l90RIkO0EaoSKWkiHAVUJvsVel6OFJw5XA6YubVcadD5X4TYZ3aEDGvFnH1X2lpC+Iqw4G0
	m9nwHcp4yA3Jli9cEA40/tFCPD/v4iYM+m9bFnxUWvl6THUQCqXkZ+4Ebkmkn4Gb1xVHBG/
	QkbpLaU3hS8KxJCfgtOeT+pDhva6PAZKgWMVi2mPoHro2Seums8QcY3oD2XaGquOK9BclSR
	fcnWn53r8HVbny0pQUT4ig==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5907862964829062476
Date: Mon, 4 Mar 2024 18:01:03 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: daire.mcnamara@microchip.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] firmware: microchip: Fix over-requested allocation size
Message-ID: <04A659134520CC60+ZeWb3xHvErS113zU@centos8>
References: <20240304092532.125751-1-dawei.li@shingroup.cn>
 <20240304-dislike-enchanted-bab883cdd609@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-dislike-enchanted-bab883cdd609@wendy>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Conor,

Thanks for the quick review.

On Mon, Mar 04, 2024 at 09:52:52AM +0000, Conor Dooley wrote:
> Hey,
> 
> On Mon, Mar 04, 2024 at 05:25:32PM +0800, Dawei Li wrote:
> > cocci warnings: (new ones prefixed by >>)
> > >> drivers/firmware/microchip/mpfs-auto-update.c:387:72-78:
> >    ERROR: application of sizeof to pointer
> >    drivers/firmware/microchip/mpfs-auto-update.c:170:72-78:
> >    ERROR: application of sizeof to pointer
> > 
> > response_msg is a pointer to u32, so the size of element it points to is
> > supposed to be a multiple of sizeof(u32), rather than sizeof(u32 *).
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202403040516.CYxoWTXw-lkp@intel.com/
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  drivers/firmware/microchip/mpfs-auto-update.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
> > index 682e417be5a3..7ea3cdb917bc 100644
> > --- a/drivers/firmware/microchip/mpfs-auto-update.c
> > +++ b/drivers/firmware/microchip/mpfs-auto-update.c
> > @@ -384,7 +384,7 @@ static int mpfs_auto_update_available(struct mpfs_auto_update_priv *priv)
> >  	u32 *response_msg;
> >  	int ret;
> >  
> > -	response_msg = devm_kzalloc(priv->dev, AUTO_UPDATE_FEATURE_RESP_SIZE * sizeof(response_msg),
> > +	response_msg = devm_kzalloc(priv->dev, AUTO_UPDATE_FEATURE_RESP_SIZE * sizeof(u32),
> 
> Why not use `sizeof(*response_msg)`?

Because checkpatch complains about 100-character violation and I don't
want to wrap lines :)

I will respin V2 as you suggested.

Thanks,

    Dawei

> 
> Cheers,
> Conor.
> 
> >  				    GFP_KERNEL);
> >  	if (!response_msg)
> >  		return -ENOMEM;
> > -- 
> > 2.27.0
> > 



