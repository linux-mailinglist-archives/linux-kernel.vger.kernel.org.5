Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CE7750F06
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjGLQwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjGLQws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:52:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951651718;
        Wed, 12 Jul 2023 09:52:46 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-191-111.ewe-ip-backbone.de [91.248.191.111])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E941D6606FEC;
        Wed, 12 Jul 2023 17:52:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689180765;
        bh=o5jGOCe3JrCIePhdA38C/esV4A5QqCAZDo9gwsQJ8E0=;
        h=From:To:Cc:Subject:Date:From;
        b=WcAqPxZhX7zAPB4mH9fCd/j4+8vpaij20ovYwitZidvoYe/yuCK1ui6TaMObwzFyr
         T+AUyeui/zMalRo/mnoWszTQVMkZ4rQxEu0+L0R7imvp4RIfM/is11XEJMrmfC17c/
         SSIUmyGyGXu5b0kKxlogY4N2fI/Le+XkUPvEMlN+Yj0NOvzBDcAa4gwpzVXKC9WqpK
         h9HhQuStQ18izoCotrT2vpkxtNpC9kbwdGvYaOOm2jwX3kykv/8PXv1E9RNJoQcKL5
         n+OvJmUdorvYCFPc6QVH32TAnmbABgGLqOcDSA9XPSEElVbKu50vtRXjifG5LYXJjN
         A+qKiuwjRYrpA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 16FF2480592; Wed, 12 Jul 2023 18:52:43 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 0/4] RK3588 USB2 support
Date:   Wed, 12 Jul 2023 18:51:02 +0200
Message-Id: <20230712165106.65603-1-sebastian.reichel@collabora.com>
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

This adds USB2 support to Rock 5A, 5B and the EVB1. The necessary USB2 PHY
changes have been queued to the PHY tree and are available in linux-next.

-- Sebastian

Sebastian Reichel (4):
  arm64: dts: rockchip: rk3588: add USB2 support
  arm64: dts: rockchip: rk3588-evb1: add USB2
  arm64: dts: rockchip: rk3588-rock5b: add USB2
  arm64: dts: rockchip: rk3588s-rock5a: add USB2

 .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 74 +++++++++++++++
 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 55 +++++++++++
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     | 78 +++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 94 +++++++++++++++++++
 4 files changed, 301 insertions(+)

-- 
2.40.1

