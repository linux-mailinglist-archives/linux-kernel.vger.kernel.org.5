Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B979782956
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbjHUMoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbjHUMoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:44:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8FDD9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:44:00 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68a56401c12so416278b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692621840; x=1693226640;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDOcyp7eDilYpxFe5Q1bO3kEe7vayX0PPFX25s4ksUM=;
        b=GTvWXJ+L/cYlHcXSI3x/PA3hA3cF3ft0F7in0VsVJqSvoWrANU7LoIJhLlb4sjMPn1
         UFK5rO1Fg2XEeTc4Ey464JHDyfKHrziA1VicQtCuVclZsO9AhsophDjXKAGd0pdI9EJW
         hwqs81Cn2uJpXYctzBZ6aJ8FyetvQRAeTm/zX8kb2UaBFx9MBNFOK4T4WgmQbaa1aVoN
         Y7ehGtjR76HZumfAeB9xR/8MNLmxzC66BMWKoDcqKfYkV6peQq4BDiISAXjLAsKDmnKm
         R53Zkhv75jJljGHKwT0zMeelQAerfCBJ+ptPjixklKn4UijQBOesILG9/L9WrKjvyc/B
         wf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692621840; x=1693226640;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDOcyp7eDilYpxFe5Q1bO3kEe7vayX0PPFX25s4ksUM=;
        b=HrUeR1QAAz/nmNf5nDul9dvxfR6OppxiCussZNwCQ0b9o37ueEN88Kmm5wiWFDSBHF
         qZdbKHeiR3Gui7QJPz9IF2Tg894i9V0BYxRkuZI1mRFIpsRIVyoIZULVyIPrRHtFkNER
         6HuUFh18NQh3na8qffDIxj6J+9SyNZwiwDOCbyzl0S5YERgq7KMn3tRMtx9o1CckyZA/
         nGfSn3MpEpWO/L7p3duk1iYfC4M4OKZTw2SO9ZKuITfI0+3nJgHSc+XP0UDQcMi+QSEj
         btMsjJL4MuDcAv6KmnPI1Ulgt8OkQ+XnfveYqmJ/g/Jb3kVtzgxRacrsQB9R9eCjF1iQ
         wzqQ==
X-Gm-Message-State: AOJu0Yy6FtbRKUAJ8T2Z08ifLTAISBPhxMrYm0jdyFtz4CUw3xbKfS4n
        6ZQV4ZYE/Od2waze7zSAfUo=
X-Google-Smtp-Source: AGHT+IGTsRcU2Kc+glTJ9NmWfOcf+p4pz82g7fyC6W2t/qHl8rmdDa+/doODgp8x1oiGLeWgPTjEGg==
X-Received: by 2002:a05:6a21:9999:b0:13c:988c:e885 with SMTP id ve25-20020a056a21999900b0013c988ce885mr5425645pzb.56.1692621840090;
        Mon, 21 Aug 2023 05:44:00 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([122.162.51.13])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902768400b001b04c2023e3sm6939514pll.218.2023.08.21.05.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 05:43:59 -0700 (PDT)
Date:   Mon, 21 Aug 2023 18:13:54 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: vt6655: replace camel case by snake case
Message-ID: <ZONcClwtt40vTHla@ubuntu.myguest.virtualbox.org>
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
 v2 -> v3: word "by_" dropped from array name "by_vt3253b0_rfmd"
           and became ""vt3253b0_rfmd

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/baseband.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 0e135af8316b..696d4dd03aa2 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -499,7 +499,7 @@ static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] =
 };
 
 #define CB_VT3253B0_INIT_FOR_RFMD 256
-static const unsigned char byVT3253B0_RFMD[CB_VT3253B0_INIT_FOR_RFMD][2] = {
+static const unsigned char vt3253b0_rfmd[CB_VT3253B0_INIT_FOR_RFMD][2] = {
 	{0x00, 0x31},
 	{0x01, 0x00},
 	{0x02, 0x00},
@@ -2005,8 +2005,8 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		} else {
 			for (ii = 0; ii < CB_VT3253B0_INIT_FOR_RFMD; ii++)
 				result &= bb_write_embedded(priv,
-					byVT3253B0_RFMD[ii][0],
-					byVT3253B0_RFMD[ii][1]);
+					vt3253b0_rfmd[ii][0],
+					vt3253b0_rfmd[ii][1]);
 
 			for (ii = 0; ii < CB_VT3253B0_AGC_FOR_RFMD2959; ii++)
 				result &= bb_write_embedded(priv,
-- 
2.34.1

