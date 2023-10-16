Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75FC7C9DED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjJPDiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPDis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:38:48 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2064.outbound.protection.outlook.com [40.107.117.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE6BAD;
        Sun, 15 Oct 2023 20:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gpc4rWHwZe+HRaVvSB0iSlr7O9WE1vHsf9/SuAFgK78nfWPqhWhGsXEPezaztZUzI+WP2AFxAGSC/e95NCsTZtbk3ZDTuVac+XzbR0Diter6do79O1RFUpwaqA5r1ls621kdS9Hz1idnpPR5iws73Hyr8GoSoNq8HdWYt7ncpdho3KfcrdUPELemw4AoMbJPENI7Exlgp4+SmVMteeMZeQgI7rN6l2tMEY5aPSu1cL4ewQgVocQ3yhIAx2B6IzmY+RdDvoG+ZmxsLWVgOoru9krcBAvmEW7d9+OovKEhdCcPlC8z2JWa6uan05FnrKzNfb7d1PSAZ1N1MU1ewUAEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j51DCuFonmq3B4gfPdW7pEc4DbnvYc7UPb/9AfL2Qpg=;
 b=M4lGnK5gD5jKPUxR8xEu9vi13Xw1+TlxEr5fKnED+7sWmEQS5vvXArZqOiiZqb69gUVoMAEcBcu2CFHny6h9iotzEDx0SJ/QXwVhnxg/kNB0IQ5uZampTA5CfWMMOAhncISznlXE4pZk63IzldnxoJVMfatuWxscj5VTaC7DKSPw1X3aUpfcIC5cihdeo1dbZJgJZ0N48oCZuugEOAy/16eXA1XNA1naAdcAoVXtgpR4Uv/Ll9QZErlYngd6i3M9yejJ21GvPQ9y+NzGHHINZYlK7o0D3+i3/xRszxDJtnE6QSmUrbM4YuEi2bPlz9dTPext6kSZhkAZdpthsHiW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j51DCuFonmq3B4gfPdW7pEc4DbnvYc7UPb/9AfL2Qpg=;
 b=GjOafQRBGKD9DBx/S92N9Jg31L2M+/UjE3nFAX30mfJK5VMOcvk061RZwUAF3tViLlZR/qQgkUXQH3TDml9beqqHecGc8y2Zy6GoAHFXvytjKlONwno0AjwRgOkIaYwZtDr66pX9mOtqWkws13csidR08ReO84pBTFIuL3Q6w38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB5156.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 03:38:42 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 03:38:41 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [Patch v2 0/6] tty: serial: 8250: Changes of MOXA PCIe boards in 8250_pci.c
Date:   Mon, 16 Oct 2023 11:36:59 +0800
Message-Id: <20231016033705.20669-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:404:a::27) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: efbca0cb-a549-47be-6401-08dbcdf96456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HneztAvfsAlqkTBbpv3gc5DXxz53EtPDME4YUivHOQjwIbB3S1tIlHMD+VUlyoUIhMxpz8/oqPc2SuRAc1Lw0VcZilwBUZkELD8Ph+Sj9So+qoW9z/N1Hu3mrzL+rUQuwRLb9SPug3ahiJMRm4ohACKmSSro0wJjgzPA6Ya9o2mSxMRWUMOmvSqXCQsDsmTKA4xHmHpKQY9Mekcs/kZfJv0cQ6JPo8yY/6G42Z8rH0P5VP/RvlemOKGdhw0+JTVbvD+DPedQBMqx4fvmzhAMzGSd/kCVV+2EkqYDdJu9UcJpoSY+SC7VIvyWLrYkRI1m2I1FUH+egq4My/juI0K43EPY7RM/QbzliLAohzUzSLpHP6ke0voOAehlNNA1Ku+0vPAuFSSheROzeOXIraFUNX1r+acDGaAW+h92B7sVyBSJCTSeRd4Kni034MvSEzBk8YIim37QoPIbo50qWbg1bl9P7Zct3HOkCO/Fy8EbeZFBnyy/p8HLmxI9txnzLwNe1+0MKah1aMXZYQu86NpudDId+RNPvjtZeaURc4hUCHRXjhENphpS+wzKBFYnT8+fLabCHagEgPTlXNx81nOQnbv2tctacFjRFnyfo1RZ0dI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(1076003)(26005)(107886003)(2616005)(38100700002)(316002)(52116002)(66946007)(66476007)(66556008)(966005)(6486002)(478600001)(6512007)(83380400001)(6666004)(38350700005)(4326008)(8936002)(8676002)(5660300002)(2906002)(41300700001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cgql+L1J8s92anCM2aCV6+z4RENhk1V0NcA5l2wCMJKHu3OAn0Hs2hIqzHcs?=
 =?us-ascii?Q?XeBa0zNqJHhC/KrzCh8uBiV0iqP0R9Y+U8/yVKtPg7Kflved2hVWU5OaCVZl?=
 =?us-ascii?Q?6lBI+uUmC84NhHEmIvwRn++ijPTAzqyfHtrIzG1BPUfs+XWitPOROVeznnm+?=
 =?us-ascii?Q?6CEEI3o2sQ2ZGiQu1Ns1NJEyl65rYagHG1DeFPv1LXUyYqBs4s2JfjQsx81E?=
 =?us-ascii?Q?u+FMy5EsMrZ2+RhJOg/MWwijDzINYVR4HaScDbxmBMU4CTK5K97qasgbi0VD?=
 =?us-ascii?Q?okqBfzeh16fYG31mvAcTKQ/PV52WDLmvxokcJM1g8vj2k5mEUQGHtj9LUoiN?=
 =?us-ascii?Q?37OzbagUseibLntldFN6pK8CiS4Bw7aHcV0lzjmLxYDKwrGfpyyrj0YUrhFd?=
 =?us-ascii?Q?3UocMGyUgS0A8QzRkEjTnIg16e6hZ6a2NAKhI/vLpCDZZXZZh40EAQ4XsUQk?=
 =?us-ascii?Q?C6UYnd/KIGHPPzFzHH5G34J1lDzNAlSgExP6SA18gaN5FljxJlO3hokdULN1?=
 =?us-ascii?Q?yOemV77naDekgTQJRv2+5nru/1otbchjoVTAkVIOywq/dK0iC1YkHg7tnjHt?=
 =?us-ascii?Q?1+7rVWCRlJOzSvK/jHSoV69wJqBCdCgoxfCsG++MZvRcIAOTA0CIqKohM/uQ?=
 =?us-ascii?Q?7O/7VuAEZ0J5+A0wrOE/jGdulO3q/APz4pCn3LaPpliblXU7cau2o42EgZUp?=
 =?us-ascii?Q?XQmYyyHEhjK9Rci+wDGfrPyYZrbX21OAReHlf6KOgPTCi/GGl/orT0i4QKuj?=
 =?us-ascii?Q?o56gI7JRE0Lh9x0D0a4rkV8REZftopbxKpiUJc2WJ74w0IPA09tlUAhiGRgl?=
 =?us-ascii?Q?3WQWC/gLvZH9FWfj2JPLMXv3/cWG6J68s8or8ywsdktVvsV04WZkRUJ/tu5B?=
 =?us-ascii?Q?+9Fjo0hivVaP8mBo+Tj4yg5Yy9tkb6qWhcZ//btGZ0+8IAh7C8VOVdUY4x8T?=
 =?us-ascii?Q?IGoGRjn5VVAfEfv4Uo04sCMpUsy6WHvTHtL5SKSMDGGyR1SxszvEufzrk+/V?=
 =?us-ascii?Q?oF3RInBbSsvVbtsIiD0sXtngRmzGFjDA29lvOrQnlue42nVDymqJ33Od2QY/?=
 =?us-ascii?Q?v/irynYMYc6s9i6XlfMCgbltgoYgduTKnvmnyudhn15JROHCn34Lmks2fjGC?=
 =?us-ascii?Q?WL+cRqroNs4dYzz0dxgTOAVGLtLgDg+7sNyOjn5ZQPdiVsd1a35oSc9yKjbz?=
 =?us-ascii?Q?eE2FfPUKEd26Jj+RMoxD9TkD32zjTzwYJ9CB4gJyXFJ3j0QznnL/kS1zrEDR?=
 =?us-ascii?Q?J3bfJQI+TYBoh7YLGqfydS1yKdmfffSXLaZStfC1SgPUnp8LaMI/6/pwOhEn?=
 =?us-ascii?Q?GOwHjJF+kWeDuBUprcVRVVaR9efdFZiUGe779lMyYWtITR++13Mey2oGOheb?=
 =?us-ascii?Q?mMrxeVq5Uh8U9acf9ztTSgEKA2669coGJmnoCMkurPbIp0WrIdMwHURqGqLZ?=
 =?us-ascii?Q?TRftEuF16VhjYSvO8GW41Bth24y+X31Q4YU6vjVsCAxeSDdKPDGogXHESJu8?=
 =?us-ascii?Q?uRmmp0bdQ9FyLZWScuVIax6NOlyGLXiHN6iauIUkLR/Og1mesL3td0esiHvy?=
 =?us-ascii?Q?Wf4/bCNwVu8t2KDZApVZXm+OOja6fhRSR5fjCjVHQBGxkQcjFE2fL8VGtjdH?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbca0cb-a549-47be-6401-08dbcdf96456
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 03:38:41.8400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAcWreQSdGtn/7BdjAtdgLzyBPUKPpUMn7UL/opcuQkgRiBCIDyokdmBv6poEyQIOd29vAvANLVzrWWikbXUGJz3Ur0pnTklYD2Vme3v0X8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patch series do some changes to MOXA PCIe boards in 8250_pci.c,
including:

- Modify MOXA enum name within 8250_pci.c
- Cleanup MOXA configurations within 8250_pci.c
- Relocate macros within 8250_pci.c
- Add support for MOXA Mini PCIe boards
- Fix MOXA RS422/RS485 boards not function by default
- Add support for MOXA PCIe boards to switch between different serial
  interfaces

Each patch depends on previous one.

---
Changes in v2:
- Split cleanup patch into first 2 patches of this patch series.
- Reposition macro list to the top of the code.
- Use PCI_VDEVICE() instead of PCI_DEVICE() in serial_pci_tbl[].
- Replace some C99 types with kernel types.
- Introduce functions for checking device ID pattern.
- Replace magic constant with BIT().
- Sort macros into pre-existing macro list.
- Rewrite set_interface condition architecture.
- Utilize unused flag to represent RS422 interface instead of adding a
  new one.

v1: https://lore.kernel.org/all/20231002015702.30509-1-crescentcy.hsieh@moxa.com/

Crescent CY Hsieh (6):
  tty: serial: 8250: Modify MOXA enum name within 8250_pci.c
  tty: serial: 8250: Cleanup MOXA configurations within 8250_pci.c
  tty: serial: 8250: Relocate macros within 8250_pci.c
  tty: serial: 8250: Add support for MOXA Mini PCIe boards
  tty: serial: 8250: Fix MOXA RS422/RS485 PCIe boards not work by
    default
  tty: serial: 8250: Add support for MOXA PCIe boards to switch
    interface between RS422/RS485

 drivers/tty/serial/8250/8250_pci.c | 354 +++++++++++++++++++----------
 1 file changed, 240 insertions(+), 114 deletions(-)

-- 
2.34.1

