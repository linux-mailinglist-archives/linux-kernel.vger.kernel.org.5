Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42087C9B2E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjJOUDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjJOUDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:03:40 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53540C5;
        Sun, 15 Oct 2023 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697400213; bh=2ykxA5zzNJWAE+OoTTOfsNOtoZ0RYvFAtzV34C7L8Ho=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=XPnutBRuLZF+K0HCGwq4OvnYkOVs0vOPCn0mKcuV4sFSBJ9Iz5LC8WoNuGdk1j5lO
         v2f7nk9aVO/u9rA+hgC4/+BSozFEish58yScozF/Qv09ZjOFc6KDGE3oj1Saai5PZs
         Jgor3sBqz6RamxbhpeeAbXID5VBSgytZ0VKkS/lo=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 15 Oct 2023 22:03:07 +0200
Subject: [PATCH 2/4] remoteproc: qcom_wcnss: Add WCN3680B compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231015-fp3-wcnss-v1-2-1b311335e931@z3ntu.xyz>
References: <20231015-fp3-wcnss-v1-0-1b311335e931@z3ntu.xyz>
In-Reply-To: <20231015-fp3-wcnss-v1-0-1b311335e931@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Kalle Valo <kvalo@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=2ykxA5zzNJWAE+OoTTOfsNOtoZ0RYvFAtzV34C7L8Ho=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlLEWR1EdQQWFa0spDxB5Nq2eXKQrvzYfHimGBh
 88EaOpKOLSJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSxFkQAKCRBy2EO4nU3X
 Vj9ZD/9+ky5IFpL9cSPvYSEDGkwX+QREqSdT7eBH+Px1+POoBQe5sLUM2/GwEZFd1vp88/2aH3S
 e3nfs+I8w39H/VZSUvZ9twVBWbzswlS6bKnlm6DaHzwc5aTbox0oTs7yIy3MFFsMz+rNbHaMg3P
 VomVU3n6qrZsDYsB3nyibYw61epBl3XFqGD39mC0BioHpc/oyXdkhWkNRwvdv0CcKZNiVGeg5YH
 vFRr/Q/HrdnH1TX8dn4URV7MFAFbtA4poBEDaHLW2RokhnOMW5xbxwVFWZ2/03IUcZ7JCdX9bi6
 zthj3sV3v2i+r3qcbIzO31JRVxLrJoM/d+z4q5v+t4IEX+5elmkNKuWDd548Sezgi1gxdERD6oR
 OdcInOZrX0lFfhzH9sivg79PufDk0GIBn8CVjSjh1fJJcPd6hFMr8wII0kmtGd3oeryTLCmu6pV
 d1MJKtcTLJ+TzVvkOgSuReXqWpz1ofDkyJrbJzaky8WumnlAaz6S+eb3TKE1abh/gQmm4+QZOgS
 LJdnh8AOVr1GCbfj+ciX6UeX35f5FE7A5/MozYbU8BvDYqaDN+h00vEF+uyqVzgBJQEGXcgVlLO
 WuUdWqlx5ZhlCz/Cx8WkGHP/H1vStUntNoeqqxUK1rWZ5NFTU86x2J6uSITf5Wr+28tFDS8mWBv
 1cyLkonatMF0K/Q==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for the WCN3680B chip used with some Qualcomm SoCs.

It shares the same regulator setup as WCN3680, so we can reuse the
driver data for that.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/remoteproc/qcom_wcnss_iris.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_wcnss_iris.c b/drivers/remoteproc/qcom_wcnss_iris.c
index dd36fd077911..22acc609105f 100644
--- a/drivers/remoteproc/qcom_wcnss_iris.c
+++ b/drivers/remoteproc/qcom_wcnss_iris.c
@@ -99,6 +99,7 @@ static const struct of_device_id iris_of_match[] = {
 	{ .compatible = "qcom,wcn3660", .data = &wcn3660_data },
 	{ .compatible = "qcom,wcn3660b", .data = &wcn3680_data },
 	{ .compatible = "qcom,wcn3680", .data = &wcn3680_data },
+	{ .compatible = "qcom,wcn3680b", .data = &wcn3680_data },
 	{}
 };
 

-- 
2.42.0

