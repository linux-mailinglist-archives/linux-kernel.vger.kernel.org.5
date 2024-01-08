Return-Path: <linux-kernel+bounces-19999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BCB827805
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72981F2311D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D5254F94;
	Mon,  8 Jan 2024 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="sIzASYUO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93DB54F82;
	Mon,  8 Jan 2024 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 17C59377;
	Mon,  8 Jan 2024 18:59:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 17C59377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704740365; bh=ozaEI1S4huawJuLFBf/xIlVv/aNEtvbhOwZ0AuBrcqM=;
	h=From:To:Cc:Subject:Date:From;
	b=sIzASYUOLGMxsDxRfJ0o9HxOVS81rqBZdKTjTGUdTpa5xnHPw1eGKxCbxi78RpFZl
	 Hnk/+1/3o+qPwOqamPYAMnZsf+aZETPsXXBRSogAjMFHS2T/3XG/WUC7kHjlYPMdnP
	 UYlgKdhA86enS5+DL72jQI74kdL4b0K70hDcycWLj5DZzXOFE7cD4KOwC63zvMjbBE
	 CUUD5gYVQFdev/oqOfREjykOdZ+LMGta6nGJzWBFvKulKeQe/GHL78Uo/2aMiGjlAn
	 PJB2otuGm/j+5knKdp4IjacxVUF0gj3jjcS5hsViv53Qp6CRVpnprYbxwIWI0EJ8qL
	 XG0N7xO1n7fTg==
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.8
Date: Mon, 08 Jan 2024 11:59:24 -0700
Message-ID: <87sf37vegj.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.8

for you to fetch changes up to 2d179e8ac02e33c82c1a314961254353eb5028b3:

  MAINTAINERS: use tabs for indent of CONFIDENTIAL COMPUTING THREAT MODEL (=
2024-01-08 11:39:00 -0700)

----------------------------------------------------------------
Another moderately busy cycle for documentation, including:

- The minimum Sphinx requirement has been raised to 2.4.4, following a
  warning that was added in 6.2.

- Some reworking of the Documentation/process front page to, hopefully,
  make it more useful.

- Various kernel-doc tweaks to, for example, make it deal properly with
  __counted_by annotations.

- We have also restored a warning for documentation of nonexistent
  structure members that disappeared a while back.  That had the delightful
  consequence of adding some 600 warnings to the docs build.  A sustained
  effort by Randy, Vegard, and myself has addressed almost all of those,
  bringing the documentation back into sync with the code.  The fixes are
  going through the appropriate maintainer trees.

- Various improvements to the HTML rendered docs, including automatic links
  to Git revisions and a nice new pulldown to make translations easy to
  access.

- Speaking of translations, more of those for Spanish and Chinese.

...plus the usual stream of documentation updates and typo fixes.

There is somewhat more than the usual number of merge conflicts, alas,
including with the security, RCU, crypto, and amdgpu trees.  Most of
these are in driver-api/index.rst and userspace-api/index.rst, which are
suffering from the "everybody adds new stuff to the end" problem;
imposing some order there is on my list of things to do.

----------------------------------------------------------------
Alejandro Colomar (1):
      CREDITS, MAINTAINERS, docs/process/howto: Update man-pages' maintainer

Andy Shevchenko (1):
      kernel-doc: Align quick help and the code

Ariel Miculas (1):
      docs: vfs: fix typo in struct xattr_handlers

Avadhut Naik (4):
      docs/sp_SP: Add translation of process/management-style
      docs/sp_SP: Add translation of process/submit-checklist
      docs/sp_SP: Warn of links pointing to documentation in English
      docs/sp_SP: Move howto.rst into /sp_SP/process/

Borislav Petkov (AMD) (1):
      docs: submitting-patches: improve the base commit explanation

Brian Johannesmeyer (1):
      docs: dma-api: Fix description of the sync_sg API

