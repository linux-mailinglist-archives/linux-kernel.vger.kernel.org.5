Return-Path: <linux-kernel+bounces-138676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3D389F8EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F60F282978
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056F315EFA2;
	Wed, 10 Apr 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="btbuZhxl"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113715FA69;
	Wed, 10 Apr 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756937; cv=none; b=eEmbSjNGZYJgXfkJ4awDWixBPzD6ijLKmVp21EcM2rb2+zEDXmcT1qUtKLlwkIYid1R2KFpjYL+9WpKJ0vqYbHkX1Dx+mcAET6Tjev8l2gapr+a0VZH48kMVGEPdmfGEKPM/Z5Z3hQwAh/pGmVEGb/C7XeZfX2LCb1L1hoozEUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756937; c=relaxed/simple;
	bh=j3k7QtlsNGkS+FgJ0seXVjN2gxtdMT3AKPuFn//PK2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNwBYn36Phc52KRQphad1uCjwrKQKKTPH5vmJtUKfP0IQ55VqOujaN1B0hIR1In8zQJf9rh8oPZgHmPw+43865C+MnfOoxsEW7CjGfAF/xql+jTRGCiFPjMUXg/w18lEbdhVJv4+/Z1PqbVB/us168GaPglbcODq4f3eazHuCiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=btbuZhxl; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=M9rtTnalSzs19ZdjaxE7elEoT3FcFxEIU/CaWWWeAuA=; t=1712756935;
	x=1713188935; b=btbuZhxl3qwOnt+9zyNpXL1KY82BvNzZxaoBlD7rxgZHPzdzBSQ4DGlSJ8vJ0
	zdleZar4lhmQpjZL6azjW7EFFN0L1TjYfVxURxtS3xpXijbwZ+Gih47IIFm6kam6hVIljV5e0XgHV
	RI1BXT1aEFeHNDPOkqSfL63s9b3smLkk8wtT2Xtu/SKi1p+0UG37rSQ75vMpy1P3kl0ktyNTMEyPU
	vgv3vnQMPgAyA0QCPrrf2gPuIVSdk4Bdc4rgJsCrbTHDYJuWXjWTVirWhqjgRltHOdFUQf0G1ELDY
	o+0JkdqFKSWziEFX9dB13Bzn+hXha/W0jD5LkwI936a6cxVIoQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ruYJo-0005QY-EK; Wed, 10 Apr 2024 15:48:52 +0200
Message-ID: <b9e54d33-7f5e-45a5-b215-d3f9daef5a8e@leemhuis.info>
Date: Wed, 10 Apr 2024 15:48:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call Trace when adding vCPU to guest
To: Thomas Gleixner <tglx@linutronix.de>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, xiangfeix.ma@intel.com
References: <b4929457-23b8-4ad4-8324-cc1cde5ecece@leemhuis.info>
 <87bk6h49tq.ffs@tglx>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <87bk6h49tq.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712756935;b56007dc;
X-HE-SMSGID: 1ruYJo-0005QY-EK

On 10.04.24 15:38, Thomas Gleixner wrote:
> On Wed, Apr 10 2024 at 09:34, Linux regression tracking (Thorsten Leemhuis) wrote:
>> To quote from https://bugzilla.kernel.org/show_bug.cgi?id=218698
> [...]
>>>
>>> When hot adding a vCPU to the guest, the guest happens Call Trace and reboot.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=a9025cd1c673a8d6eefc79d911075b8b452eba8f
> 
> It'll be in rc4

Ahh, splendid, thx for replying! Ciao, Thorsten

#regzbot fix: a9025cd1c673a8d6eefc79d911075b8b452eb

