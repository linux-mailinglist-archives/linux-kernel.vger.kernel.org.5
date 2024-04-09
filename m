Return-Path: <linux-kernel+bounces-136587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF1B89D5CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFC32856FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C960B8003B;
	Tue,  9 Apr 2024 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXZnQXLy"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C27FBC7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655940; cv=none; b=H0vIJl8Y2yzodAY4eHZDOL+tRZIdZKtAZL5oJ1qq42bxqvNKWeMdsWYgSApbO+ntEpTQV2N7gQbpMAz+taWOo48YKpGV7fqS9b2wWcUdJ6UsR9B9GKCGySaOhmxS0D6oPaES8ljLf6R71vcGTaEDn2DRbCQuaTqqr6zTNmucNwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655940; c=relaxed/simple;
	bh=vXHPhWoqvDe9SoBoLnbihQeKn1FbJdKLOtbiMVbqAbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sX5SQOD5bPlSPThJWgPBqNXAaOc/I9EsvE0uLGMj4Y5tHcSQ+oOjzHtYjPhfdbCnx/0B7c5aMGK55AlWUZTjQM8ZJQaNea5JE6f2r+zkOlKeDHtVBfyKwmD3aaqayDoFieKaObASceu1p+pImvj0xevjL8NPWM5x9cAGbweLjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MXZnQXLy; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d68d7a8bso3531359e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712655936; x=1713260736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJVBzSjAv8j+mAl0LlHvG0rXd1n1n6iiW2X1MSaq45c=;
        b=MXZnQXLygJIljcY1B7fe//uaAhDX0iiCAR6HVLcQ1hYUcOquXT+UJRX/Uv6AaS1hHS
         fqwcS9CVw58t8VXEIsd/Gm1vkbePpHtuxr9L+7vhVInUvVPJmL8GDB3zquJdFPQCtmyF
         XW7WxQFXF3WLgQAKOBl7gT0F2e+T9ugKgXWA8flVohrgkVVeHQ1TB7+g0cICHkWOagai
         BK6xPiMWTbISZQ7dH2XuFnvlqxQLnwFQX2B1l5kj8LJiCVno8dVzdYxOgXLz30pty+c+
         v/2Jkxz1k+lWsFyiLiLoOwi1IDJjAzzqIg1kjXqI77y8yPmBrnbPpxWz4Y7ysHSN9IaK
         AQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712655936; x=1713260736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJVBzSjAv8j+mAl0LlHvG0rXd1n1n6iiW2X1MSaq45c=;
        b=B/URr8nHLl5jyzrsU6Z6NoHTFR6tFPuCpaeDh/EvKVfXi7KzvpYJwQ6fk1Ygobxq9P
         12rjswX4rESWLhfHaM/lrnxgROlQW/1aElQXhPO2810ShmOw7OxBdej9a00jLunP1BvF
         j1lyNwBn8nkhIak9rQWqGiKltAhzugksgaSO85SBKtXWZ+tSyELye4/Q4uBV6l1IM2OZ
         UpYuDvD4Dtgsbv5+Ww/VAyQrmSZXoSX4wBnFHF7xER1Q7ExptfAi2uDFIPNmJEfk7tv/
         5LuxxGF87fd1WxAImc1fN8sOGsgke3lS022HiDhjcWg1UO51fi+fUeg136rVszCDDOAP
         kDIA==
X-Forwarded-Encrypted: i=1; AJvYcCXwnp5x/q00EhirY0DUS2KPVlXZFnduOo8yR/jgGdQftM2KjExaxW2EpkHvlni0sKFNs2ra3lfO+X8FPkxZ354GJ00DanrZYe0ZkOqT
X-Gm-Message-State: AOJu0Yz5WX2nPp6ExEC0b8BYNjzZlmuFLgQObIvD8cvj1Ji/m2fx3+XY
	1PbIAG+oKbh5M64a0OH4s0pO3oWODTGEfJKrgxhA3viSBToPXRt31emmYanyFV8=
X-Google-Smtp-Source: AGHT+IFVQw3hTm/r82e57pPJEd//3j8umE7yW8hXMf5w/xNKd9bHXRunOWLW2qOur1/VjZnoHstVkw==
X-Received: by 2002:a05:6512:488d:b0:516:d24a:3d71 with SMTP id eq13-20020a056512488d00b00516d24a3d71mr689091lfb.11.1712655936555;
        Tue, 09 Apr 2024 02:45:36 -0700 (PDT)
Received: from [172.30.205.99] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id s17-20020a195e11000000b00515d4f70b69sm1504520lfb.98.2024.04.09.02.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 02:45:36 -0700 (PDT)
Message-ID: <0520fc7a-d94c-4204-9c4c-070de1b75be0@linaro.org>
Date: Tue, 9 Apr 2024 11:45:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: qcom: Add device tree for Motorola Moto
 G4 Play (harpia)
To: Nikita Travkin <nikita@trvn.ru>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ruby Iris Juric <ruby@srxl.me>,
 Stephan Gerhold <stephan@gerhold.net>
References: <20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru>
 <20240405-msm8916-moto-init-v1-2-502b58176d34@trvn.ru>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240405-msm8916-moto-init-v1-2-502b58176d34@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/5/24 16:06, Nikita Travkin wrote:
> From: Ruby Iris Juric <ruby@srxl.me>
> 
> Motorola Moto G4 Play is an msm8916 based smartphone.
> 
> Supported features:
> 
> - eMMC and SD;
> - Buttons;
> - Touchscreen;
> - USB;
> - Fuel Gauge;
> - Sound;
> - Accelerometer.
> 
> msm8916 Moto devices share significant portion of the design so the
> common parts are separated into a common dtsi.
> 
> Signed-off-by: Ruby Iris Juric <ruby@srxl.me>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> [Nikita: Split up to common dtsi]
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

