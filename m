Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DB57EA149
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjKMQbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMQbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:31:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AABDB;
        Mon, 13 Nov 2023 08:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699893072; x=1731429072;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ds30mPHsUg8u2AQYd5kdNQVe8k+y/rWFZDfOlgDzTtk=;
  b=kJm2RD5l/OQeQHAAOD81PDC9ls293cdlKuKbv3ivXI+7bDKlYCqpa70L
   ucvApfqjzQDgIfea98aeTdlqPz41Efyrbc2RSKTUBJc6e2HkW6cwF7nDf
   37S+5bUtRhqkvCk8ezO3H4MYfhWNrhamvmaMG6waNUGLIxs2mrpOie2vg
   sDmxeDC19Z8GEhAvHZ+WKEy80Xk2kTzANPMTo2C8gghE0McupCZJa31Vr
   SJ8cx7z8CGwRwNH3BTRnsltCIUD+aNS2MBIgwvw8M2ayK4vkkiuiQKBVq
   7aJNfmd3JYGyPouPGOGKE/ZcVRCTaVDUJHlUCccJfRUqFRxKNCYUYFaRX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="456954139"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="456954139"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:30:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="834762743"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="834762743"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 08:30:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 08:30:36 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 08:30:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 08:30:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVPHCWFjDa1cWajXcMYVUqyRGXWYibnb7sA+/MUMETCdcR5pZeEMCJEJXcjVCw9000cGNf/N+dNgsRMP6lTAYlF3uvxq8N5woBI+QRZy8VU8U5Yy49yT3c7VcNjrcWEqBLgf8fO54OzKA4IucFGbi9WK4KdDGui6Bk7PDTLWhLzf5xNFr6ER9mjd2/K2EVEbOIPnPvt+EuLW2Yn1wv4dM6ZfyqNd1fSjgIum6sQLMK1emkn5QI1qvFD51xuS1eZ2QIUWNaRWb9iu6USJF2y6QYRAOJnpovwsIZUqzSAV50esX4c9FIOD/Oy6qw804wqsM8DzRUQ5pUw+JjxeXNvpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mOzUE8EbBIVogol0QMJX2ZXqD4zFOgvFeKntl37zCg=;
 b=ZjYQQyri5fny+6qLgy9nyxLxUYZOWZF73aV3l5S83cVNG+UE52WU06er2leGopIyTykIYz7QOO1Eqs6nC6fiwGAlmnW9hZ2xThFYMVjMZVxw7vO+1TF3T/88a/OSwIvmLNsHSMzy4Gqzdm3TThrte1wgp4tFDJtE3pX23C3JDyKqKW7rxEb+SK2aCFIkZhI5AcuRsezJs0oHUaqUzhPv4bX2e5iWY38w/1MpVGBGPrEjYAe2GJsOs7o393QvAybniauTtBmgAGWevskMfY91X6ZUg9no68sAIoyDmxzsztPYZGj1zmi9QG8UvzLLPkjHkAK7txslt4FLlrUUQvNmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DS0PR11MB7651.namprd11.prod.outlook.com (2603:10b6:8:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Mon, 13 Nov
 2023 16:30:32 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 16:30:32 +0000
From:   Johnathan Mantey <johnathanx.mantey@intel.com>
To:     <netdev@vger.kernel.org>
CC:     <sam@mendozajonas.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net v3] Revert ncsi: Propagate carrier gain/loss events to the NCSI controller
Date:   Mon, 13 Nov 2023 08:30:29 -0800
Message-ID: <20231113163029.106912-1-johnathanx.mantey@intel.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::7) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DS0PR11MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: f7db4ee2-a5a2-4d97-d581-08dbe465dadd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwjSHzeDO4AXrt7reEqhSiyhk5ifzfp343FnNfXfyctk2fTYycKa9DgaPvbsHCPY0f2X3nuShNYErGjDkYaJfSqnVe3JAHYDVYkjGG7L89PgV+bCVxQDz/gt9JTPzdOu4BoLBaQG3WinH8A40ZrpIe9h0nR+9l2Fk2yo6WP8GYlzuWElf/7Ce35Z8QsLP8oDpFwWmoBsmy8hC4t1RI4cwiAfL3S2ffkgzKpV3OngB0ckJmcNgzxTaeZ2NT8mV92eCfay98CnjyBNhzGV23r9sgbvk+GkRJqEuJ/YnsM/lMmqTBLInIowIxfjBOFuVgM6cKa3yobr2rg+FQSTRp3CQw6TDl5CmDg8PzrZkAgqD9MMV3Hgp5fmBwW6itKT2uXtDsvuTLWY4TgcS99zyulh2D3UQjTmhON4DCiQ5O+qVD9TOKlh7iAhqXH6Xi4xL3Hf0nXfLBIqg8MHAzBeBLkahjdkvai98plhm7A+YIthK/0x/0anoPTbpEwcWcHJPxKB54zK9ja+xRP43zBjvUhuOwWtVC7pBuLvs/AHA+F6DfCp39rsZ4wlNB8oSn6o0qnA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(2616005)(1076003)(83380400001)(82960400001)(6506007)(478600001)(6486002)(6666004)(6512007)(2906002)(41300700001)(38100700002)(5660300002)(86362001)(6916009)(36756003)(66556008)(66946007)(4326008)(66476007)(8676002)(8936002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iIJOBs03CKA3nyHuiQj5CxSkCmMqW2DyvDkRlr40ybullljY8IXqZtmAXfMF?=
 =?us-ascii?Q?5RslJMSiRcTbu83j9FpgwXVEK7E4iLhqyVxJXfxLrsY6YAtTorjbSQYmZYT5?=
 =?us-ascii?Q?3sHILh/qQhdw0mQKx2pp6Km71oYeS+1P6TRX0l5sWWNl/PkKtanckgcb2Sh6?=
 =?us-ascii?Q?VGEf5gxnVkdglZ2q5gPUBDoLzbUEBK0fG0lwUTEOOVhxHM5WiNJRio0sB3Ix?=
 =?us-ascii?Q?XhXFfjoKNUNnN5vNr+MLbOkNhi/CPptamCXAJCUzfhMRBw2A8mMEzabxE9l8?=
 =?us-ascii?Q?4s2/saHnsWV/X45AAKnw4j6XVUAhLVSO8qPBwJutDW4eX5h+bNKZ2I21/JyA?=
 =?us-ascii?Q?DqyqjZF4wZ7wn2y54Q/HKqL+y46TzGsoxHHAOnENXJXFBorJ+byu3l9jREJ1?=
 =?us-ascii?Q?2oW4Ha3ak11hM/u/OlFplaPH+71KeUFcL/Akl3kfBsILoh/j2io//ccuve/L?=
 =?us-ascii?Q?K4IF9BpG24T23XG41cA6TFNWhvQFQapoxMn1hPDSkR2gRaC0b7ir0KTYvZPr?=
 =?us-ascii?Q?VCETJo0bqQnLddQCatjRnh2khs82PMvJpJEAU3BuMBMm0zHEqVZzTbG7ysx3?=
 =?us-ascii?Q?YGjO7JRpOc0dz0/qRCvtAOKP0A9+cLwAeBJ6vBeecYpSaPPYACzUkpPVPQ62?=
 =?us-ascii?Q?TfieLE5U40m4upxfZz9EW0mojOYFh3/s0F5G7EL4n3ypqtWgqG5JF6/m5WNO?=
 =?us-ascii?Q?bMRt77VEcxt1rzzdk2BpAdyMiVQQOqdIm7CsSi1PyMfiQZzwqz2LHYOVdZ5A?=
 =?us-ascii?Q?KKRA++YwKZGhCmwq0PXlND6rixB3Yh0LasXDsKz3WLIZNfsQhsdgVsFkjPhp?=
 =?us-ascii?Q?I5BngMcURJV/x/eQODm1YNhyPK/HxSJ7z3ocUpEXM97sEahF1ZsnPY5hLHep?=
 =?us-ascii?Q?Zk6wNesL67EDHP18uZv4yEEwtkB8yQmhp8Tp1WNBO4reGJWljCFXoI35E4Ic?=
 =?us-ascii?Q?zswMhpMOSlJ+Sd5HvJ1hZJ72aPyGKLxhRVczeb55pSqG3cD6MnVXLv2M53YZ?=
 =?us-ascii?Q?xyhSDnFTFRaAfcE2u2gTv8+mqklVGotl3RIr31wA11uP0FLik2wzR8CR3Uqs?=
 =?us-ascii?Q?ywn9UlAGb+z1/ShchtpN21fhj4F9dCg6XCbpRD5OSun/wf9boJVP0kwtRn6F?=
 =?us-ascii?Q?JaC11VHI2ZHPpBTpR/QZr2kUG9noE/k3di09lcpdWStRBRzgmnRgDCia7ASz?=
 =?us-ascii?Q?UGsimOH2jpC2HDKdFdyiPSrbv6Yuqj+D8WE+h6IAPHzP8uodgfCxeYUsvjY0?=
 =?us-ascii?Q?B+/QdZQShTvIfUl6v26hfJO4pzZnHWGFf8V3N8+V/DYxcOe1QPW5wivSXzXm?=
 =?us-ascii?Q?iSoKJ5eL+F26bb+9nbQ3v9YoS2EG6pNeXEdDDRTd78ybtzTIRwtD1Ok5Q04Q?=
 =?us-ascii?Q?SJgiFLwCit90O4I1ADRyB5t8slQmQS3KYS/xTJxV+JZHaqu4wP9aOWiuFAUZ?=
 =?us-ascii?Q?EHsLgIVTqRwDrDlWb4yTy9+6dSOV85wZFM3VNsAK6bt/fo9MTVmCV476baYJ?=
 =?us-ascii?Q?uIEnTa1Nx319NJ6GlmIL/yTTMQLDUFPMAmMUClXzSalhl1JUxCZdfOYvysKT?=
 =?us-ascii?Q?mjKXt2IPpN5OneM5vQ3Am6hqwQ6vatllaqfwadsCZhkktrsQZV5H1K6w7cNp?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7db4ee2-a5a2-4d97-d581-08dbe465dadd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 16:30:32.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1csylYIzT0mitIIpHZSPpnk3VD8ZwGx+e+UmDXDQ9KPrvQBJ0i3vY1wQt5saCbx7YVSY8XsBF5dOCF/OvpxbdtWGLNAFfqL1p+lTuWvYU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7651
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3780bb29311eccb7a1c9641032a112eed237f7e3.

The cited commit introduced unwanted behavior.

The intent for the commit was to be able to detect carrier loss/gain
for just the NIC connected to the BMC. The unwanted effect is a
carrier loss for auxiliary paths also causes the BMC to lose
carrier. The BMC never regains carrier despite the secondary NIC
regaining a link.

This change, when merged, needs to be backported to stable kernels.
5.4-stable, 5.10-stable, 5.15-stable, 6.1-stable, 6.5-stable

Fixes: 3780bb29311e ("ncsi: Propagate carrier gain/loss events to the NCSI controller")
CC: stable@vger.kernel.org
Signed-off-by: Johnathan Mantey <johnathanx.mantey@intel.com>
---
 net/ncsi/ncsi-aen.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index f8854bff286c..62fb1031763d 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -89,11 +89,6 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	if ((had_link == has_link) || chained)
 		return 0;
 
-	if (had_link)
-		netif_carrier_off(ndp->ndev.dev);
-	else
-		netif_carrier_on(ndp->ndev.dev);
-
 	if (!ndp->multi_package && !nc->package->multi_channel) {
 		if (had_link) {
 			ndp->flags |= NCSI_DEV_RESHUFFLE;
-- 
2.41.0

