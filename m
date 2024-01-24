Return-Path: <linux-kernel+bounces-36671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D0A83A4CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07EEB1F23108
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445C518EC0;
	Wed, 24 Jan 2024 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dW+mg23T"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749518E2E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086732; cv=none; b=Eo2e7q7cMTauIv3dUrlrSs3+AkWA69ODJ3nRYMkYebWV1UcuEwRtp3A/TXJvQB0QN6YI9Zs21lFls9MzBx1tqLWmZdSelw5Fpnvh1bWoxjZGYOi9PIg4gFeePuRF9fvPclwSemntIgZBaBXzsxdy9huVXuXZQwi1sKSjD0yZP8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086732; c=relaxed/simple;
	bh=6A2agHWPglD1APaJ96geKgF4ubgM9XgIXuQcxewyelA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8NBcNaXzMryh9Ei/po6Qii2PHivTv1CsvbZ95BG3e4i0s0RNnYCXTUhfFqPw5gFeS2PQNDFoax15Cc7SwgL4xLiuPj7jWJEbfeLGYONKnV5ACASyjddKkYwcRAzVs/u1BlwIXVgtueJvy3KkZXNhSr6RHYBu4ENHboIpOV/9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dW+mg23T; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4bd78dfe523so16148e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706086730; x=1706691530; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wb2TmrQlec/Mf3yh+lhjrs8umkcGGEn+Bj8EU6iIEHk=;
        b=dW+mg23TtUNG0gYCGkz8jFPtl6rJ0z8l0oG4jTkyGXVgaYQtH4mrONiPHv4c/bLbaL
         75d2jv8KmET8QGo8/mjoCLIWjPnqNziPgvPOhRLHB+35THVIBCwhHbZdJZxliL5uXITF
         KJbDjo99aj+0bw4UuzOm7GNZOgy5GJ61S54zV4GhN9yl0YLedYR/jCCogeTOhL+hXm7F
         kKyGxQOfi11jq7q4OEBgcgrvqbJ/3eZYb+hyX79EszC4K66CrTisNp7zSIrkQwFb+AA/
         /efdTzDmLiF7qYQEYJIHbMkf82jWSGvD+tsnz/lIGnFE3ChXscrtfnZo4ePe7rpL7x3S
         yMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086730; x=1706691530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wb2TmrQlec/Mf3yh+lhjrs8umkcGGEn+Bj8EU6iIEHk=;
        b=n3HS1F+xjf/7Nghc0eWA0/BmAO7x5XCuPCrBmDZCdGmnmPBYFUYjm8X1x/bjtPfr8W
         IdCUqR8lnCnVUcmp0sCbI2MDXmPkfV1KuCPGSQO1pbMmkrOEg4nvpiZ170r7l5HNNHm1
         fpN0KUguiJy+KeeUoXhA3we+qUA+D0dxfbVbQv3DpTCRZcuccm2aakZ53SpuBMjd+2VN
         7NwIEwdudg0iJAvR4xURuvvp/NSMXHT7ZHSmEBk6Fx5zhLc0T6RkVzTqEZajVr/UaMq9
         O3jI0nrIHzXp+E7qhBhl6z/+vu+Zz9hO57NWMoWvLBy/lNvFjOR87tR4M0OcIsuiaC14
         YkIQ==
X-Gm-Message-State: AOJu0Yzejjgim3wAdZk70Sm1UpfxN7Lo02w3FZnmDuWiXsvGGJUCV3+2
	a7fQ0Jfgt3M23MSlUoQMlj6gE2YGPCB3FqQdpMQjY9oKxMQv2z4rziELWtzqEA==
X-Google-Smtp-Source: AGHT+IHNl1ACK3L5Be2b8Nbsu6WHFviUzLaBTgGDg98+Fj/yv3drk7c1yF3spYfyyD4DRj8/t8c/4w==
X-Received: by 2002:a05:6122:1c0d:b0:4bd:1677:9458 with SMTP id et13-20020a0561221c0d00b004bd16779458mr1835683vkb.32.1706086729854;
        Wed, 24 Jan 2024 00:58:49 -0800 (PST)
Received: from thinkpad ([117.217.189.109])
        by smtp.gmail.com with ESMTPSA id f1-20020a056122044100b004b723acd1e1sm2619411vkk.11.2024.01.24.00.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:58:49 -0800 (PST)
Date: Wed, 24 Jan 2024 14:28:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	echanude@redhat.com, linux-arm-msm@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: qcom: Clarify comments about the initial
 phy_gear
Message-ID: <20240124085839.GH4906@thinkpad>
References: <20240123-ufs-reinit-comments-v1-1-ff2b3532d7fe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240123-ufs-reinit-comments-v1-1-ff2b3532d7fe@redhat.com>

On Tue, Jan 23, 2024 at 01:13:36PM -0600, Andrew Halaney wrote:
> The comments that currently are within the hw_ver < 4 conditional
> are misleading. They really apply to various branches of the
> conditionals there and incorrectly state that the phy_gear value
> can increase.
> 
> Right now the logic is to:
> 
>     * Default to max supported gear for phy_gear
>     * Set phy_gear to minimum value if version < 4 since those versions
>       only support one PHY init sequence (and therefore don't need reinit)
>     * Set phy_gear to the optimal value if the device version is already
>       populated in the controller registers on boot
> 
> Let's move some of the comment to outside the if statement and clean up
> the bit left about switching to a higher gear on reinit. This way the
> comment more accurately reflects the logic.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> This is a minor comment cleanup inspired by my mistaken understanding of
> the flow over at [0]
> 
> [0] https://lore.kernel.org/linux-arm-msm/20240123143615.GD19029@thinkpad/
> ---
>  drivers/ufs/host/ufs-qcom.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 39eef470f8fa..d9ec2dfbbda4 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -843,15 +843,20 @@ static void ufs_qcom_set_phy_gear(struct ufs_qcom_host *host)
>  	struct ufs_host_params *host_params = &host->host_params;
>  	u32 val, dev_major;
>  
> +	/*
> +	 * Default to powering up the PHY to the max gear possible, which is
> +	 * backwards compatible with lower gears but not optimal from
> +	 * a power usage point of view. After device negotiation, if the
> +	 * gear is lower a reinit will be performed to program the PHY
> +	 * to the ideal gear for this combo of controller and device.
> +	 */
>  	host->phy_gear = host_params->hs_tx_gear;
>  
>  	if (host->hw_ver.major < 0x4) {
>  		/*
> -		 * For controllers whose major HW version is < 4, power up the
> -		 * PHY using minimum supported gear (UFS_HS_G2). Switching to
> -		 * max gear will be performed during reinit if supported.
> -		 * For newer controllers, whose major HW version is >= 4, power
> -		 * up the PHY using max supported gear.
> +		 * These controllers only have one PHY init sequence,
> +		 * let's power up the PHY using that (the minimum supported
> +		 * gear, UFS_HS_G2).
>  		 */
>  		host->phy_gear = UFS_HS_G2;
>  	} else if (host->hw_ver.major >= 0x5) {
> 
> ---
> base-commit: 319fbd8fc6d339e0a1c7b067eed870c518a13a02
> change-id: 20240123-ufs-reinit-comments-17c44af62651
> 
> Best regards,
> -- 
> Andrew Halaney <ahalaney@redhat.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

