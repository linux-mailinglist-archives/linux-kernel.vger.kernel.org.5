Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1AE7BF6E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjJJJKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJJJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:10:04 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A15A9E;
        Tue, 10 Oct 2023 02:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9bbIS5QDxjasG53hdnU2mPTTv1ZFEcrE7TU4qpOVj9QOgLmxlXrfL34lWffmv0ypvBNOmgWaFk871rtTDB3bUQGnhCSLFBmmwUy2Nq2F75NfB/T4fVlPjEWwadpXC+gNfI4PQus0BDP5U/MYEibDfCMBeHPp4161fNVOpSt/bHTd3OmDjNjTYtMOEu3iseEqgId+PMMyPm/4kkirNNRdThOfcrilt88lsdtZZpbsdKotoO8uUdcwgoj3ZHRMbrgmMTLiii+n4JdEUWPwTHNCBJa/ydfTjkN5MihU1Kb5iTJui37Ne3V73YJbc/Y2V8+TmX1qi183UWQwV7IYWLcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJfkSMvkEDwGsM2agRpaxrhLAMGHiw7/JkQhgPoDD2g=;
 b=BExT/OXGD+DNTMoKmP+6xnKRAznlEQDwvIBK9SHYvwZP+7TtWbtvByTm0GZAK3haxJzjo7TCFDvZ+VBcegCtdyeMcCkBuNvPXgU3tXj9VFkNAOjE2LWe3I5D52j/+MI4w4CkOvNDuEWOf3Pa6RJXfNkKBI0A8aw6uMnIxvRv/dH0zy+aI+X+6S9074YuuHXu61Zz9ghniybY1Ctr+d7eezFiOP7LffG9YUbSTZdgnRMZUqi/DCZv4NjB6qv5E9LC/R0DE/Z1fAkxOl6JXcDkPGCvdtJYDOEnGcqxZJ4JqC9xh9GXYST8GWk4PynDQ3LWym/ofRoHPgh66nKvyJ0YAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJfkSMvkEDwGsM2agRpaxrhLAMGHiw7/JkQhgPoDD2g=;
 b=Ynfv/V0K6r68uHqrRwkwEwa+cj6AQpQQKg2cM2QAR+W1xO4E28IgGNZcgW50l+goSHNj0HGCLaZn7CDFvgEbC9ZZWl2AK2NjuDmJEbsGWdX+qMvVhPGyPMU4Wo2rLSbF1ivhxNNjPV6yEii5o9rfNrOlXZvRE+OBZK8ascIvr8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by PAXPR04MB9059.eurprd04.prod.outlook.com (2603:10a6:102:220::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 09:09:55 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 09:09:55 +0000
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
Subject: [PATCH v3 1/2] remoteproc: imx_dsp_rproc: add mandatory find_loaded_rsc_table op
Date:   Tue, 10 Oct 2023 12:09:28 +0300
Message-Id: <20231010090929.4371-2-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231010090929.4371-1-iuliana.prodan@oss.nxp.com>
References: <20231010090929.4371-1-iuliana.prodan@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0054.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::14) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|PAXPR04MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 93274ab8-0ab3-4712-841f-08dbc970ab6a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: obRD5JdHv8NJT98pzN2ohRtjpB7Crk0pww38Hj6ceJ/CnCyJrxoQruOxxV/hKDdx0cHn/5QRaIrZnq2Nxlps2YGELi+iDU1F2O2ERCr7ljjRCxx84S0U6jYb2e0BZGKXdXq5kK5xULk6q+QpS066kwhRPzJea6Fq14yRZT7nD8gIJ7j7qZqr0+iMsHk7d1ewI0lcn06JOMaA/3Q8ztpZnYzNecmgqolMuFh/6+zvXVPk6u8xwrLzQhcAV+m/g+Q5PKTRnkq3EhrLMMxa6MztWFuUKtF67W8WInO+tOCYy8BJ0JpXqUuyqvnrBC1CSe8vxfY0Zo0CzKPG//tzOQYdHEgXxv9MY4sY0QIJYlr7BKsgE4ElcVoD2R83mtDJsS9m6y/2AwA3ln1QN5meJW3O7X5c5JpeB7mlGyw6KuXvPB7QLkH0taCidkZC3E5JtCgBX9k9R2btkOLG1sl5MR7fT6nL+N+CO59JZ5MznVKgs9wHR823yYdshefimp+ELrE8QjzdX7cGTsirxZhFXdf1kAUaGijjxfXnAPLa28xFOvKpuCJXvgiFycD7VhelnzYXu8MeHX77KAXOt7SODBiSQnNV9oEfVX485kDLVzJ3NAipvi+WJuE3Hf2aMFHh5DXXOIapoeCRRyokp2slAdU/Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(921005)(86362001)(38100700002)(38350700002)(2906002)(52116002)(478600001)(6486002)(41300700001)(6512007)(4326008)(6506007)(5660300002)(8936002)(316002)(2616005)(1076003)(66476007)(66556008)(66946007)(7416002)(8676002)(6666004)(110136005)(54906003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ei0QXOoG16aVUhbs9fepytKASPm/75gjT6AD5xv/D6Q6CJ9zuGdJSfh1X65y?=
 =?us-ascii?Q?ixo0PgPwklB6Fv8aC1NNwcXjZrWrKZc6W/ot3W4zuTPv5sk92Ae3FwGkZA0H?=
 =?us-ascii?Q?4W2lm/I9p5X6t8otL2oYZAsJbQQ2GDNlloCKucvbpYztHKkwoB5Pmjma/NZK?=
 =?us-ascii?Q?inxJ+Q3SAXgjZ+VCOynTAgmYaV+biXpWLzzhZHiOkWtZoVPXSH03ie7g+rLg?=
 =?us-ascii?Q?Zx6NXt7JtsPgHRpQ1iMOh6k3akI5P/D9j4xSgmj+pyDBgLuWgx1mXtUz0OVd?=
 =?us-ascii?Q?dBnGzm38e2h6Kr9tJJbQDOMBqAsdkrDpiDD6pZjnlWFKzDchYCFqGQSoqKEg?=
 =?us-ascii?Q?lGlMc4d3La5te9ShSN4LqkrpM6Grz5x9MKMwhgG2hfWa9KPRG643gQt6M/mL?=
 =?us-ascii?Q?NcwVCcJ859g2U6TIDdMQZwBqzg59eAgrgmb0zE8t61PCgdIpo9PG3zd/zHcF?=
 =?us-ascii?Q?1o2YsI/8o9GBZ4syTLZA77MigQqaZtudRBNCfnQRnOfZD77LK9aET2qpYeca?=
 =?us-ascii?Q?KGAq9QD6Ps2aYljZNz8m4t2ENhgDu44vq+5Ye+P5TeZff8CFW9P8SscN4uUg?=
 =?us-ascii?Q?BKWdcMLsJG526iFUqjt8meBAHj67y4vDXhs90ohuLGwRqidCIDmoevwyT+yB?=
 =?us-ascii?Q?niNgQxWNC2OxbZsZJhHHAxihtR14Pt4WBvyA6+kWoe16d1KH5Hg3XYZhTSfY?=
 =?us-ascii?Q?IG8bdj8lJUvMYE9bdybtvFhVeaW1JV+Zqz/nzt6OzzgB9ufi9058as2hHZqe?=
 =?us-ascii?Q?QguWqfLDTvUtzMVKHFiCCxXGNGQggUaMIU1QZuMBLDKO2EtJiFqvXAJ2JpuT?=
 =?us-ascii?Q?HZSW7ZmeSb/EPYjjG8or5SlS//Qv80qRYklyhpMkm4lLhWGRZf7KMKGES5nY?=
 =?us-ascii?Q?DZ1sn89ez0rr8uLLDXcBTvGqIl8TE+RMJxkHKerJiseDR9jb6ci8mdj25Z5u?=
 =?us-ascii?Q?/zXypZc64NV8Z86eZVglHZ/vsZS3Ars1dLYsYtMtlT+4pL7QeSAHoPl5/ppG?=
 =?us-ascii?Q?DMTASJ4LsZS9GLVeR2P63QKJn99m8Cn7CFRym+LVsf/6hOOje63ssbt7vKKs?=
 =?us-ascii?Q?dSC1T/Q1pL3zVDh4NhlsVGrl5EAEZZTh5mkDvAfB6//DtqmkPWeQ46ACU+pf?=
 =?us-ascii?Q?V3TR0JN6qrEe0OLMkGffWRjsvF7F6RgbBpDr6ys6UwyLxHbNWU1Z1ZAZpjbA?=
 =?us-ascii?Q?S/3pVKvd/uco1TbZIbX8o9IzAH3U2bwdklWbeYLcm2uVgX9Q7EdajqoOQVlW?=
 =?us-ascii?Q?roLaGJoEo6+Aykp7VxF8YpdXyXIrka/m7v+5sPCc1fhIM3OPteur3/tctrJ8?=
 =?us-ascii?Q?+p1/0s0oOEurPCqdGQjk7wdZUmJGigaJfLYbiRquLwOSImENouhCjbb0JnRf?=
 =?us-ascii?Q?8cHCE5W+NpgtUhDulbSZ/9utKyn8P9T4Qb+diellzFQPda4D6Ye1P/KAvxxi?=
 =?us-ascii?Q?0LSaOQt3fkPp2wWiMAE8cwK0CKuIICJAcNXcsrksfqNX9Tgtlhq/AYUKJ+/8?=
 =?us-ascii?Q?mgIUSKY3AsNalEcYbUfScV2tkGznW7jRCtWcVyiqRoivLPvgYgEOxf9MaLt+?=
 =?us-ascii?Q?elCvb+sXN6Z8fDBNZFLYkbP+qlyOlXSGA4mzm5cQ++ujN9msQTTFGdLrtx4v?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93274ab8-0ab3-4712-841f-08dbc970ab6a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:09:55.4214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNFR55Q7+1fMQl2k/+YyLpZ1XzxrezA/VOtyejBrxh8aEZWUA3SGXjtwn1lNAXZga6g3LTojJUzKX63m1VHgKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9059
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

