Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED63802AAD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 05:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjLDEGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 23:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDEGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 23:06:08 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0BFF3;
        Sun,  3 Dec 2023 20:06:14 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d05199f34dso13412425ad.3;
        Sun, 03 Dec 2023 20:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701662774; x=1702267574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CbkCHx96etqSfTuELzIWMZk408/Yxj+/7Dk7WZ5k3MY=;
        b=DFK0G+Iz2ZSBFS+IA3UStPS36CkBwmzEvgWn98Or7aGFot08MBdQiFfayTm8SJwdb+
         91aCmLAOYUYVuypEL49SApdGSY9vsb2ieKuitb9no+biiwKlzy1/g0RKSSHciSgcVGGp
         Ti7PPOHEFZQ2dMTPthPP64+WjDCSMw+FiSHUCI4qAo2joA0R3LOmYXXeUG0ObGxfj+3S
         nr6hWlQvJCajRg/qNGZBOxLQSkY1lHLaXojlQOSaSIqyDu5GS5kj5QB0JG6sWA4JwuSR
         Ea9fA2uWx4uKmrOf/YiNxCJa+g08gMT9Yq6+d+3Tv5f2lOryhNmlHPYCCTzyAfb8Ya6q
         AuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701662774; x=1702267574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbkCHx96etqSfTuELzIWMZk408/Yxj+/7Dk7WZ5k3MY=;
        b=Yp/25NkZ7rEBESoXS8ZEPXZ+TPLIvXeu9Df2gGUdNwSoT4acStzw/vonYM+oAPvVLn
         03DzioaaHwo3ZCLOCHk1wJD5+TCJ4ekU9yABs2sGMGj95eDYbxNKH7MNmTwM4klAi7hm
         58ucUm39HwfRha8KlWkL6fCNWYvwKFAKG2+GiHVanr0fwqMFMGwP6qK2gSYax9geifRZ
         W204NpX/cKdVGmIRncZx31CcfclQZ4cjkHeOMkEM6/XPiOphQo42araPoiSE0kUUqfiP
         p4P7Z7aciX6dVaQKGgzp7RrGmLv1SotuDQCKyioNsbnv4fpLF1rGEU/mOgPBAGPIfz8T
         NuJw==
X-Gm-Message-State: AOJu0YxdMZKQIGLkeJRppq4Wsk/7clF7emvRRC/IMBq5Z5Oy6zV/uUpr
        50uDtnUJ2Cmqcfb2jYoO5qM=
X-Google-Smtp-Source: AGHT+IFTfw+eZUHc/hM8+luAPSQ+lJwTxRZCwzjVXg5g7icgbGKpd+2Bl6qrw6MJmDLQvVzNAeZ2UQ==
X-Received: by 2002:a17:902:ced2:b0:1d0:6ffd:6e68 with SMTP id d18-20020a170902ced200b001d06ffd6e68mr1451983plg.96.1701662773729;
        Sun, 03 Dec 2023 20:06:13 -0800 (PST)
Received: from localhost.localdomain (c-73-254-2-55.hsd1.wa.comcast.net. [73.254.2.55])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b001d08f173f00sm1736084plg.194.2023.12.03.20.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 20:06:13 -0800 (PST)
From:   Adrien Leravat <adrien.leravat@gmail.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org, corbet@lwn.net
Cc:     Adrien Leravat <adrien.leravat@gmail.com>,
        linux-remoteproc@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] doc: rmpsg: update with rpmsg_endpoint
Date:   Sun,  3 Dec 2023 12:06:04 -0800
Message-ID: <20231203200606.255302-1-adrien.leravat@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the documentation was not updated when `rpmsg_sendto`
and related switched from `rpmsg_channel` to `rpmsg_endpoint`.
This change updates the proper calls, text, and the sample.

Signed-off-by: Adrien Leravat <adrien.leravat@gmail.com>
---
 Documentation/staging/rpmsg.rst | 50 ++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/Documentation/staging/rpmsg.rst b/Documentation/staging/rpmsg.rst
index 1ce353cb232a..dba3e5f65612 100644
--- a/Documentation/staging/rpmsg.rst
+++ b/Documentation/staging/rpmsg.rst
@@ -68,13 +68,14 @@ User API
 
 ::
 
-  int rpmsg_send(struct rpmsg_channel *rpdev, void *data, int len);
+  int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len);
 
