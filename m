Return-Path: <linux-kernel+bounces-147737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F02E8A7860
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B001F22AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9A613AD1C;
	Tue, 16 Apr 2024 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amOn9dPF"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463413A3E5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309034; cv=none; b=G/ZWElL9B0pGYXOiEiKiuB68IfjogMUiVJxm7DSY/RvoHlmaHiHO73fg7fufmcBUGI6EAb+SYZ7N3+ch4/99sc3y9qdApc5VXxtrjwslArOaufMVvBbS44VLlakHzBtdUqghZtnH4AffnbgJp8oQYKxZmCDmaErxMf3Pt+6K8Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309034; c=relaxed/simple;
	bh=bkKQYUPXViheM7/Pqge03AsMiP6sEOkmKPQNt/lxmrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jEBoc5y9MfDFPYPV/mBzxZbyw3/cTf+/pKURB5SgdwdSuP77z92LFPrJ1AigKHXU1suot9Snt7DtUdTMMdSa/kYDU7H6RUumyjfBNHBo8bG8AJVnJjGnjSAOq2gIvxMsI4Rf6pRrM8W+OEYY/M0bDRNahwjz57LoBKK8w8CiLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=amOn9dPF; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d5f0a155e3so188788739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713309031; x=1713913831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NZzXjRloWgZebxRLPG0BGoJm/68zG1y3Pcw2+As738=;
        b=amOn9dPFGTJDJCPAU6x4MZiHfkt5pIw8MdrsLudDZd5i8ynipOCK0lfL9qtKzXzeT9
         4tVZDnyt4uV1pgnbWZjB83y75MivRJXvUa/ouLXOOIgQl+GSEx6q+V7opPLhj/NasInP
         Bh8bjmOKPRenOlcHHQkY88HWeWZkQ15UAJGMKua/QQUZ8uzos6gwuX07AsmkuonnT+pl
         5hisQCcaC4KIe2fQt5kbrEJFLIpwmZlGkgiGCQ+ugJ5qG3H63nYFF1RmYDU9NWnsQHXm
         WtkhZtKnAz6i3p9V/zB/yg/Z4/4JCLub9ORVxj+a+crWKQNOle64sCESNx+YBsjafBN/
         aCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713309031; x=1713913831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NZzXjRloWgZebxRLPG0BGoJm/68zG1y3Pcw2+As738=;
        b=SRiopvGlxVeTG2I0rFpVyON+Okd8f/KkYG3EDj8YdnJNP6/qX6wz3i33/VvC1edLLt
         MB4q+Ea0UmLPExNcis1oBBqRH40Zh3J6y1GJS8nc6idMqHcBRXDR7PIXw6JVQkP3C6ne
         eRHr8937AscCxSmzLEZySk+OLSp8B6ae0eAYv3jOJ+/wWsVuD+5QjvlMIX02Oxnlgfz5
         AuqGxtBYxcKpFmEIXJUB5xtAThqYsRlaEnT3aujQgJLtE+n5FKHuy63IDXvzFHMSrZji
         /pf6z4zm1DYDeBi4b+2rUCO6WEIpInZTckaUMtffdiFtO3DIi4XX+HAY6te4avXO8/FP
         c11g==
X-Forwarded-Encrypted: i=1; AJvYcCXi79y5XUCOB4Cv+ADmnWgciUr/I6dXExKVE+QE9GCLyRw/vlRBVBsxaJMdB6aNQ6TGaDclOG2wpy4Z6zUJ4B40y0Td0f296N0IjT9T
X-Gm-Message-State: AOJu0YxhFpMgZ8Wv9uiNT47Ar1wZlwgTkp9BD3y6tz7ZlNbXIHlhuTIu
	XkMDqCwfczCSxFiTXGdO9E9cNYfQuDfmLyGhDvKVqCUlXL9D5xFHDNxfJ6FPdi0=
X-Google-Smtp-Source: AGHT+IEAfKRZEOuxIf+LEWv3ugurt1k0j12c8bmtW9GFysMB4XQs5qQK/elBVkoEQw8pLowN+Uq4uQ==
X-Received: by 2002:a05:6602:3809:b0:7d6:991a:ef19 with SMTP id bb9-20020a056602380900b007d6991aef19mr19404862iob.8.1713309031045;
        Tue, 16 Apr 2024 16:10:31 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id le9-20020a056638960900b004846ed9fcb1sm372170jab.101.2024.04.16.16.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:10:30 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/7] net: ipa: include some standard header files
