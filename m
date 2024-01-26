Return-Path: <linux-kernel+bounces-39999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE583D8E0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4902CB424EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE97A11CBD;
	Fri, 26 Jan 2024 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRfcMd4K"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49101BE5D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706265355; cv=none; b=mvZgT/QQThv52zoRj1CTXyhymPujAWPVhsqNyKhYxgniBxyvqJgNhWrLkAHqT6FlML+vt9h/gZsYVdNrO+xwunbHKTKXkRLYuShIJyU6GHHBkX/gs2c0R5jZ3f+kiTQdEtRUpdHg5nvvIAqdxfgqUFLbWqIuB/KFFG7noF3mgmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706265355; c=relaxed/simple;
	bh=c5PLx//hR0rc3fXLwydhPyfJ2y+OPsskKXRzH8vNVDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyR/RxVKYdpQLU0bofP6OQQIWBzAdLONgwDHIeeCktXiZLmlHHsuSQNKkaoS1qRWP4Zidm+rpkoBqP3rwGr9NS4Map0mls0F9lHElTNNxwq4aw7Asca6WsJ5HRQ9HXSzM3s35EuI6GOP3Zp38uXsK3AhiTsAcInnIZDzLM1hQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PRfcMd4K; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a26fa294e56so41149266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706265351; x=1706870151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/HaTVOkuWZamrEstVUjDb/fVGlkobIgzzXF2k3PneD4=;
        b=PRfcMd4KlTipcaKVcBKbSnr4kLkEc0lIkr+Ss4UWt4I8vvpPQC4wnvCxBf2FJ/Z4Sf
         jsVLeurrHRbnKxyk3tbFPuqo/2YZlK8RHt0aAEnB8uk4SHziEm4Jb3iE2YVa57+T8sZp
         Vdb9M+EudHT1ZqsQbvU83bJVbhbpRP5c11Jnbe1baVVBBiWW00ek70TZVign8VDdnjHq
         2qjvkYceiT2B0ROIM0xhfAlvfYkUkyP1TwPKB/WSwc6qTq5ZzxKTUUHzSyPdFdPOpicW
         EjrAXmNAJGL5ZMFqy8jUNwJxFw42mM6WsiTXhoG8z2eUnXtNDKgHrbVWF5wR3JDRhszm
         OwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706265351; x=1706870151;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HaTVOkuWZamrEstVUjDb/fVGlkobIgzzXF2k3PneD4=;
        b=B5lVcxyg84Ql9MDdmS5qnb/MXjmRs0jj41754kV/C+dpSRIg8/BE53QkUFbooHxYNy
         Vrt40E3kXDBh2BZeKqbbK/8w92Uch4RmPOD0BAeXPLeY+/fAOkIZqDaffp4QyB3s66Zb
         6B/FEwqDIQEtQOAiNYHstxJ6cmtt3yJ1d5IhNN2JNSvB+kcTn0OA1H9fkNutyzN5KQwj
         iBP6GupJm7PSslsEC9WL3cW8rWHbEauwZyT43SnrkAtG2vbvt7nzj0+AIaBHdOvkoKd4
         5mx/7eTp85egL6MqyrIwDkbnTB/i7BT4ub4bDIjsJtTNDiqcqND877E8z8tsMJpKB4gK
         rzdg==
X-Gm-Message-State: AOJu0Yza+lFDnq/e6SJqc3xilnSKsMuDVaIiDzAkG2kH+eK/csFlMxAH
	WxYPhlIQkfMLigmhLB38dqBaCK+oYSQaopgEOR7niOA8p5di/QfvtUH+ivonIUo=
X-Google-Smtp-Source: AGHT+IH9eukaLTLQ7eQe4tQiz9QkTFfQ1DpjzBG48BFRyY0IB9AnUhbMDZ+9rXCYhFjAuXOStFYdXA==
X-Received: by 2002:a17:906:f2c8:b0:a30:d9c5:e5c with SMTP id gz8-20020a170906f2c800b00a30d9c50e5cmr595859ejb.55.1706265351383;
        Fri, 26 Jan 2024 02:35:51 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090635c700b00a317b2b5adfsm475891ejb.160.2024.01.26.02.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 02:35:50 -0800 (PST)
Message-ID: <58ba835e-46d5-4331-bc3c-76ff4a5ae4eb@linaro.org>
Date: Fri, 26 Jan 2024 11:35:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: exynos: gs101: sysreg_peric1 needs a
 clock
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 alim.akhtar@samsung.com, peter.griffin@linaro.org
Cc: kernel-team@android.com, tudor.ambarus@linaro.org,
 willmcvicker@google.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20240125140139.3616119-1-andre.draszik@linaro.org>
 <20240125140139.3616119-2-andre.draszik@linaro.org>
 <9a8bf6f17a0f8b4e31a6d59c1adb735823f579aa.camel@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <9a8bf6f17a0f8b4e31a6d59c1adb735823f579aa.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/01/2024 15:10, André Draszik wrote:
>> [PATCH v2] arm64: dts: exynos: gs101: sysreg_peric0 needs a clock
> 
> Sorry for copy/paste error in the subject :-(
> 
> I've sent an update in https://lore.kernel.org/all/20240125140644.3617587-1-andre.draszik@linaro.org/

Which makes it impossible to apply (at least with usual workflow):

Grabbing thread from
lore.kernel.org/all/20240125140139.3616119-1-andre.draszik@linaro.org/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 4 messages in the thread
Will use the latest revision: v2
You can pick other revisions using the -vN flag
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v2] arm64: dts: exynos: gs101: sysreg_peric0 needs a clock
    + Link:
https://lore.kernel.org/r/20240125140644.3617587-1-andre.draszik@linaro.org
    + Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  ---
  ✓ Signed: DKIM/linaro.org
---
Total patches: 1
---
Applying: arm64: dts: exynos: gs101: sysreg_peric0 needs a clock
---
Patchwork: setting state on patchwork.kernel.org/linux-samsung-soc
 -> under-review : [v2] arm64: dts: exynos: gs101: sysreg_peric0 needs a
clock

Please do not invent your own workflows of handling patches. Each
submission must be:
1. In separate thread, not linked to something else,
2. Complete.

I await for v3.

Best regards,
Krzysztof


