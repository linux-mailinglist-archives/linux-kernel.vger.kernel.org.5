Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1EA7617B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGYLyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjGYLwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:52:32 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B3F1FE3;
        Tue, 25 Jul 2023 04:52:18 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 390A1423D0;
        Tue, 25 Jul 2023 16:52:12 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690285932; bh=3k2gR2vQ7wl6XCxGkInLU9JSXp8L45oKI5wh9/mq4vA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kRO13KeyiDG20fc5F7sbt232/vvJykJFa4Xr/9YmJ3J8JQArGhrLhPGkTkeIb2929
         H4cssd/8XhllHIudfVNcu9+XWWlOcy8HJmlC7jgXbY9QOnN8OOctxuu22bXjqtT7nB
         dwBJijQLiqcttAOb6EZufEXTcKlgh7COuBt73r59ojrROcYeVtXE1oRqBmk4T130Y3
         x5V3MwpUketIFh1p9il71ukHQIFO406CV1G/ajHKm9QjkfLJEGmUqLJh8o1NxI7+ZL
         h6poECMVNCTL1+sEKFpbxWogsGU5mj3+jOWfM3DT4pOQG/Vh7ZtirvkGLy6gThjr+u
         A4UcOgdmlQLSg==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Tue, 25 Jul 2023 16:52:03 +0500
Subject: [PATCH 3/3] arm64: dts: qcom: msm8916-samsung-gt510: Add
 capacitive keys
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-gt5-panel-v1-3-7c787e33a614@trvn.ru>
References: <20230725-gt5-panel-v1-0-7c787e33a614@trvn.ru>
In-Reply-To: <20230725-gt5-panel-v1-0-7c787e33a614@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=696; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=3k2gR2vQ7wl6XCxGkInLU9JSXp8L45oKI5wh9/mq4vA=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkv7dmplqdzYFcPD6jpKMCerTluMZZldhW+sxO8
 eu6HNpKIyCJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZL+3ZgAKCRBDHOzuKBm/
 df+aD/9mdqwAm0e2xSmsBUc0f92pce+kzB4Bm6DRQ9uUS5GKzPbh0N4KFmI668wJ22OFeMyWpDR
 IOiiAutdzydtdiKkmanwVomBd/7X8PqXUcrmap+/DhypkP1m0beK3cYDSJX6LlshDL3HFx5iExj
 DDH4Sce9gpFah2YlXMydk9g8G/hBmthJvefCN18Thx3BPGRdVlgl68fBycAkeMn4dOsfBT++QbB
 SmxuVeNWdhHmUCU13kZ/ZtvzJOx18M9GzKVCJ24kQYeeu0IyRBge39EXQ+kGZsI3Dy99nSjhBWL
 xHrgVyAQBeJZAGOElEW0GZztzc34KBPYn0EAuqmKjb1s89miMoqd1J9PdjNYTvRoDxPBwKVdumy
 aiqCl962SDRdJT3EmOW/12CbOWDoedOKfvahl9uynigHPBockM19SaACIEprgrr6uS+3C9ipjSc
 qlWbCX4rro6Qq4WO9plOIUHwqrmjCeyINEgk3wYBlYVtoRD61V7o3pDR0rLcrdTiGvsAvOP2MVr
 4euEldwGIG5tNi9xn6crsMVOmZK16HH85UP0TnzD4yk00GQFAM4H4C9BAd23XOnbH0IO2bsllJS
 omar3wFL1puGIgZ+fNBMgXD8CqVGRlT16TZOZ0Dx9W6uYLgAeuUWgzmGUA5Wn3AbQm9y3y8AvaF
 E8yjEPP6973Qo8w==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gt510 has two capacitive keys on the bottom. Define keycodes to enable
them.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
index a73cc7565bfb..75c4854ecd64 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
@@ -107,6 +107,8 @@ touchscreen@4a {
 
 		pinctrl-0 = <&tsp_int_rst_default>;
 		pinctrl-names = "default";
+
+		linux,keycodes = <KEY_APPSELECT KEY_BACK>;
 	};
 };
 

-- 
2.41.0

