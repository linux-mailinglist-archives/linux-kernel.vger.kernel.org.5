Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9115B78B4A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjH1PlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjH1Pkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:40:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2031.outbound.protection.outlook.com [40.92.19.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FF5AC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kc4hP3lIpfr7Vxxvg7YyVhcfIDcRSWySiFNw+yZWjTVBlmnIGG4H10ZDmWHTb6pFFa4da+OuT3CiNuQYnzgOtZEwfxbGG/4AQ1eSJy7af+atSAFMjdnq25htjDstx96v1cS/AXPAXXMsgdK8vPQqA+XSVBY7AcvRSGHgDU2RSh8joqQstkuulrBj4VF/vqdOniuwycXlD+iM8aiRjNd1ZyxQ5VpKLZaoRBBl6cZiR9nr4tiWQNRfUKlbmyi23hzU93a742RrJz5R5rfSFbN8jN8Z2hwPF78TDIZaKCVtEx5kIs9v23agJ3g/axzqsgjReCqD6Awlqb6pvCjKr3Cycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cevq4dBLkiGc/yrLMK8XCrv25QwUYUMrXjVJQjD9Kis=;
 b=J9t0IuRMNSagP5HP3Z0feOMzPDKEe6NpZhsv7cvxQmAHc8logpIRTIVprExJYnOw0v21aBFm7CQuQv7+hlEd+gupgE9JyU5Jnx2aJ3nab2BlvNNPrB3h/4dtH5ArvCNJBDtXN5M5hkNKS4Kuas/L7mFTJHHOcLTqJeGQAeYqIsoIaNZFiU9BFyTDKMXq7jamsm0/MtSFixQoqM11gffTT4zv2LRJh8QWsnbue3oKTnIho1bZ+1rZToM6413UTu5Vc5DLgue+8qksDLqcjaXmUoMxcbVLhGSBpcIe55icSkT6OMkLl9Jpp8ZET52U8buhng/8MYqKtc2xHw6gg0swsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cevq4dBLkiGc/yrLMK8XCrv25QwUYUMrXjVJQjD9Kis=;
 b=rfksg/DUn9bLIikp2a6vbWU/GYMvWw5E/2N8qZioGcNDjcHwaeBgsMc5LzgO9w7LMUa9FPLw8B+mmITC8dDGY3JHvVPj63v+hc9m36GAwwqn+lq46j0SSQL8DndqaAvorLyrsM+nJjcH8iYAW2b5/VexXQfeHzJ+gbAMj1iSD4nRjrsmaqvUJmMj1dxSRyNzLFImwTbXHyblhp6oVySwm5PtGBBzZLXgvSU1rRq4b+6FKv0Flc5TYh2/Patm+zZcM/GfspYLOcTGUDQhGvD97eKaxLAOu9TZToJ4ulDwu2znQymm6LncIIodANw7HQoqri6QcCdBgZ0puotr7bxLRQ==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:40:41 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 15:40:41 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v5 6/6] staging: octeon: remove typedef in structs cvmx_pip_port_status_t and cvmx_pko_port_status_t
