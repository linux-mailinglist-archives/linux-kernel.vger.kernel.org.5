Return-Path: <linux-kernel+bounces-121641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DED88EB75
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785D21C2FF48
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F21E14AD16;
	Wed, 27 Mar 2024 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy056Bx4"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34412E1F0;
	Wed, 27 Mar 2024 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557614; cv=none; b=PdlSA6wLkS0LuWyT+GMxWo9HwBgPYhKC7YQDQ1zf3FLdNBDS8f0YsxGqZ5ZR5xXGAPhGQXm53A0DUH/p9wYxTpo4BEwKAFR8G47wzpUTer4dlTf36gu4nVbsZNjbzqwudN4igPA4uEPIlYIIp475mExJOWD7FTVCcMJik6TrtfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557614; c=relaxed/simple;
	bh=55FixKpVvBnRnD4FrdIIFh3o0roqfl9/GYXUPXMDM48=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTPMFVr2XXkYoKgBevHCIjwL0VaYd0Upgmy90pxyRgtCLqNSEk7OQtEkKXpeJuTHP0pz1UAyLHtO4HMT5AaeG1jREEBUvFMiNuLQrhr50mgSwRSkEM8WjYk59BMsTvumyb2TR3Gii+XExYp3/KlqafQDcGCRNBaxeq3Ikp9UuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hy056Bx4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-414a2679222so1590985e9.1;
        Wed, 27 Mar 2024 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711557611; x=1712162411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vlQkpxaGQW3p984RRGKWywyzWKD0TWHivq5zfU3FFHY=;
        b=hy056Bx4noBqiSSlfbowKe78cKS4+d6L8JNOtnzmvYwEdXLhXp9JnAI80hPmv1wQrT
         5wCWKlTU4idNVGQANaTBbn5Li3Y0+zCoyRjCg5A6FX7MkBDlyd34D2ZuFKS9egScd0AS
         dkSIo8FueHghi2tdnnHK9FN045iXbU+agY26bsWfDUnslFSaKVnX6RAcp92Q7FgGv6Yz
         EslhNAhfmVBKNsPGrjjbraQv7IB7Y5TNNapNuliOqQwuRuByOCWssfwvR6zE1eJKLvX4
         h2W35Pw3RC4F4T5UkW3jFwsZ0SULZ2/M6bLp2GuiBRctMvXCHNP/44SNctVDgamlQJsJ
         pNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711557611; x=1712162411;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlQkpxaGQW3p984RRGKWywyzWKD0TWHivq5zfU3FFHY=;
        b=xVgmRGvjj/LwKRX2n9V7J92CzvTKBLYsjQmYrPbdHYOQ9uRBeJnb96uY9AmOVzxwoB
         IWOdhWBGRguKhHCXtkphBLTnodnLGN5b38Td0Bf2tWPBqcIuuMmUTInAmyW/Qs/9Ne6W
         inHu98o5KLlUByPxmc8I1MrGdBjDqhvGcD2mUCOFm77lEPxaw1YRE5ADNMBnycU2J6tq
         WXW5AtVdewMcYgaryN8njqHcnb9TpcL4AXorqpwog6qJtcvtg1vqnXZIQ+D3ke5Xym60
         rweUTWqNjNK4BeLYBW3OtAf/WxYIODS9MfpEvIGLrWI2YjYDgyDkzvknSDUFNZiko7J2
         0UCg==
X-Forwarded-Encrypted: i=1; AJvYcCUC0DRtyqhhAu15ZxxGVnXvcxWbxB8cdL0cj698esnehM0f9XC8Pk2eQCUiEDgJ2NucM4BMRWMDXMkw+sKKT2+lvgudQPrvVdS9BuyatqPslbosxKa2jzm7sr/Sgqrd5B6GH8jhbXUHcCdISS33ZLodlvR1tlndIFsjylxcOqTnN5bqZg==
X-Gm-Message-State: AOJu0YxPvvKIUFAWmctwWugtLpFw9Tsrlj/I/eY799i2+N9TVodw4hD/
	AeVC4rZGtPOMBxqfC+aQPHCH2bD9DpuO70+0Wl/xP6Nja94P7gZm
X-Google-Smtp-Source: AGHT+IGlxMmgSl6wOcskjtwSMRobLESUDTi3KLNM9ekBedCGEFAVz8OWGEvAAhpMa74zmpbd08FWtw==
X-Received: by 2002:a05:600c:4ed0:b0:414:8894:213d with SMTP id g16-20020a05600c4ed000b004148894213dmr382271wmq.35.1711557611033;
        Wed, 27 Mar 2024 09:40:11 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-247-253-192.retail.telecomitalia.it. [95.247.253.192])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c191300b00414924f307csm2630583wmq.26.2024.03.27.09.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:40:10 -0700 (PDT)
Message-ID: <66044bea.050a0220.dee16.c250@mx.google.com>
X-Google-Original-Message-ID: <ZgQ5RmS3eWaiVdwB@Ansuel-XPS.>
Date: Wed, 27 Mar 2024 16:20:58 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mtd: rawnand: qcom: Fix broken erase in
 misc_cmd_type in exec_op
References: <20240325103053.24408-1-ansuelsmth@gmail.com>
 <20240326072512.GA8436@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326072512.GA8436@thinkpad>

On Tue, Mar 26, 2024 at 12:55:12PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 25, 2024 at 11:30:47AM +0100, Christian Marangi wrote:
> > misc_cmd_type in exec_op have multiple problems. With commit a82990c8a409
> > ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
> > reworked and generalized but actually broke the handling of the
> > ERASE_BLOCK command.
> > 
> > Additional logic was added to the erase command cycle without clear
> > explaination causing the erase command to be broken on testing it on
> > a ipq806x nandc.
> > 
> > Fix the erase command by reverting the additional logic and only adding
> > the NAND_DEV0_CFG0 additional call (required for erase command).
> > 
> > Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v2:
> > - Split this and rework commit description and title
> > 
> >  drivers/mtd/nand/raw/qcom_nandc.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > index b079605c84d3..19d76e345a49 100644
> > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > @@ -2830,9 +2830,8 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
> >  	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> >  
> >  	write_reg_dma(nandc, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
> > -	(q_op.cmd_reg == OP_BLOCK_ERASE) ? write_reg_dma(nandc, NAND_DEV0_CFG0,
> > -	2, NAND_BAM_NEXT_SGL) : read_reg_dma(nandc,
> > -	NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> > +	if (q_op.cmd_reg == OP_BLOCK_ERASE)
> > +		write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
> 
> So this only avoids the call to, 'read_reg_dma(nandc, NAND_FLASH_STATUS, 1,
> NAND_BAM_NEXT_SGL)' if q_op.cmd_reg != OP_BLOCK_ERASE. But for q_op.cmd_reg ==
> OP_BLOCK_ERASE, the result is the same.
> 
> I'm wondering how it results in fixing the OP_BLOCK_ERASE command.
> 
> Can you share the actual issue that you are seeing? Like error logs etc...
>

Issue is that nandc goes to ADM timeout as soon as a BLOCK_ERASE is
called. BLOCK_ERASE operation match also another operation from MTD
read. (parser also maps to other stuff)

I will be away from the testing board for 7-10 days so I can't provide
logs currently.

-- 
	Ansuel

