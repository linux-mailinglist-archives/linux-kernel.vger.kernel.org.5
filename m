Return-Path: <linux-kernel+bounces-76155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C2485F391
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4816F1F24270
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8944A374C5;
	Thu, 22 Feb 2024 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PapNwf3y"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5237157
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592136; cv=none; b=jH9Oh5OT5XMLZx0DPiMvV2nxVQB4rzCnLPGhOAZQBodJeZrY7evCslc8nNc2urJwRSPnvqSc49BYiCThCgnDVwE67tBQtJgyneIj+NnosabUC0YkKlbIrBV+GZZDyArLMiIXGPUHIBMRMD0GssB2OrShHLj7/Be7/B1rv5CBPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592136; c=relaxed/simple;
	bh=FjEV8hE5eZcXGtQ08yUqG4aewSRcZQEUdUXoAZyvLdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOK2M5wa+fONA4BaUAL20+ZWOXkBVJdsamM5X3GJvowWoySFqA3Y2bRx/ZzCbn63S3H9koOATGyLHUe7I4okgV76BwUM/eizB+s0yqBNoqLzbe7llOJhflR1QABXacw7ajMrUc4h6bue5gfCIbyBkQJ/64/8Xtweu00E5GMROQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PapNwf3y; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512ab55fde6so6561560e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708592133; x=1709196933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvafyN1Ki3gtTTRQp/+ld7EIImwoKNgmY7mZr4vWUK4=;
        b=PapNwf3y537Ms/L8k4eX+lIusjbE8m+RODhEiY3DAcffEEw1EQsrNG+6fbKIe9EyAW
         tIA45Lnl0v3HXhAbk4xOFyxtc+fv6xYtw106ggEykTsnmy8TakKtbWGpfkaiKbMjrYNY
         WsYM6B4j94DypUhEtw+ttyTmcF/hXFFIHEw0yRoHo8AHJQ4GdZCF5+zr6lp97ZC4ZFf6
         AyVDGex46/8PCDe7Q5y16MZUzdcKZzYe29pKlZA3knz9KU4s0zDkXTtuE2IiTwiRSu+/
         ffWo1xsBfSfdRIOY5WuNtaiAEjHaT9rwk9+PGKD+b9E43izvMczaPA41jjzuIO2sT2O1
         nZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708592133; x=1709196933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wvafyN1Ki3gtTTRQp/+ld7EIImwoKNgmY7mZr4vWUK4=;
        b=fwJHNuFQmW4gjkutItoB7gYsYLNuPxYPJbGmLHjX6KAbFY/Cn+/YmiWHccXuAdjkWL
         ZQDpksUOoNxpEytp6lSzJjEULRR4Bk51oKlnk+1o01CUoyeX6FwKQJqDxgLF06mKt6rA
         /S0a+rWslefy2BAsmeGblX5uRtW59XYOAFP5CsyRfkD0KmvNUc9SmPB9ow0pH24DAyMY
         32oDcPLoJQ8AbzjAPT6fPkiwLt44LcOx6xIiL3JWcfJGlGmaRoPEtHnSziHzMSjqDRTV
         Nr3TY0ArVT1irnmi6gWHkq1aysAGQenl0AUF5COcQMEadLR98hQ43STHaNORng13/AZT
         uOSA==
X-Forwarded-Encrypted: i=1; AJvYcCVaHT9WskkvpSpGoaQGY0e/4JUfTY2bcNlpsc81zM6VKybKoXHeuDSOOE6ZvcsY6bBYKQIevouS6aJiebQ4sLDvZ3QCD51u7uIrppZQ
X-Gm-Message-State: AOJu0YzzIsNuvbzhc4oHx1gIEu2jxc8kYqdUD1Nb2aKAinFO9wuZkihV
	PzOn8i4ozcLFd2rKZvzyaaKYGFFQZvnNksdUC+Te0TdrUUYsNj0txwZVL2aD3Aw=
X-Google-Smtp-Source: AGHT+IEtIiogO1qg0DsIHuHZDJdmbDgFoql2wOjjQ0dHxEtTw/GBno7cWP1Jf8NhMK0pYXBLxrLr8w==
X-Received: by 2002:a05:6512:128b:b0:512:d8fa:a0f2 with SMTP id u11-20020a056512128b00b00512d8faa0f2mr1752378lfs.22.1708592133207;
        Thu, 22 Feb 2024 00:55:33 -0800 (PST)
Received: from [87.246.222.6] (netpanel-87-246-222-6.pol.akademiki.lublin.pl. [87.246.222.6])
        by smtp.gmail.com with ESMTPSA id b6-20020ac24106000000b0051176ff32c1sm1992022lfi.62.2024.02.22.00.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 00:55:32 -0800 (PST)
Message-ID: <dcbf0e04-0252-4cda-be1e-ee4c707017f7@linaro.org>
Date: Thu, 22 Feb 2024 09:55:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] arm64: dts: qcom: sc7280: Make eDP/DP controller
 default DP
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
 <20240221-rb3gen2-dp-connector-v1-2-dc0964ef7d96@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240221-rb3gen2-dp-connector-v1-2-dc0964ef7d96@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/22/24 00:19, Bjorn Andersson wrote:
> The newly introduced mechanism for selecting eDP mode allow us to make a
> DisplayPort controller operate in eDP mode, but not the other way
> around. The qcom,sc7280-edp compatible is obviously tied to eDP, so this
> would not allow us to select DisplayPort-mode.
> 
> Switch the compatible of the mdss_edp instance and make it eDP for the
> SC7280 qcard.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

