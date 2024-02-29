Return-Path: <linux-kernel+bounces-86663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF11886C89C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725411F230E0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144BE7CF2F;
	Thu, 29 Feb 2024 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M80JQ2Ti"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9C7CF20
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207637; cv=none; b=MyNgmnMDeq13B3cPtddTKX6ctg6bMSDBqju/jR2SMFKDHxUyoZn0GDi3/ydM/rBn0VUUKdWpFdfaTCOLbGkdXfdqSSiMgVOVCk1IX3CVEei0VUOEebD7keKrv9oZDCZ+UpQQwXStzMJ97Qi9peAFitDmgJMZrWxcCS1cY5Af2VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207637; c=relaxed/simple;
	bh=aPkZ1pZjNnJJI5Q/fiChvIDLNBuCtmd06jZTdL+Ggyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXyWLrVGpjZLVgHAMiSvArKblGdESA1Uqj6Eb8cm0dFDT7BX9UL80YmUnuVjWEcg6zPcZn0UP5ftEw7EUVdhws3l5uccTezDEpiUMspd5q9+9udZ3AaShN0CjxLiAGM9utKP0BnlawaEEr4/0S0g7qz0jMdOEhz9TNBTNcb7v0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M80JQ2Ti; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d288bac3caso7276451fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 03:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709207634; x=1709812434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sLTFaT7Nkx/eCJKDRCtLdc30QfXkBoGZ+x/B0puoFKM=;
        b=M80JQ2TipHM6leEvcZR2f4CFW5hd2CsDU/ysmgY/4r/0Zqw1Xpoq+ALxNkoainj/4Y
         SHhn9jeQ4dYemKDQQqS3DRp6uXTs0bCZo12G8RIqKvJdm7l5BiAPDwfhwl9sv+7qywhc
         yVcXYHsi2KlmbXVgTGZei48uGGUAJAWvpggTwtk4iqgBO9RV9UpsLtJufyzmnsXkNcOd
         dnuGr6WJEW9od+9zAzCcSCz3zIJ7LLceO074VF68DyFzi8yqnbLDP0kvpgy3cd0af8zm
         jku722Gpl87onExcA1vTACxCgBAFC9gknOsuQrJw/FA0taUxtDHmTk3rFWJuqEA08bbi
         iYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709207634; x=1709812434;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLTFaT7Nkx/eCJKDRCtLdc30QfXkBoGZ+x/B0puoFKM=;
        b=l0ppDM8uyOl1+4R17bYTJaOnLOZoSpg5vy5yZdmBkAIFariEU77FB40y45xpp/Ckq8
         NH/lBnNJtluCwD8WYEupApZ7LLHYAjBhq6oMc6FQWVwldDlOuyBX6KmTz6iUId8n1RhB
         qD/X2XTnkdhpu9UPnSRe9U6DZCMv8OuK5cOEfYocH6sAWxkhX2qDp+C8ejfXLtg6fTXh
         dFXLPJGWmf4xkCJXuLSRNmUKc4Ub2N8H4MHXcZ68C80rvUedyMfc63VstiRSGg7IslAF
         OossAVv/BVBRmr6Eyg/6l1LbHsIoz6lKvQnk8EVwnlxJe9YUUcgCnIzuktkstlL3M1RR
         O1yw==
X-Gm-Message-State: AOJu0Yz2hCoExGSNNue2kNRUYJwrm1h506qV/HJ5cJSv+iKy8OcXJrAa
	JaPMnJHxLRLr2yReQBbhmJo8trPOVTtFoDvfvRFk4ShAOb1jtiMNnQj7PAQ3lpU=
X-Google-Smtp-Source: AGHT+IGP0/pA++rl3U7efvrQPpAwssqlcxwqZNQ6Tt9Nv8HtPUR9CpPCo6oXDAAXGe9esJJngWtvkQ==
X-Received: by 2002:a05:651c:2105:b0:2d3:776:a8ab with SMTP id a5-20020a05651c210500b002d30776a8abmr967147ljq.45.1709207633804;
        Thu, 29 Feb 2024 03:53:53 -0800 (PST)
Received: from [172.30.204.118] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id b10-20020a2e894a000000b002d0d02e50fdsm201372ljk.78.2024.02.29.03.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 03:53:53 -0800 (PST)
Message-ID: <2f6bf03f-b0c4-46d2-baad-4047c78663bc@linaro.org>
Date: Thu, 29 Feb 2024 12:53:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Disable pmic pinctrl node on
 Trogdor
Content-Language: en-US
To: Stephen Boyd <swboyd@chromium.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
References: <20240229012828.438020-1-swboyd@chromium.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240229012828.438020-1-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/29/24 02:28, Stephen Boyd wrote:
> We don't use this pmic pinctrl node on any Trogdor devices. The
> AP_SUSPEND pin is here, but this pinctrl device isn't a supplier to
> anything in the devicetrees that include this file. Disable this device
> node in the DTS so that we don't waste time or memory on this device.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

If you don't use this pmic, perhaps the pins should be explicitly
"parked" instead?

Konrad

