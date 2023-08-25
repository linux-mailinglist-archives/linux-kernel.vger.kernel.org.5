Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C63788ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245686AbjHYOHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjHYOHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:07:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27E42D5A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a41035828so793453b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692972386; x=1693577186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ye0aiLYQHwIYocZ63gEkhoa8stFG6RRB55RfB3sI6K4=;
        b=T9+DWrQuvWlyPD4Cg/tRBuq8PLK1JO5xxOuVKByPMooBYBgi2nu3zhdT25tNVWi8wL
         Qbrdeh8t1ToBWL3pp3QY7pF5gNLRXf+KsYDpq2x9KE7zn4V+bNb2I1n7Z1SfyTcXwwtY
         bjeHYHssEaehCnI/uJcFF/E6GQ1Eeb9S83JCkzpbVzDte3xL9UvMqzzAUCkpOZe4jARb
         9kKTWWievURqh9flZSjsyjRjhVDpcNNnlwf0yV8mZacfoQ8OtiFepLnjHyBGmHiDhtWE
         Dpqt2fhH4+mh+0JBiBtKxBoFTE/qcxYk9YuTpbhVPLO8ulDw3FpQlqjxDNhwLa9UW6U5
         NXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972386; x=1693577186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ye0aiLYQHwIYocZ63gEkhoa8stFG6RRB55RfB3sI6K4=;
        b=XZDaNew655YdsLFQPVuTLQSPcQzFjlBA6Tls99j+KhO8GMLKeIlf/tRnC3T5vmiBy6
         Ij+DWniL+FSe+91HX4F+9NE9un0tl9UqKHhC0N9Z5xriRlACvy5hMWPFj5u1NmfBw/nv
         rfJ12XMg/KHpy2ZW6IdL8/UEzCVF/4Jrk81zm/1hXMvJ33hggeCEuJVLy2s8H6Aidwc5
         l2SbiDKqYDknDOlMAwFA/Z4nkL3YlkNR8EQk1yeF6Alb58Gq2ZWmbB8UBo+lPgWuPSm0
         gW75sqQO3YBuBk9zzpcDSm2/sZa8kwAJH4K58tzC388MzugSzyimAN84n51RVQKOV/dN
         jHVw==
X-Gm-Message-State: AOJu0Yw5UBEKG+buxjtJnNMG5WlGC8zHAUr/R8b2eoq9kT61UZ2qhP7q
        8fHIjnzAogqdA0IA+i0/4zsUGQ==
X-Google-Smtp-Source: AGHT+IFbYh3cBO1wi6bunDMHE78FQpdVmSAQlp+aQEmmeW9CFfJmQhzWOrS/73jSdFKiSXyAYTaWGw==
X-Received: by 2002:a05:6a00:2ea6:b0:68b:dfef:de77 with SMTP id fd38-20020a056a002ea600b0068bdfefde77mr7321839pfb.25.1692972385784;
        Fri, 25 Aug 2023 07:06:25 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id v23-20020a62a517000000b006870721fcc5sm1628232pfm.175.2023.08.25.07.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:06:25 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v4 09/16] Staging: rtl8192e: Rename variable tmp in function GetTs()
Date:   Fri, 25 Aug 2023 07:08:40 -0700
Message-ID: <20230825140847.501113-10-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825140847.501113-1-tdavies@darkphysics.net>
References: <20230825140847.501113-1-tdavies@darkphysics.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename variable tmp in function GetTs() to ts in order
to make the name consistent with other references of type
struct rx_ts_record.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
v4:Resending whole series as v4
v3:No Changes
v2:No Changes
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

