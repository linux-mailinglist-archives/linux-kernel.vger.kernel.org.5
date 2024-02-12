Return-Path: <linux-kernel+bounces-61709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BFA851598
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C841F2111C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F263F8C8;
	Mon, 12 Feb 2024 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN8S596l"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946513EA98;
	Mon, 12 Feb 2024 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745038; cv=none; b=HdxMnXSCEFsOYopW8rjH+UopR/ZX50j1RvgRroEdtk4tStFvKY2ecdnOPy7Smo3gJGA51vyJ78A322lZe8RqXWi6P1fFsY/NX0ud6WRCubgUEz+2dvLrjYsazn++gT5eTYv5NZ+lT/fc0XFfGNonDOGOIPkCcWhEWQLqEKKMJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745038; c=relaxed/simple;
	bh=F//opeBQLHL9vnvCVwkl/A7cs5ydPs9MIEctpGlDv58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fuke3xvykRigOMj7bxEwqvOpWjDZqJBp1wJxk62pZ0/0VFw+9fxeBR2wDd+BfRMLjGVQ4Owlrhe/BNmLYFfmjw3ZCqyLzoP5Wi58Wrv5HpainIG/7QtocWcgNq3l7U5XzOFrmVfcdaDdFt/tdHCUEq+hNlv60db93t8zXK6P+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VN8S596l; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso4422715a12.3;
        Mon, 12 Feb 2024 05:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707745034; x=1708349834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=laRfN/HWi9oFcahbxDTMU1nfn0SEB7plYdxrJOODhts=;
        b=VN8S596l9tykyZDuGE4KuoerZESQZP16PLr0jGr+uu0MONZMFXhgVJMGiU0Rxszfeo
         Al1n8enrilZ1+MocpvfJRCZqevhxTeq5XBjmyzJt4t+1t2NM7e+xMD66GMYtoILlGMAO
         nLknkuN+GoyXctrAobQA7uBD6UwV/IBkR/zehGknt8rt8y+CWtdrtx6IvUfOR4mwRSDS
         ZpHDDqGH2pF7Do3926meSLSWvF73sgQvJnbMup9xxe2tYHuj4lS+KA6ShMCV0uC8n33h
         TZBFI9oUGw3VP2ETMmou/nnb7NNbImDkYwJR3irp66HwlCQph8NnMlqQ61cy9QcgeDm9
         A+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707745034; x=1708349834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laRfN/HWi9oFcahbxDTMU1nfn0SEB7plYdxrJOODhts=;
        b=nXnMas1al353jIl6fwsTK2L6VSWL2io0/h5Xzq+HaJ6dRTzEVVNr3jMKFPtbxh4svx
         NBGPNybZmGB8pRxx3CWgs9syuY7ryXWI9HtqOGyKLJZymrYqK0Vj3mg/SfFXW1GwbVLF
         zkozd7G/VEEnusfr97oUQK/+0NIUmwKAvS11vmRuwNCkK5A3LysjeFyFrFaWruUQ33mc
         zQ7D9dzcc/ut6l+8FkiU9EVPdOr/01/44hrgXyvXMGGn8ubQ+wiuy0ge7zHOxfMS+2ma
         MiSCB/TCR9zDIhkkNm1UwXmV8jqko56DHnbHs2pr1JKXLJEjZ3vfvvNimSgWw2VHrTYq
         xf4g==
X-Forwarded-Encrypted: i=1; AJvYcCUj7j9I5KOrdAkrWVXMainLYgWXdx3qmYHh3PEZPwgRn/v28/lyIU9W3WDxl1L3NEwcbHtuLEnqC8TpQCR9uDc7ZHh3+j2qQTBZBD3bc2zpDZwj3ZPIi6oqw3yxCTnCE++PPaHGXcQ4jBE=
X-Gm-Message-State: AOJu0Ywgacedp7g49kKR8FsV8dCfesYhCJ1cQmVL3lpSbeutBXPVZ0Aq
	JCTsnlOVS7ZM1Gp3sdG6BYsXzkljARMxjwohI9vAHxEnPD0Kj8vDlHyrTJgEHQE=
X-Google-Smtp-Source: AGHT+IHClMT+6z/F2LOpPmY+C90cvi23oE87OBATifYkMwiSVZ7weG3wvapxuODx9ah9CqYEZSSRKQ==
X-Received: by 2002:a17:906:af94:b0:a2d:a6a7:b3bc with SMTP id mj20-20020a170906af9400b00a2da6a7b3bcmr4914263ejb.4.1707745033563;
        Mon, 12 Feb 2024 05:37:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXe432sCq8gKTTI0yG5pfLkQIYtqJ861AS8PZqUqhhYamDxyw7VdxiA2uix2eU872LkARzAtoE46oCSfAsRpuqm4Oa7niFQkv0IzqTpadWZ6HfO81nB7lzr4NYa94oJXYGqYev2IFT637FH4p/nM1HNZxXSlKg3qwgfsFA2YRY+l1lPcNqZ+baDql4Xb7RodzRqCAGV1yuVPh14jq+ZMQ==
Received: from pinguine.lan (ip-176-198-146-182.um43.pools.vodafone-ip.de. [176.198.146.182])
        by smtp.gmail.com with ESMTPSA id v16-20020a17090606d000b00a389838037bsm221777ejb.94.2024.02.12.05.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 05:37:13 -0800 (PST)
From: "Moritz C. Weber" <mo.c.weber@gmail.com>
To: marvin24@gmx.de
Cc: ac100@lists.launchpad.net,
	linux-tegra@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Moritz C. Weber" <mo.c.weber@gmail.com>
Subject: [PATCH] Staging: nvec: nvec: fixed two usleep_range is preferred over udelay warnings
Date: Mon, 12 Feb 2024 14:36:45 +0100
Message-Id: <20240212133645.1836-1-mo.c.weber@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a code style issue raised by checkpatch.
---
 drivers/staging/nvec/nvec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 2823cacde..18c5471d5 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -627,7 +627,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
 		break;
 	case 2:		/* first byte after command */
 		if (status == (I2C_SL_IRQ | RNW | RCVD)) {
-			udelay(33);
+			usleep_range(32, 33);
 			if (nvec->rx->data[0] != 0x01) {
 				dev_err(nvec->dev,
 					"Read without prior read command\n");
@@ -714,7 +714,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
 	 * We experience less incomplete messages with this delay than without
 	 * it, but we don't know why. Help is appreciated.
 	 */
-	udelay(100);
+	usleep_range(99, 100);
 
 	return IRQ_HANDLED;
 }
-- 
2.30.2


