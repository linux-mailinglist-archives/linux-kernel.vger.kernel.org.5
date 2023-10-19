Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48D07D0011
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345284AbjJSQ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjJSQ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:57:40 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1E3131;
        Thu, 19 Oct 2023 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1697734655; bh=Bvmn+V+8oX7B+tSkrf+0B+Kh8dg+ZztWnQG5X3x9Bh8=;
        h=From:To:Cc:Subject:Date:From;
        b=HF8lErKW9uN+o4opO7QVbialjnmDJMKxwdCdZUjC5ytgd6tmuW+2GcUOcHBloyzMU
         xQ/6/SlGUhthjcppvwfJVy5QtxxS319V/+foPhHQ9+fq34PKO7KxpeuEtkdXCNCTjS
         vuJCaU/gHw3VyKsBzV/VZJ2WMY49RfqwKPWhlJ/s=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ondrej Jirman <megi@xff.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Add support for poweroff via RK806 PMIC
Date:   Thu, 19 Oct 2023 18:57:22 +0200
Message-ID: <20231019165732.3818789-1-megi@xff.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

The PMIC supports powering off by twiddling some bits in a register. Add support
for it via pre-existing rockchip,system-power-controller DT property.

The series was tested against Linux 6.6-rc4.

Please take a look.

Thank you,
	Ondřej Jirman

v3 resend:
- add tags
v3:
- use system-power-controller
- deprecate rockchip,system-power-controller
v2:
- add a missing driver patch

Ondrej Jirman (4):
  dt-bindings: mfd: rk8xx: Deprecate rockchip,system-power-controller
  dt-bindings: mfd: rk806: Allow system-power-controller property
  mfd: rk8xx: Add support for standard system-power-controller property
  mfd: rk8xx: Add support for RK806 power off

 Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml | 3 +++
 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml | 2 ++
 Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml | 3 +++
 Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 3 +++
 Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml | 3 +++
 Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml | 3 +++
 drivers/mfd/rk8xx-core.c                                  | 7 ++++++-
 7 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.42.0

