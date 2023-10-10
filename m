Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C047BF4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442575AbjJJHsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442554AbjJJHso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:48:44 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4DAAC;
        Tue, 10 Oct 2023 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1696924120; bh=+7mC7cUIagzQs5/FRvWIKxyEtjBtUsiIq3o/E4sh/wU=;
        h=From:To:Cc:Subject:Date:From;
        b=Fzbx+hnuTGin5uAH+inRSiTNthq1wJymTDF+r0v5A7/kBgnbD9kEPgc4URwPCHalK
         r9xLIdjeFAH3Yim5DzyYURKrjIOPkIDuEeSw+3VeAw99JPmEj6TmsboVeWStlnHlyT
         2geAXMsxCO+75S7hYkH6rcAbph8me7Ktm0cZ1emU=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ondrej Jirman <megi@xff.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for poweroff via RK806 PMIC
Date:   Tue, 10 Oct 2023 09:48:19 +0200
Message-ID: <20231010074826.1791942-1-megi@xff.cz>
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

v2:
- add a missing driver patch

Ondrej Jirman (2):
  dt-bindings: mfd: rk806: Allow rockchip,system-power-controller
    property
  mfd: rk8xx: Add support for RK806 power off

 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml | 5 +++++
 drivers/mfd/rk8xx-core.c                                  | 4 ++++
 2 files changed, 9 insertions(+)

-- 
2.42.0

