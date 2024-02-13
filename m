Return-Path: <linux-kernel+bounces-62974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC69852879
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7635B259D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D57A29CF9;
	Tue, 13 Feb 2024 05:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AaALZoWW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BpZxWOUP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB2D28379
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803840; cv=fail; b=tTic3sN8wV/8u78sMePaDe+YRQVF5z92WIjwCICRygfH+hpzH0p3cqtznjo3p6Q+kRrBQ+LQ5sSQMxCmoqo1h7fT2drcG6fKrx71Uzx8kGaOW+a4qy753jppJmpk9mzvMiBPzjYlEUsG1sTw1YVBQeicrlKJ30xvO6gDM8VaWi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803840; c=relaxed/simple;
	bh=JjC6I1Yt5TepbgP7pOwxCPr07L5TXN3oQLxBWuDrOlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jlZUENOLAtEb9P93KaTfU3gWcpKQAp/TYZUu+Mfof3Ob0GmOqOpu28bgM2HhkS1XgoziAICmoRd6GYXvNdve5gYS5uIi905GUtYWsB1rT+SGQ3ZYXdYHP59DC8T1fFeaxgB7uJ9gg02+UoC0OqJl0Ts8mfkiWVC/GgR9Ps7uNGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AaALZoWW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BpZxWOUP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5n0bQ013674;
	Tue, 13 Feb 2024 05:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=yJLNdEfVBhdcfZaQk2QRGE/kfdPCbqx9mH+b0XBRGZ0=;
 b=AaALZoWWj4y0oUL0YRSnQCrckyqQYqRd3acYPnXkn+twVhVe+brXy0O3hqIJYSChxEnI
 z4mqNG9OiBTWtEwIFZ5nK4FQXoU6qm6iTnxO9+w0EilnN5W4TsEtOArW5T//AGaixiLM
 ECxUHqLtB48SM0ZY8eP6q5wKiPQpiLqTP0jD8fcpLWGIkCp7T/zWy553B0JZ9fme0D4L
 +54yW1Evv7x9oHLGH1a59T7g+sQqtBk6SJfu1aEQEf2z94PsyloUfuN3y3raXyIu7LVK
 xKgjtSqYzg4I7H2pcKCA40Cvb69MKAFm7UnznMkn2N8+LWR+zWKXBT1eisX1DNGjw2KN JQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w816tg49y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D3YlWG015085;
	Tue, 13 Feb 2024 05:56:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6k8jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8WixgJtk6rYj36Q5uweHWUseXTzJ9wUhSOPuILpSVrTNTQm+YGquXSe1XC2V7uaLq2PS+EgToGzg0mWunyZrLUe03XiOUDwb7V3VhzkYVcD9Nb49SUkfgg5It1Rt4OTipOA6VUFk8ZpAIMCfaCirppQb+re/a0nX1pL003YS9iOXeHoSXbXMb3rJmOkjju9eBHtF3GfNzmXWLTBQ8b/S21QjNxlcWlA1VO27vYEERMYCP+WTJlZcOZEiVXyKfbrbZC270OqbjKDG0uaeh4dlzBvwd4RSzI3fEa8Rd93yFWJHiL/KOYk+HnZdyUZDXLKw5KI8eQ4GVwM8Pqn7+joOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJLNdEfVBhdcfZaQk2QRGE/kfdPCbqx9mH+b0XBRGZ0=;
 b=mLGKxBJgVTT0avov6eIVyUBE/qxX/r1mKOrMbCQtO2o9g5ZEDFe4+vH6bPgfl19s09vcSsPT/iFb0IoYu/GVjQ/XaNIDjdKIyE4TOss3Hf6+TyqQPg3BLNAI5K5zAJJPQDUt5xb17L3hiZ+7oV1gKdCfX0c3fZMSYv+9YnKn3F3W9Q6IGuQJ9ik4HpYx7emAT0xNdYucSGwJb/nNWFpMBDG59CiWlywhJvcS8XvT6uwNf2oVyFGgnkTRwzxtaxdx3uHnzRBcWx6pYqJUMSklDAVfgFsC7LIJMlkKeYwGWIQV1c1v7VyqSBTyjovLhTwLro3aH7NihgX8I9u8+oAH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJLNdEfVBhdcfZaQk2QRGE/kfdPCbqx9mH+b0XBRGZ0=;
 b=BpZxWOUPt4Qe4cwMxGBM6jX9yVCYi/iJzcatA+jaIUz5Bs53u2Qp1WjtEBlaW91EA7DJ3MJGwssuT6OQZ0XoE/U0FMwkZW0HluEsI3oDbJ/7ojAztPsFDnhcJiRk0Z50CDEAI/Sj32duYItVhbt0O5JPTtyGYjICePYxnDgVxyc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:20 +0000
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
Subject: [PATCH 15/30] rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
Date: Mon, 12 Feb 2024 21:55:39 -0800
Message-Id: <20240213055554.1802415-16-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:303:b9::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e167990-1449-4efd-9094-08dc2c588034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VG9ABPqmMxjxVpZSt9tzrUIyyueOGRoTEwBmfX139M3jsfcmaMf0OI5yvabT9F7HH/M2Um/PZ4foF+lt53G7URijPermP5Ivvn3nH08Ws9rf0ZxCGBfhmhIWhcEr8kSBmWPNuRaPNG6vPKx2Oz28qWW6myJna5ZU2XWTNGRp5TB/XgaQrqeImkZVHRcuJMS6TqIsqBZPF7xF3NRDRNZk2oFlh+mQKS+KKDrt5F39WYHwbctRUyhUZZW0KLLQYM7icJkfkQB/xk87UJFpvb4HCPo1bi/lx0WKIA26a7+r6runrjfWbW1s1acoVxTwM0T94NmAyDeGlaaBdSMjnsjm14lfCnG/l5lrRjtrUbF1nvaLP5QJ4eyYP9UZ433OqYtE2Jy2To2xtSHuVKl+Ux73BN1AWupVjbGTs6htXaVhjcvnRSAR99PVRrB2gMPCANMurW+WtrJZiljHOpNQi5U9bkF8aimseRyB/q678fZ0a5DC4m++Fb1/A61XWXEcFB69tRnTHXJI35L4npGek6HT4isoDu3gIuC69J4tIXpHZu+MCRiUWOPUvyqCpUSroMJB
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?n6eOdKp+2mVk7mkEIT4aESeKMKe10KEBEqeE1Y7flc5EbKc7FhmaKo+Kp6X0?=
 =?us-ascii?Q?pnqjVcVq7V/I9qPvM+GGNyvcG3ixA1kTks5fD4BkvaI3T3wlgz3why9aOrae?=
 =?us-ascii?Q?Ogf7mBhf2NTq9hyNoS84IM4SoBra1kEM+DSsCYfQbOO9tmwnXl0yKOsNj3un?=
 =?us-ascii?Q?hn3FrhEbTjDT4FGlMTudrca06rjtAoQuEJkOeyGzMtfPvPVLWtRWrm2XN6si?=
 =?us-ascii?Q?FMni7p7HbWRQPM5f5UjkdxmWBWOroPy+RQ8htxSEv0g37uoCKU9fyQtO1nv/?=
 =?us-ascii?Q?kOasNqCEXf94BRd17kXp17lRpzba/tCjk9XvTToaK5tbJDy1RfE1t1Fj6ZX4?=
 =?us-ascii?Q?xdc3a5A/yhgfCEzAdthPQHgy5JPRzELqiIiKPCcx79ottdhjZqTwjdKGzBXe?=
 =?us-ascii?Q?vyN1YpU2ZJ5Owv5E2MFn/gY6xUPmDI+/gANxeisk6ejS2BHhEoKQsdOUAjR/?=
 =?us-ascii?Q?ltRjFoynuYysY0ww0ZC3QSPWYuCHMOLosHExxAilEH/9LYoqDaR+abIrPLME?=
 =?us-ascii?Q?gvEg/WfdEFGlfAdHh4+A3EWtarIcePnEM4MmMS+/squbVOHjiZbpNDndz1Cc?=
 =?us-ascii?Q?Tbshf2D/4/9knQVz3XM60CXMTSh7fZijGSUig3OP4ZqVLxEE7udcI+ps9/Wo?=
 =?us-ascii?Q?QnX6v6NMq/oOzwW8THGmxGG8WxgfIzZUxaFpBGsYlR7M44Fqmz72CfCETYDV?=
 =?us-ascii?Q?EwJqEcJ6n2O0O585pUEa+LqDixzoPuO2s6axOCqCfslHzvfsex22WfLm9mNr?=
 =?us-ascii?Q?uIfGZ4NqaqxDJUEDKrNMYqHMU5635mQ9biYTtxREH0mXXU6dBZ454me07b64?=
 =?us-ascii?Q?KN7bTB1w2kZVfkurqVHoXBRns59J3LXySWukaZN5GdyQj3yKHhJFxJBjGmrT?=
 =?us-ascii?Q?uiQwNNzzo+fzOQ3COtIphsJ8bRAa5BjOEyhjQ8z3LwHc+1csgGBYiDl/dcur?=
 =?us-ascii?Q?nzCrpGud/lnfwATNYlK8vN1nHG8GCY9Z8kYYEPlh5Jzcn0a85Z0/zvmHEYi/?=
 =?us-ascii?Q?BRV+Pvhd9YWCvG0qV93xxz+SLsyOxugxXI036QbpR6Lro/7NTd/MkygLrokm?=
 =?us-ascii?Q?WXJTaGNnq3dJWD7ssdXBBzZfFtgjr04SrA433U0IYXmhyIVKH+P1GscU28Km?=
 =?us-ascii?Q?b1uozbLZ6baxXwJTUA3D2epMb1baGH0PqZ+UR3B96cabHY5bB/3GIqwgac8F?=
 =?us-ascii?Q?MaTIutCRA/ITYUpoRWdtg3Rw80Io6R8quSuQyYh1Sfl9C+0Sm9Q1+MmYnC5X?=
 =?us-ascii?Q?14qNrxkumP/TuZS37wq7J6XiXvQNK7tsJgt/4gNhc9maYXRxGCSWM0K2cCRs?=
 =?us-ascii?Q?BZzd7aI2g/+lFC99DKTtzgAXUzwMo5oYk8IBPk/tJV2XIbkupqpt86EHn7EY?=
 =?us-ascii?Q?lZFdScXuKXExvE7HGu5Clvo+XwExo6FLR8C+DSmPHO3g2kiOKn6aEk5h0Z7M?=
 =?us-ascii?Q?ppLY5ctllNqNFrUDGVTnKqkJcFLz9ypb/lDc7M9u9qcKqAfX/H+7bYjFADmO?=
 =?us-ascii?Q?hjI4OUFCiGMBGuilU8dFgwhsRHDuxfq5MQKH6OmgyZu3qrtzVBZZfdkrv7Td?=
 =?us-ascii?Q?mOZ5gMuR+sAeUcL9enOSH9j3YvdEPyfoVJQHD99/TQUboyqJ9yAqs8eQFvRH?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	f9pMC49EDpKuUz6+tlePZPIO1frqqTkUdfywS9wU1lWrmBON3JDEEAoqnXYLF2mYpxEd3kFoNRGv4Y5qUTXQzbl/Om+PEEk8jRRJUZpEBWf+5lADMtRNQQ3vwELvi4pWuk2o5hHWPp+YusTfwZI0Fzf20RT2SpDXU3gGefOCKKHB+OmabUrF/POIm7Tw5BdvEZcrJouD3gNGe2CZGneydkIJbMLs5E/eWFGM4GW5rJUBRA1dHUkdXHNsmez9QXFfUu4qBRcMFfrHJi8Kt+G1SgNp0cLIow5w9Ja4REQgiQz5sJv8sWSM54lQAGHlEr7b42kIdW+SvfX2CcDGNjkZ8h/I+WPOXyL4zIVWqpkH1ATKfVGc1RwkmMapBBgH0I+4yIxmZOWL8QuFwWxjhGfsywYQLWP2nAINHsOA/vk5ycWWlaHiR/XWnpQauvBKJxQlbbs/oPc/+awOGn2dsWc14UBJZPm9I2oOKkvY5LtqBrV43oP5Ls+tktmM086FMjat+Q75sNViJXemHkEOtXTqHeqds9eFUDTnTGhIldBUHO79EyKZ6dMmQNIt8+RIsd+iLoIkJOslBUPP6qMDjNEES8l08iJS9LRQnK5lAlhi5nQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e167990-1449-4efd-9094-08dc2c588034
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:20.0803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liU8PpXs/k9jGfapHxe5XQngIFJlxxM2N2ZP0o1Q7StfitM3p0QfG0GEH9roFzQgkEd142DF7Mpfkrf9hoZ++BIXTEc7cb8vkcNiBQEquCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=969 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: -jvbt2DS2DVl02mf2QdxwccquCrtnsUh
X-Proofpoint-ORIG-GUID: -jvbt2DS2DVl02mf2QdxwccquCrtnsUh

