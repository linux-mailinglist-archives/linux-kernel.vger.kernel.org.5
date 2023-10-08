Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313737BCC80
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 08:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbjJHGEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 02:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344363AbjJHGEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 02:04:08 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2077.outbound.protection.outlook.com [40.92.58.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB47CA;
        Sat,  7 Oct 2023 23:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHhDJeLhnuEUsoJrWqmOSgMtr79M5mxJrJ7sNXfAOIc/25BAyfNLBy7OMb3XPhAbczIry5VeuWUyHSuFlPB5UA18xdnehGTEM/NC2y3VJIcppf5oAxyCaMThvynLYIA4KhmtHhdzjcPZsnumuhqPgUue0Mk2zDrBfNoFtF+MhMbm/qUURiJEudikz40WXTlAuB40A531T3RzjXUuXG53plCtH8D3nrz3BVRYWdcdKWV+UhONsgWQqNCHAljPUq2A9nlRbl9rDyWexuqPu/IMQqhnJ3HrbH2G4W+PJfmB9OYxtr97SdZOyj1cDkfsRwLJestT9x49OfrdEVpuI4V0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgVBxI1/YNT9NAbgqKbqUigJ5vE3g4F65UpsVNuyk5Q=;
 b=BtNnzjNf4990/8YBPPMaw/vMXUUREgrD7hUnTNttW2zMdhGmswn+OKR7kW4fEjXxeTS1pjwoReeNdl5bhAXQk/BD1yEobGVKW/6SXEaOdIc32li6W7dUtdmqCif+p6E3jmpktk6qynhcrajAtft+ul1t7yjn1wnLxK0UsxNDp6y3zgzG6AZsa3zXRC9/ccXPUyqNVE0kBtYiqiEAPqN45A2LjYQPAYQBoxQjvycbozcZ+ifkk48CxA4qpeX3raXC8i8NK2nFXXcdonKPiT0VM+AigVGP8c/Bg0wMtHw/MlIHszbaj6LrnK8NFtsl/iGAPIxrJDcz1DPSpv1nXmdOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgVBxI1/YNT9NAbgqKbqUigJ5vE3g4F65UpsVNuyk5Q=;
 b=ANoDQQswfOvaiuTWNmLSy6amcwvOBucHac8c99ssNbvXM0F29j4nzsnvReAtvFGUMj+iWiUluzKuDl61vTJXvl5Uynz7Tdmx6hKYIOfOWfloB653gm7C9TVPhCPYjtbg1Z6FdL/MNvCIGuWppNGoMkHggjjvP7VGrEq7+x6WYR23sGslPvJ/UQm3ZLj0IZ5iwSImxJs5aoMu10Tj7638TDDci5RSWblDIr4hYViM9eLltxjthlxW+d9t4Cq45PT1Bi4dqbjyQwZantoyIoDK8Kziyin/V3fZLq0fDbDUkpfZnfzQFenTGcWVkmgh+h92guApdCDdV91kDsN7JJFv/g==
Received: from AM9P192MB1267.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a7::7)
 by DU0P192MB1572.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Sun, 8 Oct
 2023 06:04:03 +0000
Received: from AM9P192MB1267.EURP192.PROD.OUTLOOK.COM
 ([fe80::628d:d050:3672:a203]) by AM9P192MB1267.EURP192.PROD.OUTLOOK.COM
 ([fe80::628d:d050:3672:a203%7]) with mapi id 15.20.6838.040; Sun, 8 Oct 2023
 06:04:03 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     marcel@holtmann.org
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, johan.hedberg@gmail.com,
        gregkh@linuxfoundation.org, luiz.dentz@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: hci_conn_failed: Fix memory leak
Date:   Sun,  8 Oct 2023 11:33:34 +0530
Message-ID: <AM9P192MB1267F1B8CA16CEEF884C9F2CE8CFA@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [SeoYbVoeAl1Yibf1a1pEQrOeV/C+OuBo]
X-ClientProxiedBy: JNAP275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::15)
 To AM9P192MB1267.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a7::7)
