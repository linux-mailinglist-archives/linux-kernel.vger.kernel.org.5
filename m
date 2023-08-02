Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDCB76CE8D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjHBN0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjHBN0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:26:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29ABE9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:26:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbff6b2679so25994455ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 06:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690982799; x=1691587599;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=62tLyHKB7NhhD1kHbXvVqqK4h9kH84tdATmgYG26w80=;
        b=MIUuUVV2y/RySNVvTqx40t16UomQXc6hjooSVqw8Ffxdr5cqFbnW5yYzqJ052NI9dj
         Jyl0e/AdCrrRPV4ifg9CREkxIhYkZkR6vV8OguslkM7C4BOVuklGxBLlF80yP8Uxo1ev
         +umo34VNCgkDyAMrwki/7Ku56lHMslVYJWuCea+rdHa21ypHyrjaFUXDSX5QgltRVu1R
         JdU7JUQ8NPJe82gURQHP8Gi9ys8owfEKN6gH0wH1xKXnJKargc5C9F/7X+lY9KJ/SsMF
         e6CMAhFdKQtjzp5KuuBVhq24RRJBcH6GJ8iwodB0R+xyfQj2MbNfVTwTeF/KoEyTvW1I
         TDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982799; x=1691587599;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62tLyHKB7NhhD1kHbXvVqqK4h9kH84tdATmgYG26w80=;
        b=kfFSfjYqCnYlaL/gFA46A6zDsofWWN+49+17xY4QeIXwMxb+Z2DiZB2egcSE4kHwi1
         u5AVhT7fhi1OlvddDKYamzzMOPV8tOJgPxPpZtskQI8ws0qvJLL6onIHoo8ScqqBTxbE
         VawjtPWJzHbepXIiV3wElym/njhDKEho8KEAqFlo6FdSzbnVwIjEOgk+qu58ac1Mko2H
         V/ekdv43nmwgkZp03B1ujC+Od+wplpoa2BFN+yzm/oCjgf06B4eanMVYSVy5Br0v7nBK
         xFkcl7d6EVlzgFJMWS1LiDPkErH6sMy/LtpB3CJBh0QNg0hTFvTHhWcQaVmlvPUxSkno
         qdIg==
X-Gm-Message-State: ABy/qLb7sAUIGDNAXA+ijan2MiGS5FWFScasPjAdEiLQWBm7Xx24Go1X
        UREIRq9pZJhaCQBDXRCnIOw=
X-Google-Smtp-Source: APBJJlFcaQgSc5D0knc8GrQQt9OyOoEYMbQGAxcSSCq0Lxjwk83HtDZubLPr+Vxh6q4vWCCTsh6lig==
X-Received: by 2002:a17:903:124c:b0:1bb:7927:c1ab with SMTP id u12-20020a170903124c00b001bb7927c1abmr15609255plh.48.1690982799108;
        Wed, 02 Aug 2023 06:26:39 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([223.178.255.173])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001bb24cb9a61sm12413401plc.265.2023.08.02.06.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 06:26:38 -0700 (PDT)
Date:   Wed, 2 Aug 2023 18:56:35 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: replace camel case by small case
Message-ID: <ZMpZixfZ4WQgpzF1@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace array name of camel case by small case. Issue found
by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
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

