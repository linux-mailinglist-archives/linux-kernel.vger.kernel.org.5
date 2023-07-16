Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183B1754D45
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 06:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjGPELY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 00:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGPELU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 00:11:20 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61C11B8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 21:11:16 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R3Www4dhnzBHXgr
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:11:12 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689480672; x=1692072673; bh=CTsBTIbqlmVhMmez/i4F5aY/S0M
        mIqeeOyo3GPyqXvE=; b=yNMsw7veH00TsIuaSCzXFFTM5aScBa4csay0FbWMpKw
        IlsrTW3POpoX6A01zS1jB4gCcfgqvhPg2V6UYtCLYdlD85+BqUA8GVb0WDQIDOy1
        IG1ZPlvlHsex2xRNgLvVV2EqW9sDSxU3sogrVIWNz5N0vPk/jFqm/xYVSrZn8Pvk
        2SaDFe7gUbMUoI06er3XSvUv4QPGaMAsYv788JMaV6OaPQvde/YmyT8z0aYEYdCk
        AELc18GkSpsniIfkQO62uYarXMTgekpV9Szx8A+mt7f5W97Ee6GwRjADsK/GQyZ/
        OpHbVufCk3Yn/ONjt07Xgsu1d8nOvhEdO0s9DWHhf3A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mZ-YJC6lwl6q for <linux-kernel@vger.kernel.org>;
        Sun, 16 Jul 2023 12:11:12 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R3Www0JPTzBHXgf;
        Sun, 16 Jul 2023 12:11:11 +0800 (CST)
MIME-Version: 1.0
Date:   Sun, 16 Jul 2023 12:11:11 +0800
From:   wuyonggang001@208suo.com
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hiddev: Modify Format
In-Reply-To: <20230716040716.25980-1-zhanglibing@cdjrlc.com>
References: <20230716040716.25980-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <755134062a3e4f74ef781cb8593b0f1e@208suo.com>
X-Sender: wuyonggang001@208suo.com
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

Fix the following checkpatch error(s):

ERROR: "inode * inode" should be "inode *inode"
ERROR: "file * file" should be "file *file"

Signed-off-by: Libing Zhang <zhanglibing@cdjrlc.com>
---
  drivers/hid/usbhid/hiddev.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 59cf3ddfdf78..581dc33197d0 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -213,7 +213,7 @@ static int hiddev_fasync(int fd, struct file *file, 
int on)
  /*
   * release file op
   */
-static int hiddev_release(struct inode * inode, struct file * file)
+static int hiddev_release(struct inode *inode, struct file *file)
  {
      struct hiddev_list *list = file->private_data;
      unsigned long flags;
