Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618EE759C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjGSRkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjGSRk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:40:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0913B1FC0;
        Wed, 19 Jul 2023 10:40:20 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-009.ewe-ip-backbone.de [91.248.208.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4027F6607030;
        Wed, 19 Jul 2023 18:40:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689788419;
        bh=npdCwm3+Jd5lwBgGPCmM83TseN3mERIRvQQxK5+YEOQ=;
        h=From:To:Cc:Subject:Date:From;
        b=M/Y0L+mGEInoRfd0/tuQH0u9rqufvnDcRD68MWl5xMBZuNZ5VHY67yhMml1IYvaIz
         s1Bpjkzq4t2QSCLCjgW7LMb55eQcvUulqOgEgkTt9nJNl8reqOMheAiTsRiS1Jsw1H
         pdXNrzV6JXb36Zj13URCJqUZIoPWvmBESBtHzmfssFG5qzTTIL+ZP/y/GrD/8VHRNe
         6wJhR+wvzHv8xejN7hutaTdQz1nrtKgZlWTK5eghJ/VixpoGITK92RLF/uZUB63a2e
         k8aywk5yJc4WDBaHUJt13ob6oaQSPZjBAwTtPPvk+EKLcpetZm9m1olv+8Q1KNUvD7
         vDe9rT/Y3A8+w==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1EA0A480DA3; Wed, 19 Jul 2023 19:40:17 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 0/2] RK3588 USB3 host controller support
Date:   Wed, 19 Jul 2023 19:40:13 +0200
Message-Id: <20230719174015.68153-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds RK3588 USB3 host controller support. The DT binding is
already prepared for the dual-role controllers, which are also DWC3
based, but using a different PHY and a different set of clocks.

The series has been tested with Radxa Rock 5B, which uses the controller
for the upper USB3 port. The patch enabling &combphy2_psu and &usbhost3_0
for this board will be send separately once this has been merged.

-- Sebastian

Sebastian Reichel (2):
  dt-bindings: usb: rockchip,dwc3: Add RK3588 binding
  arm64: dts: rockchip: rk3588s: Add USB3 host controller

 .../bindings/usb/rockchip,rk3399-dwc3.yaml    | 107 ++++++++++++++----
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  29 +++++
 2 files changed, 114 insertions(+), 22 deletions(-)

-- 
2.40.1

