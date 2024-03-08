Return-Path: <linux-kernel+bounces-96629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6958875F1D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D711F21C2E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A850A9D;
	Fri,  8 Mar 2024 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/N0WqQu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F54EB47;
	Fri,  8 Mar 2024 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709885339; cv=none; b=DIgjYFLTjS4aGHEARjkUPKuwZz9702My8b4ROm98ER2mRIHaYDG6EZlesMFGJyBncp7uRK7SopTE0kMM6qF788pkcU648i1y+rhgE1odE6TtacnlyXmUylkvq1IouygH1i4qpADaNoXpWvMtuBpyl2lo+VEzh4arfkDP0QEOzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709885339; c=relaxed/simple;
	bh=l2NTQSJg+Xo9v3YxBVq8xgxtXEYSOSbE2gIHyCPP/pE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WuV6EElv+xRCcc9XCUDKxgr2wtyyphc5zgsE+hcO3q65VtpCW4OsvbHvsI2khPYWtg6bXgSSK8GlwJn/sYOhN7cB+WAEy4jzWJdpdNJZ5KOL6yZQzbGUVo8S7lUdydu/STZ9KM6LNLwhS3RbmRI9pNOeFQeDENh6z6gFSJK/GB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/N0WqQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1699EC43390;
	Fri,  8 Mar 2024 08:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709885339;
	bh=l2NTQSJg+Xo9v3YxBVq8xgxtXEYSOSbE2gIHyCPP/pE=;
	h=Date:From:To:Cc:Subject:From;
	b=V/N0WqQusvIGwAuv5Uch4PZVXYeC6/rIMNRlh9YeHk55xgiMsjIvH+GbsJ/mW7kH/
	 n+mPezV9jRuHqxF3BdCvpF+NirTrkeae2ezRBXem0jxnaE5ZG95vIPITE28cIiMN4y
	 Xsxk5yT17Rzzj6HlMWjVz/wAfEQeoSvNg2KVguggF37JZRiJf+bD3DFHTNdg2OZPaE
	 Rt6vAUYrRCPccWpzv0u/wmNPSS6cJD7QBg6zhJ5FskRFSQjtmumB5BEpGRjd5cTDpl
	 63qjQ/xtwXJieXF7tMUutuxAzEomFxK7nuJPwGBBW2H+hGbHNmroNC9RTqAqxaCSKO
	 WlJSnrNERFzeg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1riVHu-000000001mk-0iTR;
	Fri, 08 Mar 2024 09:09:06 +0100
Date: Fri, 8 Mar 2024 09:09:06 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 6.9-rc1
Message-ID: <ZerHovZ5jaE4NcWj@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.9-rc1

for you to fetch changes up to b1a8da9ff1395c4879b4bd41e55733d944f3d613:

  USB: serial: cp210x: add pid/vid for TDK NC0110013M and MM0110113M (2024-03-05 07:51:37 +0100)

----------------------------------------------------------------
USB-serial updates for 6.9-rc1

Here are the USB-serial updates for 6.9-rc1, including:

 - new device ids
 - removal of some redundant assignments

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Aurélien Jacobs (1):
      USB: serial: option: add MeiG Smart SLM320 product

Cameron Williams (1):
      USB: serial: add device ID for VeriFone adapter

Christian Häggström (1):
      USB: serial: cp210x: add ID for MGP Instruments PDS100

Colin Ian King (3):
      USB: serial: oti6858: remove redundant assignment to variable divisor
      USB: serial: ftdi_sio: remove redundant assignment to variable cflag
      USB: serial: keyspan: remove redundant assignment to pointer data

Daniel Vogelbacher (1):
      USB: serial: ftdi_sio: add support for GMC Z216C Adapter IR-USB

Toru Katagiri (1):
      USB: serial: cp210x: add pid/vid for TDK NC0110013M and MM0110113M

 drivers/usb/serial/cp210x.c       | 4 ++++
 drivers/usb/serial/ftdi_sio.c     | 4 +++-
 drivers/usb/serial/ftdi_sio_ids.h | 6 ++++++
 drivers/usb/serial/keyspan.c      | 1 -
 drivers/usb/serial/option.c       | 6 ++++++
 drivers/usb/serial/oti6858.c      | 1 -
 6 files changed, 19 insertions(+), 3 deletions(-)

