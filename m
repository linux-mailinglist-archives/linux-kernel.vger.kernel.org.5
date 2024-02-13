Return-Path: <linux-kernel+bounces-62979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5BE85287F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E743F283098
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAAE376FB;
	Tue, 13 Feb 2024 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NTz8Z3mc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TeNA2R6H"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5D3717D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803850; cv=fail; b=L4hinT0koQgi9jee+XmUVQQRmfjq9IOryzvJbiVvHZh2qSPu8tfASfio7ZHol7q/4KsXqzCuF2x/m1ZEn25txEOp0a1H5nPMCql90Ru+0GAa+Zyh5t7di3hyPRrvj0J9/sZJqW21sXoZYGhXxTeYyUEb7TaXP/rsBdjkNtfj4eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803850; c=relaxed/simple;
	bh=XDjQhS9lPGXssL8EbAGlcBJie6Q34X1PmYxpIbDppPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dg+7JnQxZBMWZCIHwjA6v8smjwX0y4wlAITbcwRg+QYNF6ot8MVmhn6Kk4hdKPzTt4TbIUL1mnCgXDYBS4cZdbjnQ3IUTpNCqrzWe+zLntD7JohcyuMAYqslZ4+BZRupehY2fd8Os2mzbbxMXNQRXFtiFyPjb6VzOKZFVBMna1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NTz8Z3mc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TeNA2R6H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5ZIP4006358;
	Tue, 13 Feb 2024 05:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=SdJNpFEBBZnwiy8gXkBt3C6Eqpxv3bPK+R2Sr8Od6hI=;
 b=NTz8Z3mc3gTBZU5+l2q+u6rA1QZseRy1tKou+FsH3f69i2uEJ1BdfxTwhFmn0jhfwjeO
 xi2qoHA25meFB2XfOylrehHvvy3pz4n6rb+L7PRAZWgQlCGq/SoJLzjJobKuoP/GuyWk
 DNQ76ysYsfkPRaqs4lKEZAngyT617MaEJqaREfY806bXURVOwIHZOyYQnF5WFxTADoXM
 S2Uwg0S99x5qApgL8OSMuc9EPCFqO+Df8zQbHqprgS8yq8Aic1PycvPIA1zWWZj0zFts
 0No3l2POstDJZbncUfc4y3f2tTiH10VH3wED4vSjzvKJ5d0t7BZaQYdo78tCMs3Pigrg gA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82d7r1gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5uZxt014991;
	Tue, 13 Feb 2024 05:56:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6k8sr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neENiLYoUyei/fCK3+BqBKIdWbN+IV4doYpijYGYsl+M5va8k3n81SmLLY6Jprnl8W6eZF8uYqC+tp2uR/k4TYGV80UqbpiwYc4kbw9HLUo7Ter87VertG/rPe5gff5aWsjaadrv7DL7kMEoa+j8HTSDbLrkSMJTANWIbSEJ6HE2T9F/Gg2C1pkrtlt5v0zuunr2nIPZD6ZD3KHbdpQpwSnRf/IRUTDdYoeNE7LOdvRE3C07MTi+I2AFpteWEahHoYlDOrKRWRC5wWUqKjBujU73O7yaYaCrkggZu4jg5U0ZBRAHL4vsq9RMuAbxF/wN8IlkPXGMY9wr+40Sm+VxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdJNpFEBBZnwiy8gXkBt3C6Eqpxv3bPK+R2Sr8Od6hI=;
 b=MGje3ZTq0DuwyTcyj+sExP47lSFMjjbz4vqbGDIJD+KEYx40v8Bi0Q7EUI+GGO/ANw+zxzILtf/5LdnjlNwq+FS1CNQvw2fZG4k7hMRx1VW650dk1e0Waz/5qvk6pzGdR1lxxSaO5jDQHp5iq65/JPHFBgdDo29oKmceBngr0k+7P1t6knKAhiolukwOJzeoJjg9O0/4qt99oyEP5BRnKClwsAfs/qOFbXylXOQfDkbAGR7ld1X4NitJwXpQYL6epWtgmXB+x8rfLB1ZXDGu0GG+13I9uUnjriPtALoUdL6T2ro4/3iuupp7kYS6MXhz9f4SBlljtB5+ahoToAzj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdJNpFEBBZnwiy8gXkBt3C6Eqpxv3bPK+R2Sr8Od6hI=;
 b=TeNA2R6H959YY18xtJ7+vU+B50Jmj4GOKfDaU5eYZVvZ1o8xAWbkqBx/nnzSM22eYpzSNVh4ZAMjsL15t2FYhWnnx7ON4rcb1zKO00ji66GLjtygA5u+5MVx3Ps6RbjrImsFWRXhEFrACHjXWXRVlX/SeAYNI1ftcBX0iPxq18Q=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:38 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 22/30] sched/fair: refactor update_curr(), entity_tick()
