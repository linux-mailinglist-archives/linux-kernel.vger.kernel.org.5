Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CF17EFE97
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjKRIwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjKRIwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:52:01 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C5170F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:57 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9c6f0530929so74969066b.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700297516; x=1700902316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vxxrVa0KzjOY+CRU8JP3B25+gW4kOUQEfZfS215afM=;
        b=UjoBiRq8XmUkYsEW6cRmgLHHFYFKISMh6kMQnb2SjYgAMcOyzsa23uvDq07bOKF09K
         gf7h2PbwChUWz67syyzmCDjDTFv+6MapbCkEo4CKy3odYSnHUJkl4YfAw6UFwmV/zmeW
         WK4NRq6utLVVmEXLgSG/m3Ap41eW9jXulKrXzVmRUjUksjFhWia9ahvJ6FHbhOOdMGIa
         Dq5BJQmQwW9isA4y53wvUFidCZ6kFNU7+jGKoUgfT6dJrKe0q0fjsn0+4970tNMn9/zK
         LFkCMpp4DRrfH0MwosmxWv7y9CMZ46xDr/X+I3llD1LdOcAdN9TLaeHKANijzgtlWbly
         As3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700297516; x=1700902316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vxxrVa0KzjOY+CRU8JP3B25+gW4kOUQEfZfS215afM=;
        b=uLnp5n6fa2b4b+cAvmTutLI+8q3Kw0sTDGWWxHANdjZwuUj+iKiLewBIGO6kp4+Mmr
         62sJLSGTN/Qb8uw2KVSt3p+MC73wMQkXdUJ0aF29OLuo7QdjtNt/KcVsv0di3/UZ2Jkk
         Nt+24opXgdCmjMK7GMfoKkAIq0c+jHK7OdCzRrAz7JOFXeC0NMSjV7rX+7N0Vxy19omd
         zIXD3u9XdVViR0VGwJSAxjprr2y7DHVT39YDZWu/ltw24iIai9yKCLKPzhRtgtYIgHRY
         Yr7u80SAMqcILXBNtF8m4KQ6zDOATm/xR5RQUbfc7IA0NwI38QJjM5cSaySFz1gyDMHq
         kPJw==
X-Gm-Message-State: AOJu0YxTS7Fma8y9tE9vsAO0+NF3IhqpsuLwQzVD58u7VppvhQHnyAVS
        mK1auqPgResKfVfm1VN4e3g=
X-Google-Smtp-Source: AGHT+IFUVtH44rCt4LCqcxa/bLquM61Di/hm60eUMdgP5qLDmyjsQR0cb0wba0hX0lazKaTTYVzrjQ==
X-Received: by 2002:a17:906:cb:b0:9be:f78a:d438 with SMTP id 11-20020a17090600cb00b009bef78ad438mr1422200eji.5.1700297516390;
        Sat, 18 Nov 2023 00:51:56 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57ba2f20.dip0.t-ipconnect.de. [87.186.47.32])
        by smtp.gmail.com with ESMTPSA id bt23-20020a170906b15700b009cc1227f443sm1672692ejb.104.2023.11.18.00.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 00:51:56 -0800 (PST)
Date:   Sat, 18 Nov 2023 09:51:54 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] staging: rtl8192e: Remove check if
 channel_array[channel_plan].len != 0
Message-ID: <0cfcc32a06033908c469ef0273de2485dbfd6b82.1700296319.git.philipp.g.hortmann@gmail.com>
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
check length of array as it is always not 0.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index bb7b5c793b26..b515008045bd 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -55,13 +55,11 @@ void dot11d_channel_map(u8 channel_plan, struct rtllib_device *ieee)
 
 	ieee->global_domain = false;
 
-	if (channel_array[channel_plan].len != 0) {
-		memset(GET_DOT11D_INFO(ieee)->channel_map, 0,
-		       sizeof(GET_DOT11D_INFO(ieee)->channel_map));
-		for (i = 0; i < channel_array[channel_plan].len; i++) {
-			GET_DOT11D_INFO(ieee)->channel_map[channel_array
-					[channel_plan].channel[i]] = 1;
-		}
+	memset(GET_DOT11D_INFO(ieee)->channel_map, 0,
+	       sizeof(GET_DOT11D_INFO(ieee)->channel_map));
+	for (i = 0; i < channel_array[channel_plan].len; i++) {
+		GET_DOT11D_INFO(ieee)->channel_map[channel_array
+				[channel_plan].channel[i]] = 1;
 	}
 
 	switch (channel_plan) {
-- 
2.42.0

