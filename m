Return-Path: <linux-kernel+bounces-67681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EA4856F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560A8283644
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E74F41C61;
	Thu, 15 Feb 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byb5wA+J"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A5213B2BF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031123; cv=none; b=Lov7t1m5om0HT3P9T9bgJVMYf2ZekUo1vzxPiXxov1w9oHU8WvUei+or1WvbLGsYKAF7I2hbz937p+A7xHuwP9PMnQdBORz9MHRQAQjPnjAbDtaXFAgjP0KEQ2HsOW9ajVokTNyXPenK3LAmWI8+AkLiCvAunXidQr2ajYE6ew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031123; c=relaxed/simple;
	bh=aMOIWeOt1jD9bnQnQmZK1m4Ewkdfriyjv1XCNsipuyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ab2xRcOw2lezg0Q/Z5QdceUj39iz0RTH22bOx8qHp7ek+lWdFdXn8HzRXvs5hNp33zpzDoh9L+wTmqUPqMD0XlWyS+oyH05ep4+YaujdEgXfNWaVefpcbv3THLOmS16TQGU/3GnSPHQ6ZCRcYhogQ58wtoWOpLIrKy319UtgmvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Byb5wA+J; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso61877a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708031121; x=1708635921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbAHpNS+oOLTU8LAj4t0HslhUKwQH1LKk3gZ3VuSClk=;
        b=Byb5wA+JqjWnkgnRts+lSag4fj/lu+6CTrLKONoK7d/Gfkpop5hPHUdy22W4G/1vyS
         spw00vq89Feo1CHo2pHp5TQ/XA9a4SDe4rSdlRCOfM48W0GtfJC1KLw58tGWkaiJasS7
         gdj0flU1z58SwVMbbnWJRJTLn5dIwwlAv8ZhEdHnXrYmxbdQJfDdgOwVc/yhTFHBLCdp
         TRVtzzbfV7OlRfpiLe9BDnmZKPIdWXZOwC8Peejtqhp9vkiYHCJp23UBZenGnU97bneD
         892TmBLPcRBWNlVDwCZON8bPjDTQa062Tr+9KUWyT6StjIJsvl3r2LQbp+BU2ngE9Net
         uOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708031121; x=1708635921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbAHpNS+oOLTU8LAj4t0HslhUKwQH1LKk3gZ3VuSClk=;
        b=HfF7nriIAPDL8EPYCueIPaTHcBJZ+gwMix2hPWaOjuKoS/OfLp/rA/qF7gZM582Qsr
         6E5m/iBIb/FMoaRfhoVWolaGgqtFXhxhVs9xmvkF1pJze0fZiznBA71OiqvV5LI/s1HB
         QrHG0Eq8b7VqAOW1heRgijF9QmuHj96lAFWp+gsPZ9TwVkN5rufkGzTxizlzWFxDOpU5
         bRkS2u17zuMTdgIPzn/fsgFoVwFzduCqND+FELYedrXt+6HO1FpVEC+bVCIgkAryIWlD
         dUtWHUUyHAviecOks7foD6/oael1WCups6aWgvxDzKGjUiRNPo8HoWti8cjN+OuPzCt5
         s3ZA==
X-Gm-Message-State: AOJu0YwANYWvY9iZRYPJaA+tEG5wL4rpjvt5fEMQYN5ar4Pe/eA5DoO9
	okoG8dDHZ8yhKBkv1aNzqdaZOl2FC/GmtCMeWabs8ncqt3rpnFpickO7gOTB
X-Google-Smtp-Source: AGHT+IFu1e1GtjkpY/Ca22fHI2I9uZRfm6w3oOxLdm0dTC4dTB5bTHoZPfzj33IZsly09qCGn6w0rg==
X-Received: by 2002:a17:902:8c96:b0:1d9:df95:89dd with SMTP id t22-20020a1709028c9600b001d9df9589ddmr2819585plo.47.1708031121123;
        Thu, 15 Feb 2024 13:05:21 -0800 (PST)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:3772:8174:2d71:3b60])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709026b8900b001d8d90d4f67sm1677783plk.249.2024.02.15.13.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 13:05:20 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs_io: add lseek command to execute lseek()
Date: Thu, 15 Feb 2024 13:05:17 -0800
Message-ID: <20240215210517.2383647-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Added lseek command to support lseek() for SEEK_DATA and SEEK_HOLE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: add SEEK_SET, SEEK_CUR and SEEK_END
---
 tools/f2fs_io/f2fs_io.c | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index e7d286a..a5e151d 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -1630,6 +1630,52 @@ static void do_removexattr(int argc, char **argv, const struct cmd_desc *cmd)
 	exit(0);
 }
 
+#define lseek_desc "do lseek for a file"
+#define lseek_help					\
+"f2fs_io lseek [whence] [offset] [file_path]\n\n"	\
+"Do lseek file data in file_path and return the adjusted file offset\n"	\
+"whence can be\n"					\
+"  set  : SEEK_SET, The file offset is set to offset bytes\n"	\
+"  cur  : SEEK_CUR, The file offset is set to its current location plus offset bytes\n"	\
+"  end  : SEEK_END, The file offset is set to the size of the file plus offset bytes\n"	\
+"  data : SEEK_DATA, set the file offset to the next data location from offset\n"	\
+"  hole : SEEK_HOLE, set the file offset to the next hole from offset\n"
+
+static void do_lseek(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	int fd, whence;
+	off_t offset, ret;
+
+	if (argc != 4) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	offset = atoi(argv[2]);
+
+	if (!strcmp(argv[1], "set"))
+		whence = SEEK_SET;
+	else if (!strcmp(argv[1], "cur"))
+		whence = SEEK_CUR;
+	else if (!strcmp(argv[1], "end"))
+		whence = SEEK_END;
+	else if (!strcmp(argv[1], "data"))
+		whence = SEEK_DATA;
+	else if (!strcmp(argv[1], "hole"))
+		whence = SEEK_HOLE;
+	else
+		die("Wrong whence type");
+
+	fd = xopen(argv[3], O_RDONLY, 0);
+
+	ret = lseek(fd, offset, whence);
+	if (ret < 0)
+		die_errno("lseek failed");
+	printf("returned offset=%ld\n", ret);
+	exit(0);
+}
+
 #define CMD_HIDDEN 	0x0001
 #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
 #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
@@ -1671,6 +1717,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(listxattr),
 	CMD(setxattr),
 	CMD(removexattr),
+	CMD(lseek),
 	{ NULL, NULL, NULL, NULL, 0 }
 };
 
-- 
2.44.0.rc0.258.g7320e95886-goog


