Return-Path: <linux-kernel+bounces-140065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 530388A0B07
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0794A1F22C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EF313FD80;
	Thu, 11 Apr 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="p0gASETd"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A41E86A;
	Thu, 11 Apr 2024 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823585; cv=none; b=fJQTfMzccSFvfQ5JMpYC6QBCDU6orlE/tJ7+jAKluKDd5C0fG9mKlMPV03MzoP4s8LvVHcECTmJ4Pwjq0zF8qN+oDhisiOsU57OkFOONAP667Xwsb6RMIa1J3JlExhKf4pVP4vuT2CeDrDBeKnvGW2//jaYArNt/vo4Zb0tphFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823585; c=relaxed/simple;
	bh=CM5IClqopNcJAcrNl8/qhU8tE/TWjfiY17ebMaV+c2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=a4pwGpKucydmmH7DprrXAQG8RCj14wDYu/LUDsavetK9zuy5ktz+osXiJQl96l3e7kS7Xx09JHI59plIB8HoE7u71378LSWla9VyPvIA9HxS4UYvV/mUgeefQXzMK8YDv+s7SH+rKNOPrWTgBXJIwMRNewOEFW7OBYt3rXxBoRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=p0gASETd; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=pV4wAKFJGjNV0VvjncX8Feh6Hp2U4aZAslaBjltzL/0=;
	t=1712823583; x=1713255583; b=p0gASETdxS8FcFvut5NunRXg3P91PsGtqX7H8YtRqfBYzHg
	0KAtrnOlk9K2z1ykugONP+NoB17S7pg46cdjJXgnLlOWnIxOZ4RksrWNb7bQ6a87ZedfT8WBdpmd+
	kPpOgYmf39TwCHXr+WEOX2ls4jVEVMcOu+0fyyDSRgAGRtmvHkb5Pt5d7HI03xBrgq1TYW5JOsh2h
	CHfbsPqjWtbVeFttdaFwCvUBO3y5W89GFMmV1SNJoI1/xR9xeFGi1cb/DC9EdJ8A+4obenFMiwfiA
	9R6mmCORBg1uEh4bV6pZdEZ7b6DeVTuJ9wvcEBRA/qhPIxs/96s85RTNd0lWC3DA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rupen-0005Ey-MB; Thu, 11 Apr 2024 10:19:41 +0200
Message-ID: <4e2ff80c-9e3f-433e-8783-cb9729c30bb2@leemhuis.info>
Date: Thu, 11 Apr 2024 10:19:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.8.5 does not boot (regression)
To: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>,
 Linux Kernel <linux-kernel@vger.kernel.org>
References: <3c6e6172-cf64-4230-bcc5-7682b4d64a8a@gmx.de>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US, de-DE
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, Ard Biesheuvel <ardb@kernel.org>
In-Reply-To: <3c6e6172-cf64-4230-bcc5-7682b4d64a8a@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712823583;730eabc9;
X-HE-SMSGID: 1rupen-0005Ey-MB

On 11.04.24 09:20, Toralf Förster wrote:
> It is a remote system, nothing in the logs, system is a hardened Gentoo
> Linux, 6.8.4 was fine.
> 
> Linux mr-fox 6.8.4 #4 SMP Thu Apr  4 22:10:47 UTC 2024 x86_64 AMD Ryzen
> 9 5950X 16-Core Processor AuthenticAMD GNU/Linux
> 
> Another Gentoo dev reported problems too.
> 
> config is below.

Thx for the report, but the harsh reality is: nearly no developer will
see your initial report, as you just sent it to LKML, which nearly
nobody ready. I CCed a few lists, which might help. But that is
unlikely, as this could be cause by all sorts of changes. Which is why
we likely need a bisection (
https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
) from somebody affected to make some progress here.

That being said: there are a few EFI changes in there that in a case
like this are a suspect. I CCed the developer, maybe something rings a bell.

Ciao, Thorsten

