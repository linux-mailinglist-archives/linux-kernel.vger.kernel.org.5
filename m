Return-Path: <linux-kernel+bounces-99039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029EE8782AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38E14B20C50
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F8F43ADB;
	Mon, 11 Mar 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KzH2y4Np"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140C42069;
	Mon, 11 Mar 2024 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169380; cv=none; b=Hs1PJ+MVPTK3jb4xFOAsUwxeC0PuVPfoBNd3bBT9jcDyPnSyGsLtgSFCxO4zH8Y8I0N8PCIzrmPxvUlVREitPWtkNV9ybVZVDGhA6pgF1YXQBteh+AU4iWKpGPxCOBBzqWqcfNBxNqBDb+EEEDnBFN1QMBBUBQUCKXTCdSl0IrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169380; c=relaxed/simple;
	bh=JaAKGPCeIbBacnBIWv0JFYmiGzKZfOT6utvnm7CeKoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ypw+GKISqWNVyDj8t40ycSSylV3BuA6RKa9m/9yUK3gAmgFs1X9ve1hKvufIW/zDjlYccJw/O9u3co5gcBubA/vB1PfkmMl9mbb1ubACJFW4BXaSe1FjdlOOhIjYzh+gZJgnlXm5NN577bA7cr+ISU+VlYdD5F5qUVcx9Kng8d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KzH2y4Np; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BExtWQ007122;
	Mon, 11 Mar 2024 15:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=sDdALVEPwXdAMDsB6Yy23K+bDuBEdZgIesoaVebjGAQ=;
 b=KzH2y4NpWROICErBY1qM1oynFot45tea5289diPdT9hG7ZmvSRt3+/pXsNrWUwJwtRRy
 NSLLE7mgKFmCvMZBH9EYgqngLhtF7GjmRXrAWvnohP7u6EDsu/qtip2GzX+9mx8gz8SE
 LrWOgZA3BRPK92sUEe9eM1GT+fsXreL5UOvtPVDiOehUu8+pmTylfHj9YwEHP0mSYp8/
 k4cw1MTxQYrWCgzkjlwCZOyFQ7JdNjKig8e2sjsVqpoLfjk575ibLPM1WL3Uccg6pXa5
 0NlPLrBpElaoIJgDdX4CRc9jNL8OEWKl38qPiQm3fc40pqG0SaXLrxJt0HL2mCJS+ONQ OA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6ebhhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 15:02:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BEeYNo004712;
	Mon, 11 Mar 2024 15:02:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75ym4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 15:02:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BF2I3N000311;
	Mon, 11 Mar 2024 15:02:25 GMT
