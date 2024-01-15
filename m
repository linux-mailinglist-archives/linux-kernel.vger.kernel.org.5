Return-Path: <linux-kernel+bounces-25569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B22B682D2CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C791F212DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 00:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0EA1FB9;
	Mon, 15 Jan 2024 00:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1fT7xfS"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738D3C00;
	Mon, 15 Jan 2024 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bd6ef33227so856122b6e.0;
        Sun, 14 Jan 2024 16:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705279789; x=1705884589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DT6DB3XTDC40oMMuTXn3Vaf1U+FT3q/F4RaRZt+9Hsw=;
        b=A1fT7xfSnqKtt50iehnuLNPQdJWL+VTD8/9FKlBPZ2wCDnRj/ArMsBwt1YJJEpZYP1
         e5/e0EfP5x7w/qUeof3WcpSgAKNiaQGC6y4AkpjMTstCjis4yOYOXfDVFeBiB2qdZVqT
         FsLtPQzETJMIj0cl3nXULIa1KC0DBjSgiMok+h5ycK++p6elPSVugo/UOCCa3UBgFXka
         ZzfMADF378feRrybgRbCDBkgWAKyCrWx4RhivwoV9kdM1cokTWqSRgLV5BhpkLHVktdW
         6uAy7pljMxT5WhE/K2wkLW/BuaspS83EuHkg7RTRbBCNxxfzW9gjfwrLtmoM2yY1tlJD
         WIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705279789; x=1705884589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DT6DB3XTDC40oMMuTXn3Vaf1U+FT3q/F4RaRZt+9Hsw=;
        b=kzwEF9ay1WXIj05luwq73um+LpIPZ9KZESEiNlABmnmoIY57K7f3t6R+CXhgkFzIaB
         4dH183whJx//FIV21dBay4snsFZPvmVz52Tmqf/LstOvPCSpopHGC8VpFJph2RsLwjyk
         qElLzRZxbNi5VSrey1yX/wymvBbvO+eSs5r1sl0TDiazSWx0J1hG/KdXG+3sCDLNNvIW
         lkciykVTPAtxDQA/9knVVkkk8Y6hJ/SBmEdeZM6XpTnK7FTXmqEqqNo0lszuVw/sVCw+
         e/AvGIB4rRKiiX9mOHqdq5rmXAmiNCn02BLGH9OM0genxFqrnbfv9eJ+uV4qsBkCl2js
         noUA==
X-Gm-Message-State: AOJu0YwIFR1doe875QIg7YLiJbJDcqaTfTd1KrsBaUSO6SehbXJ1yHgq
	IV/k9uBTENNbUdLtWVnn9/FU1goV6RQ4bA==
X-Google-Smtp-Source: AGHT+IGt9s7kpfOp2/QJFQ6Mvf68WBiNEg9v9PGbK2e7riYjvwQTE9jBwW4nwrWfDyJ9K0w59PIodg==
X-Received: by 2002:a05:6808:1312:b0:3bd:6ab0:b98 with SMTP id y18-20020a056808131200b003bd6ab00b98mr4698191oiv.15.1705279789506;
        Sun, 14 Jan 2024 16:49:49 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79204000000b006d999f4a3c0sm6538365pfo.152.2024.01.14.16.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 16:49:49 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org,
	corbet@lwn.net
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 4/9] Documentation: gpio: move sysfs into an obsolete section
Date: Mon, 15 Jan 2024 08:48:42 +0800
Message-Id: <20240115004847.22369-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115004847.22369-1-warthog618@gmail.com>
References: <20240115004847.22369-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO sysfs API is long obsolete, so highlight this even further
by moving it into an obsolete APIs section in both the admin-guide
and userspace-api books.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 Documentation/admin-guide/gpio/index.rst              |  2 +-
 Documentation/admin-guide/gpio/obsolete.rst           | 11 +++++++++++
 Documentation/userspace-api/gpio/index.rst            |  1 +
 Documentation/userspace-api/gpio/obsolete.rst         | 10 ++++++++++
 .../{admin-guide => userspace-api}/gpio/sysfs.rst     |  0
 5 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/gpio/obsolete.rst
 create mode 100644 Documentation/userspace-api/gpio/obsolete.rst
 rename Documentation/{admin-guide => userspace-api}/gpio/sysfs.rst (100%)

diff --git a/Documentation/admin-guide/gpio/index.rst b/Documentation/admin-guide/gpio/index.rst
index b40f0a2a6822..3ac3aa15fa8b 100644
--- a/Documentation/admin-guide/gpio/index.rst
+++ b/Documentation/admin-guide/gpio/index.rst
@@ -9,9 +9,9 @@ gpio
 
     Character Device Userspace API <../../userspace-api/gpio/chardev>
     gpio-aggregator
-    sysfs
     gpio-mockup
     gpio-sim
+    Obsolete APIs <obsolete>
 
 .. only::  subproject and html
 
diff --git a/Documentation/admin-guide/gpio/obsolete.rst b/Documentation/admin-guide/gpio/obsolete.rst
new file mode 100644
index 000000000000..dbf88f13c680
--- /dev/null
+++ b/Documentation/admin-guide/gpio/obsolete.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+Obsolete GPIO APIs
+==================
+
+.. toctree::
+    :maxdepth: 1
+
+    Sysfs Interface <../../userspace-api/gpio/sysfs>
+
diff --git a/Documentation/userspace-api/gpio/index.rst b/Documentation/userspace-api/gpio/index.rst
index 072b9fa18aea..f258de4ef370 100644
--- a/Documentation/userspace-api/gpio/index.rst
+++ b/Documentation/userspace-api/gpio/index.rst
@@ -8,6 +8,7 @@ GPIO
     :maxdepth: 1
 
     Character Device Userspace API <chardev>
+    Obsolete Userspace APIs <obsolete>
 
 .. only::  subproject and html
 
diff --git a/Documentation/userspace-api/gpio/obsolete.rst b/Documentation/userspace-api/gpio/obsolete.rst
new file mode 100644
index 000000000000..c27bd6014a3d
--- /dev/null
+++ b/Documentation/userspace-api/gpio/obsolete.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Obsolete GPIO Userspace APIs
+============================
+
+.. toctree::
+    :maxdepth: 1
+
+    Sysfs Interface <sysfs>
diff --git a/Documentation/admin-guide/gpio/sysfs.rst b/Documentation/userspace-api/gpio/sysfs.rst
similarity index 100%
rename from Documentation/admin-guide/gpio/sysfs.rst
rename to Documentation/userspace-api/gpio/sysfs.rst
-- 
2.39.2


