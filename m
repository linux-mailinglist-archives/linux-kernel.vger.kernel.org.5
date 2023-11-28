Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD3B7FB42E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344147AbjK1Icd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbjK1IcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:32:19 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2053.outbound.protection.outlook.com [40.107.241.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29A21BCC;
        Tue, 28 Nov 2023 00:32:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoFIi5MS/IKhrCGoYSP+Yy9HmlNGaBSktFWm0pHyT4l/3iNHJdW8zasCb1GHu86gDXcs7UDRAwIGcOigJB4o7GwADogCH/XmHkk9DhbdKaOXoAXomB2V3HDippk9sNyAXZcB+muY45urY83A3sjqa+xwYKyVUszMEWrCrIYeYk7kdDR0P3dIP4+yo9NWeJrm3KoKn1BUReOXMYuhkLgY7ZsyZPDvaprmfg6bcvngEnMHjZe5d6reSEKf6aVmz2Pw7vz/gnbmUz1ed0/fZcUZ6Yd6EJN7C/Z/8abviz8LuhpjjfehHlHYaDDgv+IUYWGOeoc3V7CU+3nOyZBfEr2RuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/gpZf9bYIIaRoUG14w2vAxo8usjf+vtn2EtICcECN0=;
 b=k4VdhjxNMifcTHEIvTOzcwZI5z6z9lwoJUJDE7oVNiNpfSm5r2gnjSktaVkokAWqERmGehgMVEoavDsxnuLhEYeSvzELvnQLhz7pjkQFbmpwV+miaBU6lQBlh5ODppPbP284VlqTMc8MDsHLwY+qNzybrN/HeTeb5rUJafP7aBWy90r2l9nnhfm8+iftv/3S3nu0K16AohWAtfqRp9mZyomoZ83WDZS2wlCQBSofbPS9ZeHR3ookYbuoqu9ffBIzI12qKbMW7ejgM0soitNm8mKpiR22mzqdsZxmnl96RydDp3JoCgxtPaI8uIm0L7qI29kjJY1r67ZKL6zpAmbN5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/gpZf9bYIIaRoUG14w2vAxo8usjf+vtn2EtICcECN0=;
 b=PgIC6NDqvwZ7wWYIb7qmOF1BBYzAhXo2eWg36YrdTeD3MjPjdog+cXH9tKVePS51yTsbWJGJx9yiVYFY6pbLrEYB4vxzxMZbLHoGuqI4F5nKI2ClXinGbocanOxhOymxJtobrkmzhS49p1CwPnmE3ROZOirEc/RRmdGIiNXMAXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS5PR04MB10043.eurprd04.prod.outlook.com (2603:10a6:20b:67f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.18; Tue, 28 Nov
 2023 08:32:07 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:32:07 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v7 08/12] wifi: mwifiex: fixed the way to handle assoc timeout.
Date:   Tue, 28 Nov 2023 16:31:11 +0800
Message-Id: <20231128083115.613235-9-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128083115.613235-1-yu-hao.lin@nxp.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::13) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS5PR04MB10043:EE_
X-MS-Office365-Filtering-Correlation-Id: b167b2d5-b147-41cf-4dff-08dbefec81d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pjR5DaqgxnvKtUGcTnD96PXZMs39mvBTrBM/+ZPX6v7YjKgBW3GQj9xfJcCE6rj4jcTz5RkZ4lz3b37KK0TrlOWED9d6xMzAlA8+3FwXdNHxpnKdJVYobwBFQ1+ZBSLJi7saeQnQ166emWB+PYa98h4FJrp1t4DQtY3JQ7mDx2ufJlPYQGahxj754hy6XYRndcJNRdSkzn6fmc4LtKxYxfgi6qtEYKOZyd3Ie9+I1TTPUbA8/3rof8H9z5Bc91dSvd/nc6DUGeDZ4bBx1oSm4jkE7ghOXXQ8hvCCsFR+IbJHBpmK4qoAdESblCd4o8Cno9S15Mv+8RjcXrslpUn8/cdiLcVgPEtL1HCmXyo/LDsgvGGLfIVd0nYgae8VRBHYRztzRAekVerhakVwNGwWCFqjSD8l4Q8YZB3KeYgAKBOV1BVS4QvdHZjXUK9tsk3REJJb0I+gTmRqZn8Vvc4s6TsXl8iPf2WlCtW5Lu0KXbD6cQHBi3fRPuwIkzTpVk0KFOKAyKeCFeXeMpJLag7SP94oqOGrCzxUix30S/pFuOKWfOXKqQ2MYmPJ+cuAITwHa7rX9soCVfnGESS2CQbfziLV4UOzxzTvIkWZ5MFVspE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(4744005)(2906002)(5660300002)(6506007)(83380400001)(6512007)(52116002)(41300700001)(38100700002)(36756003)(6666004)(1076003)(2616005)(478600001)(66556008)(66946007)(6486002)(8936002)(6916009)(8676002)(316002)(4326008)(66476007)(43043002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xy2P44jmVRWooW4rBElSCkDCiusOEuqqv1pPBQI9Pm2/GevuCsjnSMafwQL1?=
 =?us-ascii?Q?VRKVMMYDpiF1CRuWkwQE0mkuaw/yJ4yVTps4gaQZHSdC+CYoPmxBIlf2vk/b?=
 =?us-ascii?Q?lhbYX9OaLfI9w1eTTurBVADMIwBD/S4IkJrhTQ6XsXzpXyTE136+Io3BFQbl?=
 =?us-ascii?Q?P0OzOTxfM8PbIz9XS1brgikE8WEDbRQrDchRjPqsH8F3J3hV6B2cv/CNvBzv?=
 =?us-ascii?Q?muOsQAECqcwxHO7gx/oKZTNZEGgFPY92csqUQq+ZuGELCcBre4AOigjl44lk?=
 =?us-ascii?Q?B3GkfbvtANKROTAwGQS7rnjX0kYlJJCkKM09f4mZAGVmior93XrqGvHLOeqE?=
 =?us-ascii?Q?PhXB15XY+KcFQ/5YlcZYRuuSB92kLOCG/2ylrzoO3MBzL49B8MKnwwYKP+Dv?=
 =?us-ascii?Q?UckKYh8L+l7X111dfm3cgaeLW3pVnNugDsqURoJv66ML34Gf6Df97AgJcP82?=
 =?us-ascii?Q?ro589eOGVyoMXHiGCGh8QdQYNgVq70mcRXS91dpsf1HNLEkdAnl8j0Oc+ilL?=
 =?us-ascii?Q?7yLWx5icECSTj9bejSdR/IkME8mSoYNx35kmLZzXTpQMuuzKLqX9RdofQnzy?=
 =?us-ascii?Q?pVVD0kcQ6Cy9484uPrPLvhBVwj27dGogfyB52VnGoAA82NyMk6AC2zhSFfa0?=
 =?us-ascii?Q?c9Op+3LtZxoWdG6l6JrwAxrL1HUAN4QbT/KJxht0YGhf2H/FX4aQH79W/x8l?=
 =?us-ascii?Q?pojUuXpyOF+vKOO1F5MsGqzGkRpH1Sb81L1ZsWr+lQkej9de617EYVdd/Q5k?=
 =?us-ascii?Q?yM+6/9Ld+gLokHPEvTTlV2APouebDpQ6tk68YNEQ/5L9OBhMbHBhpehdz/Ca?=
 =?us-ascii?Q?9j/5/GK4VS1sJOJ8aBS9Hsh0f/8rHX3ejIjg/dxuc5qJmk/PB474bytq1jMe?=
 =?us-ascii?Q?37SHrDOutzKnNIxZlOVEDoJ1uNj4Px5vmOvtPFP0zjdb/B8fHMqCAbSDSI4S?=
 =?us-ascii?Q?/38c9RHhJORou6raNIUyn8pCJ94v9XB+f1/VKElUAdgN4tXwB6m21VzDP+qM?=
 =?us-ascii?Q?H8/FItF0w5mwxp/Prciy2Ux6R51d419h5W6OIj3Qxkf7b4s13BTN1y9ZN52d?=
 =?us-ascii?Q?Hgxcj32a6slVzSI3n5iyP3nlDaGmwb2DWDMXr5dsGclKma8fexq5CeYjatFG?=
 =?us-ascii?Q?qrUTjUhDD+VZkSf+e7Hk75uePUVEPyG5sKrFALiMVkjlxKwyTa0l73tOw1VE?=
 =?us-ascii?Q?P1YH9NHEJDpXKb6yo+J2h1AZIZvHleJ4EwAtuJWMmpEleoeutPpUl/Xyomms?=
 =?us-ascii?Q?s+5RvEQNEiqRkUBJHQkBuHFU1Z9LSi/OcKRc59YrjiVNCUQdeCnOsqO21vzp?=
 =?us-ascii?Q?fQqX8SPtMG/KvzPzcDeLl6+NX7wrEaOCj/MaDGuBGdRahnZwJD33z0hVvnFG?=
 =?us-ascii?Q?AwJDtVmYsNc0rDixWIKkmA13c6gOkiDY59TBlLtd2K7dNMjbs52GkVs5WbGL?=
 =?us-ascii?Q?ddwnKltWnrJ8bzMk7Vwau9fD82F83TFBVL/SWZOQoqxjC4Pn12HBoUGuZVMD?=
 =?us-ascii?Q?aOmYgcHwGvCFa32yUaFj6ZcdJJQpOW4+ZYFMBCE+ZocrS7X066pQmFQWIyv6?=
 =?us-ascii?Q?UxYy58Y/iVi/48acHArBpyTBVcRFq0fDCo4aeIU/xioiVjSAUxYQvdH22hmg?=
 =?us-ascii?Q?OGo4/MgHowGtaKfV7MGuK5KsNH0CKNAJaO78VJR6MsPZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b167b2d5-b147-41cf-4dff-08dbefec81d2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:32:07.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InWwETKHzoVQ16OAVBGPfUSPi+5tJcqA8T84tLY6UymvFjiv8re00VI6HF4hgthmWXIsInLWP8+V4l7w9MGlCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, if there is no association response from AP with host
mlme enabled, kernel oops will occur.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/join.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/join.c b/drivers/net/wireless/marvell/mwifiex/join.c
index ef7cc40c3ba4..00720c6840ef 100644
--- a/drivers/net/wireless/marvell/mwifiex/join.c
+++ b/drivers/net/wireless/marvell/mwifiex/join.c
@@ -723,6 +723,9 @@ int mwifiex_ret_802_11_associate(struct mwifiex_private *priv,
 				mwifiex_dbg(priv->adapter, ERROR,
 					    "ASSOC_RESP: UNSPECIFIED failure\n");
 			}
+
+			if (priv->adapter->host_mlme)
+				priv->assoc_rsp_size = 0;
 		} else {
 			ret = status_code;
 		}
-- 
2.25.1