Received: from t460-2.nl.oracle.com (dhcp-10-175-49-173.vpn.oracle.com [10.175.49.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3wre75ykvn-2;
	Mon, 11 Mar 2024 15:02:24 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>, cve@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        security@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@denx.de>, John Haxby <john.haxby@oracle.com>,
        Marcus Meissner <meissner@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Roxana Bradescu <roxabee@chromium.org>,
        Solar Designer <solar@openwall.com>, Matt Wilson <msw@amazon.com>
Subject: [RFC PATCH 2/2] doc: distros: new document about assessing security vulnerabilities
Date: Mon, 11 Mar 2024 16:00:54 +0100
Message-Id: <20240311150054.2945210-2-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311150054.2945210-1-vegard.nossum@oracle.com>
References: <20240311150054.2945210-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110113
X-Proofpoint-GUID: 1udM3SC4vxEdEWQMAsrbRfttMv9tDfSG
X-Proofpoint-ORIG-GUID: 1udM3SC4vxEdEWQMAsrbRfttMv9tDfSG

On February 13, kernel.org became a CVE Numbering Authority (CNA):

  https://www.cve.org/Media/News/item/news/2024/02/13/kernel-org-Added-as-CNA

The kernel.org CNA/CVE team does not provide any kind of assessment of
the allocated CVEs or patches. However, this is something that many
distributions want and need.

Provide a new document that can be used as a guide when assessing
vulnerabilities. The hope is to have a common point of reference that
can standardize or harmonize the process and hopefully enable more
cross-distribution collaboration when it comes to assessing bugfixes.

We deliberately emphasize the difficulty of assessing security impact
in the wide variety of configurations and deployments.

Since what most distros probably ultimately want is a type of CVSS score,
the guide is written with that in mind. CVSS provides its own "contextual"
modifiers, but these are not accurate or nuanced enough to capture the
wide variety of kernel configurations and deployments. We therefore focus
on practical evaluation under different sets of assumptions.

Create a new top-level (admittedly rather thin) "book" for information
for distros and place the document there as this document is not meant
for either developers or users.

See the rendered document at:

  https://vegard.github.io/linux/2024-03-11/security-assessment.html

Cc: Kees Cook <keescook@chromium.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@denx.de>
Cc: John Haxby <john.haxby@oracle.com>
Cc: Marcus Meissner <meissner@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Roxana Bradescu <roxabee@chromium.org>
Cc: Solar Designer <solar@openwall.com>
Cc: Matt Wilson <msw@amazon.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/distros/index.rst               |   8 +
 Documentation/distros/security-assessment.rst | 496 ++++++++++++++++++
 2 files changed, 504 insertions(+)
 create mode 100644 Documentation/distros/index.rst
 create mode 100644 Documentation/distros/security-assessment.rst

diff --git a/Documentation/distros/index.rst b/Documentation/distros/index.rst
new file mode 100644
index 000000000000..871f1e99042b
--- /dev/null
+++ b/Documentation/distros/index.rst
@@ -0,0 +1,8 @@
+===============================
+Documentation for distributions
+===============================
+
+.. toctree::
+   :maxdepth: 1
+
+   security-assessment
diff --git a/Documentation/distros/security-assessment.rst b/Documentation/distros/security-assessment.rst
new file mode 100644
index 000000000000..2e046c9f5f29
--- /dev/null
+++ b/Documentation/distros/security-assessment.rst
@@ -0,0 +1,496 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Assessing security vulnerabilities
+==================================
+
+:Author: Vegard Nossum <vegard.nossum@oracle.com>
+
+This document is intended for distributions and others who want to assess
+the severity of the bugs fixed by Linux kernel patches.
+
+We could consider *everything* a security issue until proven otherwise, or we
+could consider *nothing* a security issue until proven otherwise. Neither of
+these approaches are useful in practice. Security assessment is therefore
+partly an exercise in finding the middle ground. This guide attempts to make
+reasonable tradeoffs in order to maximize the utility of security assessments.
+
+Exploitability also depends highly on the context, so we make a distinction
+between a general worst-case assessment and context-specific assessments.
+
+This is NOT an exploitation guide.
+
+.. contents:: Table of contents
+    :local:
+    :backlinks: none
+
+
+What is a vulnerability?
+========================
+
+For the purposes of this document, we consider all bugfixes to be
+potential vulnerabilities. This is because, as stated in
+Documentation/process/cve.rst, whether a bug is exploitable or not
+depends highly on the context (threat model, platform/hardware,
+kernel configuration, boot parameters, runtime configuration,
+connected peripherals, etc.).
+
+The severity of a bugfix can thus range from being completely benign
+to enabling an attacker to gain complete control over a machine --
+these two conclusions can be reached for the exact same patch depending
+on context it is being considered in.
+
+Another aspect of this is that a bug may itself not be very serious, but
+serve as a step in a chain of exploits. A common example of this is when
+a kernel pointer is accidentally revealed to userspace, which gives an
+attacker the ability to bypass `KASLR protections`_.
+
+.. _KASLR protections: https://lwn.net/Articles/569635/
+
+Common assessment scenarios
+---------------------------
+
+In order to share common ground when discussing different attack
+scenarios, we define these four contexts which range from general
+to specific:
+
+1. **Worst-case scenario** with a minimum of mitigating factors and
+   assumptions: driver is enabled, in use, mitigations are disabled or
+   ineffective, etc.
+
+2. **Common configurations**: assuming kernel defaults, taking into
+   account hardware prevalence, etc.
+
+3. **Distro-specific configuration** and defaults: This assessment of a
+   bugfix takes into account a specific kernel configuration and the
+   distro's own assumptions about how the system is configured and
+   intended to be used.
+
+4. **Specific use case** for a single user or deployment: Here we can make
+   precise assumptions about what kernel features are in use and whether
+   physical access is possible.
+
+The most interesting scenarios are probably 1 and 3; the worst-case
+scenario is the best we can do for an assessment that is supposed to be
+valid for the entire kernel community, while individual distributions will
+probably want to take their specific kernel configuration and use cases
+into account.
+
+Latent vulnerabilities
+----------------------
+
+It is worth mentioning the possibility of latent vulnerabilities:
+These are code "defects" which technically cannot be exploited on any
+current hardware, configuration, or scenario, but which should nevertheless
+be fixed since they represent a possible future vulnerability if other
+parts of the code change.
+
+An example of latent vulnerabilities is the failure to check the return
+value of kmalloc() for small memory allocations: as of early 2024, these
+are `well-known to never fail in practice <https://lwn.net/Articles/627419/>`_
+and are thus not exploitable and not technically vulnerabilities. If this
+rule were to change (because of changes to the memory allocator), then these
+would become true vulnerabilities.
+
+We recommend that a "worst-case scenario" assessment don't consider latent
+vulnerabilities as actual vulnerabilities since this is a slippery slope
+where eventually all changes can be considered a vulnerability in some sense
+or another; in that case, we've thrown the baby out with the bath water and
+rendered assessment completely useless.
+
+Exploitability and unknowns
+---------------------------
+
+Beyond build and runtime configuration, there are many factors that play
+into whether a bug is exploitable in practice. Some of these are very
+subtle and it may be incredibly difficult to prove that a bug is, in fact,
+exploitable -- or reliably exploitable.
+
+Similarly to latent vulnerabilities, we need to be careful not to throw
+the baby out with the bath water: requiring a full exploit in order to
+deem a bug exploitable is a too high burden of proof and would discount
+many bugs that could be exploitable if enough time and energy was poured
+into exploring it fully.
+
+Many exploits rely on precise memory layouts of structs and things like
+slab merging (or more generally that certain memory allocation patterns are
+possible) or extremely tight races that look impossible to achieve.
+
+In the absence of other specific information, we recommend considering the
+bug from a "worst case" point of view, i.e. that it is indeed exploitable.
+
+
+Types of bugs
+=============
+
+There are many ways to classify types of bugs into broad categories. Two
+ways that we'll cover here are in terms of the outcome (i.e. what an
+attacker could do in the worst case) and in terms of the source defect.
+
+In terms of outcome:
+
+- **local DoS** (Denial of Service): a local user is able to crash the
+  machine or make it unusable in some way
+
+- **remote DoS**: another machine on the network is able to crash the
+  machine or make it unusable in some way
+
+- **local privilege escalation**: a local user is able to become root,
+  gain capabilities, or more generally become another user with more
+  privileges than the original user
+
+- **kernel code execution**: the attacker is able to run arbitrary code
+  in a kernel context; this is largely equivalent to a privilege escalation
+  to root
+
+- **information leak**: the attacker is able to obtain sensitive information
+  (secret keys, access to another user's memory or processes, etc.)
+
+- **kernel address leak**: a subset of information leaks; this can lead to
+  KASLR bypass, usually just one step as part of an exploit chain.
+
+In terms of source defect:
+
+- **use after free**: can be exploited by allocating another object in the
+  spot that was freed and partially or fully controlling the contents of
+  that object; some otherwise illegal values may let you "control" what the
+  kernel does (e.g. pointers to other objects or function pointers)
+
+- **heap buffer overflow**: similarly may allow you to overwrite values in
+  other objects or read values from unrelated objects
+
+- **stack buffer overflow**: may allow you to overwrite local variables or
+  return addresses on the stack; this is pretty well mitigated by the
+  compiler these days (CFI, stackprotector, etc.) and may not be as huge a
+  concern as it used to be
+
+- **double free**: this may result in general memory corruption, corruption
+  of structures used by the memory allocator, or further use after free
+
+- **memory leak**: typically results in DoS if you can make the machine
+  completely run out of memory, or potentially trigger some error handling
+  code paths
+
+- **reference counting bug**: can result in either a memory leak or a use
+  after free (with quite different outcomes in terms of severity)
+
+- **NULL pointer dereference**: this used to be a severe vulnerability
+  because `userspace could mmap() something at address 0 and trick the
+  kernel into dereferencing it <https://lwn.net/Articles/342330/>`_; this
+  is typically relatively harmless these days because the kernel does not
+  allow this anymore. Nowadays, a NULL pointer dereference typically just
+  results in the kernel killing the offending process; however, in some
+  cases the program that crashed may be holding on to various resources
+  (such as locks, references) which causes DoS or potentially `overflow
+  things like reference counts <https://lwn.net/Articles/914878/>`_.
+
+- **incorrect error handling**: not really a precise bug category by itself
+  but can often lead to a number of the other errors listed above (resource
+  leaks, double frees, etc.)
+
+- **not checking kmalloc() return values**: a subtype of error handling
+  bugs; it is widely believed that `"small" SLAB allocation requests cannot
+  fail <https://lwn.net/Articles/627419/>`_ and thus do not actually
+  represent a security vulnerability
+
+- **logic error**: this is a very general category of errors and potentially
+  includes such things as not checking or respecting permissions, bounds,
+  or other values supplied by userspace
+
+- **missing or incorrect bounds check**: a subtype of logic errors, this
+  often leads to out-of-bounds memory accesses
+
+- **races**: missing or incorrect use of locking, atomics, and memory
+  barriers can manifest in many different ways, including many of the
+  categories listed above.
+
+A useful rule of thumb is that anything that can cause invalid memory
+dereferences is a potential privilege escalation bug.
+
+These categories are not perfect and not exhaustive; it is meant to be a
+rough guide covering the most common cases. There is always room to treat
+special cases specially.
+
+
+Mitigations and hardening
+=========================
+
+The kernel comes with a number of options for hardening and mitigating
+the effects of certain types of attacks:
+
+- `Address-space layout randomization <https://lwn.net/Articles/569635/>`_
+- `Stack protection <https://lwn.net/Articles/584225/>`_
+- `Hardened usercopy <https://lwn.net/Articles/695991/>`_
+- `Reference count hardening <https://lwn.net/Articles/693038/>`_
+- `Bounds checking (fortify) <https://lwn.net/Articles/864521/>`_
+
+The purpose of this section is not to recommend certain options be enabled or
+disabled (for that, see the `Kernel Self Protection Project's recommended
+settings <http://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings>`_),
+but to document the fact that many of these options can affect how a
+vulnerability is scored.
+
+
+CVEs and CVSS scores for the kernel
+===================================
+
+CVSS (`Common Vulnerability Scoring System <https://en.wikipedia.org/wiki/Common_Vulnerability_Scoring_System>`_)
+is an open standard for vulnerability scoring and the system which is
+commonly used by Linux distributions and various industry and government
+bodies.
+
+We won't go into the details of CVSS here, except to give a guide on how
+it could be applied most effectively in the context of the kernel.
+
+**Attack Vector** (Local, Network, Physical):
+
+  The attack vector for most bugfixes will probably be **Local**, i.e.
+  you need a local user account (or more generally user access, e.g. a
+  shell account) in order to trigger the buggy code.
+
+  If a networking protocol or device is involved, the attack
+  vector may be **Network**. However, many bugs in networking code may
+  actually only be locally exploitable, for example bugs that would
+  trigger when passing invalid values to a socket-related system call
+  (e.g. setsockopt()) or when making system calls in a specific sequence.
+
+  The attack vector **Physical** is used when physical access
+  to a machine is required, for example USB device driver bugs that can
+  only be exploited by physically inserting a device into a USB port.
+
+**Attack Complexity** (Low, High):
+
+  This metric represents roughly how difficult it would be to work around
+  security measures like ASLR and how much an exploit would need to be
+  tailored to a specific target in order to be successful.
+
+  As a rule of thumb, the less severe outcomes like DoS or information
+  leaks often have complexity **Low**, while outcomes like privilege
+  escalations and kernel code execution often have complexity **High**.
+
+**Privileges Required** (None, Low, High):
+
+  This metric refers to what kind of privileges the attacker must have in
+  order to exploit the bug.
+
+  We propose that unauthenticated remote attacks have the value **None**;
+  if you can trigger the bug as a local user without any specific
+  additional privileges this would be **Low**, and if additional privileges
+  are required for the user (such as e.g. ``CAP_NET_RAW``) then this would
+  be **High**.
+
+**User Interaction** (None, Required):
+
+  This will usually have the value **None** unless a successful attack
+  requires interaction from another, legitimate user. In that case the
+  value will be **Required**; this could be the case e.g. for filesystem
+  bugs that require the user to run a command (in this case ``mount``)
+  in order to trigger the bug.
+
+**Scope** (Changed, Unchanged):
+
+  For bugs where privilege escalation or kernel code execution is a
+  possible outcome, this will typically be **Changed** (since the kernel
+  has access to the whole system), whereas for outcomes like DoS the
+  scope will be **Unchanged**. Information leaks can have either value
+  depending on whether the information pertains to the original user
+  (**Unchanged**) or other users (**Changed**).
+
+**Confidentiality** (None, Low, High):
+
+  For privilege escalation or kernel code execution bugs, this will
+  typically be **High**; for information leaks this will be **Low**,
+  and for DoS this will be **None**.
+
+**Integrity** (None, Low, High):
+
+  For privilege escalation or kernel code execution bugs, this will
+  typically be **High**; for information leaks this will be **Low**,
+  and for DoS this will be **None**.
+
+**Availability** (None, Low, High):
+
+  For information leaks this will be **None**, whereas almost all other
+  outcomes have a **High** availability impact (a DoS is a loss of
+  availability by definition, whereas privilege escalations typically
+  allows the attacker to reduce the availability as well).
+
+The temporal metrics are optional, but may be useful for kernel patches:
+
+**Exploit Code Maturity**:
+
+  **Unreported** where no reproducer of any kind is known (suitable e.g.
+  for fixes based on reports from static checkers) or **POC** if the issue
+  has been demonstrated
+
+**Remediation Level**:
+
+  This will typically always be **Official Fix** since kernel.org CVEs are
+  only assigned once a patch has been published.
+
+**Report Confidence**:
+
+  This will be **Unknown** for theoretical issues or issues reported by
+  static checkers or **Reasonable** for issues that have been triggered
+  by the reporter or author of the patch (as indicated perhaps by a
+  stack trace or other error message reproduced in the changelog for the
+  patch).
+
+To calculate a final CVSS score (value from 0 to 10), use a calculator
+such as `<https://www.first.org/cvss/calculator/>`_ (also includes detailed
+explanations of each metric and its possible values).
+
+A distro may wish to start by checking whether the file(s) being patched
+are even compiled into their kernel; if not, congrats! You're not vulnerable
+and don't really need to carry out a more detailed analysis.
+
+For things like loadable modules (e.g. device drivers for obscure hardware)
+and runtime parameters you might have a large segment of users who are not
+vulnerable by default.
+
+
+Reachability analysis
+=====================
+
+One of the most frequent tasks for evaluating a security issue will be to
+figure out how the buggy code can be triggered. Usually this will mean
+starting with the function(s) being patched and working backwards through
+callers to figure out where the code is ultimately called from. Sometimes
+this will be a system call, but may also be timer callbacks, workqueue
+items, interrupt handlers, etc. Tools like `cscope <https://en.wikipedia.org/wiki/Cscope>`_
+(or just plain ``git grep``) can be used to help untangle these callchains.
+
+Special care will need to be taken to track function calls made through
+function pointers, especially those stored somewhere on the heap (e.g.
+timer callbacks or pointers to "ops" structs like ``struct super_operations``).
+
+While unnesting the call stack, it may be useful to keep track of any
+conditions that need to be satisfied in order to reach the buggy code,
+perhaps especially calls to ``capable()`` and other capabilities-related
+functions, which may place restrictions on what sort of privileges you
+need to reach the code.
+
+User namespaces
+---------------
+
+By design, `user namespaces <https://lwn.net/Articles/528078/>`_ allow
+non-root processes to behave as if they are root for an isolated part
+of the system. Some important things to be aware of in this respect are:
+
+- User namespaces (in combination with mount namespaces) allow a
+  regular user to mount certain filesystems (proc, sys, and others);
+  see https://man7.org/linux/man-pages/man7/user_namespaces.7.html
+  for more information.
+
+- User namespaces (perhaps in combination with network namespaces)
+  allow a regular user to create sockets for network protocols they
+  would otherwise not be able to access; see
+  https://lwn.net/Articles/740455/ for more information.
+
+- ``capable()`` checks capabilities in the initial user namespace,
+  whereas ``ns_capable()`` checks capabilities in the current user
+  namespace.
+
+
+Examples
+========
+
+In the following examples, we give scores from a "worst case" context,
+i.e. assuming the hardware/platform is in use, the driver is compiled
+in, mitigations are disabled or otherwise ineffective, etc.
+
+**Commit 72d9b9747e78 ("ACPI: extlog: fix NULL pointer dereference check")**:
+
+  The first thing to notice is that the code here is in an ``__exit``
+  function, meaning that it can only run when the module is unloaded
+  (the ``mod->exit()`` call in the delete_module() system call) --
+  inspecting this function reveals that it is restricted to processes
+  with the ``CAP_SYS_MODULE`` capability, meaning you already need
+  quite high privileges to trigger the bug.
+
+  The bug itself is that a pointer is dereferenced before it has been
+  checked to be non-NULL. Without deeper analysis we can't really know
+  whether it is even possible for the pointer to be NULL at this point,
+  although the presence of a check is a good indication that it may be.
+  By grepping for ``extlog_l1_addr``, we see that it is assigned in the
+  corresponding module_init() function and moreover that the only way
+  it can be NULL is if the module failed to load in the first place.
+  Since module_exit() functions are not called on module_init() failure
+  we can conclude that this is not a vulnerability.
+
+**Commit 27e56f59bab5 ("UBSAN: array-index-out-of-bounds in dtSplitRoot")**:
+
+  Right away we notice that this is a filesystem bug in jfs. There is a
+  stack trace showing that the code is coming from the mkdirat() system
+  call. This means you can likely trigger this as a regular user, given
+  that a suitable jfs filesystem has been mounted. Since this is a bug
+  found by syzkaller, we can follow the link in the changelog and find
+  the reproducer. By looking at the reproducer we can see that it almost
+  certainly mounts a corrupted filesystem image.
+
+  When filesystems are involved, the most common scenario is probably
+  when a user has privileges to mount filesystem images in the context
+  of a desktop environment that allows the logged-in user to mount
+  attached USB drives, for example. In this case, physical access would
+  also be necessary, which would make this Attack Vector **Physical**
+  and User Interaction **Required**.
+
+  Another scenario is where a malicious filesystem image is passed to a
+  legitimate user who then unwittingly mounts it and runs
+  mkdir()/mkdirat() to trigger the bug. This would clearly be User
+  Interaction **Required**, but it's not so clear what the Attack Vector
+  would be -- let's call it **Physical**, which is the least severe of
+  the options given to us by CVSS, even though it's not a true physical
+  attack.
+
+  This is an out-of-bounds memory access, so without doing a much deeper
+  analysis we should assume it could potentially lead to privilege
+  escalation, so Scope **Changed**, Confidentiality **High**, Integrity
+  **High**, and Availability **High**.
+
+  Since regular users can't normally mount arbitrary filesystems, we can
+  set Attack Complexity **High** and Privileges **Required**.
+
+  If we also set Exploit Code Maturity **Unproven**, we end up with the
+  following CVSSv3.1 vector:
+
+  - CVSS:3.1/AV:P/AC:H/PR:H/UI:R/S:C/C:H/I:H/A:H/E:U (6.2 - Medium)
+
+  If this score seems high, keep in mind that this is a worst case
+  scenario. In a more specific scenario, jfs might be disabled in the
+  kernel config or there is no way for non-root users to mount any
+  filesystem.
+
+**Commit b988b1bb0053 ("KVM: s390: fix setting of fpc register")**:
+
+  From the changelog: "corruption of the fpc register of the host process"
+  and "the host process will incorrectly continue to run with the value
+  that was supposed to be used for a guest cpu".
+
+  This makes it clear that a guest can partially take control of the
+  host process (presumably the host process running the KVM), which would
+  be a privilege escalation of sorts -- however, since this is corruption
+  of floating-point registers and not a memory error, it is highly
+  unlikely to be exploitable beyond DoS in practice (even then, it is
+  questionable whether the DoS impacts anything beyond the KVM process
+  itself).
+
+  Because an attack would be difficult to pull off, we propose Attack
+  Complexity **High**, and because there isn't a clear or likely path to
+  anything beyond DoS, we'll select Confidentiality **None**, Integrity
+  **Low** and Availability **Low**.
+
+  We suggest the following CVSSv3.1 vector:
+
+  - CVSS:3.1/AV:L/AC:H/PR:N/UI:N/S:U/C:N/I:L/A:L/E:U (3.7 - Low)
+
+
+Futher reading
+==============
+
+Different vendors have other/different rating and classification systems
+for vulnerabilities and severities:
+
+- Microsoft: https://www.microsoft.com/en-us/msrc/security-update-severity-rating-system
+- Red Hat: https://access.redhat.com/security/updates/classification
+- Google: https://cloud.google.com/security-command-center/docs/finding-severity-classifications#severity_classifications
-- 
2.34.1


