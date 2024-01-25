Return-Path: <linux-kernel+bounces-38342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D18F83BE13
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F10F1C2558F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1401C6AB;
	Thu, 25 Jan 2024 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qfo5mEc4"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751212E45
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176541; cv=none; b=gdYvNFksuOmuYBETUEo2457xkR4Fm0lhD5HOW0Do620DzsjhT2qBmQ8kd+H5uJi1YWnHm5q6vO1fgaJ1OMg+IbTqRqraDjwyziYINdkUfNML6/WzASNfVuMzGBGC4pwvWag5Ll6pQVj+jBOqpNkzem4MJhB72jy9UrgHgTIWAqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176541; c=relaxed/simple;
	bh=6lNqeaEksv1cualUi6+FAxuzKNDXiCPe52QpN8JpUzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WOob8W6RR9lA9J+59ujC/7VlqRlfSCHqMAxmP5DZ4M6cnpVIDS700SMGErL2abIjPSED0L2jr1UgxLFs4TAEjnUAzce0vLJmOZJ0jDK+p67Ki+8PLXAi6Bpg41EB2pmHSvQ/K8DFmiYChD8fcEcQ3vw0IfCXsfbOXrpGBoWk/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qfo5mEc4; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50f11e3ba3aso9619838e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706176537; x=1706781337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nRRg0fCzYKQkswk6Yuy7lpWZxrjK5S0VOtBK9puANA=;
        b=Qfo5mEc4fuO5aWZ+IqY86f+85VTunzFdnqDzptj4PMyzY3LiInX5474DIYBYgahvAT
         6mycT1SkRuGZdlrWpZvHOUq7MgD15Y+GN9QkQz5RKu94kBWMXLxQmbP/p6yRzIC6MbX0
         s39C3cXT2WN6xFq08C7HMYt7shWqyd+zIB9uK1TNWZT96PmAf0qUltiMtNXVAaeJsSkC
         qumuV6Qo5leE1ghBVxyH51gZLvyGmvDB7MI4gnuMkliPhiQGfYUHB5N9Rtczj7OC3ee6
         UxlZscgVeA4PHxp6vr92ghd8Q3hzX2lLC6uWl0bhQBnJTS1OvKb1KZgaemqmfL1WlXpc
         edGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176537; x=1706781337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nRRg0fCzYKQkswk6Yuy7lpWZxrjK5S0VOtBK9puANA=;
        b=J6ijRAiPVzC9LPRZYPS7Ci6mU5a6LWltJbbpt0tqkO6GxUAAIQKEspGmHAtdOtzVXf
         weeRmx/M1I60BKEtLI+FOluB1t3FzVKcR1q50JDa/UxmmTRETdwryIrfEQ2o/imuqJkg
         u5CHhDmC235DtizVYMs2tLi1r3sHdFwK34le+MR2zONJhxHIAzNvBWA8uIoh9dDIZ9T1
         nhW8tF4zD2q7UyYad41cuEo9bMjAfPg5X6A13Gyc6YwFDQSlPUAEekABO1dSk4hUCIQf
         horuKTUkkXtjfgnAw59I1z3wp80N8WzeTFf9FfnwjhjYJ0rpqDGol+YgBCLSReg/Hns2
         Xd7Q==
X-Gm-Message-State: AOJu0Ywn21jZIghNNisRwLG8atCjQQR8Y5wIdWLwM6yWxSf/wQd8DTxb
	eiqajx3or7FAswDuyYdMz8N37DQKUO+XXpzg1YCQ125Es4/W+KK+K3+DZwFlY8M=
X-Google-Smtp-Source: AGHT+IHk/moDiI4nmXXECSLzTb5A0yWjob+jLxVa9F5uccM2gYBYDUyV+b0NAmcXM6vNsnRosHIf1Q==
X-Received: by 2002:a05:6512:234c:b0:50e:8e74:6406 with SMTP id p12-20020a056512234c00b0050e8e746406mr578523lfu.36.1706176536902;
        Thu, 25 Jan 2024 01:55:36 -0800 (PST)
Received: from [172.30.205.155] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w12-20020ac2598c000000b0051007e2a2e7sm713457lfn.231.2024.01.25.01.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 01:55:36 -0800 (PST)
Message-ID: <5ae84692-b05d-4a43-aabb-4d2e7d9926d5@linaro.org>
Date: Thu, 25 Jan 2024 10:55:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clk: qcom: gcc-sm8150: Add gcc_parents_0_ao support
Content-Language: en-US
To: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20240123-gcc-ao-support-v1-0-6c18d5310874@quicinc.com>
 <20240123-gcc-ao-support-v1-2-6c18d5310874@quicinc.com>
 <d31a52fc-9073-483d-b84b-1f02a5698a89@linaro.org>
 <77903574-696b-90f9-f136-be5c5d219ba1@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <77903574-696b-90f9-f136-be5c5d219ba1@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/25/24 06:49, Satya Priya Kakitapalli (Temp) wrote:
> 
> On 1/23/2024 11:17 PM, Konrad Dybcio wrote:
>>
>>
>> On 1/23/24 17:34, Satya Priya Kakitapalli wrote:
>>> Add active_only support for gcc_parents_0, this is needed because
>>> some of the clocks under it are critical which would vote on xo
>>> blocking the suspend.
>>>
>>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>>> ---
>>
>> Is there a need to keep gcc_cpuss_ahb_clk_src around? Do we do any
>> ratesetting on it? Should we ever turn it off?
>>
> 
> The branch clocks under gcc_cpuss_ahb_clk_src are critical clocks, which are running at 19.2Mhz causing vote on XO during suspend. As of now no rate setting is happening but this rcg is useful to get the exact rates from debugfs. Hence this change is needed to avoid XO shutdown issues.

So, if I underderstood you correctly, this clock serves no purpose other
than getting rate?

In this case, I'd say we should de-register it from the clock driver and
use debugcc [1] (contributions welcome!) for precise measurements.

Konrad

[1] https://github.com/linux-msm/debugcc

