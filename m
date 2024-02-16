Return-Path: <linux-kernel+bounces-69255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F01858649
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5113284ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332366A005;
	Fri, 16 Feb 2024 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="IOJcRZBs"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F7F433B0;
	Fri, 16 Feb 2024 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112508; cv=none; b=dMwrQGKPYV7Vca9EFOA1oj1LjpI3kTXeFTB3Y5V8iSN+xVVXY4yKio9xkt2Iltqgj8bJn6BkZwT3p8VOC0PmWlY71lvVLVU8aaLUi9nxzyCZEKCTM5IZcz3IadAheQgNew1e93GsTr+lp2LhA3b5dWaGoJw32rWstg40yP9MLIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112508; c=relaxed/simple;
	bh=NYiejMlBKT4hQtVpRu3nvoIpFcksqFt8b9xoyKX8VVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUKc2XJaDOL/wdcB/bsV/clvX2rcmqheo3OyCivdZ04evLezMyOcvExdRJYNVDujO+B4bWjyAZ83+DihTValW5kMAaij1yf5cwqEeVvIrXaSpk7fDYXPUSpdiGvcO4cz2K8ZFGyQ3Gy1Jidnat6pl2Nz8Y+AAuJNnZ1enqqRLB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=IOJcRZBs; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 909021A8D60;
	Fri, 16 Feb 2024 20:41:41 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1708112501; bh=FkADS06nGZedHE4DwvuCBwP9OXvG3T4ADq0p3BMgFGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IOJcRZBsGSSGB99jwBKTZYTiSyS60EHwDOFRMblVoSm9sGV4ujqxcszrkOEkYxvWc
	 4oUJ/LifBUe/4xRL7FzQQ+DceuuhDMq5O+nNly5ghHjTSS2SSgnI1rDvrmuIGUScxU
	 DYJV67gO9MZvAH3wAglN9nTCWshGKj2YLh/GPEIa4ZX2L6+N41vw4KyGAQ9gGQ03oH
	 i+1pT0J7Ko32vYW4fnECoADwaM1aJzu195UmjMcOUjKZUz+QL179orIOCLCPPtlGsi
	 2ozIQhjrX232bS2vBb14OSCrcQvlOWkVhLaLaev1U2bcrzq3aIC3SWzx+NLmTKwsB7
	 1ZxhJwTk2nKLQ==
Date: Fri, 16 Feb 2024 20:41:40 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Jonathan Corbet <corbet@lwn.net>, regressions@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Bagas Sanjaya
 <bagasdotme@gmail.com>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v1] docs: new text on bisecting which also covers bug
 validation
Message-ID: <20240216204140.2ecbceec@meshulam.tesarici.cz>
In-Reply-To: <bf1d2eba0d291ff583e01b5985a0dec248eaf27a.1708072870.git.linux@leemhuis.info>
References: <bf1d2eba0d291ff583e01b5985a0dec248eaf27a.1708072870.git.linux@leemhuis.info>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 09:54:46 +0100
Thorsten Leemhuis <linux@leemhuis.info> wrote:

>[...]
> Style and structure of the text match the one
> Documentation/admin-guide/quickly-build-trimmed-linux.rst uses. Quite a
> few paragraphs are even copied from there and not changed at all or only
> slightly. This will complicate maintenance, as some future changes to
> one of these documents will have to be replicated in the other. But this
> is the lesser evil: solutions like "sending readers from one document
> over to the other" or "extracting the common parts into a separate
> document" might work in other cases, but would be too confusing here
> given the topic and the target audience.

Is this because you want to keep it readable if the target audience
reads the source text of the documentation? Otherwise, the .. include
directive does not make a difference after rendering to HTML. AFAIK.

>[...]
> * The text as of now does not really describe what a bisection is --
> neither in general nor in the scope of Git. Maybe that should be
> added. Having a few nice graphical diagrams might also be good, as the
> text is meant to be read in rendered form anyway. But I think it's
> useful like this already.

But here you expect it to be read in rendered form. So, are you afraid
of making things confusing for potential later editors of this text?

>[...]
> diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> new file mode 100644
> index 00000000000000..0a6a1a082d867c
> --- /dev/null
> +++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> @@ -0,0 +1,1925 @@
> +.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
> +.. [see the bottom of this file for redistribution information]
> +
> +=========================================
> +How to verify bugs and bisect regressions
> +=========================================
> +
> +This document describes how to check if some Linux kernel problem occurs in the
> +code developers currently support

I got puzzled for a moment as the subject of the sentence changed. What about:

  code currently supported by developers

> -- to then explain how to locate the change
> +causing the issue, if it did not happen with earlier versions.

I believe this part of the sentence could be also improved. I would not
be afraid of introducing the word "regression" here, e.g.:

  It also explains how to locate the change which introduced the issue if
  it did not happen with an earlier version. Such issues are commonly
  called regressions.

> +
> +The text aims at people running kernels from mainstream Linux distributions on
> +commodity hardware who want to report a kernel bug to the upstream Linux
> +developers. The instructions despite this intent work just as well for users who

  Despite this intent, the instructions work... ?

> +are already familiar with building their own kernels: they help avoid mistakes
> +even experienced developers occasionally make.

Again, why change the subject of the sentence? Sure, it avoids the
passive voice, which is generally a good thing, but IMO it is more
important to keep text coherence by always moving from theme to rheme
and not vice versa. Syntax of an English sentence requires that subject
appears before object, so if the theme happens to be the object of the
sentence, passive voice provides a way to place theme before rheme.

In short, what about:

  mistakes occasionally made even by experienced developers.

