Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26667EFE37
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 08:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjKRHGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 02:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjKRHGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 02:06:50 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2014.outbound.protection.outlook.com [40.92.42.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C56F10C1;
        Fri, 17 Nov 2023 23:06:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhMRhqlaVFj4vqW7JJfFX8Mi/fG+bRkpHxgUb46lPulDrWi90MJDWzAJ+wfLVOD/Eb9KO0a0I2cQN7Y87Ev5CaapG11qDcgSPLqwkH4gr43yHoEIwn89GU6Oa03kDx26SbJ0UO8L+PB+M5HcGT8TDq1ClTAaX+yMaqy05G0Amba7cqKXEZXsRWlh+5pjtJIvmfOn07P0rHWQtyMpwg3X9xgXTy8jBoDcimdcBRBBuD7ug/s7RN8TKzi1q9EeMyx8a+m6Onh5w5ZMKzx8dYsos0/EmJia+NC2wBOiz8Ij44nsvGjE5QqsirrG192bTc7jWz8+jLzQPTBeRrzaeJdwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hlf8FnDWSTHfVTubIk7o87G5BEnajV8kZyL+pd1HgBU=;
 b=NLyufc719oybi3mZpxUYjDyEOBNmI9V1brwUmkvm0oPbIBOZozpCfTIhul2eY33qSVrg8GlevK7X10jJKgsqbmZHyAXVbL+Kk1S/wMgxa1yIwyfFDP9s6LAI/SyfNIpqe7CMmOjSjcUNA5lRrL+QNjJ++l1RvsUIS2cRtfxyFIwcy+ygX2tHQMNsJvD7Gb4XCrnlSJwKUFElVqEFvYYyiRi66YUEkqS0suWoSXu4bsj8rDOlXFLGH4lCTOqrs1gigZZdlZUnrmKoJ7IIfGNjoHKz5JvaV0EQrFZg2icUBlE8vh1vmmLIyJ1raX5I7jsZblkg7AeOTgs/6WEJ5ucY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hlf8FnDWSTHfVTubIk7o87G5BEnajV8kZyL+pd1HgBU=;
 b=XJSLDVvdcTFVC3XqgaxMsPusNNkkIWnUU7bK6Uw5ZNZ1KxYSF8no0fSZXmwG/3HTJbR4OuudDAzb9Tln9d11AjWPsViRd3SmuwV9S+cbzGlbJP4dR10rjeKF2m8pxmTJWmnfWf00oz6dcz6qGgmdo2yfuKfUdUbVGwsLoFywDKjmhNVh2WGCEDcSg6on4fUiyiwFxqiio0HiRInRd3XUp5IhLqj31EsIvhj36GOP3rSqrWcCzA23JiKnUbZRLswzOcwKSK1ILYC22m5DnH3EuhqJ685+MWx4U/mAJXBtASyjsAs155ep2StoIDX99p+B8hin9n7Oe8KNVNWThaZQDA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB5788.namprd20.prod.outlook.com (2603:10b6:8:148::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Sat, 18 Nov
 2023 07:06:44 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7002.025; Sat, 18 Nov 2023
 07:06:44 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Xiaoguang Xing <xiaoguang.xing@sophgo.com>,
        Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 0/2] Change the sg2042 timer layout to fit aclint format
Date:   Sat, 18 Nov 2023 15:06:36 +0800
Message-ID: <IA1PR20MB4953C82499C5D81D2C6A020BBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Dz05Plhc5Z5eVXOB+AzIVt/VNzFMjl7zZlC2aPIOXww=]
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231118070639.244948-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 020369a9-a1f9-4be9-5591-08dbe804ebe7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XR7ek868x8iXNJxAMiuC0y/y5cBxTZe93iDV7OcJEr+ZKALyITe5Wt/Ln3QWA8KohA32DJ/psJAIIu5ssAdYvLvX2AaQAit7hpHNwFpOu2EC/wVs1ABVRxH+7PYWJO4PDj6N2R0Dffe9leG4FeYRKJJMF66Br5rqzF8fZ71NEuM+ckS44yMhfmKAyGXHR+uGUiKa9Lq0VQzBHplHDA6fJr3slYDQjMped4pnd67wIheV8xbeRCFxzmJyGlapIlsA7fnINPNCGJ0vad69yjk9LoSriUC1bgXn2GNuM2zcjPmLXTu+iHmx3A+1Y2GRxV88copOOGnuwkN9WNUMkXJ8zgiJJYzrHtafxQf5Y4I8sy+HFZ3vVxYfH8ZlYz5fpq2La/YuESjiJwensngDEi4/4vSE5nk48FvZaccLQkUOFyeNkIvSa9hxTrZCQPzhJfEzpJAmOGkJDHJ3ihC7354dd065ROsI94WxjRTwPhcHXctBBB13XIKeJGnB0n/osct1NocStehuCK/LYmsXmRnSQFnwqiUs7uny4Ym6k3wPe82upi8JcnF9iHXDsTbWbtW+Oag6A99SLkrXMLZJkHnqvE80pPCWF4+2qeIfDy0bYORr+zfNOr3YXEBpCbIa6QuOT4V6gUC07zZuBhKz0P8j59gFFAO7zUeeZTltXIqeSt0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1BpjE+QZL03cup0jw/cI40zcBR8DqkRhsJwX7qd1zycMS04vGIw82roTpNrN?=
 =?us-ascii?Q?pUWVjPkuDW4XSeNzzqHYMsmqQW5OjP3EB148ZCW69RS4FkV4L+0uJEB1pcPH?=
 =?us-ascii?Q?Sp8FaaNc1/omgUX5OgRzZm9hwmcZ/1D04x/eOjZic/3fvngAvcuxRR4lkfxO?=
 =?us-ascii?Q?Sfs6ADDxSh9Z7YnZIL3WuxgxzAoPlh+Atm18Ukv/jNTT5n/swofsVrM5cGZb?=
 =?us-ascii?Q?0dUAs7JqeqMBKlu4FNM8b7jHhuFSBGLOdn5JtS/Y8zemCwybMtT3jC5hSJ8N?=
 =?us-ascii?Q?UlDP8MDKVTDrnQG3hak85oOkMYzNyMAJ2J/s36HyedHT4HNoW2d4lJ8vek2+?=
 =?us-ascii?Q?nTVNWK3WI98M28K/uyAfnkc4cjARCpzJChuoC/6P+HffvMJYzi5x/w0HfW42?=
 =?us-ascii?Q?Cqb1retmbzuBcMeFzqcu70NWPnNlxAt6Cw3zSwA6CRSkJfB+4xyxqFCaxuUe?=
 =?us-ascii?Q?SSmZjzcHtJjNwwZN7ekGDrUNoeQQDXxNvKWatDGsXkR1tu3RESkr26XTlAeC?=
 =?us-ascii?Q?3mrD7B0oPC6HqU6ZvbA/kWfJMWhpyZIeXKMPaupFYoxwJdkOlZrAvQg2/N2h?=
 =?us-ascii?Q?T9ndCHJAvBuqGoZ4/VVt8T1VSsUE/I3UnTZC5ZtVvQaJhkI0yH+WHNa/pcAf?=
 =?us-ascii?Q?n/9SZrL39py8Tn4t1ewRjuYWmSrr95rfcjIvJT0O5bu6SouVcdsfCNEFFG7E?=
 =?us-ascii?Q?wDs5SM0l1sEFvESHPka30YKZTuKS6AeYzc+IfSNDTNQprlX/bIoPVG5+ecFa?=
 =?us-ascii?Q?KCymn+MrAWcD4NbfbiSNHZ2QpNrFqguT90EdvRTVTJfMxadheVCecWdUVLmC?=
 =?us-ascii?Q?mwCa1iWSsEtMvwLYk2BSI358XAtcGMJsJ+L1H45N17JSQSbMSpIWWqf9rBUC?=
 =?us-ascii?Q?NJtmA4QGrw6t+WToZux4Rg/KrqXGPh6lnIZP5BPkKTnoFeYcE0OCX9pYtolH?=
 =?us-ascii?Q?R2+8PKjR/VyjYnY2rWL5oMjvZSFcyYl16ajxFe8pdgWlaiDynh5w6ptThTt8?=
 =?us-ascii?Q?BEFEWOQtldhVBu+4TKVwvHqANhhBq29j4E0/w6OlVoRB3lpWtadpoqxJfpCB?=
 =?us-ascii?Q?oCylI2/JjED1+p94t3o63Cswuc/oMJIQXKwyRs0B7Co0PObkERWYYdeu7ud6?=
 =?us-ascii?Q?AxPr0zMM5Tz4dSClWOYLhKOtX/jGOe1e04hnvkj8NMKTAyMvaslg4wnbpMyU?=
 =?us-ascii?Q?dGkDDAfnqd5tPLB4JaI7dxeHYmZQYqju3NwlmsHrCUcbAcNosZdu9Qkw55Y?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020369a9-a1f9-4be9-5591-08dbe804ebe7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 07:06:44.0845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB5788
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the sg2042 uses different address for timer and mswi of its clint
device, it should follow the aclint format. For the previous patchs,
it only use only one address for both mtime and mtimer, this is can
not be parsed by OpenSBI. To resolve this, separate these two registers
in the dtb.

Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc

This patch can be tested with upstream SBI with the following patch:
1. https://lists.infradead.org/pipermail/opensbi/2023-November/005926.html

Changed from v3:
1. add all register in the bindings

Changed from v2:
1. Use reg-names to map the registers.

Changed from v1:
1. change the commit to address the reason for ABI change.
2. remove unnecessary link in the commit.

Inochi Amaoto (2):
  dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and
    mtimecmp regs
  riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to fit aclint
    format

 .../timer/thead,c900-aclint-mtimer.yaml       | 42 +++++++++-
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        | 80 +++++++++++--------
 2 files changed, 89 insertions(+), 33 deletions(-)

--
2.42.1

