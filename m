Return-Path: <linux-kernel+bounces-61057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6741850CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1D51F255F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 01:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115661851;
	Mon, 12 Feb 2024 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka5S80rF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537417C2;
	Mon, 12 Feb 2024 01:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707702265; cv=none; b=AJa88l8mMtA8ctUbnfSHxIbmfG9UvT2Pmxbta/nUlqcyLme/MkZiE+e0xvId0bquRHEwh+qJ0lzCcw9MH9BGZgA162OjBgX7lUT1mMB+SRif2lDRvh6vXpVCGxlSSg564DsHzurAgnjbDhDn5SVsMbQcZE7WE0TGOQ3LOd56iYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707702265; c=relaxed/simple;
	bh=4IMhTCm+4ebD9jlmrgZx3WxxAqePhM3QRPvgoRvuh3U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LQ9UYQDYaEHoAj/8W0UShvgz9DzOTJxEXRvLgB/cEezOh74q3VYoyx2v8+hn5cN5FTTQO2P68mgps6bKuJr6QYht4sXuC2VjObfKM80DYX5Iuc6ES98CJLSFRu+eLqAY4/+inquDAJJAYxj2s4KJDAjlrVwHaC5G6HuhqMWAX+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka5S80rF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DA9C433F1;
	Mon, 12 Feb 2024 01:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707702265;
	bh=4IMhTCm+4ebD9jlmrgZx3WxxAqePhM3QRPvgoRvuh3U=;
	h=Date:From:To:Subject:From;
	b=ka5S80rFMoog1UPHMr7XapjFqxZvQKqUqh/AFohMKz1UcNfoqPnAF7SyIyBfKBp2y
	 79T9u3U+51zvwv7ElOhsqw0Hl72icwRs1s+ZkPADIPe3fkS8I4USBeUPmuyuJIOWoI
	 TLVT080d9QWOuUwiXmAd26ZB2A2f7DPW6xeaxppnoaxbcJziTPQM+8uOwwSlKU/Jx2
	 C/7RJqlPOiFrmFoiyMSxXSdI6epUUI4oST/DLfe84a9LiGAsNPQjnp2TgKTULyzROw
	 Nw1MGBt5qULuZj74nzC6nCijIMQOvfUSiGo2qLGmcLKX9S862rYJ+tzopS9oCzuY31
	 Ur2NdJxsX19dQ==
Date: Mon, 12 Feb 2024 02:44:21 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: man-pages-6.06 released
Message-ID: <Zcl39haVgvrKcCwx@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QjVJJ2c65v2uQWSq"
Content-Disposition: inline


--QjVJJ2c65v2uQWSq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Feb 2024 02:44:21 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: man-pages-6.06 released

Gidday!

I'm proud to announce:

tag man-pages-6.06
Tagger: Alejandro Colomar <alx@kernel.org>
Date:   Mon Feb 12 02:19:45 2024 +0100

man-pages-6.06 - manual pages for GNU/Linux

