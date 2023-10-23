Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3B77D2A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjJWGlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjJWGkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:40:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA3D1710
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:40:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e2308198dso866770a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698043238; x=1698648038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F8Js+K75dwM2UqnvWvlit1BEMnTsZVyd0yFufnZLxQg=;
        b=CXK0fnOXH0HmflS8gtDIOthHZXQfh+Q407syByslj/owxlGcL6jLqpZgEJTsFQ0K4G
         fcTYSD+Di55b8b48UJujbXzjLRTA+xB2qJ4Wk3/vQt11MYQHX3jNrs5WEd8HzqT7TGYU
         g8CfESEnU4fTMKgJ63a9RMMhtKxHRn9BRRmS7xNJbyNITMvXKvrWIBTMrSNaDQ5y/BZk
         MSz+sr/gVaIldi0wmHFwf4fBu+Qf2xipvEXqWVfTzYOgcbnHeTINS+C1G/DAgkp4MGzz
         6qK+KdXp4mdxRzDLpGtceXZTZ9+LuN0TWCo8egHnKjSdrKwY4rR8S7z3G9JO7pYADiPV
         rqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698043238; x=1698648038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8Js+K75dwM2UqnvWvlit1BEMnTsZVyd0yFufnZLxQg=;
        b=cXLVmv8IX3MQC8slwOrcCMuTSmDSv2Wva7aYqJMOP2Y9N+1djHNztddlsTkDhb0f7M
         Oujy1FvBAyEDih2NHK4GN+Ex4JJb2c5PPJQCFHv4TGXsajOuggmFYZvg9gBQ2ANcYdEE
         EyAQFoTZUwq5v5imV9Eq09XNVrxjabmLoQ9j0yJ1v5Q2xYxn4CipLRRakNuQXXQ/KxhO
         3rKfgfSlX62elXzoHWHBPrjcCDV6TK2mkTZgxn3FEljBUQPLt5UXvHfewlLBO9/Onwcu
         c2njQUbMH61uqWwQ9VrR2/o8PXAByitnOqoY6Vh7Rwf9C6wYD6E3c/Gg8c+yg0BEwY5V
         93hQ==
X-Gm-Message-State: AOJu0YzEL1Xf/LSr0RofefgVajpuZKx0lk69gwO8EjrOq/txRkTVkC3v
        XUTvIh2gfaDVn3c7X++Vyl0=
X-Google-Smtp-Source: AGHT+IGeNxy5iZyPzydLlwqRkupI3US48jdW+Lm2LCjHSfw5WfIbtXsOBr6EO1UyXcxVp6+kZLtaVQ==
X-Received: by 2002:aa7:c592:0:b0:53f:ca25:c580 with SMTP id g18-20020aa7c592000000b0053fca25c580mr6075622edq.1.1698043238550;
        Sun, 22 Oct 2023 23:40:38 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id s2-20020a50d482000000b0053ddbfa71ddsm5874405edi.47.2023.10.22.23.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 23:40:38 -0700 (PDT)
Date:   Mon, 23 Oct 2023 08:40:36 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] staging: rtl8192e: Remove unused union qos_tclas
Message-ID: <7e4d32fe7a1219a9131ce49308f68790e07fb83e.1698042685.git.philipp.g.hortmann@gmail.com>
References: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove union qos_tclas as it is just set to 0 and never used.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_Qos.h    | 50 -----------------------
 drivers/staging/rtl8192e/rtl819x_TS.h     |  1 -
 drivers/staging/rtl8192e/rtl819x_TSProc.c |  1 -
 3 files changed, 52 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index 9a9ef5fef6e0..f547de4c1da3 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -30,56 +30,6 @@ enum direction_value {
 	DIR_BI_DIR		= 3,
 };
 
-union qos_tclas {
-	struct _TYPE_GENERAL {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
-	} TYPE_GENERAL;
-
-	struct _TYPE0_ETH {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
-		u8		SrcAddr[ETH_ALEN];
-		u8		DstAddr[ETH_ALEN];
-		u16		Type;
-	} TYPE0_ETH;
-
-	struct _TYPE1_IPV4 {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
-		u8		Version;
-		u8		SrcIP[4];
-		u8		DstIP[4];
-		u16		SrcPort;
-		u16		DstPort;
-		u8		DSCP;
-		u8		Protocol;
-		u8		Reserved;
-	} TYPE1_IPV4;
-
-	struct _TYPE1_IPV6 {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
-		u8		Version;
-		u8		SrcIP[16];
-		u8		DstIP[16];
-		u16		SrcPort;
-		u16		DstPort;
-		u8		FlowLabel[3];
-	} TYPE1_IPV6;
-
-	struct _TYPE2_8021Q {
-		u8		Priority;
-		u8		ClassifierType;
-		u8		Mask;
-		u16		TagType;
-	} TYPE2_8021Q;
-};
-
 union aci_aifsn {
 	u8	charData;
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TS.h b/drivers/staging/rtl8192e/rtl819x_TS.h
index b63edb815902..240e808fc4b2 100644
--- a/drivers/staging/rtl8192e/rtl819x_TS.h
+++ b/drivers/staging/rtl8192e/rtl819x_TS.h
@@ -21,7 +21,6 @@ struct ts_common_info {
 	struct list_head		List;
 	u8				addr[ETH_ALEN];
 	struct qos_tsinfo TSpec;
-	union qos_tclas TClass[TCLAS_NUM];
 	u8				TClasProc;
 	u8				TClasNum;
 };
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 96022c5ed60f..7151827408b9 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -95,7 +95,6 @@ static void ResetTsCommonInfo(struct ts_common_info *pTsCommonInfo)
 {
 	eth_zero_addr(pTsCommonInfo->addr);
 	memset(&pTsCommonInfo->TSpec, 0, sizeof(struct qos_tsinfo));
-	memset(&pTsCommonInfo->TClass, 0, sizeof(union qos_tclas) * TCLAS_NUM);
 	pTsCommonInfo->TClasProc = 0;
 	pTsCommonInfo->TClasNum = 0;
 }
-- 
2.42.0

