Return-Path: <linux-kernel+bounces-142523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDAD8A2CBE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04931F215EC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85175490E;
	Fri, 12 Apr 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WRTQecta";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fULPVSSF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5C548E0;
	Fri, 12 Apr 2024 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918666; cv=fail; b=YGr9v/GqQwyy+urjUiIySs/coSdqdtlP2qMTBkquKd12nWwDGNjvjdUJ4ddspEI8bsbM7QnxzfrOKNhAop7Q8mYq+i/MlLQd8U0Q//poaVc8UQswji3kaoYeekKQELvawATe2PEJr/R8WzkFMmiiQLhlTkecPS9tDbP/dKsKJZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918666; c=relaxed/simple;
	bh=Jsr4iQZ3kCt7oaBT8j/U4orxxlFsCY70kgLVpcfm6lI=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=M1n1hHTqnfPl+/vPf7iWTVLEZje+K4sNeUinkdwN3FbAW0pmuk3l5YkXDbihKs94Wf0jO7MmAcmPoHU83GuoJDXe+riL823nbh/YAhhNPVki7mvOPKWrKdgXtD5Yc0LZ4hpel/Kf6USH8K4YQspeY8hpJamcXyhIdMs7JHlqWec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WRTQecta; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fULPVSSF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43C97B6J010377;
	Fri, 12 Apr 2024 10:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=6XsbS8ezrdDrosgK9gpdSp68VgakNURT5J2cZKWRWS8=;
 b=WRTQectarksHGIcrQlcW5ynDZEabqJrWM86gKvA7lqYB0Vh4ngs7BRM0Pj1H3jpfATKr
 792A8v/iCtD8oRyH3ugaHeuiaS47RqvGmLPbS6fxri+C37mUxIqX3/hkX/uVxXGHhgQJ
 8YMPHHCHkCaW7AJDEDn0LkgHS/Y5PGi0A/QTAehdLMvOCBvz4SY+XLbieTBeZvXKG1Df
 cDa0a8HUY8NP/wty6NQvvcLpkFpLiAaO5owVdaZh0Yxx8KW/kam8nFQq/M39Tj4+x4Dx
 +isTAoxxgJNLroX6TIuITXOsXph65GdMbyDwt9hSWgerVFNN20+zzmFrV559/dUN639f Tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawacuk2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 10:44:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43C9nOC6026287;
	Fri, 12 Apr 2024 10:44:15 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xdrstwrrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 10:44:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7LdeqctXteokEsvG0/n3JtDzKviSgIfpLoebXWtIUNvqtSBS5keQXacQJ/lsvuHcQPnCzSbhnIQgf7LYph5PVBnKt9dpyzrI8M4FkH1rSh5OfO4HNH1Q3TnJoNc1/AxlkJp2vAV+lkkm+UZ6oU2jc5nAZYSBS/lVop/Y4BSmWbjCQSG2pVr8bIQAnUYwc1Y6TzxgZMoCc08i5cC8qoKx/5K09clbfUFO+FuHrprZ54CaQN6/xgrj1DrJk/6AQ7v1/bwizXtToyzuAh2y3hj7tURaGDFa6v7HHTrtoZqS+m2yzUwrjMa6kLRnCITQrkFTiDOFEUB1QH4z2Rpt9QwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XsbS8ezrdDrosgK9gpdSp68VgakNURT5J2cZKWRWS8=;
 b=VOLbN6gcX6EGFOQ5qRhOJeKI8lmrfIaUO+ThGAPssBulNn4hnW2umSt7GwlFDz5V4hXx4MaACD2lXH9r3XFC5MBByxyXsgSwN5N8nLntAjfehwPcmbbxBp3+VXO243dYg5iA6ZEPa0bNMtV3pGAgRcxfAzfLAQq4IUY7YcYtK5aAFJ9Go+BzFKP0W75FIBD8d62R1PisJSXLdninke4YZkX/NFxXxTqJCFWWgSIrseBtXoqg0wTjQd8tq89H51N+eZ4QRXmG5Uzx55zVsPUB2zhbVfljdsPXtEjMOpekChwftbhefbzvTF05n4HJK+1WvOZJwDnrgbnZWNYvudH/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XsbS8ezrdDrosgK9gpdSp68VgakNURT5J2cZKWRWS8=;
 b=fULPVSSFB/dtL0nMWFnUd+uk+ejtEAeGFGglEAOATBiyrgDac+tx/+6g176qmBulZGzKPFwfn5zE2Pbenl7owsWYnS8DxNIqXd2fMO98yVNsZl8wVQw0UHi1MWl949/CWluyQf7G9ivg2pjCPfxxDtXbkjV5eQeo4Osy4KFhptI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7521.namprd10.prod.outlook.com (2603:10b6:8:157::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 10:44:12 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 10:44:12 +0000
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Stephen Rothwell
 <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <yq1zftyj33f.fsf@ca-mkp.ca.oracle.com> (Martin K. Petersen's
	message of "Fri, 12 Apr 2024 06:22:11 -0400")
Organization: Oracle Corporation
Message-ID: <yq1ttk6j1zm.fsf@ca-mkp.ca.oracle.com>
References: <20240412154607.1b5096b3@canb.auug.org.au>
	<20240412060911.GA32268@lst.de> <yq1zftyj33f.fsf@ca-mkp.ca.oracle.com>
Date: Fri, 12 Apr 2024 06:44:11 -0400
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:207:3d::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: f83274a2-1d2e-4b02-6506-08dc5add7dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JcNgnnJIhjeR6N+eVZVHSqRCaXENCS1AJ5GtKRvKRezzFHfeSkQZ0W8nziXhxMmxU4e2H99e5GBSr6/OIlMYzLd3wEVl/KA21HqEAyVJeuRbgpSlCJ/pGBk1HembD5ZnnbFLR8S5RIaTk++jyGkSP+aSyiMuOwaWbxg5YIKHUtg/MlzWhxBjh2dDpZgCItvnUxRNpgu00WQERxbRBlZq50CfY9D9nnYGVQlvyZKMhbXYHFiQQXw8tfvRDejRIoOrBqCb6T7ne1gpnLlgsOhPmu0O17OoQIqt5xBmgbM4jLlAyHGX5Sn+/2Q9GHQfmW9A+J6/zVX6fyslLGmh2sv9tmyvft/frKTFrRgBClht6ZvhYZdrCznM/iSSouot9pVeAy/BBNjJ5xY5jD4/dK7pKukLitJ6T+MfIOF+UtcoUUuCRyY9v/urLI2w1p742flDdO9lyXt7sq3qguFG4Pwu8nMGryfHlvIcGkAeVpIdeH90CFpf85KOtSXDjKhssB9aJkqbNhHzwJOqyrqBp3ljHABKQ9x7LWReUWbequ7pD9W8rw37KaHw4IStsqGyx/Ez7FB9/SFHpdjnHlHDN0QhWe/stWlWANtvU4a/dEpLiRsQ8IOso7B8C6OrtxNCy4KQloeEiTdSBfNH394Ejp0bTg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Kcphqcv9hMOSinDMaXsieqhCrZUfXkQqPVRcPCtx3mhO/n7UoHD9pMJgOFzN?=
 =?us-ascii?Q?q2uosBLYu/g1ElJJl+vucnHBv+TL+sQTwO9WdtRq/OWmuteB0hGE7LwUbrcq?=
 =?us-ascii?Q?RowhVOlEFYAk1rBIs2QdYg+YPC+d6Xqu2D/fy1bbuCxLLxgWf6f1MxadZzBB?=
 =?us-ascii?Q?eITzsZKUh3IiaMSmC5BHZQsav+s2Xn5xN0abqengvHCuVXWJhaHOO2U0INBh?=
 =?us-ascii?Q?i6UGButIING9RJPaFXrKo37nQEuiIeCZs1FoTlKVkFGpIdGuYFSv5EeXSbsF?=
 =?us-ascii?Q?WXrpOpYYFBCcjquKofbK0nfjL2nM3Lyn5tbpFsrtoeozCYZZ2U6jkuNd1eRs?=
 =?us-ascii?Q?hXMx3v4vc/tMPDUivsZoYTMqi8jU8ibQHZJEMFLBRefZuTs81cNDhTLHms0D?=
 =?us-ascii?Q?UEa4EDdMbQME9vCoy5dVOJOB9UoD7/dH7yZ70n9mzC8esaWHbT/OD7Z154qs?=
 =?us-ascii?Q?o95mMTjsLOmkscV2enH/4TNBykSq2MCAL0qhHJ3tPDffovW2gLeHmWQ/vDaL?=
 =?us-ascii?Q?AnvW4gvEJpTcb4DCVHd09BtQ0LlX9R8Nskw5U6PCWNOJFH6S4ki+qKWWFgvm?=
 =?us-ascii?Q?m61S1vr2plv88NRuf2Xo1E43JEVN0y21QuZfIMaFFmZsc1L7+f5XguwmTHcD?=
 =?us-ascii?Q?+Ba5FS8Vyg4DcYRe5LkpCrFgGFHwdvdEIk+R1obqIbRLEeHky4eFXXFMeUBn?=
 =?us-ascii?Q?A1scW5lvfaaDzRzlAW8wKJK0hyCLy4brcd1bk8ORcOh5EVP+wOZ3RxEKAoGn?=
 =?us-ascii?Q?AtLg4qonQgn9DmFO9KjBjLVu0hVOG2QH6VZfDmUcWQ9jRe8Kxb93r5jHK/ni?=
 =?us-ascii?Q?9Z0hpIwNLhW6MSXNrKOdd60A9wgAztdi+Pd10+BXiwatkwMYvU2Gj1FvWfCG?=
 =?us-ascii?Q?DnyKzynlEDwfLUtwi6xD8mKFh6khEgJ+94TN3BANu4u0wAjCtcMjarw55Kn0?=
 =?us-ascii?Q?PJzxrOSlzsWb20E8y6R+XfZojBvYhvP9bUBR3kJibbk/xsM85CWSyWdtVNbM?=
 =?us-ascii?Q?914eK3yAFXgxDGRsgpu/BiHKGa99PzrtIUX6cABLC2zX1KgrVslafk7La/AS?=
 =?us-ascii?Q?i0OK8D8zmiPdSx1NJIbidIeC9fYvIXkf+uLNTep0c/5KIVLfZd52sytFZ2zg?=
 =?us-ascii?Q?ni5G2JQmJVUqbKmoOE3uKs1B1e8ZCMaDTybQ+NtZEDA9P/y9F3p+9g+86Tiu?=
 =?us-ascii?Q?KkNp5cI0ZBLQgA8xRTwgaUWhMGCOkhiOrdYWfLrxT9dQuvyWBRJjRtNBzrij?=
 =?us-ascii?Q?LoGvdq6P+Irw7QuvjkDi7ZBndLgNNuDNh29B4RSJXKE8czPTI72X3picLhUW?=
 =?us-ascii?Q?qAaiOqumYLTT9AajMDzNHJNgzs0ZgMQe377Flo7rk85BKbGnP5X+w7tzU+Xy?=
 =?us-ascii?Q?w/j0WMl+VAX4L+LfxeZDGhVh3USGZsuJg4HE5jqZLfg/qrtBiWdkrnSN3s8u?=
 =?us-ascii?Q?IBmEygYzGuq55ey6xnNBLjvYWXEu0Rc/beAjyy8iPLlzpkgzY8YxBBkHbXvO?=
 =?us-ascii?Q?1rvbtCjWivae9EczLAM7RfX0H+Rn3R4q2L95b0XJN+y45dYbsYoeJ/MJJo+A?=
 =?us-ascii?Q?gea7qxyXhIzedE8JwmDB9XYiYZEzNsVUfgtM4AyM1UWHHdzYbLJ6tw3FSQgf?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MCPveKCH1YfYWb0rsUJgIu7GB9zkMXj5NjYT1nDJ3bV2y1a/hPIP3ssoZYGCp+vmFzrLJ90t4noHnpb8jzsm412vEsJ04BQuH9T/FEEgWXrgF376KwAtuN77tkZid3OUGCI7jJYBh6hAhKR+SCGBA7NFJcl3z4cLYfg6C4rCsb90Ty4A38wHsnVNrZQfSuuz45Ff4CUI5TCh3eZ4G6abJquRREFYiV+6zI1TM/FqPgmXTSA+qr8Z2BrWeA34NhtBczG8XTrMUNjAr5UfFwgMj34Xi8PLSdIw1PBBj1BIfjJ2NjKPHepiYaoSh4g9YhFV4CQDIgnW6/IxBCWH14fwGU0JbLGR2/dzwQA2dAIhOfwWpevUhzxeHg402hLidsCTOGFD26q7pV4Zr+1ND9qYZbDS07jUnL234mVm/IR3BuLYxEY8Siko0Z3wrh/79s3/QIjQsbAbIdEUa0LAYt+ccdIBxJpStCgR/kbVlnss49kwcPC0zq7s/uRk9hc44COd5QGGazQN4qnDtTe0JHsq4kTHm3WmUwRjPNcZH4ukZLqHHbSzAwb+jnN+VLGJARIbidjRN9zYw5XNL/sK6DtzgsJxpduj2WrlGulA8e7nM9c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83274a2-1d2e-4b02-6506-08dc5add7dea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:44:12.7552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fMbuYkqYCzyV/kHISjXeIeKJ9cF72ene0Z96CT9I3TG124pEg+78yL4WF2HMudhCbn0pRQnkIhkrK2U6zGfKteuJEEsqXdt03vaF7bbSGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7521
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_07,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=903 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120078
X-Proofpoint-GUID: BFcd7Wdafv6jPWBYv3_WoFatA0JTGRH_
X-Proofpoint-ORIG-GUID: BFcd7Wdafv6jPWBYv3_WoFatA0JTGRH_


> The v3.1 patch confused both b4 and patchwork. I'll get it fixed up.

Updated branch pushed.

-- 
Martin K. Petersen	Oracle Linux Engineering

