Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E7478B5B0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjH1Qzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjH1QzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:55:15 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358B9188
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693241708;
        bh=cPNK+81IGn0TQpKkotv2WdAq+z2m9yPGmO2U+lmiC/M=;
        h=From:To:Cc:Subject:Date;
        b=tqGOmbULVmkAtJcM3uNJGANKJYBS3glMCg1B5e9hV/3hGBuQtOSz179cSuVU7wZwI
         RWE6ryXs0UkNN+/K6ConbNrF0+UjfJ50ZN32ZsEBMUBr/A+TF02w6VA4OSETwBmroy
         HmBBsJVGy0gvKNrZWafIs/a73sF4plS9Nu6/SDMo=
Received: from KernelDevBox.byted.org ([180.184.51.142])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id DC3048EC; Tue, 29 Aug 2023 00:55:03 +0800
X-QQ-mid: xmsmtpt1693241703t8cvcq53r
Message-ID: <tencent_026E4B04ACDCE341411EF54862F8C6AB1605@qq.com>
X-QQ-XMAILINFO: NvKyM24IHTKSlKGvWHJ9FbVaOla+tcVA5EuhPy5wgmj14mHAPCI21r+zyzFvbC
         zEbP4kTEBCIhYXMIdpd0itwzVmo11tKwlAlvVEkMha0Uf69Fv2/OQaW9CB/5o1NJzW8baPjVLqyU
         gGNXDozJjClOkxKfNl6oJYTesrUOqTZ+WdMKzy/RgoVO2yt9MHtzIGEwCCPAP3kJsgLMt3qTNUZj
         5wbxFWohVoX6qVxv9CUtUf7wHIYcURdSJPaWD0YnRGIm6Q0zLwFw2YHui9uqrNzOqcr07sf7SHN+
         sWZ6lREn9Mq+Yi8FXmkeLduQvGIkQf0fCr/SC2/mKF2uRTPcE56V3yEuYUhY13nv7/e/VfHijjIA
         b/Bi15BkmZpIqN/JfPYdplsD1rF8XOcWZkzT6DV0+yUach2at0h69uJmk0HjRS4h2CnFgk+0WJOu
         okqdhU4K4zDzTklAbpe6Bc8jPq9UMAIl3H8J9pVmj/1hAX/LvTMPGx0CMbcrfY+jT7qqzw9MAdG+
         xJDhkvRDaOqfFJmnveJRbKLmIxmujZpD5VEPhJchxV1GWaGpNeGlB6FT9fg0fyVC2HRCz2ULKTdR
         SV8dGOJVw0QRgz0kywGEIE3zrUXeaYFeIKolOXcbZW0YBC3y3n9ggOnqnREeqGXChwf9jeg5Au76
         Pido6M5mKdLmQzV17D2TghvoKLt/+avD/+CRRRrVdk4djLkYtw7kxs6z2TEriYqXCsGjWq3Tlfu4
         PMzEjDUvLRcMold6fp/DSNxtjdXXahNnPYYER8j44XhyGWJOYj0hfpqhgU0QAaXHcaLPASwvv+Gj
         jBCCS43yEZj7zAKunAt7z4QfYYk+MW+pWDNSumcIXhxSbg7k+6SjTaRlt2jm9ERck9NboBwc7VW+
         aCevBuldn7Dbi1ZkcG+zfJR7MFTKFAEtmHzzR7dZyA7zliFvxHvP8eQhkT7JvJNpaf4DWM3S74yy
         aOaappAagmeL8su1R0mweeLcG7UsOeKMdKXubs1v8lnAOgnRVK2HtLwmBz8RBjmoqKNPZXaOM=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     victor.liu@nxp.com
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] drm/bridge: imx: fix potential NULL pointer dereference in imx8qxp_ldb_parse_dt_companion()
Date:   Tue, 29 Aug 2023 00:55:01 +0800
X-OQ-MSGID: <20230828165501.2887816-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device() may fail and returns a NULL pointer.

Fix this by checking the return value of of_match_device().

Fixes: 3818715f62b4 ("drm/bridge: imx: Add LDB support for i.MX8qxp")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
index 7984da9c0a35..d272f35c8eac 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
@@ -488,6 +488,8 @@ static int imx8qxp_ldb_parse_dt_companion(struct imx8qxp_ldb *imx8qxp_ldb)
 	 * string.
 	 */
 	match = of_match_device(dev->driver->of_match_table, dev);
+	if (!match)
+		return -ENODEV;
 	if (!of_device_is_compatible(companion, match->compatible)) {
 		DRM_DEV_ERROR(dev, "companion LDB is incompatible\n");
 		ret = -ENXIO;
-- 
2.30.2

