Return-Path: <linux-kernel+bounces-122386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B805188F60B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13D94B23421
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE62376F4;
	Thu, 28 Mar 2024 03:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKX317pG"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C928DD1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711597660; cv=none; b=pOmwR9QGGlyw7JS8ZZxtb41YxRBWEht9kUO9SB/tvhrtrvoM8dhN4K5k3BjEz6pcaLGH2IXsQXFal94RqtDgGhnQRSfNtd67/Q+d7I1latWY+IE5dR8dtzVnXLp/61TNMl92M9+qOn+dQUfLSWISbaLgXoQOuSbvkPmzsTIOcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711597660; c=relaxed/simple;
	bh=+T8+oibyFXQseWnRP1RvqNoOK9iWnGTIOM6XcBrSfHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6LMjWG2blhC+dci108uXVso5REHPJ71hwI//1EPwdS3tjqYz5eDpdGzjY91phNUMndogZW5icTVbRwUJhg9ayp/CIv7GkM+FhTkvCL82HTfmIq7XOn+ZDV5SZBbegGEE/ejQKkjFnqH9HwJMyNbnOtaKy8Wbj0ojL0Idet0unk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rKX317pG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ea9a60f7f5so487882b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711597658; x=1712202458; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z/WHCgPvut6hI6qyx5z8tojeBqigzDZUqYNvjOT4a48=;
        b=rKX317pGKvHAm9GVzGfofDM+Vgw7heOFld+v9fAvU0S4BcOLR9ytMF5ubJcdEEbyCI
         XPIu7yz7B/uMzvOUSJcYQT/zyLJlftlpOxfTQHhRVYAREiz3kWMyCyVqikEVxdkad8Y3
         nPCfPEM5VJE5WibwSQB0+7jwLit91ZmKHEmxytROb1amaFk1CH4uReYhZiouaDbC9P+J
         9Q1HfG9qDCYLtIMFSTB03kwLF0E6ALVbPWDgh22jny/razXpNzVHzcW8HTYAXGkwFh+K
         DHOy9tIwL1SvxagtecCr+QSH87LVHPIhFiuYALokGoHTweKMGcmLaVmzfwnABaOZUuNj
         EdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711597658; x=1712202458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/WHCgPvut6hI6qyx5z8tojeBqigzDZUqYNvjOT4a48=;
        b=mpfQ5FxfaVz+1l5KwuUqWiMaT+PPgceRsgVKgt7cXZ0tS+zmbsY8A6Z5qdz3KLFePm
         IC6HvtcLHEhXpcXjFEYjoz3Uvcqi9xNYWL78Odia4n45NyNxH+KbdvEvzFFB05aVJTXh
         WMgKNCO8/5ni7zGo54y4aYjY0HHYqYC8NJPqDFEBhIxjxZ/l2poubrGbDaBJeUqABg7z
         OJf3+nGh3yHOcFxDM4pr3IgX2xkJukghEkPprIjXzDWYD7SLX8w1OF09CDHZV/OhCdHR
         9+oTjHkyjk8IDcH/C6KxnE3dMTZl14RZGfBZkM7wu87MixEl7BL29WDOquw4pOwe6ewa
         buRA==
X-Forwarded-Encrypted: i=1; AJvYcCXKqVLDGWW180m5sHWilBXf7gaIaJSJ2po+lijbVEvHdBz2hXEXCRVi6RU2mNvBDMgOAtzetgAYMxQ5sbYpBfd/guDGzZ/cMtgZWZMw
X-Gm-Message-State: AOJu0YyFuYuWcVJ6onxWUzSHP7qrRCC63tNDPubXrbiTC+sYSCp1Sjfa
	TOcA1TFC02og+CaYKA7OBZirBvQrAhgnBZCGNXe5wnEg04h46GbO+KUtX53acg==
X-Google-Smtp-Source: AGHT+IFW8Ftt5Bl/FbK/TnyOqAWEKoBzX1S89JTvlxTfnXlgLZ1WsKpzD4IlN1QhZseJ6ZbHIVvikg==
X-Received: by 2002:a05:6a00:182a:b0:6ea:c2a2:5637 with SMTP id y42-20020a056a00182a00b006eac2a25637mr2027249pfa.12.1711597657716;
        Wed, 27 Mar 2024 20:47:37 -0700 (PDT)
