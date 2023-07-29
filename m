Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0CB767CEF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjG2HxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjG2HxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:53:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07705F3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:52:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bd67facffso77488666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690617174; x=1691221974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s2H6tflOurC5lB+k8RugmRyTItQh4+yHSnzSMw6/Y4c=;
        b=lhjvhARPFi4OFqqhJd6llr2p5r8VZOARMkKfsdPLXLh4lJKDTmtBXs6rMHuNX/x5UD
         nNVQJM/RW5Cu+QkrGGpMyJJQd5xy7jX5IL2lqZJnfL/SLMHwaC0U3hNW4Kxqw7QMYPa/
         sE6N3fuWcZdp1PdjZrnsPD0M0Eirq56o1IesuM4YpIZka3WYbRfdYRitHRFx+Sc+AwSR
         7d65neDmpOd032wJxQkSh+i6n3lQZlsDL4J3yrNEOE/ls7zusFPs9IYRORr/uqNOOQ8h
         k5Jdx0ogMwDN5spHGCcams+FKNVP5ZhE2Can+IaLAGgp7/NnWCntmiXAIaeNCcG8gZer
         gLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690617174; x=1691221974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2H6tflOurC5lB+k8RugmRyTItQh4+yHSnzSMw6/Y4c=;
        b=VJYLk/EzzJl6rl7WOgRb4rMLSBx6ipfLHfoc5w3Pp9Hu0olCSh3/rHsAob7AMCC9Pr
         xQYA6ns9NJklNFkDHdyDPpknFaX1Ll3X+96LxR3BfClSEdUMZEd1thfbmmXaWmoSFBGb
         RmkzQl90h20nwlLc9uZIu+uqQUXqIzWMXAe07gQ8yVj0F0LqKRfF+UuB9yUs3tQnlBfd
         ixUKkliJbKVYRC0nRr9jidBmo1p6jzsihOIYZMRp1EO2E7c+X3a95h6ieUCG66Ugz8SQ
         tZ9pfXRnOHMh9WK9KraZ2mcOvgUUMVLHSqnohxkTMC6GCCuL2TY039K5yVuwvb2s8J+s
         LRYA==
X-Gm-Message-State: ABy/qLZaBCiMi6wVyA1XKLW6Nmzb84gRMQOBiMaBnIRxq5jmc1knvW5H
        /71ex8Gu6rhhM5xor67RjQV/epZbdxY=
X-Google-Smtp-Source: APBJJlHbHxqDmJ7Qjpy9DTyOWDjeo+wlp2ZfaBDb2aUIKGsfdiCX8tJD2hpsFxHiOPlcMDZ1gIM0GQ==
X-Received: by 2002:a17:906:64c9:b0:994:33b2:c32d with SMTP id p9-20020a17090664c900b0099433b2c32dmr1196575ejn.5.1690617174016;
        Sat, 29 Jul 2023 00:52:54 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id z10-20020a170906714a00b00985bdb7dd5fsm2966141ejj.201.2023.07.29.00.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 00:52:53 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:52:51 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] staging: rtl8192e: Remove empty function
 rtllib_rx_Master()
Message-ID: <9604360121c5547cfaa282f73af5b948cdfbd769.1690615475.git.philipp.g.hortmann@gmail.com>
References: <cover.1690615475.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690615475.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtllib_rx_Master() returns always 0. Variable ret is already
initialized with 0. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 195ce0fecd29..b9d220b015f6 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1445,12 +1445,6 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	return 0;
 }
 
-static int rtllib_rx_Master(struct rtllib_device *ieee, struct sk_buff *skb,
-		 struct rtllib_rx_stats *rx_stats)
-{
-	return 0;
-}
-
 static int rtllib_rx_Monitor(struct rtllib_device *ieee, struct sk_buff *skb,
 		 struct rtllib_rx_stats *rx_stats)
 {
@@ -1510,7 +1504,6 @@ int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
 		break;
 	case IW_MODE_MASTER:
 	case IW_MODE_REPEAT:
-		ret = rtllib_rx_Master(ieee, skb, rx_stats);
 		break;
 	case IW_MODE_MONITOR:
 		ret = rtllib_rx_Monitor(ieee, skb, rx_stats);
-- 
2.41.0

