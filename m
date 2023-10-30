Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF57DB62A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjJ3Jbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjJ3Jbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:31:42 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08233E4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/MjROvXDYWY0sHA5+WoMFzUPLBd113/J+WqfSlR9hVyY8QTh9wbgjejCS3RadhwWhqYPRmAhusExHQI54Mu8uI3CmL3nvOp/Z4lgwZnu5pJ91u/uaLSksVgVr0RjwVIiZktis7BDPGVSis68WSnyrleYk9fQSuS+lu23raJHOaeG0mi2qBEdM4xHZeduMXSrufbo0UHb/uXXt54uiwTCeycEUwg2yKZkwmXRWG2YzlDIXpzaCN35NLhQ7v39DHIvsFDi1DeS7Dk/AcOVWWJxhf7/C5uKaArbkE9XzMSP9EF+J7sOfXRGLEIHvD5dDrSmFTq4cLLzIiRan1+RMUC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7uk1RCPPo/3pbIIh8SopvIQC8rZot3Mf9cz0qhbwQw=;
 b=Sqiwnyyz66nQrVZWFGjngi9kvCaIt0ZH29ZxJ6DHkHTJlFz2zjCExX3CtLgMNNGgd4oH6PfjgyXEDaxrQXhdmvh/wo4k9B2xfjECS4/IFuszzbDSmaQ5OyUvx1V697NhCAcFectUIftW3ZWN4DUEATEnb7G1djD0pq9FrHCneNR4weu7fYIeho4gpIw7C8pcDEcQxY5YUOBRMb+fHXiPFivnDOP7Ccp6R8/jdQNhUYYG0Oh2Io0j6aBaZt61y0BxeK2JLYSWRwgyqc0B+iij17uxWsSL/LIIPfvoEooubzqknYG2zL1M0aVqOmGjdsyQ5qPCSwO/lWtH3NgtUDu/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7uk1RCPPo/3pbIIh8SopvIQC8rZot3Mf9cz0qhbwQw=;
 b=DmJ6cjaqKNprBzTYmbT2IBc50Er+aHnnjdCaeSVzWDOxhCwQPsFA9sPKx8dsLyot+fZmYK1WerV3DohCgBWhgpy59GsvN11hc6BNmmiK977ZPyK45tY1tm9Xjbgnm59eM2S0KY+6apPcQC2SJ1x7gCfIZRZPDscREm56BHxrpUSZ7gQGLC8/waYdrmO9Vj2nOqceUsGizk6cK25V5UH9gP5B28xtXHBbK69i2+cZX1btbf4E8SiFOWVIacFlDoutk2fuYcYCZBcb1Dxmuz5gH86FxU5Qgwg4Cz9r49r/9afqRZwv2x3daNW/84YnkdQkBkO/SJiFsoewrEYl/DEIHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS2PR06MB3509.apcprd06.prod.outlook.com (2603:1096:300:67::17)
 by TYZPR06MB5027.apcprd06.prod.outlook.com (2603:1096:400:1c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 09:31:34 +0000
Received: from PS2PR06MB3509.apcprd06.prod.outlook.com
 ([fe80::df44:25be:44fc:9201]) by PS2PR06MB3509.apcprd06.prod.outlook.com
 ([fe80::df44:25be:44fc:9201%4]) with mapi id 15.20.6933.026; Mon, 30 Oct 2023
 09:31:32 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Wu Bo <wubo.oduw@gmail.com>,
        Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 1/1] f2fs: fix fallocate failed under pinned block situation
