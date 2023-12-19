Return-Path: <linux-kernel+bounces-5172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0494E818786
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E14286956
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DD9182A3;
	Tue, 19 Dec 2023 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+qcIWnd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84354322E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7b35d476d61so189141039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702989225; x=1703594025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47B4J9PJ8CbVtGXi7aaGO0pXjzWtuUJsl1hSW+/clM0=;
        b=A+qcIWnd9KxDNVyiwUOq0IkSx/jEXnn7/79ssdwswkzeZGzZN75HGhK14CA//4B3v7
         9CdhcLciKucnq+ZXZXky4fbCnpAapfr2iQF8sUJr2ySd9TmCZq8h1S0478BShZhiWg6t
         Risk6J+TP7e2tK9QmZGvZzVHymqtO2lHsDmTPJqwAL+1FiwOLnf6Fa/gCm9RuOxhRRby
         KFz5U8oQ5z+XXAggpO1+eD5A8kOUjOWxiKBegZTtrdk2rAPWeESUA1y3iiGNibIwm0do
         g0TpEIKLYjMoyWq8BSIXSaQTEGCV1to4EyT+2ENbt6dk8+FxdQUpBZIGdN/nPfFVwW/f
         WwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702989225; x=1703594025;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47B4J9PJ8CbVtGXi7aaGO0pXjzWtuUJsl1hSW+/clM0=;
        b=co1qzdxisdKl5wMEJoHXnsHgm6fbZ2c2zacMUUw5p5k8oFoyQl0CM5T6EByvNhNro4
         DTk2x+kAcbFL9HCA0zAEx4ryft1AUzgvnfLvHjKQ7nclVLieGJGyOlUkOvErEMVW8YB3
         AjtT4/Anr7eHd1fwipGC6MjyieCHfdZJVzY5ujvYNUwVEMA2mbaoewjCyRlS0HmvCQ6Y
         Ze/uAf2Au2vksUlt6wdXN2KSHhvMHT8GSoiiWlY8p8X2vv+A+GhJtkeQgOqZnqIbz10F
         QEebkh3auVl0pH+QZMKeX28RwaB+7fAE5dCgIQ/TZ1hI3NrHaK5SzTcPclIDDdLUDMLr
         1REg==
X-Gm-Message-State: AOJu0YwA7wQs7cStu9CZS8xMe/kB/0heWddPP1iGcMIWRL/tpjQoKUwN
	0yLz8oeL6p8S5eVSgynQalo=
X-Google-Smtp-Source: AGHT+IEXpl/HsqfETIvhoNyvJx3esAZtdQ4nZMK58D9UPDS8hzawo2vd45dGcfflCZlw5Y97JZ8bqg==
X-Received: by 2002:a6b:6d0b:0:b0:7b7:fb2a:aa29 with SMTP id a11-20020a6b6d0b000000b007b7fb2aaa29mr131668iod.25.1702989225565;
        Tue, 19 Dec 2023 04:33:45 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id s13-20020a5d928d000000b007b7ab7442efsm2189432iom.22.2023.12.19.04.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 04:33:45 -0800 (PST)
Message-ID: <09f433c0-72cd-4ebe-b405-4c9acc26e8fd@gmail.com>
Date: Tue, 19 Dec 2023 13:33:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.8 2/2] nvmem: drop nvmem_layout_get_match_data()
To: Michael Walle <michael@walle.cc>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20231219120104.3422-1-zajec5@gmail.com>
 <20231219120104.3422-2-zajec5@gmail.com>
 <040fbc414bf7404046b12dfed7a1c647@walle.cc>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <040fbc414bf7404046b12dfed7a1c647@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.12.2023 13:21, Michael Walle wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> Thanks for layouts refactoring we now have "struct device" associated
>> with layout. Also its OF pointer points directly to the "nvmem-layout"
>> DT node.
>>
>> All it takes to get match data is a generic of_device_get_match_data().
> 
> Isn't device_get_match_data() preferred?

You're right. I think a big crusade against of_device_get_match_data()
is still ahead of us but I'll make sure to use device_get_match_data()
in U-Boot env layout to shine as an example :)


>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Michael Walle <michael@walle.cc>

Thank you for quick reviews!

