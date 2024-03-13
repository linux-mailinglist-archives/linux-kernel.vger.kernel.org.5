Return-Path: <linux-kernel+bounces-101466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 450ED87A77A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FB7284BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4351D405E6;
	Wed, 13 Mar 2024 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mydatex.cz header.i=@mydatex.cz header.b="rcarsqbj"
Received: from kali.sitour.cz (smtp.sitour.cz [77.48.244.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD13FB1D;
	Wed, 13 Mar 2024 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.48.244.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710332481; cv=none; b=Rxto2TTsTRvjsWHkmh+1doQZ5twkl8fhYlg3gJy09bNaeHe36IrQrqZ80caS/9v6rYe06GpwHJG+S9rHtJbm6hyV2eMOVl+gDPRHB/m52CXeGch98MU02BS084QkkGSKuPTfGe8/nSJdEXhoCeGUp8MfTn5Z7yUrKAauaNafT5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710332481; c=relaxed/simple;
	bh=VRMs3YlMGzWkFkHR+xos6IbFeYsSgHzgyvhxQygfLR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGlbug/VxuoOq0gier8PiKcBdyRThOX/h7yk/xgHBsFY2M4JOCMWRiJOMFhQvwSnUAClA67Ucgqm93v8L2eTyJY7gaOY2nsE4nvVIKJY8FoDtS+Ai2qF57JPXHis93KchY+BhfzVqelIpOxEkw01KCRKuzhG2EzUMS/KrpeggqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mydatex.cz; spf=pass smtp.mailfrom=mydatex.cz; dkim=pass (2048-bit key) header.d=mydatex.cz header.i=@mydatex.cz header.b=rcarsqbj; arc=none smtp.client-ip=77.48.244.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mydatex.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mydatex.cz
Received: from localhost (localhost [127.0.0.1])
	by kali.sitour.cz (Postfix) with ESMTP id 11A9F4E0278;
	Wed, 13 Mar 2024 13:21:15 +0100 (CET)
X-Virus-Scanned: Debian amavis at sitour.cz
Received: from kali.sitour.cz ([127.0.0.1])
 by localhost (sitour.cz [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hvwOGv36hJbW; Wed, 13 Mar 2024 13:21:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mydatex.cz; s=mydatex;
	t=1710332472; bh=VRMs3YlMGzWkFkHR+xos6IbFeYsSgHzgyvhxQygfLR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rcarsqbjFGnEeuI0dJPBVezMJYm5cDTgLMa5VJ9HRzoCMV3Y2c/BWyE9PR9siCvJx
	 dK9xP+XDYLpU1QO+ZDBB0wQO5a5a7VzoW95OXJ+1xqGdOXZUQfSqfXITAio8Mcl22d
	 Og19Z++wsipo2sLo/vo5YzxvYBi0okPv4eoV5sipkNeIYnaNEEmYrzU0AaieWuBVAm
	 gSLyYM7GsBE4r9aCG1fKgTT0t5s/uCZjxqjZkWbvA0un1tEw01fPA8WHxKy36JMNTD
	 2NgI+v+hE3y2fdWyug5ix8DJPu96cwf+5NOL9anZzY9rKx01ywBsMmdL/V67cwz8Ha
	 in8oU9Z/4FyeQ==
Received: from [192.168.3.13] (firma.mydatex.cz [84.242.99.246])
	by kali.sitour.cz (Postfix) with ESMTPSA id 5B7A64E0276;
	Wed, 13 Mar 2024 13:21:12 +0100 (CET)
Message-ID: <ccb4d341-fe9e-4920-8fd5-7467aadd2ea6@mydatex.cz>
Date: Wed, 13 Mar 2024 13:21:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regressions can bus with MCP2515 on sama5d3 connected over SPI
 stop working on kernel > 5.4.271
Content-Language: cs-CZ, en-US
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <2ede8f49-41f8-4d9a-83e4-ea5d4d1677fe@mydatex.cz>
 <a2e64be0-e07d-4c55-aba7-87c7e4c876e0@leemhuis.info>
 <734cf096-3769-4610-b72f-394c31a8d942@mydatex.cz>
 <91d8a6b6-6186-4aa0-8462-56b4751854e9@leemhuis.info>
 <6918321b-038d-40b9-8149-d535bf9d3d52@mydatex.cz>
 <5f69d6ee-a07a-42a9-a238-7dbe1f82cc3f@mydatex.cz>
 <3e46d70b-196d-45c7-bfdf-869c78cdc81f@leemhuis.info>
 <20240313-polio-jinx-bc5fd5df7c06-mkl@pengutronix.de>
 <b6c9b015-86bc-475b-a190-e35fa76c1ceb@mydatex.cz>
 <20240313-overload-eloquence-3e504ee0d00b-mkl@pengutronix.de>
From: Daniel Smolik <smolik@mydatex.cz>
In-Reply-To: <20240313-overload-eloquence-3e504ee0d00b-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hm,
that's what I was worried about.  Main problem is that I can't easy 
compile kernel around version 5.5 because that always failed with this:

   HOSTLD  scripts/dtc/dtc
/usr/bin/ld: scripts/dtc/dtc-parser.tab.o:(.bss+0x20): multiple 
definition of `yylloc'; scripts/dtc/dtc-lexer.lex.o:(.bss+0x0): first 
defined here
collect2: error: ld returned 1 exit status
make[1]: *** [scripts/Makefile.host:116: scripts/dtc/dtc] Error 1
make: *** [Makefile:1260: scripts_dtc] Error 2
make: *** Waiting for unfinished jobs....

I solve this problem  copying  whole scripts dir from 5.5.14 where this 
issue was solved.
After this  git reset --hard and after this   git bisect good | bad.

Prepare with this:

git clone -o mainline --no-checkout \
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  linux/
cd  linux/
git remote add -t master stable \
   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
git checkout --detach v5.4


git bisect start
git bisect good v5.4
git bisect bad v5.5

On each iteration I do git reset --hard and copy sctipt direcotry.

Regards
                 Dan



Dne 13. 03. 24 v 12:43 Marc Kleine-Budde napsal(a):
> On 13.03.2024 12:22:25, Daniel Smolik wrote:
>> this is my first bisection please be lenient :-) Threse is a result:
>>
>> marvin@marvin:/usr/src/linux$ git bisect good
>> Bisecting: 0 revisions left to test after this (roughly 0 steps)
>> [52f96cd135b160d44db4cb62a5b614b3bca20fbc] net: stmmac: xgmac: Remove
>> uneeded computation for RFA/RFD
> I think you still miss a bisection step.
>
> The commit 52f96cd135b1 ("net: stmmac: xgmac: Remove uneeded computation
> for RFA/RFD") is unrelated to CAN problem you described. It's in the
> stmmac Ethernet driver.
>
> Marc
>


