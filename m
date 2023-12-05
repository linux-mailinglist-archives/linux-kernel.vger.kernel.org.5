Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190C1805331
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347006AbjLELlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345140AbjLELkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:40:39 -0500
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42EDA4;
        Tue,  5 Dec 2023 03:40:44 -0800 (PST)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
        by mx07-00376f01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B58vQZu020794;
        Tue, 5 Dec 2023 11:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :content-transfer-encoding:content-type:mime-version; s=
        dk201812; bh=IKsMq2OOA6kmhpTCO7k0XbjaVI/tLrWSYTrh592OevM=; b=iyn
        joVnLtugMAHAwQgXf/qZ6NGLjJEqzqhJZgJqkBbgIS7qPwt+ynNgAnLhJDghz124
        L8CnV3N0BBlZVoZpSNcwg8SU3Kebk7IoEay3TY1wSniN1Y/ve8TBzm4MNgr97E77
        PXWoW5fS8qkLfV8uo2xvEMNclgamgWuuaTXPYF2nLmFY7MDJeOD9M1FRUNbVEEVa
        M06P4RqiGozSboSlhjoHTl6BYc5nm7lmfYOdhReFPHE2gO0KsejRiKLQ6U73AeFH
        0p5FTAULofvkNEpPW9iZV0Vm6I09/2g/7fYwoSrj+PDklerOWTKdajEg+Av6l2Xs
        UET0Gw03iadNi59n4Ow==
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 3uqwhwa7mc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Dec 2023 11:40:19 +0000 (GMT)
Received: from HHMAIL05.hh.imgtec.org (10.100.10.120) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 11:40:15 +0000
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (104.47.85.104)
 by email.imgtec.com (10.100.10.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 11:40:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKhvsaEyGTTU19eJRDIanEWdbhtpUnEvdDAa/xnKirY58hGeOZWj1Yggg1E7b0+RdrQJXOPc4cCji7UE1ZODemFkQQZLDBygiM9N4QDNaovkb4NncVnVgasBFMPLWOyNRdjYJ/OwQt+IVG1iWxLVHuSxUvOSaKFUvr8WiMnIKrKwwjftV4qsCE+FwfsHxH+z0aqI48HXXFtBFXZGjCUSUV3HjaRXLHYwoeIyqqdJJjAq2Dl3La4Ds1XDP4voYry3TOZ6VyJBj3c2lBRlcHjtLoBBVI29EuBC40zDiqPOE2+5NNi0A8jaqR7+uWxYfr9jc3Cazh04kJQv/Kbo54DxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKsMq2OOA6kmhpTCO7k0XbjaVI/tLrWSYTrh592OevM=;
 b=eQyF0GMQBvnBjEpNmjoqTn+6ZLkJupyQZHiWOcUCy6SNeodqk3BE+ZxtovWtFII5h+RsvrdQPQpbut4NNaoU5RKVrRzEpFtSLOCN0NAtqcvLaCZKcir8E9K3I4Reuo3qW3bme3pbv0rgq6xUxJSGY/y2uhZmqXEe2rh+1SFMIKTtWOQSmgNp08IdDuesx7NB3FdHqVczAgbkQgNBDfCH6LigvKDfZF/zSbkbIMvl7q6BmlGK1/R7pPZvXo/488ezQCeXtnGPvmlJBrxMLQbZh1fd6Q0FC8rDJmJqCS1ZtwLxlj0MBvB3dTM5MLyVsKG1ICvI7TRLHOzyyzjDxMQDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKsMq2OOA6kmhpTCO7k0XbjaVI/tLrWSYTrh592OevM=;
 b=gBZ29xqgbPYLaslViZj3EPfbIAYGP1VZ9/Bt5RuJuMu4gSRHM9a+g1ts+JvFmqxDlKFt3ZeQHcgm7w7RJJWePhS0EM7n8CNDaQvDknl45V6p8jAJpynPd9t54vIjOvn5juJ6gJ4YlZwzFCY5T/+Z237YcF2I9oUh6qbVmHc6/j4=
Received: from CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a0::8)
 by CWLP265MB1842.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:40:14 +0000
