Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E307B71CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbjJCTd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240951AbjJCTdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:33:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFEFDC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:33:22 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b28dee4de8so50255266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361601; x=1696966401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=72i878pEVOruzqTmXw4X4pHlqTkys0N/rw2142cAbGA=;
        b=FV7WSfePOvbLmEdZ2HEWTvrg5XMwGAm+7KAtN4BsZYebJRM5R24JBYH6qsmsv2AbaV
         29FSSMEJUvKLiHvs/rJORaE2D9TEu9tL6AVHoYgvHQjF2CDO8SD2bwwBS6Onfn5rreT/
         8ODRm1uGMIDbCLsw6rW70ogyw9LZ8zGusUP1UFm2TeU2R8is+fOHT0FYWGs5nFG+Gfoo
         /kpmeyqaiNf5te7b/Iylv/KF619/jGKdDfZEp8JIb7Ipqy6+qetgUSVljRIzw6/SbEer
         DhxqlXIEQ5OCSSK7x7tUKhyc/rp6d7nc1WPLRK7QM9hOa4W7eBGyWBx9LZ+SIZw6uXAB
         XEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361601; x=1696966401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72i878pEVOruzqTmXw4X4pHlqTkys0N/rw2142cAbGA=;
        b=PdoFI5nFmYXdWPKqbK9f8QqyzVyeQzodTNHSVqoYS/3ac12UkoLxNzWPIc4ryWs79a
         wn0H6RSVzUOdCtb78cwoeX2NdNgFSy+1xsgNNR9OQCQMlRWfumnRfgtX69PxvCzwvWK1
         p6oREhxvL8jJC5iwGDjgv8ByfWjbyoi3+1Do/0psYlPKGxolKbewPjND+C9xxLkRFN92
         DNQ8LvEUz8XwrazGNPmc/TR4SqJl1VzSKlTFMODYP+hk2w1coo35wTWAFYvxL0UxScYS
         0xZFpDIs3VCIjzAAykhxraKakR9EB0R+VsO2R2H27pEwbuRbFqQM9OWm6/Z6eMq6cPJs
         4nXg==
X-Gm-Message-State: AOJu0YzG2akRdHmkQmkNfWO3qM8eyCa9ClPBjp7AjMJT6wnohaxRVi5H
        VxB57olS5wxNxJCHMpYqAjE=
X-Google-Smtp-Source: AGHT+IEmi67FrdM1NuXU+t/SD4DGznx8tAeslFCpU6FRXUgLi99wj69uxin13zeljNNF6+BESyUWFw==
X-Received: by 2002:a17:906:530b:b0:9a1:d915:6372 with SMTP id h11-20020a170906530b00b009a1d9156372mr113828ejo.4.1696361600729;
        Tue, 03 Oct 2023 12:33:20 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id gr11-20020a170906e2cb00b0099bc80d5575sm1477043ejb.200.2023.10.03.12.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:33:20 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:33:19 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] staging: rtl8192e: Remove function
 rtllib_start_monitor_mode()
Message-ID: <0031b5f9150851e5ec86a56c1ffad5488fa065f4.1696360403.git.philipp.g.hortmann@gmail.com>
References: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove equation with raw_tx in function rtllib_start_monitor_mode() as it
is always false. rtllib_start_monitor_mode() is then empty and can be
removed as well.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index de1808b372d9..babd48aa327d 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2135,13 +2135,6 @@ void rtllib_wake_all_queues(struct rtllib_device *ieee)
 	netif_tx_wake_all_queues(ieee->dev);
 }
 
-static void rtllib_start_monitor_mode(struct rtllib_device *ieee)
-{
-	/* reset hardware status */
-	if (ieee->raw_tx)
-		netif_carrier_on(ieee->dev);
-}
-
 /* this is called only in user context, with wx_mutex held */
 static void rtllib_start_bss(struct rtllib_device *ieee)
 {
@@ -2371,9 +2364,6 @@ void rtllib_start_protocol(struct rtllib_device *ieee)
 	case IW_MODE_INFRA:
 		rtllib_start_bss(ieee);
 		break;
-	case IW_MODE_MONITOR:
-		rtllib_start_monitor_mode(ieee);
-		break;
 	}
 }
 
-- 
2.42.0

