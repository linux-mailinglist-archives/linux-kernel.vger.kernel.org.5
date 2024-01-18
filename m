Return-Path: <linux-kernel+bounces-30293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5A8831CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A023B24BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561B328DB4;
	Thu, 18 Jan 2024 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LenxEjr6"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8628DA0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592470; cv=none; b=ZRFRuGOsvcEDtExtBfg6tifHU5IiVAC/TbBrJ2bu68+eFT6lsZV4HdU2yYIK9BtUoWfsnTfV9U7qwcTHLw5jPSSYd8VdR9FMGk8qhK0RBbSvFCcJqG/yw9Cu5sZGvuGsVZs0kSCDybVQyjDBsdp/IGWH+eg80YIGLOla1RYsupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592470; c=relaxed/simple;
	bh=J+WQhKpZvfHmGIQZEzxPTor6QcYXMVLBY1OFriy4R6M=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=sSPXpTTK1gxbLYwJGnAXtyWS7a9wtKm9xtzctCd7GSG7w/24ELtIcauk5XTSVU8MS44dt+s76Y2EMKShtY2GskNh4yKnKubxw28rqOlT6srYDxmQN6IXWsGSzuuLkfkXOuhjc1iyUDLXQ8B/NypV67YD71aMSJ1VALrYC5cUU5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LenxEjr6; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-429d9a9e38bso7259451cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705592468; x=1706197268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RQYEaR9pL9K6tl5rJo+FOjCIXsHbGHgXG9wdJUPHVQk=;
        b=LenxEjr6YiB8qW6vimY5+l7i/7v3yOj0dgd6Por1Aqp2bygLWnCElQMyBhNSjVxghL
         RA+n7n9FgsxHfmOp81svfvwPU6B8Ku0C/W8SQbp/XxU/LwJyYY6JbpvLok2m2L+pMrNt
         Bsqx5Dpt9IJuAi2W8lXvNNz7zr3I2cUkUNxnqfiXBG4MmSPhsZXEslflLEBrULNnFO9R
         t5ARtyhsQE3QvaRCIeR+1fVTyEd6x3KnsSXZZsDejVIkPKChgKyZ2z9NDQzQVotHyLkz
         /XWyFw/OS/o2XueWvBKHhCN8I4uorNbbMfcuSB1SzZ3ZAYVABKf+ShaKKU71mOqwKN7D
         oZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705592468; x=1706197268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQYEaR9pL9K6tl5rJo+FOjCIXsHbGHgXG9wdJUPHVQk=;
        b=AyHu4oDQtEPQ7k8y28Jr30sS9GB0kVqD/4oILz3ByZmcI86W9CQMRc//T6DVpRt7Vt
         6ec21VP3IDvCMZ98cTU7b8jx7i+oCnJbPiVcjJ2B6j/hPyx1CAk8GPAmFy/Yzv+DWK1N
         cR0lgnp9yoUlPfW107iXMBXZ5YVqXI1WPKTqxvHoMMhIFXdr/P5M7WKtYEm2LuZWM3AN
         uXBLOW9M5SjKIYjJ/u4Z/B/FCxrptnfJRk349TQZ+65EcxEhJP6b9xuTOT/R74jsGC1b
         3doI/c1nszV5GXjFOmRSs+Gg54O8pkmD9H451Tr1apx6yDynpRLK9tf/rINwXgca/mrz
         ZFrg==
X-Gm-Message-State: AOJu0Yws10hXjFH5V7SVmmMfI6xG/aPBqGd7+2cn335SuW9lDOGeLVzH
	uO/ZRTd8Sqhyv7JGcdCNf/F5V6++p34Mr5YPWKs7AwC0KCfRpiqa
X-Google-Smtp-Source: AGHT+IH4knPH/sTuiKuG0L6HHgYzAYiGzcP1NRmAgEMYRhM8cxVYLCkAxajis/4Bi9du+85ipoDd1A==
X-Received: by 2002:a05:6214:2127:b0:681:926:891e with SMTP id r7-20020a056214212700b006810926891emr1906262qvc.3.1705592467995;
        Thu, 18 Jan 2024 07:41:07 -0800 (PST)
Received: from me.mynetworksettings.com (pool-74-98-201-227.pitbpa.fios.verizon.net. [74.98.201.227])
        by smtp.gmail.com with ESMTPSA id nf1-20020a0562143b8100b00681924569bbsm520689qvb.115.2024.01.18.07.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:41:07 -0800 (PST)
From: Jacob Lott <jklott.git@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Jacob Lott <jklott.git@gmail.com>
Subject: [PATCH] staging: rts5208: Add more details to Kconfig help
Date: Thu, 18 Jan 2024 10:40:44 -0500
Message-Id: <20240118154044.68425-1-jklott.git@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current help text is short and triggers a
warning from checkpatch.pl.  This patch adds more
details to the help text which should provide better information
for whether or not to enable the driver.

Signed-off-by: Jacob Lott <jklott.git@gmail.com>
---
 drivers/staging/rts5208/Kconfig | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rts5208/Kconfig b/drivers/staging/rts5208/Kconfig
index b864023d3ccb..76a083fbe401 100644
--- a/drivers/staging/rts5208/Kconfig
+++ b/drivers/staging/rts5208/Kconfig
@@ -3,7 +3,11 @@ config RTS5208
 	tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
 	depends on PCI && SCSI
 	help
-	  Say Y here to include driver code to support the Realtek
-	  PCI-E card reader rts5208/rts5288.
+      Choose Y here to enable support for the Realtek PCI-E card reader RTS5208/5288.
+	  This driver facilitates communication between the Linux kernel and the Realtek
+	  PCI-E card reader.
 
-	  If this driver is compiled as a module, it will be named rts5208.
+	  If you opt to compile this driver as a module, it will be named rts5208. Selecting
+	  N will exclude this driver from the kernel build. Choose option Y if your system includes
+	  the Realtek PCI-E card reader rts5208/rts5288. When in doubt, it is generally safe
+	  to select N.
\ No newline at end of file
-- 
2.34.1


