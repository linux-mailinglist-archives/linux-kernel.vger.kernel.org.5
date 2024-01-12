Return-Path: <linux-kernel+bounces-25078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D9B82C73D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0A51C22455
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A6E17745;
	Fri, 12 Jan 2024 22:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K+jkxS/H"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500161773D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2c29418ad5so341257066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705098529; x=1705703329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k+g8KAN/GocAbP+Hjj0VU3R5oOrMC5lRs+LQJKDyZbc=;
        b=K+jkxS/HFNwjqGT47Hes14wV4POIlXFMqJjU2r06BY6/ANnvSE/NxIER3GEbt2Rci1
         G+ySvp3yP92iSYndcPdgTP6X5prn6o3ewq88l+pzFuU03dwGecfVMjOmfuEpRysp9Yj1
         8qWmc0Tk1lZOZowmMKuoQFig+tFKJ1SqxL/E2g/E2jlzOmhwnrtaFsPKrgKw9WCtQYeG
         YMpeul7CqohG4wU/WwjK4J44hX9fdGvKBTkEd7AfkKlNtGJhIJN8jo6zJT2Yp1OCBJ/7
         HIWvt7IxJcpOpQyV6MVmy/6XytdULTSKDcX2uO08U9GsBAgOJREQ8gmSKZUmQWhUMnhl
         SKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705098529; x=1705703329;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+g8KAN/GocAbP+Hjj0VU3R5oOrMC5lRs+LQJKDyZbc=;
        b=sWphJDGZkt1Np22n/02zs8ZwZTvFFk22mGs2b6to1Dqh9vQm1iz4m3Zn5Ry6Ayq+mN
         Mk7WUl9kzUVtCiuXKLpGDCJoeXVScw7ut7/tJPyVIxTg69wizUW5zDNO8x5n6PpnSrYI
         lRAlnB41ePeAQ2d6CIghVW7hn2U4akUSn5iRgsgaAwiIlMfuOLQZgQyKohyP/ZkpkkHc
         6NW4mT2u/Wa9GmWzUU5Yp5JYdOSogDRwgYlW4xMucpqU4WamNO5M9gulk+STvhnfbBV1
         TE4e8AUSXVfxKfa211N8+LE9ECiCdpBPj3Ysd4LFrIg5hZGkbIyYWJMQ0KsQcbsRLeEs
         IuTQ==
X-Gm-Message-State: AOJu0YxF+UeVPJ9NJBMNBqvtzSEzb3mQogq70AQ7/mP/ExCgn24ffg9k
	Yhhk6TAUfHUfZo3h9f6dcPAa97hNSV4EwA==
X-Google-Smtp-Source: AGHT+IE6Y1CQAvSWgVhfPTkwN2W/RAJPjIutDlo+/cj2s9k6qNsUhtuGUhJR5tGNazvTNT3GoTlf0A==
X-Received: by 2002:a17:906:a202:b0:a2c:4b7d:69db with SMTP id r2-20020a170906a20200b00a2c4b7d69dbmr1054995ejy.18.1705098529417;
        Fri, 12 Jan 2024 14:28:49 -0800 (PST)
Received: from [192.168.174.25] (178235179017.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.17])
        by smtp.gmail.com with ESMTPSA id hx25-20020a170906847900b00a26ac57b951sm2215051ejc.23.2024.01.12.14.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 14:28:48 -0800 (PST)
Message-ID: <2a8ad790-6f3b-43d8-af31-0e6dcca72c54@linaro.org>
Date: Fri, 12 Jan 2024 23:28:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/2] scsi: ufs: qcom : Refactor phy_power_on/off calls
To: Nitin Rawat <quic_nitirawa@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 Can Guo <quic_cang@quicinc.com>,
 Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
References: <20240112153348.2778-1-quic_nitirawa@quicinc.com>
 <20240112153348.2778-2-quic_nitirawa@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240112153348.2778-2-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.01.2024 16:33, Nitin Rawat wrote:
> Commit 3f6d1767b1a0 ("phy: ufs-qcom: Refactor all init steps into
> phy_poweron") removes the phy_power_on/off from ufs_qcom_setup_clocks
> to suspend/resume func.
> 
> To have a better power saving, remove the phy_power_on/off calls from
> resume/suspend path and put them back to ufs_qcom_setup_clocks, so that
> PHY's regulators & clks can be turned on/off along with UFS's clocks.
> 
> Since phy phy_power_on is separated out from phy calibrate, make
> separate calls to phy_power_on and phy_calibrate calls from ufs qcom
> driver.
> 
> Also add a mutex lock to protect the usage of is_phy_pwr_on against
> possible racing.
> 
> Co-developed-by: Can Guo <quic_cang@quicinc.com>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> Co-developed-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 104 +++++++++++++++++++++++-------------
>  drivers/ufs/host/ufs-qcom.h |   4 ++
>  2 files changed, 72 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 39eef470f8fa..2721a30f0db8 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -338,6 +338,46 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
>  	return UFS_HS_G3;
>  }
> 
> +static int ufs_qcom_phy_power_on(struct ufs_hba *hba)
> +{
> +	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> +	struct phy *phy = host->generic_phy;
> +	int ret = 0;
> +
> +	mutex_lock(&host->phy_mutex);

guard(mutex)(&host->phy_mutex);

and you can drop the _unlock calls

> +	if (!host->is_phy_pwr_on) {
> +		ret = phy_power_on(phy);
> +		if (ret) {
> +			mutex_unlock(&host->phy_mutex);
> +			return ret;

And with the _unlock now being unnecessary, you can rewrite this
as:

if (!host->is_phy_pwr_on) {
	ret = phy_power_on(phy);
	if (!ret)
		host->is_phy_pwr_on = true;
}

return ret
> +		}
> +		host->is_phy_pwr_on = true;
> +	}
> +	mutex_unlock(&host->phy_mutex);
> +
> +	return ret;
> +}

[...]

>  static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> @@ -378,13 +418,18 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  		goto out_disable_phy;
> 
>  	/* power on phy - start serdes and phy's power and clocks */
> -	ret = phy_power_on(phy);
> +	ret = ufs_qcom_phy_power_on(hba);
>  	if (ret) {
>  		dev_err(hba->dev, "%s: phy power on failed, ret = %d\n",
>  			__func__, ret);
>  		goto out_disable_phy;
>  	}
> 
> +	ret = phy_calibrate(phy);
> +	if (ret) {
> +		dev_err(hba->dev, "%s: Failed to calibrate PHY %d\n",
> +				  __func__, ret);
> +	}

You can drop the overly verbose __func__, unwrap the line and remove the
curly braces, similar for dev_err-s below

Actually, shouldn't this error out if calibrate fails??

Konrad