Received: from CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a85a:76f7:c085:2b34]) by CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a85a:76f7:c085:2b34%3]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 11:40:14 +0000
From:   Donald Robson <donald.robson@imgtec.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <frank.binns@imgtec.com>, <matt.coster@imgtec.com>,
        <donald.robson@imgtec.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
        <konrad.dybcio@linaro.org>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <m.szyprowski@samsung.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>
Subject: [PATCH v2 1/2] arm64: defconfig: enable DRM_POWERVR
Date:   Tue,  5 Dec 2023 11:39:32 +0000
Message-Id: <2f6af3ebfe9e36c80c03de2dcc2e940dd5dc2c4b.1701773390.git.donald.robson@imgtec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1701773390.git.donald.robson@imgtec.com>
References: <cover.1701773390.git.donald.robson@imgtec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0576.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::23) To CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1a0::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5770:EE_|CWLP265MB1842:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cdf8ce-5db7-4683-0916-08dbf586f284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BM3Z1kA9MBpOLLWKv0+7/MIkrI1hmmAtvNFN5r5wBsSa0LwwPYRyT2a1FfHjhIYb+YSQgeUBtaFlqqAnl0QLZ36Ol18h0V9tDh2vBoQDl0zJeDAiebwpWMyYcEQJ9mzEDpLUawcNJwXwDDZxUGxuBqClYJY5InrhrkEEFnB1nQ94ZYJahb+82WnTlz2mmMBI5HzL9jOKx1IyFpPiCJZdhuSUO29o9b34ElHoArP/rpvJd/3/zTV1BL+2RZSdcyBVYhm7vVf1P3GSRJlp4xocvVjBSZbqPvcgMza/Wc96Tfp7pCevQ/TYIDX7mdzsDNNAiyQKBmo64xJO/GfQAZLNXoJ4reubso/DZR638nfqhg6Zug10o23TBJLXwj8pvC3cJi0PidvwBOAnlD2kZ392zfcThJTReV5rOA3ZZVZiIHuSbkfQgGYHfIraa9afaRPDE1lQiS87Mvsa+D6KCaHwNjRlooWM+8pPmrtirn5nbhPSPSFfTyRqYWQJ5QmCWscuWgTL2kefhf7KeG9aXMAPf354898uuAEWLj5yeGjh0rhvXqMlEb9mO9k5WOVS0VjMyvLsl/POEigxM7ruZsyF6tAfg88CDvnHZCDe43prBTeLTlXZjbxXd9nWuiwqCzeO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(52116002)(38350700005)(6512007)(478600001)(6506007)(6486002)(2616005)(6666004)(26005)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(316002)(4744005)(38100700002)(5660300002)(7416002)(36756003)(41300700001)(2906002)(44832011)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aGpjY+5e/EzaO4VJKMh8l3j9Wq2FcpUa3fpBmhOcpNSGBX3cQYAlWVShV46M?=
 =?us-ascii?Q?yOS0kRlNyk3jh7pKYvspbVh0p41aaaF717v9ygmmjUKprNsxIz8GBMVIUGG5?=
 =?us-ascii?Q?r+N3Nq25YPtFz2QEkcmCTuvpzOxcjKp8OXuh37ke3cDnvEDrh4+PgKa3/haj?=
 =?us-ascii?Q?ev2KvlixuxtbPquxN2pUiXi6WZjJvSos5GnOJbFnKeQt4r/c1Ul+UvayrLnJ?=
 =?us-ascii?Q?pcn4Ye3DKFHCgjPgf7befQyyQ/X881DtbQcq6Zl//EY8AeZFZ3hGVFqkODBC?=
 =?us-ascii?Q?nvRURRfk4G+UkvLUHRDfp3CKmf35HLQsfkZhOXhKzj0kVBSZwQd1eKCIvkwn?=
 =?us-ascii?Q?qIsfE7R4Em5MXar5lH+5GJmkzNnrk3yvJUZJ+w5Yae1nXCVAB+iTWMkdg165?=
 =?us-ascii?Q?+pj2EZf5z1bNngqX3nyxLrEg2etMgcMlrxP4nQR7pkc3q/U2YKhYzpSkm2KF?=
 =?us-ascii?Q?2UAADvbBCna28uvPOustemka7ZHTtOPSKLtSh7X/RYWM0JbWGFt80hrkPuMU?=
 =?us-ascii?Q?u2cL2MKw8WQQ2bF1pu/+4ZAaZEAlgyED4SP80gZX1H8ufrjnotMddB2176KN?=
 =?us-ascii?Q?8n8gmVrE49quUwy+irIbo1RC32Yyjvuhs0NTPgUvFQw9l/R7fwGGBAxtf0JO?=
 =?us-ascii?Q?1IrqlSiSBlstjARJM3oEqSqQyQtVfiib/+HU52NygMRPX+wCfP0BofanXH63?=
 =?us-ascii?Q?15P7T9LbuL0IP5bzOffbqU+RphK4PykilQ8qMvK018jCybZC+G7ydv9X9+ZZ?=
 =?us-ascii?Q?W0ec5dxvnCGTz8t3um3Q+dKdPSS3FRoSvf9EmfdV+pfx42twwQDrQkxVhjKP?=
 =?us-ascii?Q?I/mYHFCOFkVDKvHNkcTthgfA4bU68hGDjsFNYnQmGfAc9c1cUmgup5KMmSL+?=
 =?us-ascii?Q?MJ6UIPBN5qTDavVzE3okFhAfTntMUM2CFdNcZmfYb41FVMWswufE5lT7GGBJ?=
 =?us-ascii?Q?NE7w7gLOCjtpKS5oWGFasWzNXzh1wSVw6jvrDQe0G1OAvckDxXMIKKkBmW2k?=
 =?us-ascii?Q?d0kEPHxAg7u/Nbadw+LUkzY4zgl0x+6n0Ka5Qr3MXgCJXUthNOk6N2tvngTi?=
 =?us-ascii?Q?NAqOlXQQR1y1moi7E2SSU5vIdLMThi3LYFs3sMlaSIR/yYSPkTVmypl7zs0H?=
 =?us-ascii?Q?+mpTAttZQCer1jdaXwowaZ8ub2fIl1JyQ7hSgSeNrDtEwwFUYim7H/akNEBF?=
 =?us-ascii?Q?WwXMVGZnJQKmAu3MuLSGyCqmWK9fwVpTr+vWwQ4jtscy5uIvAJxbDqthtMyg?=
 =?us-ascii?Q?BBweZ4CQkCDlms8KdLdMQuOH9XoVXKmOPURaVvyEkpJEDdsKwUr9qjMFn75V?=
 =?us-ascii?Q?QBEW9jP5U2I9cCKcJ0fPqwCXEcnN2tYjp7eWybysmvROWU/m5l5q5IcqdP71?=
 =?us-ascii?Q?5Ay2Ywpz5PyhRTEPfpd1W+SZIMgQ9ZaLRZ+1LSpYvL34j38DamWlQDPoyCCv?=
 =?us-ascii?Q?2QuYPwZ7Zanm6yKZ89LQlWILsLA5lBY3ALdNnkxv/z2Um5E0wYtKj4KRMW/p?=
 =?us-ascii?Q?Ov2C//ZLmA8Ti3AiGeNaaZSjg5uingZOLaTCPc1UOVdITsJljsFGuIDmGxMU?=
 =?us-ascii?Q?7Z92xFejqOa5VXHH3OsaMWfk4AWrNx794kvwjqj17i+JypCqd8WI1Ro+sL5s?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cdf8ce-5db7-4683-0916-08dbf586f284
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:40:14.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qe3KD1EW2JQJHKHIi4+5oBS5/c9wqQiWjbneSWOXGWy3MZm08NLGr+OfgJwAZsv0QQ34moJL6nXWC7NXhCDGDYRlTfUbMNpAKBZvurHH/rM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1842
X-OriginatorOrg: imgtec.com
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: 13WpuXxrs7iWGXODb-ZXxiKRattrbX7f
X-Proofpoint-ORIG-GUID: 13WpuXxrs7iWGXODb-ZXxiKRattrbX7f
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the PowerVR DRM driver, as it's used for the GPU in platforms using the
TI AM62x SoCs, such as the TI SK-AM62 and BeaglePlay (2023).

Signed-off-by: Donald Robson <donald.robson@imgtec.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b60aa1f89343..85e55b13b114 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -885,6 +885,7 @@ CONFIG_DRM_PL111=m
 CONFIG_DRM_LIMA=m
 CONFIG_DRM_PANFROST=m
 CONFIG_DRM_TIDSS=m
+CONFIG_DRM_POWERVR=m
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_EFI=y
-- 
2.25.1

