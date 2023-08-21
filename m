Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EC078210C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjHUBQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjHUBP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:15:59 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2052.outbound.protection.outlook.com [40.107.215.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205FE99
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 18:15:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdYlPHEU8PaoKRrolf7jM221WabKu/oCudU1KpScc2fQMRNEKpLarpTym/2Z6Tz5OFt7LjyRTsFg7ITqsydMvFQk7xmxks5BOrHnggbF4vcOEi0RZQAApbDYNxhJt1ehvVVW60RUV5P3vbiMjIy/GzRbZT8Arzxr1Ngl3/xb+Dj39D/LM9+MVIjgoBEQjzVGkf+4rijKtRyl7F83BpJsjAZ5wvC6ZEpifzRvzsxyo5CpBaHx7qDStQWJhFdxaQ0pLetBYyyCo4L87P6J8TRtJzju/piNxXKma+MtHobhxRc8ps+w34G8+gj9uVzZzSJg84qxyVSVZCrcUJdtEnkOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qo49UyVgd3SudTIlTUL6v3lVDo+e+qGDoSC16jbLgRI=;
 b=GKfVyI+jSELb46TG+SJfIW3bcu22UEsJvJWL61TRMwgjMLqieqfpjGvzUws1nfe4c0grbolrYGaKfHYGBE2B0GTsPAHOulfYw6GQGo5IMnIUfCceJg7SzlW9zFxU361vqxczQHke0UbsvB40H7uFbLzjPkT1YWSMDdj5UAq/e0lbZwHONfovoDwpitieymzWkLOPmA+4KfEUwk+mLGUZWG4ONYDQvO7Ii2nxL8B/uIc28BZQLxDkD+I4G6xPfj98UTU9L9gABy7DyQPbMxliC31swGAoqWhwBLKQ9XKcFNkmIFP0c7DfO9CbV80M0+sKd/Pm0E2awgTn9t5B4DGGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo49UyVgd3SudTIlTUL6v3lVDo+e+qGDoSC16jbLgRI=;
 b=iFNGZrb2n3om3YkEg71pd7kc6l3h6XJsQfshnRiL3+OQ4qZ9vVQgiMMOj/H/SA2aLCO5hNIjhxWkVeBH8BUORr+EocDtxZYTzjLYKYqfJCDo9BZlN06rGx73hKKuwQHE8JJIare2wETod8S26ICTdP3X0xxt88/3URyX43UoNMoNkV15q7USIe2uHe/3EGncYDPRWj6doefDY/h8uiQf2pha2T6LkVFKFg50m/3M7CeKbvwasFAQr9Ds4eteWqjCFCtKaXHgC/LoMYQjm52jtwh+IChMGzsk4FlR68e8MijP5GwSRS09kuXR35jYnPzKgjglb5V9g+jrhAd/GP2t1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
 by SEZPR06MB5070.apcprd06.prod.outlook.com (2603:1096:101:3a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 01:15:50 +0000
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::7e18:3180:75d8:5495]) by TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::7e18:3180:75d8:5495%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 01:15:49 +0000
From:   "Shawn.Shao" <shawn.shao@jaguarmicro.com>
To:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     lege.wang@jaguarmicro.com,
        "Shawn.Shao" <shawn.shao@jaguarmicro.com>
