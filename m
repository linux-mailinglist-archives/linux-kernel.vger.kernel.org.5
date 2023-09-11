Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD5D79BD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbjIKUzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243768AbjIKRmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:42:17 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13020CC;
        Mon, 11 Sep 2023 10:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694454122; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LJxcdjoBR7m4kZllUmnlGCpHFwlrPzBSMUB+gLhnwLGN1OmIs6573h5QZsVrnyJH3Q
    nWhDKnS7JMUCpp0yoNDrzqM6TVbbSMCxUAKEjfg0MkTins+tP7HmnVMPyeDHyE/aVhZD
    o6E2iRDfRuE4FNe4S79rLq44D4E9pmk8/zbwu8Tfj+B06vDYxzjZ3pvRre6EoQfM+xV5
    W+Vc8xeNxjDKGqyMOddI9PZM9oaX8mjyTUV3/o/UT38sGsHV+SFW04/CYrGUkxJAWwUe
    bWYdRHwMijkyNBVgM83t8UmQgC9/xKqGK+QyU1DlqlFGhJReN017POMBLoV10NGRNv9w
    Ld4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454122;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=lUGpYNu9vK0a8TgiT4snvzLq3GB+8pMHx5fquZ+AOBY=;
    b=jQkzLlsKNGMCXJCwaXZ4UUZLP8v6Ql2hZz99RIwcH5LT0BaE4BTVsHL2ek+hHaSOBE
    ZGOokN7DFu8aCbnjVRUXONg66ThbAUYpFE5fKZ/UmygCHgECXMj4OXVT+owY5djtpQY5
    rRIYCObgsd/twv3AjByBQBhw20OVelchiChOjFF7FeAtL1JtjiNcKyxaryJfbKL4pQVA
    Z6o/maRPosRyTenVpzYE9EFk+uqHnveRSFHEEMN+Pp16R+edTmUdcObMF00/2UYDPkvQ
    bO/0/c0d2xLekfsBIk5oLD7LYBE2ZThXLzPAwNRqOMM2p5uoh9I7LNkLoXfNh6nPCC5Y
    Hykg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454122;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=lUGpYNu9vK0a8TgiT4snvzLq3GB+8pMHx5fquZ+AOBY=;
    b=KmLNmdAXVR3yk+XOGz+oSY3WoD9Tv0S9AjJCElEmrDcg3A02nqhOQlVP0T+xXxSeaP
    4Ihvr6gG87ggp9c2lkxCoKKZF+YJq86J/AY2J8oIkkwFM/IYDiZBXBL8M9kOuHSXICzN
    DF+XRjq/VNIB3KwXocrja7XPGZX93h6TLAJlYYcGjcZSjYBEkBhAkohRysuRVp9rrz+1
    R4GKi5U9EwaDnmjMwp51awUwWadMDK9oA+g9KCt31PcvYMpfTrHOAs4efLRPyKt1k8Kz
    2+EfSXnz1l9kQ/z4D+QCwYoGGGOEuUMqh/PNVYoKh157oOim0zhAK3UPT8evaccEhgtK
    gw0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694454122;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=lUGpYNu9vK0a8TgiT4snvzLq3GB+8pMHx5fquZ+AOBY=;
    b=5Li5ibQq5eWB+dXaKfKbiRBl/0grvZ24b8reXKziFbwtTVK8zdSj+ShcFMURNE614u
    g0d0N7idhdo/lyIliHBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l38TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8BHg1awK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Sep 2023 19:42:01 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/9] arm64: dts: qcom: msm8916/39: Reserve firmware memory
 dynamically
Date:   Mon, 11 Sep 2023 19:41:42 +0200
Message-Id: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFdR/2QC/x3MQQqAIBBA0avErBPUwKyrRIvSmZqFFgoRiHdPW
 r7F/wUyJsYMc1cg4cOZr9ig+g7cucUDBftm0FIPctRShBzspIxIAYMga4nI7M6jh5bcCYnff7e
 stX4LyF+6XgAAAA==
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the MSM8916 and MSM8939 device trees to make use of dynamic 
memory reservations for the firmware regions, rather than hardcoding 
fixed addresses for each device. This allows to keep most of the 
definitions in the SoC.dtsi while defining the board-specific 
properties (such as firmware size) separately for each device.

The main motivation for this patch set is to simplify enabling the 
modem on the various MSM8916/39 devices. The modem firmware size 
differs on almost each device, which requires redefining *all* of
the firmware reservations with newly calculated addresses to make
room for the larger modem firmware. I've explained this in detail
in a previous RFC:
https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-4-3bf68873dbed@gerhold.net/

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Stephan Gerhold (9):
      arm64: dts: qcom: msm8916: Disable venus by default
      arm64: dts: qcom: msm8916/39: Disable GPU by default
      arm64: dts: qcom: msm8916-ufi: Drop gps_mem for now
      arm64: dts: qcom: msm8916: Reserve firmware memory dynamically
      arm64: dts: qcom: msm8916: Reserve MBA memory dynamically
      arm64: dts: qcom: msm8939: Reserve firmware memory dynamically
      arm64: dts: qcom: msm8916/39: Disable unneeded firmware reservations
      arm64: dts: qcom: msm8916/39: Move mpss_mem size to boards
      arm64: dts: qcom: msm8916/39: Fix venus memory size

 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           | 25 ++++++++++++++
 arch/arm64/boot/dts/qcom/apq8039-t2.dts            |  8 +++++
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts   | 12 +++++++
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts      | 12 +++++++
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts     | 12 +++++++
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts | 12 +++++++
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts     | 12 +++++++
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 21 ++++++++++--
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts      | 12 +++++++
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     | 12 +++++++
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts      |  4 +++
 .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts      |  4 +++
 .../dts/qcom/msm8916-samsung-e2015-common.dtsi     |  4 +++
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  | 12 +++++++
 .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   | 12 +++++++
 .../boot/dts/qcom/msm8916-samsung-serranove.dts    | 12 +++++++
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          | 33 +++++++++++-------
 .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     | 12 +++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              | 39 +++++++++++++++++-----
 arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts    |  4 +++
 .../dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts  |  8 +++++
 arch/arm64/boot/dts/qcom/msm8939.dtsi              | 37 +++++++++++++++-----
 22 files changed, 288 insertions(+), 31 deletions(-)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230720-msm8916-rmem-f88fff6bcded

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

