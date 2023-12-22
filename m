Return-Path: <linux-kernel+bounces-9493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1FB81C680
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74B32833D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBD6CA75;
	Fri, 22 Dec 2023 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I79hw7W1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F93CA5D;
	Fri, 22 Dec 2023 08:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3879CC433C7;
	Fri, 22 Dec 2023 08:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703233553;
	bh=kPdQ/L1/w4JPV2uYWZWxw8ZJoArsS+aHNlrjusqp61k=;
	h=Date:From:To:Cc:Subject:From;
	b=I79hw7W11ErB7EKIEbnokkb/fIj95q8jaZQ8yb5rDQRJyO4qTasWC1B/ulJJsWSeL
	 iyPyR6gzP7pxb298qOXN8DNCOYu/q9ol4zzwgn8nC+K825PRnyTHZygu5LfPVLBzRL
	 WOoBStBOs8XstGTfEoVJcVlfzqzfPsFqaTYNvTinrsMj8GKF9rBjopD6qxCVDhGc9A
	 abttjViMa3BnLEa3WCpu6RFXoexQSR+jTNHoveHlVZqYGqo7e26yIFnB533bOJGsCM
	 Xshoq8mpX3ZYN0Gm78uLSUyGfaK57a3oXQsbrEehtI7Cv8aABHZENfsiu8j7Fno9FB
	 14kP0cxiihduQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rGaqv-0005qZ-2z;
	Fri, 22 Dec 2023 09:25:53 +0100
Date: Fri, 22 Dec 2023 09:25:53 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial device ids for 6.7-rc6
Message-ID: <ZYVIEZrOWCbq63Cb@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.7-rc6

for you to fetch changes up to 6d79d9434c69bb8ffa8a631050eb0ad6b83d3e90:

  USB: serial: option: add Quectel EG912Y module support (2023-12-21 17:36:06 +0100)

----------------------------------------------------------------
USB-serial device ids for 6.7-rc6

Here are some new modem device ids and a rename of a few ftdi product id
defines.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Alper Ak (1):
      USB: serial: option: add Quectel EG912Y module support

Mark Glover (1):
      USB: serial: ftdi_sio: update Actisense PIDs constant names

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RM500Q R13 firmware support

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W265 with new baseline

 drivers/usb/serial/ftdi_sio.c     | 6 +++---
 drivers/usb/serial/ftdi_sio_ids.h | 6 +++---
 drivers/usb/serial/option.c       | 5 +++++
 3 files changed, 11 insertions(+), 6 deletions(-)

