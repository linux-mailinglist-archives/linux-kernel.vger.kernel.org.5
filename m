Return-Path: <linux-kernel+bounces-12851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AE681FB23
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C152F1F213E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516DE12B8D;
	Thu, 28 Dec 2023 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIrzgjlZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF8212B88
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so2262932f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703794214; x=1704399014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oECceprFb2KNEzYP8RH01DnjdoH0LhR2UkPhqrSnzSo=;
        b=lIrzgjlZy0Cgup8nkw3DCqRQxaN0gKHdnjDqWHFoQ6iNcVg2BXktGpmoYp7zsAhznW
         pHvxIEIo8x2FtIFk5eRVVwF4ExSv7bY3xWlkcuHRWSmL0BTu2LEcDp2VBCr4QUxwExBx
         B3CQk5tRm+mhvnEbURimlyvgPx1Who3z47hXKjxThnnyNZu8FELfTgQ8jfo1yuqDTq4N
         ov8p+Bi16EIfYGUR1V7TJiip5YkmGy5v8PY2OhZPp1X1FVZCbVypRZcTjGPxtNL5cgC+
         uAgxIiiS2l8rzPG6IwshoEy17/aLJ0dbDVj6zj01dubZMwrIY3feV6AGhZ9eodKu7q7E
         ioFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703794214; x=1704399014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oECceprFb2KNEzYP8RH01DnjdoH0LhR2UkPhqrSnzSo=;
        b=QVmv/piwOv23jG1fx+lir1W+azftEBiXyDQECuFDFN86iDhhzNMvRO9C2sd0HuMgxe
         h7V9lvHXr/Y//tHdNk28vN0WnkR4LansCJc/Mn0djuqJu35v69Z6eVnkALfmfTXT3osH
         /HV5w57E3Dr0gsyi2zD/SsSHYaqQdC6wuBC+fOuG2N5jG/8p7wq/H/Wem6suX/e21sr4
         JC8q/p3bRM7m+qvTCeCM5Co2+I3EswO4wJm/aM6pS4SeOk4Gg9NJDtXF/oPKXmN1kana
         D97AWAXP9ES3oYWIUy1jFwhjhoM23ZyP7TxXPRk13xPrqltaYEb2FZQkb3RxxKBPzM8i
         xouw==
X-Gm-Message-State: AOJu0YxQ73ZTntRVcZFeNBrjK58tUHhqcMAwHnoWNHL7HneUtAMUOR2F
	mHUVSX64YM+BzyZlUDbvxuWyc4u8ntkEVw==
X-Google-Smtp-Source: AGHT+IExRQrQovdpGcDcUmD4bR3U446pNyx1fDJZ4/14t7bz0ut4efrxFfNB4yT4QEOFiWTxEVPEqQ==
X-Received: by 2002:a5d:4565:0:b0:336:7ff4:aac4 with SMTP id a5-20020a5d4565000000b003367ff4aac4mr2417673wrc.265.1703794214242;
        Thu, 28 Dec 2023 12:10:14 -0800 (PST)
Received: from localhost.localdomain (bl17-216-113.dsl.telepac.pt. [188.82.216.113])
        by smtp.googlemail.com with ESMTPSA id y17-20020adff151000000b003366aad3564sm17833531wro.30.2023.12.28.12.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 12:10:13 -0800 (PST)
From: Malkoot Khan <engr.mkhan1990@gmail.com>
To: riel@surriel.com
Cc: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org,
	Malkoot Khan <engr.mkhan1990@gmail.com>
Subject: [PATCH] ipc/util.h: Move opening brace to next line for function definition
Date: Thu, 28 Dec 2023 20:09:56 +0000
Message-Id: <20231228200956.112682-1-engr.mkhan1990@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux kernel coding style prescribes that the opening brace '{' for
function definitions should be on the next line. This patch adjusts the
opening brace of a function in ipc/util.h to conform to this style. Moving
the brace to the next line rectifies a coding style issue observed during
review and aligns the code with kernel coding standards.

Signed-off-by: Malkoot Khan <engr.mkhan1990@gmail.com>
---
 ipc/util.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ipc/util.h b/ipc/util.h
index 67bdd2aa2c28..94c167847628 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -244,7 +244,8 @@ int ipcget(struct ipc_namespace *ns, struct ipc_ids *ids,
 void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 		void (*free)(struct ipc_namespace *, struct kern_ipc_perm *));
 
-static inline int sem_check_semmni(struct ipc_namespace *ns) {
+static inline int sem_check_semmni(struct ipc_namespace *ns)
+{
 	/*
 	 * Check semmni range [0, ipc_mni]
 	 * semmni is the last element of sem_ctls[4] array
-- 
2.34.1


