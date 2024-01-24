Return-Path: <linux-kernel+bounces-37468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED80483B081
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAEB1C2148F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8291812BF10;
	Wed, 24 Jan 2024 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="ivKBBJjR"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7C12BF05;
	Wed, 24 Jan 2024 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118689; cv=none; b=bGIHhIe1sNUnT8blep+maY+oTlucC8jrNFTDzPgC6EA2My8cvfsqwAWUGv1vOv2PcH76Ju6YqyuAwYlttep9rHSYNtD0KEh9cljmjecLVdEFXJphOxqxtlq/y2cp7Jkza500+y7Lsph4u4Ewk020D3dv9fYcR2y5mBorxkDanEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118689; c=relaxed/simple;
	bh=g/sT0ZEANu/3hTClYbuhcQsedyor1GAxRK6GqvanH2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3hbSV41bTHnlmvmKj6uPYwUhU3XEAoLnc52tfpxD7PXT6WTAPVrXLfXis9CRTsX/cYzKjG0JAYqW9m87Bpi+s91zOwTEHt0tPt1mgJKn7foFZFd+dIrnXNA0NREalhgG2Dh1WGK+QoA16BYZIywrK4m1F9E3lltm0UkWeswR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=ivKBBJjR; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=E6tlfXJaHpkSHmWMRyZbFYGYiDDsxY+9eqdCUY3ZKA8=; b=ivKBBJjRDz27qMiWctzt/M/PlA
	22Ypw0cTFROfDOzakN0aZD3OZCzxi5ETs1RvMgCM2ZVje7LNrH60byWD9jcnL7Z+De7YfkdTlbMN9
	SvzpTurHBh2iqZZBApKUcIqagTd2IxJnfeUap02H0HwzzRpVlN9u5fiphEsvsm3vZmMShNbzonyOc
	UyN5kgfcNxKJyzMhrD6f5z58iCRLU6ru3uCqcso68+6B+dVVQAJnI8FdKZVAet4wnrJsb4ADifrH0
	uFdpW5+yf9nu0IPu+Jl09qOHuE607eue+8Zrqr4jGXqoRcm9fSaFhJpzotjoTTRkyhSpQ6zQG1GZ7
	mbp/vgVw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rShPF-00EJwf-2f;
	Wed, 24 Jan 2024 11:51:21 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Cc: wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject:
 Re: [RFC PATCH 1/9] ntsync: Introduce the ntsync driver and character device.
Date: Wed, 24 Jan 2024 11:51:21 -0600
Message-ID: <2716075.mvXUDI8C0e@camazotz>
In-Reply-To: <bd3f6fcb-2239-4fd3-bb9a-c772bbce5a44@app.fastmail.com>
References:
 <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-2-zfigura@codeweavers.com>
 <bd3f6fcb-2239-4fd3-bb9a-c772bbce5a44@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 24 January 2024 01:38:52 CST Arnd Bergmann wrote:
> On Wed, Jan 24, 2024, at 01:40, Elizabeth Figura wrote:
> > ntsync uses a misc device as the simplest and least intrusive uAPI interface.
> >
> > Each file description on the device represents an isolated NT instance, intended
> > to correspond to a single NT virtual machine.
> >
> > Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> 
> I'm looking at the ioctl interface to ensure it's well-formed.
> 
> Your patches look ok from that perspective, but there are a
> few minor things I would check for consistency here:
> 
> > +
> > +static const struct file_operations ntsync_fops = {
> > +	.owner		= THIS_MODULE,
> > +	.open		= ntsync_char_open,
> > +	.release	= ntsync_char_release,
> > +	.unlocked_ioctl	= ntsync_char_ioctl,
> > +	.compat_ioctl	= ntsync_char_ioctl,
> > +	.llseek		= no_llseek,
> > +};
> 
> The .compat_ioctl pointer should point to compat_ptr_ioctl()
> since the actual ioctl commands all take pointers instead
> of interpreting the argument as a number.
> 
> On x86 and arm64 this won't make a difference as compat_ptr()
> is a nop.

Thanks; will fix.



