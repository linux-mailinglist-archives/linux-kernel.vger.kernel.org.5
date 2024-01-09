Return-Path: <linux-kernel+bounces-20938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D3B82879F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6601CB2507F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9562639AC4;
	Tue,  9 Jan 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFqpjVcQ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994E38FB7;
	Tue,  9 Jan 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9bd63ec7fso1411555b3a.2;
        Tue, 09 Jan 2024 06:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704808908; x=1705413708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC/8g7ZpWpj5XGSBITdvk8s0jNFEaS2+hXn9GTWkyls=;
        b=eFqpjVcQc5nMDh1ei/DndWYaBYETtrbr4oYBhhImyay+qf7aBBC5efYEiOFPQuWqnP
         hUtZiR1C50aKiwGhjMgYWn6k5rh2/9oMXRRVbusM5vr4Ix8roufWhj9kL9nepPwEoS5l
         VWWsNsl9TpvxUu0lC9MTMBtWowUPPP2U6h/bWqZllZQPomHa4S7kD2ImGcWsu4N0Kxas
         7fr6Kx3Pax8U8dtpy3oUQAqb1HyfDkdNEJbGIVUGju3z+5Nhtq/+aYAzgGS1wpF4lHs0
         JM2ay59QLhOyvqW3b6RoyVEeEay2D9Qzi4z7lgYkFozAiMJ7CDEVSIGF/bQ/0FKgWPor
         SpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808908; x=1705413708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FC/8g7ZpWpj5XGSBITdvk8s0jNFEaS2+hXn9GTWkyls=;
        b=P26wPCsSF9I4OUdcoY1APmjr94HYVn1YOnKKJGz3di4NuCt7/oLus67Qk+lzFFGh4Y
         A11gBEOvt8SV7Wq5RXF44OLlVM2mFhmwRoFBo7qA3LnqiMlzVzzqzfvbXAD7Mfh6548v
         kD5Z1AU+UH0kTAUfXb0Mr0MMdzpLznoTpSeu6YW9aPtZV5pQu+RKsqi4S5v1cPO6FOXg
         7aH6HYPDYPcz0++R27lhLExvBluc0u6UdrG56FSokTHFfEyK/jE3MmhNlT1At0hC5oNm
         PaMFoink9r/rU1YcOIjytMEUfVcwhQViHzBUp6DtJu7p+wh0Ggqc4LMoCWqDJtah9aWw
         Ak1A==
X-Gm-Message-State: AOJu0YxoJzhNG8kF5K3A4QLJyqp9N4rfLTCSW7majKPWnNDJgKZRnstg
	i76Lv+JW9EZFfX2Fc2xRCw5CDCajzHre8g==
X-Google-Smtp-Source: AGHT+IEVssHtiESKXpR+knixhH3RM0dJ0WL/8knFJz8d2Ip0hq7H0EzMPLcgxXq5uGv49Ep0Qp4+pg==
X-Received: by 2002:a05:6a21:1f25:b0:194:d82d:83cc with SMTP id ry37-20020a056a211f2500b00194d82d83ccmr2326988pzb.108.1704808907555;
        Tue, 09 Jan 2024 06:01:47 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006d9accac5c4sm1673697pfh.35.2024.01.09.06.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:01:47 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 7/7] Documentation: gpio: move gpio-mockup into deprecated section
Date: Tue,  9 Jan 2024 21:59:52 +0800
Message-Id: <20240109135952.77458-8-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240109135952.77458-1-warthog618@gmail.com>
References: <20240109135952.77458-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gpio-mockup has been obsoleted by the gpio-sim, so relocate its
documentation into the deprecated section of the admin-guide book.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/admin-guide/gpio/deprecated.rst | 1 +
 Documentation/admin-guide/gpio/index.rst      | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/gpio/deprecated.rst b/Documentation/admin-guide/gpio/deprecated.rst
index 683d7d23e62a..8503ea2f54d5 100644
--- a/Documentation/admin-guide/gpio/deprecated.rst
+++ b/Documentation/admin-guide/gpio/deprecated.rst
@@ -9,4 +9,5 @@ Deprecated GPIO APIs
 
     Character Device Userspace API (v1) <../../userspace-api/gpio/chardev_v1>
     Sysfs Interface <../../userspace-api/gpio/sysfs>
+    Mockup Testing Module <gpio-mockup>
 
diff --git a/Documentation/admin-guide/gpio/index.rst b/Documentation/admin-guide/gpio/index.rst
index 8489b8a3991f..573682212a56 100644
--- a/Documentation/admin-guide/gpio/index.rst
+++ b/Documentation/admin-guide/gpio/index.rst
@@ -9,7 +9,6 @@ GPIO
 
     Character Device Userspace API <../../userspace-api/gpio/chardev>
     gpio-aggregator
-    gpio-mockup
     gpio-sim
     Deprecated APIs <deprecated>
 
-- 
2.39.2


