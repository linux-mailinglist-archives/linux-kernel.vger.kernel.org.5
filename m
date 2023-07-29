Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F603767CF5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjG2Hxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjG2Hxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:53:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9989335AB
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:53:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-522a9e0e6e9so309357a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 00:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690617204; x=1691222004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=faBqIZ3yezrIb7jUJEkGY6pcGmEoUQ5K1cfQPvpPu3Y=;
        b=WWLJiSrZ36YPa3OhEeXxE5Q5F6zNm9i4bWmNBky9lNgX1ICW3hhMMHsvHGtVppGqlW
         Ru9eQOThE2rK3m3NDBb1TM36V0g4m8bbC72Ph4mz4gSWibtE3DDV3QZDALGm9L5wFwN3
         83ECAaDkqOyni3P9keuwtNTOoUAL1gdI7sTUdFVM2/adANhI4iDHPOO9/0ii6Lx91kGZ
         4uYa/AU55VCwAnmSC9cn8LOaPygmIvSjh2xL4YuW3R2ERq+O1yuLfa/Y/aA8abLiboPF
         qWl+0aVi9pZs4K7E9FVPtKucmjduexiOj0Ft6vode+Bp9zZtnCTDeEFgPZ5/7w2GksSx
         hjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690617204; x=1691222004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faBqIZ3yezrIb7jUJEkGY6pcGmEoUQ5K1cfQPvpPu3Y=;
        b=G/HB83CUeE34QDc3GyxDBc1y9YSJ2MJ+uoOWlyJLoyNfqcFkwkvUtsHU8ibYZO/sN9
         YagubonoT/aEdpCTWQxmmh4r6UE0yNu++/nOZy5SPMuKlJHoOrAGZNTKyzGWY4E2Fj1e
         6IvUoZ1PzTzgOc1PeHHrYnVF/yE4mIPwBR/oj0Os6NdjB/xSno4Y9iuOWorMgn+hMNd2
         ZeEqgpNusPrsgRMXMLLgTPCTPf8L6s8x1Cy70Xxttt4SaPY0Oq8HEdLK4m61YR0+hR5n
         qEMA61uK9nxTZxOpDKJRse7zmOKNyPTzJpJQ2WUQRjCz0SltzvtUmP7T9lwy29mbPwlQ
         v0Xw==
X-Gm-Message-State: ABy/qLYfDP9O+BrxSQeDj2LweevjGVvA4R1eh68ZWrAFobumaHIbYjTj
        VSkX3OVkKGzAZSuzJ/9AQl14Gd0higU=
X-Google-Smtp-Source: APBJJlGxpEAKnLzA/W8E7sdqeYIbhGqonODNFSz4M8UbE9ZD9NErNo14UVcZKxjFtiZwOWaSXej6jA==
X-Received: by 2002:a17:906:10c9:b0:99b:b3a1:4376 with SMTP id v9-20020a17090610c900b0099bb3a14376mr1355615ejv.2.1690617203907;
        Sat, 29 Jul 2023 00:53:23 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id sb2-20020a170906edc200b0099b76c3041csm3026106ejb.7.2023.07.29.00.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 00:53:23 -0700 (PDT)
Date:   Sat, 29 Jul 2023 09:53:21 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] staging: rtl8192e: Remove is_mesh from
 rtllib_send_probe_requests
Message-ID: <06a4c66112e22d6131711969dd4f5ac9fab91426.1690615475.git.philipp.g.hortmann@gmail.com>
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

Function rtllib_send_probe_requests() has unused parameter is_mesh.
Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 06b872c1ad68..614f19603af1 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -460,7 +460,7 @@ static void rtllib_send_probe(struct rtllib_device *ieee)
 	}
 }
 
-static void rtllib_send_probe_requests(struct rtllib_device *ieee, u8 is_mesh)
+static void rtllib_send_probe_requests(struct rtllib_device *ieee)
 {
 	if (ieee->active_scan && (ieee->softmac_features &
 	    IEEE_SOFTMAC_PROBERQ)) {
@@ -525,7 +525,7 @@ static void rtllib_softmac_scan_syncro(struct rtllib_device *ieee, u8 is_mesh)
 
 		ieee->set_chan(ieee->dev, ch);
 		if (ieee->active_channel_map[ch] == 1)
-			rtllib_send_probe_requests(ieee, 0);
+			rtllib_send_probe_requests(ieee);
 
 		/* this prevent excessive time wait when we
 		 * need to wait for a syncro scan to end..
@@ -587,7 +587,7 @@ static void rtllib_softmac_scan_wq(void *data)
 	ieee->set_chan(ieee->dev, ieee->current_network.channel);
 
 	if (ieee->active_channel_map[ieee->current_network.channel] == 1)
-		rtllib_send_probe_requests(ieee, 0);
+		rtllib_send_probe_requests(ieee);
 
 	schedule_delayed_work(&ieee->softmac_scan_wq,
 			      msecs_to_jiffies(RTLLIB_SOFTMAC_SCAN_TIME));
-- 
2.41.0

