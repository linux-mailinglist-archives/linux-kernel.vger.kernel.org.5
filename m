Return-Path: <linux-kernel+bounces-95168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277D4874A33
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E0E1F25DAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3258839ED;
	Thu,  7 Mar 2024 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="m6hTmrSX"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE25682D66;
	Thu,  7 Mar 2024 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709801823; cv=none; b=OX2x5cF79Us5Cs/z/c+m5fEJDC/o6ZDl3lGeIVskzXbBdRqvf6GFOZa+hdel8oZC8twsUzDPFz/dNRfEaKRA9EfNhnQxCWvvahQTZ7upLAHzvB4jT+TVbx450nDhSlvU9VyE9giIu4U92w0q/p/sp4IvSYTJRrN10yASudFq7YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709801823; c=relaxed/simple;
	bh=2Why6ASryWefTeocwYtFuP6wrGLxahOJQ9wXxsf8FuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgrCwBWwQuvEuszxDSqQ9ZnJMHTyF27EBBdtmLWkW/enmll0SFYEk84dCwN3beVO5CXdZP2ENJ8mqtsbqe0YwrB147gTDsfEeEW9o6Znby/tjSgAsQaYIc07+MtIwrI2RXEnGXGJPy7uJ1oaoJrDPmr+lr6pseCbPl/T5XWTgk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=m6hTmrSX; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=pbTln/+BFFiNFZUa3+2kviLssti+B6ZMA9ZszG0nGPY=;
	t=1709801820; x=1710233820; b=m6hTmrSX0cyxzAph1Wzc54rRygBgdG56ct8DtT9lVDNPTQ1
	uqVFgJNd/ybAYducxExeiJ2pKJYVQ3Ix5cnDwxBoPbhxyCGVldbV7oVeO2HUhNfDg6JeX5nIzmnAl
	SRIU31RCOGg1PIPVRHOiSatBY2luu5+xqfb9NUIgIPzdGY/tcGWpefUBTXvoZO0N/7TKO7fP1uK/+
	HFAy0BQB3MaOUBD/ET/b8Yq/rsPwtapE59YVAYQqUaxUeldN3s31UW+2nZtK6A7hpX0Yil9IiSoqR
	jaqY5OKbsS8LDN6TmLtgqj8NwlIK5Bgy9AJ0AcpSNLvGeQXzi2T4vLj0DPrVGU9Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ri9YW-0000vH-An; Thu, 07 Mar 2024 09:56:48 +0100
Message-ID: <feba810d-1391-475e-9b56-fbb6c52912a0@leemhuis.info>
Date: Thu, 7 Mar 2024 09:56:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] docs: verify/bisect: fixes, finetuning, and support
 for Arch
Content-Language: en-US, de-DE
To: Bagas Sanjaya <bagasdotme@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?=
 <petr@tesarici.cz>
References: <6592c9ef4244faa484b4113f088dbc1beca61015.1709716794.git.linux@leemhuis.info>
 <ZehvJv3fDZIPs9Kc@archie.me>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZehvJv3fDZIPs9Kc@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709801820;f34de042;
X-HE-SMSGID: 1ri9YW-0000vH-An

On 06.03.24 14:27, Bagas Sanjaya wrote:
> On Wed, Mar 06, 2024 at 10:21:12AM +0100, Thorsten Leemhuis wrote:
>> diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
>> index 54bde8bac95c67..58211840ac6ffb 100644
>> --- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
>> +++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
>> @@ -192,8 +192,8 @@ will be considered the 'good' release and used to prepare the .config file.
>>  
>>         sudo rm -rf /lib/modules/6.0-rc1-local-gcafec0cacaca0
>>         sudo kernel-install -v remove 6.0-rc1-local-gcafec0cacaca0
>> -       # * Note, if kernel-install is missing, you will have to
>> -       #   manually remove the kernel image and related files.
>> +       # * Note, on some distributions kernel-install is missing
>> +       #   or does only part of the job.
> 
> Consult documentation of your distribution for how to manually install/remove
> the kernel.

That would sent the wrong message in the TLDR, as the step-by-step guide
and the reference section would be the first place to look for details,
which is kinda implicit for a TLDR.

That being said: that made me look closer at the install section of the
guide and the reference section. I think they should mention "consult
documentation of your distribution" more clearly. I just looked into
this, but that requires a few bigger changes, so I'll take care of that
in a later patch I hope to send in the next few days.

>>  Install build requirements
>>  --------------------------
>> @@ -1076,72 +1078,103 @@ about to build.
>>  Here are a few examples what you typically need on some mainstream
>>  distributions:
>>  
>> +* Arch Linux and derivatives::
>> +
>> +    sudo pacman --needed -S bc binutils bison flex gcc git kmod libelf openssl \
>> +      pahole perl zlib ncurses qt6-base
>> +
>>  * Debian, Ubuntu, and derivatives::
>>  
>> -    sudo apt install bc binutils bison dwarves flex gcc git make openssl \
>> -      pahole perl-base libssl-dev libelf-dev
>> +    sudo apt install bc binutils bison dwarves flex gcc git kmod libelf-dev \
>> +      libssl-dev make openssl pahole perl-base pkg-config zlib1g-dev \
>> +      libncurses-dev qt6-base-dev g++
>>  
>>  * Fedora and derivatives::
>>  
>> -    sudo dnf install binutils /usr/include/{libelf.h,openssl/pkcs7.h} \
>> -      /usr/bin/{bc,bison,flex,gcc,git,openssl,make,perl,pahole}
>> +    sudo dnf install binutils \
>> +      /usr/bin/{bc,bison,flex,gcc,git,openssl,make,perl,pahole,rpmbuild} \
>> +      /usr/include/{libelf.h,openssl/pkcs7.h,zlib.h,ncurses.h,qt6/QtGui/QAction}
> 
> IMO qt packages are for people who wish to do xconfig instead of menuconfig
> or nconfig.

Well, yes, that's why the patch also added a few lines to point this out
and mention that installing the qt dev headers is optional. Guess you
just missed that.

Ciao, Thorsten

