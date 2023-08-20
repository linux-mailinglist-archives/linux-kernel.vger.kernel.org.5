Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88412781BD9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjHTA6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjHTA5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:57:17 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E468B7D80B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:26 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1c8d895a602so1220117fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492326; x=1693097126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkHoJUzAPxMfc68EFG3kieBAI+4mssO5bS+U9HMrCPk=;
        b=kswwQzhfuCff78t+mtiEViBxtJqIKAU9NdE+RgljpHCkdo6pb8vnUWyMbAfBYrsxW6
         tC/lBInZSV9OjwKvs0BtIP6VQkqfXSsXm4HqtuAr17yBzVEG2VhiCB7nyucA5JhTaeQZ
         dlvN4VZT/LXkrl3AJKazyjYzXnbsX5kWGo5ZOq/0Y8TM7dpO0IS8iZw5sdiOpL2nrkwU
         /ACXRKMNmMEJfyOv+ZyR/MhU2QioTf3FFS8i5fYtcfVNf3XU9KLYUs2TTiwNbFIsFyKb
         lLpxaWNyOyjoVpZ6d6cgxT/H8mbF+OwGgFrlj8rYg/3aUVIXJvXZ4E2txZEMeO0INSaK
         x0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492326; x=1693097126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkHoJUzAPxMfc68EFG3kieBAI+4mssO5bS+U9HMrCPk=;
        b=ZIPRr//CZxGN4UjLWsSQu9dFYRXzk+PbCr1QOX/PfVNJA2nmWdKhD++Er2qyK3nYp5
         bsevDjjNqszQac1H1mwy7P5sup99IHkZsPi8KCn2qKXdINTqnRY2pDyn5bf8JSDrpmeH
         eOOlDztQ65gbFE5Tqsdpoqz3AGGZJJcGsoN09LziG2F6X5/1NL1NPxQYIMXenJNYw53o
         UmipA+qnTHQ3lkueXih7rfp30/SZtNPiunufqCsAa70nQdK1DdtLiuw2PD5taIBaYjgC
         OJr19+7HtHtLlSffqaOErwXrzwSigqwarrlx33KYlAPVxS1E+wFchd/6XUcnqiaML9p7
         3w5A==
X-Gm-Message-State: AOJu0YxOmNnYXVvShCXWTgFhH+8YWZgynJqbMawjHxD3B8ATs4kIJWPb
        QzCN2TfJ7XpgG0cmPqQMsdxkoMX5WtaASZ4z5K589K5p
X-Google-Smtp-Source: AGHT+IHImiKD+aQRv8PXSU3VVg5OLr83ViuWGdc8FfjH9gyrDraPvn3XLBCqqEXvAaAdeHgBNkQeLQ==
X-Received: by 2002:a05:6870:c094:b0:1bf:11f1:4729 with SMTP id c20-20020a056870c09400b001bf11f14729mr3857629oad.56.1692492326276;
        Sat, 19 Aug 2023 17:45:26 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:26 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 09/16] Staging: rtl8192e: Rename variable tmp in function GetTs()
Date:   Sat, 19 Aug 2023 17:47:37 -0700
Message-ID: <20230820004744.278022-10-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820004744.278022-1-tdavies@darkphysics.net>
References: <20230820004744.278022-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable tmp in function GetTs() to ts in order
to make the name consistent with other references of type
struct rx_ts_record.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index ac97b6d627da..131a5d7b4599 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -325,11 +325,11 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 				TsCommonInfo);
 			ResetTxTsEntry(tmp);
 		} else {
-			struct rx_ts_record *tmp =
+			struct rx_ts_record *ts =
 				 container_of(*ppTS,
 				 struct rx_ts_record,
 				 ts_common_info);
-			ResetRxTsEntry(tmp);
+			ResetRxTsEntry(ts);
 		}
 
 		netdev_dbg(ieee->dev,
-- 
2.41.0

