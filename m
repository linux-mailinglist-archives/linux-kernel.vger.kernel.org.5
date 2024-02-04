Return-Path: <linux-kernel+bounces-51597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F33F848D09
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E441DB22990
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C2D21A1C;
	Sun,  4 Feb 2024 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3P3C7iq"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850522137A;
	Sun,  4 Feb 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707044785; cv=none; b=K6PNf0zqiUKnPQ8sRaUrqfSjkgtM97armXNbznsUqgX+DF068ePdYSngtgAV/BmhEeLVXw9lGbw2gi+GiCtpscuh1cznVDLjN+EqMEoAjthBH1/q0gcZ4J9nk9sZDWhft1Vo14JHIRha8xZ980ECakuTbqvoHo3VYgFTr5geuJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707044785; c=relaxed/simple;
	bh=qYMfr5XdU8wnfObBkptjGfUmtNKpQZbnQkHY+J8xNxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rCywHTMmQx/6BMlGPykWwXxpNxDYRyZTWuURAF8enSHEj6gwyPhEhp3cESOlRvR/uya3t6ltuuJMW31MuzdCTnRwrg3vxCaUaWIJH45/9CrAwQMzCHJSyZT4YVoGVlVso1xgWWZMwwB/uEJ3gEe8YToT2vbwftjMZ7GT59Tm73M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3P3C7iq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d751bc0c15so30412975ad.2;
        Sun, 04 Feb 2024 03:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707044782; x=1707649582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jFC3FYaDvYaAQ3PAKsfJ4Lq2XNibWfkQG12CMQWzbDQ=;
        b=D3P3C7iqb2bRohgGrxOys8NqvNNu4kA6w8CWENqS7l/Jec5KwfK3ufDygAQdWsIET9
         r97VKbPezP+bXAB9VXDVEDVIuzvFe+p5pMJqgQDwzM3G514/OpQiyAux3Um9OlF/w59S
         pETj6iuoBkBz7tTOSJpYxFPKDcfeRDvaG11j7c6Wx1GBXaF51KxjNRDViB0oN8LJvaPJ
         y7cznFGcoCDTUkYeln7MNlvYWoBk9HY1GXCMT61krfHYPZtVIYSmF3kX+fZgt1z17dn4
         dW5DE89uor3YRJx7Z7fZgmHlun9KzcMu2QIlCQBcukqJXniW/GtY5sQyZEnOoH1XcNU1
         XPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707044782; x=1707649582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFC3FYaDvYaAQ3PAKsfJ4Lq2XNibWfkQG12CMQWzbDQ=;
        b=ibT+wO0HJxkq15og6Y295uEo9jyFPSCqVYrVbJ3O9pho2O42isk1DStX3D6KoF7uXT
         OVdDg89lYBvQKoHCSZF3laaprahRtfallpMdPcVm7pHyuGOf0kKAF+KnhlDysZ+b/MgQ
         dCntMf197IxgB60d4rHaIvvI+gMAzDziEWBrrTgjO9hP+AfKgqArMpdPGTGZDa6ErueO
         fp87vKVn5zx7FNtjS+r1Hp5Mjqxxm9KhNfXGNCZ7jHBYsgvx8YNDm92sC1hQ/w5koS/Y
         becSizs8obZ8YiQNo7NcdekQtc2q+7v8SVMBAvwmKNyBnNTBD/fFgL5udoaAwBCDyr9Q
         UmJA==
X-Gm-Message-State: AOJu0YzhpZgkPnotzmlVL43tU78OSEhJ2ZRL44oqjltUhInpsXPMGj0V
	zq2QMErSWMJaVWVuV+9aV/8f2cnZBNIUQapqToVWca0HZFHkdrlR
