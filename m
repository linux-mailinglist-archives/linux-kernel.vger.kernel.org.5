Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB8E7E2FC5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjKFWWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjKFWWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:22:14 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2092.outbound.protection.outlook.com [40.92.90.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D214ED57;
        Mon,  6 Nov 2023 14:22:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQwQen2eWBXacKp2g9IS6sLAtePUl34sFuXyQkGzESejwDQwbILrflCXjoQ2e6y5HmaGl21PAVQg280oLexewbA+qowYQKuzNr8y5xutW3ZOvbXR5x5ZssMiWTh1NdehH5c6mS8D3uiKnGc9WlEU4VPZ779sfu0UbbzhMik/UK6p+HGHsUTrJmRkrRTtBBRVdKMZ+4pa0Ppipx69WMeeEkoEm81XNtBnWckHaOOwwhv+jeJwBggK1GQLcrTD9FfThIcPa3/AEU7UPAc5+SefECrutPp+6utE93/Me2ZX14nYqxUiyrWSxeYEchz2gz03LFF6Aim3e106loQFVnY2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYgAhFYQrRNovxRm5bsWSiueE9LZzAsAZj+6d0TdFp8=;
 b=csDwMw8Q5QpKI82LXofFoC0CchNwm9cvr4K3H5pQR8W1Ph726IDPT0VRwUov5QXDAco/kzve8i0VhDuUYiqplEA6XpZBJZFLJNbcF00JQRAJMQfYRa1ceWRZhPTuq7TN4wUpKw7LRjlSeMW7Z389hVEWSypO7Ao2omDl7zXFqKJij4Q054xJZ/4mKAdBN+bmWoa4siHngjbxeA75Tu4FuurXODOL0RSQRuyy78KzvklRbimvG2LmqMGbzrU1JCLe8D4f4leTFBMaEYZVK3RZR6KdNRv5wagFRIi1nA6MtKns2NeF3AqH+t2WxFKMhpCKv/doXo/jVtNIaUIS7rY5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYgAhFYQrRNovxRm5bsWSiueE9LZzAsAZj+6d0TdFp8=;
 b=t/k/8aZ0GwkJ+Uc+mwOmas7L7GSDd8A7DXKMTepTc7SxQhRK7iPjnDJgzY0HXr/fAa7sjC8oA9+zjg9uG955sbmc/2EcV4wYPuAAkuhD/yP5xXWB4UN5skPTh95rzNZJ/jppeTD2B/KLZ57CUAKk115fSsHWD8jOVRYKUwncpdl+rm8pMCZWU1xyqnPL6rAexAaZGlpOA/eB1OfxdbYriojor93Bpn0RxM8F9EYC4ezBYtGUr4ucshSSAzWHAeoa5LNDzL0WRaxa+jOAS6emIpnx+MLU3BZukbDf0+0/QEHarevoBVmJv5/lQPZriWs4CUVhxEqzk+9P5QUUR/P/mQ==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 22:22:09 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 22:22:09 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 0/2] Bluetooth: Add documentation and replace printk calls
