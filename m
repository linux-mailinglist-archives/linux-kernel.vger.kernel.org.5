Return-Path: <linux-kernel+bounces-6889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B77819EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37B6B246D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797E422321;
	Wed, 20 Dec 2023 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGQ7C2NF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF222231D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-553729ee917so3885670a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703075219; x=1703680019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KdTntqA4E8fmXm6DC/Td1H0iHS/ntQJeHXjSnVaiiyY=;
        b=iGQ7C2NFOmeaA3OWkuDDXVPaKYqDuuEc8lDNv/MGeC08Lk94KvJw33ilXzXcexTJEz
         jnSAKSwKeeC2HbDEOJAM7skUokda1AxpPaacB9xT54c8ntdeQ7s6DdBqQjT8oD9YB4ip
         JZtBskaxPVLUmCL1zXyM4DuwlVXpsNvWmY3OpjX7kyp4uuXHUEmDWRLFf0rD6G/WRrPV
         f31NwcjkNANnTHuv0SLhRXnVBV5vRiQwakMYySz+Iq593gUiLIgfzm+jlFOIj/VbKgqn
         KU7yZ9BGBMpjjcmKmiMdB/YHp/vr4JdGc1sAj5eZ6SSLdwrEELotyI0uFF8+u7Moyyk9
         qIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703075219; x=1703680019;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdTntqA4E8fmXm6DC/Td1H0iHS/ntQJeHXjSnVaiiyY=;
        b=XziDK2570n/fu0ykLazeNUzBK8FVDfI6LNwPCDPfNKZtHWd8kTT9Kd41dlBn6XI5nD
         xn7/TWc+w1gxnaP3xF5u9POk/13d1do5rhVtSW4emCCTVgO6TM2nmJYwz/QcoJM38Ryo
         HBkvinUnLtIvZMola7w0HRp0WbMNP7z72nMsKcv4cneYLRFWtCTLnN8QbiwTotMDQWNo
         o5JESaoQXWs4XL3+DRyEiABcwtnP87n/XOKlOVTlL4brZdvnX2DiJaGalAzr72loO1RV
         FB+iaE+ZpJ/aWHiPa9CI70sIVxdlfjrbzkUXpiq0Im0D8qTyBevVYDNwHOg3urU3b68y
         Fn2w==
X-Gm-Message-State: AOJu0Yz6FG5Lr/c6cFz0jxXrJ6P+JrE2Ub84tdPy0aDNwOLT/DgiGUT1
	SWRjYoitLloXj442eFhVbDs2EQ==
X-Google-Smtp-Source: AGHT+IH7yATORlafVvzEIL2P6XMo4+LuCvTfRqEpoxkFRPba/eruYTDzLiRUKRevXJIuXf0Q2wfIWw==
X-Received: by 2002:a17:906:181:b0:9ff:7164:c20a with SMTP id 1-20020a170906018100b009ff7164c20amr8735885ejb.21.1703075219491;
        Wed, 20 Dec 2023 04:26:59 -0800 (PST)
Received: from [192.168.199.59] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id tg9-20020a1709078dc900b00a22f4736312sm10039569ejc.129.2023.12.20.04.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 04:26:58 -0800 (PST)
Message-ID: <0cbdb9fb-9ad6-46c4-9d20-b0a766ab2629@linaro.org>
Date: Wed, 20 Dec 2023 13:26:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] clk: qcom: gcc-sm6375: Add runtime PM
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230717-topic-branch_aon_cleanup-v3-0-3e31bce9c626@linaro.org>
 <20230717-topic-branch_aon_cleanup-v3-4-3e31bce9c626@linaro.org>
 <ZYKzU4FFCc9lnE-p@hovoldconsulting.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZYKzU4FFCc9lnE-p@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.12.2023 10:26, Johan Hovold wrote:
> On Wed, Dec 20, 2023 at 01:30:45AM +0100, Konrad Dybcio wrote:
>> The GCC block on SM6375 is powered by the VDD_CX rail. We need to ensure
>> that CX is enabled to prevent unwanted power collapse 
> 
> As I pointed out earlier, this bit of the commit message is incorrect
> and misleading as the power domain will never be disabled until you
> enable runtime PM as part of this very patch:
> 
> 	https://lore.kernel.org/all/ZLaSpFFBzP_Yz5yY@hovoldconsulting.com/
> 
> Specifically, genpd will not power off CX (at runtime) while the driver
> is bound when runtime PM is left disabled.
OK I only now see what you really meant.

What this bit says is true, but it may be confusing within the context
of this patch.

The CX domain must be turned on [for the SoC to function], however this
patch does not solve the issue of it being powered down [like you've said
just binding the PD will keep it always-active for RPM-disabled devices].
It complements this process, by allowing it to shut down when unnecessary.


> 
>> and that the
>> reference is dropped when unused so that the system can enter a
>> firmware-managed lower power state.
>>
>> Enable runtime PM to keep the power flowing only when necessary.
> 
> The rest is correct.
Let me try to reword this and see if you like it:


The GCC block on SM6375 is powered by the VDD_CX rail. The Device Tree
description of this dependency lets Linux keep the rail online to prevent
power outages. It is however undesirable to keep it enabled at all times,
as that consumes additional power.

Moreover, failing to drop the "enabled" vote prevents firmware-managed,
SoC-wide power collapse in suspend, which leads to even more wasted power.

Enable runtime PM to keep the power flowing only when necessary.

Konrad


