Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8608D7B9680
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243994AbjJDVc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjJDVc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:32:58 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69C8C0;
        Wed,  4 Oct 2023 14:32:54 -0700 (PDT)
Received: from i53875a3c.versanet.de ([83.135.90.60] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qo9UB-0005RF-08; Wed, 04 Oct 2023 23:32:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Conor Dooley <conor+dt@kernel.org>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ermin Sunj <ermin.sunj@theobroma-systems.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: use codec as clock master on px30-ringneck-haikou
Date:   Wed,  4 Oct 2023 23:32:42 +0200
Message-Id: <169645508392.141514.933069936235927740.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907151725.198347-1-jakob.unterwurzacher@theobroma-systems.com>
References: <20230907151725.198347-1-jakob.unterwurzacher@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023 17:17:15 +0200, Jakob Unterwurzacher wrote:
> From: Ermin Sunj <ermin.sunj@theobroma-systems.com>
> 
> If the codec is not the clock master, the MCLK needs to be
> synchronous to both I2S_SCL ans I2S_LRCLK. We do not have that
> on Haikou, causing distorted audio.
> 
> Before:
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: use codec as clock master on px30-ringneck-haikou
      commit: 84fa1865edbb3800f3344e2a5bc73c187adf42d0
[2/2] arm64: dts: rockchip: set codec system-clock-fixed on px30-ringneck-haikou
      commit: 1e585cd0aad3d491938230318d6d479f09589fd8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
