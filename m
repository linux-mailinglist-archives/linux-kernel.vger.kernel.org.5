Return-Path: <linux-kernel+bounces-119049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D50688C338
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19011F3FDE7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A8274E03;
	Tue, 26 Mar 2024 13:18:30 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62067A00;
	Tue, 26 Mar 2024 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459109; cv=none; b=QtdTJTkRpMbs1Xl+T+sISdUqLa6TMEf2C0ap7XM2Pj9Dv4ZjNpLs2ykbb4cZfxBvFUfzVXJ/jAPCRaY0qfG47HtyFwj1UQ29dPOLbcO/OsPhLgx0+eik/Li8ilb1oDSEpb35FRs2e1gPriRZAUBdJ/7SVfbrOizafj4ASihux1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459109; c=relaxed/simple;
	bh=cA2n/4MwPui6Y5OPDLkQphyzkjGT48J32nYE9CzA/dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLS1NB4u2GplQKzjZfLIwICAWfJfGABM22bsiQ4etN7goATo9JL8uqQN/sZP72CsqvI8eHcqoBlgNhPozVU5KzcSWNMlK2IxcPhAlFm6erku4+QnZBNnpDgF2lskyGc0MdBFUfdm+OsLl/RVneB8jCppOEXaTR1dq0VgiAM86jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp65t1711459041tzi6x6bq
X-QQ-Originating-IP: acgQfBts7Ri8OsILJnCeWeEv+z+f4+tsbDVsBeBQ8ns=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 Mar 2024 21:17:19 +0800 (CST)
X-QQ-SSF: 01400000000000C0B000000A0000000
X-QQ-FEAT: j86OQQvu8eT7MzXz62hGqvvve66w8l0TlZpW33Rvt5TN1M/cVf4Jm4Mu55Yo3
	XjNj2uVpHGrHWdH+uqxRo5oNJLMFjY83HKReFabpjKNaJLyCtD1XqGsM78z/LTdqEtTTJnd
	RstgIFoXYackNGGDM9J23s4usPvF/OZxHHP95N6dXSZZArTPAL3v9ZAD7N9L8U7L01zjU9Y
	KpMH46nS/LBeicmeA3YTBJydG0dIAZ9argLRNYrdzAgFbc8w3kzQlg5fsrGL2R0JDE4i7NI
	jK+ZfJdvLGdYjMBLx3YSA7muxMZt523490v32VBRodfqu+Kxh/JLJGUu+DPpPJXfmyMPJZX
	/cnE9Cm0Z9NbM9dbQl3zV18/5PJ9VspZZpgC+xkpTZYB08yiR1W3FB1Oc5EUg==
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13992481150274053400
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com,
	dmitry.torokhov@gmail.com,
	rrangel@chromium.org,
	shaoyang@uniontech.com,
	helugang@uniontech.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	huangbibo <huangbibo@uniontech.com>
Subject: [PATCH] Input: PS/2 - add support for Lenovo Xiaoxin keyboard
Date: Tue, 26 Mar 2024 21:17:18 +0800
Message-ID: <593C1A73FB93BACE+20240326131718.20497-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Modified keyboard_ids in function ps2_is_keyboard_id
for Lenovo Xiaoxin keyboard.

Signed-off-by: yuanjianye <yuanjianye@uniontech.com>
Signed-off-by: shaoyang <shaoyang@uniontech.com>
Reviewed-by: huangbibo <huangbibo@uniontech.com>
Signed-off-by: helugang <helugang@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/input/serio/libps2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 6d78a1fe00c1..39d46526c56a 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -189,6 +189,7 @@ bool ps2_is_keyboard_id(u8 id_byte)
 		0x5d,	/* Trust keyboard		*/
 		0x60,	/* NMB SGI keyboard, translated */
 		0x47,	/* NMB SGI keyboard		*/
+		0x83,	/* Lenovo Xiaoxin keyboard	*/
 	};
 
 	return memchr(keyboard_ids, id_byte, sizeof(keyboard_ids)) != NULL;
-- 
2.43.0


