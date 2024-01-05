Return-Path: <linux-kernel+bounces-18372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06195825C28
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837A51F240EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3523D35F12;
	Fri,  5 Jan 2024 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VvkhSBoB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2103.outbound.protection.outlook.com [40.107.243.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54D35887
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0Uu4oRwQ+UqSvRmDzx/WkbNuB5jrFMKtg67XCpbnHFAkPM1l4Hmtlyr1UVguV1XXbaZkhysZq3+7XSmvsLSCWrKFM2Ww8BvC2IPPEoy1vE4llgLBRwDskv1oT6fpshvoSXRLFbEkqdzv9wedlXrXWiJlt37ttbZAXzO9aZ85DhCDb5OkCtl8WSARg1/71yHZCioeq6x7QGSo6ZVEiOGmATE8HhlQZJAYGBCK8pSYaleAK/9LeLc7bgTv7fFWYruCba6dHvVlE7r7hHkn5vUqerBIDsvInYJZ0J6ZN0nMcq1o41b/zjts2v+BrKvoXmBluLzco5TRMQCvMuD+EQbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZWEWWFKDh1CUtjz4V/c6SskXpSsThuamXXd88vx5Z8=;
 b=dBteTILC4RBYkOzy4+NBlC9XunhEspmEuz/Ec/oDPUdaCSvU+R4dZSm+S/bQXq2uFDKDGzoMt9DclRMv2PX2P0p7cZKqavplyO0KKTHdo8kt750wLX/b2+pWT9BeBQ9kSb9exiCdl+OW9b2tvvjVyAbZRfxy2cU+em+F5nVyn0mkgA2MFDT1OblFI1X2bOW35JgmfBGFiv2uY55MbW9t/ISppnDrfnfbFHkomp30cNpdi68zTbhmAQo0A2V/pq8f8FiSEBwpT1yyQHQpb2I2TWo6NCNqkkaIdRd3aXy8A7kW80CKsqubGKpIj5sX2ytL4JjVml+AspwX1YsrNkH2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZWEWWFKDh1CUtjz4V/c6SskXpSsThuamXXd88vx5Z8=;
 b=VvkhSBoB84n4A9Zraaj75gn6sE3uss25jLomlPuBeltNR3rh5DHrODre+Lf7smN58rR7Cb9vlb8GeCXZubYH5/4cyku8Fm5sK3dXE18pZ964hv9xyJbYExPLDY4ww6umVaA94rb9F6G6nke4oYJtLt3t8ulmt8xAIHNkTWLtnGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 CO1PR01MB6598.prod.exchangelabs.com (2603:10b6:303:f8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.17; Fri, 5 Jan 2024 21:33:20 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::5549:ab3d:70af:8693]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::5549:ab3d:70af:8693%7]) with mapi id 15.20.7135.023; Fri, 5 Jan 2024
 21:33:20 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Raghavendra Rao Ananta <rananta@google.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] KVM: arm64: Workaround for Ampere AC03_CPU_36 (exception taken to an incorrect EL)
