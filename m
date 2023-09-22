Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AC07AAFEF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjIVKu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjIVKu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:50:26 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6726AC;
        Fri, 22 Sep 2023 03:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695379816; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PyfkQ2CJJo4r5UL55sqaXwzAE7PnEhZx9OfgNEyVfoLba9ol53fbpt5Y0NZr3MSNd3
    PuB1nGROD800A9laJH7IYEf8D89DvkKE0tK6/VIPYMpK064XIyEFKHC0czw2xEfJYfkw
    LwagCTlF27bQ6ziuwLonmWeWzI57La7GGk25Qhndvdlpjm2mfYy7gVFH3R87fNRqY3qE
    QnA3/zI2wbGf0VoslwnMzDRxZctRb44Ik7VuT1gNSORZku88X1zoyBguoCUDhsjR4G7g
    J0VA0iZ+mgRDaZphx5JIoxm6zCXNpTQKTXviKyztbnv3uc5h2eo7wR6M7NPgswH1ewA3
    YQ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695379816;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=MBmy+6PAEVsZIeJOyaTNzolxAAyu/OIriMDq4k6N6nA=;
    b=O0gAbB+MZCmr4L72TPGUP6V5GTHMMRQwAJWmcJ+GO1Gy9qCWoIUReMDnMkKpA9VFWy
    jkw/hqgeGWQd+KZtF0rYbi+pOLryw/VBZktvB/nxtHQObeVApAHi1YDjyFDMQcOPGeNr
    bz5QHMxcbR/MVLES087wY2eTyjlGV9CO2tF0ZliR+3KzC0vW+ms4ADCcjN9GI01AOVAG
    AwqbpL4rtrCElmmNGf4gqkGAHPe3cKrKPNsHrYgalmKJDlGxrMH/WSM39qM72TYz9Q5a
    76Emq0uEcdbXtzLePvIadBWOrjIcerh8a1EnrLbZTkNcByDYXaAnErrdPuelb1joLxmE
    SmIw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695379816;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=MBmy+6PAEVsZIeJOyaTNzolxAAyu/OIriMDq4k6N6nA=;
    b=U5NLr5i1ELb9DsLIWmw4m/eTQppGkvaA1NPKvk0o53RiXHMKE0wMm2f7+tP9GU8hip
    LEVO5dCsZYK2tZpOxhJ4kkU81dogIf+aXB4ZzKV8M9JcUMSw95AUrFfD86FyhzNa313g
    k6BOZbysIbuJH2bODtZ+eLvDu5Eu86GMscsbc8fLo3IBXHvhH18I7P3muH87VCzRNLaQ
    6HHtbOpBO48GSIyOQ1SDc31LQ5Dj0rrWAJLnEgKSCK2BcxV0uYBUyC7f0P2bO/k8rDRs
    Bc2KOFy5YbYgjpJto6BzdjPLAWXl1OH+YNsI5pivi/cefY8lWbNIQj8tb8Jc5ytud7+y
    Ul0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695379816;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=MBmy+6PAEVsZIeJOyaTNzolxAAyu/OIriMDq4k6N6nA=;
    b=7k6GyjYOOZIrcufc6fC5Wp5zXKzqY50GVi0rklMhsU42xg+4ihbmpznLs3zv4GI8Ab
    Yu3VDymQiDqI7ziU2ABA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8MAoFTnM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 22 Sep 2023 12:50:15 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Fri, 22 Sep 2023 12:49:55 +0200
Subject: [PATCH] arm64: dts: qcom: apq8016-sbc: Add missing ADV7533
 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-db410c-adv7533-regulators-v1-1-68aba71e529b@gerhold.net>
X-B4-Tracking: v=1; b=H4sIAFJxDWUC/x3MQQqDMBBA0avIrDswSdqm9iriIppRBySWiYog3
 t3Q5Vv8f0JmFc7wrU5Q3iXLkgrMo4J+CmlklFgMlqyj2lqM3dNQjyHu/uUcKo/bHNZFM37q8CZ
 vHA0mQul/yoMc/3fTXtcNHDbbaGsAAAA=
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing regulator supplies to the ADV7533 HDMI bridge to fix
the following dtbs_check warnings. They are all also supplied by
pm8916_l6 so there is no functional difference.

apq8016-sbc.dtb: bridge@39: 'dvdd-supply' is a required property
apq8016-sbc.dtb: bridge@39: 'pvdd-supply' is a required property
apq8016-sbc.dtb: bridge@39: 'a2vdd-supply' is a required property
        from schema display/bridge/adi,adv7533.yaml

Fixes: 28546b095511 ("arm64: dts: apq8016-sbc: Add HDMI display support")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 3c51f891029e..9ffad7d1f2b6 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -172,6 +172,9 @@ adv_bridge: bridge@39 {
 		pd-gpios = <&tlmm 32 GPIO_ACTIVE_HIGH>;
 
 		avdd-supply = <&pm8916_l6>;
+		a2vdd-supply = <&pm8916_l6>;
+		dvdd-supply = <&pm8916_l6>;
+		pvdd-supply = <&pm8916_l6>;
 		v1p2-supply = <&pm8916_l6>;
 		v3p3-supply = <&pm8916_l17>;
 

---
base-commit: a35461d47fe3e555602912b905f1bae7045256eb
change-id: 20230922-db410c-adv7533-regulators-89a607130f1d

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

