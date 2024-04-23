Return-Path: <linux-kernel+bounces-155723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5B68AF634
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2F328F456
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61621411E0;
	Tue, 23 Apr 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="tiXjiwul";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="HfWeE/u/"
Received: from mailrelay3-1.pub.mailoutpod3-cph3.one.com (mailrelay3-1.pub.mailoutpod3-cph3.one.com [46.30.211.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6973D13E404
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895356; cv=none; b=AoxBh/BOmXYLemu1y2rAhq4UVCGxu5D3ei2xvLXSDhJoyv17YHmJsNaLxpu4n8hpmpXlrPe8uo4PlkKsQin7uWGA2utsynkxUplwSK0qtBnxTFDAWzuD6++fybMHYINEnPr18WsldzfzvnGIL9n+X2IrnuYnw4cT2mzXkMkoL6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895356; c=relaxed/simple;
	bh=mmtsBmibN1yGrAOOBOq7tt4DhIUx2MTlpkSj1eOKU5s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMypfB5gLAq/QHJYiy2r9qAqxY8JZqr6BzCFP0t/x/Fz1SyVJVnvq1/q1wtAbIcckrQYxCw8bSIIWKcZcF5M7lqpnKNJG/kQTb7ZXvDe3p48pl6e+0pv3svZzV2RV6W5+74hP4GEs2U66dUgNQ82hoOSiR5x77+E6QLPpwwtjh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=tiXjiwul; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=HfWeE/u/; arc=none smtp.client-ip=46.30.211.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:to:from:
	 date:from;
	bh=QCtZv2hKR4TC2H8Xchi6BYje0EdwUJ959Ulh1BBi7BU=;
	b=tiXjiwulObS5EhcPzBhcVI2b7lyYjbhyrN+eScXsvRPf4CNWM0mzep8evt/KlX081DuECo1DQzvk1
	 wh1MmubDWKPpi1oCcXnnTeTwWGiaHZvyWX54QHWQETldd7n02Dy7XeAZxJXbF62UeR4Y8ovwmTG2h/
	 zR7q3kIBfD44p/kz90excP2SMKqNX3fsDfoQhA9jSaZsFcdlhVIn9hXhLQ0zTkmC0yJhb1xUrfO8nr
	 97Y/6MTQX2EPS+R3oWPQM8B+4lRwr4FvsPIelDz4z87plAov9qBeXcBLWVtOs9U2guU+NGPpN8TE/F
	 JPgrGgj1BwmyI3XjPqR/8abBf7BSYHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:to:from:
	 date:from;
	bh=QCtZv2hKR4TC2H8Xchi6BYje0EdwUJ959Ulh1BBi7BU=;
	b=HfWeE/u/gBKw47N8oqIKQ7L5OJBjREBgJDf8mNUmiG3dJJPOazjw4Bgsd5yuaEF2d3z7H8kD48Zbl
	 QMi8vYgAQ==
X-HalOne-ID: 9dd17742-019b-11ef-8cb9-5166eb5bc2d3
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay3.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 9dd17742-019b-11ef-8cb9-5166eb5bc2d3;
	Tue, 23 Apr 2024 18:02:26 +0000 (UTC)
Date: Tue, 23 Apr 2024 20:02:16 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>, Helge Deller <deller@gmx.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Kjetil Oftedal <oftedal@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 00/28] sparc32: sunset sun4m and sun4d
Message-ID: <20240423180216.GA906720@ravnborg.org>
References: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>

Hi Andreas,

On Sat, Mar 09, 2024 at 07:15:21PM +0100, Sam Ravnborg via B4 Relay wrote:
> This is the second attempt to sunset sun4m and sun4d.
> See [1] for the inital attempt.
> 
> The sun4m and sun4d parts of the kernel have seen no real interest
> for several years now. Last time a few people surfaced, but it was
> either due to a personal project or for nostalgic reasons.
> It is time to let go and drop the parts of sparc32 that in reality
> are not in use.
> 
> LEON from Frontgrade Gaisler is the only real user of sparc32,
> and this patchset reduces sparc32 to what is required by LEON.
> 
> The defconfig is first adapted to the one used by Gaisler.
> Then the patches removes sun4m and sun4d specific
> implementations such as small drivers, SMP support, IRQ suppor etc.
> 
> Removing sun4m and sun4d support allowed removal of the run time
> patching of the code as well as a lot of assembler code.
> The result is a much cleaner assembler code that is easier to
> understand and thus maintain and extend.
> 
> Changes in v2:
>   - Rebased on top of Andreas' for-next branch
>   - Collected ack's
>   - Added patch to remove cpuid patching (Andreas)
>   - Run-time testing using qemu (Andreas, Mark Cave-Ayland)

Please let me know if you expect me to rebase this on for-next.
I have not yet tried if there are merge conflicts but can take a look in
a some days if required.

That is assuming you agree with the sunset of the sun platforms...

	Sam

