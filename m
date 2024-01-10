Return-Path: <linux-kernel+bounces-21794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0430E829465
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54DDCB24B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38623DBB4;
	Wed, 10 Jan 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWromA1R"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A50139FC9;
	Wed, 10 Jan 2024 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50ea98440a7so3744069e87.1;
        Tue, 09 Jan 2024 23:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704872059; x=1705476859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cQA4kBLC3kUcpyDzl1NuAb1PXWAP5vnpOabzjxLoYKg=;
        b=gWromA1RzoREvoWlVZRsd2/gXsNr9ZL43Cq7uQB9YuZxmdnLoEUsIgc2cZyy/tN6ec
         SvWKazaeyMjSVxMW4aOiL33qrqGU/kkM7LrFN6yofy9A0/v1QWuqlZVmM+pPfarsPkiJ
         ZthOzasIHeoZQywMdq2/hreEoLLLC1nLvUrB/g4IF/jfQxG74GaQY91zJ2Gnq3ngaHrZ
         KWfbONGDGVu/umJjvvn+PQnr7X9vw0TFdV9TCtZnz+tinCLMSURd7E6lETf9mLQB26KX
         6LY0crbmgOstX2tf9yxv/0kprYgbivBlObYrBzYL2sD2uqrnhquTcadua5lY1cUjKxnI
         +ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704872059; x=1705476859;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQA4kBLC3kUcpyDzl1NuAb1PXWAP5vnpOabzjxLoYKg=;
        b=pKuO8deenJCAR0Ixhp4ivOOo9OXekMgbccJEpfI99UQ+cwDo44JM3wjU/94AAsHLWn
         AkZ3yrBveQ/zDpiMncovzf+z3i8tKeeugHn+ahEiBpKIdutjvc2JURlIXzWZhjbCRs2p
         PY3J3a+oy+QtMD1VAu7U/UaWGo9rDGoE7WS1bEBkj0BoTPT/QtFQ6HJZ9YmfUo3Hu+eF
         e5H5m9tE04shNb7Tgc50OZfqBuOpzjbe2/In1nlLW/m/wlpSaxM3FAS/VBl6Ii4ZQvYg
         jhLoryP9iLjmmyMvuP2GPp1ORdKwdCSJxgZ+b85lEOmOkwvfsTfxvt6TGBnuovmWMSMh
         vJIQ==
X-Gm-Message-State: AOJu0YzyWqyx0N5ZbM7SZsY33zbDfOGTMUwmani0ID4RekaC+29XhCuA
	WuT67l/BiYEvsfYBtAF5pY0=
X-Google-Smtp-Source: AGHT+IHD5xzkS8rzCE2o7LPbimN/ogtXkBJtgVX/UYmDiJjHSh2Zk64/TA7jJYVWhxN6mphokXaKiQ==
X-Received: by 2002:ac2:43bb:0:b0:50e:7b34:c17b with SMTP id t27-20020ac243bb000000b0050e7b34c17bmr95771lfl.74.1704872059131;
        Tue, 09 Jan 2024 23:34:19 -0800 (PST)
Received: from ?IPV6:2a01:c23:bd4e:3500:d880:5055:4cea:107c? (dynamic-2a01-0c23-bd4e-3500-d880-5055-4cea-107c.c23.pool.telefonica.de. [2a01:c23:bd4e:3500:d880:5055:4cea:107c])
        by smtp.googlemail.com with ESMTPSA id p10-20020a170906a00a00b00a28479fcb8esm1802025ejy.103.2024.01.09.23.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 23:34:17 -0800 (PST)
Message-ID: <a26b3079-f5fa-47b0-8b83-42db9fbbf3c4@gmail.com>
Date: Wed, 10 Jan 2024 08:34:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tg3: add new module param to force device power down on
 reboot
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andrea Fois <andrea.fois@eventsense.it>, Michael Chan <mchan@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 George Shuklin <george.shuklin@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240109194551.17666-1-andrea.fois@eventsense.it>
 <d8ed4af1-5c83-4895-9fc3-9aea25724fd9@gmail.com>
 <CALs4sv2_JZd5K-ZgBkjL=QpXVEXnoJrjuqwwKg0+jo2-4taHJw@mail.gmail.com>
 <18249a21-7aec-4a66-bc5a-3aa077c2b190@gmail.com>
 <CACKFLinZ=pkRn7oertS8W96bGmMjr8T+BvqSAN3BZ7SiEm5gxQ@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CACKFLinZ=pkRn7oertS8W96bGmMjr8T+BvqSAN3BZ7SiEm5gxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10.01.2024 08:17, Michael Chan wrote:
> On Tue, Jan 9, 2024 at 11:09 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 10.01.2024 05:12, Pavan Chebbi wrote:
>>> I think the second suggestion could be a better solution. Helps to
>>> solve the issue 9fc3bc764334 is trying to fix.
>>> But I am not sure how easy it is to test. As I recall, Goerge was
>>> unable to reach out to the author of 2ca1c94ce0b6 when he wanted to
>>> test his patch for regression.
>>> We did discuss the risk of this regression.
>>> https://patchwork.kernel.org/project/netdevbpf/patch/20231101130418.44164-1-george.shuklin@gmail.com/
>>> Unfortunately, looks like it has come true :(
>>
>> If the culprit is an unexpected MSI interrupt, then you may also address
>> this directly by disabling interrupts in the device. tg3_stop() may be
>> a candidate here.
>>
> 
> We already call dev_close() which will call tg3_close() -> tg3_stop()
> a few lines above.

tg3_stop() calls tg3_disable_ints(), so I wonder how a MSI interrupt can
occur after that. Does tg3_disable_ints() disable interrupts synchronously?
Or maybe some kind of commit is needed?


