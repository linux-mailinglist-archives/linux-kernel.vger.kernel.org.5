Return-Path: <linux-kernel+bounces-36958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B304B83A983
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41121C21DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FE363110;
	Wed, 24 Jan 2024 12:19:37 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23B96312C;
	Wed, 24 Jan 2024 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098774; cv=none; b=ct5vyCXFRmNLZ4J3+hpkEMCP/CIdCSbr3yNnZWMlS7DRiR+kSPpMxJjpDbBY9m27shP26akX3boD3Ns5UK0AhlKiEI+WYkvSN0NcgevUDnBG0ODSbumaWuZblvjHoXJygwfSyUEbR4pp1a0K4HNPV+yX74DejlgD66CM/7+ZoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098774; c=relaxed/simple;
	bh=wnThrXEhj9tkW+03/Sw41dFawmLcK20n4GbJQ6TVlps=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Xe4OAOl6JtQcx1kHCk4txHSo8G9x//gSwGjqOtdhNrOoH+opgTGGzT3YjRWksX/fpJDnFA5avaOuxmprJwoMncapiTQ5QoJunA/sIVFmD0HmmdvzXeKdynmlIJC5/N+7HdpXrNWGQOcKM1/ZwfcRwQTqkjHsprmlMuOzw/ayQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rScDt-0006LK-4B; Wed, 24 Jan 2024 13:19:17 +0100
Message-ID: <c763e15e-e82e-49f8-a540-d211d18768a3@leemhuis.info>
Date: Wed, 24 Jan 2024 13:19:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <linux@leemhuis.info>
Autocrypt: addr=linux@leemhuis.info; keydata=
 xsFNBFJ4AQ0BEADCz16x4kl/YGBegAsYXJMjFRi3QOr2YMmcNuu1fdsi3XnM+xMRaukWby47
 JcsZYLDKRHTQ/Lalw9L1HI3NRwK+9ayjg31wFdekgsuPbu4x5RGDIfyNpd378Upa8SUmvHik
 apCnzsxPTEE4Z2KUxBIwTvg+snEjgZ03EIQEi5cKmnlaUynNqv3xaGstx5jMCEnR2X54rH8j
 QPvo2l5/79Po58f6DhxV2RrOrOjQIQcPZ6kUqwLi6EQOi92NS9Uy6jbZcrMqPIRqJZ/tTKIR
 OLWsEjNrc3PMcve+NmORiEgLFclN8kHbPl1tLo4M5jN9xmsa0OZv3M0katqW8kC1hzR7mhz+
 Rv4MgnbkPDDO086HjQBlS6Zzo49fQB2JErs5nZ0mwkqlETu6emhxneAMcc67+ZtTeUj54K2y
 Iu8kk6ghaUAfgMqkdIzeSfhO8eURMhvwzSpsqhUs7pIj4u0TPN8OFAvxE/3adoUwMaB+/plk
 sNe9RsHHPV+7LGADZ6OzOWWftk34QLTVTcz02bGyxLNIkhY+vIJpZWX9UrfGdHSiyYThHCIy
 /dLz95b9EG+1tbCIyNynr9TjIOmtLOk7ssB3kL3XQGgmdQ+rJ3zckJUQapLKP2YfBi+8P1iP
 rKkYtbWk0u/FmCbxcBA31KqXQZoR4cd1PJ1PDCe7/DxeoYMVuwARAQABzSdUaG9yc3RlbiBM
 ZWVtaHVpcyA8bGludXhAbGVlbWh1aXMuaW5mbz7CwZQEEwEKAD4CGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AWIQSoq8a+lZZX4oPULXVytubvTFg9LQUCX31PIwUJFmtPkwAKCRBytubv
 TFg9LWsyD/4t3g4i2YVp8RoKAcOut0AZ7/uLSqlm8Jcbb+LeeuzjY9T3mQ4ZX8cybc1jRlsL
 JMYL8GD3a53/+bXCDdk2HhQKUwBJ9PUDbfWa2E/pnqeJeX6naLn1LtMJ78G9gPeG81dX5Yq+
 g/2bLXyWefpejlaefaM0GviCt00kG4R/mJJpHPKIPxPbOPY2REzWPoHXJpi7vTOA2R8HrFg/
 QJbnA25W55DzoxlRb/nGZYG4iQ+2Eplkweq3s3tN88MxzNpsxZp475RmzgcmQpUtKND7Pw+8
 zTDPmEzkHcUChMEmrhgWc2OCuAu3/ezsw7RnWV0k9Pl5AGROaDqvARUtopQ3yEDAdV6eil2z
 TvbrokZQca2808v2rYO3TtvtRMtmW/M/yyR233G/JSNos4lODkCwd16GKjERYj+sJsW4/hoZ
 RQiJQBxjnYr+p26JEvghLE1BMnTK24i88Oo8v+AngR6JBxwH7wFuEIIuLCB9Aagb+TKsf+0c
 HbQaHZj+wSY5FwgKi6psJxvMxpRpLqPsgl+awFPHARktdPtMzSa+kWMhXC4rJahBC5eEjNmP
 i23DaFWm8BE9LNjdG8Yl5hl7Zx0mwtnQas7+z6XymGuhNXCOevXVEqm1E42fptYMNiANmrpA
 OKRF+BHOreakveezlpOz8OtUhsew9b/BsAHXBCEEOuuUg87BTQRSeAENARAAzu/3satWzly6
 +Lqi5dTFS9+hKvFMtdRb/vW4o9CQsMqL2BJGoE4uXvy3cancvcyodzTXCUxbesNP779JqeHy
 s7WkF2mtLVX2lnyXSUBm/ONwasuK7KLz8qusseUssvjJPDdw8mRLAWvjcsYsZ0qgIU6kBbvY
 ckUWkbJj/0kuQCmmulRMcaQRrRYrk7ZdUOjaYmjKR+UJHljxLgeregyiXulRJxCphP5migoy
 ioa1eset8iF9fhb+YWY16X1I3TnucVCiXixzxwn3uwiVGg28n+vdfZ5lackCOj6iK4+lfzld
 z4NfIXK+8/R1wD9yOj1rr3OsjDqOaugoMxgEFOiwhQDiJlRKVaDbfmC1G5N1YfQIn90znEYc
 M7+Sp8Rc5RUgN5yfuwyicifIJQCtiWgjF8ttcIEuKg0TmGb6HQHAtGaBXKyXGQulD1CmBHIW
 zg7bGge5R66hdbq1BiMX5Qdk/o3Sr2OLCrxWhqMdreJFLzboEc0S13BCxVglnPqdv5sd7veb
 0az5LGS6zyVTdTbuPUu4C1ZbstPbuCBwSwe3ERpvpmdIzHtIK4G9iGIR3Seo0oWOzQvkFn8m
 2k6H2/Delz9IcHEefSe5u0GjIA18bZEt7R2k8CMZ84vpyWOchgwXK2DNXAOzq4zwV8W4TiYi
 FiIVXfSj185vCpuE7j0ugp0AEQEAAcLBfAQYAQoAJgIbDBYhBKirxr6Vllfig9QtdXK25u9M
 WD0tBQJffU8wBQkWa0+jAAoJEHK25u9MWD0tv+0P/A47x8r+hekpuF2KvPpGi3M6rFpdPfeO
 RpIGkjQWk5M+oF0YH3vtb0+92J7LKfJwv7GIy2PZO2svVnIeCOvXzEM/7G1n5zmNMYGZkSyf
 x9dnNCjNl10CmuTYud7zsd3cXDku0T+Ow5Dhnk6l4bbJSYzFEbz3B8zMZGrs9EhqNzTLTZ8S
 Mznmtkxcbb3f/o5SW9NhH60mQ23bB3bBbX1wUQAmMjaDQ/Nt5oHWHN0/6wLyF4lStBGCKN9a
 TLp6E3100BuTCUCrQf9F3kB7BC92VHvobqYmvLTCTcbxFS4JNuT+ZyV+xR5JiV+2g2HwhxWW
 uC88BtriqL4atyvtuybQT+56IiiU2gszQ+oxR/1Aq+VZHdUeC6lijFiQblqV6EjenJu+pR9A
 7EElGPPmYdO1WQbBrmuOrFuO6wQrbo0TbUiaxYWyoM9cA7v7eFyaxgwXBSWKbo/bcAAViqLW
 ysaCIZqWxrlhHWWmJMvowVMkB92uPVkxs5IMhSxHS4c2PfZ6D5kvrs3URvIc6zyOrgIaHNzR
 8AF4PXWPAuZu1oaG/XKwzMqN/Y/AoxWrCFZNHE27E1RrMhDgmyzIzWQTffJsVPDMQqDfLBhV
 ic3b8Yec+Kn+ExIF5IuLfHkUgIUs83kDGGbV+wM8NtlGmCXmatyavUwNCXMsuI24HPl7gV2h n7RI
Subject: More detailed text about bisecting Linux kernel regression -- request
 for comments and help
To: Linux kernel regressions list <regressions@lists.linux.dev>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1706098768;06af79d6;
X-HE-SMSGID: 1rScDt-0006LK-4B

Hi! Find below a WIP text on bisecting Linux kernel regressions I plan
to submit for inclusion in the Linux kernel documentation in a month or
two. I could do so now, but chose to write this mail instead, as the
text would really benefit from a few people actually testing the given
instructions. Hence if you notice somebody that faces a regression that
needs bisecting, consider poiting them them to this text, asking them to
play through this and provide feedback to me.

Ideally point users to the following rendered version:
https://www.leemhuis.info/files/misc/How%20to%20bisect%20a%20Linux%20kernel%20regression%20%e2%80%94%20The%20Linux%20Kernel%20documentation.html


It is (a) a lot easier to read (b) has no odd or broken line breaks,
like the text below has a few (sorry!) (c) is updated when I improve
something.

Anyone who might be willing to provide feedback can do so in a reply
here or by modifying the following document (which for copyright reasons
is just a copy of the document I use to prepared the text for the actual
submission):
https://docs.google.com/document/d/1Im7SPK0j6PUGQTSGZyCTSQv8h3S51EYsZuRRdyhfzto/edit?usp=sharing

Ciao, Thorsten


--- WIP patch description

docs: add a new text on verifying and bisecting a regression

