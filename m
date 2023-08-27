Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFADD78A394
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjH0X7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjH0X6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:58:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2090.outbound.protection.outlook.com [40.92.22.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B088107
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5J1AI+xjErEJQLwWOp0AVXMWyk+TNIw2I5k+gE4ajY8cGhoiDeULV5ICeNjtDK/jC8Tv+E5yPWvPIW8nVUq4IK0IfpHAA0AqNIks4ebdkmpGU+LyiZGlvU53OyybR1sFT8sM2x8/2ZdgUKZzAmSedUE7GnWADH0EQImHFDYjtmE8QcUt6JlP4HuLGdwQ2Tvr90Z96wJJIFDDvIkzvBwT7EE4o9PCCD2CmGl6GTC+rZPCYGwZ8pL3ZPzsBbGzpi9YHtQGX1h7v+z5PET9cXv1ZwKBnQNvJmMStLbaXm/O7QAYlbWeHRQL+6PaRmC5PP52vkdZLRX1QpAS9rG8V0lRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/P9aqJBAMljjL23qS8/vSxKF6xjlcTygqgAVV+IXvI=;
 b=OZuPdnX4nI0cRUN0965iTKRRG8Av8BcM+CX+ki5qPI+zPOb1ftYNylPupe9BA0Eo2IDaeUkn59zEJsoSxxEKJrCIQokNdKgRmi4VDd6i/1bMs73Mq0b8VHLrjVSDUHcdq5tnlJhKWpGIM/ObrIbIekhcu3l4SCpqOF2CI6W5Q5dfln6Gxlhna4lHjMAHcSuRj8DMJX1b94E6PXsi+YQYOdJOpy0pnohV9eCPyL9WsSpIyIi3oWIVr5THzjFy8lF3D17RUC1p01pY05pX7iioa9/005s04iTHSXScUwdiEodWWIbSbZjzFx6sjYMb6QhW+CchaNForRXmCvzwd0XY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/P9aqJBAMljjL23qS8/vSxKF6xjlcTygqgAVV+IXvI=;
 b=I07tMMaevGjgjqcGKlgCyee0GK3/DTwb2trmZGrh87CU6UO1imohnk8cMxZ2zQX6nWeTz0eXvXJHfHXy76iDxxbdTHDsky/JSog9txeQlmrfwKdobnBhuboEq5U5VbozdzWlvxINo34iF1sQv5Tvy/AVS0md1onExURCNSusmg1WDFPaVaaTZvYS5ooXVUFEQXyQ5QUNdmSagiljxuoaVQ0DAD6e6FCok0CXDOvr7Ba7m122+Mw9GbndzESAO2Hc8iOltpz3I+DM9gt2EZZQRUYKCpL1//+0uLuY/dzlRjBNbd38A/WQeDO6f1gy8zFU+OX6mtcPWygTxNMWVHctRQ==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by BN9PR11MB5306.namprd11.prod.outlook.com (2603:10b6:408:137::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 23:58:46 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 23:58:46 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v3 4/6] staging: octeon: clean up the octeon ethernet driver
Date:   Sun, 27 Aug 2023 19:58:20 -0400
Message-ID: <PH7PR11MB764363E27687C385001C1969BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693180346.git.ozlinux@hotmail.com>
References: <cover.1693180346.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [G1AjJ2e2gAESQ9NHVLOVW9WIc+GUhkeDDaYpCwdo1YNAaxaj8PeLfnpuAMSDpnmx]
X-ClientProxiedBy: BL0PR0102CA0064.prod.exchangelabs.com
 (2603:10b6:208:25::41) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <e8d86ef1077e497005eb68b26ae998bfd628e140.1693180346.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|BN9PR11MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: b3328722-2137-4d9b-9878-08dba7598d03
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrTVQo2E8YhiYZbimk9QHlfee0RmoCxeVI8gXYiNhfHNZ+GJj7EAnLmMM0hDsfRXErX133PnKvDMnsaEdNNXje7LkpfJHZlvuPqwHqUN834Th3O7aGRHPQdLW+1zJxcvDskJKto1/4DNGCBTSmoZCbzU93iDv1uNIjXKLzceu6VygPSroLcqPmruxgFRAJ2aisQaSmbcsiDhnp3U6+GpUDaWoOtfPNF+fagvx8vOMdCBgrSPyjrOumLQ6auMNWMKQJ7kk5wPL3CsmLlAVImFrd9VamuOwEnPY1H/nHSJlq0vupAvnhtFwlLM6Uu1YxqoKKNHv7fybOsaYkZ3BEOFM/+dtm3wn555vKwQhnsmxdtWNXMUs6fawBDvgncGC/O59lE1zwpM5sVOOQY8x9GgxwIgbMEFxyliQN+HzR7DNTHhOeWAZOKqGx3Ahs4wRD+ikQO+C7IveiQfwLB7penx++kh7AOujlKiJuRouys5Gn1uOj0395f3g7TU+E5H5X3ET6N6Lh2cZJwwL4ikK3Z/dtz2qKtbkWAFCmF8pJJriDrAUCBCKoh4ybErUgm0wHWuAlqD7Qp2JVKgQgk3b335mQXwFqqhbr/oTCqe6uSi5g5pHFdlTnKI07hJUemTmJblmCGiarg87NMiPp8R7DrgrALpzv0bHjFbv9hhxdzWARx7H/u75lxWJv+EovCPmFlFHDyxnanJFe9wE2ep2RLTy/eTslVK4kpy8dyvJOGZE/zRh+WDWRQTMu85RgpkA15klg=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVn6FQFuTKcQ6QvL4zHMHZVf7qGd2v8X8Tz7QQBPYlDJBtp3QvQhe9m8XzIcLUXYS7OMRx82/namyl6DThel+A/jG07+UJBe0Niau1ou2pjQlbt7J18n1SQsQJN8wWksh2Ob4ntllrwBQXM7AWva3mcilPXo7Xsxc9jMMTPeYeSWsntfqGQiwmYH8PJUkQFzU3w6Q4WWZwb7I37GcUVLkTkzCHGR7PMmWUJ2ogB5VNyov4TYn2Rq7Dz0mrMhh8OEtt7xa4j+CyyWBssEIg1KpGxzrEaUKV2sH7rfXzSSJhaxTw4sORWlLUIAT1bh6mYdQ1UDSCb8mTRzib9sEzMtvInDd1O+7GSjoBg/9/cYpWKRt5C9t6dJrsBRw1EN33AW6H9jjRAdADcrN4gj2tTuAJpWb43twSBMzqL2/dtwR5lY9d5EZX5uwxZ3SmsRNp3UkdqaY2bYGBtT1m93t9yJxZxVvusg7igZY/Xp1kekwf483Fu4AlsV8mxn723LbVKSpIYBt8qFpW8h3hoxMn6WkxPga1fKTTmOrLhaB9Uf80H/lvJX+mY85xZZRJrcoamPmuFSFGQf4oU7zuLxIta61tR5WuCtOLnor/larXUaL4I3tBnNH4B+jb1tzme3r7OM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TDA4YhYQb9l+ar/4H+QOaJoO/BYaj0tnY+Buap9jkBhS7dRJVAywJJCLvQZZ?=
 =?us-ascii?Q?pLEIInxMnyt2rzZ573/k5X/bLdZugAPFoiNo7ErO2CrZDycCKh0nYWUHFbWn?=
 =?us-ascii?Q?0xtMbiHjiH94REiG1jjofyj45FGZM4MPfD9HKpNDfR3K0FI8aUbWPnooz6/O?=
 =?us-ascii?Q?YYhzrlzM/W8vMgaTd/aqMnSvAYZP14yvyBKQBrXKXJvl+SHZ5qw+CxE45/fI?=
 =?us-ascii?Q?S3ERTTb4fIiX7Lf/Cjj8a3bl73rOCIHL2GkNu4bXGlEo3W137Ceyz3nv9DXR?=
 =?us-ascii?Q?rpSnjIANmDZs1eMw+/I03AVI5GJ2lH37GuiuPtFKcJ6LxHH+/cwS1RyS4M3X?=
 =?us-ascii?Q?iYyGmOL1AxIOYQYAs2Gn8UU2+MA/Xm7OAYSu9drZj3k1RHam84r1H6a76OcM?=
 =?us-ascii?Q?y1/YCYTeMK6Osg5onqcSlNWCGeo5zAPMF00Nh70JBj2TbZ/3aY/Yszn6gKO8?=
 =?us-ascii?Q?UTKwmrFd+CeEghICEJE++tJjUpmX23G8pc0Q+SJxQ0DVVejuWQIuU5hInpjX?=
 =?us-ascii?Q?CRxud/bTV4lSnhru+g2OpGLW9VEtlPkJ4KhrVVEtTOakvvdGspBcrEGZwOgr?=
 =?us-ascii?Q?6DEEN9q5+essWGu5yRQJQj3WeyuoCr3f9iJpSEaWi9+YBe8a7ZlLQyYj+4Bc?=
 =?us-ascii?Q?6WDKn3y7BpwgPzxPsksytqvuAX3n49agiRhcsm1l9nwhcoHv1X2lONOleaBm?=
 =?us-ascii?Q?w6FObH+1DbrIa9k1gz2HKOBcjgzTNx5mbdKxgfGPf9yf1w+oCzridE1XKiV3?=
 =?us-ascii?Q?j8qWavMDjy5KTzALYrhpN80aPY6irHZmuTrVJkQ9Qqd/O8Xz4roZrGk3+aee?=
 =?us-ascii?Q?qRTdlFIu4MuyWN0WFt4WoqZapTX/wvMy9w7WLA/0X2mNpJC90TXQros/81ma?=
 =?us-ascii?Q?OQQk4Ef2fS5XZ0s7Ohljt8hncFfy/ltL77jS8ryWlU2OdbplmN5/URqWUn61?=
 =?us-ascii?Q?/EDIN9+jYhishseAhxIwQbX0TF1ON5m1S9oNHSZxaHgLozpVQW8fTw+whCZZ?=
 =?us-ascii?Q?JOrFgYSgkVnlN+Wpwfnhto/bkGpCOuk1Ja7MMpaemdDm3Zp4BAOrbDREKSBE?=
 =?us-ascii?Q?kGDBp4UF0exm+2/7p1t0SJUYJVLom8WZkYHEgoeNdEBDv6hM8MffAWaM6mYb?=
 =?us-ascii?Q?JZktyEwajclcaBOvJtP8QpPfgW2MOSjJALVlZfCi38qMP/460Ut6bAXOphO1?=
 =?us-ascii?Q?8oiPm8lzDLBSireNVk5u5H+fTAgGPUStreXLuqb85pnO1CBHWU7//XwVeN4q?=
 =?us-ascii?Q?ogLGkD+W5F3bIz5n+jj01e672YMrxuTNXoVuY1jphw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b3328722-2137-4d9b-9878-08dba7598d03
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 23:58:46.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5306
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the octeon ethernet driver better adhere to the
kernel coding standard

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
v2: Actually send the patch set properly 
v3: Fixed a problem where I forgot to rename all instances of a struct

 drivers/staging/octeon/octeon-stubs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 4470c985dc5d..2cdbcbd8a97b 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -238,11 +238,11 @@ enum cvmx_pow_wait {
 	CVMX_POW_NO_WAIT = 0,
 };
 
-typedef enum {
+enum cvmx_pko_lock {
 	CVMX_PKO_LOCK_NONE = 0,
 	CVMX_PKO_LOCK_ATOMIC_TAG = 1,
 	CVMX_PKO_LOCK_CMD_QUEUE = 2,
-} cvmx_pko_lock_t;
+};
 
 typedef enum {
 	CVMX_PKO_SUCCESS,
@@ -1381,12 +1381,12 @@ static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interfac
 }
 
 static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
-						cvmx_pko_lock_t use_locking)
+						enum cvmx_pko_lock use_locking)
 { }
 
 static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
 		uint64_t queue, union cvmx_pko_command_word0 pko_command,
-		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
+		union cvmx_buf_ptr packet, enum cvmx_pko_lock use_locking)
 {
 	return 0;
 }
-- 
2.39.3

