Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB9477AFFE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 05:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjHNDZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 23:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjHNDZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 23:25:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD1110;
        Sun, 13 Aug 2023 20:24:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60412627C0;
        Mon, 14 Aug 2023 03:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F346C433C7;
        Mon, 14 Aug 2023 03:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691983498;
        bh=/bu/WuVeJxbijSOtw87ZrCKMpUaEl76x4Ae61pzaQOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVZ4FMZxtZ6lydre+Slcr4pkQbQ1cpgqn6O0bIBErgSImZerHym4WQrIP4+/FRHLp
         u8wlx2SNmMuYWWfBHVBeDo2BdTHqjeXUlU2r6Th9B5CpzJNvv/djRuBKkEvnxJCl5O
         p7mFVS+TMjiwdvWk+2XjBt+79SG5+iZiDFvhj05D0I4klUDN4W9PC0QD04+eiPkfN+
         wSAQocJLKe3HrSnsOky+FmMzdJBUDUK7nhQHwnFAlnlR5P3xjpnMxjw9FB1oib8Y0N
         oWSVNkmhheFpuh8tHHPQDdIUyS4dTSZYuW+PxPxrXijLEuCud75x2C8mlk1cBzTGeU
         Hyzd/KsDNEqdw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] apq8016: camss: Update dts with various fixes
Date:   Sun, 13 Aug 2023 20:27:29 -0700
Message-ID: <169198364300.2443702.3144815688296653635.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811234738.2859417-1-bryan.odonoghue@linaro.org>
References: <20230811234738.2859417-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 12 Aug 2023 00:47:31 +0100, Bryan O'Donoghue wrote:
> V3:
> - Fixes licensing boilerplate error in d3 mezzanine - Stephan
> - Moves regulators into d3 mezzanine - Stephan
> - Drops redundant enable of camss in d3 mezzanine - Stephan
> - Declares ports in core dtsi - Konrad
> - Adds R/B for assigned-clocks - Konrad
> 
> [...]

Applied, thanks!

[1/7] arm64: dts: qcom: msm8916: Define CAMSS ports in core dtsi
      commit: 349a13a1e735ef84ff1af8e56a1309171f86f989
[2/7] arm64: dts: qcom: apq8016-sbc: Fix ov5640 regulator supply names
      commit: 43a684580819e7f35b6cb38236be63c4cba26ef4
[3/7] arm64: dts: qcom: apq8016-sbc: Fix ov5640 data-lanes declaration
      commit: 3652866ff493db60e2f767bd751fe15c1b4bd37a
[4/7] arm64: dts: qcom: apq8016-sbc: Set ov5640 assigned-clock
      commit: 775d2f3f76b1de6d440d6071c61023ea71d88f69
[5/7] arm64: dts: qcom: apq8016-sbc: Rename ov5640 enable-gpios to powerdown-gpios
      commit: 4facccb44a82129195878750eed8f9890091c1b8
[6/7] arm64: dts: qcom: apq8016-sbc-d3-camera-mezzanine: Move default ov5640 to a standalone dts
      commit: 6823df31587707f5534663f04f80e40df3e709c4
[7/7] arm64: dts: qcom: apq8016-sbc: Enable camss for non-mezzanine cases
      commit: c27c73bb560bae279deae8cd94554832cee88116

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
