Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A69769747
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjGaNOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGaNOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:14:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C02AA0;
        Mon, 31 Jul 2023 06:14:35 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c10ba30afso245142466b.1;
        Mon, 31 Jul 2023 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690809273; x=1691414073;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1VlZ1FwEo+/smO6cOUgXoQW9MZfUVONXgthA3NJ828=;
        b=EwM3VRqbaIJyNpZqiBZplhqK9iWGmtBkCSy7OdmrSZM5VuBjB7eaVYRoiEkBfz5xbP
         PdQeqy9Fx4MQG0Vc4TcDvYKMUvNYz9kTTAVdQSrR3MGgxLy8zy8OH8wHyEALgDS7RO1w
         1pI5KVglMFzMGWRBzZYr/xy86g1HhCxqEWLCavV6OkX1LzDUO4WXS285idtgQNpF5H/n
         2y68sR++9x9TZibjeLqZPZg17B0v36j1UWEFrLIyNv9HMhDfeWBuda7ZBZSf4VCHyhRQ
         pEDCONn47xfO1SwbHRdv6UN1/EoVrMznwYjRun5wsJdB8XF2CZoXcNZg8qnPzgbkals2
         dIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690809273; x=1691414073;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1VlZ1FwEo+/smO6cOUgXoQW9MZfUVONXgthA3NJ828=;
        b=OX0HjroXG7u8G4GFFTvwNnH761qHa3YsFkTAkc6eQA09GJHoGG3/K2sgSe5m+dQU37
         diOVMfaXnhhbonvTJsNuHJiJWL2zIYqV+HWfAdi2Ln2IRSYHeqvdMc14bOoglxeZNGxt
         BOd1NmbNfObJST6OdRaQEEvMXb9QcdpPlwgDSfjJU7+qGML+jpWJWR5NqJOUF8FasK30
         L6XDm1zrIb0JLRoWZnqELjAe33UayiuP2Oi86r+9/9g2wtdAyiDfyqi746DyoC/O1gAj
         PI0yLpELFiEdVvUAoKWQptjgP5Xjsf8YiXgjQePAJEEgsgA9Zw94VVLR43x60KV3yI+s
         UXyQ==
X-Gm-Message-State: ABy/qLZsPNBTKDDD1b4tx6tlFi1Ep18xnmjW1Y95eT51Cr8zEvT5lchw
        4sMFOT8Qg+6HJsMS320GGZ7OVZrJ6A4=
X-Google-Smtp-Source: APBJJlH12RtSstaQpPAdCzTygHGsdlv8TeFotaptleVxfp/cUxqbFlhJT42SoJ4YLKX+ieORC0wTBA==
X-Received: by 2002:a17:907:270d:b0:99b:c2ce:501c with SMTP id w13-20020a170907270d00b0099bc2ce501cmr7769945ejk.19.1690809273218;
        Mon, 31 Jul 2023 06:14:33 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:c9d4:a174:b52d:4c33])
        by smtp.gmail.com with ESMTPSA id qk29-20020a170906d9dd00b0098e34446464sm6112502ejb.25.2023.07.31.06.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 06:14:32 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: correct file entry in MEDIA DRIVERS FOR FREESCALE IMX7/8
Date:   Mon, 31 Jul 2023 15:14:27 +0200
Message-Id: <20230731131427.601-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cd063027c304 ("media: imx: Unstage the imx8mq-mipi-csi2 driver")
adds a file entry for the driver code to MEDIA DRIVERS FOR FREESCALE
IMX7/8, but misses the number '2' suffix in that entry. Hence,
./scripts/get_maintainer.pl --self-test=patterns complains about a broken
reference.

Correct the file entry in MEDIA DRIVERS FOR FREESCALE IMX7/8.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97db167eeaa7..5ba24f88a214 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13094,7 +13094,7 @@ F:	Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
 F:	Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
 F:	drivers/media/platform/nxp/imx-mipi-csis.c
 F:	drivers/media/platform/nxp/imx7-media-csi.c
-F:	drivers/media/platform/nxp/imx8mq-mipi-csi.c
+F:	drivers/media/platform/nxp/imx8mq-mipi-csi2.c
 
 MEDIA DRIVERS FOR HELENE
 M:	Abylay Ospan <aospan@netup.ru>
-- 
2.17.1

