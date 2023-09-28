Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2057B2313
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjI1Q7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjI1Q7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:59:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0001BF;
        Thu, 28 Sep 2023 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695920340; x=1696525140; i=julian.ribbeck@gmx.de;
 bh=pgzYVMK04U11CH6h9Yble3k0HzNklkv+LW2WhvSCwtQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f2lyhWCdspd+wKbQ75KGOgK9H2BAysh7G3H7H4q5NRsw1CDU59NrgcLOlyAuujx6cH2I7jSS+e5
 48WASg0xe85trvfVvXAn2sSCq/G+xzSfWwjMNFl+D0wLAuTPnsZyWen0hsezQBx7oW4A23L98JoQi
 5g6S9z1xG9B0PLKrHjk8nICYxEMPiZ0UussHPr3WtvBFSc4k+gfG399QM/j9x6Nicw/s9nUFeCWaa
 aIiL4sa7MClKDQPMNODqSz8IUcKXJZjaHk6t6pdXeyfcQf5iPmx7X0iBRIgF5UkwJkfqhYU8SF3KP
 XeqpuLXJ+wfXETjRSDSToPHmce9IV71/8jiQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.90.255.242]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MgvvT-1rHODW3xNt-00hPZq; Thu, 28 Sep 2023 18:59:00 +0200
From:   Julian Ribbeck <julian.ribbeck@gmx.de>
To:     samuel@sholland.org
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, julian.ribbeck@gmx.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, robh+dt@kernel.org
Subject: [PATCH v3 2/2] dt-bindings: arm: sunxi: Add itead,iteaduino-plus-a20
Date:   Thu, 28 Sep 2023 18:57:02 +0200
Message-ID: <20230928165803.30127-2-julian.ribbeck@gmx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230928165803.30127-1-julian.ribbeck@gmx.de>
References: <9730f21c-fd8e-9583-98c7-e5d923269f79@sholland.org>
 <20230928165803.30127-1-julian.ribbeck@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P+6Q2PWpdB5kQfCXWzv1Akg7Tgg17CXmpZMVE+xnoG+XKC+qYEi
 arn67oWwTWaLrbmV+qSM1U26dQhZ6tEXn2IjvF7izsPMlJp90eFa3U9e5ZJAEk+VgnG3TFq
 MjbYiExv0JQLwPVWANwRiAgH9NZ1mUwLkf8W7hiNIn0hOYpgqJDWLMvCGCH3Q3bd4V6oCiZ
 DPbZ9c5Cxhe96FPSsTlWg==
UI-OutboundReport: notjunk:1;M01:P0:jrXD7kg4Rl4=;S7cWsOJDbzTL8AZvkaDGIhjFO8F
 tFNFLuD6f8DYj2qgfP007c09yMu8PnaJlGCiYtJCqdgZc0BqNxbt6aYQoj5IxhLWJDTUeWHj7
 Eqm8Dot5KEVyD1QkVUQMiJr6H6w3RqF5HjNy/B7MG0+3X1azI+nGi2yN2tdBxngXPjI4wWZ35
 CZhJIDQtyGE8mQWvwn2D8ns7lM7qVACqWxFW4dzs9uuRcc8HMJwD5DI3BYNdEYUOWlLfTSNdm
 6Ax2GsKXazX789ncIkJjKJKSYTQaOyLikJ6lN3TqAa72FN5G+/CgZUkAQGEv+b2XzPPrIC6F4
 njn85hGp1Na8IwQ7jeW4AqyOaQXSdlpL3E5VmiX+rNB6Y5Ll0nPVOUY/LVfUIHKkFr7+w2sn8
 GMPeYZydMgtuA5VZqmwyvd5cs6B23gGyiN0itwcPlXNVgLlawss5qlc1jn/1MHKKQ5fftq9jn
 uyDGYQ0TF8GTdX09jrGPvOmzQ23j7FPpWv9g6rve5s6V59lYzn1xBR4zgjK/0vZ8fc77fA4C4
 96d0zCYEAkQ1kEeoxm05m092ftSqi9vsT128Qn7c9LfXjmrd9z7TGN061RQZy1MwEIMKOobI5
 b353Eq7Iw8BzOHnzsafruZHk0qL6fbyLqEaMfTzzH+e3m6X8l6ulPm7qpo7W+2SGGw8XRM4kO
 /R4BgPcrzf/USwzroHzHOuIX78UjQj/Xif/pemb0kanZqx2nXBudESFZ6wX7fLj5J4nViJusx
 njWZyI/ynebBXwcYH0p9199+n94xaeWz9Ms7k3ao4CQ46Ytp7hjBymFE65avJF/SNPo/CWuWu
 e1s+1fc1GFxZkGx/zpjAc0xcCL3fxKhuLKl6IY2GJnoA7say/VzyF6R2lcod+i8g69xBt9z0c
 Yb0weX9jdO7fnnuSdwA9d+qj4PXh0we8A07TBuGOgz3z36hbWqfHIqtXI5LnfmDUOsyOgJQyh
 V6FiRQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add itead,iteaduino-plus-a20 bindings

Signed-off-by: Julian Ribbeck <julian.ribbeck@gmx.de>
=2D--
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentat=
ion/devicetree/bindings/arm/sunxi.yaml
index e4dd678f4212..25251ce4b60d 100644
=2D-- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -362,6 +362,11 @@ properties:
           - const: itead,iteaduino-plus-a10
           - const: allwinner,sun4i-a10

+      - description: Itead Iteaduino Plus A20
+        items:
+          - const: itead,iteaduino-plus-a20
+          - const: allwinner,sun7i-a20
+
       - description: Jesurun Q5
         items:
           - const: jesurun,q5
=2D-
2.42.0

