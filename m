Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D3975EB90
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjGXGei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjGXGeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:34:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870D9D2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:34:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcIacJxY9Nv42uw+tZXpNYd14R3QbPHun+iSzp0HlFVqXBkH8L3azN734qRDpwx9Wq8tMt/MmV1h4wkHRdirTI7mr6f25e48d8UfGGgxgeWcug6uaLpmxStp93/VHG+WMsogiva+9dRXA3FF2F2sTrhqeZkuGBV1+kGOHz+J4RTV06ixb7LWirVT30Up7kXptTAGSigYCVQN8DzzqvTMSxI4LKAj8AIsk2s0s6TMz/MWDjhdbE/bU0UBWMPlvUX88npy1/9LUS7UqgeATNE+VMLWPIVrN5MmsDutgyCtn0iloZKwf9lA28DZYKrxhWXwNa+Q+1sNt84y2HjpVVhY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oI4tLjdGvrvpQt5r0xaIf/zZnKlkwUrXvNkzmXrngp8=;
 b=VjsXouHqbPn3AgYfhs6aGyaiCAw9FTb0Jpwmke4e0RRmeE14hndu5M8HSywWm7oluQdx1juYP9ad1E2sRLO1CtkHd3CBdLnbDEJKwchqKhkh1WV/LoLlJFJByxNlWpx/Dg6BuZULADFHEB+RcVIe8sn3NIPwloIInnOm/eCkeYP6aX8sLduQjgGHsDtl8JaJdfU5q7MnhFZWxzPeMZc9di/WlW+5E9XiBuRqsL5Zio4gb6LrBppFREGN0KSwdfXOLOoBaiz9AKVmDtxsFiLBjTQx93Gq7dLYA+ocNh2vT1YeFJg/wBONimMuNKZT3uzufFH1RoqCOkuXVIPIv7xyvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oI4tLjdGvrvpQt5r0xaIf/zZnKlkwUrXvNkzmXrngp8=;
 b=gvAUBE6xZTAk5rBiVUxfj8XArhARgyP1Ft8IBNMSRH/lGJB8PP7qNaU+zhwq3/LkSHqEk59hn6sXdABTNXhshNcS1H4nfEtU5XoIijHahfWgoq0RCVTON+h19ZK+g0mT4vPDiV2ZdCygVwHI/+Wh9bCQmICIP09B+uyeTeARn30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9092.eurprd04.prod.outlook.com (2603:10a6:102:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:34:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:34:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 4/8] firmware: imx: scu: use soc name for soc_id