Add a text describing how to verify and bisect a Linux kernel
regression. It targets users that normally run kernels from their Linux
distributor that might never have compiled a kernel beforehand.

Style and structure of the text matches
Documentation/admin-guide/quickly-build-trimmed-linux.rst. Some parts
are even copied from there and not changed at all or only slightly. This
will complicate maintenance, as some future changes to one of these
documents will have to be replicated in the other; but this is the
lesser evil, as anything else would make things a lot harder for
readers. Solutions like "sending them from one document over to the
other" or "extracting the common parts into a separate document" might
work in other cases, but not for the audience these texts aim at.

The text tries to prevent users running into a few common error cases.
The commands taking care of that might be superfluous for people that
are already familiar with bisections, but users with that knowledge
should be able to adapt the instructions to their use-case.

The document covers more than just the bisection to ensure readers find
everything here they need to do when facing a regression. That is why
the first kernel the text tells users to build comes from a fresh
codebase, as that is needed to rule out the regression (a) was fixed
already or (b) is caused by config change their distributor did.
Checking this is also needed to determine if the issue is something for
the regular developer or the stable team to handle.

Only then are readers instructed to build their own variant of the
'good' kernel to validate the .config file before using it in a
bisection. Readers might thus have to go back to square one if there is
a problem with the .config. But that should only occur occasionally --
and some readers will never get to this step at all, as the regression
was already fixed. Hence in the end this order will hopefully mean users
will build less kernels overall.

This order furthermore should allow using this text nicely together with
Documentation/admin-guide/reporting-issues.rst, which early on tells
users to test the latest codebase and rule out the problem is caused by
a deliberate .config change. They thus can do so with this guide and
when needed just continue following it to bisect a regression.


--- WIP text that will accompany the patch description during the
submission:

Hi! This is a late Christmas gift, as Thorsten was (by choice) "home
alone" shortly before and during Christmas and decided he needed some
distraction. Stupid idea, I know, but whatever, here we are.

A few remarks:

* The patch description already highlights an aspect wrt to the order of
tasks (e.g. building the latest codebase first to only then validate the
config using a 'good' version). The imperative mood makes it sounds
like I'm pretty settled on that order, but that's not the case: I'm open
to changing this, if somebody makes a good case for swapping. If we
stick to the current order I'll likely update
Documentation/admin-guide/reporting-issues.rst and tell readers to
execute the preparation and segment 1 of this document when facing a bug
or regression -- and to continue with the guide if they actually need to
bisect the regression.

* The text as of now does not really describe what a bitsection is --
neither in general nor in the scope of Git. Maybe that should be added.
Having a few nice graphical diagrams might also be good, as the text is
meant to be read in rendered form anyway; but at least the latter is
something for later.

* Side note: maybe we might want to add big chunks of
https://nathanchance.dev/posts/working-with-git-bisect/ to the kernel's
documentation as well (assuming Nathan agrees) -- not sure if here or in
a separate document would be best. There is likely other stuff at
different places that might be good to include; like the "how find two
changes from independently developed trees that when merged create
trouble" bits Uwe recently mentioned in
https://lore.kernel.org/all/gevqxytidg5efylozindaqntkbl4yeoyzqnh5m3ylitmipgum3@sgmv7qieo7rs/
 But it's something definitely for later.


--- WIP text

 .. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0) .. [see the bottom
of this file for redistribution information]

==================================================
How to verify and bisect a Linux kernel regression
==================================================

This document describes how to check if some breakage with a newer Linux
kernel version is a regression -- and how to find the change causing it,
if the problem is one.

The text targets users running mainstream Linux distributions on
commodity hardware who want to report a problem to the upstream Linux
developers. In other words: people who run distributions from projects
like Arch Linux, Debian, Fedora, openSUSE, or Ubuntu who ran into
trouble with a kernel update their distributor released -- trouble that
can be resolved by booting into the previous kernel again.

The instructions despite this aim work just as well for users who are
already familiar with building and installing their own Linux kernels:
they help avoid mistakes that even experienced developers sometimes make.

The essence of the process (aka 'TL;DR')
========================================

*[If you are new to bisecting Linux, ignore this TLDR and head over to
the "step-by-step guide on how to bisect a Linux kernel regression"
below: it utilizes the same commands as used here while describing them
in brief fashion. That guide is nevertheless easy to follow and together
with accompanying entries in a reference section mentions many
alternatives, pitfalls, and additional aspects, all of which might be
relevant for you.]*

The following example assumes Linux 6.0.13 was the last known 'working'
kernel while 6.1.5 was the first known to be 'broken'; a bisection
therefore will be performed between the Git tags 'v6.0' and 'v6.1.5'.

* Preliminaries: set up everything to build your own kernels::

    # * Remove any software depending on externally maintained kernel
modules or
    #   building them automatically during bootup.
    # * Ensure Secure Boot permits booting self-compiled Linux kernels.
    # * Boot into the last 'working' kernel.
    # * Install compilers and everything else needed for building Linux.
    # * Ensure to have 12 Gigabyte free space in your home directory.
    git clone --no-checkout --depth 1 -b master \
      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
~/linux/
    cd ~/linux/
    git remote set-branches --add origin linux-6.1.y
    git fetch --shallow-exclude=v5.18 origin
    git checkout --detach v6.0
    # * Hint: in case you rebooted in between, ensure you are still
running the
    #   latest 'working' kernel.
    # * Hint: if you used an existing clone, ensure no stale .config is
around.
    make olddefconfig
    # * Ensure the former command picked the .config of your running kernel.
    # * Ensure you briefly used the feature that regressed since you booted;
    #   furthermore connect external hardware (USB keys, tokens, ...), start
    #   a VM, bring up VPNs, ...
    yes '' | make localmodconfig
    ./scripts/config --set-str CONFIG_LOCALVERSION '-bisect'
    ./scripts/config -e CONFIG_LOCALVERSION_AUTO
    # * Note, the next command enables debug symbols; if you are short on
    #   storage space, you might want to disable them instead.
    ./scripts/config -d DEBUG_INFO_NONE -e KALLSYMS_ALL -e DEBUG_KERNEL \
      -e DEBUG_INFO -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT -e KALLSYMS
    # * Hint: at this point you might want to adjust the build
configuration;
    #   you'll have to, if you are running Debian. See the guide for
details.
    make olddefconfig
    cp .config ~/bisection-config-base

* Segment 1: build a kernel from the latest mainline codebase.

  This among others checks if the regression was fixed already, if a
