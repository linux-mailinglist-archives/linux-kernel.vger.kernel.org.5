Return-Path: <linux-kernel+bounces-123485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9448890952
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C701F22985
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF201386BD;
	Thu, 28 Mar 2024 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="pnkZFVIZ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF67460;
	Thu, 28 Mar 2024 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654571; cv=none; b=sYiLnpLAOpLV3kIYMdKaMEfKFEORadPzB/jexjQn3B6M8JKqaRAAGiA0qyXgx7wx5/X0IuQGvKDYBcMdrCH0K0qFU+RLUuz6T8UpRw4U4AIZ1mnpN37tJt+b5roTapqvEa8byL354MmoX8785qS8/NS/t9IqlkLCT2CwOwGjI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654571; c=relaxed/simple;
	bh=GBMP9eUzd576uCKEfwrAbrzJQU5ydmFcRsIdjAE9gJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZU4qz1QIvXPqKMKGuaXTFgkpe+yOj0UWRuupvgBNbJP2ZXRyycB0q0Ix47yopvjPfK5nJg5gC10tZz3E2Ih4NK4Iosc0A6GEqqxgQQB7ERZ2qx8cx9BoTLSjrbkygqN/45yXyGUN8oj200KbpHdgoXBfzIspnl3QZD9bXZ0rkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=pnkZFVIZ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=hOLQ5DNBslqKcP2P0bqf6nLCFB2CmCUnxKgsxc2Zg4o=;
	t=1711654569; x=1712086569; b=pnkZFVIZyJ2TujNDEb9SvZAIgM20GaX8xQNys3ymRxyCyn+
	ZGKaBV9CHMZPCaBlvxmpPmEZIlhUnNtRaewTja65NJzx7OqbsbSEAnQphhmsgGl0LFqiSBZFVpQUQ
	cK9aNiOkI5zH2882cK7l+DH1LcJoFXkHm3srOLVsRJTEH/V28h7se6AD+KQp6fCpuo7cE5z/w8pxX
	n8sK6H7h5DUnl723SjzPU3YD6m82MkTc6P9bH2rE1dUwpLlum8zFCRIMP1zGIRnwG9BoxvqvgT21/
	oBEQmSnCeAl++1Ue7j4aQ1FH7TcLG8wZWobr/Xdpb8dgkCuLTWLIkDip/4xUwosQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rpvXi-0004a7-Hq; Thu, 28 Mar 2024 20:36:06 +0100
Message-ID: <4dce7447-678d-4e60-b76e-b01988bd6515@leemhuis.info>
Date: Thu, 28 Mar 2024 20:36:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: Only one CPU active on Ultra 60 since ~4.8 (regression)
To: Nick Bowler <nbowler@draconx.ca>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
References: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
 <CADyTPEyAidGgBT3f1VJLHb3ouO-r1UyvFp1PcwXxy0NRG94sbw@mail.gmail.com>
 <1df92fec-7f57-5080-94ed-b149ed384280@leemhuis.info>
 <14dcd743-144a-9f7b-849c-0843d50e4c04@draconx.ca>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <14dcd743-144a-9f7b-849c-0843d50e4c04@draconx.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711654569;30692136;
X-HE-SMSGID: 1rpvXi-0004a7-Hq

[CCing Linus, in case I say something to his disliking]

On 22.03.24 05:57, Nick Bowler wrote:
> 
> Just a friendly reminder that this issue still happens on Linux 6.8 and
> reverting commit 9b2f753ec237 as indicated below is still sufficient to
> resolve the problem.

