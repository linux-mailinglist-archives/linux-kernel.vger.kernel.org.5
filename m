Return-Path: <linux-kernel+bounces-38351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F3783BE33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D5D1F2276C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C7B1C6BC;
	Thu, 25 Jan 2024 10:00:53 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC79B1C69A;
	Thu, 25 Jan 2024 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176853; cv=none; b=XfMQe9KF1DW4aZjYQ6jdbtCCFw/JuI2cjLRFjZ0K3dyvt6jdRo6xClBFGx3S6vN58t3YPOcAX3prwpYN61kM25gM8hlNxkWOl+YJ/P3I0eT2r2tuiyVjPuNfW5zxMfMV7jSUsbrc/96xZ48/Z6tXBaDFACiY3ImgLOkfe/Pj8XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176853; c=relaxed/simple;
	bh=CGbHSIy071zY/1LZ1hb5hUgREb+h6t2K1eNPkQDWDMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHgJ89qMcMiJd2nJ7I5C1Amb+xoWMuHlJ39upfM9LlkWL9kUBG0+D9Th86ktjvAck/26q9tSARZ24822sivrF2JeO43H+vtcpCpM8M3QkYjQtyFxkak+shxDAosPRld7pQ3UZF66J8HtWBrAakj7A3SGiEi5FLwFJib1UdRCysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5100cb64e7dso2886936e87.0;
        Thu, 25 Jan 2024 02:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176850; x=1706781650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIe6Br5ZKFh1Sn5GNQpAVH37kfCPS835GRt3i3xglEw=;
        b=EAhhImPV79h73+MaO0ZPLnlAy1ayMJcAQuaHlTX9nkzhsTkudYK1Qk9jxclQvNk71C
         J9cCmjy1ZINRNHvgmUoVGrcp4TP4STRE582anURo1sRlPDpqOp3v25llRHhc5B5sVfhD
         GusEJ9avDB9Lmrz7gc0Ty9AXHgfAN2T14WeScBBrOg5OvXCjW8IA1MvwHtlH//TN02TC
         k7n9MykYuApxecs9i0BX9hmYvfcSPVK+bCSGyadvlaIKIgkwPViDOmmmqndvFOAqiA6E
         42MZ9ttC3/n7wSbaHL8cVacZXYFX8z7pEZRI2uPEMHiwm+jO6UxhDhXHbeEwl/AJDI0H
         6HoA==
X-Gm-Message-State: AOJu0Yxhdq3JMO6stAy6R5xti3kS1CYriWUVN0eSH5E9u+HuXYItBt4t
	IFDBDzSL6AkNf8xsEPwfxp38SfdNHwbzCFY2SHtq63Vo4mVnfYaS
X-Google-Smtp-Source: AGHT+IFwSfVo1AJFrmB/o+ycNXmm5veZY78/OMODtOeGl0vmLCuMZwo4PaCV4KdREkZNrm0kt1OawQ==
X-Received: by 2002:a05:6512:3ba1:b0:50e:62b1:f67b with SMTP id g33-20020a0565123ba100b0050e62b1f67bmr246350lfv.134.1706176849890;
        Thu, 25 Jan 2024 02:00:49 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-119.fbsv.net. [2a03:2880:31ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id rf22-20020a1709076a1600b00a2fb9c0337esm834121ejc.112.2024.01.25.02.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 02:00:49 -0800 (PST)
Date: Thu, 25 Jan 2024 02:00:47 -0800
From: Breno Leitao <leitao@debian.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Alexander Aring <alex.aring@gmail.com>, netdev@vger.kernel.org,
	"open list:IEEE 802.15.4 SUBSYSTEM" <linux-wpan@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 06/10] net: fill in MODULE_DESCRIPTION()s for
 ieee802154
Message-ID: <ZbIxT54XYLzVWx/i@gmail.com>
References: <20240108181610.2697017-1-leitao@debian.org>
 <20240108181610.2697017-7-leitao@debian.org>
 <45711bec-e0f3-43c2-b8f2-b9a55654710b@datenfreihafen.org>
 <20240124174802.0b5910a5@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124174802.0b5910a5@xps-13>

Hello Miquèl,

On Wed, Jan 24, 2024 at 05:48:02PM +0100, Miquel Raynal wrote:
> Hi,
> 
> stefan@datenfreihafen.org wrote on Tue, 9 Jan 2024 08:25:21 +0100:
> 
> > Hello.
> > 
> > On 08.01.24 19:16, Breno Leitao wrote:
> > > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > > Add descriptions to ieee802154 modules.
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >   net/ieee802154/6lowpan/core.c | 1 +
> > >   net/ieee802154/socket.c       | 1 +
> > >   2 files changed, 2 insertions(+)
> > > 
> > > diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
> > > index 2c087b7f17c5..b88f6a96d961 100644
> > > --- a/net/ieee802154/6lowpan/core.c
> > > +++ b/net/ieee802154/6lowpan/core.c
> > > @@ -280,5 +280,6 @@ static void __exit lowpan_cleanup_module(void)  
> > >   >   module_init(lowpan_init_module);  
> > >   module_exit(lowpan_cleanup_module);
> > > +MODULE_DESCRIPTION("IPv6 over Low power Wireless Personal Area Network IEEE802154.4 core");  
> > 
> > If we want to nitpick you could write it as IEEE 802.15.4.
> 
> Also agreed, can you please post an update?

Sure. I will send it soon, since I am splitting the patches in a set of
10. According to the maintainer's request:
https://lore.kernel.org/all/20240122105708.52d33fa0@kernel.org/

For now, I am focusing on Ethernet drivers.

Thanks!

