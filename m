Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30397A9EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjIUUOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjIUUOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:14:33 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8B36E44B;
        Thu, 21 Sep 2023 11:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695322580; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kwsFHd7dCNIN57VWN7QKM+BBB6VKJ/Uibh4NUM9H0XB9GxEg2DCO2D/mfezxAieNmp
    wyenxbyOBLch9mTzXyWZ3WG8qogeEDTSaRjVLqDLlrxYEOblGZgyGebvcBa7cS96Rhwa
    U0/jg9vF/MvmB1wMqG5iZU6Ofj6BHM66gm2POhDkeLzXynPHfyJWy+VbsnfL5CmniipG
    6H7Prkq724jjUOV4MnuRkwotcBS9lpwZpk6SGk1NnWj6rrvv2ll4DPZ/B1rKEdIFkkvx
    EdJ24yMRD8HnGcCq7sWhbMS7Rs0FEBzd2ypRI/L01GQlo6nE1IW2nxZe7um4768wXX/b
    TY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695322580;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=FOf+v/wwke3TzeouGqEc99A5tALTzvpovMJRRE6ypb8=;
    b=ob1WdY5UM8jZ05rlehHwRi+F5WbKQP3iWocUD6qCbZBe+dOvM1mta1ffWEAODcfYsb
    Bkjx3x0sL3pgaedaU2iDs/yTJv5+VPQbV15qOiNtJznnseqhO81MP1De/VBWtggPKS0G
    dogeiqIrtKrZ/98jwe+ThaJ4xBNPNrryG4Mx+n5wdzK0eP6On9AKGqrcE4IVTDUkTNFz
    aGw6G8zReVm/THYiAYsEAdHrIPXnk99BT3j+zR2ENUctyHoFt1w/GWZG/7cJQVbHoZzs
    KIBnOcFoRPfNRS/r9ug8CwlOcWkKMysUUPBKROB222SP90PycbvgrpgDLTlCsyYa04fB
    38IA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695322580;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=FOf+v/wwke3TzeouGqEc99A5tALTzvpovMJRRE6ypb8=;
    b=FPsTxJYj4YRGiCWPj5d5cCOlfeakn5s6F7H1aBePVJHPyJ7ZjvWe3IkS6mFoozYU+B
    sOp1km5C6g8zmT+F2HNIGOmnb2q1G6bPHm4QIFKoWOfuapwGgLxQk3jtskWxMzt4wKHc
    1A2N5yy6g98YCUOimXQ5bPETD++jVk9v8jhBIknLTiqQ/Hnuh9MXq0AqQB8/5SzRx9zQ
    XLiIlNNjDVAgHEnGNpaQMedy2xI9qe2Apu5o1J4nE2INpvCXS904PJRySbhzr5yih/AP
    D9OOthvq0+NgKGmLzLGS3YNiJbUGELzJZfz41YoVdYG9l2X7OFkaA86BKpWabHel168c
    IJNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695322580;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=FOf+v/wwke3TzeouGqEc99A5tALTzvpovMJRRE6ypb8=;
    b=JPFvhmCrerYgAMpUXBCZxOZ1dISBOPRMIAkDVGC6ADixzj9M4CFXu1qlkhtEVdCqxH
    el4u1VWgtUnE/942wlAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4p39TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8LIuKRRy
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 21 Sep 2023 20:56:20 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/3] arm64: dts: qcom: msm8916/39: Fix-ups for dynamic
 reserved mem patches
Date:   Thu, 21 Sep 2023 20:56:03 +0200
Message-Id: <20230921-msm8916-rmem-fixups-v1-0-34d2b6e721cf@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMORDGUC/x2MywqAIBAAfyX23ELaA+1XokPZVnvQwqUIwn9PO
 g7DzAtCkUmgL16IdLPwETKosgC3T2Ej5CUz6ErXldUKvXhjVYfRk8eVn+sUbDpyysx2ntoFcnl
 Gyua/DmNKH8FtMY9lAAAA
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable GPU/WCNSS properly in some MSM8916/MSM8939 boards that were 
changed after I sent the patches for the dynamic reserved memory 
allocation.

I have magic scripts that make the necessary changes automatically so 
I'm quite sure that I caught all new instances that need adjustment. :-)

Since my scripts only work properly on board DTs with sorted nodes
I also included a bonus patch to fix that in some of the MSM8916 DTs. 

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Stephan Gerhold (3):
      arm64: dts: qcom: msm8916-samsung-gt5: Enable GPU
      arm64: dts: qcom: msm8939-longcheer-l9100: Enable wcnss_mem
      arm64: dts: qcom: msm8916-*: Fix alphabetic node order

 .../boot/dts/qcom/msm8916-alcatel-idol347.dts      |  8 ++---
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts      | 10 +++---
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  | 38 +++++++++++-----------
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts |  4 +++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts  |  4 +++
 arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts    |  8 ++---
 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts  |  8 ++---
 .../arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts |  8 ++---
 .../boot/dts/qcom/msm8939-longcheer-l9100.dts      |  4 +++
 9 files changed, 52 insertions(+), 40 deletions(-)
---
base-commit: a35461d47fe3e555602912b905f1bae7045256eb
change-id: 20230921-msm8916-rmem-fixups-46ec18b9ba5d

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

