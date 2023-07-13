Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546CA751DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbjGMJul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjGMJuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:50:39 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861592127
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:50:37 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1qbv0r1DzBRRLX
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:50:35 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689241835; x=1691833836; bh=6WnmXWGeuIprBtGV4+/Kt79fxFd
        2Fye2zKda3lFwPA0=; b=n7J1t9A7pIno3IJaEq5wQLqqndVR2Qv9RADwNbWd38E
        iTTSITUButtJWQT4Wn6qMKpKQJO7vD81o/3WyoXjgFPvSmrwJTZUrTTqy6zIlsPW
        mmv9xMosM3nTxcQ5ejMjndmlk01i2RcbXiKYfDzE/EkY28K8qh0XMqGEEBHaBXQU
        32O4imTGRkw9/WUkIGj7rupIYPUb48fVE/drRIXEE/QiEPNxnk9YKVukJhIpdKkQ
        n+/f4OFxyDvKfKnVY8Xlk+y7Mv6o+MymFYL+IKChpKN9i3xtnYjhaesAicXOeNtU
        GagHNP7Q5o/9/322q5a5jkWJCABHDXJf7MQ3Qjiv1+w==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xJQQCp--mSP6 for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 17:50:35 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1qbt5VRWzBHXgh;
        Thu, 13 Jul 2023 17:50:34 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 17:50:34 +0800
From:   hanyu001@208suo.com
To:     jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] fsi: replace snprintf with sysfs_emit
In-Reply-To: <tencent_C55557552E8EDB1001D0B2D7629CDB0A0C0A@qq.com>
References: <tencent_C55557552E8EDB1001D0B2D7629CDB0A0C0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <465bfbd0726d1f24d1684fa5dc97cc9c@208suo.com>
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

coccinelle report:
./drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c:
479:9-17: WARNING: use scnprintf or sprintf

./drivers/fsi/fsi-master-ast-cf.c:1086:8-16: WARNING: use scnprintf or 
sprintf

Signed-off-by: ztt <1549089851@qq.com>
---
  drivers/fsi/fsi-master-ast-cf.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-ast-cf.c 
b/drivers/fsi/fsi-master-ast-cf.c
index 5f608ef8b53c..294ca962f569 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1083,7 +1083,7 @@ static ssize_t external_mode_show(struct device 
*dev,
  {
      struct fsi_master_acf *master = dev_get_drvdata(dev);

-    return snprintf(buf, PAGE_SIZE - 1, "%u\n",
+    return scnprintf(buf, PAGE_SIZE - 1, "%u\n",
              master->external_mode ? 1 : 0);
  }
