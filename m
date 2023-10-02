Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418287B4FBD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbjJBJ6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbjJBJ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:58:41 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2032.outbound.protection.outlook.com [40.92.74.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89F710EA
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBCcX4VR8+SBZWf7f21VhY3vnOWqU/FrNl06eMMc2HLnTe5lCTind5HmA6ISDsSG+f+gv24L/53iGxdG0tjaFFn3/IGy3IBm1/fHcu4RcsGYj1+P4IUmiD+isszUKz92uw7OFHuw88OkgTXkA92g02p39RO75lOVwwC/AtBtp8H0FHrd6pRhEpsaoPD9WWELfIEjJ4/n4L4KowGRpn3uVOsbX+05lp7iYilUEYqwJpypqrvwHYCfY6GKqA2CQ9Yk7x/W4GYpQosTtHWZofD45o1i6jEjH7xolhDThAV6ueRgxyxHACgN7bir1Gs4vahz2Rjd6s5DiU6Oau2gJtHPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qySDZNJMAbmrPP78JX+ABd9cy2/MeElgNTUkIFyxme8=;
 b=DNsFYkwMlUknnafvI+QKsxc4j0FD2oDjkGW0NfZSCVzRmmdO/BG1QAuPLbpuoA8g/d51wBSG24hrxFdmk8Gct9d/LygA/jLZkoE5r/03xRgysXy6aVQb3+bZimSduP8WBPBBaDWE2Ikwe15v+pMfFxXcZqLE3ddPjI2iYnyQiihDYdVUVjZYJhgA6sUSwmSXE5OIllmv1rP7tOK3n2tkyMBgqCutyIL60eIHEtLxeRJ8yAOgFd8ShJ55RQzPUsoTzLtHhqcexIh8Rl0jin1kDZDXe5F7KRPCa4VrQdBpOfWq4sj2eDnJvoj/meOawECrMN5yItpQKbMX/Z5nhMgQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qySDZNJMAbmrPP78JX+ABd9cy2/MeElgNTUkIFyxme8=;
 b=W9OplMX5L65wE8tqG5cKbeEBj/jpxlhQidG909Syx9kC/DJvgcNSckACRgZwJc/P/kgrLBKaICFYN6uHZyXpRE03Fb/cQG4MxdNMbS0BmgnkAjzUdQ4HRZvEw+CAOfMe7Leb8H+4qpjZ7jFApHr0nOF+7Mrc7UXLi3BJP/XGo8UZU/PVMSmJUbSYVZ5qNU9nBDm1vLw1mA2x8IG8e8GabqSyA/q6h1+tQp0G/hTL92bYKD9e0WkyFiZ7rAa5rDpaP1bOlbENFuQ45RTVCS8lEpJSaKohhSNLSrUD3nMXTMBUZO9A6zpuXwW+zgv64WoYssmbCj/81VRLZH8Qs7iLgQ==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by DU2P193MB2081.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 09:58:14 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad%4]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 09:58:14 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     shaggy@kernel.org, wonguk.lee1023@gmail.com, liushixin2@huawei.com,
        andrew.kanner@gmail.com, wuhoipok@gmail.com
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+debee9ab7ae2b34b0307@syzkaller.appspotmail.com
Subject: [PATCH v2] fs/jfs: Add check for negative db_l2nbperpage
Date:   Mon,  2 Oct 2023 17:56:58 +0800
Message-ID: <VI1P193MB0752E63048A98BC70E4CFA9E99C5A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [dt02rW2Q/RWGnnGepOIhGCOYGVpZZX81]
X-ClientProxiedBy: AM0PR06CA0093.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::34) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20231002095658.512407-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|DU2P193MB2081:EE_
X-MS-Office365-Filtering-Correlation-Id: 31dd9f7c-a645-4264-099c-08dbc32e1822
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z07Hcovb/1JwccgnDtzvfQ0uonZLUJ05pHEwd9xKUyhJIdGCe76eRlcvB95hdfOG2LOGUKZEzj8YVPKeC6/YoJMpOANW+mRROh8llXGNDTijcBBhDZTxal8o0kcOpShPNgaGOj+DQWrdDWCiiNjmygvt86ewn2tsW/Gq7vSJfr+FwhSw9XytDxAHnKbD+NqeEkxLxNGUm5UUiOyH6gOjSJToibCdq1EWAeO5OzUP0kIDYlIDkA4CITGzoH6cmLmVtvyjP4gK7nPIvDdOOeUTMvR2KTDOkWIHve3FpiqvpTa6vzGHsFpZ8BJ9Eb6VCH4FSx9AtrwI+JAFiHZ2QR19coXJtMDvyJNma6SDomWPZ4Zo0ctNoSoxAT4/ocTgcyt1Pgra5XJrC30M3jBDePzpG74NgpLe5AYsPR6axNr8d1Y+QnYnwG3QNM+qQGM/lrk8+vAYxSm/bYbfdcstrLhGV63BUSxbXmmbOjWMM3n7ayQIUIN1OsdDtuimNtDFlgOqgJ+y13LLov03FIpajCYj70090TOfszdEwSAa5yHclMT9tA4k7QUzZc6aGaCXyjHq4jfm1o+R8+plt4tNf+86r0w39Uvb37krEEzNgq3S/k0UhkBnqdaMW+qkELdwv0BJrwG6H0pCdYO1mFwlYTZ5wgDlJlioANeM8FiGrIxK+x5T9BRJflml7WgANByFE151oYMm2k0f8pa0H21KFKl5TUycd/3TezZSFVHpKmZlp3NpRmUNqfX/f4xsPdVam0AAmasTIlsF0IxmLw+cId3IPlP3AZBM/LRkHWsZX8ee1bqLVVRYjjzVF6z52vP4XWVdYHP9/7DWlJMOGAJLpSFnnlFfAlS9ZNObGvyJmHZGitCcaaZq9mH+Kc35ZrwjPWE1AKBUoWL0+JCPUpXVi3AI+KXZr4VFD2P7tM0Uto+LsYA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bP30tcWoc2pxLeS5qxKXggoitAtHVTrMP9NAQn3jboA/cmhfMNLALr5ulsrO?=
 =?us-ascii?Q?UdnWTcMAZ19A94Naxo95rUGvgnkpN8J0S8fGKyFft7/Aa9mNq6JFVkLQzH1r?=
 =?us-ascii?Q?vN9kWiQJRyZTkOEY3rpP8MKQOz02SZWPreYir7MuWOjSqSTI39EaEttmMAT5?=
 =?us-ascii?Q?pYrmVEUZBmkAVDA9E7dG2Td39GJAkx6hSs3CvNWANLnjt8i9hQTg1bv23a03?=
 =?us-ascii?Q?OgT5XAziM8l5y4jkgHQX8n9/icV89xCQlPPV8yFanTtupQ3Z02sWSor57vhA?=
 =?us-ascii?Q?ypnVFf6/fpEbSDIa1KOJc6wAXcPhOLyWhveX+wHEeODDsNSwgA23dcSE/EB4?=
 =?us-ascii?Q?ijHvPHuxrUMxcYI99X6SwI4TTcl1BYYbcv9ziNb1f/yJJBeGGZdji6al7HuA?=
 =?us-ascii?Q?PFsm4wANumEanOG7jqA0dFv9H1xROyZEDe/9S6b1Cpv1MGgnX/xhj9OaZLP7?=
 =?us-ascii?Q?BBE4VxZjLz8QeaVwG90OsdB7IrqbpToas2VwZpA+m4PnWXT4RrqvjmCC16Ji?=
 =?us-ascii?Q?2fdtW3hzFcwC1/pE2KGz3ATxDOJW79k0jxdGXjMoLQCjlVag/u26JQSATOHV?=
 =?us-ascii?Q?C4g5FdibKArceu61MQZClJ78dSQTiXvLOBBkJL7gHqn+1czARyrMSWy5/Hen?=
 =?us-ascii?Q?NcldOvEhuoyEolxyZVtUjMycvbpdtp8zRABUXNDZclMzhe1K+5WW2YJJgmY5?=
 =?us-ascii?Q?IQWUTvVkmO4qME/MMPZ658LZExoqxjKE18mSM+MIAlWqIidCCXg8X247Cc46?=
 =?us-ascii?Q?ccJ6hGQ3GkDcLNP+oSBZqNBKKVC6tfOMpEJmRzcZfrYbcusZRjcfEDHzN8Ho?=
 =?us-ascii?Q?5JwA/6Zadhp7IYPw0DK+msvzyTNkFz1s8UxI0X8LjkOhi8ijyEEJLluk+7ka?=
 =?us-ascii?Q?nCRFWBzW/weVvoDVam8/58C7XXSdXvZq0oCxnmh8ir8+X1C4KsuyiLEheZYS?=
 =?us-ascii?Q?1N4ZyUuhF+YVnf+8Fyf0A/iap2hSCCh0SorujRvtmxHk9H44KaNzi42WAhyE?=
 =?us-ascii?Q?Jmt5sdPp5olHJhb/k3oKZWS63URM3zxlj/6fZpyLvooOqGAhu84nJHnEUDpe?=
 =?us-ascii?Q?hN3imeaqS6jxDx4NapsAyEd4+Ay7wB/i1C5fiBTE7e8RDNynuAaB5E3+4KEX?=
 =?us-ascii?Q?o8fGqHv7N2pRXxyRiCa/w9p3PPR3r5YtDozx/59pmCY/SUGB09y6W++CSFfM?=
 =?us-ascii?Q?Osky6xKyMG54NUlxRqVPjIUEOCGLV+vX2t2+uTLsR2xgK6htpBcXcCoSemY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31dd9f7c-a645-4264-099c-08dbc32e1822
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 09:58:14.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P193MB2081
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

l2nbperpage is log2(number of blks per page), and the minimum legal
value should be 0, not negative.

In the case of l2nbperpage being negative, an error will occur
when subsequently used as shift exponent.

Syzbot reported this bug:

UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:799:12
shift exponent -16777216 is negative

Reported-by: syzbot+debee9ab7ae2b34b0307@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=debee9ab7ae2b34b0307
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 fs/jfs/jfs_dmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 88afd108c2dd..3a1842348112 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -180,7 +180,8 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
 
 	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
-	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE) {
+	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE ||
+		bmp->db_l2nbperpage < 0) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
-- 
2.39.2

