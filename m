Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F09755982
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjGQC2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQC2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:28:01 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0C31AA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 19:28:00 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R45bK2KwhzBHXhQ
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:27:57 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689560877; x=1692152878; bh=99RFAXWtJFaUvOMEuVHX9uYuQ0v
        tcClcFPABWjk/Vi4=; b=D1pFZbFbhEbVEDigmSTuDwa2+n2JJN8KXPN0FXnGuuo
        fgINaJ1dT83u4S4M1sfiKRaRIu0sW6151dG/v5bKauplIFoD+RG5UT4dDI7aZNim
        f8no88ObrkHvQlMDKI+LDI88BNMhBcii3dP4lMt/qFPndErKBuVUukW/EB6uErPr
        ESkCGDZnUQMuMlsijsIRoJkyerVTHVYMtg+N6Q6GNK7p3HYIXljUrgu8Eo65PxSA
        G1NRES/J43MTgQuy/x1ChJmrU8Kx+Uhwzp3FfIABXJmJTYLweq6zLKDUJlaI7ige
        anhrBpEzg54DTa+IbMDrdGt2uDS51vBi2mJmBGa2P5w==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BA6zgpAOZ3ac for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 10:27:57 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R45bK0LnwzBHXR9;
        Mon, 17 Jul 2023 10:27:57 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 10:27:56 +0800
From:   hanyu001@208suo.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] myri10ge: Prefer unsigned int to bare use of unsigned
In-Reply-To: <tencent_6D5BA78E96792524AFC51045DB50A6203907@qq.com>
References: <tencent_6D5BA78E96792524AFC51045DB50A6203907@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <d5ac1bb7a79b43c8349cf9012671791d@208suo.com>
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

Fix checkpatch warnings:

./drivers/net/ethernet/myricom/myri10ge/myri10ge.c:572: WARNING: Prefer 
'unsigned int' to bare use of 'unsigned'
./drivers/net/ethernet/myricom/myri10ge/myri10ge.c:579: WARNING: Prefer 
'unsigned int' to bare use of 'unsigned'
./drivers/net/ethernet/myricom/myri10ge/myri10ge.c:614: WARNING: Prefer 
'unsigned int' to bare use of 'unsigned'

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c 
b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index 65d7057..8de2e5e 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -569,14 +569,14 @@ static void myri10ge_dummy_rdma(struct 
myri10ge_priv *mgp, int enable)

  static int myri10ge_load_hotplug_firmware(struct myri10ge_priv *mgp, 
u32 * size)
  {
-    unsigned crc, reread_crc;
+    unsigned int crc, reread_crc;
      const struct firmware *fw;
      struct device *dev = &mgp->pdev->dev;
      unsigned char *fw_readback;
      struct mcp_gen_header *hdr;
      size_t hdr_offset;
      int status;
-    unsigned i;
+    unsigned int i;

      if (request_firmware(&fw, mgp->fw_name, dev) < 0) {
          dev_err(dev, "Unable to load %s firmware image via hotplug\n",
@@ -611,7 +611,7 @@ static int myri10ge_load_hotplug_firmware(struct 
myri10ge_priv *mgp, u32 * size)
      for (i = 0; i < fw->size; i += 256) {
          myri10ge_pio_copy(mgp->sram + MYRI10GE_FW_OFFSET + i,
                    fw->data + i,
-                  min(256U, (unsigned)(fw->size - i)));
+                  min(256U, (unsigned int)(fw->size - i)));
          mb();
          readb(mgp->sram);
      }