Date: Mon, 12 Feb 2024 21:55:46 -0800
Message-Id: <20240213055554.1802415-23-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:303:8c::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: e95b355e-8ebb-4a54-4956-08dc2c588b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gQPazGmPDoBTCMszzvf/YOQ8ICqf7z2OVWC/605Ox8tinCl8jsCW9FLDsVdjq/Jh6R+6AeGCT3cBZ5MuhCRLTYRsQRxHBAeqgNgxfPBiyUu3ULbnVrnQ31io5jCj+SrYfdUs50yyeUTNC3D3iaKjQpMzA9Y5Fr/vPfJGjyHKTiksRBcjM4m8VmixwvG997r9KUMUpDP1YwxZXrXG/iHwKPNjV7BjFoDkf5PWbWRxlRG7unnzMiLv6vhgyUvdbIh6mYQxfsxLDAx6lXmtUlN4cfVST7sxVA/nDKpubGu3fVstLXnZzTboTGM0WCw3XGLUxTu3I/dOWtHKm0HvcF8bvOJCgK4eTp2dqGL95szOkWL6ERW7snqBPi0auC/q/CpylfaEB0IkE5pCKu6muusr+IHXaUItOP4NlyMcZwtbB2kqbOaueJSDeAm2gqFyO47w3HjX30JtBFv2Knvo9JkA0D4C8iydpcHGjjMeG2CQnMc1Odao8PpbOlB8AfoSqP+/zyvHYGrbKkTCpgGuYCjunH0MTpto1reWB3WDgPBzwQjHOcS6NBVD2ivbUGTzf3U4
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(15650500001)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iEZi7uGslFmOkVWCV2Hi45kmAQL6GS4UxfsPQO9ZDW5px9wCGd68B/SGXy9O?=
 =?us-ascii?Q?l2MOLmH1toU6UHnBJ/5LJH/wK+rs0RdGeTlMxAf65gadDi5Xdpqf8aKRshg1?=
 =?us-ascii?Q?rmawGZUmxAzjATtKVmQBrZ76HozfJ+c9CmVdwQf/B5vB9pgzGogvomG56f/h?=
 =?us-ascii?Q?z6+3X+OWhZLrEJoR2P3c5t1dLLCTQPVpHqoAi3lW37GRv1xPA0uTUHHIc308?=
 =?us-ascii?Q?90/ciqHROtaYZbSBoWENagVAxYVAcjmxBRsjvUKoUcmZN1uhK3aiBa9a822M?=
 =?us-ascii?Q?zQfzsf5I6/y6frTGPCGd23FNJbMR0K95oEr5uqYHGtkW7WAZuEVOPqFD+ts0?=
 =?us-ascii?Q?xDiuaPrVjFbG5PYs3fq0LcNRIwR2Vb+2JPtapTzY1EP2E17OPwKqE8yp6tL4?=
 =?us-ascii?Q?2d+zEUSJW4vOmfhkxCqbH5KsKpIZRbOEIZ6Be4VXSh2qs9B4fRyfi+EYeQ7x?=
 =?us-ascii?Q?xNWILA663q8I9VgTOjFF/U2giVxnMZ0evEDPuB2hcLsSFGJg4Pp3KJd+6MZe?=
 =?us-ascii?Q?t3ynunk0DTzm0DgvHjV0p9wASIFD0uemh8CpgpBZ+PHMJL4+t5dzYoMrE/Bw?=
 =?us-ascii?Q?rDyHMuRUgJeThbQFIL4qedydcmeOn1UYRDZZJ3wjtmUm9AgBCOmdrBpygeSN?=
 =?us-ascii?Q?5jYqnS7+WBk7tgiiOf8bJyAFAHQ7RwiO+3y0ZkkQT+gTZj5S4Hxz0VTPpuIm?=
 =?us-ascii?Q?Cp6udx714s+f0AN7UkI5fTsomLl+yWtE4L7Xin1AxZliZKNh9kzhdIPeSYnw?=
 =?us-ascii?Q?bm5tl+krqWvFGEJVi1k5RsmO9fcBPupWBMMHg7ppWMtlH4bo6X1jVEeM4ihw?=
 =?us-ascii?Q?gRtI71FZcwEuYFKATdlWflGJOYn2K7T0XoabkUp2mynslB/Rol3s5BT2qlCC?=
 =?us-ascii?Q?W/hBGdkgC15DGPlQkXSVKnuLyqLWags60voAZ3XDC35CLNtvyJtltLpfIYa7?=
 =?us-ascii?Q?kiklRZm3+IAWxQPwx4SNPPRMG9775sL34nt7H9DhiVl8acwVLvl7chjVLN7B?=
 =?us-ascii?Q?vCQstrp9HPg28xedfjK1ReaArzo3O3cxM/rzLTm5k2vnp0DTXYkvh/2ohWHx?=
 =?us-ascii?Q?IuaVRcI78XjvPxA779RC+Q34x9Lr84H0i9GW0yOZsUyIW70l88pQUMFRTi4X?=
 =?us-ascii?Q?oTfO4X826+OUnruo1lAdzV7xd5bli3gz2H2zSln1OTPouqsVtyrw1BV7uuT9?=
 =?us-ascii?Q?ZntQ+wIuDuQMqZQRYVRaNpvpL5R/oV5QFFSWcE5W9wTkpllPBV6J1piso+FT?=
 =?us-ascii?Q?CTJXrZ+omqzXs3PopJDVaJatE3MlwNoYYC/xzmcmTNyZsy242Xv4PzBh86rV?=
 =?us-ascii?Q?PDwpAjIMiJoVDqoIbr1ITazENQk5y0f81YUXIxZQXcZFu0SxLIlFdyWbR6LC?=
 =?us-ascii?Q?/+C+zoFyU2BRJMxHYWrrwqhJSkieHX8YubPdIlMKtMcDqFn6arQPLxv+xv59?=
 =?us-ascii?Q?VSUntwcWEFjbC1dJ467BGAEXM3OeNIZiym3rLocdLaiykI8nhvyt2j8+5Pik?=
 =?us-ascii?Q?LpfPvqExx4qGOmPlN8STFnk0Nvhse6pYFez3R5u00H4dvz86yH+8dKb4j35r?=
 =?us-ascii?Q?HHXkDzO82oHWIEOkNETehZwVKB/wdx8GARNmfVWWsiE08GeNgZYBSRsoMl+S?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mkJNLTLXgJMFiUFXR7xs57U1ooJNsqw6CvUQG1fFj0lZ4tuXygAq9lTco+lT23lSz9UvDl7a0r/y0bsquBE7DENYaH7mdX4FGDdh/W2TrL1Kx0/I8RX9cGiMmNyTfUDbz5/9lNytlRDrQ5NrvXlc4zHB/+QMZKiKeOW1eFIB1G6Cd5bLckaSJRV4DcPhTllGn3/3K9mq1RlfnUUKlGL1wTJAPZh0xcbXiulxQRP/qWNNyMEuVLrNReBfckRdtbeU+NUfS31YD6H0I/XvMc/pzk8wUNdpDMyw4r2hClrA7qaLeXh9UR704lq3dwTK8gzRxYY3Dk4b9IXiUVsthpw0fGWHydSMDAhe9cl+Q7wBMCv2wO5z1Mo1hGeN/um2wQMecA3VOlPIksm7x2ewrq6uvqgoT8YSQEAsGm3/k87Q0qcgCcSuoFO5YkbxP1AEUJr9AzQD+T5yYaFosgNiekpXZKAGlRYK/QRlaf1exHp/8EFaFOKpgDf/FzD7N+W2gQhC0lj8cpcP6y0E14spZf0N4hoMDUMKwnFYOhWuMAqvxdF5RZz+0R1WkJRwagW7j5nN/sen86xxhWZZ+NZGKCAsHDDuyGz6WwWXG75qhJhVF3g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95b355e-8ebb-4a54-4956-08dc2c588b5f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:38.8141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P4ujcLPPrnHArHoIid3mQNREUFDIApEe++vvlaz2udrgUdO5jBpoEWBUibpDDtFiURNe6Zp3yKwKFS4UIUA15RmPEY3a2Zttg0b8e7nldgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-ORIG-GUID: 0RdEmUMVz6onagjUqz27alULBnpRVvBV
