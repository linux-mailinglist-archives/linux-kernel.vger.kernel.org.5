Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E0B796EA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 03:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243091AbjIGBoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 21:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbjIGBoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 21:44:18 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2132.outbound.protection.outlook.com [40.107.215.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50FB1BC6;
        Wed,  6 Sep 2023 18:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksVPMWSFnYwt6qIQGnusbg9RIVIsvY4gLalWPBif7AAOtqA06NXoh9+ctJyc8IHg7MSEIkERGWXLdw2ofeEnDSKbRvdrDoCb82WzdaCw4cKrEAMP4U5R+5xX/x5jhd+Y6pVXWvzp0NKqoPKXtx8KWsqLqf8z9FUVvRJ1v1CPez0ozhUyiugCxUDHh/REiRYVrYK13h5+iZKsTv8tnDzTa8ZRq79BPNZ4NO3gK18OcLgbTni5HcFFl6z6lhAZp3qkTiP5MiITyw5KdwffYWgqLj3faui0TCObdlm7uDh4Kttsh4G20Xk9D6Ij9DyI83uo8nK5tFhw2Ay0Qm6meKQAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CySLsg6kxgNaXKBjzcag03x7A/n/bgyFnp3sUDM79U=;
 b=MvtFqM/TfXOCpKrK/oSeT4mj75BQF6RG3vxv8B2OyIlD52ebem0rdfGeR6oR1eE5ymlMws1bHJuKMqjnbPNkvfLeVCoeqX3gp9YB8UZVQpk3cFC2A42LPA9ncL7VLGhchvEd8PLht6qgY4h7Jg9mqrvhgi+Z18D7DabOHtnu2iNwniZvvJjnEBa1MOdH1EINn9B6gBXmJmqCjNlu4Im/VlJa6BvTRS56L8vbOZNBRbAU/2WjTtjln9IVsK4EdmXBBnm1JTE0PFFwOtmhkradpJJCbsqCt6wJjsJSZ78DcGpfinRsYtvbMF+G6FcyQRSpQ7xHKYbCCIKzET0+2ITNaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CySLsg6kxgNaXKBjzcag03x7A/n/bgyFnp3sUDM79U=;
 b=Onr8hJ7xEBm5B2f4+8j2o7XSBg6pKBF+UJQ6zHnQJpSucNCzVhed6fobrd+T7wvIpSrnfzSMLDkadP5KgGfZ8sWQpCCKkinTBI0HjcGgjxmjQGxEpdrjFG6u5YYOLad8a9y8Z+kUeDhSMpkD4KeaZK0aKnSANZApPXcywGm96I6wGsXb/mfX4tna4k7va1xWguYt8ikmvyzNG80xbx8IL+d6Z0I90iT/NE8L46LD37cm2o+CVet0NhoySQakaq8899cY4E6FSc7h/FP3a9edPoJe7bFEQC1Aya/AaAvtmE1creJzurCEsxPBnlCL4lqgEpBt5qKtSey5S/HULeSYjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
 by TYSPR06MB6713.apcprd06.prod.outlook.com (2603:1096:400:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 01:44:08 +0000
Received: from SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::b59:294f:e052:238e]) by SL2PR06MB3017.apcprd06.prod.outlook.com
 ([fe80::b59:294f:e052:238e%6]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 01:44:08 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        audit@vger.kernel.org, Wu Bo <wubo.oduw@gmail.com>,
        Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 1/1] audit: remove redundant 'fsnotify_put_mark'
