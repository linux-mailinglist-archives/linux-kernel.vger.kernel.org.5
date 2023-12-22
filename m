Return-Path: <linux-kernel+bounces-9276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C2081C33E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8CE1F25876
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D273215A4;
	Fri, 22 Dec 2023 02:59:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71818ECA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8BxNPCN+4Rlbr0DAA--.19034S3;
	Fri, 22 Dec 2023 10:59:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Axnr6J+4RlGu0EAA--.17897S2;
	Fri, 22 Dec 2023 10:59:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	raven@themaw.net,
	davem@davemloft.net,
	svenjoac@gmx.de,
	anthony.l.nguyen@intel.com,
	richard.henderson@linaro.org,
	peter.maydell@linaro.org,
	philmd@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH 1/1] LoongArch: defconfig: Enable Generic PCIE by default
Date: Fri, 22 Dec 2023 10:46:28 +0800
Message-Id: <20231222024628.3138406-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Axnr6J+4RlGu0EAA--.17897S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Enable generic PCIe by default in the LoongArch defconfig.
QEMU requires this configuration when booting the kernel with FDT.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 arch/loongarch/configs/loongson3_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 33795e4a5bd6..6350be7e8ec8 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -348,6 +348,7 @@ CONFIG_NET_9P=y
 CONFIG_NET_9P_VIRTIO=y
 CONFIG_CEPH_LIB=m
 CONFIG_PCIEPORTBUS=y
+CONFIG_PCI_HOST_GENERIC=y
 CONFIG_HOTPLUG_PCI_PCIE=y
 CONFIG_PCIEAER=y
 # CONFIG_PCIEASPM is not set
-- 
2.39.3


