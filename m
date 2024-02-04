Return-Path: <linux-kernel+bounces-51773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118B4848F24
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9408CB210D1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F48F22EE5;
	Sun,  4 Feb 2024 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="QoLNkxv0"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058802263E
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062995; cv=none; b=kPpYP25lrU5pTO7wnhpr4BYae1j2CxsATmHNbitOqjAuEaFPIosNpvJMgr/tIPeIQZIQZ0Gc9KVPq/uGLgkPQoITDoi2lFshNsDx+kGt/s/iZroKmXVagesOLbuF9zVoFaOiykRZ2lbEwvcia4q95a91iR7AXesFTK85r/a/LY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062995; c=relaxed/simple;
	bh=yT6J0fuV2sy5FT+Ua1YIv78ljWDgj24fSnY8XpK8Ggg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MP+WGsrFKKiYiEtGHlVx2m807zTsXoxofABEiiFjq0fcHDACLfA+ZI1L0gzT5TaSpLj090aVv8uOjEUjFoF3Dw8txsCeTYVP5QFRmMSaAvywsjCd2XPUjys/8qanOsjMET+n2KEIjBwMUStOdEmvwAXaI05vj/TadDU6MDBCe/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=QoLNkxv0 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3029700a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 08:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707062993; x=1707667793;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWqMJ/jRctxyHiUbWPmjsOM1QzXA4zMH0ym4Baam8co=;
        b=ZIu/xwOGRNzxEFz/scXYqxJt2oEfJdqTsACRNa+qK3s0Om53+OeCwjIWr3oSX5csHf
         uP8NGjO3PVeysKurrXj8FsaU6uBsGjz2gcrHeg6OWwR/ETxxTDPdSbg0LRiqdkpmFujn
         h113h2tE9hXk7qiUvVkAJjhie5jV9AjBlNI2OByVDi9BvsQyCrOOCGGPT2tyRwQyyo6c
         3sszuBA8i3yzngb612+bTCCFRjQT7mAU7FgXLzpR85/JJV/2Scq6D2hnu/kU3QNBsKrB
         2Oe0b75AxZwlQDHELDw6wi19oH++vzTYa/apuptZhJBdEGJAfpzTZJbzF2jgt8QSPhcM
         lf9A==
X-Gm-Message-State: AOJu0YwxRkJLqyusU6OKXg1nyQr/6Fuuxe4XZFGuSBA8YZOX/0LE30en
	cBT2jVcorAtf7R5ZLseJGMY/KKFjdWj4LuS55s4dN6gJo5OQ3mUC
X-Google-Smtp-Source: AGHT+IF3flFTHd6K6edLpNmAFSNjuA1IKaxBFgxvH3+lgmQKoTbdXT/oE6xIM7kRe9HaQxRwY4HXAw==
X-Received: by 2002:a05:6a21:3984:b0:19e:4816:e71a with SMTP id ad4-20020a056a21398400b0019e4816e71amr12017186pzc.27.1707062993209;
        Sun, 04 Feb 2024 08:09:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU0sivYn1COiDhZZ+tKc/D5cERyQ+JIG9Et3X6isu25w/21FaucbNexqwHt3etdffRJG9qXSYC8k2BM1CNHkWcwyE+WpqrQd1/bk2xUb6f9Zq7fvNsDyVIAyfJlPRI5LA9I2SOhXXzlpsLtNcPEfKaGxD9JbZJWBwgC6pLblXU4g6frJrs5eaPGgebk6O/qbg7YuxJSDEmbrA==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id y184-20020a62cec1000000b006e02ff27fe6sm2293043pfg.121.2024.02.04.08.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 08:09:52 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707062991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rWqMJ/jRctxyHiUbWPmjsOM1QzXA4zMH0ym4Baam8co=;
	b=QoLNkxv0e2xWnQMW2JQ8AfxBzwnfJ5QvRjDVbxExUnEFR4PZ5Y53gw4mGj2SddY6BGCy+T
	/RWSeFCdTDcSON8hkaazjN6jWCklqyE1gTmZ3hRBzhP1iCGZ8faR2GDpttm+nCOwlNhKla
	PQS19r1schtKbn/Khksofg0uGDQ8hBKWFseVXhe6vSKjFJ5+sSUsrFdxYk5cbC4JDDyOA0
	88u0gbIPBIP4a6Q70GLSENKCo/fwBv/YagkcEHv51vtqcbR7VW1CKoE3loCX58+TY6FukL
	KNXlKwjjmZ0yjMC/nBEkviCfl3Qovggp/zUSsxP6wwcEFWuNMUhufzOcPsixiA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 13:10:18 -0300
Subject: [PATCH] firmware: coreboot: make coreboot_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-firmware-v1-1-d1bff946606d@marliere.net>
X-B4-Tracking: v=1; b=H4sIAOm2v2UC/x3MTQqAIBBA4avErBMmEcGuEhFWUw2UxUg/EN49a
 fkt3nshkjBFqIsXhC6OvIeMqixgWHyYSfGYDRq1QY1G9WfshpV8OA81sWy3F1LOjYi2QmO1hZw
 eQhM//7ZpU/oA5utJsmYAAAA=
To: Tzung-Bi Shih <tzungbi@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=yT6J0fuV2sy5FT+Ua1YIv78ljWDgj24fSnY8XpK8Ggg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv7buAhLuTmKEID3LBRKEmHRjCq+WHjAExS/b5
 w9rn2SfqLOJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+27gAKCRDJC4p8Y4ZY
 pjr+EACBSX/uoVX4aHiUwP4CwddHD6HrgguSY7UqiO/BBdEz5ZlBCoDppZBbIkD4G6GlD3SAoih
 RbHezlso8x2cUulOcgBuF8R5RbEk0gy9pSIE4Y7hMYxHkr6gV6bNuXzXVJMitfDRTDJy6sl0pm+
 So+XuRnJMK4dqJY+mGBN4inMOKWigPY7QAqZbslb1zHzhvfAtRAZe0Bv6pME8yYY4/79sC3P58L
 3xfzoWpuEAaL4YPczYloeEXr+Drv0mYj6HBI1zN2d3ayc+gHv7dNoOpINfAGx/z6aUSD5swIHMS
 602ZcF9G68LSUE4898x7jxoqjB6jehbakbpIWFqCaqkK/UrymmXXtY38hqZw1GdFpejWX/M0sm/
 kUoNIJaPA/LGi31oF72l1rEEWJx/vNjye3HFcRjCoOoNm/XJ5o+/safzQlZUWQliartjJKWKI4M
 vqCIh95Lsmw92HvhaIZPXNp59WXW6tr6VD/b6vBR4RdO0hK4Go/YVwvfj8mbx1ml6elsEx/NEoA
 WNpcjIbcKPDqx8uLlffIzBcKKBPnM+g4eSSMwF2Mh/ObzTVfEVhox8qVNYpfn+aeFJZTt/pjwJC
 fNKbXxfNsaf6PtjFR47MdSeVp71GhDQSYXKSu/t6U8Lt1pXhHpzP9+l4EOQqD8WidIRujmWrMhb
 ZwZOmD8YI+nAxcQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the coreboot_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/firmware/google/coreboot_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 2a4469bf1b81..fcdc387ae7aa 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -53,7 +53,7 @@ static void coreboot_bus_remove(struct device *dev)
 		driver->remove(device);
 }
 
-static struct bus_type coreboot_bus_type = {
+static const struct bus_type coreboot_bus_type = {
 	.name		= "coreboot",
 	.match		= coreboot_bus_match,
 	.probe		= coreboot_bus_probe,

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240204-bus_cleanup-firmware-99d006104626

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


