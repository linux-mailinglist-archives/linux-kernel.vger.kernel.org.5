Return-Path: <linux-kernel+bounces-30499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9550831F84
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6A51F2885A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6772E401;
	Thu, 18 Jan 2024 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXZmjKD6"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2498F2E3F9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605475; cv=none; b=Xt38BBvS/1XwW2VDbBDdD9kEM4MmLxBkJ2uzRnBL4TsDfo/KGJCa5ATzxfsEzOY0h3KUgxXa38EeBS26GLYJVOhj2PPcTDyHt5wn5k4FvZkLzyv0twWJy4K1wB6uLUFCOSlGdJh0/6W3LY/egUKsO6Y/LEPZqY3R93paflhxoO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605475; c=relaxed/simple;
	bh=U74K1kY2dyd5hSBstEhod90EVhWSL5ywn5NpSDxh7c4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CoQduO1SuIQ6ahAYoS8k7SrkLiSoMSbD9iYmKJwSx095WUMBqi/MlTrAy8kgLLcQwVX6RBzQEb+yfmmSfist+IvjzZPlPsyYcdlDzjAsa/KlB1tREfLTwY1JsBJAPpxzzixfqRPS5ozApjzSSJltcbkeXfDraqJkUwhyFnP4wio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXZmjKD6; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78370566ae3so170185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705605473; x=1706210273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+QqmfYbfkxReSZlnA0Rop1TbT1YTY/BIoy1a4nhbFg4=;
        b=fXZmjKD6Z9WHoINhGVd1ujQcXjK1EcK/zWD0jK9JeDTM5Oy6lTqeKZ/m8LJtSEegeA
         hC+BJMSqxrp3eh/fOT5+6xFmZwWpjzgzhXtVBFBJZ7OGsVm37CkbJbWlvSord7h1pdAS
         DCE8q8R5abmzDpS/arojPFa2TFDVnvevgVuHGiNo7u4VrzWBwVCL/Mi4uBk6oS7+i/wR
         nYJ5OHsUSlcYkD14Xcy8INe41hjECfMILQVBZunywDb0DLnw2f7G6EPL/lFySgd8GXDw
         OLcAmEKqstFi3RfJ7Y2FK+pPZ4p1BN48G0z/5OyY+h8qyfRdK1T4U//tj/8/ORTQoyxd
         YA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705605473; x=1706210273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QqmfYbfkxReSZlnA0Rop1TbT1YTY/BIoy1a4nhbFg4=;
        b=cmn6qXSa3NYJdyB+Ok/x3SDEno0ar8m5HJgCzdYIRMNlUK9gZAcyJkbt8Q+1J0Mtxm
         mlqa03CX8roVtNrCj4axNiHzEJOwxuWAiOpYaKdGiJ778M3M8h7PaHt1hB17BdSDgnLO
         kwEneYFq+AbFBzm4To49rZNtD9dKJc1criQG+EkMOo9NK+cGhvzZlsmZ9rvrY6GNFfnW
         G9CmHbXyT059EoXZ4wf+pNxpkujJK3oAjBi2jdJT43xB8nT4D2NimmwvEwlwPbLYzL/G
         QPw1FtKYGx4pJ7wBmiD3uCGoz8RbLOjxRjcD28wenv4lqhm7zSXZvp2DYTligyJ1uQHh
         OqdQ==
X-Gm-Message-State: AOJu0YzsQ2/QCCctwOoj7n2Dod//5d1IR9NN7Qxi+F8Gxy5tJrtmvewv
	PYykeIhBdiE9SLjsbCPHyyyhc0Fy2G4rxRDxNxdVkObQmA2ibcNT
X-Google-Smtp-Source: AGHT+IEb91YYCfcYQfOZMQ7J1lypHUmBWTsBrt2DsHYjfZ5XQJgJkP+UK/FcAq+zUwbeP7RGZvAJgA==
X-Received: by 2002:a05:620a:6881:b0:783:843d:df5b with SMTP id rv1-20020a05620a688100b00783843ddf5bmr266388qkn.7.1705605472745;
        Thu, 18 Jan 2024 11:17:52 -0800 (PST)
Received: from me.mynetworksettings.com (pool-74-98-201-227.pitbpa.fios.verizon.net. [74.98.201.227])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a081000b0076efaec147csm5461145qks.45.2024.01.18.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:17:52 -0800 (PST)
From: Jacob Lott <jklott.git@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jacob Lott <jklott.git@gmail.com>
Subject: [PATCH v3] staging: rts5208: Add more details to Kconfig help
Date: Thu, 18 Jan 2024 14:17:04 -0500
Message-Id: <20240118191703.89535-1-jklott.git@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current help text is short and triggers a
warning from checkpatch.pl. This patch adds more
details to the help text which should provide better
information for whether or not to enable the driver.

Signed-off-by: Jacob Lott <jklott.git@gmail.com>
---
v2 -> v3: Fixed spacing and newline in text
v1 -> v2: Corrected line spacing based off feedback

 drivers/staging/rts5208/Kconfig | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/Kconfig b/drivers/staging/rts5208/Kconfig
index b864023d3ccb..c4664a26ba3b 100644
--- a/drivers/staging/rts5208/Kconfig
+++ b/drivers/staging/rts5208/Kconfig
@@ -3,7 +3,11 @@ config RTS5208
 	tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
 	depends on PCI && SCSI
 	help
-	  Say Y here to include driver code to support the Realtek
-	  PCI-E card reader rts5208/rts5288.
+	  Choose Y here to enable support for the Realtek PCI-E card reader
+	  RTS5208/5288. This driver facilitates communication between the Linux
+	  kernel and the Realtek PCI-E card reader.
 
-	  If this driver is compiled as a module, it will be named rts5208.
+	  If you opt to compile this driver as a module, it will be named rts5208.
+	  Selecting N will exclude this driver from the kernel build. Choose option
+	  Y if your system includes the Realtek PCI-E card reader rts5208/rts5288.
+	  When in doubt, it is generally safe to select N.
-- 
2.34.1


