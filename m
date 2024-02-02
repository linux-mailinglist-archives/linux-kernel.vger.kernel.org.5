Return-Path: <linux-kernel+bounces-50016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300F784730E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C246E1F2C88B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2252B145B23;
	Fri,  2 Feb 2024 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+yMkyq+"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06513EFFB;
	Fri,  2 Feb 2024 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887300; cv=none; b=a+5KWwSU5kwQZfrC4pKNXzt+CTvFsO2iA5Ync91g6iBy1USz3zoycyADXXTeT2uAa6sT064N9idt7OscQnnbNHwCqlQX0uBjDJ+LwdqQuK0ThEExXVj/wYPkN1jSgwzE8g/940GHlu0yVoqZe3ZsFNhkF1J6nvvaeyi8GVy6Wr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887300; c=relaxed/simple;
	bh=60udXl9tGICJStOf3FsZ8Y/LhHheNLwsi4UzVmlgbB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A0sx+eSybZ8oRaOcvrPMBJ04reX6sRO67MaiiixJ4yoWPoF936WKlLHKRTKtEgCyDggYwdUQkMOmvqBUALUh+S4arCDA0cx3HXfvMGg6QdvQWRDvI46AsV76hClFFwom+75XTHb9KFXvvU2cFgD7ruXEjCt13b8L92fo/PJplr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+yMkyq+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6de24201aa6so1405637b3a.2;
        Fri, 02 Feb 2024 07:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706887298; x=1707492098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WzB9CiG8527gM43w39eAVcIuImyQFLRSzEMWnUfNR5Q=;
        b=U+yMkyq+2s+OOtI8vFHfT2R4I5yM3K9C8CMbqCNXmaMHwNc91CCnq1iN31ViWLHhnE
         VEREDytVuXwkfUU3Abr4uRGBBApkjEGJ3By/4ycOQuGfsy2IzpP/5TKw5l/pCneuaatl
         WZxDWkIoSp8BL6WvAxFfV0+KQru+2CZbZujk345YCB/oVk29sDsjm+y3ZDzsIxN1+mbx
         Sn9n7KJ96kZX6y4PT9j024I7MztPTBpJk9v8bH2G/d5bKOzYOf2AERz6QB1KIxxBmJ+T
         bi+SG6ID7ujN3fFstlGMHzgJH8lVQOirogOpM9dRkh/tiewmFZgRu8vlF4JZL87EiyON
         zqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887298; x=1707492098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzB9CiG8527gM43w39eAVcIuImyQFLRSzEMWnUfNR5Q=;
        b=Ds9695pgypn4GXnZxG9EKcdZAJzwIT3mkjReGqMPae29HHNAH0Qm4khGtXyEXYnoZR
         crTHTmn4tYctjwfqoWDXOc/+6Y7kKUTqGICqQkY0pfsV33F43fysf3st6FSF0sz3Rnif
         d+0wM2Q2NLzaNYVCZu9O1OJngIcUg/BSQL50sklYJIinNzF2eBg52vVxIwV6Absn/Myu
         P5jnu5uSXlsTtQl4IMVZMjRl1+Y7Gvr0shYE0iULakBqjQ9W8RpMzO59xtR8szAPspB9
         mh36CYKO0OpgqCEJxt+qRUxPCqW4jB2rnEN8BUQVvHvJhWfO+flyEH8p/vmwkPIp55RY
         oICw==
X-Gm-Message-State: AOJu0Yzc06Qrc+oX+iboe4O7gi6Z4oIXvTHrjY1NP5Bej/+My2DMy6wU
	8ipyfvCqIIUdXscL2hIyc1x5CqOrdruUq+gdvk0q8d0WUOdMNQWN
X-Google-Smtp-Source: AGHT+IGk3cGVAyNVViJrx5ZRvyLU4FsqPF1aLBAiMMi/ut8i/PfCBqg7P7T7bPB6FjdvtoHYcBPIqA==
X-Received: by 2002:aa7:984b:0:b0:6dd:c1b4:2643 with SMTP id n11-20020aa7984b000000b006ddc1b42643mr7997922pfq.28.1706887298273;
        Fri, 02 Feb 2024 07:21:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVfi3WN2Yw+G6AXGdYGJtKqsao0E+UCrKD9j9LB7DiCnbjz+gwpQg08O04YIkSN8XK/evSQLKpYegJVramjhxiSR2wUiogqn5XtYups0RoKGhDX1X//jGHXxRRvqI5fVXpioOjp12vJwddspyF0Xkr5yRpKrD1PJ008jJ8P3/XmTDTMQnyk75WWXBMODA==
Received: from rin-ThinkPad-L390.. (123-193-217-197.dynamic.kbronet.com.tw. [123.193.217.197])
        by smtp.gmail.com with ESMTPSA id v17-20020aa78511000000b006dde0b7d633sm1757626pfn.77.2024.02.02.07.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:21:37 -0800 (PST)
From: Yiwei Lin <s921975628@gmail.com>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	RinHizakura <s921975628@gmail.com>
Subject: [PATCH] Documentation: PM: Fix system hibernation section
Date: Fri,  2 Feb 2024 23:21:20 +0800
Message-Id: <20240202152120.13317-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: RinHizakura <s921975628@gmail.com>

According to the context, 'pci_pm_suspend_noirq' is the right
word for the changed sentence.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 Documentation/power/pci.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index a125544b4..120703203 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -625,7 +625,7 @@ The PCI subsystem-level callbacks they correspond to::
 	pci_pm_poweroff()
 	pci_pm_poweroff_noirq()
 
-work in analogy with pci_pm_suspend() and pci_pm_poweroff_noirq(), respectively,
+work in analogy with pci_pm_suspend() and pci_pm_suspend_noirq(), respectively,
 although they don't attempt to save the device's standard configuration
 registers.
 
-- 
2.34.1


