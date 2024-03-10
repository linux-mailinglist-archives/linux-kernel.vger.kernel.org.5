Return-Path: <linux-kernel+bounces-98221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4388776DD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 13:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C0BB21190
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3337A2943F;
	Sun, 10 Mar 2024 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zkgdkt70"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7692C68F
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710075266; cv=none; b=csKR3uDLIzLUkWSY2meHxX0icZvnEVZ/r9FoE1DrYPL/6QDSsEYf/Za73gt2hbGcYhplWZsJs2CpiGZeHDTkFEIXgMnNMksvR7U6OrUDtIkyAtbamfLrb2wBY6R5kt0u8ubyyqCSk3UPeLBQkqXVZKtaGsrBpH3jhOQMz1tVT6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710075266; c=relaxed/simple;
	bh=KNKrikJqZISr2kYrc5CDd+izWHNtbd02L7Iv6YDOW5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvyfRvZn++oAH6lMe+lJrnmTy6K8Lu2LtpyCyABivvUpwp3pNIllLBg9FhFEr+i4bGYk7ujgCDDFiSr5jfg206arT66x8p8HWFvDGzdpdiu6dpwoNTx+SXIC+LRGMXVYsmoeP2HlmoG6PCYdRynFf1UDYzYPiNqVWz6yF0usq/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zkgdkt70; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso26192265ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 05:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710075263; x=1710680063; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/OwG24vRkQy9wB5IPBp4dArvNgRlN9XugeDOLt3z9CU=;
        b=Zkgdkt70k2Ic4Y4+uKsaapy/A/XTSXAYzaD7c0PXEDjcUAij26x3rtqqaWDgWG+cUk
         WaVcaSk64sqtt8SRm4pIoKfnJYsN+LR9x3+POy0YJRQW8/fgpCBDbMfFfXNo2aYlqciF
         8YdZhiQBP1RZgqSyNHboL9cuDGvxV0sdwD+Uwj4jbRo2mFiPWdu8sKC5br9Z8E6JPxak
         EkfWFKBBF8q0GLBsJOrG7Q5szFJR6j5vnIXTT8TeQ3BLV4SgfnrNl//Lx2jfA1BFlG+O
         tBYjp1D9Qf0vzzTx8XqMyG29jGnJqgR2VVbO64nDTbny/2su224WPd5xttGxwg44VN0J
         tcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710075263; x=1710680063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OwG24vRkQy9wB5IPBp4dArvNgRlN9XugeDOLt3z9CU=;
        b=jW8C7gehR8L2rUmupqU+Z9Ao5HtPTyd492VR1UpDy3pgJn38jbFmnZqoku3ebC999A
         gbUhN+UzFdhE3I03ld1AtqVIfZEHxmVyGEZmjzzy9yruL72v5vlYHEUGQDG8jb4p/+ml
         XooyKHLSBUlcg16+6fU7tdzUZY4gb6NDpCt40YktxYFFe28cwMw3eekSAnAj/2S7Rmgy
         DNQFmKo0EwXHpRpcvmf9nLk1a3mzF1sko2VlsRXdpR/F84939Saa5GRtc/vrmfRIvkOz
         Wcaa5KPzN+AlYJJfUTjC5QexzFxUYAZLS8kOYdgyPptPWm4moF90YN4dCsRk8VCi1l3m
         Mx2A==
X-Forwarded-Encrypted: i=1; AJvYcCXg+j8YYOUGWVD19Ene6/jbbwLqhyE2fZK2Tc4E0F0QCRpxCbL3k4MK8i7X52eyw+FU+1UQpcqvZvROJLhM6W01IGMkLCu73JLvEHxB
X-Gm-Message-State: AOJu0Yz6qi10iLmnBj+D8YJiVQG35sBleIH41IYoJ+4+4a377zCT6puM
	x/5L2h7YKjCBermK4YtArAK3lmPgVpi9eRqNQ0imUNWGXc2qs8x264TO8hdBGw==
X-Google-Smtp-Source: AGHT+IEVQ7GfOqMRCB1dIQ1AspY1rQeQnuOs3JnjOjR2lJDMiLLjo5FyQaHpOpQoHUZqjJU2W/dK5Q==
X-Received: by 2002:a17:902:e74d:b0:1dc:e58:8ab4 with SMTP id p13-20020a170902e74d00b001dc0e588ab4mr3741393plf.9.1710075262835;
        Sun, 10 Mar 2024 05:54:22 -0700 (PDT)
