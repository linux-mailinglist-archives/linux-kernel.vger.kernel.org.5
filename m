Return-Path: <linux-kernel+bounces-25027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9300082C650
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F219B212F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE351642D;
	Fri, 12 Jan 2024 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BNBwPdl+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304216408;
	Fri, 12 Jan 2024 20:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47D4C433C7;
	Fri, 12 Jan 2024 20:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705090653;
	bh=75JiH8kzfFtsmvxd4fH2+U/Tptv/Qz1Z1CgVG1oNzXw=;
	h=From:To:Cc:Subject:Date:From;
	b=BNBwPdl+miROVR6GXT5ds/0g9Dkvd6qGFpoLItV3l8tK+rawe6TRx7gSqGC/UtJOC
	 q2mTFO35a/Ewc0Aq6YorDYPzTTBReOOnFRRkzwOkd2Ycf24eNMIZznlEV9AQRj3ney
	 dEDlxYHdDpEYRCMQ4YrZB4EbCZyHj/1m41YQTJoo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.207
Date: Fri, 12 Jan 2024 21:17:28 +0100
Message-ID: <2024011229-oyster-basically-df9f@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.207 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                    |    2 +-
 drivers/scsi/scsi.c         |    2 +-
 drivers/scsi/scsi_error.c   |   34 +++++++++++++++++++---------------
 drivers/scsi/scsi_lib.c     |   38 +++++++++++++-------------------------
 drivers/scsi/scsi_logging.c |   18 ++++++++----------
 drivers/scsi/scsi_priv.h    |    1 -
 include/scsi/scsi_cmnd.h    |   29 +++--------------------------
 include/scsi/scsi_device.h  |   16 +++++++---------
 8 files changed, 52 insertions(+), 88 deletions(-)

Alexander Atanasov (1):
      scsi: core: Always send batch on reset or error handling command

Greg Kroah-Hartman (7):
      Revert "scsi: core: Always send batch on reset or error handling command"
      Revert "scsi: core: Use a structure member to track the SCSI command submitter"
      Revert "scsi: core: Use scsi_cmd_to_rq() instead of scsi_cmnd.request"
      Revert "scsi: core: Make scsi_get_lba() return the LBA"
      Revert "scsi: core: Introduce scsi_get_sector()"
      Revert "scsi: core: Add scsi_prot_ref_tag() helper"
      Linux 5.10.207


