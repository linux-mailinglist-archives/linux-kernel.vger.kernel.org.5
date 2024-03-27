Return-Path: <linux-kernel+bounces-122040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E2288F116
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B571292911
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288CB153591;
	Wed, 27 Mar 2024 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yGJZd8Oi"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEDF152532
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575545; cv=none; b=CNUyhz9Sa3kZU9C/VyNWTonJlYCK2OsceGIDYANoVx06YJeVCE6L3qaB6/uEflqSufKdFKjfNodDjwej+j83saHlI6xl+JF2tK76sCca1WBWRTsF0afjPPvQeweqO0aUkRv5m2E3MugudConPV6h4pW3DeKHchWcVuAJShzki4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575545; c=relaxed/simple;
	bh=bu6RxpPz3djudl2ukcas1r/SzQvrd4PByfxE3MOX2nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKl8HT9hMSMn0ZNXaFjCgZpxOZrDJnKeD9X2EFkllPe46URZoPZn1LkJqFbGu2OEr96qZtH6jnsokfKx28SLYV5bwhQyjVEP9z034Lha+Mmm8SDCYtISDvhMrbGJ7mwYQhdCJMvCsCOc+0ugC8RP9AcFOxFRxFkPbMKTsItk6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yGJZd8Oi; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513d212f818so260024e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711575542; x=1712180342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QZUBkdVY61Xlb2cgTE2nmUubLiWvg04+qp2XWqnm/Mc=;
        b=yGJZd8OitfxVI9YtDhLqF+V66mBpH87A3WyfD2g2Zzl/L3ozIBtALYJPqrxD6bd7bj
         ebfvP2Uj/T0WEJHqcRyDo5TltnIS0LbOfVEneDB+oZj2YNCvQgKSaiTqaAO3FFCPKBUA
         fvolNDymzfWOek3XC0IVrf2cwlsYIl1FrEbkVYrYDJU2CyoxJ4vBBoihoJ+3PzE7W2Gm
         dlnThMGY+lFtH9ZyUowSi4iu7OSkrTZUpHNjXFGKUYX/MLRO+vXqD18YTWzb5WXjCvh7
         iCp3LEkX2XjLUwiGjj8oGba9K9nY6PVYv/qYAI/4FoynrlausruKLOcnAq9gMhD1DAJv
         k6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575542; x=1712180342;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZUBkdVY61Xlb2cgTE2nmUubLiWvg04+qp2XWqnm/Mc=;
        b=hTPbrUkHl+d78h54s1BI8/jcEZU3tCAgCjbTvbvBQN/r3296+ZRdlNLLtZmIvYqqAZ
         1QQKZixfIivgaTA7U6oVtybBh0FPdjb0eoS1lB486ESPW+e03p1AQ/vl7mUiVDqUPACD
         Qfj9XfLrVrGmuOI9Y/+0+W5jN+OY1MKovpd/MmqfognGm0RdyDqHxYix1fy7vJCFhQYG
         /XDhs87e1bpPtBBnGWrbeNMF8timr/VpJB8sABfhrQYeyUFXD24qPj6bWAfiWAHZ18lo
         OHlu+21yHWnjPZufu8DenWRC62Wi7BVTlwiNJ7te5OxLrruYQzf6ohhIU9v8IbMttGmX
         50kA==
X-Forwarded-Encrypted: i=1; AJvYcCUbzXs2anwwcro1aq6D6AJrBdyWD5c0IzXpOz2tJkSkNGZAb0oC7nwtw/Gumd5AaLxJa4xBAH/RBNnWVHdXsQQh7kMP67Orb+EHVg2B
X-Gm-Message-State: AOJu0YzX94NV5mvzDoTz4L2UM9tYyUbjx6dpJT+VUMugPdJ8zu8rz0yz
	IU0tURNkAcIPMMcPK3WCwMEE2oj229eoKDxB8YGtcIVfKu7chyM1YyuWvVBBXmq73aH8TgbZEU1
	y
X-Google-Smtp-Source: AGHT+IHaoxkChZu/+Jt0Xrh4sJcV8X/QAzL8iuwzT7IqFsgZ0w8MskfrrQ4N0RuTGIQCbnsSSIbwnQ==
X-Received: by 2002:a05:6512:535:b0:513:e934:8e34 with SMTP id o21-20020a056512053500b00513e9348e34mr491448lfc.56.1711575541912;
        Wed, 27 Mar 2024 14:39:01 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id ci8-20020a170907266800b00a4e1aa345f6sm70245ejc.115.2024.03.27.14.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 14:39:01 -0700 (PDT)
Message-ID: <afcbb668-ab9e-4f97-9014-ecbd5170ab92@linaro.org>
Date: Wed, 27 Mar 2024 22:38:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: qcom-qmp-ufs: Add SM8475 support
To: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327180642.20146-1-danila@jiaxyga.com>
 <20240327180642.20146-3-danila@jiaxyga.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240327180642.20146-3-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.03.2024 7:06 PM, Danila Tikhonov wrote:
> Add the tables and constants for init sequences for UFS QMP phy found in
> SM8475 SoC.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---

Worth mentioning that SM8475 is a respin of SM8450 on a different
process node, which probably forced some electrical changes.

Konrad

