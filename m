Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D600F803013
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343953AbjLDKVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbjLDKV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:21:29 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE4AF2;
        Mon,  4 Dec 2023 02:21:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701685291; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=b+HyazTPNVzckwREw47xO2W+5XlGhZAn8V2HVeKO2TiUzP7kMCLoL77u6VArhKTNZD
    Bp99uzciG6+m4TUO8cTiwdMl6s6W+ACN8Wa0AoFTp8yLPw7NKORF7tEWO3BfpsdgS6W5
    mUD873HkLHZK2ay/MGpS8WoLsPk3NUZdkYmeiPBnP1QFeKUB49C2rZ9zEU9gAsimhXBL
    iyNGkvADMU3hxJ3JOCQ999nqy+VdlVShnnVqOFwPwEYSmqcn1LzCDdHs46ahal7EIkuW
    NCSsAVSLysV5lwL3iB1h3Mor0UDjNvB+FvaKuddCPyO3ULneCV1QNMKjg6UfE0Vl9gqP
    t1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701685291;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=5iAsS5XB58/f5cNCz7T2RBsklGCxCrx47QuQO5tkpEE=;
    b=jZgRzl6eiMaVMtx4crTj8mr1Ce3Yb7i5S1B49HqWUgD1Ira2Y4gXGTOPlDHTJL/A/p
    VFFwUk8TqEV3Wl0M5+TELgkzS20mbTI7C/dNdil5acdwlV3l4d5ZLqXw4zNH3zxErSz/
    3GjM1ZA9NbLDqAvxH23/Exii6MyE59nHvKmOI6n7RHvDpxOdRm5KZMeYwrQu72UetIp5
    0qykm+aomVoL4iS+Rm2cbbt9OtIJXZkOOMIE2qPzI6DQadZTXF1n8aousvrNvB3pLnBx
    OzOsuTHckuKhIbynMi8N5HLJQYOPx1cg9s1ListUF5l82n7/tGbLsUYSD921Hi95iICU
    9EtQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701685291;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=5iAsS5XB58/f5cNCz7T2RBsklGCxCrx47QuQO5tkpEE=;
    b=h8Vf8qTuHU5vlVnXkVH0RgvMrOK7AT+b6DWrjyLpIsn4F0pJsyU1UFu2XGc+Ykuwl7
    og0/CqHN/FHfyrhpc+xTmkx2t2qAHdE0kDoE1u+E8UsN7RoW8hTBAN01ynfwet/HJqA0
    ahh5OQe4pPtv2cDqfHvvJvdLXV5J7lJ3F5uCMW1r+oZpnNWzA+qCOs6FaPbSwAJy3QgU
    kAckF5Jzg2Lv+EfSJMUPL+kBMuyryJ41NvVkg1Blt5G3oHTu6fOI40BlW38rfcY0nOu9
    lDwcK7HCKWX8Ebi3z1hdeqT1+yWztPDKf07ClbvQm5xEwddPFe2jB/T5jM4ja6ua1KUj
    QpaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701685291;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=5iAsS5XB58/f5cNCz7T2RBsklGCxCrx47QuQO5tkpEE=;
    b=qKmkwMwZro24yl69YazgJWDTsVr7txPj+OdCB9sebKYroROyxnNqueurDg81/hYS+y
    89ZlfhXjmxyHKihdQNBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.9.7 DYNA|AUTH)
    with ESMTPSA id R5487bzB4ALVA1w
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 4 Dec 2023 11:21:31 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/2] arm64: dts: qcom: msm8916/39: Make blsp_dma
 controlled-remotely
Date:   Mon, 04 Dec 2023 11:21:19 +0100
Message-Id: <20231204-msm8916-blsp-dma-remote-v1-0-3e49c8838c8d@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB+obWUC/x3M3QpAQBBA4VfRXJsy6ye8ilwsO5iyaEdS8u42l
 9/FOQ8oB2GFNnkg8CUq+xZBaQLjYreZUVw0mMzkZLICvfq6oQqHVQ903mJgv5+MJVVuqq0dS0M
 Q6yPwJPd/7vr3/QBoeMepaQAAAA==
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blsp_dma controller is shared between the different subsystems, 
which is why it is already initialized by the firmware. We should not 
reinitialize it from Linux to avoid potential other users of the DMA 
engine to misbehave.

In mainline this can be described using the "qcom,controlled-remotely" 
property. In the downstream/vendor kernel from Qualcomm there is an 
opposite "qcom,managed-locally" property. This property is *not* set 
for the qcom,sps-dma@7884000 so adding "qcom,controlled-remotely" 
upstream matches the behavior of the downstream/vendor kernel.

Adding this seems to fix some weird issues with UART where both
input/output becomes garbled with certain obscure firmware versions on
some devices.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Stephan Gerhold (2):
      arm64: dts: qcom: msm8916: Make blsp_dma controlled-remotely
      arm64: dts: qcom: msm8939: Make blsp_dma controlled-remotely

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 1 +
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 1 +
 2 files changed, 2 insertions(+)
---
base-commit: adcad44bd1c73a5264bff525e334e2f6fc01bb9b
change-id: 20231204-msm8916-blsp-dma-remote-516df8aac521

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

