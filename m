Return-Path: <linux-kernel+bounces-150866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C2B8AA5FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1460E1C20F06
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAABF79950;
	Thu, 18 Apr 2024 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QEG4v2rw"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304929CEF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483719; cv=none; b=PaeqUtJDedXZUKyRET/ttabfCCUGI9x6KfeBs5kQG6K5Sj8yhfoaDQB1l6BdBpLSDrVLB6AAtM73yAap2WdeKgQiSYljlMVtBYLFxv0ERqgLnM/lWPiXhnE+ffczrHbuRvjhhPuWC0qqK2Jrr0nOEMzZAUgmJgBGiJq/2jj1lxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483719; c=relaxed/simple;
	bh=+5tyRpFZjPP1SM73nE88cOsgWau4ESrZotbdiOXoto0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haIwG0RogUmKqpXDaPGrBPNewYcMrz1E440gvjdQCIHePrIr3YXdUsuPtqSzhnHSr4LEMWe75VAtgUDfu5L6qDckVgfHk4cJUc/vyj215r7g8qN7ggWA3vx2dhLIG7NzNn1am7GrsN1QsBdC84KhLcytlhUHnCuQqL6dQdNbJ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QEG4v2rw; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa22ebd048so892140eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713483715; x=1714088515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9IJ76Ejq6B7Vhl/CGpUW1RVfuowjYIbxdWO91aKguEA=;
        b=QEG4v2rwTMo/MMKD7O0UFibmOQukmuIsz4HpQz+Xq5b10QlO7hYSIwbwnbm4kPw1n0
         /fDpB8zle/dkMj1CCbAehjRqk+lR1Qpt97o/+goFl7oNMD5E0ZolkyVBc6pagDQLWrUK
         YLFQUYqn7do+eHFxgTwUost+xO2W3o+3odEd6yr+05iSO92GsYsbBW2W6xMDn7fxuMI5
         SpeYEQ/GLJfpV9cPOj78Y9KSHmgLXNYtQ3xq0vytOYaCgWBLYAdkwK8OH7bhgbL3vNEF
         iCMRbVGuU/4IJxrSFYgWCfwbgTtuxEi+oLyPusStceKT4AkL5MCJOP4uHIGwU8+mPVWb
         s3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713483715; x=1714088515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IJ76Ejq6B7Vhl/CGpUW1RVfuowjYIbxdWO91aKguEA=;
        b=VNNIygcgDlJ4bNfW+2lvyilszS+VNyMUGALAlgKi1vTHRCe7kBpJFwXvQ5zjpzdgxp
         Bn2z9JzR1tjMhTE5KNhd3th/dkvuVXCnD1K2d7D/YVSlXtA9LemnE+c208gQUx0uNkCY
         YCFhKg3EnvIRTTSaenArwRCUx5Ld4yaI0nVP+SsbLJJy83WRlBqAGW1++/KIKyQxYQuO
         gi8A+/PwwYmQsSYXGj5I/iCY5+GG78k1pi8y8wFmN3ok1rcIBsl1zb0Q+R023K1brYYn
         GqumFKLyH26bC9Lfb4hDY6oOnBoy8Wn+jNFyIOpjR8B8LPQU9YO1p/lH19yVr8BKf4+Z
         psGA==
X-Forwarded-Encrypted: i=1; AJvYcCXjdqR5pkW9jF+7esRAXRNK6HkZo94H1D2n6kD3QYqPP6JXQECv3nQhhHpoIEOxmTJ6yeFLzGcnRQWNAZEpgWq8dWGNsapxeuA70XUD
X-Gm-Message-State: AOJu0YxSj6PVXNa1gT7b4E9528QNLczM6od0mTP2eDbCYnKNLONC03Hj
	/gxGiRnusqV9OxofXmD0eh8zXNnyOiCmYLS3kEIaTSPFTxjOcajqBehdHpqBwP0=
X-Google-Smtp-Source: AGHT+IEPPhrny4ZXAVN1iU2b2OjfmoT6zuGx6RKKiOlIUbWTSDXLSdB15t4JfekdzgJZ4+jLDhSH4w==
X-Received: by 2002:a05:6870:92c5:b0:239:e7:a679 with SMTP id g5-20020a05687092c500b0023900e7a679mr596171oak.14.1713483715726;
        Thu, 18 Apr 2024 16:41:55 -0700 (PDT)
Received: from [172.20.10.110] ([209.37.221.130])
        by smtp.gmail.com with ESMTPSA id ld2-20020a056a004f8200b006eaf43bbcb5sm2050444pfb.114.2024.04.18.16.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 16:41:55 -0700 (PDT)
Message-ID: <c5965733-f49b-4245-8d4e-778c94203845@linaro.org>
Date: Fri, 19 Apr 2024 00:41:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: typec: qcom-pmic: fix pdphy start() error
 handling
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240418145730.4605-1-johan+linaro@kernel.org>
 <20240418145730.4605-3-johan+linaro@kernel.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240418145730.4605-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/04/2024 15:57, Johan Hovold wrote:
> Move disabling of the vdd-pdphy supply to the start() function which
> enabled it for symmetry and to make sure that it is disabled as intended
> in all error paths of pmic_typec_pdphy_reset() (i.e. not just when
> qcom_pmic_typec_pdphy_enable() fails).
> 
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> index 6560f4fc98d5..5b7f52b74a40 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> @@ -475,10 +475,8 @@ static int qcom_pmic_typec_pdphy_enable(struct pmic_typec_pdphy *pmic_typec_pdph
>   
>   	qcom_pmic_typec_pdphy_reset_off(pmic_typec_pdphy);
>   done:
> -	if (ret) {
> -		regulator_disable(pmic_typec_pdphy->vdd_pdphy);
> +	if (ret)
>   		dev_err(dev, "pdphy_enable fail %d\n", ret);
> -	}
>   
>   	return ret;
>   }
> @@ -524,12 +522,17 @@ static int qcom_pmic_typec_pdphy_start(struct pmic_typec *tcpm,
>   
>   	ret = pmic_typec_pdphy_reset(pmic_typec_pdphy);
>   	if (ret)
> -		return ret;
> +		goto err_disable_vdd_pdhy;
>   
>   	for (i = 0; i < pmic_typec_pdphy->nr_irqs; i++)
>   		enable_irq(pmic_typec_pdphy->irq_data[i].irq);
>   
>   	return 0;
> +
> +err_disable_vdd_pdhy:
> +	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
> +
> +	return ret;
>   }
>   
>   static void qcom_pmic_typec_pdphy_stop(struct pmic_typec *tcpm)

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

