Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E9B762F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjGZIGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjGZIGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:06:18 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ECF4492;
        Wed, 26 Jul 2023 00:58:35 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36Q5F7QC005751;
        Wed, 26 Jul 2023 07:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=PPS06212021; bh=uLvPtOpV/mQidyCy1z
        yTZHuoSTLrBfpnXIfGTA2L1fU=; b=rU94rEHszoJyzHBl9nPyNe6F31V+uZPGK2
        zRIsEcsRDP6q1cRPj0qRrG2g3Y29/FOfOxz+bW2AzimfIDdnENmKUGeEo3LyUhXD
        ApOgJ8El1aTZQo/yqThlxVaWDNAjI+cl7VeaVWJ+RvELZj1SFJPFnJkotB9mnIbD
        8gLDfgUrBlSP/Gk2I2P9C0sN49x4qXlTQjtfCX7CHC70J/40EA/r9RyY6i6WUz3h
        FN9hN/3qwLRRT3NNaBUkVcnJhe8+7UnstPar9Np7jF8U7sQTCVSu5rQIkJnFQqYI
        t/fFraj+GnExkmuH1ILU36U+qnrv5qPEVmOFmi+n+i9oMVd4Iyew==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s1a78ta79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 07:58:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bujCSScMik6NV6IBQgl+BCL7TwGhyzjcF/qLC0XBLOr9/Sblg5YzL1UHD8zZUkyNdmYaWybN2X6Lbz5TnrUlf4a8YNpQ47kj9thokuJjNpPrCBthMR6FQ1TYV0q8pcTOaAdyD+wSRs9+nfeQ9SkacGx62ZwhT0ME9+sD+FmBfekm9hvyCZexHbnujcUc9QcJRy0EsUZW/0FbLtYNh4tx3TtGypDdXjNy/mMRRxoCFmv3gaT7S1zoD9snkn6OGKuP8AX5kqgsYNZKgzAis8yvfR4JWPXkVfMhZUQlzzYovbLJkNBzN9O1oVYlzyhXF+Z8AGFBs7Dyb2/2PKzdFzDJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLvPtOpV/mQidyCy1zyTZHuoSTLrBfpnXIfGTA2L1fU=;
 b=WLhEUZOTK1lm9wwMmka5Sj07rpipC30KBtcBwR8pBjObgsL+j9u4mZOJvCfHyRE4FjoW33NVxAFWZtYM8zrZNmSDAOUybUdoaIrUmVZnvdJTAealA9a/56VAxOWtBydKEMaMn6c7dB8ZnAr5HOBjyxU7fNfmVRII/Fy9Mc42bW0uZ12LxdUai9z5uPnLDhY9gkDJvRQl0olLcKKDFmvmH/+vRxUHB9Rpe2W+NoKgPik9h/mubyqgNHDzVwi6x6wQdM4HJpwruvOM8x0sApcXk6SU2Isymhc5G97RImSslypniVtM2oUs3s+8jLinrPDep8uq31RPtc3woLKXfNerAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SJ0PR11MB6718.namprd11.prod.outlook.com (2603:10b6:a03:477::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 07:58:10 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::43f3:ec40:692c:b924%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 07:58:10 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        richardcochran@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx: Set default tuning step for imx6sx usdhc
Date:   Wed, 26 Jul 2023 15:57:47 +0800
Message-Id: <20230726075747.1016930-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SJ0PR11MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 412f8d60-a567-4e28-c235-08db8dae0e3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7r+cTx2gHl8rS1Re6jdPrP7nhVq0lMvfewUiBwIo1zxOYmajsHXZSVhBKXqCezb9RNHxvP5M5zhJiDXF5LQDk8ZJ/EGRykT3xPuNFr9eXTVsqsd+k09g5AaaRU6IQavoDoVPIO4pCuCuU+gdhviMFgk3F3Dt3nC4wd8o1BCJ0PLne0iZCEkauMSnZG/jx7kzStzut8p68t+IV9uVihdHRhSR3Sav9LVj0gZ/B64cLnXbvfdDjIAnhlGov7Ip98wqZnEA/TzmyIyDi2etaCuzg88IRluhADm3VZOYJcKQk91qooon/nj/cl23zxN1O1nJs9hPXgOXrCPi6fqQuu/skKbCc/68RsYiSbFAVe2VbXlkSsCqHs7Ccqjci5afxgRb7px/Ei/nbyGG44gbG2TShufqvChSOTgZDp0aaXHVgWqUPWIZNnSeRpMjMPr0wzaINm5VkZdMbZLg85wj4pdkvhGGGIiR3nvkJjDpeGQebx2Hrqltyz1z5iISA3c4kGsmpznh+ifdhN4wvjRLFMiOhVLcRo9tuVWv1dOJaSRuiaPGU9xHUZ9avaJne9syeu438vZOBhb1IrcXg4sbg8GgMq1GdWhlYd4q7B9AAcJT8LIQkUQa9IgXzhTt7FJ4nnUS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39850400004)(396003)(451199021)(2906002)(1076003)(186003)(6506007)(26005)(4326008)(38350700002)(38100700002)(5660300002)(2616005)(316002)(83380400001)(41300700001)(66946007)(66556008)(44832011)(66476007)(7416002)(8676002)(8936002)(36756003)(52116002)(86362001)(6486002)(6512007)(6666004)(478600001)(966005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PmczA/YbkwH8/AuXYJ95ZKiAsGBPPa4RNpsC1rOChz5ElLZnL6KYM6F01f5o?=
 =?us-ascii?Q?xbtzfNjLfvmyWp4zOaVqwswRCD9wBEKaTYiZcrnF6F0Un9V5lXszoWp9lLtv?=
 =?us-ascii?Q?dufHy3hEaBxF320b6jeiAXE4brPagSIykB5nR83pBz+5DWQcHEe1aLAbiSB2?=
 =?us-ascii?Q?UHmqvEse2mYPdINnLCq1Wvv4SQg4+xVePOS084IJ9g+/7ioeMg+23HuiLnxV?=
 =?us-ascii?Q?blOtel6QXL70/fs/faDPDZyCLB9kT/RwQdRBM6m/aL7ARmjA/OZloAkfeRH4?=
 =?us-ascii?Q?uqOHmC2BwrljQqerCS4Et2o7YuVe5P6ieu+sJYw92SyMB0D9x2KZKqXNdznX?=
 =?us-ascii?Q?gU9w3LkQ7/dVbKW8BrQsfoEzgSikKPELSdK2ikBAGibhlNqb143nr5dLLDPM?=
 =?us-ascii?Q?CpqMPQPk4cRlC0ZhB0vn3XU7morRzCS+yJX7Rpl5N1gwNeaUIgL9fJOWaV2W?=
 =?us-ascii?Q?AuMA2OqNhZQ2yUjVgg9YO629bN9fPfFGWZ/Q/qytgSkSOV7jrzoPzrZC4l0q?=
 =?us-ascii?Q?4rtl+Fo4W+e+SZG+syBUvXZm4i+Qlbij1CCaQec/4wBlCx4UXwDww6z/JI60?=
 =?us-ascii?Q?yYItiyWeqRXSTRQKp2um8GIdGxWf7P4T/XWS0iiJ8yEaTDlfr9NbOm2spPOZ?=
 =?us-ascii?Q?7H8iXgHtPq14+36lgGg78UMlMRmcK9q+Z7m25f0kr9y+bAgQFQ1iVhCSmtxR?=
 =?us-ascii?Q?GGNOEZCRB8SJeEOEZRxepTDMUgZlL4Q2x4J0kCzAZGYyB3/oWWOs9hIj3o0w?=
 =?us-ascii?Q?qdLoQaCmnQt2Y0TubUbvcwer5aP5mcllR9o+b9kDVfJCZvVtfy3dfa2LXtiD?=
 =?us-ascii?Q?jrP39cZ71m8DdMxksod0npaZc+Nx50N18mzR0bz7PMoin4GFbdK3eUDjoB22?=
 =?us-ascii?Q?NKVmByH4D9brGlHjewPaEUK/G8Q6CihH/MoF56cGJUqVrKSMA2WJm6I33S5d?=
 =?us-ascii?Q?M9bx0Hzr2sjCahdBLxFMlhGq3YaC+2bBlKtajHegJgBwjE5xbLu4lJnG+Unt?=
 =?us-ascii?Q?6DqIUQMyOL3VL8pwBc2Ll1vGd+ZG5zrsOrIHkprwWiwvU7gX6eb8OPyzupVj?=
 =?us-ascii?Q?RKLAeldLftWllrwzeampzCKL54QV4FEl4oynoYf9jVbNk9RrfvkS18VpCNRP?=
 =?us-ascii?Q?L1F4rbBxdyt4xzHAPykgrdLCEe0Y3mUwJg05VeOZBOI7o+Swhny21fbAEeMO?=
 =?us-ascii?Q?D9atbOuhO/qGX6Jf+T2jg2ojh2W9N5cHu1dHyLPwRvHxtNT3mBwno1uTK5G3?=
 =?us-ascii?Q?DV+jDFZkCEhTlBcC5CharbXeP3KZiLp3gd48TbJoPofnlsq8ZiwWtQ/7JamX?=
 =?us-ascii?Q?LyERmKj5vCrpN8wf5gdkq4i7uNiOgbavvQvLVbwAPVQx7S38PZNftfLNT3+h?=
 =?us-ascii?Q?zxP8NBJzit7ikj8bO8X0PaX3zTnAgv7j4D/6wvRT63a9wDJ6Hrtg0jwvEL4E?=
 =?us-ascii?Q?vkvAEFxHPg7SYVkBOngfaZnpYbyANa9jTKb7PSFBL0BjWwUxaWrcxgcQvAzu?=
 =?us-ascii?Q?w0jfDT7etDBvjjWDAdNvKY5S06P/NchHTwTp9zxsz6eh/Op1NhEc8efsWNr0?=
 =?us-ascii?Q?L3cCCa6maLGmwUUreNHh0wT1xrHsYtVuaHV2VN8D9qqX5i/5uGMxCWgrql3u?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412f8d60-a567-4e28-c235-08db8dae0e3d
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 07:58:10.7996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjieqUQreFgT+5hyDh5KlwBwMzpC9HhIp08wtxFXgV6Ecz/0iOCRMxWYXZkeUlg2KNcNYM4Apti1JuY0w0pbWsv3+ELfvf/URzPWRUbrWsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6718
X-Proofpoint-ORIG-GUID: lQFs_77xOtXgGVGWTMvgs_Om9iP44geL
X-Proofpoint-GUID: lQFs_77xOtXgGVGWTMvgs_Om9iP44geL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_01,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=974 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2307260069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the tuning step is not set, the tuning step is set to 1.
For some sd cards, the following Tuning timeout will occur.

Tuning failed, falling back to fixed sampling clock

So set the default tuning step. This refers to the NXP vendor's
commit below:

https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/
arch/arm/boot/dts/imx6sx.dtsi#L1108-L1109

Fixes: 1e336aa0c025 ("mmc: sdhci-esdhc-imx: correct the tuning start tap and step setting")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index 3a4308666552..5bed7b411a3a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -1010,6 +1010,8 @@ usdhc1: mmc@2190000 {
 					 <&clks IMX6SX_CLK_USDHC1>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
 				status = "disabled";
 			};
 
@@ -1022,6 +1024,8 @@ usdhc2: mmc@2194000 {
 					 <&clks IMX6SX_CLK_USDHC2>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
 				status = "disabled";
 			};
 
@@ -1034,6 +1038,8 @@ usdhc3: mmc@2198000 {
 					 <&clks IMX6SX_CLK_USDHC3>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
+				fsl,tuning-start-tap = <20>;
+				fsl,tuning-step= <2>;
 				status = "disabled";
 			};
 
-- 
2.25.1

