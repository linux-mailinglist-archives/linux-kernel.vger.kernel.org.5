Return-Path: <linux-kernel+bounces-120605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5CE88DA24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307B51C280DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9303770B;
	Wed, 27 Mar 2024 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="reHV/YbG"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB3C364AA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531259; cv=none; b=Jlby9B0HnIBNv2aNU1HtbzwcT/SJiExiBK1wmhbsLEqJh1nIaf5zou9O8bnEIa5V4Ap7bWQKrnp+6N6+AQo4sSBjgI2QsXcyhE1EZ/VOcUfp89fun5HLgI55kvHY05+GX5heqOHdXFeizedQ2VAm7OsQz5IjgC7cPAkHDRwPxn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531259; c=relaxed/simple;
	bh=RQnGNQln6HUSRmZMM9YhXnc19rJih+6Fo79tXSwzJ3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3zeT3NxZSudzgrVyMJX1KOXtNxYldHLn6TuygNdgSpNktUR0ZGxvFvepNOWpUQlwXjolBaEJQT8pdNbEOK0GeE3F4wE8QvgiHxHjIgNfFxU5dK+UU4LQGQO0PIHwy9htG9z/LIGTmciHpdt74onVWLR62YpGZvYsZflZ54BWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=reHV/YbG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so1050813a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711531256; x=1712136056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PVUyFVDIZulXwICyQlj9QTD9tz8APS9bTNZy6SBhqeM=;
        b=reHV/YbG94hTYmJcJro+lWhwny99Mxa/ZBH4NhI74tSCw34cwmeUHnzbZrJyTIEzpw
         6/UYODV1PeNs/l93dW/7RSqF8UT1ImH4d+mm1b3MDqA3UXiX99CL3Ojf56ljvukC2ktB
         Jczed/E7CkAbetR7OKEQM6KbWgQQ5tshhXztPDQII1JOqf5Vsh6s0qZCTt0C9c+Bae2v
         T0Z9UV32v0K3tvCLjerE6vNUKgSS5DcJ3WONCIWpQYwdt52lLP9aSoyil600e6SuxbDy
         r9RBN0AvHXNMHxa7hrBAuoqeRv/5wnaaykxqiuVP9GHr4YLx7SjpUezDGvKBjWYhdR8C
         rcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711531256; x=1712136056;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVUyFVDIZulXwICyQlj9QTD9tz8APS9bTNZy6SBhqeM=;
        b=KefAT1ajNOTC6Y5LvuGeKjnCIQRaG+tWCWgaJYqwPfJ70hyKpgzectfO/osKkr5qmG
         jaLyh4MAEAqEa4so719Jc8vIQma8SRxTDTqVm8JtRi/68HYHIAGKzu2l2/trWLfzQP7d
         l69zP24aiRa3GZRCBzevG5QaXLZ+tjvbx22HwgET6fLs8/jJawPJMnA2KPxid1PfbLjs
         cAj0Tr8p+GDPhkP00h+F0ZEsy/0BUP410p9VAB/t8SKHgOIxUhC9UwFPzZGdoEkC4toc
         T2+Cts7/Zv3COytJ1ylMogG9PYbfb7u54OtGnAI7seHCKadUOmjUtJ7hb3Mp5ZGyAwrw
         PaMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPSEkULg66ZJ+W4A2U/1IyMe6+6n6l1qxlG1AwvnBKwexuZV1+Sadxna4D206OvEaxL/eze4P2JfvjpwnLoXi3vP07Wh4XZWAKFQzV
X-Gm-Message-State: AOJu0YwMPykLp/Mvv14PMj9CQV955vMTa8mrhOZu4BXSOuF7ey4cpiZo
	fac9SMrcHboTiTxbX7l4PE5qLEOd3wPT7bQAuzVZvxWcGQ3s2KGoP4OYJDhgXUU=
X-Google-Smtp-Source: AGHT+IGLscm5Y0ou+WRFTa1lB0ylXsfaScVPOvRTVPiEOHnOb++TwNjd6k7n3DNGtNl+LNVgThDk1w==
X-Received: by 2002:a05:6402:1654:b0:56b:aaf5:e546 with SMTP id s20-20020a056402165400b0056baaf5e546mr3294677edx.16.1711531256342;
        Wed, 27 Mar 2024 02:20:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id f13-20020a056402004d00b005689bfe2688sm5114415edu.39.2024.03.27.02.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 02:20:55 -0700 (PDT)
Message-ID: <30f470b8-e243-4d6f-b626-7f509b6a9858@linaro.org>
Date: Wed, 27 Mar 2024 10:20:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] dt-bindings: display/msm: gpu: Split Adreno
 schemas into separate files
To: Adam Skladowski <a39.skl@gmail.com>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326201140.10561-1-a39.skl@gmail.com>
 <20240326201140.10561-2-a39.skl@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240326201140.10561-2-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 21:05, Adam Skladowski wrote:
> Split shared schema into per-gen and group adrenos by clocks used.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  .../devicetree/bindings/display/msm/gpu.yaml  | 317 ++----------------
>  .../bindings/display/msm/qcom,adreno-306.yaml | 115 +++++++
>  .../bindings/display/msm/qcom,adreno-330.yaml | 111 ++++++
>  .../bindings/display/msm/qcom,adreno-405.yaml | 135 ++++++++
>  .../bindings/display/msm/qcom,adreno-506.yaml | 184 ++++++++++
>  .../bindings/display/msm/qcom,adreno-530.yaml | 161 +++++++++
>  .../bindings/display/msm/qcom,adreno-540.yaml | 154 +++++++++
>  .../bindings/display/msm/qcom,adreno-6xx.yaml | 160 +++++++++
>  .../display/msm/qcom,adreno-common.yaml       | 112 +++++++
>  9 files changed, 1157 insertions(+), 292 deletions(-)

One huge patch of 1150 insertions... please split it, e.g. first move
the common parts to common schema and include it in msm/gpu. Then move
device by device.

>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-306.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-330.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-405.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-506.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-530.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-540.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-6xx.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,adreno-common.yaml
> 


Best regards,
Krzysztof