Date: Fri,  5 Jan 2024 13:32:51 -0800
Message-ID: <20240105213251.4141-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:610:cc::27) To PH0PR01MB8166.prod.exchangelabs.com
 (2603:10b6:510:293::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8166:EE_|CO1PR01MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: a0108a2c-cfc2-4ad8-a3e9-08dc0e35f00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7OnFLaLk4d4jYXCFmiaN33mtkRqAdFPyKNULG0ABpZbI/PIxBKEQD7wunTJS6B0oMcmMuLYtmEp6EmHQB20a8p1VuVGSr9naLlxc+tRF8VP1Gf3/G26p6e2h+SbYaxlaHI6ZaOSNrUDFF0u2wrfAhO/I9YBOrRNvFayPtYji/RI/YGD/9A9hB5e6DavinBj05RIAbmX3K+RyCwe+AyL+W7aiUhsqRbI3U15sLEMErFHhip6kJFDTBka6FCl7MxAwBx1b7G9M2X41Z1A4Bi9u6UyNVsC73BiHo/B2cxio/FHzmSfYa4Mjdo0fHapoa743RyjoATb8o4kJ79uJJ3B7rpXCheoOxhV1g/WoMycZmRMP6zejZv4hoIKFFph2HT8djg1Q3Fz1EqC9D1klKAZL4KGRxcay4V2CAaKzTyItfTQWl4Nar+Be+NbFV95YdVxCxbtyOPoAiUyAwR/iJE39nEqdv/+Os/w6PzSzkvTKROrSrJLA+GfNliHG1FAB4+JN9MR7dc6iirOAWFPzIHrxW00iyNyrUyLXWV7eyZsqO4n6hlnybQQETkzmbb3Zkb9z/kusl/TgSZOAOB7SBmFLKf7/JNNfi1aDmulBFWv+n10d1J5aPINZGoSKeCzIxB4v+clsokGyD5IOCjpOS65R6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39850400004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(86362001)(52116002)(478600001)(6512007)(41300700001)(6506007)(6666004)(921011)(2616005)(110136005)(7416002)(54906003)(38350700005)(5660300002)(2906002)(6486002)(316002)(66946007)(66476007)(66556008)(8936002)(8676002)(4326008)(38100700002)(66899024)(26005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hUPPOu5X2U2ShhruUGmX54ZC2wu3J5wCIoOITnGlWcBHH6WdUl1opl7TScz/?=
 =?us-ascii?Q?2j7PM0SB3fFRvGxjtMdA2T6jZyoKcMl4v5EMofakGm4yOyJ2nkrYHo+nWThE?=
 =?us-ascii?Q?UAjXLsNd16QnR3uIeDRCOkvw/rQzs66u1W/UymIuOtb+pDLDCwvXbDugrVpD?=
 =?us-ascii?Q?sl9SQsnZKSvPdur1Oys9nTihwpXs8mCAF4WVn/Bp+YrORg5fOzhqEhrFHD55?=
 =?us-ascii?Q?U7XrvKtP5BYfl4mRXfVb08wLCLoqxFCfFqeFrXVGinY1M1lSdYuQ/MC+ysZF?=
 =?us-ascii?Q?Ycb6jDijoMHbTpMGyZ0oCDJD1q4LIEiuzez7i7tvOE/6FCVqOnYB7UX7Ea65?=
 =?us-ascii?Q?ug/FPsRT+cJD53FgGS940WmJZIomwSPZYsn1/j1T9tRxw+D7vTOMaqycszyw?=
 =?us-ascii?Q?vxKazXGGzL9aZsGWDwJTWPdBdX3uQ+EdiIfh6SAdip/BwOnlDh6mInSm8BOj?=
 =?us-ascii?Q?rw4Kl0sWquhKSXjQEfhen9GOlNJtsArjuAU4YDWUMBzAXtOdST8tbZOMa6q2?=
 =?us-ascii?Q?OuYxb96MMR9d0rqLGJ8BJvXMP47juxo53YRBDro/502icq5kN8rlYK3xtOn7?=
 =?us-ascii?Q?mSBfYXvxQ5qqo5I9r9hCHeCS3YhSHWxIZCO50H4+mEJun8VlKRLrU3FvPekT?=
 =?us-ascii?Q?XcgumkPVrVZdtEe7c6LV2wZuZJMYNKbSsJ68bePhYlGz0t9ep/53quwdgDWH?=
 =?us-ascii?Q?mKkS0ouvY2xQOLMPgi7yqPcNHoVMZTLVo2PAf5TfMe1lvNnKQWrrJmvuTp/m?=
 =?us-ascii?Q?c0+GNhRybPJJrfz+alhf1zp8XP226F/cyRLDaUJ5EwzXb7sz6pAyDg6WU2Uk?=
 =?us-ascii?Q?BTecrpzBvjBCvXT8rj0TPK40FoQr/N7AE134QS9/9ThWygQ7986Yfvhoeo+x?=
 =?us-ascii?Q?hOvr5J+FzgpQKqgPZFv7ZnCj59QVZ044BnrcGSWrD4Fu8poJQkILRbU67ql6?=
 =?us-ascii?Q?yUl9vq3U1W4FvjpnBMRqS+i8c22m7U9ojs1WTVMrq/naKX5OiNC7VkW+eQRU?=
 =?us-ascii?Q?EG5y5ReJbHheK5bTSCcEpRgAyYW4mgqHT9gPMvvEouL05Qu3fDWHPM0xSvAk?=
 =?us-ascii?Q?8kaswy1SG+LnQUJdazfclheXfvR2Ho4/b0LalQrwDAcPSfhy2LAaA8/37wXA?=
 =?us-ascii?Q?uPjJxuK3rg6ULdwzTMDmSrLMQrMktS5n8y/mglg7BC8dXsInCCyTpX4zh6pY?=
 =?us-ascii?Q?Z4AE2Bz02HDbN1xEMW4wA6ig6a970AV4srllOpP0cruBCvlJVJxGeUwQ2NDR?=
 =?us-ascii?Q?KZNV4MTKoOnsvgmLTVgOV70HvJ0LhvwttfULFfqHFnWlly6oFqBSm0jan0HE?=
 =?us-ascii?Q?udVFfet+rXzcL0XPxfzNUh1A0bDNA+l8IPm9leMFPH/BLEh9FSxwHKpGwfST?=
 =?us-ascii?Q?VqsnM/8Y33o7I1eSlXf5OvvkUgMaMSUhjaNRaexIvqTtzPoKy5BxUwvXWpVJ?=
 =?us-ascii?Q?C+pwhcowYmaYL5A5TY/qLfC4TmMw8MhZYiZ2ahOmoa5tsARqE7hNcnJTi06T?=
 =?us-ascii?Q?cxCqUYd562uWWRA7sBLG8tUElrPiJ1Nk50rddXBVrlJLtd4zY4EgnjjmewFD?=
 =?us-ascii?Q?eH0qReTvgk3PFWZjHgttTSESCjZfRaXuXB7gBVAjysShGXq9LjBhC2C74Gw8?=
 =?us-ascii?Q?ZGrGs6T7793BXK3NqK/J9hg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0108a2c-cfc2-4ad8-a3e9-08dc0e35f00d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 21:33:20.4869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhPfDlc4Wb7z3c7ye/49lhiSXNUYpUV1LfPAVQUVwfOp7vsn9BzyEPBi9p3wlrqLSQxfBtMfzJeR8STX0w4J5h1RMUAV66J49adFnG5lSGfAqhzX0TfpcyiBHSDXzUDr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6598

Due to erratum AC03_CPU_36 on AmpereOne, if an Asynchronous Exception
(interrupts or SErrors) occurs to EL2, while EL2 software is modifying
system register bits that control EL2 exception behavior, the processor
may take an exception to an incorrect Exception Level.

The affected system registers are HCR_EL2 and SCTLR_EL2, which contain
control bits for routing and enabling of EL2 exceptions.

The issue is triggered when HGE.TGE bit is cleared while having
AMO/IMO/FMO bits cleared too. To avoid the exception getting taken
at a wrong Exception Level, we set AMO/IMO/FMO.

Suggested-by: D Scott Phillips <scott@os.amperecomputing.com>
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 arch/arm64/kvm/hyp/vhe/tlb.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/vhe/tlb.c b/arch/arm64/kvm/hyp/vhe/tlb.c
index b32e2940df7d..c72fdd2e4549 100644
--- a/arch/arm64/kvm/hyp/vhe/tlb.c
+++ b/arch/arm64/kvm/hyp/vhe/tlb.c
@@ -61,9 +61,15 @@ static void __tlb_switch_to_guest(struct kvm_s2_mmu *mmu,
 	 * has an ISB in order to deal with this.
 	 */
 	__load_stage2(mmu, mmu->arch);
-	val = read_sysreg(hcr_el2);
-	val &= ~HCR_TGE;
-	write_sysreg(val, hcr_el2);
+
+	/*
+	 * With {E2H,TGE} == {1,0}, IMO == 1 is required so that IRQs are not
+	 * all masked. This also works around AmpereOne erratum AC03_CPU_36
+	 * which can incorrectly route an IRQ to EL1 when HCR_EL2.{E2H,TGE} is
+	 * written from {1,1} to {1,0} with interrupts unmasked.
+	 */
+	sysreg_clear_set(hcr_el2, HCR_TGE, HCR_AMO | HCR_IMO | HCR_FMO);
+
 	isb();
 }
 
-- 
2.43.0


