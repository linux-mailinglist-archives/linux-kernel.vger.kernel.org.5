Return-Path: <linux-kernel+bounces-75736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D1085EE30
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6FD1F24AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B7010A0A;
	Thu, 22 Feb 2024 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmyvVi70"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12EB290E;
	Thu, 22 Feb 2024 00:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562455; cv=none; b=DomJcwy+J0mAM7bo4cZTCOuLMHsjSO0Swxf4i5bpNQXTwmamh2XcQq5fNRps/rG8xAiC3Xq71LQ5RzoBCzxsIZ5ZZoY8G4x/JfU+ESKWLl+5iKGFqB/o0Qi3+eloNqhQr1tgOuLgK6fKZ+oaSyaZ2AeeQHiUz4vbE5yp/8nYxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562455; c=relaxed/simple;
	bh=uIknOpeeUouqDPil14LJdoYQHv5RvkrlrBxIYK5+/38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZx+v6Lg44FA8gBNNs1f9VWiWP2WtJnI4bydTfDSZ/5TRUrqjHN0FF3QRkvqve8Zoob3GyCT96EyxyYvvSRpPySesCAVKDCvn+vcyto07F/nhnSvBkRK14sJ6P/KdqLt5kbLFR4EI48T9+EYHkTwcZD+EERKEs8rmcUQGU9oJWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmyvVi70; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7874a96a0a8so29240385a.1;
        Wed, 21 Feb 2024 16:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708562452; x=1709167252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G592VWMGGcABpadcIh5PdK0ygTD2cWhbQA79MbBz9fA=;
        b=SmyvVi70RWGUD40sb6XqHXLs4s0VAplUPkUC5xGj3ZRyG82WsL1zAS4dUhfDmt7zLC
         +27a+PHxYkfZSypHbU8qpgsEz5+R1/grGdBu7WALoI/Cb7DXSzv8Ay3MtMdJ9QA3+ZJp
         HrpwPthmIpOyXmRk+lDIl9AtQzcfzLQNB8bKISk/SFFXjrprbB3EhWylUR1FN5cQx68J
         yMDfa8j5K5+BAgX6P0fouDh/K9dFO87xrPZVOd7IeNp/fn/3z4LtRyzke3x8nmcizgok
         WWkpz87LnzKMomWy2wAm9egqsgxwAZgZU6j5aZoRIVSPHqozTmF8+/HBveQwwsK1mPUZ
         URsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708562452; x=1709167252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G592VWMGGcABpadcIh5PdK0ygTD2cWhbQA79MbBz9fA=;
        b=rdYAGwjVyiM2EXEhpuvkttGHhnDbnrMs7RHJijVXDeLDWmL3SMqs+yxXYbz66Wx3O/
         0m7krqrusMpjZXej0/TdF1KxG2Aznq8xeKPj0ic8EEHTQLD4bfGMnIDsnYBzPzoiK0D4
         yaoEiSrMQHnxSsL67S4u3i+jQFE+rrS/w2f3PQkatzTIDg9V+45K4ElCwt+NOddjk/+H
         V7GiJ0a+kUiYnHsTn3WK7z8PEz2gXTP3PDXXH3z243Vo6ChABjHpvJ2zBke6ajvMvdP1
         VYoE8UyvBkBHWDfNHsDdKr2qY69Cl9h3U1rizVoDCzOAYAJcgA7U4UqgEyyl+TUjPql+
         8kTw==
X-Forwarded-Encrypted: i=1; AJvYcCVfTjM1c3tYT/ojH97wmlA3PUuj+6RxFwVKCoJwVWD3m9mvTxRnTRwjouL7mhSldWGxjEs4EeeyZMlB3UvYvLHTC9xStT4DIKlCGmFCp+KxCITfp+cFjGhaj07ewZ50zcWaN6c3M5uRRw==
X-Gm-Message-State: AOJu0YyO9PoeQ/zF/LdrSTx3X6L0jkGZ4iLQj5wePIx+Wv9AhP3OTuto
	gkfsU9e05FOLUvtOPlvzyCOagmR7imHMt58thpG6mEglUJrq41Cw
X-Google-Smtp-Source: AGHT+IFMZPcztj+yF88D81UW5dxTUX4mF799w8qju7MgkdsbqrbDoESIU7yGI5Z+WYNTzz8dKI2EGg==
X-Received: by 2002:a05:620a:2441:b0:787:8dd3:7c5 with SMTP id h1-20020a05620a244100b007878dd307c5mr1797283qkn.21.1708562452552;
        Wed, 21 Feb 2024 16:40:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b15-20020a05620a0f8f00b0078401adad7fsm4811165qkn.133.2024.02.21.16.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 16:40:51 -0800 (PST)
Message-ID: <1e636620-d456-4bb8-a5f0-742be3a9d6ad@gmail.com>
Date: Wed, 21 Feb 2024 16:40:48 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] arm64: dts: broadcom: bcmbca: Update router
 boards
Content-Language: en-US
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com,
 William Zhang <william.zhang@broadcom.com>,
 Linux MTD List <linux-mtd@lists.infradead.org>,
 Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc: kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
 <20240207202257.271784-7-william.zhang@broadcom.com>
 <20240222003755.670359-1-florian.fainelli@broadcom.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240222003755.670359-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 16:37, Florian Fainelli wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> On Wed,  7 Feb 2024 12:22:51 -0800, William Zhang <william.zhang@broadcom.com> wrote:
>> Enable the nand controller and add WP pin connection property in actual
>> board dts as they are board level properties now that they are disabled
>> and moved out from SoC dtsi.
>>
>> Also remove the unnecessary brcm,nand-has-wp property from AC5300 board.
>> This property is only needed for some old controller that this board
>> does not apply.
>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>> ---
> 
> Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
> --
> Florian

Actually no, cannot apply this just yet since this depends upon patch #5.
-- 
Florian


