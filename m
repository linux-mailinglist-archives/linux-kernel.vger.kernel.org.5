Return-Path: <linux-kernel+bounces-98351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6428778BF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB8B2816BB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5233BB22;
	Sun, 10 Mar 2024 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XsHbk6Mu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hjEokUIK"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213223B2BD;
	Sun, 10 Mar 2024 22:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710109093; cv=fail; b=SCT4HfQcH2eKpazWidXAb9n3OUFx8y1GM9zWgHt4dz8s92m94CgGmw4/git1QnXRfH7sOJPbrel2q5h5icJSmGLEkam4PqHmPtJFxxNgQlS9ZP9FUZN4BcuwwdWEgU3oemhqYnUpCHCFtSLCfh04+D3WIF3s0IUbew88JkL6JEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710109093; c=relaxed/simple;
	bh=bjqw87F64k3RSVLWWm5dfmiMiT0FFO2proLVzWkeYe8=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ttijaBHSF6iB/uraNnNgBX8Dj3gz+uTt3SzPk11m20ttQQTLJAJUARRd/MZADhoGtHDf4tWMWZ3U7pnTemjTOpwsZq+LW7EAiRRUVWnrSwIqQqvLpu7NsjNBRdaog/AlsrwhuybcNIle1333Y18z+X3NNECfdpmmwezxE5Sj1EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XsHbk6Mu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hjEokUIK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42AKQqP3030849;
	Sun, 10 Mar 2024 22:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=JM6jByLOnplQ6xPBvePLadMMbpzbzFsKbvAyhfs0w54=;
 b=XsHbk6MuHWu1U1XlgTWkTuqsdrb/y2U0jCp/ZsKe1skQwg2pWoloLNOpAIfElamT1Hbr
 xaI7g9/34x1JKjHtlYHBX21vA1MrnmYZimiB4AbNLUNIUmh8FRoKbRhGKdYVkqXQZ57p
 h4cCyLDyrZQ2Os1aiaHW2T7m9vF5lzyGqAg7C8nMGV/vxcnPUOCBB0xAeXe33cZK0NIJ
 in9j7TP8Hs8Ntr86jFbKgpQXbCEog2+9YjvhT7xlozhtCdLl0v6Ekxp9obzGoDC45oKq
 raFfoqck1CDv4XiNiiyYRNcO0C3FmEFzX09+STY+I+wTiTbk0xjgRjd8Djuq4XRErcmf sA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepcsu1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 22:18:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42AJosDl019874;
	Sun, 10 Mar 2024 22:18:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre74yqn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 22:18:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3jVxRz7Rtb6ThxU6ET+42DCVURP1Yz6TladBXElbMj4xo9OBWCRMTN6N/N4NbZ0D+gZ4zloJsHdwGWXRj+BkWYVQU6yOovSStnSDFkebbXeyjJMMU/OtK05bUtgxZk9IlL0WJoR3UEQsMbl+1J0M1skA3i3MDSgUQ+3nxJVjhiyIyl/zYQfhX3zLrwjBAKaKPhb8nBv2QVXOn4DoYXgpMkrw8d2PzV1jWjIxZAL4mUibfG6/QKz7WTdzjgT2ii9fkIZefoDtsZ1na1+PbYKTWhFqpfZ/4QlwCxuHJri+/vcSQldJf8BbZAlLXqEUDDbGklXew9J5TAgkSpE/UB+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JM6jByLOnplQ6xPBvePLadMMbpzbzFsKbvAyhfs0w54=;
 b=iWR2r7YcRJLYTjDj6B4/ztb8wAXQBUu0AIBDs0RPnVeiX/HFf0xQWbP1NKJh1xaFFeizj3Wp6bOlG0EsGfKngnNv0j4wVGdhdQwzEIO5wBISHpGE2PZiYotNskPC/49ejl9ZwsHux54jeF965jPRTxAJnjnG0mGKlfMFxSvr+7GXvWC0VvAt+h29K6HLPthW/rwTBYt77IOh4v8s/Q2jDnedD/CsQ+QzDX5EUFQHKLLShUoX+jWeZrRRKWz7sevQAUHhNt10PqHpvcsFhOqc890R46/MNLWDFFNGb+8/BF2ih8LPt3GV9ks4jRZO5H+qFUf0gfgdm0ZKhvj/GbYH9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JM6jByLOnplQ6xPBvePLadMMbpzbzFsKbvAyhfs0w54=;
 b=hjEokUIK8XJiJCt10CDT5FvHINMxVQxt3uNgKyKv8s0rxOPhcaxm7hDPhdJne0O2odOJ8IqF+GOdwFfVo0wJj6CZ8/v0ABwj5epcwQb4RAg2HRxzzc8HX/uSyLqUDPpg2LkR2yNzoOY6e0k23l4q0PJNioGLWtrv5xrVgnipf4k=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH8PR10MB6527.namprd10.prod.outlook.com (2603:10b6:510:229::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Sun, 10 Mar
 2024 22:18:00 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 22:18:00 +0000
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: James Smart <james.smart@broadcom.com>,
        Dick Kennedy
 <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke
 <hare@suse.com>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: lpfc: correct size for wqe for memset
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240304090649.833953-1-usama.anjum@collabora.com> (Muhammad
	Usama Anjum's message of "Mon, 4 Mar 2024 14:06:48 +0500")
Organization: Oracle Corporation
Message-ID: <yq1plw1d94h.fsf@ca-mkp.ca.oracle.com>
References: <20240304090649.833953-1-usama.anjum@collabora.com>
Date: Sun, 10 Mar 2024 18:17:58 -0400
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:208:256::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH8PR10MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 740704e5-4653-4e26-5da1-08dc414ff215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rAdD4NkAPsoDvxgKEfleAlRsuFgW+VkJ/nsij8Vmy2GjWAbnN3odSlfo9Z0OdUls3Tux1RqDdblzlaFhrFUPEwR2Q3pLjKSJWIMR4LoDWtn2CALJndLWmoXyM/Adxj8r/M2OOmlRm6pzfcYCa7qkj41AhR0Mab8I0zPhbFXwkpTqcX6Xv/tHjQmflapDXKj+YyzGUW3BivY+/V1/Bwrbk994BfxUZCBQIE+NvUNh5GvXF2LDFid1d58btLNb7VZ4KMyrzi4TZrdiRUzFkN1ERWLfTk4geFejl/jETaQz9yKnINZ3ICJUPekxvCy2FAFfDWv4rdevEqezIJ2HZs0WnQZjfbihmQ9qsFqEo4qY8NFc68aXdfXbUMObEx9F18W3A1JeU2lKTHrRBFAX23hcDLS7DyD0g/QaHh1QuIH96A9jYWXKR62YpMsO0TvQOAOYtiS3eL3fuXm8os90QqnKYVvXwxOuV153g79AhR4kCo+iUdWKNOF1YFrS1JsY7f0v/bFnZ1qIN2ZdYxpdROR81xbSYTgV52ZwZQicKF74EZ9lvjw8q/sc3BNsDB6uPbgT5hudyDgE+yYd/hsYGz7EnvZ1Rzd39zxkHPdSAqEhfzOfQ8zrAavYEriiDJE1cglYBORRry3F6ol38gI2WGnhH9H9TcGHktzkU7fQmFBiw28=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KR3naAMEYxevWU7hyZKKWDCKz1Cs5+zn2bfqF8hqnGfWVLelR8l5iejegtSi?=
 =?us-ascii?Q?SuUUCp5KgpKiWEKjhXfv4hiXLyxzoiq/WiGsycE7fxlzBJ8j6tDaFzPCV4Bo?=
 =?us-ascii?Q?eiJLVyBgQvIV9J53nSSsPD1KMiVi4KIT9JnkrIErjPtG8AO4cnJaXqUvrErt?=
 =?us-ascii?Q?kFs15up+zQ9KUqo/Li+o9e4py/HUXmNI/OysAbWoyt/0SlKrFkzd9lUuZycR?=
 =?us-ascii?Q?ZJA5oiYGKrafllh4IbzN68Jh0/Ji6H5ybsIKARs+SlRrfMJAW4YpZoAga1va?=
 =?us-ascii?Q?y7ebp5qtx0OEtGdsG0qhPYjDmeAcAEiEJTtj8SgzO+eGIBEpbknvA1acVaPM?=
 =?us-ascii?Q?IOjt6lvV7Z2ClnnzHzykyhEkT/VwicyhS4k0lqxdCnDOjheOTGP0ROd9aq/3?=
 =?us-ascii?Q?HiJXJ9baUSCaF7KISaR8vLlYzXJVKPz6pZGuJ9lmensb8OgbNyKtl2URkE7o?=
 =?us-ascii?Q?uMTJQmlmF4ZM1lKETRhNCbmclc3Afs8hFPuP+KpZIJbSDWiekybixF5DJnVy?=
 =?us-ascii?Q?gVLDkd1iwrsZpVS1Nk+J5oj+lg9Gsu4HThPY55X18WUGoS1raDVVtZta0E1W?=
 =?us-ascii?Q?oAeVCTQk1NS+WHv8TzpHs7aKj2LIC4gb/J/vwgbJdWKmfxwfHObOS4PvDiJR?=
 =?us-ascii?Q?kskAXYdLpGntRlD92jlty+EEyUI166ebaRkhLip5/h21XU1f4WyE6sRTxeLs?=
 =?us-ascii?Q?uBC0CHxGtp+h84jK/ZEY39a3HJv+chrMxi0sKiSc9fwK+YsdMNe1kBuL94Dz?=
 =?us-ascii?Q?wMAWHqYL5xUf9rjPNsD9+W9mTa6gF5w49BlB3oqwjh4dH5+KI8sUf/Ih5MYZ?=
 =?us-ascii?Q?e+AwvSmKifz56UtiIdzGQD/wlDUQHag7OQ/0mxf++uJXMFM0fSscrMAuwa/e?=
 =?us-ascii?Q?jlPIz1RLZL9/ef/M/J75UnMxgTtbnA4BvtjAc+JZLIlhyFVfwmagASvlJ2iE?=
 =?us-ascii?Q?swGMhIzY5wwsgexVmvPUaEingRchD4lmN9zj70GggYomCnNbd8Yz/M19Zt6e?=
 =?us-ascii?Q?tGqcKaqBD2Rh76r96gIUJAfkqJtIjNOHmEMXcasov/NCORptrlF3ObXrBZW5?=
 =?us-ascii?Q?6OSmrU9mj8v1TmkmTf2xeyb6RvbsynMs0DnWVv4Q/ffRTpeNf8Ny/5mwGsVS?=
 =?us-ascii?Q?R016qaAcM+imjHk22Ke+2v3E3gmG5iJ/1T6zh0Nwr2AhJmRszEX4PEjRMBTe?=
 =?us-ascii?Q?r99wonFFU3B/B7bBAHN6nrsAMF4yh9q0Zarlxx85YBVH2y9oDJ8nUTftbIhq?=
 =?us-ascii?Q?7eC2vW76vrixh3nYrU0jIXwD2G7X920PXrQpwPfVx/Zu7pvvn0jIcdd1j8vv?=
 =?us-ascii?Q?HUfXumSNQHG7KzHGTkv/ARbzl2zYX7wbAKjVSPIRe8FY9J6U/CcKboIeKIsT?=
 =?us-ascii?Q?XSNMYC97LKlwo0gr9dhPNN0Z5zgCXsTEQtPswerHF4bHpadOEX4iTi1xioSp?=
 =?us-ascii?Q?NGQIycZpF7MPaD/FeoWBHfT3YUDxlsqe4Mm57tWr+Uw+ox5Nb8wgQK6JbL+h?=
 =?us-ascii?Q?fk5E2yN44Z/UM5O0IphUSyio2Rta+rwX9orgrFbH4yJwfGork0xOMMq+3ix3?=
 =?us-ascii?Q?npcpnzl3Z6miijzTcGblp2Ho9yU4yKhq0gw6AtCGJsqTkbPX2YZwFHkpP1U7?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bfEmeHs4vWnMyARtVLxwtj3UmKEroM304f08yYsip0vizd4UoRRQpta9CFY+mo54gL9Bd0XU2+g6QMYFAlJOE7YhkeFdkON4lh7YNKa/Ze/6rcOYX6ZbDrLEqT4m7XSAZ499AJUD7+pnLs3pPmsk5QpADxpV8SeQV3ETGRCfrpJ+aVUxfs3XeVbD+MO7xhgnDUPc7U2NLHyF5t93TGizNCmtzd4VlxmmUla1E3LdilaQHtzLBhmy0GuR6azrf1YMeFsS1iT+LI8aTFqFOcKN6bGCmfafxLsy5ttPk4c9LfFB05C9XmClo4RHKFaHrlu2h81xzHTdSwATqkyQxVY8UPKns0FExIWfP14tcXb01ICSHLY5bAu22GUQqYEFnH7jE/R/GEw4c6dxkZE8IbZUd1wmnL2WCs21EpG1tGIajksi2ZbtLUQNy3/xDDDZdSVA2RyXDiNUkEw3WgfbLePSR5kSSqh/1nG9KwJHhjILQn9NxYCR68jIsvvyCE8FpGDFadRnKAWRBqyYocXXnjUAB0Hi96E9qKNOYXA9Gu71MK9FAVlP2J1/onbLA0vpndVagr2IecuhtOoK6E8L5QYNnov/WLIWeibhnTOkMghdWNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740704e5-4653-4e26-5da1-08dc414ff215
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 22:18:00.0457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vX3IvYhtPm9nhLA6ZvTLSVDCtzRwEqDocuAiPr75xyvPLsacNWVLmvpaSgeFl0Xq1/x+jYDvWgOB/ky1kUuT/8syZA7gho6uxhXVjt0tjqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=771
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403100181
X-Proofpoint-ORIG-GUID: izIdy1aw5s5mV3E9yX01TRMILnsNr-f-
X-Proofpoint-GUID: izIdy1aw5s5mV3E9yX01TRMILnsNr-f-


Muhammad,

> The wqe is of type lpfc_wqe128. It should be memset with the same
> type.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

