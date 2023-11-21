Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BFF7F2556
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjKUFgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjKUFgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:36:09 -0500
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEBC123;
        Mon, 20 Nov 2023 21:36:04 -0800 (PST)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx0.riseup.net (Postfix) with ESMTPS id 4SZCll3nPKz9vYH;
        Tue, 21 Nov 2023 05:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1700544963; bh=q692EMLiwWELVU5OazHP7MapPL7Sxk2dJzZRLS2Ag4c=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=K4LotakTbKKCdDu6ADKLldOTo6VrHU9LGkO5jn9dWnUyBBRBjaMgje2EmKfqXZFNw
         vJtX05PU58RFxzqLBvowUqu6y703vx465Klrme9oX+fWC8/p7GUUJ2+5VItw26nX33
         /bfM5n/wud3ITyFqusC3PaiuyqYzhxQ+humCiKgE=
X-Riseup-User-ID: D16D4989A101DBCC556D80F18CDBD3CF8A70E5B6A8F7F11519A499B2BB92C079
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4SZClh67VgzFrxv;
        Tue, 21 Nov 2023 05:36:00 +0000 (UTC)
From:   Dang Huynh <danct12@riseup.net>
Date:   Tue, 21 Nov 2023 12:35:02 +0700
Subject: [PATCH v2 4/4] soc: qcom: socinfo: Add PM8937 Power IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-pm8937-v2-4-b0171ab62075@riseup.net>
References: <20231121-pm8937-v2-0-b0171ab62075@riseup.net>
In-Reply-To: <20231121-pm8937-v2-0-b0171ab62075@riseup.net>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Dang Huynh <danct12@riseup.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8917 and PM8937 uses the same SUBTYPE ID.

The PM8937 is found in boards with MSM8917, MSM8937 and MSM8940
and APQ variants.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 drivers/soc/qcom/socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 51e05bec5bfc..37692fc1aefb 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -93,7 +93,7 @@ static const char *const pmic_models[] = {
 	[22] = "PM8821",
 	[23] = "PM8038",
 	[24] = "PM8005/PM8922",
-	[25] = "PM8917",
+	[25] = "PM8917/PM8937",
 	[26] = "PM660L",
 	[27] = "PM660",
 	[30] = "PM8150",

-- 
2.42.1

