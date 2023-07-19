Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26599758B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGSC4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjGSCz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:55:59 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0051FC4;
        Tue, 18 Jul 2023 19:55:54 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36J2rh0b000831;
        Wed, 19 Jul 2023 02:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        PPS06212021; bh=SAO8iLroOVgzOlqjccOfRNV6YP2Lu+8iFsXRtF5fwbU=; b=
        K7DK/DUk//kc+qohTHPIRvTj1Mo4PTLD6ilXVc3kdndfDXcbJdPn4rN1tUrV82OI
        +1LzhUy8+ErNLD+q8locVxJP0RG0fyeVEeRKriJOomGWKPYyfbDVax2841vF32M+
        gedn/6rg5l11MKQuEc7/fYW1UNtDEKE+dpr/jyjzdqY8867b9lPSzWRDbQoeexsC
        GiFvM1aKLatPy8yaBUcR/+BEA9NRgqI5BB/B8NLa3PxMGBS1Rc5BwfZlnpFLaO49
        BRjBjfwZ2EqkZSexvI0bxOkzcrJ0oyq+hYwtBmKqRHkkiiZjzk7gMdcs+mhwq5BU
        rCa12R1qcv5+ata5nh2RCw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3run9ju8mm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 02:55:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdh2+obryMzZnfebTAhh7Xi5Ei72v3mpxmuYE3nVq09ZYjLs/q+qiaVFADi63xtWx7l1S6+lSSdKKTYR0/JVkPqsLOYDPzdZAMe8qDY9UpgbpioK+JyiXGHOVkzzIGfousQJ+TBQyO8L1rRdFi/cYmLkacMb7MBP9qvPPr5ceQfuC2l1e8rWifi3KvGRLImYDiT/bjqCxqpZgDO7goGjdXDP20JwDBSIkEB0SMuDL0CBoNBkAX+81dcXJg0VYPzjCfhRedypyYBeNvBGcM+gQIRKYFCGh82rvNb5HgA5NFRFkYpyobGwRDMf2idYNlCBi15+tgyQupgryT9OcOL1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAO8iLroOVgzOlqjccOfRNV6YP2Lu+8iFsXRtF5fwbU=;
 b=eDBLyTsjbjM0c7WYiKj4FKHsGr8MtnkF+yu86DldicvgRbOljBacxntrEj+0DyWGBim80VjaNETQeDe0C6aqTB0gSdcrzGyW4/3i6c2So8Et45VqG07l672fc2+IjOno+ItS2Zv039GvDGdN7+enVFh4SAmaeLjN0c589QPucWdRxfCOsurQe3oxD74J+UgxEE1RjdCO2tEG+fXyzdAiKDsVTdfQninnLHzlHXs1ercrDErc4cHg5+wmURpeyVUDWCpnNAH4nqQS/lorxdEMaZai+/T7+X542NGCtZz5H30iW78JhLJwdUhllBPoC6YGScGNfAfF2VNAiUPClu/bqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by IA1PR11MB7728.namprd11.prod.outlook.com (2603:10b6:208:3f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 02:55:37 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9%3]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 02:55:37 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dinguyen@kernel.org, hminas@synopsys.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, meng.li@windriver.com
