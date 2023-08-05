Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E475A770EF0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 11:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjHEI7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 04:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHEI7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 04:59:17 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CB844B8
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 01:59:15 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34930fe8608so10691855ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 01:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691225954; x=1691830754;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfvEEeKIgA69ovhmfGQ9VWugUSsdWnJ329BDpMe7j+E=;
        b=f1Q3wHnX/qCtsMOy4DMBXm8Ujfxuz6oglXZdiwbkhn4zwPmGelfXzCIvBYIKy35iOt
         WjmxqTXVngbVFwjhK7oDuSObP587i7hA65RPU3AFY78Sx1oaoB1Q3n+9s/ADx7/0yuYp
         antix6m//lJU9q42Yiy+lh3rFDhwdJBDSHPV7W5/UHaRRASRlsvWAAu8lEKZ4iLapYOw
         6vP4UVJOdv8YMX0b5WlMU5kR5JwANdUHSI1I18fRBgE53BSrJr7oIHZr2zv8vxCqKWVa
         pWM6EBCUMnn9b9bfOTDpiw/cp8/93vn0ERt8Wp1ztm87Y+0ZoFkCK8hYFsceybs2Vx7t
         yxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691225954; x=1691830754;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfvEEeKIgA69ovhmfGQ9VWugUSsdWnJ329BDpMe7j+E=;
        b=ckHDhrLg7GjHodb+ydKdLoprbo8sP3DqpEW9srZxztCt5B547wmdkFWCs0cSSmNOR2
         dzGENBZ5LwTkaaUqDcdkE9COSdDcQkCAFIHyWxHdlP06I9bH6qto/MKYqaDPM33emUBh
         euGSztB6PhzR9YlePgThRIv59DZC0Ah4fWpVgE7zI0h56Ohthw1xxtYVbaHWEhirlGOG
         VhFVLAkSS4xnGH5zkFConZzJ5RRxR9RTvp7fDPV+OlwQGckqw6NX6zG8E2X2vtiZV3Tk
         8O7Kwj43aEP3Gj2jPjm/ojIYuRA6C8ySPEtkAWxe21ifG18Utdcs5giX6MdnqVbDCA4m
         FYbQ==
X-Gm-Message-State: AOJu0YxwuLBAGaN2aOrNLhLBm7VpVPB+FUC6rD06JTwq4DXQUcYFwRp9
        tIdk8Loozi2kqjWtgmr3KnpzG+NLu8o=
X-Google-Smtp-Source: AGHT+IFP6KXDRVRGva01CtKkrcrpDq5SMvTG6aWShTTIqJnVe1nF0HrSUO1zYsoABezdfXLboQ43pQ==
X-Received: by 2002:a05:6e02:1a6d:b0:345:d583:5c64 with SMTP id w13-20020a056e021a6d00b00345d5835c64mr6790311ilv.24.1691225954629;
        Sat, 05 Aug 2023 01:59:14 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([122.171.52.122])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78008000000b00686f0b15b06sm2728784pfi.188.2023.08.05.01.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 01:59:14 -0700 (PDT)
Date:   Sat, 5 Aug 2023 14:29:04 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6655: replace camel case by snake case
Message-ID: <ZM4PWL55pMQiYIX6@ubuntu.myguest.virtualbox.org>
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
 v1 -> v2: 1.character '_' added in the array name "byvt3253b0_rfmde"
           2. typo in the subject line "small case" corrected with the
	      proper word "snake case"

 drivers/staging/vt6655/baseband.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 0e135af8316b..8b913c64845c 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -499,7 +499,7 @@ static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] =
 };
 
 #define CB_VT3253B0_INIT_FOR_RFMD 256
-static const unsigned char byVT3253B0_RFMD[CB_VT3253B0_INIT_FOR_RFMD][2] = {
+static const unsigned char byvt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {
 	{0x00, 0x31},
 	{0x01, 0x00},
 	{0x02, 0x00},
@@ -2005,8 +2005,8 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		} else {
 			for (ii = 0; ii < CB_VT3253B0_INIT_FOR_RFMD; ii++)
 				result &= bb_write_embedded(priv,
-					byVT3253B0_RFMD[ii][0],
-					byVT3253B0_RFMD[ii][1]);
+					byvt3253b0_rfmd[ii][0],
+					byvt3253b0_rfmd[ii][1]);
 
 			for (ii = 0; ii < CB_VT3253B0_AGC_FOR_RFMD2959; ii++)
 				result &= bb_write_embedded(priv,
-- 
2.34.1

