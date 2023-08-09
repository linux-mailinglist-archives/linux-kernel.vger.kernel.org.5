Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB77775F99
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjHIMrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjHIMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:47:28 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C241BDA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:47:28 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a5ad4477a7so5120256b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 05:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691585247; x=1692190047;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgLnNTyUqxgdIBRnXZkONE83fOCISV+cZafhjFByJ6s=;
        b=UgkCM4qxu+uMbk49jGT/byouHYOa4cv4oHh73ITQPbDuXUdoDmlxBEMDj8GE4XxWU5
         sWqqNVVkYn3vTMSbAgGvUVEMtW1e80xAlbTr72znfkhB7sbdhiOOogTDq7ZYyUYaPNfp
         JYEPqSAB/Dkf5C6ek+iVp3OhlCkb2ZCCGxpjL8DiOGVeSgcPBOnox1XED6TDreA7jpgl
         RYwP3ANO53FUuVDzdCsLw3m4DdntADVXHtPU3nW8jyi0bP2JInk6kG+FZWY9EqRGPdYE
         HMbO1VmckcHWj69SyMxpiY0YpcAa85VCi95nzAOZaX6o7WUCooNk/nLMnjrgRDtaoj2t
         Dfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691585247; x=1692190047;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgLnNTyUqxgdIBRnXZkONE83fOCISV+cZafhjFByJ6s=;
        b=MCijVCx5Cz7KufcR2/rqh6SpMTGNOn4TpBH4LQRmqEHho+AbzgBDw/k4NyVgzrp3Sw
         tsJP78x5Qjt5Y4lFQ4jWc3LfGU3i4Mfka2Sitn2QRuj7VD7ZXFppXgCGWQakwXsTixxZ
         vAQRhRgVdhkLDyOUOzO8IGwPjIuk+1MyCGtQjWql0WNCpcVbAl6kexFPR183M96wBmjD
         8rC5StFtW2Jdm/ZNXvukx3p8fX+GCVGd/9T2DkpRRs24Gj14yx+Of8IgUq/wx3Ptazok
         p08lTfwlmrgN8YDwClE9CShILveaM1BOXjK0x6rwLZvrc3zf/77grErHXMaC/ebt9AOA
         hxcg==
X-Gm-Message-State: AOJu0YytMLYtBMchzK9t9XNmRTnst7Zzr9Y8XfeQ/jura1SS7Cfk0nMX
        1yRHL/A2vjQUN5sVCg084K7UBrSMI8Q=
X-Google-Smtp-Source: AGHT+IEJxQd9Oqcd4G67bDzrVNJX78gVSfE3k+NxBSuyqs7fZY5a8noxIH7dI7lmZgLO86KsDGskUA==
X-Received: by 2002:aca:220b:0:b0:3a7:4cf6:f0cb with SMTP id b11-20020aca220b000000b003a74cf6f0cbmr2540164oic.21.1691585247611;
        Wed, 09 Aug 2023 05:47:27 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([122.173.206.194])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a7ac800b0025023726fc4sm1362860pjl.26.2023.08.09.05.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 05:47:27 -0700 (PDT)
Date:   Wed, 9 Aug 2023 18:17:22 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6655: replace camel case by snake case
Message-ID: <ZNOK2u1sJoRAxhIC@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace array name of camel case by snake case. Issue found
by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 v1 -> v2: 1. array name renamed from byVT3253B0_RFMD to by_vt3253b0_rfmd
           2. typo in the subject line "small case" corrected with the
              proper word "snake case"

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/baseband.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 0e135af8316b..cc8793256661 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -499,7 +499,7 @@ static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] =
 };
 
 #define CB_VT3253B0_INIT_FOR_RFMD 256
-static const unsigned char byVT3253B0_RFMD[CB_VT3253B0_INIT_FOR_RFMD][2] = {
+static const unsigned char by_vt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {
 	{0x00, 0x31},
 	{0x01, 0x00},
 	{0x02, 0x00},
@@ -2005,8 +2005,8 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		} else {
 			for (ii = 0; ii < CB_VT3253B0_INIT_FOR_RFMD; ii++)
 				result &= bb_write_embedded(priv,
-					byVT3253B0_RFMD[ii][0],
-					byVT3253B0_RFMD[ii][1]);
+					by_vt3253b0_rfmd[ii][0],
+					by_vt3253b0_rfmd[ii][1]);
 
 			for (ii = 0; ii < CB_VT3253B0_AGC_FOR_RFMD2959; ii++)
 				result &= bb_write_embedded(priv,
-- 
2.34.1

