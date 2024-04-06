Return-Path: <linux-kernel+bounces-133749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ADD89A80D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572851C228BC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33666EAD5;
	Sat,  6 Apr 2024 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="amOT0R67";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TKFHnjs0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE5C9445;
	Sat,  6 Apr 2024 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365188; cv=fail; b=iF1SxBCM5DoeJt8KPBQxtgem93Jo9Yb9SUZkSZwKCHwd6QNzN0Y/+MiETWCrFOBO0GWnUNH3K0uhJnaOJhdSexCiSdY3vVBF7XyYmoktNPvrrB/4gCjAIZjn/WWRQbs+aOSacP/oPGmCdJ8pz9SQ1iH1rYQTgJnW6KpM41WW/kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365188; c=relaxed/simple;
	bh=dkB9SUNKVldSVMHxZirNwaOyHNwq5T3DhjZdnDGWcpE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=rA8Upo6whbdUBBq2gVht0JI/6VQj1E2Pxm5O4ZXPQuJIBsYT6z46COOHafgyZLnquWIJetOIXUkHqfT2fnlFELHQwbfSO8KA82LdDXNjA+dECvvLYiIvNjkUlozWQ4fw2ZkyMkTb9gS+YJkA5YcZ3hn61Vrsv3tb/G85Tl9TzsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=amOT0R67; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TKFHnjs0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4360jO3C024837;
	Sat, 6 Apr 2024 00:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=C4j0aTobHEcG8gDjraC4U6JLJoDMVf5sl02JO/LtBKc=;
 b=amOT0R670USXJnDp0aVTOWbQzYLIpMJjj7r5MR6u/iKBV9At3zqSnPYnlXzKI1kCZiih
 BYL85lXFG0dxzxIpt9iFinEeUZLPbdXmUayHP42iDzanSENKcv62Ao60G3lukYLGU9OV
 T1M6YqM4KOakpoFmjckQDm6HrJ+lC+FO9cZ8m293ORsCMkPEaHq0bo2GG1YTSv7uRjeX
 xJUfxO7ZSvgGv0HyrDry/0S9dUFu+0RKW6hcOH9VdKkxKZK8NuJSmTOnfmXxtJylw6QX
 xHKCsO6w78gZK1x4wKE0NwL4h3VWcUcNt30YA8YjEOOhJUdsJedU/BShG0dWRhlFp/5q Yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9euy4jfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 00:59:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435Ncp1H024275;
	Sat, 6 Apr 2024 00:59:15 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emptrc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 00:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ca4m7r8URs3D0qiMZ4CzeHL4cwiLFzBiLkKFOvq/DyCSQQFWsVS+wHe7cdSpMkXx4G2C18Il6SjGqixvu62Q8zEOgODZg/Ey1SdukhpdMMF3WBojSLvl9kYGnkZSjbEGLntPlXQKVs/bJg1Vx8Fsh2EHhuRX6h7ZIYkWf+b4jKjgT8PuZd4ZdfJXrEP6qCq57JYrdDlNRLpV2HN8p3w4O5IOJEit+Myy76p6hA1vLj3pBn/YkeDpb24OLx8VVXZL5SqZHv6Usp6mV+6HCx9VUIJqdipW3qgnl3vAVjeWyggf5f+Jittw8w+TkQdw22TAw8g4/Bi3z+VEHUiSHVkxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4j0aTobHEcG8gDjraC4U6JLJoDMVf5sl02JO/LtBKc=;
 b=PPwzoynf7KWtERvTpRfyrJYdfKR5Ka6naF5diw2g+tm9KvHXKam9m+L1tMt4Ga6XSK+avGd+f2o/af25NqtUA3Z+HJcje7/i9/6ut7zEfiWogCc5PfMJ5jZUnq1yJSfNES7ypPwXXodclzRNBosGOCtMeuwl6fyF7WGGnD4YSEVhhmErIhBTbzk+4lu5JTf2Qzp/RidERbRRg5afuEJHpbpLxj115fX8MVwDdXch5+gh2IRIdl7FMRuNDFyI8I1Ll8r1iVl5bONZFRwMDUU5oXSSruchjYxXMsJ7DoEqd2S6KB+D2vHhBVIdloQh/4neYTyY+tSwpVx0EFDx47aYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4j0aTobHEcG8gDjraC4U6JLJoDMVf5sl02JO/LtBKc=;
 b=TKFHnjs03iCa50wGY5xkXTaesOq3F62N97npGmbxaiYKDtMs/WivMpChZ9XdwY8yPlJUueikfnciGF2iphSzd5rPh1+O8dKPecoIHQgoakZcs7sWVmA5EPFqCaunkwSvHz3kG50Zyfd6juc5yO0XofpOA6EpLFmmk0htELz5a4A=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6674.namprd10.prod.outlook.com (2603:10b6:510:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 00:59:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 00:59:13 +0000
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Kai =?utf-8?Q?M=C3=A4kisara?=
 <Kai.Makisara@kolumbus.fi>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman
 <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] scsi: store owner from modules with
 scsi_register_driver()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240328-b4-module-owner-scsi-v1-0-c86cb4f6e91c@linaro.org>
	(Krzysztof Kozlowski's message of "Thu, 28 Mar 2024 21:45:44 +0100")
Organization: Oracle Corporation
Message-ID: <yq1bk6ns3vv.fsf@ca-mkp.ca.oracle.com>
References: <20240328-b4-module-owner-scsi-v1-0-c86cb4f6e91c@linaro.org>
Date: Fri, 05 Apr 2024 20:59:11 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6674:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HJY+7c58LR3lS+RPoz26pVD3QvQgHPQhgXqNRLZW1QU+NVCtFb62DpTG3tQr7y9nA1j/6ElBndKF3r77Hq5aQF+Y+LNtVQBPWo1xku0yPGd6rRsHTrOhK6PAVerhPcSQWbnlT6rSHxAB0A/wiW7/u34nOb2vkHTBC7fM3+sHMk6WHGD+pwBrdS4whFwmeIJcuf97wkZaoRpWQMut0/QunVbWaCB2+gWJoKp3aUoKkPVbz6z5/0WeTX8QIk7bK4uXniY50uADSWw67OyD8TjX+iTIvP69XJ208UsHCMWjcQ7xPhbfvUDlSaVM7/sOc7bsXupXHkjhPWUPmkVBUWfgCczu50S8jp4gqsypPjCNJlW51i+6Aa8vT9pyBiNcukE7x26v8WF44qAdtCJOoGqAiuQ/aLsxYpb8KINad1ypKOopiQFHNQdjJV2PmHC+HXhhwGG3v5vTGZrS6LB1U/hpFdugcOvjXGtIUI0puePGqTO1dLeqK7qvxH3WdwnoXnS/pUA0wUiaKx2fBhEdQpAm6gkV3oRpYXmBARuL6HbfVn/cNCk2PxaRzOxnlggYEe2yFINukx020Yq4eZmfq5id6VDG1ybKwM30gh7Ot9/D0dQtpdi9khCICvaUECyW0K3nxSYsNW3WbSqV8UoT1lMnnUMygld9d1Jyq7CgzWbc3YA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jI6iuIsUi3zqSHqaOuInhBFtw/G9uY4iwoi/lj8sIN5kKM2MWTJriHCFb6ai?=
 =?us-ascii?Q?0kk2ahJiz0F7ig/47xrQQWIphlSe5ZZBlJcSYE40yhwxMd1GCixRyia7QI4T?=
 =?us-ascii?Q?aBapWwlXpaiDc3ymbJp2VgKee6UV3UhND1VICK5iQCrCI2Es8reWbh0Yv/6F?=
 =?us-ascii?Q?6UHXhd35esfWX9wGoqwQYT/9JJ5ZRA9gkMkR9k7C5P6G1bbCNC0ar1Ywa2cQ?=
 =?us-ascii?Q?+9XeyCpP3n8/FycGrwd8cDGITO/ZJS0w+IHmk6CL71eUExdIMhinLASdGAOe?=
 =?us-ascii?Q?ay4io77yFb0DOLjTSSaoGJQkiLZRTbVtjp/Uit0nJCwoUNW+8Cog6Co5Jg6g?=
 =?us-ascii?Q?qVGI/IyQaHjka0D/aAA9SSM8gTSSmIvHUV8obEeg/j2fF/CRhjyz0PoJMlvZ?=
 =?us-ascii?Q?5BYI8vDdK09yx5WWb9WFOAggaNz0BheNfyVRWotb6CzaOS+gyEzYmf2Ttb0Z?=
 =?us-ascii?Q?NcN6PyeU6XwIWMrJuJnGRduNBw4pXAdZYu53wczlm67fiBZGH4tASlxQA+In?=
 =?us-ascii?Q?zhICrisdDmA/OGH/d9OG58KYzRoDjyOuy0JYePBzcR6V7B60mMK7XOKK7FS6?=
 =?us-ascii?Q?pe+UUdlD5Mlqs/UPgwoG+UPz6J5fxiJwpAt77H6ay/F5YCBtmRWzaP/QQtw/?=
 =?us-ascii?Q?6uBjAinBM9UeyO5FyYxpIY7f6n9dEms1ekf/8YhX3nWanXqEe3HQBrRyQ5Xz?=
 =?us-ascii?Q?1mX0b88EgPWUThZLsFTV20gkPASm3DU9Nio3F0FSNK5QZHGn7U05QohcNVfi?=
 =?us-ascii?Q?UucZWZ89V1xNxkpOvW+8obD8CGX3H0jx01clvh9Xwu5vObPXT+PTrv/AenSR?=
 =?us-ascii?Q?U6vqJ90VIy1KJ+xrhju3SmPOyfKoI+7B230Z1//A/CcQY9uuw8nI7OIKOlOL?=
 =?us-ascii?Q?56U7tNMAUXfBeCXkxFCvE7+Q8qcSaq1phwY1DYw1Ln/F6c27IsWm+anCvRHM?=
 =?us-ascii?Q?vuXcdoNZx9PRHvZ+9Oai7RpQJ3xa3ml28yJe4UIdK07d3J+Wn3fb0Fu7HmY+?=
 =?us-ascii?Q?ULTwmOiFjetZWvQd37Gy7QK6NZJkNYx/RoA9YM1WylUq1V4K9a05MPoNvNjP?=
 =?us-ascii?Q?H5tWEE0wI1cPe2/lKjw6XXaXgsjuCrLTmoskgy5u1WJo2m9vCsWgZ7TNkYJc?=
 =?us-ascii?Q?SLH574LU5IK3OmCE2utbs6WLvGu2qpEedOpFDu7IO5gG7v/Zdw5Dk/lM3d0w?=
 =?us-ascii?Q?QbNmDS7pSqIJtf8hXE5tl2bJ6iPtR62bsHwbGn43wADg2jfRD6XGj1Pvwg4q?=
 =?us-ascii?Q?52TNAmJfHwY9hq/ryZ4ZtZcDDYCzc19NSawsJ75Y2SONps2Jr7wVt6x2BKg2?=
 =?us-ascii?Q?5WHu7BESj5ON4zb9mVmmRtTWn0EO00R/3tMfzdRLu+XDfDRtrQA091IPVJxS?=
 =?us-ascii?Q?WvfAgsFW4luND/kY3xI+fvLpl3/Rfl5tpINQ43hv9tn093grWzT3azS9CTy4?=
 =?us-ascii?Q?VVAEdOgg6/mZ8rnEcIcJaUpCCenvb/u+EGvFnVTYu/MeWoGbWLmjcTGkoGp0?=
 =?us-ascii?Q?lkLKWmpPvPdg7kCm3BYofULDCg3sKZ8u+HSAu7nGSMwV9YCYdHsE47AmZhoy?=
 =?us-ascii?Q?8EBmcJw+wAMswPYGFPbooII4fSsxzx8MFFgfVQQH988IVAlW+zSj8hvdRvYO?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IvsAdU8CTJ0G7q8pD8/C2eVEb7VaK0vXB+fzG6r6jJltaUeNq1l9OreojWXyiqOxoXD6n5HAYfmLRIMnksfsNAxVvIV/Gws0nuJAvZ9Awvkxm26emj2aJosLnpln80h8JyWyDcbgor+Z4GG5fkzhoPnO/I48OGlboriktWESnZRFQqyQvA+kzrl3hXzGMCjzFqpujI6fAIw201tUnjCJV8jwQETL5OpG4r9ghIB2yj36/taknewoBQDMwQRIbW5BxjJjO9QP6RG1U30+Cx64PHKR6oZoFj0oFTACcMlGwDfnDSfwH3Ds/Zjg1sv68v23xfpZUnrItNgUqhNiCjFacEMoFKAk/YW8xZhXQ+b6LKrduuM/K51arDjJx7WNH9JEjPdE8VFBlBEi1uUwezJjQRFNUKGsKTWOZam1O0NmohZ5WuIIn4g6yssTrFMO28R41Qxs0/BaIGyGApubEWkFVuh+J+A8tnRaWLMvnMZX8kFIqcpWHFPc4kkXsFOS0nL5hxqYv7ajM9Lz0FICD14kU8r2jUPio0Tg52bIclVOruK3nSrj9HIspP6LDSl9lM7JB2HSre7F1XlZBYluW94AixO4mRHndC5+i7cCBfsWO9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f89bd9-03dc-4d70-5341-08dc55d4c695
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 00:59:13.3995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEMfTrzNYV2+/e0uKiw0IA6IEv81PJdjrSFlr1UR0OPO+7fBpDeiRKYJlC8n8v1bMZOcWl7ZKcCqVanqVWrmVF3Aqk+xiqXScRkDfB949Bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_31,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=829 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404060005
X-Proofpoint-ORIG-GUID: Af-djUKdjw51BnT5rTn-Q27xKTwnDCtT
X-Proofpoint-GUID: Af-djUKdjw51BnT5rTn-Q27xKTwnDCtT


Krzysztof,

> All further patches depend on the first patch, therefore please ack
> and this should go via one tree.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

