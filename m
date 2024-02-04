Return-Path: <linux-kernel+bounces-51855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD63849017
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067F01F232F5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E47250E0;
	Sun,  4 Feb 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="H64FwgkV";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="80V/cH2H"
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [46.30.211.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E1E250ED
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707074567; cv=none; b=MsuIqXzNQBghkSHHBU8iDbFf1/wbfC5LfU/CR6Dp/ngmWwhZANJpG3bPMqZ0UZjWzo7TmEhRTlcy7+lZ30rVFA20zWpGST4d19koiNhU5hJt6RWuM6QzCKSqzv2Ifp2am3qrPJKg9gjg/v5PRar+sxxvZLhSCSmQHWf8WqFFMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707074567; c=relaxed/simple;
	bh=BhS7llerz0XxSfqMKsPaxpwBnH6uQCzYexdrBKauA7c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv4vd2sgTWK4cZWyfbBkbUrS91a/oziIObDthUXKxEj+OOzzjOW/xGdApH7IljR3EMKrj5CzUKK5crn4tl2lT2g+G0pYLJfQBvWDm34ozq4vvKpcz6Ci5RztpJghOfwrQkAjdtGSmvhLu4Cc3ZTXveOa+7KYX1ZhyUaCjHEwF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=H64FwgkV; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=80V/cH2H; arc=none smtp.client-ip=46.30.211.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:to:from:
	 date:from;
	bh=fpJe+ZWxuYGRqiTWDJhGrptuD0C5OKl3hDjFax0lIjw=;
	b=H64FwgkV5WZ4jw3sVS4I3jHDmdQheACk3uS6z+GzDDnTxABipZMyPZqiiDkP95NduZDXM5Yv/53Yo
	 1I1QRB/kF8RIohD6zt2MgYsB0H0mT5fu37fHJfGFZejhH8Kc6EYpqtD+9jD1J8ZBYKC0wkUjPB3kZz
	 eyJpZHIOUTb1s9oYe+tOYOWjgSCkx7KSe8ox3F3ct2CYEiMlwE1uJq+doULNvx43AllqL+GeKqUnLT
	 2b6l0cXMDNCN024IsspAijbf/ZEfs6nXpAQPFFkosmOGKsyMTQKp1WI5m1mqnNTHNiRdTEtc+u6xXN
	 Arn8bHYgBZopHj8qCQZxPbRBFUs5EHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:to:from:
	 date:from;
	bh=fpJe+ZWxuYGRqiTWDJhGrptuD0C5OKl3hDjFax0lIjw=;
	b=80V/cH2HNCxHVLy7b/Oi7n46poVf24quLfcg0PY17uNn3UYE7AtbM/m5JYa7O28gsIXzj9K8gf0D4
	 IuBv35bAg==
X-HalOne-ID: 9c002278-c392-11ee-980a-b520e3c7e1da
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 9c002278-c392-11ee-980a-b520e3c7e1da;
	Sun, 04 Feb 2024 19:21:35 +0000 (UTC)
Date: Sun, 4 Feb 2024 20:21:34 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>, Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 00/27] sparc32: sunset sun4m and sun4d
Message-ID: <20240204192134.GB896678@ravnborg.org>
References: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>

Hi Andreas.

Congratulation being the new sparc co-maintainer!

On Tue, Dec 19, 2023 at 11:03:05PM +0100, Sam Ravnborg via B4 Relay wrote:
> This is the second attempt to sunset sun4m and sun4d.
> See [1] for the inital attempt.

I have now verified that the kernel can boot with qemu.
There was a bug in the uart driver that is fixed and upstream, and then
using the instructions you provided I could use buildroot with an
external kernel tree to get a booting kernel.

Assuming you agree with the patchset how do you want me to move forward?
I can rebase on top of the latest -rc and collect acks if that helps.

Arnd promised to pick up the patches until you got a git tree up,
but I do not expect Arnd to pick up anything unless you have acked or
reviewed said patch(es).

If I rebase the patch-set I will likely include a few bug-fix patches that
was prepared in the meantime.
I can also send them as a separate series, no worries.

	Sam