X-Proofpoint-GUID: 0RdEmUMVz6onagjUqz27alULBnpRVvBV

When updating the task's runtime statistics via update_curr()
or entity_tick(), we call resched_curr() to resched if needed.

Refactor update_curr() and entity_tick() to only update the stats
and deferring any rescheduling needed to task_tick_fair() or
update_curr().

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Suggested-by: Peter Ziljstra <peterz@infradead.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/fair.c | 54 ++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae9b237fa32b..278eebe6656a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -975,10 +975,10 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
  * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
  * this is probably good enough.
  */
-static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	if ((s64)(se->vruntime - se->deadline) < 0)
-		return;
+		return false;
 
 	/*
 	 * For EEVDF the virtual time slope is determined by w_i (iow.
@@ -996,9 +996,11 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 * The task has consumed its request, reschedule.
 	 */
 	if (cfs_rq->nr_running > 1) {
-		resched_curr(rq_of(cfs_rq));
 		clear_buddies(cfs_rq, se);
+		return true;
 	}
+
+	return false;
 }
 
 #include "pelt.h"
@@ -1153,26 +1155,35 @@ s64 update_curr_common(struct rq *rq)
 /*
  * Update the current task's runtime statistics.
  */
-static void update_curr(struct cfs_rq *cfs_rq)
+static bool __update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
 	s64 delta_exec;