The following `make check` errors are known, and can be safely ignored
by touching all those files:

	$ make check -kj >/dev/null 2>&1;
	$ make check -i 2>/dev/null;
	GREP    .tmp/man/man1/memusage.1.check-catman.touch
	GREP    .tmp/man/man3/mallopt.3.check-catman.touch
	TROFF   .tmp/man/man3/unlocked_stdio.3.cat.set
	GROTTY  .tmp/man/man3/unlocked_stdio.3.cat
	COL     .tmp/man/man3/unlocked_stdio.3.cat.grep
	GREP    .tmp/man/man3/unlocked_stdio.3.check-catman.touch
	TROFF   .tmp/man/man4/console_codes.4.cat.set
	GROTTY  .tmp/man/man4/console_codes.4.cat
	COL     .tmp/man/man4/console_codes.4.cat.grep
	GREP    .tmp/man/man4/console_codes.4.check-catman.touch
	TROFF   .tmp/man/man4/lirc.4.cat.set
	GROTTY  .tmp/man/man4/lirc.4.cat
	COL     .tmp/man/man4/lirc.4.cat.grep
	GREP    .tmp/man/man4/lirc.4.check-catman.touch
	GREP    .tmp/man/man4/smartpqi.4.check-catman.touch
	GREP    .tmp/man/man4/veth.4.check-catman.touch
	GREP    .tmp/man/man5/proc_buddyinfo.5.check-catman.touch
	GREP    .tmp/man/man5/proc_pid_fdinfo.5.check-catman.touch
	GREP    .tmp/man/man5/proc_pid_maps.5.check-catman.touch
	GREP    .tmp/man/man5/proc_pid_mountinfo.5.check-catman.touch
	GREP    .tmp/man/man5/proc_pid_net.5.check-catman.touch
	TROFF   .tmp/man/man5/proc_pid_smaps.5.cat.set
	GROTTY  .tmp/man/man5/proc_pid_smaps.5.cat
	COL     .tmp/man/man5/proc_pid_smaps.5.cat.grep
	GREP    .tmp/man/man5/proc_pid_smaps.5.check-catman.touch
	GREP    .tmp/man/man5/proc_timer_stats.5.check-catman.touch
	GREP    .tmp/man/man5/proc_version.5.check-catman.touch
	GREP    .tmp/man/man5/slabinfo.5.check-catman.touch
	TROFF   .tmp/man/man5/tzfile.5.cat.set
	GROTTY  .tmp/man/man5/tzfile.5.cat
	COL     .tmp/man/man5/tzfile.5.cat.grep
	GREP    .tmp/man/man5/tzfile.5.check-catman.touch
	TROFF   .tmp/man/man7/ascii.7.cat.set
	GROTTY  .tmp/man/man7/ascii.7.cat
	COL     .tmp/man/man7/ascii.7.cat.grep
	GREP    .tmp/man/man7/ascii.7.check-catman.touch
	TROFF   .tmp/man/man7/bpf-helpers.7.cat.set
	GROTTY  .tmp/man/man7/bpf-helpers.7.cat
	COL     .tmp/man/man7/bpf-helpers.7.cat.grep
	GREP    .tmp/man/man7/bpf-helpers.7.check-catman.touch
	TROFF   .tmp/man/man7/charsets.7.cat.set
	GROTTY  .tmp/man/man7/charsets.7.cat
	COL     .tmp/man/man7/charsets.7.cat.grep
	GREP    .tmp/man/man7/charsets.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-1.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-1.7.cat
	COL     .tmp/man/man7/iso_8859-1.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-1.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-10.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-10.7.cat
	COL     .tmp/man/man7/iso_8859-10.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-10.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-11.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-11.7.cat
	COL     .tmp/man/man7/iso_8859-11.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-11.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-13.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-13.7.cat
	COL     .tmp/man/man7/iso_8859-13.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-13.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-14.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-14.7.cat
	COL     .tmp/man/man7/iso_8859-14.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-14.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-15.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-15.7.cat
	COL     .tmp/man/man7/iso_8859-15.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-15.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-16.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-16.7.cat
	COL     .tmp/man/man7/iso_8859-16.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-16.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-2.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-2.7.cat
	COL     .tmp/man/man7/iso_8859-2.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-2.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-3.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-3.7.cat
	COL     .tmp/man/man7/iso_8859-3.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-3.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-4.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-4.7.cat
	COL     .tmp/man/man7/iso_8859-4.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-4.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-5.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-5.7.cat
	COL     .tmp/man/man7/iso_8859-5.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-5.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-6.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-6.7.cat
	COL     .tmp/man/man7/iso_8859-6.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-6.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-7.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-7.7.cat
	COL     .tmp/man/man7/iso_8859-7.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-7.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-8.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-8.7.cat
	COL     .tmp/man/man7/iso_8859-8.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-8.7.check-catman.touch
	TROFF   .tmp/man/man7/iso_8859-9.7.cat.set
	GROTTY  .tmp/man/man7/iso_8859-9.7.cat
	COL     .tmp/man/man7/iso_8859-9.7.cat.grep
	GREP    .tmp/man/man7/iso_8859-9.7.check-catman.touch
	GREP    .tmp/man/man7/keyrings.7.check-catman.touch
	GREP    .tmp/man/man7/uri.7.check-catman.touch
	TROFF   .tmp/man/man8/tzselect.8.cat.set
	GROTTY  .tmp/man/man8/tzselect.8.cat
	COL     .tmp/man/man8/tzselect.8.cat.grep
	GREP    .tmp/man/man8/tzselect.8.check-catman.touch
	TROFF   .tmp/man/man8/zdump.8.cat.set
	GROTTY  .tmp/man/man8/zdump.8.cat
	COL     .tmp/man/man8/zdump.8.cat.grep
	GREP    .tmp/man/man8/zdump.8.check-catman.touch
	TROFF   .tmp/man/man8/zic.8.cat.set
	GROTTY  .tmp/man/man8/zic.8.cat
	COL     .tmp/man/man8/zic.8.cat.grep
	GREP    .tmp/man/man8/zic.8.check-catman.touch


