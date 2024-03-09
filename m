Return-Path: <linux-kernel+bounces-97856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C19877081
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B771F21488
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F772C6A3;
	Sat,  9 Mar 2024 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+stfkch"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5216C28E22
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709980863; cv=none; b=rbIpMUu4HF73XRf9QuwjZcewnp+RwiuzI7Iy3xMP7UsDNO2TYbddIlysOuNobs90BObeH6ynFrHh28dSMY5jX/fzAq5scekneY5TPeUrhMSuJW+Tsip34VxHkMJSptyuX5yupymAfBNLdm1ZjTLsinr6Tf/2QqXfMxX1qx0YTXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709980863; c=relaxed/simple;
	bh=Dh9V2PfB348Arae8187yykw+A7d4pAIxQgkMlEODmIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aM2ToreXpFSdCBJs/OSLSKKInMrI/XzLfNaAI7yYdxipD4ZgjJQDl8X1z9DgWxWgYVL33JHVc/14EEPWnRchAWVUgDRzH5XneLYNa0ueaBdhUYJwzTApHMfLeNLlXVaDLpSEU4qkhfVnsksLJ8u/T9Ww8pd25se3Kkhb4iy0WCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T+stfkch; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso1903153276.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 02:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709980861; x=1710585661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/zwcDfLfy6H/xwTNg7xVsc+HCBPAWPPDyK8ncs4w+gs=;
        b=T+stfkchbw3OzdhVTmml7wBSaHenkNjauK1L1qMQKhTAvvGdhPD7hBCiyo5MdNF/pE
         10bEQswQKQ+p1NQbdguDlUAOYKU19ywyp5araFn/nZJLZoYe7teiKXkl/AatHLWzAdjr
         kbTwfhptcVhnmySU3No7yrH2gAb1hsaEEuqSYUd4CVTukpXM4CIUkoCrMpkxVVAVdrGY
         xUDEt6VXUPJOXM+fot8W3bHdCAZ4gjUhzIFBI/rkTy+puCfc46n5qIk32BB07ePWmvs9
         uzWYwUH0rzHUVO3EdPGceDh9Za/BqBv58TAr4ZUzxMgO+D6JvXp2iqVUFGtSpMu6NGB4
         JtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709980861; x=1710585661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zwcDfLfy6H/xwTNg7xVsc+HCBPAWPPDyK8ncs4w+gs=;
        b=matQ6d/8nqDMtT1sjBEbsrRVswFlAXgUV0ZEDr6wZZlC2daZSNTXgBQs0D4MKaLS4O
         nUyqbJlXWGc+0ubOUcDqnhKg72Z3iIMgKnaI668YjPYWPfJSF7T8YWSO4zX5y3cZ7lds
         H5t7f0vX0SvGiliU9LF8kOdD0pJjsRBq86EAP1Jt5PFjtxJpGvrCsetlTYdZC1MgYS0h
         Qs5DDJ5S3QbbyouSg1oAmVmD7rzQpFK/QoSDyiQKPn8GjPHFiY9fKZFmtlttgk2WLzQc
         3oUTu56Q07zVI0bIzNQiIkA4oIMQaECXX4mVOwE5Cle1pzfkwX/8ksxMO7jlqkAcCv6v
         +aKA==
X-Forwarded-Encrypted: i=1; AJvYcCU2KwYz0TRYBYAsiC/Q401UYeMv179KtepdMjrCEI06IDETz13zojrjM/aFFOm18aNn9xVbhu7HUudLjid7NPKccnhjIGhijHX0nRRu
X-Gm-Message-State: AOJu0YwwDWQV4o47+Xp7roMk6n6Y5xjFADdI7jreE53AMo8wgoeBA5gS
	wCQoTqCthkt6K3puj7RshGcD7vxijPWt3FDwY0aZ7uEpElGjDmDcHytKH1jkc58NCJMmd++3v04
	p3zGSZOwfGbbwWcyub8UwMa63rsZL5dnCz0T3jA==
X-Google-Smtp-Source: AGHT+IHwQwkSLfesKtrPrMGKJ4Q2PnQLBph1lGKkzbnH0SpIFTbRZI4HlaMD+5FNweFu/bH2N/hGy0XTcTcPw+znj1M=
X-Received: by 2002:a25:b325:0:b0:dcf:f535:dad6 with SMTP id
 l37-20020a25b325000000b00dcff535dad6mr667006ybj.56.1709980861366; Sat, 09 Mar
 2024 02:41:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308-topic-rb1_lmh-v1-0-50c60ffe1130@linaro.org> <20240308-topic-rb1_lmh-v1-2-50c60ffe1130@linaro.org>
In-Reply-To: <20240308-topic-rb1_lmh-v1-2-50c60ffe1130@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 9 Mar 2024 12:40:50 +0200
Message-ID: <CAA8EJpq9bOkv9Ha5wjOjHGdPT7AqTZWnA2SpLNGB99YXP2OmQw@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: qcom: lmh: Check for SCM avaiability at probe
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Mar 2024 at 00:08, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Up until now, the necessary scm availability check has not been
> performed, leading to possible null pointer dereferences (which did
> happen for me on RB1).
>
> Fix that.
>
> Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/thermal/qcom/lmh.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry

