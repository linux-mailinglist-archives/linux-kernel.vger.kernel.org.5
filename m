Return-Path: <linux-kernel+bounces-58921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A1084EEA4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4055E28B00F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FAB136A;
	Fri,  9 Feb 2024 01:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAoMP/K/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479A15AF;
	Fri,  9 Feb 2024 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707443004; cv=none; b=I6Egle0IRsrLM35t+5xwUT5buVJKLIBUEnmqjXvOXPDjTIhHx/DMLuUWINXc5bzhwDviZbrPTONPI4krAhPMb2UR/XAWUsPwZKUb4/QWBQKKXrtgf7KsVfYtrEgKVXnG3kvE0SNL4k7+TYa9nm1f/eSsBRGdwFouXIpltbRZoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707443004; c=relaxed/simple;
	bh=+Scx3UIv24JIkpDEkG9RgRFZouxyNm778JhYqy4VoiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqYjJfen5miXcu3OwxMOZJn6l1/udYlRzyFDM2geh5rVzIcXNashPA/FWJDCrN9gk8JhG6poKXRONf1rJJ93J4csJb0ocuxdSmJ2T8AsI7m1CqBFhgUNBdAVgDUCqN/JMM2lur9/4lu7dLzdJfkmU22rawtqUG5lexRkD1qw3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAoMP/K/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF16FC433C7;
	Fri,  9 Feb 2024 01:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707443004;
	bh=+Scx3UIv24JIkpDEkG9RgRFZouxyNm778JhYqy4VoiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAoMP/K/I3VxVfD2GXsxK1hFI/4VvgHfHiQsLd3XLhXggHMXPswk8VgvrbI3ajtbS
	 dGSSKnO6XpFCWTQJ0cyaTQYkRyZUu064I/mZ+XP9rdlR1Lnnmgu3oPnlZlPoRI0mxt
	 ErbaK05dHqmJblJw7HK7JueUVuQstwQ9cm+18Bfv9OuL49ibEWhgrvI0RJqxdBklu1
	 s4DMAW+tg74R3wkuoNWHipOEKA5vEevUrLmjVIxsdnWEnS/oHatwccrEZZWjCZVB6H
	 hho0gCSxlvI1zRsPA0jTys4wBikv3sPv+6+YKWTw230NyDXZ2RF2nPOt8XPDq5SCvD
	 PM2zZT8xFKftQ==
Date: Thu, 8 Feb 2024 17:43:22 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Dhya <dhya@picorealm.net>, 1063422@bugs.debian.org,
	Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [regression 6.1.y] f2fs: invalid zstd compress level: 6
Message-ID: <ZcWDOjKEnPDxZ0Or@google.com>
References: <170736382774.1975.1861975122613668970.reportbug@tsuga.picorealm.net>
 <ZcU3VCrt9VOpuFUq@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcU3VCrt9VOpuFUq@eldamar.lan>

Hi,

Let me check this soon.

Thanks,

On 02/08, Salvatore Bonaccorso wrote:
> Hi Jaegeuk Kim, Chao Yu,
> 
> In Debian the following regression was reported after a Dhya updated
> to 6.1.76:
> 
> On Wed, Feb 07, 2024 at 10:43:47PM -0500, Dhya wrote:
> > Package: src:linux
> > Version: 6.1.76-1
> > Severity: critical
> > Justification: breaks the whole system
> > 
> > Dear Maintainer,
> > 
> > After upgrade to linux-image-6.1.0-18-amd64 6.1.76-1 F2FS filesystem
> > fails to mount rw.  Message in the boot journal:
> > 
> >   kernel: F2FS-fs (nvme0n1p6): invalid zstd compress level: 6
> > 
> > There was recently an f2fs patch to the 6.1 kernel tree which might be
> > related: https://www.spinics.net/lists/stable-commits/msg329957.html
> > 
> > Was able to recover the system by doing:
> > 
> > sudo mount -o remount,rw,relatime,lazytime,background_gc=on,discard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,extent_cache,mode=adaptive,active_logs=6,alloc_mode=default,checkpoint_merge,fsync_mode=posix,compress_algorithm=lz4,compress_log_size=2,compress_mode=fs,atgc,discard_unit=block,memory=normal /dev/nvme0n1p6 /
> > 
> > under the running bad 6.1.0-18-amd64 kernel, then editing
> > /etc/default/grub:
> > 
> >   GRUB_DEFAULT="Advanced options for Debian GNU/Linux>Debian GNU/Linux, with Linux 6.1.0-17-amd64"
> > 
> > and running 'update-grub' and rebooting to boot the 6.1.0-17-amd64
> > kernel.
> 
> The issue is easily reproducible by:
> 
> # dd if=/dev/zero of=test.img count=100 bs=1M
> # mkfs.f2fs -f -O compression,extra_attr ./test.img
> # mount -t f2fs -o compress_algorithm=zstd:6,compress_chksum,atgc,gc_merge,lazytime ./test.img /mnt
> 
> resulting in
> 
> [   60.789982] F2FS-fs (loop0): invalid zstd compress level: 6
> 
> A bugzilla report has been submitted in
> https://bugzilla.kernel.org/show_bug.cgi?id=218471
> 
> #regzbot introduced: v6.1.69..v6.1.76
> #regzbot link: https://bugs.debian.org/1063422
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=218471
> 
> Regards,
> Salvatore

