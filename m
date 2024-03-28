Return-Path: <linux-kernel+bounces-123065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D638901A9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223911C2C3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91E126F19;
	Thu, 28 Mar 2024 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5V3AZLA"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51A81AB1;
	Thu, 28 Mar 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635751; cv=none; b=KWfxr5WJnNaBmrrVD8TsTN22eByJkyRTbZIcN+HdR+nJJ3N3GOIrYbHbC0fvAwN5HoO8wngbBuNIJ1IWF1Xss6rTHslI+ZjZmBKWdJoz59CWhBOEFiaKZbfBMmVeqNaAl+o42GkT1rRbpv5IGHK8Pl9fcWgXSc15HaW6lWxSa1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635751; c=relaxed/simple;
	bh=HKUM7GHsawvdsDBUaUAnufrJHM3zXzsI6SaLI98bQTI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PET3UGHNj6v4xSzhCHXAPT0vhqME3onX7tALjmxhwLYGdyjFz+1VmIogCZ5m5TS6GP8TrNma0pKaPObsey9KfMR81WO8TIxAdn6dSbT4QBeW2D83NyiPwkLVYE/rOod3Ers9WMBzZiOrFxTbpkNpZP2a0fdJYp5SfBzvApwxqOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5V3AZLA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4150cd01febso6965815e9.2;
        Thu, 28 Mar 2024 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711635748; x=1712240548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5PrHKcuusjOlgc0C0gsGNU0F2oRgSATsr5DXKh5NEGQ=;
        b=U5V3AZLAMM3b9t3XELPuurjn+qqQT/0wDzoF6wtUxYLO2j5ZGlkA+NWplz5OURxytg
         1KVxZc2bkYHh1WEfBM8DN1uJN/QgJj/idsY+xe6EujjVZYsZMKJKl4djYiQ4NB0XHFUk
         yhrjurkNAa4hfh6TldwMmnDmcz9wIaV+bRcMu+JuVwW7mcJY6bFC1e5CQ8QQN0+x8wYg
         73VvFXKKmPqBlws20XYzUhmJmd81yQ8rGqfENzmnOZ0qrGwP6PRBIkDaE2KuvO9swzeE
         Ng+awTJX3QTi+NF+H2uhFUT5Bhh6w8q11Tjc3NxAolwV7IoItSxo+kxzUgyfJN01Bj9H
         UPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635748; x=1712240548;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PrHKcuusjOlgc0C0gsGNU0F2oRgSATsr5DXKh5NEGQ=;
        b=E7+Bb+MqbNivhQG8U7uqPKoMSjhahVy0DWEIE3TSlMln0n5QLur81lTwTpJzuDY1xG
         EtJdteaYWSCoXrQpEQpG+05WKbmi6Q580HUdMAG0/fkGSpei9/+U9a2Ry1Pv2A3CjDJh
         juEBtTSEwXrOXEL2SAIM9NMwFRbPnC2C3KWy0YNlu1FpZ3QEIRUGFgLBzK56bTawSeA0
         1ZooHLGT+GKrCgs7ZzIFSfG2NGmmMpa/0AnSD/RnLeiJRjpLzj6NkxiyYWdGl8u0sY5j
         JoQTiIPuDAiRkS42gpn4t0Ij+lldd1Pf8fsUZ3PJKLtpQHRQsxYRXVIwhnX/bbSyDIuf
         jsCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtAm4SZxGLSMCGWu2opYdSqXpuJZRy8L5eT3E3H0dKQmQ3vxB1W3EtpqKJSR2YjbpbHjv2C9DeyX60r2ZIQSYTBmEm+5oYgB8GImaXYTON6V5GmkevY37tESqY/o0h+WocbXVXwnmTVl0UxMH01xBauZCRGO+1drLNHTr9xcHKoiLtBw==
X-Gm-Message-State: AOJu0Yy9rDnulT7mzZAfF2W0HhCN7wXyWmT9iHAGxLArtOMtEgKLdFnb
	Be9hMzLlnEv3taHaISq2cLUSoaEerPsmacGENooX+2m/SXeCqT2B
