Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A6A7F095F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjKSWQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjKSWPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:15:52 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501E910FE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:42 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5451faa3aa7so923255a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432141; x=1701036941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IpbsuDxmEGfBla3FiTj7+jrIsLHV/WRQbjndZVr2cOs=;
        b=mtBqd14lyi1S0a1Wni/86wchOtY9f5pFLCEw1C+QfxaMGuzlQKHHuZCAlxomSg12+1
         JnD9by10yIZVzokPi0kp6dtnyUm3sojNTyHHcv1F7AeUzy5vYmhDzWaMTIgJhW9My+p6
         0r6RqapZNh/gDotQBvL+WbQFLbamfrlAV6D0Cw1ViQe03kb79l5E+C7NwcYe/FZMUZ24
         SJKue2fr8i6JPdxv8/MWEUxllkPexVYI8UgIcdE2HTvnuSfZxleWka4NqGkdvA8CY58C
         gZ8kH0oFTMr3tBJhugBiGV+/pouK3BCI149WvLSbdFNpE4DvdKyEUBdMm60tkbRPXs//
         F4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432141; x=1701036941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpbsuDxmEGfBla3FiTj7+jrIsLHV/WRQbjndZVr2cOs=;
        b=dLCSUvh4HqUg+nvQq7p3SyuxWhTx+bvPxH35e0x6mfL40C0/6GMq5bb9GIVNOF6REL
         XRmDuySmxP4LHp9x3U/P79PXD8QooFxpyq4yJlLVkYhTYVeHG3VVWzNBLDxlnXea0pOh
         nufEwx9sZhqxc8sGkd8DPqY+WwIJyEljjMmXn1HTEq6ffOm7qVjaOPuCvC3+PYQVBlZI
         lK0nFSvbNTyCxQKNj2CPt9ecictZlf57HKly/nnwUjVrhgmyrph33oGvy2m7Fv6suM6M
         QGo3GeT4kMEy+J84ScLYEZAkgOs95ASRlhtzYBJDtSXfUweEu1w5rA5CA6K+sUMkZbC6
         XWjw==
X-Gm-Message-State: AOJu0Yy863ArWi302I08W2VLt2nZP3bxUdlAaFPwGJijK3iNzaUluIyp
        H2HxCh+Lyt4pR44b9Fd5ZlU=
X-Google-Smtp-Source: AGHT+IFdaeHab3rIG4c5+rtKpdNpGPjuDibPx7GT8M2KGWYMU7Nl07OTwBtiJpoYyTwRVy8rICa/xA==
X-Received: by 2002:aa7:ca50:0:b0:544:355:16a6 with SMTP id j16-20020aa7ca50000000b00544035516a6mr4391104edt.3.1700432140736;
        Sun, 19 Nov 2023 14:15:40 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402068600b00548a57d4f7bsm887935edy.36.2023.11.19.14.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:15:40 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:15:39 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] staging: rtl8192e: Remove unused variable global_domain
Message-ID: <5e7a0753ed9d6d934203fe29ab8ecef41090f055.1700431464.git.philipp.g.hortmann@gmail.com>
References: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

global_domain is initialized to false and then never used.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 2 --
 drivers/staging/rtl8192e/rtllib.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index b8ba95a65f27..fd488e2fa815 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -26,8 +26,6 @@ void dot11d_channel_map(struct rtllib_device *ieee)
 {
 	int i;
 
-	ieee->global_domain = false;
-
 	memset(GET_DOT11D_INFO(ieee)->channel_map, 0,
 	       sizeof(GET_DOT11D_INFO(ieee)->channel_map));
 	for (i = 0; i < channel_array.len; i++)
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 1d0878d1f696..820951602fb0 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1322,7 +1322,6 @@ struct rtllib_device {
 
 	/* map of allowed channels. 0 is dummy */
 	void *dot11d_info;
-	bool global_domain;
 	u8 active_channel_map[MAX_CHANNEL_NUMBER+1];
 
 	u8   bss_start_channel;
-- 
2.42.0

