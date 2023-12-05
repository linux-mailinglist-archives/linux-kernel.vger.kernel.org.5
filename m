Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D56880430F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjLEAGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjLEAGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:06:05 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72D5FA;
        Mon,  4 Dec 2023 16:06:09 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rAIwt-0001qb-Qe; Tue, 05 Dec 2023 01:06:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: rk3399-gru: Fix PCI node addresses
Date:   Tue,  5 Dec 2023 01:06:00 +0100
Message-Id: <170173468936.501889.14178301756278206830.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130191830.2424361-1-robh@kernel.org>
References: <20231130191830.2424361-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 13:18:29 -0600, Rob Herring wrote:
> The rk3399-gru PCI node addresses are wrong.
> 
> In rk3399-gru-scarlet, the bus number in the address should be 0. This is
> because bus number assignment is dynamic and not known up front. For FDT,
> the bus number is simply ignored.
> 
> In rk3399-gru-chromebook, the addresses are simply invalid. The first
> "reg" entry must be the configuration space for the device. The entry
> should be all 0s except for device/slot and function numbers. The existing
> 64-bit memory space (0x83000000) entries are not valid because they must
> have the BAR address in the lower byte of the first cell.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3399-gru: Fix PCI node addresses
      commit: c13c823a78b77ea0e5f1f73112d910e259911101

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
