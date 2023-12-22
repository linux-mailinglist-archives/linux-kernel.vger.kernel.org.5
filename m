Return-Path: <linux-kernel+bounces-10088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE08681CFE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE249B23A44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E152E84D;
	Fri, 22 Dec 2023 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Q4BKrtyD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2094.outbound.protection.outlook.com [40.107.92.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860A2FC37
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE4OTKftI0rH6hnSMPsYVrP4JltdQrwJar1LP4w+GSsQzsHPAr6j/yskk7pPcUS76+oaZ+YvWdY+sah5pxNkbcWHZILPaSMFm4MF8aMmQWR1MXYhQ+4U1rfOwFq0PkUsAmjuCbpomf/+kwUjpARGEzkEuDy6381uUJTwNx8MSQHxnq0ffVNZpY751tUhr3gtvw35UZM3987uoaKmoZqXxKJaE3ti6nZGWF9VgJ3uEtPqQ1b3mcR6CPHzf1ghwgPjX+PTQ0YjHd/hZXdQy2J5ygNmyqyaqubALaS/UCQZIZqLd2HYR6a8XfvScfrtgezytvngXwyCoGUgzRQQ968kAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uw+O1kwUFNPtghzeARFI8lNac+Yh9qplvIyGK0lhYo=;
 b=DJl16iMwsiah9mfWp3BAF7EBp3Z+LNAO++WT1romgBdZFjZ9p8SPWaG3+zcE8E2Hs388TUspeOuYfPnJenbnbbukCh0wMyYvQ3prqFg+QJPbmQQ/5xU2ILDzX34Muy+OFjx/OIYg4gwnZ035bDY0ykjGpU/kZZnTSmaHPSXk2vKgt3UEfceh1vko1dDD2m9MiJ6vUNgtBvtGv/9lyYUZkbuysVjQlAFKnCEjkGEKH2LiLlvAvYuJO7WhczkAUMq++vdXvd+bIThP+I+QYiHn87OLV/AJpQqTS0BQ4GYidnMIB3M7Nkns8uk6zZJTJf2YKJJvWnF5exhJ7TLN4QbMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uw+O1kwUFNPtghzeARFI8lNac+Yh9qplvIyGK0lhYo=;
 b=Q4BKrtyDM5SbYQbiJEZhYYltNqUY++T7RDAWJFtliY6ZMzB+g+I0VtdRbdskACU9HWsjJQGyRRXfSuD722FgjeWwVAt9zWrshVvLhis9V6Q+N4Kz7rrMi67LE3F9ZurLHr7fObpxJsaMQntmGZ627PZ1SCt3AMEzZ0vgWDTy9Hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8024.prod.exchangelabs.com (2603:10b6:510:287::6) by
 SA0PR01MB6282.prod.exchangelabs.com (2603:10b6:806:e6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.21; Fri, 22 Dec 2023 22:43:48 +0000
Received: from PH0PR01MB8024.prod.exchangelabs.com
 ([fe80::5036:18a6:c477:2320]) by PH0PR01MB8024.prod.exchangelabs.com
 ([fe80::5036:18a6:c477:2320%5]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 22:43:48 +0000
From: Carl Worth <carl@os.amperecomputing.com>
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
 <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>, James Morse
 <james.morse@arm.com>, shameerali.kolothum.thodi@huawei.com, D Scott
 Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>, Xin
 Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com
Subject: Re: [PATCH v8 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
In-Reply-To: <20231215174343.13872-1-james.morse@arm.com>
References: <20231215174343.13872-1-james.morse@arm.com>
Date: Fri, 22 Dec 2023 14:43:43 -0800
Message-ID: <874jg9rh7k.fsf@rasp.cworth.amperemail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:610:119::6) To PH0PR01MB8024.prod.exchangelabs.com
 (2603:10b6:510:287::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8024:EE_|SA0PR01MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa46b63-518d-4b18-cf1a-08dc033f7617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+v1RYH0+KzuHP4L95chfGM+bmDfZAvFdA3F24mKtg26E1oWKhi+Euvtev9O0WXa9LhJjpKaeMWHeBWjSP5GJLFT9WnqTsSbPa7K/e7zqnrehpo+yhD9aTeBaweYfKKhnj4pCSVmZwsO2YNhNiBPzzJh6TP42dOKLQqvwRjtROElsbBanWQpJ0vWo699CyA7CQ5YkE8lyJu3D0EwVzbYo2R9oUAkHFheAEN34guPm2M8FbHgVC1Xfe/ltHAR1wwKo5WPf8bh73136Q4N7nNq3Z5vqRC8ITDhNclbQ67VUqXGbx/Za3HzRrmg2ibXlHX1rTyAjEEftZ91lbjGS9HAPCDGKfGzU0meIIezkkpo3xf5x0MrqpN9OUFEc1VnppoGdNRWEohNZe54yg0nEBhqZXsYK8z+utqE9kvbLVd8qmb43clawjoFjCI+SU2hIS/Phznd/aY9gVQl5iVddszBsYJSuMKIOdEYmJfqbjcs4sj2uwyw5TArmlQ0IjWiD94rx01NzD60voptCjvdx/i8K4oFGhCQe7htQ61SxlVJo+fZyjR6zWEK7drQE/jUofLXiqPmlZKlpyEqyAT++LuKGBq1w/hpnPZ85tsy7yJpt0hnCVAbYz18MkEqWSwSoYRry
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8024.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39850400004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(5660300002)(6512007)(6666004)(6506007)(478600001)(52116002)(9686003)(6486002)(26005)(83380400001)(8676002)(4326008)(8936002)(38350700005)(41300700001)(2906002)(86362001)(38100700002)(66556008)(4744005)(66946007)(316002)(66476007)(54906003)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?16Uq4/LyY4MRDiwwD/b6p7GwPeGUJklknpiy5Pzq714h7m6jXMbiHEoRmlF1?=
 =?us-ascii?Q?yW3iPWEk1WjAkx98IkfOQmlR4dp1sOLRHWBss1ZzBb0Yq4kbNyiB6U7uCSwR?=
 =?us-ascii?Q?HyMwYt+fkLsZk2ai8dtG7IifZujLGEmjxfSgV7lOLma2pSYATzaNnyu4YQ+M?=
 =?us-ascii?Q?/udgc5kNkZuFRP+0gcu/w1nXXqAnO8K1pyjsPMIGuchDCSnZhTc/i7KOWRzF?=
 =?us-ascii?Q?+Bvbzt3hzi3V0fzvXjVZM11I7trQ8h8qdbwAjaws/OkGjFsAPVy3HYqMsW4K?=
 =?us-ascii?Q?tIt7Z5rc/1SR6n2xfUK4lACmUwDQMmJ0MH64c806rY+AkpO0uccmGEa6zVON?=
 =?us-ascii?Q?ZvVGCxI7d9lhKIJOh26Cw+K3U7r5MRGzfqYdaVklx9M6FROELmO2DmVtmeIX?=
 =?us-ascii?Q?Lrmohmi5wfGl66I6FW6jbTnHnOJfYI56tFCupOQprTdgkKgmSFGfMV8ourR3?=
 =?us-ascii?Q?1A7cWT0C6qRtqIrwybmz/MPm2d5hpsQtDXrc8mZ3cUTKu23hSkSV/Kx3T8Qf?=
 =?us-ascii?Q?1Hva+CPF1NVX/U9u0XYnGeH5RUim6JKBL4lm38NsJ1q78G4njJVf7079JOiz?=
 =?us-ascii?Q?nXWwMCrVKYJHHlQwu2V8lwOtSfzOOM04j3fhahtbeJKKqWofDDRKNJ0CRYAV?=
 =?us-ascii?Q?QCX2RD7G679GI9NnQ8zQbFX9fUg37hF0/7LzlucXO9WEroRag0Bu7MSNPPLZ?=
 =?us-ascii?Q?DwXRhM2CGLlmtdGJDy6q/dKbJ1TenR87dgbux2i7KJzxIvtf5xWc9BtIm7r9?=
 =?us-ascii?Q?Sr0cgK+2JEY4AJw9ez3rx/A6vnDLunIWmOrs5nKYipSL37rUrfTgEBBq20dD?=
 =?us-ascii?Q?XhhQx865Ob1O/n1bKpm6eFhftlSb/W69PCPiCWrDJ4+I0qhLSIJ7s5yGZXXF?=
 =?us-ascii?Q?ytrDKnt8SZuXVAw6hEK/v6fwf28xsttoHcaGBr9JBtk0bCSgMhNV5FT4g5Ls?=
 =?us-ascii?Q?kjRbBoEgHmzbZPDStutWASYdD/1+ecBSR3AIA/Gs6jDHAHPwqBu58dLLBbZ8?=
 =?us-ascii?Q?ewW6CumvvOlmTp449PpsP+nDvYZSfqhfRM1rR2Nsnx+AgpNGj7qq+HffudMn?=
 =?us-ascii?Q?YSfAg3erPjDJ2OIqDWKgHS4YHV8XjdXzw/nM7NYQjPd29VBgu7+0bYmsNbBF?=
 =?us-ascii?Q?e3Sq1W01tEMzDL2g6v7vmKxid34ryxqTnw0L9NfDXjjhd4nAfEc7g8q6yRJW?=
 =?us-ascii?Q?9HqEHjS1YRrvG3ivQQ2N8n5MPzJMujClp+Lz23O8jbd1YrvBmc6y2RLhDYi+?=
 =?us-ascii?Q?A0t/1C2l/bU1igwUY6TgloOCwO5HWXYUK7+611l7zdrcLxypis+XCsVyPbJR?=
 =?us-ascii?Q?/LVVkmPQ0Y93fUwq0uDvITF7C/UHqEzxCwhLaK8wd4MyBWRWce7Frm7+fmiw?=
 =?us-ascii?Q?nhwlzoY/vQaC2M8DdMkFqVBmHmib1LHXq+1XvImlRmxMGtNfD3OjzntWf/GM?=
 =?us-ascii?Q?dfHntlH5GzmFJDDxKbfeLEqRnZwT22p+Vsj9GCllLxUV81/y6L97qPlqmPIi?=
 =?us-ascii?Q?nUytynOv2lm6PwGKE20OcUQYosFCuzZrfXh77h5G96grCbaM1ZJMpI+5OZmJ?=
 =?us-ascii?Q?Lg8/bXXoKIUA7sMdEmXcZOWnL4wgdWsO0wZ5blpHi3sdeYtFG0InjXRIZJBo?=
 =?us-ascii?Q?d37D+HeuPGZbq3l9RDrM0+I=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa46b63-518d-4b18-cf1a-08dc033f7617
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8024.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 22:43:48.1733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92VuehLEmexrj5PloUWkoI3S6OhLeelV9bX78jGJFqGhxKTwwfD/H1sTHoVXFGMIh1he1fHN5sY5U4IhTiUo6+b0z1G+8w4CYzmspST7BTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6282

James Morse <james.morse@arm.com> writes:
> This series does two things, it changes resctrl to call resctrl_arch_rmid_read()
> in a way that works for MPAM, and it separates the locking so that the arch code
> and filesystem code don't have to share a mutex. I tried to split this as two
> series, but these touch similar call sites, so it would create more work.
>
> (What's MPAM? See the cover letter of the first series. [1])

Thanks, James. This is really useful for us at Ampere since it enables
the MPAM driver on top of this series.

I've tested this series on an Ampere implementation, by successfully
using resctrl to configure and exercise MPAM functionality. I can't
speak to the effects of the refactor on x86 since I have not tested that
all.

For the series:

Tested-by: Carl Worth <carl@os.amperecomputing.com>

-Carl

