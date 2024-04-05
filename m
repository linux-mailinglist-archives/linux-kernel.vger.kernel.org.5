Return-Path: <linux-kernel+bounces-132284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE42899276
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0B7282A3F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6F01367;
	Fri,  5 Apr 2024 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4MH14xC"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7244D36F;
	Fri,  5 Apr 2024 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275797; cv=none; b=BaOBvfSlMOhHrrV6EDu08DdZ5a4ABAV/+Ig2EJCEbWUe41vzSIMDnhztIs7JO7ncQpqEVg6iPKThs6z1e9d8r8LKnl9iegRuxBae4adNjJfzGKhO5pBd25BegdLp+/FnoZuSQ9+0Le89mGDpSodm+mvpiYHXbV3jcI96vHN82ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275797; c=relaxed/simple;
	bh=VslqtpWV8HZ2n6jsi2flLRXK1lNliMOrPOyCoQd/QcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezHg0+rsoXU9z6lu02IcG5JmFdJACvqv8oQXX9ypDmKXuaT3kMaZiSt7flIwemnG1s+TSUelBoU7KkQVOTyZe7+zCMeH0/eG+7EtqiVvnDS6Ul42wh0SHuPT3TQhw9uY2IpkSJuxwoQyByV7KAEIUEJwx1QBNzJbN08x4mTX1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4MH14xC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ead4093f85so1403967b3a.3;
        Thu, 04 Apr 2024 17:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712275796; x=1712880596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrEadAnWsc+S5I9mQlpyw9ef/mT3Xvv+Fy/i8/caB1o=;
        b=L4MH14xCKZd8t54HVCwUYaSR90xY+EXmRKLUuE3XF7iJAFt+V0v8L8+7G5mNUn+hXX
         U4Wqd1NDMIUCnc64iKAyobfbl2ZiuGgwHF6zMITqHYgp4XiWqHQwWQ8bnfHg8FhfVXBX
         lB8lpGyBXIOzgRomLmAs5uvk+W/SwTDIybZe3b3KU50ZLXD6wIiXKyBt52OJSMpQ2Bfd
         0YzsS/kwwcvWTstIWG8fF6Fum8mHktFC0QC6uC31HT8yMG414r0XRNvvS88RFp31jahC
         odUHBFJmQxyxpK6fcmsbSE6Tx2lJgnc1+5SE6/kdursJRNZr9649cCp6pbP/MZFjv3kK
         eOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712275796; x=1712880596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DrEadAnWsc+S5I9mQlpyw9ef/mT3Xvv+Fy/i8/caB1o=;
        b=PjFvI3FhI+CgenWHzLCE4UHhxgNPqDiFfrCPhyzOffGRCrRZTDCJs6fnVbSkIj1KW8
         qR9hegPEHZNLjc0jvo7iRDaSvqgxUDeTdooVfoOz2VZEW4kpySrOZJ/Hrl9+b8uWgJIS
         HcvUIlwTYtBUhBin+KBr+V7LHPA26i6Bt3lqCfTSyAFDUQFevZpv9/OuXdIRN7STu4it
         cVlGgYcmw2L7Lf/eRwmvoQPIE0Ki7sjwJsnpGbxzgO8YoQRGMEetck0azFOrqbaFW7LC
         /jjqFGXHEiPfXozF0YmhiAI3bOn/p7h1jauWn5kZmJLdE8z5DIxJW1IPEUz+M9N0LhfI
         srKg==
X-Forwarded-Encrypted: i=1; AJvYcCV9dvo/xuX2uHoGcG0Mn2rWp9kufKVF+Yi7J1DhMIFIIVSRiT3C9jLKc2p9MSyhgYhHpgz9w40iXGPIP8wgTNZ0kZMeoS14kkOqVQxhLNb+RI1VF0ktT1STFRF+tagHsjBIsWbC6enO0oCTuEZ2Kg==
X-Gm-Message-State: AOJu0Yz+k5e3EkOLc72FXoIjOC85Db4a7iC7EdaXMg0qjhQnwnV4Kf4k
	lvn21xIdqkmfoB+2obnF7HgN6hLulzeIL9N/1c/F7oaFYUqLLk06
X-Google-Smtp-Source: AGHT+IEcdC5Fj+xZsa6xKFUVGzWAnng2NU9K2uBBv1ktE65A/1SnfTCrPvgaXU54obPC2xiNLu7riw==
X-Received: by 2002:a05:6a20:d80d:b0:1a3:c549:62ef with SMTP id iv13-20020a056a20d80d00b001a3c54962efmr69231pzb.1.1712275795657;
        Thu, 04 Apr 2024 17:09:55 -0700 (PDT)
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id 3-20020a631843000000b005e485fbd455sm253708pgy.45.2024.04.04.17.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 17:09:55 -0700 (PDT)
Message-ID: <3485d1b1-7824-4e62-82b4-ed52360122dd@gmail.com>
Date: Thu, 4 Apr 2024 21:09:51 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf srcline: Implement addr2line using libdw
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401160805.51277-1-yakoyoku@gmail.com>
 <CAP-5=fXu4uM=cU8Q=1JP19sELfarNE9BtBmbFW0Uyq2e_HJ6QA@mail.gmail.com>
 <CAM9d7cjgfQpo6dgV4f5Wm4shVpknzP4_m36AkTwaUaF4jLrV1w@mail.gmail.com>
Content-Language: en-US
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CAM9d7cjgfQpo6dgV4f5Wm4shVpknzP4_m36AkTwaUaF4jLrV1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/24 8:31 PM, Namhyung Kim wrote:
> [...]
> 
> Thanks for doing this!  Yep, we could unset the env temporarily.
> 
> As a general comment, perf has some helper functions for libdw
> in util/dwarf-aux.[ch].  Please take a look and use/update them.

Whoops! I haven't seen that file, thanks for mentioning it.

> [...]
> 
> Probably we can use cu_find_lineinfo().

I could use that, I'll see.

> [...]
> 
>>> +static struct a2l_data *addr2line_init(const char *path)
> 
> debuginfo__new()?

`libdw_a2l_new` can be another option too.

> [...]
> 
>>> +static int get_inline_function(struct dso *dso, struct inline_node *node,
>>> +                              struct symbol *sym)
>>> +{
>>> +       struct a2l_data *a2l = dso->a2l;
>>> +       Dwarf_Addr addr = a2l->addr + a2l->bias;
>>> +       Dwarf_Addr bias = 0;
>>> +       Dwarf_Die *cudie = dwfl_module_addrdie(a2l->mod, addr, &bias);
>>> +
>>> +       Dwarf_Die *scopes = NULL;
>>> +       int nscopes = dwarf_getscopes(cudie, addr - bias, &scopes);
> 
> It's not clear to me how this dwarf_getscopes() and later
> dwarf_getscopes_die() work together.  Can you please add some
> comment?  Also we have die_get_scopes() and I think it's simpler.

I think the first is to get the scopes at an address and the second is
for the scopes with the addr offset at that DIE. Off the top of my head.

> [...]
> 
> Why not get the function name from the abstract origin?

I'm not getting it, where's that abstract origin?

> [...]

