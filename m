Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A907E1A3B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjKFG1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjKFG1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:27:30 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2063.outbound.protection.outlook.com [40.92.98.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19D9B8;
        Sun,  5 Nov 2023 22:27:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JheXT6UxzODZPBuGhAAjs/eKzPOYqgl57+DUBZVJm0DydrYPVxataRbvIhN0dgn2zxefZKZZQyjUmkuL+a+4JHGcJQhLEVrENvOevg3mC7AQGv8nX4oRm3QyvzPvX/wnPRvzMfwMNzijlJna6JeSyBnaf0O7yHzfAaMbzy+atNpJvmgvRR+BsoLUv6t8s6AVcek+xaLfxiKUBI7BWF/rDIt1U5VNbY5BPEYz+NnzfXq9qMhOxNmOGqBfd9XCJ57A+3ecNxYspsr4qnKJm08uH+NoZKnaJOp3k9qDnGf6vMPKrjcOXZVjKBERZ239Repb/S6qR/YGSKQ24tE1z/7gIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJ651AL1iOYHGhpZcB2u908BUH/4wvbqx5MxAwswnno=;
 b=M7K1JIFf4uCzzaAERhxDxYuY81+/iVEW+c14GBmkY4Ro5jxq3/Nri1dDpkgryvQ1z6qidY+tYomolV5yCXe7XYEFN0VLrXuWhjBfAH3L9bzBicBSXZ+53fOBF1YG+LuQzYcpExX+uiW3dThfWHnn+kQ3Z1HTlfDlQmPBZGAy0UTNe0kHMphPuds+m8vynQ3VRgtigx/RMy+5NT50WGsq02xXIHYX9q6tyxtYCkecrx3iG6ZQh9/CZvvD6S0G0cOFDixo3opWBpaES+mqr+dHnVLzTVjMU1IZ8npb/laq3sGbHYanze2su4mgwdOMmdbNUr44WUo7tbb0KBF5mHbe9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJ651AL1iOYHGhpZcB2u908BUH/4wvbqx5MxAwswnno=;
 b=mFHOAA88KGIQmS8AB216xbQSr90ZeI3nXIPIvzKwqSph/SNirkp+9lRSAzBROQAqok5DrLbiUtUzqxxJcYuNQDCCztP4RMbwS2cLAvIWsb/n0DyWwpAnsYhGc8gkM8UQNjtVstj28vDlDxmT+lQZG/oshAJ8byMjFgP8uYYFWdRowO4Te23c3glXU6sS2gkmyQKoRMt/vc2UlIoy7QOP9zWhtGMSh8W344PsTYj9qTnAGI2i7ql/TcK3R1RVjG385ZD8XAVm3LD5UOl1wTXg6W64MEie3pEbotatDtJbwsmbSg0kqj9pu+EHg6HoJWk3fZarIsEGfVNz8E/ubn31ag==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TYCP286MB2367.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 06:27:22 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 06:27:22 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v4] dt-bindings: leds: add 'internet' and 'signal' function definitions
Date:   Mon,  6 Nov 2023 14:26:51 +0800
Message-ID: <TYAP286MB0315F4D71698370875F58F6EBCAAA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [+IcjH/6JQ/NEElEnZktObtPbbM7gCv3o]
X-ClientProxiedBy: TY1PR01CA0198.jpnprd01.prod.outlook.com (2603:1096:403::28)
 To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231106062652.5466-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TYCP286MB2367:EE_
