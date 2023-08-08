Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13708773CC7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjHHQJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjHHQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:07:52 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51D376A2;
        Tue,  8 Aug 2023 08:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmNJvy3cHPp3VCGnc2totBIUx8ve43xsQbI6nUKU24trIEA2O1Z5UmKXga1254ZtYLtdg3IjCRufN2QvUYEVl8PvRO2oHnQdN4U5k8a2ptx+Km0f8QlInaxvasrK0DDJnd6AI3AUxpbjm6DXVNq6LJfp1ns/KCKo/ttSMxgPhPH/NAj/+B6T7EaNlk5G0BxA/3bZT9JxaHCTrbWkFLEPLtZoiQzl8nDgjeraER/+b5/dQ6xI8Eqa67FYY8SL4agAyYZR9EZxP1b8gADvq8kHTHoZiIqH4te46oyVnxkibZEElEMRHwqiKFMEh+zPxcFu2wdl8DcKrVm/PwcZ3TiLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tah8vgUSjzEQgngPQ60IeoDkd+XR0LPGIuYXlb19fQ4=;
 b=dZLaWaiGYqXPRPV7eqMQJJTDnMF8zEiSDQLyj8g9DKvdE/FoQng5UnVuTQeWa1Bu9CGVLSLFPRDixReL5fFXNgiMRABbHVCN7zAYdoCWh74/MMiGzICZfQ6wnzab9P2//niakOSqWSQXilyG+D4rOTg5dImIIO3k/TpyZT8CPQs2H39IYUwaD7H069KLg+/SeWlEkDt1Sxi0R/X9zckf6lnR+G1y1ZOKvkwh6h1RQ+CBjki1tSZtfUYZwqsgjPKmkBbFwvrsx5wj63Z/kdpIpdI6nrd2GSSMf2xzZrdlp2BPoA+UfYmU/8Jn7g6HNPxFu9F2oUbH+WCmUav/WWVdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tah8vgUSjzEQgngPQ60IeoDkd+XR0LPGIuYXlb19fQ4=;
 b=FUOCt2v/6Jzj+sXcbySnM1ofip7xEhUNZpN163ee4ZoRtD1/MXNgAqLrJyIE8oOSu1g3cJpSRFwm5o4eSg6rBfioVSrKfOELkXHRZat7kVgqRMHeNd51gDnmpNItyoNW+H3qjYMT/0p2KJeVZHyOr9Bn1p0qE3m2iHGEYcC+wXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS8PR04MB8101.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:55:46 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 10:55:46 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH] crypto: caam/jr - fix shared IRQ line handling
