Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D6578A369
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjH0X1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjH0X03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:26:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2046.outbound.protection.outlook.com [40.92.40.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64FEBC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:26:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm6O9GzuVykjgChet1euJ0vdnS44Nq7Nx+GUuECrexn7acolcGMBKbSvkuCfI7z8Lt6EDuxQ1nyqm/bEDUlI8/PjgANS5mDb7HYPyB3+LSwawjS08SQGJ2HBKa6H1oDMhpOb4Wal0YZRIzk67dYq0mYl9LTs1cxzi0aGvgfTpjPS+3lxRKtYESK01Akbu9oOcz3rwkXgFvUFqxT6jflHy6QVYSDjvoU6B4NaMa99stsSPiF6BtzeCGY9j8UpUnhD4gEFLP7qTuaV+eWkAUkd82CMF24OBztH6/p7yaCtqpr/CUUOjxakzvk+fo3KKXVFQhyBr6DuslRRM4lRNdZKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ0YCsxg9eJUeRQaZl0vhQycO+xB5Y+xbiFPtDuBCGk=;
 b=X1YWIP6jtK/Ys8rkSEHjCm069vgaC+cIN3H3ldk7CN8ERMF+VFclt3WDUGWBxt0q4DpjMlMSW7qSnBwf33VmljS0QbuW1TNf3bpxNOpnbJPSr+5TPvxIczzuGG/aeunBbxmKo7EElHhrQtavSDaNZ8CRtPV80xVPTzUenL2xtYKS02bRwkgfYVnrUHDwQ2vDCu/83E5ff3YIB6mq0A3LwlEF1uCdu32jYRmBgKf+dC5BUDDWgRVLMXQIAMFJU6yXYea1t1AS/WEbz7qJb4U872rQDY7me2UfERy6eZgMuXGCO13mDt/tYTtHNPM/iDUJ7O9H0+RZ6Fk6yDSPcHjnKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ0YCsxg9eJUeRQaZl0vhQycO+xB5Y+xbiFPtDuBCGk=;
 b=ROe0oe6JjtuO9mXw72+vL56kEng7mEOao3NnNadndsQ0bC0HvDlsA/opJuC+Vp4ADCVKYK0nXbOVK4q3auD5M6UXqdgjTES3pvimfJXG7VG1WB/a6750KLr7caBU/nPZBgbDxNqxDQrMKG8XJ64Kpd2OflSDSNB2yZBkts85tTGSj3iRF4Klom+IxTSV9NRL0Udx4aSmAdijl2QWCCWJ9KxZXjVwl1QfSr9b4d4J6kA1HWR7qm6m/bwM5JwB8UFZvayJMmQ05O068TjT1VXUj6aPoRhwvwdETIE54wmaYca8Ul1kpxYkvt7sY1gsDs/phfzUliVbokircUm0b3qghw==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by SN7PR11MB8027.namprd11.prod.outlook.com (2603:10b6:806:2de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 23:26:25 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 23:26:25 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 5/6] staging: octeon: clean up the octeon ethernet driver
Date:   Sun, 27 Aug 2023 19:25:55 -0400
Message-ID: <PH7PR11MB7643E3A86B0D15ED22E350A4BCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693177830.git.ozlinux@hotmail.com>
References: <cover.1693177830.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [X1PfHjp9RmnYEF3liemdi63HUtuN0GWaMkreyP/tZiX+12X67twNEsXDdpCPPpqX]
X-ClientProxiedBy: MN2PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:208:134::41) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <e9630d0489b3a584284affb7a4a26b59d8213d36.1693177830.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|SN7PR11MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 33df0b1e-20eb-49d1-0b45-08dba75507e5
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmrTVQo2E8YhiYZbimk9QHlfee0RmoCxeVKrcwyOHQe/aK18otc3EVZWY2CH+Zd0NfXZ6lz/q5TtbqARofZl+jfBM/ayCHNPCq20d0B2chLVLAowyKYZv5EJL2AlddqmJVUqHrYrx7C7NwmjPzANqGw9gVcPhsursRU7EI9I45eR1bLPwhpBC0Hs7M+x2i32aC7+cEUv00iFsIjajUI2hk5KFTCoamgJkJpUv32lba4pSwqrmFRbhdMgcvf3VH1BBg/7S8I0l3ZBX2qkPCFdUW1ZBXZjE8fiMWGLs9ztnbYSOHmI2bxo5OCsPpr0YS/Ade2++BRr9TikixSxpgx9LJilxM/s67KUSqhc/AUGjh0wEtuBRV7jDQZ6BBx3RM1b/l5v1FEVEb/HuEJSMB+rkCiuxlNCqA+YmXF1mMiJA2PkV3pkFSi/yRqRyO5wnWORDsorF0jzZZx23oL75VduZ2+k8yCRdTW9lVW7cdehM7uCFMN5RX9ItTubpjPxrjFYED0yepkMYMt2gycUIpveuLJ+WzpGUNIu0ocGIHaVI7pbfVNlNUaQFtKhkRRLmHJgDDZAq2YJ+Jq6wa2pBNDN7bPxbBDVooeWJlNY9OIed95+i/V7lYru5THi7movIOvDWZhUT792u4aDv5bbo76mkqG0HvdYG/1ozybTDZXRhdwu96mLobI5SWlOYUhliVS5nHCdx8iZ5IJ2cK658YZ0Tj3JTrUUHN6hHSMaV4pTgRhuvUBCqkq5FUnatn6XnorQpEY=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LByAJEh1Dqzq1s1xy1YxO19ChQLR9svDMAojAyz2tYW284EJGVYPxtpuxFGyiEjvyUjd00CUTTVXL/Vwtk3C2LnkDB1V8pl4XfGtGd8QiE+oW/TeVckZeUB5sMNQw1UJMNp6lk/pGpKCZxhMC1kEI44Vancip+x6NUE+W6HMrJGjMUTdLWOpE0xtHcvAWnvKPrl5/BfbJ+WqZVVLpBaVJ3AQuud1Nm+/UvCZBQWRDOemgiLU6U9DXlqWs3OZVCQs6ansg7OllJCWBqa/aa3g3Ta0q1rptHSPzMHH2s21GWTHgdPmxKUZOlV7haAQ8ZJPj5W1ZhBv84vlNra+kpUbMLXqfhKl8Ajd+U8nqcT3j4+RXVVxfe5glqYF7kfnG86G3S8Fmuodu06Jp9erctXmhofZWrjIvaM9VvdgonRzWQ8I93c4CPNLd57kuMzdv6gLcsHMRje7/zWKH/33fk+4nVLwBxjTJHxJevbZCdIVBIEEinP761YlH8Ptme5o5SpcUtJXaYSzdb2YXJD1BbOEqZHdDRqOGMLeyDT6XfZAbT4VbGLrM8uZ4qfC2F7S/DnlbZG4gG6TPxjwOcQI3bBcLoI9DXiX+r8ck/SSccZXd6B5yp083q4jfHeAGV8ssK03
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Apb9sTVzx4P7gM574KN+RB/JdW3gXanvhU0lCT+YI+ngVhZ2vp9FFEnxGfXZ?=
 =?us-ascii?Q?675btG2OihYPHvXfY5672dVB+SyI/2qaEV1pas2SM1AelhPyNWSDB/7xNlLf?=
 =?us-ascii?Q?1lHmWN+fL7Hp7PxWpoFaOoV0aJTBKUvRMZgRr9ROkjniPGN9+gC+9nlXKQN2?=
 =?us-ascii?Q?Yhg/zk35VVucyzEKZ92fkOq2eCXlAclzND8KW/ACXtv3Ubq2mexHRwpAngI6?=
 =?us-ascii?Q?EdnGaodtZigcwzAt7SRBY5SINfsYKP4mlx4AFcN+OHIkqq9wmCx/r2OQTnH0?=
 =?us-ascii?Q?OcfV+pbBRcXxpMpktaK2v8fUE7+fu/3qoWnm1RpTCTYbuayqdFCd2WBXy7eg?=
 =?us-ascii?Q?ywJKuV3azIMroR+PIsPBQosNCg9vGdom3CsK/Z9oBsoJ0UCXU4fF7BQVCliV?=
 =?us-ascii?Q?6kfo887OU+alu7nLEITu9IDH4zXj9k1n8BPsx9SDu6GNp7TR1vF33Gy89l17?=
 =?us-ascii?Q?lQDHTrbshLz3EFT0YBuc7WjMeYCDtcswp4+1HFRLAyrf5gpjaI5Nyyji8M2T?=
 =?us-ascii?Q?9CKdpsSLubDVrmyspr2BBMfGPXkK91p6p2EgzLVkn8CeYHvULLLrVYaHdXj8?=
 =?us-ascii?Q?KR9aXQ/ILSovUd4OK12KAab7cyC9Fjxp1xvBz2pEeBBE9R5GIqPLqFK0Y7GG?=
 =?us-ascii?Q?T6NRY6Bg4HUNP1ZCAk2PYNK2byBWv6qTMJqywMoHqditzkgwzPSNjWM4q0YU?=
 =?us-ascii?Q?N3aDF5UWENiCWbGm/ithD3QCuV40E6RGEQ+vfgwQuuPfm+QvEvWlI2ULAtTM?=
 =?us-ascii?Q?pHd7bHztXGGSCLgRxsN381dVsfwckgxVu7P/jNN3hh1eWBK0qYlr35fmN0Ah?=
 =?us-ascii?Q?SLsCfX3ReuEXPUweKj/ozjD5B0LH+njwltjXvC9Y+TbavlNNZy42sLHnhqxz?=
 =?us-ascii?Q?3gdq82faokfJlx8R+lATjyaVmKDzdHyPvwpTww3SlplCkozy+Msnp4w8kMlA?=
 =?us-ascii?Q?5YOIAE9+yDQPvwf8WP3jZnh8VJ0iUmx0qLh/73rDotAYuXNFmO2OVfaJ+e11?=
 =?us-ascii?Q?YTTi8SnrjcZL1jQZU15xHBPKR1PvKH6YGgbZjQqUIX7huTyOaXzD5vDNj46w?=
 =?us-ascii?Q?XYFSexlOTZeDeIuD1Zwc/1cg/EOSzET7BFPtWqpvprkjW+uBdD3MaueTlArJ?=
 =?us-ascii?Q?q5CiO7/YPeeecHWl4645UIAtDVr/Nb90p+q5BKt82e+yRqu0AznvhisfZS6B?=
 =?us-ascii?Q?CjNHkgGIkaTMH90hnA+y4F8aHT7mcWZH9LOpKPqpUBSogwpqiZY4LVwCMt3i?=
 =?us-ascii?Q?patTibYs0jLoYyk8EB3Jp/cUfKJ61bZm5GJ+G96Z2Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 33df0b1e-20eb-49d1-0b45-08dba75507e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 23:26:25.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8027
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

 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 2cdbcbd8a97b..b9852994882b 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -244,7 +244,7 @@ enum cvmx_pko_lock {
 	CVMX_PKO_LOCK_CMD_QUEUE = 2,
 };
 
-typedef enum {
+enum cvmx_pko_status {
 	CVMX_PKO_SUCCESS,
 	CVMX_PKO_INVALID_PORT,
 	CVMX_PKO_INVALID_QUEUE,
@@ -252,7 +252,7 @@ typedef enum {
 	CVMX_PKO_NO_MEMORY,
 	CVMX_PKO_PORT_ALREADY_SETUP,
 	CVMX_PKO_CMD_QUEUE_INIT_ERROR
-} cvmx_pko_status_t;
+};
 
 enum cvmx_pow_tag_type {
 	CVMX_POW_TAG_TYPE_ORDERED   = 0L,
@@ -1384,7 +1384,7 @@ static inline void cvmx_pko_send_packet_prepare(uint64_t port, uint64_t queue,
 						enum cvmx_pko_lock use_locking)
 { }
 
-static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
+static inline enum cvmx_pko_status cvmx_pko_send_packet_finish(uint64_t port,
 		uint64_t queue, union cvmx_pko_command_word0 pko_command,
 		union cvmx_buf_ptr packet, enum cvmx_pko_lock use_locking)
 {
-- 
2.39.3