X-Microsoft-Original-Message-ID: <20231008060334.24497-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB1267:EE_|DU0P192MB1572:EE_
X-MS-Office365-Filtering-Correlation-Id: 442700bc-53ff-4c1d-e475-08dbc7c45e9c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3U/0gC+jH3mTpv0DWyuHCxN+Yo0w1Ab1O7CFIySJI16JfD+skWx2w07ioyRk96knDX0YNoba7dkVkRghwf7nHABV1BO5J6H1vNEXwr8nH3dsFKVk9d1jk+wd644ZM/0oSx90XmSFaR/TrLxZWMK0hBUCV5YR9+5/6b5wCQdYv1cNOigtVSKMaPKnwcp30rFLNmASiyivEgjLI4kncJ6ErPKInLkiNRYl/sw29AThm6YryDaAvjjnObtpi6EFZ1YW1RNMfZ0YYa0sekE3Ywcm2GYYelssSqBojalTfzbZ259XbGSxXTfpu5AW9u114Xeibo1APqC/JXF9P2K5AYJCW2ImDB0SrAiOXTt+lCoW2AgC73cW7tw7hXkeG2HKHsRE4D0zDR7fvTv5O3w26esGIks+Md1AComxxI3LprSNpng6rGOuq0JM0hZ/RWwkUiAURi69gIQIiC4DNoHtfMGvi1V+gIsXm89tn2yldZxEhwGiTOkhOiKcHUN8IhPeJTRyZqHJZ7xIRx2Qd7855AVP0gkw+DYD9o9ahlq7Bnq42A1rQ6GbYlcD35zLhstoVUeXIYNMPZuQpiRhzUyVluLSg6Oz2PXZFfz2YWj2JalY3DqDzeg54K6ExLAv+bHAmpK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T2mF8Zm3enWKy4t5D2pGaNhpH4iyd2ahdqnPpapnQ9lqF3SJKh6rER0tqz2+?=
 =?us-ascii?Q?qBcQ8TF328xEiamWZ+qVBxFKF2e7iRGzaJ57lUvKJ6dYvKDN5KKu5SxC+ykZ?=
 =?us-ascii?Q?wtpI7lkXwCtuPukVz4WigVkqZ+lIz9+txqlvSLLq+y9UHuOkfGnr5FYo4Cyc?=
 =?us-ascii?Q?j59Zn+l3vZdKZgZdGVtIJlviUpDGs3O5+lLtTuLaqDPx+tJy7LzrsfHRnr0p?=
 =?us-ascii?Q?W/vP3kTxteThw5amTuQk08XJM7aFUlaQsxqiL3xpGVgJWkekDA8Yvd9/zEVW?=
 =?us-ascii?Q?SjKT8B4Yv5CrtKR54bGLjkBPYdplKhiFUxW3qC1Hy9qKcADEQ8sQmJ3tA9M8?=
 =?us-ascii?Q?Qjf746C9TVW5xF9enTIFlbiPbZr65v3cSV/uxCqWAaeYD3R6dE5vlhY6gnLs?=
 =?us-ascii?Q?1kCR9wRIJNJ34VCGOcNUezwNQNkmvirBmn43aE24tkcOYWLnqgfA5wQI9uPl?=
 =?us-ascii?Q?mOk7+CpbV3bhBIAzL0ksRa0gloIsRry6WCYHT9G2GjT2esIppbhzckv5VkYJ?=
 =?us-ascii?Q?3NUPpES6Zchx/KW08HFmBFa6+zXeoVjiGkW0ZJBY6z3xWt94U63ueU/+K0ys?=
 =?us-ascii?Q?/jyi/IhfLa+xAphxI9DBLlQY0emVKpz1H7WIdwLgF9Cz/r2dyCHQas/qYdk4?=
 =?us-ascii?Q?ep68D7RuUfaG+wYt2o/sN5IHvetnIi4CAfV/wH5DWSrfohBIRVWsxGFrLsOR?=
 =?us-ascii?Q?4LCenIT0o/9Gv2NJkDHDftCyvaqeNsa8NcuWimXYH0fbQxMMx+GfqKfUuFUK?=
 =?us-ascii?Q?vL/iydXe068w1OzIOUmBhk/H4eS/ZQ98V4oP03iSko2TB1Lwp1cxAkOzggiS?=
 =?us-ascii?Q?MN3TR6Tg9SdZGRJF/37XHWl/wSnbX94qJMKWfTrwdJIuEts0Z11FXbKQQpt9?=
 =?us-ascii?Q?/g1o4YdaiEfpltjQCX2JoXshC05pAXAdm59RsEbqapNq1OQh+pqLt2nCPb5N?=
 =?us-ascii?Q?xzjclBkr3ZQoYjUeqsHgK0hYvmog4WNQe6BdfVAaC7KpBdX+WE4AEEfzOdpp?=
 =?us-ascii?Q?wNf+5I2kwB8YD+vxJfqSSsdtLVjiA8PRPjlvgbGhFcb+2O38Mc89KVsaKBWQ?=
 =?us-ascii?Q?jnGesb3dn/nBWVzRRqt3uCcg6hSheMauMDy1S/A/59dyjSzRW70+pxitxxB6?=
 =?us-ascii?Q?Tqm6o9kvnFgLd5VJPtrAyeZlFQBp4VuiAV8pUg6t6/vqsG6+5d0Dh4ZCGNCF?=
 =?us-ascii?Q?+gyp1hLY4H9lve5bVRwcF5Havbe1I1QqQk8EESxi9Vx36LZGeAQlU8HXWls?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-fb43a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 442700bc-53ff-4c1d-e475-08dbc7c45e9c
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1267.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 06:04:02.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1572
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hci_conn_failed() function currently calls hci_connect_cfm(), which
indirectly leads to the allocation of an l2cap_conn struct in 
l2cap_conn_add().
This operation results in a memory leak, as the l2cap_conn structure
becomes unreferenced.

To address this issue and prevent the memory leak, this patch modifies
hci_conn_failed() to replace the call to hci_connect_cfm() with a
call to hci_disconn_cfm().

Fixes: 9b3628d79b46 ("Bluetooth: hci_sync: Cleanup hci_conn if it cannot be aborted")
Reported-by: syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=39ec16ff6cc18b1d066d
Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7a6f20338db8..1d2d03b4a98a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1248,7 +1248,7 @@ void hci_conn_failed(struct hci_conn *conn, u8 status)
 	}
 
 	conn->state = BT_CLOSED;
-	hci_connect_cfm(conn, status);
+	hci_disconn_cfm(conn, status);
 	hci_conn_del(conn);
 }
 
-- 
2.25.1