Date:   Mon, 28 Aug 2023 11:39:11 -0400
Message-ID: <PH7PR11MB76434462A6563C5FBDEE51A8BCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693236450.git.ozlinux@hotmail.com>
References: <cover.1693236450.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [wmFDcVaUGUvquKQyOcrSHS3ndbuN36z9ldhSg8aIeYDW602g0ZxLlc+e6r8S7Qh4]
X-ClientProxiedBy: MN2PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:208:120::26) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <5bad40a167f3c5a5c21f37cf8824217e651ff2da.1693236450.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a60e491-c5bf-4454-5a4b-08dba7dd2286
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmr1VCrDDYJl/lCLgD1Tr5zrNiSP+l/4MPxueaJs6qhf9+lsXwx9FG8ai2FLNTM1Y/hV4s8Tmf93aAffLzI/85OIB6iVtqXFY05FFfPdnaxkcKqtsO0JfbZYMrV+sy22yh/Wqwh9ag2v1dUPzZX2FEH4SJAB+7vUSL8jANEXOE/cJEIRjPa4GimU9vkAB8p6ae9JGfGsnWnPy98onnRij7h4zndpI9PFGogpESrwF9cmB1LGfp5h4GF+pxKCYSKxb6A+Fd49L1Y6opRcPODVIS0MWGIxTVmMmtL+k4l1ZOOxr0MauGqfkrF7vnpHZ232w4NxvrHGYl9JfUhuMOBvzuP3n7KtY90+E4UCgtAgo/PEG8LMUMnS0aF7FF0irNiK0s2YWEiNH0UFl8pmhrQTOvx2dsyYmQRDHH+8bWmNufK1fSJ78Mj1VE92e5WcAmXl2I4FinkjExFg2vG6IbKoBcIzm6gQO8wlrnJdmK5preyZCQDZkmx6rU13bm0mgk/9Da/JsZXnwD3VYaCWvRr8nmEx3WonOJAgYHsDxgiaPmpLPSmUx7d7w6yhPWYKsG3+dYc9s/gzMYel5U0Y+DsfWcF4z/LjHsLDaqOWHcx8Z7+2jM0WVyQSn+rQqK5EKPfDkBTKw1mcNNgQs3YJFUhyOs9Z1Pih5XXPD+8y1BdV9GtQluTblg2Lznu0HWEDyKtX3+H3i6LSHB9pTARTmQNRbcPFM+sMO3aP8jK1MMMxQ9AWdb6nii+7+MOoAYQcxp29ncA=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bRimuLadBNQaUDkBBrq6LYxwbPqahzo6H+4mXswcpP5sl3rURsxsPYhpnjeuBJLInvOaNmCxpmHgD9roFI+oZP8E+16jAf9Mx34bxoLKvriOKRTlEUAocVm5IvGNOGmmxqK8dX0AKyo6Oy1kYk5Yy7zz276kOT+cQSWl0kTvrqma+3llanw7Gpd7rwD6yhZ3zAwT+F7awhrLU6zrRtKPzhY4iFdkYn/hEIvraxDnvAJPFqNc1qUVcQt8w0pB3iOBmpCsNBVnBnY/wx1+PfzYcL0+uYDXEenocjiOwc/MighQjCnIAL2uO89mNoORybrcptFnQNPGXpnr4MDIz6dYKMNAsnfTUCk6OPuDQ2NzDrqccVO+Dk53CiQ0Kfi+W/pJ8LzGbxjmR1XV2x9FmpUmVSe8fhAFBO1wq+gaIVJl8mWG5nSD6Y6ZGSFD5OZ1A8G47PK6E2QlAclFQKY4lZUVlW5G3uY/+TCXT71rwjya+DyFyhG+l0M0c7/WBu/x/m41Mwi6NDBs0t1BZB5MJ4wE8bUMY81wtASEleiSP93kifs9KT8DrFSPSA29IFz21IJB1IH9ezDYux/HMueEC4MDeLfnMWUz0VOA29Jdwzk8tHEV5OcEhwqdfPYN8qmStZZx
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RuAM5WaqEJl7blqGf66qYQ4gKgesWjsxJQNVnYZldJAyTsqlH0SgBcOWE5Ck?=
 =?us-ascii?Q?WRrvBq/k6QfWJ9V3tuzOQvB1yIAaTpwIMENQFvpoB7XCG9CGAx/bjOnfClw/?=
 =?us-ascii?Q?3i00l/ldvc+CdhG4iiBz48mbP6l7bcbP/2ba9bAUf+6w09kX/11x923+QbN1?=
 =?us-ascii?Q?J7gKYonOMkeQt75fy8GE2u5fYED0J6NalrC+zJ/hbmaUP5mdAxiSyHaiSCsP?=
 =?us-ascii?Q?87b8MW5b9JopYn3RM2Bgd2hrhceuJMa5c7YhD1tdKyTRlc5dJmy8dC3v+lrn?=
 =?us-ascii?Q?iPbPr2sDnyWnZiEAPX3GgDf6wLXErNtAtTxkyW8sEe1OITzmo0KTpBTuXFTG?=
 =?us-ascii?Q?b1tH3KKniN0gDJh13YZ76GJ3kGtm3kRmy1RrcM6je6nTs/VQfAfpOmUxcFji?=
 =?us-ascii?Q?PKASFOXDcj5wg2i9RVixZ8lCSt9DEZloz06FC1F4uChclUC/px3MHcu7+8Q+?=
 =?us-ascii?Q?iT2BRGIp+pkfI9yI/azy9rH0sG2NPs6AKPFOmU5JJcwrOhfkak4R8hc+KsnA?=
 =?us-ascii?Q?PIAwa9MQmmea1I/x4pkSG452KhnwJ8OAxcRd69hAZPkzeWDUEJF6iW+OQloX?=
 =?us-ascii?Q?ZvejzVx7Eu8yLznuNsgOi4xdf7ciOiZYU8LEwgZQ0Cpljb4dFRGKiVlScW5l?=
 =?us-ascii?Q?G0iXIbJo/cuuwdQL8doDChmYbldbSwIJM7fw7GsZPWxCio+WeGoKFejrCNRn?=
 =?us-ascii?Q?0ZjmA6vDODrv5igw5uZJI7wc1lf0qlR3mS5J8Qu5KRS9YbKQ47dNAm1DL6xH?=
 =?us-ascii?Q?younhpqB18nrVaYyTaSgBqLrr05B95uWHKkQfOH8rCtBYYVh3MYqvL20aOz9?=
 =?us-ascii?Q?n6DXw7i+jIJf6yfCxupZeaOGRJbxYYMNI1KnxUJDTHiz0lDLyOJKpeYs4qIJ?=
 =?us-ascii?Q?l6zzjPXgNig92+kwyt5icWwRj+BjeFbMfbHCMWOlMleq5iXXQmuZSvdabWkC?=
 =?us-ascii?Q?jPVmD7Rhtoszm+KwIdf4wlc2Kx35i5kjTGFS+nIhzvndXYXDrk1MiChASDYw?=
 =?us-ascii?Q?MDs6xTjBry0dud7JBFVs/gS2KRzpcpiahWj+IF3DGin2izjFrsqfx3KGbuYt?=
 =?us-ascii?Q?BnUGcDS1HlJuHgib4ZuTuLIJUbXDCdJxUjCcW0kAAMY90aNtPup2eSHFbxtu?=
 =?us-ascii?Q?NbCn3rA0zCYhb1L3b37NIqRX5QosSStWav2YG6DlD0tmApw+lIEbj6bSRFOj?=
 =?us-ascii?Q?fg71yECtcBJmUktKLJWb5IJvjoiNO+X0x3MThzcE3K+TJM0BG6h0N1NxW2Ee?=
 =?us-ascii?Q?tBlw2uGnWYU9lvhHg6md8e91MULIwChRD7ap4hrD9w=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a60e491-c5bf-4454-5a4b-08dba7dd2286
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:40:41.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedef in structs cvmx_pip_port_status_t and cvmx_pko_port_status_t,
and rename all instances to cvmx_pip_port_status, and cvmx_pko_port_status,
respectively

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
v5: More descriptive commit descriptions
v4: Forgot to rename all instances of another struct
v3: Forgot to rename all instances of a struct
v2: Send the patch set properly, with messages in a single thread

 drivers/staging/octeon/ethernet.c     |  4 ++--
 drivers/staging/octeon/octeon-stubs.h | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 023b107e077a..8e1f4b987a25 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -201,8 +201,8 @@ EXPORT_SYMBOL(cvm_oct_free_work);
  */
 static struct net_device_stats *cvm_oct_common_get_stats(struct net_device *dev)
 {
-	cvmx_pip_port_status_t rx_status;
-	cvmx_pko_port_status_t tx_status;
+	struct cvmx_pip_port_status rx_status;
+	struct cvmx_pko_port_status tx_status;
 	struct octeon_ethernet *priv = netdev_priv(dev);
 
 	if (priv->port < CVMX_PIP_NUM_INPUT_PORTS) {
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index b9852994882b..579c755cfdc0 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -384,7 +384,7 @@ union cvmx_ipd_sub_port_qos_cnt {
 	} s;
 };
 
-typedef struct {
+struct cvmx_pip_port_status {
 	uint32_t dropped_octets;
 	uint32_t dropped_packets;
 	uint32_t pci_raw_packets;
@@ -407,13 +407,13 @@ typedef struct {
 	uint32_t inb_packets;
 	uint64_t inb_octets;
 	uint16_t inb_errors;
-} cvmx_pip_port_status_t;
+};
 
-typedef struct {
+struct cvmx_pko_port_status {
 	uint32_t packets;
 	uint64_t octets;
 	uint64_t doorbell;
-} cvmx_pko_port_status_t;
+};
 
 union cvmx_pip_frm_len_chkx {
 	uint64_t u64;
@@ -1258,11 +1258,11 @@ static inline int octeon_is_simulation(void)
 }
 
 static inline void cvmx_pip_get_port_status(uint64_t port_num, uint64_t clear,
-					    cvmx_pip_port_status_t *status)
+					    struct cvmx_pip_port_status *status)
 { }
 
 static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
-					    cvmx_pko_port_status_t *status)
+					    struct cvmx_pko_port_status *status)
 { }
 
 static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int
-- 
2.39.3

