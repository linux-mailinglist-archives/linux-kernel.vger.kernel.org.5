Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE29E7A8A48
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbjITRLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjITRKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68163CF8;
        Wed, 20 Sep 2023 10:10:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09614C433C9;
        Wed, 20 Sep 2023 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229827;
        bh=3DI+rP4GUZdEpq6Mx+GyUnkKuBAxvddDZMe26L5pzv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDteWq/Zl71f0bIOEjfc7emTrMVhYb56O+f/uiuL9VB6Epz+Urtxofo7EUxPjKvHN
         gguExDsyqiaDEmQhZTJ6vVgdqEb+BM5eC6+4QYv1kpjqYmrUf/XC7QRFzcDP7HYhtp
         J4ZHkBa4FjPrOkHg/p7BM3QCQpMnXXvr2hKp003uHE/oZPKJxXfXtZ3FJ8azOHxBUx
         xHGYez4KJm3YGjP+hZkA77t2p7bTc+IodRbCDOSSmgS9L0pIvlKZTb8KQuuy/eNhzm
         2Q2K4LuiSGcZaS+sqaIQrAID7taYdd2l7E7ZyM9UohOI9i7WrF8+iX2dsCZdp1vrb7
         aDyNs22CQXxQg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 0/9] arm64: dts: qcom: msm8916/39: Reserve firmware memory dynamically
Date:   Wed, 20 Sep 2023 10:14:13 -0700
Message-ID: <169523004970.2665018.7388281323259797805.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Sep 2023 19:41:42 +0200, Stephan Gerhold wrote:
> Refactor the MSM8916 and MSM8939 device trees to make use of dynamic
> memory reservations for the firmware regions, rather than hardcoding
> fixed addresses for each device. This allows to keep most of the
> definitions in the SoC.dtsi while defining the board-specific
> properties (such as firmware size) separately for each device.
> 
> The main motivation for this patch set is to simplify enabling the
> modem on the various MSM8916/39 devices. The modem firmware size
> differs on almost each device, which requires redefining *all* of
> the firmware reservations with newly calculated addresses to make
> room for the larger modem firmware. I've explained this in detail
> in a previous RFC:
> https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-4-3bf68873dbed@gerhold.net/
> 
> [...]

Applied, thanks!

[1/9] arm64: dts: qcom: msm8916: Disable venus by default
      commit: 29589248420766cd492e6db0632d6f59ec216e92
[2/9] arm64: dts: qcom: msm8916/39: Disable GPU by default
      commit: 0ce5bb825d54c904b217cc7f1131e084e02ed037
[3/9] arm64: dts: qcom: msm8916-ufi: Drop gps_mem for now
      commit: 40eb256e5fd1fd49813a27a252b7f45ccca89fde
[4/9] arm64: dts: qcom: msm8916: Reserve firmware memory dynamically
      commit: 0ed3d82862e8451cc2b14ddb1b064e72ba3e5a60
[5/9] arm64: dts: qcom: msm8916: Reserve MBA memory dynamically
      commit: b4f3a410061bf5a8cc148c9435479da580abf85b
[6/9] arm64: dts: qcom: msm8939: Reserve firmware memory dynamically
      commit: b22bef3dbc3a67a796f82f49a6df9e413211cb40
[7/9] arm64: dts: qcom: msm8916/39: Disable unneeded firmware reservations
      commit: 0ece6438a8c0492a7df036d57ac299500a25cb70
[8/9] arm64: dts: qcom: msm8916/39: Move mpss_mem size to boards
      commit: 35efa1be51bd6db067d7380b34538b17b9f250a8
[9/9] arm64: dts: qcom: msm8916/39: Fix venus memory size
      commit: e3c6386c6a5d0187f103fc9bf39850ac15c01690

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
