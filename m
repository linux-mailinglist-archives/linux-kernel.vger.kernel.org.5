Return-Path: <linux-kernel+bounces-19190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F1882698D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707ECB214CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58C11C87;
	Mon,  8 Jan 2024 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c2T3111V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649B1170D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d2376db79so14790805e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 00:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704702813; x=1705307613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GfLQg2J+OwD4mK8aB87IakjXF3Kgfssqm9r5be44QF4=;
        b=c2T3111V3t9+xUAP2vipi3qNRYeYjNE2BQ0UfqlwHCtuAQbQLcf2qSKxTQcarMM6tV
         o9w2+qUgmcv3RJu0Sv907qG4m/rxNJ+0Wmi/RG0u9PcbwHljd9KcXpO3F7J0vzwAk/cf
         hddJv0TwRt9Y6PPLtDDisnuoPQPS6NBuXTGFRIBC6AJk9N1DCoUwgK+LsCbgLRH0efZm
         ICQQeDp3RozBTBbCQ/z1u11SncBdEDra+jMw7Vzt1UXeOZyShrfa7k/t/OsSCPkH8XFI
         AWHP4Mwlwfc1awYa7EdMg/C3CtEZ8fdbipmS7+xq4ToJM02z256wvqs4ZCvkF/Sv5YRb
         +M3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704702813; x=1705307613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfLQg2J+OwD4mK8aB87IakjXF3Kgfssqm9r5be44QF4=;
        b=Ce2s+Jkptw8OfyzLThgH2KkWoZjpd1yGh5KE3sBFIwdVZywANoXut0UpGMEbGxM/+8
         iY0aGNbO9nh+65GU3VymoE6uYp2AGBKBrS7b24wzOvibywNPhJ2w7Rgo4oQDvGHocX/y
         AsXHOmuya/mEjhvoV49BbjltSfpihfChjBtgz1fMItkJ6TjvhXOUdJQin7OWOn3NghPJ
         bEzyRjzuIiyQOSXpka4du7W9n4hdZQRmS16nRjJ99UEpSC8j+eYrcGBn0Qa39Lz3UpEz
         1aQ+Qr5pXei74gFyjXS8QZs2vMEezjwvH/yziAUWm6BRB5qzZ5KvZxHycvH+NRFJQSC1
         Po9w==
X-Gm-Message-State: AOJu0YyarvxAbLN180LkE5Hi/bRFx02MTDGHU4zqUxeIhv6CdBS8tZbE
	kF1Lboyvyz7ZbBXVxnPzGbGOMvRpaDBBLg==
X-Google-Smtp-Source: AGHT+IFdr9+p9p3yVvUI5Yb2+RUaaTtc6lK6/0ftFespHQFyJZzml/U22xZUgZCqObC/GxElyekYhg==
X-Received: by 2002:a05:600c:3411:b0:40d:4dce:4a2e with SMTP id y17-20020a05600c341100b0040d4dce4a2emr2008525wmp.26.1704702813400;
        Mon, 08 Jan 2024 00:33:33 -0800 (PST)
Received: from [172.20.10.3] ([37.161.21.69])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b0040d3db8186fsm10246189wmq.5.2024.01.08.00.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 00:33:32 -0800 (PST)
Message-ID: <848d1908-b758-44c2-a7bd-f3e83da18bce@suse.com>
Date: Mon, 8 Jan 2024 09:33:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/36] Remove UCLINUX from LTP
To: Rob Landley <rob@landley.net>, Cyril Hrubis <chrubis@suse.cz>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Li Wang <liwang@redhat.com>, Greg Ungerer <gerg@linux-m68k.org>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
Content-Language: en-US
From: Andrea Cervesato <andrea.cervesato@suse.com>
In-Reply-To: <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

My 2 cents. I'm working on refactoring growfiles test which uses UCLINUX 
flag.
During its development I had occasion to check UCLINUX support and 
(indeed) it seems pretty
broken for LTP, because nobody is maintaining it for a while and such 
tests use old API that will
be replaced in any case sooner or later. I agree with other people about 
removing it, unless there's
a valid reason to keep it.
Just in case we want to keep it, someone should take care about UCLINUX 
support, testing LTP releases for it as well, but it doesn't seem like 
something we can do inside the LTP devs team due to the lack of resources.

Regards,
Andrea

On 1/5/24 04:52, Rob Landley wrote:
> On 1/3/24 06:09, Cyril Hrubis wrote:
>> Hi!
>>> I am not sure I agree with this series.
>>> Removing support for UCLINUX from LTP is almost a guarantee for
>>> not noticing when more breakage is introduced.
>>>
>>> How exactly is UCLINUX broken in LTP?
>> As far as we know noone is using it and nobody is maintaing it for a
>> decade,
> Nobody is maintaining "uclinux" because that was a distro, but you can build
> nommu support in buildroot and such, and people do.
>
> Rob



