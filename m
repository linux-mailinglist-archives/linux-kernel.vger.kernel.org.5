Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C777DF4AD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376775AbjKBOMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbjKBOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:11:58 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B922C12E;
        Thu,  2 Nov 2023 07:11:55 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 2F84A186AD7D;
        Thu,  2 Nov 2023 17:11:54 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Mit1H4cav2aX; Thu,  2 Nov 2023 17:11:53 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id D32D0186AD9B;
        Thu,  2 Nov 2023 17:11:53 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CEjmqHfM5iRG; Thu,  2 Nov 2023 17:11:53 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.237.131])
        by mail.astralinux.ru (Postfix) with ESMTPSA id E2B80186AD86;
        Thu,  2 Nov 2023 17:11:51 +0300 (MSK)
From:   Alexandra Diupina <adiupina@astralinux.ru>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, lvc-project@linuxtesting.org
Subject: [PATCH 4/4] Remove redundant return value check
Date:   Thu,  2 Nov 2023 17:11:35 +0300
Message-Id: <20231102141135.369-4-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231102141135.369-1-adiupina@astralinux.ru>
References: <20231102141135.369-1-adiupina@astralinux.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

media_entity_pads_init() will not return 0 only if the
2nd parameter >=3D MEDIA_ENTITY_MAX_PADS (512), but 1 is
passed, so checking the return value is redundant

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 2ec5bfe0c24a ("media: atomisp: gc0310: Switch over to ACPI powerma=
nagement")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c b/drivers=
/staging/media/atomisp/i2c/atomisp-gc0310.c
index 9a11793f34f7..62550504b68c 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-gc0310.c
@@ -660,11 +660,7 @@ static int gc0310_probe(struct i2c_client *client)
 		return ret;
 	}
=20
-	ret =3D media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
-	if (ret) {
-		gc0310_remove(client);
-		return ret;
-	}
+	media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
=20
 	ret =3D v4l2_async_register_subdev_sensor(&dev->sd);
 	if (ret) {
--=20
2.30.2