Date:   Tue,  8 Aug 2023 12:55:27 +0200
Message-Id: <20230808105527.1707039-3-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808105527.1707039-1-meenakshi.aggarwal@nxp.com>
References: <20230808105527.1707039-1-meenakshi.aggarwal@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0028.eurprd04.prod.outlook.com
 (2603:10a6:208:122::41) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS8PR04MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: fd287d85-d8fa-47d1-6173-08db97fe051f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lTxMyPg2U+1RLeL84ktvucdEzs0djYGL1qqUvn3AyjPLNtMkFqo7YFt8jRvNktWOTOteTwzx2ifdq95f7rNNKymEEHGIyEyYTFevgvGzY92ycMaMuOzhevrqPMCQTCT1HMGZlQV2prb7A+9zLRdCG4sTrl7wkDMVWzFBOHKaLpBcXX4+UYxadY+urqUMoJCej95G5FUjNbMm4rSBjDQVgYhdsLRbSnTtCKgkVjQlUNz+TUkx8qu9DSQ5fkiFwJ/QUNXTZwUYPt7odxJKEoaLMPqYeN/rOtt69vizIRJwR1itDFEcY2Gb+sSD4czi+W4LxuA3CSenynTRvs2JL328KY6yywHR/xKikXwzMqCRbUwRDwSaoCI6G95UdON/OZ4+GPo9T85df4JWuT4wYMwGClE2A5CLchvlajYyC/P75H05+LkC+/HLEqFpoYp0BXWbiVqjgE6e72tDTnWIM6PXtcAHpU1EeAl5cRwwpKcnBUMQIiCFwmLlmgfx1HQb6bLYtqWtu9XsSdGsN+PxVf89UvxVihYolQ8h58rS9kDLqNEvlBbdkYDN5l1JtQ9922ZUMBGC3uvz13AX2XvUJVd6gSF8oJCxhE+7nlbgBNZ1WIBRzCQtrcW90u3/8aYynQ8D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799003)(186006)(451199021)(2616005)(6486002)(478600001)(83380400001)(66556008)(9686003)(6512007)(26005)(6506007)(1076003)(66476007)(41300700001)(8676002)(316002)(52116002)(8936002)(66946007)(2906002)(4326008)(6666004)(36756003)(38100700002)(38350700002)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHpkdlk1cUFYUHJXdFFCNWEwVlNqd1dvOFEvQzN6M2NiaG9VZ0cvY3dJNVRv?=
 =?utf-8?B?ZjgzMEpNZXZJMmJNdjd6RTlsMDZaY2ptdFJ6RUozV3JxK0pEUXJIdldaRENE?=
 =?utf-8?B?blN6YXgrMEVzZU1CY25LRExVYmdpQ3ZQM1RueGNieU1Ydy96aDJMSDBFSmFB?=
 =?utf-8?B?Vko4MHRWRngrYTVydDVHbkYzaXo5UFRIZmJuU1QwcURjM2Mvbmt0S3lrVWJG?=
 =?utf-8?B?OURiVDM0NnMzZWo4dmYwbHNTMG02QkZpeEZzYzZTcWIydXFtelNuZ281YXhT?=
 =?utf-8?B?L0RrV0daQlNTMXgrM1ZRdCs2dVZKMStXRWxzLzJYYzZMQ2RSNFZETXM0bUhu?=
 =?utf-8?B?QkhHVkhjcUdIYWs5OTlxVzlGcnI2QjdtbWF3SnlVVW1iVkFCM1k3TisrTkY5?=
 =?utf-8?B?dGltck1aU0F6ZjdXQUpmWFM4aU1aVlBTWG4xd0lUNWd1OEpOeVNKNUhoRjhy?=
 =?utf-8?B?UUdXSlhCS21Ma0pHMkNXeXg4MHg2LzNRN3M4YzgxdFlVQnd0Q2FmTHFORU1U?=
 =?utf-8?B?bXYybnVEdlRBOGxwcERmeFBqUFBkejFvQXBwQ2VGbzVHQTI4SVNIY0RiYjh6?=
 =?utf-8?B?UjMrbVljdWUwUGczemtYblgySUtuRG15N2lCR2E2QVUxcUlsbVRyeUFudUpk?=
 =?utf-8?B?aHhqWEdCWGx0KzJxT01vSmhRZ0ZXMEFCcm9QWVZnYlBNTndMZWRUTmZ1L1JV?=
 =?utf-8?B?NHNacG9sdzlENDZTOFoyQXgyc0JkNVM1dGlIK1Y0dDU2VTBiRWppNDFOM0JU?=
 =?utf-8?B?MEFrR01KMUxQekxVQ0VCb01qTk5yd3kzbHBvdXlNWUpORUF2dGczWDM2blBu?=
 =?utf-8?B?NG1oWko3c2FFLzV5OXVYNWtjUDRPa2ZhVEczd2lNL2pIRnVJQWUrR0tabk5Z?=
 =?utf-8?B?MG01QmpleEs4c3JJWStvSUR2NEovTGN6TGQxZTdQQ0hFSDJRakZReDdWOVpr?=
 =?utf-8?B?NENLekU0elN1WUl3anZ4cG50Q3hsdzhhRm4vUlRhdlR0a1JRTWQwRDBxdXZO?=
 =?utf-8?B?YzVuQ3ZYZHNITTYyV2wyTUxiV0thWlpBSzFVdTNqNHRydmp6WFVyTU5HR3Fy?=
 =?utf-8?B?V2FYVENiYTVsVEFLNFlOOW91SlVadmREaDBIUlFYU0JJa0ErV2Z3RDJyWVRS?=
 =?utf-8?B?Q3BTeThhYm9wT29TbS9iUnFlUkhyN0lTb3JFc0hRS1BWMHB5ZmE2cFNLd20z?=
 =?utf-8?B?U3lvU3cxcm5RSEpldlpXMVJvelM0T0VtL01Xck1PaG5GMFdWcXlmSmNLUEJq?=
 =?utf-8?B?ZmZ1MUtVaFIxZXdndnk3TmlMcmRpQ3lTQXZQcHhTbEJ3ZTk4LzQxV2M2Qmsw?=
 =?utf-8?B?WCtrUGZqR28rZWl3ZEJndm9rbzlQbEdNZU9jS3VhY0xuaXhEWVdvemc5alZG?=
 =?utf-8?B?ei80RlBsbnZxdmpENTEvTEhqV2lYSnlybXREZjZwci9ueW54Z2lxZVl4Vkxq?=
 =?utf-8?B?aHdHMXN2Q3E0WUFXRVZTVnB0dGdlb2NwQTNudHhVVVhCSkljWG01RlNHSDVr?=
 =?utf-8?B?NVhCQyszdUVBdE0rNTYvc05QZVVCd05pQmZkM2dFenVvUDd4d3FyL3N0anZm?=
 =?utf-8?B?aHJNK2hZR3l2cCtMWWc5amViVXlVNWtDb1g4SzZhdDRjSkhWVndGbTluOXNN?=
 =?utf-8?B?RlBMNkxIWXJWN0RmazBjME5UdG10ZGh2VDFtN1JTZnRpODBMeEladEhtRGlT?=
 =?utf-8?B?NGl3M01jMHZvdDdkZnplMHhTeUdwTHZRTVN2ZEFsSHo3Y2N0ang1ZGtVZG13?=
 =?utf-8?B?ZGlzNmQ0MUJhSEM3clYzK3RsL3pELy9Lc2RIc0VFVlZNWmRndGFaNkNmNktT?=
 =?utf-8?B?YW5xZDUyZUFhckZ4RDVPLzVLTG95cm5uQm1UZ0NnTXNRVWdmZ2hoc1hISHJU?=
 =?utf-8?B?ZnBrT2hmSE5FMjNkZ0FMU2UydUhkZlB3ZXppdVAwWUM3TG5xcmNvSVNqUW9D?=
 =?utf-8?B?ckMvdDdBM2Q1cVNKbzQ2MlZ0dmpZYWxuaDFmSGorQ2tJZDlqYjFHcDQxK0xM?=
 =?utf-8?B?bWRFMU8wc3ZTaXpBZUJlVVlML1hPaTZqRVFDWm4xdWVsV1V5dHFiM3JKeStx?=
 =?utf-8?B?cU9zQmE4K3JXTmY4bXFVMklCYmh5VHFRalpEa28zdFYzVVoxOWgrbGZDNTNW?=
 =?utf-8?B?NWw2ZzBmeStuais2aUtNZUJic2lsWmcveHE0Y0JxTXZ2Qk93cE5NZHdZaDI1?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd287d85-d8fa-47d1-6173-08db97fe051f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:55:46.8257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGyQ21yD4/br2/5RMNUHEF1gVhwz3mcybMsK9/h4mZ9soPZvhg1V0CRHavB5kk7fKaeDBMkx+P8mFxLC3S+CEEzFV8bvCNHvH3tVHX2p0w0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geantă <horia.geanta@nxp.com>

