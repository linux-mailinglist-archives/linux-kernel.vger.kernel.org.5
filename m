Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28790781C0E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 04:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjHTCfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 22:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjHTCfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 22:35:39 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5C37D810
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:28 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76cded293e8so149164885a.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 17:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1692492328; x=1693097128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAOkobjP7Wkz3qWYoXgCw5Zbn+EJxaWf/bYJaog4oo8=;
        b=k2VZ87YKBlm1HUYmHdzMuIb9GMbJCxHTlletAiMw/oLTpVP7RM1wreeYnyx/bZ5los
         C3bILGXuQE5CZgUqzYEBQaD6J+UUS3EIKenWtcg7RCROuFF0Ed+5FNOtlg2uofm+GSqr
         dnPnkyN73QKSqeQP2TdfbXN0CD4wnrHlnFaBQXS6M/H/PwjRynF9RQO+EEZKXdur+8r3
         YRYdodIqqt9+mwUPXkZJTf87+gOdzE3p7/w+bizezQbI8xaKD+zBcgNnz5tHstgxUKac
         IGvVFGa51k+4+jCWdWU6SqggLkOrMlg+bWhricGY2iux53GmPHuuwWPlwn5cc9dMxVOM
         NmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692492328; x=1693097128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAOkobjP7Wkz3qWYoXgCw5Zbn+EJxaWf/bYJaog4oo8=;
        b=T/+QP4K1x/NvjaSdDsLQSJZkhvIVGAg6qd4U/x6njyRNRAF3ZtjRFCG7+rUl1L7y3g
         21gxApG11bJ2xENbQ5xZTd/T7ABnsKTBNdpiYT7unR/9oY+cO2ZLVCMHZiAuGBZCnJSI
         02++5sus0SRcmpcx40gWCJw4QL7Noh0YaZ0g70Y97YovNh0bk4NUpfOsWC9kbKVDeqdh
         WP/BNmcaMbQuOl9S/7bEuBHlRYtvB94YAch3aS9mk4Z6DUtgocYOWaxHZPCC/aZGZtyZ
         t9sVvpFuIleUtJlOmPI7Ke4Ly7+Ac1SMDnqpO+yOCrJd4PXiiaj/i0VvdIiIwhiumAKW
         zREQ==
X-Gm-Message-State: AOJu0YxjG2La6BlOsyM4aoeixQcOiKyD+GwgJNloVLWQ+HGMOvVANvVh
        y4k96JJF10yFvtms2NOGg8wrLw==
X-Google-Smtp-Source: AGHT+IFegj/z8aF56tvf5mmWpMbfhNfPowM/PyDVQ3EYK+tT6/nq8y8gRAdPO4BNs4xOEZ68PtCjzQ==
X-Received: by 2002:a37:ef17:0:b0:76c:e9d3:cac2 with SMTP id j23-20020a37ef17000000b0076ce9d3cac2mr3698598qkk.27.1692492327816;
        Sat, 19 Aug 2023 17:45:27 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a1a1900b00268b439a0cbsm4004884pjk.23.2023.08.19.17.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 17:45:27 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 11/16] Staging: rtl8192e: Rename variable pTS in function prototype rtllib_FlushRxTsPendingPkts()
Date:   Sat, 19 Aug 2023 17:47:39 -0700
Message-ID: <20230820004744.278022-12-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820004744.278022-1-tdavies@darkphysics.net>
References: <20230820004744.278022-1-tdavies@darkphysics.net>
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

Rename variable pTS in function prototype rtllib_FlushRxTsPendingPkts()
to ts, to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0c812eb02ba6..9c2817e8a5d4 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -2039,7 +2039,7 @@ bool rtllib_MgntDisconnect(struct rtllib_device *rtllib, u8 asRsn);
  * ieee handler to refer to it.
  */
 void rtllib_FlushRxTsPendingPkts(struct rtllib_device *ieee,
-				 struct rx_ts_record *pTS);
+				 struct rx_ts_record *ts);
 int rtllib_parse_info_param(struct rtllib_device *ieee,
 			    struct rtllib_info_element *info_element,
 			    u16 length,
-- 
2.41.0