+	bool resched;
 
 	if (unlikely(!curr))
-		return;
+		return false;
 
 	delta_exec = update_curr_se(rq_of(cfs_rq), curr);
 	if (unlikely(delta_exec <= 0))
-		return;
+		return false;
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
-	update_deadline(cfs_rq, curr);
+	resched = update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr))
 		update_curr_task(task_of(curr), delta_exec);
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
+
+	return resched;
+}
+
+static void update_curr(struct cfs_rq *cfs_rq)
+{
+	if (__update_curr(cfs_rq))
+		resched_curr(rq_of(cfs_rq));
 }
 
 static void update_curr_fair(struct rq *rq)
@@ -5487,13 +5498,13 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 	cfs_rq->curr = NULL;
 }
 
-static void
-entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
+static bool
+entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	/*
 	 * Update run-time statistics of the 'current'.
 	 */
-	update_curr(cfs_rq);
+	bool resched = __update_curr(cfs_rq);
 
 	/*
 	 * Ensure that runnable average is periodically updated.
@@ -5501,22 +5512,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	update_load_avg(cfs_rq, curr, UPDATE_TG);
 	update_cfs_group(curr);
 
-#ifdef CONFIG_SCHED_HRTICK
-	/*
-	 * queued ticks are scheduled to match the slice, so don't bother
-	 * validating it and just reschedule.
-	 */
-	if (queued) {
-		resched_curr(rq_of(cfs_rq));
-		return;
-	}
-	/*
-	 * don't let the period tick interfere with the hrtick preemption
-	 */
-	if (!sched_feat(DOUBLE_TICK) &&
-			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
-		return;
-#endif
+	return resched;
 }
 
 
@@ -12617,12 +12613,16 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &curr->se;
+	bool resched = false;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		entity_tick(cfs_rq, se, queued);
+		resched |= entity_tick(cfs_rq, se);
 	}
 
+	if (resched)
+		resched_curr(rq);
+
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
-- 
2.31.1


