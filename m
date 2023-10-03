Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E97E7B6A1A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjJCNSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjJCNSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:18:50 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6306FA1;
        Tue,  3 Oct 2023 06:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696339124; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NuJc32Qgcf/R9KCLq0zXtrk67XNqWNKhoXIojXg91E7m5haFPeKCZKL3FYAVmRBU85
    WgKBhr1VHBUJLZOzbLdCRpuOa3Lt6BealM7r9BMzLncVG3T6L0FmgzKVwcBOYucMgpjh
    Tr3s+4gCxGeqfazGr2l3OHldil3baik5bGJuTLrP1iMLP6s8oA8ptr5Id7wQzeKx4YrJ
    rmQ5GaHGsXLKa0xq28kIHD7WDpLBoaRANTNeuPhpZD0Lel18teKuV5N7DIRDjcdY/SWo
    CE4kgB61XHtcpfqYYiajN/spA7jdKRbVRi/02pg5l2yxdww9nrxYCPl5kd0NdOxdlgw8
    SXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339124;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=y/6S4nMoO4T7ksu2UG4ZmhUfqYCihjRfVEMaHE5bdN8=;
    b=JowxvgwaZxb57wCfjeWY4Neu/8MlcolGYrj7AO4O14t0PyckCdtJG0sS+XKBjABdAN
    JMszYVG42YlmRAm9r1jAOo+QtIVkoP1fsBKDx6zL8MZOjyZjXNIVCB+bq0C3cknVTctO
    SOFHn5LJb6wxoxDRKhAZyycXce0x2KFtn4tB0K6C5U0QgZ7cM9drEMoe17fLd7H8sMEJ
    Y0HQhh8YOmkmIZFn/ndCokBnRwxHgY5XfplhNNwOn9wC6/wuDekqTwRwFrg0TyIwMfdJ
    TbHXXeMMGorMQbmUjJO6zvsIo4zrgCydx0QSFW74GHil4We1oM01BJmHdlGAYeC4BIUg
    HvBA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339124;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=y/6S4nMoO4T7ksu2UG4ZmhUfqYCihjRfVEMaHE5bdN8=;
    b=pnX4wGgt7JHaZdlGiIFyQy7kWkFzcI809bTEuVu+N9e4BUcnrfXuiUpU+aG2ZX3bPm
    zGGe9TDEs6lH9962fyhfFhUn0Gg5m0OuiYSMwF+GBwe0mTl2QRXgy+t+mUtbexeeVHQ0
    kwRS3nRgDLnAD+iXDWFF/6l82cMWKebOb+65TFGlYTWMwCKVFR39alETwLUwn1WaOQrp
    PQW9KO18Dgpw9Q+pUZK0IRbq3Aar9Hms1LGNKiGFiPl9bVC1QFW1lE4AQ7agL6AOPJia
    rGRM5oe8zff9XDV8YHaNidWigRxvrGBiF+2rBlDlCFllq2QTB1KOx1A04uf7hVMcMXZJ
    gO7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696339124;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=y/6S4nMoO4T7ksu2UG4ZmhUfqYCihjRfVEMaHE5bdN8=;
    b=RCtyPs/vV4FkdKcPUJfWnPZFz4j7a2E+F/H0bIap5b2bnXKwvJG5+T81EQQ/WYhNPK
    +ln6FbWUrHH/eh3aTdDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z93DIh2OC
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 15:18:43 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 00/14] arm64: dts: qcom: msm8916/39: Enable sound and
 modem with QDSP6
Date:   Tue, 03 Oct 2023 15:18:18 +0200
Message-Id: <20231003-msm8916-modem-v2-0-61b684be55c0@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJsUHGUC/13MQQrDIBRF0a2EP67FmGK0o+6jZBD1JwpViwZpC
 e69NtBJh/fBOztkTA4zXLsdEhaXXQwt2KkDbeewInGmNTDKBioZIz57IXtOfDToCTVCcS1mtYw
 c2ueZcHGvw7tPra3LW0zvgy/9d/1J/E8qPaFkkAJRjxc1a3lbMdn4MOeAG0y11g9wk7SerAAAA
 A==
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
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v2:
- msm8916-modem-qdsp6.dtsi: Add some missing new lines (Konrad)
- msm8916-modem-qdsp6.dtsi: Avoid unused template nodes (Konrad)
  - Refactored/cleaned up dai-link nodes a bit to fix this
- Split up msm8916.dtsi and msm8939.dtsi QDSP6 patch (Konrad)
- Clarify purpose of &lpass node with a comment (Konrad)
- Move around status properties a bit for more clarity (Konrad)
- Link to v1: https://lore.kernel.org/r/20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net

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

Stephan Gerhold (6):
      arm64: dts: qcom: msm8916: Add QDSP6
      arm64: dts: qcom: msm8939: Add QDSP6
      arm64: dts: qcom: msm8916: Add common msm8916-modem-qdsp6.dtsi
      arm64: dts: qcom: msm8916-samsung-a2015: Add sound and modem
      arm64: dts: qcom: msm8916-samsung-serranove: Add sound and modem
      arm64: dts: qcom: msm8916-wingtech-wt88047: Add sound and modem

Vincent Knecht (2):
      arm64: dts: qcom: msm8939: Add BAM-DMUX WWAN
      arm64: dts: qcom: msm8916-alcatel-idol347: Add sound and modem

 .../boot/dts/qcom/msm8916-alcatel-idol347.dts      | 171 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts     |  21 +++
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      |  31 +++-
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts      |  52 +++++++
 arch/arm64/boot/dts/qcom/msm8916-modem-qdsp6.dtsi  | 148 ++++++++++++++++++
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     |  71 +++++++++
 .../dts/qcom/msm8916-samsung-e2015-common.dtsi     |   4 +
 .../boot/dts/qcom/msm8916-samsung-grandmax.dts     |   4 +
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  |  54 +++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts |  22 +++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts  |  42 +++++
 .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   |  14 ++
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts    |   4 +
 .../boot/dts/qcom/msm8916-samsung-serranove.dts    |  13 ++
 .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     |  74 +++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  49 ++++++
 arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts    |  70 +++++++++
 arch/arm64/boot/dts/qcom/msm8939.dtsi              |  79 ++++++++++
 18 files changed, 920 insertions(+), 3 deletions(-)
---
change-id: 20230922-msm8916-modem-0d8b6c8abf76

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net> 

