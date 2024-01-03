Return-Path: <linux-kernel+bounces-15425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D4F822BCE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2942B281459
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF49718EAA;
	Wed,  3 Jan 2024 11:06:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F518EA0;
	Wed,  3 Jan 2024 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rKz59-00048H-RT; Wed, 03 Jan 2024 12:06:43 +0100
Message-ID: <5c8eb9ed-8029-4e31-b957-083255b6616c@leemhuis.info>
Date: Wed, 3 Jan 2024 12:06:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Platforms supporting SGX fail to kexec due to
 96c6b8f212a ("memblock: report failures when memblock_can_resize is not set")
To: LKML Mailing List <linux-kernel@vger.kernel.org>,
 regressions@lists.linux.dev
References: <ZY4T7YxrJZCxhMxx@a4bf019067fa.jf.intel.com>
Content-Language: en-US, de-DE
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZY4T7YxrJZCxhMxx@a4bf019067fa.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1704280006;a8c67909;
X-HE-SMSGID: 1rKz59-00048H-RT

On 29.12.23 01:33, Ashok Raj wrote:
> 
> 96c6b8f212a ("memblock: report failures when memblock_can_resize is not set")
> 
> Causes kexec failure. Backing out this change, kexec succeeds. Symptom is
> it appears to hang, possibly hung at the panic. Although I have the
> earlyprintk enabled, I don't see any console messages when new kernel
> boots. 
> 
> Also tested turning off CONFIG_X86_SGX, the kernel with this commit
> included also kexec's fine.
> 
> Booting from warm/cold reset has no issues. Only kexec to new kernel with
> this change included and CONFIG_X86_SGX=y causes the kexec failure.
> 
> #regzbot introduced: 96c6b8f212a

Fix a typo and do a few other things while at it:

#regzbot introduced: e96c6b8f212a
#regzbot title: memblock: platforms supporting SGX fail to kexec
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