Date: Tue, 16 Apr 2024 18:10:12 -0500
Message-Id: <20240416231018.389520-2-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416231018.389520-1-elder@linaro.org>
References: <20240416231018.389520-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some IPA header files use types defined in <linux/types.h>, but do
not include that file:
  - In "ipa_mem.h", the ipa_mem structure has u16 and u32 fields
  - In "ipa_power.h", ipa_power_retention() takes a bool argument,
    and ipa_core_clock_rate() returns u32
  - In "ipa_version.h", ipa_version_supported() returns bool
Include it in these files to satisfy their dependencies.

The ipa_qmi structure (defined in "ipa_qmi.h") contains a work
structure, so include <linux/workqueue.h> in there.

All of the data and register definition files, as well as "reg.h",
use the ARRAY_SIZE() macro.  Include <linux/array_size.h> everywhere
it's used.

Similarly, all register definition files (and a few others) use the
GENMASK() macro, so include <linux/bits.h> to ensure it's defined
where used.  BIT() becomes available by including this file also.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/data/ipa_data-v3.1.c   | 3 ++-
 drivers/net/ipa/data/ipa_data-v3.5.1.c | 3 ++-
 drivers/net/ipa/data/ipa_data-v4.11.c  | 3 ++-
 drivers/net/ipa/data/ipa_data-v4.2.c   | 3 ++-
 drivers/net/ipa/data/ipa_data-v4.5.c   | 3 ++-
 drivers/net/ipa/data/ipa_data-v4.7.c   | 3 ++-
 drivers/net/ipa/data/ipa_data-v4.9.c   | 3 ++-
 drivers/net/ipa/data/ipa_data-v5.0.c   | 3 ++-
 drivers/net/ipa/data/ipa_data-v5.5.c   | 3 ++-
 drivers/net/ipa/ipa_cmd.c              | 3 ++-
 drivers/net/ipa/ipa_endpoint.c         | 3 ++-
 drivers/net/ipa/ipa_mem.h              | 4 +++-
 drivers/net/ipa/ipa_power.h            | 4 +++-
 drivers/net/ipa/ipa_qmi.h              | 3 ++-
 drivers/net/ipa/ipa_version.h          | 4 +++-
 drivers/net/ipa/reg.h                  | 4 +++-
 drivers/net/ipa/reg/gsi_reg-v3.1.c     | 4 +++-
 drivers/net/ipa/reg/gsi_reg-v3.5.1.c   | 4 +++-
 drivers/net/ipa/reg/gsi_reg-v4.0.c     | 4 +++-
 drivers/net/ipa/reg/gsi_reg-v4.11.c    | 4 +++-
 drivers/net/ipa/reg/gsi_reg-v4.5.c     | 4 +++-
 drivers/net/ipa/reg/gsi_reg-v4.9.c     | 4 +++-
 drivers/net/ipa/reg/gsi_reg-v5.0.c     | 4 +++-
 drivers/net/ipa/reg/ipa_reg-v3.1.c     | 4 +++-
 drivers/net/ipa/reg/ipa_reg-v3.5.1.c   | 4 +++-
 drivers/net/ipa/reg/ipa_reg-v4.11.c    | 4 +++-
 drivers/net/ipa/reg/ipa_reg-v4.2.c     | 4 +++-
 drivers/net/ipa/reg/ipa_reg-v4.5.c     | 4 +++-
 drivers/net/ipa/reg/ipa_reg-v4.7.c     | 4 +++-
 drivers/net/ipa/reg/ipa_reg-v4.9.c     | 4 +++-
 drivers/net/ipa/reg/ipa_reg-v5.0.c     | 4 +++-
 drivers/net/ipa/reg/ipa_reg-v5.5.c     | 4 +++-
 32 files changed, 84 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ipa/data/ipa_data-v3.1.c b/drivers/net/ipa/data/ipa_data-v3.1.c
index 3380fb3483b2c..58fe2a4fe37ce 100644
--- a/drivers/net/ipa/data/ipa_data-v3.1.c
+++ b/drivers/net/ipa/data/ipa_data-v3.1.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2021 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 
+#include <linux/array_size.h>
 #include <linux/log2.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/data/ipa_data-v3.5.1.c b/drivers/net/ipa/data/ipa_data-v3.5.1.c
