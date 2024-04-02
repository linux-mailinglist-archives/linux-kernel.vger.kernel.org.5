Return-Path: <linux-kernel+bounces-127758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA8789508A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D54C1F2107A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE24605C6;
	Tue,  2 Apr 2024 10:40:55 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFF4604C8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054455; cv=none; b=tjTES4NjZ3Tz3yhTjN7SvZLblwecLSu5Kgs+Kx6Bp7J7ApulP27O3X/jdmSM86zczpi/3xQhkdU414p0aFXTbcIbIzOmuRzqHwFC0lK1KrNugToLZBvdB5lAxtziq2pQlEkibhwjxjZrYIFTuGGocb4qxEXBIDU7liYRqJN4lR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054455; c=relaxed/simple;
	bh=zlkeU6jpjojNIbiATur5Go6ZRJPdDmGjYR+bSmWYh/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VVdoJacKMs8TNuE+3xzEO2yXskxtTp5pdFOu87m2VWZ/oFTwln6y+CMSKwZmqUQWiW4nYug2MJybebhd2ZMm5YR3a0GL8sn1KohUKY1PSK+Hol59eBOh3tl3v3k1ifBUWIT8ILDMVvlCGTy7mzh4kkkyspcLZs4UDTu/q42g22w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp87t1712054393t2i27laa
X-QQ-Originating-IP: pQTYK67xRdtnui0t3nN3/WaiLvBKI0ftL7JGDsgYtec=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Apr 2024 18:39:51 +0800 (CST)
X-QQ-SSF: 01400000000000G0G000000A0000000
X-QQ-FEAT: SX/WFj88WPXNfEQ5MBA40yVv9m/8TTEpOkDjsxEXYeDgJs8qCxwvtxlXfQmgS
	hRixDCy/B7Rld6Pa40LS/5KOHlSl6Z4305rQDo5t5Ew5YQSdLfuOD9v4GgzqT8PoAQkI6b0
	ZxHfASTynNFv5EJ5b8kgeNPtHwwGT9sDMCQHQoX2NNiyd80YMolKd2X8hV6HR2Gvb5YKLMO
	hs6iVbQsansRA3TyxaMDypBzxZZGDwUzUIPRznW1hamuy1Sn0bhC7LmLhJAto9yfB1edcUt
	PJKHrYp0Z1CHV03vSityjlXXkhQPf7CH1SaMK88/Ahw81vEo+CeG8sVE5mHJLLAMsrT0OcF
	EEAqIEY5+IebYp6gYt466UcVocI8U1QchuoUF/LdOWcsNZuyxL7zeG0MvpUy66ddnt3QNYB
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9711682065161928136
From: Wentao Guan <guanwentao@uniontech.com>
To: zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>,
	Yuli Wang <wangyuli@uniontech.com>
Subject: [PATCH] LoongArch: KVM: Remove useless MODULE macro for MODULE_DEVICE_TABLE
Date: Tue,  2 Apr 2024 18:39:42 +0800
Message-Id: <20240402103942.20049-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-1

MODULE_DEVICE_TABLE use ifdef MODULE macro in module.h,
just clean it up.

Suggested-by: Yuli Wang <wangyuli@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 arch/loongarch/kvm/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 86a2f2d0cb27..7f2bd9a0814c 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -410,10 +410,8 @@ static void kvm_loongarch_exit(void)
 module_init(kvm_loongarch_init);
 module_exit(kvm_loongarch_exit);
 
-#ifdef MODULE
 static const struct cpu_feature kvm_feature[] = {
 	{ .feature = cpu_feature(LOONGARCH_LVZ) },
 	{},
 };
 MODULE_DEVICE_TABLE(cpu, kvm_feature);
-#endif
-- 
2.20.1


