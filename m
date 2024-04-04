Return-Path: <linux-kernel+bounces-132273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BBD899252
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D691C2216B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAAB13C807;
	Thu,  4 Apr 2024 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LADr0tLD"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9152113C687;
	Thu,  4 Apr 2024 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712274824; cv=none; b=m7qQ3L7mrBjH+Ojc9wS5A20IVKpARXb2xNWzrix/uvj78XYldCow0kK6nuFPH9pSw9oEMdXQztK3SLp1tQwhM01SqI/jQumtbseozn8S7VvPY5LtW1iJsx3RmPNHC/Aayr2frzo1Zjm8/3g1WKcH43pMV0zlMeznpAeWu9cZNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712274824; c=relaxed/simple;
	bh=yPUkKEmnMlbH24omeQEh7wwPFqns/bYkVK8OvtQn0pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMfWxZpMhgTqgufpupVPib4EiJ4h4xzd+BP1gGLq6GeTBR8IDHBeEbZtubjQtKFM3+U1JCWYXoK//mA/ywLyYobNY6MOC8R2gWduY6Ly49zXllIVigqT5rd3nGL7Ij0q+BwwPZmRRM6AdPnz6ChtdsGWiyd7ABfAqutpfEN9+9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LADr0tLD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6eaf9565e6bso1194787b3a.2;
        Thu, 04 Apr 2024 16:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712274822; x=1712879622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pemxDaE/c4hiqnOrM7jkQhQHqjMoRFwFG/wb/u72+qc=;
        b=LADr0tLDjr+QPwuNndjikpExp1SnuIezV0Zq/Va091F00I0hq3YZgg8Al080AGH4Ci
         7MdNL8pE/Z3j1wLvS2W0E46kSuKUX9NkonoPcW/Vma99+J0+dgDGztIh4WnS41chPjNJ
         QQ6UjnZt+i3s+v3AI31m6s7TX1S50Rdtq+7PO/MnJOpBFXCAxueS4o134lGt2sP1uz4j
         4v4HC4qY0PE3cgHzLQUSwD3A1Wk2BKooPbW2P2aUOgskL3fRxm9uu3EOXd9Af7fGt/1q
         8abdvWuOyfxPS0Nkj7AmPZmRJpfbMxXsqbeTqNVkzGftN7EAj5OQvmzTUySObVnwFulb
         Mf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712274822; x=1712879622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pemxDaE/c4hiqnOrM7jkQhQHqjMoRFwFG/wb/u72+qc=;
        b=ga4B3tRIjIcgC71V+E1714SCA+dlniwiIeAeFMmsDOp0XZH8Kw60J25TFlrmTLaS+G
         KmBuX0AVlCAnaaH1ydssE+5tEAgIWE2WgwV3P3A9Cdx26JR5qPLNNd8WmAIHIVTJ6RRA
         ZRngXa3EmJfCXtmfAll2YRiZoRoc8tmzRi5JHGdhPeVEAfBmWPbyWEEZlZh7eozxfmLu
         mlTqehJI/4fnEZAeo1l5Z373EGxYwbg8pHRoy4VXMZ8lqCHfM6U8UlweG7MXotf8Pltu
         H5X28Gg8uq3yjRCXA92BrJnNkcnEDiOBNFLC4v8TscFk4seSTXIeK2BNjYpEWpWWLZ9X
         X56g==
X-Forwarded-Encrypted: i=1; AJvYcCWR6hCT3EVYJG8jBYWD+kKUzzd7bYNtm+dThr8p79P/msQSNYEg3GzrHuYLYcRL4P9D/2hnXrAk1oCWc8g7UG7nV8dLvScus5pEp111KEDNj27DkhYvUO7BLTC65FLW6VS0nMoqPcQM9QU9f0UIQA==
X-Gm-Message-State: AOJu0Yw8Xv0o1RD7VvOpbqf8L9oQObSzjEpOW6qkD4fpnMoYsZ0coLeM
	noPYXxo668xI3Eo76+1vg32F0ZVjy7QZSiBm/6xc7du20f0KrcL0
