Return-Path: <linux-kernel+bounces-118964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0839388C1FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706FA1F63376
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CB976401;
	Tue, 26 Mar 2024 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="iWCNxYR9"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3045D7353D;
	Tue, 26 Mar 2024 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455714; cv=none; b=LpoEEmELVfbs8hmHsykHLmlgLxtG/GqCZW4/l0/R+2oaRjVwQaszoZTrZqiiD8KiB9Sln5U7LojjdhUk7opikS8P3biONDBiHdS3Mx1zYDcK/rWRkBUTdOKPmHAuivi7wWOq+EZdF+gu1cx+6GVCbXOcNdZq1aXSXfvWou8Wzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455714; c=relaxed/simple;
	bh=EHkf9zQWVCrbVg6RwIVH/RCrzMkzsLSJ3BgNHt7DwEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEsEfF5VkefC90vizBIUo/RXzLH7XPhGu5e3hI/qrIvJ+BGbeJKwr4febSzMAPpwFwh1vfmiRr6zMmqTgxtLLIRsFZYHcolOS+moK4v5+KN0dfHyrYIxrIfdJTGwLYBkfYva/qHbtEXGCOEkD4sUNcVMxI+dcbLvP53Lx46928M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=iWCNxYR9; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=0a6ZAtmG9oBatBg6HcOJ39ldrKzI8Q1aQrDOAdAsTkk=; t=1711455711;
	x=1711887711; b=iWCNxYR9oPOW9HR3MkZZD7Xn3E678fdLZk4EZT/IEhoeZmIQzLcn8+9ywkyBP
	xluzHrbchHEBci5XYrbwoj/ekSnF6+HXWWYl589yyTbDD2vsxz1Mp+lRWvkBDX9idMNY0dShDl1DC
	izPP0lJw1M+iVzeeW037APoFyhVAfo47TYDwP2rrz0BxbnPsWDt/JRGxn1DE39Y8z4BNGK05zh2tc
	Oe2yRjAaUupA8CaQVijAgieoQ9XMUwdIPyVwksHUdo68A/tnZZyd6X/gBimEtuuTA0vLOdFFwGauT
	ORP0dOPHkMPJp/TILBS9BvzXb1UUb6elC4E0XpX6ZsW7zOr+uw==;
