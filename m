Return-Path: <linux-kernel+bounces-27391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F7C82EF30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9078F285BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B901BC23;
	Tue, 16 Jan 2024 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFfQlLbZ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034A01BC2B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e586a62f7so76086905e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705409496; x=1706014296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QI+4nn9va5UipX9+6FGUSQcma7K6g+670jRS/I4V9Nc=;
        b=CFfQlLbZCM5WMEB5tRjla8dD29lGIuCb288auUpFYl2QxctSnfMg5BErwwALfREOwg
         ac7TdFfgVdDnhMUlZ0yDDy13gq8RbOeBzj/Duki77qMXVPza2p292dfDHLqbd37pt8pj
         CAMP3h/TTWxtB5XWNymEwBWEhCZXSDDw0to/GDYexWQwqvCdGsDs+RVC3ICZE9NzViXR
         Kbc/z/3EuktsfhA4BUpauS84etZsN6+Vu4DKUE6EtPdfgBQvHZwDBiYiVQQI7ry5oh6Z
         NQzicb50m7xGuyNT+GJc7GGuSDXhM3XKth9RXEWhc+45c2jo0rfptl3dCaZNWwb7eid6
         CggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705409496; x=1706014296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QI+4nn9va5UipX9+6FGUSQcma7K6g+670jRS/I4V9Nc=;
        b=qgC57KjNfzaaXQviRCRTzb8ih7ggHRbXFgdXjIit6EQhBq6oyz0l1gUaVeTT3cR8dq
         0gI6SoHNoBKsrps7e/u2TiE8AoudOxCFUV3dSRLRbSFv3RdmQvXxf30Pma1SYlbj/vpg
         wSgblL1wBSMpxsAwGHXtfumZ8VjwfbsEM2pIOo+B3PaUjJ1Xzc00QTztelC3E0dI931e
         FqgfvsKfaek592JdZnKLF2UNi3Kp4K3K1KMuUqCdw/2fUN+A81r/rth/zl5DQevubRYU
         ztrMKDl+MMTSZweErHBgk4oREdnl7Jh02gNSnNjrxUb4FZ4MncT4tW92fKeaTw7wKtqu
         6qGw==
X-Gm-Message-State: AOJu0Ywu6vKyNzKpeWNERlf38xB3to+mYQi0OJ9cTj2eekEqm2BYaONd
	ri7lxmTg4rW0yUbFQT6JWN/IhaDVlEEMlA==
X-Google-Smtp-Source: AGHT+IETj4D8uX+N7RsDIxfm9fpyv072L9YVis4Qfy0HWVw3urWN26NkJ9QmgtuMo9VD7m+qIgaocQ==
X-Received: by 2002:a7b:c7c7:0:b0:40e:85fe:b00d with SMTP id z7-20020a7bc7c7000000b0040e85feb00dmr373501wmk.97.1705409496168;
        Tue, 16 Jan 2024 04:51:36 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:fab3:687:ead6:5b40? ([2a05:6e02:1041:c10:fab3:687:ead6:5b40])
        by smtp.googlemail.com with ESMTPSA id r7-20020a05600c35c700b0040d1bd0e716sm19367162wmq.9.2024.01.16.04.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 04:51:35 -0800 (PST)
Message-ID: <5db88d48-4868-49f0-b702-6eea14400e5b@linaro.org>
Date: Tue, 16 Jan 2024 13:51:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Fix wild reboot during Antutu
 test
Content-Language: en-US
To: Luca Weiss <luca.weiss@fairphone.com>, andersson@kernel.org
Cc: Amit Pundir <amit.pundir@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240116115921.804185-1-daniel.lezcano@linaro.org>
 <CYG4WTCOBTG2.11PA7Q4A3H93H@fairphone.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CYG4WTCOBTG2.11PA7Q4A3H93H@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/01/2024 13:37, Luca Weiss wrote:
> On Tue Jan 16, 2024 at 12:59 PM CET, Daniel Lezcano wrote:
>> Running an Antutu benchmark makes the board to do a hard reboot.
>>
>> Cause: it appears the gpu-bottom and gpu-top temperature sensors are showing
>> too high temperatures, above 115°C.
>>
>> Out of tree configuratons show the gpu thermal zone is configured to
>> be mitigated at 85°C with devfreq.
>>
>> Add the DT snippet to enable the thermal mitigation on the sdm845
>> based board.
>>
>> Fixes: c79800103eb18 ("arm64: dts: sdm845: Add gpu and gmu device nodes")
>> Cc: Amit Pundir <amit.pundir@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> A part of this is already included with this patch:
> https://lore.kernel.org/linux-arm-msm/20240102-topic-gpu_cooling-v1-4-fda30c57e353@linaro.org/
> 
> Maybe rebase on top of that one and add the 85degC trip point or
> something?

Actually, I think the patch is wrong.

The cooling effect does not operate on 'hot' trip point type as it is 
considered as a critical trip point. The governor is not invoked, so no 
mitigation happen. The 'hot' trip point type results in sending a 
notification to userspace to give the last chance to do something before 
'critical' is reached where the system is shut down.

I suggest to revert it and pick the one I proposed.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


