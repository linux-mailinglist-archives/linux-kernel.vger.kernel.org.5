Return-Path: <linux-kernel+bounces-41917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EFA83F991
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDE21F219BD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C223BB3B;
	Sun, 28 Jan 2024 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXG8zA/D"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD1C2D61A;
	Sun, 28 Jan 2024 19:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706471863; cv=none; b=bTMuPxgWaJrF+tjXWg3v/yAuku8FveUSvR+54Ug1/rN3CKw/jcHj+l3U60DZ8bcml9sGKTNlZSGNw1udXr2xdqDw/NVFcJ/wjP568VESUz2NUAuJD2BLN5AwzoYq5DQGdVCl5L9UmjRNdxL/kVYSHnDb9lGrp/Wo5tP+C9AVgPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706471863; c=relaxed/simple;
	bh=/QPR/qDfKOcrRm87Xiko56xF+rk8CX4zS8nZ1M+uiRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DueldzJyyUsRzLoZMK0PoKXdtvh2YrUZzK9dnN/jQP7PTi8xRi2ugujJPafPBscCLPqUoVHEJ5GDd4U2BzVwklJueFIrNJcuNXMEBrexc6uVHlTscbvBLtycigvb1/gLSHwPGCVfA5oNfBdRa618CYQcGbGwbFDauO9qbIWexVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXG8zA/D; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d76671e5a4so15934305ad.0;
        Sun, 28 Jan 2024 11:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706471861; x=1707076661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W5rvBIjZB6f/l7eWENYMQezAWoxVgyOQwzg5bdH8Pi0=;
        b=BXG8zA/DhJLW5CZCfCm+gs3W6vs+2j7OAZhAaS4ZKmHSCfAoqGjppCiQhv6meS3Aqy
         c7DjeP6Js7AEMr54rzi5FMforfWNTB7bV2wVJHBu3BP4k7kcDuTRuqpNFH0OaWzPjylG
         wYrE4KAu+hEh5ykJdf5haVqJFRRRPQGN8EzfkjgGn3xhvVSGyLlY81oNJ7Bf0b+oWF4S
         kXgutm7PRZ9q21JL1rRQLvJyPlx0FwcUmTxyefbhrNwUYFq1TYWzYQgCcW9P5m+aVfy6
         qFdRSD1iMWDZudLKdlHMt7k2/hYMe4S8wN4qYNmCQd+i0Iv2FPeXcMDEUjwCfFsrcqQE
         hEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706471861; x=1707076661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5rvBIjZB6f/l7eWENYMQezAWoxVgyOQwzg5bdH8Pi0=;
        b=qEXigE0DOqaOvAxTU8+dUnCltn//2hnRxoK1mi+gq5ggl3H5qOkHIVP20qkUG18p+d
         X3srX4xvatVw9A8MosX6U/xXe9rYEBPeOlb+KvK+L7u39zW7Une8W6e2dPeAwhXRxKyZ
         TzOHOvO34GpEQgC/QWKiApr8oanGCEvVVCQYXTP+CPkdveDfDAeMIVTbm+UFGQ9ELtxD
         gOTVV4m1SYfuG+LQrRJphv2ChTMJU+NtSpZ0N/OHCb3K3RAj+a1F2gyG/n3sLPVhyA/D
         onFDCPlD1tP3312gXkvMukQDfUgX4PwoWeqxk5985qJ6KLDad5QktqK7OFi7pQzrvQcz
         2xTQ==
X-Gm-Message-State: AOJu0YzOLjza6ONDZvy9YVTn0K/5+D8gq7vjRQ5e4RVjUklAlseZQ9YD
	N/GHakGWW0EP2ndfBNaDV8IIrxr40jwubpkzp0cFdrwiuGaxNMT2
X-Google-Smtp-Source: AGHT+IF8LNP683ZdD/msPWljI3oDdXkEgvLJE+R0BVknqxo0xfx6cWTXK7UsQFjH7TI9GBziHWtryQ==
X-Received: by 2002:a17:902:7845:b0:1d8:ca24:d654 with SMTP id e5-20020a170902784500b001d8ca24d654mr2260474pln.100.1706471860894;
        Sun, 28 Jan 2024 11:57:40 -0800 (PST)
Received: from kohshi54-ThinkCentre-M715q.. ([2404:7a80:c880:6500:7f79:d78c:e8ac:f086])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902c98a00b001d5e340d979sm1113365plc.6.2024.01.28.11.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 11:57:40 -0800 (PST)
From: Kohshi Yamaguchi <kohshi54.yam@gmail.com>
To: gregkh@linuxfoundation.org,
	corbet@lwn.net
Cc: Kohshi Yamaguchi <kohshi54.yam@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH] doc: Fix malformed table in gadget-testing.rst
Date: Mon, 29 Jan 2024 04:57:31 +0900
Message-Id: <20240128195731.40003-1-kohshi54.yam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The table describing the NCM function attributes in gadget-testing.rst
was malformed, causing Sphinx build warnings. This patch fixes the table
format to align with the reStructuredText specifications.

The border lines of the table were not properly aligned with the column
headers, which was corrected by adjusting the border line lengths to
match the headers.

Signed-off-by: Kohshi Yamaguchi <kohshi54.yam@gmail.com>
---
 Documentation/usb/gadget-testing.rst | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 8cd62c466d20..1d1737f246df 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -448,17 +448,17 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "ncm".
 The NCM function provides these attributes in its function directory:
 
-	===============   ==================================================
-	ifname		  network device interface name associated with this
-			  function instance
-	qmult		  queue length multiplier for high and super speed
-	host_addr	  MAC address of host's end of this
-			  Ethernet over USB link
-	dev_addr	  MAC address of device's end of this
-			  Ethernet over USB link
-	max_segment_size  Segment size required for P2P connections. This
-			  will set MTU to (max_segment_size - 14 bytes)
-	===============   ==================================================
+	================   ==================================================
+	ifname		   network device interface name associated with this
+			   function instance
+	qmult		   queue length multiplier for high and super speed
+	host_addr	   MAC address of host's end of this
+			   Ethernet over USB link
+	dev_addr	   MAC address of device's end of this
+			   Ethernet over USB link
+	max_segment_size   Segment size required for P2P connections. This
+			   will set MTU to (max_segment_size - 14 bytes)
+	================   ==================================================
 
 and after creating the functions/ncm.<instance name> they contain default
 values: qmult is 5, dev_addr and host_addr are randomly selected.
-- 
2.34.1


