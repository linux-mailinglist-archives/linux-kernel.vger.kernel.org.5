Return-Path: <linux-kernel+bounces-3345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786B7816B45
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33659282A25
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F0615E98;
	Mon, 18 Dec 2023 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2c5lkad8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43515E8E;
	Mon, 18 Dec 2023 10:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8454C433C7;
	Mon, 18 Dec 2023 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702895877;
	bh=ybyi1d3sA58qzNYwRDx5s0PVDcrLSSPeJQ7tCbKuzaQ=;
	h=From:To:Cc:Subject:Date:From;
	b=2c5lkad8kACJJJI37g5WeSrgyOFe/2iS/xgadTIM44wC2wEm3V0s1B/ONlsblIJB2
	 cVkePsv2YI+js31FFg728oqULtItVPowhhMAK42Sk3/zo4dAM1Fr3yVvvPP6yVZysl
	 LkJ/pOWCalyftakgJNnQNroHnr2OHIe3qTbLCUMg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <sfrench@samba.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	linux-cifs@vger.kernel.org
Subject: [PATCH] ksmbd: Mark as BROKEN in the 5.15.y kernel
Date: Mon, 18 Dec 2023 11:37:42 +0100
Message-ID: <2023121841-register-nutshell-9d6d@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 32
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=ybyi1d3sA58qzNYwRDx5s0PVDcrLSSPeJQ7tCbKuzaQ=; b=owGbwMvMwCRo6H6F97bub03G02pJDKkNCt//cFodfccw70tt3t72Kvvcf6vnR8U0V/72OVzqd s0vXfZZRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEyks4VhfjKbxM2L5xeK7Zg8 0+rIrejuX9NVLBjm6T6zZYqef3zfpG6tFSXxM1kC3dc6AQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Due to many known bugfixes not being backported properly to the 5.15.y
kernel tree, the ksmbd code in this branch is just not safe to be used
at this point in time at all.  So mark it as BROKEN so it will not be
used.

This can be changed in the future if all needed backports are made by
anyone who cares about this code in this stable kernel branch.

Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steve French <sfrench@samba.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-cifs@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ksmbd/Kconfig b/fs/ksmbd/Kconfig
index 6af339cfdc04..bc8b7fc8894d 100644
--- a/fs/ksmbd/Kconfig
+++ b/fs/ksmbd/Kconfig
@@ -3,6 +3,7 @@ config SMB_SERVER
 	depends on INET
 	depends on MULTIUSER
 	depends on FILE_LOCKING
+	depends on BROKEN
 	select NLS
 	select NLS_UTF8
 	select CRYPTO
-- 
2.43.0


