Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173567D0161
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346386AbjJSS0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjJSS0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:26:18 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DF6AB;
        Thu, 19 Oct 2023 11:26:14 -0700 (PDT)
Received: from i5e861907.versanet.de ([94.134.25.7] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qtXim-0006n2-UV; Thu, 19 Oct 2023 20:26:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, Sam Edwards <cfsworks@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Edwards <CFSworks@gmail.com>,
        Lokesh Poovaragan <loki@gimmeapis.com>,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
        Sven Rademakers <sven.rademakers@gmail.com>
Subject: Re: [PATCH v2 0/3] Add initial devicetree for Turing RK1
Date:   Thu, 19 Oct 2023 20:26:11 +0200
Message-Id: <169773987935.1461852.15123065300008221603.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011225823.2542262-1-CFSworks@gmail.com>
References: <20231011225823.2542262-1-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 16:58:20 -0600, Sam Edwards wrote:
> This is the second version of my patch to bring in support for the RK3588-based
> Turing RK1 SoM. In my previous cover letter, I perhaps should have specified
> that the RK1 is a little bit unusual in that, though it *is* a true SoM, it is
> targeted toward home-hosting/edge users directly as a compute node, and as a
> result the vast majority of users will be seeing it more like a
> micro-bladeserver, rather than an off-the-shelf part meant to power a larger
> system. This was my rationale for previously sending this as a single .dts,
> targeting that use case.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: vendor-prefixes: add turing
      commit: 817bacc3a648cc55a0b07a699c03ecc70309ae50
[2/3] dt-bindings: arm: rockchip: Add Turing RK1
      commit: e30ecfcbe4ed3706af67dff5aa1418fba6ba2c29
[3/3] arm64: dts: rockchip: Add Turing RK1 SoM support
      commit: 2806a69f3fef61d7353ea8206add8ffb15064b51

I've dropped the mem-supply references from the cpu nodes.
I think some at Collabora is working on upstreaming the
cpufreq driver that will utilize those.

Until then they are not part of the binding, so please add
them via a new patch once the cpufreq support has landed.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
