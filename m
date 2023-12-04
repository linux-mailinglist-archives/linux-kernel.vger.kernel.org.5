Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31EC8039B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344490AbjLDQIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjLDQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:08:45 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2079.outbound.protection.outlook.com [40.107.247.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A7195;
        Mon,  4 Dec 2023 08:08:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVFIDWcgTqApKTbR54CQk4Iz3NAYjWrBUxIEFyafnbKl3b+iBqXQlofA2GWZMRtigYQP7kN8ISgGtutbopXJ555MquCnPCiEGtJ1B5LYDyxplM9IdMUTO64sq7wEk21aMYxANSi8Pmw8U7yd67JKeCrfM/cgBeHnaQsL8m5GSxXzAtA/HLUuch/PMVhZzsG3xgizF//KRQDyFEQrVJ3YjQmhAeYg/faJt3w2OG+Vd0uT9cu1KhDat13QpvtVjG+93POqAvJ+T6Kxo8wiCoY9wt+WlI4XSzjfrReeLGWQyJL4EcoL2y/h5/NY3owWUUldCQs3RIqC64B8gh8TAII3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17WZZLrXPiTc6z9KaKCI8v7ARF8zmp5q6mVA9M9HyRY=;
 b=bWm4BAV+3cjwvDEOYuua7YnzTtoyoLzPRGvMipzq9nIEwQd49/qbyqNvWhO5Dc+LaGoo47LBwXHIBLHq86d0UwrgspHLpVZ9qC7TBL7R7VXWZSooepzHXvIbgokmdmUrGxq3TE0kc0N/V5fUAUSPYKJKcwy+uovlKVMquLMoLtoupX41rWaixodylfJNqVDaWN1LybtH13vZ1j/9wBRArha/kCAEegKb2Pxgo3MFVL420iNhshFH0Zm9T7XAtDFCzZxNX14JB8z7UwtaScjtos9+IgohPUJ5MY7NR7a3vwJoKS99Iv+PC0QDyZJzWdysgDrRC09km3cDoUHbkon9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17WZZLrXPiTc6z9KaKCI8v7ARF8zmp5q6mVA9M9HyRY=;
 b=TjNgO558c2Kyq6u03itqQT04uc60pyOv0twv/UPLucBmg37nVvIarIfr7exeiFT0AwPjpuS0xEFMjEkJ+HxiVBYoNe0spHoEqlslgNUMlf8ML3SILElCWjpKMshOAGDwEemWB2LOubKRH7aiLXlcosYldjQHxxZXUOYaQZTljHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB8057.eurprd04.prod.outlook.com (2603:10a6:10:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 16:08:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 16:08:48 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     Frank.Li@nxp.com, bhelgaas@google.com, imx@lists.linux.dev,
        kw@linux.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, lpieralisi@kernel.org,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, robh@kernel.org,
        roy.zang@nxp.com
Subject: [PATCH v6 0/4] PCI: layerscape: Add suspend/resume support for ls1043 and ls1021
Date:   Mon,  4 Dec 2023 11:08:25 -0500
Message-Id: <20231204160829.2498703-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0027.namprd21.prod.outlook.com
 (2603:10b6:a03:114::37) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: bee95f8c-3a29-4fb0-aa57-08dbf4e34c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Kyae+7OKKu7rJMuC4BwsCUILq3oxuF+FHMZ9N1XQRDK27pxZZj9RNyeQzHMVfyIlz3DqdrhScgFeG0X4TchwPtMe7T4DboxfYtH9D2PyRXw3anOKksuDkaVZRw46KQD95iOaC63XT+wrljunOsXIlPpZOkPc2CX7958ommL+5nJVcZpAf8F7Dh7YINef2s5zPrntREC+VSlAO9DYt7aD9tGBBJXgkjMqPpp6+sTYfWHFyivujKn0aG/ESQcNyHfmS27apX9bQ6AvrZBa4ELvit3k868pS43QfPUcYxc2TX6eeSRL83WZYgG5mZpcMNFT3tjn5PH+b2L7e1pf/Wz6agJqdWTdfQJFWsJB6+F/tawxYmRd0fV1lcLb04lrvn0JMlH6sxECMF8IgBizNjkUQ3LbApAUapE0r5a8d9AfQrvn/t+PUJHvjCF1RmMPEmgxOH3Inm3jpFKYVm8/4DOb+wnpCjQRuwnoydzWTgnc88jgQ77xkQC8VHxeVFSNKC2hdPafO/NzGx9pjuOlIUerbhRsZ3FM+BWCK9ZT5hZip7kbZuxTA7ipUDfIzK94S+7unXNUSws4j+U/id4w2z0zpVQJGR2+tiLSBkbOWl5/UHj4JQwKNtvsGtsod9JvGTH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6916009)(66556008)(66476007)(8936002)(316002)(86362001)(8676002)(4326008)(6486002)(478600001)(66946007)(36756003)(41300700001)(38350700005)(15650500001)(2906002)(7416002)(5660300002)(4744005)(26005)(2616005)(1076003)(6506007)(6512007)(52116002)(83380400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2SRXxBSjCOTxMY1JmVlwRm7vvjfsk1zpDtC8hIJ5EbBtCgKo9Di3P9NDGdtR?=
 =?us-ascii?Q?N4ztyBw9WN+Kr2WUc5Mh69/numiV0Z7aDTtViHV3h+wqgk7wahNr4XdgcfzY?=
 =?us-ascii?Q?VJkdFvvxyHH0uaZs25GqWsXuLl2HNEvdnzqlA8TjNuRcT0K5xGhqZXpVnR5W?=
 =?us-ascii?Q?Aiqw101IMGu+tc9DvHl1KGrY9BvFC8Ft6JtQ5YnPri1/tOAm7KqNntvrx9D/?=
 =?us-ascii?Q?VL74fT62XzIJ1L5RkMdfYNGBdjOnAv0dIqty7jvF6x92rO6dvVAAI5vTd26I?=
 =?us-ascii?Q?awjHVIAJyG1uvbGSB+rqGkD+8KowBztzejHz2el/C+4C7/v7XiGDVPWwNESW?=
 =?us-ascii?Q?QayVnR7deJQqlE+189wJBrFF9sbe/vMGxT41i58oRFtFN6YJNcRMVsSGfFIB?=
 =?us-ascii?Q?bM8jWXe4SNOaOngybxTQFmr5jPZXr2MhM26FiunMrLNeLFsoWp/HCTmpF6Uo?=
 =?us-ascii?Q?TbZHIF+r0t8m4XfVvUMEp6NzvkU06Xq0oBR+vj4dud/WDKl36Sl85Rh7ulPz?=
 =?us-ascii?Q?XS0Qn951sM51MItWR+H4+N/IX3n6aR7wbfPl/E6v5t5Oj2j+Llee86JnT9JD?=
 =?us-ascii?Q?AcMS3D29mddTWzn2MSDMdjsqHvxvgVDb9RylT2TgPyQrIU4TAtEAQw8z2pC1?=
 =?us-ascii?Q?X1VC6L0ZsBU/s2PzuqstTQY8PjLiwKqNSYJ+HcmwiiOo1InLniPDpkILxyCZ?=
 =?us-ascii?Q?Pp7E0D/uqbNSwetIFjtD2Gr83ZxA0UB7KCiQBJDImp98wxRs4XySGMDoszx/?=
 =?us-ascii?Q?yluWSxRJ9erdTE2xiZxQthWXs+cjdQX6wtMrX6J13kJWQ9D2Q2Jfv8oe3pSb?=
 =?us-ascii?Q?cwQtOwA4pGjgPNtgAXUUKAywxCV6uKNQtsft8mh0JWugKkEwOPhIEEYExulQ?=
 =?us-ascii?Q?EjxuSPgN7pNgD6a7GmK/EBn3lQKbftoN047/KQ3f3UhwmXKwp0Ygpbz0MBos?=
 =?us-ascii?Q?yu5V88ggkRyg3p7aZ+TfHew650AzSORvUlaz46y9Dow8lb2AH+3cFBQBxQBT?=
 =?us-ascii?Q?blAbbAwKiKkXRQUetCYKhLhvGqRFRRT6skXx/pPr7ktn5QgOU199CFEbuVsm?=
 =?us-ascii?Q?arIvtrpikdtAHbdTjH96Mu+F/RGajrJqr4rPT0H2gX2drohWUz6qzfQ7kUSv?=
 =?us-ascii?Q?6Tywhug4FclTUPUxgLriPlaaiQMjmTfOvb2qsquIbJ9CFPXDxpmAKRydN0Iq?=
 =?us-ascii?Q?oUp6aCJuYciF97Ucc15JbYzmvQQyNGNnonJHqwrthFS3FbBeQkkTRSjwUK8g?=
 =?us-ascii?Q?Yauwy7GS/1pEV7+Vmw/mbYaYvYzMaiUf8PmluBy7eLwNF4iAU2Ukx1JlY9Tr?=
 =?us-ascii?Q?VzwKGFQSCYp18ZyMEZjTIj1dATq34kCx5QjojKF50OwUY6a9scg6iNA+YV3O?=
 =?us-ascii?Q?i+tCIfxQBwu/m7stRX7UwikgBBmlIuSgSefZ5kpARtuQRYE8F5QOtEumiJzB?=
 =?us-ascii?Q?NpZxEHkmWUGmvsocUJ4N8/C+zV9tnxCk1MdaVQ9JOfUZSr+3o2hXVLpscjQP?=
 =?us-ascii?Q?S81lchP/qEsnv4/R1hbejBDidUKg+HwHCaijhnUY88zBeebn2IUPau1GQ3TO?=
 =?us-ascii?Q?c76nIepKFrBasGmGanjdOu8hgVW+MqJO/a5/fsXp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee95f8c-3a29-4fb0-aa57-08dbf4e34c37
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:08:48.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fgo3Xcs39dJsV3oqEc2xnlKnFMMQ4R7zmiB6rDOnyhZ9qWzf9OOlv9l2hdjCmwScK9s58421e1vDA5uUpCx+Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend/resume support for ls1043 and ls1021.

Change log see each patch

Frank Li (4):
  PCI: layerscape: Add function pointer for exit_from_l2()
  PCI: layerscape: Add suspend/resume for ls1021a
  PCI: layerscape(ep): Rename pf_* as pf_lut_*
  PCI: layerscape: Add suspend/resume for ls1043a

 .../pci/controller/dwc/pci-layerscape-ep.c    |  16 +-
 drivers/pci/controller/dwc/pci-layerscape.c   | 191 +++++++++++++++---
 2 files changed, 176 insertions(+), 31 deletions(-)

-- 
2.34.1

