Return-Path: <linux-kernel+bounces-99165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D2787845C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557AA283317
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E56547F7C;
	Mon, 11 Mar 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ayo64gUb"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5574503F;
	Mon, 11 Mar 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172793; cv=none; b=OdEW/Ps8GCTfIt4X2bmcZ4Yus8xU0jsvthwTFvkfZC5m+vABBs6mvRg9BE7sITRsVV5GRLjqlNbcy5/yluyS3Oz6lYBdlrZxJ2LxHAIUEpZ2z8NPdGVpVBaF1KOoM/j2GXuc4tGFjGdQkLmVhwgO7SU3WIZgSXouV2NS+FQEsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172793; c=relaxed/simple;
	bh=ZMxApj46SsIn/A/FYyzsDQTT5R6LSY4H8Sz+r/0c5ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FQn2dG7XtBPsZ4EDbyBWoks10bak0JHBDlr+atiI5qF7ilEvvEL4GZutodoeRdXWzOZ92Vn0TMiz75+nlaTuXoX73lxlEKQF07oXarG9Oqa7PbkjQOUCcmZ+vhCQDRXYEvk7yYpTJBbKGQJXTMehKqqFmi0elqztLbb24qyK8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ayo64gUb; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 61177418B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1710172782; bh=ovGPDVXdpSFMq6eQyToO9ymTw7UrWGF9MGWubRqygzo=;
	h=From:To:Cc:Subject:Date:From;
	b=ayo64gUb2k+HtMvK3s5oBhb9cG/pfpmSE/pyQ8FA0ZezK0/ZraDaqL8ljUUyik+Hw
	 GG5WFOFDMOZKkvBnCisJx8RGu2zWAv40X9VzQVat9AgRcWB4VsvPSaU7xziLMEQgwJ
	 pZwC7JCUmySZzfLKCURU25DGPYDdsAeHM/CwhPuJiOHzFmbxqRWfKVpWHE2yq6vb7E
	 NyCmllRjHQB9TdGC4EtvcDbrrWFGaSGgAECusm7Tw8OuhhfmZKX3JRJFRRrb6C6Ulh
	 AO/ADy5UwP41ymVHeBNWqRnyVq4RfB2Qndzx/DM7N4Aq/OryrN2q0YjXtYuwqh9JxJ
	 L8MVJ2QyCgmew==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 61177418B9;
	Mon, 11 Mar 2024 15:59:41 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.9
