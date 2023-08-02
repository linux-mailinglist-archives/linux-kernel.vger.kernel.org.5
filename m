Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C8176C56E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjHBGmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjHBGm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:42:26 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFDF2D6A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:42:00 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 9A87E40016;
        Wed,  2 Aug 2023 11:41:44 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690958505; bh=V6C249y+rFRMuzRrVSpIXCIkln6wPAivQtiZCxA0Wds=;
        h=From:Date:Subject:To:Cc:From;
        b=YweWWvBA54xvQvNnP2PtRPq48JQSoKL6dwYfPKdJoqrw9Ho/10cMkrmHlumdBe/FS
         UjBKYExPD2H4LXTlKywWzkfSnB6C2WaQqhD8EcMLDLFgca2/JwO7RSnXTQH0WIWnYS
         zFeGPZepiLxnvdxWb1UqbnYqWi/XhvSH2bW585PZLDpIjXsjje6vW0AJBXUp0SCiQV
         o1AstQq4w6NVDjXeYx4EepuxjVqIfMmP27WEtot9+FCQ10GpZnxdYLrmqFsb6z1U00
         /c4fgOh0gQtfYFEm/g9mjZJJmxhJg/mtDuOokCkJkDxdXEfNrBDV6Mu22qOrl7r+pL
         na2Wt0QorLCfA==
From:   Nikita Travkin <nikita@trvn.ru>
Date:   Wed, 02 Aug 2023 11:41:22 +0500
Subject: [PATCH] drm/panel: samsung-s6d7aa0: Add MODULE_DEVICE_TABLE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-gt5-panel-dtable-v1-1-c0a765c175e2@trvn.ru>
X-B4-Tracking: v=1; b=H4sIAJH6yWQC/x3MSwqAMAwA0atI1gZq/XsVcRFtrIFSpRURxLtbX
 L7FzAORg3CEIXsg8CVRdp9Q5BksG3nLKCYZtNKl6pRGe9Z4kGeH5qTZMZreNAtVql11Ayk7Aq9
 y/8txet8PmAHwZ2IAAAA=
To:     Artur Weber <aweber.kernel@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=V6C249y+rFRMuzRrVSpIXCIkln6wPAivQtiZCxA0Wds=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkyfqnoFNkzGTraRzk5XVjG6mjPoMrdXvBVuL4I
 LqAPlaw2J6JAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZMn6pwAKCRBDHOzuKBm/
 dWPMD/9XUk+/DNuZMQrI61M0bp334E5KlVK/trMHhzW60X9ksS0T+NAkuD4bjx5lyz56iD8ZdEY
 lYKBU4moO7u2dsXLZ8qmmN6EmATZbox780002YZms0Z4T7aKKZj6Xz1BC9K0iuRk77D4Q2RfQqG
 JcCJfBZXKLuK2TLDYVOcWm43zY3r00ug50enenA9+R5ZY3sRsDc5LJK0nDA8J8rxqHRU3HCE5Mq
 P18ivVYA5s2DabpDFN0H2M9Z31n5GA39ub5MqEJ+sZdXmf5uNTjWKM+LYpEh28NFkl4JCELWoUJ
 O/H/Vl+m/Mr1P7L3iDcaWNYn0EAFQdRvWnifJgqIiFWyUqAdBMpa7IRO80eJzsV75y2+7jpYHIQ
 4ynOeuctThFYnwT0XnaioEwF38ktfW47eNcZunHOjPADoJhuEf1nwV3Gkn/gzH5o4OVPlgFrkKl
 VGD4BauHUwFhx63isIXpZLcfbvLPJzehdP8iuf+0xjPhjhkLTI4lULj1Dy7M1/mVbz10iY6frsZ
 +yYforsOVL0LTxflsPxT6w5DY+vDUNoAj2ARmaQcyciOVzOUqc5hcd3b3TpuCNwQEcXdxorCCGm
 9Ye34sOnSam8l8FKIGOwnbPYuKHJNGz2t2Y78HwiNpdVw51sK0Rv8ID2doE5fsPpX1jLYycfOne
 iRvOlx29xRCsBFA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be built as a module, however the lack of the
MODULE_DEVICE_TABLE macro prevents it from being automatically probed
from the DT in such case.

Add the missed macro to make sure the module can load automatically.

Fixes: 6810bb390282 ("drm/panel: Add Samsung S6D7AA0 panel controller driver")
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
index 0583360b1280..ea5a85779382 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
@@ -567,6 +567,7 @@ static const struct of_device_id s6d7aa0_of_match[] = {
 	},
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, s6d7aa0_of_match);
 
 static struct mipi_dsi_driver s6d7aa0_driver = {
 	.probe = s6d7aa0_probe,

---
base-commit: 626c67169f9972fffcdf3bc3864de421f162ebf5
change-id: 20230802-gt5-panel-dtable-d9d6ca407f26

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

