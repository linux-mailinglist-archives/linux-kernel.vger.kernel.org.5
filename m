Return-Path: <linux-kernel+bounces-18723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B00F8261CD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 23:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32B128303F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 22:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2F3101D0;
	Sat,  6 Jan 2024 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJQ1aIUW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807CAF9EC;
	Sat,  6 Jan 2024 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3368b1e056eso665367f8f.3;
        Sat, 06 Jan 2024 14:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704578618; x=1705183418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lsex701tK5pEY9KKRutw30UPF14FTBUAFWLK2f3CQHw=;
        b=nJQ1aIUWgaj80sClMj6gXPIMV3QI8mB4mI7KHOFwb8DEJ7gxixsHnZqVcwEgvzD+PF
         SvRtaLohc3Myh4aMYP19gZcp0uDT+KknFeT1FbR0yCX4RNdKyoTpjH+NWoPGo9QowcJ9
         yvVy2QIlAZ+GP+hEm+4ipaPXo9PxSq4naZbrQIOEbNVMhoMcF2KP/iBizO3CkjneveYY
         Yq6+cWGzeAe2n5P4CAV3dIW/Cspx4KjPUyspdUWmxD5WCJH1NnjmVlKLohF+Kd2xJMnx
         iUsnP59SHrAnxbxcKl6POQUBdSKJdZi8jZ0TCi+szQ19wUwnVD2EvG/FiYMoollJgUa+
         mQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704578618; x=1705183418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lsex701tK5pEY9KKRutw30UPF14FTBUAFWLK2f3CQHw=;
        b=laH2UaLNEHvgPYv+RfxQkqwZxtUjCdwP0GB/RVzLkjmqplGbkGMS0GlZhV3Lkc7zhZ
         GU9evoq0p6dKdpYl+usUuH6h+q3bAZfXPtX1IiW5l/Y895eAnkC56gYRWi80Sganz+5z
         VFZvLWRaoxrtWKJ+OevWFofENJyt5eNyrz/XgsmgkXhrGbZAl1lnMbBKFbo/1FkieEaJ
         da8JTJK78QhGgTnYvYTkg333XaN7SEkLrPDXH+/EDl1qiTXhGR1CrV/QbcFSw6fbLwaG
         35W83ep2w+GRmpQZoqp8iBUlRqhZ1w35Y3yRGpQsGQEQwT95Uchzwrz7AFzCKqbp/E1l
         QXjg==
X-Gm-Message-State: AOJu0YzVDZ4TwRd1o3GzC4uDYQzUQWVCsX8zC21cLKQZwtJrnuDzk38v
	hFvsvFtJs7QqvCWZ1H5jgQw=
X-Google-Smtp-Source: AGHT+IGDeerTecMM96jf2+5wf4xdFVF5xLpyn984JWv3i9RYFRE/cXWCFvw3+Vz08LFiSgm/8FroqA==
X-Received: by 2002:a5d:408a:0:b0:337:555b:d320 with SMTP id o10-20020a5d408a000000b00337555bd320mr747108wrp.39.1704578617487;
        Sat, 06 Jan 2024 14:03:37 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id r16-20020a056000015000b003373ef060d5sm4069972wrx.113.2024.01.06.14.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 14:03:36 -0800 (PST)
Message-ID: <1df87389-d78c-48e0-b743-0fd11bd82b85@gmail.com>
Date: Sun, 7 Jan 2024 00:03:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] support ipq5332 platform
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 hkallweit1@gmail.com, linux@armlinux.org.uk, robert.marko@sartura.hr,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <a6a50fb6-871f-424c-a146-12b2628b8b64@gmail.com>
 <cfb04c82-3cc3-49f6-9a8a-1f6d1a22df40@quicinc.com>
 <dd05a599-247a-4516-8ad3-7550ceea99f7@gmail.com>
 <ac1977f5-cd6a-4f16-b0a0-f4322c34c5f5@quicinc.com>
 <bdeca791-f2e5-4256-b386-a75c03f93686@gmail.com>
 <895eadd7-1631-4b6b-8db4-d371f2e52611@lunn.ch>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <895eadd7-1631-4b6b-8db4-d371f2e52611@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.01.2024 17:45, Andrew Lunn wrote:
>> I just realized that the UNIPHY block is a MII (probably SGMII) controller.
>> Isn't it? And I expect that it responsible more then just for clock
>> enabling. It should also activate and perform a basic configuration of MII
>> for actual data transmission. If so, then it should placed somewhere under
>> drivers/net/phy or drivers/net/pcs.
> 
> Before we decide that, we need a description of what the UNIPHY
> actually does, what registers it has, etc. Sometimes blocks like this
> get split into a generic PHY, aka drivers/phy/ and a PCS driver. This
> would be true if the UNIPHY is also used for USB SERDES, SATA SERDES
> etc. The SERDES parts go into a generic PHY driver, and the SGMII on
> to of the SERDES is placed is a PCS driver.

As far as I understand, UNIPHY only contains SGMII/PSGMII/whatever and a 
simple clock controller. PCIe & USB phys are implemented in other 
hardware blocks. See the lately merged USB support code for similar 
IPQ5018 SoC. But I can only speak to what I found searching online and 
checking the vendor's qca-ssdk "driver".

https://git.codelinaro.org/clo/qsdk/oss/lklm/qca-ssdk/-/tree/NHSS.QSDK.12.4.5.r3

I hope Luo can clarify with more confidence.

> The problem i have so far is that there is no usable description of
> any of this hardware, and the developers trying to produce drivers for
> this hardware don't actually seem to understand the Linux architecture
> for things like this.
>
>> As far as I understand, we basically agree that clocks configuration can be
>> implemented based on the clock API using a more specialized driver(s) than
>> MDIO. The only obstacle is the PHY chip initialization issue explained
>> below.
>> Thank you for this compact yet detailed summary. Now it much more clear,
>> what this phy chip requires to be initialized.
>>
>> Looks like you need to implement at least two drivers:
>> 1. chip (package) level driver that is responsible for basic "package"
>> initialization;
>> 2. phy driver to handle actual phy capabilities.
> 
> Nope. As i keep saying, please look at the work Christian is
> doing. phylib already has the concept of a PHY package, e.g. look at
> the MSCC driver, and how it uses devm_phy_package_join(). What is
> missing is a DT binding which allows package properties to be
> expressed in DT. And this is what Christian is adding.

Andrew, thank you so much for pointing me to that API and Christian's 
work. I have checked the DT change proposal and it fits this QCA8084 
case perfectly.

Am I right that all one has to do to solve this QCA8084 initialization 
case is wrap phys in a ethernet-phy-package node and use 
devm_phy_package_join() / phy_package_init_once() to do the basic 
initialization? So simple?

I came to put my 2c in and learnt a couple of new tricks. What a nice day :)

--
Sergey

