Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4B28053DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346994AbjLELlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346891AbjLELkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:40:39 -0500
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4504A7;
        Tue,  5 Dec 2023 03:40:44 -0800 (PST)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
        by mx07-00376f01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B58vQZt020794;
        Tue, 5 Dec 2023 11:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=
        from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=dk201812; bh=Vlh35DXnLvrDTBgCpYKiq
        dR765fY1hQx5eWhxuIg0Ho=; b=GrFnBAqnmVOpTXXmF7+5P/ynyz5APem9O94h6
        w+SxTrXn4CKDqE+ungwduO6e4KHogR9zR72iYtxve0HZ9A077R6mFbVZ9jfKCRrK
        GdB+sxyesS4CsfEXbDePq1v+TZ/Xz+Kqo7XnyJZ+iORkgAollKHeToYuAQxI0s/p
        bIbmFH+i5WWC/49zzt7iqpBxuM61W0J+fOwL8szFYDF0DdF55fAqilr8nUfMQoKv
        Ygs4WGlVTACJekuDKB9UyHacTwVo9mCUAUt5agpqBr9rvtQhjUK/sBRRYJ4Mvpw6
        KJGAAwnbqY8rT+VIti3bXVWq9tpBujejbtQz0moUt30sZASmw==
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 3uqwhwa7mc-1
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
 b=EwZzI9iSg0LeGWSaxlySZKGGrRDt64kLqeNGheeOjvESVnUWADqsoPsHHxniAzpg4bzhH7bz5D4IHR1JhLsnWqkbOS3NLtA58SHpN8yZcbER89HKIf3QmR8UmSSsm5tGYyDx/sz2qjTgMT63Py8pWaEx9OT4G7U6+VgwDocf+LG0LbLj2UmCaNVuKprdlGg8D02ZNA9n6n5F55kibA5G+rdzmr7f1ZWs3EDh8HpJad0B1a2gvGm6XN0X503pgWnTed7Dz3pFzzx9k1FQ1E/Hi/1hRCTsHMg84fXVTi3JIqQs53ZfmpCOUrIYRmmETHqO3tOR3osIKBQnQMBvP+LMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vlh35DXnLvrDTBgCpYKiqdR765fY1hQx5eWhxuIg0Ho=;
 b=hxmhVCihoxsIFmR40uOspMTTzeZp2BGdOOAnxG7TaMjOvd4m6niXoIx0WobnB8BpzLQvjjKJasmRff8FFSTTZwHLOzVn6+2lGzAN3Q7Fgbin9SPB12VyqwplIOpCtZWsw5iC8b70yZ6CtyoZWHEy3R0BnzR41xOiZvsEr6NfSz1leGvBePR4rbkdn5B66BWqjq95SlKW0l7Y9PJg5wrlcpseIcpAdz+5OXZ81iBfuLoumhBESIomz0rBtBnKZFl/DGhCC3t2QTqs8HnCoFf68fAJ6liWZ9MofIyP62BAM3zjboxVhm0++j/lpvnHzBjqgd+veDBJYQv1tOQMIGUayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlh35DXnLvrDTBgCpYKiqdR765fY1hQx5eWhxuIg0Ho=;
 b=kmqrA2HhlzucvAXG/zCK5g1/hh+dDG8Bpg79sXwtXhujvAqvnkSOz77xU3mpKomuv44rrk4UboDMszzDuVOGuwt09AVt86O5LftG6JZUzkIHJZ1twuw2X6zOjoqqqaC0dEivwHPbpYeESGZO4I+3Q7ykPww9DKMRaL2UmUKjgeU=
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
Subject: [PATCH v2 0/2] Enable PowerVR driver for TI AM62x
Date:   Tue,  5 Dec 2023 11:39:31 +0000
Message-Id: <cover.1701773390.git.donald.robson@imgtec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0576.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::23) To CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1a0::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5770:EE_|CWLP265MB1842:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fefba6-3e40-4caf-4998-08dbf586f203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRWxGTWWezicjsJPX0Y/U1P8HRjE5VZXidZYT2AVbzDRmRLWIMKZFR4VI+HlL+Tlt/e4erxOLNlTfdplt6PKXNSAPw/7gxaagSX17czMnWsES2U+ukx5+uUYvCFJ57DdogOU0cBrNYw5NcQkc5QvdCFaZFT0t4s/Nx2X/Q94WfneEXWAUu3oFzyC2wud/RBL/gRC5qa4YjV3PIBNZR35xEovLoKFfBwZ7LUuWQ02OZNZnjHSdTjeoXqvfVTvuOYaBlynLPLWYR7B3S46WYBUxECOHPMQHT0Xjd/0ZIeijaubug/xTUflKbSJsY9iEDHwG6Ue+aeVpCtW72mHxQDbpiIvJxuqcNlVgjHuxzK1Z+rSE3mOXz7uidipFCTLEfRjIokNHkzn7frMDcP4SyXqcIyTU7q0XtnxRcwg/KJFtc3sjlVcqESHwERU1XiqyWI5mMKLfxFnagqtc3GLujdAkh+d1Q6G4R6BW3Veo6QAirsj+A7RAOfRUt2QfP5knA8gSDMAxRuRxpLkA6+HEvxhkS5YDUrB1GzEgJypYXZHULQ1yo+jbbraJhzc1v6HXWlsdCrs7V2Za4LwLPl6GWJNDJd6vMWqVXhuwlc6RWIgqFpTpPZkVsUGJjh1ygnoXh9n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(52116002)(38350700005)(6512007)(478600001)(6506007)(6486002)(2616005)(6666004)(26005)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(83380400001)(316002)(4744005)(38100700002)(5660300002)(7416002)(36756003)(41300700001)(2906002)(44832011)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qR/GjJNG+GdZnqFY0evfJYzd8Wo6w3OTagGHbPejzHEWctGFF63yzcGw+wqE?=
 =?us-ascii?Q?6/uTi26a24b/9X3QOGvUn5sPGCNA519sLvFVObkXkQ58mGMsPdwvqfF1251s?=
 =?us-ascii?Q?F/H0dZlMa47/DXdjcPkRiW7zUOko9+E4J9uaBRBnmBtyvNoLH9W4EJgWVYh2?=
 =?us-ascii?Q?N5SiQRecCsA8FBXA2Zbo2lNGrL8rqHY1ETzZ04RXi8SGlEXR0hyxZH3pf5DH?=
 =?us-ascii?Q?0kTtoebnBafogViayvG1kbfwfVUvhHp6vFOLMVvw1jdHeUHWutXjahbuedRs?=
 =?us-ascii?Q?B/8Hi3fPgrhfSvp6BdhjHBjvtmwyuS+J6fFJnbtWZKb+l4QPTmcilmH4zojY?=
 =?us-ascii?Q?HgmsIHDGhDWmPYNj+994z4kVFwj0evt8L4CBmj+8V2H2xqBWexK6QbtjFu4X?=
 =?us-ascii?Q?v9mnwErhMRmHLqXPcIBqGa5eeX9iZlCLC+vs0OktkcuZNtFadFencujSbrhc?=
 =?us-ascii?Q?RkTPFvnKbKS3L1vyI9QJVBbwhLBTlTefOwt7zOJTzv2ZoIIlBZ7N15mEGrEo?=
 =?us-ascii?Q?vNZ2nHypwN05gjzLhOEGlolmKvvt+TY/s0mfoBRhz5DaEax3vR90d33oKJSe?=
 =?us-ascii?Q?yER2mTowxTsRwXNiFsrUvrN4NSnlNoHoQOKJw0SZsyKjp0ClaG922tVVydS6?=
 =?us-ascii?Q?fvn6xj4hxX7YkptkYOgXKMZZWAJBdBhQNzod5/ib90BsD3OhxcgEVizVsFvr?=
 =?us-ascii?Q?+kZ82JXqA8Ln42qoj4Z6/Lxf7g13U0hkPEw2xLEsiVE27T2xZiJF2NNk67VQ?=
 =?us-ascii?Q?Hm8/mGU0W3eM6YSZ9MVjwmjcnam0IOgREnCI8x2W/vH7kK/yX5XA7q3IdXJf?=
 =?us-ascii?Q?qcAee9pRYX+sU+neatjdNZRP4NYStF/9TWVIrxwuTMxOuIolhdD002dW4Xnl?=
 =?us-ascii?Q?30B5JBDXQ2znMeUFkr1eLJMoTUfdyPFhaOZ+DzKE41NLtJNQ0Xu7UUngERIQ?=
 =?us-ascii?Q?qIRLLDRj7ZJdDGqYkkiyhqt/XH0JOzCysOB38U49W9C5+n4+ysOXBvVe1Eda?=
 =?us-ascii?Q?tkl5k//JNgARqPRjWsT/+k6FyKmFND6snw2szpkr9Hkzi9enzm1VUNJDJlED?=
 =?us-ascii?Q?B19G7VBcpCvIZ2EE4CvRZ0gLbODyoZdivGn2DNCSYH8U+gWau7JejTV+OZ/V?=
 =?us-ascii?Q?KuIve3MJ4Y0iZhKD+hPqtxy7PnftWVTP8tq2ql9YIgXqxRdCDVAvwczDkB+f?=
 =?us-ascii?Q?M7RIvCRbM0DYcJXuq/aFP3oaWbsJEbGbyhiQrxAlVUXug5gKMp5AjnJ4HGJi?=
 =?us-ascii?Q?5lN/8iSbrNhpNTv7PnMyxoyeUUVNQnkTGpCyGVAhOUu6G3yq6fwar1R47GYK?=
 =?us-ascii?Q?xVjNq3eYBKDDJwz+4O2f1ANcCsOwH/m2FwiVqL7sQKXD2UWWi3/E6+rLExWV?=
 =?us-ascii?Q?KncDHJjaRcb4GHdENQWq7px2XZtEKhe4sjIoyxLYODWUbYand803IRBjfFZf?=
 =?us-ascii?Q?8lnY9+UeiOXXurVoe2YctGyD/W4j00ImLBAu/INV2XmQn8QEI3V7N0jCh+SL?=
 =?us-ascii?Q?MTD0GpclGo8QMhSK3tezI53ycS1gpWZqdFl+sE39/J2OXk7bEDFWK8p+QA5a?=
 =?us-ascii?Q?Kjl3CuBNa7GdchoyFUqR7bzxAi9XRNAu2w5Jm4bDFCUAfspTJvrpgR9eujXS?=
 =?us-ascii?Q?aA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fefba6-3e40-4caf-4998-08dbf586f203
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:40:13.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: que2UfeNolrUcB2WqGV/FZIPbRqSTnzqIqqIOcbVlyIAOh0gr+YPTJhRQsQJKQXWTs8/k8b+dV/7FTdRDM5L/0xgFSAjYMnx2ww6+MijJkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1842
X-OriginatorOrg: imgtec.com
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: xOa9ENM23ekRddMv7zGY_4KQUs2zf7UB
X-Proofpoint-ORIG-GUID: xOa9ENM23ekRddMv7zGY_4KQUs2zf7UB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches enable the new open source PowerVR driver for TI AM62x SoCs,
currently the only one supported.

Changes since v1:
- Added patch 1 for arm64 defconfig (requested by Nishanth Menon)

Donald Robson (1):
  arm64: defconfig: enable DRM_POWERVR

Sarah Walker (1):
  arm64: dts: ti: k3-am62-main: Add GPU device node

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 9 +++++++++
 arch/arm64/configs/defconfig             | 1 +
 2 files changed, 10 insertions(+)

-- 
2.25.1

