Return-Path: <linux-kernel+bounces-86080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8631586BF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4CB1F24118
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84765364D6;
	Thu, 29 Feb 2024 03:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTgGUJ7o"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73433CF1;
	Thu, 29 Feb 2024 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709176087; cv=none; b=n3Mpd+x8FanCQxBdK5MjD0l7tX48/Im2q04D65armqPbytaLkU3V2AxnKcRSOXzKLrp9nR1/bSxdqxt+vAD/Hg9kMGBm8k5w0k60YxXmkOY1gtPPEnaHQsamfOXIHEyfKTdHfchI12hcLawsOBChTxu3vLSyPeMJ7F5uib69RII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709176087; c=relaxed/simple;
	bh=QcAUxCzYfP6556O97wVS0e4m5bGKL6XPEjLA4wHJ8cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qxpc+64r1HqFvE8tDmDqOTF4NKA0AO0oE0dfq1G/Hqu5HN9nX3k6XuJo0kc4vSjIk3p8CP/Ws/BbuOPmlniF/tGfL+3hRo+iJdCjrF21f2Ld6h80jPmEwummwuA/hzcX53IUBEHUduKYu5t2Jav8OV6YfVIUlgRDcWCzWlMtV8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTgGUJ7o; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d36736d4eso300556f8f.1;
        Wed, 28 Feb 2024 19:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709176084; x=1709780884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c5OMLwHZp9ihvaBqRpMZQP7KGXLqJLRTQO586mYvq4=;
        b=NTgGUJ7odCxM5Xr2mSQV7pskjiNExMr+Jl2CVKsSO4p1gqhZYXxDSRSJ1IP39hfDJP
         0WucxIs2PBSLmsNM+IIwXQiM2iSraEyDNSRf04f3rU3+cZmNQ/j/fSMd5fX7Y65dw3ut
         qkJtgG2MC2o+FZTR43ZYmP8TU7inmHd+FWNz2SZYW3R5ZKfc9V503+XJWmH7rISD8w5g
         P8pz8lJ9c20WKX3nMHSvAijjx/+3uKc2HUVry0wKymFvOh1It/F6ydd4FvtNRPlHq5mG
         diDwkJvZfsLdgq5cPFPvOg2JwykBt53Q3F5iz1HwsStH2SOlH8NSj1XdwPgAihxUPBCo
         868A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709176084; x=1709780884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8c5OMLwHZp9ihvaBqRpMZQP7KGXLqJLRTQO586mYvq4=;
        b=qQ4Y7DJvF+JYFh/iU6EZrwgrbYPHoaj8o+9GlyffoVXeWZhVHI7ouc7KK1/VgPtx86
         gZgvwLEnkH2g+Wsm6n1srs+4qVRLsRLDSxeUsa0I4DUSNQWVFGFRDcg8TU+jibz9nmih
         9QKBoR42kiaNDNKjETc0nVuczXVfDzmUPTTRfm+mev9pKVuPXmemUNu4vrRLwMl3pOTY
         /ShXNmXoZhnVcDjCz5EPVI6avseJtHz/5XXnIVx6Xhr8g1mWUpDHIEXsh02PE/4BIZcb
         fEVSmLvuWC3e+3QisoSm7QWZVRqInz+RgNmT/Y3rEt4Lu50Ot2XaLoL3mULa9IvaVbKU
         JJVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/7ZnFwFTq68DEktQpfqgUrC6EUJHTYmnqWDiQVyGYwe2+ZRtxEBs/l0CRsNvxTa4nU7rUictwpsp8wQBML09tW6LcxtzuTMDt7R3VPbXpM3AvFpe5lR6hJPR53v7C2MM5PZAL1rhZSMt9+Ey/2LF1k/eGchRQAlzhF9pC1h5GLqit
X-Gm-Message-State: AOJu0YwfP0ojPswWduGGnB9fEin7nIXmYIA/yIIuUxPzNMf11XLPRO4s
	mPV1TWnoQ2YuwNSQXSQFZTx+pISmolFVxCv5tVePLSpb444VrX8g
X-Google-Smtp-Source: AGHT+IGbtpD5fVse7Q/U8XS88jmqnzMuf57snXPhnpFztxMOPqIzccy7C3jERo9xEvYq1HYehWZB9g==
X-Received: by 2002:adf:e0cc:0:b0:33d:6bd3:9e28 with SMTP id m12-20020adfe0cc000000b0033d6bd39e28mr380462wri.70.1709176083361;
        Wed, 28 Feb 2024 19:08:03 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id u1-20020adfb201000000b0033b1c321070sm417512wra.31.2024.02.28.19.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 19:08:03 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 1/3] docs: submit-checklist: structure by category
Date: Thu, 29 Feb 2024 04:07:41 +0100
Message-ID: <20240229030743.9125-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229030743.9125-1-lukas.bulwahn@gmail.com>
References: <20240229030743.9125-1-lukas.bulwahn@gmail.com>
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
reordering. Randy confirmed that it was important to Stephen Rothwell to
keep 'include what you use' to be the first in the list.

While at it, replace the reference to the obsolete CONFIG_DEBUG_SLAB with
CONFIG_SLUB_DEBUG.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
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


