Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4235679C34E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbjILCui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbjILCu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:50:28 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on0606.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B7D3AEDD;
        Mon, 11 Sep 2023 16:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcwoVg81qo5euLZW2u2d+FgZFcl+Ql572KNzwo+amdGdUKWoI64JxqZhVHc2Lqagiee1tG93KfJWkENa5HP1Zl9I9CCz6DnmKUm7/3oiVm/8aFzHPF5wbxXHKLRXk/hAQFUIgiy8qEcXyrlEKbX7ZUQKlJ3wXnlLdt2YWVcas5WPPhguVxLgg3fKxYnkufTJ+j18+pTTphzu90SFvUlF/eKlmu4BZG4gbpJ7V0B14O4yji3JKDpD1r6Dc9CJN1Ip4Bd0/USGRTYaCv2TQ305mEClkmu0Uf1MmAS5UdCZwbmH4WBD3eOfqH566K9Nn54MpfXaz81iAR89rsaNu5TV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJfkSMvkEDwGsM2agRpaxrhLAMGHiw7/JkQhgPoDD2g=;
 b=Etti0yfzxJefnmZrEzgUgiRDccUueNb859BaZ6ACYKJM0d9xFskitOEPJKQ8PaCvvXS+TIgCe9Wh0bYvxE1yqlYoVATdRWBTrYXuTCKfZYaCsEULlerXpnMk5jQb1oRXEUcyrYjeyfaYX38uD7HRzwkwIzZx1c7/D60V/zuUQiZWE4N1HctOQVL602Ayl+Xj9a1HDLOJYt1uMFG/ZIF7gBDyDOiSRdRMynfZOwui4segnqzxGGnZZa25ERKN/2LS9X0dkGw7SYAdthgUNlOtPJ6pXIOI/uFUl+bWKBnEDg30Y1N0FNlCpG2hUqMK+ehtH22+6AxSL6AptSY2a1Q/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJfkSMvkEDwGsM2agRpaxrhLAMGHiw7/JkQhgPoDD2g=;
 b=bQOHfV4GAOi8o3iWj0nqHu30y7oz3Bo+YkzZJCfVZFiiKmrLdBG/Cgi6M7DjmHvSZJkwwB6I+S5P77Nqvm0aAKaa54O6e5+QB3QMytZTHkn7dxu2WyYjD5Ch/1t90psIKtDidV7xsGLJ0/oXt77T1SNQ8I/4fyErPDEgidNNEY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by VE1PR04MB7310.eurprd04.prod.outlook.com (2603:10a6:800:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 22:45:24 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 22:45:24 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: [PATCH 1/2] remoteproc: imx_dsp_rproc: add mandatory find_loaded_rsc_table op
Date:   Tue, 12 Sep 2023 01:44:51 +0300
Message-Id: <20230911224452.15739-2-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230911224452.15739-1-iuliana.prodan@oss.nxp.com>
References: <20230911224452.15739-1-iuliana.prodan@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:205::25)
 To DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|VE1PR04MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 5812c7ec-5521-402a-b4de-08dbb318c97a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOgETzAvewkWvV+1brwbFrA+6Y+h+17sCpojioGPFNQJXVV0NBvSUAr9KIuNbP/K4EFD2/9EAtF1/qORF2r0sCquphLx7ojxeMYebXHpySdA4qt6Sm1ZB20rGkfEoKOenSZfr4d45QmBwhsVP8X0f8qNHR7qWNrGfoED59iKF5ItiQbu48mLhQKUUkTFLZRSLemkz0znO7Jwsn54xTg3XC5VgxwPGfWsoJshHP3kfAa8TA62viHwSsrH8lWKTNRq4Le/tYTIUvWzrxOI6j8+16wtMuAbNuK82Jm3LdICt8Dg4V3OT2Zk+VMm4izM6wms2bisfyqtc2PR6jftbsV8z0sERIlTSktqJKjKsTZCuwg7BCFDB4ttFODpBIEw/PGVJhJhoTwBtGIQKWJCPf4FuQCz2Ed49OpcEmR3SPfNaNWzuOtiqTmY6Dt/8uEW9UghB1si2UibT4PHrvoNMsP115KJoV6Vi4YmpGJUd45ILqss30qL1C6rGoimsOvpg+5dpTTeNap0aPELvhXX53MxFhqPD4aHoCiJITQ9zQmKbqcj16623AIpI3lOOrkskC5/S4HFR5BxXCY+J/cYqYMzid/CqnR/77+eJ1kgWZs7wdH9yYNlDtSEOMK2bupVkVDU/vUaooHi157yAIJ/jPjcvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199024)(186009)(1800799009)(6506007)(6486002)(52116002)(6512007)(6666004)(921005)(86362001)(38100700002)(38350700002)(2616005)(1076003)(26005)(316002)(7416002)(41300700001)(66556008)(66946007)(66476007)(54906003)(4326008)(8936002)(8676002)(110136005)(478600001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?afyo8eY2S/m3vTwz3Ov1sj9WYsnHzdG3PkQY8hWvT/Z1mX0lWE9SBS6mBL0c?=
 =?us-ascii?Q?qEvQPO1O5P0V99PfXD+EinHDebsRLRK2BGkjI7hca0Od/wdF4B6eBEFIsMv3?=
 =?us-ascii?Q?feY3GIpHtLeECtHiBTJCM7vyDaGTOkux9DleciC9BUEJ6TSabkiZx1bCImzu?=
 =?us-ascii?Q?aBbO7ZTz4BPpipHLzkBku2pucJINaXBaogZdzChsFSHqP26fZ31/S+AsDl+m?=
 =?us-ascii?Q?jbnzA6H5WiwUd66ZRbi/w4FGsnogQoXhHhePuBtgOgJGvUB71IDSaVVsazup?=
 =?us-ascii?Q?KUk+waBf7JiSDFp4CSYTMdfCVt2DQfonZE4yPGBYWgy/d9K6Nw7hNPbwwoFr?=
 =?us-ascii?Q?besnbjFG4tyxrfuIM1De8T6zpBSo3GcqeXrJvre76a5rwLDgj7ZWt2dpq7po?=
 =?us-ascii?Q?SpEN61xB6XmIQyrmNUbhuwQL9z+emUlB3IpI3HKyiO3wJKrrjUTGLamqeB/O?=
 =?us-ascii?Q?L5RE28U2KUe/IBP7fz9xXhz2X8ymRq/QCt7v4G013z8kZVGDIJrhLXNdiA/M?=
 =?us-ascii?Q?UT9o4olT5mecms5mngSeKlZ76aj2Gr7n37KxVDvzmy5KH2qo/Upld36cPkJ5?=
 =?us-ascii?Q?j72EUhqB73nP0sxVw51EGPDWajmhYQnjloRZauM3eTBaju1O3235/X61ev6q?=
 =?us-ascii?Q?PaRYZtA/i+twZTPGTHrKsA1I5RNPIWcvBQdheG4r5Cn3IMAbRNqenum9sOTa?=
 =?us-ascii?Q?Z6WhJYOPB8IeJW5ftgTi60wVTDbdGKBdztTqrhok1JuEYHYBhxhpyuWFKRgr?=
 =?us-ascii?Q?IlZTib5wNll/0qlL29AKAlm/GH3JGJzHqjM5k6FWXDaC/pZgcMxLoHHZejYH?=
 =?us-ascii?Q?1jfeFrEB33yfqoddsJXhn1CBqvZ/RBrC967fmSXkwOeshGVnxWeQZALoSEJD?=
 =?us-ascii?Q?19ruH5vSArrCh5LUDI8NwMAyW8g332ImqAYi3EuOdEoaA6kwhsJLqS41sT1g?=
 =?us-ascii?Q?EJAAMg6Ax2Zlr866ZnoCYbOFRsQ3E+8Fzs7EetDSs2jOQVxhxMnEI6D36TB0?=
 =?us-ascii?Q?KtPzn7nvw9ECQ5zEEaXfRgzr9ahcwDw49K9/XYhJZ1dWTNWfBcT+gL+FVzJl?=
 =?us-ascii?Q?iIU0zytpoorFO6JEFLkXeybDgqoRDML2sqctg7mTBipYrgW65j0HkmieeNjF?=
 =?us-ascii?Q?rnweFqAiHkeq3ydLmJE9I6ZXzL449GN/qfslJnxRF2r7TQF5YcAgV+nHaVnS?=
 =?us-ascii?Q?eZnBa4PhqRcwye+55QHzInUontQhCeUcuoRBUvbPWrfnLqDsxh8aWQa4DXRm?=
 =?us-ascii?Q?lfeqP9lltKzM3jxf0huL4ZQA264jRvaUfpsal7t3hogLYPbM5hSKJDl/fJLl?=
 =?us-ascii?Q?oebkyckqz4xw79joXwvRlDzEzsLqOHbBEqcmdp5D4RhvbfB0Txss06yy4siI?=
 =?us-ascii?Q?KZGvsri+Aa93H9yulYIni6O17WpDUCMHLau5ROeH6SgLodPE8XyWSTvwUl5f?=
 =?us-ascii?Q?qPBpD/b0wHsv1Av6ptkrzB6Ockp8oy1hhOLoxfkE8evvdDuzJIV+vgBYvbbG?=
 =?us-ascii?Q?aDaqX0abIZ6l4tiVVHeLskf8o100ldpBIFqkDUgH66k6wEx3fSAqT3pScdJ9?=
 =?us-ascii?Q?pFzZxwtbRgtUkelsRRhWQEv8vhKkJLhKLvKBBESSdGHOokq0brx8DeqTL+kX?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5812c7ec-5521-402a-b4de-08dbb318c97a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 22:45:24.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Brwzb6FmDMky3j2Cz2Mr7uSIv2U9inw4DIWDHOOWASVPfOP8ZD3Ab2uKBmZW2oI5lkAXAjcHDExS9dxPzsgB8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7310
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,HTML_IMAGE_ONLY_20,HTML_MESSAGE,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

Add the .find_loaded_rsc_table operation for i.MX DSP.
We need it for inter-process communication between DSP
and main core.

This callback is used to find the resource table (defined
in remote processor linker script) where the address of the
vrings along with the other allocated resources (carveouts etc)
are stored.
If this is not found, the vrings are not allocated and
the IPC between cores will not work.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/remoteproc/imx_dsp_rproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 8fcda9b74545..a1c62d15f16c 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -940,6 +940,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
 	.kick		= imx_dsp_rproc_kick,
 	.load		= imx_dsp_rproc_elf_load_segments,
 	.parse_fw	= imx_dsp_rproc_parse_fw,
+	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
 };
-- 
2.17.1

