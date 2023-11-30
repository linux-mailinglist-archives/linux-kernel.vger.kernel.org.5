Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C47FEEF9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbjK3MYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345413AbjK3MY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:24:29 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65182D50;
        Thu, 30 Nov 2023 04:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4hIly
        MNzL863/Hk1Ll2QKnKQl9tBh0XjMWCIZh2OIFg=; b=Ml6VreRjhwwDPfgQci6rB
        KtjrBEfuq6fiGjk/kyqu7CqzGfNRj9CAsLS4xRTwCqDpA5HcFiIbNquTwtETAzQc
        ImSPTftZEY4IYy/AWn2eCR4XxPtAV3enwUXFhxEfQttjZ2IeZLDZ6VXt9zM+mSM8
        GGYyMec2fJBye8oGZXrkBQ=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g5-4 (Coremail) with SMTP id _____wD332fofmhllsadBw--.48571S2;
        Thu, 30 Nov 2023 20:24:11 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 08/14] dt-bindings: soc: rockchip: add rk3588 vop/vo syscon
Date:   Thu, 30 Nov 2023 20:24:07 +0800
Message-Id: <20231130122407.13198-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130122001.12474-1-andyshrk@163.com>
References: <20231130122001.12474-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD332fofmhllsadBw--.48571S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF13Ar4UKr17uw1Utw47urg_yoWfCFgE9a
        4xZ3WUuFW8GryFgw1qyayIk3Z8A3Z2kFykCa1jyF4kCaykZrWDKF95tw1Svr15u3Wfuwn3
        GFn5WrWUGFnxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8iSdPUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEAw4XmVOAqtmegAAsk
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Yan <andy.yan@rock-chips.com>

Add VOP and VO GRF syscon compatibles for RK3588

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---

(no changes since v1)

 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index e4fa6a07b4fa..26db4f48ff62 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -28,6 +28,8 @@ properties:
               - rockchip,rk3588-sys-grf
               - rockchip,rk3588-pcie3-phy-grf
               - rockchip,rk3588-pcie3-pipe-grf
+              - rockchip,rk3588-vo-grf
+              - rockchip,rk3588-vop-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
       - items:
-- 
2.34.1

