Return-Path: <linux-kernel+bounces-167286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9298BA72D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82C6281FC9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5829514659D;
	Fri,  3 May 2024 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="NJAnpq4B"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98574848D;
	Fri,  3 May 2024 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714718400; cv=none; b=j8i5LHj5h5Z5U3eLCsIvuEYPqqSKVO4usec9uwdzIJ+/rRe05ajDh4eurKN5BLWsZAs0GEEzVdKLfzI2AsZ9olQLw/BashPdjnp1OlJOiQPFnGLw59UsSCNrB8BUxok+Qaq2gHP8dor2BlqqzRXUlzE0t+RTT3BbtH5zWUcRAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714718400; c=relaxed/simple;
	bh=qo6gNNSP/j6kpY7IcyU/qgjiBE3W7wIKyPUWxhxHQMM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=k8y29M12sIE11cd8XFCdSXvJw0Loycr4IJ5nJvb1BdYO8V4qJczh94wZ3Y9TED7XexNIJ257KSzfSNZGgV4dMSMzCoNPysNTmpIaHX7kadGedjaPFlPcYZiIwseYak+jxb3UO04cXCYOqfEHLLvRusF8dp84sr5Uo4BoJb0sjyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=NJAnpq4B; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Reply-To:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=7zeNTz9dZI8LnTBatn2bq2v7BK5j7Weg7XVPNxsiLDY=;
	t=1714718398; x=1715150398; b=NJAnpq4B1bewI3YJelHuwEV9QLPjvu03d1It33hpGYLBcCP
	OB1SqFG7MfSffK7ZkFICBKsJtmJlNcIwdUL1o6gO/VcBN223Z3cZmsM7gmYVFYdxTDNMR1bgoFx7c
	TcZ++0ZAa8aCL4uHg3tPhIJU/Xtw2Fs2VTIp0WRXcBUuEz0wSKuHlmMeKw+sgPpnKihAtrZgQxQ2a
	p3VYOZl7FXwAFOumB7N7qfOwxjHqzJ+tL+rRBT1BeskWWNi4igfWqCTkgmqAsTSRquesFlu2FYl1w
	QTF/E7j2XJVeTkpoXTg1xkBOA1IWRwsTSdbKcBUEfXuaHvSZazzpj3Lajk8nDAiA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s2lwZ-0004pK-RV; Fri, 03 May 2024 07:58:51 +0200
Message-ID: <82fde49f-5dc8-47de-b220-83f9d7555485@leemhuis.info>
Date: Fri, 3 May 2024 07:58:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] Tri-band AMD RZ608 (MediaTek MT7921K) has 6GHz band
 disabled in kernel 6.8 despite working in <=6.6
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <e17e5bf2-657a-4a22-a925-94db95fe8ca1@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <e17e5bf2-657a-4a22-a925-94db95fe8ca1@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714718398;42eb24cc;
X-HE-SMSGID: 1s2lwZ-0004pK-RV

On 18.04.24 10:48, Linux regression tracking (Thorsten Leemhuis) wrote:
>
> mt7921 maintainers, I noticed a report about a regression in
> bugzilla.kernel.org related to your driver. As many (most?) kernel
> developers don't keep an eye on bugzilla, I decided to write this mail.
> To quote from https://bugzilla.kernel.org/show_bug.cgi?id=218731 :

FWIW, the reporter meanwhile confirmed that this happens with 6.9-rc6.
No bisection so far

Mt7921 maintainers, so you have any idea what might be wrong? Or is this
a situation along the lines of "uhhps, we screwed up somewhere (hardware
detection, regulatory stuff, ...) and had to fix this, which leads to this".

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>> On kernel 6.6.27-1-lts, running `iw list` shows that 6GHz channels are supported:>
>> [...]
>> Similarly, discovering and connecting to 6GHz APs works fine.
>>
>> However, in recent kernel 6.8.5, running `iw list` shows that 6GHz channels are disabled:
>>
>> [...]
>>
>> And scanning or connecting to 6GHz APs does not work. 
>>
>> There's nothing in `dmesg` that differs between boots of the two kernels. On 6.8.5, 6GHz band doesn't work like it did on previous kernels. 
>>
>> I can provide more logs or help debug the issue if needed.
> 
> See the ticket for more details. Note, you have to use bugzilla to reach
> the reporter, as I sadly[1] can not CCed them in mails like this.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> [1] because bugzilla.kernel.org tells users upon registration their
> "email address will never be displayed to logged out users"
> 
> P.S.: let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
> 
> #regzbot introduced: v6.6..v6.8.5
> #regzbot title: wifi drivers: mt7921: 6GHz band stopped working
> #regzbot from: AlexDeLorenzo.dev
> #regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=218731
> #regzbot ignore-activity
> 
> 

