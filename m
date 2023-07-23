Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D08275DFB7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 04:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjGWCVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 22:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGWCVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 22:21:50 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3D810D7;
        Sat, 22 Jul 2023 19:21:47 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36N2F1W4009383;
        Sat, 22 Jul 2023 19:21:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=5Y2Ria5M3txBtX/ouO
        w7wluiyGctvuSRVBEBHRtN+oQ=; b=pW1t5TYA2/v7sj1QAgHOGge4scx1/T5ODJ
        4h70KRmE2VPA7cC8vsGGEQlp/L19Fjue4UMpKWSAPc4FovJYzKyZ89Qq9AXmzVQe
        /Qr0NYwmgmuiPr0oGvn6krhv1wPha9+7biRawFPGd6OVZF3wV2aUdSYxprdKyccL
        oUti/xEDC2DFNeFFOX+w4mf5b6zyZThoRRlknSJ3/OLfenTRUP6EqAKYHVEmFd1H
        Y3tiK4fvQl0R7Ao/Ha0B/grOWO5aeqallX/O1p1iUUPRgmAPu/7fS9LZGNL4byJ1
        9PhF54pLAw+yZL9qQcWV5syZNYva5DZbGssbXxZNX5o7DWluNLFA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s0ad00fk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jul 2023 19:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXk/y6V5dWZ0SRrsvqAWHBb1MeSmiDK/8ZQhy5iNt2ePnJwIxnCE/SGYVssvfd2AGnbCqe0Jkma5+iTUCSGAmwCNr5cKNMXAK06PQ0l53YhMWz9F4cA33HTLHhul5kuoO/ksPVXVnycNnvkJx4DHqagY1YQ/9R1goFd32cF8AP2/Wd6AL/1PlMMAxqtJza+JOSvwEoWvzmdT4bJ3eQVemLV87CY2UOCaOYOeDJPdW4hz4dSfKFuL5w2F0wCOKHFCp6BnSaPkgTbXoxe6qciAxRtft1rkYaBfdyNM4ZElafhIRypymd0HX4gcAcK5wqN/QjrhbihgKUISaePV6YkAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Y2Ria5M3txBtX/ouOw7wluiyGctvuSRVBEBHRtN+oQ=;
 b=JeRtd6Fd7N9dQ7zEbFb+M/NlO8DlJ2OxkVOy7/4j1rM4/g4thTFp0Meh69IyjfKHOL9LEGSd3LFlCI0doOO3+/eXI0X38942azOD9qQC76TugiEL9PeoCTynfJ5kFtJL1DsBnnAu2+ZfaJbKuRnZKwhwZf0i+9B2LUeDvYlk4X6WpNQ8LchHJT81EYUlL8RKiu+ZHehYuY5OXlV/wtUPcfpZZSijBPpQIWoRfb5vrITSYs7jWI2RE0YT661nL0Y777XH2hRNNJ6gKTWj4GVxwoJ2X4nBMiLjdnG4nCqubIPfnvfdED25yR+Sr5oIqIYA0k5bBix7GHJSL1Og+fKhzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SJ2PR11MB8538.namprd11.prod.outlook.com (2603:10b6:a03:578::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 02:21:16 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6609.024; Sun, 23 Jul 2023
 02:21:16 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, richardcochran@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: imx: Set default tuning step for imx7d usdhc
Date:   Sun, 23 Jul 2023 10:20:50 +0800
Message-Id: <20230723022050.524050-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SJ2PR11MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 321f024b-864a-4a5b-9dc1-08db8b237df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DrLGKpSKJWLJQrlQnGLQV/+1JfPyxvMtLucP8PhaurAHhPWhM+6nND0xLIVxEL3P/yJknq4wRWh5OQX5yBTbmUi7y8aVlD6NVPOQwASYY3P1rFyWi6EseKTG7wVz7vRNEPGX0thCW09ACzMXxzin039XWvFA7yMymEQbKq21PBdTGDPxKeCcmWAtpFuEgEA6gJo1eB3ZnzVISe4k7xXl+9fNqGd6LE9YNrYqUaxyN9+78RH0BJ8u/PQ/FRseKg6p39E1frdjS7EUfuMjx8bkg/j6JdZHSlzRK3whOJYmTTowhzkMw3y4bV4hyBtduDisPc2PjquwYeS7xLeFHf/cfBGS+pTPD0U9IHCBX2xa/VIiNtrUwh6JTq9afNp9Y2BJmFFjRrUeBmK5BiQ7dR14es7Ji9yzALCI3IGIiV/kX4REmtcQKvu7RNVk4KCGChkNninGS3DK4hLMJg/UMrLsCDlodfPRq7P4O0JMeHgTw26Dyen/5zgMR8CeNH4poPuXBhxKsX8QX7NXh9RJICTkgZKi8Ya1IUnQ2M5tc5tVnOhTSnqKTzGvw8Lj5PQ+Jw1f7olgIK31G5czmUcYQuTPFQ347tJHt1KuTgHiebeL+LuLNWPj2jzzK0Vo5+8ojme7m59svGK8N9NKGdVoeMu1JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(366004)(39840400004)(451199021)(38100700002)(38350700002)(36756003)(2616005)(83380400001)(8936002)(8676002)(7416002)(44832011)(5660300002)(478600001)(66556008)(66476007)(4326008)(66946007)(316002)(41300700001)(26005)(186003)(1076003)(6506007)(52116002)(966005)(6486002)(6512007)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TbkvFrEDF1+pn3tfJ7tnZnw/S4sHKgYoSW6dSewru4HtKi0+RavQowiUtlQt?=
 =?us-ascii?Q?fQ2Ewzer6RO8ROZ0dI4D93nGGhYfkHNORkylLTIlOKpIaMoMNNUurHkMOo4+?=
 =?us-ascii?Q?u0oqAL2VCNfUZd17XcglRp1BcZ81g4R0wNSLvTtzsbOWCXfQFE2kLgqTNl4M?=
 =?us-ascii?Q?mdCowZfW2s1lkdSapLFPcNbQntBoENRBJF+kbnkB1Hdr3m7+b7PLI7/N8UYI?=
 =?us-ascii?Q?j2YXHkNhOJUlRdfSS4kPuMVMx/rgARLBHcyovfnHlvO2P1184JdnfUc5DEcx?=
 =?us-ascii?Q?dONUeKQ/wXjtNcDE7+ordNcLYMcRTZLAGD8iQ2g3A7hkdF0DInnrIzH3w0E4?=
 =?us-ascii?Q?pTxwi1KHtY7aKEWNG0Q+znpGRmG4bvxxtzbGHbrH9J8MM7ev/Hxgwp8J8M9d?=
 =?us-ascii?Q?IoT8S6kwh6dCTgJZSgELlaWNKLJ3afpOl+t9+C4n8FdChEU9DUugoVI7vGsM?=
 =?us-ascii?Q?V3hyTMcvCR4vQ+RQTFOf6ye8CYz+Zas7CsZo1j/BRmBQCI08RStrniMbl64H?=
 =?us-ascii?Q?yBmkSHcRD42dHm+8DHH6CTrNWV/pUaeAG+7S4QoVV+MLr9QzRXstms3hNen+?=
 =?us-ascii?Q?y8ZmtrDla2yhlmxb5N32WKr+QkqnM9A3DYv4vwErgvk1nx6lQhTQ0U3mHhRX?=
 =?us-ascii?Q?4Vc0gnD5VY5YNWZoupeSTCRkMVgtg2/VA3CUgS+k6ACgVwUa4DvLtMbUUKjh?=
 =?us-ascii?Q?4bgU9Dv9+D9xsz63pDFZoVwsqMXgouw5TDnGdjg2CUOdg1Jrcl01hGMnaoCI?=
 =?us-ascii?Q?EeB2YUT9A/ha/Wz6MqYjffCetslua8IKsBThgArn8pXyOtXhfS3jNWFcrfdT?=
 =?us-ascii?Q?TqfSbf3jBbIxjeSvItbKMvuuWv02GydsQPcmpY06xkoHiou4yzWb1EWRA4FM?=
 =?us-ascii?Q?UPQxvFrmQ6g0CBcyCylwHnqb8KaPM82xOsCMqoB4QMVpiYzY1FsU2jxY2C0u?=
 =?us-ascii?Q?FLsI20XsRzrCRCgRJ+n3YoAXEnJv9aMhS7M9sUHeBPPTxylYShp22uOQohK0?=
 =?us-ascii?Q?NB/YFAi5F1d0ZjsA8rhbvNlPol4qJe8cxtykJAmcs49yXk+CG2cSePlj2TUt?=
 =?us-ascii?Q?HubQoPc9B8gi/cwfUz05L3cjOnAl6whAeuHYL77PmbU/4HX0sxN++hrtPitx?=
 =?us-ascii?Q?Tk5sAGUCmP+nCswPaM+XQCMof1yRzQWejog47ZsDvUlXXeGXg7wSYaDJJqgI?=
 =?us-ascii?Q?bCOLIBM2RchgwBqAHVJUQ7PHMNoodSFZ61V3k+cVRTbrFQrTBWI88QWeLI1Y?=
 =?us-ascii?Q?mZCL/fHJnPULbnAfr5IbcvKmyz75iw9GycO/ur9my3ujtMNQHG+bb6fkMfpF?=
 =?us-ascii?Q?yiHHDSNmiXpC7evdRsBZ1uSWFIhUxpUl9gTT2dwQpbCGTHUjJYpeKE+eFQuE?=
 =?us-ascii?Q?t4/ZwqwZ78syNlVTf9To4z9Hq8G4scNj/2T8RHYKMoF3EiV+WmO3vmveduFO?=
 =?us-ascii?Q?udnJd9kLcI0Df2G+sJ41EUVN70YKW+DwtIEBxFK5jedsBT9d9htLhQp9X4dD?=
 =?us-ascii?Q?qyjYTaJ8GG4wWCTD76ChTolTLlds03x9Y6LWxSwQW5OX6qaxTWA9cZUJeDYV?=
 =?us-ascii?Q?3omQQaX8qnBQmbDb0fwdH0toJIPnpq7qehLK2+d7Q251F2NqDsrI0GhNFGDb?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321f024b-864a-4a5b-9dc1-08db8b237df8
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 02:21:16.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UM6QJqQmtq6wshKKVKRuyQNDO6Ab7ZN+lGPaglhHVIAsyjNkla9+PYxE+R/T0d0iOW6Gn7/WaL6oyXsAQgA6BxHt5nXZne1pvlv5bmaKfa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8538
X-Proofpoint-ORIG-GUID: EUaetmmOisk2rCWPeHIi4rXl7raqwqto
X-Proofpoint-GUID: EUaetmmOisk2rCWPeHIi4rXl7raqwqto
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=967 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1011 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2306200000 definitions=main-2307230021
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the tuning step is not set, the tuning step is set to 1.
For some sd cards, the following Tuning timeout will occur,
so set the default tuning step. This refers to the NXP vendor's
commit below:

https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/
arch/arm/boot/dts/imx7s.dtsi#L1216-L1217

Fixes: 1e336aa0c025 ("mmc: sdhci-esdhc-imx: correct the tuning start tap and step setting")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

v2:
  * Refer to https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/arch/arm/boot/dts/imx7s.dtsi#L1216-L1217
    and add the following attributes for all usdhc of imx7:
      fsl,tuning-step = <2>;
      fsl,tuning-start-tap = <20>;

---
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
index 54026c2c93fa..6ffb428dc939 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
@@ -1184,6 +1184,8 @@ usdhc1: mmc@30b40000 {
 					<&clks IMX7D_USDHC1_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -1196,6 +1198,8 @@ usdhc2: mmc@30b50000 {
 					<&clks IMX7D_USDHC2_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
@@ -1208,6 +1212,8 @@ usdhc3: mmc@30b60000 {
 					<&clks IMX7D_USDHC3_ROOT_CLK>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-step = <2>;
+				fsl,tuning-start-tap = <20>;
 				status = "disabled";
 			};
 
-- 
2.25.1