Tarball download:
     <https://kernel.org/pub/linux/docs/man-pages/>
Git repository:
     <https://git.kernel.org/cgit/docs/man-pages/man-pages.git/>
Online PDF book:
     <https://kernel.org/pub/linux/docs/man-pages/book/>

Thank you all for contributing!

Have a lovely night!
Alex

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Changes in man=
-pages-6.06 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Released: 2024-02-12, Aldaya


Contributors
------------

The following people contributed patches/fixes, reports, notes,
ideas, and discussions that have been incorporated in changes in
this release:

"G. Branden Robinson" <branden@debian.org>
"G. Branden Robinson" <g.branden.robinson@gmail.com>
"Huang, Ying" <ying.huang@intel.com>
"Serge E. Hallyn" <serge@hallyn.com>
Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
Alejandro Colomar <alx@kernel.org>
Alexander Kozhevnikov <mentalisttraceur@gmail.com>
Alexey Tikhonov <atikhono@redhat.com>
Amir Goldstein <amir73il@gmail.com>
Andreas Schwab <schwab@issan.informatik.uni-dortmund.de>
Andreas Schwab <schwab@linux-m68k.org>
Andreas Schwab <schwab@suse.de>
Andriy Utkin <andriy_utkin@fastmail.com>
Arnav Rawat <rawat.arnav@gmail.com>
Arnd Bergmann <arnd@arndb.de>
Aurelien Jarno <aurel32@debian.org>
Avinesh Kumar <akumar@suse.de>
Axel Rasmussen <axelrasmussen@google.com>
Brian Inglis <Brian.Inglis@Shaw.ca>
Bruno Haible <bruno@clisp.org>
Carlos O'Donell <carlos@redhat.com>
Catalin Marinas <catalin.marinas@arm.com>
Christian Brauner <brauner@kernel.org>
Christopher Lameter <cl@os.amperecomputing.com>
Colin Watson <cjwatson@debian.org>
DJ Delorie <dj@redhat.com>
David Mosberger <davidm@hpl.hp.com>
Deri James <deri@chuzzlewit.myzen.co.uk>
Don Brace <don.brace@microchip.com>
Elliott Hughes <enh@google.com>
Florent Revest <revest@chromium.org>
Florian Lehner <dev@der-flo.net>
Florian Weimer <fweimer@redhat.com>
G. Branden Robinson <g.branden.robinson@gmail.com>
Geoff Keating <geoffk@ozemail.com.au>
Gobinda Das <godas@redhat.com>
Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Guillem Jover <guillem@hadrons.org>
Guo Ren <guoren@kernel.org>
Guo Ren <guoren@linux.alibaba.com>
G=C3=BCnther Noack <gnoack@google.com>
Hanno B=C3=B6ck <hanno@hboeck.de>
Helge Kreutzmann <debian@helgefjell.de>
Iker Pedrosa <ipedrosa@redhat.com>
Ingo Schwarze <schwarze@openbsd.org>
Ingo Schwarze <schwarze@usta.de>
Jakub Jelinek <jakub@redhat.com>
Jakub Wilk <jwilk@jwilk.net>
Jan Engelhardt <jengelh@inai.de>
Jan Kara <jack@suse.cz>
John Watts <contact@jookia.org>
Jonathan Wakely <jwakely@redhat.com>
Jonny Grant <jg@jguk.org>
Kees Cook <keescook@chromium.org>
Kevin Barnett <kevin.barnett@microchip.com>
Kuniyuki Iwashima <kuniyu@amazon.com>
Lee Griffiths <poddster@gmail.com>
Luis Chamberlain <mcgrof@kernel.org>
Maciej =C5=BBenczykowski <maze@google.com>
Mario Blaettermann <mario.blaettermann@gmail.com>
Matthew House <mattlloydhouse@gmail.com>
Matthias Gerstner <matthias.gerstner@suse.com>
Max Kellermann <max.kellermann@ionos.com>
Michael Kerrisk <mtk.manpages@gmail.com>
Miguel de Icaza <miguel@nuclecu.unam.mx>
Mike McGowen <mike.mcgowen@microchip.com>
Mike Rapoport (IBM) <rppt@kernel.org>
Morten Welinder <mwelinder@gmail.com>
Muhammad Usama Anjum <usama.anjum@collabora.com>
Oskari Pirhonen <xxc3ncoredxx@gmail.com>
Patch by Xavier Leroy <Xavier.Leroy@inria.fr>.
Paul Eggert <eggert@cs.ucla.edu>
Paul Smith <psmith@gnu.org>
Peter Xu <peterx@redhat.com>
Petr Vorel <pvorel@suse.cz>
Philip Blundell <pb@nexus.co.uk>
Renzo Davoli <renzo@cs.unibo.it>
Reported by Ralf Corsepius <corsepiu@faw.uni-ulm.de>.
Reported by Sam Roberts <sroberts@uniserve.com>.
Richard Henderson <richard@gnu.ai.mit.edu>
Richard Henderson <rth@cygnus.com>
Richard Henderson <rth@tamu.edu>
Rik van Riel <riel@surriel.com>
Roland McGrath <roland@gnu.org>
Sam James <sam@gentoo.org>
Sambit Nayak <sambitnayak@gmail.com>
Samuel Thibault <samuel.thibault@ens-lyon.org>
Sargun Dhillon <sargun@sargun.me>
Sascha Grunert <saschagrunert@gmail.com>
Sascha Grunert <sgrunert@redhat.com>
Scott Benesh <scott.benesh@microchip.com>
Scott Teel <scott.teel@microchip.com>
Serge Hallyn <serge@hallyn.com>
Sergei Gromeniuk <sgromeni@redhat.com>
Shahab Ouraie <shahabouraie@gmail.com>
Shani Leviim <sleviim@redhat.com>
Stefan Puiu <stefan.puiu@gmail.com>
Thorsten Kukuk <kukuk@suse.com>
Tom Schwindl <schwindl@posteo.de>
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
Ulrich Drepper <drepper@cygnus.com>
Ulrich Drepper <drepper@redhat.com>
Wolfram Gloger <wg@wolfram.dent.med.uni-muenchen.de>
Wolfram Gloger <wmglo@dent.med.uni-muenchen.de>
Xavier Leroy <Xavier.Leroy@inria.fr>
Xi Ruoyao <xry111@xry111.site>
Yafang Shao <laoar.shao@gmail.com>
Yang Xu <xuyang2018.jy@fujitsu.com>
Zack Weinberg <zack@owlfolio.org>
=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net>
=D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=
=D0=B2 <dilyan.palauzov@aegee.org>
=D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz>