X-Google-Smtp-Source: AGHT+IHaQzNvk4YWrQWT9WNAAwHe0kQOSE06N9pBtdSp1KGd0h6iK95EAr4dLsZF/PZXUPcYuq9GVw==
X-Received: by 2002:a05:600c:438a:b0:413:f4b5:dcec with SMTP id e10-20020a05600c438a00b00413f4b5dcecmr2085905wmn.40.1711635748283;
        Thu, 28 Mar 2024 07:22:28 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-1-248-55.retail.telecomitalia.it. [87.1.248.55])
        by smtp.gmail.com with ESMTPSA id k4-20020a05600c1c8400b00414807ef8dfsm2491296wms.5.2024.03.28.07.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:22:27 -0700 (PDT)
Message-ID: <66057d23.050a0220.2dbd5.9e0e@mx.google.com>
X-Google-Original-Message-ID: <ZgV9IBJH-ZEmipor@Ansuel-XPS.>
Date: Thu, 28 Mar 2024 15:22:24 +0100
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
 <66044bea.050a0220.dee16.c250@mx.google.com>
 <20240327175131.3c0100c3@xps-13>
 <20240328034732.GA3212@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328034732.GA3212@thinkpad>

On Thu, Mar 28, 2024 at 09:17:32AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 27, 2024 at 05:51:31PM +0100, Miquel Raynal wrote:
> > Hi,
> > 
> > ansuelsmth@gmail.com wrote on Wed, 27 Mar 2024 16:20:58 +0100:
> > 
> > > On Tue, Mar 26, 2024 at 12:55:12PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Mar 25, 2024 at 11:30:47AM +0100, Christian Marangi wrote:  
> > > > > misc_cmd_type in exec_op have multiple problems. With commit a82990c8a409
> > > > > ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
> > > > > reworked and generalized but actually broke the handling of the
> > > > > ERASE_BLOCK command.
> > > > > 
> > > > > Additional logic was added to the erase command cycle without clear
> > > > > explaination causing the erase command to be broken on testing it on
> > > > > a ipq806x nandc.
> > > > > 
> > > > > Fix the erase command by reverting the additional logic and only adding
> > > > > the NAND_DEV0_CFG0 additional call (required for erase command).
> > > > > 
> > > > > Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > ---
> > > > > Changes v2:
> > > > > - Split this and rework commit description and title
> > > > > 
> > > > >  drivers/mtd/nand/raw/qcom_nandc.c | 5 ++---
> > > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > > > > index b079605c84d3..19d76e345a49 100644
> > > > > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > > > > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > > > > @@ -2830,9 +2830,8 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
> > > > >  	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> > > > >  
> > > > >  	write_reg_dma(nandc, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
> > > > > -	(q_op.cmd_reg == OP_BLOCK_ERASE) ? write_reg_dma(nandc, NAND_DEV0_CFG0,
> > > > > -	2, NAND_BAM_NEXT_SGL) : read_reg_dma(nandc,
> > > > > -	NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> > > > > +	if (q_op.cmd_reg == OP_BLOCK_ERASE)
> > > > > +		write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);  
> > > > 
> > > > So this only avoids the call to, 'read_reg_dma(nandc, NAND_FLASH_STATUS, 1,
> > > > NAND_BAM_NEXT_SGL)' if q_op.cmd_reg != OP_BLOCK_ERASE. But for q_op.cmd_reg ==
> > > > OP_BLOCK_ERASE, the result is the same.
> > > > 
> > > > I'm wondering how it results in fixing the OP_BLOCK_ERASE command.
> > > > 
> > > > Can you share the actual issue that you are seeing? Like error logs etc...
> > > >  
> > > 
> > > Issue is that nandc goes to ADM timeout as soon as a BLOCK_ERASE is
> > > called. BLOCK_ERASE operation match also another operation from MTD
> > > read. (parser also maps to other stuff)
> > > 
> > > I will be away from the testing board for 7-10 days so I can't provide
> > > logs currently.
> > 
> > So, shall we wait for additional logs from Christian or shall I merge
> > the two-patches series? I'm not sure what's the status anymore.
> > 
> 
> TBH, I don't know how OP_BLOCK_ERASE can fail without this change. But I can
> clearly see the 2 patches required for OP_RESET_DEVICE command. But merging the
> patches as it is doesn't look good to me.
> 
> So I think if Christian can club the two patches into 1 as like v1 and reword
> the commit message and subject to reflect the fact that OP_RESET_DEVICE command
> is being fixed would work for me.
>

Ok will do, very confusing and sorry for not providing additiona log. I
was adding support for ipq806x for 6.6 and notice the regression.

Will rework the patch.

-- 
	Ansuel

