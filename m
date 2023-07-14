Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD11753622
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbjGNJJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjGNJJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:09:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2118.outbound.protection.outlook.com [40.107.215.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354601734;
        Fri, 14 Jul 2023 02:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYLnypC3JpxIu/BAM+KS88VwF3BkRrxv9u17rPTzj+g6wktDWf0uysXFPHmFn5zJ40gL7xIzf44mQSkUuPHZM9OQ9yiODeWfUgvU/r9DNUqpXTZTimuF4677ferDRdzMAEh6Gyf0tNh1AN1TbX2857PDq1LrtZl83662rr/DmZnr6G2XnNqWgtiF+2sIZkTYiAsJVqg5uzGM/shYrG2yp+AFuQPjuxPlJ4PI80RxaFPQ4GFhx4Id8rxNV91Q1R+lGJh79X8eWNB7idlBbU28CvBGq+oLC5zUIO/rIndoVIxgJH42vlFbtkPKxO/RvAWTSM17Zx2jK+/iokNbL8OrzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YavZlFexwyfkEeEFTyUKxSku7WdThenRSVON8LfG7cE=;
 b=hZhkf+JoXnnHKzQhd6c1SFtcFR2vbDlwz+1cY5CPueXgK/xaUL+RFnMcmztzxfJuRUlpkjM/WtfezixUHUgCjkle+CKPJtoXUNw4iQZgMa8p2p9aK+3BLj9VtpVTR3RWGQal7/H/BFe6v0p3lKQNenwR5g5B6Z7GJ+Dl6IKfT3Lb6gok/YpxLDo+aobotTTl5qS0eLLd46xrq7kKOq30MrgDd/7hZuWBr8p3eCn5R+tCb49r9nacnLxxZGaKhBgdpClkRYaX5/HhdEWQoW9pOTAM0PwhE9kRw1J7OGETAGYxYnYk6wgybS2WKOE4p4zR7BFtMsBGxQX6+8+5rctnag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YavZlFexwyfkEeEFTyUKxSku7WdThenRSVON8LfG7cE=;
 b=jGnXIUPoDDYHpmUlhTHuH6RfhQZXOFr624ILJTNdVzlqsbITbOZpn/YF9eof2rBi/tAURnzNYXi91o4um7f9URTyPu5z6/cGnOaQN6qWhVvAitGtydrINtj2apznt//mN3DZr3cuB9pEy8L9yKaClJbLV+43TWzUH5rtc+t88fOFZjJ9ftogHdeWjjpPbODOvyLRknv/5Mamj85Z1KIOkAqFEXw+e5xhgROKI5wVKhT5d7ce5waCqdeROE+tAvS7SqOc40XJwzFprCmynza+VwLWdwSpnJW4A5Zrsnxl0INLVFzOH4yzs0O7CimA12jF4cyVGeWyG1pN9lUTrWc2CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SI2PR06MB5241.apcprd06.prod.outlook.com (2603:1096:4:1e1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27; Fri, 14 Jul 2023 09:09:40 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 09:09:40 +0000
From:   Wang Ming <machel@vivo.com>
To:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, jay.vosburgh@canonical.com,
        Wang Ming <machel@vivo.com>
Subject: [PATCH net v2] net: bonding: Remove error checking for debugfs_create_dir()
Date:   Fri, 14 Jul 2023 17:08:42 +0800
Message-Id: <20230714090856.11571-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0014.jpnprd01.prod.outlook.com
 (2603:1096:404:a::26) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SI2PR06MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: f277a695-4fb6-4fe0-6de8-08db844a0d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGVR3BftkKjTJFti+fxsLjM3Pi3Dzb8rpowdLNJyayMrRVPmu5ZQThuTIFw0BgLstJ/qA+5vVt5QXsP1Bow9+UG5JFfqhUwjoN5GbhHm7alJSLJZ+8TIoukV8l3MqJoZ+PmDCEH3Ju9Lo8L6oDDQNHa9Dq+yHwdgvj7xalkYRd3PMx8j/tSOFVtUUUp1mokNh29n2SsmWhpNB6pVs5ZLW+8qXF2upSjWWX5oi+oD7L38NnZgcFAr/V3M3W4gwI30WlSnFhsCqzSCt3PdcK2G6Q07AjrVkIKOeMHCalm78YzHTb3DYQYtdtB8jfiSHXmQkrUCc7r3ghnMT65hmrCjTCef0dazRHXmXgpqZ1fjsOFR06FXI7pqnRhYty84qA6X6Yy6M5lI1vf4cuc2OG/cIKRhLLl8a3hbekZiUO3sEIqUWuh7bVVGNFc5VRp/JSYykgb0Xq8rAkYMpO8cmL1BlkYf6V5XGh7vaz0NAVsnibtu04nCpXCmysi3lHpHHPkLeBBOcfyV/aKDL3mmpxSGrz46k9vRSef7+hze+jqyOv7D0D6iGjjwmejlAoLNRb+TqnzjIzUH2y1IQ8wPgIpQ9nlE08Nn0sQu0Srs17/4/Ag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(478600001)(52116002)(6486002)(110136005)(186003)(6506007)(1076003)(6512007)(26005)(107886003)(2906002)(4744005)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(5660300002)(8936002)(8676002)(38350700002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QQbFruykQCUnmg6VYa0K36lh0uPpvYsBVYQhx8EEXlFbLtjtmzhZWLJfibM9?=
 =?us-ascii?Q?xIe+gv/pdrqwfAfbul0+Grr2turSabK8Q8KWooJaMgDlLzUczewNnhN9zodp?=
 =?us-ascii?Q?x20afSLImRrxJe7BJK3mo5NDR08zbb14ifTT/FW7JMk92N0Rbh4Knn7UqHcc?=
 =?us-ascii?Q?nmlPvYrs/CZcZ4MX/sgsAR7NQBJhZHTAIp7KX7+khGKHlhekTSEGJ3/Z7Qpy?=
 =?us-ascii?Q?K1HyX67yHEPlpf/UIiQRvGoeVO63gwXne2TNPq6W29zGDsfvuC7XKWstvFDQ?=
 =?us-ascii?Q?pmLhgzPoF5+eUgsvYdBVIoQxzZS9zoy9Djtr6/74ObEfoZenMqH9neiVSJF4?=
 =?us-ascii?Q?iVGJ6EHkIRdnBmJ/+TbAxIWoMpHTt6q6NGCye1tXb+8a40bRyzDTZC7uM9tf?=
 =?us-ascii?Q?YXqu865+Tnm+olbp2CjsfqyMuGE+9AFUQdTOBbY8jUqQ5X7gQLga9Thjw+9e?=
 =?us-ascii?Q?x73t2bgX13duJCiGBF3dC6t6LdBVCcomWXqlhEfqa8igK3lCD8uMDSz1v26x?=
 =?us-ascii?Q?/fltc3rXH0FiPX13P2NOgpzOwSTfMmWSvj3BgUYJOgGQQQUlHjNVSgzEMGiW?=
 =?us-ascii?Q?CB+jPswvaCffr4a8yRruPCc3HI+jLt6FCtvWXrQxwCubIqRu5N8JH5nTh+t7?=
 =?us-ascii?Q?7gyJbXN915894eXjcnYyVJCS2U2JaVy6uOiepVLpg/qhnrShZsHIv6TVKj3z?=
 =?us-ascii?Q?pLTFzzZiGZEPALQQ9fy9/CM0LfaKaxEDV7/6WSpWatWzqJi5WeK092ZUUby0?=
 =?us-ascii?Q?P7Cfqcw/hUku97/LAgLcs8oI7tjeD8q5RAJeTyINEF/Z0wSLGLpHPy2tBxPy?=
 =?us-ascii?Q?ttCqBukncfUwCcLluZ0N3KgqvFfpjpH51rxcYmQ/NaqUwtk0y8VmQY8ELg3g?=
 =?us-ascii?Q?vtJKon9k1WLgwiHiA/G/2EGAcSU47dq28egarekgTZ7o4K5chn4cpquE2nFK?=
 =?us-ascii?Q?9I2jsoXOq6H2J8k434yvqfVxpqgvNAWRfWcxyHZRpUAYX0SIZA2Chc00zwCT?=
 =?us-ascii?Q?H5r/r0hHpYG3+BbYQu16Z9RfC9YwLhZvcFyRgvAfUKJrh3Wd8eYwHOiaokU2?=
 =?us-ascii?Q?Qu5VyaL9JL3HmHhVBxe3O1MnQ3kX+OzKUsbEgenHER6gP12yIayh09O6o4OK?=
 =?us-ascii?Q?qXNxl3WP5SMnuQom0XKCMBg9TkeCnAtidZSiKOfrKJp21KsBox5uY1YQvgDa?=
 =?us-ascii?Q?nDMvxKtwkPKt2JxRVQAS2eE53vMuZeeNxmUwyLsHY6UGPT8FrJ6uIqlK0u7E?=
 =?us-ascii?Q?Qqd9rdqb8dkCo2hFJGQKyQAJVjq1m/2ORLZSkyiS7hwkHduf9bwkC6ykfUTK?=
 =?us-ascii?Q?9M/L8W4IjCpE3RoNtzEvkymFNzj1BA+xlIWoAywQQ63WO0y6EE1OtS5SHbNk?=
 =?us-ascii?Q?q29NOqKY358K2Y1jo3u7mnKoOyXWyaJEN31gbGIxzT3CQ+12oi/VojN/J0Vq?=
 =?us-ascii?Q?Li0KCKGqcw5LAOZSOR9Gx7ApciTXek+LzqciBJwR5A5faUYxX4skzHmCY4Da?=
 =?us-ascii?Q?VmmoCjPz2ZQXtLLXXDYXuDpEVOwy7a2o6GRqgb8EsI5ZKima5rFMPI0jnr11?=
 =?us-ascii?Q?5w4Eb5aY06H7YkQW8kc5drT/Sl0k8cJCW2xcA0Iv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f277a695-4fb6-4fe0-6de8-08db844a0d7c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 09:09:40.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzr32lUQVUzVBz3QCDhBzSqqhh/OPoyNM6XtRX5aYdSPjFYtcft41deKVq2GjEnWwcyFr6g3eatgJq04D5LuvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 594094526648..a41f765420dc 100644
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

