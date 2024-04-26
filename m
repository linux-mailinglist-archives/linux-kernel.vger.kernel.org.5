Return-Path: <linux-kernel+bounces-160377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E156D8B3CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E42C1C222F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FEF13D2AC;
	Fri, 26 Apr 2024 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Qip71L1C"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB43469D;
	Fri, 26 Apr 2024 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149087; cv=none; b=QacFyPiI6dFQz5XX9DaSS2RwRGiTEw9RJ4VbziV9Gkzrc/KWyCLiRBAckivQJs462i2VsX3S2oCu1qDmOZCA1cA7Djs1fOB4pLJyIGqAa+4WhNLfjnX3cE2tGQaqg/1/wba+pEClUYeciyI1jU0K1V7m8KnDGtWTHOtROeSXpg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149087; c=relaxed/simple;
	bh=7dZ7krTYAZxq8cPoPdHSIbY+K7yXIIJx3qWxQhJ/RRk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=HDeaKGWWM+6FKQfSBnILJSQM4g232iG90fbqndQ+LN+GR2rBbj/jtirYLRH4lvL2O6hwNB+AQcN5M+sDIK2mMn7dZk4yg7LMZRo4kEJFkYlv/Uryr+VNEk6AsqFFDGUgDHfOun2/+XLSPztyJj1rWNNO6gSDmVmhZXNdB1TTE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Qip71L1C; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4VQysF4BZqz681r;
	Fri, 26 Apr 2024 18:31:13 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4VQysD6C6Lz681M;
	Fri, 26 Apr 2024 18:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1714149073;
	bh=7dZ7krTYAZxq8cPoPdHSIbY+K7yXIIJx3qWxQhJ/RRk=;
	h=Date:From:Subject:To:References:In-Reply-To;
	b=Qip71L1CB2hsoOlwuKmcv17dZwZJcIodp8s9eiGLiE2SdJKEkPWTctJVORe6CHLyw
	 w1vgSpFi5Etpn/M8S373xPLJoB8krfHcRZKzkUxQEs9wK1YY2FZkFjRYS1WsI7YWxh
	 vepEI2N+D2i5R7QMzj66NgwXNxt6h05IqlTiooW4=
Message-ID: <7749e9f4-2540-4618-8689-b6bb757f9cd0@gaisler.com>
Date: Fri, 26 Apr 2024 18:31:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v2 00/28] sparc32: sunset sun4m and sun4d
To: Sam Ravnborg <sam@ravnborg.org>, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@kernel.org>, Helge Deller <deller@gmx.de>,
 Randy Dunlap <rdunlap@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kjetil Oftedal <oftedal@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org
References: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>
 <20240423180216.GA906720@ravnborg.org>
Content-Language: en-US
In-Reply-To: <20240423180216.GA906720@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-23 20:02, Sam Ravnborg wrote:
> Please let me know if you expect me to rebase this on for-next.
> I have not yet tried if there are merge conflicts but can take a look in
> a some days if required.

My local testing branch for this patchset rebased with trivial fixups,
so no immediate rebase and resubmission is needed. I do run into some
strange problems on SMP with this patchset plus your CAS patchset, that
I do not get when I rebase the Linux patches from our kernel release
that has my CAS patchset. With no CAS at all these things fails even
worse, so do I need one or the other for these tests.

I will need to dig deeper into figuring out the problems seems to be due
to something in any of your two patchsets in themselves or if it is
something else. I do need some additional fixes from our kernel release
for SMP to work properly, so it could also be that there is something
with my combination of your patches and my patches adapted on top of
yours.

There are also some needed fixes for LEON that relies upon code removed
in this patchset. Maybe the best solution for that would be if I submit
those and you then rebase upon them.

> That is assuming you agree with the sunset of the sun platforms...

I do agree with the idea in general, but being busy with other things I
have had little time to dig into this lately.

Thanks,
Andreas

