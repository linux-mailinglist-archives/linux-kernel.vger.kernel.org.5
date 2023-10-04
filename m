Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC227B8D6B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243944AbjJDT0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjJDT0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:26:54 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0F2CE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:26:50 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6c6504c9ac5so134875a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696447610; x=1697052410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Zfzelmm1n/oCSSsu2UQQ3ShaAfhz3hNzTZf6CMU+g4=;
        b=Pi8CIpn07shffaXyjeVj/e+/7+yV2y5oahlK+xoXr7t7Btw9U8+wECYrKE1/YN5oO4
         OydR0Hn8PwKXEFr+uTO9r1lE3hxzosPOzZwMKAO03yKlSOng45Qe/QGXGu2gxWqHKHFk
         XUcK2Ay6rBJnExE+DGeY+WXg2bJHMdLdInhZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447610; x=1697052410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Zfzelmm1n/oCSSsu2UQQ3ShaAfhz3hNzTZf6CMU+g4=;
        b=FbYBUhtM7VLL8MeI8RgT1fcfi3ffvrYxz7N2FxeJUYMEYJrr6DbNQyf5StLm8MHPiA
         YEc7ziDI4vDml6VSF5jRLqSvx0lO3rQqDjMebHP5Xa9ZLTRfZQAvL/6gABxMaXNk3NR9
         bXpEzEa9IPmacg8GpYTtqvgo6Y+hf9oL6XRthMOFaS5ngTgAF7uCyUIXyi7E5l49eRCh
         d9adc+iMW+NyfTdCE8euEn1bTA3Sf0gQXisYfshxOQi94xZgcXGUOnbd6UU9/aN0qahF
         0WcdwPn6ghZjKXHbnb0fi3k83xJwPge5cpPV/TMK3oru7uFUEX6qzI2XboaiqbVxYdfD
         nH/Q==
X-Gm-Message-State: AOJu0Yw4gvzd+feoRqIqvKUld/AmOPKSKTL7p/spYcHQiYMbmhOeNsW4
        mpnBln4jZAHa0GVvoiz8RZYv8g==
X-Google-Smtp-Source: AGHT+IFLqgqksG+reeE7PZOYesE5gVIpvSs2k7VqK+4YgIVhHEe8hG2Nx3gW4/n0MzstshK1BGyLsQ==
X-Received: by 2002:a9d:7383:0:b0:6b9:2869:bd81 with SMTP id j3-20020a9d7383000000b006b92869bd81mr3271947otk.18.1696447609953;
        Wed, 04 Oct 2023 12:26:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9cce:13a8:f2b8:b799])
        by smtp.gmail.com with ESMTPSA id d190-20020a6336c7000000b0057c29fec795sm3649151pga.37.2023.10.04.12.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:26:49 -0700 (PDT)
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
Subject: [PATCH v2 1/5] r8152: Increase USB control msg timeout to 5000ms as per spec
Date:   Wed,  4 Oct 2023 12:24:38 -0700
Message-ID: <20231004122435.v2.1.I6e4fb5ae61b4c6ab32058cb12228fd5bd32da676@changeid>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231004192622.1093964-1-dianders@chromium.org>
References: <20231004192622.1093964-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the comment next to USB_CTRL_GET_TIMEOUT and
USB_CTRL_SET_TIMEOUT, although sending/receiving control messages is
usually quite fast, the spec allows them to take up to 5 seconds.
Let's increase the timeout in the Realtek driver from 500ms to 5000ms
(using the #defines) to account for this.

This is not just a theoretical change. The need for the longer timeout
was seen in testing. Specifically, if you drop a sc7180-trogdor based
Chromebook into the kdb debugger and then "go" again after sitting in
the debugger for a while, the next USB control message takes a long
time. Out of ~40 tests the slowest USB control message was 4.5
seconds.

While dropping into kdb is not exactly an end-user scenario, the above
is similar to what could happen due to an temporary interrupt storm,
what could happen if there was a host controller (HW or SW) issue, or
what could happen if the Realtek device got into a confused state and
needed time to recover.

This change is fairly critical since the r8152 driver in Linux doesn't
expect register reads/writes (which are backed by USB control
messages) to fail.

Fixes: ac718b69301c ("net/usb: new driver for RTL8152")
Suggested-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 drivers/net/usb/r8152.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0c13d9950cd8..482957beae66 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1212,7 +1212,7 @@ int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_in,
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      value, index, tmp, size, 500);
+			      value, index, tmp, size, USB_CTRL_GET_TIMEOUT);
 	if (ret < 0)
 		memset(data, 0xff, size);
 	else
@@ -1235,7 +1235,7 @@ int set_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 
 	ret = usb_control_msg(tp->udev, tp->pipe_ctrl_out,
 			      RTL8152_REQ_SET_REGS, RTL8152_REQT_WRITE,
-			      value, index, tmp, size, 500);
+			      value, index, tmp, size, USB_CTRL_SET_TIMEOUT);
 
 	kfree(tmp);
 
@@ -9494,7 +9494,8 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
 
 	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
-			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp), 500);
+			      PLA_TCR0, MCU_TYPE_PLA, tmp, sizeof(*tmp),
+			      USB_CTRL_GET_TIMEOUT);
 	if (ret > 0)
 		ocp_data = (__le32_to_cpu(*tmp) >> 16) & VERSION_MASK;
 
-- 
2.42.0.582.g8ccd20d70d-goog

