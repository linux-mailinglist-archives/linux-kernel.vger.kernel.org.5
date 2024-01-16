Return-Path: <linux-kernel+bounces-27273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7775082ED17
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A641F2185B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C36A1944E;
	Tue, 16 Jan 2024 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8kYel86"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0064718ED9;
	Tue, 16 Jan 2024 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso21142085e9.0;
        Tue, 16 Jan 2024 02:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705402295; x=1706007095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QmW3E1M++L+e6C8eJiaAiTpNXnV9f8Z6oWcF270MPX8=;
        b=e8kYel86+UXggl7qe9PXaB+qHYnCSKK/K0eIwjs1il8+HYc6+dRo0xevRzCbSAM9pq
         Lz2EF1+xr3gkS6UBVHpzmuVbM+k4OlDbC19TTpxAKf/MTgMICqP7981etJqxPz9nnuaP
         YnHREKbuC/nxHqeZepGTSr37UaLXzo/vjx1RooFgXvtn736XlShVv02dznYM3vMVptAB
         AG1MzFVinomd4MLr3XPbLa9RMID4kCa1A+Y0o0zMKkexnqTK7hYysc+NUJLnotyxXKGA
         pYRMM3NZW7Rk/SoHoMgLPWShpnEGEqhTgmTwiRKcuWW22aLYtr9ZlshVAvtDcimt/eYG
         eRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705402295; x=1706007095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmW3E1M++L+e6C8eJiaAiTpNXnV9f8Z6oWcF270MPX8=;
        b=liUDg6fWqiRtn/77f+uR5hrDzDkeA8J3Vb3doaXlJE9aZ2d5motFCN6hrwXqdBNy8J
         yUOX8+Z6rSme7DiaO6GBegznfvAbSRKSZIGZUIP0ACTMAa1IXj6kfdNKdii34KaEk03H
         k1TxO8VYAyUMEIQc+CKrBR8MVdm3ZhvUk2BaOoNlN/Kk1jrznXTaUcWekj+z0mi61W6U
         QD5mVtHkHhhOiPTmVgFvMBAnyAX1RlxF6QpUAZMaiU2Wc6JOH6gOfpJd4pplKLCKs/SQ
         FLpx4uYab71Jati3oAx9ZLkxlU+yd9mM6xtXibboYDOLV56HIkd7AZEkgyfrRjI1lgWH
         WX5A==
X-Gm-Message-State: AOJu0YyDJTZhGLWm++t8S5nEBnH+/eMkuvzr7C0KMki3fOZSRiVZavE2
	VuRhKdFBruvU2UvFmUYG8H4=
X-Google-Smtp-Source: AGHT+IGsRM2SQvZwTko+3YSCVvtjJBo13ZTflclOl7C3d7usUv8K2vrGo9hRAFWuejKivQmhjFmcnw==
X-Received: by 2002:a05:600c:1310:b0:40e:4a58:3c1c with SMTP id j16-20020a05600c131000b0040e4a583c1cmr3706765wmf.154.1705402295001;
        Tue, 16 Jan 2024 02:51:35 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g7-20020a7bc4c7000000b0040d5c58c41dsm18400875wmk.24.2024.01.16.02.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 02:51:34 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] cifs: remove redundant variable tcon_exist
Date: Tue, 16 Jan 2024 10:51:34 +0000
Message-Id: <20240116105134.2245640-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable tcon_exist is being assigned however it is never read, the
variable is redundant and can be removed.

Cleans up clang scan build warning:
warning: Although the value stored to 'tcon_exist' is used in
the enclosing expression, the value is never actually readfrom
'tcon_exist' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/smb/client/smb2pdu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index bd25c34dc398..50f6bf16b624 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3918,7 +3918,7 @@ void smb2_reconnect_server(struct work_struct *work)
 	struct cifs_ses *ses, *ses2;
 	struct cifs_tcon *tcon, *tcon2;
 	struct list_head tmp_list, tmp_ses_list;
-	bool tcon_exist = false, ses_exist = false;
+	bool ses_exist = false;
 	bool tcon_selected = false;
 	int rc;
 	bool resched = false;
@@ -3964,7 +3964,7 @@ void smb2_reconnect_server(struct work_struct *work)
 			if (tcon->need_reconnect || tcon->need_reopen_files) {
 				tcon->tc_count++;
 				list_add_tail(&tcon->rlist, &tmp_list);
-				tcon_selected = tcon_exist = true;
+				tcon_selected = true;
 			}
 		}
 		/*
@@ -3973,7 +3973,7 @@ void smb2_reconnect_server(struct work_struct *work)
 		 */
 		if (ses->tcon_ipc && ses->tcon_ipc->need_reconnect) {
 			list_add_tail(&ses->tcon_ipc->rlist, &tmp_list);
-			tcon_selected = tcon_exist = true;
+			tcon_selected = true;
 			cifs_smb_ses_inc_refcount(ses);
 		}
 		/*
-- 
2.39.2


