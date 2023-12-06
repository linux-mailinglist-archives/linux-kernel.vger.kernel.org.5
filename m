Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF77806AEB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjLFJmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLFJmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:42:08 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0558BA;
        Wed,  6 Dec 2023 01:42:13 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rAoPv-000077-Ju; Wed, 06 Dec 2023 10:42:07 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sam Edwards <cfsworks@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Joshua Riek <jjriek@verizon.net>,
        linux-rockchip@lists.infradead.org,
        Sam Edwards <CFSworks@gmail.com>,
        =?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
        Sven Rademakers <sven.rademakers@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] arm64: dts: rockchip: Fix eMMC Data Strobe PD
Date:   Wed,  6 Dec 2023 10:42:04 +0100
Message-Id: <170185570321.596796.2043963859516585499.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205202900.4617-2-CFSworks@gmail.com>
References: <20231205202900.4617-2-CFSworks@gmail.com>
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

On Tue, 5 Dec 2023 12:29:00 -0800, Sam Edwards wrote:
> JEDEC standard JESD84-B51 defines the eMMC Data Strobe line, which is
> currently used only in HS400 mode, as a device->host clock signal that
> "is used only in read operation. The Data Strobe is always High-Z (not
> driven by the device and pulled down by RDS) or Driven Low in write
> operation, except during CRC status response." RDS is a pull-down
> resistor specified in the 10K-100K ohm range. Thus per the standard, the
> Data Strobe is always pulled to ground (by the eMMC and/or RDS) during
> write operations.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix eMMC Data Strobe PD
      commit: 37f3d6108730713c411827ab4af764909f4dfc78

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
