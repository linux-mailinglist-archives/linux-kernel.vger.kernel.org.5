Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDAA7CD31F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 06:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjJREhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 00:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjJREgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 00:36:52 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD3810B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 21:36:49 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6bce254ba56so2681160b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 21:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697603808; x=1698208608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSddBUAe956x9GyHNcmiKlaDE7dW5RFLQMzOpH7UipA=;
        b=IEL+E+NLdS0EgThTg0TeqEgvdFKwJD+b4d7B52kP7+X2I9w7fcjWm4jSTqOw3zoFKG
         i/rlQ+reCqz8NDRgeIH9H0xdKJhex/nydYPlG7pSShvtODYMRpsJFHW0ugxfi4Nar7Cx
         bX5gdpqQDa378nukU+qMcJnKdtIcqYjeuGw3kHilazlNVsVX96f578KxyTuDnw3WpZUi
         w8FmQvgwGu6vzAGkbXHZIyjuxeXmDKlUyZDdERRGqFQgpqrYFoe61CiwPf0DEPdoSRvL
         teiMZL0C9DNX6/q6q80Hn9Ecrxi0xnI5iKnrn3OSpSt/HQPNmxGj7C+6cmroF6Bw2o3N
         bbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697603808; x=1698208608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSddBUAe956x9GyHNcmiKlaDE7dW5RFLQMzOpH7UipA=;
        b=oAIwHrDOz5KYJdTwuGjw7y2UdgIyajbYKNuEEEHpuKXVJd3VYMzXqM5aj9VV2jX9G/
         YphszUqwowV9ho/NbgFI4S0UkNPew1hW8QflzIpb59xpMVZbzV4Z/5CxCsvA11ov4eDX
         TDPCBeAYrdP/h4X4eW7Z6y1TPv7sil8yQA7MB1h8PhlBp1B2hM3E5eg0xTlhRtNBPNI8
         oqckAbugPA7/+1oQAj//hPrEJo0OKto7DvthHX+GMFHfRva08BhRDXzWyUC/A7UOw/yJ
         IbMNeXmRN0UlAYAZVQnoReNuOmZ4wvzyoFV3cW8Zq6FuYmesVMWV6XfoE08Yy0TnPfHD
         R3DQ==
X-Gm-Message-State: AOJu0YwWkORITMIbcqv5nZ5AcEhS4rYPtfTZHeDzu10dpuKJVq+FTwB9
        uo7Wyy/cMCE9iLiLMLVifYQteSYJsOOxQQ==
X-Google-Smtp-Source: AGHT+IGCaQ0E9lrWBwLhwhSx+BpUyciw5QPK+upLQ3W33LPDXkewu/finbRuG18hTKEHJkZnWNI66w==
X-Received: by 2002:a05:6a20:7494:b0:161:2bed:6b3a with SMTP id p20-20020a056a20749400b001612bed6b3amr3987395pzd.17.1697603808486;
        Tue, 17 Oct 2023 21:36:48 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902788500b001ca222edc16sm2422852pll.135.2023.10.17.21.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 21:36:47 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH 2/2] staging: vme_user: Use __func__ instead of function name
Date:   Tue, 17 Oct 2023 21:36:33 -0700
Message-ID: <c553e5901f16b78681e74b2d77796f8fc102b602.1697601942.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697601942.git.soumya.negi97@gmail.com>
References: <cover.1697601942.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace function names in message strings with __func__ to fix
all checkpatch warnings like:

    WARNING: Prefer using '"%s...", __func__' to using 'vme_lm_get',
             this function's name, in a string

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/vme_user/vme.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index e8c2c1e77b7d..11c1df12b657 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -422,7 +422,7 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
 	image = list_entry(resource->entry, struct vme_slave_resource, list);
 
 	if (!bridge->slave_get) {
-		dev_err(bridge->parent, "vme_slave_get not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -572,7 +572,7 @@ int vme_master_set(struct vme_resource *resource, int enabled,
 	image = list_entry(resource->entry, struct vme_master_resource, list);
 
 	if (!bridge->master_set) {
-		dev_warn(bridge->parent, "vme_master_set not supported\n");
+		dev_warn(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1565,7 +1565,7 @@ int vme_lm_set(struct vme_resource *resource, unsigned long long lm_base,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_set) {
-		dev_err(bridge->parent, "vme_lm_set not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1601,7 +1601,7 @@ int vme_lm_get(struct vme_resource *resource, unsigned long long *lm_base,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_get) {
-		dev_err(bridge->parent, "vme_lm_get not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1638,7 +1638,7 @@ int vme_lm_attach(struct vme_resource *resource, int monitor,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_attach) {
-		dev_err(bridge->parent, "vme_lm_attach not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1671,7 +1671,7 @@ int vme_lm_detach(struct vme_resource *resource, int monitor)
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_detach) {
-		dev_err(bridge->parent, "vme_lm_detach not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1738,7 +1738,7 @@ int vme_slot_num(struct vme_dev *vdev)
 	}
 
 	if (!bridge->slot_get) {
-		dev_warn(bridge->parent, "vme_slot_num not supported\n");
+		dev_warn(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.42.0