config file change might cause the problem, and which developers later
need to be told about the problem.

  a) Start by checking out latest mainline::

       cd ~/linux/
       git checkout --force --detach origin/master

  b) Build, install, and boot a kernel::

       cp ~/bisection-config-base .config
       make olddefconfig
       make -j $(nproc --all)
       # * Ensure free storage space suffices holding another kernel:
       df -h /boot/ /lib/modules/
       # * Note: on Arch Linux and a few other distributions the following
       #   commands will do nothing at all or only part of the job. See the
       #   step-by-step guide for details.
       command -v installkernel && sudo make modules_install install
       # * Check how much space your self-built kernel actually needs, which
       #   enables you to make better estimates later:
       du -ch /boot/*$(make -s kernelrelease)* | tail -n 1
       du -sh /lib/modules/$(make -s kernelrelease)/
       # * Hint: the output of the following command will help you pick the
       #   right kernel from the boot menu:
       make -s kernelrelease | tee -a ~/bisection-kernels-built
       reboot
       # * Once booted, ensure you are running the kernel you just built by
       #   checking if the output of the next two commands matches.
       tail -n 1 ~/bisection-kernels-built
       uname -r

  c) Check if the regressions occur with this kernel as well (which is
assumed to be the case for the TLDR).

* Segment 2: reestablish a known 'working' kernel.

  This among others verifies the trimmed .config file actually works
well, as bisecting with it otherwise would be a waste of time:

  a) Start by checking out the code you want to build::

       cd ~/linux/
       git checkout --force --detach v6.0

  b) Build, install, and boot a kernel as described earlier in *segment
1, section b* -- just feel free to skip the 'du' commands, as you have a
rough estimate already.

  c) Ensure the feature that regressed with the 'broken' kernel actually
works with this one.

* Segment 3: perform and validate the bisection.

  a) Begin the bisection::

       cd ~/linux/
       git bisect start
       git bisect good v6.0
       git bisect bad v6.1.5

  b) Build, install, and boot a kernel as described earlier in *segment
1, section b*.

     In case building or booting the kernel fails for unrelated reasons,
run ``git bisect skip``. In all other outcomes, check if the regressed
feature works with the newly built kernel. If it does, tell Git by
executing ``git bisect good``; if it does not, run ``git bisect bad``
instead.

     All three commands will make Git checkout another commit; then
re-execute this step (e.g. build, install, boot, and test a kernel to
then tell Git the outcome). Do so again and again until Git shows which
commit broke things. If you run short of disk space during this process,
checkout the "Supplementary tasks" section below.

  c) Once your finished the bisection, put a few things away::

       cd ~/linux/
       git bisect log > ~/bisect-log
       cp .config ~/bisection-config-culprit
       git bisect reset

  d) Try to verify the bisection result::

       git checkout --force --detach origin/master
       git revert --no-edit cafec0cacaca0

     This is optional, as it is impossible to revert some commits. But
if the second command worked flawlessly, build, install, and boot one
more kernel kernel, which should not show the regression.

* Supplementary tasks: cleanup during and after the bisection.

  a) To avoid running out of disk space while following this guide, you
might need to remove some kernels you built earlier. You most likely
want to keep those you built during segment 1 and 2 around for a while,
but are unlikely to need any again you tested during the actual
bisection (Segment 3 b). You can list them in build order using::

       ls -ltr /lib/modules/*-bisect*

     To then for example erase a kernel that identifies itself as
'6.0-rc1-bisect-gcafec0cacaca0', use this::

       sudo rm -rf /lib/modules/6.0-rc1-bisect-gcafec0cacaca0
       sudo kernel-install -v remove 6.0-rc1-bisect-gcafec0cacaca0
       # * Note, if kernel-install is not found, you will have to
       #   manually remove the kernel.

  b) Once you tried to validate the bisection result you might want to
remove some or all kernel build during the actual bisection; others you
might want to keep around for a week or two, as explained in the
step-by-step guide.

. _introguide_bissbs:

Step-by-step guide on how to verify and bisect a Linux kernel regression
========================================================================

.
   Note: if you see this note, you are reading the text's source file. You
   might want to switch to a rendered version: it makes it a lot easier to
   read and navigate this document, especially when you want to look
something
   up in the reference section to then jump back to where you left off.
.
   Find a the latest rendered version of this text here:

https://docs.kernel.org/admin-guide/verify-and-bisect-regressions.rst.html

This guide describes how to check if some problem with a newer kernel is
a regression before explaining how to find its cause. The goal is to
cover everything typically needed when something broke or works
considerably worse after updating the kernel of a mainstream Linux
distribution running on commodity computers or servers.

This step by step guide separates the process into five segments:

 :ref:`Preliminaries: set up everything to build your own
kernels.<introprep_bissbs>`

 :ref:`1. Check if you can reproduce the
regression.<introlatestcheck_bissbs>`

 :ref:`2. Check if the kernels you build work
fine.<introworkingcheck_bissbs>`

 :ref:`3. Perform a bisection and validate it.<introbisect_bissbs>`

 :ref:`Supplementary tasks: cleanup during and after the
bisection.<introclosure_bissbs>`

The steps in each segment illustrate the important aspects of the
process, while a comprehensive reference section holds additional
details for each of them. The latter sometimes also outlines alternative
approaches, pitfalls, as well as problems that might occur at the
particular step -- and how to then get things rolling again.

Be aware *segment 1* describes how to build, install and remove your own
kernel; the command introduced there will be used in later segments in
bulk fashion without further explanation.

*Segment 1* and *segment 2* are not strictly required. If you consider
skipping them, be sure to read the accompanying entries in the reference
section: it might prevent you from wasting a lot of time and effort on a
meaningless bisection.

Be aware that *segment 3* will require you to build quite a few kernels
-- usually about 15 in case you encountered a problem when updating from
say 6.0.11 to 6.1.3. Due to the trimmed build configuration file used
this works a lot faster than many people assume, as it on average will
only take about 7 to 15 minutes to compile each of those kernels on
commodity x86 machines.

Further details on what actually qualifies as a regression can be found
in Documentation/admin-guide/reporting-regressions.rst.

For instructions on how to report an issue with the Linux kernel,
consult Documentation/admin-guide/reporting-issues.rst. They work in
conjunction: when that guide tells you to compile a kernel, just follow
the instructions until the end of *segment 2* -- that way you can just
continue with *segment 3* later in case a bisection turns out to be
actually needed.

. _introprep_bissbs:

Prepare everything to build your own kernels
--------------------------------------------

The steps in this section will set everything up for further tests and
the bisection.

. _backup_bissbs:

* Create a fresh backup and put system repair and restore tools at hand,
just to be prepared for the unlikely case of something going sideways.

  [:ref:`details<backup_bisref>`]

. _vanilla_bissbs:

* Remove all software that depends on externally developed kernel
drivers or builds them automatically. That includes but is not limited
to DKMS, openZFS, VirtualBox, and Nvidia's graphics drivers (including
the GPLed kernel module).

  [:ref:`details<vanilla_bisref>`]

. _secureboot_bissbs:

* On platforms with 'Secure Boot' or similar solutions, prepare
everything to ensure the system will permit your self-compiled kernel to
boot. The quickest and easiest way to achieve this on commodity x86
systems is to disable such techniques in the BIOS setup utility;
alternatively, remove their restrictions through a process initiated by
``mokutil --disable-validation``.

  [:ref:`details<secureboot_bisref>`]

. _bootworking_bissbs:

* Boot into the last working kernel and briefly recheck if the feature
that regressed really works.

  [:ref:`details<bootworking_bisref>`]

. _buildrequires_bissbs:

* Install all software required to build a Linux kernel. Often you will
need: 'bc', 'binutils' ('ld' et al.), 'bison', 'flex', 'gcc', 'git',
'openssl',   'pahole', 'perl', and the development headers for 'libelf'
and 'openssl'. The reference section shows how to quickly install those
on various popular Linux distributions.

  [:ref:`details<buildrequires_bisref>`]

. _diskspace_bissbs:

* Ensure to have enough free space for building Linux. 12 Gigabyte in
your home directory should typically suffice. If you have less
available, be sure to pay attention to a later step covering debugs
symbols, as disabling them can reduce the amount of required space for
building to about 4 Gigabytes.

. _rangecheck_bissbs:

* Determine the kernel versions considered 'good' and 'bad' throughout
this guide:

  * Something which used to work in Linux 6.0 broken when switching to
Linux 6.1-rc1? Then henceforth regard 'v6.0' as the last known 'good'
version and 'v6.1-rc1' as the first 'bad' one.

  * Some function stopped working when updating from 6.0.11 to 6.1.4?
Then for the time being consider 'v6.0' as the last 'good' version and
'v6.1.4' as the 'bad' one. Note, it is at this point an assumption that
6.0 is fine that will be checked later.

  * A feature you used in 6.0.11 does not work at all or worse in
6.1.13? In that case you want to bisect within a stable/longterm series:
consider 'v6.0.11' as the last known 'good' version and 'v6.0.13' as the
first 'bad' one.

  *Note, do not confuse 'good' version with 'working' kernel; the latter
term throughout this guide will refer to the last kernel working fine
for you; likewise 'broken' kernel will refer to the first one known to
have regressed.*

  [:ref:`details<rangecheck_bisref>`]

. _sources_bissbs:

* Retrieve the sources of the Linux version range you intend to bisect;
then change into the directory holding them, as all further commands in
this guide are meant to be executed from there.

  *[Note: the following paragraphs describe how to retrieve the sources
using a 'shallow clone', which speeds things up by only retrieving
recent code changes instead of the full history. If downloading and
storing a lot of data does not bother you, consider using a 'full git
clone' instead. The* :ref:`the reference section explains this in more
detail<sources_full>` *while also* :ref:`pointing out a few peculiar
characteristics of shallow clones<sources_shallow>` *.]*

  First, execute the following command to retrieve a fresh mainline
codebase::

    git clone --no-checkout --depth 1 -b master \
      https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
~/linux/
    cd ~/linux/

  Add the stable/longterm trees for your 'bad' version; in case that's
v6.1.5, add the 6.1.y stable branch::

    git remote set-branches --add origin linux-6.1.y

  If your 'good' version is a mainline release, deepen your clone's
history to its second predecessor. In case 6.0 is the 'good' version
5.19 would be the first and 5.18 the second, hence deepen the history up
to the latter::

    git fetch --shallow-exclude=v5.18 origin

  [:ref:`details<sources_bisref>`]

. _oldconfig_bissbs:

* Start preparing a kernel build configuration (the '.config' file).

  Before doing so, ensure you are still running the 'working' kernel an
earlier step told you to boot; if you are unsure, check the current
kernel release identifier using ``uname -r``.

  Afterwards check out the source code for the version earlier
established as 'good' and create a .config file::

    git checkout --detach v6.0
    make olddefconfig

  The second command will try to locate the build configuration file for
the running kernel and then adjust it for the needs of the kernel
sources you checked out. While doing so it will print a few lines with a
line starting with '# using defaults found in'. Ensure it is the former
of the two and followed by a path to a file in '/boot/' that contains
the release identifier of your currently working kernel.

  If it instead continued with something like
'arch/x86/configs/x86_64_defconfig', then the build infra failed to find
the .config file for your running kernel -- in which case you have to
put one there manually, as explained in the reference section.

  In case you can not find such a line, look one containing '#
configuration written to .config'. If that'S the case you have a stale
build configuration lying around. Unless you intend to use it, delete it
-- or better yet, remove all stale files you might have lying around
from an earlier bisection using ``make distclean`` or ``git clean -i``.
Afterwards call 'make olddefconfig' again.

  [:ref:`details<oldconfig_bisref>`]

. _localmodconfig_bissbs:

* Disable any kernel modules apparently superfluous for your setup. This
is optional, but usually wise, as it speeds up the bisection enormously
-- at least unless the .config file picked up in the previous step was
already tailored to your and your hardware needs, in which case you
should skip this step.

  To prepare the trimming, connect external hardware you occasionally
use (USB keys, tokens, ...), quickly start a VM, and bring up VPNs. And
if you rebooted since you started that guide, ensure that you tried the
regressed feature since you started the system. Only then trim your
config::

     yes '' | make localmodconfig

  There is a catch to this, as the 'apparently' in initial sentence of
this segment and the preparation instructions already hinted at:

  The 'localmodconfig' target easily disables kernel modules for
features only used occasionally -- like modules for external and
currently disconnected peripherals, virtualization software not yet
utilized, VPN tunnels, and a few other things. That's because some tasks
rely on  kernel modules Linux only loads when you execute those tasks
for the first time.

  This drawback of localmodconfig is nothing you should lose sleep over,
but something to keep in mind: if something is misbehaving with the
kernels built during this guide it's likely the reason. You can reduce
or nearly eliminate the risk with tricks the reference section outlines;
but when building a kernel just for quick testing purposes during a
bisection this is usually not worth spending much effort on, as long as
it boots and allows to properly test the feature which regressed.

  [:ref:`details<localmodconfig_bisref>`]

. _tagging_bissbs:

* Ensure all the kernels you will build are clearly identifiable using a
special tag and a unique version number::

    ./scripts/config --set-str CONFIG_LOCALVERSION '-bisect'
    ./scripts/config -e CONFIG_LOCALVERSION_AUTO

  [:ref:`details<tagging_bisref>`]

. _debugsymbols_bissbs:

* Decide how to handle debug symbols.

  In the context of a bisection it is often wise to enable them, as
there is a decent chance you at some point will need to decode a stack
trace from a 'panic', 'Oops', 'warning', or 'BUG'::

    ./scripts/config -d DEBUG_INFO_NONE -e KALLSYMS_ALL -e DEBUG_KERNEL \
      -e DEBUG_INFO -e DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT -e KALLSYMS

  But if you are extremely short on storage space, you might want to
disable debug symbols instead::

    ./scripts/config -d DEBUG_INFO -d DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
      -d DEBUG_INFO_DWARF4 -d DEBUG_INFO_DWARF5 -e CONFIG_DEBUG_INFO_NONE

  [:ref:`details<debugsymbols_bisref>`]

. _configmods_bissbs:

* Check if you might want to or have to adjust some other kernel
configuration options:

  * Are you running Debian? Then you want to avoid known problems by
performing   additional adjustments explained in the reference section.
    [:ref:`details<configmods_distros_bisref>`].

  * If you want to influence other aspects of the configuration, do so now
    by using make targets like 'menuconfig' or 'xconfig'.
[:ref:`details<configmods_individual_bisref>`].

. _saveconfig_bissbs:

* Reprocess the .config after the latest changes and store it in a safe
place::

     make olddefconfig
     cp .config ~/bisection-config-base

  [:ref:`details<saveconfig_bisref>`]

. _introlatestcheck_bissbs:

Check if you can reproduce the regression
-----------------------------------------

Verify the regression is not caused by some .config change while also
checking if the problem still occurs with the latest codebase. This
might seem superfluous, but due to the two aforementioned aspects in
almost all situations is worth the effort; the reference section
explains this in more detail.

[:ref:`details<introlatestcheck_bisref>`]

. _checkoutmaster_bissbs:

* Checkout the latest Linux codebase::

    cd ~/linux/
    git checkout --force --detach origin/master

  [:ref:`details<checkoutmaster_bisref>`]

. _build_bissbs:

* Build the image and the modules of your first kernel using the config
file you prepared::

    cp ~/bisection-config-base .config
    make olddefconfig
    make -j $(nproc --all)

  If you want your kernel packaged up as deb, rpm, or tar file, see the
reference section for alternatives.

  [:ref:`details<build_bisref>`]

. _install_bissbs:

* Install your newly built kernel.

  Before doing so, consider checking if there is still enough room for it::

    df -h /boot/ /lib/modules/

  150 MByte in /boot/ and 200 in /lib/modules/ usually suffice. Those
are rough estimates assuming the worst case. How much your kernels
actually require will be determined after installing the first one.

  Now install the kernel, which will be saved in parallel to the kernels
from your Linux distribution::

    command -v installkernel && sudo make modules_install install

  On many commodity Linux distributions this will take care of
everything required to boot your kernel. You might want to ensure that
by checking if your boot loader's configuration was updated; furthermore
ensure an initramfs (also known as initrd) exists, which on many
distributions can be achieved by running ``ls -l /boot/init*$(make -s
kernelrelease)*``. Those steps are recommended, as there are quite a few
Linux distribution where above command is insufficient:

  * On Arch Linux, its derivatives, many immutable Linux distributions,
and a few others the above command does nothing at, as they lack
'installkernel' executable.

  * Some distributions install the kernel, but don't add an entry for
your kernel in your boot loader's configuration -- the kernel thus won't
show up in the boot menu.

  * Some distributions add a boot loader menu entry, but don't create an
initramfs on installation -- in that case your kernel most likely will
be unable to mount the root partition during bootup.

  If any of that applies to you, see the reference section for further
guidance. Once you figured out what to do, consider optimizing and
writing down the necessary installation steps: you will have to execute
them every time that ``command -v installkernel [...]`` comes up again
in this guide.

  [:ref:`details<install_bisref>`]

. _storagespace_bissbs:

* Check how much storage space the kernel, its modules, and other
related files like the initramfs consume::

    du -ch /boot/*$(make -s kernelrelease)* | tail -n 1
    du -sh /lib/modules/$(make -s kernelrelease)/

  Write down or remember those two values for later: they enable you to
prevent running out of disk space accidentally while following this guide.

  [:ref:`details<storagespace_bisref>`]

. _kernelrelease_bissbs:

* Show and store the kernelrelease identifier of the kernel you just built::

    make -s kernelrelease | tee -a ~/bisection-kernels-built

  Remember the value momentarily, as it will help you pick the right
kernel from the boot menu upon restarting.

. _recheckbroken_bissbs:

* Reboot into the kernel you just built and check if the feature that
regressed is really broken there.

 Start by ensuring the kernel you booted is the one you just built. When
unsure, check if the output of these commands show the exact same
release identifier::

   tail -n 1 ~/bisection-kernels-built
   uname -r

 Now verify if the feature that regressed works with your newly built
kernel. If it does, check the reference section for further details.

  [:ref:`details<recheckbroken_bisref>`]

. _recheckstablebroken_bissbs:

* Did you encounter the regression with a stable/longterm series, but
failed to reproduce it with the kernel you just built using the latest
mainline sources? Then check if the latest codebase for the particular
series might already fix the problem. In case the regression happened
between 6.0.11 and 6.0.13, start by executing these commands::

    cd ~/linux/
    git checkout --force --detach linux-6.0.y

  Now use the checked out code to build and install another kernel using
the commands described in more detail earlier::

    cp ~/bisection-config-base .config
    make olddefconfig
    make -j $(nproc --all)
    # * Check if the free space suffices holding another kernel:
    df -h /boot/ /lib/modules/
    command -v installkernel && sudo make modules_install install
    make -s kernelrelease | tee -a ~/bisection-kernels-built
    reboot

  Now verify if you booted the kernel you intended to start, to then
check if everything works fine with this kernel::

    tail -n 1 ~/bisection-kernels-built
    uname -r

  [:ref:`details<recheckstablebroken_bisref>`]

. _introworkingcheck_bissbs:

Check if the kernels you build work fine
----------------------------------------

This segment among others will ensure the trimmed configuration file you
created earlier works as expected, which you otherwise would only notice
after wasting a lot of time and energy on a bisection.

[:ref:`details<introworkingcheck_bisref>`]

. _recheckworking_bissbs:

* Build your own variant of the working kernel and check if the feature
that regressed works as expected with it.

  Start by checking out the sources for the version earlier established
as 'good'::

    cd ~/linux/
    git checkout --detach v6.0

  Now use the checked out code to configure, build, and install another
kernel using the commands the previous subsection explained in more detail::

    cp ~/bisection-config-base .config
    make olddefconfig
    make -j $(nproc --all)
    # * Check if the free space suffices holding another kernel:
    df -h /boot/ /lib/modules/
    command -v installkernel && sudo make modules_install install
    make -s kernelrelease | tee -a ~/bisection-kernels-built
    reboot

  When the system booted, you once again might want to verify if the
kernel yo started is the one you just built::

    tail -n 1 ~/bisection-kernels-built
    uname -r

  Now check if this kernel works as expected; if not, consult the
reference section for further instructions.

  [:ref:`details<recheckworking_bisref>`]

. _introbisect_bissbs:

Perform the bisection
---------------------

With all the preparations and precaution builds taken care of, you are
now ready to begin the bisection.

. _bisectstart_bissbs:

* Start the bisection and tell Git about the versions earlier
established as 'good' and 'bad'::

    cd ~/linux/
    git bisect start
    git bisect good v6.0
    git bisect bad v6.1.5

  [:ref:`details<bisectstart_bisref>`]

. _bisectbuild_bissbs:

* Build, install, and boot a kernel from the code Git checked out using
the same commands you used earlier::

    cp ~/bisection-config-base .config
    make olddefconfig
    make -j $(nproc --all)
    # * Check if the free space suffices holding another kernel:
    df -h /boot/ /lib/modules/
    command -v installkernel && sudo make modules_install install
    make -s kernelrelease | tee -a ~/bisection-kernels-built
    reboot

  If compilation fails for some reason, run ``git bisect skip`` and
restart executing the stack of commands from the beginning.

  In case you skipped the "test latest codebase" step in the guide,
check its description as for why the 'df [...]' and 'make -s
kernelrelease [...]' commands are here.

  **Note**, the latter command from this point on will print release
identifiers that might look odd or wrong to you -- which they are not,
as it's totally normal to see release identifiers like
'5.19-rc1-bisect-gcafec0cacaca0' while bisecting a regression between
versions 6.0 and 6.1.

  [:ref:`details<bisectbuild_bisref>`]

. _bisecttest_bissbs:

* Now check if the feature that regressed works in the kernel you just
built.

  You again might want to start by ensuring the kernel you booted is the
one you just built::

    cd ~/linux/
    tail -n 1 ~/bisection-kernels-built
    uname -r

  Now verify if the feature that regressed works at this kernel
bisection point. If it does, run this::

    git bisect good

  If it does not, run this::

    git bisect bad

  Be sure about what you tell Git, as getting this wrong just once will
send the rest of the bisection totally of course.

  While the bisection is ongoing, Git will use the information you
provided to find and checkout another bisection point for you to test.
While doing so, it will print something like 'Bisecting: 675 revisions
left to test after this (roughly 10 steps)' to indicate how many further
changes it expects to be tested. Now build and install another kernel
using the instructions from the previous step above; afterwards follow
the instructions in this step again.

  Repeat this again and again until you finish the bisection -- that's
the case when Git after tagging a change as 'good' or 'bad' prints
something like 'cafecaca0c0dacafecaca0c0dacafecaca0c0da is the first bad
commit'; right afterwards it will show some details about the culprit
including the patch description of the change, which might fill your
terminal screen, so you might need to scroll up to see the former message.

  [:ref:`details<bisecttest_bisref>`]

. _bisectlog_bissbs:

* Store Git's bisection log and the current .config file in a safe place
before telling Git to reset the sources to the state before the bisection::

    cd ~/linux/
    git bisect log > ~/bisection-log
    cp .config ~/bisection-config-culprit
    git bisect reset

  [:ref:`details<bisectlog_bisref>`]

. _revert_bissbs:

* Try reverting the culprit on top of the latest codebase to see if this
fixes your regression.

  This is optional, as it might be impossible or hard to realize. The
former is the case, if the bisection determined a merge commit as the
culprit; the latter happens if other changes depend on the culprit. But
if the revert succeeds, it is worth building another kernel, as it
validates the result of a bisection, which can easily deroute; it
furthermore will let kernel developers know, if they can resolve the
regression with a quick revert.

  Begin by checking out the latest codebase depending on the range you
bisected:

  * Did you face a regression within a stable/longterm series (say
between 6.0.11 and 6.0.13) that does not happen in mainline? Then
checkout the latest codebase for the affected series like this::

      git checkout --force --detach linux-6.0.y

  * In all other cases checkout latest mainline::

      git checkout --force --detach origin/master

    If you bisected a regression within a stable/longterm series that
also happens in mainline, there is one more thing to do: look up the
mainline commit-id. To do so, use a command like ``git show
abcdcafecabcd`` to view the patch description of the culprit. It near
the top will have a line like 'commit cafec0cacaca0 upstream.' or
'Upstream commit cafec0cacaca0; use that commit-id in the next command
and not the one the bisection blamed.

  Now try reverting the culprit by specifying its commit id::

    git revert --no-edit cafec0cacaca0

  If that fails, give up trying and move on to the next step. But if it
works, build a kernel again using the familiar command sequence::

    cp ~/bisection-config-base .config &&
    make olddefconfig &&
    make -j $(nproc --all) &&
    # * Check if the free space suffices holding another kernel:
    df -h /boot/ /lib/modules/
    command -v installkernel && sudo make modules_install install
    Make -s kernelrelease | tee -a ~/bisection-kernels-built
    reboot

  Now check one last time if the feature that made you perform a
bisection work with that kernel.

  [:ref:`details<revert_bisref>`]

. _introclosure_bissbs:

Supplementary tasks: cleanup during and after the bisection
-----------------------------------------------------------

During and after following this guide you might want or need to remove
some of the kernels you installed: the boot menu otherwise could become
confusing or space might run out.

. _makeroom_bissbs:

* To remove one of the kernels you installed, look up its
'kernelrelease' identifier. This guide stores them in
'~/bisection-kernels-built', but the following command will print them
as well::

    ls -ltr /lib/modules/*-bisect*

  You in most situations want to remove the oldest kernels built during
the actual bisection (e.g. segment '3' of this guide). The two ones you
created beforehand (e.g. to test the latest codebase and the version
considered 'good') might become handy to verify something later -- thus
better keep them around, unless you are really short on storage space.

  To remove the modules of a kernel with the kernelrelease identifier
'*6.0-rc1-bisect-gcafec0cacaca0*', start by removing the directory
holding its modules::

    sudo rm -rf /lib/modules/6.0-rc1-bisect-gcafec0cacaca0

  Afterwards try the following command::

    sudo kernel-install -v remove 6.0-rc1-bisect-gcafec0cacaca0

  On quite a few distributions this will delete all other kernel files
installed while also removing the kernel's entry from the boot menu. But
on some distributions this command does not exist or will fail; in that
case consult the reference section, as your Linux distribution needs
special care.

  [:ref:`details<makeroom_bisref>`]

. _finishingtouch_bissbs:

* Once you have finished the bisection, do not immediately remove
anything you set up, as you might need a few things again. What is safe
to remove depends on the outcome of the bisection:

  * Could you initially reproduce the regression with the latest
codebase and after the bisection were able to fix the problem by
reverting the culprit on top of the latest codebase? Then you want to
keep those two kernels around for a while, but safely remove all others
with a '-bisect' in the release identifier.

  * Did the bisection end on a merge-commit or seems questionable for
other reasons? Then you want to keep as many kernels as possible around
for a few days: it's pretty likely that you will be asked to recheck
something.

  * In other cases it likely is a good idea to keep the following
kernels around for some time: the one built from the latest codebase,
the one created from the version considered 'good', and the last few you
compiled during the actual bisection process.

  [:ref:`details<finishingtouch_bisref>`]

. _submit_improvements:

This concludes the step by step guide.

Did you run into trouble following any of the above steps not cleared up
by the reference section below? Did you spot errors? Or do you have
ideas how to improve the guide? Then please take a moment and let the
maintainer of this document know by email (Thorsten Leemhuis
<linux@leemhuis.info>), ideally while CCing the Linux docs mailing list
(linux-doc@vger.kernel.org). Such feedback is vital to improve this
document further, which is in everybody's interest, as it will enable
more people to master the task described here -- and hopefully also
improve other guides on bisection that use this one as a reference.

Reference section for the step-by-step guide
============================================

This section holds additional information for almost all the items in
above step-by-step guide.

. _backup_bisref:

Prepare for emergencies
-----------------------

   *Create a fresh backup and put system repair and restore tools at
hand.*  [:ref:`... <backup_bissbs>`]

Remember, you are dealing with computers, which sometimes do unexpected
things -- especially if you fiddle with crucial parts like the kernel of
an operating system. That's what you are about to do in this process.
Hence, better prepare for something going sideways, even if that should
not happen.

[:ref:`back to step-by-step guide <backup_bissbs>`]

. _vanilla_bisref:

Remove anything related to externally maintained kernel modules
---------------------------------------------------------------

  * Remove all software that depends on externally developed kernel
drivers or builds them automatically.* [:ref:`...<vanilla_bissbs>`]

Externally developed kernel modules can easily cause trouble during a
bisection.

But there is a more important reason why this guide contains this step:
most kernel developers will not care about reports about regressions
occurring with kernels that utilize such modules. That's because such
kernels are not considered 'vanilla' anymore, as
Documentation/admin-guide/reporting-issues.rst explains in more detail.

[:ref:`back to step-by-step guide <vanilla_bissbs>`]

. _secureboot_bisref:

Deal with techniques like Secure Boot
-------------------------------------

   *On platforms with 'Secure Boot' or similar techniques, prepare
everything to  ensure the system will permit your self-compiled kernel
to boot later.*  [:ref:`... <secureboot_bissbs>`]

Many modern systems allow only certain operating systems to start; they
thus by default will reject booting self-compiled kernels.

You ideally deal with this by making your platform trust your self-built
kernels with the help of a certificate. How to do that is not described
here, as it requires various steps that would take the text too far away
from its purpose; 'Documentation/admin-guide/module-signing.rst' and
various web sides already explain everything needed in more detail.

Temporarily disabling solutions like Secure Boot is another way to make
your own Linux boot. On commodity x86 systems it is possible to do this
in the BIOS Setup utility; the required steps vary a lot between
machines and therefore cannot be described here.

On mainstream x86 Linux distributions there is a third and universal
option: disable all Secure Boot restrictions for your Linux environment.
You can initiate this process by running ``mokutil
--disable-validation``; this will tell you to create a one-time
password, which is safe to write down. Now restart; right after your
BIOS performed all self-tests the bootloader Shim will show a blue box
with a message 'Press any key to perform MOK management'. Hit some key
before the countdown exposes, which will open a menu. Choose 'Change
Secure Boot state'. Shim's 'MokManager' will now ask you to enter three
randomly chosen characters from the one-time password specified earlier.
Once you provided them, confirm you really want to disable the
validation. Afterwards, permit MokManager to reboot the machine.

[:ref:`back to step-by-step guide <secureboot_bissbs>`]

. _bootworking_bisref:

Boot the last kernel that was working
-------------------------------------

   *Boot into the last working kernel and briefly recheck if the feature
that regressed really works.* [:ref:`...<bootworking_bissbs>`]

This will make later steps that cover creating and trimming the
configuration do the right thing.

[:ref:`back to step-by-step guide <bootworking_bissbs>`]

. _buildrequires_bisref:

Install build requirements
--------------------------

   *Install all software required to build a Linux kernel.*
[:ref:`...<buildrequires_bissbs>`]

The kernel is pretty stand-alone, but besides tools like the compiler
you will sometimes need a few libraries to build one. How to install
everything needed depends on your Linux distribution and the
configuration of the kernel you are about to build.

Here are a few examples what you typically need on some mainstream
distributions:

* Debian, Ubuntu, and derivatives::

    sudo apt install bc binutils bison dwarves flex gcc git make openssl \
      pahole perl-base libssl-dev libelf-dev

* Fedora and derivatives::

    sudo dnf install binutils /usr/include/{libelf.h,openssl/pkcs7.h} \
      /usr/bin/{bc,bison,flex,gcc,git,openssl,make,perl,pahole}

* openSUSE and derivatives::

    sudo zypper install bc binutils bison dwarves flex gcc git make
perl-base \
      openssl openssl-devel libelf-dev

In case you wonder why these lists include openssl and its development
headers: they are needed for the Secure Boot support, which many
distributions enable in their kernel configuration for x86 machines.

Sometimes you will need tools for compression formats like bzip2, gzip,
lz4, lzma, lzo, xz, or zstd as well.

In case you want to adjust the build configuration with make targets
like 'menuconfig' or 'xconfig' later, ensure to also install development
headers for ncurses and Qt5.

You furthermore might need additional libraries and their development
headers for tasks not covered in this guide. For example, zlib will be
needed when building kernel tools from the tools/ directory;.

[:ref:`back to step-by-step guide <buildrequires_bissbs>`]

. _diskspace_bisref:

Space requirements
------------------

   *Ensure to have enough free space for building Linux.* [:ref:`...
<diskspace_bissbs>`]

The numbers mentioned are rough estimates with a big extra charge to be
on the safe side, so often you will need less.

If you have space constraints, be sure to hay attention to the
:ref:`step about debug symbols' <debugsymbols_bissbs>` and its
:ref:`accompanying reference section' <debugsymbols_bisref>`, as
disabling then will reduce the consumed disk space by quite a few gigabytes.

[:ref:`back to step-by-step guide <diskspace_bissbs>`]

. _rangecheck_bisref:

Bisection range
---------------

   *Determine the kernel versions considered 'good' and 'bad' throughout
this guide.* [:ref:`...<rangecheck_bissbs>`]

Establishing the range of commits to be checked is mostly
straightforward, except when a regression occurred when switching from a
release of one stable series to a release of a later series (e.g. from
6.0.11 to 6.1.4). In that case Git will need some hand holding, as there
is no straight line of descent.

That's because with the release of 6.0 mainline carried on to 6.1 while
the stable series 6.0.y branched to the side. It's therefore
theoretically possible that the issue you face with 6.1.4 only worked in
6.0.11, as it was fixed by a commit that went into one of the 6.0.y
releases, but never hit mainline or the 6.1.y series. Thankfully that
normally should not happen due to the way the stable/longterm
maintainers maintain the code. It's thus pretty safe to assume 6.0 as a
'good' kernel. That assumption will be tested anyway, as that kernel
will be built and tested in the segment '2' of this guide; Git would
force you to do this as well, if you tried bisecting between 6.0.11 and
6.1.13.

[:ref:`back to step-by-step guide <rangecheck_bissbs>`]

. _sources_bisref:

Download the sources using git
------------------------------

  *Retrieve the sources of the Linux version range you intend to
bisect.* [:ref:`...<sources_bissbs>`]

The step-by-step guide outlines how to retrieve Linux' sources using a
shallow git clone. There is :ref:`more to tell about this
method<sources_shallow>` and an alternative worth explaining: :ref:`a
full git clone<sources_full>`.

[:ref:`back to step-by-step guide <sources_bissbs>`]

. _sources_shallow:

Noteworthy characteristics of shallow clones
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The step-by-step guide uses a shallow clone, as it is the best solution
for most of this document's target audience. There are a few aspects of
this approach worth mentioning:

 * For bisections the history needs to be deepend a few mainline
versions farther than it seems necessary, as the step-by-step guide
already explains. That's because Git otherwise will be unable to revert
or describe most of the commits within a range (say v6.1..v6.2), as they
are internally based on earlier kernels releases (e.g. v6.0-rc2 or
5.19-rc3).

 * This document in most places uses ``git fetch`` with
``--shallow-exclude=`` to specify the earliest version you care about
(or to be precise: its git tag). You alternatively can use the parameter
``--shallow-since=`` to specify an absolute (say ``'2023-07-15'``) or
relative (``'12 months'``) date to define the depth of the history you
want to download. When using them while bisecting mainline, ensure to
deepen the history to at least 7 months before the release of your
'good' kernel.

 * When running ``git fetch``, remember to always specify the oldest
version, the time you care about. Otherwise you will risk downloading
nearly the entire git history, which will consume quite a bit of time
and bandwidth while also stressing the servers.

   Note, you do not have to use the same version or date all the time.
But when you change it over time, git will deepen or flatten the history
to the specified point. That allows you to retrieve versions you
initially thought you did not need -- or it will discard the sources of
older versions, for example in case you want to free up some disk space.
The latter will happen automatically when using ``--shallow-since=``.

 * Be warned, when deepening your clone you might encounter an error
like 'fatal: error in object: unshallow
cafecaca0c0dacafecaca0c0dacafecaca0c0da'. In that case run ``git repack
-d`` and try again.

[:ref:`back to step-by-step guide <sources_bissbs>`] [:ref:`back to
section intro <sources_bisref>`]

. _sources_full:

Downloading the sources using a full git clone
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If downloading and storing a lot of data (~4,4 Gigabyte as of early
2023) is nothing that bothers you, instead of a shallow clone perform a
full git clone instead. You then will avoid the specialties mentioned
above and will have all versions and individual commits at hand at any
time::

  curl -L \

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/clone.bundle
\
    -o linux-stable.git.bundle
  git clone linux-stable.git.bundle ~/linux/
  rm linux-stable.git.bundle
  cd ~/linux/
  git remote set-url origin \
    https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
  git fetch origin
  git checkout --detach origin/master

[:ref:`back to step-by-step guide <sources_bissbs>`] [:ref:`back to
section intro <sources_bisref>`]

. _oldconfig_bisref:

Start defining the build configuration for your kernel
------------------------------------------------------

  *Start preparing a kernel build configuration (the '.config' file).*
[:ref:`... <oldconfig_bissbs>`]

*Note, this is the first of multiple steps in this guide that create or
modify build artifacts. The commands used in this guide store them right
in the source tree to keep things simple. In case you prefer storing the
build artifacts separately, create a directory like '~/linux-builddir/'
and add the parameter ``O=~/linux-builddir/`` to all make calls used
throughout this guide. You will have to point other commands there as
well -- among them the ``./scripts/config [...]`` commands, which will
require ``--file ~/linux-builddir/.config`` to locate the right build
configuration.*

Two things can easily go wrong when creating a .config file as advised:

 * The oldconfig target will use a .config file from your build
directory, if one is already present there (e.g. '~/linux/.config').
That's totally fine if that's what you intend (see next step), but in
all other cases you want to delete it. This for example is important in
case you followed this guide further, but due to problems come back here
to redo the configuration from scratch.

 * Sometimes olddefconfig is unable to locate the .config file for your
running kernel and will use defaults, as briefly outlined in the guide.
In that case check if your distribution ships the configuration
somewhere and manually put it in the right place (e.g.
'~/linux/.config') if it does. On distributions where /proc/config.gz
exists this can be achieved using this command::

     zcat /proc/config.gz > .config

   Once you put it there, run ``make olddefconfig`` again to adjust it
to the needs of the kernel about to be built.

Note, the olddefconfig target will set any undefined build options to
their default value. If you prefer to set such configuration options
manually, use ``make oldconfig`` instead. Then for each undefined
configuration option you will be asked how to proceed; in case you are
unsure what to answer, simply hit 'enter' to apply the default value.
Note though that for bisections you normally want to go with the
defaults, as you otherwise might enable a new feature that causes a
problem looking like regressions (for example due to security restrictions).

Occasionally odd things happen when trying to use a config file prepared
for one kernel (say 6.1) on an older mainline release -- especially if
it is much older (say v5.15). That's one of the reasons why the previous
step in the guide told you to boot the kernel where everything works. If
you manually add a .config file you thus want to ensure it's from the
working kernel and not from a one that shows the regression.

In case you want to build kernels for another machine, locate its kernel
build configuration; usually ``ls /boot/config-$(uname -r)`` will print
its name. Copy that file to the build machine and store it as
~/linux/.config; afterwards run ``make olddefconfig`` to adjust it.

[:ref:`back to step-by-step guide <oldconfig_bissbs>`]

. _localmodconfig_bisref:

Trim the build configuration for your kernel
--------------------------------------------

  *Disable any kernel modules apparently superfluous for your setup.*
[:ref:`... <localmodconfig_bissbs>`]

As explained briefly in the step-by-step guide already: with
localmodconfig it can easily happen that your self-built kernels will
lack modules for tasks you did not perform at least once before
utilizing this make target. That happens when a task requires kernel
modules which are only autoloaded when you execute it for the first
time. So when you never performed that task since starting your kernel
the modules will not have been loaded -- and from localmodonfig's point
of view look superfluous, which thus disables them to reduce the amount
of code to be compiled.

You can try to avoid this by performing typical tasks that often will
autoload additional kernel modules: start a VM, establish VPN
connections, loop-mount a CD/DVD ISO, mount network shares (CIFS, NFS,
..), and connect all external devices (2FA keys, headsets, webcams,
..) as well as storage devices with file systems you otherwise do not
utilize (btrfs, ext4, FAT, NTFS, XFS, ...). But it is hard to think of
everything that might be needed -- even kernel developers often forget
one thing or another at this point.

Do not let that risk bother you, especially when compiling a kernel only
for testing purposes: everything typically crucial will be there. And if
you forget something important you can turn on a missing feature
manually later and quickly run the commands again to compile and install
a kernel that has everything you need.

But if you plan to build and use self-built kernels regularly, you might
want to reduce the risk by recording which modules your system loads
over the course of a few weeks. You can automate this with `modprobed-db
<https://github.com/graysky2/modprobed-db>`_. Afterwards use
``LSMOD=<path>`` to point localmodconfig to the list of modules
modprobed-db noticed being used::

  yes '' | make LSMOD='${HOME}'/.config/modprobed.db localmodconfig

That parameter also allows you to build trimmed kernels for another
machine in case you copied a suitable .config over to use as base (see
previous step). Just run ``lsmod > lsmod_foo-machine`` on that system
and copy the generated file to your build's host home directory. Then
run these commands instead of the one the step by step guide mentions::

  yes '' | make LSMOD=~/lsmod_foo-machine localmodconfig

[:ref:`back to step-by-step guide <localmodconfig_bissbs>`]

. _tagging_bisref:

Tag the kernels about to be build
---------------------------------

  *Ensure all the kernels you will build are clearly identifiable using
a special tag and a unique version identifier.* [:ref:`...
<tagging_bissbs>`]

This allows you to differentiate your distribution's kernels from those
created during this process, as the file or directories for the latter
will contain '-bisect' in the name; it also helps picking the right
entry in the boot menu and not lose track of you kernels, as their
version numbers will look slightly confusing during the bisection.

[:ref:`back to step-by-step guide <tagging_bissbs>`]

. _debugsymbols_bisref:

Decide to enable or disable debug symbols
-----------------------------------------

  *Decide how to handle debug symbols.* [:ref:`... <debugsymbols_bissbs>`]

Having debug symbols available can be important when your kernel throws
a 'panic', 'Oops', 'warning', or 'BUG' later when running, as then you
will be able to find the exact place where the problem occurred in the
code. But collecting and embedding the needed debug information takes
time and consumes quite a bit of space: in late 2022 the build artifacts
for a typical x86 kernel trimmed with localmodconfig consumed around 5
Gigabyte of space with debug symbols, but less than 1 when they were
disabled. The resulting kernel image and modules are bigger as well,
which increases storage requirements for /boot/ and load times.

In case you want a small kernel and are unlikely to decode a stack trace
later, you thus might want to disable debug symbols to avoid those
downsides. If it later turns out that you need them, just enable them as
shown and rebuild the kernel.

You on the other hand definitely want to enable them for this process,
if there is a decent chance that you need to decode a stack trace later.
The section 'Decode failure messages' in
Documentation/admin-guide/reporting-issues.rst explains this process in
more detail.

[:ref:`back to step-by-step guide <debugsymbols_bissbs>`]

. _configmods_bisref:

Adjust build configuration
--------------------------

   *Check if you might want to or have to adjust some kernel
configuration options.*

Depending on your needs you at this point might want or have to adjust
some kernel configuration options.

. _configmods_distros_bisref:

Distro specific adjustments
~~~~~~~~~~~~~~~~~~~~~~~~~~~

   *Are you running* [:ref:`... <configmods_bissbs>`]

The following sections help you to avoid build problems that are known
to occur when following this guide on a few commodity distributions.

**Debian:**

 * Remove a stale reference to a certificate file that would cause your
build to fail::

    ./scripts/config --set-str SYSTEM_TRUSTED_KEYS ''

   Alternatively, download the needed certificate and make that
configuration option point to it, as `the Debian handbook explains in
more detail
<https://debian-handbook.info/browse/stable/sect.kernel-compilation.html>`_
-- or generate your own, as explained in
Documentation/admin-guide/module-signing.rst.

[:ref:`back to step-by-step guide <configmods_bissbs>`]

. _configmods_individual_bisref:

Individual adjustments
~~~~~~~~~~~~~~~~~~~~~~

   *If you want to influence the other aspects of the configuration, do
so now.* [:ref:`... <configmods_bissbs>`]

You at this point can use a command like ``make menuconfig`` to enable
or disable certain features using a text-based user interface; to use a
graphical configuration utility, call the make target ``xconfig`` or
``gconfig`` instead. All of them require development libraries from
toolkits they are based on (ncurses, Qt5, Gtk2); an error message will
tell you if something required is missing.

[:ref:`back to step-by-step guide <configmods_bissbs>`]

. _saveconfig_bisref:

Put the .config file aside
--------------------------

  *Reprocess the .config after the latest changes and store it in a safe
place.* [:ref:`... <saveconfig_bissbs>`]

Put the .config you prepared aside, as you want to copy it back to the
build directory every time  during this guide before you start building
another kernel. That's because going back and forth between different
versions can alter .config files in odd ways; those occasionally cause
side effects that could confuse testing or in some cases render the
result of your bisection meaningless.

[:ref:`back to step-by-step guide <saveconfig_bissbs>`]

 .. _introlatestcheck_bisref:

Try to reproduce the regression
-----------------------------------------

  *Verify the regression is not caused by some .config change and check
if it still occurs with the latest codebase.* [:ref:`...
<introlatestcheck_bissbs>`]

For some readers it might seem unnecessary to check the latest codebase
at this point, especially if you did that already with a kernel prepared
by your distributor or face a regression within a stable/longterm
series. But it's highly recommended for these reasons:

* You will run into any problems caused by your setup before you
actually begin a bisection. That will make it a lot easier to
differentiate between 'this most likely is some problem in my setup' and
'this change needs to be skipped during the bisection, as the kernel
sources at that stage contain an unrelated problem that causes building
or booting to fail'.

* These steps will rule out if your problem is caused by some change in
the build configuration between the 'working' and the 'broken' kernel.
This for example can happen when your distributor enabled an additional
security feature in the newer kernel which was disabled or not yet
supported by the older kernel. That security feature might get into the
way of something you do -- in which case your problem from the
perspective of the Linux kernel upstream developers is not a regression,
as Documentation/admin-guide/reporting-regressions.rst explains in more
detail. You thus would waste your time if you'd try to bisect this.

* If the cause for your regression was already fixed in the latest
mainline codebase, you'd perform the bisection for nothing. This holds
true for a regression you encountered with a stable/longterm release as
well, as they are often caused by problems in mainline changes that were
backported -- in which case the problem will have to be fixed in
mainline first. Maybe it already was fixed there and the fix is already
in the process of being backported.

* For regressions within a stable/longterm series it's furthermore
crucial to know if the issue is specific to that series or also happens
in the mainline kernel, as the report needs to be sent to different people:

 * Regressions specific to a stable/longterm series are the stable
team's responsibility; mainline Linux developers might or might not care.

 * Regressions also happening in mainline are something the regular
Linux developers and maintainers have to handle; the stable team does
not care and does not need to be involved in the report, they just
should be told to backport the fix once it's ready.

 Your report might be ignored if you send it to the wrong party -- and
even when you get a reply there is a decent chance that developers tell
you to evaluate which of the two cases it is before they take a closer look.

[:ref:`back to step-by-step guide <introlatestcheck_bissbs>`]

. _checkoutmaster_bisref:

Checkout the latest Linux codebase
----------------------------------

  *Checkout the latest Linux codebase.* [:ref:`...
<introlatestcheck_bissbs>`]

In case you later want to recheck if an ever newer codebase might fix
the problem, remember to run that ``git fetch --shallow-exclude [...]``
command again mentioned earlier to update your local Git repository.

[:ref:`back to step-by-step guide <introlatestcheck_bissbs>`]

. _build_bisref:

Build your kernel
-----------------

  *Build the image and the modules of your first kernel using the config
file you prepared.* [:ref:`... <build_bissbs>`]

A lot can go wrong at this stage, but the instructions below will help
you help yourself. Another subsection explains how to directly package
your kernel up as deb, rpm or tar file.

Dealing with build errors
~~~~~~~~~~~~~~~~~~~~~~~~~

When a build error occurs, it might be caused by some aspect of your
machine's setup that often can be fixed quickly; other times though the
problem lies in the code and can only be fixed by a developer. A close
examination of the failure messages coupled with some research on the
internet will often tell you which of the two it is. To perform such a
investigation, restart the build process like this::

  make V=1

The ``V=1`` activates verbose output, which might be needed to see the
actual error. To make it easier to spot, this command also omits the
``-j $(nproc --all)`` used earlier to utilize every CPU core in the
system for the job -- but this parallelism also results in some clutter
when failures occur.

After a few seconds the build process should run into the error again.
Now try to find the most crucial line describing the problem. Then
search the internet for the most important and non-generic section of
that line (say 4 to 8 words); avoid or remove anything that looks
remotely system-specific, like your username or local path names like
``/home/username/linux/``. First try your regular internet search engine
with that string, afterwards search Linux kernel mailing lists via
`lore.kernel.org/all/ <https://lore.kernel.org/all/>`_.

This most of the time will find something that will explain what is
wrong; quite often one of the hits will provide a solution for your
problem, too. If you do not find anything that matches your problem, try
again from a different angle by modifying your search terms or using
another line from the error messages.

In the end, most trouble you are to run into has likely been encountered
and reported by others already. That includes issues where the cause is
not your system, but lies the code. If you run into one of those, you
might thus find a solution (e.g. a patch) or workaround for your
problem, too.

Package your kernel up
~~~~~~~~~~~~~~~~~~~~~~

The step-by-step guide uses the default make targets (e.g. 'bzImage' and
'modules' on x86) to build the image and the modules of your kernel,
which later steps of the guide then install. You instead can also
directly build everything and directly package it up by using one of the
following targets:

 * ``make -j $(nproc --all) bindeb-pkg`` to generate a deb package

 * ``make -j $(nproc --all) binrpm-pkg`` to generate a rpm package

 * ``make -j $(nproc --all) tarbz2-pkg`` to generate a bz2 compressed
tarball

This is just a selection of available make targets for this purpose, see
``make help`` for others. You can also use these targets after running
``make -j $(nproc --all)``, as they will pick up everything already built.

If you employ the targets to generate deb or rpm packages, ignore the
step-by-step guide's instructions on installing and removing your
kernel; instead install and remove the packages using the package
utility for the format (e.g. dpkg and rpm) or a package management
utility build on top of them (apt, aptitude, dnf/yum, zypper, ...). Be
aware that the packages generated using these two make targets are
designed to work on various distributions utilizing those formats, they
thus will sometimes behave differently than your distribution's kernel
packages.

[:ref:`back to step-by-step guide <build_bissbs>`]

. _install_bisref:

Put the kernel in place
-----------------------

  *Install the kernel you just built.* [:ref:`... <install_bissbs>`]

What you need to do after executing the command in the step-by-step
guide depends on the existence and the implementation of an
``installkernel`` executable. Many commodity Linux distributions ship
such a kernel installer in '/sbin/' that does everything needed, hence
there is nothing left for you except rebooting. But some distributions
contain an installkernel that does only part of the job -- and a few
lack it completely and leave all the work to you.

If ``installkernel`` is found, the kernel's build system will delegate
the actual installation of your kernel's image and related files to this
executable. On almost all Linux distributions it will store the image as
'/boot/vmlinuz- <kernelrelease identifier>' and put a
'System.map-<kernelrelease identifier>' alongside it. Your kernel will
thus be installed in parallel to any existing ones, unless you already
have one with exactly the same release name.

Installkernel on many distributions will afterwards generate an
'initramfs' (often also called 'initrd'), which commodity distributions
rely on for booting; hence be sure to keep the order of the two make
targets used in the step-by-step guide, as things will go sideways if
you install your kernel's image before its modules. Often installkernel
will then add your kernel to the bootloader configuration, too. You have
to take care of one or both of these tasks yourself, if your
distributions installkernel doesn't handle them.

A few distributions like Arch Linux and its derivatives totally lack an
installkernel executable. On those just install the modules using the
kernel's build system and then install the image and the System.map file
manually::

   sudo make modules_install
   sudo install -m 0600 $(make -s image_name) /boot/vmlinuz-$(make -s
kernelrelease)
   sudo install -m 0600 System.map /boot/System.map-$(make -s kernelrelease)

If your distribution boots with the help of an initramfs, now generate
one for your kernel using the tools your distribution provides for this
process. Afterwards add your kernel to your bootloader configuration and
reboot.

[:ref:`back to step-by-step guide <install_bissbs>`]

. _storagespace_bisref:

Storage requirements per kernel
-------------------------------

  *Check how much storage space the kernel, its modules, and other
related files like the initramfs consume.* [:ref:`...
<storagespace_bissbs>`]

The kernels built during a bisection consume quite a bit of space in
/boot/ and /lib/modules/, especially if you enabled debug symbols. That
makes it easy to fill up volumes during a bisection -- and due to that
even kernels which used to work earlier might fail to boot. To prevent
that you will need to know how much space each installed kernel
typically requires.

Note, most of the time the pattern '/boot/*$(make -s kernelrelease)*'
used in the guide will match all files needed to boot your kernel -- but
neither the path nor the naming scheme are mandatory. On some
distributions you thus will need to look in different places.

[:ref:`back to step-by-step guide <storagespace_bissbs>`]

. _recheckbroken_bisref:

Check the kernel built from the latest codebase
-----------------------------------------------

  *Reboot into the kernel you just built and check if the feature that
regressed is really broken there.* [:ref:`... <recheckbroken_bissbs>`]

There are a couple of reasons why the regression you face might not show
up with your own kernel built from the latest codebase. These are the
most frequent:

* The cause for the regression was fixed meanwhile.

* The regression with the broken kernel was caused by a change in the
build configuration the provider of your kernel carried out.

* Your problem might be a race condition that does not show up with your
kernel; the trimmed build configuration, a different setting for debug
symbols, the compiler used, and various other things can cause this.

* In case you encountered the regression with a stable/longterm kernel
it might be a problem that is specific to that series; the next step in
this guide will check this.

[:ref:`back to step-by-step guide <recheckbroken_bissbs>`]

. _recheckstablebroken_bisref:

Check the kernel built from the latest stable/longterm codebase
---------------------------------------------------------------

  *Did you encounter the regression with a stable/longterm series, but
failed to reproduce it with the latest mainline codebase? Then check if
the latest codebase for the particular series might already fix the
problem.* [:ref:`... <recheckstablebroken_bissbs>`]

If this kernel does not show the regression either, there most likely is
no need for a bisection.

[:ref:`back to step-by-step guide <recheckstablebroken_bissbs>`]

. _introworkingcheck_bisref:

Ensure the 'good' version is really working well
------------------------------------------------

  *Check if the kernels you build work fine.* [:ref:`...
<introworkingcheck_bissbs>`]

This section will reestablish a known working base. Skipping it might be
appealing, but is usually a bad idea, as it does something important:

It will ensure the .config file you prepared earlier actually works as
expected. That is in your own interest, as trimming the configuration is
not foolproof -- and you might be building and testing ten or more
kernels for nothing before starting to suspect something might be wrong
with the build configuration.

That alone is reason enough to spend the time on this, but not the only
reason.

Many readers of this guide normally run kernels that are patched, use
add-on modules, or both. Those kernels thus are not considered 'vanilla'
-- therefore it's possible that the thing that regressed might never
have worked in vanilla builds of the 'good' version in the first place.

There is a third reason for those that noticed a regression between
stable/longterm kernels of different series (e.g. v6.0.13..v6.1.5): it
will ensure the kernel version you assumed to be 'good' earlier in the
process (e.g. v6.0) actually is working.

[:ref:`back to step-by-step guide <introworkingcheck_bissbs>`]

. _recheckworking_bisref:

Build your own version of the 'good' kernel
-------------------------------------------

  *Build your own variant of the working kernel and check if the feature
that regressed works as expected with it.* [:ref:`...
<recheckworking_bissbs>`]

In case the feature that broke with newer kernels does not work with
your first self-built kernel, find and resolve the cause before moving
on. There are a multitude of reasons why this might happen. Some ideas
where to look:

* Maybe localmodconfig did something odd and disabled the module
required to test the feature? Then you might want to recreate a .config
file based on the one from the last working kernel and skip trimming it
down; manually disabling some features in the .config might work as well
to reduce the build time.

* Maybe it's not a kernel regression and something that is caused by
some fluke, a broken initramfs (also known as initrd), new firmware
files, or an updated userland software?

* Maybe it was a feature added to your distributor's kernel which
vanilla Linux at that point never supported?

Note, if you found and fixed problems with the .config file, you want to
use it to build another kernel from the latest codebase, as your earlier
tests with mainline and the latest version from an affected
stable/longterm series most likely has been flawed.

[:ref:`back to step-by-step guide <recheckworking_bissbs>`]

. _bisectstart_bisref:

Start the bisection
-------------------

  *Start the bisection and tell Git about the versions earlier
established as 'good' and 'bad'.* [:ref:`... <bisectstart_bissbs>`]

This will start the bisection process; the last of the commands will
make Git checkout a commit round about half-way between the 'good' and
the 'bad' changes for your to test.

[:ref:`back to step-by-step guide <bisectstart_bissbs>`]

. _bisectbuild_bisref:

Build a kernel from the bisection point
---------------------------------------

  *Build, install, and boot a kernel from the code Git checked out using
the same commands you used earlier.* [:ref:`... <bisectbuild_bissbs>`]

There are two things worth of note here:

* Occasionally building the kernel will fail or it might not boot due
some problem in the code at the bisection point. In that case run this
command::

    git bisect skip

 Git will then checkout another commit nearby which with a bit of luck
should work better. Afterwards restart executing this step.

* Those slightly odd looking version identifiers can happen during
bisections, because the Linux kernel subsystems prepare their changes
for a new mainline release (say 6.2) before its predecessor (e.g. 6.1)
is finished. They thus base them on a somewhat earlier point like
v6.1-rc1 or even v6.0 -- and then get merged for 6.2 without rebasing
nor squashing them once 6.1 is out. This leads to those slightly odd
looking version identifiers coming up during bisections.

[:ref:`back to step-by-step guide <bisectbuild_bissbs>`]

. _bisecttest_bisref:

Bisection checkpoint
--------------------

  *Check if the feature that regressed works in the kernel you just
built.* [:ref:`... <bisecttest_bissbs>`]

Ensure what you tell Git is accurate: getting it wrong just one time
will bring the rest of the bisection totally of course, hence all
testing after that point will be for nothing.

[:ref:`back to step-by-step guide <bisecttest_bissbs>`]

. _bisectlog_bisref:

Put the bisection log away
--------------------------

  *Store Git's bisection log and the current .config file in a safe
place.* [:ref:`... <bisectlog_bissbs>`]

As indicated above: declaring just one kernel wrongly as 'good' or 'bad'
will render the end result of a bisection useless. In that case you'd
normally have to restart the bisection from scratch. The log can prevent
that, as it might allow someone to point out where a bisection likely
went sideways -- and then instead of testing ten or more kernels you
might only have to build a few to resolve things.

The .config file is put aside, as there is a decent chance that
developers might ask for it after you reported the regression.

[:ref:`back to step-by-step guide <bisectlog_bissbs>`]

 .. _revert_bisref:

Try reverting the culprit
-------------------------

  *Try reverting the culprit on top of the latest codebase to see if
this fixes your regression.* [:ref:`... <revert_bissbs>`]

This is an optional step, but whenever possible one you should try:
there is a decent chance that developers will ask you to perform this
step when you bring the bisection result up. So give it a try, you are
in the flow already, building one more kernel shouldn't be a big deal at
this point.

The step by step guide covers everything relevant already except one
slightly rare thing: did you bisected a regression that also happened
with mainline using a stable/longterm series, but Git failed to revert
the commit in mainline? Then try to revert the culprit in the affected
stable/longterm series -- and if that succeeds, test that kernel version
instead.

[:ref:`back to step-by-step guide <revert_bissbs>`]

 Supplementary tasks: cleanup during and after the bisection
-----------------------------------------------------------

. _makeroom_bisref:

Cleaning up after the bisection
-------------------------------

  *To remove one of the kernels you installed, look up its
'kernelrelease' identifier.* [:ref:`... <makeroom_bissbs>`]

The kernels you install during this process are easy to remove later, as
its parts are only stored in two places and clearly identifiable. You
thus do not need to worry to mess up your machine when you install a
kernel manually (and thus bypass your distribution's packaging system):
all parts of your kernels are relatively easy to remove later.

One of the two places is a directory in /lib/modules/, which holds the
modules for each installed kernel. This directory is named after the
kernel's release identifier; hence, to remove all modules for one of the
kernels you built, simply remove its modules directory in /lib/modules/.

The other place is /boot/, where typically two up to five files will be
placed during installation of a kernel. All of them usually contain the
release name in their file name, but how many files and their exact name
depends somewhat on your distribution's installkernel executable and its
initramfs generator. On some distributions the ``kernel-install
remove...`` command mentioned in the step-by-step guide will delete all
of these files for you while also removing the menu entry for the kernel
from your bootloader configuration. On others you have to take care of
these two tasks yourself. The following command should interactively
remove the three main files of a kernel with the release name
'6.0-rc1-bisect-gcafec0cacaca0'::

  rm -i /boot/{System.map,vmlinuz,initr}-6.0-rc1-bisect-gcafec0cacaca0

Afterwards check for other files in /boot/ that have
'6.0-rc1-bisect-gcafec0cacaca0' in their name and consider deleting them
as well. Now remove the boot entry for the kernel from your bootloader's
configuration; the steps to do that vary quite a bit between Linux
distributions.

Note, be careful with wildcards like '*' when deleting files or
directories for kernels manually: you might accidentally remove files of
a 6.0.11 kernel when all you want is to remove 6.0 or 6.0.1.

[:ref:`back to step-by-step guide <makeroom_bissbs>`]

. _finishingtouch_bisref:

  *Once you have finished the bisection, do not immediately remove
anything you set up, as you might need a few things again.* [:ref:`...
<finishingtouch_bissbs>`]

When you are really short of storage space removing the kernels as
described in the step-by-step guide might not free as much space as you
would like. In that case consider running running ``rm -rf ~/linux/*``
as well now. This will remove the build artifacts and the Linux sources,
but will leave the Git repository (~/linux/.git/) behind -- a simple
``git reset --hard`` thus will bring the sources back.

Removing the repository as well would likely be unwise at this point:
there is a decent chance developers will ask you to build another kernel
to perform additional tests. This is often required to debug an issue or
check proposed fixes. Before doing so you want to run the ``git fetch
--shallow-exclude [...]`` command again followed by ``git checkout
origin/master`` to bring your clone up to date and checkout the latest
codebase. Then apply the patch using ``git apply <filename>`` or ``git
am <filename>`` and build yet another kernel using the familiar commands.

Additional tests are also the reason why you want to keep the
~/bisection-config-base file around for a few weeks.

[:ref:`back to step-by-step guide <finishingtouch_bissbs>`]


Additional reading material
===========================

Further sources
---------------

* Git documentation: the `man page for 'git bisect'
<https://git-scm.com/docs/git-bisect>`_ and `fighting regressions with
'git bisect' <https://git-scm.com/docs/git-bisect-lk2009.html>`_.
* `Working with git bisect
<https://nathanchance.dev/posts/working-with-git-bisect/>`_ from kernel
developer Nathan Chancellor.
* `Using Git bisect to figure out when brokenness was introduced
<http://webchick.net/node/99>`_.
* `Fully automated bisecting with 'git bisect run'
<https://lwn.net/Articles/317154>`_.

.
   end-of-content
.
   This document is maintained by Thorsten Leemhuis
<linux@leemhuis.info>. If
   you spot a typo or small mistake, feel free to let him know directly and
   he'll fix it. You are free to do the same in a mostly informal way if you
   want to contribute changes to the text -- but for copyright reasons
please CC
   linux-doc@vger.kernel.org and 'sign-off' your contribution as
   Documentation/process/submitting-patches.rst explains in the section
'Sign
   your work - the Developer's Certificate of Origin'.
.
   This text is available under GPL-2.0+ or CC-BY-4.0, as stated at the top
   of the file. If you want to distribute this text under CC-BY-4.0 only,
   please use 'The Linux kernel development community' for author
attribution
   and link this as source:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/verify-and-bisect-regressions.rst

.
   Note: Only the content of this RST file as found in the Linux kernel
sources
   is available under CC-BY-4.0, as versions of this text that were
processed
   (for example by the kernel's build system) might contain content
taken from
   files which use a more restrictive license.

