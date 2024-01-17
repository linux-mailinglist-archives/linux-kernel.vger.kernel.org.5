Return-Path: <linux-kernel+bounces-29051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB81F8307B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C981F24912
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEA3208AA;
	Wed, 17 Jan 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="acUCpYn1"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B20208A0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500873; cv=none; b=XFCcIFcn3XlYRPMJiLYfUIy9hLZWLfZ1/Hln1ZPgr4k9/sdVtgJZh5GOKNXF4H6s33VTAs3YLmRcuoGHzdphVchJcBh6i9KyH5cjOxoaR35QX7zpnKdKHnDTWZAHUxciGhzeF4M+rkIptnXps/c+wJW3ey0gOt4bmPEeK04Wba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500873; c=relaxed/simple;
	bh=JB/sO0hUvlGOLAOj/TdazBS735nJBE/uFDOhzWPZTaQ=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version; b=DEboLzE7NurGQF1Nfrety1H3fMIf2OetiHehmOxwD5DR0N5mLTQDwixk3rU4k2E3Y98dxW/Ytbdt6KTuOBQ20IMbH00yRDzirafjaVAaOfVD04bI3gGmpgQG9ZvZmltLWrWpowkSUy3PImMkGE+SDDsxgtS4JvgGO4gsdKxtU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=acUCpYn1; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H8pncr012890;
	Wed, 17 Jan 2024 06:14:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=9hGHKg1L
	IZv//WFnLkiKQZa8nyqG4hfZ/wEOZ4zc+O4=; b=acUCpYn118uZDM+VjjXfsvlF
	nLQwRdSU9GIyvS/xkLSQ+Ad+uYaEAaLR9E3Z9thGT9jQD9nYOVY/jMhkGCpP8jfM
	8NQAKBmbO7QyPTpXKsxTG2/4OHMyYoXDti88KQMtBwKKby/5CThZZc6R8iQ8JKqz
	9x31402fO6vCY25qkM5VXfzXT5QNTQfj1qfkyVjlWDBSlt/XdEuXNCLcHjBVDPyn
	hvx4fFikD/kH89hAFNBImbq1CWa2HSJqfro1ypBc2i6lWqjDzK+BlpWeZRbJ53W9
	5AmiSOY4n/Wnql8x1hxiTIKXZA+ioXTuEvM6N6NMmekQdK30B6aqyvIANosGcw==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vp0ge391r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:14:14 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 06:14:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 17 Jan 2024 06:14:11 -0800
Received: from localhost.localdomain (unknown [10.28.36.167])
	by maili.marvell.com (Postfix) with ESMTP id A15CA5B6932;
	Wed, 17 Jan 2024 06:14:08 -0800 (PST)
From: Amit Singh Tomar <amitsinght@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <fenghua.yu@intel.com>, <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <jonathan.cameron@huawei.com>,
        Amit Singh Tomar <amitsinght@marvell.com>
Subject: [PATCH v1 00/14] ARM: MPAM: add support for priority partitioning control
Date: Wed, 17 Jan 2024 19:43:51 +0530
Message-ID: <20240117141405.3063506-1-amitsinght@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: I1Qvg8_aeG6dDMzfE6dDHktllrwixrgS
X-Proofpoint-ORIG-GUID: I1Qvg8_aeG6dDMzfE6dDHktllrwixrgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02

This patch-set is continuation to the RFC[1], we sent last year. The patches
that we sent earlier, embed the DSPRI (Downstream priority) value into already
existing schemata file, which is used to configure CAT (Cache Allocation Technology)
capabilities. For instance, in order to configure Downstream priority, DSPRI
value is passed in following way:

echo L3:0=ffff,a > schemata, where "a" dspri value, and ffff cache portion bitmaps.

But instead of using already existing, "L3" schemata, we can have new schemata
that is dedicated to this new/extended priority control (at the moment, extended
control is limited to only DSPRI but we can put new/more control same way). For
instance, this version uses new schemata L3DSPRI, and following is the way
to configure downstream priority value.

echo L3DSPRI:0=a > schemata, where "a" is dspri value.

Overall, the schemata for a system that support all these controls looks like:

MB:0=100
L3DSPRI:0=f
L3:0=ffff

and this approach aids in code decluttering, for instance, we don't have to 
really care about dspri flags (dspri_store, dspri_show, used in RFC version).

To help creating new schemata, Patch(1/14) is introduced (new one), It
basically divide the resource control type into two groups, and map it
to list of schemata(s).

"SCHEMA_BASIC" type is for already exiting schemata ("L3", and "MB") used
to configure features like CAT (Cache Allocation Technology), and MBA
(Memory Bandwidth Allocation).

"SCHEMA_DSPRI" type is for schemata (L3DSPRI), and used to configure
Downstream priority values. This is used in patch (3/14) when the
schemata list is extended to support priority partition control.

Took this idea from openEuler Kernel[1], pointed by Jonathan in previous discussion.

This division into groups help in configuring resource control of different
types based on control types (patch 6/14, and patch 8/14).

For now, patch (5/14), and (9/14) is split for easy review, eventually these
get squashed.

Patch (12/14) is reworked, and now priority value is inverted based on
DSPRI_0_IS_LOW value.

Patch(14/14) is a new patch, that export Maximum DSPRI value to resctrl's info
directory.

At the moment, these patches are restricted to support only the Downstream priority
control, but if this approach looks okay, can have support for both the priority controls
in next variant.

Also, these patches[3] are still based on older MPAM tree[3] from James, as facing some
trouble setting up the resource control with latest snapshots.

[1]: https://lore.kernel.org/lkml/20230901141731.00006f46@Huawei.com/T/
[2]: https://github.com/openeuler-mirror/kernel/commit/8139268b70398c37843a38bf8c7b243ad1f20c97
[3]: https://github.com/Amit-Radur/linux/commit/71ac4cca1eccb831ce04d3094f0cf794fc9d2d72
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/v6.2

Amit Singh Tomar (14):
  fs/resctrl: group the resource control types for schemata list
  arm_mpam: resctrl: Detect priority partitioning capability
  arm_mpam: resctrl: extend the schemata list to support priority
    partition
  fs/resctrl: Set-up downstream priority partition resources
  fs/resctrl: fetch configuration based on control type
  arm_mpam: resctrl: Retrieve priority values from arch code
  fs/resctrl: Schemata write only for intended resource
  fs/resctrl: Extend schemata write for priority partition control
  fs/resctrl: set configuration based on Control type
  arm_mpam: resctrl: Facilitate writing downstream priority value
  arm_mpam: Fix Downstream and internal priority mask
  arm_mpam: Program Downstream priority value
  arm_mpam: Handle resource instances mapped to different controls
  arm64/mpam: resctrl: export DSPRI value to info directory

 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   9 +-
 drivers/platform/mpam/mpam_devices.c      |  72 +++++++++++----
 drivers/platform/mpam/mpam_internal.h     |   1 +
 drivers/platform/mpam/mpam_resctrl.c      |  81 +++++++++++++----
 fs/resctrl/ctrlmondata.c                  |  74 +++++++++++++--
 fs/resctrl/monitor.c                      |   6 +-
 fs/resctrl/rdtgroup.c                     | 105 ++++++++++++++++++----
 include/linux/resctrl.h                   |  19 +++-
 include/linux/resctrl_types.h             |   9 ++
 9 files changed, 309 insertions(+), 67 deletions(-)

-- 
2.25.1


