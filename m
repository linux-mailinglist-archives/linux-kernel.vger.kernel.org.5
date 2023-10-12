Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C337C76CA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442228AbjJLTa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442170AbjJLTaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:30:22 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F549CC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:30:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690d8c05784so1130112b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697139018; x=1697743818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbvzQqP0LAVibFSc2uogz4x5ZKRmyFttXMYHpoYS+M4=;
        b=ZKyBR9cUkEwA/LMbDou152prn3jqubQEGGjLUARcLLnm0F8vWYtVANBYVDiLdrH8kG
         wCV+DLkaWoxHy22+6i+Bb9rILNZ5hv1WD+JfwFf8IYmoRpWTjBvGEHIFFTCjYKxy7eaR
         BGLxcG6cYjXPbEmAW6PKG1gByySvPV2cmro6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697139018; x=1697743818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbvzQqP0LAVibFSc2uogz4x5ZKRmyFttXMYHpoYS+M4=;
        b=a9ffIPEvDbJwnoGDqwvkJtczykBRS0o9oTKS5l6mJV0dUrL1BiOAke8VQ4I60B/RYm
         9hSEJkku7gPuLDR7MRzUvNuO2HirPez1eNMapM8XOBEdlVYVz99d+xoVeRHc4BJNAOga
         8ZillrYTZHX/IBT8LzTjZVwgKaBufgqABTLQ8m/87eARPYo8MLqreh4lsV3i5O2793im
         /eYMraHNKuJudlVesikkytLDvcH2HCUb7P2I7zf64pHOGPI5bFWp80DPv7Gy6Oo0VU8w
         cN/yTeYTSsPMN94Jj2UZA2qmomI5nwV/0E9fEt620TnEe7+JO4aRnxVB9L5Fiex2fwbk
         2OWg==
X-Gm-Message-State: AOJu0Yy4Sly3Xr9vDn/scLq4TBMzfweb5KStn7G80nEw33OhSQU5A31Y
        DvY5BhIlU1RAi6pVrn9CC6Sevw==
X-Google-Smtp-Source: AGHT+IHX+LAFkl+UTb4hMHk5hMbenBt98/XVUPofnKxCfpJ1RLXBg+q7crQtvdtlRe1yoANKkXPevg==
X-Received: by 2002:a05:6a21:789c:b0:14b:8b82:867f with SMTP id bf28-20020a056a21789c00b0014b8b82867fmr26000299pzc.50.1697139017857;
        Thu, 12 Oct 2023 12:30:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:7c85:4a99:f03e:6f30])
        by smtp.gmail.com with ESMTPSA id b3-20020a639303000000b0057c25885fcfsm2075720pge.10.2023.10.12.12.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:30:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>, linux-usb@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v3 1/5] r8152: Increase USB control msg timeout to 5000ms as per spec
Date:   Thu, 12 Oct 2023 12:25:00 -0700
Message-ID: <20231012122458.v3.1.I6e4fb5ae61b4c6ab32058cb12228fd5bd32da676@changeid>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012192552.3900360-1-dianders@chromium.org>
References: <20231012192552.3900360-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
2.42.0.655.g421f12c284-goog

