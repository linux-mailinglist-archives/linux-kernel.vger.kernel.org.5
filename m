Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED47C6BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378206AbjJLLEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378247AbjJLLDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:03:48 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2078.outbound.protection.outlook.com [40.92.50.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F368F5;
        Thu, 12 Oct 2023 04:03:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9I7Wsxoi2msSJTECusPF8OQOTWID4SHbJfShngm/DpVh9xIsEaooRKUYNDLc21aBBot7iJEf4iot7GytJI8hcAqHuEPetM3DWIJyAX0Xt+JgdWAj0tHekkuIG3jwR1gqWJiG/4I3I5/IWvBjqPyRy2qoWtAk4091WbsMF2kkkAO+HYJ5Tnvhw/cNW9XO1CENgrgLOWCWvFbvUcPN+06d3XUH2kn1eMpDoNW0uRW3N2FASAJnhljvPB+U+ITix98d2gfdaO7ZVTr0TR0AivaZdWlOeLTPJokKRIMzCqsxK+7dlOnPnyuTaKCKftIBt66jRbxZ0oV/BYS83XZSBQpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWAbrkXml6NEsYcTfWFt3VsGaLxIICZYwThYz40k9t0=;
 b=A1fbf7rQFi2LhlAbaCSY0nJ1dOTB4Bq4iPqXvpIw6U0AUC113CdXGYQ9q6NekYCDAUCY83yoLvGxY1tqH3vrjlrK6HAAC+4//MUBZhTpI3EP7fO84fWErEI6Cybqh9zT5+3gyHZPPGa4SI/ouS6cYheXG7u4ZPkFtRqFx+K9WZat25ErJt7hElaXEjncZh/0i8uSCu9pR5BRr9oFVWEeiGStl+mb+BIq1BdiCpuJdVXbbBWSGp6SA3QCz1SbAosjrSzaLkPQq3G7hIdkWwuXzM6LeF4y+XQu1VHvE1tK8xtF7sr+DtpYUHpeBoygclVj80cWRQkBmh1Hgz88TGw4BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWAbrkXml6NEsYcTfWFt3VsGaLxIICZYwThYz40k9t0=;
 b=AG4CFqMVUqffihyI1i/Ab1SoDZlvkVZO911mGFqffLis2hQrdVTI1jzNF06Kf2jzwkPxqfgjhmphHvRhA+xnANonBti9bOCHkO4Nbz5ujuw49lyBVqIS36b1O61jYqKPgQoNrxTlxdTrWR3wEuzm6nVhnPHz16/4ui3oGMgeju0RiYPpzkoznH1sK4bw9ArJmbwKqgRYpBRsc5FGfTQatcteOz180os8bt5BX3rnV7q2/KBLzpUIH9f6G/wbg+dfrhQs1wAGYqFakeptBwbhvRGVFh8LiGXAGVAqKPt/dceqXSzXqYMajzNVrm1ovQVPKlySOq6DGq7eF/Q6avo7aA==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by PAXP193MB2252.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:232::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Thu, 12 Oct
 2023 11:03:36 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::af68:c2a:73ce:8e99]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::af68:c2a:73ce:8e99%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 11:03:36 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com
