Return-Path: <linux-kernel+bounces-48495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78A1845CE6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECA528B826
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8BD1649C6;
	Thu,  1 Feb 2024 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMZofDuy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4A51649D2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804070; cv=none; b=MU04MSdcxA+sbb+sBAGelvaWonZqKrUiZ+4P+nYyy8apziFznqsoKGHsQXIIIy6JSZxMLyZWFJOTGJySmj9BceCy3p1C14Da6jsdE5qJR8Zruc6NKxasd9Ql5/AjtXTDFtPfndYhPSLtsHH++mKuqMkom3TNzuR+9xic+9u6n3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804070; c=relaxed/simple;
	bh=rwKzLmSSRmEEpMX+QqvNlHLc4dRHi0DGf0sAxL6yZak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dUIi187UPNKU4cbDtSktETYZz+seAPM7RZdFf4Gjg8txR+bRjFCfl3z0RUNeYAu5TS/Xgchqmg6QIc88qBWG6KIaR2zWsZGKACCsitp5rIdibftmWI3xiTyScZz3pZ9jFM0tBJzhl9KKnJ4KQznEcZu8Ny969AvHbOJGyCkW1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMZofDuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2C6C433A6;
	Thu,  1 Feb 2024 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706804070;
	bh=rwKzLmSSRmEEpMX+QqvNlHLc4dRHi0DGf0sAxL6yZak=;
	h=Date:From:To:Cc:Subject:From;
	b=uMZofDuyNb+ZYKzKUN8jb6HO6tWvE6lTGO59Fv6ywYLyXnvw1HKoZO7MgPUl/cbEI
	 fDBcSxY1EzzP1qLF0eR0qjT0QqW1AnJZoRYt+fU692ieRuByXlPhxlBcfvLk1OxPE0
	 nIrFm9edtnSXtjWUVGI4iQI77ll5/MIG2g18otE932Vp8PtWPbhoBJ1UnJeat/I+S5
	 SUgw/3OKCvN+Rq28RdxHyt62Aj4lMHUaZUoBuFXaegowugp9cdtiiTgHbdUiZ0EGpK
	 697/sbaJ1xNdSMpC6ld00FZBG3FGyPKYmJINtrCJfAzArhgxSdkBqImFUQ7VNOp0K9
	 lEKUYK99aKC5g==
Date: Thu, 1 Feb 2024 17:14:26 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes for 6.8
Message-ID: <pcax5asgwo6x4mwrnxnwixfknqhovx7unjxe4txtpzab65dwcf@jm7552y2whzj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024020101

to receive fixes that should go into 6.8:

=====
- cleanups in the error path in hid-steam (Dan Carpenter)
- fixes for Wacom tablets selftests that sneaked in while the
  CI was taking a break during the year end holidays (Benjamin Tissoires)
- a null pointer check in nvidia-shield (Kunwu Chan)
- a memory leak fix in hidraw (Su Hui)
- another null pointer fix in i2c-hid-of (Johan Hovold)
- another memory leak fix in HID-BPF this time, as well as a double
  fdget() fix reported by Dan Carpenter (Benjamin Tissoires)
- a fix for Cirque touchpad when they go on suspend (Kai-Heng Feng)
- a new device ID in hid-logitech-hidpp: "Logitech G Pro X SuperLight 2"
  (Jiri Kosina)
=====

Thanks,

----------------------------------------------------------------
Benjamin Tissoires (4):
      selftests/hid: wacom: fix confidence tests
      HID: bpf: remove double fdget()
      HID: bpf: actually free hdev memory after attaching a HID-BPF program
      HID: bpf: use __bpf_kfunc instead of noinline

Dan Carpenter (2):
      HID: hid-steam: remove pointless error message
      HID: hid-steam: Fix cleanup in probe()

Jiri Kosina (1):
      HID: logitech-hidpp: add support for Logitech G Pro X Superlight 2

Johan Hovold (1):
      HID: i2c-hid-of: fix NULL-deref on failed power up

Kai-Heng Feng (1):
      HID: i2c-hid: Skip SET_POWER SLEEP for Cirque touchpad on system suspend

Kunwu Chan (1):
      HID: nvidia-shield: Add missing null pointer checks to LED initialization

Su Hui (1):
      HID: hidraw: fix a problem of memory leak in hidraw_release()

 drivers/hid/bpf/hid_bpf_dispatch.c                      | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
 drivers/hid/bpf/hid_bpf_dispatch.h                      |   4 ++--
 drivers/hid/bpf/hid_bpf_jmp_table.c                     |  40 ++++++++++++++++++++--------------------
 drivers/hid/hid-ids.h                                   |   3 +++
 drivers/hid/hid-logitech-hidpp.c                        |   2 ++
 drivers/hid/hid-nvidia-shield.c                         |   4 ++++
 drivers/hid/hid-steam.c                                 |  36 ++++++++++++++++++------------------
 drivers/hid/hidraw.c                                    |   7 +++++--
 drivers/hid/i2c-hid/i2c-hid-core.c                      |   6 +++++-
 drivers/hid/i2c-hid/i2c-hid-of.c                        |   1 +
 include/linux/hid_bpf.h                                 |  11 -----------
 tools/testing/selftests/hid/tests/test_wacom_generic.py |   8 ++++----
 12 files changed, 138 insertions(+), 85 deletions(-)

---
Cheers,
Benjamin

