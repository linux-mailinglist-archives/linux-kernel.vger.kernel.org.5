Return-Path: <linux-kernel+bounces-23341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C44D82AB51
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED38B21ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2487312E5B;
	Thu, 11 Jan 2024 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0RtdqRMj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46212E4C;
	Thu, 11 Jan 2024 09:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51154C433C7;
	Thu, 11 Jan 2024 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704966779;
	bh=Rg+uWdSn7M8siVwGtnph84S0VwOHlpKxDjRqhHzmUBE=;
	h=From:To:Cc:Subject:Date:From;
	b=0RtdqRMjVtvj+J7ROrMeb6Sr/+F4RqCQItOXOt4+RNnO0MS+dLkH7f+78WQrgQEJW
	 20YmvNzQFZP8ohR1Y7yg1gIB75sO+PLU7vjmMoUWutRHxfWvw2RmFw/m5LRE+kyWUf
	 x1NR2Xo3BuTYiQu+gp+nh5sbJUdc0+uy9VCwAMAI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 5.10 0/7] 5.10.207-rc1 review
Date: Thu, 11 Jan 2024 10:52:49 +0100
Message-ID: <20240111094700.222742213@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.207-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.207-rc1
X-KernelTest-Deadline: 2024-01-13T09:47+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.10.207 release.
There are 7 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 13 Jan 2024 09:46:53 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.207-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.207-rc1

Alexander Atanasov <alexander.atanasov@virtuozzo.com>
    scsi: core: Always send batch on reset or error handling command

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "scsi: core: Add scsi_prot_ref_tag() helper"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "scsi: core: Introduce scsi_get_sector()"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "scsi: core: Make scsi_get_lba() return the LBA"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "scsi: core: Use scsi_cmd_to_rq() instead of scsi_cmnd.request"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "scsi: core: Use a structure member to track the SCSI command submitter"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "scsi: core: Always send batch on reset or error handling command"


-------------

Diffstat:

 Makefile                    |  4 ++--
 drivers/scsi/scsi.c         |  2 +-
 drivers/scsi/scsi_error.c   | 34 +++++++++++++++++++---------------
 drivers/scsi/scsi_lib.c     | 38 +++++++++++++-------------------------
 drivers/scsi/scsi_logging.c | 18 ++++++++----------
 drivers/scsi/scsi_priv.h    |  1 -
 include/scsi/scsi_cmnd.h    | 29 +++--------------------------
 include/scsi/scsi_device.h  | 16 +++++++---------
 8 files changed, 53 insertions(+), 89 deletions(-)



