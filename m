Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C57FB0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 05:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjK1EAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbjK1EAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:00:42 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363571AD;
        Mon, 27 Nov 2023 20:00:48 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r7pH7-0002hr-09;
        Tue, 28 Nov 2023 04:00:42 +0000
Date:   Tue, 28 Nov 2023 04:00:39 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH v3 2/2] docs: ABI: sysfs-class-led-trigger-netdev: add new
 modes and entry
Message-ID: <e72a6794639cf3881d698e1d34b456e747da1b95.1701143925.git.daniel@makrotopia.org>
References: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document newly introduced modes for the LED netdev trigger.

Add documentation for new modes:
- link_2500
- link_5000
- link_10000

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: include this documentation patch as well

 .../testing/sysfs-class-led-trigger-netdev    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-netdev b/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
index f6d9d72ce77b7..a6c307c4befa0 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
@@ -114,6 +114,45 @@ Description:
 		speed of 1000Mbps of the named network device.
 		Setting this value also immediately changes the LED state.
 
+What:		/sys/class/leds/<led>/link_2500
+Date:		Nov 2023
+KernelVersion:	6.8
+Contact:	linux-leds@vger.kernel.org
+Description:
+		Signal the link speed state of 2500Mbps of the named network device.
+
+		If set to 0 (default), the LED's normal state is off.
+
+		If set to 1, the LED's normal state reflects the link state
+		speed of 2500Mbps of the named network device.
+		Setting this value also immediately changes the LED state.
+
+What:		/sys/class/leds/<led>/link_5000
+Date:		Nov 2023
+KernelVersion:	6.8
+Contact:	linux-leds@vger.kernel.org
+Description:
+		Signal the link speed state of 5000Mbps of the named network device.
+
+		If set to 0 (default), the LED's normal state is off.
+
+		If set to 1, the LED's normal state reflects the link state
+		speed of 5000Mbps of the named network device.
+		Setting this value also immediately changes the LED state.
+
+What:		/sys/class/leds/<led>/link_10000
+Date:		Nov 2023
+KernelVersion:	6.8
+Contact:	linux-leds@vger.kernel.org
+Description:
+		Signal the link speed state of 10000Mbps of the named network device.
+
+		If set to 0 (default), the LED's normal state is off.
+
+		If set to 1, the LED's normal state reflects the link state
+		speed of 10000Mbps of the named network device.
+		Setting this value also immediately changes the LED state.
+
 What:		/sys/class/leds/<led>/half_duplex
 Date:		Jun 2023
 KernelVersion:	6.5
-- 
2.43.0
