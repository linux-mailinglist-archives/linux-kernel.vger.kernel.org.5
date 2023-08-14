Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA6177BE30
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjHNQhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjHNQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:36:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3FD124;
        Mon, 14 Aug 2023 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1692031005; x=1692635805; i=j.neuschaefer@gmx.net;
 bh=arIfURks3B5Vf0o5lhr2f1M0B+uljezROcQ5CKR6D/E=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=nfmnsPRajTRJ1BzFYln1wimrbHO+bDp/zu0MSB1j761DFiZlCwanNRA8LIX+fFtY+WzNSCH
 rCEGZaWQIBn7HZRnXlgmae7GKn9tpJpT44/8attvVkNLiWZ6aqbjoK2nbDVINQx9z9THcMDYS
 LtP+h+xZbbMqtN1wI31MqPzRGHoKQDNrwR/u2PtYZqnRDehF+VF/h3nmkXtQcDsq4G3/TK4KJ
 JS62Ph5nS69Ha6PNMzNBIjI5wPHMaHWC4b8Jl5NqfIQk5P05UwD/1y4Nm//UgEdg8fB8br3Du
 sDOl9MHLqwIJRZd2H16uL8IJ/V8LU2v8zwehBXlRATbd9Ffku1fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([151.216.154.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK4f-1pf8PU3OhF-00rIfq; Mon, 14
 Aug 2023 18:31:17 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3] dt-bindings: leds: Fix reference to definition of default-state
Date:   Mon, 14 Aug 2023 18:31:15 +0200
Message-Id: <20230814163116.1696092-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kyk89y2Os9QLpyXCC2oVuYUPrP479VWYGZotKMM8bkxf3w6FVWK
 hi7hiGpR66ycC5GlXKavQ6gQXMVLsBadVvO4bzWVh+B003VzUpm2P+kihy6GySuCidEkzpu
 vkp30foIyrle6MveHZWq/FExBT72OmEd1MQWQhtO3rRoPgRxKcbs7uVmgJM5dta5elxYD+B
 qjBPOgMLxd3bxYCIWCqSg==
UI-OutboundReport: notjunk:1;M01:P0:ral/hzWxdXI=;BOIVTbOJwvwtjSwJCW5QldncwLg
 VkHKXjwDxm4oGec/cJqwGx/zxsjR7GJ4fRRApfR+jmfdkmLdmr8z10E/S3vc/EwtWMcRsMdzM
 d1jhEMIoE9EvvfGDqB6l51N8JX2fe0OjtBfFYcMVVjR9v444SkTbn/kihau550qvWAQPaNaYL
 qTHQwNq49DYlNtjYapiYDzwZsFKBakxtMzmzsORAQOqsU1i7FPv7J+DU2O5aTm855SCAtPjpT
 JP8iVRg9rU1n4cd/fLS67E522roBcWsgbj01B9RF9cMMFqn4SL8dPgvMj1LYqcf43OeiuSw+d
 XhPQXzKOJnZXAR9Ji561nmbPhpxHMKZQpTnjayNK3O9AOpvqtXDbuMHgu4lmEHFt1BYKf1wXV
 DqNuv7Mi4IW/JBQgkrq5tPLjYUsp5pJu2wm+RwVS2j/8aPc5EDgYrndVsPmIUjgrCA9xdHtpy
 0hy3P9JKNy8w/QSRW7bS6jSMhN+uAkpeFZdQx4DT1jKmPs5CmqqmZ4EWB6cHwT7rL34Ez1Tda
 1c01eE2AG8wWKVmTAhKZebXoFHd9ofDsfJy6oUwTDZxMUKmHGsklv5vUf7qDzCgE01nCnYWcp
 KznOtfV4hq9AS0y6GYAV4wQMtCcSxyBd9m89Wri/ED7OJdb6+ty8af3bh5XYIgyNN2bbTVbfU
 24jjm6mmCKbi34JKn3/ZFGFw2JN4StQGVCzYnTa26NSpFwKbkOUjOEXCV6dxSyB0ftatOIycY
 YXOMApPt/Ci7pVtv3Cb+b9GFiHQZfl/QSbKFidwfq8f7OIj5rGizWz/WBkV623Q+F4nVLdju3
 Wn+t1D2XuNngQlcMmYJcIOTEUD6lKVlq4CbY4BX5SDeZF7ZtRj7cLHNjJyCx1W/nvyhFs/7x0
 i9/0KugoSMqd+lHHznIliTESUtQlO5BSzDqMzhSLXuuDsP5tX8f+TyqekjbVquXmnnaFP/XaD
 Sg1AGtAK0k0JkIWDRJ22FKBzr4E=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least since the YAML conversion, the default-state property is
described in leds/common.yaml, so there's no need to point to another
file for its definition.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Rob Herring <robh@kernel.org>
=2D--

v3:
- Rebase on v6.3-rc6

v2:
- https://lore.kernel.org/lkml/20221008131918.1235397-1-j.neuschaefer@gmx.=
net/
- Add Rob's ACK
- Rebase on Marek Vasut's patch in -next
=2D--
 Documentation/devicetree/bindings/leds/common.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Document=
ation/devicetree/bindings/leds/common.yaml
index 15e3f6645682e..c9b0dde44986c 100644
=2D-- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -83,8 +83,7 @@ properties:
       - enum:
             # LED will act as a back-light, controlled by the framebuffer=
 system
           - backlight
-            # LED will turn on (but for leds-gpio see "default-state" pro=
perty in
-            # Documentation/devicetree/bindings/leds/leds-gpio.yaml)
+            # LED will turn on (see also "default-state" property)
           - default-on
             # LED "double" flashes at a load average based rate
           - heartbeat
=2D-
2.39.2

