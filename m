Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1FA7AF149
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbjIZQwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbjIZQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:52:04 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB046127;
        Tue, 26 Sep 2023 09:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695747097; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WU2lwHCMZgk1EsprLFii7WasIJeI/SMV3MhuNkXSajOE5YN+LFJqgDhnx8TaF1OgaY
    Sw5G3hlOvW/whA/lY6PEhLViumKmHL1bnT9Ujg8+tE0HqOlb0gz44fXNa9C3D8SI/YKy
    1GOI07LiOm1OoeDN4HR+MCkpb5EUjdGy5Ab3xa8X4qAqbjbmDgzZQGz5kWe44vG6QVR/
    54lf6N7OVjQKBXBZCPzDcLVQ8g8b+FyzA9MJr1NCV7mLUNWdcUMzjDCQgO4lZttwuQhN
    GQaPtXDZ6Kkpk/enZPzRnG+Sidpuc7zzkUOdx0E/aPETkcJBJ5Xv8VieE4GQ4c9s2dTK
    2bBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747097;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=yRLM5+8bfAKKkXJ6kvgTOc046sJD+dLfqkmxoa1P6AY=;
    b=knjqHNWnCjg+YVLkne4HPUszVr3VsIXAgTNLRlq+UUKZq9BgDqAHVSmcsCJKIX3R1u
    wKLshdW1Sge7aZ26CgyaYTxlptBoXJBvUvDykEHZsv28+AcBilhZAFgz00K8gnmnzxvc
    kno8tHZLOT+dZZnMiSuYQFFuLJvsL6u9InwnDx67hG2jzvdyi3+5gdlKyFJMYhMc1JS3
    IVfOp2sdIUEo1vra3+t05IGyvAazRm+9xBgEINsp1sredDricTRnwUZXUbARl5XNngQg
    9wN64caIMDV8JTl/w78LpK2yDc5hGQdG6jCxgSRJYxUISNqZXfErhmXFvzZfV4rGZI73
    Zz/Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747097;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=yRLM5+8bfAKKkXJ6kvgTOc046sJD+dLfqkmxoa1P6AY=;
    b=m9O3S61HgTh+EYajqFOLWQx5OSiKcSNXkSTc9aFJmzPPFsqbgbN0mLWDI2JC2lAuCR
    zkzP8CKJMUf7n5WmL5Dfyfcd4DFcuT3metFCC54aXoMZRkBTbIu4DvH7jbfOQsTA70JV
    74a7FAElDEHQ5JVeFp3448SbQrDFQqrhUgk6jrW35a88o3M+9mSPs1Ha8bPo7KP4qpKV
    h8fPgPFO3W96vef64WpvAkNoEl6DdsigM4NGGb/lYecsNrf/mgwJZ83NFDi009HfetBB
    mbq0Z7KZYiWEvBOUkyLsOwq4zAkxmL8r2QGiIlm+Vw9Fvvxc75rk+Ibq8Z7vWSz7I8ps
    6Qjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695747097;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=yRLM5+8bfAKKkXJ6kvgTOc046sJD+dLfqkmxoa1P6AY=;
    b=V/g6IdamHickOiFoCad98wOmkVTORBHTDf01aV6CvNE/24HDY+ZFVrhFMexJFzT4zo
    TxpXYzlP4Bm0ViuvIoAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH+nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QGpag5X
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 18:51:36 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 00/13] arm64: dts: qcom: msm8916/39: Enable sound and modem
 with QDSP6
Date:   Tue, 26 Sep 2023 18:51:14 +0200
Message-Id: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAIME2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSyMj3dziXAtLQzPd3PyU1FxdgxSLJLNki8SkNHMzJaCegqLUtMwKsHn
 RsbW1AEQ4kNlfAAAA
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        "J.R. Divya Antony" <d.antony.jr@gmail.com>,
        Nikita Travkin <nikita@trvn.ru>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sound and modem on most of the MSM8916/MSM8939 
smartphones/tablets supported upstream by:

 - Adding the BAM-DMUX DT nodes to msm8939.dtsi for WWAN Internet
 - Adding the QDSP6 DT nodes to both msm8916.dtsi and msm8939.dtsi.
   This is needed because audio must be routed through the QDSP6 
   services provided by the modem firmware when the modem is active.
 - Setting up the sound/codec related nodes for all the devices.

Most of the sound/modem setup is very similar on all MSM8916/MSM8939 
devices because the device-specific details are abstracted by the modem 
firmware. Reduce duplication by adding "msm8916-modem-qdsp6.dtsi" which 
contains most of the common definitions. The board-specific DT part is 
limited to extra codecs or board-specific sound setup.

With this patch set, the following functionality works on most 
MSM8916/MSM8939 devices supported upstream:

 - Sound: Speaker/earpiece/headphones/microphones
 - Modem: Calls, SMS, WWAN Internet (e.g. with ModemManager)

And with extra pending patches also:

 - Voice call audio
 - GPS

These patches have been contributed by different people and have been 
used/tested in postmarketOS for several years. Until now they had to 
wait for other changes to be upstreamed (QDSP6 audio support for 
MSM8916, dynamic reserved memory, ...).

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
J.R. Divya Antony (1):
      arm64: dts: qcom: msm8916-asus-z00l: Add sound and modem

Jasper Korten (1):
      arm64: dts: qcom: msm8916-samsung-gt5: Add sound and modem

Jonathan Albrieux (1):
      arm64: dts: qcom: msm8916-longcheer-l8910: Add sound and modem

Lin, Meng-Bo (2):
      arm64: dts: qcom: msm8916-samsung-j5: Add sound and modem
      arm64: dts: qcom: msm8939-samsung-a7: Add sound and modem

Nikita Travkin (1):
      arm64: dts: qcom: msm8916-longcheer-l8150: Add sound and modem

Stephan Gerhold (5):
      arm64: dts: qcom: msm8916/39: Add QDSP6
      arm64: dts: qcom: msm8916: Add common msm8916-modem-qdsp6.dtsi
      arm64: dts: qcom: msm8916-samsung-a2015: Add sound and modem
      arm64: dts: qcom: msm8916-samsung-serranove: Add sound and modem
      arm64: dts: qcom: msm8916-wingtech-wt88047: Add sound and modem

Vincent Knecht (2):
      arm64: dts: qcom: msm8939: Add BAM-DMUX WWAN
      arm64: dts: qcom: msm8916-alcatel-idol347: Add sound and modem

 .../boot/dts/qcom/msm8916-alcatel-idol347.dts      | 164 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts     |  22 +++
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      |  32 +++-
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts      |  54 +++++++
 arch/arm64/boot/dts/qcom/msm8916-modem-qdsp6.dtsi  | 163 ++++++++++++++++++++
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     |  55 +++++++
 .../dts/qcom/msm8916-samsung-e2015-common.dtsi     |   4 +
 .../boot/dts/qcom/msm8916-samsung-grandmax.dts     |   4 +
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  |  36 +++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts |  23 +++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts  |  43 ++++++
 .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   |  15 ++
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts    |   4 +
 .../boot/dts/qcom/msm8916-samsung-serranove.dts    |  14 ++
 .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     |  76 ++++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  49 ++++++
 arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts    |  54 +++++++
 arch/arm64/boot/dts/qcom/msm8939.dtsi              |  79 ++++++++++
 18 files changed, 888 insertions(+), 3 deletions(-)
---
change-id: 20230922-msm8916-modem-0d8b6c8abf76

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

