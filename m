Return-Path: <linux-kernel+bounces-89724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A95A186F4BB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474771F21BDD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D3C126;
	Sun,  3 Mar 2024 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="K4+z7M4V"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95225BE4A;
	Sun,  3 Mar 2024 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709467980; cv=none; b=e3B7mu+UwZRF6rjllwIUOUjGbwvNRxDWWjnWqRPMR/8HAhMPD9rtgvoJIwsK6TA23IrgSfvTcHtesLTQQ4uuov2KdkMAsSu4oZp5MuREMXFtXctVHWaliRlG6DexmeMgWmAe5ojIje2fxlotvWJlRckaVLRxUe+ej7FB1ydeX5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709467980; c=relaxed/simple;
	bh=SBOPZsrdqZ/NNDMbOM0UYx3P98xhQulgQAGDn5mg7Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBHdYwZLAKomizScmcY6XS589WGpsp4zVVE/cpdmzR7rC6Dcl1pXmbBog8s0iYC34oMRwjHlknvfdACYeln5pH5W3MTIbTk6Rtf3xbLq/s0gibKC1irNzzvO8TWCyvA/CkjggZlkfU6AHUj7HLfo3MgqbogFQoioUk22HCX7d+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=K4+z7M4V; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=SBOPZsrdqZ/NNDMbOM0UYx3P98xhQulgQAGDn5mg7Zg=;
	t=1709467978; x=1709899978; b=K4+z7M4V7mynQwndJVgwr/opirGmmeGOgwchIZAQPIfklrZ
	kgVfUoOh2VP8w7/HZRxgbwPcVbB1883Kk4To3ppmTjjekPkiMwJtqhEqUrs4W0dXqAd1rH4o9CqwZ
	kZG/PyPQibsFjjlPdUTj08gBrxYmcfMGBx3OKhhScEwm8xf0GsNIKvZupSzwBA0+al/j8egd9WSg6
	rRRK8EzJeaFHpkZRQhWntfcmaUUwIJaFXeyppX1NY+UfEPERNV46oFzyBtKOAtaBN9aIn85GpHYRx
	gfegNs21eW/YddCe/OICU0QoyVfWuHg68dWFdIwnSZ3lHbatYgJVrnmgl+pPOZqg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rgkPH-0008Ly-3H; Sun, 03 Mar 2024 12:53:27 +0100
Message-ID: <78c14dd8-b655-4405-85e6-5c9530c77282@leemhuis.info>
Date: Sun, 3 Mar 2024 12:53:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Revert "scsi: ufs: core: Only suspend clock scaling
 if scaling down"
Content-Language: en-US, de-DE
To: Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
Cc: linux-scsi@vger.kernel.org
References: <20240228053421.19700-1-quic_rampraka@quicinc.com>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240228053421.19700-1-quic_rampraka@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709467978;bb23a397;
X-HE-SMSGID: 1rgkPH-0008Ly-3H

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 28.02.24 06:34, Ram Prakash Gupta wrote:
> This reverts commit 1d969731b87f122108c50a64acfdbaa63486296e.
> Approx 28% random perf IO degradation is observed by suspending clk
> scaling only when clks are scaled down. Concern for original fix was
> power consumption, which is already taken care by clk gating by putting
> the link into hibern8 state.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 1d969731b87f122108c50a64acfdbaa63486296e
#regzbot title scsi: ufs: core: approx 28% random perf IO degradation
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

