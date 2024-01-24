Return-Path: <linux-kernel+bounces-36638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC5B83A438
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019F71F2749D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF4F17740;
	Wed, 24 Jan 2024 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkQRGVg5"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B01759F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085228; cv=none; b=CmRXwHAOcZKMJDa0nN26qI/mQ2yTEzRYj3hiTkHtHlcGPb39SWconXGex+VGa/J9qND+NY6gjLs8+i3aig0xb+VDEt8QBgPnCaztZa2ZBmRkW7kHAEeXakLOuXefFV4oMiUdXuTjtcoXxroc1Rg1ePUbU5agJKTsGNU3eKt9S1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085228; c=relaxed/simple;
	bh=PX2GmyFRFn2nD4mNi7u/AP+PYTUtYKCoSLnLW+0R0YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0YU2QWkqjqXGp+y1L113y/f3TYNzA8kT/50E73RmDgP6l0SfejsPRzrp7/NyggSMU397T8UCi1Ug2nTMUVR9lgClTImB+x9RcXc+1u+cKmlDoGRpNF9yspoAMdqaWGKz2pB9+upSIqZwTpk2YmVWL1W9PjJVT7roWwP/HiMEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MkQRGVg5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d74045c463so21495945ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706085225; x=1706690025; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vPFRER/gkE3zm2pQ/KTOV3I0e5WTpUXpU3iwr5G1xwY=;
        b=MkQRGVg5KQaz8kO59PpfA1JkXBGB+nRarrD0otaJNQwrXkUYP4UsublGyFlbOLJ0SV
         8rvhey5drE9RT3lwh11Bssl7yNz2ebtbOYupPBxCxLn2xzoBa0UaynOIhp2T7VoV3NWw
         4iMTbUJa9w/2CLlsFasCy45KYFExpTx8hjIlPlRafIYvcE2JpJmE5lnuHrlBMlGr8Esh
         9pcsx+Z2BB807HPSR3hdCc0tH99AW8wqZ53mWe82ZnvQNte5vLYD5jih710m3PkAFbre
         BDQsn89NfttpdwaL/wXG00azs+bepMZxEIYQvxR1iZQXuObOZ7Rcjqggtej3zzYMiBmT
         dIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706085225; x=1706690025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPFRER/gkE3zm2pQ/KTOV3I0e5WTpUXpU3iwr5G1xwY=;
        b=Pzfvh2p0j4XZTRML7Pfba4mOVMJS21wvBSnN/IrZ9B2/GPE9CpRhqvX+krvP2MW7mh
         RxcbOYPFPM4iqv5fPtPRrPKhEOlREvgnSC9RgEVFDic5KiJZthl0qt+IovC+qUxyldDQ
         sFW1WB5/yDiVhkN8JbWVuQC/TWcwmGGjn0F+kJ+GXpRUZVreHvlKN0kXAhwPAwbSroF6
         bbwuCphclLD5n1l+ne0yiR1lfdobRrxvdEu6YHWNRWWQYjlZQ31/wKDU3+j1YxrvzRoe
         PAUz1afWRyQzEDv+p+pK15GI8KAWHs606ELaqaauAXRUFWi+MKHaoSaDFeZwgyaYU6o8
         3bWA==
X-Gm-Message-State: AOJu0Yx5rs9HHJKG1j9XqrrVIgwvmhTk+v/eh/b6VNYbBpE8XyXyhRYt
	CdLiugZVYNcrQfIFalyM2hP0C7ZOnCWPLYN5435S2ePadXCd0dx65TZOBi5diw==
X-Google-Smtp-Source: AGHT+IHAMGkA6E3jdrT6it59P0NjlIeY0P9GAB/kSyKZfIcGyYzIgZ45Z1bjWpdQtj9CnzDYvvwFFg==
X-Received: by 2002:a17:902:da84:b0:1d6:f2c0:3c00 with SMTP id j4-20020a170902da8400b001d6f2c03c00mr436044plx.16.1706085225158;
        Wed, 24 Jan 2024 00:33:45 -0800 (PST)
Received: from thinkpad ([117.217.189.109])
        by smtp.gmail.com with ESMTPSA id r19-20020a170903015300b001d741effb7dsm5373688plc.270.2024.01.24.00.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 00:33:44 -0800 (PST)
Date: Wed, 24 Jan 2024 14:03:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	Can Guo <quic_cang@quicinc.com>,
	Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: Re: [PATCH V1 2/2] phy: qcom: Refactor phy_power_on and
 phy_calibrate callbacks
