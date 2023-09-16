Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CBF7A31A1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 19:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbjIPRPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 13:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjIPRPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 13:15:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31CFCEC;
        Sat, 16 Sep 2023 10:14:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31c5a2e8501so2936145f8f.0;
        Sat, 16 Sep 2023 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694884498; x=1695489298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVZXsVyggnQQBeZou9kqJ/xLa3R34SntugSTM7Apkww=;
        b=P5kdAw7ql1QkWx1/CtNEWvHq7epAEqKcwLAEsGqZCt+Qe7OJkf5G0h/oL9bsceOhCK
         GWKkPNDxzCYxyLA+jvT8dAJMvfcMGJM8UI+GNlM0ApoxZ5JLxV77QC3y4GaBjyScbkUw
         VwVzoJUxkXjupj6IO/MgxGjoKWcuQcpz8Qeiw/cqV1fasFoVE6yAq4ULNJ8YbQwemP2O
         Hdh2y2Vz+N5sK8cM446v708eYuVje3fO5+10wAWqAZNMH9fhmORKjlktTbUHEb5tiRZj
         VnrlEbFq5NZkptcoL9SSP+gDJXb0ilaDJHA5Ham5pCpqTRoKcc0MFbwc0debdTf8cYV3
         Mmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694884498; x=1695489298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVZXsVyggnQQBeZou9kqJ/xLa3R34SntugSTM7Apkww=;
        b=PwtPQEq7SqfI9IWc+6T+IYuP+hYA82SgXiHDCbR1UipHbvdFsfAmMwh6aOqxFkqkGz
         sSV/XqWVtqi6+ckw9uoFIEQImSVNwNjSEWuzUe+JRz1VKw+6YQXt4tJAm9c7e2zTztrQ
         or+dhn39RxVessLRPMCkTjUdOcoKDBKsty4J8gr9tivHadC2lgAUn+KHxK9C9lppL9zf
         ejJjqZ6eESq9JcKnJtwjpISmDemENdBIaeF7aSI5FPAumVf/STg0mDY5ORQC2TKUAG8M
         nQKdXZoksQZAsVWLsXl9S1hq/g4scJhuyELMh0ZH0A1eyJmluggTcA2VlnurF2dXuaHG
         jzrg==
X-Gm-Message-State: AOJu0YwDcZtOmKY1QNWE4bj8FgBRSKMVtDJaxeBPXqEKAxerj0G6lfDT
        5H8lUBI0/osEmhsf7Wc47aE=
X-Google-Smtp-Source: AGHT+IGEOxr64dWy80O37qvohPSo6KmqFNR4Ouidxg0QkTTgOWK43xOc7mIgtd449FAcx/yukJxquQ==
X-Received: by 2002:adf:fb90:0:b0:317:e5dc:5cd0 with SMTP id a16-20020adffb90000000b00317e5dc5cd0mr3984009wrr.21.1694884497939;
        Sat, 16 Sep 2023 10:14:57 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id w4-20020a5d6804000000b003196e992567sm7712395wru.115.2023.09.16.10.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 10:14:57 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v6 1/3] clk: qcom: clk-rcg: introduce support for multiple conf for same freq
Date:   Sat, 16 Sep 2023 16:00:44 +0200
Message-Id: <20230916140046.7878-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230916140046.7878-1-ansuelsmth@gmail.com>
References: <20230916140046.7878-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index e6d84c8c7989..c81458db6ce4 100644
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
+	int num_confs;
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

