Return-Path: <linux-kernel+bounces-193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1AE813D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B1B28310F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F6C2C69B;
	Thu, 14 Dec 2023 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="EGvakLnA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2115.outbound.protection.outlook.com [40.107.94.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE51671E7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdI06iJu09/dCtncdvdurFnNY3xG3XNcTOdwH8cv6O/U9jc5Z6qRiJqJF/eWTQZBFpNV1iiWEY65+SOxlrNxUoeox5k6poP/FG47aE37VYSqPnEOmOsZT5wN31xXigqdvxEqjU0dwe/pXTaVXHTdQDyQnHkShnUyIAOanul1zrpiiRjlbEu6NxsqSViG5C4pOdd0OYeLH7tpe8hG4wXgHn7a0aW4k3P0z+1bs77uJEpMHOM0VqQ5U6ispMuNFrkXSRZOPS/czMTvl4arBWQ4cH+mbTIZxMQxRdVRO0ziNfBozkdRSnNwGm/Keedcp6hQQkri9UhSsZLwNrH1oYsefw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BbGHNFDqbLs84+grYdyze7BUBnAr0BBq8KJg5XdSIs=;
 b=ILVQH7gmhA2qV36SJQ1vJRo981bJ8TZAWqtJFE6EXMcvl2ZZSsMssp0x/Ok4rnFUvANDZNiT7F7+wRlxkQkWidXpwhHiL/33vtD8GjjJrbmraaVkZ100pMe1bzxLG4TnU//S/56rGaC/euGCcU9fKnH7qjcjk3CSLDJdO15pnNXddLkJpzrGIxOq57WfVGBS+oMlYEqGTPbeXNyDHbC72CsrCABEgDyHCqM440gL8AYRcHDXTcqkumS7BuKxpxveMoykcB+LFIA8XfNyAe01mM39tAUFujesaLSeYZa+iH80Z2iKc6BEfpmYEqB2jIuc7MoOl4JC/y/yRDFjbcO+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BbGHNFDqbLs84+grYdyze7BUBnAr0BBq8KJg5XdSIs=;
 b=EGvakLnA/Io13ZX9LdALGtA1xBDVa5yT1HdbU0BeL73z6622Kt6QTyYwG4FtmbEKnErN3pRx3LX6Eh1ZDsimm+Nve2g2aJW7MdckGtwevI13p65wkiW25W40MPNoE4ETotSLaPoLFKrd1aGjfJ2P2XVpZym3x82c0E9Swki86IU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7492.prod.exchangelabs.com (2603:10b6:510:f3::6) by
 PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.28; Thu, 14 Dec 2023 22:34:44 +0000
