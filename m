Return-Path: <linux-kernel+bounces-110931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6928865DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA0B1F238E5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6678BF9;
	Fri, 22 Mar 2024 04:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="XTDtkdSc"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21116FB2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711083460; cv=none; b=MLZs8FpUZs9UuDUn4dCPvGSn9ZU156B0qn4aRj3+M/EXdQVbVQpQmybhdC9hII5bIrRF2rasmR8ydvb29X7S8rQ/YLvmjvHBRZOP/jBkSp2o/8mgjxzHyoBH9VWwApDtKeTTJPc2ClC7n0USa1GzW0L4YWdTOtoRWg6uamToazM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711083460; c=relaxed/simple;
	bh=fF5rQyHQWkmRrGj1g5vNHmvUdV2jYxwEEWFntwt3mQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VH24c8niE6Lr6DsZeOAQmE94UHP7E1OqcxB63HsEHDZzlJ/cift68L9EWiwJATRUpVgxmAlSpSsu8WE9WtRqQC/xkZf5rnCBCQiCKGMipxbzW2VtCT1I6QJxaBjKpqno57t3jMaXXdWeiQgCWeuBOQfQ1qnTYe/4JNB0D4PS8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=XTDtkdSc; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42e323a2e39so16499811cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1711083458; x=1711688258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4moE6UNpA9SIxqGdVmnT/LKS1e/fLbBXDD3FIgn3m9U=;
        b=XTDtkdScNFkcF4CigirtjL1hg1DNSj0URKs8xP+UrqQAjVNgfzfUBxWJ7gq1+RjJ2r
         hngAnxBb72TYsVJ2dVSEsEnUbqvdd8E+tyxbyd2GfSQ3LwLyGV+NsgTf2xUGfiEhGjhG
         CEKQVXDPj5XSskFAsAe/0BX9NwFeGO3JrrRoaU85nom+ODU9AYoD/Wt0ca+oAbec03lX
         FN0DmisqtPbu1knPLzUM/ms9HyfEaErO0L7ct1Tg1QjdL8tdhnngvwz/e4mESXMJVCvw
         11z/FWElfOXSGnW7nx0Cg3jVvahZCHh3IEYx4dskGQ82lsUhMhSCrKAmNjn/OnZjN1qz
         eifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711083458; x=1711688258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4moE6UNpA9SIxqGdVmnT/LKS1e/fLbBXDD3FIgn3m9U=;
        b=Z8eFOa/WhOqlzJJ1U1SEiaLuiZHeJl/SeFAuhdoa2Zo8RdyfHx3vcCtM+8lAC/dV/g
         zCK8g1n7XVixlCFzjURKWCxQ5U3A9cpIXavCAnEO6SzmBnHJYD2s/VNSkh8eI2asWHnN
         49DzIbd1LL12vA9WrafxIYcGmZhf4zuucdJbK9L3CtY7vZHzqIMfYjd1M5YiS9mGVofo
         Tnh39Yxc7SrlZZcgWvgYomijYnXzjBgFLStqTuv3TAo5rEJWO2kPD1l5b/R0HZxmRGR7
         rZ0nGlU6jIWQE3um7Xso9jg2UO+flDerpP2JEda6TtTyOOEGteFP3+0KdFd8pmkowk3i
         BcCQ==
X-Gm-Message-State: AOJu0Yyaox1AozYqRxdV7xpUy5aYcDsLGCWgCQohHU3IfIICdGUTdwTN
	3ZVh9M+ZLKXpi3J0hlalzulkZ/4PYo95mrbdI0cqGpRlIw7tntjwnQ8DMahr8Vs0LRzcZGyq7kw
	f
X-Google-Smtp-Source: AGHT+IFDVzdsNTf0W2w6oKUGYAk+vCLJ348WVZdcAHzdnqbFdRV88jezCeF+eTR98FPPhDmSdzt2NQ==
X-Received: by 2002:a05:622a:1210:b0:430:c6d3:b4e6 with SMTP id y16-20020a05622a121000b00430c6d3b4e6mr1592464qtx.12.1711083457763;
        Thu, 21 Mar 2024 21:57:37 -0700 (PDT)
