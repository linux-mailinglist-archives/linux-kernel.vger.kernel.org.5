Return-Path: <linux-kernel+bounces-132663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B365899831
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EEEF1C20383
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72CB15FA9E;
	Fri,  5 Apr 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvvbWPld"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3E5145B31
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306498; cv=none; b=MFKtAux87SYMhooLA77P9/dwvSvSjddL9r0bqKJ7hOy8xX0B+FTkQ6nvO01ECpmG4fgLpZZ7imhs1k+hMS4uXOclw649WT1V21hpNwaz4d0PFdDw0bj3HleBv++agUvgEkWPDPxJ3g03fSMnMGxBM8oCZtxIbo/7fhPm1/Xrt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306498; c=relaxed/simple;
	bh=fEkXmy/4u1mgrjhH3SwUx8BWtxqc054U+RJQFBi63Y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HMj5SN6NAepoK706UlXD5BbSG3OU71slxRsaZ6MezWGurDBFAqEYh5DMJ2+R8IEtV60lwW1Gf2io02N/vzP+RJbidTZtaQNA59fQ7ExkEns8DezcN5ztGq8sGVWTN5RRAfLYPKZwHMJLRdZKPS8hRwUF2P48Fx/+DfTRvGg81uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YvvbWPld; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d23114b19dso21525001fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 01:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712306494; x=1712911294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSABBNNlKEhtSsrOAA7jkzf/IIG0fsXnntsFQ9SmQNk=;
        b=YvvbWPld8/6EBx3lX6105PDBoupyJh+Ov7uQdP+2zMiiU+s+AWW4e/GKuCanr+9fcv
         P+Mbi4vn9SvLZuyezH7eaU2IHWZK0CE7Y80yMIG8bct8T1hdH4Ogi1eWJvElywovp7s3
         KKJpdb5MUroykj7l2b4vaiaGRcaeQy3ezuV68uoewOb2IstzDbct1c/0JkuAhGuLY/d4
         JVWRs5y4AZofsNTOYhVz2FQzSn/5JmflcWgLG+TkASucATj/ashTNadaf8GsG4eBhnZB
         oVmpb9VlAuNcXCXm1mrXtjVD+oN5msSwG5ZWZM53i5HY5D6848ZbRH3rYR9PaMT2cgmL
         phpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712306494; x=1712911294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSABBNNlKEhtSsrOAA7jkzf/IIG0fsXnntsFQ9SmQNk=;
        b=Da8sZv15cEQ/jOeuA6fuYLNgsDRDSWB9XrPvC+povyJcuxC5d5FiybDforS4XXwm9X
         QUBnrdqfXIOe9kGxJDGv/0C5BmfW4Vv5LEY98ybwgclxAtS7vtKRJduvBEhijMkMa4Nc
         lgZ7yInRYiWUb9VC4Ym+Di6vAHtm9xRi137W72djcIY7c1thgk22UpwBe19gB2NchgpQ
         BwhvaPGurb6HodDYe7ylNrXXUw5cTQOa07zqNH+C3U5hGWsPnPkpbcl+VwLsVwdPPDBf
         wG28Ku1AoT4gp6ozqK35F4gMy1pVbX5UlSTmKVrrG250U0wBHm1NKUwv5ABvIeFB7rWR
         /VQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA/dF9WXR+bxQBaTOYGBTaMNDyA1pFzSs0Sl2fAY+ROUM8ynGxQ8jfxlKA1slCU5aVo4vYGjamzxnJ7m4/hJcwq8IOxA4Ky1UTeHto
X-Gm-Message-State: AOJu0YwlS+th4Elhn0mhQYerL4SDz+0OFKq46qkcd+E/nIFFwegifMRU
	eE+TdcS3KnB7OnKv3xZ47gqKPnteaYLyR5pFhl2Z6EvS8zs9mM7VUC79cD2SR/o=
