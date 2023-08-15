Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D26077CD28
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbjHONIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjHONHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:07:52 -0400
Received: from forward201c.mail.yandex.net (forward201c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AC7B0;
        Tue, 15 Aug 2023 06:07:50 -0700 (PDT)
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
        by forward201c.mail.yandex.net (Yandex) with ESMTP id 2358A4A49F;
        Tue, 15 Aug 2023 15:59:43 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:17a3:0:640:53a6:0])
        by forward103b.mail.yandex.net (Yandex) with ESMTP id 643BA60031;
        Tue, 15 Aug 2023 15:59:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 3xeYJg5Wma60-VVag7b6Y;
        Tue, 15 Aug 2023 15:59:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail; t=1692104349;
        bh=W0sB+Yne05rsYeHXPgw3LIcd/XRPY0E85Vo6QNC1YDQ=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=LVy7viZueqdVlCckBmTTdfAMirSbVmesDdfXgWPE6RjzJg1dGN5pPXiUfYddfRvyW
         1+Q/F39qaCANTXtp1xiW0Uga/P+1Zg0BSRQL2y7fwT8i2I8EDHguB5KIsWvU7EWK1K
         0/tsEPqfOg0q1FqbhuTYCHBI1aw5o/LrCguqBb6c=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From:   Muhammed Efe Cetin <efectn@6tel.net>
To:     linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, sebastian.reichel@collabora.com,
        Muhammed Efe Cetin <efectn@6tel.net>
Subject: [PATCH 0/3] Add Support for Orange Pi 5
Date:   Tue, 15 Aug 2023 15:58:58 +0300
Message-ID: <cover.1692102057.git.efectn@6tel.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These series add initial support for Orange Pi 5 and SFC node for RK3588S.

Muhammed Efe Cetin (3):
  dt-bindings: arm: rockchip: Add Orange Pi 5 board
  arm64: dts: rockchip: Add sfc node to rk3588s
  arm64: dts: rockchip: Add Orange Pi 5

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../boot/dts/rockchip/rk3588s-orangepi-5.dts  | 873 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  13 +
 3 files changed, 891 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts

-- 
2.41.0

