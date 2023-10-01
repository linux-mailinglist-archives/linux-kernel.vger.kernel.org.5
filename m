Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6047B47AD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjJANpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjJANpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:45:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F3EE8
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:45:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-406553f6976so6205635e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696167909; x=1696772709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+SB15LjBo6aILGXM+nVMfGuTrZhkGA5r6PNyI0UWDI=;
        b=Tn0vOWZULl6K1+ZkwsBnksha9pDq2Lf3yXy6k/oVphIA1i/CNuzF8J4Mxt3T51BWqB
         0d78J5/OaLDRoi5vohsMBs0Ge1zYYCRcfWxs6ppTGYkfz9fhOHlrAcxFppCULv0GA2IG
         UCUNviwJTeR8L7V7XtbkDxUVl5DBgklw+quTHQGUIvWF52igV8OoqRaYsGt8fpssZ5TB
         4mMH/prShCpcqiTz12yZ0B+r+87JUnRJcKGIr9oZC0D5/aYIOw6eJBeOsKIWwzazbaeZ
         +ZmH7daqSFngyPu7bYZVn0WYZIkfpAi0JOtoOgFjb5Qhax+S59F5hAMQHoOx4QReucj1
         ALoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696167909; x=1696772709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+SB15LjBo6aILGXM+nVMfGuTrZhkGA5r6PNyI0UWDI=;
        b=FG8Faxq1S6IhBv3qLkVVgFIWAtRRJD0Ygz4YKc3y8ODxN0JjYKrQ8lePDpbA9l0dGf
         3zOLYy8sJ4Pyz5a30VQKE4GbiWcXVHkx5j+in2D/uEEmKTPxfQtXkNV/V38cXeFTlZXO
         eNAa0DuNguUmwKMDzXWlBJDN/v4pGT5w7nQSIVoZ7uexk/v2yfcx4saz+mudByjvYHhc
         Z09cx/zc27ydE3TNMmOcXKluazp58EeE5EG+rJmQ+XI64teZyuCrxTxj+UV/LKm6wnSs
         hUEqLBs+aWlQ2KPeU6zUylIyjZJ3QHicSltsqDeloCNm1zBXXdXVjxmbkfZ27v1hBIIt
         mQtw==
X-Gm-Message-State: AOJu0YyD1DZUVhJMoT48X7LuIysXTKN3J/KHoTia2wxmIllD/if0f+FV
        xM5VHQj0+gJhZNfEOImq9mg=
X-Google-Smtp-Source: AGHT+IHFqni/ARgFFk2kkfNXSK4L4Jqc3PQeph4iWUAVQ0S82xK5l5NBfqntOWP0BKc6i3q71NwFpA==
X-Received: by 2002:adf:dd91:0:b0:317:3da0:7606 with SMTP id x17-20020adfdd91000000b003173da07606mr7784635wrl.4.1696167909191;
        Sun, 01 Oct 2023 06:45:09 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id t21-20020a170906179500b00988e953a586sm15516694eje.61.2023.10.01.06.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:45:08 -0700 (PDT)
Date:   Sun, 1 Oct 2023 15:45:07 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] staging: rtl8192e: Remove unused parameter from
 _rtl92e_up()
Message-ID: <24f221c44beae8e6fbf895f82fe04b082f8679d5.1696165351.git.philipp.g.hortmann@gmail.com>
References: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused parameter is_silent_reset from _rtl92e_up().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 94a73f9cf888..2b91c481df93 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -61,7 +61,7 @@ static short _rtl92e_pci_initdescring(struct net_device *dev);
 static void _rtl92e_irq_tx_tasklet(struct tasklet_struct *t);
 static void _rtl92e_irq_rx_tasklet(struct tasklet_struct *t);
 static void _rtl92e_cancel_deferred_work(struct r8192_priv *priv);
-static int _rtl92e_up(struct net_device *dev, bool is_silent_reset);
+static int _rtl92e_up(struct net_device *dev);
 static int _rtl92e_try_up(struct net_device *dev);
 static int _rtl92e_down(struct net_device *dev, bool shutdownrf);
 static void _rtl92e_restart(void *data);
@@ -1707,7 +1707,7 @@ static void _rtl92e_cancel_deferred_work(struct r8192_priv *priv)
 	cancel_work_sync(&priv->qos_activate);
 }
 
-static int _rtl92e_up(struct net_device *dev, bool is_silent_reset)
+static int _rtl92e_up(struct net_device *dev)
 {
 	if (_rtl92e_sta_up(dev) == -1)
 		return -1;
@@ -1731,7 +1731,7 @@ static int _rtl92e_try_up(struct net_device *dev)
 
 	if (priv->up == 1)
 		return -1;
-	return _rtl92e_up(dev, false);
+	return _rtl92e_up(dev);
 }
 
 static int _rtl92e_close(struct net_device *dev)
@@ -1770,7 +1770,7 @@ void rtl92e_commit(struct net_device *dev)
 	rtllib_softmac_stop_protocol(priv->rtllib, 0, true);
 	rtl92e_irq_disable(dev);
 	rtl92e_stop_adapter(dev, true);
-	_rtl92e_up(dev, false);
+	_rtl92e_up(dev);
 }
 
 static void _rtl92e_restart(void *data)
-- 
2.42.0

