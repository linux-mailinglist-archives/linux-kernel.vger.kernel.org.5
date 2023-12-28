Return-Path: <linux-kernel+bounces-12400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DEC81F447
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0C51C21844
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE4815B3;
	Thu, 28 Dec 2023 03:09:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 09B8B10F2;
	Thu, 28 Dec 2023 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 568476019ED87;
	Thu, 28 Dec 2023 11:08:55 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?kernel:=20capability:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20ret?=
Date: Thu, 28 Dec 2023 11:08:54 +0800
Message-Id: <20231228030854.11689-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ret variable is assigned when it does not need to be defined, as it
has already been assigned before use.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/capability.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/capability.c b/kernel/capability.c
index dac4df77e376e..ed8a983e21da4 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -140,7 +140,7 @@ static inline int cap_get_target_pid(pid_t pid, kernel_cap_t *pEp,
  */
 SYSCALL_DEFINE2(capget, cap_user_header_t, header, cap_user_data_t, dataptr)
 {
-	int ret = 0;
+	int ret;
 	pid_t pid;
 	unsigned tocopy;
 	kernel_cap_t pE, pI, pP;
-- 
2.18.2


