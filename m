Return-Path: <linux-kernel+bounces-20931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC19582878B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B68F2863EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7939ACA;
	Tue,  9 Jan 2024 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V95yhIDE"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1239876;
	Tue,  9 Jan 2024 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9a79a1ad4so1309163b3a.2;
        Tue, 09 Jan 2024 06:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704808834; x=1705413634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BCKYEo6R3k+Quwcv5Ub6j7F0zuPGuRj4A0bC177gLY=;
        b=V95yhIDEajr3HmzJVrIwBY+e47asf0G2mjSiz4Au7AVBykOQXLfvgtG6S/mugCV4lA
         6hQ3Cm3geXaR1Jxl48zE2/lEQimvbaH2i19p2kt3scLp3386dPMeyYYXS9EcX/3Fygzy
         UQZz+tuy5yV8e//1ELPvFZCUuPw03uKtfYbVfwlX1vPF9dUh0TQKCb6rSsAy/t8eVuH+
         QmLk5opxZ1MnU9DrIClDvnn8wAUNfVYWcLjybBWcI1CYiI+nSFZsxTZI+z0i0LCz2bVC
         6zgGYYyNPQ5AM8A5ZbQjGjwnhOWp0l0MixBIWmC+afm1OPBHPA0KsooqDaBybbixET7I
         ig3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808834; x=1705413634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BCKYEo6R3k+Quwcv5Ub6j7F0zuPGuRj4A0bC177gLY=;
        b=qZ+PbPPwmhMsHY2EhL9j7+5h33ugCwLTahu/JKxH4ZF3ryvb1/BIVnVoUkMRe3R2q8
         /1qovg1H6k7NNYmxVe4S7chCFfJ1Qq3q9oSwBsvmbQ+efdu/E0Gxx8riHT+ETldjE8/E
         t3S5TrKpkqHZRavax5HKnTlqCVG93AKdsT4LkR3vhM+33hDvQytgfggBzz/TrAnuvn/j
         4SUQ1EDOoqY7IID1B2beHVi8k4B4yp5QZUnJ8e+g2jgVVeoV/Y5RRbLwb2ZpUSg/q32B
         Qwx3GipWv4bPtlmnrtzhq5hL383v5OxNRVQx8Q8p0FObkt9WZcEhGRGojTkMOTXNc46Z
         CqrA==
X-Gm-Message-State: AOJu0YwmRfbNR/SB6zk84iZk6BSyWX1fZi/Gnp32BmD5t8epwf5hY2hI
	LD1useD2aFSLN10UgAvLCHG+jvnhjRytmA==
X-Google-Smtp-Source: AGHT+IGtSWguF7q9VbOdESfHQUdcHFNHIIo25gfrQLm7+3M4oj3w0UNypF9mveF+o5k+Ezu3rOcpcg==
X-Received: by 2002:a05:6a21:150d:b0:199:81a3:847 with SMTP id nq13-20020a056a21150d00b0019981a30847mr3033272pzb.57.1704808834018;
        Tue, 09 Jan 2024 06:00:34 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006d9accac5c4sm1673697pfh.35.2024.01.09.06.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:00:33 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 2/7] Documentation: gpio: move sysfs into a deprecated section
Date: Tue,  9 Jan 2024 21:59:47 +0800
Message-Id: <20240109135952.77458-3-warthog618@gmail.com>
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

The GPIO sysfs API is long deprecated, so highlight this even further
by moving it into a deprecated APIs section in both the admin-guide
and userspace-api books.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/admin-guide/gpio/deprecated.rst         | 11 +++++++++++
 Documentation/admin-guide/gpio/index.rst              |  2 +-
 Documentation/userspace-api/gpio/deprecated.rst       | 10 ++++++++++
 Documentation/userspace-api/gpio/index.rst            |  1 +
 .../{admin-guide => userspace-api}/gpio/sysfs.rst     |  0
 5 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/gpio/deprecated.rst
 create mode 100644 Documentation/userspace-api/gpio/deprecated.rst
 rename Documentation/{admin-guide => userspace-api}/gpio/sysfs.rst (100%)

diff --git a/Documentation/admin-guide/gpio/deprecated.rst b/Documentation/admin-guide/gpio/deprecated.rst
new file mode 100644
index 000000000000..33f701294732
--- /dev/null
+++ b/Documentation/admin-guide/gpio/deprecated.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Deprecated GPIO APIs
+====================
+
+.. toctree::
+    :maxdepth: 1
+
+    Sysfs Interface <../../userspace-api/gpio/sysfs>
+
diff --git a/Documentation/admin-guide/gpio/index.rst b/Documentation/admin-guide/gpio/index.rst
index b40f0a2a6822..9b0630f30d3e 100644
--- a/Documentation/admin-guide/gpio/index.rst
+++ b/Documentation/admin-guide/gpio/index.rst
@@ -9,9 +9,9 @@ gpio
 
     Character Device Userspace API <../../userspace-api/gpio/chardev>
     gpio-aggregator
-    sysfs
     gpio-mockup
     gpio-sim
+    Deprecated APIs <deprecated>
 
 .. only::  subproject and html
 
diff --git a/Documentation/userspace-api/gpio/deprecated.rst b/Documentation/userspace-api/gpio/deprecated.rst
new file mode 100644
index 000000000000..4cc7c79d7c23
--- /dev/null
+++ b/Documentation/userspace-api/gpio/deprecated.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Deprecated GPIO Userspace APIs
+==============================
+
+.. toctree::
+    :maxdepth: 1
+
+    Sysfs Interface <sysfs>
diff --git a/Documentation/userspace-api/gpio/index.rst b/Documentation/userspace-api/gpio/index.rst
index 072b9fa18aea..17f0f92db384 100644
--- a/Documentation/userspace-api/gpio/index.rst
+++ b/Documentation/userspace-api/gpio/index.rst
@@ -8,6 +8,7 @@ GPIO
     :maxdepth: 1
 
     Character Device Userspace API <chardev>
+    Deprecated Userspace APIs <deprecated>
 
 .. only::  subproject and html
 
diff --git a/Documentation/admin-guide/gpio/sysfs.rst b/Documentation/userspace-api/gpio/sysfs.rst
similarity index 100%
rename from Documentation/admin-guide/gpio/sysfs.rst
rename to Documentation/userspace-api/gpio/sysfs.rst
-- 
2.39.2


