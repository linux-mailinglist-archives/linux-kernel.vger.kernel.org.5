Return-Path: <linux-kernel+bounces-81207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB70867202
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35741C28A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E001D554;
	Mon, 26 Feb 2024 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeDEVlLs"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78A13AC5;
	Mon, 26 Feb 2024 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944435; cv=none; b=mZAKXJgunqwd4pAfs1rMw7jdTrKKLIh/npY9Y9FAnYPcadhiq/zSxRd9yv4sVXInofJd/mTWPkhTXQbu45/CabbEiaISCfwZOaewtmEztSkYojHwdDVcNOCjqwv9sXedMvEhLrtlwl8A6agdS17uRUdEkPNoVxTDa+qtB/ju0LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944435; c=relaxed/simple;
	bh=b2zP15hp3my/Zgo6TPJb8NR4Hz/zxAHO+EDyKjO8PFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nfvmp/94NnpdjKD4T79rLVN7Z/mosgLRrt0ofrf2qHFpEoV6tG6cUNCrjVXho+SZONoRo+BtyXhPrGSTAxr7q+A+PvBCrz1VVaHaObEeN9tCzXoGvEeZJ8ttQ6ouA5dQU+lpPbc5jYmR5zZzV1X2L3wENfiSzrx+05WYs8x449o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeDEVlLs; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so411045666b.2;
        Mon, 26 Feb 2024 02:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708944431; x=1709549231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpfx0GE3evITkVyqlAdocfj8/iqGlFsQTTziHhgua2c=;
        b=QeDEVlLsqZWpzu0dMp1doKD/LPxiTZ7ftLDwMRGqdNMrn6DAH9vjllO9rVaKPgAiGG
         WuvIkKXo6LzAfczp5Wxv76Gve6aEmk34EVLu1i9E0ASyBH9tn3LgyKjLwgeljmXlFTZW
         UhsDtD4HS1GS54CcDXv0/ztezmaM8kZ5cN0B+Tk9oBGNWFlR8jfDToLqu9vNdpasrHkL
         jhIV3WNkUSU90jO4mHmdUA2Oz1iKJI29Tt7Bnr++91+bbGWmiP0fdyPd37ayiUNLvbqA
         O3iKKqYn+kptDy0iFsCoskt3mWk7BYgchZeudo1LQC4b/d9JKlT/CL/Ah2lzfU9m+QSt
         JcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708944431; x=1709549231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpfx0GE3evITkVyqlAdocfj8/iqGlFsQTTziHhgua2c=;
        b=Z2105LPJ9fIYvPeZpLnvWozot5xXMgLy7S1hl73c5DJTmZJLjAB/qoVBk56kSXm/eY
         JFl0EY7X4CykaTyKjR89sFMpLEQqbkmSyNAcxuXBJvxvHuSeaRM7k6y56OqqSJoaqMQd
         xf34JxNgfmKzsyTwsyTTFRuoAsk5+J6zZcN8a0OlZFs8hxSuq7AEJJNc7HgoBj7jiykO
         vFVDUjJwKQHBZNSpc2LPVewvAUhCIKdTMhjrAWq5tkONlL8dAQeuYvJVjFK2S1CB724i
         /vDKACmvmD4SCotz+Ay/tLouqKHfwCuh/uJFleKQAnANwwkMCuRteDgtu5ljLvmXriDJ
         mAAw==
X-Forwarded-Encrypted: i=1; AJvYcCVadW32rFTSVaFu/PyXbsTyfOEbv/brISij9KHzMFk7hFBwhVfVxq4ignaJOxbN7pvG8LJZQYJpFhs2kZXfF6S1lBFWtHV0I6TevGFIvoUhQLBPMf42Czlf17M973FIuYsa0am+xSIX0cKzzE2QNjI6ivcvFG4XS1YvhZsnZRfo8fts
X-Gm-Message-State: AOJu0YyyOD3eK24rPzuzf0L1jyODp2ysTZdcQQdpIaLIeQmu0OazhPvG
	AWgpZdxHL/VrA3LEW0uHrb3phhemmmernP7zVoTjl3JX75U6dZ6z