Subject: [PATCH 2/3] arm64: dts: agilex: use the compatible "intel,socfpga-agilex-hsotg"
Date:   Wed, 19 Jul 2023 10:55:08 +0800
Message-Id: <20230719025509.3007986-3-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719025509.3007986-1-Meng.Li@windriver.com>
References: <20230719025509.3007986-1-Meng.Li@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::23) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5191:EE_|IA1PR11MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fe1efb-860e-4a61-7ca6-08db8803a105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Qru2OpeM6ocuFC1wCAXgYI1OyikgZYrUx4ODmq++jaITvhHDM8cSg58wQ5gJXZuEeTIwDBTPwISkAkBDxQIsBfquXlocnX0tAjGoEoq2vjxs1ZU21VFu6i4RRiRK8vate85QsLiG8DI69HNKkM9TS6XdVxH+U9ds2hu7H8nlhdOZPCUzdq5RNf1qxShyzhmKIM9AwthS9JVP9DVmk8SW43tj+MBoVJX7gleBG9eS1Kfchr2pRHPf0y8R0kpiH8wEWeQTHVBHYdmuRTmSdfEhbk3gWOQrN8P3AwGflz4a6gwbUw6LPpTgsS4R4o5O9yE7AzPePW0boBFi42+yRKjVJM88LiVfVJcuv7y/49vUtLRw3tt4Rubl7oNFyFez7WgWA00nkHJSG/KciGgg/qdT42DByO6pvMECkaxb5jCOGLRHUekmiAIwpntdOImmL8MB2jKFxE6SVwDu7ORtio2d6ugQedlR2wFPHRyBlkq40mf11hdpvlDENO6AZ4vTjuEGKfTDsLS/wf3srMaAjEgMXKw/KpF6Fx6tm3AoPi6X+abpw5TlxBdeOgr+xT4z9BUx4oj6KvleLHcCcK+/zB0yRHMAuyhBU1m2F8kHprz0jigcz5Cs4TGsXjkcu701q8W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(136003)(39850400004)(451199021)(478600001)(52116002)(6666004)(6486002)(2616005)(83380400001)(86362001)(36756003)(2906002)(1076003)(186003)(6506007)(107886003)(26005)(6512007)(38350700002)(38100700002)(316002)(4326008)(41300700001)(66476007)(66946007)(5660300002)(66556008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?whi8Hrg/lous9N0PNbNJb8dWYZJ4AgX5ktV5z9b56k4OxvZVlS2R0JEPi6HD?=
 =?us-ascii?Q?+lxsuFfdjC/8LBFRwWgFU4O7N1i8DRmwEksJdMM2tN24eNhXF3vxI7SlvykQ?=
 =?us-ascii?Q?xWsK6anV1YcNP/FUch4qvuVU+eYA2pVDLc/exleV8BwLdRegwbjPkOEsLghF?=
 =?us-ascii?Q?f4CB4bkuf0WlXgSMD2pZUBAJvw1NXE3hU/allScF6ElgDZvDqZ6DeKXsuhbe?=
 =?us-ascii?Q?tvQLxHls1mj8SoPJj30Fty50HcaNQDW7WrHZ0CJ260SN3I2/A8k1WRSzvaB0?=
 =?us-ascii?Q?qILLdDHp1EzYEXuyPkxY2BxeQarLxaBkm30PO8XaxcUm3rgpkI8fEv1qjk0S?=
 =?us-ascii?Q?UG8z6Ib8AC0FTRJbWLBoRiR7mtvfi43IJFt5cannmQjyvdFrMSYUVHJJCaq3?=
 =?us-ascii?Q?S/a1Z2nxBoXm4Ka7HE3mFIePhziCmgGJMCe+FE0DC3JHvJzP+yztcDQgKCuY?=
 =?us-ascii?Q?uKZAvR4qy2HobtPcYmRezUgGQITD2GyCLLid9r7GQuSC9224hViRJ+9u64Oc?=
 =?us-ascii?Q?szKlD/N22yqj2vlAx1V2BaNzLZ2ku7LMkLU84sdDpAk91CFVnCecqrqho/Sr?=
 =?us-ascii?Q?Q/lq/dJHZsCZMdKxVL5ggJXV76UIQ5fTRRwD1A/sfDj73PTU24VfALBbOGXM?=
 =?us-ascii?Q?s8T6MLm0z58fgwQ0LaNVmXbezh/gXDlRCjAzQhD5V2gvE8BYdHkOqJ9EwytR?=
 =?us-ascii?Q?m5koLgOtS22quLd5fD5lR/C9/icTk7YQ+Ql/wopdn85vY1WiNId4bN7EF9xX?=
 =?us-ascii?Q?20OT57Grkq6kfkfkByGGG7vpLaaQkZuptwTbriRjTFRuCcSrwjv0svXyLjGk?=
 =?us-ascii?Q?eSQ2tGbPB0+SPk2NKSY86G0Qvy8d7qmDWnG4ujIMMiYqfj8gLgkhRHwMPk2w?=
 =?us-ascii?Q?Z/knvMuX9F8PnV6xC7pR7x58+pD7wVPna0LVSqv6nlSU5uap/Uy30F0t2SA5?=
 =?us-ascii?Q?xM9Lns3BLIMoDY98FlWIT5NY2VIqPftSyRcFcF8v0K7nXbc/Q19FDdYE2n7p?=
 =?us-ascii?Q?oLAnKEZGl4JsS3qFso4feJN+O/tffJ3oB3JVXSA5hsDrZetutEZeXT2vL7Hs?=
 =?us-ascii?Q?WGDytL755zMoCGQ5kCbi+hdItK6BGfq6JW24wc+SEDRVspd2wQkYEuLsOWXd?=
 =?us-ascii?Q?p7KZm8VN5Shfb9ioZtFVfFXU9EF6qGambhajnOgk0mRLZpWGxX5PE0fIOq+W?=
 =?us-ascii?Q?1exu47N5bmJ5kDAwyEnOE1160NXotupyYy15Zg3qTwrd03U6eh04/3OvbQYZ?=
 =?us-ascii?Q?latyiDOBagGa/CfWZgZLlLZwMa4UsRHIU/tvy+dyQbARl38r5PTK0ZLlKCsm?=
 =?us-ascii?Q?IGyAzEsYckOY8q1/JEaBZS61b2NKVbPWq2HxNZTnrFljLo1A5VQTp7wB5WRp?=
 =?us-ascii?Q?qx6MQJwZoyHAmYupM4O5b5Tb9IhLVCtoJcs0AMGhGsg+anNzgwnB2n/8IxcH?=
 =?us-ascii?Q?uvtT+KgwqR2ED2KTLaWzgaqUz0rTWCzGkhUzyTKNhsuUF5lzktPO8YfVgBTd?=
 =?us-ascii?Q?M+0dWYrheF0tKp2c7fzgkKMwY6iNBvjDNbNvzBdDuRSfMH/3/mnPAkLNKlN+?=
 =?us-ascii?Q?qnvbqx/rqnmTpupVz/rkGtJEW+GhmNi+Zk6DIOHE?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fe1efb-860e-4a61-7ca6-08db8803a105
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 02:55:37.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOag9BGck4axwvtC838P3vXV1qDFHCAiGf7GgT/+D8A6u32VUqckUm1WwAcgKiFmJNvydOOdJ4Hvp/Zer5ms/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7728
X-Proofpoint-GUID: zBSq1ytWI9-fmZPzR0W0oTYQXAUKPic7
X-Proofpoint-ORIG-GUID: zBSq1ytWI9-fmZPzR0W0oTYQXAUKPic7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_19,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=608 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307190027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DWC2 USB controller on the Stratix10 platform does not support
clock gating, so use the chip specific "intel,socfpga-stratix10-hsotg"
compatible.

Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index ea788a920eab..435f1cc52af3 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -490,7 +490,7 @@ usbphy0: usbphy@0 {
 		};
 
 		usb0: usb@ffb00000 {
-			compatible = "snps,dwc2";
+			compatible = "intel,socfpga-stratix10-hsotg", "snps,dwc2";
 			reg = <0xffb00000 0x40000>;
 			interrupts = <0 93 4>;
 			phys = <&usbphy0>;
@@ -504,7 +504,7 @@ usb0: usb@ffb00000 {
 		};
 
 		usb1: usb@ffb40000 {
-			compatible = "snps,dwc2";
+			compatible = "intel,socfpga-stratix10-hsotg", "snps,dwc2";
 			reg = <0xffb40000 0x40000>;
 			interrupts = <0 94 4>;
 			phys = <&usbphy0>;
-- 
2.34.1