X-Google-Smtp-Source: AGHT+IGElqD09S+bJG4HGQvHSKf6D8Gm7soI+u09xdQyhSPfpytTlYXflLgvpGmtQOzdAf/NVzT1EQ==
X-Received: by 2002:a2e:7d07:0:b0:2d8:3cd3:35d with SMTP id y7-20020a2e7d07000000b002d83cd3035dmr709319ljc.33.1712306494294;
        Fri, 05 Apr 2024 01:41:34 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-101.pol.akademiki.lublin.pl. [87.246.222.101])
        by smtp.gmail.com with ESMTPSA id y3-20020a05651c020300b002d429304a20sm116880ljn.8.2024.04.05.01.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 01:41:33 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 05 Apr 2024 10:41:29 +0200
Subject: [PATCH 1/6] soc: qcom: Move some socinfo defines to the header,
 expand them
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-smem_speedbin-v1-1-ce2b864251b1@linaro.org>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
In-Reply-To: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

In preparation for parsing the chip "feature code" (FC) and "product
code" (PC) (essentially the parameters that let us conclusively
characterize the sillicon we're running on, including various speed
bins), move the socinfo version defines to the public header and
include some more FC/PC defines.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/socinfo.c       |  8 --------
 include/linux/soc/qcom/socinfo.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 277c07a6603d..cf4616a468f2 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -21,14 +21,6 @@
 
 #include <dt-bindings/arm/qcom,ids.h>
 
-/*
- * SoC version type with major number in the upper 16 bits and minor
- * number in the lower 16 bits.
- */
-#define SOCINFO_MAJOR(ver) (((ver) >> 16) & 0xffff)
-#define SOCINFO_MINOR(ver) ((ver) & 0xffff)
-#define SOCINFO_VERSION(maj, min)  ((((maj) & 0xffff) << 16)|((min) & 0xffff))
-
 /* Helper macros to create soc_id table */
 #define qcom_board_id(id) QCOM_ID_ ## id, __stringify(id)
 #define qcom_board_id_named(id, name) QCOM_ID_ ## id, (name)
diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
index e78777bb0f4a..ba7f683bd32c 100644
--- a/include/linux/soc/qcom/socinfo.h
+++ b/include/linux/soc/qcom/socinfo.h
@@ -3,6 +3,8 @@
 #ifndef __QCOM_SOCINFO_H__
 #define __QCOM_SOCINFO_H__
 
+#include <linux/types.h>
+
 /*
  * SMEM item id, used to acquire handles to respective
  * SMEM region.
@@ -12,6 +14,14 @@
 #define SMEM_SOCINFO_BUILD_ID_LENGTH	32
 #define SMEM_SOCINFO_CHIP_ID_LENGTH	32
 
+/*
+ * SoC version type with major number in the upper 16 bits and minor
+ * number in the lower 16 bits.
+ */
+#define SOCINFO_MAJOR(ver) (((ver) >> 16) & 0xffff)
+#define SOCINFO_MINOR(ver) ((ver) & 0xffff)
+#define SOCINFO_VERSION(maj, min)  ((((maj) & 0xffff) << 16)|((min) & 0xffff))
+
 /* Socinfo SMEM item structure */
 struct socinfo {
 	__le32 fmt;
@@ -74,4 +84,30 @@ struct socinfo {
 	__le32 boot_core;
 };
 
+/* Internal feature codes */
+enum feature_code {
+	/* External feature codes */
+	SOCINFO_FC_UNKNOWN = 0x0,
+	SOCINFO_FC_AA,
+	SOCINFO_FC_AB,
+	SOCINFO_FC_AC,
+	SOCINFO_FC_AD,
+	SOCINFO_FC_AE,
+	SOCINFO_FC_AF,
+	SOCINFO_FC_AG,
+	SOCINFO_FC_AH,
+	SOCINFO_FC_EXT_RESERVE,
+};
+
+/* Internal feature codes */
+/* Valid values: 0 <= n <= 0xf */
+#define SOCINFO_FC_Yn(n)		(0xf1 + n)
+#define SOCINFO_FC_INT_RESERVE		SOCINFO_FC_Yn(0x10)
+
+/* Product codes */
+#define SOCINFO_PC_UNKNOWN		0
+/* Valid values: 0 <= n <= 8, the rest is reserved */
+#define SOCINFO_PCn(n)			(n + 1)
+#define SOCINFO_PC_RESERVE		(BIT(31) - 1)
+
 #endif

-- 
2.40.1


