Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6871375E183
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGWKzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGWKzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:55:10 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0E8E5E;
        Sun, 23 Jul 2023 03:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690109688; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OEfz+orufQY5cNmm9G8cBvw3W9YITgCTUgrEp2xPjb2T/hMeSfVMecjc6+iQle1Aoz
    aFOCyKseHlRk2/iOJ7UOLV25mR3gqaVZ/W9LO9KFjb8Hv2PgirV6kdxkoKsKJCpdRB7y
    /F6a0TfsKgh/Ko2LxEm8iwMYEhyEo3nsIdfmJnMIjnRZcwa/tQ/OTAmRsLh0nODgoDKq
    68cgFmDSzeG7NLXvab6/lOWdE14FuWdpHCZt66VIDVULrL+Pyyt/GgC3qfMIyMWk8243
    yB3DcbCx/HYN1RF60eh6I+TdHpCRWomPmtu+/P5IOmOfAmQoEEFiS1Rkj6aGJLmk5yBH
    6fFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690109688;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=hF+ms8Lsly9Hr5pKQvnSnpwWb901GZ6/p89DrvqLNj4=;
    b=lwFhVt3Y43SSTRpu+rqYj8LoAMV+vnEH5tM/NcyLWGjevGarxJRKlpfg3Rrld5bwtt
    2icGalVi+or98QaqAqHILNB4h80T7gCTuFT6HJSaF6eO1GMyi9Gkc5zxStzZPcyaa7BK
    BKlcTAip/KWwxDhHliMrP0Ge6VDgJIFxgWV+CYE62TXTjQ00I+ZPO4PM3O/Ac+8QSqnS
    Z78uANMACRRBmWuH/jsenH6X1jkUB4SeIOz6NmnWRPi/5fIPbVKQmAuEDY7lSpDcAXLA
    nzX2m03EtUX1DZsnMdFx5Y7FFER20oekJVhVHgovWvMVkMARHjFjp4TjPVptYYRerUVm
    2afA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690109688;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=hF+ms8Lsly9Hr5pKQvnSnpwWb901GZ6/p89DrvqLNj4=;
    b=ebaBJQzx5qwYb3vEJDYsZWYGQGe0/tbxtTHWljV3mzyahghdXoiKQACUFjBUDT+PAJ
    /+jQlUSdjek08nKKupzlhSBCMXwJsBGwdCaZUOl4Ln9TOBEB6vrUL4Aj/QIWo1MfbUyh
    Ci30Dn/nMD24qAisInfn3tMiGLWsrK8W4QrzFQ7zwe4BSNFzzN0OdfE907vPvf3xB/qt
    uM5BvUTRTD9HtGFSchSs3qSB45v2UKMSJ/4ZTdzOTRHjfUS/UqhqXAozt3UhZTERSFYm
    uXomph+wPV/1frTTCM2xoynOLv2Ntz8dJQ22kVt85ERB363b07mMXSvXdLCL0/JFXuN5
    7J9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690109688;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=hF+ms8Lsly9Hr5pKQvnSnpwWb901GZ6/p89DrvqLNj4=;
    b=DlaVvywo25M4p8k4h55cYLz4NUQ4lbg9sAKvwepMKacujF81FdLNBjLguiJX7zHxPz
    BCiXeY5O47MXm+vA6sDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l38TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.4 DYNA|AUTH)
    with ESMTPSA id V0b383z6NAsmCdU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 23 Jul 2023 12:54:48 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Sun, 23 Jul 2023 12:54:41 +0200
Subject: [PATCH] arm64: dts: qcom: msm8939-samsung-a7: Drop internal pull
 for SD CD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230723-a7sdc2cdnopull-v1-1-699fd730afcb@gerhold.net>
X-B4-Tracking: v=1; b=H4sIAPAGvWQC/x3MTQqAIBBA4avIrBP8CYyuEi1MxxoQC6UIxLsnL
 b/FexUKZsICM6uQ8aFCZ+qQAwN32LQjJ98NSigtjNLcmuKdcj6d1x0j17iNzvowBRmgR1fGQO8
 /XNbWPpF5JS9gAAAA
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A7 seems to have external pull-up for the SD card chip detect (like
most MSM8916/MSM8939 devices) so drop the internal pull-up. It's not
necessary.

Tested-by: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
index 66e56ac59998..ba652909d162 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts
@@ -448,7 +448,7 @@ sdc2_cd_default: sdc2-cd-default-state {
 		pins = "gpio38";
 		function = "gpio";
 		drive-strength = <2>;
-		bias-pull-up;
+		bias-disable;
 	};
 
 	sensor_i2c_default: sensor-i2c-default-state {

---
base-commit: 34e472f41d9cd04400b80649ce82cfe11fbe135a
change-id: 20230723-a7sdc2cdnopull-3eb4cadf8f1f

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

