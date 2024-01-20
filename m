Return-Path: <linux-kernel+bounces-31875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C72658335C6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5206EB21CF2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF4010940;
	Sat, 20 Jan 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UZCPW6UW";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UZCPW6UW"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D405638E;
	Sat, 20 Jan 2024 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705777774; cv=none; b=fkoxXKddEEVW0wboDbQRiwt5QYcznUxt3L3pkUKvtE1RzprPhWsRTYFQ+a8d9UzaNPnlO8GIZEBGnNnwoDeK/Uly1BMYHODlnaGZdNtVVLS3uPWftSKUIJwIvAsL8GUpIWH9EIFS5NK66a5pxGgfzhATqqNHC1Mf7+p0pcXhfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705777774; c=relaxed/simple;
	bh=s7wFiZD6E5tJ/1g6tszfUH13rKB9H0XEvV1JkDjHXZU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TB4Icjio4xl030ai7JdqPFlyaa7ySYb7cl9vppotDDVmrKSa2huo9nwhVRM/D2tXyAgUec9y6PxKRe+h1psj5UBX+Vqd33md6x5kIibJbJct01mMaHm3jspkaQW2TgjVD5QhyegVy5aUI1bZtQIzE2HkTX2cQQe2Uo/gFWRBKHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UZCPW6UW; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UZCPW6UW; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705777770;
	bh=s7wFiZD6E5tJ/1g6tszfUH13rKB9H0XEvV1JkDjHXZU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=UZCPW6UWDLaKrlHjJ4728VYiPfJoJnrcchrJRM9HwZVRC6FgoATW94N9Z324fj7JN
	 Htbr7mHuIRvmxUkTt4I2OhSSHeZa9qAMv9Dphj+qrG2+E8YlMPptbWzs0L95PR8jKK
	 OQlznhLzLSOpvuH1ppu1fYYGnFXKRSV2ts9zb884=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id E3BAD1286462;
	Sat, 20 Jan 2024 14:09:30 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id VVxAY1k8rzoF; Sat, 20 Jan 2024 14:09:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705777770;
	bh=s7wFiZD6E5tJ/1g6tszfUH13rKB9H0XEvV1JkDjHXZU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=UZCPW6UWDLaKrlHjJ4728VYiPfJoJnrcchrJRM9HwZVRC6FgoATW94N9Z324fj7JN
	 Htbr7mHuIRvmxUkTt4I2OhSSHeZa9qAMv9Dphj+qrG2+E8YlMPptbWzs0L95PR8jKK
	 OQlznhLzLSOpvuH1ppu1fYYGnFXKRSV2ts9zb884=
Received: from [192.168.2.247] (unknown [204.148.121.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 319A21280773;
	Sat, 20 Jan 2024 14:09:30 -0500 (EST)
Message-ID: <7b104abd42691c3e3720ca6667f5e52d75ab6a92.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] final round of SCSI updates for the 6.7+ merge window
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi
	 <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Date: Sat, 20 Jan 2024 14:09:28 -0500
In-Reply-To: <CAHk-=wi8-9BCn+KxwtwrZ0g=Xpjin_D3p8ZYoT+4n2hvNeCh+w@mail.gmail.com>
References: 
	<d2ce7bc75cadd3d39858c02f7f6f0b4286e6319b.camel@HansenPartnership.com>
	 <CAHk-=wi8-9BCn+KxwtwrZ0g=Xpjin_D3p8ZYoT+4n2hvNeCh+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 2024-01-20 at 09:52 -0800, Linus Torvalds wrote:
> On Sat, 20 Jan 2024 at 07:26, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > As requested, I did a longer extension of my gpg keys, so my key
> > needs
> > refreshing, before you pull, to fix the expiry date.  You can get
> > my
> > updates via DANE using:
> > 
> > gpg --auto-key-locate dane --recv
> > D5606E73C8B46271BEAD9ADF814AE47C214854D6
> 
> No I can't.

So this one looks to be a DNS issue.  The secondaries on infradead.org
hadn't picked up the update (they were still showing old serial numbers
for the domain).  I've force pushed an update (and verified the new
serial) so if you have the patience to retry, it should work now
(fingers crossed).

It also seems that this magic option combination works better (just
tried it on an old laptop that had my expired keys)

gpg --auto-key-locate clear,dane --locate-external-key james.bottomley@hansenpartnership.com

James


