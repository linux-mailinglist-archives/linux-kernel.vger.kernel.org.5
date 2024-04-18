Return-Path: <linux-kernel+bounces-150589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B408AA153
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28F6283E95
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C83176FBD;
	Thu, 18 Apr 2024 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fb97ymLN"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B7175564
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462359; cv=none; b=UrD4aFsUWu+oIKX1NxMN/JweJhMEgg0UKD21w5oWYNnwl5GSmOdYLfDGNtPLtbVp1E+hFsgmynVkfgA7depb/bUheHg1FalngFme4I3D+LHqjoR5bgA3EQinYDGwZiJjJ3pwLy/4cU8mrQvxDIG9ssbyui/wDb2ZpGs3dvLzhR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462359; c=relaxed/simple;
	bh=cmVM7114Wg4c+eTojAQNT4khmmHaTED7X82UXWToh7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxdyJZHfyp9w2Hz9l6GbOrovYjpY92KORUU8yZuyReiIqWD5OQy+9sR8nOI5YG0HqNpibfLv5tcZXZhi+HqImd2DBThtdBDfCl0WJCei+OBlLXqQtHXCZkJDmzx/kUWVwEmpKWC8iezme2/CTYIL2RsayPHHYQ4UBZIT48eKXLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fb97ymLN; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so54277e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713462356; x=1714067156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CnaZqLleXkKRQtG9lodbPU6Ant05+dj1iWTT1GEt3P0=;
        b=Fb97ymLNSS5pF2oHoQ7M0Sm+fkc/FR3rdNIvTvsbwpSoF3WWpo33jhDtk0+hIt8w31
         S2+F5D4wujYAy9rQW56SIs1qqd474avBrGtcXVKGJ5uePCx4RB4je04c3bYszeEt2V1O
         Yhw4QH3Uxl8ghxBYzEqPftCWhsDctReLp1srgLyHHQl5bPANL8rWCjJLsTVh7QeIOM/g
         9962+HvpYUzrRQLscSS/ePxU5k8Nsje6YvP1yiC1njbHcleyW9+GT97KptvBHEvRdk3R
         Op9CRvIrvIAJ/Ke6zW42Gt0rVIqICN26O+jw6A+GGcGO4LeLKk1wZkmWAHJUWliHYpmm
         Akwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713462356; x=1714067156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnaZqLleXkKRQtG9lodbPU6Ant05+dj1iWTT1GEt3P0=;
        b=b1Mn9hZIkRgAScEEFFHXUg2XXBId48Q0gSqqJFeRKACZO72jcmP8iksc5rq0xOdssJ
         2BJQMQkUKys7rpU2d6yz0QdBSj923axMNlVL+S8/px3BT/i/NkhpuRtRjg+7jmMz/1xI
         B+QykE1Zb7bj5+FzYNKnufQ+iejNp92TfETGwAdFBG+DHJzxPJuqMjmRWFqmMGT7sdM0
         WHqJVVxrP+O0Mmqd77J04FoRFBCN9ctZBh3xirkOCWd6djgoSHQ57JCdZiypKwghQebg
         PYRwu8ybv4j+TYERkXhdRHGVs36hriiGjhUhv+b2J7Xlyxaf6WEQguCVT8xHIRMXHbZM
         avug==
X-Forwarded-Encrypted: i=1; AJvYcCUuTLCoFyL/6mUzhVO7QksQiTp89GGPumRV0J354PVqQ+Ii8DpwDP89ZNgqTeHfjEjg9PSSoghVmrmToKiHs9k+fKibhPdNE3CHnuDR
X-Gm-Message-State: AOJu0Yx5NlOx6e5fBcr2ISO5LyHUdJAIyQcTfqMSIYOO3dGWBcWTDiXk
	WC3BGJ7hCBMrUxjUIYLRmRyGpLkh/1HZvUPFPWqgKSxnCHrNlVqxfacK+NrE70o=
X-Google-Smtp-Source: AGHT+IHyMINeDJMq/yGej8du0gbVkUuDu458MwsKllIzhnyz9PhEDktjd7blUOHB5UnvEw9HDOFp0w==
X-Received: by 2002:a05:6512:2809:b0:518:dc5b:6f5e with SMTP id cf9-20020a056512280900b00518dc5b6f5emr3078202lfb.43.1713462355939;
        Thu, 18 Apr 2024 10:45:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id q18-20020ac25292000000b0051a20afb4d9sm171124lfm.255.2024.04.18.10.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 10:45:55 -0700 (PDT)
Date: Thu, 18 Apr 2024 20:45:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: qcom-pmic: fix use-after-free on late
 probe errors
Message-ID: <whokqg6gei5knc6kpmp6jidalljlfvf2kpa4xwjyh6xfsfj4ql@rjkweiqeu5fq>
References: <20240418145730.4605-1-johan+linaro@kernel.org>
 <20240418145730.4605-2-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418145730.4605-2-johan+linaro@kernel.org>

On Thu, Apr 18, 2024 at 04:57:29PM +0200, Johan Hovold wrote:
> Make sure to stop and deregister the port in case of late probe errors
> to avoid use-after-free issues when the underlying memory is released by
> devres.
> 
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Cc: stable@vger.kernel.org	# 6.5
> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

