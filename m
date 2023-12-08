Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12AE80ABEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574594AbjLHSTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574592AbjLHSTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:19:30 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F38172A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:19:36 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a1d48f0223dso65241266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702059575; x=1702664375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kTX3lMeAIKadkUoJwz/Rosz/NiJGwf6YHqZeimpRp6A=;
        b=mDLbP8vtyMy84mVO3GrO5VmCe7tdhUbP9faumlnvcR+S03q9haSXx6nDgvqPsRNgX4
         83xv44mZuO7dUnxj9F61UDg7YT8iUCAzVNSA6VynNWScvZFGYXyhbR/Iax12UNX5xw0Q
         HaopogiWm07f/wdC9/Y+GwDahA0+b6OaZ5D7g0vmr9E268v8i6zvTaCdJ2cNhkPOyfl8
         Df/ZlfKkyrqShCLofLvXV+G1mwlsxniHhoKA18wKQoqs733QbpqPsej89EYMTbL0xaxP
         A5NMTmXFnrTBv8nh3lrPuzQtHPe3I8YFUUyO4gYSzQS3NzWXbZKUPdyaWWcb3csfne4P
         Kk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702059575; x=1702664375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTX3lMeAIKadkUoJwz/Rosz/NiJGwf6YHqZeimpRp6A=;
        b=gF+X6TClVVcd3MhgrbNMWZ6U0lmHEWaDnF2G+sfnAfcHPrdROX2nhT10HRtE2y9F6y
         5YKRuK8n+I6B4DgDwIV6rdFmUj0NhzQk4NPE9HaOAEmi1PX2nQrJDqyLXMz1V0B6ycWQ
         BtnnuB81Eb5hGntXHcGb4R4p2D9KcGprxD8RHo3kc+ifMtEL67qxxnV0AQcuH0zx/epa
         ikZhki/BRUhTObAZWGkNCjyTQJW8m823IoZ+zMgc3JEg/NIxIzivL4bIGrjH9FPLAmat
         O7Oqw+jLrKheXv4K9wsudpjohpeoxTax8YGrvIGbDXuuwjrnsrtgs4jWNI0JSBxfdVRp
         DfmQ==
X-Gm-Message-State: AOJu0YxjcG/s9RREBls2SnBubVfko5ExRji4TZNS8GyyUlyf4/XV7yOQ
        DeIhcA6t12cMMiAz0vQwTXA=
X-Google-Smtp-Source: AGHT+IEa2gyOJV1MQMCzieEEmtEXsvhMMp5A3m//mLOsFG8g1bj4IJth0spuTtuBYjsKzVHut3WiYQ==
X-Received: by 2002:a17:907:d30a:b0:a1c:dce4:1daf with SMTP id vg10-20020a170907d30a00b00a1cdce41dafmr445458ejc.2.1702059574759;
        Fri, 08 Dec 2023 10:19:34 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id rd12-20020a170907a28c00b00a11b2677acbsm1266784ejc.163.2023.12.08.10.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 10:19:34 -0800 (PST)
Date:   Fri, 8 Dec 2023 19:19:32 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] staging: rtl8192e: Remove function
 rtllib_update_active_chan_map()
Message-ID: <bae3ddeffe96e4ac7d929127ce3a72cd23fae8dd.1701989555.git.philipp.g.hortmann@gmail.com>
References: <cover.1701989555.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701989555.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function rtllib_update_active_chan_map() as "active_channel_map"
and "channel_map" have the same content.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index d20970652432..fdb0e76d20b0 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -394,12 +394,6 @@ static void rtllib_send_probe_requests(struct rtllib_device *ieee)
 	}
 }
 
-static void rtllib_update_active_chan_map(struct rtllib_device *ieee)
-{
-	memcpy(ieee->active_channel_map, GET_DOT11D_INFO(ieee)->channel_map,
-	       MAX_CHANNEL_NUMBER + 1);
-}
-
 /* this performs syncro scan blocking the caller until all channels
  * in the allowed channel map has been checked.
  */
@@ -408,8 +402,6 @@ static void rtllib_softmac_scan_syncro(struct rtllib_device *ieee)
 	union iwreq_data wrqu;
 	short ch = 0;
 
-	rtllib_update_active_chan_map(ieee);
-
 	ieee->be_scan_inprogress = true;
 
 	mutex_lock(&ieee->scan_mutex);
@@ -475,8 +467,6 @@ static void rtllib_softmac_scan_wq(void *data)
 				     struct rtllib_device, softmac_scan_wq);
 	u8 last_channel = ieee->current_network.channel;
 
-	rtllib_update_active_chan_map(ieee);
-
 	if (!ieee->ieee_up)
 		return;
 	if (rtllib_act_scanning(ieee, true))
@@ -2042,8 +2032,6 @@ void rtllib_start_protocol(struct rtllib_device *ieee)
 	short ch = 0;
 	int i = 0;
 
-	rtllib_update_active_chan_map(ieee);
-
 	if (ieee->proto_started)
 		return;
 
-- 
2.43.0

