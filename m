Return-Path: <linux-kernel+bounces-147968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A74AA8A7BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA402842B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21FB52F8E;
	Wed, 17 Apr 2024 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="dF9BqFas"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268C063A9;
	Wed, 17 Apr 2024 05:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713332918; cv=none; b=WdwXpLignKd2EsUd0/6EejPDNUWYxE7XlLo/QXpvGecE0cBdXUAQL/3d5r0mFfSUo27brj5C5lilXMnXmFfIWN6+h+xhrRK/CU3eHATpITlR0T4ZBdR67Zx0K5ox92RWuZv9SuH0DOOPKDjjrVCVUJe3CgsFZJEvQAzB/YRqJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713332918; c=relaxed/simple;
	bh=Sm9q0EOoXp0q6ICHLJOVlGc/O9eyBrB7YL1yaQfmswM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8RX/jxeS69UTvUSuKKV2sG6OgtzCxXs9vy2o7RBOA+RqVXJiEsemYVrf6v5tQ3wy6rK2FVOjV91VU/tgaT5nEbU2ueDGspzMRRXaw0E5jpzqMz4LDBvMs0pnO47EisBjDqSR8QOOx2dqy65syUSZVlFelBu0RPon+vGX9aQWZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=dF9BqFas; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=VEpepBBKD5Nnnsgtm3zVY7Py62POG/xkrWi/8rs2xJM=;
	t=1713332916; x=1713764916; b=dF9BqFaswUMqYadA3DXzz3sDg9591+fXdvsvCYOFMB9BOd/
	3VTewGU0rBbbAWiFNvP9agidVg57Rx0RJyw2QhZKEavB5SwVdagtvgJzDZ6RjMaZtJ8c6D/cPzDN+
	cfZe7vDOEy/rM6flRzeUJHwW43M5Y8prE8GR8SPpzsGgBiK9d1acMtAFh5XWk+CqrJaI1rZKIiRA6
	geMlPEZ9q6Ox64asZo0z2CKcpbgvptDdZw7ytGYbNVxqDz5afWUHSswVWJjTVBXpI5o5kbnk27Kz/
	BDDdjGRG1yrvG4hVTl0ZEtYFP0RarBeI0z4HFjQDXuVXI7+ktCZt8X7wyfLSNd6Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rwy9p-0005nB-Jt; Wed, 17 Apr 2024 07:48:33 +0200
Message-ID: <51942e58-a5a3-4dcd-80c1-6735c7b5cc1e@leemhuis.info>
Date: Wed, 17 Apr 2024 07:48:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug 218665 - nohz_full=0 prevents kernel from booting
To: Tejun Heo <tj@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info>
 <enqg6mcuhvff7gujjbapdiclicl3z6f2vnggcsg65pexipyr3o@4men5fhyt3vb>
 <28c84b3b-f68f-4f45-8da1-9c3f9a342509@leemhuis.info>
 <7kugx5ivbplwwrcq5zp37djtpakl55b3pfy36gpbsbcx43dpcs@uheu6iv7gm7h>
 <81149f18-0132-4ace-8c71-1b75790a88e4@leemhuis.info>
 <Zh8H_vG2dQLOjoIB@slm.duckdns.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Zh8H_vG2dQLOjoIB@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713332916;8ec4cf79;
X-HE-SMSGID: 1rwy9p-0005nB-Jt

On 17.04.24 01:21, Tejun Heo wrote:
> On Tue, Apr 16, 2024 at 08:08:07AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 12.04.24 04:57, Bjorn Andersson wrote:
>>> On Wed, Apr 10, 2024 at 11:18:04AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> On 08.04.24 00:52, Bjorn Andersson wrote:
>>>>> On Tue, Apr 02, 2024 at 10:17:16AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>>>
>>>>>> Tejun, apparently it's cause by a change of yours.
>>>>>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218665 :
>>>>>>
>>>>>>> booting the current kernel (6.9.0-rc1, master/712e1425) on x86_64
>>>>>>> with nohz_full=0 cause a page fault and prevents the kernel from
>>>>>>> booting.
>>>>> [...]
>>
>> Tejun, I got a bit lost here. Can you help me out please?
>>
>> I'm currently assuming that these two reports have the same cause:
>> https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/T/#u
>> https://bugzilla.kernel.org/show_bug.cgi?id=218665
>>
>> And that both will be fixed by this patch from Oleg Nesterov:
>> https://lore.kernel.org/lkml/20240411143905.GA19288@redhat.com/
>>
>> But well, to me it looks like below issue from Bjorn is different, even
>> if it is caused by the same change -- nevertheless it looks like nobody
>> has looked into this since it was reported about two weeks ago. Or was
>> progress made and I just missed it?
> 
> Can you elaborate why Bjorn's case is different?

Well "not booting at all when using 'nohz_full=0'"[as reported two
times] and "I start neovim, send SIGSTOP (i.e. ^Z) to it, start another
neovim instance and upon sending SIGSTOP to that instance all of
userspace locks up - 100% reproducible."[while no 'nohz_full=0' in use]
at least on the first sight to and outsider sound a lot like different
problems to me -- but of course that impression might be wrong and you
know better about these things.

> I was assuming it was the
> same problem and that Oleg's fixes would address the issue.

Bjorn, could you give it a try?

Ciao, Thorsten

