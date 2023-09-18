Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4217A4CED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjIRPoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIRPoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:44:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8C4E60;
        Mon, 18 Sep 2023 08:42:24 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-188-252.ewe-ip-backbone.de [91.248.188.252])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3BCF066071F1;
        Mon, 18 Sep 2023 15:14:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695046498;
        bh=eDPgzqzOt8C0tSrqfznZpadr+6u2SSJcGi+WOSLOE6s=;
        h=From:To:Cc:Subject:Date:From;
        b=bU0psDT57KgX+Ugd6nMxTkzKM49BD9cEdn+Kbs/ziEiQfkgBtxVo1mbgK0WxoXEZt
         0oZdoNpGlC43YAUw0nbUJwwrnoD5AF09FCFLRPsi+uPrmxsF0VE6zvwBLL7o0VZAhJ
         rLlfjLaSfWFclolrHa6Pms5dNESXkQgFXkpy8AiL3mmCXKkItojagVug4HC1FGc0Lg
         B9DjBbW0BIUzCqALgw6QQpAI6WdHlNb9tpXj+4UagsZacINr3zBifdVT3to0qKj52h
         aiGlDgywyn/OxXnI9mwLQPIp4sHpP26F+YizGUSbS+4keItbMUzGM6y/VuVcDoid+O
         VyYUqtaIvYYAw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7ED764800CE; Mon, 18 Sep 2023 16:14:56 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/3] RK3588 Rock 5B PCIe support
Date:   Mon, 18 Sep 2023 16:14:48 +0200
Message-Id: <20230918141451.131247-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This enables PCIe network card and PCIe for both M.2 ports the Rock 5B has.

-- Sebastian

Sebastian Reichel (3):
  arm64: dts: rockchip: rock-5b: add PCIe network controller
  arm64: dts: rockchip: rock-5b: add PCIe for M.2 M-key
  arm64: dts: rockchip: rock-5b: add PCIe for M.2 E-Key

 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

-- 
2.40.1