Date:   Mon, 24 Jul 2023 14:38:48 +0800
Message-Id: <20230724063852.2666930-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724063852.2666930-1-peng.fan@oss.nxp.com>
References: <20230724063852.2666930-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d9aefb-eb17-4a15-4098-08db8c10028b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uf4KTKz3XTx3Fbt3WN36D9m9ER8RJaDTJ577M6cLwSYHME3xRG2vgIYiqmdLoBLhRHMvy1CwPXWFB6Y/0f8fZKTgTez1YthDkFqf9mhfSOXtc944uSyDVD0aeUsAa84gy2QEle4rcnVeym9LMhSVRIOz3q1I28/efYNbquQt+0+QOFDCSoPB7Ma7B5QYFBOFQaauuY8uLa+ALDKXj4ILXMVLIOlPjG72QkO51FqM4ASXaxI+lpC3BDHtBiTDmMadJV618mreHwI5WsOWBV5MxKICE2u1chWxlZ/6JK4RYTOz5QtUGr27LwHJGIGRaR0RvpGhKn55z5LgK15GK+CdhmhuQq04Rul8EX/iM4x+p/Cxnd8KYGcYcFEuSgVDsp1pXslyz7/N7Uufh/ZuYokyADXZiqxhOH64Hx3XoqsdmV+cj6TqrKpScoxh/4ZgtT786VT/d7NeKQ/OQaG5PPFSwY63wulHcjCYxORZj4NIVyVWVowKmSeA37lDn4ZbK9tKe06qCtdKQjT+q7pbvwTiisROpRcPPrSSDFbvV0kJY4QeXFHls4bCkT/3uvJx259qUEMKyptFGJM8npCSQZvOlLB9auBRwOaGH0LENs5QF5F/3uLlCaQJRnHEIsXKsdcF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(38100700002)(478600001)(38350700002)(8676002)(6512007)(83380400001)(186003)(6506007)(26005)(2616005)(1076003)(5660300002)(86362001)(8936002)(6666004)(6486002)(52116002)(66946007)(66476007)(66556008)(316002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZKNtOb0P3x5aVD301s0lc3gQc2MzSSU2TVSs2bIbedpfy3RZqfJXTyT9Jt/V?=
 =?us-ascii?Q?8nyTLIUamq6Qjbv+BN01VIXQWiCataV1eO8l3oX6cwwGPUyCzaFQ/VctSC/o?=
 =?us-ascii?Q?btAx+pnj9FRBe0oIVpre29uCdW13wJsHNXkbb3g09tYdxlwA90Vdn1OJkwJs?=
 =?us-ascii?Q?l/O6Yz39cF8tZV9bT+Uk2inmGr0Uv+P/FZyzztJeIaXMvKupEPR0+LWEuRXS?=
 =?us-ascii?Q?XAf++zgm+N7ncg2vfKtnVNCHWYMner9yQ80XiV2tevNBhrqBVK1LkK0ewc6w?=
 =?us-ascii?Q?riVpVXAA+6UIbAa1wJ+pLbSP05GLFjC8NeySba8AuZDrJOFqP1Thx424PHp7?=
 =?us-ascii?Q?hegmmr8JGoMMtEGIVZcXiN0fnOq3lVhiTyJMWmsaxkm5/ais8P3Tq1FPFqER?=
 =?us-ascii?Q?nBUWzzfgp6SSRnc3y7ztm48Wq4JoAZA8xNQMGXoZPxIipGe8Q4NazWPwvxrQ?=
 =?us-ascii?Q?uw/Xn8R4ejCHl0WIY6gcBmLWSm3dcSVEaPxhLsY6rGPYzLWIekp+eVaz9imc?=
 =?us-ascii?Q?4kTumZd/nfkmAu/RgTxfk9aIdPhIyMrNS0gCn8Gjlt1+KLOtcUpsSp9z5e01?=
 =?us-ascii?Q?nSRB7JSbk8vZeQ2WM2QHpLKAG34/PFOw+Y0Y8u9vnUT6lxvbO5rCJ1mLw96n?=
 =?us-ascii?Q?AgLDJ/UlrhtPdXA3e1u6kAVpYyw1spxSR38ws4i4+VTWah4UkiaWlutTBTwn?=
 =?us-ascii?Q?b6aOiJp2V4N+h6OBaaw+aHGqUn6c22Zmm6qyuMYUrUMuHdDnLAHKHuA6ApVI?=
 =?us-ascii?Q?kmaZZrPpRRjhbavJPDPytv2KQonUkSMQCBuaVkVXHphKWcS34V3VSGKwqo2m?=
 =?us-ascii?Q?dUNsEq5a7fzEuMZHfngESAJmrUEeFZDpp9jYTigAKw+TMq8L0EOob5gbJfm2?=
 =?us-ascii?Q?AbarOnKfrGsBFGjf4RtbHyFWlHG/Gc6SZHB4hkTpXbLJpShG7y+fl8+qBPZJ?=
 =?us-ascii?Q?KWDqj50Djc8rKe9cKSmu2dJyiydrudVgE/xFT+FFccentemqwCPuBsQExpFZ?=
 =?us-ascii?Q?h9AYuXU5G2JgiAIwTWoY25BzFVoL5/PcRUUJDQH0/yZzgeOW85ZcZRBALXN/?=
 =?us-ascii?Q?yEdlYF3xsfbhNlgNrfpTC7cTUTHuBHseR3c3O/2v8KJbrJASW2Ew1QoOJzQe?=
 =?us-ascii?Q?HRld5Per4HqLsAWL3JDgcbFQ872CYVrpmXyGPAyc8P/xS0bt4kAzRatF9QV6?=
 =?us-ascii?Q?XwbFIaX0UglOZgz4SvalrCI3qmGS37wBk7iBNKrzikw8TSMeZDtpyVNARmMK?=
 =?us-ascii?Q?tA/7RC8f9zL1W2FKaoy1xmAp9bUNW8/TcJh2FZi6NPun6jhEwFJlJ3iNZv9T?=
 =?us-ascii?Q?SQDNiLyjG5G4amUVc/YsX+jPkHSsErgj+GdJ9V2+zPTYVsHOZuA50zw/QTOE?=
 =?us-ascii?Q?TEobxfwmOLim+t2TgyVLjSROwYm2xYIr4cXdI+Gcl8IXosPHGscu3L3eAv5J?=
 =?us-ascii?Q?elGk8qFCu5LkKw2pPcRx5sG995mYG93PftR+oR1Gja3e4N3Vk9ZH/f8ScYAH?=
 =?us-ascii?Q?tY+/VCCuM10Dmj6qvTns/Hst7RhxVo1VsYBxwYX0xRU/qisZQU0TTHvr5mKj?=
 =?us-ascii?Q?bHOheeYCOiCsCxztAX0HpR+2wG0AQ4uC1gE8yajo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d9aefb-eb17-4a15-4098-08db8c10028b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 06:34:19.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qTahhXhrTkYngFBe8cCxWkRvOpi+a647ayDLCKWvCh5prjdYOwoYuFRsbbeFzjFWhZ+mjW8/euPO5AWttN3VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Same as soc-imx8m and soc-imx driver, use soc name for soc_id

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-soc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-soc.c b/drivers/firmware/imx/imx-scu-soc.c
index ef9103987e76..cb8377670a7d 100644
--- a/drivers/firmware/imx/imx-scu-soc.c
+++ b/drivers/firmware/imx/imx-scu-soc.c
@@ -107,10 +107,12 @@ int imx_scu_soc_init(struct device *dev)
 		return -EINVAL;
 
 	/* format soc_id value passed from SCU firmware */
-	val = id & 0x1f;
-	soc_dev_attr->soc_id = devm_kasprintf(dev, GFP_KERNEL, "0x%x", val);
-	if (!soc_dev_attr->soc_id)
-		return -ENOMEM;
+	if (of_machine_is_compatible("fsl,imx8qm"))
+		soc_dev_attr->soc_id = "i.MX8QM";
+	else if (of_machine_is_compatible("fsl,imx8qxp"))
+		soc_dev_attr->soc_id = "i.MX8QXP";
+	else if (of_machine_is_compatible("fsl,imx8dxl"))
+		soc_dev_attr->soc_id = "i.MX8DXL";
 
 	/* format revision value passed from SCU firmware */
 	val = (id >> 5) & 0xf;
-- 
2.37.1

