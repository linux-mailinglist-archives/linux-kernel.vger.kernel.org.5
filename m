Return-Path: <linux-kernel+bounces-101265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6A287A4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53D9282EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3BE224FA;
	Wed, 13 Mar 2024 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="lFfJfBl0"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C25210F8;
	Wed, 13 Mar 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321418; cv=none; b=V3HgkYgYhaTNQOn4Z/OPvwEL+N/ctILkoqMXdvAWqH2taGS37voHX2OArnsm031vja2Mx477eikieEdr1bIZfaiCg8qHO2fOgpqeDGxfqOFl4QabJ0FFrrbPlYHXN9zLWEDyBGpOH7rF6K877KCgrkZmgsFIxH1zsTQ6+aQYX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321418; c=relaxed/simple;
	bh=ByCbagcTebOW3qifvCBn2/PTAzLo4LTEj67iXwr3nrc=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:Cc:To:
	 In-Reply-To:Content-Type; b=qAnPrcpBi7VnOR5AghvOymmpSZ55hoZxNADrFejEs5KUS5Vhkmtfcw1axoAIpgZzWgW6WKwzGxNrRaDG02Kp5L7YIwDOuz+gUSmPPqMD3PxpXeR+et1hi6brepdbr6/m+V/tWZEQAeR3FcCmMHPnhYynuETiYTVUqf3tfDh1vHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=lFfJfBl0; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:To:Reply-To:Cc:From:References:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=QIi9/DjwhK5Nca9r9Q65/MotMONafCf0MSaMXkjEpqQ=;
	t=1710321415; x=1710753415; b=lFfJfBl0eMMtZLlb424xJS9UysEnuYdchXRGPUhpITSnP0e
	8jk2/NTZDF5qC+8yUKiBUIsAO110XGj8py8GVLSRuuEoxhH0vH8glXYnVpbnA6MfFv77IhvBeAJ8z
	u2NhyltYWhLiYADUHX0ip4+u7hMYWgUYYDO8Rvnv3mOGR05/XPuB2r9yME9yFrT10yPmpTDWhLYkG
	SlrTqrWmscSuxRbQ5cRtDcCSMDBhrBiiP8f7vori3s8wqepoXXrYPJw9pbyKCmMEbgi/m3l4CtBcl
	xZXkB2E8JQSkA0LYE2bCP6UobA9yXUE7uEiaudvYAKVqwhbXm4Ivo/hr9BXjLYEA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rkKjA-0004TW-0c; Wed, 13 Mar 2024 10:16:48 +0100
Message-ID: <3e46d70b-196d-45c7-bfdf-869c78cdc81f@leemhuis.info>
Date: Wed, 13 Mar 2024 10:16:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regressions can bus with MCP2515 on sama5d3 connected over SPI
 stop working on kernel > 5.4.271
Content-Language: en-US, de-DE
References: <2ede8f49-41f8-4d9a-83e4-ea5d4d1677fe@mydatex.cz>
 <a2e64be0-e07d-4c55-aba7-87c7e4c876e0@leemhuis.info>
 <734cf096-3769-4610-b72f-394c31a8d942@mydatex.cz>
 <91d8a6b6-6186-4aa0-8462-56b4751854e9@leemhuis.info>
 <6918321b-038d-40b9-8149-d535bf9d3d52@mydatex.cz>
 <5f69d6ee-a07a-42a9-a238-7dbe1f82cc3f@mydatex.cz>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Cc: Daniel Smolik <smolik@mydatex.cz>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
In-Reply-To: <5f69d6ee-a07a-42a9-a238-7dbe1f82cc3f@mydatex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710321415;f0b7d482;
X-HE-SMSGID: 1rkKjA-0004TW-0c

Hi! Mark and Manivannan, do you by chance have an idea what might be
wrong with Daniel's system or can point us in the direction of people
that might be able to help? See
https://lore.kernel.org/all/2ede8f49-41f8-4d9a-83e4-ea5d4d1677fe@mydatex.cz/
for the initial report (but it is in the quote below, too).