Carlos Bilbao (2):
      docs/sp_SP: Add translation of process/handling-regressions
      MAINTAINERS: add reviewer for Spanish translations

Donald Hunter (1):
      docs: Change <h4> style to use smaller font size than <h3>

Hu Haowen (1):
      docs/zh_TW: replace my email address

Jakub Kicinski (1):
      MAINTAINERS: use tabs for indent of CONFIDENTIAL COMPUTING THREAT MOD=
EL

JiaLong.Yang (1):
      Docs/zh_CN: Fix the meaning of DEBUG to pr_debug()

Jonathan Corbet (4):
      Merge branch 'vegard' into docs-mw
      docs: Raise the minimum Sphinx requirement to 2.4.4
      docs: ignore __counted_by attribute in structure definitions
      A reworked process/index.rst

Kees Cook (2):
      docs: conf.py: Ignore __counted_by attribute
      scripts: kernel-doc: Clarify missing struct member description

Li Zhijian (1):
      docs: dma: update a reference to a moved document

Luca Ceresoli (2):
      docs: nvmem: generate kernel-doc API documentation
      docs: nvmem: remove function parameters (fixes hyperlink generation)

Matthew Cassell (1):
      Documentation/trace: Fixed typos in the ftrace FLAGS section

Randy Dunlap (4):
      fs: vboxsf: fix a kernel-doc warning
      scripts/kernel-doc: restore warning for Excess struct/union
      scripts/get_abi.pl: ignore some temp files
      kernel-doc: handle a void function without producing a warning

Rex Nie (1):
      Documentation: Remove redundant file names from examples

Steven Rostedt (Google) (1):
      ring-buffer/Documentation: Add documentation on buffer_percent file

Sumit Garg (1):
      Documentation: Destage TEE subsystem documentation

Thomas Wei=C3=9Fschuh (1):
      Docs: remove mentions of fdformat from util-linux

Vegard Nossum (18):
      docs: style toctree captions as headings
      doc: userspace-api: properly format ToC headings
      media: admin-guide: properly format ToC heading
      crypto: doc: properly format ToC headings
      Documentation: dev-tools: properly format ToC headingss
      docs: driver-api: properly format ToC headings
      input: docs: properly format ToC headings
      doc: misc-device: properly format ToC heading
      media: doc: properly format ToC headings
      docs: use toctree :caption: and move introduction
      docs: remove .toc-title class
      docs: automarkup: linkify git revs
      Documentation: add tux logo
      docs: translations: add translations links when they exist
      scripts/get_abi: fix source path leak
      docs: kernel_abi.py: fix command injection
      Documentation: move driver-api/isapnp to userspace-api/
      Documentation: move driver-api/dcdbas to userspace-api/

Vlastimil Babka (1):
      Documentation, mm/unaccepted: document accept_memory kernel parameter

Yanteng Si (3):
      docs/zh_CN: add process maintainer-pgp-guide tanslation
      docs/zh_CN: Adjust the number of characters per line in magic-number.=
rst to less than 40
      docs/zh_CN: Update process index to 6.7-rc2

Yuanhsi Chung (1):
      Documentation: Fix filename typo in ftrace doc

attreyee-muk (1):
      Documentation/core-api : fix typo in workqueue