index 4287114b24db1..c71e585ed3f1c 100644
--- a/drivers/net/ipa/data/ipa_data-v3.5.1.c
+++ b/drivers/net/ipa/data/ipa_data-v3.5.1.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2021 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 
+#include <linux/array_size.h>
 #include <linux/log2.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/data/ipa_data-v4.11.c b/drivers/net/ipa/data/ipa_data-v4.11.c
index 1b4b52501ee33..d1289de3ecf01 100644
--- a/drivers/net/ipa/data/ipa_data-v4.11.c
+++ b/drivers/net/ipa/data/ipa_data-v4.11.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2021 Linaro Ltd. */
+/* Copyright (C) 2021-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
 #include <linux/log2.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/data/ipa_data-v4.2.c b/drivers/net/ipa/data/ipa_data-v4.2.c
index 199ed0ed868b9..25194519df8e3 100644
--- a/drivers/net/ipa/data/ipa_data-v4.2.c
+++ b/drivers/net/ipa/data/ipa_data-v4.2.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2019-2021 Linaro Ltd. */
+/* Copyright (C) 2019-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
 #include <linux/log2.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/data/ipa_data-v4.5.c b/drivers/net/ipa/data/ipa_data-v4.5.c
index 19b549f2998b8..e9e375d530765 100644
--- a/drivers/net/ipa/data/ipa_data-v4.5.c
+++ b/drivers/net/ipa/data/ipa_data-v4.5.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2021 Linaro Ltd. */
+/* Copyright (C) 2021-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
 #include <linux/log2.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
index b83390c486158..f3444c009fea8 100644
--- a/drivers/net/ipa/data/ipa_data-v4.7.c
+++ b/drivers/net/ipa/data/ipa_data-v4.7.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2022 Linaro Ltd. */
+/* Copyright (C) 2022-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
 #include <linux/log2.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/data/ipa_data-v4.9.c b/drivers/net/ipa/data/ipa_data-v4.9.c
index d30fc1fe6ca22..5284312c02f33 100644
--- a/drivers/net/ipa/data/ipa_data-v4.9.c
+++ b/drivers/net/ipa/data/ipa_data-v4.9.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2021 Linaro Ltd. */
+/* Copyright (C) 2021-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
 #include <linux/log2.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/data/ipa_data-v5.0.c b/drivers/net/ipa/data/ipa_data-v5.0.c
index 4d8171dae4cd7..615750c412fc7 100644
--- a/drivers/net/ipa/data/ipa_data-v5.0.c
+++ b/drivers/net/ipa/data/ipa_data-v5.0.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2023 Linaro Ltd. */
+/* Copyright (C) 2023-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
 #include <linux/log2.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/data/ipa_data-v5.5.c b/drivers/net/ipa/data/ipa_data-v5.5.c
index 2c6390f11354b..2c5bfa6d7101d 100644
--- a/drivers/net/ipa/data/ipa_data-v5.5.c
+++ b/drivers/net/ipa/data/ipa_data-v5.5.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2023 Linaro Ltd. */
+/* Copyright (C) 2023-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
 
diff --git a/drivers/net/ipa/ipa_cmd.c b/drivers/net/ipa/ipa_cmd.c
index 39219963dbb3f..ae489557bf355 100644
--- a/drivers/net/ipa/ipa_cmd.c
+++ b/drivers/net/ipa/ipa_cmd.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2023 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 
+#include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/slab.h>
diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index dd490941615e2..0522267a7988a 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2023 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 
+#include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/slab.h>
diff --git a/drivers/net/ipa/ipa_mem.h b/drivers/net/ipa/ipa_mem.h
index 28aad00a151da..b25babade787e 100644
--- a/drivers/net/ipa/ipa_mem.h
+++ b/drivers/net/ipa/ipa_mem.h
@@ -1,11 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2023 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 #ifndef _IPA_MEM_H_
 #define _IPA_MEM_H_
 
+#include <linux/types.h>
+
 struct platform_device;
 
 struct ipa;
diff --git a/drivers/net/ipa/ipa_power.h b/drivers/net/ipa/ipa_power.h
index 227cc04bea806..e41791f2a1be4 100644
--- a/drivers/net/ipa/ipa_power.h
+++ b/drivers/net/ipa/ipa_power.h
@@ -1,11 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2022 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 #ifndef _IPA_POWER_H_
 #define _IPA_POWER_H_
 
+#include <linux/types.h>
+
 struct device;
 
 struct ipa;
diff --git a/drivers/net/ipa/ipa_qmi.h b/drivers/net/ipa/ipa_qmi.h
index 1c236826c17ab..ce7bbb97699f2 100644
--- a/drivers/net/ipa/ipa_qmi.h
+++ b/drivers/net/ipa/ipa_qmi.h
@@ -1,12 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2022 Linaro Ltd.
+ * Copyright (C) 2018-2024 Linaro Ltd.
  */
 #ifndef _IPA_QMI_H_
 #define _IPA_QMI_H_
 
 #include <linux/types.h>
