Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DD77B8D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbjJDT1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244452AbjJDT1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:27:02 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F87F1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:26:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690bd8f89baso120266b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696447614; x=1697052414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5PJMycEXBTARd/V1ON7uAyaQyF56XJbZsQp7M/oePc=;
        b=dSbYTyppKK6GGdgo/uzVNGfGelV7sntQNk3cCy/W5fvqRYKufRUOlKFkL9tMh1aFEC
         tbU/1lrT+KQCzUCWSL+1mIoilwkd6SWrTKVairzdJt21mNTydGPmKB1gfO84e5TueYx6
         kqo/tJAVzqVuf5SFwj4kk+mOMBNDvC8qmH3Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447614; x=1697052414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5PJMycEXBTARd/V1ON7uAyaQyF56XJbZsQp7M/oePc=;
        b=uEPwEtPe5cvs4oPQQw7YcpGaS/G1bk7ANEgy59juGK019/NGQncpFyqaP2soPrvaNT
         CXDSd46pPontZagZ+HPNgZhUhfeK3l33yi+CUBOr7IXL8TrSTYpx2NgcGGpHLjecE8Gv
         WQo6IVsJ7A2w7nwVRefSqYcmsaJrrs/QnyCrsPr/A1UdxZBXGXd4+pfZqw7zD6er5SK+
         oQQgxb1mGruWLxDxxmus41XHtlZacEW5J1AX0Y3YAl22IynlqSBKh5ung9VzmPvrQlKC
         UPdMdw1k7ip6Yqx//spxm29sNvm6Qo96NuY548QdbTpqz5jx8Pr6awferq8cqbCvOsgM
         KZNg==
X-Gm-Message-State: AOJu0Yxg71DsRY1+biL67fr0lgBh4xdWOinGohbAPrFhb0YI8Z2X2QuI
        ZgsYfSiIfiU2EL2iUY+vlSJK0A==
X-Google-Smtp-Source: AGHT+IEh1Bbk/DThNmwQX1a1P0K5A+VqFGwIb+W+IHmklxH8tFWIr0+VpYVV9/RIanpifdMejZ5YjA==
X-Received: by 2002:a05:6a00:1951:b0:68f:ca4a:efd with SMTP id s17-20020a056a00195100b0068fca4a0efdmr3534941pfk.9.1696447614536;
        Wed, 04 Oct 2023 12:26:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9cce:13a8:f2b8:b799])
        by smtp.gmail.com with ESMTPSA id d190-20020a6336c7000000b0057c29fec795sm3649151pga.37.2023.10.04.12.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:26:53 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Grant Grundler <grundler@chromium.org>,
        Edward Hill <ecgh@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 3/5] r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()
Date:   Wed,  4 Oct 2023 12:24:40 -0700
Message-ID: <20231004122435.v2.3.I6405b1587446c157c6d6263957571f2b11f330a7@changeid>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231004192622.1093964-1-dianders@chromium.org>
References: <20231004192622.1093964-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the adapter is unplugged while we're looping in r8153b_ups_en() /
r8153c_ups_en() we could end up looping for 10 seconds (20 ms * 500
loops). Add code similar to what's done in other places in the driver
to check for unplug and bail.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Check for unplug in r8153b_ups_en() / r8153c_ups_en()") new for v2.

 drivers/net/usb/r8152.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index fff2f9e67b5f..888d3884821e 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3663,6 +3663,8 @@ static void r8153b_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
+				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
 					break;
@@ -3703,6 +3705,8 @@ static void r8153c_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
+				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
 					break;
-- 
2.42.0.582.g8ccd20d70d-goog