X-Google-Smtp-Source: AGHT+IH8BTS8jTgd4YgQ/FRXtECBOni7z5mBkZk/W8XRrm6RSZBPGzGzCvvsv6NrzEuuqVCjId4GpA==
X-Received: by 2002:a17:906:a049:b0:a43:3670:a2b7 with SMTP id bg9-20020a170906a04900b00a433670a2b7mr2259386ejb.44.1708944431110;
        Mon, 26 Feb 2024 02:47:11 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id tl2-20020a170907c30200b00a4335edcfd1sm1213528ejc.189.2024.02.26.02.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:47:10 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] docs: submit-checklist: structure by category
Date: Mon, 26 Feb 2024 11:46:53 +0100
Message-ID: <20240226104653.54877-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While going through the submit checklist, the list order seemed rather
random, probably just by historical coincidences of always adding yet the
next point someone thought of at the end of the list.

Structure and order them by the category of such activity,
reviewing, documenting, checking with tools, building and testing.

As the diff of the reordering is large:
Review code now includes previous points 1, 5 and 22.
Review Kconfig includes previous 6, 7 and 8.
Documenting includes previous 11, 15, 16, 17, 18 and 23.
Checking with tools includes previous 5, 9 and 10.
Building includes previous 2, 3, 20 and 24.
Testing includes previous 12, 13, 14, 19 and 21.

Previous point 4 (compile for ppc64) was merged into point 3 (build for
many architectures), as it was just a further note to cross-compiling.

Previous point 5 was split into one in review and one in checking
to have every previous point in the right category.
Point 11 was shortened, as building documentation is mentioned already
in Build your code, 1d.

A note that was presented visually much too aggressive in the HTML view was
turned into a simple "Note that..." sentence in the enumeration.

The recommendation to test with the -mm patchset (previous 21, now
testing, point 5) was updated to the current state of affairs to test with
a recent tag of linux-next.

Note that the previous first point still remains the first list even after
reordering. Based on some vague memory, the first point was important to
Randy to stay the first one in any reordering.

While at it, the reference to CONFIG_SLUB_DEBUG was replaced by
CONFIG_DEBUG_SLAB.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
So far, no point disappeared and nothing new was added.

Points/Ideas for further improvements (based on my knowledge and judgement):

  - The Review Kconfig changes makes sense, but I am not sure if they are
    so central during review. If we keep it, let us see if there are other
    parts for review that are also important similar to Kconfig changes.
   
  - Concerning checking with tools, checkpatch probably still makes sense;
    it pointed out in several places. If sparse and checkstack are really
    the next two tools to point out, I am not so sure about.
    sparse has a lot of false positives nowadays, and many things are not
    fixed just because sparse complains about it.
    And I have never used make checkstack and have not found much
    documentation about it.
    So, maybe other tools deserve to be mentioned here instead?

I am happy to get feedback---I will work through submitting-patches next
and do some clean-up there. While doing that, I might learn what really
should go into a better future 'submit-checklist' documentation.

 Documentation/process/submit-checklist.rst | 157 +++++++++++----------
 1 file changed, 84 insertions(+), 73 deletions(-)

diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
index b1bc2d37bd0a..7d8dba942fe8 100644
--- a/Documentation/process/submit-checklist.rst
+++ b/Documentation/process/submit-checklist.rst
@@ -11,110 +11,121 @@ These are all above and beyond the documentation that is provided in
 and elsewhere regarding submitting Linux kernel patches.
 
 
+*Review your code:*
+
 1) If you use a facility then #include the file that defines/declares
    that facility.  Don't depend on other header files pulling in ones
    that you use.
 
-2) Builds cleanly:
+2) Check your patch for general style as detailed in
+   :ref:`Documentation/process/coding-style.rst <codingstyle>`.
 
-  a) with applicable or modified ``CONFIG`` options ``=y``, ``=m``, and
-     ``=n``.  No ``gcc`` warnings/errors, no linker warnings/errors.
+3) All memory barriers {e.g., ``barrier()``, ``rmb()``, ``wmb()``} need a
+   comment in the source code that explains the logic of what they are doing
+   and why.
 
-  b) Passes ``allnoconfig``, ``allmodconfig``
 
-  c) Builds successfully when using ``O=builddir``
+*Review Kconfig changes:*
 
-  d) Any Documentation/ changes build successfully without new warnings/errors.
-     Use ``make htmldocs`` or ``make pdfdocs`` to check the build and
-     fix any issues.
+1) Any new or modified ``CONFIG`` options do not muck up the config menu and
+   default to off unless they meet the exception criteria documented in
+   ``Documentation/kbuild/kconfig-language.rst`` Menu attributes: default value.
 