+#include <linux/workqueue.h>
 #include <linux/soc/qcom/qmi.h>
 
 struct ipa;
diff --git a/drivers/net/ipa/ipa_version.h b/drivers/net/ipa/ipa_version.h
index 38150345b607e..156388e90a141 100644
--- a/drivers/net/ipa/ipa_version.h
+++ b/drivers/net/ipa/ipa_version.h
@@ -1,11 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2019-2022 Linaro Ltd.
+ * Copyright (C) 2019-2024 Linaro Ltd.
  */
 #ifndef _IPA_VERSION_H_
 #define _IPA_VERSION_H_
 
+#include <linux/types.h>
+
 /**
  * enum ipa_version
  * @IPA_VERSION_3_0:	IPA version 3.0/GSI version 1.0
diff --git a/drivers/net/ipa/reg.h b/drivers/net/ipa/reg.h
index 2ee07eebca677..e78eb0c0c6613 100644
--- a/drivers/net/ipa/reg.h
+++ b/drivers/net/ipa/reg.h
@@ -1,10 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-/* *Copyright (C) 2022-2023 Linaro Ltd. */
+/* Copyright (C) 2022-2024 Linaro Ltd. */
 
 #ifndef _REG_H_
 #define _REG_H_
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/log2.h>
 #include <linux/bug.h>