longjin (1):
      Translated the RISC-V architecture boot documentation.

 CREDITS                                            |   7 +
 Documentation/admin-guide/abi-obsolete.rst         |   2 +-
 Documentation/admin-guide/abi-removed.rst          |   2 +-
 Documentation/admin-guide/abi-stable.rst           |   2 +-
 Documentation/admin-guide/abi-testing.rst          |   2 +-
 Documentation/admin-guide/dynamic-debug-howto.rst  |   6 +-
 Documentation/admin-guide/kernel-parameters.txt    |  11 +
 Documentation/admin-guide/media/index.rst          |  10 +-
 Documentation/arch/x86/boot.rst                    |   2 +-
 Documentation/bpf/btf.rst                          |   6 +-
 Documentation/conf.py                              |   9 +-
 Documentation/core-api/dma-api-howto.rst           |   2 +-
 Documentation/core-api/dma-api.rst                 |   2 +-
 Documentation/core-api/workqueue.rst               |   2 +-
 Documentation/crypto/api.rst                       |   5 +-
 Documentation/crypto/index.rst                     |   5 +-
 Documentation/dev-tools/index.rst                  |   5 +-
 Documentation/doc-guide/sphinx.rst                 |  11 +-
 Documentation/driver-api/index.rst                 |   8 +-
 Documentation/driver-api/media/index.rst           |   7 +-
 Documentation/driver-api/mei/index.rst             |   7 +-
 Documentation/driver-api/nvmem.rst                 |   8 +-
 Documentation/driver-api/pci/index.rst             |   5 +-
 Documentation/driver-api/tee.rst                   |  66 ++
 Documentation/filesystems/vfs.rst                  |   2 +-
 Documentation/input/input_kapi.rst                 |   5 +-
 Documentation/input/input_uapi.rst                 |   5 +-
 Documentation/input/joydev/index.rst               |   5 +-
 Documentation/livepatch/callbacks.rst              |   4 +-
 Documentation/misc-devices/index.rst               |   5 +-
 Documentation/networking/snmp_counter.rst          |  16 +-
 Documentation/process/changes.rst                  |   6 +-
 Documentation/process/development-process.rst      |  19 +-
 Documentation/process/howto.rst                    |   3 +-
 Documentation/process/index.rst                    |  84 ++-
 Documentation/process/submitting-patches.rst       |  15 +-
 Documentation/security/keys/trusted-encrypted.rst  |   2 +-
 Documentation/sphinx-static/custom.css             |  63 ++
 Documentation/sphinx-static/theme_overrides.css    |   5 -
 Documentation/sphinx/automarkup.py                 |  26 +-
 Documentation/sphinx/cdomain.py                    |   6 +-
 Documentation/sphinx/kernel_abi.py                 |  56 +-
 Documentation/sphinx/kfigure.py                    |   8 +-
 Documentation/sphinx/templates/translations.html   |  15 +
 Documentation/sphinx/translations.py               | 101 +++
 Documentation/staging/index.rst                    |   1 -
 Documentation/staging/tee.rst                      | 364 ----------
 Documentation/subsystem-apis.rst                   |   1 +
 Documentation/tee/amd-tee.rst                      |  90 +++
 Documentation/tee/index.rst                        |  19 +
 Documentation/tee/op-tee.rst                       | 166 +++++
 Documentation/tee/tee.rst                          |  22 +
 Documentation/trace/ftrace-uses.rst                |   4 +-
 Documentation/trace/ftrace.rst                     |  17 +-
 .../it_IT/process/development-process.rst          |  19 +-
 Documentation/translations/sp_SP/disclaimer-sp.rst |   3 +
 Documentation/translations/sp_SP/index.rst         |   1 -
 .../sp_SP/process/handling-regressions.rst         | 797 +++++++++++++++++=
++++
 .../translations/sp_SP/{ =3D> process}/howto.rst     |   2 +-
 Documentation/translations/sp_SP/process/index.rst |   4 +
 .../sp_SP/process/management-style.rst             | 299 ++++++++
 .../sp_SP/process/submit-checklist.rst             | 133 ++++
 .../translations/zh_CN/arch/riscv/boot.rst         | 155 ++++
 .../translations/zh_CN/arch/riscv/index.rst        |   1 +
 .../translations/zh_CN/core-api/printk-basics.rst  |   2 +-
 .../translations/zh_CN/dev-tools/index.rst         |   5 +-
 .../zh_CN/dev-tools/testing-overview.rst           |   2 +-
 .../translations/zh_CN/driver-api/gpio/index.rst   |   3 +-
 .../translations/zh_CN/driver-api/index.rst        |   5 +-
 .../zh_CN/process/development-process.rst          |   5 +-
 Documentation/translations/zh_CN/process/index.rst |  53 +-
 .../translations/zh_CN/process/magic-number.rst    |  69 +-
 .../zh_CN/process/maintainer-pgp-guide.rst         | 789 +++++++++++++++++=
