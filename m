Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BCE751DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjGMJvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbjGMJvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:51:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2131.outbound.protection.outlook.com [40.107.255.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4918B2694;
        Thu, 13 Jul 2023 02:51:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL8l4Ad2PRVHxRKtwG8bLprrSnCL2UFfxvOFcGxkNS0UF2VJh5HWK03zVQ3Nisi+HXUWjr12nVjX4+QFQ0k/hUYvgBzdgDGEgMnT5uDs8fNXfEh+GAPS83sVjqqgJgXfy92uhdUQlvZi1up9g+izd+xA7cJKSbcqw1ApP6JGjz9r0XZXfoMyAGg8GXAADHt5LV32Dua7CzvhgJ3FPmaGcZDyzw9PtzYWbX4eUDSdB1gqr6WHSCeUR4kN2kl1/63VNRSWVnMGloq3VdHXNcGI2d2crCszfxS4B11Sr7Ev5hAtcSNauy7naNYhtMJMyyrjhNeRBZ8+1HNUsupPBMZ5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncL1usSbVzlc/5RT+K21KP1wPirkErVh13DJ2Fn3cWc=;
 b=RySHFP/giksK/ufBOAb8DGvqUSnXhUvOk8NXNxMcZEfD1RJaX/cxcC2r7Pzm8jK176D3PAWawfKGHAmSyy7G7bFouDTNVKpag5OkOlfIpWaHwJ7uTdB9P6snAhKE6Adw4lLpc1mDaVPjEg9JkTJJY88i5CgLXB3DW7VLIx38v6OUL0BKRSuIIk2DzmDqoJFnNZkLYsZsFI2qaQ1hGvSybITmlDXJUN2hjs77m7cFyr4yJvD9EpMtdPGWf3gJgfNIJNNDLbYX8zwn9iZXPuiP9Lxo36bVT/YmYp4e3AHfhZwX9Qt8boSF3BZ4oUTmgXKwKfZ/5OsFWmwuPNgQLaXjQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncL1usSbVzlc/5RT+K21KP1wPirkErVh13DJ2Fn3cWc=;
 b=M0l/U2HCmSDywQDjkd7fPRifOL6uuDYDmpW1sP9cKI4KJ2Csc3IixRiw06jOvpwD5NZuUGz5VCd/aap/Sq2pa4RPIoYflUIyorOYep35dYXA6FKpvbQ+ILshCbLdtbTuSIFPoRJpLeRpQzYp2Zv8uU2lc9LqL5dYR2d2iogcIBSBzqEUXk5g14aR8/lSvh8QwD8JBJ5MOAvJ/lcqtjfpTIEMxLwBz9zmLcgoxcOzPF49P6IZJBijCdKO1F3ZlOREpby8PTfS0BbriuVgUcHy9ZBho64TgH4m+Wr5+2UALRvbNWR2of6xbTjDlRWOlZzJhmS2aIwJvEqchM0E618RaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 PSAPR06MB4182.apcprd06.prod.outlook.com (2603:1096:301:34::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Thu, 13 Jul 2023 09:51:27 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 09:51:27 +0000
From:   Wang Ming <machel@vivo.com>
To:     Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, rdunlap@infradead.org,
        Wang Ming <machel@vivo.com>
Subject: [PATCH net v2] bna: Remove error checking for debugfs_create_dir()
Date:   Thu, 13 Jul 2023 17:51:06 +0800
Message-Id: <20230713095118.4807-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::17) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|PSAPR06MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 73932512-7e52-424c-ebb4-08db8386ba16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6W20infGwTw15GoclAosx3Bn02/E4Cb8OADQdct2hyFEJmpjwX7/LZ2FrECrWiQwR/Njlm3+ly7wkFo1j79U4ZLE/ZM+c5b9wEV54RV8fbrmSKVMeNw+bVnUVMBC7wez5PI4rsSq7ZG8hlDd76DBFwTY9op+qebJ3nFfAjyNtlATtFF9VqeN2fkWtgxzpp8F98VcKleohA2EuiEPdTCJ4fqma/GOeIDJvs7iaH+4Ll0Tfc+b5VKco85s52cjNOAtFYiT2SiA8WTuc4MsV5GAKcp6nLmDOy4IiAVvQqHXnirEuzx8JUo/eSWGHzAKW5nvhYlb0qbkYGg3huqtPiUSVYJ4U2I7FcMF1QMM8aoX/A8Z63sLJ6eOvJi1DBYcS5eHEuc0U7D+7yZioHkJWJ8silK8D3OxTB3Mk7d1S8nBX4bvA7F9vmFPo/TjviH6QWxaKfxuD1+SRd/B6BGZSLHHUkEE0u0Ltv88BkfUOIeeF7pxXgKWjd6dDQrHZSHzF5pTiZYka+j81FSkFQavLcK7BEXSEwcVo6mz1qqlKLej167i9EOEKLACs2IvYgXLUsX9wVcan+cEQwDDEGy8OzEyP0ii/fejh4iaLi8Fn/wfcw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(366004)(136003)(376002)(396003)(451199021)(2906002)(38350700002)(6512007)(38100700002)(83380400001)(2616005)(1076003)(107886003)(26005)(186003)(6506007)(86362001)(5660300002)(8676002)(36756003)(7416002)(8936002)(4744005)(110136005)(478600001)(6666004)(66556008)(52116002)(66946007)(41300700001)(4326008)(316002)(66476007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uhq89BFH0pHZDzAaXMY74i7g9V1P4oZzK1yPN2PVJ8UU98VA7E/HvF08ppgI?=
 =?us-ascii?Q?5pZa5g1svePP5w9QmS/XTEszKtBlbPxKJ5D8jgSTOc4jOVLHT8Y7a7KJ98Ij?=
 =?us-ascii?Q?vi8dTRRyCjtqiCbfioKaZ/Z2+RruHddWrVhzOlpkMkwSossLnnwK/T9RcYrV?=
 =?us-ascii?Q?OYQejp68KGN0T6J3Ql6oI7s2qeb8flLFiii6uwgBr0Yv2eNHD8hUZbjZIcxK?=
 =?us-ascii?Q?ZdjRyA4GbE1etATnCfCAB6WKshHi3bN2sR5JvoPHsA5wp5JRFNUjbdC7tXUX?=
 =?us-ascii?Q?jwsV2Iu0bmutZlPEb6q4xFu8SjAhdJg5Oruf6v7tvqxOWTErtR9cK3rUeNZD?=
 =?us-ascii?Q?4AHIw0jGWoWWYnkjxjdl264q8GJkgcD0BSrBmeqyajaOqzn5tvme2oPCt5MY?=
 =?us-ascii?Q?bt1BDRuYbWxfFYdGQU3gAhl5totr3pkQA4+RMr6lEoZfPTV8DZkco0t05wUr?=
 =?us-ascii?Q?2AAWtYIrGXHPxloW9hjQjq2GwtSg3NoX5C/gCv32Y6Ks6ao/vJzwUfHTEQoR?=
 =?us-ascii?Q?doQXjCEanq6NRgH4frQTvtYt/pnrua3xZkTf2fDVEUW/MF3BT/+/wdZ7gJQn?=
 =?us-ascii?Q?R4vhucizSWFKY66kDW/DDmBL2w2JD+1Hl7M1JT2o8ZpAutIgg06tPMBBj+HQ?=
 =?us-ascii?Q?BTui1kDQ7KyKXqkSK8if1Y3ZRNZBH5D6Xa4PN8sxwkJVS0I60kwWFhjCYkd+?=
 =?us-ascii?Q?IR0viw4pqOj7uWySyYH4FVaVpDWl2DUaShcPNqsylS4U8KLFAdw0DZ6/26Ge?=
 =?us-ascii?Q?dsiRABX27XYcr/K99Smn00dQlSxSBqZb1VGhoMAcjx2nAoAmyUbk3TKvmsfn?=
 =?us-ascii?Q?Gv/R9pTsRzT0FFTIwse/LcR9/vRvbfKgPIAM2ZZXRG3C7CkbCYudM0JWcK2E?=
 =?us-ascii?Q?8dsp7laDw+t1Mi6Pqwsem+iQxgHViRIZ5bCNQfbxvJJ+lvy3J3J9zErZCwAM?=
 =?us-ascii?Q?cHAL97HTsYe+2n6QJDnmLF35AoXke1rr5kymNc8AxADZgcr5zcw3n6J1lmRN?=
 =?us-ascii?Q?HFqPT1c+utM+iHzVT1afIkWHJ7A98ndCbRX5gIqbP8ml4h+fqoogUuNWeMya?=
 =?us-ascii?Q?UrNPpG80FQ0CunyFHldgoduCp5cjLrvfQhr9Bo8sGXizMHERnqtNUS51enYz?=
 =?us-ascii?Q?3E3X/dfGwDjqR1p0lIaf20nqMWam6qbxCnTK9fDZK3r7KrO/lKAsViHHAZ2W?=
 =?us-ascii?Q?mug820lWW0939jui30kMgAcYBr5CGsd5IuAPVvHtVONyvzZLcAWAKdCDGUvC?=
 =?us-ascii?Q?TlT5Im6ChKYKsA0FQuqlTB2cVcsIzry+3zlULKkQJySXpovvZ0DQOemehVXM?=
 =?us-ascii?Q?J4u8eCi0QTMQA2Cxn1CpN7Aobam3aXmSR+PvZUayc2lMo/PaeUKowWUugCgH?=
 =?us-ascii?Q?+IF6HOAHNMwsCKd/b+qJTje31+HgLZmGgilFUOluqUjspZelh+rGZ3g6Hwwn?=
 =?us-ascii?Q?78p7D5W9JarXVf1hKb8ymHtlocvuHPSQoGfHQk5oLw9gaLVN/uYAW8Bk9PW9?=
 =?us-ascii?Q?w0eS+rL64eYcWsrmz3B0+5CIIFJFQ1AmbpFMRpMEPcWM/OiGRGLqDhwlKTlq?=
 =?us-ascii?Q?tPxD4WdtjJaisn0D8x/UW2QOl/k8GDInVZTW+TKM?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73932512-7e52-424c-ebb4-08db8386ba16
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 09:51:27.6340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dNgCo3pFThQVz8qKxiy9qNjRPVAVKEA1CKLJxVJMpLIg7zXRzRu+l6WF0IJLnSUngj3dj+i4b0+T2bB3GoSiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is expected that most callers should _ignore_ the errors return by
debugfs_create_dir() in bnad_debugfs_init().

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/net/ethernet/brocade/bna/bnad_debugfs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
index 04ad0f2b9677..7246e13dd559 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_debugfs.c
@@ -512,11 +512,6 @@ bnad_debugfs_init(struct bnad *bnad)
 	if (!bnad->port_debugfs_root) {
 		bnad->port_debugfs_root =
 			debugfs_create_dir(name, bna_debugfs_root);
-		if (!bnad->port_debugfs_root) {
-			netdev_warn(bnad->netdev,
-				    "debugfs root dir creation failed\n");
-			return;
-		}
 
 		atomic_inc(&bna_debugfs_port_count);
 
-- 
2.25.1

