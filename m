Return-Path: <linux-kernel+bounces-51301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADBD848906
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25461F233DD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737AE134D1;
	Sat,  3 Feb 2024 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KEserLf4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF35E12E48;
	Sat,  3 Feb 2024 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706996961; cv=none; b=OcgP75FjI2wfCD1A8mcksfS7rb8xGHosrKJIAKpBiJCF3OD636QhD7LcVgkbRXMGld7xgaugtT4ONi5bK1nnpoth5hQ2JuUisjhu0d0hK5ZKF38v4iSum59GrIS35m9kXoM7g+hGQzQkLpLHIxmC41AQVJH7GbQ9UeVa00lmLEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706996961; c=relaxed/simple;
	bh=+FBMOQB3faUW4Rvc94zSO2OIMH3ZaGb/MEhF9zaVYXY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KBo5cH+apK5Tb7yW5aor5Hk7lMVEsx6Q9RhrrK3R0RhIM32zhYqPQb2znuKkk1oVKCDdk1txMX0S1xFLz3HT/y0WXAtE3TzmjTMjKx0V27ZJXnZ795CZUZzywLEls1YdSXrEnGAjAxIQxBxgm8pxgfoq/1n/E+sVqDH7oIyl3K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KEserLf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E35FC433F1;
	Sat,  3 Feb 2024 21:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706996961;
	bh=+FBMOQB3faUW4Rvc94zSO2OIMH3ZaGb/MEhF9zaVYXY=;
	h=Date:From:To:Cc:Subject:From;
	b=KEserLf4PdPMyHfeSAsvmnZVsVrbRoWYJC4BIUfRCKVKAmZkLWz4KQCBFsdiCUAjH
	 m7BQWPIlSsG8MpVxjChOrK9GAaVqhc/XS4421U819WiP6v8BWIUEo7m7rZD0LVfS9H
	 i6+EXcAs5XGgeYAeGfXbQSaIGgN15qK0UvGfr9jk=
Date: Sat, 3 Feb 2024 13:49:20 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.8-rc3
Message-ID: <Zb604Bt0_l-KUvkg@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc3

for you to fetch changes up to ad834c7c8e4a74dd6cd4397848aa255e473d4a63:

  Merge tag 'usb-serial-6.8-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2024-02-02 08:36:38 -0800)

----------------------------------------------------------------
USB driver fixes for 6.8-rc3

Here are a bunch of small USB driver fixes for 6.8-rc3.  Included in
here are:
  - new usb-serial driver ids
  - new dwc3 driver id added
  - typec driver change revert
  - ncm gadget driver endian bugfix
  - xhci bugfixes for a number of reported issues
  - usb hub bugfix for alternate settings
  - ulpi driver debugfs memory leak fix
  - chipidea driver bugfix
  - usb gadget driver fixes

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Badhri Jagan Sridharan (1):
      Revert "usb: typec: tcpm: fix cc role at port reset"

Christian A. Ehrhardt (3):
      usb: ucsi: Add missing ppm_lock
      usb: ucsi_acpi: Fix command completion handling
      usb: ucsi_acpi: Quirk to ack a connector change ack cmd

Dmitry Baryshkov (1):
      usb: typec: tcpm: fix the PD disabled case

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-6.8-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Arrow Lake-H

JackBB Wu (1):
      USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e

Krishna Kurapati (1):
      usb: gadget: ncm: Fix endianness of wMaxSegmentSize variable in ecm_desc

Leonard Dallmayr (1):
      USB: serial: cp210x: add ID for IMST iM871A-USB

Mathias Nyman (3):
      xhci: fix possible null pointer dereference at secondary interrupter removal
      xhci: fix off by one check when adding a secondary interrupter.
      xhci: process isoc TD properly when there was a transaction error mid TD.

Michal Pecio (1):
      xhci: handle isoc Babble and Buffer Overrun events properly

Oliver Neukum (1):
      USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT

Prashanth K (2):
      usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
      usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK

Puliang Lu (1):
      USB: serial: option: add Fibocom FM101-GL variant

Randy Dunlap (1):
      usb: gadget: pch_udc: fix an Excess kernel-doc warning

Sean Anderson (1):
      usb: ulpi: Fix debugfs directory leak

Udipto Goswami (2):
      usb: gadget: ncm: Fix indentations in documentation of NCM section
      usb: core: Prevent null pointer dereference in update_port_device_state

Uttkarsh Aggarwal (1):
      usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend

Xu Yang (1):
      usb: chipidea: core: handle power lost in workqueue

yuan linyu (1):
      usb: f_mass_storage: forbid async queue when shutdown happen

 Documentation/usb/gadget-testing.rst         | 22 +++----
 drivers/usb/chipidea/ci.h                    |  2 +
 drivers/usb/chipidea/core.c                  | 44 +++++++-------
 drivers/usb/common/ulpi.c                    |  2 +-
 drivers/usb/core/hub.c                       | 46 ++++++++++-----
 drivers/usb/dwc3/dwc3-pci.c                  |  4 ++
 drivers/usb/dwc3/gadget.c                    |  6 +-
 drivers/usb/dwc3/host.c                      |  4 +-
 drivers/usb/gadget/function/f_mass_storage.c | 20 ++++++-
 drivers/usb/gadget/function/f_ncm.c          |  8 +--
 drivers/usb/gadget/udc/pch_udc.c             |  1 -
 drivers/usb/host/xhci-mem.c                  | 14 ++---
 drivers/usb/host/xhci-plat.c                 |  3 +
 drivers/usb/host/xhci-ring.c                 | 80 ++++++++++++++++++++-----
 drivers/usb/host/xhci.h                      |  1 +
 drivers/usb/serial/cp210x.c                  |  1 +
 drivers/usb/serial/option.c                  |  1 +
 drivers/usb/serial/qcserial.c                |  2 +
 drivers/usb/typec/tcpm/tcpm.c                |  6 +-
 drivers/usb/typec/ucsi/ucsi.c                |  2 +
 drivers/usb/typec/ucsi/ucsi_acpi.c           | 88 +++++++++++++++++++++++++---
 21 files changed, 267 insertions(+), 90 deletions(-)