-sends a message across to the remote processor on a given channel.
-The caller should specify the channel, the data it wants to send,
+sends a message across to the remote processor from the given endpoint.
+The caller should specify the endpoint, the data it wants to send,
 and its length (in bytes). The message will be sent on the specified
-channel, i.e. its source and destination address fields will be
-set to the channel's src and dst addresses.
+endpoint's channel, i.e. its source and destination address fields will be
+respectively set to the endpoint's src address and its parent channel
+dst addresses.
 
 In case there are no TX buffers available, the function will block until
 one becomes available (i.e. until the remote processor consumes
@@ -87,17 +88,18 @@ Returns 0 on success and an appropriate error value on failure.
 
 ::
 
-  int rpmsg_sendto(struct rpmsg_channel *rpdev, void *data, int len, u32 dst);
+  int rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst);
 
-sends a message across to the remote processor on a given channel,
+sends a message across to the remote processor from a given endpoint,
 to a destination address provided by the caller.
 
-The caller should specify the channel, the data it wants to send,
+The caller should specify the endpoint, the data it wants to send,
 its length (in bytes), and an explicit destination address.
 
 The message will then be sent to the remote processor to which the
-channel belongs, using the channel's src address, and the user-provided
-dst address (thus the channel's dst address will be ignored).
+endpoints's channel belongs, using the endpoints's src address,
+and the user-provided dst address (thus the channel's dst address
+will be ignored).
 
 In case there are no TX buffers available, the function will block until
 one becomes available (i.e. until the remote processor consumes
@@ -110,18 +112,19 @@ Returns 0 on success and an appropriate error value on failure.
 
 ::
 
-  int rpmsg_send_offchannel(struct rpmsg_channel *rpdev, u32 src, u32 dst,
+  int rpmsg_send_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 							void *data, int len);
 
 
 sends a message across to the remote processor, using the src and dst
 addresses provided by the user.
 
-The caller should specify the channel, the data it wants to send,
+The caller should specify the endpoint, the data it wants to send,
 its length (in bytes), and explicit source and destination addresses.
 The message will then be sent to the remote processor to which the
-channel belongs, but the channel's src and dst addresses will be
-ignored (and the user-provided addresses will be used instead).
+endpoint's channel belongs, but the endpoint's src and channel dst
+addresses will be ignored (and the user-provided addresses will
+be used instead).
 
 In case there are no TX buffers available, the function will block until
 one becomes available (i.e. until the remote processor consumes
@@ -134,13 +137,14 @@ Returns 0 on success and an appropriate error value on failure.
 
 ::
 
-  int rpmsg_trysend(struct rpmsg_channel *rpdev, void *data, int len);
+  int rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int len);
 
-sends a message across to the remote processor on a given channel.
-The caller should specify the channel, the data it wants to send,
+sends a message across to the remote processor from a given endpoint.
+The caller should specify the endpoint, the data it wants to send,
 and its length (in bytes). The message will be sent on the specified
-channel, i.e. its source and destination address fields will be
-set to the channel's src and dst addresses.
+endpoint's channel, i.e. its source and destination address fields will be
+respectively set to the endpoint's src address and its parent channel
+dst addresses.
 
 In case there are no TX buffers available, the function will immediately
 return -ENOMEM without waiting until one becomes available.
@@ -150,10 +154,10 @@ Returns 0 on success and an appropriate error value on failure.
 
 ::
 
-  int rpmsg_trysendto(struct rpmsg_channel *rpdev, void *data, int len, u32 dst)
+  int rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
 
 
-sends a message across to the remote processor on a given channel,
+sends a message across to the remote processor from a given endoint,
 to a destination address provided by the user.
 
 The user should specify the channel, the data it wants to send,
@@ -171,7 +175,7 @@ Returns 0 on success and an appropriate error value on failure.
 
 ::
 
-  int rpmsg_trysend_offchannel(struct rpmsg_channel *rpdev, u32 src, u32 dst,
+  int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 							void *data, int len);
 
 
@@ -284,7 +288,7 @@ content to the console.
 	dev_info(&rpdev->dev, "chnl: 0x%x -> 0x%x\n", rpdev->src, rpdev->dst);
 
 	/* send a message on our channel */
-	err = rpmsg_send(rpdev, "hello!", 6);
+	err = rpmsg_send(rpdev->ept, "hello!", 6);
 	if (err) {
 		pr_err("rpmsg_send failed: %d\n", err);
 		return err;
-- 
2.43.0

