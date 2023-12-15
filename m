Return-Path: <linux-kernel+bounces-1677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A44CB8151F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67491C24281
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F92487A6;
	Fri, 15 Dec 2023 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjqzdXlm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E9049F67;
	Fri, 15 Dec 2023 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5910b21896eso818810eaf.0;
        Fri, 15 Dec 2023 13:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702676360; x=1703281160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=URgaobETTGO523ms2/XzCSoR/l+b3Vxx1CFTkH0pETk=;
        b=DjqzdXlmcF+KedNooMgfZlUTsqeKkMUxmmnz7jgKkpVgC2wE7mrBoYtcoR2IckGvdS
         lFUwxc9dMZ1kt/kvsvqdHwbebM0iSfY66VZAD6P4Oogi3kwnB7l1fAeWbRAg8qYzyyLy
         QZzTuQGXrZHApult4CWWi703nbFO5wAXZHI8JfveZ8zkkNXzVlzbjZuMgqW7DT2KEAfy
         J4kucKdDMP1YToq8yIATZefHL/afECGBrf0se8RSrE3pibF4umSSTDUwr+0EWeD5Bo+R
         694Po6Uk4z4RGCdBNCnC7LUqiVmu7epbdELbVrJKnh8kc4n6F0VCQt418FcX5BFfHXfH
         YkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702676360; x=1703281160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URgaobETTGO523ms2/XzCSoR/l+b3Vxx1CFTkH0pETk=;
        b=JuBFyJQQnQM6b5nBINZSLRAL3aI/lfZTijNmOMSBVJnONZSS6OKqxopzHoL13O9jYk
         5Y/X9RR+mnaP6A6wXsZXfDhAZIgKVlseaCQUbJJh/qzSXmHpXyUsP/7R3L7wBsqyvUOm
         0gXfSFZSUKFOcm4ao/2f8vQVvJraCZ1VdHlaXu6y3XRXb+8U1/e04fJxnfKyqAstjVGX
         kyhsly5nUmqid3QxOFxxUxey/wy5fEb6yHctCM41KL7nwlw2QZhLg0M7xrQQ166LRgcR
         5v9OkqUnlpUhUW9X5F13tuc1dIlgorwVVoThQHKnyAC2KSoUAODVwuA1B3vub5SvKjMM
         1mVw==
X-Gm-Message-State: AOJu0YwyCydsiRCNROtimbP6yYtwzX0I99xKMOjHJe3wiaixrLZcCTcb
	7my26PyhjxeMNVNnLoOwmHo=
X-Google-Smtp-Source: AGHT+IFskJrGRqXtrWPhWEftG8DqLSuh2BjSC9EONfWQ2siHQJdpSeo9D21Exn2M1itqayEZejncSA==
X-Received: by 2002:a4a:92dd:0:b0:58e:1c47:6325 with SMTP id j29-20020a4a92dd000000b0058e1c476325mr8640645ooh.19.1702676360300;
        Fri, 15 Dec 2023 13:39:20 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:7c7f:3273:a81a:4618? ([2001:470:42c4:101:7c7f:3273:a81a:4618])
        by smtp.gmail.com with ESMTPSA id x6-20020a4aea06000000b0059030f95ebfsm3989528ood.41.2023.12.15.13.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 13:39:19 -0800 (PST)
Message-ID: <1737d758-3b3f-8ea3-ec9a-bc53c282390f@gmail.com>
Date: Fri, 15 Dec 2023 14:39:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] usb: dwc3: host: Disable USB3 ports if maximum-speed
 doesn't permit USB3
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231208210458.912776-1-CFSworks@gmail.com>
 <20231208210458.912776-3-CFSworks@gmail.com>
 <2023121506-persecute-lining-45bf@gregkh>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <2023121506-persecute-lining-45bf@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/23 05:44, Greg Kroah-Hartman wrote:> Where is patch 1/2 of this 
series?

Hi Greg,

I double-checked and it does look like you were Cc'd on it. Either way, 
it's here:
https://lore.kernel.org/linux-usb/20231208210458.912776-1-CFSworks@gmail.com/T/#m5203732de487136de9b1d8a93b1c2f0b89dfe5e1

> 
> confused,
> 
> greg k-h

Equally confused,
Sam