X-Google-Smtp-Source: AGHT+IHTcC+lNyISJD1nDPbEX5waCxGPSwuScQMsamCmjLMoe8bzHwer25GauMjxpD7yp57ghsIUKQ==
X-Received: by 2002:a17:903:248:b0:1d9:1359:75ec with SMTP id j8-20020a170903024800b001d9135975ecmr16720239plh.30.1707044782652;
        Sun, 04 Feb 2024 03:06:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUhub+o1uLlu6ppy4nncTJ3sEfp2Lmd1WGyds8o7Bva2aBfCRrnLpbk5ibe6xGsnSsDe2dU3Zyk/XdrN19poDrHUBaDWy5lkc2rEN5cyBzbwTTPWto6s22lEtlNgRwEzcduthNVlZ5QRaExky0Ko5ylebNc4dYpwInqGfddr9rjEcyQ6EZUUHkuCi9DJJvRb/UhbZHZjTaGNmbE/XqsBP1ZsMAVmy04kbp1PUX5ri4PtVzt1KHTJ40V8fentFZWIPdV+jdSRZGVweyY2PG4jFrXkjmnVlgaaTVZo8cExemn+p0ha2HwBovVGTL4Kmth50AIDQhGY3J5oNhKnZrsZQEFxYhZfthzWufhSi/yYsOxrG27pznfOt0pEWQ6OB/xpeQnNj/Y5WchxquDJadYjwfRyj8OkCYiC9Z1NMCh5+DQBWkiyeiD/ihWGhdjtfCxtei0RJkPDZ5KHeQwYYru4VsStZTOx9fpHoUmImtmscvTg8Q=
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id u3-20020a170903304300b001d706e373a9sm4390561pla.292.2024.02.04.03.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 03:06:22 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1E005184797C0; Sun,  4 Feb 2024 18:06:18 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Michael Roth <michael.roth@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Peter Gonda <pgonda@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] crypto: ccp: Fix sev_issue_cmd code block
Date: Sun,  4 Feb 2024 18:06:04 +0700
Message-ID: <20240204110604.192024-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1809; i=bagasdotme@gmail.com; h=from:subject; bh=qYMfr5XdU8wnfObBkptjGfUmtNKpQZbnQkHY+J8xNxg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKn7865G/gg4N3PD0/JeH8/OvmceYekRj18tFznxlC8lm bmoTbGgo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABOJWM7I8DwwkG/bN/m9B1hn yyT17sg73HRvbf3KyWttC+XnyodwpzMyXGP+a9brvaxFIKQx4U38vCbp2MWc1VN/Kpj0/fURqMl hAwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Stephen Rothwell reports htmldocs warnings when merging tip tree:

Documentation/virt/coco/sev-guest.rst:75: WARNING: Inline emphasis start-string without end-string.
Documentation/virt/coco/sev-guest.rst:78: WARNING: Inline emphasis start-string without end-string.
Documentation/virt/coco/sev-guest.rst:81: WARNING: Inline emphasis start-string without end-string.
Documentation/virt/coco/sev-guest.rst:83: WARNING: Definition list ends without a blank line; unexpected unindent.

sev_issue_cmd struct code block has unindented block marker, hence above
warnings. Fix the marker by appending it instead at the end of preceding
paragraph to silence these warnings.

Fixes: f5db8841ebe59d ("crypto: ccp: Add the SNP_PLATFORM_STATUS command")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20240202145932.31c62fd6@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/virt/coco/sev-guest.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index 14c9de997b7d34..ab3ccfd5b54838 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -68,9 +68,8 @@ counter (e.g. counter overflow), then -EIO will be returned.
         };
 
 The host ioctls are issued to a file descriptor of the /dev/sev device.
-The ioctl accepts the command ID/input structure documented below.
+The ioctl accepts the command ID/input structure documented below::
 
-::
         struct sev_issue_cmd {
                 /* Command ID */
                 __u32 cmd;

base-commit: 00bd91c99f9e8b4bb6b65c45598fbf426e1f1b53
-- 
An old man doll... just what I always wanted! - Clara


