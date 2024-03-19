Return-Path: <linux-kernel+bounces-107258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 894B387FA0F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E41B282A73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1417164CF7;
	Tue, 19 Mar 2024 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="m/M173BU"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1FA22339;
	Tue, 19 Mar 2024 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710837619; cv=none; b=T6M6tZ3Fe6SdRo9oWoQAKFSjz2RNZLN/Lm9uFKHhLLXWjH0hZbxjq2vUh/2ZLyHE/XeCQKsw7RU08FOCTllq5fFnpG0/EahPhHzTx6nhW3DAWXVYBoXhexRisf4mSdy5hbqn1xxzp8iuqcN8AhjOe2tcId40XwwJe56lmb08/xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710837619; c=relaxed/simple;
	bh=awU6bHfyFvME5sBPQIOIZlxiBWs4318LwwLhArgAyPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A/zOmJe9eEH1b5jklJ8M3BF5iWjBrdBrjlOdMmymbg0V4v0c8eXq6hAYYtZ4pmjayojoxib2aWUwbMmdRhBXSr2V0jM8LxE9by82qW8lPE9vSUlGPYncZhqLkJDuxOthuDcRBL/IWHGMOF3rF2LqZJUVKUcX60fVAnUg4aokGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=m/M173BU; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:
	From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=osWUnIlqD8Dt5t4BF7gk8jBXgg5fKeale1jkrNw0dMk=; t=1710837617;
	x=1711269617; b=m/M173BUwddvN7kpdyUNyosaXEKl5ilpVXeTJZLlCir3fCAXM3+ET2NRyJoAT
	Ve6SsZP6Ka/qGagMhuz+zKH3oFSoKl/m84x8D3fPjuRtBOhosFd7O9rjrzh27a2pzFuxPjzPlznkV
	QXJsAuAnF4ry7ROSAvsTgpbL/GDW5vzSIkVBSbIzVk27AQob3Nsax0eAccp9zyUiNNw30I77KopDh
	3Rk/fRQ5GDaX4gnodWnlJZ+wVgkjs9a1gnyM1G9p9z6+JQplMRk6SWLvOAIFAyOcv2sORbkbXmH1y
	6ssqYIMBwaxfm6APGP9JBFhuR43DDXkt/NxASt5JiZxIJiKmBg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rmV0y-000611-V8; Tue, 19 Mar 2024 09:40:09 +0100
Message-ID: <be5a7213-78b3-4917-b95b-ec31cd2350e4@leemhuis.info>
Date: Tue, 19 Mar 2024 09:40:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] 6.8.1: fails to hibernate with
 pm_runtime_force_suspend+0x0/0x120 returns -16
Content-Language: en-US, de-DE
To: Martin Steigerwald <martin@lichtvoll.de>, linux-pm@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
References: <2325246.ElGaqSPkdT@lichtvoll.de>
 <12401263.O9o76ZdvQC@lichtvoll.de>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <12401263.O9o76ZdvQC@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710837617;2b3652af;
X-HE-SMSGID: 1rmV0y-000611-V8

On 16.03.24 17:12, Martin Steigerwald wrote:
> Martin Steigerwald - 16.03.24, 17:02:44 CET:
>> ThinkPad T14 AMD Gen 1 fails to hibernate with self-compiled 6.8.1.
>> Hibernation works correctly with self-compiled 6.7.9.
> 
> Apparently 6.8.1 does not even reboot correctly anymore. runit on Devuan.
> It says it is doing the system reboot but then nothing happens.
> 
> As for hibernation the kernel cancels the attempt and returns back to
> user space desktop session.
> 
>> Trying to use "no_console_suspend" to debug next. Will not do bisect
>> between major kernel releases on a production machine.

FWIW, without a bisection I guess no developer will take a closer look
(but I might be wrong and you lucky here!), as any change in those
hundreds of drivers used on that machine can possibly lead to problems
like yours. So without a bisection we are likely stuck here, unless
someone else runs into the same problem and bisects or fixes it. Sorry,
but that's just how it is.

> [...]

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.


