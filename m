Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1727B7AC479
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 20:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjIWSie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 14:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjIWSid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:38:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0279F136
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:38:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-502a4f33440so6575264e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695494305; x=1696099105; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClXqT8Uh8EdDamPSJYkPDkToktmXy2eMl0T39P8sMUs=;
        b=ST5Z3m6tMYh/mIJwP27f5ZCoXdmYVRNjQglFa/ROzeRBkNJ+MgRRpG34+iHsPBLAW/
         1z4C/DYlUq27ZsJXViS9Itz0NYGTWSr9kEbIlhtPEyy4uTooWKJyItrLZNXMsqV2Raq0
         klHvi2XGsqHzz9gxkTwWG0yBOL6L0k7GJZxzgy+MtQS7uOrin60hknZI4mGugDgHCU2m
         x1lxntrZf6M2mP6HjLepcfZ0MuAo2F0GNZruR0pn4t0/XfCaBYdkHuP9HbIorP8h5Hzy
         7HIMC8EhSLZ1XVBrBu/E/oSjFoqmlk5tfgJOAHJmhYv5/F/aMA7C4WiccmSHF1IxZXP7
         JICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695494305; x=1696099105;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClXqT8Uh8EdDamPSJYkPDkToktmXy2eMl0T39P8sMUs=;
        b=OjB4lwaMFjI0Olh+3dBmlFh4v/jORy4qj8Wi0YDZz96TFJDUQ+hs0mReSSe3zNZ9TO
         yexAFKNFOxqGOOwyMfaQ4xsP+ty6P76gqshvMWiSlnVz5em5p8AudgaubL8h6VEuHHVz
         yRQ+Vfch3it19qq7ejyDicw2hDVpMwG4JOQbEseUZ985NIKGt1inbdSaQJCbR/f2uzlD
         Jf7byjyQFSY9kG+ZX86w7k0NX3cQqJV4fT/VWCIgUKMhGHYbAsus5osvQlrIXuB8XUM3
         9chBCbAHvNJzWBDtqEHEc9t2D72qucxT4eBx2wbbzXF3pDbiPXENEnsV8Ikart5K7oqX
         Q9Eg==
X-Gm-Message-State: AOJu0YwsTSYRG081dKfiJW3PEm8knptoct8h2h8qnRIzrq8fxdrGUIOk
        ow/jRz7Hgh7w+hhmloEfN2k3AA==
X-Google-Smtp-Source: AGHT+IHwPS7X2JaPX1XspJWy7/+/It3JKBd53/qHQOfkp5g0dzAT1nZ4nyXNFSyfAgeLi8oGWEjnDA==
X-Received: by 2002:a05:6512:32a3:b0:500:91ac:c0b5 with SMTP id q3-20020a05651232a300b0050091acc0b5mr2274668lfe.30.1695494305141;
        Sat, 23 Sep 2023 11:38:25 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id v15-20020a056512048f00b004fe5c7d40dbsm1147959lfq.273.2023.09.23.11.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 11:38:24 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 23 Sep 2023 20:38:22 +0200
Subject: [PATCH net-next] net: ixp4xx_eth: Specify min/max MTU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJ0wD2UC/x3MQQ5AMBBG4avIrE1SrUS4ilgIP2ahpC2ZRNxdY
 /kt3nsoIggidcVDAbdEOXxGVRY0baNfwTJnkzXWmdY6Fj1rVUbaeE8XT6au5gYLWmcpR2fAIvo
 Pe/JI7KGJhvf9ABtOVV1qAAAA
To:     Krzysztof Halasa <khalasa@piap.pl>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we don't specify the MTU in the driver, the framework
will fall back to 1500 bytes and this doesn't work very
well when we try to attach a DSA switch:

  eth1: mtu greater than device maximum
  ixp4xx_eth c800a000.ethernet eth1: error -22 setting
  MTU to 1504 to include DSA overhead

I checked the developer docs and the hardware can actually
do really big frames, so update the driver accordingly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index 3b0c5f177447..8f40287c8d58 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -24,6 +24,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
 #include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/net_tstamp.h>
@@ -1488,6 +1489,13 @@ static int ixp4xx_eth_probe(struct platform_device *pdev)
 	ndev->dev.dma_mask = dev->dma_mask;
 	ndev->dev.coherent_dma_mask = dev->coherent_dma_mask;
 
+	/* Maximum frame size is 16320 bytes and includes VLAN and
+	 * ethernet headers. See "IXP400 Software Programmer's Guide"
+	 * section 10.3.2, page 161.
+	 */
+	ndev->min_mtu = ETH_MIN_MTU;
+	ndev->max_mtu = 16320 - VLAN_ETH_HLEN;
+
 	netif_napi_add_weight(ndev, &port->napi, eth_poll, NAPI_WEIGHT);
 
 	if (!(port->npe = npe_request(NPE_ID(port->id))))

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230923-ixp4xx-eth-mtu-c041d7efe932

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

