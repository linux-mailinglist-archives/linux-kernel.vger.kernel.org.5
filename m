Return-Path: <linux-kernel+bounces-19191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F14826991
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F043B21518
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39DD12B84;
	Mon,  8 Jan 2024 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aWSxOLhM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D84512B6A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d4a7f0c4dso18276475e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 00:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704702881; x=1705307681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GfLQg2J+OwD4mK8aB87IakjXF3Kgfssqm9r5be44QF4=;
        b=aWSxOLhMBt67gko+wp/hw79/N1xiyAhcULyJCFaajUXhhpLxOHw1zQt45IlP1qLgrm
         cS7GiORgmazWxjvj7Nu0V4s/p7JCapp/KaRVXy3bzPRQC/qFER59yVgdwkJCNzQiRgGw
         /+gkM7oMEqjiItiQ3VnAKgJsdHtxP2ZiAb0hFB7U40zw2yi/Adn6X5A/v/qYryVH73Hr
         w9GW5raYY3yNzAtubEivj76/ETpmCSFOnko1O8T5nAhS/ez/XHcPfAtXkia+AOLjaVO9
         DlFl4Ke4+7bzB/WNqi4EVw+kzWexf/a8NDdiMK31qF6v1KBOVT7/tIIOzsaDXm3Laf0p
         3KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704702881; x=1705307681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfLQg2J+OwD4mK8aB87IakjXF3Kgfssqm9r5be44QF4=;
        b=vHYsyIehaWaNUuWVQgZ9cFdOUuNsens7pEOnU8L6YOvSc5sPQScsY+C0SRL172j5H6
         mO3esB8Jc5b8N3sD175Ry/r7oIQwgKqgs5BTl4sBBi8p5P+MljhvkkjUMVvrVbOTqY9R
         a8nwSn3WvhHqx2HGS/dM3UH8oAVnV3WvR0bzDUdl0CcD9C7y4qrSwTsVReba9GWl3LWh
         9Wv2p+mRn7IA7naGLBAzKz0s8KJ2li6l1V7RDH0uAalHBozrirkMybxeKmy0cud7LpK7
         MD/+7RDXYfMOsNQrWfEwN3rq0zfsKtQcwJsSOIHx3g51vhwpipaiLal3IrtP1fVvXzTW
         lQZg==
X-Gm-Message-State: AOJu0Yzx3CzHqQ8FPgw3x5AioKjMW07AbM4RaPtS7XlODltTorvSnXcC
	BLGVuaKyHpbHWjfc9yUM+TOg+WtdSDQ7xg==
X-Google-Smtp-Source: AGHT+IG/mp6y+0cYUrDCavig/3hnnulb4tFtsRjSF6zEM6NAi6nWZTX4f7mAdVBvGKSLQG0+ZSf0JA==
X-Received: by 2002:a05:600c:3ac6:b0:40e:4785:276f with SMTP id d6-20020a05600c3ac600b0040e4785276fmr507460wms.100.1704702881399;
        Mon, 08 Jan 2024 00:34:41 -0800 (PST)
Received: from [172.20.10.3] ([37.161.21.69])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b0040d7b340e07sm10122595wmb.45.2024.01.08.00.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 00:34:40 -0800 (PST)
Message-ID: <6fd9dcfa-b412-4573-a2c7-e4ded89bb225@suse.com>
Date: Mon, 8 Jan 2024 09:34:35 +0100
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



