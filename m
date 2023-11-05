Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85767E1694
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjKEUsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKEUsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:48:10 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628D6E1;
        Sun,  5 Nov 2023 12:48:08 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CF8405C00F5;
        Sun,  5 Nov 2023 15:48:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 05 Nov 2023 15:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mai.rs; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1699217287; x=
        1699303687; bh=kVEZlrszrjh9a3ZxV7/Ffc4AxMfllhy0++OOArIA+04=; b=n
        O/U4K+f4htAk4dJFQAgjWLq7W5oWbmytOCm+aDo89nHpHuAtukCFtiH1PY7YtKvn
        D62W30/vK47cUZC+Dy4f88cY8e5HTvDh8C6gfjpGVKgXH/fuJhf2tl3sY3ICRrq3
        6hQwBAk5r96o0m8LmT38PW0pqqv45Wf9FmNskns5KwPGx3fmx6L82HYsGHutYFVl
        6vih7QnLT3W50Cc92tcAPCu957KMxhDDsb3pH3Mc8Glyo/QfI5DyUhB9KyBgm+1d
        ZVCAiS00Y7gOtdXtPgFq4RnrEqpoXpT2/pl7CzoHLT5AzPOiqmghBgfq0SE/I3qX
        +YPWOO1AFB/u+yP/3YPSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1699217287; x=1699303687; bh=k
        VEZlrszrjh9a3ZxV7/Ffc4AxMfllhy0++OOArIA+04=; b=ZnoTPDg0WJqQwPS+L
        xP4QmJjVbuqw9l3wCncV5W5BvmZMiZ1r62emE9TDvTRcUig6aYxASO5bnS4b9RNf
        7vVXFtAd6EunMrm0SAfuiuPUpgBur3D8jzmpVVZar/widc1lqioDDfJGpp7hQB+i
        P5P13ANU/GJn2V50xJcZ9IbJrGnr94y+nOtuswZKfVMpvBF1v/whFBrx4h8W46WA
        IeVac9OnIC5O+WpFnNw57GynXytXjBxT6wgQtUGyI3/rFHeEjz2Pz1uGr3LjyQQw
        lDAMGfnbM5XFE5Nq0VT7o1IbAvV4OtFaBMZhm3CcfTn564zHl8c9RO8kzJ2YqBj2
        AtZrA==
X-ME-Sender: <xms:h_9HZevuYT-AFYabl0-DEZtivbonEc4VC8BnMdyM5yuKXGT1PgCuGQ>
    <xme:h_9HZTf480vhZT-w9lha4lCEeZEF7eGGxmBJ9LQnYRhQFMxSbeNX1PTbulgV328fe
    3KNqH7uhgvL7DyVEA>
X-ME-Received: <xmr:h_9HZZxx9gNohtR_5KFu3pWHXqfJwHWyLNjqsUamwb67qYFVV_9rRJkmsUDiIPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduvddgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehrhigr
    nhhtucforghirhhsuceosghrhigrnhhtsehmrghirdhrsheqnecuggftrfgrthhtvghrnh
    epvdegkeekkeehffehveeltdekvdfhffejuefgjeelfeefgffgleekheeffefggeefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghrhigrnh
    htsehmrghirdhrsh
X-ME-Proxy: <xmx:h_9HZZPzs2JK3yJ82Ur29H7jN52s9fHaS53-OQ3yKOGuZLANOVwE0w>
    <xmx:h_9HZe-LPPWUis9TW4VJ-qPbVaGDOWyYX53qXrDj5pEnP0MXp7eflA>
    <xmx:h_9HZRXrupNLt8NPVymSZHqB82yCrJDC9gawMC7RVfORedZwPPwfgg>
    <xmx:h_9HZf33KVauxl1602M7rq3-Kc6VPI07KtEQgfiE90dYDSooXpOtTQ>
Feedback-ID: i891b436e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Nov 2023 15:48:06 -0500 (EST)
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
Subject: [PATCH 2/7] dt-bindings: arm: qcom: Document samsung,milletwifi device
Date:   Sun,  5 Nov 2023 21:46:17 +0100
Message-ID: <20231105204759.37107-3-bryant@mai.rs>
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

Add binding documentation for Samsung Galaxy Tab 4 8.0 Wi-Fi
tablet which is based on Snapdragon 400 (apq8026) SoC.

Signed-off-by: Bryant Mairs <bryant@mai.rs>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 88b84035e7b1..c66980b79f59 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -156,6 +156,7 @@ properties:
               - huawei,sturgeon
               - lg,lenok
               - samsung,matisse-wifi
+              - samsung,milletwifi
           - const: qcom,apq8026
 
       - items:
-- 
2.41.0

