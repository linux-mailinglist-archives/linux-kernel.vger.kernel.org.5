Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502CF7E62E1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 05:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjKIEjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 23:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjKIEjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 23:39:10 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2031.outbound.protection.outlook.com [40.92.99.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA6526A0;
        Wed,  8 Nov 2023 20:39:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiX9mPiQfXl+CeatA1XfszWlKk/4INuiYvkDHYxBNszIkSm4c8CifeMiL37nffI0jk91icC+4DAx71s24wI8hKnPoOqNfca9PQ5dUNqw0fg4Gg0srpyWKJ6zXiIo6IBzrgzUmPE38IOgPU1xwEjfr2MfvMMtUIFqh6jsPHgiKJ6rIcu+2qDAhvILLXZle5wCBPk663rfVgQOE+JPvEDZlVMxbWXuNSPHM8f9/sS7zVMRJj/uHEcbpqfUs1DemtbSAs1C4tiIqgn15rBMzglwcReZ4WD57NzrVMI+/Y66qZBbmmjbPKGLT9xEypDTscV74GhV3to0qPDz6EwW63AB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zq8ppgizd2ejfRY8/vPm1f2xw/C11dZfCnWvGn9Z0I=;
 b=g4fa2QVRXlz8nBMdlP9GFnrf6OO0ZoqaTul5CzaVRHSq/gsUp0Wg1TrcnxqebL0l287IzPL/idXoOwSnh2zCiGhGQtI6SmnBy58s4n7JwAMw0KEtNr0gFGFHqLCN2kq2yBcBAlZ90Kdd9IT3ptjssgvLeb7QoiTHpBKG99ZvlhEq9UoPc02vEmz378vq1vG/5We4SU/rMiTArX1THmQJddMUHVcqtq4wEQirCgNu0qgx0Lj1kOL3oGunpT9X3elUZ/S0Hfj1dAFaDlvaEmDEG08D0n3rletBhRrVHumftSB0lJfHAc29LC/LZZVLGfYp426+nc7onz4FQIaCpPANGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zq8ppgizd2ejfRY8/vPm1f2xw/C11dZfCnWvGn9Z0I=;
 b=IZ+8k8lbp/UvAPRVib7hoMW6EkZ327NjoBH2xLxZkQOqHE2MEr7JsFDKy5aSetgJUafP8kM5q+abdd10E0HLmdgaxAGeOuMa+QJ/ZVPQU3ULcHSbq7Ad3Y3sIY2DBYgVV65hnNsKbEO8I1Z7bJ6xW0wrzWlk8Dhy+mMgUZcu7CClWf5QLVbf3/Ih2fkOlbNUYfNIq0XJ3cfZhJtTUS04+oDltpJRRoL9/DPs/sA4JGcbIxNRkRujFyY+pf2QRYQm0qo07BZwqjyzEfHoPt918VAO0wnm+2z5/mr7Dp0ZOSi6S1aAn0Pe5vnhA8F2AhVccAHIVnXmNXuNtIFFjDdKdw==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TY3P286MB2609.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.33; Thu, 9 Nov
 2023 04:39:05 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 04:39:04 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     linux-wireless@vger.kernel.org
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>, Kalle Valo <kvalo@kernel.org>,
        linux-kernel@vger.kernel.org, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] wifi: rt2x00: correct wrong BBP register in RxDCOC calibration
Date:   Thu,  9 Nov 2023 12:38:51 +0800
Message-ID: <TYAP286MB0315B13B89DF57B6B27BB854BCAFA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [FRpPPHR0U2TgWYIh3kY9EA0nXi5RaMls]
X-ClientProxiedBy: TYAPR01CA0013.jpnprd01.prod.outlook.com (2603:1096:404::25)
 To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231109043851.26584-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TY3P286MB2609:EE_
