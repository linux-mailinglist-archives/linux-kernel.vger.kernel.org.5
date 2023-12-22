Return-Path: <linux-kernel+bounces-9843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB581CC46
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A51285AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3268F2377D;
	Fri, 22 Dec 2023 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="p2o87jp7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072C62374E;
	Fri, 22 Dec 2023 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4SxWPh4Sz5z6831;
	Fri, 22 Dec 2023 16:27:20 +0100 (CET)
Received: from [10.10.15.23] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4SxWPh0TQLz681j;
	Fri, 22 Dec 2023 16:27:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1703258840;
	bh=m7I+N7YglnnDAb5DtR+LUfwkg0HkRzNLUluJIF+uoPM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=p2o87jp784kPbSta4a1986Wv2iStA5gze7ttrCbLhC6KgxlYUjGY/PIwPQbTB9ZNQ
	 ngb13eNePXnFDkTX+E3eWmvLmTtffjg6qL12LR+Tw8vTHoaoELXiz+DYsKTMjm0GaZ
	 ef2LvbQI6FRWQtn12eZpRwvwz2kHJ3puvEPVLwdM=
Message-ID: <22f2a3af-0f61-4938-8546-d0308853b467@gaisler.com>
Date: Fri, 22 Dec 2023 16:27:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] sparc32: sunset sun4m and sun4d
Content-Language: en-US
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Sam Ravnborg <sam@ravnborg.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Arnd Bergmann <arnd@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Helge Deller <deller@gmx.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org
References: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
 <01ea8c41-88cd-4123-95c7-391640845fc3@app.fastmail.com>
 <e897e6d5a88ec2f9024c62f7bee5c13bfb2cab55.camel@physik.fu-berlin.de>
 <dbb60b13-565f-43b8-8cb8-6f8cd98b06df@app.fastmail.com>
 <3d733b57-884a-4755-a32a-74061b48e182@ilande.co.uk>
 <20231220152224.GA867968@ravnborg.org>
 <566d7867c746ac2a85f0fc42dd8e28eaffd45ed4.camel@physik.fu-berlin.de>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <566d7867c746ac2a85f0fc42dd8e28eaffd45ed4.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2023-12-20 18:25, John Paul Adrian Glaubitz wrote:
> Hi Sam,
> 
> On Wed, 2023-12-20 at 16:22 +0100, Sam Ravnborg wrote:
>>> The leon3_generic machine is maintained by different people so I'd suggest
>>> contacting them: see [1] for their contact details. I see there is an
>>> avocado boot test for the leon3_generic machine included within the QEMU
>>> source tree, but it uses a downloadable image of HelenOS rather than Linux.
>>
>> Thanks for the pointer, I will try to reach out to them when I have
>> something a bit more solid than "it does not work".
>>
>> I tried to hack around a little in qemu and I have an idea where things
>> goes wrong. The leon_generic assumes another address layout than what is
>> used by the kernel, so the very first jump to a kernel address fails.

The MKLINUXIMG second stage bootloader sets up MMU tables and the SPARC
OPENPROM interface for LEON systems, so you need to run the vmlinux
image through that. You can find it (and our other Linux related
releases) via https://gaisler.com/index.php/downloads/linux. The manual
is at https://www.gaisler.com/doc/mklinuximg.pdf and the latest release at
https://gaisler.com/anonftp/linux/linux-2.6/kernel/mklinuximg-2.0.15.tar.bz2

With a sparc-linux-gcc in the PATH (or using CROSS_COMPILE to point out
a toolchain stem) you can do:

mklinuximg vmlinux image.ram

and then run the resulting image.ram in e.g. QEMU 8.2.0 with

qemu-system-sparc -nographic -M leon3_generic -m 256 -kernel image.ram

This at least boots the kernel and let me log in when quickly testing a
few images with root filesystems in initramfs, admittedly with our
kernel patches in place.


> I would argue that before we start introducing larger changes to arch/sparc,
> we should settle the maintainership question first. Once we have an active
> maintainer again, we can have a more extended discussion about what to keep
> and how to name things.
I agree.

Cheers,
Andreas


