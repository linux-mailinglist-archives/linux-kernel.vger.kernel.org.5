Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B31778FB11
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348874AbjIAJlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243709AbjIAJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:41:48 -0400
X-Greylist: delayed 916 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Sep 2023 02:41:44 PDT
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE148C0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1693560380; x=1696152380;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Wk+v8UMEl5LiUTyiWv4t09O7PSYZehWA/PcV3yt7YOo=;
        b=nEVHQYpiI2cBP0m8DbAz488k+4VNUsu9YRQv042opHIB2OO61hcqmPyo5QkPwloA
        YHUMfAihIcNWtHv/VBEVv8tecKiy7sRAy7UcajtjxKTJ7KRNoKKjWm7EwwNq4gr2
        1qtaX6irM/7EOxJTvv8h0E2Zd8J7i96VTm3hcdTwHOg=;
X-AuditID: ac14000a-917fe70000007ecb-fc-64f1ae3ce3c8
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F8.5A.32459.C3EA1F46; Fri,  1 Sep 2023 11:26:20 +0200 (CEST)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 1 Sep
 2023 11:26:20 +0200
From:   Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 0/2] Add support for the phyGATE-Tauri-L IoT Gateway
Date:   Fri, 1 Sep 2023 11:26:15 +0200
Message-ID: <20230901-tauri_upstream_support-v1-0-ed30c6df789b@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADeu8WQC/x3MQQqAIBBA0avErBPUiKSrRITUVLOoZEYjkO6et
 HyL/zMIMqFAX2VgvEnoOgtMXcG8+3NDRUsxWG0b7axT0SemKQWJjP6YJIVwcVTarX62pmtNq6H
 EgXGl5x8P4/t+rAjV7WgAAAA=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>,
        Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWyRpKBR9dm3ccUg4dn5S3W7D3HZDH/yDlW
        i4dX/S1WTd3JYtH34iGzxaHmA0wWmx5fY7Xo+rWS2eLyrjlsFq17j7Bb/N2+icXixRZxi+53
        6g68Hjtn3WX32LSqk83jzrU9bB6bl9R79He3sHpsfLeDyaP/r4HH501yARxRXDYpqTmZZalF
        +nYJXBnNp/6wFxxkq5i4+y9TA+Mq1i5GTg4JAROJ26vXM3cxcnEICSxhkti14wEjhPOQUWJ2
        1xxGkCo2ARWJxy/ugXUIC7hILJtwjA3EZgGKP7p+GqyGV8BTYld/GzOELShxcuYTli5GDg5m
        AU2J9bv0QcLMAvIS29/OYYZYvIVR4l2rFsguEYEXTBLHpv1gBXGYBVYwSmx6/IwNokpYon3R
        LSYQW0hAVuLF+V52iLi8xLRzr6EmhUps/bKdaQKj4Cwku2ch7J6FZPcCRuZVjEK5mcnZqUWZ
        2XoFGZUlqcl6KambGEGRJMLAtYOxb47HIUYmDsZDjBIczEoivLFm71KEeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ897vYUoUEkhPLEnNTk0tSC2CyTJxcEo1MMbb6pSVxH+fUjw9lLVUqO+tder3
        R//0ghdO6G5tzmztuiB91eqUxV2Zx8vWJt+Y78p8Z/0M6cJ1NxX/fLLpqD96vdZ+L1tezono
        zfkzj6krbJnZa3lV6euZxoqGk3Ys7kIJrYUhTxd/2WRnz9Mj4nQ89v/CdfXbkxlf7zr36bJm
        0qUZgtb39JVYijMSDbWYi4oTAXv+8OGSAgAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phyGATE-Tauri-L is a SBC that uses the phyCORE-i.MX8MM SoM, but has
a different carrier board.
This series adds support for the board and most of its interfaces.
Notably, RS485 support is missing.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
Yannic Moog (2):
      dt-bindings: arm: fsl: add phyGATE-Tauri-L board
      arm64: dts: freescale: add phyGATE-Tauri i.MX 8M Mini Support

 Documentation/devicetree/bindings/arm/fsl.yaml     |   4 +-
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 .../boot/dts/freescale/imx8mm-phygate-tauri-l.dts  | 488 +++++++++++++++++++++
 3 files changed, 492 insertions(+), 1 deletion(-)
---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230828-tauri_upstream_support-08fac2175150

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

