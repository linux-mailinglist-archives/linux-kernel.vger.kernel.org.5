Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FE97F0961
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjKSWQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjKSWQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:16:14 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57590C0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:57 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c506d1798eso11228261fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432155; x=1701036955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NIhoH4W09MvJbrN21uw6rO/SQD23kOyfhhx8/4dLsXo=;
        b=C8GWl+0Q1MeJZfwXMnzKYB6DoFno6p8VZxHC34T1aQSBgPTuTUcvphDPKIrNycCPzo
         A7T+0NkfjGm41QIBsfjq3YLTM5SdGuot+fgBKv3m+IQQtlj5cQK05Wou27PrQj0CTeOq
         H3huC6WsQPK3Ja9QMTJbMMQHbwabTuHecKhykodYvfALpJqntbUZR9PuGP06yC4RD77j
         b5U7Y+TnoLk6wSgoG7kqsnZ5vn8lJ3boExSgnrnCnzOGQAnDMbv4FDPqffKTmg78U40R
         QunocFdP8oq8RxHCYfx6w8RSjGEDRqw1Dao2xBdYTsrGBzReqchnspStTMu3AL7K9icJ
         UR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432155; x=1701036955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIhoH4W09MvJbrN21uw6rO/SQD23kOyfhhx8/4dLsXo=;
        b=X00gh4T+PMa+ukY7zkTYajc7RRxyfoCQ10OcT+tPHtFbcOTqE53T76bcrkvEPTccT3
         4ehbtAWAlPLAUQ5xT5q0MFki8+ER1Sd9SKGET1nKNg//YAP7vxS1n9vFtUFxe/GCjkbW
         9D1sN2+/QYsHigxMNJOF6B59bIDJd7vMGNQWTXC6qa2Hg9UjbrQJri3eLkyUAhf2Id5b
         xXFtbdfVTXmVRKa8iEekXXatiyCnae1DIk64w5W35u+DqjxdpvG6pz4U+dcNyuAtJXW2
         Erojgv5rdRFfkgvmZJFrYYOWRN3EQE02u9qv5QfliocgdqKSJ7SM8ik8v/dKfRxs0D2i
         UQgQ==
X-Gm-Message-State: AOJu0YwO8GqyBU/Y1dqy71WnNlK8Jd5bVL//eOyJY+Y1ID0QIleMuubt
        j9MUdaGWOTgNVZ/IOCRzYvQ=
X-Google-Smtp-Source: AGHT+IFEqSIYbd5LhJkPEaVk90/utKB6EDyBw9gZV9IursshLp6hunJu83ZjfWk6QPfde9haCmWxOA==
X-Received: by 2002:a05:6512:124d:b0:508:1a9d:d768 with SMTP id fb13-20020a056512124d00b005081a9dd768mr3999014lfb.4.1700432155353;
        Sun, 19 Nov 2023 14:15:55 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090657c200b009fd77d78f7fsm805507ejr.116.2023.11.19.14.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:15:55 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:15:53 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] staging: rtl8192e: Remove unused struct
 chnl_txpow_triple
Message-ID: <f66c7cd95ae460ccb376e9edce11b2b955c908cc.1700431464.git.philipp.g.hortmann@gmail.com>
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

Remove unused struct chnl_txpow_triple.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index 767bbbc8b01d..5c02e51c39cd 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -10,12 +10,6 @@
 
 #include "rtllib.h"
 
-struct chnl_txpow_triple {
-	u8 first_channel;
-	u8  num_channels;
-	u8  max_tx_power;
-};
-
 /**
  * struct rt_dot11d_info
  * @channel_map: holds channel values
-- 
2.42.0

