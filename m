Return-Path: <linux-kernel+bounces-155155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9138AE5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3502841DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EBC127E0A;
	Tue, 23 Apr 2024 12:23:46 +0000 (UTC)
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9598529E;
	Tue, 23 Apr 2024 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875026; cv=none; b=kmh5VCAP7ZPe+ImlKVDt/hAPFiktUTGpi08XENI8s5nJ9GJ2QXlwz4CSKQB7K70Z64296NvujBXQw3QEudYKGnk71RBRWRKMSTbzDLosHRRVby29vG+0imgeV8pAzE4Ay5ZsrMyS+yEHYZr/57uoLfsOZZASp/Y/YEZcaJqRS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875026; c=relaxed/simple;
	bh=5DmUvjxy5vtrmeA+aWwOw6GwVTh9Pm0+Jafzv1sTFSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwzDmaozonsKxGpZBSxPNg4LD9pC6r548aljuJQy0wI12dO2oWP1aMLKRoSZ4pYVLQXIZBMo/Wd9Cusg9/WpkObEQWq50+ftsbCPMxsN6rKodeGIOX61XIXIVTOqP7Dk6fXzCFS15uhjP+WLvkyK03U5/cbqhc4ybFsdUnU78UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 3A406E80104;
	Tue, 23 Apr 2024 14:23:36 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id A91ED1602F7; Tue, 23 Apr 2024 14:23:35 +0200 (CEST)
Date: Tue, 23 Apr 2024 14:23:35 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Babis Chalios <bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>, linux@leemhuis.info,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] Re: [PATCH] Revert "vmgenid: emit uevent when
 VMGENID updates"
Message-ID: <ZieoRxn-On0gD-H2@gardel-login>
References: <20240418114814.24601-1-Jason@zx2c4.com>
 <e09ce9fd-14cb-47aa-a22d-d295e466fbb4@amazon.com>
 <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9qKFraYWmzD9zKCd4oaMg6FyQGP5pL9bzZP4QuqV1O_Qw@mail.gmail.com>

On Di, 23.04.24 03:21, Jason A. Donenfeld (Jason@zx2c4.com) wrote:

Jason!

Can you please explain to me what the precise problem is with the
uevent? It doesn't leak any information about the actual vmgenid, it
just lets userspace know that the machine was cloned,
basically. What's the problem with that? I'd really like to
understand?

There are many usecases for this in the VM world, for example we'd
like to hook things up so that various userspace managed concepts,
such as DHCP leases, MAC addresses are automatically refreshed.

This has no relationship to RNGs or anything like this, it's just an
event we can handle in userspace to trigger address refreshes like
this.

Hence, why is the revert necessary? This was already in a released
kernel, and we have started work on making use of this in systemd, and
afaics this does not compromise the kernel RNG in even the remotest of
ways, hence why is a revert necessary? From my usersace perspective
it's just very very sad, that this simple, trivial interface we wanted
to use, that was in a stable kernel is now gone again.

Can you explain what the problem with this single-line trivial
interface is? I really would like to understand!

Lennart

(BTW: even if the uevent would leak the vmgenid somehow to userspace —
which it does not —, at least on qemu — i.e. one of the most relevant
VM platforms — the vmgenid can be read directly from userspace by
cat'ing /sys/firmware/qemu_fw_cfg/by_name/etc/vmgenid_guid/raw,
i.e. it's not that well protected anyway).

--
Lennart Poettering, Berlin

