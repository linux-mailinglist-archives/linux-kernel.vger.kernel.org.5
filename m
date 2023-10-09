Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD7A7BD4B5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbjJIHxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345466AbjJIHxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:53:10 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2051.outbound.protection.outlook.com [40.107.15.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37EDF0;
        Mon,  9 Oct 2023 00:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idPm4MCTwiiSJOBBsY05uUCCldi11EkwH2Sp617cayKv+57EEGY2YBnChNIUxPfOhrGcqHxMiC93Y7He5IQrwcTp8S/hfpzVyEGyjM6Wv5OujMmSNNKcqh8AhGSbdDwayHYFrSauY/MVpR7dI7WVkft+PfepRuIOZr/6/yCbdGcG7kRrn9LzbLopkORRUVwy0vq+8iUQuTbKnb3up5vS2A2taRaj2SKkhB/Aq2gpTHCN9w3GcEa2QddAUiL8x0vTD0MNodXSLUgC5egqtYI6MhpK1dV6fL3tGF6mMI3RN6LKJoTTSfmlJfksBHiDHppYirj27Fkk/2t8Se2f11TMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tLKFM2BacsWaDh7fvFYx6eXHDwE1/JrXmixMgrBVDs=;
 b=i7CVKpsfHRitSUughftZJ/TN2C9o7uw0y7hMFSLCk4uTEXQxV9yPI2qRGPfme07PpwaM3PA5erjy4i1unqBTC5v/vaEYKDGl7PSOoe/uxan7oWK6qwQNdJR+WfTEoniPrp6npLY6AhJd/nIXzUKT1bX059oz2HEzHLZCoqGD0nlB9kVhqQKB31B6ZiluTd+Ryx+dju/0gjENs71S+a94tIoFdOFDU/Dt2xEcrF/hXJpOKnlLXqrrwFDzE1EAw8iiTrk+IfkCyfVYT/eYT1kSkxXPBi+LxpeUWSXrvuLEC76TiTqGSPUxqet5DsOt5RuSJOiWKpRdzkIFOwVhVdIy9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tLKFM2BacsWaDh7fvFYx6eXHDwE1/JrXmixMgrBVDs=;
 b=PdURA1kr0wmo87YdAHpKKouuvDgp2W7UF8KgIbGBpn+7vSdLAymrGKoQa/67oOASvkbzLRHwsfVTsR+tftwZXkRF1/ymGuvj5Di8+I50GcgzfwniV8gQogsg/ilhlHTO3/MiaGfbXXmGnvgBQZXZBHipDw6hz8JqocLdo/J+FyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB10064.eurprd04.prod.outlook.com (2603:10a6:10:4d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 07:53:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 07:53:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Mon, 09 Oct 2023 15:57:29 +0800
Subject: [PATCH v2 3/3] nvmem: imx: correct nregs for i.MX6ULL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-nvmem-imx-v2-3-86cb135c20a4@nxp.com>
References: <20231009-nvmem-imx-v2-0-86cb135c20a4@nxp.com>
In-Reply-To: <20231009-nvmem-imx-v2-0-86cb135c20a4@nxp.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696838259; l=769;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Npmw6hW7naTfx2BO6R44NlcLopRDF1Wg0Qp+/koQzR0=;
 b=VtmtxgsMIKgxm8TnyMb07FRWqeJS7dwCZvm6VZUzrEryNBQ478DIxMXdzVFCYmeKqOHw1W3eC
 BuhRQkqNkZ6D3YnHjmWLIIkGOa3TC0Cv68iPiUVWf4+Qc4Uj1a7CcX9
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB10064:EE_
X-MS-Office365-Filtering-Correlation-Id: f69a7dc6-f67c-4f80-8a94-08dbc89cc3eb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59iFRjOcyVzzOawFWUVsdtYLGtw961WnKmc+/h3DHqozga5sPcXTfU2vvdJefVTDLx3dMXWXsYYEQ4YyXCueeFAdUYhRHtB15XmX+NmfGyUj/hfBBdCJKpW7LWZYleL2xloAnTBUN0nEDufp1uEUD9ZVx2qYk+nGj3kjvNrfKDl+SS5L+GiES6K4r1XU0+BvwZoG3yvqpt5GFbi8GduHUGcZGxXv/Tq442bQmhTM7pcaAh+eI0c6l1VgpdpTfkfb4Den601c2ndEx3fOzj/SNLzDwYkq21YJSYRlrUt4qbzZXyyb9HOjq7bkieY1exWC7+f+8LPP1+U6RJxp+ggdUw5cJ8QymyHchwmK/a3rCWQxc3O37rrz2WRpxUDpPcoOYCRUG+sqsOk9Hjjv/vbtQzu3hfSRHyThQE0d7unW5V9LeQfOMAQR7Xu5TVDeWDjRpae9/PfQrVvcwf9CXg26Vl/megACotUKcZHU6xvIbPb1jft77aywYBWkZqgZp1BORETzkM/HZ/jdUygUacDXqv4p3yBZMg0HojY0a7Q32YR5w4wF55fVaprORLomUEUPbfGi+pXlSvzOY/aD0hcb3krtPAfUDVzs/l2+WkDeedg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(52116002)(9686003)(6512007)(36756003)(38100700002)(86362001)(38350700002)(26005)(4744005)(7416002)(2906002)(83380400001)(6486002)(6666004)(478600001)(6506007)(4326008)(8676002)(8936002)(66476007)(41300700001)(66946007)(316002)(5660300002)(66556008)(110136005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akQ4QWo5dHlyMkRjSHNyNzl0dlFyazhiTlU1UHBZR1d2SlNKWEF5QkV1dTlS?=
 =?utf-8?B?QzZKWkI1SGhBclliTnlKWDdYWnpxTFd1MkhGYXlJallLYThDdFAyTU5hWDZ2?=
 =?utf-8?B?aGlZVTJTZHc2cVJKck0waTFKVVJlZ0Y4bGx6azY0QlgxbGtrQjYrNjdGSjNC?=
 =?utf-8?B?czkzMS9yWEtleUVSL1Z1NUt5bVVDR1ZsWDVHWXFHSUZyR0RYRmNsZmVjV0FB?=
 =?utf-8?B?VklCa2tQZUQ5a09FeHF6MFBpZVo4TXp4TVd1SmxWbVlSTFlmL2dTZU1FOC94?=
 =?utf-8?B?cmdFakFMVEJQaTM5REorV3hqMEcyMlY5aXRXejFvR0dTTVYrYlVWN2Y0aC9D?=
 =?utf-8?B?UjdNbVI4dytpY21EMkpQbTlhd1ZDTzVkcG4vZ2plMXBaNldVeE9KeGlRWDQ5?=
 =?utf-8?B?N1FMdzgwNytINVFSaGNSdFlreHYwYlZjTVdWZ3pBckM4UVluUStPN2dUU242?=
 =?utf-8?B?T1dNa2VZS2QyUUNIZHowdEJnek5iakpJOVhYSDRad0o4TVhiNnJSblFDa0p0?=
 =?utf-8?B?S2M1VjY1d1ZFckd5K2RIbEZITTM4a3h3Uks2YW5QMmVEN00vQTZkMnp3NDZu?=
 =?utf-8?B?NHF5WkY5VGRXQkdCQW8wRnpRSVBpakdlMm5mZnMvZDBXYzRyUTdZdXc0YldR?=
 =?utf-8?B?b2IzL291cXBMNENIN0VzK1FkclVKTzY4SjZLV3hrR1dxek9jTmV1VGZIZjQ0?=
 =?utf-8?B?aC82YnREVGhXa1dKQU04WXJUOHBzdW5oMDZsWE9zTjJ5S2tHR0ZKU3VwRW9Q?=
 =?utf-8?B?QzRxRXNhVmVFbGFaQWQ3NFhKWjAzdEx4ekdCNTVkQ3VOeGYreTBmZm50TnBi?=
 =?utf-8?B?aXlTaTEvY05ZSjJYMHlKNDFjV3RJVER3Y29id3E5c0w4cUh1cGtiS3lDSncv?=
 =?utf-8?B?eERXeWVUQm9wd2lsbkdwTUZjL2haR2JORFFKR0VLOWN4OHB2ZDdDOXFpVHRO?=
 =?utf-8?B?SjJDSHV2eEJRVFdJd09YZFBYd2xLTGlYUjFjNkxXR3NFSW1NT2N5WUtRc2pt?=
 =?utf-8?B?NVpkN1JXOEkzek5lcUk2Q3RIYytPa1hlWnBFU2NUazdaMGlkV0J6bHhQZlZn?=
 =?utf-8?B?QnBaODhHR09zWnUwK0p0azhMelN1STRDQWp3UllYZjUzVUVFWldkS0ZZaklq?=
 =?utf-8?B?dzlnOUkrZjNkSDhuYTgxWGZPV21HUEVjSTVybVdDeVNJR1VPZU5wMmpxQlRS?=
 =?utf-8?B?cnVRbXhSclhudDYvVnlnd2F4cWRSN1FwaDllcnpUYUJtREdaVnFvVWc2SVZK?=
 =?utf-8?B?S3ljWmZSd2g0bFE4Qkl3dVNXcHhBL1VoTUc2NC9Cd1B3RlVHbE9SUlpOcHN3?=
 =?utf-8?B?ZUExZjEreFlJbXhxOElxUTlSWWUyY3M1aytLVk44NlVVcWd0dllHcjk0TVhY?=
 =?utf-8?B?WFYvcGJaazVSTTdxUzRyR3Avem9tYnNTUnVDQ1JSd0hRWVJIcmdZRVZ2OGwx?=
 =?utf-8?B?NzV0SmVpVXhBQ0RYWEM1eVRubWJqandNU042SnBtenpycEU3ekl5bGErTW9G?=
 =?utf-8?B?VDh4UUVNN3Q2NTBlc01JWHhhM0lROWxHQVZiOEhicVIzZTFHWGJ6anZnb3pL?=
 =?utf-8?B?VTFwMXhUS1FEV3d4aU0yVUNlK0RneFIvWjhqeXFwYndSZUEyQ0FEamJ3MGZq?=
 =?utf-8?B?N2JVUHZNNm5OQmgvOTFoYng1enhGcTRabDFhRnQ0TG10ZDBjUzR4RnN5dUhV?=
 =?utf-8?B?WTcwcWwxdUFaT3RoZWp1bTU1UktVTVNXdmJWQW5FbmN2azZNK3pwT3hpSlhz?=
 =?utf-8?B?WCtrME5FaDFZU1ZlaENuREY4Y1hLQjI2TS92amNpZzFPREZlTVIvTVZCWnZM?=
 =?utf-8?B?ZXpNL0hpOW5PUkFkZStPRCt0MVRvTDJoajRPbWZwb2dLZ25NbFQ5Y0VwQ3Bu?=
 =?utf-8?B?eStNSUdGakVFODNJeEtBcks0ZTdkYkxyT3EwbkN2Vm9KQzk1NnhtOU51NThV?=
 =?utf-8?B?cWpBc0NpcDFQWmYwYWZtMk82dlRWdjBHM3NKcG56cE9BT3phaktHOXlDaWdC?=
 =?utf-8?B?TVFwU3NXcllpZzFseDVzMHlMVUtLOGlXcFRKQzg3Z09oYkdGTy95WEFFMGRK?=
 =?utf-8?B?d1IwUU1HWnoyNGY0cVdnakQwZHRVV1p5NE56USs0cnVIVkdENEl0VHVWYmRS?=
 =?utf-8?Q?j/z3DLaKk2/vqTH8bkVA69MH3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f69a7dc6-f67c-4f80-8a94-08dbc89cc3eb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 07:53:03.2326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SD6Vx+hAIdUzXYx5ib2Dy36wpAlFSXznaBhC/H/CnSj2bw5CZ1RUb8TCJkdlqraVX24mmNoSa2bitC/5rHtAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10064
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The nregs for i.MX6ULL should be 80 per fuse map, correct it.

Fixes: ffbc34bf0e9c ("nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 8d30c8bfdbcf..f1e202efaa49 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -519,7 +519,7 @@ static const struct ocotp_params imx6ul_params = {
 };
 
 static const struct ocotp_params imx6ull_params = {
-	.nregs = 64,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,

-- 
2.37.1