Subject: [PATCH] net/tls: Fix slab-use-after-free in tls_encrypt_done
Date:   Thu, 12 Oct 2023 19:02:51 +0800
Message-ID: <VI1P193MB0752428D259D066379242BD099D3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [IYw6gEqPreLhsJRR+n9bpDeFOiGYOaZz]
X-ClientProxiedBy: LNXP265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::33) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20231012110251.10696-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|PAXP193MB2252:EE_
X-MS-Office365-Filtering-Correlation-Id: c77aa7bc-1b2d-4b0b-1b78-08dbcb12e130
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ncHInV2HNgsx5LhrR4Vg83pPI2No9Tz7Iz3dQOOWozVbhV5kQ9emIdVXhis6dW6TwltjbaYmexushk8rFLLLVP9FndPnUFK1voRTBb9nnUjvFEPtBvztrAb0J3zoLcVkITQQzla+zWhkazZ6CEGasZvtJvtA10WRZ8ZsrbvpWeVHLtQrw0fPEuzPS1mBP9LD0DNGqUKyQtK6nnHJDcXXi+NjeznaqulgHsT5FYjrO4PPr0o5y+fY6ZlblkTh2WCGM6ZWP1cDJnpeuBSPWPOgj2SHgohD4esdnrIJWXZMi65ClKfNWoVQ8T3UoI4+FEwFaQ8B+Tk64WjtyQR2FDyjS3vhvQcDF15KwJeyHKl6zdAFmewy3wP2QA4THH5oQVX/txdMmNQLRTX/wg0qz6lA9lxnr7aDyMrNyxhVIn21nTK5xmwemkHjzZDD0nsA96tOzNdR6ZPP69HGytfNL+es9ChkniUT42LyHKvynJPm9FkZRvUTz7Or0/O1mJ04CJVAhz2rzTRxKFuI/xoCHOvLhkpjsePYCCJ7tw3fPgULNxiBwfgpuqMpBfWYoIWZjgCTTSPjfY0prnaH3ey0GrZnBsmZ+qBCLRhUYjxM/2IWJaM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YJ3qbzQt1oNaeXazn620RqPIf6L314yOqNlTP4Q7jG4mDxEN5voOmIUnrgwl?=
 =?us-ascii?Q?T2nAh57EZoMo33BPx0ZXb2AB5DoAdkWEpN3U/NYotavXUOZFMdw1sF7kfpl+?=
 =?us-ascii?Q?Zl6dUT1Dew3q3usIJ0sXjVKxNMMSEDg6ib6ixUgxK7AhOGtlHZ3QIYV83cOR?=
 =?us-ascii?Q?qE1sl3RSFGlRvjRWMRCO/EWC205DB2o5l9oyLG+lVVylj5e0eDDD9anU/n8g?=
 =?us-ascii?Q?EmP6Qc4P0wVH0e6fhXl79BafivjHqt9uf3DXf+fmB4thyN0t2Hsf+dFyan7o?=
 =?us-ascii?Q?YGVUeBUt+sIMdqw60nH8yrDYlQ89THYBridolMJV4ekVpFS5k9PJ1yr179FB?=
 =?us-ascii?Q?X9H2hjZOeJ8nXNgdDyaTfaAVRrBRf/7sWGH8EfaiG6nwVwmGc2YWB5IEUCau?=
 =?us-ascii?Q?JO7FShVhmJ/o9vb0hC0qBAEhOIF2x2CDQH7ACjrgaejVCd3vNxW1qi76Vzst?=
 =?us-ascii?Q?TieAhTRJwBXZ2s4bXrjsQnkHtm3XuC7KH6Jdd5OiJPGtH4YnLRdCacAXvgrH?=
 =?us-ascii?Q?UQBWTHf8yRClR/NJHoiK9aur60z9OxYyIOkhQMKgjk9BmXDoj9YFEFG9XV3b?=
 =?us-ascii?Q?huFgkrCLCw/BkkgaTFvNLK1KYn0KW8P3ZGhO17xALTkcwBWAhu4+yDxl4mQu?=
 =?us-ascii?Q?OPTaEmN9xHN0s/z/lNrlYzRr7O4L/Ph3MkyAvyB5cwimWXtHQCbCw/D93XBZ?=
 =?us-ascii?Q?D1j1adNJe67lcoRNAFtexTz7WV4Bo6e47s54VZOsGCngGSZBbsVvZjVh3KyL?=
 =?us-ascii?Q?ZCgLZJtJyf2VHp5KXj3xTHNdkje+rES4lY2wSgxVuwfDTCOHzjeq0pRl5iHY?=
 =?us-ascii?Q?BVSvQ45gHB/nWet+gK8xjEzHTaiPUlyJftcaxNB88tXDj28WuFmkRkFrI/Hs?=
 =?us-ascii?Q?QEjDOVcwwTGz6oFUKMUAlrH1HS/EDTkBth84H3P+GsQp22prKShz4gRcfHK3?=
 =?us-ascii?Q?HXCSnqFxHPkJHOSG7U2X0FEmVE6SvuB4v5vNIq/BPQMt1klh+wH2FtSBy77B?=
 =?us-ascii?Q?uNFzQAopdVS3dJwYFw9XejH/it9/QDAKRU8DlBTgVnQx8PrbaoJehUljNR+b?=
 =?us-ascii?Q?lVujm/Ia0KmLCvDuO8NJ3S9KU6nY6yg8XncCGj878Dnpps5n3lnHD2B8meYp?=
 =?us-ascii?Q?nz7ph2oMArNPgTMrbImBnnkF9xx2//7DYTqUtClmotPlPwE40xJ+ldlDr2E8?=
 =?us-ascii?Q?D/YBfmEUTXBk0Zqx3Ltwws4cG8cpscNxCeZSy2IA7dEX5gUTJAD+AMJIhiw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77aa7bc-1b2d-4b0b-1b78-08dbcb12e130
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 11:03:36.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2252
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current implementation, ctx->async_wait.completion is completed
after spin_lock_bh, which causes tls_sw_release_resources_tx to
continue executing and return to tls_sk_proto_cleanup, then return
to tls_sk_proto_close, and after that enter tls_sw_free_ctx_tx to kfree
the entire struct tls_context (including ctx->encrypt_compl_lock).

Since ctx->encrypt_compl_lock has been freed, subsequent spin_unlock_bh
will result in slab-use-after-free error. Due to SMP, even using
spin_lock_bh does not prevent tls_sw_release_resources_tx from continuing
on other CPUs. After tls_sw_release_resources_tx is woken up, there is no
attempt to hold ctx->encrypt_compl_lock again, therefore everything
described above is possible.

The fix is to put complete(&ctx->async_wait.completion) after
spin_unlock_bh, making the release after the unlock. Since complete is
only executed if pending is 0, which means this is the last record, there
is no need to worry about race condition causing duplicate completes.

Reported-by: syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=29c22ea2d6b2c5fd2eae
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 net/tls/tls_sw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 270712b8d391..7abe5a6aa989 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -441,6 +441,7 @@ static void tls_encrypt_done(void *data, int err)
 	struct sk_msg *msg_en;
 	bool ready = false;
 	struct sock *sk;
+	int async_notify;
 	int pending;
 
 	msg_en = &rec->msg_encrypted;
@@ -482,10 +483,11 @@ static void tls_encrypt_done(void *data, int err)
 
 	spin_lock_bh(&ctx->encrypt_compl_lock);
 	pending = atomic_dec_return(&ctx->encrypt_pending);
+	async_notify = ctx->async_notify;
+	spin_unlock_bh(&ctx->encrypt_compl_lock);
 
-	if (!pending && ctx->async_notify)
+	if (!pending && async_notify)
 		complete(&ctx->async_wait.completion);
-	spin_unlock_bh(&ctx->encrypt_compl_lock);
 
 	if (!ready)
 		return;
-- 
2.39.2