FWIW, that commit 9b2f753ec23710 ("sparc64: Fix cpu_possible_mask if
nr_cpus is set") is from v4.8. Reverting it after all that time might
easily lead to even bigger trouble. That's why it might be better to
handle this like a bug and not like a regression. At least unless we
find someone to judge how likely such an outcome is. But it seems nobody
really cared so far, so unless this mail makes someone act you might be
out of luck. :-/

I wish it was different, but in the end we (including the maintainers)
are all just volunteers here which you can only motivate or compel (up
to some point) to look into some issue, but can not force to do so.

Ciao, Thorsten

> On 2023-01-21 08:31, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
>> CCing the sparc maintainer. Also CCing the regression list, as it should
>> be in the loop for regressions:
>> https://docs.kernel.org/admin-guide/reporting-regressions.html
>>
>> The the mail address of the culprit's author bounces. There is another
>> Atish Patra still active; does anyone known if those two are the same
>> person?
>>
>> Anyway, that's it from my side.
> [...]
>> On 20.01.23 04:15, Nick Bowler wrote:
>>> Hi,
>>>
>>> I'm resending this report CC'd to linux-kernel as there was no response
>>> on the sparclinux list.
>>>
>>> I tried 6.2-rc4 and there is no change in behaviour.  Reverting the
>>> indicated commit still works to fix the problem.
>>>
>>> On 2022-07-12, Nick Bowler <nbowler@draconx.ca> wrote:
>>>> When using newer kernels on my Ultra 60 with dual 450MHz UltraSPARC-II
>>>> CPUs, I noticed that only CPU 0 comes up, while older kernels (including
>>>> 4.7) are working fine with both CPUs.
>>>>
>>>> I bisected the failure to this commit:
>>>>
>>>>   9b2f753ec23710aa32c0d837d2499db92fe9115b is the first bad commit
>>>>   commit 9b2f753ec23710aa32c0d837d2499db92fe9115b
>>>>   Author: Atish Patra <atish.patra@oracle.com>
>>>>   Date:   Thu Sep 15 14:54:40 2016 -0600
>>>>
>>>>       sparc64: Fix cpu_possible_mask if nr_cpus is set
>>>>
>>>> This is a small change that reverts very easily on top of 5.18: there is
>>>> just one trivial conflict.  Once reverted, both CPUs work again.
>>>>
>>>> Maybe this is related to the fact that the CPUs on this system are
>>>> numbered CPU0 and CPU2 (there is no CPU1)?
>>>>
>>>> Here is /proc/cpuinfo on a working kernel:
>>>>
>>>>     % cat /proc/cpuinfo
>>>>     cpu             : TI UltraSparc II  (BlackBird)
>>>>     fpu             : UltraSparc II integrated FPU
>>>>     pmu             : ultra12
>>>>     prom            : OBP 3.23.1 1999/07/16 12:08
>>>>     type            : sun4u
>>>>     ncpus probed    : 2
>>>>     ncpus active    : 2
>>>>     D$ parity tl1   : 0
>>>>     I$ parity tl1   : 0
>>>>     cpucaps         : flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
>>>>     Cpu0ClkTck      : 000000001ad31b4f
>>>>     Cpu2ClkTck      : 000000001ad31b4f
>>>>     MMU Type        : Spitfire
>>>>     MMU PGSZs       : 8K,64K,512K,4MB
>>>>     State:
>>>>     CPU0:           online
>>>>     CPU2:           online
>>>>
>>>> And on a broken kernel:
>>>>
>>>>     % cat /proc/cpuinfo
>>>>     cpu             : TI UltraSparc II  (BlackBird)
>>>>     fpu             : UltraSparc II integrated FPU
>>>>     pmu             : ultra12
>>>>     prom            : OBP 3.23.1 1999/07/16 12:08
>>>>     type            : sun4u
>>>>     ncpus probed    : 2
>>>>     ncpus active    : 1
>>>>     D$ parity tl1   : 0
>>>>     I$ parity tl1   : 0
>>>>     cpucaps         : flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
>>>>     Cpu0ClkTck      : 000000001ad31861
>>>>     MMU Type        : Spitfire
>>>>     MMU PGSZs       : 8K,64K,512K,4MB
>>>>     State:
>>>>     CPU0:           online
>>>>
>>>> Let me know if you need any more info.
>>>>
>>>> Thanks,
>>>>   Nick
> 
> 

