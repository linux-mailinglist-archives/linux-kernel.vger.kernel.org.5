Return-Path: <linux-kernel+bounces-123653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38170890C43
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0161F22866
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F95913A89E;
	Thu, 28 Mar 2024 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="yQP1ckTt"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCD4131E4B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660134; cv=none; b=ELeLwQ/rzyj2SPfs8Pw9KYTntoTMCaNhR0SEm+z/dHdQSYhED5oIQz5WbZoDCn/9UW/9HMr6VyT7UvgxQxpugT+gysCKG+pB6llTXOsB8+xh+W4gYW4cidjCk+8MZHLu8VpQU6G8zl/oEhQXRpXxV+8nPM9Bc1FikLb9xOSHdLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660134; c=relaxed/simple;
	bh=F4IrvSS6WvfTbwg+S1nOzbzpIHvcq0dGlD5txkHzVK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpulzlBUfTDiX6Auan5jq5fRZVTEjtV+doPhWSxIVWU1/3vdxk2ohO8v8QB9oR6KZNl+nMxQuDn5ClbeUauUfnv4qYkx3pScnMZwrVOl26W5qAV9lgB1IscG7HLOnlY3LAIiTn8juGd58Ds8/nz0ajneeimPOlytDy1E1x2kr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=yQP1ckTt; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a470320194so721882eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1711660132; x=1712264932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhOqlDsFnhyStsUL+RT7PNmxZO7uBWizHf6GICmX+OI=;
        b=yQP1ckTtFa0Nbah0PwcMmMl2brmJIdALgYkA3qHiG1ptTpY4BohkbmtlFBzcj8nP1u
         XvI69UyDvJ0UXzCzpl1G13BGZtSlewsF//tWfHsMic2Pi+LQz+thKHxN7d5nhw0ugRAn
         NsX0BETOnK+cVvFPTVvOQ9NG+P4OKCGfzwHi8krhtuFmmSs63oLtRGrkeADWBX0EfMvj
         6y0v+bE8cngBRTVknruywhgm8fonta1JI/NnqFCfVsxfcBIn6xjPblwi9p7UuPYCFjx3
         xbHcXHcMKUwtMjJGjWtIzU1y6eRC1EYWDkc0EB2wrewgNotwZ7KBcvh+5B02cJO0rlCc
         jpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711660132; x=1712264932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhOqlDsFnhyStsUL+RT7PNmxZO7uBWizHf6GICmX+OI=;
        b=o8RmQxNqn8BorJ4KOiEY6WfSC9SO8ytDgq1/BltNbEkfWm5Qy41pOa0jB207Cd1UTV
         6CpMr4bki/Xg2k97hm4lx7QcyoI2EKlFSajcBnautqonAILTenYzbiy1adlBGDRX0l70
         ylCwKEJGZEK7gSmNjf1lDfu5j4Jo27GAkfUU6ZcFdHUC94dmir9A4taauBv2FhLTsfFJ
         z7TtMF/vnC9iWSSxBDPLanp4la6v+SGSACU4iD5hlkzgArEqkZShE3KxvWzjchTuV5+g
         iOKnT1dTDkvri59DTflhBqjL81u5omtBVJz3jwjIwRm2PgO5S4WMPkrITb1hhOsXcyw4
         Xn8g==
X-Gm-Message-State: AOJu0Yxsa6QkIf9v6DI3F+iplj9b3N7Egui7QszCiKx9bY1BXH6UOGpt
	BeHAlpDXF5x3dEilofnwap/Iarz7+cQcpVGn2qqlok9BM8eVjnwn9RcqvtHHq0U+3H0BBbkRpei
	aMDQ=
X-Google-Smtp-Source: AGHT+IGfo+9brJXeQXDPL+VZY/J/lhapMlsOdjDfc2YE8PgBEa/Sxxdwof6mO9UnEH8hZci7XVl3nQ==
X-Received: by 2002:a05:6820:208:b0:5a4:7696:6ba8 with SMTP id bw8-20020a056820020800b005a476966ba8mr317575oob.7.1711660131965;
        Thu, 28 Mar 2024 14:08:51 -0700 (PDT)
Received: from [192.168.0.50] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id l26-20020ac848da000000b0042ee2bda028sm954486qtr.54.2024.03.28.14.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 14:08:51 -0700 (PDT)
Message-ID: <943c6d11-e214-43c8-8813-8e1aba6be15c@draconx.ca>
Date: Thu, 28 Mar 2024 17:08:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: Only one CPU active on Ultra 60 since ~4.8 (regression)
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
 <CADyTPEyAidGgBT3f1VJLHb3ouO-r1UyvFp1PcwXxy0NRG94sbw@mail.gmail.com>
 <1df92fec-7f57-5080-94ed-b149ed384280@leemhuis.info>
 <14dcd743-144a-9f7b-849c-0843d50e4c04@draconx.ca>
 <4dce7447-678d-4e60-b76e-b01988bd6515@leemhuis.info>
 <CAHk-=wgFuoHpMk_Z_R3qMXVDgq0N1592+bABkyGjwwSL4zBtHA@mail.gmail.com>
From: Nick Bowler <nbowler@draconx.ca>
In-Reply-To: <CAHk-=wgFuoHpMk_Z_R3qMXVDgq0N1592+bABkyGjwwSL4zBtHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-28 16:09, Linus Torvalds wrote:
> On Thu, 28 Mar 2024 at 12:36, Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> [CCing Linus, in case I say something to his disliking]
>>
>> On 22.03.24 05:57, Nick Bowler wrote:
>>>
>>> Just a friendly reminder that this issue still happens on Linux 6.8 and
>>> reverting commit 9b2f753ec237 as indicated below is still sufficient to
>>> resolve the problem.
>>
>> FWIW, that commit 9b2f753ec23710 ("sparc64: Fix cpu_possible_mask if
>> nr_cpus is set") is from v4.8. Reverting it after all that time might
>> easily lead to even bigger trouble.
> 
> I'm definitely not reverting a patch from almost a decade ago as a regression.
> 
> If it took that long to find, it can't be that critical of a regression.

FWIW I'm not the first person to notice this problem.  Searching the sparclinux
archive for "ultra 60" which turns up this very similar report[1] from two years
prior to mine which also went nowhere (sadly, this reporter did not perform a
bisection to find the problematic commit -- perhaps because nobody asked).

[1] https://lore.kernel.org/sparclinux/20201009161924.c8f031c079dd852941307870@gmx.de/

Cheers,
  Nick

