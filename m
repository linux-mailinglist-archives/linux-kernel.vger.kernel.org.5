Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0BD7D7DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344393AbjJZHcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJZHcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:32:16 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A052ED6;
        Thu, 26 Oct 2023 00:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kcqi83r3kweh9VWfJ3V1pdYEXiFrH63axBohtGZc3o+yflZUqXWvd81GMqr4lz8CU1W5MQ0aGAvTwPoSaUStsPWyUYZkGPlMJuoth2FvrwOS0BJ9AvEntk0s1WS2Pe9IBJC316Rk3XwPDt1cCUUu8vKmebh+3LoT+DIUrjDEpV/YjbaVp+QfO1gml77/GCHi03pE7PEdtEt3YXMVoWDHa3ayTcoaMWDVYwq9Vjtn3tWSWGVIQ42ZWC8LEkKTl/Wvp08wD/Mq0GVnpfcTKL7zXBo/0/IPZRLPVFWm+MI3tVqxvPPFHcjHgylHAOIL1LdT720yF/S8aus4ZA8yGLfTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSuAmrgINoomT7mtpfOd4wzBPE8um33FG/NO4SM8q+w=;
 b=QW+2KGkmL2B7uo0jVpqOvFRrZYQjPdVzySIZ4tHdgL0z2l7Ht0mldnTqJ2NQJzgVbg2OuaPNYj9sE1G7jJSTeahkhDfEnghYpucbZyLEDXnmEwbPMhVkQRj92gG7LYavmI+ZBNjsfxys4J52GVEr29hGq9MYebuGiOSdsl1CRPA1ECvaIAPExddnjMWPv5tmoFZn/pNMBY7OQ6/VIEZTPcc0QTVVKCpN3q2aIaAjd9nvs68lL+sNCMqYRuSRQtj/j3nFDah1fbc8uzUjlHk7FMyXV3vDN1R/evgruCUW+FFlGyQeNuKRPH/Y1BBrH5GBqaughtqh3k70iHg9l9z6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSuAmrgINoomT7mtpfOd4wzBPE8um33FG/NO4SM8q+w=;
 b=M0NVIrGHnFrZezb9MwjiRnitXV1OZ2ck/7jxqvENfC+rOg2V/9+g/HhNFMgiTWjfgZmRpVeNsQt6TVvUyJ/Od86XCf5eyzobbjFRpiZ3+xVw54XcfS0ha5yWWJEJqkf2lLtyMdUSKLOdPDn9YSAZg2bRmrYfhYcdtBqJphVi8lAJ+OG8vA+6rSAbODBzYP3JH57+SN5Qn84yE0yu1U/d1npWs4KHJMU/hFpe/bmydxo615ZfDAPWqnuc26ZxIaojoooyuZNRFcB2iuEtK8gvWIaojN1pxRo85nDHp5crJlOHCP4Dvw7TeI7GYE2hZzI9P8q+HHKT8eJxhQZSyf7bdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5939.apcprd03.prod.outlook.com (2603:1096:400:126::12)
 by SI2PR03MB5830.apcprd03.prod.outlook.com (2603:1096:4:142::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 07:32:10 +0000
Received: from TYZPR03MB5939.apcprd03.prod.outlook.com
 ([fe80::4011:f41:f71f:355c]) by TYZPR03MB5939.apcprd03.prod.outlook.com
 ([fe80::4011:f41:f71f:355c%5]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 07:32:09 +0000
From:   "Rong.Chen" <rong.chen@amlogic.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rong Chen <rong.chen@amlogic.com>
Subject: [PATCH v2] mmc: meson-gx: Remove setting of CMD_CFG_ERROR
Date:   Thu, 26 Oct 2023 15:31:56 +0800
Message-ID: <20231026073156.2868310-1-rong.chen@amlogic.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0044.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::17) To TYZPR03MB5939.apcprd03.prod.outlook.com
 (2603:1096:400:126::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB5939:EE_|SI2PR03MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: dd02db07-2199-4393-357a-08dbd5f5a8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZFSRJrRu82HINap/O57WscdPBLTXutd4ZhDcJDrQHc/kjKzik+thcRB1At9/cobRHUCf9kyjqqUbtt0M4W9PxoGJ4VKZmpR25torWvrB37M8RuiWkRhYFZ9GmOt+2QafyOD98BTN7cy15ILpkfQqL+jiBtLPEyEEChX0KGwPCZMZ/C+TGN6gBWfRK32WfGUrNMRjgj2IMeJn34gxpJUPknU13UvWjOuiptQ1UVUznoI9R8hGj4nYbDg8tOGEk6kFTFBan3ZEtBzG+G4M/t0Q49zQ9OPxCUfAS9d1WvN05zJttvHfLpaLc+6fugeFsLGmHzoI1EWj5zkd2lWxCG14Tau6ny/q4gL+cd6EMbCKbghXoRKlJUBDqc5iVevaBYY8BhLkue8q6a6OPzOiKqvVFjaJEYjFlgKuTUjo+fnh5IID4eVTaicMD2Z3WxGLasJzZ8n3LFoKnvFNT3EvOkspmbEKfTdgEjoarI2SmwKDoTLgdvyyOplHCURMfJzsl4Mu1qOlQ353vL4oz1w0ZHDd0pitAO13A7oiHz8swLDK2d15M5JTAN5qS8rJwCMPgtNvfcJ5C6M8tuMIzvd36XMVibmTEMzgVc+FCV2S8OhPIsgySLvHpuZPJPAUrtj1dkwpq2sPEpIQ5XP3gwXcgyabyTBuEuoMJZWN4BLNESa/ls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5939.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(366004)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8936002)(110136005)(66946007)(8676002)(316002)(5660300002)(6512007)(66476007)(66556008)(6506007)(6666004)(4326008)(478600001)(2906002)(36756003)(41300700001)(86362001)(38100700002)(6486002)(26005)(2616005)(107886003)(52116002)(1076003)(83380400001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sb/egRTSWN2tuvHtqV2hu7yWgnY0F+drAWI78vJ/5ezVZA8eYR7aPJ67uzNq?=
 =?us-ascii?Q?IZjPtkjivd2cl350UXGGG7vZLXEM+5zGEgo/suIo04hn2v5m+iUAouXT0pux?=
 =?us-ascii?Q?OCOneJ9QlpwNlRGVc0Sw6J1FiBu2Szr7FCJNCkdVzkYki23Xme1wvBONnH5i?=
 =?us-ascii?Q?B5hWxYrW6xwIyNT/gn1WVN9pdgB0SdYW+zxzT+5wkFW3cfYhTgzD1lYfPUA7?=
 =?us-ascii?Q?rvwIoAhvDeteW4Sy2kit0RzlX83z0V8vsu1JLczt/MiP+YAygDiMHxeB5nd/?=
 =?us-ascii?Q?qMbGRFXVM+Fpyfjr+ZoW2yvw6Zrw6bJnSfmZEtCsCH11QTwKMbO3N4dcI+59?=
 =?us-ascii?Q?SQ9yGE/jcYIFyAN0hilqVclccAXhG1RCCTo5sdZzmQQLt85s9MASksANqDTJ?=
 =?us-ascii?Q?yXlwUFDih3hgjPNlcVBTwDMSZ8bMWiCsDKSc1vMlcgAI4F3uHThRJ0mzoMDs?=
 =?us-ascii?Q?hv/vHixw/IMurw0rR9QDD8CsMib9AwVm3KQkq42L9k0p+l+xwJbvqnkpUMLi?=
 =?us-ascii?Q?XGqwyiR6x/8gt8BEcRedJJwTlBuAdy6oiTdeSgnLYTkcjpfXMy7y2+UuoJ8j?=
 =?us-ascii?Q?OvZrF0KzvVlU4jG8FJx2wgjtks9Q0O8imsKALQcr1DMfup7bDRVARtxGgzNT?=
 =?us-ascii?Q?fIa1lWwOcoHWETxFyPrdaAllg20WsMyZi0+1f9LaGTn/J2XqJU97bvcl35o2?=
 =?us-ascii?Q?JoLhWiLCrdRERHmvOXhtb8gZrFf23IA5qQN/+n2m8yyhuImNxlblVjgk2ukG?=
 =?us-ascii?Q?RPrFd5ekhXMbDArHmF5i6XpZ12DlnroGmEVNPKPireBVtwQpSM6ejW+IL3eh?=
 =?us-ascii?Q?DLJpYw5mIfHXtbrgMIUpU0RveUcknPWJj21PZI8HgrNKjkwGE8ViW9Dyrmy2?=
 =?us-ascii?Q?Act+RzLMs5H0i+N7aS1HukvW68vGzC8oy5HL3h8timUSC5lQ6bsOgQrqQLwC?=
 =?us-ascii?Q?7R9zuV7AHVVF+Pn2vgI1xyPGEl6diToakYCSyzCamPO3FFA9m9B/90mpwQvz?=
 =?us-ascii?Q?o1oshlrL6yR3ojbOLH+jMVE+WBZvJHvdSr8S5BlTgJtwssWrDJOutYCIDW/S?=
 =?us-ascii?Q?o1Yoz8dGFQq15N5i/ZIxTWRIg/lKE5hgq+/f5CNvChYtp5WLjRsCDDncZtae?=
 =?us-ascii?Q?wYRayrUzGHqUBrh5bIBoHPhlG0AFvJ4rsxtDpqmno7ljmgaT/Mc46gTQNcFS?=
 =?us-ascii?Q?0vTjCuF3i0Vuhe5yTAfYcslEuoJu5WBMHxB7EgPo+vQ44JR2l+S7U/bAPfmN?=
 =?us-ascii?Q?7X5LKRZ5RhTtnwTN9vFHBrWpDH1+UqQhX+s4pf9VQ7KC4rLKv6ARgHgzIbq5?=
 =?us-ascii?Q?Pg20RVUxDU0K8RPWcnuncm7/1jnb2BwgcOw+ev2dxjB3gp1hDkuhXEhW/KFK?=
 =?us-ascii?Q?SWwQxJtDR7ViOIXVNIMRIOcG5byzmUhKeermAayktw9kzdGRsHyJ2k+rlbgQ?=
 =?us-ascii?Q?5wpzgD1YbymNG8Dd0H+Sj/+GX0znTxsYXi9Q9Oc7z28OQo8Dj9OUO5KLm74a?=
 =?us-ascii?Q?PSWg8jYmPLbcpYtfBwa2S8P7sdto/SgE5nFpHxxEzMCKyRfj85z7MijxMY7h?=
 =?us-ascii?Q?10uvuHjjXa0aE98CPSQiuQu5pLWF9Rzf42chVWEFRy0gKBoMXYYKxkcvMYaG?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd02db07-2199-4393-357a-08dbd5f5a8a0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5939.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 07:32:08.5250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCslIWsvkbIswQOIbvlGsROXFg/pJngLA6PPgXB8sHlBH+Snhf3yEd5p02HYV03b4fAPe9X/Ug+/2M1eNNAW9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5830
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Chen <rong.chen@amlogic.com>

For the t7 and older SoC families, the CMD_CFG_ERROR has no effect.
Starting from SoC family C3, setting this bit without SG LINK data
address will cause the controller to generate an IRQ and stop working.

To fix it, don't set the bit CMD_CFG_ERROR anymore.

Fixes: 18f92bc02f17 ("mmc: meson-gx: make sure the descriptor is stopped on errors")
Signed-off-by: Rong Chen <rong.chen@amlogic.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 9837dab096e6..c7c067b9415a 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -801,7 +801,6 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 
 	cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
 	cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
-	cmd_cfg |= CMD_CFG_ERROR; /* stop in case of error */
 
 	meson_mmc_set_response_bits(cmd, &cmd_cfg);
 
-- 
2.42.0

