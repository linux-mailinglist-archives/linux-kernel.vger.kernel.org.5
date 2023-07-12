Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFE75120B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjGLU5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjGLU5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:57:46 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E311BEC;
        Wed, 12 Jul 2023 13:57:45 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b5d5e6b086so790491a34.1;
        Wed, 12 Jul 2023 13:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689195464; x=1691787464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1RnYYOt2ROeAmSiJt8+HCO24CDCU5SuB0/XP79pTxVU=;
        b=HoO3K91cclh+Ar8T00O5cP1lKwZeTWwAiaR/SLOkDnhDkXG+Xk0zKHG6XykVvda24i
         Ak818Mw3+mPA1kgFE5DIVfcpGuhfXaAlGWTrCME+mnv6AjzSPkcxAtbQGgx9Dc6drHYV
         lt+Mvppfu2m/rDowChjeOAbpCu9N/utyr6Plr5UEMTFEf03iOvTScbDdBtusSuL4Xdsi
         6+TSgtHX7dlze9xjbIeEuTytDwRfYQNXNAPoI4An2QJlBMOvWp/dPT6YzIqpzShmRrNx
         ha6lASemaLZ5SH8/qBsENOkXgUlfBTSXvZnzKqTl81bWUq3y07/a5Dq2GKV8oy+gyupA
         35sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689195464; x=1691787464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RnYYOt2ROeAmSiJt8+HCO24CDCU5SuB0/XP79pTxVU=;
        b=WDjDeJXQcB5pNNDznkax3Q4Ln9gQ1k1LtlkSiwLHuUz4kN512Ch8BnVHGW4xlZ6utE
         mqmigN5Hido7wWiIPlODJkfXldgLAMt/5uB+yhkX7A+2rbwIYCYt/V3biXacbnOkOReU
         JW18ru2TMFISOgEX2n2lvWesf4PgVnezaTy9cIv3I8HgggXrDX+RCiqDCLReFPp7CV3V
         sMAaUUxjqhACBSMOkd1bJjrubRbsFqY+KDsqY9dbBGxJ+AzWlmlY+zNOHJfR+xo4S/iW
         03EEdPir6SZ7DqISF93KI6sfIazY8JxiSAqK6TTGj0vcADdkQekFnFWmAQlKFhdVUjus
         rYHA==
X-Gm-Message-State: ABy/qLbXPvFqYdGwrkzULKXWCVYKGvC4sZ1u1XI8Wqb0QlgzQdTZolhb
        ghl7cja/MQkV/G2TUkjJ0iA=
X-Google-Smtp-Source: APBJJlE1MYhtH+H9dFumCjnqewXMgIlQ6LNofQwnPzRvk2hpc95lQHmslpfQWnbzhMZSs/hirn/rPA==
X-Received: by 2002:a9d:7759:0:b0:6b8:b83c:a1f8 with SMTP id t25-20020a9d7759000000b006b8b83ca1f8mr1617676otl.19.1689195464515;
        Wed, 12 Jul 2023 13:57:44 -0700 (PDT)
Received: from localhost.localdomain ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id b3-20020a056830104300b006b469ace1b1sm2288715otp.22.2023.07.12.13.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 13:57:43 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        syzbot+cf71097ffb6755df8251@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: [PATCH] staging: 7811: Fix memory leak in _r8712_init_xmit_priv
Date:   Wed, 12 Jul 2023 15:57:32 -0500
Message-ID: <20230712205733.29794-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the above mentioned routine, memory is allocated in several places.
If the first succeeds and a later one fails, the routine will leak memory.
Fixes commit 2865d42c78a9 ("staging: r8712u: Add the new driver to the
mainline kernel").

Fixes: 2865d42c78a9 ("staging: r8712u: Add the new driver to the mainline kernel")
Reported-by: syzbot+cf71097ffb6755df8251@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 090345bad223..16b815588b97 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -117,11 +117,8 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	_init_queue(&pxmitpriv->pending_xmitbuf_queue);
 	pxmitpriv->pallocated_xmitbuf =
 		kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4, GFP_ATOMIC);
-	if (!pxmitpriv->pallocated_xmitbuf) {
-		kfree(pxmitpriv->pallocated_frame_buf);
-		pxmitpriv->pallocated_frame_buf = NULL;
-		return -ENOMEM;
-	}
+	if (!pxmitpriv->pallocated_xmitbuf)
+		goto clean_up_frame_buf;
 	pxmitpriv->pxmitbuf = pxmitpriv->pallocated_xmitbuf + 4 -
 			      ((addr_t)(pxmitpriv->pallocated_xmitbuf) & 3);
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
@@ -130,12 +127,12 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 		pxmitbuf->pallocated_buf =
 			kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ, GFP_ATOMIC);
 		if (!pxmitbuf->pallocated_buf)
-			return -ENOMEM;
+			goto clean_up_xmit_buf;
 		pxmitbuf->pbuf = pxmitbuf->pallocated_buf + XMITBUF_ALIGN_SZ -
 				 ((addr_t) (pxmitbuf->pallocated_buf) &
 				 (XMITBUF_ALIGN_SZ - 1));
 		if (r8712_xmit_resource_alloc(padapter, pxmitbuf))
-			return -ENOMEM;
+			goto clean_up_xmit_buf;
 		list_add_tail(&pxmitbuf->list,
 				 &(pxmitpriv->free_xmitbuf_queue.queue));
 		pxmitbuf++;
@@ -146,6 +143,14 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 	tasklet_setup(&pxmitpriv->xmit_tasklet, r8712_xmit_bh);
 	return 0;
+
+clean_up_xmit_buf:
+	kfree(pxmitbuf->pallocated_xmitbuf);
+	pxmitbuf->pallocated_buf = NULL;
+clean_up_frame_buf:
+	kfree(pxmitpriv->pallocated_frame_buf);
+	pxmitpriv->pallocated_frame_buf = NULL;
+	return -ENOMEM;
 }
 
 void _free_xmit_priv(struct xmit_priv *pxmitpriv)
-- 
2.41.0

