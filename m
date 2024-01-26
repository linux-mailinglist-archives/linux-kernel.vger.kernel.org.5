Return-Path: <linux-kernel+bounces-39727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3024283D575
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41971F26231
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4305163135;
	Fri, 26 Jan 2024 07:56:19 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5ED310;
	Fri, 26 Jan 2024 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255778; cv=none; b=pR+OAQisXCZAYI8CBP55HtH3NDJZHpPn9gclVOKj+Q4IQFFfKGMO/BJ0OTQ+yNSpXmF+x3mEnPKSU5Y/0IZp+UOrAFQvlZLGTDf01m/YlTLTKefZBSGwR7dM3X4P7BCd0CgjRpwMUAIdcljz+SC14nQR4GemvWp2JAyB4Y3ieJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255778; c=relaxed/simple;
	bh=x40KTGVdO4caFI9vAMxA+4UUWiZpktSPCnUOvDhAMK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hdd9UplVzp0KZj+uMhG+O6WX7mNt/+bSCRjH8fiV0mPfMQPSN3r2rTSPO3tcT8skQX/aVaeZDrV8Ewl2BqY6XHsyHoj1vjrD990ezGbsVzKPyhpGO2vo5nY45lArARo9nmdbhlkj3cGEMA6avg0L512Y8eRUU+VYMR5FhoiPg4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1fc204bb3df547b99960ebe6b27bc77e-20240126
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:49738768-b6d3-4cf5-9efa-c39c590ff1bf,IP:20,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:6
X-CID-INFO: VERSION:1.1.35,REQID:49738768-b6d3-4cf5-9efa-c39c590ff1bf,IP:20,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:6
X-CID-META: VersionHash:5d391d7,CLOUDID:dc7baf8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240126155607M9ZGF07O,BulkQuantity:0,Recheck:0,SF:38|24|17|19|43|74|6
	6|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 1fc204bb3df547b99960ebe6b27bc77e-20240126
X-User: mengfanhui@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
	with ESMTP id 832743153; Fri, 26 Jan 2024 15:56:05 +0800
From: mengfanhui <mengfanhui@kylinos.cn>
To: tsbogend@alpha.franken.de,
	geert+renesas@glider.be,
	mengfanhui@kylinos.cn
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] config/mips: support zswap function
Date: Fri, 26 Jan 2024 15:55:47 +0800
Message-Id: <20240126075547.1521556-1-mengfanhui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Solution /sys/module/zswap/parameters/enabled attribute node
does not exist issue，handle zpool zbud initialization failed,
open CONFIG_ZSWAP CONFIG_ZPOOL CONFIG_ZBUD configuration,manual
zswap function by /sys/module/zswap/parameters/enabled file

Signed-off-by: mengfanhui <mengfanhui@kylinos.cn>
---
 arch/mips/configs/generic_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
index 071e2205c7ed..14884df392f4 100644
--- a/arch/mips/configs/generic_defconfig
+++ b/arch/mips/configs/generic_defconfig
@@ -13,6 +13,9 @@ CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
+CONFIG_ZSWAP=y
+CONFIG_ZPOOL=y
+CONFIG_ZBUD=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_BPF_SYSCALL=y
-- 
2.25.1


