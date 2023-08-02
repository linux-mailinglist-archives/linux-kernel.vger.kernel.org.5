Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B8C76C569
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjHBGlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjHBGlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:41:37 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2088.outbound.protection.outlook.com [40.107.13.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBFD2733;
        Tue,  1 Aug 2023 23:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8hVyfjetBJqsLtSWSokzEMsVJPKcAlrdf1r4DCEzwPrZ6NC6u6lK0tWxfE7R0nE/7Wgk3SemHeEJ64k/jnFlLdJV//nay13u6rQamS5z2gou95OHwW0nVX1jz5TVqOm5VSuwv01QmkukZ1gb7zlxsV2Cb9XO27D7E3Qcf7BdITZDkqTicavEa3Pd4VfYsSLqnAxVTpKM3qH5s/nbS8MaDDQ31cRf9S1SdvTtjztTbz1U/ottSlhtPbg8ZM7VNzcNDXoW3QuRVJqW9Lh96X7D1avfaC4Fm3tU7rClp9puOXGrN3dmcqRpeNYQ+BoYhrvI9XKKtZ+Mu2TYFiLsftxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxZr3nVoXjvyOrnj4iRj6pQreeGJaq5LTOgqRYntHCM=;
 b=SlDYhVMfgojEDP0FJRRtNFvoLbVJxC9ZRsz9rNk2IKPm1TURd7GVsdZufyw24ucVYMgi8+f/ocjynf6NDf58nUPhYcqneK3Gn5CxQ0CqiEyJ9S8bJ5D+uSG6xETdwaSgqbRwR4xVe6dxDnUBU5OHxVAO4Io3LUvIlkjoBcJTIiky/anHh5Qzotr1r+e7hnaM6uMUX+pE33dhsM4uhXs6vf7qB7o3eQJdBifl8ixLKTf9mcehVyY+PBSEVEIqt36EsojYYUqfbbSzACDzpBVzxdjaDsyhtzqNYY6vDlrFDbwgdbAGCCq7yIIn4fogCZBi839pj4gfgWKVd6dIvdwkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=topicproducts.com; dmarc=none action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxZr3nVoXjvyOrnj4iRj6pQreeGJaq5LTOgqRYntHCM=;
 b=tBSKM4MHn05hYwL3+R3wGnP60ZI+q/owgma2TE8Jt4CgUJv6Thu2yo77+Z6FnI5SgOWHIiG+/st7hsm/3+iQO/fe/QIkA5HRTCl98oXpAK0eTJZAZB9sU6GNmqMnTXGGQZdzFf8yd/g+ilG/2Irz5Cj4sgZrp/TCmaFf+lVA/ORYpOQfJ1OZTY595DAnm3P9XEnnQhHSvyZ3zYS+6MSEVzhsCuiGCnBI/KahKDU8kxI3U4GAJZzmoLUZxif4hnmJsLtv5B4EsY/Fm9a1wwjldjwO7wpX0FCnIvj61rGCnOqAGZgPWTgJjHqQZeXIyXhwRpXVsQW8AIjoll/2xRxc2w==
Received: from AM6PR05CA0021.eurprd05.prod.outlook.com (2603:10a6:20b:2e::34)
 by DUZPR04MB9796.eurprd04.prod.outlook.com (2603:10a6:10:4e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:41:22 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:20b:2e:cafe::3b) by AM6PR05CA0021.outlook.office365.com
 (2603:10a6:20b:2e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 06:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:41:21 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (104.47.51.236) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 02 Aug 2023 06:41:20 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:41:15 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6b6e:1525:72e9:d02f]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6b6e:1525:72e9:d02f%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 06:41:15 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-clk@vger.kernel.org
CC:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 1/3] clk: lmk04832: Set missing parent_names for output clocks
Date:   Wed, 2 Aug 2023 08:40:58 +0200
Message-ID: <20230802064100.15793-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0079.eurprd03.prod.outlook.com
 (2603:10a6:208:69::20) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|GV1PR04MB9216:EE_|AM1PEPF000252E0:EE_|DUZPR04MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a32ab4-3ae3-474a-9b68-08db93237bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Qe5ex9kK4hvm6NuuECbHOY36XWqqYYyN6F7q2wwuXiWRJMgxq85Zz9vdMCUG9vtWHRb2kCCrocYASZa6xD8qVcZS4USOaia8nVxE1EjTt7/wBgNTfaTKoO9F6nIGj7YmTbyln1Y59hd7LsN49M+qrJOmMBlDyAnr57N5yNax+OrZ53v1zvzUg7Df82ehyBF9Hux6FsF/DtvvUbYGgzzCXaMJEtLptRiyyUb4XyiMSUFwU6aGul4zYnFYcbnTS6NP3w6MtK/DIFl14qx9KvlNm4xk0HqbI2s+KrlTvLg3I4yJ4//Lghg+VLBfex401Idfxx3w3H31D8HCNPKrIp6wOO/2a1E2+aBLio4lXZFDaQLlo62WpB/P4XXQ8VtHgAR3+SYnPO1s5kntqW1o2P96MDqVssvdBd8sZUXXWe2fwW5hV0k8ZPTvul3M7vUKCUWzC4M9Arw9GU3D23RBjNRNxBtpyCJltDVhMzj/aQdKeGFnxSDjUeogTYF8x1fhHpgkz9/jrlRFO8wgsT2MuTcvQyqBmcj9VqAR25QAvRIwwXPFLMEK5ydUiIUBbMZ9Hq5QZc/Hhjo/M9JWHk1gOGgqwI4i6fKzXoZZSHPNq+5ap7Bar2/Rlx9VYQAg3C3gAtAY
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39840400004)(396003)(451199021)(66946007)(2906002)(66476007)(4326008)(66556008)(6916009)(6486002)(52116002)(478600001)(6666004)(6512007)(83380400001)(36756003)(186003)(42882007)(38350700002)(107886003)(26005)(6506007)(1076003)(38100700002)(2616005)(83170400001)(41300700001)(4744005)(8936002)(8676002)(5660300002)(44832011)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216
X-CodeTwo-MessageID: 87c8c010-796d-4ba0-8734-e77592ff58b1.20230802064120@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.05b2cfbe-0414-4869-b825-034b9be5bf9a@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 111acc31-e766-4ad3-4098-08db9323783d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R49i2Q59ONdutMYJLMIKQQAdhK8RYXN3PUBPu9CQnKRPUfbCJVKl5bKe2CIg4hNSwI26RrDLzjUJlLNNyX22ViqFvUipZInM8vNucqflCmVj8yCkmvGgO7m/xMtkuTcOpDNgg3xPwmcCCMyFi+WRCDr081v/NwuUxMKXbdyzUK/bBV18alOMMlmY7A03QIOEuIUAaKdkD82C9SpQTXkDf7Ore+vsWlrV8BDH8qCEyV0WfAC4tJZfOfkVnALsQKHdYvuJTASirzZtLlMpBTEftwryz7UHcAY8hh2pJo4EwQcGdslkkt5d+8jGHbTazbkzzptznOuYIgYwdtz+UKxLS4mi00pqotFM5/mxG0dby0FMphi/kGqrub7l5p07cNcUkH8Rz2Kuxc7qzltm8clGEQpUeLvrcprP0AXuwSVWC2a+2CRPEDYMu6Hi0VWo0Dro/Lfqxv3Ixo66RYtU0amJbebQ+/C/hwM+l9vDzYKKNN38UFpheaWK5KpPjXtsAChE+Udj00u9FMZNifHOILZiVlz8E4v+5A2AEp3ha+lY5GS3rXXOkIpcNK8BfvOiFR5rFb/X2+p2+vQaXnR7jTYScD6wxEa8dp2akMqVZ+01SBpqEJ3P357T5gOEyZhfp8x8g3S9vIT8uCsWXeuwGMgxmVLpSB/q22aHXhF86bDpnR6/npIkbE4droeBIMMOzQx5
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39840400004)(346002)(396003)(82310400008)(451199021)(36840700001)(46966006)(42882007)(2616005)(336012)(107886003)(6506007)(1076003)(26005)(186003)(83380400001)(47076005)(36860700001)(316002)(70206006)(70586007)(2906002)(4326008)(6916009)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(40480700001)(356005)(7596003)(7636003)(83170400001)(15974865002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:41:21.5642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a32ab4-3ae3-474a-9b68-08db93237bf6
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9796
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lmk04832_register_clkout forgot to fill in the parent_names, resulting
in the error message "Must specify parents if num_parents > 0".

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/clk/clk-lmk04832.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index e22ac93e0c2f..188085e7a30b 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -1297,6 +1297,7 @@ static int lmk04832_register_clkout(struct lmk04832 *=
lmk, const int num)
 		sprintf(dclk_name, "lmk-dclk%02d_%02d", num, num + 1);
 		init.name =3D dclk_name;
 		parent_names[0] =3D clk_hw_get_name(&lmk->vco);
+		init.parent_names =3D parent_names;
 		init.ops =3D &lmk04832_dclk_ops;
 		init.flags =3D CLK_SET_RATE_PARENT;
 		init.num_parents =3D 1;
--=20
2.17.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