X-MS-Office365-Filtering-Correlation-Id: 671b7df7-7d07-4671-f7b9-08dbe0ddcd26
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDbF9c7/Cg31i4jaBKs60Bj60n4ERQnTbtkpfKmJclJOpclXMyYt3iEbL46Efyd8yi6OvPl7nqJ2JHeRzDCEmquGXpiaGdZGFAmeXtw79Fq2K6b0G6afgSomDxRhUiio/9N57yNxPYqvbXJqv7UpkgB/cWA+GcHuhkugOddxViZfJJrpfELq3uckpgutCRVNrtxIkphyy+/9kZ7LsMit0CioStFikIuAy5yn/hdqVwkNXl35GmwrXQ2jFoqPTHBDbcov2lph1S0sP6dO/TsgMQ/nbof7Q2yWGLezwMnipN2TI2yEhmbVMSIn8SOf54Yn99zuUPZcouoiI7KZtDQXHjM8fhD33lpdIVKmvzbl+pzUd/Ljn0HHuUyy6zOSGABBb/5mVF6j//nNruxB0S+wlfJUdR6ODOB6hpkdX3sddB8Ix9LwzxZsWVpQcWrXXs7/rfohHDWJ+IkmYs1U4F5HDuXZ9m1x8oZRlsRR41M2YlXEC4LERLyFxcJtw5OnpZw/Lp41iAcLoUujV9RznqUUZQxVLlxkwBa/QPkcwvAjuHrlg06u8Z40pMAJ1W7QsLb6rLMjSpuTeij/MfkbVvnjzjgAl3amW5Fdnwqq6Ygw1AiU3x0O23VKUVXJgAbQ8WPT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wBKcyhrH7arytULJ9FXWhx2dPP6XqcThbuL4DaL+2UYQ4wvZcdjox23fs9AK?=
 =?us-ascii?Q?oy6A6le1l5HWwzFUMGV04/kLxajXeN51jH3zN7yn5eGk+SyPvI4Ml+KNUeNR?=
 =?us-ascii?Q?qVxDgBX2KPXSg9aJQ0pHd9Ow+epVrsq0utg7By3z2ZA1D6G9Gh8zcJOAY7G8?=
 =?us-ascii?Q?tVYYHZaYMl9D7ShbXu34LuorheeMyjq/vN74eTuocnb96kejRbkOC30/8yi/?=
 =?us-ascii?Q?3ZmrUqmgoexaIWHUg7Wc4DV73jIvtfcJZLOkfNrOlJXZMRWJ3+JE9AtS8cml?=
 =?us-ascii?Q?3v1jVRCDL1ByrZIMQ4Ba85oMu4q6K9w+xwvHg2X/oWXgdUcbv/Kd21sSK8qN?=
 =?us-ascii?Q?+2CufHyUDnqBq4vS8sEfwSZL5NGgtKdNviCsE1ZOLyYoY4qcMRRc8DabpnLf?=
 =?us-ascii?Q?Pjz3rL/GNu9qmbvHfjVSsZ2KJTFJqviYKW4ZMrH5F7OFsvj7dk5C/v26vL3Z?=
 =?us-ascii?Q?uDd7oHiB0LsTzUkrg/kG7N+p5bwJ3vKyV9wF1zgnmfokHxWbdqGubduKA20p?=
 =?us-ascii?Q?l72Xveayl0rBT51n1Eg4m47hQ09ftZQd9q5d7OvMXfydHN1CrdoEBPvilZ6o?=
 =?us-ascii?Q?do3S+BjHL+NEfVEErMG0x73P7APtT7uoVLvlMakBEtCJ14lD/lEJTxlAPnuE?=
 =?us-ascii?Q?hZqQKFVEtoKkXhzIotVyuX6TUidCYD0IcSZRFCZqq5jrxJDFZeVbYY4sZg5O?=
 =?us-ascii?Q?2x/TMdpwgo4n4nmQxuWS+jYE1dJqgEjYNsCViouBjJVSR41v3kBOnP4aS8W8?=
 =?us-ascii?Q?GrCIXknjeJZbVHBasMqXk19kjlty7JBrzu/AhfZ8CjXzzD0IR+ou29IKRskd?=
 =?us-ascii?Q?6S6iQc9GZ0sfq7+flmGohz5poLICX9ws6zJJSIbfV9JovzrlodNhLnZzOG8h?=
 =?us-ascii?Q?1f8r/xdn8LoJ9YXKRecYasStv3mXDe0hlHi9mywoBXI5xLSIQXajkhbBz+ew?=
 =?us-ascii?Q?U7/7cjeuiVrXU+FHGjXrWp6s/ejPXheW9PngqdXDi+2IHwMwtk0Wvdco2Rzm?=
 =?us-ascii?Q?apAZvM+2eaDOUhineAlqwH0gH4gs8MjiYl+w5mrwHThCZZM9aZ56fyJbYhiU?=
 =?us-ascii?Q?dGhJXoDsW/qverzcZjeEfuMutmxeOboKpbLDxmpzP3Dn0i26f/G50YkLE5b0?=
 =?us-ascii?Q?nziUIBse8rXyNlh/AvgKc8k0vZhA9YkXZLToR/3t9uTRaT9jNHD8WT3wK3OS?=
 =?us-ascii?Q?/nfsuB0DdM8EUgT9QwU7/LDX1bhQDwqQHur3Rsufe9eNmbRAerAtqqAViCY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671b7df7-7d07-4671-f7b9-08dbe0ddcd26
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 04:39:04.9604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2609
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to Mediatek vendor driver RxDCOC_Calibration() function, when
performing gainfreeze calibration, we should write register 140
instead of 141. This fix can reduce the total calibration time from
6 seconds to 1 second.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---

Hi!

I found another small fix. Ref:
https://github.com/hanwckf/rt-n56u/blob/23387b278a7cf728748af606760758f5d59d1451/trunk/proprietary/rt_wifi/rtsoc/2.7.X.X/rt2860v2/common/cmm_rf_cal.c#L2464-L2470

This link may not be a permanent link, so it is not included in the
commit message.

Regards,
Shiji Yang


 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 7b13c176d..3a52a04d3 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -8710,7 +8710,7 @@ static void rt2800_rxdcoc_calibration(struct rt2x00_dev *rt2x00dev)
 	rt2800_rfcsr_write_bank(rt2x00dev, 5, 4, saverfb5r4);
 	rt2800_rfcsr_write_bank(rt2x00dev, 7, 4, saverfb7r4);
 
-	rt2800_bbp_write(rt2x00dev, 158, 141);
+	rt2800_bbp_write(rt2x00dev, 158, 140);
 	bbpreg = rt2800_bbp_read(rt2x00dev, 159);
 	bbpreg = bbpreg & (~0x40);
 	rt2800_bbp_write(rt2x00dev, 159, bbpreg);
-- 
2.39.2

