Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442457B7090
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbjJCSJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjJCSJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:09:33 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2079.outbound.protection.outlook.com [40.92.75.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F2DAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkO3/DNMG9vqRwiinBA8zD/0Tn4Mj3djPD4QsRyrWctdoRKEdz9LJxDpD/7fcYwBA/1qmK08rnNRGVnnrgASMoBdj2nkfl+ThXOIH8jZj0BGaCDzY3PYQD0fxWSxKPIPjgBXEMB+O5o0307hgW/ZaeCfKTfe6ah/dvYGzMHvIHfz5XdIw3JTjyhPf18et0gMGWeidIqDbZzaefqKR4+5D6szczroVONGZMySqesbDwZVKzXlsSAXMRKIdD/U+KKsUMhZ1V7+/AVp3HggFnK2quQkYfOm19BOBxFgXe0FR4nGpHRW9OrWr/qO8f0TU4MAm0m+a6olG+KBpgc5SsAkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxUiblOH1EPFha2exxQSvqCiT1JTlayJYPsTasvn97w=;
 b=cdXrHbGe52mGqr36bV5Q4AePI0wX4c6299EK3K2pPlomE8tQlQX430mo2HRWiakvXlMT4OLefPz3c6Ev9LTYE0ulhjgFXvB1FR9utkZkz+5brSQCinI9Cn2J5vNjX2wKtwVtCpiPrRQvWKEmLAA7V1PDaf+XvA2WyilurArYK66ufAUmIwR/H+7M49/vT8mEwrmYmbixFNAtoZxFMTyU+3bdCVaDP8MbP2iTiRCOL7848htmnv985Y6PaOjbyPfXUhLQLfX+F4IjKUhGsILMU97n9MfvYIkZQLh6NwoAThd8H986oANDv+Y6nBJCRrjvEGT7n8tEKOtWFO6EZjVIMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxUiblOH1EPFha2exxQSvqCiT1JTlayJYPsTasvn97w=;
 b=kUuMiZHypS96F35AcWJKkZWwESzQSYm8q4lkpLVPbIBEktfyrj9Xu4+kXqb7JESHUIK1D+ZOZfk6zAP2XYpcwqnf+P/VE5o79KZuNVnNUkUlrS0bP9txx66d+EjguRIEjhjThAj868n+H6C3002g8T0acH3lyd9y3BIkleTaSiDGdtymKK7ldBdry3Io9j3mKFo4tUuK3sRTZDBwCP7u3m+beELZuEit+fKkShJ3+plSCQd+xUCWZChBDKlDnevAPtIVBwB2mnEdJd5fOHPjFYJDoRqejCEOfwp7PFQAHJgt1B1KlWAMz/DKF2VGnOdxAJIKEl3tRoAwsLWDGaswQQ==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by DB8P193MB0582.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 18:09:28 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad%4]) with mapi id 15.20.6838.029; Tue, 3 Oct 2023
 18:09:28 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     shaggy@kernel.org, liushixin2@huawei.com, yogi.kernel@gmail.com,
        andrew.kanner@gmail.com
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+38e876a8aa44b7115c76@syzkaller.appspotmail.com
Subject: [PATCH] fs/jfs: Add validity check for db_maxag and db_agpref
Date:   Wed,  4 Oct 2023 02:06:41 +0800
Message-ID: <VI1P193MB0752B8FE593B2854914ED09F99C4A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [dkmVihAjFH6jGEh1n3t4/aoS0CCLWrmu]
X-ClientProxiedBy: AS4P195CA0009.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::17) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20231003180641.13320-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|DB8P193MB0582:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2b7f8e-f50f-4dae-0a51-08dbc43be1fb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wPCgoO3rkgJxcCUiLaf4ElMouGGdOy/wvVv3dT730Un3hQKcfXCMsjMJmCj8QVUBE0EArOWHdxg/9p76/qwK6tDJ6HUodOqqt0lWaU29tSxrZZR8E3PAJqyP3ZiKGjvvvaKjIL/NqazVF6v3ZppwL/9HEYBX6nDTD2PIShofUZfSmH0dIDImOGPdps+LkusJBwmO4riSejPuIQtoqUyQ7qxsfgBEyUGrgBwytWIF9PLhy1NKDjqvl8/0sdJAH/HOj6iKtuPMVGnZdRhXvkak9eZld50kOB0rKWQgsfBYVy8bZSy6InOp0leS9jFP/CO9Ra4k9gs8idnSQENHRR3m3c7UEk2KWz8ihK4cu2xNPGEwzeCWBSIlZiEilvvFH0PCPbYB6Y3GnV6doLERXMkfJ4YTKFU32noNJXmWB+axLbbRPs6Ikn0H8uTrlub/rl754lKJMhJndnWI/YdwwAr9oU8aC9+aHEbkhUCqiASm2c8QVyzplHNZj7HOx+/QuKV6QYHX0vm1oexDqnp1Y64dxpFDfKrC8f0VYydxa/jDJksfFU/Dv2tekjQXCn5+FgfisrG0fnRhQiZWaoVAIU7jmE3BOk+6NDXon+dHVDi17GPEC03ntm1eJdg/UE6mgku1mZhSWgWUio+4aQcPh01JRhrhJ8HqDX/Q0Tz2dXEVAWwSOgQFdvmFks7aZWBbOcaoW8VAXSHOtAIMt4jdYZIcKab1ZykvpiJwmbmgZvi/H1rrgrPAHZn9RvJbSylv8sXDzQN9WVtlE5mFCc7kia6FESAt03j0Bx86frNWs3AM0t2vqUOOoBwKWa4U/ypkLpQOMWDsR96Sjzi4RYPCcLbXOt1LMfUb3FHzB8o5yh6eg7Xa0FFtgwiZHI9XAzjTD/w4wG5zo0f49jevBZnyu4MBfJWrE5s8xXjX1d6+oDxjjv0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i7TTjtKsWQhQzEEZNe3Nt/hR/qOZ3DQKp1gAApy9UPCi6Nhy/+j4CJYB6HYo?=
 =?us-ascii?Q?1TIOrgZAI5u5t56yN0eymAU8swa0p9bFaMNcgritl7HPcRn/6OBDFEBjVZ3z?=
 =?us-ascii?Q?7kUppuFcmCGpbj1cs2M28l9Ylya0NtjB3ZjInu846JTxYbjavG+NTRnIw5rU?=
 =?us-ascii?Q?hxNN5tzswqOf/Kp6NHctUBhT+oV7LzTbsngMrm8wHt4XyqckEkkS2iMd2nQv?=
 =?us-ascii?Q?1k5vDJdUhOfxSguaTmn/gHuBSxVARjCSMvGyoKMJlKaletkAl0Fg53ymx7Zb?=
 =?us-ascii?Q?IxOul0chcehv2Bly2JevhWBfWm7z6Hpbj06EBbJQtjBf2THZWhtgnonQkCI1?=
 =?us-ascii?Q?UaBzQbO9aEZo3ZQUOn2592a9srxpRXhzzA9dtMWKCcx8x+UThJC6+/ckiwf8?=
 =?us-ascii?Q?onSv2a1gJCEvbRJFxJC9QFmpnq6EOp+/A01demQ3I9Rf3o1IxgwnqODVMOoO?=
 =?us-ascii?Q?hRgQYTTiFBqZ1tZhRsZy5JoPdNL6j7xNfogpvK+eaUzUourfQgfG7BxNLKtS?=
 =?us-ascii?Q?8AV5F4Xt4UQXZLKym6xrJkBO3ykIsiG1h+78I3/7aQKclKNX3pO8ntrtrcux?=
 =?us-ascii?Q?CeuNAc0ZGUzKXrrN9hPDnksPF/wMRlJBC4+xOIcxwWgp0wGsR/t0xxejOQiE?=
 =?us-ascii?Q?fsgFBgBrzNj7NyIIxkayFfAYXfOApyeTQ54CDPn82b07Os0qX9sDsCr0j6EB?=
 =?us-ascii?Q?nrVRp5carLcl7O2yPyJtW2ZhjrAOw3imdUyiSUekghwBVnP7S7tEJukd0Lc3?=
 =?us-ascii?Q?pL7XPwvLfYoB7Nuxi0sz+IwCm8Jt06QXl3CpX2FR1ctEYOZDE6NYMBYvYFvf?=
 =?us-ascii?Q?f+v54vIBXyXKBYQG3OaL3Pxmvzaj8LhFNccP24InsNK2O9uydN58UcAsj9A3?=
 =?us-ascii?Q?/oojjEylyo4q3zs/zXmAdd6c5FUVZ76/Rox3y/NESppEO0SEtVDjh4hEJZvL?=
 =?us-ascii?Q?bG1g1PIREsx+eQO80ctREtdIE9bwgpux1iCGs1xGH5CApivSc9B4SnWcztkp?=
 =?us-ascii?Q?WNkkCi+234UWUYpl5yX9HYBTJTr0i/AuvTK6tayFSpyFEV6Si1XViFyLDGBu?=
 =?us-ascii?Q?Cu/TnJSzs7/9ntxA6q50qorQukHxrmVWvpZuWnn74Jtifjii/SmtaK/nJuy5?=
 =?us-ascii?Q?tiM6F0F0DSlh+fLuOR7vix5oVrogy8kwHVh9zHKNZdiDh3wbFevjsQtl9lPx?=
 =?us-ascii?Q?0vZz3YkRPSRHNgWC54/ltnnM5ETQZ2xyf/PkhHLZCe9DliwGXm4RqHLme9Y?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2b7f8e-f50f-4dae-0a51-08dbc43be1fb
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 18:09:27.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0582
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both db_maxag and db_agpref are used as the index of the
db_agfree array, but there is currently no validity check for
db_maxag and db_agpref, which can lead to errors.

The following is related bug reported by Syzbot:

UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:639:20
index 7936 is out of range for type 'atomic_t[128]'

Add checking that the values of db_maxag and db_agpref are valid
indexes for the db_agfree array.

Reported-by: syzbot+38e876a8aa44b7115c76@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=38e876a8aa44b7115c76
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 fs/jfs/jfs_dmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 3a1842348112..4d59373f9e6c 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -195,6 +195,12 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
 	bmp->db_maxag = le32_to_cpu(dbmp_le->dn_maxag);
 	bmp->db_agpref = le32_to_cpu(dbmp_le->dn_agpref);
+	if (bmp->db_maxag >= MAXAG || bmp->db_maxag < 0 ||
+		bmp->db_agpref >= MAXAG || bmp->db_agpref < 0) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
+
 	bmp->db_aglevel = le32_to_cpu(dbmp_le->dn_aglevel);
 	bmp->db_agheight = le32_to_cpu(dbmp_le->dn_agheight);
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
-- 
2.39.2