> +
> +The essence of the process (aka 'TL;DR')
> +========================================
> +
> +*[If you are new to building or bisecting Linux, ignore this TLDR and head over
> +to the* ":ref:`step-by-step guide on verifying bugs and bisecting
> +regressions<introguide_bissbs>`" *below: it utilizes the same commands while
> +describing them in brief fashion; the steps are nevertheless easy to follow and
> +together with accompanying entries in a reference section mention many
> +alternatives, pitfalls, and additional aspects, all of which might be essential
> +for your needs.]*
> +
> +**In case you want to check if a bug is present in a codebase developers
> +currently support**,

Again: "codebase currently supported by developers" ?

> execute just the *preparations* and *segment 1*; while
> +doing so, consider the newest Linux kernel you regularly use to be the 'working'
> +kernel. In the following example that's assumed to be 6.0.13, which is why v6.0
> +will be used to prepare the .config file.
> +
> +**In case you face a regression**, follow the steps at least till the end of
> +*segment 2*. Then you can submit a preliminary report -- or continue with
> +*segment 3*, which describes how to perform a bisection a full-fledged
> +regression report needs. 

a bisection needed for a full-fledged regression?

> In the following example 6.0.13 is assumed to be the
> +'working' kernel and 6.1.5 the first to be 'broken', hence v6.0 will be

6.1.5 to be the first 'broken' ?

> +considered the 'good' release.
> +
> +* **Preparations**: set up everything to build your own kernels::
> +
> +    # * Remove any software that depends on externally maintained kernel modules
> +    #   or builds any automatically during bootup.
> +    # * Ensure Secure Boot permits booting self-compiled Linux kernels.
> +    # * If you are not already running the 'working' kernel, reboot into it.
> +    # * Install compilers and everything else needed for building Linux.
> +    # * Ensure to have 15 Gigabyte free space in your home directory.
> +    git clone -o mainline --no-checkout \
> +      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ~/linux/
> +    cd ~/linux/
> +    git remote add -t master stable \
> +      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> +    git checkout --detach v6.0
> +    # * Hint: if you used an existing clone, ensure no stale .config is around.
> +    make olddefconfig
> +    # * Ensure the former command picked the .config of the 'working' kernel.
> +    # * Connect external hardware (USB keys, tokens, ...), start a VM, bring up
> +    #   VPNs, mount network shares, and briefly try the feature that is broken.
> +    yes '' | make localmodconfig
> +    ./scripts/config --set-str CONFIG_LOCALVERSION '-local'
> +    ./scripts/config -e CONFIG_LOCALVERSION_AUTO
> +    # * Note, when short on storage space, check the guide for an alternative:
> +    ./scripts/config -d DEBUG_INFO_NONE -e KALLSYMS_ALL -e DEBUG_KERNEL \
> +      -e DEBUG_INFO -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT -e KALLSYMS
> +    # * Hint: at this point you might want to adjust the build configuration;
> +    #   you'll have to, if you are running Debian.

Ugh... this step is necessary if you are running Debian ?

> +    make olddefconfig
> +    cp .config ~/kernel-config-working
> +
> +* **Segment 1**: build a kernel from the latest mainline codebase.
> +
> +  This among others checks if the problem was fixed already and which developers
> +  later need to be told about the problem; in the regression's case this
> +  furthermore rules out a .config change as root of the problem.

in case of a regression, this rules out a .config change as root of the
problem.

> +
> +  a) Checking out latest mainline code::
> +
> +       cd ~/linux/
> +       git checkout --force --detach mainline/master
> +
> +  b) Build, install, and boot a kernel::
> +
> +       cp ~/kernel-config-working .config
> +       make olddefconfig
> +       make -j $(nproc --all)
> +       # * Ensure free storage space suffices holding another kernel:

Make sure there is enough disk space to hold another kernel:

> +       df -h /boot/ /lib/modules/
> +       # * Note: on Arch Linux and a few other distributions the following
> +       #   commands will do nothing at all or only part of the job. See the
> +       #   step-by-step guide for details.
> +       command -v installkernel && sudo make modules_install install
> +       # * Check how much space your self-built kernel actually needs, which
> +       #   enables you to make better estimates later:
> +       du -ch /boot/*$(make -s kernelrelease)* | tail -n 1
> +       du -sh /lib/modules/$(make -s kernelrelease)/
> +       # * Hint: the output of the following command will help you pick the
> +       #   right kernel from the boot menu:
> +       make -s kernelrelease | tee -a ~/kernels-built
> +       reboot
> +       # * Once booted, ensure you are running the kernel you just built by
> +       #   checking if the output of the next two commands matches:
> +       tail -n 1 ~/kernels-built
> +       uname -r
> +
> +  c) Check if the problem occurs with this kernel as well.
> +
> +* **Segment 2**: ensure the 'good' kernel is also a 'working' kernel.
> +
> +  This among others verifies the trimmed .config file actually works well, as
> +  bisecting with it otherwise would be a waste of time:
> +
> +  a) Start by checking out the sources of the 'good' version::
> +
> +       cd ~/linux/
> +       git checkout --force --detach v6.0
> +
> +  b) Build, install, and boot a kernel as described earlier in *segment 1,
> +     section b* -- just feel free to skip the 'du' commands, as you have a rough
> +     estimate already.
> +
> +  c) Ensure the feature that regressed with the 'broken' kernel actually works
> +     with this one.
> +
> +* **Segment 3**: perform and validate the bisection.
> +
> +  a) Incase your 'broken' version is a stable/longterm release, add the Git

In case...

> +     branch holding it::
> +
> +       git remote set-branches --add stable linux-6.1.y
> +       git fetch stable
> +
> +  b) Initialize the bisection::
> +
> +       cd ~/linux/
> +       git bisect start
> +       git bisect good v6.0
> +       git bisect bad v6.1.5
> +
> +  c) Build, install, and boot a kernel as described earlier in *segment 1,
> +     section b*.
> +
> +     In case building or booting the kernel fails for unrelated reasons, run
> +     ``git bisect skip``. In all other outcomes, check if the regressed feature
> +     works with the newly built kernel. If it does, tell Git by executing
> +     ``git bisect good``; if it does not, run ``git bisect bad`` instead.
> +
> +     All three commands will make Git checkout another commit; then re-execute
> +     this step (e.g. build, install, boot, and test a kernel to then tell Git
> +     the outcome). Do so again and again until Git shows which commit broke
> +     things. If you run short of disk space during this process, check the
> +     "Supplementary tasks" section below.
> +
> +  d) Once your finished the bisection, put a few things away::
> +
> +       cd ~/linux/
> +       git bisect log > ~/bisect-log
> +       cp .config ~/bisection-config-culprit
> +       git bisect reset
> +
> +  e) Try to verify the bisection result::
> +
> +       git checkout --force --detach mainline/master
> +       git revert --no-edit cafec0cacaca0
> +
> +    This is optional, as some commits are impossible to revert. But if the
> +    second command worked flawlessly, build, install, and boot one more kernel
> +    kernel, which should not show the regression.
> +
> +* **Supplementary tasks**: cleanup during and after the process.
> +
> +  a) To avoid running out of disk space during a bisection, you might need to
> +     remove some kernels you built earlier. You most likely want to keep those
> +     you built during segment 1 and 2 around for a while, but are unlikely to
> +     need any again you tested during the actual bisection (Segment 3 c). You

Got lost again.

  but you will most likely no longer need kernels tested during the
  actual bisection.

> +     can list them in build order using::
> +
> +       ls -ltr /lib/modules/*-local*
> +
> +    To then for example erase a kernel that identifies itself as
> +    '6.0-rc1-local-gcafec0cacaca0', use this::
> +
> +       sudo rm -rf /lib/modules/6.0-rc1-local-gcafec0cacaca0
> +       sudo kernel-install -v remove 6.0-rc1-local-gcafec0cacaca0
> +       # * Note, if kernel-install is missing, you will have to
> +       #   manually remove the kernel image and related files.
> +
> +  b) If you performed a bisection and successfully validated the result, feel
> +     free to remove all kernel build during the actual bisection (Segment 3 c);

all kernels built ?

> +     the kernels you built earlier and later you might want to keep around for
> +     a week or two.
> +
> +.. _introguide_bissbs:
> +
> +Step-by-step guide on how to verify bugs and bisect regressions
> +===============================================================
> +
> +..
> +   Note: if you see this note, you are reading the text's source file. You
> +   might want to switch to a rendered version: it makes it a lot easier to
> +   read and navigate this document, especially when you want to look something
> +   up in the reference section to then jump back to where you left off.

..reference section, then jump back... ?

> +..
> +   Find a the latest rendered version of this text here:

remove "a"

> +   https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.rst.html
> +
> +The following steps show you how to verify a kernel problem you face is present

verify if your kernel problem is present

> +in code the Linux kernel developers support; in case of a regression the steps

code supported by Linux kernel developers

> +furthermore explain how to find the change causing it. The guide separates the
> +process into five segments where segments 2 and 3 are only relevant for those
> +facing a regression:
> +
> + :ref:`Preparations: set up everything to build your own kernels.<introprep_bissbs>`
> +
> + :ref:`Segment 1: try to reproduce the problem with the latest codebase.<introlatestcheck_bissbs>`
> +
> + :ref:`Segment 2: check if the kernels you build work fine.<introworkingcheck_bissbs>`
> +
> + :ref:`Segment 3: perform a bisection and validate the result.<introbisect_bissbs>`
> +
> + :ref:`Supplementary tasks: cleanup during and after following this guide.<introclosure_bissbs>`
> +
> +The steps in each segment illustrate the important aspects of the process, while
> +a comprehensive reference section holds additional details. The latter sometimes
> +also outlines alternative approaches, pitfalls, as well as problems that might
> +occur at the particular step -- and how to then get things rolling again.

remove "then" ?

> +
> +Be aware *segment 1* describes how to build and install your own kernel; the
> +commands introduced there will be used in later segments in bulk fashion without
> +further explanation.
> +
> +*Segment 1* and *segment 2* might look unnecessary for a bisection, but in fact
> +in almost all cases are important due to concealed aspects explained below;
> +skipping these segments thus could result in you wasting a lot of time and
> +effort on a meaningless bisection.
> +
> +Be aware that *segment 3* will require you to build quite a few kernels --
> +usually about 15 in case you encountered a regression when updating to a version
> +from a newer mainline release (say from 6.0.11 to 6.1.3). Due to the trimmed
> +build configuration file created initially this works a lot faster than many
> +people assume, as overall on average it will often just take about 10 to 15
> +minutes to compile each kernel on commodity x86 machines.
> +
> +For further details on how to report issues with the Linux kernel to its
> +developers checkout Documentation/admin-guide/reporting-issues.rst, which works

check out

> +in conjunction with this document. It among others explains why you need to
> +verify bugs with the latest 'mainline' kernel, even if you face a problem with a
> +kernel from a 'stable/longterm' series; for users facing a regression it also
> +explains that sending a preliminary report after finishing segment 2 might be
> +wise, as an bisection might be unnecessary in case the regression is already

remove "an" ?

> +known.
> +
> +For further details on what actually qualifies as a regression checkout

Again: check out

> +Documentation/admin-guide/reporting-regressions.rst.
> +
> +.. _introprep_bissbs:
> +
> +Preparations: set up everything to build your own kernels
> +---------------------------------------------------------
> +
> +.. _backup_bissbs:
> +
> +* Create a fresh backup and put system repair and restore tools at hand, just
> +  to be prepared for the unlikely case of something going sideways.
> +
> +  [:ref:`details<backup_bisref>`]
> +
> +.. _vanilla_bissbs:
> +
> +* Remove all software that depends on externally developed kernel drivers or
> +  builds them automatically. That includes but is not limited to DKMS, openZFS,
> +  VirtualBox, and Nvidia's graphics drivers (including the GPLed kernel module).
> +
> +  [:ref:`details<vanilla_bisref>`]
> +
> +.. _secureboot_bissbs:
> +
> +* On platforms with 'Secure Boot' or similar solutions, prepare everything to
> +  ensure the system will permit your self-compiled kernel to boot. The
> +  quickest and easiest way to achieve this on commodity x86 systems is to
> +  disable such techniques in the BIOS setup utility; alternatively, remove
> +  their restrictions through a process initiated by
> +  ``mokutil --disable-validation``.
> +
> +  [:ref:`details<secureboot_bisref>`]
> +
> +.. _rangecheck_bissbs:
> +
> +* Determine the kernel versions considered 'good' and 'bad' throughout this
> +  guide.
> +
> +  Do you follow this guide to verify if a bug is present in the code developers
> +  care for? Then consider the mainline release your 'working' kernel (the newest
> +  one you regularly use) is based on to be the 'good' version; if your 'working'
> +  kernel for example is '6.0.11', then your 'good' kernel is 'v6.0'.
> +
> +  In case you face a regression, it depends on the version range where the
> +  regression was introduced:
> +
> +  * Something which used to work in Linux 6.0 broken when switching to Linux

s/broken/broke/

> +    6.1-rc1? Then henceforth regard 'v6.0' as the last known 'good' version and
> +    'v6.1-rc1' as the first 'bad' one.
> +
> +  * Some function stopped working when updating from 6.0.11 to 6.1.4? Then for
> +    the time being consider 'v6.0' as the last 'good' version and 'v6.1.4' as
> +    the 'bad' one. Note, it at this point is an assumption that 6.0 is fine that
> +    will be checked in segment 2.

Ugh. What? Probably this:

  Note, at this point it is merely assumed that 6.0 is fine. This
  assumption will be check in segment 2.

> +
> +  * A feature you used in 6.0.11 does not work at all or worse in 6.1.13? In
> +    that case you want to bisect within a stable/longterm series: consider
> +    'v6.0.11' as the last known 'good' version and 'v6.0.13' as the first 'bad'
> +    one. Note, you in this case nevertheless want to compile a mainline kernel
> +    as explained in segment 1, as that will determine if that is a bug that the
> +    regular developers or the stable team will have to handle.

Ugh again. Probably:

  Note, in this case you still want to compile a mainline kernel as
  explained in segment 1. It will be used to decide if your issue will
  be handled by regular developers or by the stable team.

> +
> +  *Note, do not confuse 'good' version with 'working' kernel; the latter term
> +  throughout this guide will refer to the last kernel that has been working
> +  fine.*
> +
> +  [:ref:`details<rangecheck_bisref>`]
> +
> +.. _bootworking_bissbs:
> +
> +* Boot into the 'working' kernel and briefly use the feature apparently broken.

I suggest pre-position: the apparently broken feature

> +
> +  [:ref:`details<bootworking_bisref>`]
> +
> +.. _diskspace_bissbs:
> +
> +* Ensure to have enough free space for building Linux. 15 Gigabyte in your home
> +  directory should typically suffice. If you have less available, be sure to pay
> +  attention to later steps about retrieving the Linux sources and handling of
> +  debug symbols: both explain approaches reducing the amount of space, which
> +  should allow you to master these tasks with about 4 Gigabytes free space.
> +
> +  [:ref:`details<diskspace_bisref>`]
> +
> +.. _buildrequires_bissbs:
> +
> +* Install all software required to build a Linux kernel. Often you will need:
> +  'bc', 'binutils' ('ld' et al.), 'bison', 'flex', 'gcc', 'git', 'openssl',
> +  'pahole', 'perl', and the development headers for 'libelf' and 'openssl'. The
> +  reference section shows how to quickly install those on various popular Linux
> +  distributions.
> +
> +  [:ref:`details<buildrequires_bisref>`]
> +
> +.. _sources_bissbs:
> +
> +* Retrieve the mainline Linux sources; then change into the directory holding
> +  them, as all further commands in this guide are meant to be executed from
> +  there.
> +
> +  *Note, the following describe how to retrieve the sources using a full
> +  mainline clone, which downloads about 2,75 GByte as of early 2024. The*
> +  :ref:`reference section describes two alternatives <sources_bisref>` *:
> +  one downloads less than 500 MByte, the other works better with unreliable
> +  internet connections.*
> +
> +  Execute the following command to retrieve a fresh mainline codebase::
> +
> +    git clone -o mainline --no-checkout \
> +      git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ~/linux/
> +    cd ~/linux/

This is not very nice to git-daemon. Plus, it uses the insecure git
protocol. Is it too much to show cloning from a bundle instead?

  https://www.kernel.org/cloning-linux-from-a-bundle.html

> +
> +  [:ref:`details<sources_bisref>`]
> +
> +.. _oldconfig_bissbs:
> +
> +* Start preparing a kernel build configuration (the '.config' file).
> +
> +  Before doing so, ensure you are still running the 'working' kernel an earlier
> +  step told you to boot; if you are unsure, check the current kernel release
> +  identifier using ``uname -r``.
> +
> +  Afterwards check out the source code for the version earlier established as
> +  'good' and create a .config file::
> +
> +    git checkout --detach v6.0
> +    make olddefconfig
> +
> +  The second command will try to locate the build configuration file for the
> +  running kernel and then adjust it for the needs of the kernel sources you
> +  checked out. While doing so it will print a few lines with a line starting
> +  with '# using defaults found in'. Ensure it is the former of the two and

Eh, "lines with a line" ? I suggest:

  While doing so, it will print a few lines. One of them starts with
  '# using defaults ...

> +  followed by a path to a file in '/boot/'; the latter furthermore should
> +  contain the release identifier of your currently working kernel.
> +
> +  If the line instead continued with something like

s/continued/continues/

> +  'arch/x86/configs/x86_64_defconfig', then the build infra failed to find the
> +  .config file for your running kernel -- in which case you have to put one
> +  there manually, as explained in the reference section.
> +
> +  In case you can not find such a line, look for one containing '# configuration
> +  written to .config'. If that's the case you have a stale build configuration
> +  lying around. Unless you intend to use it, delete it -- or better yet, remove

Remove "delete it -- or better yet". Don't confuse people by offering
two solutions here.

> +  all stale files you might have lying around from earlier builds using ``make
> +  distclean`` or ``git clean -i``. Afterwards call 'make olddefconfig' again.
> +
> +  [:ref:`details<oldconfig_bisref>`]
> +
> +.. _localmodconfig_bissbs:
> +
> +* Disable any kernel modules apparently superfluous for your setup. This is
> +  optional, but especially wise for bisections, as it speeds up the build
> +  process enormously -- at least unless the .config file picked up in the
> +  previous step was already tailored to your and your hardware needs, in which
> +  case you should skip this step.
> +
> +  To prepare the trimming, connect external hardware you occasionally use (USB
> +  keys, tokens, ...), quickly start a VM, and bring up VPNs. And if you rebooted
> +  since you started that guide, ensure that you tried using the feature causing
> +  trouble since you started the system. Only then trim your .config::
> +
> +     yes '' | make localmodconfig
> +
> +  There is a catch to this, as the 'apparently' in initial sentence of this step
> +  and the preparation instructions already hinted at:
> +
> +  The 'localmodconfig' target easily disables kernel modules for features only
> +  used occasionally -- like modules for external peripherals not yet connected
> +  since booting, virtualization software not yet utilized, VPN tunnels, and a
> +  few other things. That's because some tasks rely on kernel modules Linux only
> +  loads when you execute tasks like the aforementioned ones for the first time.
> +
> +  This drawback of localmodconfig is nothing you should lose sleep over, but
> +  something to keep in mind: if something is misbehaving with the kernels built
> +  during this guide, this is most likely the reason. You can reduce or nearly
> +  eliminate the risk with tricks the reference section outlines; but when

tricks outlined in the reference section

> +  building a kernel just for quick testing purposes this is usually not worth
> +  spending much effort on, as long as it boots and allows to properly test the
> +  feature that causes trouble.
> +
> +  [:ref:`details<localmodconfig_bisref>`]
> +
> +.. _tagging_bissbs:
> +
> +* Ensure all the kernels you will build are clearly identifiable using a special
> +  tag and a unique version number::
> +
> +    ./scripts/config --set-str CONFIG_LOCALVERSION '-local'
> +    ./scripts/config -e CONFIG_LOCALVERSION_AUTO
> +
> +  [:ref:`details<tagging_bisref>`]
> +
> +.. _debugsymbols_bissbs:
> +
> +* Decide how to handle debug symbols.
> +
> +  In the context of this document it is often wise to enable them, as there is a
> +  decent chance you at some point will need to decode a stack trace from a

Why not remove "at some point"? We're not paid by word, are we? ;-)

> +  'panic', 'Oops', 'warning', or 'BUG'::
> +
> +    ./scripts/config -d DEBUG_INFO_NONE -e KALLSYMS_ALL -e DEBUG_KERNEL \
> +      -e DEBUG_INFO -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT -e KALLSYMS
> +
> +  But if you are extremely short on storage space, you might want to disable
> +  debug symbols instead::
> +
> +    ./scripts/config -d DEBUG_INFO -d DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> +      -d DEBUG_INFO_DWARF4 -d DEBUG_INFO_DWARF5 -e CONFIG_DEBUG_INFO_NONE
> +
> +  [:ref:`details<debugsymbols_bisref>`]
> +
> +.. _configmods_bissbs:
> +
> +* Check if you might want to or have to adjust some other kernel configuration

Sorry, "if you might want to" is over the top. Keep it simple:

    You may need or want to adjust some other kernel configuration options:

> +  options:
> +
> +  * Are you running Debian? Then you want to avoid known problems by performing
> +    additional adjustments explained in the reference section.
> +
> +    [:ref:`details<configmods_distros_bisref>`].
> +
> +  * If you want to influence other aspects of the configuration, do so now
> +    by using make targets like 'menuconfig' or 'xconfig'.
> +
> +    [:ref:`details<configmods_individual_bisref>`].
> +
> +.. _saveconfig_bissbs:
> +
> +* Reprocess the .config after the latest adjustments and store it in a safe
> +  place::
> +
> +     make olddefconfig
> +     cp .config ~/kernel-config-working
> +
> +  [:ref:`details<saveconfig_bisref>`]
> +
> +.. _introlatestcheck_bissbs:
> +
> +Try to reproduce the problem with the latest codebase
> +-----------------------------------------------------
> +
> +The following steps verify if the problem occurs with the code developers
> +currently support. In case you face a regression, it also checks that the

code currently supported by developers

> +problem is not caused by some .config value your distributor changed between the
> +'good' and the 'broken' kernel. [:ref:`details<introlatestcheck_bisref>`]
> +
> +.. _checkoutmaster_bissbs:
> +
> +* Checkout the latest Linux codebase::

Check out ?

> +
> +    cd ~/linux/
> +    git checkout --force --detach mainline/master
> +
> +  [:ref:`details<checkoutmaster_bisref>`]
> +
> +.. _build_bissbs:
> +
> +* Build the image and the modules of your first kernel using the config file you
> +  prepared::
> +
> +    cp ~/kernel-config-working .config
> +    make olddefconfig
> +    make -j $(nproc --all)
> +
> +  If you want your kernel packaged up as deb, rpm, or tar file, see the
> +  reference section for alternatives, which obviously will require other
> +  steps to install as well.
> +
> +  [:ref:`details<build_bisref>`]
> +
> +.. _install_bissbs:
> +
> +* Install your newly built kernel.
> +
> +  Before doing so, consider checking if there is still enough room for it::
> +
> +    df -h /boot/ /lib/modules/
> +
> +  150 MByte in /boot/ and 200 in /lib/modules/ usually suffice. Those are rough
> +  estimates assuming the worst case. How much your kernels actually require will
> +  be determined later.
> +
> +  Now install the kernel, which will be saved in parallel to the kernels from
> +  your Linux distribution::
> +
> +    command -v installkernel && sudo make modules_install install
> +
> +  On many commodity Linux distributions this will take care of everything
> +  required to boot your kernel. You might want to ensure that's the case by
> +  checking if your boot loader's configuration was updated; furthermore ensure
> +  an initramfs (also known as initrd) exists, which on many distributions can be
> +  achieved by running ``ls -l /boot/init*$(make -s kernelrelease)*``. Those
> +  steps are recommended, as there are quite a few Linux distribution where above
> +  command is insufficient:
> +
> +  * On Arch Linux, its derivatives, many immutable Linux distributions, and a
> +    few others the above command does nothing at, as they lack 'installkernel'
> +    executable.
> +
> +  * Some distributions install the kernel, but don't add an entry for your
> +    kernel in your boot loader's configuration -- the kernel thus won't show up
> +    in the boot menu.
> +
> +  * Some distributions add a boot loader menu entry, but don't create an
> +    initramfs on installation -- in that case your kernel most likely will be
> +    unable to mount the root partition during bootup.
> +
> +  If any of that applies to you, see the reference section for further guidance.
> +  Once you figured out what to do, consider writing down the necessary
> +  installation steps: if you will build more kernels as described in
> +  segment 2 and 3, you will have to execute these commands every time that
> +  ``command -v installkernel [...]`` comes up again.
> +
> +  [:ref:`details<install_bisref>`]
> +
> +.. _storagespace_bissbs:
> +
> +* In case you plan to follow this guide further, check how much storage space
> +  the kernel, its modules, and other related files like the initramfs consume::
> +
> +    du -ch /boot/*$(make -s kernelrelease)* | tail -n 1
> +    du -sh /lib/modules/$(make -s kernelrelease)/
> +
> +  Write down or remember those two values for later: they enable you to prevent
> +  running out of disk space accidentally during a bisection.
> +
> +  [:ref:`details<storagespace_bisref>`]
> +
> +.. _kernelrelease_bissbs:
> +
> +* Show and store the kernelrelease identifier of the kernel you just built::
> +
> +    make -s kernelrelease | tee -a ~/kernels-built
> +
> +  Remember the identifier momentarily, as it will help you pick the right kernel
> +  from the boot menu upon restarting.
> +
> +.. _recheckbroken_bissbs:
> +
> +* Reboot into the kernel you just built and check if the feature that is
> +  expected to be broken really is.
> +
> +  Start by ensuring the kernel you booted is the one you just built. When

Start by making sure ...

> +  unsure, check if the output of these commands show the exact same release
> +  identifier::
> +
> +    tail -n 1 ~/kernels-built
> +    uname -r
> +
> + Now verify if the feature that causes trouble works with your newly built
> + kernel. If things work while investigating a regression, check the reference
> + section for further details.
> +
> +  [:ref:`details<recheckbroken_bisref>`]
> +
> +.. _recheckstablebroken_bissbs:
> +
> +* Are you facing a problem within a stable/longterm release, but failed to
> +  reproduce it with the mainline kernel you just built? Then check if the latest
> +  codebase for the particular series might already fix the problem. To do so,
> +  add the stable series Git branch for your 'good' kernel and check out the
> +  latest version::
> +
> +    cd ~/linux/
> +    git remote set-branches --add stable linux-6.0.y
> +    git fetch stable
> +    git checkout --force --detach linux-6.0.y
> +
> +  Now use the checked out code to build and install another kernel using the
> +  commands the earlier steps already described in more detail::
> +
> +    cp ~/kernel-config-working .config
> +    make olddefconfig
> +    make -j $(nproc --all)
> +    # * Check if the free space suffices holding another kernel:
> +    df -h /boot/ /lib/modules/
> +    command -v installkernel && sudo make modules_install install
> +    make -s kernelrelease | tee -a ~/kernels-built
> +    reboot
> +
> +  Now verify if you booted the kernel you intended to start, to then check if
> +  everything works fine with this kernel::
> +
> +    tail -n 1 ~/kernels-built
> +    uname -r
> +
> +  [:ref:`details<recheckstablebroken_bisref>`]
> +
> +You are done here, if you follow this guide to verify if a problem is present in

I suggest to remove the comma. But even then the second "if" confuses
me. Ideally it should be reworded somehow, but I'm too tired.

> +the code Linux kernel developers support. If you later want to remove the kernel

code supported by Linux kernel developers again?

> +you just built, checkout :ref:`Supplementary tasks: cleanup during and after
> +following this guide.<introclosure_bissbs>`.
> +
> +.. _introworkingcheck_bissbs:
> +
> +Check if the kernels you build work fine
> +----------------------------------------
> +
> +In case of a regression, you now want to ensure the trimmed configuration file
> +you created earlier works as expected; a bisection with the .config file
> +otherwise would be useless. [:ref:`details<introworkingcheck_bisref>`]
> +
> +.. _recheckworking_bissbs:
> +
> +* Build your own variant of the 'working' kernel and check if the feature that
> +  regressed works as expected with it.
> +
> +  Start by checking out the sources for the version earlier established as
> +  'good'::
> +
> +    cd ~/linux/
> +    git checkout --detach v6.0
> +
> +  Now use the checked out code to configure, build, and install another kernel
> +  using the commands the previous subsection explained in more detail::
> +
> +    cp ~/kernel-config-working .config
> +    make olddefconfig
> +    make -j $(nproc --all)
> +    # * Check if the free space suffices holding another kernel:
> +    df -h /boot/ /lib/modules/
> +    command -v installkernel && sudo make modules_install install
> +    make -s kernelrelease | tee -a ~/kernels-built
> +    reboot
> +
> +  When the system booted, you once again might want to verify if the kernel yo

When the system boots, you may want to verify once again that the
kernel you started is the one you just built::

> +  started is the one you just built::
> +
> +    tail -n 1 ~/kernels-built
> +    uname -r
> +
> +  Now check if this kernel works as expected; if not, consult the reference
> +  section for further instructions.
> +
> +  [:ref:`details<recheckworking_bisref>`]
> +
> +.. _introbisect_bissbs:
> +
> +Perform the bisection and validate the result
> +---------------------------------------------
> +
> +With all the preparations and precaution builds taken care of, you are now ready
> +to begin the bisection.
> +
> +* In case your 'bad' version is a stable/longterm release (say v6.1.5), add its
> +  stable branch, unless you already did so earlier::
> +
> +    cd ~/linux/
> +    git remote add -t master stable \
> +      git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable.git

Naked git protocol again?

> +    git remote set-branches --add stable linux-6.1.y
> +    git fetch stable
> +
> +.. _bisectstart_bissbs:
> +
> +* Start the bisection and tell Git about the versions earlier established as
> +  'good' and 'bad'::
> +
> +    cd ~/linux/
> +    git bisect start
> +    git bisect good v6.0
> +    git bisect bad v6.1.5
> +
> +  [:ref:`details<bisectstart_bisref>`]
> +
> +.. _bisectbuild_bissbs:
> +
> +* Now use the code Git checked out to build, install, and boot a kernel using
> +  the commands introduced earlier::
> +
> +    cp ~/kernel-config-working .config
> +    make olddefconfig
> +    make -j $(nproc --all)
> +    # * Check if the free space suffices holding another kernel:
> +    df -h /boot/ /lib/modules/
> +    command -v installkernel && sudo make modules_install install
> +    make -s kernelrelease | tee -a ~/kernels-built
> +    reboot
> +
> +  If compilation fails for some reason, run ``git bisect skip`` and restart
> +  executing the stack of commands from the beginning.
> +
> +  In case you skipped the "test latest codebase" step in the guide, check its
> +  description as for why the 'df [...]' and 'make -s kernelrelease [...]'
> +  commands are here.
> +
> +  Important note:, the latter command from this point on will print release
> +  identifiers that might look odd or wrong to you -- which they are not, as it's
> +  totally normal to see release identifiers like '6.0-rc1-local-gcafec0cacaca0'
> +  if you for example would bisect between versions 6.1 and 6.2.

Remove "would". Move "for example" to the end of the sentence.

> +
> +  [:ref:`details<bisectbuild_bisref>`]
> +
> +.. _bisecttest_bissbs:
> +
> +* Now check if the feature that regressed works in the kernel you just built.
> +
> +  You again might want to start by ensuring the kernel you booted is the one you

making sure

> +  just built::
> +
> +    cd ~/linux/
> +    tail -n 1 ~/kernels-built
> +    uname -r
> +
> +  Now verify if the feature that regressed works at this kernel bisection point.
> +  If it does, run this::
> +
> +    git bisect good
> +
> +  If it does not, run this::
> +
> +    git bisect bad
> +
> +  Be sure about what you tell Git, as getting this wrong just once will send the
> +  rest of the bisection totally of course.

I guess this should be "off course".

> +
> +  While the bisection is ongoing, Git will use the information you provided to
> +  find and checkout another bisection point for you to test. While doing so, it

check out

> +  will print something like 'Bisecting: 675 revisions left to test after this
> +  (roughly 10 steps)' to indicate how many further changes it expects to be
> +  tested. Now build and install another kernel using the instructions from the
> +  previous step; afterwards follow the instructions in this step again.
> +
> +  Repeat this again and again until you finish the bisection -- that's the case
> +  when Git after tagging a change as 'good' or 'bad' prints something like
> +  'cafecaca0c0dacafecaca0c0dacafecaca0c0da is the first bad commit'; right
> +  afterwards it will show some details about the culprit including the patch
> +  description of the change. The latter might fill your terminal screen, so you
> +  might need to scroll up to see the message mentioning the culprit;
> +  alternatively, run ``git bisect log > ~/bisection-log``.
> +
> +  [:ref:`details<bisecttest_bisref>`]
> +
> +.. _bisectlog_bissbs:
> +
> +* Store Git's bisection log and the current .config file in a safe place before
> +  telling Git to reset the sources to the state before the bisection::
> +
> +    cd ~/linux/
> +    git bisect log > ~/bisection-log
> +    cp .config ~/bisection-config-culprit
> +    git bisect reset
> +
> +  [:ref:`details<bisectlog_bisref>`]
> +
> +.. _revert_bissbs:
> +
> +* Try reverting the culprit on top of latest mainline to see if this fixes your
> +  regression.
> +
> +  This is optional, as it might be impossible or hard to realize. The former is
> +  the case, if the bisection determined a merge commit as the culprit; the
> +  latter happens if other changes depend on the culprit. But if the revert
> +  succeeds, it is worth building another kernel, as it validates the result of
> +  a bisection, which can easily deroute; it furthermore will let kernel
> +  developers know, if they can resolve the regression with a quick revert.
> +
> +  Begin by checking out the latest codebase depending on the range you bisected:
> +
> +  * Did you face a regression within a stable/longterm series (say between
> +    6.0.11 and 6.0.13) that does not happen in mainline? Then checkout the
> +    latest codebase for the affected series like this::
> +
> +      git fetch stable
> +      git checkout --force --detach linux-6.0.y
> +
> +  * In all other cases checkout latest mainline::
> +
> +      git fetch mainline
> +      git checkout --force --detach mainline/master
> +
> +    If you bisected a regression within a stable/longterm series that also
> +    happens in mainline, there is one more thing to do: look up the mainline
> +    commit-id. To do so, use a command like ``git show abcdcafecabcd`` to view
> +    the patch description of the culprit. It near the top will have a line like

There will be a line near the top which looks like

> +    'commit cafec0cacaca0 upstream.' or 'Upstream commit cafec0cacaca0; use that
> +    commit-id in the next command and not the one the bisection blamed.
> +
> +  Now try reverting the culprit by specifying its commit id::
> +
> +    git revert --no-edit cafec0cacaca0
> +
> +  If that fails, give up trying and move on to the next step. But if it works,
> +  build a kernel again using the familiar command sequence::
> +
> +    cp ~/kernel-config-working .config
> +    make olddefconfig &&
> +    make -j $(nproc --all) &&
> +    # * Check if the free space suffices holding another kernel:
> +    df -h /boot/ /lib/modules/
> +    command -v installkernel && sudo make modules_install install
> +    Make -s kernelrelease | tee -a ~/kernels-built
> +    reboot
> +
> +  Now check one last time if the feature that made you perform a bisection work
> +  with that kernel.
> +
> +  [:ref:`details<revert_bisref>`]
> +
> +.. _introclosure_bissbs:
> +
> +Supplementary tasks: cleanup during and after the bisection
> +-----------------------------------------------------------
> +
> +During and after following this guide you might want or need to remove some of
> +the kernels you installed: the boot menu otherwise will become confusing or
> +space might run out.
> +
> +.. _makeroom_bissbs:
> +
> +* To remove one of the kernels you installed, look up its 'kernelrelease'
> +  identifier. This guide stores them in '~/kernels-built', but the following
> +  command will print them as well::
> +
> +    ls -ltr /lib/modules/*-local*
> +
> +  You in most situations want to remove the oldest kernels built during the
> +  actual bisection (e.g. segment 3 of this guide). The two ones you created
> +  beforehand (e.g. to test the latest codebase and the version considered
> +  'good') might become handy to verify something later -- thus better keep them
> +  around, unless you are really short on storage space.
> +
> +  To remove the modules of a kernel with the kernelrelease identifier
> +  '*6.0-rc1-local-gcafec0cacaca0*', start by removing the directory holding its
> +  modules::
> +
> +    sudo rm -rf /lib/modules/6.0-rc1-local-gcafec0cacaca0
> +
> +  Afterwards try the following command::
> +
> +    sudo kernel-install -v remove 6.0-rc1-local-gcafec0cacaca0
> +
> +  On quite a few distributions this will delete all other kernel files installed
> +  while also removing the kernel's entry from the boot menu. But on some
> +  distributions this command does not exist or will fail; in that case consult
> +  the reference section, as your Linux distribution needs special care.
> +
> +  [:ref:`details<makeroom_bisref>`]
> +
> +.. _finishingtouch_bissbs:
> +
> +* Once you have finished the bisection, do not immediately remove anything you
> +  set up, as you might need a few things again. What is safe to remove depends
> +  on the outcome of the bisection:
> +
> +  * Could you initially reproduce the regression with the latest codebase and
> +    after the bisection were able to fix the problem by reverting the culprit on
> +    top of the latest codebase? Then you want to keep those two kernels around
> +    for a while, but safely remove all others with a '-local' in the release
> +    identifier.
> +
> +  * Did the bisection end on a merge-commit or seems questionable for other
> +    reasons? Then you want to keep as many kernels as possible around for a few
> +    days: it's pretty likely that you will be asked to recheck something.
> +
> +  * In other cases it likely is a good idea to keep the following kernels around
> +    for some time: the one built from the latest codebase, the one created from
> +    the version considered 'good', and the last three or four you compiled
> +    during the actual bisection process.
> +
> +  [:ref:`details<finishingtouch_bisref>`]
> +
> +.. _submit_improvements:
> +
> +This concludes the step-by-step guide.
> +
> +Did you run into trouble following any of the above steps not cleared up by the
> +reference section below? Did you spot errors? Or do you have ideas how to
> +improve the guide? Then please take a moment and let the maintainer of this
> +document know by email (Thorsten Leemhuis <linux@leemhuis.info>), ideally while
> +CCing the Linux docs mailing list (linux-doc@vger.kernel.org). Such feedback is
> +vital to improve this document further, which is in everybody's interest, as it
> +will enable more people to master the task described here -- and hopefully also
> +improve similar guides inspired by this one.
> +
> +
> +Reference section for the step-by-step guide
> +============================================
> +
> +This section holds additional information for almost all the items in above

..in the above...

> +step-by-step guide.
> +
> +.. _backup_bisref:
> +
> +Prepare for emergencies
> +-----------------------
> +
> +  *Create a fresh backup and put system repair and restore tools at hand.*
> +  [:ref:`... <backup_bissbs>`]
> +
> +Remember, you are dealing with computers, which sometimes do unexpected things
> +-- especially if you fiddle with crucial parts like the kernel of an operating
> +system. That's what you are about to do in this process. Hence, better prepare
> +for something going sideways, even if that should not happen.
> +
> +[:ref:`back to step-by-step guide <backup_bissbs>`]
> +
> +.. _vanilla_bisref:
> +
> +Remove anything related to externally maintained kernel modules
> +---------------------------------------------------------------
> +
> +  *Remove all software that depends on externally developed kernel drivers or
> +  builds them automatically.* [:ref:`...<vanilla_bissbs>`]
> +
> +Externally developed kernel modules can easily cause trouble during a bisection.
> +
> +But there is a more important reason why this guide contains this step: most
> +kernel developers will not care about reports about regressions occurring with
> +kernels that utilize such modules. That's because such kernels are not
> +considered 'vanilla' anymore, as Documentation/admin-guide/reporting-issues.rst
> +explains in more detail.
> +
> +[:ref:`back to step-by-step guide <vanilla_bissbs>`]
> +
> +.. _secureboot_bisref:
> +
> +Deal with techniques like Secure Boot
> +-------------------------------------
> +
> +  *On platforms with 'Secure Boot' or similar techniques, prepare everything to
> +  ensure the system will permit your self-compiled kernel to boot later.*
> +  [:ref:`... <secureboot_bissbs>`]
> +
> +Many modern systems allow only certain operating systems to start; they thus by
> +default will reject booting self-compiled kernels.

that's why they reject booting self-compiled kernels by default.

> +
> +You ideally deal with this by making your platform trust your self-built kernels
> +with the help of a certificate. How to do that is not described
> +here, as it requires various steps that would take the text too far away from
> +its purpose; 'Documentation/admin-guide/module-signing.rst' and various web
> +sides already explain everything needed in more detail.
> +
> +Temporarily disabling solutions like Secure Boot is another way to make your own
> +Linux boot. On commodity x86 systems it is possible to do this in the BIOS Setup
> +utility; the required steps vary a lot between machines and therefore cannot be
> +described here.
> +
> +On mainstream x86 Linux distributions there is a third and universal option:
> +disable all Secure Boot restrictions for your Linux environment. You can
> +initiate this process by running ``mokutil --disable-validation``; this will
> +tell you to create a one-time password, which is safe to write down. Now
> +restart; right after your BIOS performed all self-tests the bootloader Shim will
> +show a blue box with a message 'Press any key to perform MOK management'. Hit
> +some key before the countdown exposes, which will open a menu. Choose 'Change
> +Secure Boot state'. Shim's 'MokManager' will now ask you to enter three
> +randomly chosen characters from the one-time password specified earlier. Once
> +you provided them, confirm you really want to disable the validation.
> +Afterwards, permit MokManager to reboot the machine.
> +
> +[:ref:`back to step-by-step guide <secureboot_bissbs>`]
> +
> +.. _bootworking_bisref:

I stop here and call it a week. I may read the rest later. Hope even
this much helps .

Petr T

