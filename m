Return-Path: <linux-kernel+bounces-29562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF183103F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035B21F26684
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C339528DA9;
	Wed, 17 Jan 2024 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="A6vHNlKu"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E2025620;
	Wed, 17 Jan 2024 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705535959; cv=none; b=XyxwKgJuy4YpWddjJ8BqNFMuAVSmW18NNNsKUJ5eRJKVAcJZSVxrXQxfzXZIRqSV7H0E6rdo+tFK1kYBW2WrubA0Yaz8i0+gh7HeLIpnOgV6/HujyEn2bCtvVF6Et68eUsQka3ZhmS/Ubof60RoO7htSIAMrkw5B+bRAXVBzWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705535959; c=relaxed/simple;
	bh=q8Vx1+eV+IMjzKRdpbvHaW0IP2LB49ldProxKUL9Hfk=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:
	 X-Spam-Checker-Version:X-Spam-Level:X-Spam-Report:X-Spam-Status:
	 Subject:X-SA-Exim-Version:X-SA-Exim-Scanned; b=uMiCwsOXA4t8uso6mupSK0hJ5arlEkq0cunNwDPYjxt7qDz00p80bnqMdk2wTJnsriDVb1InaIfimTocrkfEcIq+W993iin5kmrEVSAhLwdw51IoGTITxX6d8Uk1O5bCdz60+kWmMU2f4yKnNCD+8nkIAkT85dDQfBUhPGuN1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=A6vHNlKu; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=j/XImjCrDnHLnH1bZ58NWxdX7iYeW2BtAykEvdA9ASE=; b=A6vHNlKuLOm3Fc+YGOzJUVBnz8
	bpAl3isE8NFvrHEzGrrJjZMDxSw6baED/EHORPJyVuDRRxjw5BY6pfnPw3PPGNbXjz+PsWky2zL5W
	l9vYthG17AyxC7ONsX6PMaVW+Q2Y0zEmK8N3jZ/t9vuQwxZp9cbhFT4q2+1Lp8UZO4jY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:60128 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rQFoL-0001xn-Vh; Wed, 17 Jan 2024 18:59:10 -0500
Date: Wed, 17 Jan 2024 18:59:09 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 cosmin.tanislav@analog.com, shc_work@mail.ru, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20240117185909.78bb633ea090f74de9f4f3b7@hugovil.com>
In-Reply-To: <CAHp75Ve5PYQTRdxcffdQvYWJ-iwvfEHfMnL-vhs_mv7yg+GJ5Q@mail.gmail.com>
References: <20240117223856.2303475-1-hugo@hugovil.com>
	<20240117223856.2303475-16-hugo@hugovil.com>
	<CAHp75Ve5PYQTRdxcffdQvYWJ-iwvfEHfMnL-vhs_mv7yg+GJ5Q@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	* -1.7 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 15/18] serial: max310x: replace ENOTSUPP with preferred
 EOPNOTSUPP (checkpatch)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Thu, 18 Jan 2024 01:24:11 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jan 18, 2024 at 12:39 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Fixes the following checkpatch warning:
> >
> >     WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> 
> NAK.
> It's a false positive.
> 
> > According to include/linux/errno.h, ENOTSUPP is
> > "Defined for the NFSv3 protocol", so replace it with preferred EOPNOTSUPP.
> 
> The GPIO subsystem uses this internal error code internally. User
> space won't get it, so users may not see this one.

Hi Andy,
I will drop the patch then.

What about adding a comment to prevent future fixes?

-               return -ENOTSUPP;
+               return -ENOTSUPP; /*
+                                  * ENOTSUPP is used for backward compatibility
+                                  * with GPIO subsystem.
+                                  */

Hugo Villeneuve

