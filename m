Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7147EFE96
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjKRIwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjKRIv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:51:57 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A9619BA
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:51 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54115c72f78so784659a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700297510; x=1700902310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y3T+DN+4X901BSZo7/K9QB8FTvLJTfF9SbWoEo2JZ34=;
        b=VSKEaj37wj56DgcMQgxrJVa6jorGo+BRWEDPK8oRDqiAf4V1SCm7JVVitmzj832Ox4
         AKNJMcr2LS9tFONBF/pAyLRsxcq5vQNJ2NupiF5I0372HMWk8OgiXeAY7VuabIzkwZJ3
         mMOHGhBCFXobANKzbx1kUbfMxZuMo3uJTjW2nminmUEvWA70+1udRHu/Y7N1wjOcK7KN
         nA0Pu9hd+IX98b9SUJzGxk9/ijuxzOfRNjFNP9OH2pwsMkvoDe9vbBfxqgabPw4QR0Fj
         CAO0cpG15T0CRAkGjATqJYUXrXts1Z/EHjYad5MWyGnlkOH47h+KOaeMsglxB9Lgn7xx
         F4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700297510; x=1700902310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3T+DN+4X901BSZo7/K9QB8FTvLJTfF9SbWoEo2JZ34=;
        b=iJPtwIjl2/HZQnpPb2yRYrHY26L8F0bF6QT3i21SMuW8Hf3T154uE2vYoIsMO40x29
         YUwAEJOCHmKYSQLnfxyv9OPTsmsfCB/wbFY6hPcY5kjfs5ru2YFtnBSKw25zt6azMWeB
         qkrkbt6d2ZAJpjma0OoJf5wLYU/22ludp1FL4kha0kA4VZk+m7IUFNHlTxDIivNty2Cw
         wAMIk6cuHAcFulfPclFkbenP8VY+utBXiUreXAB3nXd/uz4oIRIRTY7yU/m7/J2WBx6z
         AjVih3QP9xWqg9zaR/RVJEku9Qgfre1GPa6ghEsfSCtmmY1PN3FCWD7UXYNZRTUcB8iZ
         JDLg==
X-Gm-Message-State: AOJu0Yz54pHPTsMqWQXlQ5juZujSpSZohs62LkJJwDaf08pfHrgyOVTI
        g029teLHOP4Z/3HZ43mUOjs=
X-Google-Smtp-Source: AGHT+IEsss1sE5P6PCOo9cOkcdRQIbNvEKYz6FnbYDkiPnC/oiwhxvXRu0x7aqyfdT5zy4jYNXXhEw==
X-Received: by 2002:a05:6402:797:b0:544:3944:d7cd with SMTP id d23-20020a056402079700b005443944d7cdmr1236784edy.2.1700297510204;
        Sat, 18 Nov 2023 00:51:50 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57ba2f20.dip0.t-ipconnect.de. [87.186.47.32])
        by smtp.gmail.com with ESMTPSA id o9-20020a509b09000000b0053deb97e8e6sm1584438edi.28.2023.11.18.00.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 00:51:49 -0800 (PST)
Date:   Sat, 18 Nov 2023 09:51:48 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] staging: rtl8192e: Remove equation to check limits of
 channel
Message-ID: <1f91cf8145b304b09b37734a2a504da394833378.1700296319.git.philipp.g.hortmann@gmail.com>
References: <cover.1700296319.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700296319.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

channel_plan is constant COUNTRY_CODE_WORLD_WIDE_13. Remove equation to
check limits of channel as those are always in limit.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index d0b7332645be..bb7b5c793b26 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -51,7 +51,7 @@ EXPORT_SYMBOL(dot11d_init);
 
 void dot11d_channel_map(u8 channel_plan, struct rtllib_device *ieee)
 {
-	int i, max_chan = 14, min_chan = 1;
+	int i;
 
 	ieee->global_domain = false;
 
@@ -59,9 +59,6 @@ void dot11d_channel_map(u8 channel_plan, struct rtllib_device *ieee)
 		memset(GET_DOT11D_INFO(ieee)->channel_map, 0,
 		       sizeof(GET_DOT11D_INFO(ieee)->channel_map));
 		for (i = 0; i < channel_array[channel_plan].len; i++) {
-			if (channel_array[channel_plan].channel[i] < min_chan ||
-			    channel_array[channel_plan].channel[i] > max_chan)
-				break;
 			GET_DOT11D_INFO(ieee)->channel_map[channel_array
 					[channel_plan].channel[i]] = 1;
 		}
-- 
2.42.0

