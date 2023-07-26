Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAAA7634F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjGZLaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjGZLaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:30:00 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2115.outbound.protection.outlook.com [40.107.117.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740182D70;
        Wed, 26 Jul 2023 04:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzfH0N/s8OhVP8xfXFrlWXkDlP6tta+qHUOQD7ZDtIThfV0ItfwkTOvneU+Zc22g/+S60NvmLYCCV9AvPZ77VbFDt8UMzTlFeI9PDBQuu5IDk6BwttASrhmQ3QPrztQ5CGqZP2lnyBMakpxDMXLGEDG1Vyt6f69kQNd1oYtylKVxEnd9hGxnOAQgewXNO6W/5+hXZkPWx1GHgCIm9kG7uw8KRoN5WmQWT7K3eWtL+CQZoCd4LeZFqcB76U4CAMzcUtEk+Og8HIeNMSCos6AdpB0qatLpaoEvKeYigrIYkua0wjB6soQkMznRaIpQZeKVQLkwTxjghk/Bdm8HR2H+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF1RdSQIQPg/5ii6mDAmLc0B6z7wKXww0QwwHCMFkOw=;
 b=QOEvY2vltCJ1mo57VU116/WdlM7Zvj5MkljpoI6qyDM4azmodHhaKFNwFltcGrlfayhVfAQ3gjGOg7CZIk5WvnhGYRC6N5D01E1XLbvXDZTPt+7Pwy6YIzKIy57N0jtHivzqeZ9ljK3xVTIYIygkMXOCluZn1zuzBJGU8AX43vJ0A+6oO9QOYAhWo37MKoepxSj0OuLu+tqta8d9tMn4tfiiOoF0smhXBJE8dn5ragDIWqSqBBZj8r/eeaaxdAOJTwF94w8s1waLct2HrNBiQURgMYjk91dGItMcSJ4gIwrY//0gtt48TjZ9tHnSTfPj8q7xkVXffyZ0+TvJHigBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF1RdSQIQPg/5ii6mDAmLc0B6z7wKXww0QwwHCMFkOw=;
 b=pne4jdvUFUGvSgE870Hv7lu+iEHIp6RMbH+lHr2No68+JiD+TB/VrvXdeZvh4dXj6C+AbOdzlaggt9DP9TMHXbNUbf5u5JGudADkRWW8HENxipTfVBeomfRWY5rsf1+oSvJd7kPxLjjV0PbaVGu6StFIP6FeQpHqKFGjJaJKP5fc9EZ2jkqjYiNc42g1awlTyfFubPbPuutI0vhLWlCVev/VYSWSYEszVemhwvNCveg4kMionB9NFqBNhvV2UpvKJEJiEknX76mF0E89cuFc+qeBKY5vZWlKc3SVZAzjh49Vldf9L/pfLnUPakXoBTRvdmlQW/gbPE/K0ORe/DPlVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by SEZPR06MB6331.apcprd06.prod.outlook.com
 (2603:1096:101:12c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 11:29:24 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:29:23 +0000
From:   Wang Ming <machel@vivo.com>
To:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, gregkh@linuxfoundation.org,
        Wang Ming <machel@vivo.com>
Subject: [PATCH net v5] bonding: Remove error checking for debugfs_create_dir()
Date:   Wed, 26 Jul 2023 19:29:00 +0800
Message-Id: <20230726112913.4393-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0012.jpnprd01.prod.outlook.com (2603:1096:404::24)
 To PS1PR0601MB3737.apcprd06.prod.outlook.com (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|SEZPR06MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbd5fae-6476-491b-40f2-08db8dcb8fd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A0fON+JX8EQomvbttKBrWuRsb1Z+QChaF9a+9+PsD0L/F2F/v5UH9uvue+FwC6vqIYzZ/OVCWub3r43Pq741XqRgpXtpcqSAMQLZ4RyOMvxcYHz+015gvnv1rjksRnhUeqIwDuy72Rxxuqkx26TLT57pGo8sQJ3ai9eRZc6EwRNjWucOjvVOOOehAVoUvvyQ4R6Iy7q6CepNDXnzhqzB1tDe4lAOolKX+J0ZGwme8xvNPnucmjetDKjH860Q2RC+nKePv+aNVU7Z1O8iVen9tDW9b4wQVIfvCe+iFlaVrbntJPkto765t097xYMWcpGua2X/l+BDZtPXNatuBjX+eBeY/nbSG5lCZYiQ4lXW0r4O60vxx1KiMYryH6TNqyHt+SiZNaNHniGX7aUTbl+NPUYBDEdroR+PfdFBnJ/YXbqg4wW9gRvogKC/b5XrbSfQd+1CuBRhOReZxoyOIXLxm0kjKdkdYvh5+nj1Da2gc6FyXDcIMxlTDgkNeR000rO5tLBjpmxvKTNmMWa63IQ4nMf0JBXF5iBGdpwfemnTV+UnmSBozNvvDmUIeTmlLooT50XULUTmDwydIU+C4rNQWxytSNFJp2NlyZiHxgPjfhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(86362001)(36756003)(110136005)(52116002)(2906002)(478600001)(4744005)(38100700002)(38350700002)(2616005)(1076003)(186003)(107886003)(6506007)(26005)(41300700001)(5660300002)(8676002)(6512007)(8936002)(6666004)(6486002)(66476007)(66556008)(83380400001)(66946007)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m1zIfj+fBgYF0z8cgKa6pUfBozOwT9BLoqN7etOLmSmqOVtojlXelffEjaZT?=
 =?us-ascii?Q?wfSfQPMO9bfFDnIz5WLPnBMdCM3MREUXKHQBM7MKU+xU111cWDjd1l7jZFXw?=
 =?us-ascii?Q?HX/d7xqusorb0HJ2MOiPBy4mUtuz6wzOTe4lStkJmIXwbRLG5DIm22Xw5UH2?=
 =?us-ascii?Q?9xxMg3Z6twdH/rG76aJudL3CSwkAsZ5SWG6FrK2v4x+dXcKc5qWbtV2UorjN?=
 =?us-ascii?Q?6H1lc5kTThA4henLVCazd8k7rs3zafimQslD1PJAcg6vvon291WoEK+eZPsl?=
 =?us-ascii?Q?vkTtnE0Mz/65Rl/ShlhqBSEzdoOe76WHtBhKh965LfWASUM7j28rS9kiQY5F?=
 =?us-ascii?Q?w7YDo7bzrYXZaRi4DBWrSJWDhZ/OPGdqojGOk7jEple5shVDSySZwY5o3kj1?=
 =?us-ascii?Q?CIxFLiKS6OruVpHVwrwmn2UQD6VonWoPAnY5p+xxsoLyoYS2mafok7MmTqqx?=
 =?us-ascii?Q?QRNJJb2QcNTEiZWtej/wxDeFS1IDic4c1Cji7SoL2QCX3m9FrGmSTmV0CmUu?=
 =?us-ascii?Q?5/pDcBMbe5qBtv6vc4suL7hMyNQv/HXzje3lVUhAiP7DBEDPhgsmQ8XUQSlH?=
 =?us-ascii?Q?Y3S39RLpLp2KCtqQ5Ze0c3vEZlV0Cy+GRK5bBzRwSJjv/GWfLhOLpPDkwU5J?=
 =?us-ascii?Q?fJEzhX+9A64+2+sBYWPfzTibROOpAmaeosLZGVne/5UgXOsCc8S8F6hyYYDi?=
 =?us-ascii?Q?Oa2tWIdCXyMw7C5oZ+eU5w7aBQmgadbmqt9l2/Ppj/WyAnNfEM3Cc+pSC4fC?=
 =?us-ascii?Q?sk7h8Z1skwQ6eweBkKl81/AXOgBDRtmfQ9N4V4zEAgWUeqCKTGfoe9EqMuUf?=
 =?us-ascii?Q?UxGCpdP3FDSpKI8y2GrVo8Jn6NGAHqRQYscxQtFqZdVllS0LOy6tsKTjEZh8?=
 =?us-ascii?Q?+pOycTyUObgm6Xs833MGp99PbxGXDGxwE5NO71f1/wifohwt1t6zpv2nFozb?=
 =?us-ascii?Q?YUv7Z5mI1UZ52d6QtgtfhW828cJafFPnBsTHQTBbMoUV1Tl3ALcOGQVz/kXD?=
 =?us-ascii?Q?YgSQZBAbDg7y3zTJkhymxk8w+gIMtvvH/FviVSK6I2XWHxqaz4CuwAWuqmwD?=
 =?us-ascii?Q?ohz9o6C5YP8QucUHnNmzZjqRmZBRBzsYkOR86xjT/TwOaMaZT04wp2x4H70u?=
 =?us-ascii?Q?TdeiCLJE+ybUx2Twse4/CVl2UmZtooiKAi5FiCGuP7T6reBjfgBlouL0K3oN?=
 =?us-ascii?Q?YKBkon0XJYGK10JM4u2KDF7AYlwodWowmOKRuxa78IYTzu5pieP0kit7PR/O?=
 =?us-ascii?Q?Ana1fi0hDecBnHqwTpZPdyJsCZuPnWVGkwCPsAtXd8Un0vhRnG59HYo92lak?=
 =?us-ascii?Q?a1h/Sx2zHPQrCQsjTP6Gxu8yXj/O1C/aLzorBZ9x/dHkuTZdo5AqF3IeD+9C?=
 =?us-ascii?Q?VQro6r0y0uIvsJPQz4O9m32FTeHGm0yBcnK/V5WKTbsESsP2wTTbAxSXMMOl?=
 =?us-ascii?Q?IAcvB5x36kt5xFgs8w6JZaFzchsXt08V7y3X+xykmrxDo0fK536IM1Y74QBg?=
 =?us-ascii?Q?RyQtmQHOOrM7GJUju1/e6DtVu+aVnyTZliArd2wBHklLSISXrJejlptL9yx7?=
 =?us-ascii?Q?gu8Gt1wG+on5nXMuaKcE0910Xcm1Kx+hvwmWY2WC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbd5fae-6476-491b-40f2-08db8dcb8fd9
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:29:23.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2dqjg3maAxH/1GGTOejy5BFhyrRNakDTbyBiTyePzX3o+r3dKdAHTOejCIDQUHtetT8Wjgj5s0AiyjQx+yNEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6331
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is expected that most callers should _ignore_ the errors
return by debugfs_create_dir() in bond_debug_reregister().

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/net/bonding/bond_debugfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
index 594094526..a41f76542 100644
--- a/drivers/net/bonding/bond_debugfs.c
+++ b/drivers/net/bonding/bond_debugfs.c
@@ -87,9 +87,6 @@ void bond_debug_reregister(struct bonding *bond)
 void bond_create_debugfs(void)
 {
 	bonding_debug_root = debugfs_create_dir("bonding", NULL);
-
-	if (!bonding_debug_root)
-		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
 }
 
 void bond_destroy_debugfs(void)
-- 
2.25.1

