Return-Path: <linux-kernel+bounces-25002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2782C5ED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9C928215A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FC916400;
	Fri, 12 Jan 2024 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HT+iXscA"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31215E98
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7831386ee01so672630385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 11:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1705088139; x=1705692939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7IwvYEPmaSHyWVulXMha0dJbxFMc8lO+ii/l4e0nSY=;
        b=HT+iXscAX/vrZbRA3+pLZAzUEht3XwTpHbLCbV/4wQ2o9+JJXxKL17sqjmLFD0y0dR
         Z4QVCnsbQAt4gmDLZ3YUJXd6n2DklHBkHKPqtD12vRRn2lMQC5kJHnaZk//IjchRwvJL
         /PE7MxLXBqnlZzbbkxJiimyDRLuGmj2wXHdu4zcr9fj41eIJVkoxr8TwDC5epRH7wv/T
         f7dOY/fJaoUxBcTyMT+BZL2K8JCjdXL/0m+6SBXZhO7zvJEhXbpnQ8RmyK9cG70uxiNl
         ONmVtgzA8rz2e5KxPr0Re2zWrSVIw3GqmBSlM+NRZ40Bi2SKJJoAehkF7ieVOZkf200R
         2xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705088139; x=1705692939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7IwvYEPmaSHyWVulXMha0dJbxFMc8lO+ii/l4e0nSY=;
        b=FyrIGz3HKLHIhIINGcjCrWge8DP41G1RCX9jYobZZ2VLXSrfco9c3SvWMw/QRgxbkU
         sU+YqnMVI55LMZICGvEOm8plhQoVehnTiX8mbfVONMpYWlAerJTIQ+eZAe8fl+t5Aq3Z
         vTw79l56RCmnC87cdMzcXwAJwx//nf9XGILETgfrF8QIXJoy0JftvOdjYxCY3/AyZ5Gl
         Z2CrhckvifkJUI+LRttaUz6WdRvm86/E51uyUih3WvZHnQ+0Ikwhieez59HubSlUkCME
         hZu+s2F6AliPncUrPfmarxPMJvvl59i1a9Rs7uxSqy28k96vUDAhvOUFD+i/XdCoyyDM
         ry6g==
X-Gm-Message-State: AOJu0Yz+cEPqeamXc3Ko/BuW7bOVNgO4YfK/EkQDAZXhSjmq13hGiBcD
	gP9o/PhhTyHxLyAmqB0BZZTVUamnW24JZA==
X-Google-Smtp-Source: AGHT+IEn+rIOiYc1vvR4dCLtefqWpSfHzxdJHtOG31fmNn1e26lFQwkxQJsbr+u6jS6ZoVkzx4OjsA==
X-Received: by 2002:a05:620a:2a08:b0:783:4a3f:cb9b with SMTP id o8-20020a05620a2a0800b007834a3fcb9bmr1551707qkp.146.1705088139195;
        Fri, 12 Jan 2024 11:35:39 -0800 (PST)
Received: from [100.64.0.1] ([170.85.8.192])
        by smtp.gmail.com with ESMTPSA id oo18-20020a05620a531200b0078190599d4dsm1279999qkn.39.2024.01.12.11.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 11:35:38 -0800 (PST)
Message-ID: <cd856233-06bb-4a5a-ba12-2996c89cb492@sifive.com>
Date: Fri, 12 Jan 2024 13:35:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] dt-bindings: clock: sophgo: support SG2042
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Chen Wang <unicorn_wang@outlook.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com,
 robh+dt@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com,
 xiaoguang.xing@sophgo.com, guoren@kernel.org, jszhang@kernel.org,
 inochiama@outlook.com, Conor Dooley <conor.dooley@microchip.com>
References: <cover.1704694903.git.unicorn_wang@outlook.com>
 <925d99d5b4ece01337cb3389aaea4b631894dd1d.1704694903.git.unicorn_wang@outlook.com>
 <f88b79c3-e44b-4136-ae56-10e1f2502e2d@linaro.org>
 <MA0P287MB2822C7A3C1DC7786708E860BFE692@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240110-untoasted-underfed-fe81479506f6@spud>
 <MA0P287MB282224A6097B4FCCF721C89AFE682@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <20240111-jolly-prize-930931cc648a@spud>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240111-jolly-prize-930931cc648a@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Conor, Chen,

On 2024-01-11 10:58 AM, Conor Dooley wrote:
> On Thu, Jan 11, 2024 at 04:00:04PM +0800, Chen Wang wrote:
>> With this change, we describe the plls defined in system control as pllclk,
>> as a child node of system controller. clkgen will use pllclk as "input"
>> because pll clocks are parent of div clocks .
>>
>> But there is another remaining question about the gate clock. For those gate
>> clocks controlled by CLOCK, no problem we will provide then in clkgen, but 
>> for those gate clocks controlled by registers in SYS_CTRL, they are child
>> gate of the "clk_gate_rp_cpu_normal", which is a gate clock provided by
>> clkgen. If I extracted those SYS_CTRL gate clocks and define them in system
>> controller dts node, I may have to use "clk_gate_rp_cpu_normal" as their
>> input, it looks a bit wierd becasue there are cases where each other serves
>> as input. I try to draft below DTS to explan what I meant. I'm not sure if
>> it can work and I'd love to hear your guidance.
> 
> I'm not sure how this sort of circular relationship works for probing
> works either. Stephen etc would know more than me here.

It generally works fine. The common clock framework can handle the child clock
being registered before its parent, even when using a DT (fw_name) reference.
See for example clk_core_fill_parent_index() and
clk_core_reparent_orphans_nolock() in drivers/clk/clk.c

Regards,
Samuel