diff --git a/drivers/net/ipa/reg/gsi_reg-v3.1.c b/drivers/net/ipa/reg/gsi_reg-v3.1.c
index e036805a78824..8d76d04058d57 100644
--- a/drivers/net/ipa/reg/gsi_reg-v3.1.c
+++ b/drivers/net/ipa/reg/gsi_reg-v3.1.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2023 Linaro Ltd. */
+/* Copyright (C) 2023-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/reg/gsi_reg-v3.5.1.c b/drivers/net/ipa/reg/gsi_reg-v3.5.1.c
index 8c3ab3a5288e6..f66c67996ff4c 100644
--- a/drivers/net/ipa/reg/gsi_reg-v3.5.1.c
+++ b/drivers/net/ipa/reg/gsi_reg-v3.5.1.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2023 Linaro Ltd. */
+/* Copyright (C) 2023-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/reg/gsi_reg-v4.0.c b/drivers/net/ipa/reg/gsi_reg-v4.0.c
index 7cc7a21d07f90..8e689edc792b8 100644
--- a/drivers/net/ipa/reg/gsi_reg-v4.0.c
+++ b/drivers/net/ipa/reg/gsi_reg-v4.0.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2023 Linaro Ltd. */
+/* Copyright (C) 2023-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/reg/gsi_reg-v4.11.c b/drivers/net/ipa/reg/gsi_reg-v4.11.c
index 01696519032fa..6d3ed0441f518 100644
--- a/drivers/net/ipa/reg/gsi_reg-v4.11.c
+++ b/drivers/net/ipa/reg/gsi_reg-v4.11.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2023 Linaro Ltd. */
+/* Copyright (C) 2023-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/reg/gsi_reg-v4.5.c b/drivers/net/ipa/reg/gsi_reg-v4.5.c
index 2900e5c3ff888..544db5852f499 100644
--- a/drivers/net/ipa/reg/gsi_reg-v4.5.c
+++ b/drivers/net/ipa/reg/gsi_reg-v4.5.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2023 Linaro Ltd. */
+/* Copyright (C) 2023-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/reg/gsi_reg-v4.9.c b/drivers/net/ipa/reg/gsi_reg-v4.9.c
index 8b5d95425a766..a6d0584ab7996 100644
--- a/drivers/net/ipa/reg/gsi_reg-v4.9.c
+++ b/drivers/net/ipa/reg/gsi_reg-v4.9.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2023 Linaro Ltd. */
+/* Copyright (C) 2023-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/reg/gsi_reg-v5.0.c b/drivers/net/ipa/reg/gsi_reg-v5.0.c
index 145eb0bd096d6..a7b7f345c11a9 100644
--- a/drivers/net/ipa/reg/gsi_reg-v5.0.c
+++ b/drivers/net/ipa/reg/gsi_reg-v5.0.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2023 Linaro Ltd. */
+/* Copyright (C) 2023-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../gsi.h"
diff --git a/drivers/net/ipa/reg/ipa_reg-v3.1.c b/drivers/net/ipa/reg/ipa_reg-v3.1.c
index 648dbfe1fce3a..c05b382933ad8 100644
--- a/drivers/net/ipa/reg/ipa_reg-v3.1.c
+++ b/drivers/net/ipa/reg/ipa_reg-v3.1.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2022 Linaro Ltd. */
+/* Copyright (C) 2022-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../ipa.h"
diff --git a/drivers/net/ipa/reg/ipa_reg-v3.5.1.c b/drivers/net/ipa/reg/ipa_reg-v3.5.1.c
index 78b1bf60cd024..afbe042b166be 100644
--- a/drivers/net/ipa/reg/ipa_reg-v3.5.1.c
+++ b/drivers/net/ipa/reg/ipa_reg-v3.5.1.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2022 Linaro Ltd. */
+/* Copyright (C) 2022-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../ipa.h"
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.11.c b/drivers/net/ipa/reg/ipa_reg-v4.11.c
index 29e71cce4a843..1d6b8ea9c5c80 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.11.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.11.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2022 Linaro Ltd. */
+/* Copyright (C) 2022-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../ipa.h"
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.2.c b/drivers/net/ipa/reg/ipa_reg-v4.2.c
index bb7cf488144db..93a78352c3c81 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.2.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.2.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2022 Linaro Ltd. */
+/* Copyright (C) 2022-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../ipa.h"
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.5.c b/drivers/net/ipa/reg/ipa_reg-v4.5.c
index 1c58f78851c21..9e23e503d4013 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.5.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.5.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2022 Linaro Ltd. */
+/* Copyright (C) 2022-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../ipa.h"
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.7.c b/drivers/net/ipa/reg/ipa_reg-v4.7.c
index 731824fce1d4a..728ab90dc8d43 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.7.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.7.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2022 Linaro Ltd. */
+/* Copyright (C) 2022-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../ipa.h"
diff --git a/drivers/net/ipa/reg/ipa_reg-v4.9.c b/drivers/net/ipa/reg/ipa_reg-v4.9.c
index 01f87b5290e01..f61b66d36607f 100644
--- a/drivers/net/ipa/reg/ipa_reg-v4.9.c
+++ b/drivers/net/ipa/reg/ipa_reg-v4.9.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2022 Linaro Ltd. */
+/* Copyright (C) 2022-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../ipa.h"
diff --git a/drivers/net/ipa/reg/ipa_reg-v5.0.c b/drivers/net/ipa/reg/ipa_reg-v5.0.c
index 95e0edff41709..cba5be34106db 100644
--- a/drivers/net/ipa/reg/ipa_reg-v5.0.c
+++ b/drivers/net/ipa/reg/ipa_reg-v5.0.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2023 Linaro Ltd. */
+/* Copyright (C) 2023-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 
 #include "../ipa.h"
diff --git a/drivers/net/ipa/reg/ipa_reg-v5.5.c b/drivers/net/ipa/reg/ipa_reg-v5.5.c
index 26ca9c9bac599..2436d3489cf2b 100644
--- a/drivers/net/ipa/reg/ipa_reg-v5.5.c
+++ b/drivers/net/ipa/reg/ipa_reg-v5.5.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
-/* Copyright (C) 2023 Linaro Ltd. */
+/* Copyright (C) 2023-2024 Linaro Ltd. */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/bits.h>
-- 
2.40.1