Date:   Wed,  6 Sep 2023 19:51:52 -0600
Message-Id: <20230907015152.1388111-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To SL2PR06MB3017.apcprd06.prod.outlook.com (2603:1096:100:3a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SL2PR06MB3017:EE_|TYSPR06MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d21e59e-018e-46b5-70c4-08dbaf43ed0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AgzpgVCmFUi7626we+0dHperYOR3fdUeOxAHn6nHQfIHdhourTMW6BglbR6N2qL5m525H7sH0Zyf+plm0eK0M7y4+RjwUtb3K9bXc2ZAEbslItbNqua51M4qmTCyr7XMkbXNFp71WP546l+IqLKKZ2q+h+SghdVQPbQUbR/a8dYXfEFYfKQo5oTOKrTjnO67IkeP8XrvmIVW71dbSwDZMQg+U1grEpxgIegHyQ5InB96k69/9LuhhLjw1sW02NT9taUWCM9NCt5s5JfStBASlaZQT0tbQypTwUCNks1AVdLAMXSw7Ow4mzcPKgtm9a1dE0MO1prsQw9/0dJ5p6rPZyBK2npUCanfJjJhzC6kFhyBeeZ66CVAlI7W7rLCX6CR5r1yrtjOp5idgkgzWEthEMP5+yExwPDfIcR9/Pkyq21MqdSEH2ouMo/H2dnY0OTkut7OC8LaC3CP5HN/fexNrvMzHeMqN8abrKYGRWHDyGIxJoShbaMO49T/+ZVcYabJj0+IigsbFqLGwbizjIKIn6o1/FURvHIHF/VgmOULbK8VZN7UVxOixQaeNIjEggLYHCowICLquZrQL/SnD3D8JEOOkhrB5U8HfMSHyL9c8x51vNe7i661B9JZv+kIIF5l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3017.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(186009)(1800799009)(451199024)(2906002)(4744005)(38350700002)(38100700002)(36756003)(86362001)(6512007)(41300700001)(6486002)(2616005)(52116002)(6506007)(54906003)(66476007)(66946007)(107886003)(66556008)(4326008)(1076003)(8676002)(8936002)(6916009)(316002)(6666004)(478600001)(83380400001)(5660300002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7GMPPKx7IPPl0YdwmvpdfUTRu+44bHYNjoODKNrg0n+/eVs5nxdGNFQYoyGP?=
 =?us-ascii?Q?jlQIltqFPxMPOCIdd+G/PaJvjazOY9f3RCyorCvVt6PsvmovDdO1Y10auTQx?=
 =?us-ascii?Q?LigJ2MTCziM8wcYiBteS6VFTkU780/4rkGfiEyV3EaY40CsVL3Hs2RLIN79e?=
 =?us-ascii?Q?Oj1/eroTvn2lYguNEC3yrkt9P1W9/p/ACHjxpQKWExfLpoug5WeZs0BTJQnO?=
 =?us-ascii?Q?FvXwObEx95+MK9NkZthcvqqzhWI3RqF1/FlSssFi05kGl1oY8v3V5Ko7a7Yg?=
 =?us-ascii?Q?CgrbM+RZxkSeuFnD5CnGaNR7EwZ2QDYda6C3DdDk1YYV0FSiNocMp4bGqK6e?=
 =?us-ascii?Q?AsVJ28Yt8srUnbiZ8VCqhjceVK8F+dqHZgs6I7hkHrxWE0Y8hwR/wMM8Tk1H?=
 =?us-ascii?Q?7lQZ02rLfR5oQimbdhunR6CZjqQPmaA0adDj3s5gl83LfdsIA7w//55vrx4M?=
 =?us-ascii?Q?rQF8KyMkzws04CGmsT9iB3SFKGbOETKasu2892DaLM2ROK69VuANlKHBdQ+W?=
 =?us-ascii?Q?cxGj6J4IytiVIkdAP2clt/Xa0epPfZMce7oGx8wYERdf4x1SwnfWo3miVSUW?=
 =?us-ascii?Q?2tGcFPRoGRPXTAuA9dhRH00/2p3sCIkAhEX81K8TrjL52/s1fr8dBRqk9qXI?=
 =?us-ascii?Q?wy7CekkZvmzIAMELAszO73qPzokF+74v5JG/Xx0m3LB1ADRN9zZ8qgR4yHFF?=
 =?us-ascii?Q?46BE3seABhGO2rV9n1K86wXwqAYJz2KJib/9wXJgEwMLBGh+Cng7ZG1lAGgL?=
 =?us-ascii?Q?t/pnfTEnVM7jnYwXhnEDhqKp4BzkoTL0nJU23298uaaIB0Zvx3s54p5CpwAZ?=
 =?us-ascii?Q?1Uj2XiIubD9YB1woyKf5PggL4JJHPNpMrM3bCuTi//LKoo+K9SuzIbe9bxTV?=
 =?us-ascii?Q?8nzZln3EgEdgyRp17uRCrDlkOVuuGcJusubyMqlC49QNy2+ObjS6111DGR3D?=
 =?us-ascii?Q?7JT0S7FO3aR1V1kKCxjmxXnO0tpyTw7syctsaugtQX8t7hwSE909Byfy/IR6?=
 =?us-ascii?Q?eRFEyBUAYTPC002xGocG54hIjjohWs04QvYOI9GFWoH2ZQ5imT2iM59QISUB?=
 =?us-ascii?Q?W1bK+/dyrEjHMTFRammS1aC5jbQs+KhSbqC6IZEPXRbu/N5jFZt48dDFyN3u?=
 =?us-ascii?Q?taHFjyYDxvjqCyafbALRFzBUV9x4JnH9Im3odYB1Ufjs1oSl/rnT7twgqjui?=
 =?us-ascii?Q?kNTdNQCsMyEI3+4mypkDWUruNbvow+a8TujuvPQ+q6oF3iV8OaET5VrZKV+v?=
 =?us-ascii?Q?C5JcfzrWcZENnLodzp9qjvzK64q59KErY6zLI7RnauqdnHdWk16QsAjOwVR/?=
 =?us-ascii?Q?NbjQi32ordChyAmc72wCLt8Ic6SwJLqryAp2ylylovmaPJlhYsMHNuaZB+6f?=
 =?us-ascii?Q?xKhDam68RCrqCgYkbqVrJlsIVMks3fuLDJ7I1EqAM428oFpTbIwsf50QELzr?=
 =?us-ascii?Q?M1r6ecLufqtcsyLuG/F56v6dV7x1iWN1LGW4w3DxfmHVRfN8LUSkecfH79tA?=
 =?us-ascii?Q?Q/HjO1P5IpJXHE+XSQVEfn5+aNOzrDrwirhRBM+vR0ITPNr4hfRWJoWs14CV?=
 =?us-ascii?Q?QYZ3erx5sumif9IndPkyiptEkl+I+CaFCw6GGqJ9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d21e59e-018e-46b5-70c4-08dbaf43ed0e
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3017.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 01:44:08.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+ExICCgZsl3t/JyAlmE3/lJKAU/ljXcG0ZcIu9RDoasKRVl7RgQPVNFOrZY8ZzNGsmxz3G+Fdg6cK18DkJhOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'fsnotify_add_inode_mark' has done 'fsnotify_put_mark' if error occurred.
So here to call 'fsnotify_put_mark' is redundant.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 kernel/audit_fsnotify.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index c565fbf66ac8..ff1cdda27653 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -103,7 +103,6 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
 	if (ret < 0) {
 		audit_mark->path = NULL;
-		fsnotify_put_mark(&audit_mark->mark);
 		audit_mark = ERR_PTR(ret);
 	}
 out:
-- 
2.35.3

