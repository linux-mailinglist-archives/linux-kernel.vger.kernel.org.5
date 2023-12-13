Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67240811A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjLMQwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbjLMQwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:52:19 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FE810E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:52:25 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1e25a49603so189659366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702486343; x=1703091143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QcuM1B7Nqln2T8HsY+RDMt6vNuKyn/uBt6HB0cu06wE=;
        b=Bo/Jm7I1UxvaGeTwhVprkKb/JgtwOY2NbyN616u264wzR5MJVJxYxBfzZqbcDF6pHT
         r/ul0+GykSmrBWC2/C172pn994C45eoMD68eIons2RV1U4s1XVP9hAhhKXSL1WGxTBMi
         ooDX17sNjvxBZJtDmm+NyC9YurzSDWHmrph5ktupJkaqTjooK1aH7naMtSApgA+WzAiJ
         r948V+dI6M5hH8QpcJyXGaHvPJo1jV7c3shBwl0nBn8svBKLSdtHwQZjjPl7B3mVeW+H
         5nhSu6wO9N1roDCE9L9gceKVjz2k2v+xGc/zpb7PDZiGflPMazgO9V5TNnnFJwne43UU
         k5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486343; x=1703091143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcuM1B7Nqln2T8HsY+RDMt6vNuKyn/uBt6HB0cu06wE=;
        b=a04mhCepd+pBc970HHeLqUz+CSn4PdYrMQlrEnR4FAne1T5M52vOiqzaG9hmAiUxQl
         2rCU0On9JKuDUHIHSH99aK/VTHuS3O84DdZQSC3c/GYTDtFBu6Bs+XHb2K8FuwsDxOrO
         xzigfkmFQOfm0rzEkaGilrlgiyR9C7CZGPxQK1kldfgi+UrpG55EZxnJA6MOUtLRVJXz
         d/qNfPtxAqeap26yeCVyP98La/33bIS7Fd4u3gwiHpPZAbhqEX45sXyZcRhG8aT+jqPf
         1QnV7kkKXngtS9ssQytGWeKqSNPozODglon2LSqoZTTRjMJgC+docSzDusWHLOqjXomo
         RzgQ==
X-Gm-Message-State: AOJu0YxiVNMk6mmH/HEo4zmIRuktG0cj/95MnGP+VP6OAfnFmQB0gQ9K
        2FLKMIF54bglT4374TmOMBo=
X-Google-Smtp-Source: AGHT+IHnnv5a7KagUWLWUtnXmhAJTELjZR68Rq07jNtKxvCUpjdfOeyNLnO8XgZA84eeMOocpuA34g==
X-Received: by 2002:a17:907:a70f:b0:a00:211c:9a9a with SMTP id vw15-20020a170907a70f00b00a00211c9a9amr9176973ejc.5.1702486343268;
        Wed, 13 Dec 2023 08:52:23 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id tb19-20020a1709078b9300b00a1cd30d06d1sm8245901ejc.14.2023.12.13.08.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:52:23 -0800 (PST)
Date:   Wed, 13 Dec 2023 17:52:21 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] staging: rtl8192e: Remove unused variable
 ht_info->amsdu_support
Message-ID: <b3ea8ddd16a753d9ee1ee8b99e31e990ce89133b.1702406712.git.philipp.g.hortmann@gmail.com>
References: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable ht_info->amsdu_support.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index e6cd906dc0ac..c4af9968cd67 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -101,7 +101,6 @@ struct rt_hi_throughput {
 	struct ht_capab_ele SelfHTCap;
 	u8 PeerHTCapBuf[32];
 	u8 PeerHTInfoBuf[32];
-	u8 amsdu_support;
 	u8 ampdu_enable;
 	u8 current_ampdu_enable;
 	u8 ampdu_factor;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 578d9276035f..044bfe44d213 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -71,8 +71,6 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	ht_info->amsdu_support = 0;
-
 	ht_info->ampdu_enable = 1;
 	ht_info->ampdu_factor = 2;
 	ht_info->mpdu_density = 0;
-- 
2.43.0