Date:   Tue,  7 Nov 2023 03:51:47 +0530
Message-ID: <DB3PR10MB6835C002EB4C5A05AD17610BE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [MAvBBO600D5xPui3UmRVquZ0wutlUJDq]
X-ClientProxiedBy: JN2P275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::30)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231106222147.1793535-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|AS8PR10MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: f8194ab6-2933-4c55-32e5-08dbdf16d0df
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwRtveDDQb1w6KYZ45UYKRks5m5R3vJFWo3uFRR1n+wEZG5im/1GG3B3dZyXxV8/k5sCTJbUQzqvvLVuZURJHfxZPZQI4eoRB94oLmDeyydPfWoXcvSzcP7YveFgPIWzuJ9OCt8Dd66KdBLkBScuhOvfnQoBnsxB/j6KBr+QoUQH2+17Y41E+QBpXPhhyZjd8WMA45IH5J23TtCwEs/yQnR6eFZhq8AvB7GrFZjiTZm7m4ly12PTHYLp87uuNCPK9XwsLmGZrbIWef10lsJiH7cZKR/MOVzjcWb1Eycdbww42W0HRGoUaz2n/tFNbPXfuZvbDykNPv6NKUXQe1PVW6Nr7vdPQ+1ouDCZLdx25FesLpaR+D4eMZVRlvPpL4s4VnAheXr2Mcjq0Saw8UAHj8fRitf+BcbjA2jPiiEBuC5wkdCHkzZ6VydyuDs7L51j5KRwcmNi6GoCWUJpGjS3WEkhOS50K7m1jaMBWwgdqRe57HTqVx0igdkfringCA/+YAs5EHZ0b4q72L31JRuyuzzYTS6iXSDR4mgUk69fpwcGJyRQuh9/psfWGhKfzC2et/9OR3o/+9bQ6tbB8mWbGkFKH3rOlpQNkBqC0WKKQAo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mW2HlB7/N3Ly1f3Hs4K+t4tA+VjMa5P76Sz6xGLFRQdsNHlQKaVF9Mkv/psW?=
 =?us-ascii?Q?mJ1K+jLntYjv+GewSgU7upqJvYxQq/NzThaNPTCwmiiHCEJ3N4wBgIARdawV?=
 =?us-ascii?Q?FpPZ1I2oU9mdCk3vUA+Ysk3zkq6FoyDb1zJ8RpdiNZ3M7J/9ujOwTSR1G9ac?=
 =?us-ascii?Q?TOovAb8PJhAyrekUvlB327hCcbPb6CAJjZmGkE3WWXBF/mYPVEEV7F+OJQZD?=
 =?us-ascii?Q?77uNBY4jEDpXythwNKWFwSZWS1JxBsk0GSW8U3aDQ15H9bR1qUhuyP8eFSXd?=
 =?us-ascii?Q?uE7FfGtIrS/BTsCZp+Q5zleKpDnL/Qxgm1lCUwgUAR77U74Y25CLpDLFlWy/?=
 =?us-ascii?Q?d1IsZAJMFYDmLCv0gJIr6z1ybL64nC7A/lGtfOj57oi+40SmtbqzVxb9l2zs?=
 =?us-ascii?Q?C2ylhs1PkDfcS7gbTfbUD/7+ES/RjFDb5NugfPzkpo1mmGb2Jc++RA9RitAg?=
 =?us-ascii?Q?ktIwUXFlsZkQFBvAAQiv6NK63bxxLYKPrR1WUmRMZ0ouqcxCuWB6qTqaMD5K?=
 =?us-ascii?Q?p61iMh6+uCm/R6pj6bPcof9DMGvfZJWz6u0QeBJHOWvtX/YcyojWj8TPRG9E?=
 =?us-ascii?Q?i7bSFfZS8vR4kGBOk6B1o4odRmVvpjweAh26/5RmiJUVYazf24mgzGOQh+CW?=
 =?us-ascii?Q?vdKdImpBdKOWXhgZTRLeLXWwzW5Yg/5bXsoS3X7bMDOks4UUh8JnkUPQwpiI?=
 =?us-ascii?Q?ZK36wgEkolEEzGUTWhu6SUnSrDAMoShGGaWKJz2/UC66SDyxq6WL9MXdFqR/?=
 =?us-ascii?Q?geLzvkWq++sEtE+jYKfEJNeTWpw8wfzj+229+LH+ymfi4zHrnDFDDaRtR/pz?=
 =?us-ascii?Q?eqqU4Fx+FKMVtdvIAGYRhnt2HMm/3JJNpxm7pqPaoCBTUW9g+MWaG/ZYstAZ?=
 =?us-ascii?Q?vgXTabY2rVbfLuJFPxxAwJXdTKhI4SgD69OvGTbulkOAHnjQYGesqN1tiNlR?=
 =?us-ascii?Q?uvUIE4IcU5B1ho/c1wZfrjurbLsCP5am2jcyhM3Ox0TwN0Lr8uiy4dp5h5xw?=
 =?us-ascii?Q?jpJKQl9HbLQvfhWIbHImpOirVQGKn2+l2M7gJi4JXcw+VL4zrMzpNWclUkIh?=
 =?us-ascii?Q?3ldAwoaehx5gSRV9J6r4gwHm7FSol+2V2H9E8Nk4afi4X773aj/cHtlbRB18?=
 =?us-ascii?Q?dx3QkDXJuuvQ6YJellmNXMOD6+WH1ZBwHRpSmKfE/bN1colfjrWpvsSauuM2?=
 =?us-ascii?Q?xrt191JlAmLTLiu4az7J6CbrKp5Xwi520/W1gnx0H+Bk7BbrFofvsnH3yqI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f8194ab6-2933-4c55-32e5-08dbdf16d0df
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 22:22:09.5928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6993
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset adds documentation to exported functions in
`net/bluetooth/lib.c` and ensures that `bt_*` logging functions are
calling the correct pr_* function as opposed to `printk(KERN_*`.

Yuran Pereira (2):
  Bluetooth: Add documentation to exported functions in lib
  Bluetooth: Replaces printk with pr_debug in bt_dbg

 net/bluetooth/lib.c | 71 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 4 deletions(-)

-- 
2.25.1