With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
states for read-side critical sections via rcu_all_qs().
One reason why this was necessary: lacking preempt-count, the tick
handler has no way of knowing whether it is executing in a read-side
critical section or not.

With PREEMPT_AUTO=y, there can be configurations with (PREEMPT_COUNT=y,
PREEMPT_RCU=n). This means that cond_resched() is a stub which does
not provide for quiescent states via rcu_all_qs().

So, use the availability of preempt_count() to report quiescent states
in rcu_flavor_sched_clock_irq().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/rcu/tree_plugin.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 26c79246873a..9b72e9d2b6fe 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -963,13 +963,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
  */
 static void rcu_flavor_sched_clock_irq(int user)
 {
-	if (user || rcu_is_cpu_rrupt_from_idle()) {
+	if (user || rcu_is_cpu_rrupt_from_idle() ||
+	    (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
+	     !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {
 
 		/*
 		 * Get here if this CPU took its interrupt from user
-		 * mode or from the idle loop, and if this is not a
-		 * nested interrupt.  In this case, the CPU is in
-		 * a quiescent state, so note it.
+		 * mode, from the idle loop without this being a nested
+		 * interrupt, or while not holding a preempt count.
+		 * In this case, the CPU is in a quiescent state, so note
+		 * it.
 		 *
 		 * No memory barrier is required here because rcu_qs()
 		 * references only CPU-local variables that other CPUs
-- 
2.31.1