Date:   Mon, 30 Oct 2023 03:40:24 -0600
Message-Id: <20231030094024.263707-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To PS2PR06MB3509.apcprd06.prod.outlook.com
 (2603:1096:300:67::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS2PR06MB3509:EE_|TYZPR06MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f6bb30-8c2d-4cea-3e54-08dbd92b0079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkwgGjtSaW7xponbgyvVByZ+zY8WLtjog1f/ke7HkZI/2J/sIwDcf28Ohhza8xR4oYOxinXNK5a4GZm1QvSXVtpN9TCE21RYzp7V27lkLuy3g6sdi4ksbLJmlvATvolkWIadGuib7SeJQWJyV+wzL2ajKD/G8gRMtPju+hpd6S/aPjulK+ctVVH8HdqdEZg02ne7kAD7g6pPQP1LybbFNv7OiGyhJ2xz9Sa8BK9fPadZLwkS4/tRlKIG61IfLAKaGQ2oNvtci3igoAZKG1FSmAoSAG6EUVR7Vd0oltg1aHnkeWoybffDmqjk49QXcYq+Q7zwZQJMYWaDbxslej2vHd/OLBEYcEOe1pRnAZ8NuValcMSyBFu3LzaEQB5TCx1QDf+764cfPjZ6dZuaUDVaCAKw6pTYINbyTcMg9RnHdXSrR0Ccp4pYTyDOGQ/H4taInR27CScnyVKbRkFYEE0sa3DvefrBq/yZYo5nn2E04FiOotwtYHeAuVjEuQ1aSi0FUlVMh23b1Bk5mbMGgB9wYB2upMGyK84fGjeA89pKgtLgyX/IwaKqcM8eiyjj+kfByP8+TBhjcNVMbFGQhcGPfy5pB4n4Mu5NeEPq2YplK9pVcb8Nhy6JTmVJtLSQfNkP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR06MB3509.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(346002)(376002)(136003)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(66476007)(54906003)(6666004)(66556008)(66946007)(316002)(38100700002)(107886003)(6506007)(52116002)(6512007)(6486002)(478600001)(110136005)(83380400001)(2616005)(1076003)(26005)(41300700001)(5660300002)(8936002)(38350700005)(8676002)(4326008)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nVIVsahreQeaVIkNr4fZgh8AKlDkZ0F+fw/8SthVHMvijPqXrNEgT7aFCo0Yym+PShFYdiWrYXxD2OxLfapfbHn036qARKruQqFx21quMW2qRL83iPm4HfDq0M3L3aO4YkC3rjMMRBQccdzJAA9RJN+ot8DkobrXzOgz6h46p59y+dkTTg54oXZgoQv5CXYKyh0d9p4rVxIjemwOvwehZYxB0qos+ws/0RbUOt/meBmXHr9Q0FVjpB8sOs2KxUPHfJzLCTubJ93GSakuAVHUbkkJOpNxwetLiklIQT5RdOVpdRZ+ntGDfNFJWhtMOlRp9NrJ/xdP7sHvK+m5briOufZjaA/e2P9B3C4AVUadYhAiW6CmHM1dV64u2xSjfCVv0Xz565iZpXJP1L8J6bbfdU9II8xdr++ECkF29oP1zhE=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f6bb30-8c2d-4cea-3e54-08dbd92b0079
X-MS-Exchange-CrossTenant-AuthSource: PS2PR06MB3509.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 09:31:32.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxnCYBQPDp8ZgV4N1fcIDDDQu7eg2kaT4zG+eJ6OAoudVNoDy+PLvTwWmcYzp828tbpnzzj/a6vCuNtB5vs7sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If GC victim has pinned block, it can't be recycled.
And if GC is foreground running, after many failure try, the pinned file
is expected to be clear pin flag. To enable the section be recycled.

But when fallocate trigger FG_GC, GC can never recycle the pinned
section. Because GC will go to stop before the failure try meet the threshold:
	if (has_enough_free_secs(sbi, sec_freed, 0)) {
		if (!gc_control->no_bg_gc &&
		    total_sec_freed < gc_control->nr_free_secs)
			goto go_gc_more;
		goto stop;
	}

So when fallocate trigger FG_GC, at least recycle one.

This issue can be reproduced by filling f2fs space as following layout.
Every segment has one block is pinned:
+-+-+-+-+-+-+-----+-+
| | |p| | | | ... | | seg_n
+-+-+-+-+-+-+-----+-+
+-+-+-+-+-+-+-----+-+
| | |p| | | | ... | | seg_n+1
+-+-+-+-+-+-+-----+-+
...
+-+-+-+-+-+-+-----+-+
| | |p| | | | ... | | seg_n+k
+-+-+-+-+-+-+-----+-+

And following are steps to reproduce this issue:
dd if=/dev/zero of=./f2fs_pin.img bs=2M count=1024
mkfs.f2fs f2fs_pin.img
mkdir f2fs
mount f2fs_pin.img ./f2fs
cd f2fs
dd if=/dev/zero of=./large_padding bs=1M count=1760
./pin_filling.sh
rm padding*
sync
touch fallocate_40m
f2fs_io pinfile set fallocate_40m
fallocate -l 41943040 fallocate_40m

fallocate always fail with EAGAIN even there has enough free space.

'pin_filling.sh' is:
count=1
while :
do
    # filling the seg space
    for i in {1..511}:
    do
        name=padding_$count-$i
        echo write $name
        dd if=/dev/zero of=./$name bs=4K count=1 > /dev/null 2>&1
        if [ $? -ne 0 ]; then
                exit 0
        fi
    done
    sync

    # pin one block in a segment
    name=pin_file$count
    dd if=/dev/zero of=./$name bs=4K count=1 > /dev/null 2>&1
    sync
    f2fs_io pinfile set $name
    count=$(($count + 1))
done

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ca5904129b16..e8a13616543f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1690,7 +1690,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 			.init_gc_type = FG_GC,
 			.should_migrate_blocks = false,
 			.err_gc_skipped = true,
-			.nr_free_secs = 0 };
+			.nr_free_secs = 1 };
 	pgoff_t pg_start, pg_end;
 	loff_t new_size;
 	loff_t off_end;
-- 
2.35.3

