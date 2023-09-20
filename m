Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D917A8A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjITRK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjITRKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405CE1A5;
        Wed, 20 Sep 2023 10:10:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD70C433A9;
        Wed, 20 Sep 2023 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229824;
        bh=5jerPGNbcK9KNA1y+/GRylQgU81KiqAMsxmSHXO1ZY4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=klXnREVt9CDId2+UUdmcI9nssWMto2cM99O71tm4zWG0sOb2+9uVcbS0vUo8O3TP4
         T3nm7cXtVhE3PAPERM3jL0AyROJCENs3Ea0xyAPP9UHcaiI8IAkoNYy3Lsu41BsBBQ
         Hgv+yjIrDDoU2FViqNML5U62jwLtb0dsNyAXD7m72hkC9Gj3452v2J1giMEqDC6qg9
         aRp1AiKU6f0w19osS6OvuSH0Hfdh5XNyIbppExbhZk90FOh3MqlgpQEZ9hB8IJvTF6
         q4LB90wxZApxt4CxCLQvtKkJOpB1tZ9L5KDnNC6WHrxS8zCcJs5vO+bMO/tdyW/EcI
         EENd7JJ1Ozq0w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, arnd@arndb.de, geert+renesas@glider.be,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: (subset) [PATCH v12 0/4] Enable IPQ5332 USB2
Date:   Wed, 20 Sep 2023 10:14:10 -0700
Message-ID: <169523004948.2665018.13241458828978249111.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693468292.git.quic_varada@quicinc.com>
References: <cover.1693468292.git.quic_varada@quicinc.com>
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


On Thu, 31 Aug 2023 14:47:42 +0530, Varadarajan Narayanan wrote:
> This patch series adds the relevant phy and controller
> DT configurations for enabling USB2 on IPQ5332
> 
> v12:
> 	DTS:	usb2_0_dwc -> usb_dwc
> v11:
> 	Driver: Rebased to accommodate https://lore.kernel.org/linux-arm-msm/20230824091345.1072650-1-yangyingliang@huawei.com/
> 	DTS:	Sort nodes in alphanumeric order
> v10:
> 	Driver: Restore register success print per Dmitry's comment
> 	DTS:	usb@8a00000 -> usb@8af8800
> 		regulator_s0500 -> regulator-s0500
> v9:
> 	Driver: Since the driver code has been picked up for merge,
> 		(https://lore.kernel.org/linux-arm-msm/169226613917.81413.1200008047604336868.b4-ty@kernel.org/)
> 		adding the coding style fixes alone in this patch.
> 
> [...]

Applied, thanks!

[4/4] arm64: defconfig: Enable M31 USB phy driver
      commit: b46d856cb9b3bd2fef54cc8caec8595a232a23b6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
