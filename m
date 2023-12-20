Return-Path: <linux-kernel+bounces-7500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED0381A8F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDDE1F23940
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83834A9BB;
	Wed, 20 Dec 2023 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGZXIz7s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECBE498AE;
	Wed, 20 Dec 2023 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so1808905e9.3;
        Wed, 20 Dec 2023 14:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703110667; x=1703715467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WXsTXt5tNNCO94Jfxptt1+xmo7JvqPD/4sHkvcR0pA=;
        b=DGZXIz7sUWvuJXG0L6rKkdfrf/Vs2zjuFyf5xApnhrgdxOS5i82FsfQh7vQWvVrFIV
         j3ZWNzdvLowYSzkfzmKiI9ZMw+h91R9y5xaBRbW+J1IzMOKgz5qa3OyrvbCaKx624e8y
         pe1bD23slB8bWIbv4ZxpoeR8nNfmGZrNGymkD66BbJUf4xJnmdMMtMhwjY6vXVz2EJpp
         uBR4hWxSPXAUS/9hVM6oZaZ9cORUp5lCSh9wAvWpRGrGdGUKUs2YnqdflGc3NTWc+nmQ
         oMp8VhnzTG//TBWmTTWI/hKocq9GLrQgjZ0hER//Hh8IQlpx2a4Uw6a3yCoLmXtW3HmP
         2NGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703110667; x=1703715467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WXsTXt5tNNCO94Jfxptt1+xmo7JvqPD/4sHkvcR0pA=;
        b=dr8HqSvImoHMXwhHhPxR03IixwuGbKbJW98RugF2A3CIX1nfbCttE6xf6YhXFUynE+
         gptquoKLGAHBW2a0+dB6BzhuCilOnE+QCi6hsS+b7nOK45pW7qcjjOAAUFve8uJlXiNZ
         TtoE96BuimYii//VnW9fdsauL+kJh4B4ZGFfvMPyBJlbvqanJrlaHjU3ipIoH71EstJG
         TW9SHA+gYLEXkkqs+1OKInVIKkt/XKXdbqTuKagHoklm5ThxFs6o4h+o9S1i4I39b0Jr
         qelfNd4MNFIa4eta2kCvu5RmP5TEl1/P6xloWbB/wgqn/NR5oJbuegMf6nEPHc8xA4xb
         /hDQ==
X-Gm-Message-State: AOJu0YwwLGSnuW0rS7nEFbmaJ5hoIWCHAeReJnolNFiZp0RHWjPyN1eJ
	IL0EChD9Vzb9cnAFZpiWBdE9aE8mJuw=
X-Google-Smtp-Source: AGHT+IEPZzAUuWY4AbfBPk9NNhKK7WFp44YsvCdsZZi2uSUWDKm6t2BxfyzGvettwKbqeX9tSfcgtA==
X-Received: by 2002:a05:600c:538a:b0:40c:6d53:601f with SMTP id hg10-20020a05600c538a00b0040c6d53601fmr86644wmb.337.1703110667010;
        Wed, 20 Dec 2023 14:17:47 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id v14-20020a05600c444e00b0040c58e410a3sm8908826wmn.14.2023.12.20.14.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:17:46 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v8 1/3] clk: qcom: clk-rcg: introduce support for multiple conf for same freq
Date: Wed, 20 Dec 2023 23:17:22 +0100
Message-Id: <20231220221724.3822-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231220221724.3822-1-ansuelsmth@gmail.com>
References: <20231220221724.3822-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some RCG frequency can be reached by multiple configuration.

We currently declare multiple configuration for the same frequency but
that is not supported and always the first configuration will be taken.

These multiple configuration are needed as based on the current parent
configuration, it may be needed to use a different configuration to
reach the same frequency.

To handle this introduce 3 new macro, C, FM and FMS:

- C is used to declare a freq_conf where src, pre_div, m and n are
  provided.

- FM is used to declare a freq_multi_tbl with the frequency and an
  array of confs to insert all the config for the provided frequency.

- FMS is used to declare a freq_multi_tbl with the frequency and an
  array of a single conf with the provided src, pre_div, m and n.

Struct clk_rcg2 is changed to add a union type to reference a simple
freq_tbl or a complex freq_multi_tbl.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-rcg.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index e6d84c8c7989..c50e6616d02c 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -17,6 +17,23 @@ struct freq_tbl {
 	u16 n;
 };
 
+#define C(s, h, m, n) { (s), (2 * (h) - 1), (m), (n) }
+#define FM(f, confs) { (f), ARRAY_SIZE(confs), (confs) }
+#define FMS(f, s, h, m, n) { (f), 1, (const struct freq_conf []){ C(s, h, m, n) } }
+
+struct freq_conf {
+	u8 src;
+	u8 pre_div;
+	u16 m;
+	u16 n;
+};
+
+struct freq_multi_tbl {
+	unsigned long freq;
+	size_t num_confs;
+	const struct freq_conf *confs;
+};
+
 /**
  * struct mn - M/N:D counter
  * @mnctr_en_bit: bit to enable mn counter
@@ -138,6 +155,7 @@ extern const struct clk_ops clk_dyn_rcg_ops;
  * @safe_src_index: safe src index value
  * @parent_map: map from software's parent index to hardware's src_sel field
  * @freq_tbl: frequency table
+ * @freq_multi_tbl: frequency table for clocks reachable with multiple RCGs conf
  * @clkr: regmap clock handle
  * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
  * @parked_cfg: cached value of the CFG register for parked RCGs
@@ -149,7 +167,10 @@ struct clk_rcg2 {
 	u8			hid_width;
 	u8			safe_src_index;
 	const struct parent_map	*parent_map;
-	const struct freq_tbl	*freq_tbl;
+	union {
+		const struct freq_tbl		*freq_tbl;
+		const struct freq_multi_tbl	*freq_multi_tbl;
+	};
 	struct clk_regmap	clkr;
 	u8			cfg_off;
 	u32			parked_cfg;
-- 
2.40.1