-3) Builds on multiple CPU architectures by using local cross-compile tools
-   or some other build farm.
+2) All new ``Kconfig`` options have help text.
 
-4) ppc64 is a good architecture for cross-compilation checking because it
-   tends to use ``unsigned long`` for 64-bit quantities.
+3) Has been carefully reviewed with respect to relevant ``Kconfig``
+   combinations.  This is very hard to get right with testing---brainpower
+   pays off here.
 
-5) Check your patch for general style as detailed in
-   :ref:`Documentation/process/coding-style.rst <codingstyle>`.
-   Check for trivial violations with the patch style checker prior to
-   submission (``scripts/checkpatch.pl``).
-   You should be able to justify all violations that remain in
-   your patch.
+*Provide documentation:*
 
-6) Any new or modified ``CONFIG`` options do not muck up the config menu and
-   default to off unless they meet the exception criteria documented in
-   ``Documentation/kbuild/kconfig-language.rst`` Menu attributes: default value.
+1) Include :ref:`kernel-doc <kernel_doc>` to document global kernel APIs.
+   (Not required for static functions, but OK there also.)
 
-7) All new ``Kconfig`` options have help text.
+2) All new ``/proc`` entries are documented under ``Documentation/``
 
-8) Has been carefully reviewed with respect to relevant ``Kconfig``
-   combinations.  This is very hard to get right with testing -- brainpower
-   pays off here.
+3) All new kernel boot parameters are documented in
+   ``Documentation/admin-guide/kernel-parameters.rst``.
+
+4) All new module parameters are documented with ``MODULE_PARM_DESC()``
 
-9) Check cleanly with sparse.
+5) All new userspace interfaces are documented in ``Documentation/ABI/``.
+   See ``Documentation/ABI/README`` for more information.
+   Patches that change userspace interfaces should be CCed to
+   linux-api@vger.kernel.org.
 
-10) Use ``make checkstack`` and fix any problems that it finds.
+6) If any ioctl's are added by the patch, then also update
+   ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
 
-    .. note::
 
-       ``checkstack`` does not point out problems explicitly,
-       but any one function that uses more than 512 bytes on the stack is a
-       candidate for change.
+*Check your code with tools:*
 
-11) Include :ref:`kernel-doc <kernel_doc>` to document global  kernel APIs.
-    (Not required for static functions, but OK there also.) Use
-    ``make htmldocs`` or ``make pdfdocs`` to check the
-    :ref:`kernel-doc <kernel_doc>` and fix any issues.
+1) Check for trivial violations with the patch style checker prior to
+   submission (``scripts/checkpatch.pl``).
+   You should be able to justify all violations that remain in
+   your patch.
 
-12) Has been tested with ``CONFIG_PREEMPT``, ``CONFIG_DEBUG_PREEMPT``,
-    ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
-    ``CONFIG_DEBUG_SPINLOCK``, ``CONFIG_DEBUG_ATOMIC_SLEEP``,
-    ``CONFIG_PROVE_RCU`` and ``CONFIG_DEBUG_OBJECTS_RCU_HEAD`` all
-    simultaneously enabled.
+2) Check cleanly with sparse.
 
-13) Has been build- and runtime tested with and without ``CONFIG_SMP`` and
-    ``CONFIG_PREEMPT.``
+3) Use ``make checkstack`` and fix any problems that it finds.
+   Note that ``checkstack`` does not point out problems explicitly,
+   but any one function that uses more than 512 bytes on the stack is a
+   candidate for change.
 
-14) All codepaths have been exercised with all lockdep features enabled.
 
-15) All new ``/proc`` entries are documented under ``Documentation/``
+*Build your code:*
+
+1) Builds cleanly:
+
+  a) with applicable or modified ``CONFIG`` options ``=y``, ``=m``, and
+     ``=n``.  No ``gcc`` warnings/errors, no linker warnings/errors.
+
+  b) Passes ``allnoconfig``, ``allmodconfig``
+
+  c) Builds successfully when using ``O=builddir``
+
+  d) Any Documentation/ changes build successfully without new warnings/errors.
+     Use ``make htmldocs`` or ``make pdfdocs`` to check the build and
+     fix any issues.
 
