Return-Path: <linux-kernel+bounces-85600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8AB86B82E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BD81C22FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C900B74439;
	Wed, 28 Feb 2024 19:33:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44FA71EB3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148790; cv=none; b=dOv3f1HGbddUyKYh6MgYSwlj26K8WAVrQ3d7nu2DqyX/Do0zSdHM3thSetyqdGVDbT+snLHkSNgn1oQ/q34z8RRsK1VJGO/3OuthOqnOyrfUd7LAzRCIF1gfNZ6/GHRfX/uFvGoBxhOdlTvC5cW7VT4sJq0edeHXH07b0SarfUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148790; c=relaxed/simple;
	bh=cp8+6ekJBWKtKNySKj24XiQGgULlwtU+xIo4dFgAjFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhrXMHaFlMDvurRiZybtPp4rv3mwRsxktok8Le3xWgWtGcDGgbuf7bueH0UcxKPJU1u8x3HXHOzzK63kLpWLkn18dwRe2/I0JHO1REwBG5DVTxczJm5Gd/tLdnDrwIVqiBGcN7OYL29rIFrvcWzHITgd1dboFsOKzL7DB03uBLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D10AC15;
	Wed, 28 Feb 2024 11:33:44 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB01A3F73F;
	Wed, 28 Feb 2024 11:33:03 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/4] SCMI misc small-updates
Date: Wed, 28 Feb 2024 19:32:34 +0000
Message-ID: <20240228193238.2102157-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

a bunch of small SCMI updates based upon sudeep/for-next/scmi/updates on
top of:

commit c2f0961a45c4 ("MAINTAINERS: Update SCMI entry with HWMON driver")

Thanks,
Cristian


Cristian Marussi (4):
  include: trace: Widen the tag buffer in trace_scmi_dump_msg
  firmware: arm_scmi: Add message dump traces for bad and unexpected
    replies
  firmware: arm_scmi: Simplify scmi_devm_notifier_unregister
  firmware: arm_scmi: Use dev_err_probe to bail out

 drivers/firmware/arm_scmi/driver.c | 70 ++++++++++++++++++++++++++----
 drivers/firmware/arm_scmi/notify.c | 30 ++-----------
 include/linux/scmi_protocol.h      |  2 -
 include/trace/events/scmi.h        |  4 +-
 4 files changed, 67 insertions(+), 39 deletions(-)

-- 
2.43.0


