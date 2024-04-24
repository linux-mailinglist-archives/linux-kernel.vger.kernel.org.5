Return-Path: <linux-kernel+bounces-157623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEAE8B13BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C033FB26739
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7F413A401;
	Wed, 24 Apr 2024 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEVETtDR"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D031772F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987860; cv=none; b=RC7EBJWy9z06eJl/dOdSfVGGbJ0iYsNuV8TsWkafjFXM9VK+7pI5p7UX70YuuHIUIyMimWMAx8vZyktnTKtzwEr/RRlvJhGcTOn06X5p//g8WYD2xS2Y8rMWft7SrfKxJ0ckeME1iNIWo9j4kD4lv75451bJVGXmzj2vWDY/UEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987860; c=relaxed/simple;
	bh=SHS+idxz3xdv8Xun7bfL6z19nxq1XI4eGUs6WLzWbhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eak2I1UPBabdMUp196w5ygZiu4oiEhODJ0P3TIngr5XxlwbiDHNLcXx3xxVR40V04YRbS+PzoMquUujTGl0Ma2De38NttJ/kcB4TwquxdXSjgz780rKCyI+nyKGHG+MRvKl4XY3IOFY2H6KEDpiigU4Hajn4f2ayTzkFJDRjrXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IEVETtDR; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2db101c11beso2343561fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713987857; x=1714592657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vafs3nvN9dgAZ9/CjOw5I4D2RBxmfmANPhjz8LrzFXE=;
        b=IEVETtDRnxV7DDEiZDWEDg+4m6D0jnPcE3kKE+EZRL4CjPEh5SMFdMCBBrmx7ryIGs
         7jl52TlzjGmUjIyszIXAeBcUzhlKNkqBJncZPSY61stiwiIjJ0FlKMB7Bw7A88SIIwQY
         H5M8OAg20LbNx0yaTX1RMgsmxh6O7Wb/cvC3XdE81+hdmiAOdbU+bSyxWN86roZ8xWOy
         Vcv85TKme1XbhgG2NqcFhyP3wyO1mUY/3Hy/iXF/nRf/vAkM48IISg3aItrjcmpGOiX8
         GstsCWKrdvTf/tghcDyC0cC4O/ZIWJ6xJoHdH8ic0NBeEO1oxVrAQPZ537y+iShkvf2R
         bDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713987857; x=1714592657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vafs3nvN9dgAZ9/CjOw5I4D2RBxmfmANPhjz8LrzFXE=;
        b=n9PjYJXiwGM4D+ocxeXrS25S6/hL5qx5wb4R4MhKonDvgcAquDLFkbGktJPVCDbDIM
         HTFPCLkMFRrokbX3aFcAHzWaoLM0ST9KJnejEaCq7ktXQi4reMNeKGezqveKu2WmyM5o
         ZDxIRxuAWo2XWZAo51hWZ4lKd/BSDJco13WfOseJcLuQGRE4uzK+WO+lqq2XKEysR/wh
         G3h6E4eAcw8T4wxe1Ldx6pGP/KF6SdV+JAbLv7gEcvT6yIcGGow2L8RCwFZ1psRPs7X4
         q1XolOWGsLQ5It35x64Pgp2VhW8+BKrY+dhKl1VVZCHm07j3eAv2FmYp7kX1bMfXCGKr
         jotg==
X-Forwarded-Encrypted: i=1; AJvYcCVEON+25x3q6I/S07p0v0kDFFvVcfSsU1ChZExF1pGa1C7ql4ME0egKLR9f+CclgungboaJYxUT+8LrKtHJyafMSZrxybrNSYMLKM1s
X-Gm-Message-State: AOJu0Yztvp085/I8N0b2+J5e2Tc1vLWW54j52vaEiAAym3Q2hYeh4WWp
	gqU1YtbSgLh7cHTmhAl7EfL6lnIW2RFHJta6aIYHgorcbIlK/sE2ha8sg3Iqowc=
X-Google-Smtp-Source: AGHT+IGCXef3XnPsK5cT0g1DZqwuA9Q29qnFcMYr2Fhi61/p5wZFZniYAhOTTY+fOOdBRJuSyKKFxA==
X-Received: by 2002:a2e:9f0d:0:b0:2d8:6104:f95a with SMTP id u13-20020a2e9f0d000000b002d86104f95amr1980841ljk.23.1713987856997;
        Wed, 24 Apr 2024 12:44:16 -0700 (PDT)
Received: from [172.30.204.223] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t15-20020a05651c204f00b002d864ef1d74sm2153371ljo.49.2024.04.24.12.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 12:44:16 -0700 (PDT)
Message-ID: <6b73369f-9cef-4ab5-abf4-c5732c2ad168@linaro.org>
Date: Wed, 24 Apr 2024 21:44:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: qcom: msm8226-microsoft-common: Enable smbb
 explicitly
To: Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Luca Weiss <luca@z3ntu.xyz>,
 Bryant Mairs <bryant@mai.rs>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240424174206.4220-1-rayyan@ansari.sh>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240424174206.4220-1-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/24/24 19:42, Rayyan Ansari wrote:
> Enable the smbb node explicitly for MSM8x26 Lumia devices. These devices
> rely on the smbb driver in order to detect USB state.
> 
> It seems that this was accidentally missed in the commit that this
> fixes.
> 
> Fixes: c9c8179d0ccd ("ARM: dts: qcom: Disable pm8941 & pm8226 smbb charger by default")
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

