Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A018F763487
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjGZLIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjGZLIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:08:06 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8489B;
        Wed, 26 Jul 2023 04:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVCWVzGkrIzB5OhVvrugYwM6V/o6Ylrrh0fZ/RcOLsog7NiL2mH2k1v7gZOqkNmfAmqAK+h6QH5CN2mTVvH3kzLY/NOixbBdF9EuTBtwnbzI2GmiygYH6w1GkYfUL8fHUCU8bCYlcCba63ge5ky9DRP38GkYnsfcZJ+y8zStLg0nz5I58CiHlXTD5UXqUZtGCVsi8EIEdwnN0K+4TJ5oAn5YAvQjkjJvT2g1u3zhIW1GifW4E1AGB7p2jqaQ4qqXSMrLSe9jzClVhItI3py9z3NmsPg+hL7zLtpkjxDuDi+fht90b6xA4bp9GN8TXKjLShYmRXUgqNb+4Tsp4hSDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W1onGJNTOUmgR5Pgg5nCVcLVymgFxCURVkAxwVQUxM=;
 b=QrSORDWcL4kQTjyI48WUmi86LxRjlNKOQ9d8MxdCX1fg/hlNQ64yNWU1dWUPkJy+Pf+AwWQsrrH+GVZ7b095Nrj2pCfcqi+6BJc/se2XxwBe0wOBZe/AYtR08YR63k8kX3rOvvaBBKiM0iDg3N/ns9DVKT67/H4TTLp8Lj8VkV0igKQtSawCHoR4Ik8W8dpgQeGPNs+ASzJ/bui8+FQt54N7DZPtVP/aojkZZ+9divb7rdSEoT2SlCGV8xYMRlEwu3yijbjSR4Ch0zVBmUU9FNhZpLdbf+AgaEi8D5GGflLMa+0kP7W07uBt5OSGM3nuscNRX2qImyqv0qhSYJIFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W1onGJNTOUmgR5Pgg5nCVcLVymgFxCURVkAxwVQUxM=;
 b=iUBrByKUHX+1embv67+rSpR+jNMoHhoSwOb1mmZeIQAzti9sf2wuM96LbxiDJ5OIUjvXLytSet6jA3cJL3M4FUQf8ES8U1P1DiHMMUeUqYWo7GIpvo1snSIzNuyFZj3/FCamECiAULYpetjoWfqEL94wAjzYJhazpHlyd44mA8Kgpae3EeWDOsp0YPkvbbPp3pfwEWAVN2K8SceAXlYmWCJt7nRFo+xXm/fwKMX423WefesHPZiPTDnDlMUi4umLcVwIV575iSa5uYyzXShhzfhASyTM63kSaAfXevjQQqMnU5L4ZzgufOVKSGxyT+caHNC6HUVeB+eqTzbZcXs8sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18) by KL1PR06MB6042.apcprd06.prod.outlook.com
 (2603:1096:820:d5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 11:08:01 +0000
Received: from PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573]) by PS1PR0601MB3737.apcprd06.prod.outlook.com
 ([fe80::74f9:2f8c:e5b8:a573%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:08:00 +0000
From:   Wang Ming <machel@vivo.com>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH net-next v3] wifi: ath9k: Remove error checking for debugfs_create_dir()
Date:   Wed, 26 Jul 2023 19:07:39 +0800
Message-Id: <20230726110750.3925-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0079.apcprd02.prod.outlook.com
 (2603:1096:4:90::19) To PS1PR0601MB3737.apcprd06.prod.outlook.com
 (2603:1096:300:78::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS1PR0601MB3737:EE_|KL1PR06MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 231f76d1-917d-4afa-7372-08db8dc8934e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tWMVqC+ALwy0egyOwNIf8BYiIXCam/uZIEbxDYqovPiEZtbzgMmvE+CSu6Df+RufPyCWNtr8NCvNajih0GSJiaO29KWSHAl6o0vhpGTROpcgliAMU2UQjM4nmA8PqWQR43tuxPLuR4uYfxE96r06GoMz7CkqCcZHAFFHvnJePfWvwCTB/HZtp4efXmlPYrt+/Bd7bwJep6cR2pEAJpo7M+IIF5D/9Lobh158g/H8cXn1ek7AHhkgJcqxLb9aTvUmJ3Pil91Q6+NZr0GBvLsosBVW6bAZeHW4hz/WEFnQPD9ThsnSi0PFi8wQWZ14GLPFY20Cg5fTN4e/KBv6FrYk4AuhLxX3nOVepCp5n2xIFZO+oXAZeAH2IyqXBS+2n1muFLdPhnzOc3kPCqR6ylyjI/KA4LkawgBHlqb5gz1O+d6BBBaRt1PacIZKHAAsCa6F+CIWFmV7BkLxhsbJv8lWMD1+XtzDAyf3T4cTZuBDUMprT8+Vg1lQ8+tO9F4/GYVCu5FAcaACEMNTbYT8JUkFlWz1//oeXmBy5I6MshDhdKnUasFO5QmcwPNe3Xh2S8IANN1NUAPDA525GC0H5IIp6Yi1o3/fLxEjF03HNT8MHuNVcqzfIohS2IjMyeh8l2B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR0601MB3737.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(6666004)(6486002)(52116002)(478600001)(83380400001)(107886003)(6506007)(6512007)(26005)(1076003)(4326008)(38100700002)(110136005)(38350700002)(66556008)(66476007)(66946007)(186003)(2616005)(5660300002)(8936002)(8676002)(2906002)(4744005)(316002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ME6KtAeC+QGQOhxfd66fc43WD+7mmZCtjIVjgf9ixDsZeppVuUmYAYw0lU8j?=
 =?us-ascii?Q?W2WHV0RaHnvzO5W8DseIyCiQj53UjTYjrp7DP+5zHhEX/4X7agocb+hejva5?=
 =?us-ascii?Q?g/AydMRFs90XSrPitCuQlALgQKQod1vMytLKHZyiT8ZIGvhwp1MQvev+671+?=
 =?us-ascii?Q?SdCqv+zdKenxs0GJVJu/UkeDILvZpNxxkoowbAK1Zo/HMaF/4tckRd8Z76TG?=
 =?us-ascii?Q?hOf18lXLntibo7xi+fofkfDRLBVNA7q3lzOmI2QajccmJhWoEbNcpo4T/6Vh?=
 =?us-ascii?Q?j4tCuBN8/fLyduGIyCYRF4212KLg1eg4PkeNqMeIsp5DHZgV3xmxYUtaAucU?=
 =?us-ascii?Q?zDR9AH19U2FPxqRBuvHb0muRWEJASy44Y5RFvDSGUzQX8IRwy6tc5tvUvwDi?=
 =?us-ascii?Q?le8L6RvVj9glYekcjMCvOvmgZwp1tkyJJHeSfLgK9kU8Kv5Q5uo+rJfFzr+p?=
 =?us-ascii?Q?4eSkCZHNa8OnMjEqoKdend08JPfLx24dG/lMtj4e1Fnt+7QJ87Uh628JCiIA?=
 =?us-ascii?Q?yzjPEZbgzQj+FikPHp4bYc9WJQGIz2QthfqeIzBISg1kR5c3OVUH6rUOjnoJ?=
 =?us-ascii?Q?9hlm1nCRoS3aT97cVawLyYOnehW3jgAFj6hKCE9tCHfrK6wLqEEtulQ3jeqA?=
 =?us-ascii?Q?TGemN3Z50e0DwIAH2dRrzIsojONJhL4og1hBRSsPdaYkbJAunP7x5BaOcZFk?=
 =?us-ascii?Q?HS+l7iLZX9Aj6X7ZOBxZm35OiOwI0xDkHJgc3eKYIhQzHgcacNS8LtMMN3hi?=
 =?us-ascii?Q?gaSmJrv2Gq3pv1d8g66Yl38ry2ga//+QapsFj0L4AqbiSbeiAl0Kx6sVisRJ?=
 =?us-ascii?Q?qqL0+lXYtPvD5ig6RgJ930Wg53xRptkTwy6ogZt8Sl4ZF1uYhDCYB7abPGSn?=
 =?us-ascii?Q?o4e2bqbYnEgX68cLnWtgN54UdcBhKzK9deZfCd2M79aFdclOGz49s5V1XiMs?=
 =?us-ascii?Q?02XdlK+aZGWlZRLWIXqJQy/Gnc/gZNdGg6z5IAJRmqUbvMQiTXStAwK5051C?=
 =?us-ascii?Q?efXjBez6ZLGQ7+cQh1SuOCXZ0g2uPh3N+B+lyYuajBn6WLQnNwV91p4yLvSb?=
 =?us-ascii?Q?vXxdNvloQMj0ggRzGynTTmuKt9cSoveXRs3+kfusA2eMVA4ukpR3vDG+pdWN?=
 =?us-ascii?Q?9kL/G3kJOyIjb7EutY09fxN+TB0rmV7K7by8GG6AGJxrsW+nlibhRlsTvkzK?=
 =?us-ascii?Q?lwLfqaUmkwYdsUGKBpFNb4aheE/zXjkWu1/KZ+FuWL8q0yR0olAT7KdD3nn9?=
 =?us-ascii?Q?H59J7fuhivfZ5OrEhTgdGsWVsWIwwHYxJ8XV52ug0DvyJXQGIr9lnzlFsBXE?=
 =?us-ascii?Q?Zq2+uRzo//nYI363fkdC6jTOegX3dw1m8vqG8sV2r09k2N1bIZLnQuW/NeMK?=
 =?us-ascii?Q?Tsv/r3DSMaLcyJxYGgPRBSmD+UhUsG3H1uAN1jEsWM+5SgNb1guO8fzFKWrJ?=
 =?us-ascii?Q?3BZq09a4XRZca3X95KARQBkLyYdAYFcEZfNSa5au1oVxrctfqIybdKxj5FIg?=
 =?us-ascii?Q?eaeCqVzgWWW9Lu5a9L8mpR4J8zu4u87sRhbq6oVFyqfmT4/Yha5QP2U+nOCW?=
 =?us-ascii?Q?IH6L7/05HWVvqZF2wLUCKR2swYWGe1Paa+zsmoPj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231f76d1-917d-4afa-7372-08db8dc8934e
X-MS-Exchange-CrossTenant-AuthSource: PS1PR0601MB3737.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:08:00.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58jRVLyKdnrzdK7QT7o35XvaTQSnDIgM4gZSqzbRCsSbyOMGcQNI6suMGGxPy2GufGt+HcLz41c4KRe89rEhgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6042
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is expected that most callers should _ignore_ the errors
return by debugfs_create_dir() in ath9k_htc_init_debug().

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index b3ed65e5c4da..85ad45771b44 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -491,8 +491,6 @@ int ath9k_htc_init_debug(struct ath_hw *ah)
 
 	priv->debug.debugfs_phy = debugfs_create_dir(KBUILD_MODNAME,
 					     priv->hw->wiphy->debugfsdir);
-	if (!priv->debug.debugfs_phy)
-		return -ENOMEM;
 
 	ath9k_cmn_spectral_init_debug(&priv->spec_priv, priv->debug.debugfs_phy);
 
-- 
2.25.1

