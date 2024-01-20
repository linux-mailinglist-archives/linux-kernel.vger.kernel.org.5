Return-Path: <linux-kernel+bounces-31891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B04A8335FE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F95282E8A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5CB125CB;
	Sat, 20 Jan 2024 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kxk2srN2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="kxk2srN2"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75311EEC6;
	Sat, 20 Jan 2024 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705779523; cv=none; b=unU9y+QYv6c5W/IjuMsDKZQSI7s3laP2DIHuwYsR5XAnFihqWsnJHx3b8AkZmBPoO/I6Pcu5rPni7vM+ybS+5GoSSt4sNTcktPw+fgDYoOjLYJ6JNjuFFGXTEicnFJwGl1TbYxAMBc4t7DvOJZR+HFswZJ2gKrdrpHMBr+sqShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705779523; c=relaxed/simple;
	bh=Glqkwv3q8GwLXQGmGGRK+p0yakPQ8395MrBQ5xCoCJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V65nVNEe+7YtZCRCbalQRHWLU1Fo98m8GaG23Q8n+3CTQgDZC49kWexTBE6ynL61+z/TGdeaWVaCjoH/bsEnn1jnmRXO0V8AQBWWzV0kcPWPUuIoHLxHbM+rfSEUl4gkhG9uJmJLA2yhdQbT61Mu4SiTQZjkv51bwVowvG6p3Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=kxk2srN2; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=kxk2srN2; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705779521;
	bh=Glqkwv3q8GwLXQGmGGRK+p0yakPQ8395MrBQ5xCoCJ0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=kxk2srN2ULOCvbO3v95B+glsvWMcPl3KmJuGgdP3F8sI1DgBMkcPLOixuUpldIjH8
	 JjPHF6vpWMGbs33Z8wooCOHRITI/peI1DJPCX2gbhi9huiMv5r26pXdjulAFTvMDA+
	 cFc1MKXm5RjK1UqTviyMNkIF5Pzpkff4krKaWYdE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id B78EB12801D1;
	Sat, 20 Jan 2024 14:38:41 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Pe8n24VlXPtG; Sat, 20 Jan 2024 14:38:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705779521;
	bh=Glqkwv3q8GwLXQGmGGRK+p0yakPQ8395MrBQ5xCoCJ0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=kxk2srN2ULOCvbO3v95B+glsvWMcPl3KmJuGgdP3F8sI1DgBMkcPLOixuUpldIjH8
	 JjPHF6vpWMGbs33Z8wooCOHRITI/peI1DJPCX2gbhi9huiMv5r26pXdjulAFTvMDA+
	 cFc1MKXm5RjK1UqTviyMNkIF5Pzpkff4krKaWYdE=
Received: from [192.168.2.247] (unknown [204.148.121.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 12F0B1280599;
	Sat, 20 Jan 2024 14:38:40 -0500 (EST)
Message-ID: <b7da1112d9adc36722b8509314a7746f6f05764e.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.7+ merge window
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi
	 <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Date: Sat, 20 Jan 2024 14:38:39 -0500
In-Reply-To: <CAHk-=wi03SZ4Yn9FRRsxnMv1ED5Qw25Bk9-+ofZVMYEDarHtHQ@mail.gmail.com>
References: 
	<d2ce7bc75cadd3d39858c02f7f6f0b4286e6319b.camel@HansenPartnership.com>
	 <CAHk-=wi8-9BCn+KxwtwrZ0g=Xpjin_D3p8ZYoT+4n2hvNeCh+w@mail.gmail.com>
	 <7b104abd42691c3e3720ca6667f5e52d75ab6a92.camel@HansenPartnership.com>
	 <CAHk-=wi03SZ4Yn9FRRsxnMv1ED5Qw25Bk9-+ofZVMYEDarHtHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-01-20 at 11:35 -0800, Linus Torvalds wrote:
> On Sat, 20 Jan 2024 at 11:09, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > It also seems that this magic option combination works better (just
> > tried it on an old laptop that had my expired keys)
> > 
> > gpg --auto-key-locate clear,dane --locate-external-key
> > james.bottomley@hansenpartnership.com
> 
> So now I have a new subkey.
> 
> However, I note that you really do not seem to have gotten the
> message:
> 
>   sub   nistp256 2018-01-23 [S] [expires: 2026-01-16]
>         E76040DB76CA3D176708F9AAE742C94CEE98AC85
> 
> WTF? What happened to "stop doing these idiotic short expirations"?

I can't extend the expiration longer than that of my main key
(apparently I created it in 2011 with a 25 year expiration ... that
seemed like infinity at the time, right).   I think I can also extend
it but that's more of a virtuoso gpg manoeuvre, so I thought I wouldn't
try that in case it failed spectacularly and you were less than patient
..

James


