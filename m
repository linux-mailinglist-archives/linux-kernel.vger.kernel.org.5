Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00BB7A4CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjIRPiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjIRPiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:38:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B09CF2;
        Mon, 18 Sep 2023 08:36:38 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-188-252.ewe-ip-backbone.de [91.248.188.252])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F6C3660716C;
        Mon, 18 Sep 2023 15:13:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695046419;
        bh=jUBMzzrZP2ozft5sWOPwadaxJadrsgcEVDuXZaKS9pI=;
        h=From:To:Cc:Subject:Date:From;
        b=EGZdGQ+qidXndDrZjztBDm3QNv9uAzpcV5FLI8O2khxEFKmvGUrRCWbHD7e27dqrV
         obiniG2FlGTS4Mtu60nA0zPNDOYg30LUhzLLuaAX3SHsI1Fi5Ki1lXb38RegjHwYZ8
         M36gu+MdtlGtxD4xQdjUHbS3hdtecRAQBdtKXU81ve9ayFFugB65+3ZJ7oABS4ziB9
         KBYZxnUTu8BAVXoRWFoDey5OQddCjAkwkoYMlrCPXDnpIq30EEyZ/mBGGv+9b3fZXe
         U7f/PNH8dzMFFQOvbUx9h0/TxxTux1no5Y4dUyI2XDBEwPERPOm5Kr1/HhdcXCm5dE
         VO/VB/H2d+/MQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7F6A64800CE; Mon, 18 Sep 2023 16:13:37 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/2] RK3588 EVB1 PCIe support
Date:   Mon, 18 Sep 2023 16:13:25 +0200
Message-Id: <20230918141327.131108-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This enables PCIe network card and the PCIe slot for the RK3588 EVB1.
There is one more PCIe lane being used for a WLAN card, but I did not
yet get that working.

-- Sebastian

Sebastian Reichel (2):
  arm64: dts: rockchip: rk3588-evb1: add PCIe2 network controller
  arm64: dts: rockchip: rk3588-evb1: add PCIe3 bus

 .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

-- 
2.40.1