-16) All new kernel boot parameters are documented in
-    ``Documentation/admin-guide/kernel-parameters.rst``.
+2) Builds on multiple CPU architectures by using local cross-compile tools
+   or some other build farm. Note that ppc64 is a good architecture for
+   cross-compilation checking because it tends to use ``unsigned long`` for
+   64-bit quantities.
 
-17) All new module parameters are documented with ``MODULE_PARM_DESC()``
+3) Newly-added code has been compiled with ``gcc -W`` (use
+   ``make KCFLAGS=-W``).  This will generate lots of noise, but is good
+   for finding bugs like "warning: comparison between signed and unsigned".
 
-18) All new userspace interfaces are documented in ``Documentation/ABI/``.
-    See ``Documentation/ABI/README`` for more information.
-    Patches that change userspace interfaces should be CCed to
-    linux-api@vger.kernel.org.
+4) If your modified source code depends on or uses any of the kernel
+   APIs or features that are related to the following ``Kconfig`` symbols,
+   then test multiple builds with the related ``Kconfig`` symbols disabled
+   and/or ``=m`` (if that option is available) [not all of these at the
+   same time, just various/random combinations of them]:
 
-19) Has been checked with injection of at least slab and page-allocation
-    failures.  See ``Documentation/fault-injection/``.
+   ``CONFIG_SMP``, ``CONFIG_SYSFS``, ``CONFIG_PROC_FS``, ``CONFIG_INPUT``,
+   ``CONFIG_PCI``, ``CONFIG_BLOCK``, ``CONFIG_PM``, ``CONFIG_MAGIC_SYSRQ``,
+   ``CONFIG_NET``, ``CONFIG_INET=n`` (but latter with ``CONFIG_NET=y``).
 
-    If the new code is substantial, addition of subsystem-specific fault
-    injection might be appropriate.
 
-20) Newly-added code has been compiled with ``gcc -W`` (use
-    ``make KCFLAGS=-W``).  This will generate lots of noise, but is good
-    for finding bugs like "warning: comparison between signed and unsigned".
+*Test your code:*
 
-21) Tested after it has been merged into the -mm patchset to make sure
-    that it still works with all of the other queued patches and various
-    changes in the VM, VFS, and other subsystems.
+1) Has been tested with ``CONFIG_PREEMPT``, ``CONFIG_DEBUG_PREEMPT``,
+   ``CONFIG_SLUB_DEBUG``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
+   ``CONFIG_DEBUG_SPINLOCK``, ``CONFIG_DEBUG_ATOMIC_SLEEP``,
+   ``CONFIG_PROVE_RCU`` and ``CONFIG_DEBUG_OBJECTS_RCU_HEAD`` all
+   simultaneously enabled.
 
-22) All memory barriers {e.g., ``barrier()``, ``rmb()``, ``wmb()``} need a
-    comment in the source code that explains the logic of what they are doing
-    and why.
+2) Has been build- and runtime tested with and without ``CONFIG_SMP`` and
+   ``CONFIG_PREEMPT.``
 
-23) If any ioctl's are added by the patch, then also update
-    ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
+3) All codepaths have been exercised with all lockdep features enabled.
 
-24) If your modified source code depends on or uses any of the kernel
-    APIs or features that are related to the following ``Kconfig`` symbols,
-    then test multiple builds with the related ``Kconfig`` symbols disabled
-    and/or ``=m`` (if that option is available) [not all of these at the
-    same time, just various/random combinations of them]:
+4) Has been checked with injection of at least slab and page-allocation
+   failures.  See ``Documentation/fault-injection/``.
+   If the new code is substantial, addition of subsystem-specific fault
+   injection might be appropriate.
 
-    ``CONFIG_SMP``, ``CONFIG_SYSFS``, ``CONFIG_PROC_FS``, ``CONFIG_INPUT``, ``CONFIG_PCI``, ``CONFIG_BLOCK``, ``CONFIG_PM``, ``CONFIG_MAGIC_SYSRQ``,
-    ``CONFIG_NET``, ``CONFIG_INET=n`` (but latter with ``CONFIG_NET=y``).
+5) Tested with the most recent tag of linux-next to make sure that it still
+   works with all of the other queued patches and various changes in the VM,
+   VFS, and other subsystems.
-- 
2.43.2


