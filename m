Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0B7EFE98
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 09:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjKRIwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 03:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjKRIwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 03:52:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D1B1BC2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:52:04 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c40c3814a8so83405466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 00:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700297523; x=1700902323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMz8/s0f1rrtzmkkOs21rTHNKe3hKx+usDsY/Vx3Y2c=;
        b=Fha9DYMnpyvw5Qp3D/VxO+DLEGbH/9zlSFfFXHCsjM053+Go/QjIonvIqu/Sbx3uGW
         tNjwJsmA7geF3+qxEG4ciTbwUX7PaSHXETZ35NJ4HMkkW+4hn6Eg6Xs75Sg28Jl3+X16
         91WYyS9s0OiXD26Ac1vjbHvVBzTR4lcCcCYbaxhQMPgMywe96D4a9ke4yfqZWTtd85ig
         Kg9rsJNDRnV3VFJi2gHGGFS2oDfoYUJOHDf/rlB+a6MiM1Z6CNjcW/7tK/PS3I8qbxut
         Qp40jhIgOjibqyIi9SSaplmXSl/yGo3Y8HzyreHgIBvsYW3zClcUA7UKc1MtoaRBRr0q
         lphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700297523; x=1700902323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMz8/s0f1rrtzmkkOs21rTHNKe3hKx+usDsY/Vx3Y2c=;
        b=FUhpaNTWq12O2qGLhHKNv59i8gLhBBd9zGyrpCUQ44UTYpKlkYq2OXhJkYDPIXBP+0
         Z7zutlIfeUwG20S0w6/toIFYm+7dZ5QJe9euB/7/t5PUjscg6EWizYkz0WODD+XpiW7A
         6tHOK/1rqejKQsH+j6q/pNJS1RPojc81MG7FLyPdEpfU/pk6Oc9/gsBYB8+A6GFh5giY
         BROF38uoppTuneQv1KX03HWeZB+6fAgGH8Nkg5Ex6Pv2orTXXD6wBe41k63jAge/OX3f
         DphbeDOgUomqMfFq5UTgMaJFYmmyWNoWFLT3aj0K1hOmwGStEIN3fKnYwZrIET62WwcM
         nzzw==
X-Gm-Message-State: AOJu0YxLn073YSaFIW+eRHKeUYLzcKDEWT66DkTzkHLEK+NB0IorRP6s
        nxwIm11HgnXw8OMb+Bu0Ii8=
X-Google-Smtp-Source: AGHT+IHx+v/ZGnNo4+fLMZ/G906LymFhb0eamu67zefP3CIQKl8CBvzEJXfUuBsuYSErr8Vqey8HMw==
X-Received: by 2002:aa7:d755:0:b0:547:da7:9c10 with SMTP id a21-20020aa7d755000000b005470da79c10mr1261003eds.2.1700297522916;
        Sat, 18 Nov 2023 00:52:02 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57ba2f20.dip0.t-ipconnect.de. [87.186.47.32])
        by smtp.gmail.com with ESMTPSA id g22-20020aa7c856000000b005487d3fb436sm202605edt.90.2023.11.18.00.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 00:52:02 -0800 (PST)
Date:   Sat, 18 Nov 2023 09:52:01 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] staging: rtl8192e: Remove switch for a constant in
 dot11d_channel_map()
Message-ID: <d81caa0894bdaaca471010cb3512f3459a2e7df4.1700296319.git.philipp.g.hortmann@gmail.com>
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

Remove switch for a constant in dot11d_channel_map() as the result will
always be the same.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index b515008045bd..37106fd54f00 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -62,24 +62,9 @@ void dot11d_channel_map(u8 channel_plan, struct rtllib_device *ieee)
 				[channel_plan].channel[i]] = 1;
 	}
 
-	switch (channel_plan) {
-	case COUNTRY_CODE_GLOBAL_DOMAIN:
-		ieee->global_domain = true;
-		for (i = 12; i <= 14; i++)
-			GET_DOT11D_INFO(ieee)->channel_map[i] = 2;
-		ieee->bss_start_channel = 10;
-		break;
-
-	case COUNTRY_CODE_WORLD_WIDE_13:
-		for (i = 12; i <= 13; i++)
-			GET_DOT11D_INFO(ieee)->channel_map[i] = 2;
-		ieee->bss_start_channel = 10;
-		break;
-
-	default:
-		ieee->bss_start_channel = 1;
-		break;
-	}
+	for (i = 12; i <= 13; i++)
+		GET_DOT11D_INFO(ieee)->channel_map[i] = 2;
+	ieee->bss_start_channel = 10;
 }
 EXPORT_SYMBOL(dot11d_channel_map);
 
-- 
2.42.0

