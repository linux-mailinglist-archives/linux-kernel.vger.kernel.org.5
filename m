Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8047B59A7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbjJBRxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbjJBRxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:53:33 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89C1F2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:53:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53636bc91a8so1134454a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696269208; x=1696874008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ayat5KM/WUkPq1z1BDmKsHr3rXeO84/wlnct3+KjBfI=;
        b=iJalnKRjlujpgDH4Q7pZ6TW6hxyhu7cVlVEu7Rb6XgbMbmzT+ZJP+9Wja/2/AWq//L
         GweeCfNXeYZF4stNsF9lx3uWTW7SPUyzS2gRf3CC64l7P2X5A30FgW1TXvVHDFtQcLeq
         8Fi5GHHiB3+h1ARPr8m1L70kbLXTKMgzUtChYNwjbO2jNYeyBdFzAWOAg/M3Ndni7804
         sQ2GSW4jdhE3UuqvDy+5Jk/5LEvohR78SQw8cifYW8Eylwn4k7sVOhccDTKeBpPST6Dh
         NLZf9Yd2NGL8VPPcAzB2x0RXTSOmsP4vd9GCFYewgVQfSbayyXtvUJilRFtdMIMYnJRp
         L5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269208; x=1696874008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ayat5KM/WUkPq1z1BDmKsHr3rXeO84/wlnct3+KjBfI=;
        b=WxSUDH9FFy/onfjFFMn8RhIQYXEwDzAsurgWdk7OkMMxwY+XB4fG+lct1YtdbIKlyo
         xwZPtH6sblfD97/IaorD/xxL8zJPXPLRA/Vv5eqBwFuFtOpEyOfmeL6fZe7CYqcwy1QZ
         VkLgNBFYCwMdDEsCAJHwAJg98z4mU2nYhe00O9LGAQuEsTcZ5fvFD2mOaISJhVfXA/g9
         8t8jlLf1oVAW4olwkm6IQveS+F/jXyhCAlPQQAeTkbXeRptM6NrFDdyKZHUHN4vdwSS/
         v9w4DQK5p8Kl+pdEkaStpUxwF2xhHi2sjGAO1fxR7gA+OEMobXBH8vt090hgq5OP8p6A
         GiMA==
X-Gm-Message-State: AOJu0Yx6YvVcdoaVnQo6iiFzI8ZUGdRNrNieYjN+pXbMfP2kLQ4JLO/3
        x1oZRagqws38IzJ1c6n612AHeeF5Lok=
X-Google-Smtp-Source: AGHT+IHpvTp7tKTXmSCrAZb8YRarfK4mYBGN+W44cmYxXmWEVHLEPVh7MTKNbTs8Te2KMHTQmlpaIw==
X-Received: by 2002:a17:906:74d4:b0:9b2:b149:b816 with SMTP id z20-20020a17090674d400b009b2b149b816mr9417257ejl.7.1696269208425;
        Mon, 02 Oct 2023 10:53:28 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id qk8-20020a170906d9c800b009a1dbf55665sm17183634ejb.161.2023.10.02.10.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:53:28 -0700 (PDT)
Date:   Mon, 2 Oct 2023 19:53:26 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] staging: rtl8192e: Remove unused variable last_ratr
Message-ID: <2b91a8f4ec6184c2f16b8f65bdf65c69a4d17458.1696266964.git.philipp.g.hortmann@gmail.com>
References: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

last_ratr is written but never evaluated. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 2 --
 drivers/staging/rtl8192e/rtllib.h          | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 8f5e4b932350..52b9393b55e7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -370,8 +370,6 @@ static void _rtl92e_dm_check_rate_adaptive(struct net_device *dev)
 			ratr_value &= ~(RATE_ALL_OFDM_2SS);
 			rtl92e_writel(dev, RATR0, ratr_value);
 			rtl92e_writeb(dev, UFWP, 1);
-
-			pra->last_ratr = target_ratr;
 		}
 
 	} else {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 004818520ea8..1e474691aa88 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1164,7 +1164,6 @@ struct rate_adaptive {
 	u8				ping_rssi_enable;
 	u32				ping_rssi_ratr;
 	u32				ping_rssi_thresh_for_ra;
-	u32				last_ratr;
 	u8				PreRATRState;
 
 };
-- 
2.42.0

