Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568D87D2A94
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjJWGj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjJWGjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:39:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D5CD70
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:39:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9c6f0530929so66439066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698043189; x=1698647989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1oSx7TAqwvt3r72vk49KB6i5+36XUD3K4VbaVXfPF7M=;
        b=c4/+cz0YrxthI23+Sgp3KYLOYaYrpAGrWUxjx4NOJ1XAe3dEykkOThXRGm7AeSJfo6
         xnrS1ym42aGb84rtZmEmbcC7ksufsPjNjeWKzuwJXgxw4gFi572cVyEah0KOwgp+SBHe
         EHQ9BFLMlPhOpdSCTy/TAEgnVet/6mwZkjD7ooT5yUjDRO/c3zNjDi9qStPEIR+wqaU7
         Nam2LWkrdJE7Rf1APCddE4XEbOeR6lJOL0sHFdh3Dk9/1SG+O7kineDGfzPu7ZUtCuCq
         ozwpb44XygD5O9R30MODaz4JagCEwTZ1Xeo6c4hybDxnFxJu2z4VOf0TC752vtkEH2Zd
         dMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698043189; x=1698647989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oSx7TAqwvt3r72vk49KB6i5+36XUD3K4VbaVXfPF7M=;
        b=JuHVT5N+sjYy1TVgUuT1++2WEsIXDlwKW4/5jwc0rqV2O07pYKzf4lgrsb0bkmCeF1
         cPDNb/X46fAFbA8fI7rmb+F/j4eH0wjXmoBw22VovB5mXbARdQQW1YCvRhtN9U9ql8/U
         ee3um16pmUZHYUF/C4z9wFm+WXv1SGO1Jbjf4Y15tFlieIKPLSYTE2/sstj1cvQfuyf8
         ZOPHguNwHoWf8jFwKCHUjIknvzgRI5WOBKfLMDMBm8KmDe+5CA6GGqg2HmTLfZ8PawMq
         atXSM/tB1a0N5EP4A64isXgqnAVxd/ufFskxGqEFlN7Nq0mHkEVHi22ftINHfJXqNFxW
         dLdQ==
X-Gm-Message-State: AOJu0YxtC873krkqezekzM6Vgo7ideOvqFqY6kJUk5WP4y4Q6zhGiBr+
        UtyTeFHChUuC/9DPGIrPn3shhgD2MFw=
X-Google-Smtp-Source: AGHT+IFULxBeVVAI3uq6wV5dI2ulhwRLeUvmuKu2fAbDhXTWrxV+Ae2PumPeHyaJVMA6HZF2Rup4lQ==
X-Received: by 2002:a17:906:cb:b0:9b2:bf2d:6b66 with SMTP id 11-20020a17090600cb00b009b2bf2d6b66mr5151513eji.7.1698043189387;
        Sun, 22 Oct 2023 23:39:49 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id v26-20020a17090610da00b00993a37aebc5sm6047066ejv.50.2023.10.22.23.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 23:39:49 -0700 (PDT)
Date:   Mon, 23 Oct 2023 08:39:47 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] staging: rtl8192e: Remove unused variables ucReserved
 and friends
Message-ID: <4edfbe350e05649d1f6028777dcadb15af25238c.1698042685.git.philipp.g.hortmann@gmail.com>
References: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variables ucReserved, ucSchedule, ucTSInfoAckPolicy, ucPSB,
ucAggregation, ucAccessPolicy, ucTrafficType and charData.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_Qos.h    | 8 --------
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 6 ------
 2 files changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index a43a5142e96f..5cdecec496e0 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -8,18 +8,10 @@
 #define __INC_QOS_TYPE_H
 
 union qos_tsinfo {
-	u8		charData[3];
 	struct {
-		u8		ucTrafficType:1;
 		u8		ucTSID:4;
 		u8		ucDirection:2;
-		u8		ucAccessPolicy:2;
-		u8		ucAggregation:1;
-		u8		ucPSB:1;
 		u8		ucUP:3;
-		u8		ucTSInfoAckPolicy:2;
-		u8		ucSchedule:1;
-		u8		ucReserved:7;
 	} field;
 };
 
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 95e735c078e4..af4d31a66853 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -318,15 +318,9 @@ bool rtllib_get_ts(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		netdev_dbg(ieee->dev,
 			   "to init current TS, UP:%d, Dir:%d, addr: %pM ppTs=%p\n",
 			   UP, Dir, addr, *ppTS);
-		ts_info->field.ucTrafficType = 0;
 		ts_info->field.ucTSID = UP;
 		ts_info->field.ucDirection = Dir;
-		ts_info->field.ucAccessPolicy = 1;
-		ts_info->field.ucAggregation = 0;
-		ts_info->field.ucPSB = 0;
 		ts_info->field.ucUP = UP;
-		ts_info->field.ucTSInfoAckPolicy = 0;
-		ts_info->field.ucSchedule = 0;
 
 		MakeTSEntry(*ppTS, addr, &TSpec, NULL, 0, 0);
 		list_add_tail(&((*ppTS)->List), pAddmitList);
-- 
2.42.0