+++
 .../translations/zh_CN/userspace-api/index.rst     |   5 +-
 Documentation/translations/zh_TW/IRQ.txt           |   8 +-
 .../translations/zh_TW/admin-guide/README.rst      |   2 +-
 .../translations/zh_TW/admin-guide/bug-bisect.rst  |   2 +-
 .../translations/zh_TW/admin-guide/bug-hunting.rst |   2 +-
 .../zh_TW/admin-guide/clearing-warn-once.rst       |   2 +-
 .../translations/zh_TW/admin-guide/cpu-load.rst    |   2 +-
 .../translations/zh_TW/admin-guide/index.rst       |   2 +-
 .../translations/zh_TW/admin-guide/init.rst        |   2 +-
 .../zh_TW/admin-guide/reporting-issues.rst         |   2 +-
 .../zh_TW/admin-guide/security-bugs.rst            |   2 +-
 .../zh_TW/admin-guide/tainted-kernels.rst          |   2 +-
 .../translations/zh_TW/admin-guide/unicode.rst     |   2 +-
 .../translations/zh_TW/arch/arm64/amu.rst          |   2 +-
 .../translations/zh_TW/arch/arm64/booting.txt      |   4 +-
 .../translations/zh_TW/arch/arm64/elf_hwcaps.rst   |   2 +-
 .../translations/zh_TW/arch/arm64/hugetlbpage.rst  |   2 +-
 .../translations/zh_TW/arch/arm64/index.rst        |   2 +-
 .../zh_TW/arch/arm64/legacy_instructions.txt       |   4 +-
 .../translations/zh_TW/arch/arm64/memory.txt       |   4 +-
 .../translations/zh_TW/arch/arm64/perf.rst         |   2 +-
 .../zh_TW/arch/arm64/silicon-errata.txt            |   4 +-
 .../zh_TW/arch/arm64/tagged-pointers.txt           |   4 +-
 .../translations/zh_TW/dev-tools/sparse.rst        |  10 +-
 .../zh_TW/dev-tools/testing-overview.rst           |   2 +-
 .../translations/zh_TW/disclaimer-zh_TW.rst        |   2 +-
 .../translations/zh_TW/filesystems/debugfs.rst     |   2 +-
 .../translations/zh_TW/filesystems/index.rst       |   2 +-
 .../translations/zh_TW/filesystems/sysfs.txt       |   2 +-
 .../translations/zh_TW/filesystems/virtiofs.rst    |   2 +-
 Documentation/translations/zh_TW/gpio.txt          |   8 +-
 Documentation/translations/zh_TW/index.rst         |   2 +-
 Documentation/translations/zh_TW/io_ordering.txt   |   8 +-
 .../translations/zh_TW/process/1.Intro.rst         |   2 +-
 .../translations/zh_TW/process/2.Process.rst       |   2 +-
 .../translations/zh_TW/process/3.Early-stage.rst   |   2 +-
 .../translations/zh_TW/process/4.Coding.rst        |   2 +-
 .../translations/zh_TW/process/5.Posting.rst       |   2 +-
 .../translations/zh_TW/process/6.Followthrough.rst |   2 +-
 .../zh_TW/process/7.AdvancedTopics.rst             |   2 +-
 .../translations/zh_TW/process/8.Conclusion.rst    |   2 +-
 .../process/code-of-conduct-interpretation.rst     |   2 +-
 .../translations/zh_TW/process/code-of-conduct.rst |   2 +-
 .../translations/zh_TW/process/coding-style.rst    |   2 +-
 .../zh_TW/process/development-process.rst          |   6 +-
 .../translations/zh_TW/process/email-clients.rst   |   2 +-
 .../zh_TW/process/embargoed-hardware-issues.rst    |   2 +-
 Documentation/translations/zh_TW/process/howto.rst |   2 +-
 Documentation/translations/zh_TW/process/index.rst |   2 +-
 .../zh_TW/process/kernel-driver-statement.rst      |   2 +-
 .../zh_TW/process/kernel-enforcement-statement.rst |   2 +-
 .../translations/zh_TW/process/license-rules.rst   |   2 +-
 .../translations/zh_TW/process/magic-number.rst    |   2 +-
 .../zh_TW/process/management-style.rst             |   2 +-
 .../zh_TW/process/programming-language.rst         |   2 +-
 .../zh_TW/process/stable-api-nonsense.rst          |   2 +-
 .../zh_TW/process/stable-kernel-rules.rst          |   2 +-
 .../zh_TW/process/submit-checklist.rst             |   2 +-
 .../zh_TW/process/submitting-patches.rst           |   2 +-
 .../zh_TW/process/volatile-considered-harmful.rst  |   2 +-
 .../{driver-api =3D> userspace-api}/dcdbas.rst       |   0
 Documentation/userspace-api/index.rst              |   8 +-
 .../{driver-api =3D> userspace-api}/isapnp.rst       |   8 +-
 Documentation/userspace-api/media/cec/cec-api.rst  |   7 +-
 .../userspace-api/media/drivers/index.rst          |   7 +-
 Documentation/userspace-api/media/dvb/dvbapi.rst   |   7 +-
 Documentation/userspace-api/media/index.rst        |   7 +-
 .../media/mediactl/media-controller.rst            |   7 +-
 .../userspace-api/media/rc/remote_controllers.rst  |   7 +-
 Documentation/userspace-api/media/v4l/v4l2.rst     |   7 +-
 Documentation/userspace-api/tee.rst                |  39 +
 MAINTAINERS                                        |  21 +-
 drivers/platform/x86/dell/Kconfig                  |   2 +-
 drivers/platform/x86/dell/dcdbas.c                 |   2 +-
 drivers/pnp/isapnp/Kconfig                         |   2 +-
 drivers/tee/optee/Kconfig                          |   2 +-
 fs/vboxsf/vboxsf_wrappers.c                        |   2 +-
 scripts/get_abi.pl                                 |   3 +-
 scripts/kernel-doc                                 |  15 +-
 scripts/sphinx-pre-install                         |  10 +-
 153 files changed, 3206 insertions(+), 794 deletions(-)
 create mode 100644 Documentation/driver-api/tee.rst
 create mode 100644 Documentation/sphinx/templates/translations.html
 create mode 100644 Documentation/sphinx/translations.py
 delete mode 100644 Documentation/staging/tee.rst
 create mode 100644 Documentation/tee/amd-tee.rst
 create mode 100644 Documentation/tee/index.rst
 create mode 100644 Documentation/tee/op-tee.rst
 create mode 100644 Documentation/tee/tee.rst
 create mode 100644 Documentation/translations/sp_SP/process/handling-regre=
ssions.rst
 rename Documentation/translations/sp_SP/{ =3D> process}/howto.rst (99%)
 create mode 100644 Documentation/translations/sp_SP/process/management-sty=
le.rst
 create mode 100644 Documentation/translations/sp_SP/process/submit-checkli=
st.rst
 create mode 100644 Documentation/translations/zh_CN/arch/riscv/boot.rst
 create mode 100644 Documentation/translations/zh_CN/process/maintainer-pgp=
-guide.rst
 rename Documentation/{driver-api =3D> userspace-api}/dcdbas.rst (100%)
 rename Documentation/{driver-api =3D> userspace-api}/isapnp.rst (51%)
 create mode 100644 Documentation/userspace-api/tee.rst

