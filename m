Return-Path: <linux-kernel+bounces-13014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB66381FE73
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA371C22999
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DC3111AD;
	Fri, 29 Dec 2023 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQMmK2Ak"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140EF1119F;
	Fri, 29 Dec 2023 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cdfa676fa3so3243181a12.1;
        Fri, 29 Dec 2023 01:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703840814; x=1704445614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipC33JpZc5+bW8eogM1x62qzqCCgucngE0K+YreHHZY=;
        b=IQMmK2Ak0fldgl3kTaOFaJ+5gTD8a39scD73mpqpsB0EW3WZvcp2EPDUCwdEhB0UPZ
         BQm1tIH5dQR8RxMPmpyk+W1ExfrNe2vwiCFtQ6cguYum2SJ2lNTQkdPbrQOci8i9WSOu
         o3fa37AMUn5a2k+SlZteS5cL9oWgAt/uSGr+ZeYiJdbpI3WAz2jDjzn3wjug8tZ/06Yl
         84sDYfX4fMYC9GFtJOR2nQq6tA9BwqjDohUwqV8la8U48JKh3qbqRXDAuuebxPoNlzck
         cHWzIqpKxAxgmU2gaa0EbmWsAdKf66UePA1+x/cbthehuZlEtpCt3CjwO00OffavngIU
         2Fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703840814; x=1704445614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipC33JpZc5+bW8eogM1x62qzqCCgucngE0K+YreHHZY=;
        b=HpM0q8AcJtlkMY5k46eyNCOyhPBi5xIS3VPcc/g8I1GPzFWbGO6Y9h4ED9S4Vv10Hl
         7m+okR2ZqLiHIOSNSkGtUukzWAmm15N/qmFNkbRYPjyhL5YkIb69kwOL88+xNhfzS4pP
         2ncaawPxbj7hfkZ/bU+d9djcxrS//fTyGc8vSr1aINhKfwNnjoNt/X+79nL0j7DnrFxX
         QNdmnyYpXhNV601txyBhzm2SZIUcVomgSMPYuPyaJeq5yzBaFXByd0vHbVzxM3lcGRGr
         kZFRFrBruFZYQ5VX+Uku3uJ0Kf7LBLDWx6YJMvjckUJbv1x86+LJF/S0pccd+d+zZhNl
         MC3w==
X-Gm-Message-State: AOJu0Yxew5XgFhOp18nXJ6UNf0UvX4gj0MRX/ppr/mLEfLm/+RkNPio2
	/h0ZtdND+KfwbaZE3xaBNig=
X-Google-Smtp-Source: AGHT+IFdQ8Wghr5nSXOJgh/nHQij/NEKRrK2W7mF+yKHNx01rbtSIW3e4oNpSCznn5KH+njbRbR1qw==
X-Received: by 2002:a17:90a:7e0d:b0:28c:361c:c418 with SMTP id i13-20020a17090a7e0d00b0028c361cc418mr9896033pjl.29.1703840814127;
        Fri, 29 Dec 2023 01:06:54 -0800 (PST)
Received: from localhost ([46.3.240.107])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a134800b0028c387b2528sm11164352pjf.8.2023.12.29.01.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 01:06:53 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v1 2/3] dt-bindings: power: sophgo: add Power-On-Reset/POR for Sophgo CV1800 series SoC.
Date: Fri, 29 Dec 2023 17:06:42 +0800
Message-Id: <20231229090643.116575-3-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231229090643.116575-1-qiujingbao.dlmu@gmail.com>
References: <20231229090643.116575-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding to describe the Power-On-Reset/POR for Sophgo CV1800 SoC.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 .../bindings/power/sophgo,cv1800-por.yaml     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/sophgo,cv1800-por.yaml

diff --git a/Documentation/devicetree/bindings/power/sophgo,cv1800-por.yaml b/Documentation/devicetree/bindings/power/sophgo,cv1800-por.yaml
new file mode 100644
index 000000000000..8706230a1cbc
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/sophgo,cv1800-por.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/sophgo,cv1800-por.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Power-On-Reset/POR of the Sophgo CV1800 SoC
+
+maintainers:
+  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+
+description:
+  This hardware provides triggering and timing control
+  for chip power on, off, and reset.
+
+properties:
+  compatible:
+    const: sophgo,cv1800-por
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    por {
+      compatible = "sophgo,cv1800-por";
+    };
-- 
2.25.1