Date: Mon, 11 Mar 2024 09:59:37 -0600
Message-ID: <87cys0hi8m.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit b7b2ffc3ca59b06397550f96febe95f3f153eb1e:

  docs: translations: use attribute to store current language (2024-02-21 13:41:37 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.9

for you to fetch changes up to 0c8e9b538ed7ecf4159b080ab0dafca3941c69db:

  docs: verify/bisect: fixes, finetuning, and support for Arch (2024-03-07 04:19:43 -0700)

----------------------------------------------------------------
A moderately busy cycle for development this time around.

- Some cleanup of the main index page for easier navigation

- Rework some of the other top-level pages for better readability and, with
  luck, fewer merge conflicts in the future.

- Submit-checklist improvements, hopefully the first of many.

- New Italian translations

- A fair number of kernel-doc fixes and improvements.  We have also dropped
  the recommendation to use an old version of Sphinx.

- A new document from Thorsten on bisection

..and lots of fixes and updates.

Expect minor merge conflicts with the vfio, edac, and gpio-brgl trees,
all of which are long since (and correctly) resolved in linux-next.

----------------------------------------------------------------
Abhishek Pandit-Subedi (1):
      coding-style: Add guidance to prefer dev_dbg

Akira Yokosawa (4):
      docs: Restore "smart quotes" for quotes
      docs: kerneldoc-preamble.sty: Remove code for Sphinx <2.4
      docs: Move ja_JP/howto.rst to ja_JP/process/howto.rst
      docs: Makefile: Add dependency to $(YNL_INDEX) for targets other than htmldocs

Andrew Ballance (1):
      docs: sphinx-pre-install fix-noto-sans-cjk on fedora

Anna-Maria Behnsen (2):
      drm/vram-helper: Fix 'multi-line' kernel-doc comments
      scripts/kernel-doc: Do not process backslash lines in comments

Carlos Bilbao (2):
      docs: Correct formatting of title in admin-guide/index.rst
      docs: Include simplified link titles in main index

Christoph Anton Mitterer (1):
      docs: proc.rst: comm: mention the included NUL

Davide Benini (1):
      doc:it_IT: add translation for I2C summary and protocol

Federico Vaga (2):
      doc:it_IT: first translation for locking/
      doc:it_IT: remove unreferenced and not translated page

Guilherme G. Piccoli (1):
      docs: Document possible_cpus parameter

Hunter Chasens (1):
      docs: admin-guide: Update bootloader and installation instructions

Jeffrey Hugo (1):
      Documentation: embargoed-hardware-issues.rst: Fix Trilok's email

Johannes Berg (1):
      kernel-doc: handle #if in enums as well

Jonathan Corbet (3):
      docs: rework the driver-api top-level page
      docs: rework the userspace-api top page
      Merge branch 'docs-fixes' into docs-mw

Juntong Deng (1):
      kasan: Add documentation for CONFIG_KASAN_EXTRA_INFO

Konstantin Ryabitsev (1):
      Documentation: update mailing list addresses

Krzysztof Kozlowski (1):
      docs: maintainer: add existing SoC and netdev profiles

Leo Yan (1):
      Documentation: userspace-api: Document perf ring buffer mechanism

Lu Dai (1):
      docs/zh_CN: accurate translation of "function"

Lukas Bulwahn (4):
      doc:it_IT: fix a typo in the config name in RCU torture
      docs: drop the version constraints for sphinx and dependencies
      docs: submit-checklist: structure by category
      docs: submit-checklist: use subheadings

Michael Kelley (1):
      docs: Fix subsystem APIs page so ungrouped entries have their own header

Ran.Park (1):
      Fixed case issue with 'fault-injection' in documentation

Randy Dunlap (2):
      kernel-doc: drop looking for "MACDOC"
      doc-guide: kernel-doc: tell about object-like macros

Sakari Ailus (1):
      kernel-doc: Support arrays of pointers struct fields

SeongJae Park (1):
      MAINTAINERS: Set the field name for subsystem profile section

Thorsten Blum (8):
      Documentation: coding-style: Fix indentation in code-blocks
      Documentation: coding-style: Update syntax highlighting for code-blocks
      Documentation: multiple .rst files: Fix grammar and more consistent formatting
      Documentation: admin-guide: tainted-kernels.rst: Add missing article and comma
      README: Fix spelling/capitalization
      docs: dev-tools: checkpatch.rst: Fix grammar
      docs: scripts: sphinx-pre-install: Fix building docs with pyyaml package
      docs: Makefile: Fix make cleandocs by deleting generated .rst files

Thorsten Leemhuis (2):
      docs: new text on bisecting which also covers bug validation
      docs: verify/bisect: fixes, finetuning, and support for Arch

Vegard Nossum (8):
      docs: add blurb about target audience to maintainer-profile
      scripts/kernel-doc: reindent
      scripts/kernel-doc: add modeline for vim users
      scripts/kernel-doc: simplify function printing
      scripts/kernel-doc: separate out function signature
      scripts/kernel-doc: simplify signature printing
      doc: kerneldoc.py: fix indentation
      docs: kernel_feat.py: fix build error for missing files

Vincenzo Mezzela (1):
      docs: staging: fix typo in docs

 Documentation/ABI/testing/sysfs-bus-vdpa           |   10 +-
 Documentation/Makefile                             |    5 +-
 Documentation/RCU/torture.rst                      |    2 +-
 Documentation/admin-guide/README.rst               |   69 +-
 Documentation/admin-guide/index.rst                |    2 +
 Documentation/admin-guide/kernel-parameters.txt    |    5 +
 Documentation/admin-guide/tainted-kernels.rst      |    4 +-
 .../verify-bugs-and-bisect-regressions.rst         | 1952 +++++++++++++++
 Documentation/conf.py                              |    6 +-
 Documentation/dev-tools/checkpatch.rst             |    4 +-
 Documentation/dev-tools/kasan.rst                  |   21 +
 Documentation/doc-guide/kernel-doc.rst             |   45 +
 Documentation/doc-guide/maintainer-profile.rst     |    7 +
 Documentation/doc-guide/sphinx.rst                 |   18 +-
 Documentation/driver-api/index.rst                 |  169 +-
 Documentation/fault-injection/index.rst            |    2 +-
 Documentation/filesystems/proc.rst                 |    4 +-
 Documentation/index.rst                            |   52 +-
 .../maintainer/maintainer-entry-profile.rst        |    3 +
 Documentation/networking/bridge.rst                |    2 +-
 Documentation/process/changes.rst                  |    4 +-
 Documentation/process/coding-style.rst             |   13 +-
 .../process/embargoed-hardware-issues.rst          |    2 +-
 Documentation/process/howto.rst                    |    4 +-
 Documentation/process/researcher-guidelines.rst    |    2 +-
 Documentation/process/submit-checklist.rst         |  161 +-
 Documentation/sphinx/kerneldoc-preamble.sty        |    7 +-
 Documentation/sphinx/kerneldoc.py                  |    6 +-
 Documentation/sphinx/requirements.txt              |    7 +-
 Documentation/staging/rpmsg.rst                    |    2 +-
 Documentation/subsystem-apis.rst                   |    2 +
 Documentation/translations/it_IT/RCU/index.rst     |   19 +
 Documentation/translations/it_IT/RCU/torture.rst   |  369 +++
 .../translations/it_IT/core-api/index.rst          |   12 +
 .../translations/it_IT/i2c/i2c-protocol.rst        |   99 +
 Documentation/translations/it_IT/i2c/index.rst     |   46 +
 Documentation/translations/it_IT/i2c/summary.rst   |   64 +
 Documentation/translations/it_IT/index.rst         |    2 +
 Documentation/translations/it_IT/locking/index.rst |   20 +
 .../translations/it_IT/locking/lockdep-design.rst  |  678 ++++++
 .../translations/it_IT/locking/lockstat.rst        |  230 ++
 .../translations/it_IT/locking/locktorture.rst     |  181 ++
 .../translations/it_IT/locking/locktypes.rst       |  547 +++++
 .../translations/it_IT/networking/netdev-FAQ.rst   |   13 -
 .../translations/it_IT/process/coding-style.rst    |    6 +-
 .../translations/it_IT/subsystem-apis.rst          |   47 +
 Documentation/translations/ja_JP/index.rst         |    2 +-
 .../translations/ja_JP/{ => process}/howto.rst     |    0
 .../translations/sp_SP/process/coding-style.rst    |    6 +-
 .../sp_SP/process/embargoed-hardware-issues.rst    |    2 +-
 .../sp_SP/process/researcher-guidelines.rst        |    2 +-
 .../translations/zh_CN/process/coding-style.rst    |    4 +-
 .../zh_CN/process/embargoed-hardware-issues.rst    |    2 +-
 .../zh_CN/userspace-api/accelerators/ocxl.rst      |    4 +-
 .../translations/zh_TW/process/coding-style.rst    |    4 +-
 .../zh_TW/process/embargoed-hardware-issues.rst    |    2 +-
 Documentation/userspace-api/index.rst              |   47 +-
 Documentation/userspace-api/perf_ring_buffer.rst   |  830 +++++++
 MAINTAINERS                                        |    9 +-
 README                                             |    2 +-
 drivers/gpu/drm/drm_gem_vram_helper.c              |   44 +-
 include/drm/drm_gem_vram_helper.h                  |   16 +-
 scripts/kernel-doc                                 | 2531 ++++++++++----------
 scripts/sphinx-pre-install                         |   32 +-
 64 files changed, 6857 insertions(+), 1607 deletions(-)
 create mode 100644 Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
 create mode 100644 Documentation/translations/it_IT/RCU/index.rst
 create mode 100644 Documentation/translations/it_IT/RCU/torture.rst
 create mode 100644 Documentation/translations/it_IT/i2c/i2c-protocol.rst
 create mode 100644 Documentation/translations/it_IT/i2c/index.rst
 create mode 100644 Documentation/translations/it_IT/i2c/summary.rst
 create mode 100644 Documentation/translations/it_IT/locking/index.rst
 create mode 100644 Documentation/translations/it_IT/locking/lockdep-design.rst
 create mode 100644 Documentation/translations/it_IT/locking/lockstat.rst
 create mode 100644 Documentation/translations/it_IT/locking/locktorture.rst
 create mode 100644 Documentation/translations/it_IT/locking/locktypes.rst
 delete mode 100644 Documentation/translations/it_IT/networking/netdev-FAQ.rst
 create mode 100644 Documentation/translations/it_IT/subsystem-apis.rst
 rename Documentation/translations/ja_JP/{ => process}/howto.rst (100%)
 create mode 100644 Documentation/userspace-api/perf_ring_buffer.rst

