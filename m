Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD1378B4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjH1Pku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjH1Pkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:40:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2015.outbound.protection.outlook.com [40.92.19.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34CE99
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mg/CKfqO4kvVCWzK5dNjVAkTYzw4z5LgnJtZBPyRY7yCrJMwO30Zlu/lrOCno/Nuh5G2KiNKeIfb3dFRIDkarSVsDFzF9+2FhbZ27auDxNt6eDeYiSFurAbZRYHe3NnGhQ8fE6uBIfCcqH1s8/PPs01ntHUwhopEjsPQ0lU6gPd7IVAUgW9asLu0BhScUIEt2GhHOMR/GRI0GxGx3FKIdWw7x/E9WVwu+bDtTya//Q1MSIVgNwnq2ZkfipSijTATuMbouifL86+gLMCIOQVKs9GbrF9omCD6KWzVbLOJAtnf+sqDpHVbQ0cktB5TfUCx9KPjgIQrAjRmziNriAAP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPjQn65OPeFfX7BJpeQI8TDeqx8whk9i08e8Japd3wA=;
 b=XWdSIBWQNvWlcjbdb/ThpsoEzF8fqvwEsIT+W0/doofex7/I+pwPDbVeIROIkOh6oC47JllXOp+azTtGGElK8wurAwLqwK93dLTOIgkyDtDkRdlKY/fwyGMZHxhZTlHF3aOMkcjWBn7AkbKnBruKX0qoXg+V6zXHKZIB4BYvZcp7aQzHUBvhWfpgtqHciXNFJ/3m0RqWJAZojGqAz3Dme5no4C79PQLpR5muHBqQ8LPxF4sHRvuLEd8modWU8GiFk+TIY4wC4Wz8sdxgfYI56kRe7RXNwRvVKrJqW16gxd/J6f76gK39+LQ4tbNsy5eyu04jRk4iWWhB21RWR5UzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPjQn65OPeFfX7BJpeQI8TDeqx8whk9i08e8Japd3wA=;
 b=aWH4/FQGNaF4x/3gD710hzjZBpBjGjKZ8cSEKGJq5/0aIaimwDonU0ihVVCUJDgQpALhPQQbI/xdzmKXOd1rGqCxBh/mtrYMn0QbRKuM4TqTK3eZnMqgX3Ay7gqLhiVeI/WwhYGE9xDlklbmoN1WMzszjwtLNGob0WTBNRstHtOAHXp34iGzLocR7ffMnPnPHKOIVb36Pc+maJPhwAcluZweL97exj/sL5OKB/yyowstYTkxK2VLzsOUDwifZu3OofJYo/i2ffy6/awRNFMc6uyqkPaTdolDUUabInUe2Fu/ysTAMSQBQEgYMR0ZjqD2yBEm6Zw6DIVfF0/pvTsdjw==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:40:38 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 15:40:38 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v5 5/6] staging: octeon: remove typedef in enum cvmx_pko_status_t
