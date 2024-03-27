Return-Path: <linux-kernel+bounces-121453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CFC88E81F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95EC1C2F8AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D5A1386DA;
	Wed, 27 Mar 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlEEP/1e"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5FB131186;
	Wed, 27 Mar 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550515; cv=none; b=tp6+BkkGzr7n7MSNSYreFBC+cXP4HVOfBhcA9S5vDpzoHijllKooUD6bfAk4pMQHEgL8TYZnW8mEthnfA26Z6Uyk40EKx8ecj7dAOFUtJoNLrvqPCMyQX0PomDa/1Mtcve9UMVH/xQ4GnAjKxVu7092QIAfev2xJApXLI4od79I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550515; c=relaxed/simple;
	bh=wmmiPcNi9/L0mLdH/UYICeW1I3Q9ziHtN+YyCKad0tU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOAlxkzfTlgsK7uPPjS9nD8CxZdzHYLE11MnRIrCOPGdjarKMJMOwpvdiw2cQOhlZIki4X/SHGGY0qmxeXVWmzxJN8OpiPbo9tryPNkSoJ+Itbt7xfpafooVZR5t0KE3lLHSyu2wdEn3ldavkWByl+wHtuiuat5DCR0vSuNq1vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlEEP/1e; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33eee0258abso3328563f8f.3;
        Wed, 27 Mar 2024 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711550511; x=1712155311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OUrGaFOTm3HIgbVg/3+q83JkWLVUBaXqcSW9xQP09cY=;
        b=FlEEP/1eWxLqqfIfldKpfaCzPVm3dz0FUL+dJHUAuwHM1NCS9x2GWJg49at6SHVGKh
         u4+tJE0sgbrfRkrQyQXvNbU292J5aog1kwvzeB+n8FR6LtFkDwP8fw44XgbZ2CPJ4INA
         y3CUKy7Ibt7bJsAu5f/iPjcPvjQbte1IpC+CgzO6PpHeqXi4RtE6HDRuuXx0QYIJpFk8
         smzcIjtfcU//RJtFKxTo4d3EV5qAmoxL6yoLOc/cjpG8ydqRYsgeZvMhfF1MlfnK/HgP
         Mytu1xrNPOR6TsFRHkMh9MKvOvLpgE704Uxwp8jjQpLeRTm3BctfgTdBnstxv5FWBEZr
         A5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711550511; x=1712155311;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUrGaFOTm3HIgbVg/3+q83JkWLVUBaXqcSW9xQP09cY=;
        b=IGF+1cHeeweKbLRfk0+in4vIcXs/J3Z4zZg1+QvK6Av+O65kpvamtVl37tajFaqpRU
         txSULvNw6AUHUUZxN4dshSCCQtksrLAoNX/GdOZSRpdR3tomztr6PkcifYOybkSnF+V9
         U3wSdhg38qxgLiDzXnqyHyqHgIIsEBN1zZwvUkBrwiCSbqvrXa81Gz/MGLACOIK7l3Vz
         34Oj3vgtYC6wRNvLo26w8suVPQhLryeSx9pfsTliaKcxoNbLJxXOOIbql/OTnt7SEcZY
         Irief5yGqCynC0uBUfA3UA1wtsKncBvd357wc4xBxNLseKMP99bfnIYYzqqm+rV4e0M0
         pbbg==
X-Forwarded-Encrypted: i=1; AJvYcCUkZLL+5w1Y/J9tEro/xlxHXqY9SHSxgukpnd49pClq7iBcaknL389peBYUQXvDJaAehdRLD9YKs/XwV4YHvi2Qh1depP/iYtqfTHjkX0LygY/tZH5rCqEdKVd8T8PA+2Q3Fi++qpZP3rO5Vly0K4bdyh8ErJwucsoLlqvXmW1hfzCrLQ==
X-Gm-Message-State: AOJu0Yw9dL4t/VTM2CDpkZA3Odmv7DEuBrN4aJ/G4ltr+jawx/16sxpi
	/jE/aZh35Iq/d2TrKgwM+1EEX3jyGRyPO5K4vdRVaYKQAFp6QkmdtGCciKAI
X-Google-Smtp-Source: AGHT+IH3hhBbBOaJyytCArqO8u63fzWZ9+iCxdRQaBCRR2VKg2JV+sT8K3SotUOm+F1TlR488dD7JA==
X-Received: by 2002:adf:b31c:0:b0:341:bf39:9f8 with SMTP id j28-20020adfb31c000000b00341bf3909f8mr139952wrd.6.1711550511199;
        Wed, 27 Mar 2024 07:41:51 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-247-253-192.retail.telecomitalia.it. [95.247.253.192])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d5910000000b003418364032asm15087444wrd.112.2024.03.27.07.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 07:41:50 -0700 (PDT)
Message-ID: <6604302e.5d0a0220.bdb64.4077@mx.google.com>
X-Google-Original-Message-ID: <ZgQwK7kh_MUDUbQb@Ansuel-XPS.>
Date: Wed, 27 Mar 2024 15:41:47 +0100
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
 <20240326073947.GA9565@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326073947.GA9565@thinkpad>

On Tue, Mar 26, 2024 at 01:09:47PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Mar 26, 2024 at 12:55:19PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Mar 25, 2024 at 11:30:47AM +0100, Christian Marangi wrote:
> > > misc_cmd_type in exec_op have multiple problems. With commit a82990c8a409
> > > ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
> > > reworked and generalized but actually broke the handling of the
> > > ERASE_BLOCK command.
> > > 
> > > Additional logic was added to the erase command cycle without clear
> > > explaination causing the erase command to be broken on testing it on
> > > a ipq806x nandc.
> > > 
> > > Fix the erase command by reverting the additional logic and only adding
> > > the NAND_DEV0_CFG0 additional call (required for erase command).
> > > 
> > > Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > > Changes v2:
> > > - Split this and rework commit description and title
> > > 
> > >  drivers/mtd/nand/raw/qcom_nandc.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > > index b079605c84d3..19d76e345a49 100644
> > > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > > @@ -2830,9 +2830,8 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
> > >  	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> > >  
> > >  	write_reg_dma(nandc, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
> > > -	(q_op.cmd_reg == OP_BLOCK_ERASE) ? write_reg_dma(nandc, NAND_DEV0_CFG0,
> > > -	2, NAND_BAM_NEXT_SGL) : read_reg_dma(nandc,
> > > -	NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> > > +	if (q_op.cmd_reg == OP_BLOCK_ERASE)
> > > +		write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
> > 
> > So this only avoids the call to, 'read_reg_dma(nandc, NAND_FLASH_STATUS, 1,
> > NAND_BAM_NEXT_SGL)' if q_op.cmd_reg != OP_BLOCK_ERASE. But for q_op.cmd_reg ==
> > OP_BLOCK_ERASE, the result is the same.
> > 
> > I'm wondering how it results in fixing the OP_BLOCK_ERASE command.
> > 
> 
> Perhaps you are trying to fix the OP_RESET_DEVICE command altogether?
>

Well with this only patch correct working of nandc on ipq806x is
restored. I'm still very confused how since the misc command currently
works only with the PROGRAM_PAGE and the BLOCK_ERASE (from ERASE1 and
ERASE2)

Still the extra read was added with no explaination and I couldn't find
this command cycle in any of the previous legacy function and the one
introduced after the parser rework.

-- 
	Ansuel

