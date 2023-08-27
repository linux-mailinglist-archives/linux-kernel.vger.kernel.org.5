Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FF278A1CA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjH0VPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjH0VPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:15:11 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2075.outbound.protection.outlook.com [40.92.21.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB91C1BB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 14:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1hdYezf8sLkfi8J+5px35xMRROkWFmSOkOQABTFBt/c1q65ZWTrdBEf/026+4OiWKqqtZKjUy8iB8ymcO3icP4TB7loyTvyRwafgv7HtYp9D5TQNnmKn2+jGTFX5qXR+hsfD4hJHsNIVT046rl0CEk/++d0ZB8fSI7hvQLuqbGQAidAYtDpFX9teF5SqLFypxC2EIKZsaLK7VXuxHHv2ddaNVEgazoi1gwtC/fif0RgBBf7/tCZBh9n0pufpyjqo52TEAig3ySe1Ti7AvIR7drOzack2e0y9wA9tvaKpB0iRNGME2RmUVRtd0tF5XnKykVyiztFwJoKoU5WDu79sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLQ5pwZ3a/n1mEJrBABK6cKDOCC0xVpHRqxv2OXdTn4=;
 b=frl+SlGJrLQMg/74P0ER0lNRaOtWBcqC/bHUcY1SKfTnBTlajkvkKe6iR1Q8b1w/BVd9mB2wp+C4OjjmdodcPkBXXLTYXrJXyXibgYekXlW82XZDMwx65cVCdRMy5qxkZfERJjDdbKQlDTgQEXjzugTtJPNymy5wrc4Kj77FZvM6uGJVi0bfoOAWFgoS8JeeML7AvGEbg4qDRdwkvL2LZG7VDl9U/pSvQXvQZmFbHq6DSs90S4F7fVWyeS1WK4fy3WPyk5YLV1K0NE6YdhF0cULfAA8MgdUVEs3+O1VVhlvqfZ+DzJ9Iegakg+dUgUgLNoBSHWiOpz7Fpv9JvZKPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLQ5pwZ3a/n1mEJrBABK6cKDOCC0xVpHRqxv2OXdTn4=;
 b=Nqc3R1cVK7Moy/ve23bdx7iVxKmekV7sSkTDUppcFlgQSj0UGe7WxaZ9EGDTDDKxX6L7s8UdzlGBibu4DVLC9KKLoap3Bgc9ZjLXlNCOrghwAjx3qqoqFklZqsRdZMNdn76Msr26cIuZUUQkWHqYnbG7KD8T6oScRLOmAl+++YZbsy9f+ldsAPMtv2sQIdrZ3tBy4QoXrgSu668H9NS5Wx6iFZCnMeYp2UNDMH4IxVOJJWBbFt6lD3BYN0+EKKg0rH4tb9si21iGe9ZIYwDeWVICnJ7z9dRVtLPg1VxmgMbsce11cWHgYqJv0AUlJfNo4Ms/IiTU86r7Ls4sx6fa4Q==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by CY5PR11MB6115.namprd11.prod.outlook.com (2603:10b6:930:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 21:14:53 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 21:14:53 +0000
Date:   Sun, 27 Aug 2023 17:14:50 -0400
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 6/6] staging: octeon: clean up the octeon ethernet driver
Message-ID: <PH7PR11MB7643F9F5DBB6781022CC4F4DBCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [as0DA54OAPWmvWg61q4fo5z/BmSJh+M7FCRryo+iUYcnTgg0qw5TN0aiaRrINVWu]
X-ClientProxiedBy: MN2PR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:208:237::6) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <k4xcs4agjg2pkkepgwfjxpfoncpp4ppuwong5btxzxlrq344hs@dpduydrei67d>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|CY5PR11MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2c3b50-e4e9-4993-544d-08dba742a765
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCjqU9KAT1rFlCsCHecQkIrzCUSa4BMH2DbEFms3JahXgo6Nn72NC7PCzMKGUMDzHWBh0u/6TYFLlVgpnAaCkjFZoCdUlcN0WvzghZFSpigQ6/I7L2QrpROISEsI/wkDxW1fkrfUhv0q88pky2VygtM9I6phESdMhwJv3vrtKUZ433mnee9iCnDSKGvFZ2bo3k6bjxTMz7UAfnTy6pf4ZFFR2ZK5Rsf7QkXCyHtqF6+yxRE5b9f+IxcgOtkGMgiub+q6jAp2Dt502n3sAz9FQ7G9696eS1A0R9hVQ2pz/NcxJLUXbORIjh5UJNwV8ACTZiFFjADzyP9+5vV3V4n8YV9lPwQr+aVXW1AspRFhInTbA9ovlB7HKH65RL3EzJVCaIO6MAOUD4c0PTg6YC1K4lTYipr1Ds29AdGZaeIM32ud6SwbL55BhZJhUuXKEUOi3cLyb2eaAR2h53DwB4mnyMK84LQZ2ceYH+t9uQqK4RfeN6rH307HN95WLagU4EP4J7itgUVQSDtxiorQSZWBUmfDqjzhf7i+gSM+0wnbdatQbejK+pNuSgH+BBkqV7Hk
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i1eRSF+5/02PGMFUXxQ+WC62rAxZ1LUnJv/f1hW2itb6nSQGuArmoOgex8Kc?=
 =?us-ascii?Q?nDKPUTRn9I6Ozj2nwcAOMMUydmPhgyJW77WtdB31fkHKJEAqysEml8H1SHl8?=
 =?us-ascii?Q?CwZwRkANHiOiwGhaepbX0gpBW9KbfD7oElwmlAXyQFFFs1Q3mtKB6yfYqpBU?=
 =?us-ascii?Q?rgDCRkFf7yAzidPPfcD/t1u9o+WiqJI1pQpfPxT7pUhh45RoA9bHlvfd1ieb?=
 =?us-ascii?Q?AYpUoapCfFrRsgoSUKxhNY6oTrkz6ZNW+RsU6uFZP0TawtZaJcWFEpbrnLq6?=
 =?us-ascii?Q?ASlIkJiYDkYUmSQMinWx12TrRDVh5erEVDaVSK/N1P8w/U25AhxRZFMWgWhV?=
 =?us-ascii?Q?bFUS0BT5IMdoxMb7j4PiEvLympKPlp79kQDro7W9Cfvtb8jkedik+PJ46Fi9?=
 =?us-ascii?Q?z1niTy9JGS1EMerTdCM/Z2WtcV70jiLdZ8sHPe4RVv3xBsk1JUAjgGYAIVYj?=
 =?us-ascii?Q?qO/3un2Bk9FiFuBmbOLgmFx/gSSYkZcQ1LokCWCfoCgDyfSbjTCZUbwZN1Vp?=
 =?us-ascii?Q?PK/JTHCAtUUgdJJmcCwsUF5qO6qVybqPoD5RU6RtvVkaiKb5QQedBTWNaHp+?=
 =?us-ascii?Q?tBGqBA4mjxUGrfWUixyUJh47lOWRC5PVrUlnQowS7+V0uB0GPBn4FFL6+lnY?=
 =?us-ascii?Q?J0lBuuUFgC8J4P2QLu2faP6YXg7zaWGl/ahjfZAnUDExJkOtPOIpev2xpkHO?=
 =?us-ascii?Q?AnbtkZUPNZTeNptV31hYdClrx2FdzE3ViQ8beDPhD3cx3ejBfMLkRophjR64?=
 =?us-ascii?Q?hRVjS5yltZrqcqMBn/tNyOte7TxAlk015WP1HxzE7+tKsuOTw07qTc1hRto1?=
 =?us-ascii?Q?CKqGpq7YVqmSos2Pbv7N0+VrX3Ul+X0I0Nj7S1kQ/jL+kMrYVzwQlAmz49Xe?=
 =?us-ascii?Q?x3Q8FH+yPOYxFllTwcrsef2i+Z+gkoZhJDVsisvhFV7Wq8EDMgAM880jHD+2?=
 =?us-ascii?Q?bT1aQlO/3pX6x7FQJ55JKVwKbhDHOhUyE05ug6iK8YedXCb5iCzKT5ylwcL1?=
 =?us-ascii?Q?r8rP0Q5b8qv4eYmXu5yPBjcTmfyL1/dlEZZJCGAxvfnjt3GlqA5ezlDTSzRV?=
 =?us-ascii?Q?iZvq1KSsDzCXnIUygXrSMdPPjmciEM7ZUQZsm/DNkzGxXhWSHWAHsDgiXV2+?=
 =?us-ascii?Q?vfCYq48hX4XA0IumrEiEheKkU2FkPzFc1PFeGf1NbZ+4D+4J4U2eiJnNqtwL?=
 =?us-ascii?Q?2lmU10yDUZC4oo/iM3wj4Cjn0GL/f5n+qalyXzcAewk2BedHqox/jtEE3v6i?=
 =?us-ascii?Q?j77QFJ1oNxvAVGREjkZRPghXlXkFVYSqYRxt7Vqoow=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2c3b50-e4e9-4993-544d-08dba742a765
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 21:14:53.0379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6115
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
 drivers/staging/octeon/ethernet.c     | 2 +-
 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 023b107e077a..f01cdfa3275a 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -201,7 +201,7 @@ EXPORT_SYMBOL(cvm_oct_free_work);
  */
 static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
 {
-	cvmx_pip_port_status_t rx_status;
+	struct cvmx_pip_port_status_t rx_status;
 	cvmx_pko_port_status_t tx_status;
 	struct octeon_ethernet *priv = netdev_priv(dev);
 
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index b9852994882b..8befdcee6ee9 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -384,7 +384,7 @@ union cvmx_ipd_sub_port_qos_cnt {
 	} s;
 };
 
-typedef struct {
+struct cvmx_pip_port_status {
 	uint32_t dropped_octets;
 	uint32_t dropped_packets;
 	uint32_t pci_raw_packets;
@@ -407,7 +407,7 @@ typedef struct {
 	uint32_t inb_packets;
 	uint64_t inb_octets;
 	uint16_t inb_errors;
-} cvmx_pip_port_status_t;
+};
 
 typedef struct {
 	uint32_t packets;
@@ -1258,7 +1258,7 @@ static inline int octeon_is_simulation(void)
 }
 
 static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
-					    cvmx_pip_port_status_t *status)
+					    struct cvmx_pip_port_status *status)
 { }
 
 static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
-- 
2.39.3