Subject: [PATCH] vdpa: Update sysfs ABI documentation
Date:   Mon, 21 Aug 2023 09:15:35 +0800
Message-Id: <20230821011535.1117-1-shawn.shao@jaguarmicro.com>
X-Mailer: git-send-email 2.37.2.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0299.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::19) To TYZPR06MB3933.apcprd06.prod.outlook.com
 (2603:1096:400:29::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB3933:EE_|SEZPR06MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: 322a8ea6-c987-4ff7-cbb0-08dba1e427d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ymaguyQh4H9MYCFpiIFWAZWcmnTo7frBJF8HOXAWtNbUcUEMpqKMAEU9Qcd2KhCAZ7HvT36E6dAihdKQ3Vy8GaNCBRlYw5GkvHM5Bw9P9HDJ7SttMDGq11KI1BxiCjYZTdvyYjlBKTkIywUdme4KGS5PwuyUEm2+lZXkq1nRFGMw4+SnjI1Fmw/Iy1UKIykrWcj0t73iR96Odcf+Uw8jNROcZ7RTiB4TxT5TE/OnJvmK5BxqOqVG1OcrVAQ1Ml1aTDN/j9RexZ7MStXjuPBuVyxgqz3UVgTdeGBAWdSO8inXgp5SaNN/rrgJcZgsR99qBk6vxgy+nmiOo1nkm/vNQE826xxvzT1VymDwstgwTYhB45ClOv8C2wnmBTay0sQFdDDFLWsJtVStI0S1J412NbN69NyFjZ5qoo5tGtDDMvsui09F/6JcTCnv9ocAOp6eKukJXoflNPz3akaHPV5ZHmxCLP9cEJk4Hv/GJsjKaQXyE+jamurt4TzRUTReDdX2ypZCICGiBaJtfzd4Yv+iDWwkzhf6EezFKjkg4UcZFgURJQenmndeZkWYh7cjnRFY+9ONkKT88jJFPqLPmE8Fk0P2rQfn6knAzOuD7ldBRx5sUFUvaIE573OXkQArObt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB3933.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39830400003)(136003)(346002)(451199024)(1800799009)(186009)(4744005)(66556008)(66946007)(66476007)(2906002)(4326008)(8676002)(8936002)(41300700001)(316002)(6666004)(6486002)(5660300002)(6506007)(52116002)(478600001)(6512007)(2616005)(1076003)(107886003)(26005)(83380400001)(38100700002)(38350700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D2SBJso3aM/3YKIRCm2REVF6YiwZ2L/4yCfnylquJpSFPLzJr8gI54OSjayo?=
 =?us-ascii?Q?I48zSUH0HkRllaN1Or+glMQierP2XJrno9hVATAotuoZNgmTnFlyXCgxreeq?=
 =?us-ascii?Q?5VGecXbtpwhgjziYV5g8dEEAxhdIdml9cogOjvtHJnTXzpjzwk/vCCK9mNDr?=
 =?us-ascii?Q?YqY/zqt5ovNIcqsYT/FxtHKca8iv7kUSUTQJvBP4EzVBpLchK4Ox4qqe8fu6?=
 =?us-ascii?Q?3ZhalwEm4+jJXuLWxVghU+UrfU3ecZz3pf/IhTFUGyHX0RuKSEqblKLVzWjZ?=
 =?us-ascii?Q?fOcfGQf6/bT1sW3NYZyZEn8IPwAsgJRnDGGMAb/umO0F5OIj6N2FT3OdANas?=
 =?us-ascii?Q?T63AkrSV4JVppd4d4clzNsRDJev1GH1sR+F0fECMJxljz4yoOv7IRg0KRGjF?=
 =?us-ascii?Q?n0vE01NMe5RShF52nfetVC9yu5stv/erdldopi9k544z6oomyESLb6vcygwq?=
 =?us-ascii?Q?c0Uvgah8ztQvOQTjvyRfUwTX2ySfM9q4zhZmtufVXz5CJm8ZlJWhoXWakS+n?=
 =?us-ascii?Q?7fPh8GWBa1wwn8eJaMDkoxMs3ma1tG7hSXaVXTrB5uWMH/IGrXnK4Mo1+BVj?=
 =?us-ascii?Q?RSB2c6RFRb2G0IInVi/3cZ/pajtxj4+wDcVB9rsbXl0wPLziUIibwFDnOBRe?=
 =?us-ascii?Q?H387luHYPrGkFe/5jrHcm5XrzYup9h3WYx3nmfjKmuxY+SxBg1zeoTRPWWTF?=
 =?us-ascii?Q?pwc0b1bDGB5zDuxmUsjghx7I4wMhnRT1u1P6qYBqMu/+KY1nGJcbUKjh3oHP?=
 =?us-ascii?Q?Jh7H28dW5zvDZZshgzpj1CzIIa5/EPsITGeyQZI/ZFffUyozLKqzuuPm1e7V?=
 =?us-ascii?Q?91plwwBlBgt3lCqP27CLCx0ueffK/bq05veSOdr9j69xWsYqI9NOCBwzeU3G?=
 =?us-ascii?Q?AqCkmeNu2Zy6WhMoGKWnWsdnjUeNIoL2rjIkzpYWptg+EU4li4RsfH8ANlQk?=
 =?us-ascii?Q?+6yuuDlvhkeq7XPDPzd0VCdHK0Ev3Ss4VglYkGxEJLfZPfariFhWvenuuj1c?=
 =?us-ascii?Q?vsulovCtv6QyLyFfs3RCyHXmkJyKi9HGWwb8sE8RTfyLVwqIa8KF9Ye1uYXv?=
 =?us-ascii?Q?F0BZgM2lhj7Ske3ua7hkYxLq2fYUhJByp9QEyvGc36GuQ/rsjAKLS4HTiiv8?=
 =?us-ascii?Q?6csA1h5qC4lzLTicAvKvan5PtUiQHcZvK5fAlWT0H0KwNDfS3iuBEnAytfWd?=
 =?us-ascii?Q?s+CrpljXifKCS8AN56MdmADlEvrFWkU5yiQzICzRR6PAqyTPT9MmPda5HPrD?=
 =?us-ascii?Q?fRJ2zGRWrOtC2nZ7z3VOsrLHFK+IvN4P9+vHFsTtdo+1RbRhE1C3ehMQ1Zbd?=
 =?us-ascii?Q?Yz82SzwnvYcBtopx0t8q6hJpJ8UqEzry0FzVtDQjGuxqBA2PsgtKuYIVEtFk?=
 =?us-ascii?Q?JqjTPpCynPT1m4qjLpaXNydCh4hrxBEUn4+GobE2Jy2jGJkEAPsJeoWlaEFh?=
 =?us-ascii?Q?xZr9lNAhQpwfVgr2Hl1fwWE+y4N2WTqh7p/D6OBo7Red7/Lb01lNahed8HhK?=
 =?us-ascii?Q?NAcz0gvs3dRrlXZ0YsoRrSX8QnwWmWUV9MzRsIEa0OZlTEeuXgoIY7fYqJNc?=
 =?us-ascii?Q?RowHbwuvjS18Qggt9CubToPC+5IcHwgvcVksjfyL/2t4SFdGB3v29IYSP6b2?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322a8ea6-c987-4ff7-cbb0-08dba1e427d1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB3933.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 01:15:49.8266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsHt/plB5/6LKn3n809tjYJYqD89FB/D52yyTJkUikT8Q5jN5XXAXA5grvNdAFiEPd5K2yvltvw3EeCYzQekKPCh9exFiysWLEiPOXl54NU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the wrong drivers_autoprobe path name in the document

Signed-off-by: Shawn.Shao <shawn.shao@jaguarmicro.com>
---
 Documentation/ABI/testing/sysfs-bus-vdpa | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-vdpa b/Documentation/ABI/testing/sysfs-bus-vdpa
index 28a6111202ba..4da53878bff6 100644
--- a/Documentation/ABI/testing/sysfs-bus-vdpa
+++ b/Documentation/ABI/testing/sysfs-bus-vdpa
@@ -1,4 +1,4 @@
-What:		/sys/bus/vdpa/driver_autoprobe
+What:		/sys/bus/vdpa/drivers_autoprobe
 Date:		March 2020
 Contact:	virtualization@lists.linux-foundation.org
 Description:
@@ -17,7 +17,7 @@ Description:
 		Writing a device name to this file will cause the kernel binds
 		devices to a compatible driver.
 
-		This can be useful when /sys/bus/vdpa/driver_autoprobe is
+		This can be useful when /sys/bus/vdpa/drivers_autoprobe is
 		disabled.
 
 What:		/sys/bus/vdpa/drivers/.../bind
-- 
2.34.1

