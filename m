Return-Path: <linux-kernel+bounces-101444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F4787A727
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5D31F22872
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788473F8FB;
	Wed, 13 Mar 2024 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mydatex.cz header.i=@mydatex.cz header.b="eoSrV7j8"
Received: from kali.sitour.cz (smtp.sitour.cz [77.48.244.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B223D3BE;
	Wed, 13 Mar 2024 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.48.244.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710329960; cv=none; b=o+0AcQwi6eb4osLwequQWPxYccp5UFFwvOAUTjN2Tw/zyRmmNMhq4lzYYXims/m6aCf8mKjqC8mCUHI3hjIdEhJDVZrV5QhFSLMwgQ8qoOFiDQRCmu/JgRnU3UX7P90SgB8IFRk5zdjG05bgzt8tRXCWsWFw4QD7NAblHp8ZM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710329960; c=relaxed/simple;
	bh=9ovafFScVtcbkEjyPonUN2CJTjm1kMv9ezENYlGgXfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CEP9fb0q94Rv0jM+cHCkyH9NZSyYCnn/UXvo3TloGk60itCbcSMpPRG9H6F4LHqIR9ijUvnVuGGBD4bUDziwuZNpHJEG3GXirfwIvXzbpyv07gXDrTh0tvP3zLKyQWSaCyMoeRltcNOmvTMCq6F6Q8KUMxt5+ewhhqz8ZsLgzJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mydatex.cz; spf=pass smtp.mailfrom=mydatex.cz; dkim=pass (2048-bit key) header.d=mydatex.cz header.i=@mydatex.cz header.b=eoSrV7j8; arc=none smtp.client-ip=77.48.244.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mydatex.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mydatex.cz
Received: from localhost (localhost [127.0.0.1])
	by kali.sitour.cz (Postfix) with ESMTP id 1221E4E0278;
	Wed, 13 Mar 2024 12:39:17 +0100 (CET)
X-Virus-Scanned: Debian amavis at sitour.cz
Received: from kali.sitour.cz ([127.0.0.1])
 by localhost (sitour.cz [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bu-wu_DxQ_yc; Wed, 13 Mar 2024 12:39:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mydatex.cz; s=mydatex;
	t=1710329954; bh=9ovafFScVtcbkEjyPonUN2CJTjm1kMv9ezENYlGgXfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eoSrV7j8FOthplpG1aUzEeP0f99doS5lN9cI5h4iYrq73t+r4DTrm+YOkv/6AUhOX
	 ORR3WUCxGRZFdNOeRxz0dCt3QJSNS9PnIjhA5cQ//PpXe6vs785lTKHnkWT55onQfP
	 4YA1r946U6X1k5P+KkQoPAgQuo4goA3TUCJrrj9k7KMoQ3JtRHcTkXnZ42sdP3ontS
	 ruTQW+swSdII5xncTZU1oFfOucBZQjabjU88XVbtljNrhpHzf73r5QjQN+JLmNO1Iq
	 J+Kr4r/ybOz+DP3WhQGVLfdbKk+0c7O9zWD36WRZ/qio1R0pG9dlN86km7kOWMXk9L
	 D4rZe5VU4AeMA==
Received: from [192.168.3.13] (firma.mydatex.cz [84.242.99.246])
	by kali.sitour.cz (Postfix) with ESMTPSA id 455494E0276;
	Wed, 13 Mar 2024 12:39:14 +0100 (CET)
Message-ID: <fccabbff-4a71-4498-934a-5f6b18b94dd2@mydatex.cz>
Date: Wed, 13 Mar 2024 12:39:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regressions can bus with MCP2515 on sama5d3 connected over SPI
 stop working on kernel > 5.4.271
Content-Language: cs-CZ
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
 <8086dce0-11d2-4bad-be47-e16bbc0800d9@leemhuis.info>
From: Daniel Smolik <smolik@mydatex.cz>
In-Reply-To: <8086dce0-11d2-4bad-be47-e16bbc0800d9@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


No, if you kick me little I do it:-)

git clone -o mainline --no-checkout \
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ~/linux/
cd ~/linux/
git remote add -t master stable \
   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
git checkout --detach v6.8

cd ~/linux/

git cherry-pick
--no-commit   52f96cd135b160d44db4cb62a5b614b3bca20fbc]

Is this right way ?

	Regards
			Dan






Dne 13. 03. 24 v 12:32 Linux regression tracking (Thorsten Leemhuis) 
napsal(a):
> On 13.03.24 12:22, Daniel Smolik wrote:
>> this is my first bisection please be lenient :-) Threse is a result:
>>
>> marvin@marvin:/usr/src/linux$ git bisect good
>> Bisecting: 0 revisions left to test after this (roughly 0 steps)
>> [52f96cd135b160d44db4cb62a5b614b3bca20fbc] net: stmmac: xgmac: Remove
>> uneeded computation for RFA/RFD
> Have you tried reverting that commit on-top of 5.5 and/or 6.8 to see if
> this fixes the problem, as advised by the bisection guide I mentioned?
>
> Ciao, Thorsten
>
>> Dne 13. 03. 24 v 11:35 Marc Kleine-Budde napsal(a):
>>
>>> On 13.03.2024 10:16:47, Linux regression tracking (Thorsten Leemhuis)
>>> wrote:
>>>> Hi! Mark and Manivannan, do you by chance have an idea what might be
>>>> wrong with Daniel's system or can point us in the direction of people
>>>> that might be able to help? See
>>>> https://lore.kernel.org/all/2ede8f49-41f8-4d9a-83e4-ea5d4d1677fe@mydatex.cz/
>>>> for the initial report (but it is in the quote below, too).
>>> At the first glance the mcp251x.c changes between v5.4 and v5.5 look
>>> unrelated.
>>>
>>> I try to find some time to setup bisecting on an imx6.
>>>
>>> Marc
>>>
>>
>>


