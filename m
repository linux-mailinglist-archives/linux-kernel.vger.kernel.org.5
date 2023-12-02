Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026EB801DCC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjLBQgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjLBQgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:36:35 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3B6102;
        Sat,  2 Dec 2023 08:36:41 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r9Syn-0002Wz-R7; Sat, 02 Dec 2023 17:36:33 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, Sam Edwards <cfsworks@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Sven Rademakers <sven.rademakers@gmail.com>,
        Sam Edwards <CFSworks@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
        Lokesh Poovaragan <loki@gimmeapis.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix Turing RK1 interrupt pinctrls
Date:   Sat,  2 Dec 2023 17:36:31 +0100
Message-Id: <170153497984.380580.16625087945958405832.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231202071212.1606800-1-CFSworks@gmail.com>
References: <20231202071212.1606800-1-CFSworks@gmail.com>
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

On Fri, 1 Dec 2023 23:12:12 -0800, Sam Edwards wrote:
> The pinctrls for the hym8563 interrupt line and fan-tach input
> were both mistakenly defined as `pcfg_pull_none`. As these are
> active-low signals (level-triggered, in the hym8563 case) which
> may not be driven at times, these should really be pull-up. The
> lack of any bias results in spurious interrupts.
> 
> Fix this by modifying the `rockchip,pins` properties as necessary
> to enable the pull-up resistors.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix Turing RK1 interrupt pinctrls
      commit: 9f6acd2b4dfef81dcc45486ac704cf602c88db02

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
