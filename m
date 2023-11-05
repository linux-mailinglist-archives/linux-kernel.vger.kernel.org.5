Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A437E169C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjKEUt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjKEUsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:48:18 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C57E0;
        Sun,  5 Nov 2023 12:48:15 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2AA585C00B6;
        Sun,  5 Nov 2023 15:48:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 05 Nov 2023 15:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mai.rs; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1699217295; x=
        1699303695; bh=D+GTzLQFmpfIZebnBHKmLneCEhVlPIP7ZLa4jOj3Qhk=; b=F
        cgbn1EgO+ZN/Ku5AhJwVNvrRBZMAE2GVgtjAo5dWFmBoF2SK7OGspGM/IG9yTVBr
        dyTAUQduSv7nRR0E+LhCm+SvGcFF4y9EWvigCgX8Ipou/bmIEW9+OGc9XKCcQVtl
        TJ/0QXN0uSFVWYloHCrTnSN3QXcV7K8vlaoihxTcyE9VNntzOrc91ofBA9vJS+1q
        WwkeiRetH/fJ2jyvh/xftE4Z5Y9UaAlZTCnMQ36mcy13e1Q9ZhBIzXlFITGnk24a
        M+TP4d+Ub9ofYQ8zCSnMTe9vUQv3ieavgafceG70DxSbeLsLDjOoEKBXHcQlcM+O
        OjOPbAr891frLjRq0e77w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1699217295; x=1699303695; bh=D
        +GTzLQFmpfIZebnBHKmLneCEhVlPIP7ZLa4jOj3Qhk=; b=Yi2kMvP44eqkWUEsb
        pk/wBH9onTmESYr3nUT4MQNlvp3L3lcLl7Qs7o9wa7WJLKDhFLjZQEyfBLsjWcOd
        DQqPodZSXkCh2VBTM/V5hchDFauiyj3GOiy4KSfkkc+4EbLVoihV/YRPoAozWqCu
        xY1ak03vNOfI52UtYvFBQsyaIAiOlzF25msYgwZok76n5WpZg2i7yl8w43xIoghw
        Dhhd0mGAdqBQ+Nw3ux0SMYCBtkTf+O8CKZgd7WpehVZjSSogIEiQYpZslKEjFUGM
        cqoYFJxJoVyAkvh5ENva00Z7rdDuipue5NL7iHTN+SWN/2Q7MF+4xcVegxw0INZS
        wA/tg==
X-ME-Sender: <xms:jv9HZeJeO4iqRLHTk5ElgHXPVh_fHO-YmGkOJmJ596P2xXWFPojhJA>
    <xme:jv9HZWKO1BQzH5XV2tRCZzpaEvHdciaxHzJB-d1z4JQJgDAXXAwMOSmPqW9Sag8Mj
    GVf0rfDBpRi6IqKvg>
X-ME-Received: <xmr:jv9HZesDJQz_MZggRgYZZa_ywcP6_onOqzHcYb8ZOEKU0AqRHM7CFpXLPYDrknc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduvddgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehrhigr
    nhhtucforghirhhsuceosghrhigrnhhtsehmrghirdhrsheqnecuggftrfgrthhtvghrnh
    epvdegkeekkeehffehveeltdekvdfhffejuefgjeelfeefgffgleekheeffefggeefnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsghrhigrnh
    htsehmrghirdhrsh
X-ME-Proxy: <xmx:j_9HZTY5zxjMPCpYG6ru11WhEF0ZarcplAjO_MZNerEpppWM4CvUaw>
    <xmx:j_9HZVakrYtfiPszQtvl19j_xbXP8ElTRoIV-mg1vI-0yIhBRinbVA>
    <xmx:j_9HZfDYwg5LfGzhLAxDs4NeB7E4W7xq441NXbOOpeFV8Xwvih6ozg>
    <xmx:j_9HZST4vRnt-OqF1RqWOlA0wuPtTDjGO-Kys9B7ekwBBrSGcuUzpg>
Feedback-ID: i891b436e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Nov 2023 15:48:13 -0500 (EST)
From:   Bryant Mairs <bryant@mai.rs>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH 6/7] ARM: dts: qcom: apq8026-samsung-milletwifi: Enable Wi-Fi and Bluetooth
Date:   Sun,  5 Nov 2023 21:46:21 +0100
Message-ID: <20231105204759.37107-7-bryant@mai.rs>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231105204759.37107-1-bryant@mai.rs>
References: <20231105204759.37107-1-bryant@mai.rs>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Wi-Fi and Bluetooth support for milletwifi. This device
uses the WCN3660A that is already supported, so it only needs to be
enabled in the DTS.

Signed-off-by: Bryant Mairs <bryant@mai.rs>
---
 .../qcom/qcom-apq8026-samsung-milletwifi.dts  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts
index 910e8d2f69b0..57f50af487c1 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-milletwifi.dts
@@ -310,6 +310,28 @@ touchscreen@48 {
 	};
 };
 
+&pronto {
+	vddmx-supply = <&pm8226_l3>;
+	vddpx-supply = <&pm8226_l6>;
+
+	pinctrl-0 = <&wcnss_pin_a>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	iris {
+		vddxo-supply = <&pm8226_l10>;
+		vddrfa-supply = <&pm8226_l24>;
+		vddpa-supply = <&pm8226_l16>;
+		vdddig-supply = <&pm8226_l24>;
+	};
+
+	smd-edge {
+		wcnss {
+			status = "okay";
+		};
+	};
+};
 
 &rpm_requests {
 	regulators {
@@ -557,6 +579,13 @@ tsp_int_rst_default_state: tsp-int-rst-default-state {
 		drive-strength = <10>;
 		bias-pull-up;
 	};
+
+	wcnss_pin_a: wcnss-pin-active-state {
+		pins =  "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
+		function = "wlan";
+		drive-strength = <6>;
+		bias-pull-down;
+	};
 };
 
 &usb {
-- 
2.41.0

