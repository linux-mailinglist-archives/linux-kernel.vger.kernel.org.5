Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560C37B65FC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbjJCKCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjJCKCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:02:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66A191;
        Tue,  3 Oct 2023 03:02:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso1139507a12.0;
        Tue, 03 Oct 2023 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696327349; x=1696932149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0D9ErtnzA2GpIpQYRTV/PEhl9qcHXadLDJ8uRkyriWg=;
        b=c7/VYGxgZ0CqBogVAf9FH8yWKciLCMyxiT1iAy2uaE/2n7pmYp6pKvY8WGaQhxHY6k
         3TMHbTaKDiDYEZ/EgxWsmWgVorfWrWsWgye3DCh1T+gp0P3rPdd/rTVNj88IAra21Hx1
         Qf8cROXy3nEi3/QK5DGNNDyKOvR3QuIJc7aD7sBy8Hhz/ic+0RyLxgFVOxGTGtdN0nFd
         mT4YjS5c9MSJlsw732OURb3Rne5f6DtfVE0E9oPjKd40a2oeIv1EVw0TtDKgddN0Vxud
         xxU0Cqbz0l2AjrzkwXT/g+4oJfpfdXxEUZCTxP8z7PgUa1Y8QR95M3XFotco9uZ2P8cK
         B2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696327349; x=1696932149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0D9ErtnzA2GpIpQYRTV/PEhl9qcHXadLDJ8uRkyriWg=;
        b=wHXu4Lbr+n9+4HnI2QObbs+D7ojWx6V6r0hhKvLLgvXf02FvrsgsF7ljO2PL/osgEG
         Jyx35vWGSVgC4u6ZcOxGfSsEIxA+RkSkeH7ly/QAb2BwJySJCf5migN3+iJMc17tRCYQ
         yn6TeTCT1FMQ3S1UGOCMu07YEb2opSqFUtxjFcRhJcLfuuSdgCq8WfHGpsotT91m0Sl2
         9dKMRtCn0CiaBvG6h36OyRbEvwYPPyDbECPatCagRFlfX/cmDb6098IPUpuLtbcoYKCA
         p5ZME9x6XDidXhbfC8BOpLOtNmGeajLQ5i1Ue1prMdPNmKw0zSF+ms5xyVZbQpPy6Bc0
         +YgQ==
X-Gm-Message-State: AOJu0Yz6A2MOWFG2BSUuUiOCmjVlqixloTh9G9mMFfpKIyHhvqCgmHoU
        9Uh7TVkmpVj8Q7CWZq0l1XdLQno2/ws=
X-Google-Smtp-Source: AGHT+IH0k5yMa/0iYCiPQ1fuG/HKEuGdzG1sxKEBA5/Y49MjGitabCCmKzp2v1l1prAMschwvTRcUQ==
X-Received: by 2002:a05:6402:1257:b0:530:77e6:849f with SMTP id l23-20020a056402125700b0053077e6849fmr12709177edw.27.1696327348717;
        Tue, 03 Oct 2023 03:02:28 -0700 (PDT)
Received: from sauvignon.fi.muni.cz (laomedon.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id s7-20020aa7c547000000b0052595b17fd4sm607137edr.26.2023.10.03.03.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 03:02:28 -0700 (PDT)
From:   Milan Broz <gmazyland@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     gjoyce@linux.vnet.ibm.com, jonathan.derrick@linux.dev,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Milan Broz <gmazyland@gmail.com>,
        Ondrej Kozina <okozina@redhat.com>
Subject: [PATCH] block: Fix regression in sed-opal for a saved key.
Date:   Tue,  3 Oct 2023 12:02:09 +0200
Message-ID: <20231003100209.380037-1-gmazyland@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 3bfeb61256643281ac4be5b8a57e9d9da3db4335
introduced the use of keyring for sed-opal.

Unfortunately, there is also a possibility to save
the Opal key used in opal_lock_unlock().

This patch switches the order of operation, so the cached
key is used instead of failure for opal_get_key.

The problem was found by the cryptsetup Opal test recently
added to the cryptsetup tree.

Fixes: 3bfeb6125664 ("block: sed-opal: keyring support for SED keys")
Tested-by: Ondrej Kozina <okozina@redhat.com>
Signed-off-by: Milan Broz <gmazyland@gmail.com>
---
 block/sed-opal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 6d7f25d1711b..04f38a3f5d95 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -2888,12 +2888,11 @@ static int opal_lock_unlock(struct opal_dev *dev,
 	if (lk_unlk->session.who > OPAL_USER9)
 		return -EINVAL;
 
-	ret = opal_get_key(dev, &lk_unlk->session.opal_key);
-	if (ret)
-		return ret;
 	mutex_lock(&dev->dev_lock);
 	opal_lock_check_for_saved_key(dev, lk_unlk);
-	ret = __opal_lock_unlock(dev, lk_unlk);
+	ret = opal_get_key(dev, &lk_unlk->session.opal_key);
+	if (!ret)
+		ret = __opal_lock_unlock(dev, lk_unlk);
 	mutex_unlock(&dev->dev_lock);
 
 	return ret;
-- 
2.42.0

