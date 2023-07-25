Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E79D762170
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjGYSdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjGYSdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:33:14 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC822129;
        Tue, 25 Jul 2023 11:33:14 -0700 (PDT)
Received: from [185.230.175.137] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qOMqD-0006Er-BR; Tue, 25 Jul 2023 20:33:01 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chukun Pan <amadeus@jmu.edu.cn>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        FUKAUMI Naoki <naoki@radxa.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix regulators and enable SATA on Radxa E25
Date:   Tue, 25 Jul 2023 20:32:58 +0200
Message-Id: <169030979754.2939984.9282914456412331786.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724145213.3833099-1-jonas@kwiboo.se>
References: <20230724145213.3833099-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 14:52:16 +0000 (UTC), Jonas Karlman wrote:
> Despite its name, the regulator vcc3v3_pcie30x1 has nothing to do with
> pcie30x1. Instead, it supply power to VBAT1-5 on the M.2 KEY B port as
> seen on page 8 of the schematic [1].
> 
> pcie30x1 is used for the mini PCIe slot, and as seen on page 9 the
> vcc3v3_minipcie regulator is instead related to pcie30x1.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Fix PCIe regulators on Radxa E25
commit: a87852e37f782257ebc57cc44a0d3fbf806471f6

[2/2] arm64: dts: rockchip: Enable SATA on Radxa E25
commit: 2bdfe84fbd57a4ed9fd65a67210442559ce078f0

As you can see, I've split them in two. Please check that I didn't
mess anything up. Having an "and" in the commit subject is always a
very strong indicator that a split is probably a good thing ;-)


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
