Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D391C7F5CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344831AbjKWKxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjKWKxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:53:31 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DE719D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:53:38 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5488bf9e193so966332a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700736817; x=1701341617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXU3VapMuxm+OHdxhm9E3FdyezzmvFUHPr+Qvx5uEeo=;
        b=QM309kAienokpnpMnpRk5RILwOw1ElKVysXWlN2kf0MIbTWDJpIyIRAHigSH9BJLgb
         mVYHqeVFUBBNI40tkfn9ZGUV/RTz5wwGNZ2xGzEhl1ED9zaeSq9fKpamyL4QKmcKzdn4
         V3mcCqZKdShBTTvR/dQsBBlLz3f4FSDPYhyW6MxbWQW4d1OPYq4n0xEhCY8q/LFTjyyv
         seqze9/nVtK6n3IIjZGWNacnfGTfzVr62TVQv1yp3FGgG/ozBpsJQ+1unxYttksa5oET
         AvW9YCC4Z9i6nOHEQk4q9+rvAltq0lln9TuGWPvHJVpzFAk19caYUr+QwxMrI1h9/NzK
         R/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736817; x=1701341617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXU3VapMuxm+OHdxhm9E3FdyezzmvFUHPr+Qvx5uEeo=;
        b=Lak7g7+cEG2o+vz7bMCuHs+tNpumDuDsYsQHNYAxtJst4k45jJ4vvrEouJcJzHk0fv
         2n2DuB+N5RKOu/YD2MFi151u8/I6nDeIAxHymHXpYJVvTyzV9mZvenq3Dlc4u9D2W1aX
         +9D4+Se6GCyFHWB8r/LYMYwLJ0M55m7VRdWAY4QbQ8jeejCX2lTJFAjyxaI0e0uA2xZq
         BAnQv/PJcYd4ctga/h5ehY2UGf121Y1/fc+wCQL5Fln1oYfWCql1L3QJELy0Phc6jg6E
         wrtQf8has7edJ4MXsW6mUlyd62QjauRjKmESqMKTFSAfk/8bCgO/zmK8Qs+skKi92g5f
         aCxQ==
X-Gm-Message-State: AOJu0Yyq+r53OneLBMRk2tH98cc+mHQWi5EolRvWGmmeOjapqWUDZEVo
        ZUQweouv/J7d1Od/jqFMoIUXRg==
X-Google-Smtp-Source: AGHT+IGJB4AU8eFOfo2dYz6wrhqCVEFEhT1IVtkxagyVUOc+WtZFn2exlewHWw/fxkDvma7X5xvmyQ==
X-Received: by 2002:a50:871d:0:b0:543:b9ae:a0d5 with SMTP id i29-20020a50871d000000b00543b9aea0d5mr4060236edb.4.1700736816809;
        Thu, 23 Nov 2023 02:53:36 -0800 (PST)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f18-20020a05640214d200b005486228190dsm513130edx.42.2023.11.23.02.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:53:36 -0800 (PST)
From:   srinivas.kandagatla@linaro.org
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.de,
        yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com,
        krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: qcom: set controller id to hw master id
Date:   Thu, 23 Nov 2023 10:53:32 +0000
Message-Id: <20231123105332.102167-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=ljBkIaNKS9KdRWAJPNWyfkmMFwRfm1vJDp7GGFK8o1k=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlXy8oclKJu3tGkmYiZnaZIA+W3UyQgpfftPMlP bVZZGYkp02JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZV8vKAAKCRB6of1ZxzRV N1wEB/9jIGoxEIeqSJm3JoDJr1R5p6OjuWizPPXlshOzrcaVQStrtBAxIGaAUtyK1KsuXwGvB/u XyKG83pSf+tf6A7bpTG9ofIfrvgpv+KBIWFASzpiIp+5prGNH3HnY7hv6vXJ8wlGrgWCMTBy3Wv bTdqX6FoM853lIt8N/SLcOJw0abDNujzTCypJK4q8t/CyR//lPcoR3lxIpmRkKeXwo5PnzN8eez +UVDbO/4bmTZVOIm8w6QRS3+2FLQJVCyWH5LEQ1hSKYv7MUZQyi19ho1BCctX7VuUKloSJqio+e JPXO21e2J/p0rhhDJx3ABqNdj4v/8Y8GZ9r3EyaSnFge/8Fr
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Qualcomm Soundwire Controllers IP version after 1.3 have a dedicated
master id register which will provide a unique id value for each
controller instance. Use this value instead of artificially generated
value from idr. Versions 1.3 and below only have one instance of
soundwire controller which does no have this register, so let them use
value from idr.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

This patch depends on "[RFC PATCH 0/2] soundwire: introduce
controller ID"
https://lore.kernel.org/lkml/4815c8d6-635d-415c-9e02-4e39e92a3d6d@sirena.org.uk/T/
patchset.


 drivers/soundwire/qcom.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 8e027eee8b73..48291fbaf674 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1624,9 +1624,13 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* FIXME: is there a DT-defined value to use ? */
 	ctrl->bus.controller_id = -1;
 
+	if (ctrl->version > SWRM_VERSION_1_3_0) {
+		ctrl->reg_read(ctrl, SWRM_COMP_MASTER_ID, &val);
+		ctrl->bus.controller_id = val;
+	}
+
 	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
 	if (ret) {
 		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
-- 
2.42.0

