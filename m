Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5549F7A9E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjIUT7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjIUT6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:58:43 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2689C72428;
        Thu, 21 Sep 2023 11:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695322581; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Af0kNSkUIApYMW7jR2nJgT9wxojCBucsRZBp+Vb6ZVML328uVEZl5KWVRsSKfOK6Zc
    TuZaZ7ubvcx5LgLED7ZxSDLa2o14HsCHKdTwGxay3BRGmsSTRhZB1bzSg9E4Ob6gbKGl
    kSt4dPhoLexNS2MokU41DLXr5Eseun8dMKPLp6WJXmQA/oZlA/TcmZqabs58esg7yhIw
    0bRgk1nf29CR239HnCR2I7/S95AKmyAL6l9aVKlQBIfWnuIp16cSyA4jzTl4z99zWd9k
    flBByvs4zVVBjG1zNXR1EygkEnO27rTG1OFlqm4lk0+UbgDMtvohp9MEgmY79/Cd8As2
    y3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695322581;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=k3VeNueovqwvAeOtbPbFknTbbRAKphS4vEK7X7L7wHQ=;
    b=nkw01R8YKzWcEGXUkZE0Aa9OEk9EJm5Z4jWCK0bEHZwydEedD4cGi7vvqE/iRU4cDz
    RGj61uvbMNM7faXDc4DHSbbXWCdnACI7fO+QMWQOHUvwXRksGIaaQIVXRsk29olAxWN0
    gHYVdINPv20fMBF15pTPmb90oMpHHjbyN5W647pUYAh8/Ghvoee2UxSvKM7Fqy5k7WlD
    WdUl/WIy4SMAvC7/x0WZK+/JJqTYZNhzhvBftdkRgKD1NHksRBe6eare4J8U/xXscjrK
    3KWZfzf8ylgVdlWMtAuz2O5Ow1+MAn1dgJgaomLW4WToK2R2+n457HRlETluZlFpk3/1
    CXEA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695322581;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=k3VeNueovqwvAeOtbPbFknTbbRAKphS4vEK7X7L7wHQ=;
    b=gRHNOThj80hRmZu8wjSMrj7VUOETuBnVzKvrP7QAvOraydeZbgqD76K+VC22QDJ+yj
    IcAeLyRd30/dQgU6RdxGcG3n8GhGVbvwpid1atSfQxgWijC+fxEMP1H18bsTAOE2e/nB
    6c030PQJ0WAV1jL5kt8ek2PNNPXap2UTdPt7wYiV3PdanLd1i6wRs1m7akt2Zn7TfrPp
    ntNY5sFIawnqP6QGYKQ9wqAxHkSRTjKc6ypFIO7dLTbqysF23ecqwrqJJaqeW0Ohk9q2
    z4v73x9kRnXC2hv8vZ8PYrthvxShZ6uvwfeb/ypXLzGaVWUzqWu8h0SwXaOdLGbZOcKz
    GDgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695322581;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=k3VeNueovqwvAeOtbPbFknTbbRAKphS4vEK7X7L7wHQ=;
    b=6hjDRegVapE8eu7LZIqKREGbBd4zQ9AaSG6c2gICci7xyO7AxzmQrIoB8f+uwdZ0oB
    craDQmTjPX36s3LNJsAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4p39TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8LIuKRRz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 21 Sep 2023 20:56:20 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 21 Sep 2023 20:56:04 +0200
Subject: [PATCH 1/3] arm64: dts: qcom: msm8916-samsung-gt5: Enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230921-msm8916-rmem-fixups-v1-1-34d2b6e721cf@gerhold.net>
References: <20230921-msm8916-rmem-fixups-v1-0-34d2b6e721cf@gerhold.net>
In-Reply-To: <20230921-msm8916-rmem-fixups-v1-0-34d2b6e721cf@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the GPU for the msm8916-samsung-gt58 and gt510 tablets now that
they have display panels enabled in the device tree. This was missed
when the GPU was disabled by default because the change was not applied
yet.

Fixes: 0ce5bb825d54 ("arm64: dts: qcom: msm8916/39: Disable GPU by default")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
index 75c4854ecd64..c3f1acc55078 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
@@ -112,6 +112,10 @@ touchscreen@4a {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
index 11359bcc27b3..998625abd409 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
@@ -64,6 +64,10 @@ touchscreen@20 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.42.0