Received: from [192.168.0.51] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id c17-20020ac81111000000b0042f07081f26sm558521qtj.22.2024.03.21.21.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 21:57:37 -0700 (PDT)
Message-ID: <14dcd743-144a-9f7b-849c-0843d50e4c04@draconx.ca>
Date: Fri, 22 Mar 2024 00:57:36 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: PROBLEM: Only one CPU active on Ultra 60 since ~4.8 (regression)
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
References: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
 <CADyTPEyAidGgBT3f1VJLHb3ouO-r1UyvFp1PcwXxy0NRG94sbw@mail.gmail.com>
 <1df92fec-7f57-5080-94ed-b149ed384280@leemhuis.info>
From: Nick Bowler <nbowler@draconx.ca>
In-Reply-To: <1df92fec-7f57-5080-94ed-b149ed384280@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Just a friendly reminder that this issue still happens on Linux 6.8 and
reverting commit 9b2f753ec237 as indicated below is still sufficient to
resolve the problem.

On 2023-01-21 08:31, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
> CCing the sparc maintainer. Also CCing the regression list, as it should
> be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html
> 
> The the mail address of the culprit's author bounces. There is another
> Atish Patra still active; does anyone known if those two are the same
> person?
> 
> Anyway, that's it from my side.
[...]
> On 20.01.23 04:15, Nick Bowler wrote:
>> Hi,
>> 
>> I'm resending this report CC'd to linux-kernel as there was no response
>> on the sparclinux list.
>> 
>> I tried 6.2-rc4 and there is no change in behaviour.  Reverting the
>> indicated commit still works to fix the problem.
>> 
>> On 2022-07-12, Nick Bowler <nbowler@draconx.ca> wrote:
>>> When using newer kernels on my Ultra 60 with dual 450MHz UltraSPARC-II
>>> CPUs, I noticed that only CPU 0 comes up, while older kernels (including
>>> 4.7) are working fine with both CPUs.
>>>
>>> I bisected the failure to this commit:
>>>
>>>   9b2f753ec23710aa32c0d837d2499db92fe9115b is the first bad commit
>>>   commit 9b2f753ec23710aa32c0d837d2499db92fe9115b
>>>   Author: Atish Patra <atish.patra@oracle.com>
>>>   Date:   Thu Sep 15 14:54:40 2016 -0600
>>>
>>>       sparc64: Fix cpu_possible_mask if nr_cpus is set
>>>
>>> This is a small change that reverts very easily on top of 5.18: there is
>>> just one trivial conflict.  Once reverted, both CPUs work again.
>>>
>>> Maybe this is related to the fact that the CPUs on this system are
>>> numbered CPU0 and CPU2 (there is no CPU1)?
>>>
>>> Here is /proc/cpuinfo on a working kernel:
>>>
>>>     % cat /proc/cpuinfo
>>>     cpu             : TI UltraSparc II  (BlackBird)
>>>     fpu             : UltraSparc II integrated FPU
>>>     pmu             : ultra12
>>>     prom            : OBP 3.23.1 1999/07/16 12:08
>>>     type            : sun4u
>>>     ncpus probed    : 2
>>>     ncpus active    : 2
>>>     D$ parity tl1   : 0
>>>     I$ parity tl1   : 0
>>>     cpucaps         : flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
>>>     Cpu0ClkTck      : 000000001ad31b4f
>>>     Cpu2ClkTck      : 000000001ad31b4f
>>>     MMU Type        : Spitfire
>>>     MMU PGSZs       : 8K,64K,512K,4MB
>>>     State:
>>>     CPU0:           online
>>>     CPU2:           online
>>>
>>> And on a broken kernel:
>>>
>>>     % cat /proc/cpuinfo
>>>     cpu             : TI UltraSparc II  (BlackBird)
>>>     fpu             : UltraSparc II integrated FPU
>>>     pmu             : ultra12
>>>     prom            : OBP 3.23.1 1999/07/16 12:08
>>>     type            : sun4u
>>>     ncpus probed    : 2
>>>     ncpus active    : 1
>>>     D$ parity tl1   : 0
>>>     I$ parity tl1   : 0
>>>     cpucaps         : flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
>>>     Cpu0ClkTck      : 000000001ad31861
>>>     MMU Type        : Spitfire
>>>     MMU PGSZs       : 8K,64K,512K,4MB
>>>     State:
>>>     CPU0:           online
>>>
>>> Let me know if you need any more info.
>>>
>>> Thanks,
>>>   Nick