Received: from PH0PR01MB7492.prod.exchangelabs.com
 ([fe80::f6b3:cbb5:65c9:b0ef]) by PH0PR01MB7492.prod.exchangelabs.com
 ([fe80::f6b3:cbb5:65c9:b0ef%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 22:34:44 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: riel@surriel.com,
	shy828301@gmail.com,
	willy@infradead.org,
	cl@linux.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RESEND PATCH] mm: align larger anonymous mappings on THP boundaries
Date: Thu, 14 Dec 2023 14:34:23 -0800
Message-ID: <20231214223423.1133074-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:610:58::21) To PH0PR01MB7492.prod.exchangelabs.com
 (2603:10b6:510:f3::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7492:EE_|PH0PR01MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 8604f7ff-84a5-41c3-2a20-08dbfcf4decf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	alfkTjEEtnIj0tgP2MuvCZclvmQRGTnijB88RLQE85GBI/QEv0QQtUR5k6XejXPz/91hsK967dHcsPJi4G3U3vXQjywnujuomyvTMNgje9X9AUW1rQZvGiuCTHEMmwM7qAe5ZUWEyGZ/DDGGjNGxOlwAW5VXck/PxdUnE4M0jyTpzw+or7s3XxsdgPTGp6fVWpsRNtp9I/llsk+Wpo3VXahFuSTGyEXAo1h6IImukDriix053cR4SHwODxG4t67EF5n5aP3EdetZiBThPtvEE65e+CdcSWlpd6Sx9S4iHweEo+uBwxRgn/u8kpwVTbDgi0iwvCFcGmO2cPC/QwFgnS1zHJfmxF531EGNpviAGEcTy4Ln13ICfe/PXigCk1lTIxU0Lq2xxKhHGkOFT2YLad0iZypHGE9eFB1LNfV10Z1VPnrTP/FLTycI3jKJeHXBIcceYQfHpnQEZPtrwAlfDB1lhFBG8XVaJuWs0D4bS6SWSMwvdDJ2Nnqo0xz4Bhkk5YBe+CclmXK1qMowRpCE4+FapLcvifDYEK3tUeApkEhq2rfaJPNsbNxrDrmPWIcRt+KGygKbzjOvwDI0JvvSZXYbVJK/ZRz3c7f4ioc9H2U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7492.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39850400004)(396003)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(8936002)(8676002)(4326008)(38100700002)(5660300002)(38350700005)(2906002)(966005)(6486002)(478600001)(1076003)(2616005)(26005)(6506007)(52116002)(6512007)(6666004)(86362001)(41300700001)(316002)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yx9Q+ASuDo4HxeC026AfmbjQPZTTAncbCGBToBQALFf+fMieEacJApSJ34c3?=
 =?us-ascii?Q?Ti8vypclQX6Z66KqQ4vxPgfjHCTcTxLzI/4DcB14DJkMl878bh17bMEbc1xi?=
 =?us-ascii?Q?S5Vi9z9my4xM+yOWElxf8/9Iu08mCjjgAwjq7OvodkgETKNWA4yfxkxOkTvx?=
 =?us-ascii?Q?2wvoK9KhQgSuFKn5CiO2mZ4t4I99jJ6XXkuUG6j61z42xeOH+8KZ+9sey56x?=
 =?us-ascii?Q?zdJ3msIaOmBWLnKckJFvh7JEBABCz14cPYmO8if+J9UEeE+T9JiaxFrp+Nro?=
 =?us-ascii?Q?27jVTGr6zAmuZayFRm87o1XzK3m5UQQEUhfNnE5P8tndWQ05H5MX+URb9j0s?=
 =?us-ascii?Q?TacpkS5uheIAobi/jqILhyyXReGBLKMn4sW+0WrbQQks2ia4DEQskto6NtLs?=
 =?us-ascii?Q?RfOxcDvr5yT77/RLhTgVtg7UaVCn/OAWVIP63usRKY6lxqQFgKSMfJKBEwWT?=
 =?us-ascii?Q?oq/NWK0XxOgLAnw4xj2kG6yIG2zSQgmJA/Q1giNqm+8BToyWnNZndgH7v3Sb?=
 =?us-ascii?Q?cbSE20xitz1zgtf6fA499poa9OB3kXp1eOGuvUnssahSmvCjWqDgJF11b02m?=
 =?us-ascii?Q?SEMfs70ne3xSJs7K42cd9cqpr+T+LeCpGGhauqBoZB2wvXiOgdZMc2GGUYDB?=
 =?us-ascii?Q?VWmPDJ1J58ytWm78EI7/yOky+sjhRw9n695PSGDMgRr0vkYIxz1wF2BboEGn?=
 =?us-ascii?Q?Y2jp9emzA7Bj998wXQdMoFQd4/LoqWR24pzVGZtqm6skhVGsCJ3LGI9G7Wso?=
 =?us-ascii?Q?eRB4sfoQe4e8cHDxvT0e8X4jFeWDr0cM1ec70EKsXq5VfcVXoD7FzOdoAhCz?=
 =?us-ascii?Q?6d0kquA/xUkZ7hRcA+2l2EdDIr1lMuRMJ+/n+xeYtw3Yps16whdpmYrgjm73?=
 =?us-ascii?Q?aeyaKmyYZvSZ8EvlSGRhzjNzesyk0vSsJv+57+4hYN5bbY6Gsr97RC8RABri?=
 =?us-ascii?Q?kuIhkmFQpPsjN81cGQvwg8LAla+NyL8BOJAsy+FkkQc0/1QS0au+S6rA7cKt?=
 =?us-ascii?Q?Eg9RnVc6g5WHnoAWzfJjL9l8HCKXi1bUbsMHtOTPhAynkKF876EsJ4NtDtIy?=
 =?us-ascii?Q?Ys6sL8bnYnwS8Yw38yRamKkYcgc6aXKlzJfVEux8i112tg2jgovpmWd961pA?=
 =?us-ascii?Q?Dbi99mM7KT4jIJsqqtvsJ/pucL1y3Kx70t84PLSOm7H6CbbsTZjN0BPoD+WJ?=
 =?us-ascii?Q?bxZRHykUF3ijndzrL8M0RvZWKfEcfW/R/oU0abIcwK2XaENSzXdkbcuAVVnD?=
 =?us-ascii?Q?+J9qtTWp+YMHGBjU2Qhrp5eGLnHcvaTr4h/salCOfXuxfBPF5mMIcL5fY+gr?=
 =?us-ascii?Q?N9/su8rE8HTSdizCCuBDG4d7owo5AVWHCgVNkEe6O3QlR+zRtOfhtUWpwfkY?=
 =?us-ascii?Q?vNKRPsUcxsRX0S8q6aeITih+HJrXIhDZOgatAYbJFNtEkKc9c/kZHB46ZM6m?=
 =?us-ascii?Q?NoWteuy+R6Z7pClwQU5BnbQ6qkAkdENBiZvL4Y+aAbg6+OpWQBbJ5PwG2dWY?=
 =?us-ascii?Q?KhzWM9hm/FgXEyNY7FRhR5+HkxLWg256ldfw1huGWoXyOazdUjvLxLdNU1Sr?=
 =?us-ascii?Q?ZK6FGFdJLwKga7AXRdMwsMFVs8yFGYO+rTIQsSTKrGacsVfj7nXsQviTPRDW?=
 =?us-ascii?Q?eGFy5TJq7F0DLhLvFIuGXZM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8604f7ff-84a5-41c3-2a20-08dbfcf4decf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7492.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 22:34:44.5659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMh+cJuTSCSEaxPuJK5UHrbOqOTVxYik36Yj3sQwUkfRuXorecVFy+GXGgusia3tA4ClrJDFqN3E16YUR0IH7oALZAZUcXC1+wdzPNsD9uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8166

From: Rik van Riel <riel@surriel.com>

Align larger anonymous memory mappings on THP boundaries by going through
thp_get_unmapped_area if THPs are enabled for the current process.

With this patch, larger anonymous mappings are now THP aligned.  When a
malloc library allocates a 2MB or larger arena, that arena can now be
mapped with THPs right from the start, which can result in better TLB hit
rates and execution time.

Link: https://lkml.kernel.org/r/20220809142457.4751229f@imladris.surriel.com
Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christopher Lameter <cl@linux.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
This patch was applied to v6.1, but was reverted due to a regression
report.  However it turned out the regression was not due to this patch.
I ping'ed Andrew to reapply this patch, Andrew may forget it.  This
patch helps promote THP, so I rebased it onto the latest mm-unstable.


 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9d780f415be3..dd25a2aa94f7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2232,6 +2232,9 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		 */
 		pgoff = 0;
 		get_area = shmem_get_unmapped_area;
+	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+		/* Ensures that larger anonymous mappings are THP aligned. */
+		get_area = thp_get_unmapped_area;
 	}
 
 	addr = get_area(file, addr, len, pgoff, flags);
-- 
2.41.0