Message-ID: <20240124083336.GB4906@thinkpad>
References: <20240112153348.2778-1-quic_nitirawa@quicinc.com>
 <20240112153348.2778-3-quic_nitirawa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240112153348.2778-3-quic_nitirawa@quicinc.com>

On Fri, Jan 12, 2024 at 09:03:48PM +0530, Nitin Rawat wrote:
> Commit 052553af6a31 ("ufs/phy: qcom: Refactor to use phy_init call")
> puts enabling regulators & clks, calibrating UFS PHY, starting serdes
> and polling PCS ready status into phy_power_on.
> 
> In Current code regulators enable, clks enable, calibrating UFS PHY,
> start_serdes and polling PCS_ready_status are part of phy_power_on.
> 
> UFS PHY registers are retained after power collapse, meaning calibrating
> UFS PHY, start_serdes and polling PCS_ready_status can be done only when
> hba is powered_on, and not needed every time when phy_power_on is called
> during resume. Hence keep the code which enables PHY's regulators & clks
> in phy_power_on and move the rest steps into phy_calibrate function.
> 
> Refactor the code to enable PHY regulators & clks in phy_power_on and
> move rest of the code to phy_calibrate function.
> 

This patch should come before UFS patch since you are introducing the
calibrate() callback here only.

> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 183 +++++++++---------------
>  1 file changed, 67 insertions(+), 116 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 3c2e6255e26f..ae0218738b0b 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -32,14 +32,15 @@
>  /* QPHY_SW_RESET bit */
>  #define SW_RESET				BIT(0)
>  /* QPHY_POWER_DOWN_CONTROL */
> -#define SW_PWRDN				BIT(0)
> +#define SW_PWRUP				BIT(0)
> +#define SW_PWRDN				0

Why 0?

>  /* QPHY_START_CONTROL bits */
>  #define SERDES_START				BIT(0)
>  #define PCS_START				BIT(1)
>  /* QPHY_PCS_READY_STATUS bit */
>  #define PCS_READY				BIT(0)
> 
> -#define PHY_INIT_COMPLETE_TIMEOUT		10000
> +#define PHY_INIT_COMPLETE_TIMEOUT		1000000

Why? This is not mentioned in the commit message. If it is not related to this
refactoring, then it should be a separate patch with justification.

> 
>  struct qmp_phy_init_tbl {
>  	unsigned int offset;
> @@ -1464,8 +1465,25 @@ static void qmp_ufs_init_registers(struct qmp_ufs *qmp, const struct qmp_phy_cfg
>  		qmp_ufs_pcs_init(qmp, &cfg->tbls_hs_g4);
>  }
> 
> -static int qmp_ufs_com_init(struct qmp_ufs *qmp)
> +static int qmp_ufs_power_off(struct phy *phy)
> +{
> +	struct qmp_ufs *qmp = phy_get_drvdata(phy);
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +
> +	/* Put PHY into POWER DOWN state: active low */
> +	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> +			SW_PWRDN);
> +
> +	clk_bulk_disable_unprepare(cfg->num_clks, qmp->clks);
> +
> +	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
> +
> +	return 0;
> +}
> +
> +static int qmp_ufs_power_on(struct phy *phy)
>  {
> +	struct qmp_ufs *qmp = phy_get_drvdata(phy);
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>  	void __iomem *pcs = qmp->pcs;
>  	int ret;
> @@ -1480,8 +1498,7 @@ static int qmp_ufs_com_init(struct qmp_ufs *qmp)
>  	if (ret)
>  		goto err_disable_regulators;
> 
> -	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
> -
> +	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRUP);

Newline please. As mentioned above, why can't you use existing SW_PWRDN macro.

>  	return 0;
> 
>  err_disable_regulators:
> @@ -1490,61 +1507,7 @@ static int qmp_ufs_com_init(struct qmp_ufs *qmp)
>  	return ret;
>  }
> 

[...]

> +static int qmp_ufs_get_phy_reset(struct qmp_ufs *qmp)
> +{
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	int ret;
> +
> +	if (!cfg->no_pcs_sw_reset)
> +		return 0;
> +
> +	/*
> +	 * Get UFS reset, which is delayed until now to avoid a
> +	 * circular dependency where UFS needs its PHY, but the PHY
> +	 * needs this UFS reset.
> +	 */
> +
> +	qmp->ufs_reset = devm_reset_control_get_exclusive(qmp->dev,
> +							  "ufsphy");

You have moved this to probe from power_on() without any justification. What
about the circular dependency mentioned in the comment.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