Apologies if I missed anyone!


New and rewritten pages
-----------------------

man2/
	ioctl_pagemap_scan.2

man3/					(taken from glibc's linuxthreads)
	pthread_cond_init.3
	pthread_condattr_init.3
	pthread_key_create.3
	pthread_mutex_init.3
	pthread_mutexattr_setkind_np.3
	pthread_once.3

man5/
	proc.5				(split into many small pages)
	proc_apm.5
	proc_buddyinfo.5
	proc_bus.5
	proc_cgroups.5
	proc_cmdline.5
	proc_config.gz.5
	proc_cpuinfo.5
	proc_crypto.5
	proc_devices.5
	proc_diskstats.5
	proc_dma.5
	proc_driver.5
	proc_execdomains.5
	proc_fb.5
	proc_filesystems.5
	proc_fs.5
	proc_ide.5
	proc_interrupts.5
	proc_iomem.5
	proc_ioports.5
	proc_kallsyms.5
	proc_kcore.5
	proc_key-users.5
	proc_keys.5
	proc_kmsg.5
	proc_kpagecgroup.5
	proc_kpagecount.5
	proc_kpageflags.5
	proc_ksyms.5
	proc_loadavg.5
	proc_locks.5
	proc_malloc.5
	proc_meminfo.5
	proc_modules.5
	proc_mtrr.5
	proc_partitions.5
	proc_pci.5
	proc_pid.5
	proc_pid_attr.5
	proc_pid_autogroup.5
	proc_pid_auxv.5
	proc_pid_cgroup.5
	proc_pid_clear_refs.5
	proc_pid_cmdline.5
	proc_pid_comm.5
	proc_pid_coredump_filter.5
	proc_pid_cpuset.5
	proc_pid_cwd.5
	proc_pid_environ.5
	proc_pid_exe.5
	proc_pid_fd.5
	proc_pid_fdinfo.5
	proc_pid_io.5
	proc_pid_limits.5
	proc_pid_map_files.5
	proc_pid_maps.5
	proc_pid_mem.5
	proc_pid_mountinfo.5
	proc_pid_mounts.5
	proc_pid_mountstats.5
	proc_pid_net.5
	proc_pid_ns.5
	proc_pid_numa_maps.5
	proc_pid_oom_score.5
	proc_pid_oom_score_adj.5
	proc_pid_pagemap.5
	proc_pid_personality.5
	proc_pid_projid_map.5
	proc_pid_root.5
	proc_pid_seccomp.5
	proc_pid_setgroups.5
	proc_pid_smaps.5
	proc_pid_stack.5
	proc_pid_stat.5
	proc_pid_statm.5
	proc_pid_status.5
	proc_pid_syscall.5
	proc_pid_task.5
	proc_pid_timers.5
	proc_pid_timerslack_ns.5
	proc_pid_uid_map.5
	proc_pid_wchan.5
	proc_profile.5
	proc_scsi.5
	proc_slabinfo.5
	proc_stat.5
	proc_swaps.5
	proc_sys.5
	proc_sys_abi.5
	proc_sys_debug.5
	proc_sys_dev.5
	proc_sys_fs.5
	proc_sys_kernel.5
	proc_sys_net.5
	proc_sys_proc.5
	proc_sys_sunrpc.5
	proc_sys_user.5
	proc_sys_vm.5
	proc_sysrq-trigger.5
	proc_sysvipc.5
	proc_tid_children.5
	proc_timer_list.5
	proc_timer_stats.5
	proc_tty.5
	proc_uptime.5
	proc_version.5
	proc_vmstat.5
	proc_zoneinfo.5


Newly documented interfaces in existing pages
---------------------------------------------

man2/
	access.2
		AT_EMPTY_PATH

	execve.2
		E2BIG

	ioctl_userfaultfd.2
		UFFDIO_API handshake
		UFFDIO_POISON
		UFFD_FEATURE_WP_ASYNC

	mbind.2
		MPOL_F_NUMA_BALANCING

	prctl.2
		PR_SET_MDWE
		PR_GET_MDWE

	set_thread_area.2
		C-SKY

	utimensat.2
		AT_EMPTY_PATH

man3/
	stdio.3
		fmemopen(3)
		fopencookie(3)
		open_memstream(3)
		open_wmemstream(3)

man4/
	smartpqi.4
		ctrl_ready_timeout
		enable_stream_detection
		ssd_smart_path_enabled
		enable_r5_writes
		enable_r6_writes
		lunid
		unique_id
		path_info
		raid_bypass_cnt
		sas_ncq_prio_enable

man5/
	proc_pid_status.5		(previously, proc.5)
		Seccomp_filters

	tmpfs.5
		size/blocks=3D0
		nr_inodes=3D0

man8/
	ld.so.8
		--list-diagnostics
		--glibc-hwcaps-mask
		--glibc-hwcaps-prepend


New and changed links
---------------------

man5/
	proc_mounts.5			(proc_pid_mounts(5))
	proc_net.5			(proc_pid_net(5))
	proc_pid_gid_map.5		(proc_pid_uid_map(5))
	proc_pid_oom_adj.5		(proc_pid_oom_score_adj(5))
	proc_self.5			(proc_pid(5))
	proc_thread-self.5		(proc_pid_task(5))
	proc_tid.5			(proc_pid_task(5))


Removed links
-------------

man3/
	stpecpy.3
	stpecpyx.3
	ustpcpy.3
	ustr2stp.3
	zustr2stp.3
	zustr2ustp.3


Global changes
--------------

-  Build system
   -  Update PDF book for groff-1.23.0.
   -  Add targets to [un]install intro(*) pages separately.
   -  Support manual pages in other projects, so that our build system
      can be used to for example lint them.
   -  Reject non-GNU make(1).
   -  Add target to build the PDF book.

-  man*/
   -  Add some consistency in the use of man(7).
   -  Split proc(5) into many small pages.
   -  Import pages from old linuxthreads (glibc), with their git
      history (from both glibc and Debian).
   -  Rewrite a large part of the documentation for string-copying
      functions.
   -  Say ISO/IEC instead of ISO where appropriate, and be consistent in
      the fomatting of names of ISO or ISO/IEC standards.


Changes to individual pages
---------------------------

The manual pages (and other files in the repository) have been improved
beyond what this changelog covers.  To learn more about changes applied
to individual pages, use git(1).

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--QjVJJ2c65v2uQWSq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXJd/UACgkQnowa+77/
2zK9bBAAq3xVj+KSlmI3y75mpVD5AW1AasP/+GK0wXcQ0k67TJSvGksczNKAmFAN
cwxkO0LocBUcaNWl+vF+x3VkEgISn2HyrM8O/ZAFIvDjsAKvoEaqldXzCiR0ZqrS
7PUUbJHO4kYY0UsAKcvy5y1rgqrOFH8jLpz9X+/tDtoeRH5eC35zZlI2gry5nKax
BtWzmjRjwQpfy8m+vSZo8BYMZPwmD6C1UqD7XWO3CjVRXt1GGp8sx8Tiz/VPRUbi
92zK2LhuXFcPNyOCmq4KBwbGnOENGR4+6YKL601ypl3hb3EoCsiuo7dItogUMGQD
N04bAWUoas0cyMshlBW2XUCpqCHIGOGudmJA6BZ2pT0u378FqChrS3XkuuYj0gtP
1bR8hGr1SO6x9PW/X5hy9GX6h65lTDe6LCldIijCPKDkTtb/g5WcFoefbs0d+cs2
9u5LknB3SHBH20TobOMO6/yA8wq1w+G5n/LWguY8Pv2X99xSFUuaBBh2JhyA2l5l
+rtBg/DEqaPdeddajz8srYzYDUvpS10TIIdj8/ugmAF8SsUBhhQefgLiOGvKh7Rn
zYhE5A6HouMNQ/s4KJ22pQpG9IPudpbsUzXF+uWTeOaLNSVGQ87nS36qyD6aC0sp
hf7oONTK0y4QNh4/TOjiBcRA9CvCLz3weMXnJ7vpGvzwBHc4k/M=
=tAar
-----END PGP SIGNATURE-----

--QjVJJ2c65v2uQWSq--