On 13.03.24 00:22, Daniel Smolik wrote:
> I am not very familiar with bisecting :-(  I have found how to solve
> another problem and compile 5.5.0 kernel. And now I know that latest
> working is 5.4.271 and first not working is 5.5.0.

Let's wait first if Mark and Manivannan might haven an idea. And in case
you in the end have to bisect: please follow the guide I pointed to and
tell me where you have the problem, as the guide (and an earlier mail,
too!) tells you that you need to bisect from 5.4 to 5.5.

Ciao, Thorsten

> Dne 12. 03. 24 v 20:57 Daniel Smolik napsal(a):
>> Hi ,
>> 6.8  is affected   with this bug.  I try bisect the bug.
>>
>> Regards
>>             Dan
>>
>> Dne 12. 03. 24 v 11:39 Linux regression tracking (Thorsten Leemhuis)
>> napsal(a):
>>> On 12.03.24 11:27, Dan Smolik wrote:
>>>> Dne 12. 03. 24 v 11:19 Linux regression tracking (Thorsten Leemhuis)
>>>> napsal(a):
>>>>> On 11.03.24 22:55, Daniel Smolik wrote:
>>>>>> I have found problem with kernel > 5.4.271 (long term) on sama5d3.
>>>>>> When
>>>>>> I config can bus with:
>>>>>>
>>>>>> ip link set can0 type can bitrate 125000 triple-sampling on
>>>>>>
>>>>>> and type
>>>>>> ifconfig can0 up
>>>>>>
>>>>>> prompt never returns and cannot run eg. ip a (never returns) existing
>>>>>> ssh connection works but can´t do new one.
>>>>>>
>>>>>>
>>>>>>     I have my own daughter  board with can bus driver MCP2515
>>>>>> connected
>>>>>> over SPI bus. There is
>>>>>> snippet of my DTB:
>>>>>>
>>>>>>    can0: can@0 {
>>>>>>                                           compatible =
>>>>>> "microchip,mcp2515";
>>>>>>                                           reg = <0>;
>>>>>>                                           clocks = <&can0_osc_fixed>;
>>>>>>                                           interrupt-parent = <&pioD>;
>>>>>>                                           interrupts = <29
>>>>>> IRQ_TYPE_EDGE_RISING>;
>>>>>> spi-max-frequency = <10000000>;
>>>>>>                                       };
>>>>>>
>>>>>> with this all working  perfect  on long term kernels 4.19.  I try
>>>>>> switch
>>>>>> to newer kernel and latest I get working is 5.4.271. Kernel 5.5.0
>>>>>> -5.5.6 I can´t  compile and 5.5.14  is affected with bug.
>>>>> The two important question here are:
>>>>>
>>>>> * Is mainline (e.g. 6.8) affected as well? That determines if the
>>>>> regular developers or the stable team has to look into this.
>>>> I mean yes,  I tested 6.6.21 and is affected.   6.8 I can test today
>>>> afternoon.
>>> Yes, please test 6.8.
>>>
>>>>> * Could you bisect the problem (e.g. I assume between 5.4.271 and
>>>>> 5.4.272)? I'm working on a guide that explains this:
>>>>> https://www.leemhuis.info/files/misc/How%20to%20bisect%20a%20Linux%20kernel%20regression%20%e2%80%94%20The%20Linux%20Kernel%20documentation.html
>>>> Yes I try this but it looks like that latest good is 5.4.271 and first
>>>> bad us 5.5.0  but this kernel fail when building to arm platform. 
>>>> First
>>>> which I build for arm is 5.5.14.
>>>>
>>>> I try bisecting but when I can't build kernel what can I do ?
>>> Bisect between 5.4 and 5.5 and during the bisection use "git cherry-pick
>>> --no-commit <sha1sum>" to apply the fix(es) without committing them
>>> before you build; once the build is ready, use "git reset --hard" to
>>> reset things.
>>>
>>> But please check 6.8 first; if it is affected we can CC a few
>>> developers. If you are lucky they have an idea what might be wrong here
>>> and then no bisection might be needed.
>>>
>>> Ciao, Thorsten
>>
>>
> 
> 
> 

