Return-Path: <linux-kernel+bounces-152480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8788ABF14
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0BF1C20886
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 11:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CE2125BA;
	Sun, 21 Apr 2024 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tsqqbXWb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB27205E18;
	Sun, 21 Apr 2024 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713699378; cv=none; b=KE7Glf8KzmC05wnhd7KvhgZfpOOMjyIVImHwMX/Iq+X5dIgSkx68CKTA+zkfWuRJ3UW/hqzoJdYV6RuszO5RSLSjgW6pj+5RL5FhfIp4K1cwljop2KJCbgNFl0mFDPMoyUX5xLtV/KnxVw2NzLvFG7MOzEuxPxGCQ2G1Qo0VepM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713699378; c=relaxed/simple;
	bh=gzbUQsZaoeyIpw/FMjHcyR+/W/UJIM3nsyCRxswYcJk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Uz3DgM8fZEqTe5IxVhhjGNv+fXaBx1Eei5gmBySIBppDH2ufaxkRX5Arl3mspPIIn4bI8SBj544cmLU9BMyCdUuelGNdQsY9ELJkIgq45554ckwogLOephTd731VUMNdIBeX8CgfCch1bWfQCp5r+2o4BEuHf9iVYmOaiuJ8K04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tsqqbXWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F85C113CE;
	Sun, 21 Apr 2024 11:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713699378;
	bh=gzbUQsZaoeyIpw/FMjHcyR+/W/UJIM3nsyCRxswYcJk=;
	h=Date:From:To:Cc:Subject:From;
	b=tsqqbXWbtMw2Vz91lVZmyM2JQbCU2ZCfFE5fWp1RuDzgWOqcRz1hrtckikwfv5sdw
	 K91FF/NMxsRaLWk+/IBH+hkBy5cOAxxhIfbEr9vRY4fs6mS8slxsUTNFXlAOVmiUbq
	 gfcMbZ1vmHmqZ/LZBQrWgoDMwDayB7Ehoc0+z/A0=
Date: Sun, 21 Apr 2024 13:36:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver fixes for 6.9-rc5
Message-ID: <ZiT6LyZvHAwg7Vye@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.9-rc5

for you to fetch changes up to 7a9a304069810c0c5296b851f228f8966d3a030e:

  Merge tag 'usb-serial-6.9-rc5' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2024-04-19 16:07:18 +0200)

----------------------------------------------------------------
USB / Thunderbolt driver fixes for 6.9-rc5

Here are some small USB and Thunderbolt driver fixes for 6.9-rc5.
Included in here are:
  - MAINTAINER file update for invalid email address
  - usb-serial device id updates
  - typec driver fixes
  - thunderbolt / usb4 driver fixes
  - usb core shutdown fixes
  - cdc-wdm driver revert for reported problem in -rc1
  - usb gadget driver fixes
  - xhci driver fixes

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      usb: typec: mux: it5205: Fix ChipID value typo

Christian A. Ehrhardt (1):
      usb: typec: ucsi: Fix connector check on init

Chuanhong Guo (1):
      USB: serial: option: add support for Fibocom FM650/FG650

Coia Prant (1):
      USB: serial: option: add Lonsung U8300/U9300 product

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 rmnet compositions

Fabio Estevam (1):
      usb: misc: onboard_usb_hub: Disable the USB hub clock on failure

Gil Fine (2):
      thunderbolt: Fix wake configurations after device unplug
      thunderbolt: Avoid notify PM core about runtime PM resume

Greg Kroah-Hartman (3):
      Merge tag 'thunderbolt-for-v6.9-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus
      Revert "usb: cdc-wdm: close race between read and workqueue"
      Merge tag 'usb-serial-6.9-rc5' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K sub-models

Kai-Heng Feng (1):
      usb: Disable USB3 LPM at shutdown

Krzysztof Kozlowski (1):
      usb: phy: MAINTAINERS: mark Freescale USB PHY as orphaned

Kyle Tso (1):
      usb: typec: tcpm: Correct the PDO counting in pd_set

Mathias Nyman (1):
      xhci: Fix root hub port null pointer dereference in xhci tracepoints

Mika Westerberg (1):
      thunderbolt: Do not create DisplayPort tunnels on adapters of the same router

Minas Harutyunyan (1):
      usb: dwc2: host: Fix dereference issue in DDMA completion flow.

Norihiko Hama (1):
      usb: gadget: f_ncm: Fix UAF ncm object at re-bind after usb ep transport error

Oliver Neukum (1):
      usb: xhci: correct return value in case of STS_HCE

Paul Cercueil (2):
      usb: gadget: functionfs: Fix inverted DMA fence direction
      usb: gadget: functionfs: Wait for fences before enqueueing DMABUF

Thinh Nguyen (1):
      usb: dwc3: ep0: Don't reset resource alloc flag

Uwe Kleine-König (2):
      usb: gadget: fsl: Initialize udc before using it
      MAINTAINERS: Drop Li Yang as their email address stopped working

Vanillan Wang (1):
      USB: serial: option: add Rolling RW101-GL and RW135-GL support

bolan wang (1):
      USB: serial: option: add Fibocom FM135-GL variants

 MAINTAINERS                           | 14 +++-------
 drivers/thunderbolt/switch.c          | 50 ++++++++++++++++++++++++++++-------
 drivers/thunderbolt/tb.c              | 10 +++++--
 drivers/thunderbolt/tb.h              |  3 ++-
 drivers/thunderbolt/usb4.c            | 13 ++++-----
 drivers/usb/class/cdc-wdm.c           |  6 +----
 drivers/usb/core/port.c               |  4 ++-
 drivers/usb/dwc2/hcd_ddma.c           |  4 ++-
 drivers/usb/dwc3/ep0.c                |  3 ++-
 drivers/usb/gadget/function/f_fs.c    | 29 +++++++++++---------
 drivers/usb/gadget/function/f_ncm.c   |  4 +--
 drivers/usb/gadget/udc/fsl_udc_core.c |  5 ++--
 drivers/usb/host/xhci-ring.c          |  9 +++----
 drivers/usb/host/xhci-trace.h         | 12 ++++-----
 drivers/usb/misc/onboard_usb_hub.c    |  6 ++++-
 drivers/usb/serial/option.c           | 40 ++++++++++++++++++++++++++++
 drivers/usb/typec/mux/it5205.c        |  2 +-
 drivers/usb/typec/tcpm/tcpm.c         |  4 +--
 drivers/usb/typec/ucsi/ucsi.c         |  6 +++--
 19 files changed, 151 insertions(+), 73 deletions(-)

