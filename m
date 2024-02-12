Return-Path: <linux-kernel+bounces-61771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 017EE8516F8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D87C9B23D44
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258A652F61;
	Mon, 12 Feb 2024 13:52:03 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A67C524D6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745922; cv=none; b=BV2KCij1B2DAriXG/Q0nHvbdGCo3rkqhdczwZh2o1+NstL6MAQxpnwAPeEyGcmvI3jeTNA6/nXSg0voxt95Z5x6j7DQh4tcGzBxwFgARm10h6JvZwpHcd7GMTwQHMHmhyH4lei638v5RuZ4tNlUOOY9jGxEwNKcTz+w1BNvPrwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745922; c=relaxed/simple;
	bh=xKX+1qfCGDoMvjkeWUoqk1cysYFlqoZNqkjSGZSbb9Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KjVYLNBkInXC/qcgD1ttRrS93QjcTl84rIb1evWCqYqCxkrv/+WDIVJsqar8g+i6gtB7dFI7Vxer6nuixcE396cgHi9xP8cL1CMoumU2teQL+77uoNwLXA+tp8xAS4gbD4P+1bjnFlLQ19esEQVjWPKQDhIeL0GdWESYD9ngBvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:47b8:b872:d87c:512])
	by xavier.telenet-ops.be with bizsmtp
	id mDry2B0041wMtyi01DryJT; Mon, 12 Feb 2024 14:51:58 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rZWiz-000VqX-W9;
	Mon, 12 Feb 2024 14:51:58 +0100
Date: Mon, 12 Feb 2024 14:51:57 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Max Kellermann <max.kellermann@ionos.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/35] Fast kernel headers: reduce header
 dependencies
In-Reply-To: <20240212115500.2078463-1-max.kellermann@ionos.com>
Message-ID: <ced259d-591-1186-9c3c-7af65978010@linux-m68k.org>
References: <20240212115500.2078463-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-257163098-1707745917=:122263"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-257163098-1707745917=:122263
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 8BIT

 	Hi Max,

On Mon, 12 Feb 2024, Max Kellermann wrote:
> This patch set aims to reduce the dependencies between headers, in
> order to have cleaner code and speed up the build.  It continues
> previous efforts by other developers.

[...]

Thanks for your series!

On next-20240212 + your series:

m68k/defconfig:

sound/oss/dmasound/dmasound_core.c:1436:8: error: implicit declaration of function ¡get_options¢ [-Werror=implicit-function-declaration]
arch/m68k/emu/nfblock.c:45:10: error: implicit declaration of function ¡virt_to_phys¢; did you mean ¡virt_to_pfn¢? [-Werror=implicit-function-declaration]
arch/m68k/emu/nfblock.c:71:2: error: implicit declaration of function ¡bio_for_each_segment¢ [-Werror=implicit-function-declaration]
arch/m68k/emu/nfblock.c:71:39: error: expected ¡;¢ before ¡{¢ token
fs/notify/fanotify/fanotify_user.c:1760:6: error: implicit declaration of function ¡upper_32_bits¢ [-Werror=implicit-function-declaration]
drivers/block/amiflop.c:1954:7: error: implicit declaration of function ¡get_option¢; did you mean ¡get_pid¢? [-Werror=implicit-function-declaration]
drivers/block/ataflop.c:2163:8: error: implicit declaration of function ¡get_options¢ [-Werror=implicit-function-declaration]
drivers/net/Space.c:148:8: error: implicit declaration of function ¡get_options¢ [-Werror=implicit-function-declaration]
drivers/scsi/atari_scsi.c:396:2: error: implicit declaration of function ¡get_options¢ [-Werror=implicit-function-declaration]
drivers/scsi/NCR5380.c:424:2: error: implicit declaration of function ¡snprintf¢ [-Werror=implicit-function-declaration]
drivers/scsi/mac_scsi.c:72:8: error: implicit declaration of function ¡get_options¢ [-Werror=implicit-function-declaration]
drivers/zorro/zorro-driver.c:144:6: error: implicit declaration of function ¡add_uevent_var¢ [-Werror=implicit-function-declaration]
fs/open.c:1214:19: error: implicit declaration of function ¡upper_32_bits¢ [-Werror=implicit-function-declaration]

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
--8323329-257163098-1707745917=:122263--

