Return-Path: <linux-kernel+bounces-16352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CED823D2C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08A5287753
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED028200CC;
	Thu,  4 Jan 2024 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvN769tr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0813200C0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so249679e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 00:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704355709; x=1704960509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/PGdF3B3iwuG0k3TXxzXDW9ol0S69WmnY8YmNGg6IE=;
        b=jvN769tr24gS2Lw/Ac92JDgNSL3S5olVF4/bSE/LlAw6FwYhlwKkHqY7BXIv9yQoFB
         p8Ylh7IAr0yEyAzVujGFa9eNNRgccbVz2Ie95bd4gpI4uEdwSxZCWpwaWCp6Yi2VAfOM
         ySI2Vc0b7Q04uVphlwWCmrdT1akvUVYU7eaNObGn6Bm3I0fbNsehKVD48gBTcqxxKpZx
         N3BElRrW9zavqo0J2we3FgM2rLWri+xxUJyf4F0yZVk5m8IkM/hTP7bzYKlwEOo3K+4f
         EQ3JP278agOep3R1c2nOo42F7AoNj9jZnJhTJ96Kwvp0Qiqs1XVcrKQuHpncrfbk8oWh
         bnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704355709; x=1704960509;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/PGdF3B3iwuG0k3TXxzXDW9ol0S69WmnY8YmNGg6IE=;
        b=bJQxVZcxSzE7LJtzJk9GvCK4n+3TrEYkn7m1G6hqO8QJp9qgS9hWWq2YAVutFIk3Oh
         e3T18nGVeRy9FIqKEouJtd0kS1gvIlBjgFsWnCoI238Dw1a54AhzMz8ZDNA65P4ohEMi
         yxXLC85iRleh5aIhklL+gTsY3bBUxUwFeX2cqZYf6Kv/VBPUye4YbDbAiuKsKIsp4MbT
         t9eiibos9tOE8M4eNuiH/GiKEnY0z/Mdg6+8Kww4A16kJJYJ4BFhY1VoIIRXnPAY8Mqm
         nG0/uJ02r+WYzmwc3IDCvN36Cugg3bQXPKEASfOHLOsWT8X8pzgdP2F9vs/zo8uPCA/F
         ZFUQ==
X-Gm-Message-State: AOJu0YxretHxeJZnrVtiwv+6GX7HRHw04DZoIc9Ig1deLFPK63zXypgj
	AFMEVjnCSL2pDBrMi0QgxI0mm735xkFqAA==
X-Google-Smtp-Source: AGHT+IEzPIXCpC5wNAhe/Kl6nJVFzUV7wggmA6I9V4zMkVgC9G7SBO1wv6hnkExB3aIpDRWSX0USDQ==
X-Received: by 2002:a05:6512:34ce:b0:50e:7c9b:9e20 with SMTP id w14-20020a05651234ce00b0050e7c9b9e20mr116426lfr.19.1704355709624;
        Thu, 04 Jan 2024 00:08:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id u23-20020aa7d0d7000000b005533a9934b6sm18460918edo.54.2024.01.04.00.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 00:08:29 -0800 (PST)
Message-ID: <8aea46d8-0ecd-4f16-92a2-96ec5ae07240@linaro.org>
Date: Thu, 4 Jan 2024 09:08:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: iio/adc: Move QCOM ADC bindings to
 iio/adc folder
Content-Language: en-US
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
 andriy.shevchenko@linux.intel.com, daniel.lezcano@linaro.org,
 dmitry.baryshkov@linaro.org
Cc: lars@metafoo.de, luca@z3ntu.xyz, marijn.suijten@somainline.org,
 agross@kernel.org, sboyd@kernel.org, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, linus.walleij@linaro.org, quic_subbaram@quicinc.com,
 quic_collinsd@quicinc.com, quic_amelende@quicinc.com,
 quic_kamalw@quicinc.com, kernel@quicinc.com, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
 Rob Herring <robh@kernel.org>
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
 <20231231171237.3322376-2-quic_jprakash@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231231171237.3322376-2-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/12/2023 18:12, Jishnu Prakash wrote:
> There are several files containing QCOM ADC macros for channel names
> right now in the include/dt-bindings/iio folder. Since all of these
> are specifically for adc, move the files to the
> include/dt-bindings/iio/adc folder.
> 
> Also update all affected devicetree and driver files to fix compilation
> errors seen with this move and update documentation files to fix
> dtbinding check errors for the same.
> 
> Changes since v2:
> - Updated some more new devicetree files requiring this change.

Changelog goes under ---

> 
> Acked-by: Lee Jones <lee@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>

No dependencies mentioned and this has build failures. Please test your
patches before sending.

Best regards,
Krzysztof


