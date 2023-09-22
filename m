Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B767AA92C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjIVGhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjIVGg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:36:59 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F290E19B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=FklUloVeC/IRscF5Gxi0GaW0kes3xUCC/OyKePZjK7g=; b=QMDzuS
        5SRIR3kgcPOVLsMOQOQjRV03h+7w8tVMA1L53xCEhlo/eiF8uRtU8qs+Y9YupN5w
        1jCfYXB3jXVnkbCW09p1V8BrdC3FWI+xvH5d0edFEwNkHzrdLfsvmQFs1AO8uXk3
        5k7nldWfgpT6k7AHB1WL4O6BXQIaI6AksP8QymfGSJiMF3SBD/TNE6bCaZs3cjCH
        /UeLchJO1bCk6QO8QsEki16nnSheCssxUejZesJCns0CibWjYj+i8SIpHeumw/LH
        DsexD1/9NGXYw+RpKt4J0XE6Gf/fweltgpzau92yUc+I11Qs7KHDrVlxMU6uSFwt
        3cPxw4mQUnE9NJtA==
Received: (qmail 1276431 invoked from network); 22 Sep 2023 08:36:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2023 08:36:51 +0200
X-UD-Smtp-Session: l3s3148p1@bHdj1ewFeroujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 2/2] serial: core: add comment about definitely used port types
Date:   Fri, 22 Sep 2023 08:36:42 +0200
Message-Id: <20230922063642.4120-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230922063642.4120-1-wsa+renesas@sang-engineering.com>
References: <20230922063642.4120-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When port type 18 was removed, it was deduced that the code could go but
its define has to stay because it is used in userspace. Share that
knowledge by adding a comment about it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/uapi/linux/serial_core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 92e3dd56f631..46e06c483899 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -11,6 +11,8 @@
  * The type definitions.  These are from Ted Ts'o's serial.h
  * By historical reasons the values from 0 to 13 are defined
  * in the include/uapi/linux/serial.h, do not define them here.
+ * Values 0 to 19 are used by setserial from busybox and must never
+ * be modified.
  */
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
-- 
2.35.1

