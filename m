Return-Path: <linux-kernel+bounces-17457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAC5824D84
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056E52854AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBA946A1;
	Fri,  5 Jan 2024 03:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="ZCrzf3hA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7CA440E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 03:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67f7bd86cafso5639176d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 19:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1704426333; x=1705031133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O8c3ESdi0IpZK01xiWxgeJ4UdiYi9dbopai5vRQAmfM=;
        b=ZCrzf3hAxojmPURXjyhmjP55vobVpOhNUc+p71kECADzYXsC/m78kAwcFOOuZ2k5SL
         +D/CJXn8PDyOT1UgdUw+akNGUaIhYHVAvFxlZfZg9FKnb5VIqGpvoaWof03eiYLsVun5
         +cZMl+K8A56Mq6MCr3uNK5Mja0lNk1Z4pv52W8CJXqG14IfYgw9bCmEBfV9VjOGsYMic
         1VblRaUocYmokkMkJbt3q6AolZsc7neXzpovAjECE0gAbpSrdEHKQApF8OW+MMMiaGMc
         F1pFZQ6v+v7HHaOlx3KTJ0r8vVVRNS+1xVEyHHhFyv3rOAaWu+nF3rjBwWAgIMBp/EAn
         4aaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704426333; x=1705031133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8c3ESdi0IpZK01xiWxgeJ4UdiYi9dbopai5vRQAmfM=;
        b=Qbg2yCOHJlxRCLz7D9N7hVeoYCMHtAjKfttC2EZkKuwuU8fGDASz71fKXarDR2jVs3
         UozYb28C3Cg69Vpz3L8Wy31T9sDgoHGbVJM8Cv/uTO21JTNLHDe1JNPtJAQpurzhPYTh
         BXg+vgUFGlzJ3IlRMdN+Hm6Up1PMfrUBpjzy6wf2EBZhDoEN/eRIvpEgESHx5AR76ck5
         VHBmQBhSHEoR/tzZc5v3wNQnuOOO9XlS9vWE5Q0mXZuivgdZ2U3Hvp5hufCUqHfdkhth
         FKlcwbJb7BVcpxoSIAhEBJSMJ+Z4TDzworaXDaNvUUw4Q1Rf6zePYy6OcEoZRwYLFt5D
         gN8g==
X-Gm-Message-State: AOJu0Yzb3baAwr30jF7d3C0C0gxQs6MLgIzHbuL3lIgZxEGi4Ltcnt3G
	cSrRyY7o2OCyuExDZL7vwMWEhI6NHJDj/g==
X-Google-Smtp-Source: AGHT+IFbkA2aPU2aI39vcY4LyLCBENRrl6F3tJNOaay03B3PVHlOWcvhr88DceJ6bvJ0p4z3390ecg==
X-Received: by 2002:ad4:5742:0:b0:680:d233:9d7 with SMTP id q2-20020ad45742000000b00680d23309d7mr1637485qvx.125.1704426332729;
        Thu, 04 Jan 2024 19:45:32 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id n12-20020ad444ac000000b0067f75dbf08fsm307623qvt.11.2024.01.04.19.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 19:45:32 -0800 (PST)
Message-ID: <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
Date: Thu, 4 Jan 2024 21:52:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/36] Remove UCLINUX from LTP
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Li Wang <liwang@redhat.com>, Andrea Cervesato <andrea.cervesato@suse.com>,
 Greg Ungerer <gerg@linux-m68k.org>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>,
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
 <ZZVOhlGPg5KRyS-F@yuki>
From: Rob Landley <rob@landley.net>
In-Reply-To: <ZZVOhlGPg5KRyS-F@yuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/24 06:09, Cyril Hrubis wrote:
> Hi!
>> I am not sure I agree with this series.
>> Removing support for UCLINUX from LTP is almost a guarantee for
>> not noticing when more breakage is introduced.
>> 
>> How exactly is UCLINUX broken in LTP?
> 
> As far as we know noone is using it and nobody is maintaing it for a
> decade,

Nobody is maintaining "uclinux" because that was a distro, but you can build
nommu support in buildroot and such, and people do.

Rob

