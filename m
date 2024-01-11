Return-Path: <linux-kernel+bounces-23908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2E82B38B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528F31F233A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E201251C2E;
	Thu, 11 Jan 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="htMtifhl"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FF85103D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e67e37661so7264965e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704992427; x=1705597227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A0AgdpPDajiFYZmAlf4PGLhKbMhRtCKLeFUUnGiUzGU=;
        b=htMtifhlVgNO5ejOFISHindmohVeOsuw1CUy+M/03nyNboFS1oIMuDRDNfiFXzIw8B
         px9ao4TCSNFPWmEdrcVPQ7Td5J9jpEjRf3ZlTSY11AslxNuVqTjJsrHpng/+QcBQS6rX
         RVcm4s3fIiCHHseINB933RFtTdUddFKOSq6oue/p7BosG0c2C3X+u5Jg5aYxg6Xxc8VX
         nfVRMl+s11rvLoPhna18xqIqwy9/I+YBe/VdWATmITS+sk5w0H8ub533eC59CyPXDQOa
         Y/ZVHdvxD2A6x68wlnRoXvbEGhyIvWLm0UA25CseZnQWcypWftpXkxw8UrGaahjRWctu
         f3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704992427; x=1705597227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0AgdpPDajiFYZmAlf4PGLhKbMhRtCKLeFUUnGiUzGU=;
        b=sN+FYSK09FbIOq3s0s5DorwZu9g/w2w9BBqE6ZBis1ZBM2D8HyGBFe2uP2cY7rDNK4
         wNKZp5RiSBNdb/G/twQUu+VyQXw5YgJ1bLD0+AcqUD0U1LO/gcn+qikj2tMJ2lJQ3wu7
         lGMymbMtU9mxDbV/m+3xI4NxRJHJeH2Y5wBBCHpaWBlJymMKgVJEgPGfsOASqdh+W1Uq
         JePHT568liT0Z3f+N9BNEmZr/GbHjrVpd/TKwyn6/tWPwO6XS1xhHDHPohakccNZEIVX
         rSI9odfr1K6TuxVuX6WPOvvqCRWEXO+/2cAzC8b2sak7rAZx5Y36umb8cEsGgje+9L4K
         QnXg==
X-Gm-Message-State: AOJu0Yxje08hEtKlNhqcUXGRvdEI9HbTMpCqCLfXuO5PZ0cLnBobTyaa
	fskFaut7X3Qv10nQcyf/Vyly5y+MkQ3pJQ==
X-Google-Smtp-Source: AGHT+IE52ELMsNzae34xjGj8xCfc7ClJfC7NBee9boVX5N5hNd4tYekJXDz8kgS9UHu/ZviZdLmkKg==
X-Received: by 2002:a05:6512:68a:b0:50e:50a1:8321 with SMTP id t10-20020a056512068a00b0050e50a18321mr932994lfe.79.1704992426787;
        Thu, 11 Jan 2024 09:00:26 -0800 (PST)
Received: from [172.30.204.205] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u12-20020a196a0c000000b0050e64b558fbsm242640lfu.79.2024.01.11.09.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 09:00:26 -0800 (PST)
Message-ID: <77b36608-4fca-48e4-beb1-c31cf4579b7b@linaro.org>
Date: Thu, 11 Jan 2024 18:00:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8650-mtp: add gpio74 as reserved
 gpio
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Georgi Djakov <djakov@kernel.org>
References: <20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-v1-0-fad39b4c5def@linaro.org>
 <20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-v1-2-fad39b4c5def@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240111-topic-sm8650-upstream-qrd-fix-gpio-reserved-v1-2-fad39b4c5def@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/11/24 17:58, Neil Armstrong wrote:
> The TLMM gpio74 is also used to communicate with the secure NFC
> on-board module, some variants of the SM8650-MTP board requires
> this GPIO to be dedicated to the secure firmware and set reserved
> in order to successfully initialize the TLMM GPIOs from HLOS (Linux).
> On the other boards this GPIO is unused so it's still safe to mark
> the GPIO as reserved.
> 
> Fixes: 6fbdb3c1fac7 ("arm64: dts: qcom: sm8650: add initial SM8650 MTP dts")
> Reported-by: Georgi Djakov <djakov@kernel.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

