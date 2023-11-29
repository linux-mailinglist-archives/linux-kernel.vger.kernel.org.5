Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B03F7FE1C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjK2V0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjK2V0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:26:18 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DF410C3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:26:24 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cd8ce7bf7fso261948b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701293183; x=1701897983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sCyYkRoGgiDRrKxcp8ji3Yt467zSBtV+G7Y08/1tlE=;
        b=dVKQ8MixDcLZ2oSabxC+7x6RrFJL047Gu8zum68hWW+AzR+BD2+QpqUDXLj1t1lzi+
         6nO4NRw2Uimzsl6KnyJue0QEKfJPTgWIhPXeGwgBWpjm1ccBT3edLWDkMjq/63+t8A4c
         Mfb2WNVDVoHz+YiVDdMjKxStJxLMVQFTl7B5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293183; x=1701897983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sCyYkRoGgiDRrKxcp8ji3Yt467zSBtV+G7Y08/1tlE=;
        b=tWJ/GwDAYHTpSyO0S1QEBusPaBFkipN6tOKST3tQ04ZduJ/a3fiFauEy6h36ER61Ng
         kdF0lpDQuFFOctndUpLQj1za9ZrfpLpKiJG+JcMFZz0LsIAOnWqGpX+nE+tygbHl8XFr
         xhkctTsGl/eE/827H0jYO53KhP+VrdA0oGG/UCMjTHH8NJH1YWwGmOxeln7BXbD6dmUw
         CInmPPy5E0JL8ISY6bFXES/ApxRYKqxXn4+4inwttLDwYX7v/tALpoEVlzyoLaqO9jMU
         qJmVJOXAwYERLWpxc135oKvn+dDbV971qHIqg5l3Ahed4NFNC1L0NbZwlkc5GiRUGDLx
         L/pA==
X-Gm-Message-State: AOJu0YyeEKgqvv0d5g4pYMGzJtRwtaWabmIUwrUmJSUfa3+S6LjPqkVZ
        i3aXEX8Z9WzWVHyxiiQbZsN2jw==
X-Google-Smtp-Source: AGHT+IHuJr/thflyNs5KBDR3MnZ/ZjMRWa/3xsno1k1cW6LIH0sssFnjJRvfIj02P0P07giWDmy72Q==
X-Received: by 2002:a05:6a20:3d0b:b0:18c:90f9:5084 with SMTP id y11-20020a056a203d0b00b0018c90f95084mr14166441pzi.27.1701293183515;
        Wed, 29 Nov 2023 13:26:23 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:dcf:15e4:5f50:e692])
        by smtp.gmail.com with ESMTPSA id t22-20020a634616000000b005c215baacc1sm11816336pga.70.2023.11.29.13.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:26:23 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-usb@vger.kernel.org, Grant Grundler <grundler@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Edward Hill <ecgh@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net v3 2/5] r8152: Add RTL8152_INACCESSIBLE checks to more loops
Date:   Wed, 29 Nov 2023 13:25:21 -0800
Message-ID: <20231129132521.net.v3.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231129132521.net.v3.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
References: <20231129132521.net.v3.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous commits added checks for RTL8152_INACCESSIBLE in the loops in
the driver. There are still a few more that keep tripping the driver
up in error cases and make things take longer than they should. Add
those in.

All the loops that are part of this commit existed in some form or
another since the r8152 driver was first introduced, though
RTL8152_INACCESSIBLE was known as RTL8152_UNPLUG before commit
715f67f33af4 ("r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE")

Fixes: ac718b69301c ("net/usb: new driver for RTL8152")
Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Use `break` when we see RTL8152_INACCESSIBLE, not `return`.

Changes in v2:
- Added Fixes tag to RTL8152_INACCESSIBLE patches.
- Split RTL8152_INACCESSIBLE patches by the commit the loop came from.

 drivers/net/usb/r8152.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index d6edf0254599..e9955701f455 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3000,6 +3000,8 @@ static void rtl8152_nic_reset(struct r8152 *tp)
 		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, CR_RST);
 
 		for (i = 0; i < 1000; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				break;
 			if (!(ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CR) & CR_RST))
 				break;
 			usleep_range(100, 400);
@@ -3329,6 +3331,8 @@ static void rtl_disable(struct r8152 *tp)
 	rxdy_gated_en(tp, true);
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			break;
 		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
 		if ((ocp_data & FIFO_EMPTY) == FIFO_EMPTY)
 			break;
@@ -3336,6 +3340,8 @@ static void rtl_disable(struct r8152 *tp)
 	}
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			break;
 		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_TCR0) & TCR0_TX_EMPTY)
 			break;
 		usleep_range(1000, 2000);
@@ -5499,6 +5505,8 @@ static void wait_oob_link_list_ready(struct r8152 *tp)
 	int i;
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			break;
 		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
 		if (ocp_data & LINK_LIST_READY)
 			break;
-- 
2.43.0.rc1.413.gea7ed67945-goog