Received: from thinkpad ([120.138.12.86])
        by smtp.gmail.com with ESMTPSA id i8-20020a170902c94800b001dcf91da5c8sm2642373pla.95.2024.03.10.05.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 05:54:22 -0700 (PDT)
Date: Sun, 10 Mar 2024 18:24:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_schintav@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 1/3] PCI: qcom: Override NO_SNOOP attribute for
 SA8775P RC
Message-ID: <20240310125415.GA3390@thinkpad>
References: <1709730673-6699-1-git-send-email-quic_msarkar@quicinc.com>
 <1709730673-6699-2-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1709730673-6699-2-git-send-email-quic_msarkar@quicinc.com>

On Wed, Mar 06, 2024 at 06:41:10PM +0530, Mrinmay Sarkar wrote:
> Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
> in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
> the requester is indicating that no cache coherency issue exist for
> the addressed memory on the endpoint i.e., memory is not cached. But
> in reality, requester cannot assume this unless there is a complete
> control/visibility over the addressed memory on the endpoint.
> 
> And worst case, if the memory is cached on the endpoint, it may lead to
> memory corruption issues. It should be noted that the caching of memory
> on the endpoint is not solely dependent on the NO_SNOOP attribute in TLP.
> 
> So to avoid the corruption, this patch overrides the NO_SNOOP attribute
> by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
> needed for other upstream supported platforms since they do not set
> NO_SNOOP attribute by default.
> 
> 8775 has IP version 1.34.0 so introduce a new cfg(cfg_1_34_0) for this
> platform. Assign override_no_snoop flag into struct qcom_pcie_cfg and
> set it true in cfg_1_34_0 and enable cache snooping if this particular
> flag is true.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Minor nit below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 2ce2a3b..d4c1e69 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -51,6 +51,7 @@
>  #define PARF_SID_OFFSET				0x234
>  #define PARF_BDF_TRANSLATE_CFG			0x24c
>  #define PARF_SLV_ADDR_SPACE_SIZE		0x358
> +#define PARF_NO_SNOOP_OVERIDE			0x3d4
>  #define PARF_DEVICE_TYPE			0x1000
>  #define PARF_BDF_TO_SID_TABLE_N			0x2000
>  
> @@ -117,6 +118,10 @@
>  /* PARF_LTSSM register fields */
>  #define LTSSM_EN				BIT(8)
>  
> +/* PARF_NO_SNOOP_OVERIDE register fields */
> +#define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
> +#define RD_NO_SNOOP_OVERIDE_EN			BIT(3)
> +
>  /* PARF_DEVICE_TYPE register fields */
>  #define DEVICE_TYPE_RC				0x4
>  
> @@ -227,8 +232,14 @@ struct qcom_pcie_ops {
>  	int (*config_sid)(struct qcom_pcie *pcie);
>  };
>  
> + /**
> +  * struct qcom_pcie_cfg - Per SoC config struct
> +  * @ops: qcom pcie ops structure
> +  * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache snooping
> +  */
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
> +	bool override_no_snoop;
>  };
>  
>  struct qcom_pcie {
> @@ -961,6 +972,13 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  
>  static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  {
> +	const struct qcom_pcie_cfg *pcie_cfg = pcie->cfg;
> +
> +	/* Override NO_SNOOP attribute in TLP to enable cache snooping */

This comment is now redundant due to Kdoc of override_no_snoop.

- Mani

> +	if (pcie_cfg->override_no_snoop)
> +		writel(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
> +				pcie->parf + PARF_NO_SNOOP_OVERIDE);
> +
>  	qcom_pcie_clear_hpc(pcie->pci);
>  
>  	return 0;
> @@ -1334,6 +1352,11 @@ static const struct qcom_pcie_cfg cfg_1_9_0 = {
>  	.ops = &ops_1_9_0,
>  };
>  
> +static const struct qcom_pcie_cfg cfg_1_34_0 = {
> +	.ops = &ops_1_9_0,
> +	.override_no_snoop = true,
> +};
> +
>  static const struct qcom_pcie_cfg cfg_2_1_0 = {
>  	.ops = &ops_2_1_0,
>  };
> @@ -1630,7 +1653,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
> -	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_9_0},
> +	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_34_0},
>  	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