Received: from [77.20.141.166] (helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rp5oH-0000kc-Fh; Tue, 26 Mar 2024 13:21:45 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [RFC PATCH v1 1/2] docs: reporting-issue: rework the detailed guide
Date: Tue, 26 Mar 2024 13:21:28 +0100
Message-ID: <ac847c1c539d5f2c3d55ab363a5038ce6d303424.1711455295.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711455295.git.linux@leemhuis.info>
References: <cover.1711455295.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1711455711;c092b3a9;
X-HE-SMSGID: 1rp5oH-0000kc-Fh

Rework the detailed step-by-step guide for various reasons:

* Simplify the search with the help of lore.kernel.org/all/, which did
  not exist when the text was written.

* Make use of the recently added document
  Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst,
  which covers many steps this text partly covered way better.

* The 'quickly report a stable regression to the stable team' approach
  hardly worked out: most of the time the regression was not known yet.
  Try a different approach using the regressions list.

* Reports about stable/longterm regressions most of the time were
  greeted with a brief reply along the lines of 'Is mainline affected as
  well?'; this is needed to determine who is responsible, so we might as
  well make the reporter check that before sending the report (which
  verify-bugs-and-bisect-regressions.rst already tells them to do, too).

* A lot of fine tuning after seeing what people were struggling with.

FIXME: adjust the entries in the reference section to match these
changes.

Not-signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 391 ++++++++++--------
 1 file changed, 210 insertions(+), 181 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 2fd5a030235ad0..e6083946c146e8 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -48,187 +48,216 @@ Once the report is out, answer any questions that come up and help where you
 can. That includes keeping the ball rolling by occasionally retesting with newer
 releases and sending a status update afterwards.
 
-Step-by-step guide how to report issues to the kernel maintainers
-=================================================================
-
-The above TL;DR outlines roughly how to report issues to the Linux kernel
-developers. It might be all that's needed for people already familiar with
-reporting issues to Free/Libre & Open Source Software (FLOSS) projects. For
-everyone else there is this section. It is more detailed and uses a
-step-by-step approach. It still tries to be brief for readability and leaves
-out a lot of details; those are described below the step-by-step guide in a
-reference section, which explains each of the steps in more detail.
-
-Note: this section covers a few more aspects than the TL;DR and does things in
-a slightly different order. That's in your interest, to make sure you notice
-early if an issue that looks like a Linux kernel problem is actually caused by
-something else. These steps thus help to ensure the time you invest in this
-process won't feel wasted in the end:
-
- * Are you facing an issue with a Linux kernel a hardware or software vendor
-   provided? Then in almost all cases you are better off to stop reading this
-   document and reporting the issue to your vendor instead, unless you are
-   willing to install the latest Linux version yourself. Be aware the latter
-   will often be needed anyway to hunt down and fix issues.
-
- * Perform a rough search for existing reports with your favorite internet
-   search engine; additionally, check the archives of the `Linux Kernel Mailing
-   List (LKML) <https://lore.kernel.org/lkml/>`_. If you find matching reports,
-   join the discussion instead of sending a new one.
-
- * See if the issue you are dealing with qualifies as regression, security
-   issue, or a really severe problem: those are 'issues of high priority' that
-   need special handling in some steps that are about to follow.
-
- * Make sure it's not the kernel's surroundings that are causing the issue
-   you face.
-
- * Create a fresh backup and put system repair and restore tools at hand.
-
- * Ensure your system does not enhance its kernels by building additional
-   kernel modules on-the-fly, which solutions like DKMS might be doing locally
-   without your knowledge.
-
- * Check if your kernel was 'tainted' when the issue occurred, as the event
-   that made the kernel set this flag might be causing the issue you face.
-
- * Write down coarsely how to reproduce the issue. If you deal with multiple
-   issues at once, create separate notes for each of them and make sure they
-   work independently on a freshly booted system. That's needed, as each issue
-   needs to get reported to the kernel developers separately, unless they are
-   strongly entangled.
-
- * If you are facing a regression within a stable or longterm version line
-   (say something broke when updating from 5.10.4 to 5.10.5), scroll down to
-   'Dealing with regressions within a stable and longterm kernel line'.
-
- * Locate the driver or kernel subsystem that seems to be causing the issue.
-   Find out how and where its developers expect reports. Note: most of the
-   time this won't be bugzilla.kernel.org, as issues typically need to be sent
-   by mail to a maintainer and a public mailing list.
-
- * Search the archives of the bug tracker or mailing list in question
-   thoroughly for reports that might match your issue. If you find anything,
-   join the discussion instead of sending a new report.
-
-After these preparations you'll now enter the main part:
-
- * Unless you are already running the latest 'mainline' Linux kernel, better
-   go and install it for the reporting process. Testing and reporting with
-   the latest 'stable' Linux can be an acceptable alternative in some
-   situations; during the merge window that actually might be even the best
-   approach, but in that development phase it can be an even better idea to
-   suspend your efforts for a few days anyway. Whatever version you choose,
-   ideally use a 'vanilla' build. Ignoring these advices will dramatically
-   increase the risk your report will be rejected or ignored.
-
- * Ensure the kernel you just installed does not 'taint' itself when
-   running.
-
- * Reproduce the issue with the kernel you just installed. If it doesn't show
-   up there, scroll down to the instructions for issues only happening with
-   stable and longterm kernels.
-
- * Optimize your notes: try to find and write the most straightforward way to
-   reproduce your issue. Make sure the end result has all the important
-   details, and at the same time is easy to read and understand for others
-   that hear about it for the first time. And if you learned something in this
-   process, consider searching again for existing reports about the issue.
-
- * If your failure involves a 'panic', 'Oops', 'warning', or 'BUG', consider
-   decoding the kernel log to find the line of code that triggered the error.
-
- * If your problem is a regression, try to narrow down when the issue was
-   introduced as much as possible.
-
- * Start to compile the report by writing a detailed description about the
-   issue. Always mention a few things: the latest kernel version you installed
-   for reproducing, the Linux Distribution used, and your notes on how to
-   reproduce the issue. Ideally, make the kernel's build configuration
-   (.config) and the output from ``dmesg`` available somewhere on the net and
-   link to it. Include or upload all other information that might be relevant,
-   like the output/screenshot of an Oops or the output from ``lspci``. Once
-   you wrote this main part, insert a normal length paragraph on top of it
-   outlining the issue and the impact quickly. On top of this add one sentence
-   that briefly describes the problem and gets people to read on. Now give the
-   thing a descriptive title or subject that yet again is shorter. Then you're
-   ready to send or file the report like the MAINTAINERS file told you, unless
-   you are dealing with one of those 'issues of high priority': they need
-   special care which is explained in 'Special handling for high priority
-   issues' below.
-
- * Wait for reactions and keep the thing rolling until you can accept the
-   outcome in one way or the other. Thus react publicly and in a timely manner
-   to any inquiries. Test proposed fixes. Do proactive testing: retest with at
-   least every first release candidate (RC) of a new mainline version and
-   report your results. Send friendly reminders if things stall. And try to
-   help yourself, if you don't get any help or if it's unsatisfying.
-
-
-Reporting regressions within a stable and longterm kernel line
---------------------------------------------------------------
-
-This subsection is for you, if you followed above process and got sent here at
-the point about regression within a stable or longterm kernel version line. You
-face one of those if something breaks when updating from 5.10.4 to 5.10.5 (a
-switch from 5.9.15 to 5.10.5 does not qualify). The developers want to fix such
-regressions as quickly as possible, hence there is a streamlined process to
-report them:
-
- * Check if the kernel developers still maintain the Linux kernel version
-   line you care about: go to the  `front page of kernel.org
-   <https://kernel.org/>`_ and make sure it mentions
-   the latest release of the particular version line without an '[EOL]' tag.
-
- * Check the archives of the `Linux stable mailing list
-   <https://lore.kernel.org/stable/>`_ for existing reports.
-
- * Install the latest release from the particular version line as a vanilla
-   kernel. Ensure this kernel is not tainted and still shows the problem, as
-   the issue might have already been fixed there. If you first noticed the
-   problem with a vendor kernel, check a vanilla build of the last version
-   known to work performs fine as well.
-
- * Send a short problem report to the Linux stable mailing list
-   (stable@vger.kernel.org) and CC the Linux regressions mailing list
-   (regressions@lists.linux.dev); if you suspect the cause in a particular
-   subsystem, CC its maintainer and its mailing list. Roughly describe the
-   issue and ideally explain how to reproduce it. Mention the first version
-   that shows the problem and the last version that's working fine. Then
-   wait for further instructions.
-
-The reference section below explains each of these steps in more detail.
-
-
-Reporting issues only occurring in older kernel version lines
--------------------------------------------------------------
-
-This subsection is for you, if you tried the latest mainline kernel as outlined
-above, but failed to reproduce your issue there; at the same time you want to
-see the issue fixed in a still supported stable or longterm series or vendor
-kernels regularly rebased on those. If that the case, follow these steps:
-
- * Prepare yourself for the possibility that going through the next few steps
-   might not get the issue solved in older releases: the fix might be too big
-   or risky to get backported there.
-
- * Perform the first three steps in the section "Dealing with regressions
-   within a stable and longterm kernel line" above.
-
- * Search the Linux kernel version control system for the change that fixed
-   the issue in mainline, as its commit message might tell you if the fix is
-   scheduled for backporting already. If you don't find anything that way,
-   search the appropriate mailing lists for posts that discuss such an issue
-   or peer-review possible fixes; then check the discussions if the fix was
-   deemed unsuitable for backporting. If backporting was not considered at
-   all, join the newest discussion, asking if it's in the cards.
-
- * One of the former steps should lead to a solution. If that doesn't work
-   out, ask the maintainers for the subsystem that seems to be causing the
-   issue for advice; CC the mailing list for the particular subsystem as well
-   as the stable mailing list.
-
-The reference section below explains each of these steps in more detail.
+The detailed step-by-step guide on reporting Linux kernel issues
+================================================================
+
+The short guide above might be all needed for people already familiar
+with reporting issues to Free/Libre & Open Source Software projects. For
+everyone else there is this more detailed step-by-step guide. It still tries to
+be brief and leaves a lot of details occasionally relevant to a reference
+section, which holds additional information for almost all of the steps.
+
+Note: this step-by-step guide covers more aspects than the short guide above and
+does things in a slightly different order; that is done in the reader's interest,
+to make sure you notice early on when  on the wrong track.
+
+* Be aware you must have or install a fresh vanilla mainline kernel for
+  reporting; you furthermore must remove any software that builds or relies on
+  externally developed kernel modules possibly installed. There is also a decent
+  chance you will have to build a patched kernel yourself to help resolve the
+  issue.
+
+  In case that sounds do demanding to you, better report the issue to the vendor
+  who built your kernel (usually your Linux distributor or hardware manufacturer).
+
+* Skim the output of ``journalctl -k`` for any indicators of problems that might
+  lead to your bug.
+
+* Check if the kernel was already 'tainted' when the issue first occurred: the
+  event that led to this flag being set might cause your issue, even if it looks
+  totally unrelated.
+
+* Consider some glitch in your kernel's environment makes it misbehave -- like
+  a hardware defect, a mis-configured system firmware, an overclocked component,
+  a broken initramfs, an inconsistent file system, broken firmware files,
+  a pre-release compiler, or a malfunctioning/misconfigured Linux distribution.
+
+* If you deal with multiple issues at once, process them separately from now on.
+  If there is even a small chance they are related, briefly mention the other
+  issues in each of the reports later, ideally while linking to the others.
+
+* Search for fixes and earlier reports referring to an issue like yours. Start
+  by checking `lore <https://lore.kernel.org/all/>`_. Then perform a general
+  internet search. Consult :ref:`MAINTAINERS <maintainers>` to determine where
+  developers of the affected code expect bugs to be submitted to; if in a doubt,
+  use your best guess to determine the driver or kernel subsystem. If its
+  developers have a dedicated mailing list not archived on lore, search its
+  archives; when they are among the few that uses one of
+  various bug trackers, search it as well. Note, bugzilla.kernel.org
+  is the right place to file bugs only for a small percentage of the kernel; if
+  you submit bugs for other code there it most likely will be ignored.
+
+  If you find fixes, try them. If you find matching reports, evaluate whatever
+  is wiser: joining the discussion or reporting the problem anew. In the latter
+  case mention and link to the related report you found; after you submit it,
+  add a note to the related report along the lines of 'I have a problem that
+  might be the same or related, for details see <link_to_your_report>'.
+
+* Are you facing a regression? One still occurring with a less than two
+  (ideally: one) weeks old kernel from the affected series? A kernel that is
+  vanilla or close to it? Then send a brief (one or two short paragraphs) email
+  to <regressions@lists.linux.dev> asking if the problem is known already.
+  Consider proceeding with this guide immediately to confine the problem and
+  report it properly; definitely do so, if you don't receive any helpful
+  answer within three days.
+
+* Evaluate if the issue you are dealing with qualifies as regression, security
+  issue, or a really severe problem: those need special handling in some of the
+  following steps.
+
+* Write down coarsely how to reproduce the issue on a freshly booted system.
+
+* Verify the bug and potentially bisect any regression as described in
+  Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst;
+  alternatively handle the tasks it covers on your own:
+
+  * Verify the bug occurs with an up-to-date kernel. For regressions within a
+    still supported stable or longterm series this means the latest release from
+    that series. In all other cases, this means a mainline release, pre-release, or
+    snapshot ideally less than one week old and two at maximum; the latest release
+    from the newest stable series might work as well, especially if the series
+    is based on a mainline version released in the past two weeks.
+
+  * In case of a regression, consider bisecting it. If it is one within a stable
+    or longterm series, you must verify if current mainline is affected as well.
+
+  * All kernels used for verifying and reporting bugs must be free of externally
+    developed modules (like Nvidia's graphics drivers, OpenZFS, or VirtualBox's
+    host drivers). The kernels also should be built from pristine (aka 'vanilla')
+    Linux sources, but lightly patched might work, too. The kernels furthermore
+    should not be 'tainted' when the issue occurs.
+
+  Note, don't skip this step or take its demands lightheartedly, as there is a
+  decent chance your report otherwise will be ignored or welcomed brusquely.
+
+* If you learned anything new about the bug while following this guide so far,
+  consider searching once more for earlier reports and fixes.
+
+* Were you unable to reproduce a bug with a current mainline kernel you want to
+  see fixed in a stable or longterm series? A bug that is not a regression? Then
+  move over to ‘Resolving non-regressions only occurring in stable or longterm
+  kernels’.
+
+* Optional: if your failure involves a 'panic', 'Oops', 'warning', or 'BUG',
+  ideally decode the included stack trace.
+
+* Prepare the report by writing a detailed description of the issue.
+
+  Always mention the Linux distribution and the kernel version used for the
+  verification; also include your notes on how to reproduce the issue. If your
+  failure involves a 'panic', 'Oops', 'warning', or 'BUG', include a copy or
+  photo of it.
+
+  Most of the time you also want to describe relevant aspects of your
+  environment, like the machine's model name, the relevant hardware components,
+  or the version of related userspace drivers. Often you want to also save the
+  output of ``journalctl -k`` to a file you later attach to your report or
+  upload somewhere and link to.
+
+  If there other aspects about the environment likely are relevant, attach or
+  upload & link detailed information about is as well, like the output from
+  commands as ``lsblk``, ``lspci``, ``lsusb.py`` and
+  ``grep -s '' /sys/class/dmi/id/*``.
+
+  If anything in the attached or linked files is certainly relevant, ensure
+  to copy that part to the body of the report to make it easily accessible.
+  Furthermore make sure to not overload the report with many or huge
+  attachments: developers will ask for additional data when needed.
+
+  Ensure both the subject and the first sentence of the report outlines the core
+  of the problem and gets people interested enough to read on.
+
+  When finished, review and optimize the report once more to make it as
+  straightforward as possible and the core of the problem easy to grasp.
+
+* Submit your report in the appropriate way, which depends on the outcome of the
+  verification:
+
+  * In case you deal with a security issue, follow the instructions in
+    Documentation/process/security-bugs.rst.
+
+  * Are you facing a regression within a stable or longterm kernel series you
+    were unable to reproduce with a fresh mainline kernel? Then report it by
+    email to the stable team while CCing the regressions lists (To:
+    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
+    Sasha Levin <sashal@kernel.org>; CC: stable@vger.kernel.org,
+    regressions@lists.linux.dev).
+
+  * In all other cases, submit the report as specified in MAINTAINERS. In case
+    of a regression you have to report by mail, CC the regressions list
+    (regressions@lists.linux.dev); when you know the culprit, also CC everyone
+    in its 'Signed-off-by' chain. In case of a regression you had to file in a
+    bug tracker, write a short heads-up email with a link to the report to the
+    list and everyone that signed the patch off, if the culprit is known.
+
+    Did you send the brief inquiry about a regression mentioned earlier? Then in
+    both of these cases keep it involved: either send your report as a reply to
+    the earlier inquiry while adding relevant recipients or send a quick note
+    with a link to the proper report.
+
+* Wait for reactions and keep the ball rolling until you can accept the outcome
+  in one way or the other. That among others means:
+
+  * React publicly and in a timely manner to any inquiries.
+
+  * Try to quickly test proposed fixes.
+
+  * Perform proactive testing: retest with at least every first release
+    candidate (e.g. -rc1) of a new mainline version and report your findings in
+    a reply to your report.
+
+  * If things stall for more than three or four weeks, check if that happened
+    due to an inadequate report of yours; if not, send a friendly inquiry.
+
+  * Be aware that nobody is obliged to help you, unless it is a recent
+    regression, a security issue, or a really severe problem; hence try to help
+    yourself, if you don't receive any or only unsatisfying help.
+
+Resolving non-regressions only occurring in stable or longterm kernels
+----------------------------------------------------------------------
+
+Are you facing an issue in a still supported stable or longterm series you were
+unable to reproduce with a fresh mainline kernel? An issue that is also not a
+regression and still happens in the series latest release? In that case follow
+these steps:
+
+* Prepare yourself for the possibility that trying to resolve the issue resolved
+  in the affected stable or longterm series might not work out: the fix might be
+  too big or risky to include there.
+
+* Search Linux' mainline Git repository or lore for the change that resolved the
+  issue; when unsuccessful, consider using a bisection to find it. Then check
+  the description of the fix for a 'stable tag', e.g, a line like
+  'Cc: <stable@vger.kernel.org>':
+
+ * In case there is such a tag the change is already scheduled for backporting.
+   Usually it will be picked up within two or three weeks after being merged to
+   mainline. Note, a version number after the tag might limit backporting to a
+   series that is newer than the one you care for; plans to backport a change
+   sometimes are also discarded. In such cases search lore or contact the
+   involved developers for details, but you likely are out of luck.
+
+ * If there was no stable tag, search the mailing list archives if backporting
+   nevertheless is in the works. If not, search for the review of the fix and
+   check if backporting to stable and longterm kernels is planned or was
+   rejected. If it's neither, send a reply asking the developers if backporting
+   to the series is an option. Note, they might greenlight it, but unwilling to
+   handle the job themselves -- in that case consider testing and submitting the
+   fix and everything it depends on as explained in
+   Documentation/process/stable-kernel-rules.rst.
+
+ In case you have trouble locating the fix or the discussion about it, consider
+ asking the maintainers and developers of the affected subsystem for advice.
 
 
 Reference section: Reporting issues to the kernel maintainers
-- 
2.44.0