X-MS-Office365-Filtering-Correlation-Id: b187daea-9432-4f49-d427-08dbde916ed5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsufzQ4KG+RcG1PFGVJtEdv4Aw2YUS6n4S5hEdyzoAymPPPHoKO7EB7utReW6/ZB4tnBFI5vkBTXN1RN4CxTLhjelF+7h1qgKGr77WA42Xj/DFSt/NqWGlJuQfcYAqtZwwJGTFTeoWAZjbqbcYw8wdhx0kXES9KJZXUc349HjRoLnE8DNGGFfKoEuANzS8/hQNMQ5QhA6EWUkTEqJWAuG8bI0+EHTra6OzXr/D+FgmvfCtj+Gp637Y3hHp7YGV+wusqkWhPh9iA4clbsJC4+KF8n+YjdbSAs0FqDRKc2/JYgR4J4buRE12QByq/uIWdd1gurk70EByMaUkADR00LBMmK3z7b9vnPcBLdLYt7xQp9lNYH/UmVXebrBg7AGpedKErgFAt2pLUN2eOaE9Lhwyw1f/bctZUBrw6ruLspiARGDvh0m+1cIk767qY1lu+rSRLenoqHe+gJ746GKi1tqCaxhdmL41nylmrgW7A2NMHK5Fxm8cJs8BZjfKXC78aOQTCF78aw1Uc0g+mbYiSUzThfo0zf0dpqJvTBTZh6Md9Z+I6SzhG4vytmjePBYDwKKVI6gHgYKdpaQDsCLWB2I/2B4+sqKG6gcTt5xXZmvQhPTyEVAnuOCM47j4pTPqHTo1/bJzs0x48SynpHRtZnpA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aF8MxX802yYxpc0OS1ErXHMx2rR/35yBPtAls15DWopKI9XH1Mr5JZj2TbWe?=
 =?us-ascii?Q?u7q1NHgu/y3lkcHbbWrhTNEWFodw+QV0v4JaDgVzKUabkpjFAmTmR/07PIOT?=
 =?us-ascii?Q?RownfyJBALfAELtyADm9j+747YJv6sEdKDUgtmbqRE5yxwjZnZ4eFdhBBHB6?=
 =?us-ascii?Q?DusnD7Mcumy44rAFpjWnOxey/QorbYBgk3ZlA2XyGGLNqqanM5O1tEhw2RKp?=
 =?us-ascii?Q?4xCgunYp3DvdoLKu+ucgNPOYBzm7w220KWMb5GiOWWNYQqsi/WlP8sLAmIda?=
 =?us-ascii?Q?kLvRW/1UOymlAHd1IS9sMsC+grpfc10SYLVmh6IpsPW8T4HuRub4wb8N7oVq?=
 =?us-ascii?Q?TlsHfbpReBTPnz4KxgeZ61FO00MtfAUfTVJ582PZgZJclGaCZUovOlNkhftn?=
 =?us-ascii?Q?ReIqB3UI/1igBOzYBThlcSGsJqX9N87ufvHcWXA4OcwR+9CXEY0+A49TLiap?=
 =?us-ascii?Q?167I9SLVMZcjzX59armHz1zZBtIQnhZyyZh3uYRr8wLwT/IEMOoIYO9Ttar+?=
 =?us-ascii?Q?D53Wbo80DrEMHujp7O6BEGcNTyN+xYJw3lrCXQFIIyLqpgiXwAaiCdhq38in?=
 =?us-ascii?Q?WegpVTppjBzMUiHXQNqXcu+2oJL9rN6w2eI1MxLGMNTprDJvTnM3l/Rw1FBs?=
 =?us-ascii?Q?Wv7zxueRYUIK/Z0OX8cvR9/G40g1aI6+X53fFyKNdhVaI7iIOjlVOebIfYgN?=
 =?us-ascii?Q?F8/iVGcyqAVcKow4WXcG20tLOlOTUa8tJFM7mMFPUoPE0lqgId8srrxcl19K?=
 =?us-ascii?Q?8VpH7DhQYLDCyNWzDPDR9ntwH3ytdAIOk3PMbCh4/TowvAlXvBj5id4PgUDZ?=
 =?us-ascii?Q?vRxQwuqVz2biajEycBfDQNMqDXj/RdVyM5nYffCOHeDRVkU1rZ5PlyJ89G5m?=
 =?us-ascii?Q?Zmx0e2c76nbNWjFvmpyDuDizEWQlXLr0InhKbJQIPSjvz9I6NM0xFJzQNVLm?=
 =?us-ascii?Q?inzenjp0MjrZPOduhiDBMQ+6d8j7e5Lqpv062l2lUkNimFQHrUjlv8OmUz7W?=
 =?us-ascii?Q?Tr/PZJ3NFVUpkLCbcH191OEaKDxg9TkLwUttPJCSHdKKjM3cQ5oj0vWmM5DU?=
 =?us-ascii?Q?bSS8SqjSHsWUKakpEJ92uzebktWi6bCPlnKHDnB5jg01z+hwtSDLhk9ydfY+?=
 =?us-ascii?Q?tYmRC/NrND4ZwcmLgsLzlKhCj+wd83NzfI7IQnFsvnWObKk6RycOLqMJf0Ds?=
 =?us-ascii?Q?pODub6QQ4GTYXCLeqPAnAblrIydF3t0CmBZcU19PPY1oxXKt16Wg2nIg5Ug?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b187daea-9432-4f49-d427-08dbde916ed5
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 06:27:22.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2367
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two types of LEDs are widely used in routers and NICs.

The 'signal' LED is used to display the wireless signal strength.
Usually, there are 3~4 LEDs in one group to indicate the signal
strength, similar to the signal icon on a mobile phone.

The 'internet' LED can indicate whether the device can access a
specific server. It's different from 'wan'. 'wan' usually indicates
whether the WAN port is connected to the modem (internet services
may still be unavailable). But the 'internet' shows if the device
can successfully ping servers such as 8.8.8.8 to detect the internet
connection status. When the router is running in AP only mode, we
can even connect LAN port to the AC/modem to connect to the internet.
In this case, the 'internet' LED should be on. On some routers, both
'internet' and 'wan' are available and can be controlled separately.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---

Changes in v2:
* Remove the LED name sorting patch as it changes the ABI.
* Add "devicetree@vger.kernel.org" to '--to' list.
  Thanks to Rob Herring and Krzysztof Kozlowski for letting me know I
  can send patch to multiple mailing list at once.

Changes in v3:
* Add more information about the new added LEDs.
* Remove the missing LED fix as Jisheng Zhang has already sent a
  similar one. I should search the mailing list first...

Changes in v4:
* Rename 'rssi' LED to more generic name 'signal'. I forgot to update
  the source file in v3.

v1:
https://lore.kernel.org/all/TYAP286MB0315FE921FF113BF76F7B700BCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

v2:
https://lore.kernel.org/all/TYAP286MB03159A83A77E6FD59F271D9BBCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

v3:
https://lore.kernel.org/all/TYAP286MB0315AE8F62E6AB48E3F9A0DDBCA5A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

 include/dt-bindings/leds/common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index 9a0d33d02..f831c5dba 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -88,6 +88,7 @@
 #define LED_FUNCTION_FLASH "flash"
 #define LED_FUNCTION_HEARTBEAT "heartbeat"
 #define LED_FUNCTION_INDICATOR "indicator"
+#define LED_FUNCTION_INTERNET "internet"
 #define LED_FUNCTION_LAN "lan"
 #define LED_FUNCTION_MAIL "mail"
 #define LED_FUNCTION_MTD "mtd"
@@ -95,6 +96,7 @@
 #define LED_FUNCTION_PROGRAMMING "programming"
 #define LED_FUNCTION_RX "rx"
 #define LED_FUNCTION_SD "sd"
+#define LED_FUNCTION_SIGNAL "signal"
 #define LED_FUNCTION_STANDBY "standby"
 #define LED_FUNCTION_TORCH "torch"
 #define LED_FUNCTION_TX "tx"
-- 
2.39.2