Received: from thinkpad ([2409:40f2:201b:315f:8cec:6523:95f2:3f93])
        by smtp.gmail.com with ESMTPSA id p6-20020a056a000b4600b006ea7b343877sm325711pfo.9.2024.03.27.20.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 20:47:37 -0700 (PDT)
Date: Thu, 28 Mar 2024 09:17:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mtd: rawnand: qcom: Fix broken erase in
 misc_cmd_type in exec_op
Message-ID: <20240328034732.GA3212@thinkpad>
References: <20240325103053.24408-1-ansuelsmth@gmail.com>
 <20240326072512.GA8436@thinkpad>
 <66044bea.050a0220.dee16.c250@mx.google.com>
 <20240327175131.3c0100c3@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327175131.3c0100c3@xps-13>

On Wed, Mar 27, 2024 at 05:51:31PM +0100, Miquel Raynal wrote:
> Hi,
> 
> ansuelsmth@gmail.com wrote on Wed, 27 Mar 2024 16:20:58 +0100:
> 
> > On Tue, Mar 26, 2024 at 12:55:12PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Mar 25, 2024 at 11:30:47AM +0100, Christian Marangi wrote:  
> > > > misc_cmd_type in exec_op have multiple problems. With commit a82990c8a409
> > > > ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
> > > > reworked and generalized but actually broke the handling of the
> > > > ERASE_BLOCK command.
> > > > 
> > > > Additional logic was added to the erase command cycle without clear
> > > > explaination causing the erase command to be broken on testing it on
> > > > a ipq806x nandc.
> > > > 
> > > > Fix the erase command by reverting the additional logic and only adding
> > > > the NAND_DEV0_CFG0 additional call (required for erase command).
> > > > 
> > > > Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > > Changes v2:
> > > > - Split this and rework commit description and title
> > > > 
> > > >  drivers/mtd/nand/raw/qcom_nandc.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > > > index b079605c84d3..19d76e345a49 100644
> > > > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > > > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > > > @@ -2830,9 +2830,8 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
> > > >  	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> > > >  
> > > >  	write_reg_dma(nandc, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
> > > > -	(q_op.cmd_reg == OP_BLOCK_ERASE) ? write_reg_dma(nandc, NAND_DEV0_CFG0,
> > > > -	2, NAND_BAM_NEXT_SGL) : read_reg_dma(nandc,
> > > > -	NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> > > > +	if (q_op.cmd_reg == OP_BLOCK_ERASE)
> > > > +		write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);  
> > > 
> > > So this only avoids the call to, 'read_reg_dma(nandc, NAND_FLASH_STATUS, 1,
> > > NAND_BAM_NEXT_SGL)' if q_op.cmd_reg != OP_BLOCK_ERASE. But for q_op.cmd_reg ==
> > > OP_BLOCK_ERASE, the result is the same.
> > > 
> > > I'm wondering how it results in fixing the OP_BLOCK_ERASE command.
> > > 
> > > Can you share the actual issue that you are seeing? Like error logs etc...
> > >  
> > 
> > Issue is that nandc goes to ADM timeout as soon as a BLOCK_ERASE is
> > called. BLOCK_ERASE operation match also another operation from MTD
> > read. (parser also maps to other stuff)
> > 
> > I will be away from the testing board for 7-10 days so I can't provide
> > logs currently.
> 
> So, shall we wait for additional logs from Christian or shall I merge
> the two-patches series? I'm not sure what's the status anymore.
> 

TBH, I don't know how OP_BLOCK_ERASE can fail without this change. But I can
clearly see the 2 patches required for OP_RESET_DEVICE command. But merging the
patches as it is doesn't look good to me.

So I think if Christian can club the two patches into 1 as like v1 and reword
the commit message and subject to reflect the fact that OP_RESET_DEVICE command
is being fixed would work for me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