X-Google-Smtp-Source: AGHT+IFUdjuEWq9BCDpG2Xzm4IMEnETdqMHAsq9KiJRZUSVJtT1IDB5qfW6+TzqJo16UOlqdwCao8g==
X-Received: by 2002:a05:6a00:2e87:b0:6e6:9a11:ccec with SMTP id fd7-20020a056a002e8700b006e69a11ccecmr3968389pfb.17.1712274821562;
        Thu, 04 Apr 2024 16:53:41 -0700 (PDT)
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id y7-20020a63de47000000b005e838b99c96sm191208pgi.80.2024.04.04.16.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 16:53:41 -0700 (PDT)
Message-ID: <6d2666bd-1c86-484d-8b4f-f195f1bf1f7e@gmail.com>
Date: Thu, 4 Apr 2024 20:53:35 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf srcline: Implement addr2line using libdw
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401160805.51277-1-yakoyoku@gmail.com>
 <CAP-5=fXu4uM=cU8Q=1JP19sELfarNE9BtBmbFW0Uyq2e_HJ6QA@mail.gmail.com>
Content-Language: en-US
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CAP-5=fXu4uM=cU8Q=1JP19sELfarNE9BtBmbFW0Uyq2e_HJ6QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/1/24 1:56 PM, Ian Rogers wrote:
> On Mon, Apr 1, 2024 at 9:08 AM Martin Rodriguez Reboredo
> <yakoyoku@gmail.com> wrote:
> [...]
> 
> Awesome sauce! Namhyung was just mentioning the idea to do this to me.
> I wonder when this lands we can just work to remove all of the
> BUILD_NONDISTRO options, namely libbfd, libiberty, etc. I suspect we
> have dead/broken code hiding there.

I thought about the same, though I think there's some disassembler
things to tackle, otherwise it'd be easy to do.

> [...]
> 
> What does SYMBOLIZER mean in this context? Shouldn't the code be gated
> on say a HAVE_LIBDW?

Accourding to LLVM `addr2line` is a "symbolizer" program, that
`SYMBOLIZER` means that we have a library for translating an address or
a symbol with an offset into a source file and line.

> [...]
> 
> Perhaps libdw_a2l_data to avoid confusion with data used for forked
> addr2line. Could you comment the variables? Names like "input" are
> fairly generic so you could provide an example of what their values
> are. It is also useful to comment when something like a string is
> owned by the struct, so that cleaning it up can be checked.

I've left out some unused and suboptimal fields, a mistake from my part.
Though `filename` and `funcname` come as read-only from `dwfl` so they
don't have to be copied.

>> +       const char *input;
>> +       Dwarf_Addr addr;
>> +       Dwarf_Addr bias;
>> +
>> +       bool found;
>> +       const char *filename;
>> +       const char *funcname;
>> +       int line;
> 
> Moving "found" and "line" later will avoid padding. As this data is
> attached to a DSO, does there need to be some kind of locking protocol
> for >1 symbolizing the same DSO? Perhaps these should be filled in as
> out arguments to avoid this kind of complexity.

Maybe not, I'm not sure about it.

> Also, there is some DSO clean up happening in:
> https://lore.kernel.org/lkml/CAM9d7chqnsDBCVFoK2hSs=22QrXBS=13Px5hGA4hM=ho7CZd2g@mail.gmail.com/
> where accessor functions are used for the sake of reference count checking:
> https://perf.wiki.kernel.org/index.php/Reference_Count_Checking
> which may cause some minor conflicts with this patch.

Will rebase it, then.

> [...]
> 
>> +               Dwarf_Die subroutine;
>> +               Dwarf_Off dieoff = dwarf_dieoffset(&scopes[0]);
>> +               dwarf_offdie(dwfl_module_getdwarf(a2l->mod, &bias), dieoff,
>> +                            &subroutine);
>> +               free(scopes);
>> +               scopes = NULL;
> 
> Is this dead code?

I don't think so, as the scopes could probably differ in each call, I
will have to investigate.

>> +
>> +               nscopes = dwarf_getscopes_die(&subroutine, &scopes);
>> +               if (nscopes > 1) {
> 
> Similar early return comment to above to avoid indentation.
> 
> Thanks,
> Ian
> [...]

