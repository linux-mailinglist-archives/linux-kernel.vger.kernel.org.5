Return-Path: <linux-kernel+bounces-138583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD6D89F40A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9969A28BAB1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D0015F311;
	Wed, 10 Apr 2024 13:19:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726D215E5C3;
	Wed, 10 Apr 2024 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755156; cv=none; b=hrqLoWwLuNbGAw5vOkBfac+fTRoMDEMK4GvdubyZ0/HjSwG+On4CHZ/zj8crQ34I9BOtDQAoK1vsvG+WxYeekkHShha4+r08pymmPyCgDJHvekCDw+quHtudCrFkug+acqmNq4M3NOt7llEocfuOBdosq+WdGmq1H45OmeHxvGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755156; c=relaxed/simple;
	bh=5O4fmy2vjH3L0s3zrjGmErdy2p3sZ4emy2NNtUuD/Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JektFyQfyUoRp43d86yKrS9jcH4CQK5sZf/QzyPa4tZfFPu8PFHk2etcaZxu9Z3eDs+088sCUUDet/gdmb1vh/GmlSFOtEYOxuFVwTEcwXZeu+lJI/43H7AK+yqJuPtjKqJy4B3v9GIeZpSLscBRC+lD5oI1xy2b8zs8oeAxgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B14C433C7;
	Wed, 10 Apr 2024 13:19:13 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 1/4] LoongArch: Update dts for Loongson-2K1000 to support ISA/LPC
Date: Wed, 10 Apr 2024 21:18:01 +0800
Message-ID: <20240410131804.2165848-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410131804.2165848-1-chenhuacai@loongson.cn>
References: <20240410131804.2165848-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Loongson-2K1000 platforms have ISA/LPC devices such as Super-IO,
define an ISA node in the dts file to avoid access error.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/boot/dts/loongson-2k1000.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/loongarch/boot/dts/loongson-2k1000.dtsi b/arch/loongarch/boot/dts/loongson-2k1000.dtsi
index 49a70f8c3cab..b6aeb1f70e2a 100644
--- a/arch/loongarch/boot/dts/loongson-2k1000.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k1000.dtsi
@@ -100,6 +100,13 @@ bus@10000000 {
 		#size-cells = <2>;
 		dma-coherent;
 
+		isa@18000000 {
+			compatible = "isa";
+			#size-cells = <1>;
+			#address-cells = <2>;
+			ranges = <1 0x0 0x0 0x18000000 0x4000>;
+		};
+
 		liointc0: interrupt-controller@1fe01400 {
 			compatible = "loongson,liointc-2.0";
 			reg = <0x0 0x1fe01400 0x0 0x40>,
-- 
2.43.0


