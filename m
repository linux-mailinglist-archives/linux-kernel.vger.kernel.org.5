Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC4A756371
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGQM4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGQM4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:56:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16162171A;
        Mon, 17 Jul 2023 05:55:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C27160FCE;
        Mon, 17 Jul 2023 12:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28389C433C8;
        Mon, 17 Jul 2023 12:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689598550;
        bh=Q7pKNk67CcMjZhU2BuR7aWDSbf0Q1N/8D9W5c7T9mi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CyzM2lrX2vhR7YURG51IIcmk7Pb/9k6qGXm2HGHRz+mFX7WF34G8ppatWSuyKQg8t
         9agezGE48OHI5jrr+9t24YNom5IPUvt+u+WpaL3OSSHfKcfDyvLlF9LCphgU3d2xxs
         FILKtierYhdlu5WRBUpJxNRFTHs69p6OAnnVmarOQvZVEXlsRKJUWc77O4eW8j3ZnO
         qI0BLIjy7unmw4puJyJVrTRvCo7ZC1/kXo+mdnLQDaeDZecVylkP1wZ0jaDF9JjWpH
         u0zF0aU6uYmFFSVkRvLHBNhkwlChnYPn8fA0EvJJ6iKA0wKLVm2/KrxZctsujCf80I
         nQn+W2YMPGA8w==
From:   djakov@kernel.org
To:     djakov@kernel.org, konrad.dybcio@linaro.org, andersson@kernel.org,
        stephan@gerhold.net
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] interconnect: qcom: icc-rpm: Explicitly return 0 at the end of the function
Date:   Mon, 17 Jul 2023 15:55:34 +0300
Message-Id: <20230717125534.2455745-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZLUdXBoMJdSzeZdq@gerhold.net>
References: <ZLUdXBoMJdSzeZdq@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Georgi Djakov <djakov@kernel.org>

Fix the following smatch error:
drivers/interconnect/qcom/icc-rpm.c:243 qcom_icc_rpm_set() error: uninitialized symbol 'ret'.

Fixes: 32846c4a8f2a ("interconnect: qcom: icc-rpm: Set bandwidth on both contexts")
Signed-off-by: Georgi Djakov <djakov@kernel.org>
---
v2: Just return 0 when reaching the end of the function. (Thanks Stephan!)
v1: https://lore.kernel.org/r/20230717073429.2115015-1-djakov@kernel.org

 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 612390b9eb18..2c16917ba1fd 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -240,7 +240,7 @@ static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 *bw)
 		}
 	}
 
-	return ret;
+	return 0;
 }
 
 /**
