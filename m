Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44660753585
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjGNIt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjGNIt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:49:57 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2108.outbound.protection.outlook.com [40.107.215.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528272683;
        Fri, 14 Jul 2023 01:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrMEd4OVqp4Pf58puXsGBmmdMmwrCWpl7QkEVsUi2lKlEhiBeISsau1kWPn0uAtT/vv7iXFtg0CNeojfKIqvYVzOaDdL5av6kZkPjKIgF3rMmWI0jwSjAJe7UPJgav23JKSIdcYtpmKnsYi6hBY91e3DfgFNzhWJrgmmv1iOOutjIweZef7NK/gJbFTPsCGR6miLtThkN2U4Ygjvj3cFuVwWBBwWOCip72807U8U8WlozZ/g3aSpFqpCLr9D38o57aCr4YC+fgPBMJqr2KpIxaPUmCqbeI6z8/eOvNhLdmAsu2g7dCGmenCx0HYrhrJ+C8jsKHS8fSnLIPkNiQZTJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W1onGJNTOUmgR5Pgg5nCVcLVymgFxCURVkAxwVQUxM=;
 b=apiUayPNl/daRGMkTucPsiObzqmtcrwgcYnlxXOf+F7r8V/KXlXHE2TkUrIv/ixmLUfDCI+1PIjcVBOvlkeJe3CY063ptQfnybQBsh4EIfK6Pfv+hcM8jX4hqwNMShLOoYJxOm4PkfdoYNaMBwnE2ZL9q5OY6gE36Vw7jofSAeW1ejca14b3t2mL+ftVZe1+j1vpraKlzhLgVXdoA2IxhAEJoOn7akIye4T9hY9ox+c30UhMNkXV3Z9SFr+nN/eEJzxgxG4g/in1EO9VG0gxfjec/a67/e+O3G16Xa1c2r6Xi8kKeMYWlUgetJKj+kQUKn/uexB1nFtOCmKeHsBlHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W1onGJNTOUmgR5Pgg5nCVcLVymgFxCURVkAxwVQUxM=;
 b=OvlzA6pdGuNSl9enxsDsdCEvlRMO6qzkl2QLfRhpElkfYYMyjhAQORhPCAyPXArWa1lqinV0Y1aw7JjUlUTon8oXKyKB77S8uv/FU6hkvpq5nty6HT53sLl07P01Wqtfs1suBpybW8fEPW1jEdm6Dyrg94LMDNvNTw2jva+93MSACm9QCy+yMDqCr5BQHWNErVd20qToIxG168t/9H3EwRDYd8NqJioll8nMEF9aPQ/KrwDiJBU03M+9MU1HHSPcFYF2KkboUFxTheW+VH4DK6YZ0NXZxwYI5D5fznvI2z/FsLAr9AtoU2JIRtWTaO89vrUTZZj+ig5QhZEVD34kPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYZPR06MB6700.apcprd06.prod.outlook.com (2603:1096:400:44c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22; Fri, 14 Jul 2023 08:49:52 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 08:49:52 +0000
From:   Wang Ming <machel@vivo.com>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, quic_jjohnson@quicinc.com,
        Wang Ming <machel@vivo.com>
Subject: [PATCH net v2] wifi: ath9k: Remove error checking for debugfs_create_dir()
Date:   Fri, 14 Jul 2023 16:49:11 +0800
Message-Id: <20230714084926.10986-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYZPR06MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c30040-eb70-4270-5368-08db844749bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/D4B3uhEaJJuKVRymmClgpXCtMEcfhFWNpANftdf+v2g+8VyqiR8XZ4aNJdvbsyA+MIPaIa5fEjQURZ+qWXaMYfjqhixSnYQRlofsnWwXn7RQccDtTG4S6MxZiv5udvbNGOT9lu7QkP4lNXX+149SDYfChKULYdJf7uwGSPzkKfyvQoQfp0YjD1ZjQipXf5TGDdifeevgGWqShRcboW5m7B5T7jVpBhevQxvwbwFBiqc+X11w4WQAX8Y4A8vHDZiJbSp/okRUIISAogJRUBgD9A4+GBaP/7cmi3HvBpFc4a5FNDOXW4xDbh8qu+b7MExfWSnd2SRRxzz6p6C6UgpS5lh1nlf43yquJxXEys9wdSfpZDEvF5L/Ym2OyC6IASiO0MNDYd11jtUAdLMl9e4inA107EaG54LwV2Wd4XyCgc6UNtRv1PblTM+zELjFrWJzhJHplanYFmZX6c32MODSiwmONzirnjFDYo19grfMw0wg0KRYNJZUDwq/lTlekKbJpXKZs9TmoKfjacvmdAvrudJlfKUy4ttfPZY7lI0BJjXJTNZ/1tO1VyhLy2SEb7dxIqVN7c2ea2uzzuRTJT0To97lRswHmHGoZXBozhbzEYsuNtVB86BN99ul6yrQVQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(86362001)(6666004)(186003)(52116002)(6486002)(316002)(4326008)(66946007)(66476007)(66556008)(36756003)(6512007)(41300700001)(26005)(6506007)(1076003)(107886003)(5660300002)(478600001)(4744005)(38100700002)(38350700002)(2906002)(110136005)(2616005)(8936002)(8676002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?27KFBUhi0Dt0nRP5GI3LA4p7piezcXLc9VQwwx121izd/nPffDqNsFkXU/jz?=
 =?us-ascii?Q?laxvVEBYG/hptSUaAEeitmwK08ErxGVPVuccazW868GiBkyiJyyqW/jIfIz2?=
 =?us-ascii?Q?BqG6uWBfQTSemsGHtjWlEfo0CLQzROwqUTyIynbfF/3XMrLQIWR3aAtUzobV?=
 =?us-ascii?Q?qBQBkGjdJrvfOToNw0rOOiYD7gYGU8KaDWJjs4EYp0f+rwQlqkUVcTx3k+lt?=
 =?us-ascii?Q?NgkI8t/gZ1g+RPEVZPaAwlK45daZGg4pApU1YLapDqlrPIVsYfkGe+anxp+a?=
 =?us-ascii?Q?9d2gWaFOlpKRK2IIcuHDPHFl9KfdUTwVRfwWs/mDAFJqK+x9J5OFBRG6+voH?=
 =?us-ascii?Q?CN0OWkwMmoZHfCmQyRiywGuorzwBgDYMIz6XNMTHbmkfyyIbn5LBClbUpjA6?=
 =?us-ascii?Q?epdqg/w8Mr0XIuZaJIQm5aaAvYygVPjSrU+Ghob2RFb7u+0BOIQffpyNYAja?=
 =?us-ascii?Q?uZqbJlXrTdj/u8kLN97raJBCIHmSU0U9bjYLWSc/3sWYyb3NWgq/DGRzlxEa?=
 =?us-ascii?Q?YJkc+y3nePYrPqO9gK3x+ajKNSIZwjfaE/Gg3uOSbcd/BIHAzlzvIoGen6w+?=
 =?us-ascii?Q?GGeQJB3f8+yDFSSuRbeLsbyRSlfoYt8e48eE/Rsheb3dCvwJ8Ed8QZH7dKs3?=
 =?us-ascii?Q?95bZj2uiRKFS4o3O8SzWOLq/ZFJxLP91Lsm6WsL1sfFkcdk4V0vIMjYuf3Zk?=
 =?us-ascii?Q?NyIJbtjFbilfXSrjRe243jH/WnTjoyuXsxKeBAX/fKIFpiKHp6EFuvI5tV16?=
 =?us-ascii?Q?IZW1G/DW01RLCDpoPI6N2vi4SNls5yVRvJsKgRVEohiY5cDPnDZHh/vikvvP?=
 =?us-ascii?Q?q8qbaZ9vT8kHBCJwrZ4TJlS2qRX/44jx1pujBnVkl8hcOIBV5A0zctUiXdun?=
 =?us-ascii?Q?8vBrom7XdPdjRWLxyJJwNaqako5fyX+NyCETTzWTg4JYsRthc2KzjmAKTXK1?=
 =?us-ascii?Q?WIMG57TdFNcte3iQTerTQf7/QBm+jptMiLWbkQtBfqgvAdO7A80z721pBGA+?=
 =?us-ascii?Q?+8V7hTJS9XkEgKSdqW5qMKVSM8ooDYOWV3R0KT8HDHEx/8gRMEY7Lue7wfng?=
 =?us-ascii?Q?8fECILi1WfHD7EOeA9pV8/HmEkk3RVX9UucKeqSkJ9ERnKJYecXoBzYiLjc8?=
 =?us-ascii?Q?XnmN92JKA4XQXyfMKtZEchyiL+09CtLxOKDlMVekasA0eCCOTdx4P7giqfEx?=
 =?us-ascii?Q?Z7fsuOy6V0oI5cwrrg+yegRgNUFw4lvLb1AacdOf9phi6xKuAkXVdL4Qjcdf?=
 =?us-ascii?Q?EJmQ+dJ8YoJAxEgpMQxQIv49hdPg8ZJunj/YKnd2wtA5k0mx8Yzrgo1ucxZi?=
 =?us-ascii?Q?GlZoEWhFXm8q5qW7teZf4NMNPciaMdV2EyOhCA2yxIh2edkyfdc+RwjkKIv2?=
 =?us-ascii?Q?sDRd9jD9l9JhUep+QEK42/Lktx1oe/mMABlAtWa/Df00Eu6PgBpg497YUoPq?=
 =?us-ascii?Q?8ilj5b98XHbFUq0ZyEM1qx76KqhbaGhnXUihtMiXbO24EuXw1N4VwTfX41SE?=
 =?us-ascii?Q?pHJDf2GzFtR0nOGMkXUnhbONbvXIzZ8eLZzXyrS51hMICMgO/O3uNP6r043K?=
 =?us-ascii?Q?apKweCQtJ3N4/SOOtSzUfYpP5gTVKeD42bVqma4C?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c30040-eb70-4270-5368-08db844749bb
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 08:49:51.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5/gaB5Yns4W2zcXoz0mYVSR4/WOm84tnvyZj+ghgXW//HYAi3SUMpIru/mAnUwO5bUfaMVV75KUXiAyrgjsbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6700
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

