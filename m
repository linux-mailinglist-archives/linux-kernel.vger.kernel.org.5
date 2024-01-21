Return-Path: <linux-kernel+bounces-32188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BDA8357DE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C101C20BB3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A17438DE0;
	Sun, 21 Jan 2024 21:11:54 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84625381DC;
	Sun, 21 Jan 2024 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705871513; cv=none; b=e1BqUmfIuLrAL00CDxMt8YFUBMD87vKvi0UmOh4L9uvQo8wdhkTjwwDRdRabbVM6kQX8hoKo8x1bGHEz6qJm4SuIQoD66+m5dO3FJScz9BlzkNXSGiLgGIzi6BYyoULmEtcGsNuk9LDB59LT/x9vqgWLwkgJxRNmVbSGXDQJazY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705871513; c=relaxed/simple;
	bh=otOwVFhN9BfjL4K3Po0fXUsJpt+/JO+cvNKKpgo5aKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rFm8bA+Ma52fHtg7vcij3e4BZovkAEsMqICnELxt+OzrRBzysBJjjv3PmL5LN/YnwEiT4nzJjZ4vQcftK3JMKnYA974Pj3cn6tm1uTD26MO/OxkT3TFeYOE3m0anUC8v+WX2CzLCSs+QZLnuTFz4ZhWCVsXvpkuixjDWSP8dPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id E7A6C844EC;
	Sun, 21 Jan 2024 22:11:46 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Sun, 21 Jan 2024 22:11:00 +0100
Subject: [PATCH] Input - 88pm80x_onkey: add SPDX and drop GPL boilerplate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240121-88pm80x-onkey-spdx-v1-1-b646d4749f5b@skole.hr>
X-B4-Tracking: v=1; b=H4sIAGOIrWUC/x3MQQqAIBBA0avErBtQsZq6SrSImmqITBTCiO6et
 HyL/x+IHIQjdMUDgS+JcroMXRYwbaNbGWXOBqOMVdpoJPIHqYSn2/nG6OeEpplU1S41EVnIoQ+
 8SPqn/fC+H7sTeDBkAAAA
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=otOwVFhN9BfjL4K3Po0fXUsJpt+/JO+cvNKKpgo5aKY=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlrYhtTPZRUI09tm+zogjqmzGruDaqzkqcVAPlR
 gYCPGM+lymJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZa2IbQAKCRCaEZ6wQi2W
 4cudD/0Q9HF+pXYPIC8iqWmDKeYyB4vLnYpulp/4UeRerww11Prq0zrf7oJVjetIuqGROgHhpbR
 LRsVBwHFcb0P/rGxp+ofldYWl5T038Z30Sek0zjmdRkd65njEJeXTiNXnxGseoQ2OtRYRNd4q+u
 Q5528j3LLssC7tPiF3ByS5vBCIEwlnn60JBmpE/S8Z1gN9B7wNJUftFiQYc1RNPDlg7vNPf5gL5
 WmUvKolLxNzu4IGYyfkykpgvmbBeZq36AZLKyugGZiKD8w7JPABEsUVPmYGfJU8zI1CY/iSqT0U
 V8SZAeaZa0jqb2wghPzskkUKEs6msA6jbQVQsYTsAzXkk3IqV2VOZqu4r9NpO8hkwe3hXenyca/
 oa1H3AYQnOn1e8PI+DMpyAFblQGWAWEYAQFB0Tw97pZl+wCd54kS4zaeKGKDOHMerkPKJPOGz02
 JtvxpUEXPydXGGwjgKYbS30HkNmm158mlWk0ozFVAy5ycmzANYz7zlnLqwGnBChZzEohmMIBSca
 R0IKkCroqwsfXJvIVLq8vgjaxqiOWz2yHtdsD52R5ObbSQAQRj3RIw2KN4Z+fIz9y8Mdpk6MW4q
 EkuNjeAfk8y+AKLKvIq4aq5i/jvM0iMfGHsSgEGFoXPWylnRHX4hhMZh880/Hmzq4xo3LjTUYlx
 kC07O5C/eTmz63w==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Add a SPDX-License-Identifier to the 88PM80x onkey driver and drop the
GPL boilerplate in accordance with current kernel code guidelines.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/input/misc/88pm80x_onkey.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/input/misc/88pm80x_onkey.c b/drivers/input/misc/88pm80x_onkey.c
index 31f0702c3d01..4b0685f96113 100644
--- a/drivers/input/misc/88pm80x_onkey.c
+++ b/drivers/input/misc/88pm80x_onkey.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Marvell 88PM80x ONKEY driver
  *
  * Copyright (C) 2012 Marvell International Ltd.
  * Haojian Zhuang <haojian.zhuang@marvell.com>
  * Qiao Zhou <zhouqiao@marvell.com>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file "COPYING" in the main directory of this
- * archive for more details.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/kernel.h>

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240121-88pm80x-onkey-spdx-27c059f68884

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