Date:   Mon, 28 Aug 2023 11:39:10 -0400
Message-ID: <PH7PR11MB7643430B9516797F3870936FBCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693236450.git.ozlinux@hotmail.com>
References: <cover.1693236450.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [suuGSqUn2DqFgTyEbWpsW6+Al2/Tbhz5orXUkzq7LlKtnCq5TqQdsahxscFokXiw]
X-ClientProxiedBy: BL6PEPF0001640C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:13) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <b74102fad482ed4213ae6dfe7b34172a3dbd7fc7.1693236450.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: d07da5dd-0c99-4722-bda4-08dba7dd20cf
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmr1VCrDDYJl/lCLgD1Tr5zrCV98kiscFCSzlzc2UZidX74SdB0Nk7xT2VkLG1JIs4WJPuOdy5J1U8KOHA5CqMj1Q//MKi9OTZvXOY4BQ6g8uoMrG0ZOUNTe6P+EIU8hrDNSRvJLddgxohb8LUoiSFytVSXK15sEDnUpcFkBLFwLASlY2ZQhQyI8cnIksPT0CZe63OVcdsfQ+K86Vq/i1qT/6NzF7ABOOLCcP4bzNVvduYwWCYSI299Pi4FNpLW0GrtEbUB1JsGSlZ/SQwXyCdFJLvoZfmkmItE//rzYtAXQ3xbKdKpbrlNyYlceZMN7KlwWcKFhib60MFzDrpebXMjFYpjVLDzlJyfTXtsasbTlirzA7gARuisyzh32X81QTkJK58o3IMQ+xcni4S+Sn+6Hb+JwyFLUG/uCyRFY3iw4+WwAtdhnRyRKclv+7TPqFlJJZWziiZP+cgFn6IPNvCTXUbfc0R3VxcRQI/MQQrqcANSHIr+pEpVxMPqLT62tF/q/ujW+YoGNb6HmfVnya8Vg9dQ+SFxry0rfK607wQo6jAn1q0OB3kudvCAlVLnMRSP4J/XxRZ0f8vrsQxknt4Mph+cMzWk9x5i3ZANv/CGbIVerbC95MlqufPP7i6T2YxjnWg6lkh3u0duPvER55pxJSQM+NRt+VBd2CNnne4HNZi+9DsDWygYGPUGWCdrOtUez0vUNQ4LYEiWyaA38C4lSxycnGTAQMsBB/hTEdWkjM28KnkX2tC2Z/yWzObJ5uTI=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: laXrKalGC2ByNKq4RU5Q+kDJ+nZArE1ID0wMprCrmw/RiEteaFjNWvJhjDWCkI2+W3j0fK9Gtqf1InGT1wCLgIWBGdS8G1puy+Cyq/K8fpwBTRaDDu5djC9rru7FX9bJZKj6cY6BlgK9YbpLszt/USTcjPwTMBhIw0i5U4Gdosl9BjAL7Zrgbhz+6pV+FNbDE37Qy+lwcCQrcrlUfS8PBXO4OP0ZUr7w7o7y4DA8VXKYkRGG0W3OW4MhiKax0rFUf5zD3nf7ZypdMSqWBes0uccMKGOL1JvI9qCjrs+J6Of0KinINcWD30fVpSTAPUVzyzBIGiY6/t/pyOrSdU3dMRFvtjtyVnwykyl5HDQ4FdxOh4FDT4Wknt4cxKcpBmvWmw5tOqE3DUcu4+biB+pFLYa5znwoCQoP9Jv8FL0TVjfIOgpl7ftEW3WcQo0QqTvUaO4ULjc6SWi1nwEc80neL9Gi1v/8WxY9ghMcW30iLPLYr1r2SZklEh+al+UFmjL3GUpQf9zUM6g8VQoSGUClt4cJh7MR2GID1JAkC8vPVdFWme3MWlwLX8BoN3SR8iu+ZakfhMuIX2PfwjGyCIaub0dF4W+OjIa6veu71Bo5xRPgSClRfpTKjr1FRkpFntep
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N6y73fSNaF6mxuse73rMeQ4cz2LSh/YVuaS33nbjqu8H9saq5WVD98l6ZF4v?=
 =?us-ascii?Q?RJspjjJd2T5LC617w6tJYsivAT9G+puJaCAwi5DpHUcMc8PnxnCohQatKXIO?=
 =?us-ascii?Q?YcZ6/NkIcR6Ex22iep0/19M8G92dKO3KH6ThEPhuifMj/Sy8iYl+3KrsErvE?=
 =?us-ascii?Q?cX1E1xofXV9z6+dDkAwkeKzfHj9Xz76I2zwCb/2aL3LDrkCEuutZAp4qXF/2?=
 =?us-ascii?Q?Te1AmpkpvI0vXoFxzQqh/u26+2TQgiXABpagNcdNgBxtVhvzKH+7s68gDWn/?=
 =?us-ascii?Q?ggvnR9a3JC4626fXuM+dynkChaq1jmM4R9mB/sYsEwZJHX1dfuAwshpwPHp2?=
 =?us-ascii?Q?4XQI68eMDwgpRPbrdRitpfAj4yOxGY1U5h6Q/Wk/cSlETI0gseAcu5DSQOmv?=
 =?us-ascii?Q?FhmtMAJtLRXncrJtrthhtWibs/UtwjkakpJtoWPj27A7/ZCYdpv5BQN/8h3m?=
 =?us-ascii?Q?4dxmBLuYGdtEd2Rt+u8v+Sjy7cgAgPr9g0LBKVfMawqaw3JU0AjSluKmWuit?=
 =?us-ascii?Q?aJGaTIJ6K3nwG6Jcbahru0HTezZVoY9tDqCTLqJFAd5y3uNiBVm/kXJbNnss?=
 =?us-ascii?Q?QFzK9Ts29xOcJEccGzo5nTtV7prkE1qN0QVj6QtpzFewpS0EaM4SwuRZsAo6?=
 =?us-ascii?Q?zX5KUSgY5R/8nNDjzhjJbn56jRmcY2iHlKBoyzFriLN9kMvN84xbXg6LNxEt?=
 =?us-ascii?Q?kKi5dz63GlKislgkDtgsanjGZH/hmpUaz0YH4vyjvUrmQaqDY7AQsCCUb8gn?=
 =?us-ascii?Q?DU3Ic3nhrnOOGZiz56uYzDJt4qcCX8V70xIDuF6ix3dFTjp+DvNqODnrpXCw?=
 =?us-ascii?Q?Dq44mFA367Q8knhqucOD7FiX7eVa4mu4qYrbo9sfBeEwux1NUs+eertuYgJQ?=
 =?us-ascii?Q?6+gY3ZXOKSMRkQERVAIy1c9mzlU35eu0TI8apiVhAT5ojxBkRSmVH61QehOw?=
 =?us-ascii?Q?+WKdRtO2uwLrBw7Y/PlUwRyFWGNlYLSMHNU+Ws23+TSrD08aS8nbSrvR5MpL?=
 =?us-ascii?Q?2KehyJuJyRNRCfqjJmg9RGSbuMCLtvzTJzPaMGaSCHxyrOR/dcVg6MiPV/bH?=
 =?us-ascii?Q?PKtKDe3312InjcOUJhLaKjJxTuUrIrklhtxX/HxdpB30drG3TYannaoIbnvS?=
 =?us-ascii?Q?K3tbSYxyJ7kqfafOBU09r+zMcFErWdGbn8XMO3IRCG9477RkETO7g/AXi+da?=
 =?us-ascii?Q?EoLW8jK4k0VPAg4jAjaqn4UwhwR40PI3XmZg9CxWEZKh3peObU7DVzuiKgTR?=
 =?us-ascii?Q?nhBF8Y+bSgnlNwNE+94e5PyY4xeK3hH/iPmeKYu6Qg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d07da5dd-0c99-4722-bda4-08dba7dd20cf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:40:38.8149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedef in enum cmvx_pko_status_t, and rename all instances to
cvmx_pko_status

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
v5: More descriptive commit descriptions
v4: No change in this file
v3: No change in this file
v2: Send the patch set properly, with messages in a single thread

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

