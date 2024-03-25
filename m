Return-Path: <linux-kernel+bounces-117876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3C688B0B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A8F1FA7591
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37652E3E0;
	Mon, 25 Mar 2024 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nux9ob7/"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0952208E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396801; cv=none; b=OblEwbG9/ach8WBGInb5Nj+bFSAO9q+2xrFR1j0XAJX7Do4OBEADiWib8zg4wxM9TTD22GB+wJ7wvyAsqpwxSXVpQU6BvpjEfe/a0JYJv0vAvwkJYkEyK2g/oZnDpfckUMVeN4R/FY+adcOfSxULZIZYmk78LQiT1RJlBBC5jYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396801; c=relaxed/simple;
	bh=KAhUTJvzNkm3b4neV7pulzSSEmuCbrpXuxRSv5AiZzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXwBvXZUM40wXFWRrsAJpov0b8dWQ0HkLtYBvQJvI4LilhAJvh4OkTmSypW0m0uIBF8uTA14+tD+W/A1XIMEYUvjlEClRXfQM7L0o4arIxnU/0ReY0lr8tKpmLv17NeTZKFznyxRZFVcEJlDrVNgcVlZ+3sUBJyUML8HtIb1wn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nux9ob7/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a468226e135so563010866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711396798; x=1712001598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lgkQSyal/SRv3rQQQEwxvLE+TokRSozfMoQk2BKMP5I=;
        b=Nux9ob7/BUxo8Xgz9Q41Lg6fJJVdKH/Ku8NVRaema5c/p4LqzL3FXlpgJzGNHsSL1X
         iV0sOsEf7naO/K9y3alJLvLHbRrOTXe1YPmfGzKMKQPJti5IkQ40UndMzWjTUHk4MZg8
         3PgOeqpUMkF/782c/EhRZxlMellDhJECNqysDw5S9EGHU7lHO2AGxxsvx9MkGZrsp5AZ
         YHnHriXPogAVPcdJ8MVYQNXS5x0K20cpHQ0vOPp6w52ODRn3yWx74hUj6Y06tdEpSlOu
         nCu+qBmyLmMqgmiB2EdCiZ0rU1DVtfScngecPD/5PE9cCF9xh9Fsi8UO7dxhI4tEo9Ar
         mjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396798; x=1712001598;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgkQSyal/SRv3rQQQEwxvLE+TokRSozfMoQk2BKMP5I=;
        b=GVgLATLYZIgjVwJc1T3ZUzUzxksPRn4lXnnHvOhotGLBrwvZfIpwb7oe/6vqarNmSN
         4eBSG+qST/4Axx6T0yYld5978Tx0pgh79sL4+QDjtKS4/czL809GD4K9HgY/AFakA1Zi
         Hz4VCfFMHGVd69XbMN7KmcW2nPEZNtvfgpOLYdmeKiK7pNsMtuGiuT2VyiQzhyT16vLP
         lKvTkNdY0bRhc9zwcMpJJ/jtMdlhLd8T0X6WO+zVng99xJ5WD86czxQOC44I1gpLcSby
         tu2MKqsqvX7eWftwf1lm6hFyZonfjOJWWCZ5SNLDQ8qjpUoQ+8q0ClFL4a1e57QJBrRo
         KgNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeCi1kCIM8WttrNI6uFLiGyWYf+DrN8f8poDEeUd9+KEOkM2qP1inUqajF2mzWup3KEAUKelWTZEVcpcb6IHgTweKVCZGqkQ/0KjeT
X-Gm-Message-State: AOJu0YynKpuwKX7ORm5x630mZpaDmNLhSC8oi2fqWMCfd7a7CVYfPHpM
	UN8LBWKbHTpYo2ipdMu6Moic5RF7G/MEkWaqOCUCcKhcOjHbaJ7PXKhID909T6s=
X-Google-Smtp-Source: AGHT+IG3JV9sncL+HlDfYCuquIzMG0sUzlaNlli/pgwtzOtHqj5IB8gq6tHfiKiNfQHuVqRONWmswA==
X-Received: by 2002:a17:906:da04:b0:a46:11a9:430 with SMTP id fi4-20020a170906da0400b00a4611a90430mr469317ejb.76.1711396798312;
        Mon, 25 Mar 2024 12:59:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906c00900b00a462e166b9bsm3379435ejz.112.2024.03.25.12.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:59:57 -0700 (PDT)
Message-ID: <dbe90a1c-bac2-4176-8eba-7ad96a182313@linaro.org>
Date: Mon, 25 Mar 2024 20:59:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] QCM2290 LMH
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable@vger.kernel.org,
 Loic Poulain <loic.poulain@linaro.org>
References: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
 <d8ed4e6c-549f-4c04-b38a-2d788df8b707@notapiano>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d8ed4e6c-549f-4c04-b38a-2d788df8b707@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/03/2024 20:08, Nícolas F. R. A. Prado wrote:
>> Loic Poulain (1):
>>       arm64: dts: qcom: qcm2290: Add LMH node
>>
>>  Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 12 ++++++++----
>>  arch/arm64/boot/dts/qcom/qcm2290.dtsi                   | 14 +++++++++++++-
>>  drivers/thermal/qcom/lmh.c                              |  3 +++
>>  3 files changed, 24 insertions(+), 5 deletions(-)
> 
> Hi,
> 
> I've started tracking the results of 'make dtbs_check' on linux-next, and I've
> noticed that on today's next, next-20240320, there's a new warning coming from
> this. The reason is that the DT change has landed, but the binding has not,
> since it goes through a separate tree. I thought the binding was supposed to
> always land before the driver and DT that make use of it, but looking through

There is no such rule. Of course new binding should be documented in
earlier or the same kernel release cycle as users get in, but it's not a
requirement.


> the dt-binding documentation pages I couldn't find anything confirming or
> denying that.
> 
> I expect this to happen again in the future, which is why I'm reaching out to
> understand better how to deal with this kind of situation.

Deal as what to do? Are you asking in terms of maintenance of some
subsystem or sending some patches? In this particular case here, I don't
think there is anything on your side to deal with.

Best regards,
Krzysztof


