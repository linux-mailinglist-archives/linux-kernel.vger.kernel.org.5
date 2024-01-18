Return-Path: <linux-kernel+bounces-30332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1000831D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41331C23014
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2BF28E1B;
	Thu, 18 Jan 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T34mUrxK"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BABF28DCB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705594147; cv=none; b=SW2MDscyHCTAw1jiFeOx7pUevR3Ev4sDv6Lqc6DVo0Jtz1Ptc2ZdPgDwXKDNdoAYFnLbBIYCc5I/X/Rn8U7EOY7VjTaTbcku16YONGN9tvAnbnwgoR7obF3m2GO7auXBR7cvIzPx7CBu2jc+AG+JY9vNSbfJjz8FH40SrGsD3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705594147; c=relaxed/simple;
	bh=kHzuk/kNSL6JIRdg7lH2BgyUkGbVunML4qI1j50U/aU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=E7rkDHwjlXkcOQLnZHPBKlPD24OdWBhI2pqekID2NiDEW1YADLkkf2E1nu7C/IXHhkVJH3DSTnOmmlzbRzcHWHLgIts7uyqvs/GqgR9oCpDYB1uXzIJqalneGKNg/6nm9gY4Wlg5gUEID/zUUici5vSxVeoZRpr4YSxyI4jdGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T34mUrxK; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4298761b728so16802751cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705594145; x=1706198945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kDM781oFpgaSAT0QQI2tKSG6Pv6TalHpG0gxNI4eT4Y=;
        b=T34mUrxK9p/b7EaXg0Zf2KokQCrtlboryqCjf6NexicVwTCqleMS+Rm2YTSWxbVRlt
         TSKTOYsocg/aZ/QCMjwZRw8FtplNVjiGHdIIRuHdr2T6EaCRhQe9PGsGy3BGlN1b3gs2
         jmtxsl3Dt0SJZwbFBgfoV806Q2I1KJm/FD/E+3qzKKCIkcqn55nAAkPgj+ZXxIY6dGiW
         JS6SH7c/23/tfwIBOMUIx24yKHGJ6T4xGqdfD7uIaPS2dH1b1vCuptJEIf6+uFZs3rVA
         fQ5haCM5gXZIPcj28UAVZnPNz38+73pcH3kCmy08NWSV2SObhE633MN/+I5KwR1SbxSk
         kwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705594145; x=1706198945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDM781oFpgaSAT0QQI2tKSG6Pv6TalHpG0gxNI4eT4Y=;
        b=csq3OgqYjWpjsYtvw5U13LO1AilMD/ElqbMCPY+4XCbh0IstYNzmUHE52XIx7jWidD
         D75RbgW+kxluC5+XZG4EX02t3Fhx+6jMMdntCQzZACO4bO5X+SIFSPcaivyrInnQA6hM
         KJ8YSV6xS4wdgk9nJ54lPnjQG1Wqoh9GUxoSJRMktkLotQudpOd5hXbvf0a3Kj8SrMPH
         Rag7Ysoykj9WAAPqLNGe8vSd6eC/0GwFmOz3SEmm7fYRvPNXeB2D6nX52DbVoDqFyASC
         3x5R+3rtEiL1atmvXdOvEOln8NOQJi64e6K5fdS9CruxAnxdoBquMItLqu1GCx/7vPaM
         X9NA==
X-Gm-Message-State: AOJu0YzYHRVyJsc78N63/sWI4Tmg5XaXc/ypleSOLzY7Mn6sVezdRIgC
	I5a+CP64wFbHRmrSqiYeeHqCxnnjAeNdz3D0Tzw9frEFI+qZkCk5
X-Google-Smtp-Source: AGHT+IF0+tItICVcJXLHzZ8+UXQlKYxINubxeC3GTQ4wEZYESJxViQuSAVZO0+FI3GoxlJHS+PzTsw==
X-Received: by 2002:ac8:118f:0:b0:42a:1c4c:f662 with SMTP id d15-20020ac8118f000000b0042a1c4cf662mr1398446qtj.3.1705594145125;
        Thu, 18 Jan 2024 08:09:05 -0800 (PST)
Received: from me.mynetworksettings.com (pool-74-98-201-227.pitbpa.fios.verizon.net. [74.98.201.227])
        by smtp.gmail.com with ESMTPSA id fw6-20020a05622a4a8600b00427f89957d9sm6863013qtb.79.2024.01.18.08.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 08:09:04 -0800 (PST)
From: Jacob Lott <jklott.git@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jacob Lott <jklott.git@gmail.com>
Subject: [PATCH v2] staging: rts5208: Add more details to Kconfig help
Date: Thu, 18 Jan 2024 11:09:01 -0500
Message-Id: <20240118160901.71756-1-jklott.git@gmail.com>
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
 drivers/staging/rts5208/Kconfig | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/Kconfig b/drivers/staging/rts5208/Kconfig
index b864023d3ccb..4f9cc3f00e1a 100644
--- a/drivers/staging/rts5208/Kconfig
+++ b/drivers/staging/rts5208/Kconfig
@@ -3,7 +3,11 @@ config RTS5208
 	tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
 	depends on PCI && SCSI
 	help
-	  Say Y here to include driver code to support the Realtek
-	  PCI-E card reader rts5208/rts5288.
+      Choose Y here to enable support for the Realtek PCI-E card reader
+	  RTS5208/5288. This driver facilitates communication between the Linux
+	  kernel and the Realtek PCI-E card reader.
 
-	  If this driver is compiled as a module, it will be named rts5208.
+	  If you opt to compile this driver as a module, it will be named rts5208.
+	  Selecting N will exclude this driver from the kernel build. Choose option
+	  Y if your system includes the Realtek PCI-E card reader rts5208/rts5288.
+	  When in doubt, it is generally safe to select N.
\ No newline at end of file
-- 
2.34.1


