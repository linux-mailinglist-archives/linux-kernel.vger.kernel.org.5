Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D886B7E7F95
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjKJR4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjKJRza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:30 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB4D8681;
        Thu,  9 Nov 2023 23:26:26 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA625Eq004259;
        Thu, 9 Nov 2023 23:25:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=C4EpXEiT1z+E/3v8jX
        QSu585NWD9WcV4oSSusR4ALlY=; b=H+8XzdwvXxgNCB+/t09t5JcN7RJv6Azhnp
        g5whg4qYWcQyv2loVlCAdpxerF7wVrpTGZBhtq4flRr3FSkECtRpyl/hxRGV8YV0
        AlWFKMksQteDDUz6yRK01CXKfR1pY8lSz8JTm5O4khubu63n8KfPYLGD6blmI2Oj
        WxjwSN/zIoVoXByj95DddmXOGPPY5+Kx/UNVJu+9lLVwm7RqoMt0I+oxXwCDTF45
        V/EF7dFXaFY9DCsCEHE6Gd3+xK3olarH6WYtNJ7V3iZgOn29qR+h6cUVXWI2uTlR
        9yd7MQ3xXVQRircGTKr+lTQGo9XBUxfKWIh3Bfv0Ff12Es8wCA6Q==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u7w2sjtvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 23:25:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwfNt9kHKp2j7tZy3SukBRNbnYzy/489DL59CH80f+EmFJpv1le3MNxutcybcKV4gXvi0QaVBjRtNr45syz4mfRJ+Nc296NVGF542vlo/inySzuLTQGKrWKOTBOz7MamXetLNnl5wCn5Dy7bFbdGFc/vWZ1cXIoI6yWQGc0OYi8lb5GZL/Gw3LNw+5WySTp3nXcVjZWquucwxW913CoB3tI5IJKP6xmn+LVuwrvZvtt++We+rkKRH+lP6lS413M8GM++HvdHqoWrnV1yuz0CIGv2ltNc2zEtVr4J1vgluc6mzLMXC8RpP4f3PilYNV3MUL6UtiJYYuHqINFyeSOqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4EpXEiT1z+E/3v8jXQSu585NWD9WcV4oSSusR4ALlY=;
 b=Fj4eWjogd3bKEloP31qirIch8OknjQcliKASfuI8k+rWHP9BN6idCZF3OMyJwRIDSx/Ok6DTigKAv8cwZHKYrVB79WhgpWTz6ttVE7Abmzx5epynp5oQFAheNloivL9G5t+h5whqIk/OO0kje4PyCljuykGstYtoA51ZRBK/rKM09srRnxHxW1k70PaKc7ENO+/U0/D3oV4uTKYLD0mcaSHzRwJNPqYdhRCqm62TOlqlhXNw99LumbUKbex6xQjNjLtiInvfh0zfFBZVZ8a2HBGsSVxl6BvY8mUk5kJSbmPczD3x75gjA5umwVfwk2eLJkma+KgnQSw2BGMk7are+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by CH3PR11MB7867.namprd11.prod.outlook.com (2603:10b6:610:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 07:25:52 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::7d7c:4379:e96:3537%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 07:25:52 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, kernel@pengutronix.de, shawnguo@kernel.org,
        festevam@gmail.com, linux-imx@nxp.com, Frank.Li@nxp.com,
        marcel.ziswiler@toradex.com, qiangqing.zhang@nxp.com,
        s.hauer@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8qm: Add imx8qm's own pm to avoid panic during startup
Date:   Fri, 10 Nov 2023 15:25:31 +0800
Message-Id: <20231110072531.1957891-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|CH3PR11MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8594aa-44bc-41ae-e9a8-08dbe1be4516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93f8EMamc/uDFsCTfVV/tyh7UnzN/WWzLi4Np56L/Vhv6THqEt/4LNUX5b8tLoRg6XDQls/dd7s8EK7FStCe8Dl8zpUQAG4dIaI7cjAFQ0HD3W056WlBq1evPefH/+DAEe1EK7zqdmQH8eASxx7U7a7BNGIKTSHlYAHeqLHFvL1hZzWSdLWHVjSiNhiVdrP0evlrhFOG5RzMZWGhDnbjN8tgRU4HLllYYYIbdRG6bPju81fbrdhDYqf3aa42eLYTg01++9NG2PcEMnR1oJT4J2nwMMglBUEQCoHAkZMDvOCm/oi46qTMie0Tosazq5U8opVhKuMtZKetnUcjDfrHYQ7dAtwW9WByHlS/gPCW7IL8qrC+/KQh2qw6SUQCChyISJjvYzMTLXhjgJI3dkakqVgSN3wsCXSR6wC1XUk57XMC3TeqGJlc2fOVId9Xvf8LI8VWsEFvFh2sdNzymFuRffoS8JyiN8EEJPIYBd2tl5xZb6galeNYo1ZFLuBzVv/cGSExU/FSeljEXrV4fcOCT6xZ8EthUWsOhAXth5D9DDYY5KPZYZN3ZErCiEvIYFD8yAz4XNmoKZhbuTFxIODaC0xrG8AG6QZfdoscZobrjNDSvfwXyYQyzvCTRGA9xuUcX2KdDtLUJvgtW4pt5mrAEDWhZWgsBp1BrOCF5+SuU2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2616005)(2906002)(66476007)(316002)(6512007)(7416002)(66556008)(6486002)(26005)(66946007)(5660300002)(44832011)(478600001)(4326008)(6506007)(8676002)(83380400001)(8936002)(38100700002)(41300700001)(86362001)(1076003)(6666004)(52116002)(36756003)(921008)(38350700005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VkKupF71eS7MAD+xIUlRTThKpktokQmMSxYGgfVtVcYjIK1LKyziB9604cwZ?=
 =?us-ascii?Q?HbpNb+P6W+beHWog5dSbkV+4w3oB2tJ2xbG+/TFqlTu/ALieECnScDG+eymO?=
 =?us-ascii?Q?ciKvvrWHhKTrXaQVUpvQq4HKMT/KfaAXDPMQDxoNE3uFI0avm4MhsQ6Hk0kr?=
 =?us-ascii?Q?OfIdoB5QHHfOYrNdaXVa/HC8aKViE78h40Z9xH3eL2u1kJa6ClNJ3/BfS5qF?=
 =?us-ascii?Q?GSevAv76WjGGdKvs+ZWBmpAmz6ZPQyw6Lg9/TYbtnH3F8M3MHQottPOo9W2o?=
 =?us-ascii?Q?GlQbMqamSVMNXhxRKNuvQxA3cj1Hm4ZR0kgaCxmSheJvyZEFJHtJYBhIcgQm?=
 =?us-ascii?Q?Py/6kmMa8MorDUDmZfvdWj7K3cIVCJRZynm5E01hvrkUPf7ojROhmguv6tvw?=
 =?us-ascii?Q?lh3BAjQK3aCHMuTHmpjuUz9sFFodzaPVft0wlAWvf0Nk3arBr6Tq39OodDXn?=
 =?us-ascii?Q?P443nugTPLlMXqzJ5Na4ViXPAqia2tAUhMfjMy6wBToTJUQv75kReD+FsD0d?=
 =?us-ascii?Q?JEfVfZLl1P6wQ0wbyTImC+TozLk8ah/zWx7rBxZ1OQp/e73K1kxkKa30WeCI?=
 =?us-ascii?Q?45P+o7nBLQYRgLzubfC1FtESedTWV7yPXZHtl0uebMYsQZLU8IbCVvTP/sg6?=
 =?us-ascii?Q?8+TyZD+o7wzVgjJjjZ/5U04qpecNuvXrK//y3mF1nxOQ77pF/SZ05siA+vDk?=
 =?us-ascii?Q?XNa6f54ae1XgbdMNXzLTyuM0g01MLRsHnlPTQL58ydpTCWRBhnEJGV390Yu7?=
 =?us-ascii?Q?jKfOZocKue4KAVdxCJyRtodl/RA2ndw15GkSBWvBLw/8VaaY+RPJPd9s8SjG?=
 =?us-ascii?Q?G979NgaeW3PBQGTACVSGu9A1urGwbRRpbhQywpwzNATznIUhwEmPN8s4UJib?=
 =?us-ascii?Q?j0V04xSLimHtFFGG7dslMiA73gzicnBXoJeSVxAWG08jaXxijwrTV40q4Kxq?=
 =?us-ascii?Q?wcjVADQ4DEgF1PZ8p5JFdaTrOZeQWTnNhwV4q5gdmLVymHz4LLKzEz0BvX5u?=
 =?us-ascii?Q?0GaYmZ10BW/EL/bFSSU7ngTnVQCIYvhSl/5pT5MjQRyFBHTxhgqlMqmfa0Z+?=
 =?us-ascii?Q?nvGinBR2lR41GWLYWlwaK23q2eIvyMdNZM9c9QjDY2g2bTzpuyYNuLDKi+LL?=
 =?us-ascii?Q?GnmGbpTQGcVJyar5hhXvJk3jZwf+eS26KXQlPEdVekT2g1mempPSnamhdMth?=
 =?us-ascii?Q?65gGC7mC82KZ7BS/eaf9tdus+Zu3oyMU9KMlQ8FbrPqU38e03G0ypIR5gnnM?=
 =?us-ascii?Q?qydKbPK3dcn0mxYIk7zZg3Kx9HKq0+jMRIL7sRhi5csj376JsyrNsVgCQSDB?=
 =?us-ascii?Q?7oZqkL+el54ict+IAoPdfsjB5aFJ2qIXeWZJxUUn2VgT4Ig0fXMlpxflbqXz?=
 =?us-ascii?Q?lQIxakQyK7iUNQnTjtKmD99NwV3bo0XZiOSYz7ejM8SVvlmtThRMizfBGIpr?=
 =?us-ascii?Q?Yxpl+z+SR1GD4JoK0owp/+862km0mn6ZpFaJPBh0L+2qQFx5Zf39IwlEahWm?=
 =?us-ascii?Q?8q2L8efhxFshBxiUPun1MzcadepcmvfoyppvNxfQAxDIy5zKS8z+6SSUldjc?=
 =?us-ascii?Q?djAh/KfNUSpROtcYn5bYY1hV3Av5fu1qCnHcVGzScgm8vM73Kke5sLpX7a67?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8594aa-44bc-41ae-e9a8-08dbe1be4516
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 07:25:52.4382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTleX98gD/22jzh4y7wBwSENsXAswmuoArtoMwaEogrbYnyNVFzfRdL11v9almshajSab2XTnArSQ5HJoH03oUGhnCpEoQzbLolSJWYW0aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7867
X-Proofpoint-GUID: mk7dMhzRTdPsWlBVbjOXWYEqUvpW9C6N
X-Proofpoint-ORIG-GUID: mk7dMhzRTdPsWlBVbjOXWYEqUvpW9C6N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_03,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=734 mlxscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311100062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add imx8qm's own pm, otherwise the following panic will
occur during the startup process:

 Kernel panic - not syncing: Asynchronous SError Interrupt
 Hardware name: Freescale i.MX8QM MEK (DT)
 Workqueue: events_unbound deferred_probe_work_func
 Call trace:
  dump_backtrace+0x98/0xf0
  show_stack+0x18/0x24
  dump_stack_lvl+0x60/0xac
  dump_stack+0x18/0x24
  panic+0x340/0x3a0
  nmi_panic+0x8c/0x90
  arm64_serror_panic+0x6c/0x78
  do_serror+0x3c/0x78
  el1h_64_error_handler+0x38/0x50
  el1h_64_error+0x64/0x68
  fsl_edma_chan_mux+0x98/0xdc
  fsl_edma_probe+0x278/0x898
  platform_probe+0x68/0xd8
  really_probe+0x110/0x27c
  __driver_probe_device+0x78/0x12c
  driver_probe_device+0x3c/0x118
  __device_attach_driver+0xb8/0xf8
  bus_for_each_drv+0x84/0xe4
  __device_attach+0xfc/0x18c
  device_initial_probe+0x14/0x20

Fixes: e4d7a330fb7a ("arm64: dts: imx8: add edma[0..3]")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index 01539df335f8..8439dd6b3935 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -96,6 +96,17 @@ &edma2 {
 	status = "okay";
 };
 
+&edma3 {
+	power-domains = <&pd IMX_SC_R_DMA_1_CH0>,
+		     <&pd IMX_SC_R_DMA_1_CH1>,
+		     <&pd IMX_SC_R_DMA_1_CH2>,
+		     <&pd IMX_SC_R_DMA_1_CH3>,
+		     <&pd IMX_SC_R_DMA_1_CH4>,
+		     <&pd IMX_SC_R_DMA_1_CH5>,
+		     <&pd IMX_SC_R_DMA_1_CH6>,
+		     <&pd IMX_SC_R_DMA_1_CH7>;
+};
+
 &flexcan1 {
 	fsl,clk-source = /bits/ 8 <1>;
 };
-- 
2.25.1

