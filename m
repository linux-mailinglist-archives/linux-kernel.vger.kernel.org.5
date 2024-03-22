Return-Path: <linux-kernel+bounces-111674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41456886F64
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F147B282854
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3364D9F0;
	Fri, 22 Mar 2024 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9it4zVh"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B14D135
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119918; cv=none; b=CLJTw3t4oMbAKpU0dlgWGNT3XYOXk2UicJkQGaP+4p9lx/qdcJliwG+oKAXeUrW1fud8oQ80FtD04A/pXF+2jgHW9UEW51Lm/SO9IPmtmFfCIV2NwkSMsEceOM8VR/e/GKw07ueEKO2s1J2Q1LqRGv2JrtuSBGMp5jQ4/wDqbuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119918; c=relaxed/simple;
	bh=gkYusBscgoxgaz2KTP3MjsMEu9+re1gKs0yjn4oDBW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SM9gRKCDekXsKb0FeSV6dZ/iwz5rnHCNSAv9m8JWzJeIA6sRQVP4SyyEO6HliZ40FcUjkxM5QyKSZws/7M9/A6Su2estP+ip1vltFR9FRMZCHg4SdtkjGJ5V2+Fzm1ZHGZHwQEgDLasthGRd4/1AuIfmkmEs6eAEQ8ozBVIo7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E9it4zVh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e88e4c8500so1556657b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711119915; x=1711724715; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nYtRMDTbG4RNH7nK1yI7ROk5/pYQnmRT4k34XSD/fpw=;
        b=E9it4zVh9Pkks3nwfSUogd0oEvXC8XrwSt0mueISehd+g9ShdMJRzkz0xBSr10Zg6B
         3YQo5ZfQDiVEbC22WCdo1df/bt7/ji62Uira2xHoj8SkxYtmo5WOanEsqdUVftPi497H
         wirNuBmfYtc0eOy0TBHulPPitlIBZCjbZQmHKO7SVmuf2FARpKNGaxenvSy/th3Uaqdq
         kNL2myDWA1GWQwol1RInA1akjed1GNeyyj6QhEZ0FqmDYtNikQX+mNNVegvah+G//4ZD
         rAAh6eA+OPerRqfSbphSb5dIkxGqgxNsdPkIvRtiFEKhuvw/vMWsNJrJtlRoLFHR498C
         rVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711119915; x=1711724715;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYtRMDTbG4RNH7nK1yI7ROk5/pYQnmRT4k34XSD/fpw=;
        b=T33WZ540NSUIMcfV9QITo6ubw9ryu1q0UtFQh1iZwcIeG5g7Eeq0WwxQpVmODuUCCe
         UhObp3Gw16UAP4C/Wo6L6KfsjIxjONZRtnQldlABCSqMnDmf9YrRRKEYz2RGcmKi4Huv
         wj4c2wdNgB8nxHMXYF/4Xfj2y3ZiPLbBM7PZY1uGBClnLRZLXc1zGdOgFNwTp3YjqNjt
         vNQ5RQPQ6jElHZU4XIYdD+4vX5KB3CLEhRShE4+w3UsYvoT+kLg0p74wgrysWK8EKuIa
         YC0r33tSVh1ZcUEZDT2WvjweN+i/nP8FzvBqJUKIfRft0oQwZ8mByGmvyLDtwqkWi/Qb
         Y/kg==
X-Forwarded-Encrypted: i=1; AJvYcCVwQchpb/rfeBC5Ec9Qv/9dDvt1dxS6Rr6FnMzus0Il/g4dpsEli2P9XKygr9wGgKZqchmEXtYWPmXEAQH3XkHH+ujbT28QMXz+fPRp
X-Gm-Message-State: AOJu0YySAjCNNBaG/QWhqnTWbGKqJLgQTCrNiR99kZq8/H/02EvWy86e
	Z4dLzKT0d2XKxdfGGY4iZC69LXd7cpX+JEc5ejOmWz8NX/GrUJxlXrnAze0Zrw==
X-Google-Smtp-Source: AGHT+IGYbQybiUZqXzRNwAr1M/pqxdrMdugBVhGSQDcs2L60R2/mNWIyHVBayTYGU3wCM5UA6L13jA==
X-Received: by 2002:a17:90a:ff95:b0:29f:9548:4932 with SMTP id hf21-20020a17090aff9500b0029f95484932mr2430080pjb.3.1711119914819;
        Fri, 22 Mar 2024 08:05:14 -0700 (PDT)
Received: from thinkpad ([103.28.246.103])
        by smtp.gmail.com with ESMTPSA id x20-20020a17090abc9400b0029dd7b52d1bsm5604576pjr.56.2024.03.22.08.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:05:14 -0700 (PDT)
Date: Fri, 22 Mar 2024 20:35:10 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: qcom: Fix broken misc_cmd_type in exec_op
Message-ID: <20240322150510.GC3774@thinkpad>
References: <20240320001141.16560-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320001141.16560-1-ansuelsmth@gmail.com>

On Wed, Mar 20, 2024 at 01:11:39AM +0100, Christian Marangi wrote:
> misc_cmd_type in exec_op have multiple problems. With commit a82990c8a409
> ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
> reworked and generalized but actually dropped the handling of the
> RESET_DEVICE command.
> 
> The rework itself was correct with supporting case where a single misc
> command is handled, but became problematic by the addition of exiting
> early if we didn't had an ERASE or an OP_PROGRAM_PAGE operation.
> 
> Also additional logic was added without clear explaination causing the
> erase command to be broken on testing it on a ipq806x nandc.
> 

Interesting. I believe Alam tested the rework on IPQ platforms and not sure how
it got missed.

> Add some additional logic to restore RESET_DEVICE command handling and
> fix erase command.
> 

This sounds like two independent fixes, no? Please split them into separate
patches.

- Mani

> Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index b079605c84d3..b8cff9240b28 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2815,7 +2815,7 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
>  			      host->cfg0_raw & ~(7 << CW_PER_PAGE));
>  		nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
>  		instrs = 3;
> -	} else {
> +	} else if (q_op.cmd_reg != OP_RESET_DEVICE) {
>  		return 0;
>  	}
>  
> @@ -2830,9 +2830,8 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
>  	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
>  
>  	write_reg_dma(nandc, NAND_FLASH_CMD, instrs, NAND_BAM_NEXT_SGL);
> -	(q_op.cmd_reg == OP_BLOCK_ERASE) ? write_reg_dma(nandc, NAND_DEV0_CFG0,
> -	2, NAND_BAM_NEXT_SGL) : read_reg_dma(nandc,
> -	NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> +	if (q_op.cmd_reg == OP_BLOCK_ERASE)
> +		write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
>  
>  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>  	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

