Return-Path: <linux-kernel+bounces-143658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB408A3C01
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5CAB218C9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C049638FA3;
	Sat, 13 Apr 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="hrdbw6qr"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47442C695;
	Sat, 13 Apr 2024 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713001586; cv=none; b=havcTmPNpDFj1zWbXuiBl7p8iWfWdhUI+l1ueG5VOJUSgOsER9NHPeNOWacVFyG/mjVj2U3t1K98D8fjodvrAUHP3xZtPYBCWxAW87vAdUFXtN8s/2FYPgyrXgaKoGLlxxzze+PJL3nmpJ6HDxUvB5rxqai4VZlowstszVAG3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713001586; c=relaxed/simple;
	bh=Ztmw7mAa84lxMDMSs6zmz7G2+daGprxOSPZXS2TG924=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjB0CP/hlCrHxaaWg+qs3FngdMS5LfMgFI8aIivns0EG4yHVnipPaasE9zjUGPYsVdoeN0bqcdGUBMc4/Oto5GFnglWeN5XsVXV5rW0Z/fId+JngQ4QJQIKxXAqHR2BG/2P234wu1aQOy2lp681k6LJjpxq/PA/xl/FApIKbyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=hrdbw6qr; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Ztmw7mAa84lxMDMSs6zmz7G2+daGprxOSPZXS2TG924=;
	t=1713001584; x=1713433584; b=hrdbw6qrKTu7OI7uxBDeaLHakS53exA7oSFiK+JjEM1Fq9N
	OW35y9h5Gp6BnJw+3SeEfSVSJonn1vj6M1hfEJEdZJCFwDYPrutRNMAhVom5VNJurdtw10zL2GH+6
	VqqXsHZGi7iycWwCswb2am6EjBkC+lriD4KicaS144Wy5vJYQaO3QPvyqP8mLSs5xI5a4A9Ac3iIs
	959noTFSBF50ex2F4cDWYUItekiCP6igE89SgjF7uS3m+d4js/17HqokYOYg7fYSjwqPTtmTSUH+F
	L7IDhnZzRUefaMzIisYUypWcYa1BeWu5qcrVv+ortLDfoM9JZtIascm39kjplJxw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rvZxa-0000fw-CN; Sat, 13 Apr 2024 11:46:10 +0200
Message-ID: <68e3503c-5573-4d82-8fb0-5b955c212d67@leemhuis.info>
Date: Sat, 13 Apr 2024 11:46:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bisected] Kernel v6.9-rc3 fails to boot on a Thinkpad T60 with
 MITIGATION_RETHUNK=y (regression from v6.8.5)
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Erhard Furtner <erhard_f@mailbox.org>, x86@kernel.org,
 Linux Regressions <regressions@lists.linux.dev>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 jpoimboe@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Breno Leitao <leitao@debian.org>
References: <20240413024956.488d474e@yea> <ZhpOIeVq1KQXzjBp@archie.me>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZhpOIeVq1KQXzjBp@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1713001584;7c34a78a;
X-HE-SMSGID: 1rvZxa-0000fw-CN

On 13.04.24 11:19, Bagas Sanjaya wrote:
> On Sat, Apr 13, 2024 at 02:49:56AM +0200, Erhard Furtner wrote:
>> Greetings!
>>
>> With MITIGATION_RETHUNK=y selected in kernel .config v6.9-rc3 fails to boot on my Thinkpad T60. The resulting kernel stalls booting at "x86/fpu: x87 FPU will use FXSAVE":
>> [...]
>> 4461438a8405e800f90e0e40409e5f3d07eed381 is the first bad commit

There was an earlier report about this here:
https://lore.kernel.org/all/78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com/

Boris there suggested: "perhaps we should make
CONFIG_MITIGATION_RETHUNK depend on !X86_32":
https://lore.kernel.org/all/20240403173059.GJZg2SUwS8MXw7CdwF@fat_crate.local/

But that did not happen afaics. Would it be wise to go down that path?

Ciao, Thorsten


