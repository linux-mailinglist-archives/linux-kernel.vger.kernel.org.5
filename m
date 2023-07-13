Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7BD751D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjGMJ3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjGMJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:29:26 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A154112E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:29:25 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1q7Q3MSKzBRSVR
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:29:22 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689240562; x=1691832563; bh=QsDmrnrnsJCaJIX1Vc4ktSVE/rk
        ZqqgmvJQSwWR2qzE=; b=MQppogzMFWS0hnCB2BETozoyORTSrm8cdmmS5P6xdSI
        FcK8jQCHPfmidP/nBqT0AeMJlIpzKhGb4z/sslYx+ZnUxUDTwt3cHEmQh9mLE2kP
        sQkxY5fIVVbv+2RvUgO/ZUzUiH4B5/p+53CmNxncleAs2dZ0LOEuiVH43YWRv9FZ
        /R6mMYRKn1gLdpEosRDJAzOfGviLKg+ndebqzsiFQ699vH0Alcxrmtk7Yhh/9CAt
        gI5k7zJFXdQtJ4bCJjVm/8+H2ELo4xhqKqZ6Lz31DzclZs92SPqKozZsNurcZ8I8
        vj/wEraoqSgAN9smimgb1q6a9YMc9mLWK58Uq/jNlkQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Mnm2l0Gk2mxU for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 17:29:22 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1q7P68pKzBHXh8;
        Thu, 13 Jul 2023 17:29:21 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 17:29:21 +0800
From:   hanyu001@208suo.com
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] fsi:  Replace snprintf in show functions with sysfs_emit
In-Reply-To: <tencent_1E5AB8730E81C86AF0CAF2F10F222F5A9207@qq.com>
References: <tencent_1E5AB8730E81C86AF0CAF2F10F222F5A9207@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <14c7e158390db531969e7520710d5fab@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
   drivers/macintosh/ams/ams-core.c:53: WARNING: use scnprintf or 
sprintf.

./drivers/fsi/fsi-master-gpio.c:721:8-16: WARNING: use scnprintf or 
sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  drivers/fsi/fsi-master-gpio.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-gpio.c 
b/drivers/fsi/fsi-master-gpio.c
index 7d5f29b4b595..75499365729f 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -718,7 +718,7 @@ static ssize_t external_mode_show(struct device 
*dev,
  {
      struct fsi_master_gpio *master = dev_get_drvdata(dev);

-    return snprintf(buf, PAGE_SIZE - 1, "%u\n",
+    return scnprintf(buf, PAGE_SIZE - 1, "%u\n",
              master->external_mode ? 1 : 0);
  }
