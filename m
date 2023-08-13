Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A7E77A522
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjHMGgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMGgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:36:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E083173C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:36:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3177d3bdfb3so682958f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691908603; x=1692513403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZksEFWs5gcqXs2RD9fx1RHaWOhTjp65n9mM6G9h1Zg=;
        b=p1pJseAx73KAkF1sWsnQDTQr2UKK8diUs5kBL6oo27OcK7q2qwt7eYq9fdb1hCpAMu
         vcxuLSFJqJHoa4MQt08pViRS6/AJ8qwKiDjktyzTV1/Tq/IF/hjwm9beZmtlqroJnO2l
         Bq96rnZNwfMVdy6Uv2mBuJgTYJ9dlbeBcwrxuSSvqVQGzjnRV+/ZGevkB7Rq9brmhOIY
         Mo+k4BnWinE36K2tRLzXoRyNwykdWyz0OtUvDwhPjCOUvDwOoUJWT/bRiqQJqnIvY6kS
         sU7aLqMudBU5nAmKDkdzOfqQfENfOOZAsSMmD96iwgbDeLnqYImKApgsYX3YJlIdl1vU
         z/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691908603; x=1692513403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZksEFWs5gcqXs2RD9fx1RHaWOhTjp65n9mM6G9h1Zg=;
        b=Ep9JYhuMi98Vf+a2G6cF+FxmUUR5mc3/UJa5yziUVFxB5tpJxLhk8/Wc9t3toGEOsu
         nOzz9/HUPTplotewcw8Sukxvgq2XMtX2zqEEFJJZJQPL+Xem8xlZuxZyJ0RS+4+V0e5f
         w+FILPN8Zb32cBgcvbOVFIEyylFAgWavYFmKDMi6ZmwnVvM++xklGVIZ1jGgRFA6LzUc
         JYOPu/bUAfZvoLBj654F+JWIofO472gOOMQbXza0n7Mq58i0oDK2mXXPi/pmw8qS9GoQ
         5MnswOMzpzpbH950jWrV0y0HH6vHH3saqUAUH+VG0AkW1uvncRSXZ2AsWCcKUqrIXvmd
         7GMw==
X-Gm-Message-State: AOJu0YzWKHEt2VuAwVPRc5aJ7FS03kK8DXU3xmaMAzBaJLEypqIBiH4t
        mr2zC63OwB6seEcTkKgDVS2H3cIQLHo=
X-Google-Smtp-Source: AGHT+IG8ki56v/UzcesUZ/CiVmYuZaplD51t9zmZ14vEHOrNqcSm4IevbJn2jRH6wlJKbzYZmTYwbQ==
X-Received: by 2002:a05:600c:354c:b0:3fb:a651:c153 with SMTP id i12-20020a05600c354c00b003fba651c153mr6265295wmq.2.1691908602760;
        Sat, 12 Aug 2023 23:36:42 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c7404000000b003fe1a092925sm10259669wmc.19.2023.08.12.23.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 23:36:42 -0700 (PDT)
Date:   Sun, 13 Aug 2023 08:36:40 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: rtl8192e: Remove unsupported mode IW_MODE_REPEAT
Message-ID: <dc6a0ac89970f5b80a552453a9d057c24f53f43b.1691908402.git.philipp.g.hortmann@gmail.com>
References: <cover.1691908402.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691908402.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasklet irq_rx_tasklet is scheduled when hw is receiving frames. Function
_rtl92e_irq_rx_tasklet() is then called which calls then
_rtl92e_rx_normal(). In _rtl92e_rx_normal() all frames are processed by
rtllib_rx(). When ieee->iw_mode is IW_MODE_REPEAT the function returns
0. The calling function then calls: dev_kfree_skb_any() which clears
the skb. So the driver clears all packets received in this mode. Remove
dead code in mode IW_MODE_REPEAT.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index b3f5ab33603e..322e603237d4 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1496,8 +1496,6 @@ int rtllib_rx(struct rtllib_device *ieee, struct sk_buff *skb,
 	case IW_MODE_INFRA:
 		ret = rtllib_rx_InfraAdhoc(ieee, skb, rx_stats);
 		break;
-	case IW_MODE_REPEAT:
-		break;
 	case IW_MODE_MONITOR:
 		ret = rtllib_rx_Monitor(ieee, skb, rx_stats);
 		break;
-- 
2.41.0