There are cases when the interrupt status register (JRINTR) is non-zero,
even though:
1. An interrupt was generated, but it was masked OR
2. There was no interrupt generated at all
for the corresponding job ring.

1. The case when interrupt is masked (JRCFGR_LS[IMSK]=1b'1)
while other events have happened and are being accounted for, e.g.
-JRINTR[HALT]=2b'10 - input job ring underwent a flush of all on-going
jobs and processing of still-existing jobs (sitting in the ring) has been
halted
-JRINTR[HALT]=2b'01 - input job ring is currently undergoing a flush
-JRINTR[ENTER_FAIL]=1b'1 - SecMon / SNVS transitioned to FAIL MODE
It doesn't matter whether these events would assert the interrupt signal
or not, interrupt is anyhow masked.

2. The case when interrupt is not masked (JRCFGR_LS[IMSK]=1b'0), however
the events accounted for in JRINTR do not generate interrupts, e.g.:
-JRINTR[HALT]=2b'01
-JRINTR[ENTER_FAIL]=1b'1 and JRCFGR_MS[FAIL_MODE]=1b'0

Currently in these cases, when the JR interrupt handler is invoked (as a
consequence of JR sharing the interrupt line with other devices - e.g.
the two JRs on i.MX7ULP) it continues execution instead of returning
IRQ_NONE.
This could lead to situations like interrupt handler clearing JRINTR (and
thus also the JRINTR[HALT] field) while corresponding job ring is
suspended and then that job ring failing on resume path, due to expecting
JRINTR[HALT]=b'10 and reading instead JRINTR[HALT]=b'00.

Fix this by checking status of JRINTR[JRI] in the JR interrupt handler.
If JRINTR[JRI]=1b'0, there was no interrupt generated for this JR and
handler must return IRQ_NONE.

Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/jr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 5507d5d34a4c..07ec2f27cc68 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -232,7 +232,7 @@ static irqreturn_t caam_jr_interrupt(int irq, void *st_dev)
 	 * tasklet if jobs done.
 	 */
 	irqstate = rd_reg32(&jrp->rregs->jrintstatus);
-	if (!irqstate)
+	if (!(irqstate & JRINT_JR_INT))
 		return IRQ_NONE;
 
 	/*
-- 
2.25.1

