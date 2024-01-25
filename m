Return-Path: <linux-kernel+bounces-37892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 668E483B735
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DFEDB2229D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB76FAD;
	Thu, 25 Jan 2024 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VaSHhtak";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nrsbx6GS"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A891FB2;
	Thu, 25 Jan 2024 02:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706150272; cv=fail; b=CtPEoi9VrZSwbLKJIV7vmLJSH9KePfV69LLlWJx/djExSjq2YdMkqkq49VxUqEqh0uQCCv6/W+53BywR6hzUvGPh03ko3hjmJ0rA6HaOilktqzSqt85rIX2AneKlD9K08Cmao7+SSUVtM5H64GhayaE3yuLOX50MOCaFBS6NTQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706150272; c=relaxed/simple;
	bh=WP2A/GHAPU3Vsy48Lhpm2ygUKR95SKgdXC6SEObxMjI=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=a4qfdJTlH6mKLYcHj5vE66j/G6OeQAIlDTyAQpOKcgzlm2MuzCfCFxa0XpPS5b5Vh3I/iEe21lAbnG34mG8Ck0lahXEd1IHUuEKsNCwuNaReRwSVJb99I28L1NGPi0yy2qt3Dwx9GciXW8VXi5RYljSS477+Z0jfOFNTbjd8Wd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VaSHhtak; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nrsbx6GS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OLcXSv024125;
	Thu, 25 Jan 2024 02:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=K9DhpnuiY9e8D859HU845q0/d+8UmNoxDxHhvUfkNmg=;
 b=VaSHhtakTc9GWTPcjB78+ARepwe3zR9RYNhwG9YpbGFA2xAxRA/vEML/o0KH9LCK8urH
 ZcWN/pAfannNNXXT9/nDF4Gui+CDSu2HJT8K9003GGf/nxBsbiUZLeFwF+MVpxLxJNEG
 v4GLpcde6HG5bayTK35fkK3h6BpIRoXkFBY4zgWynMurQU3Iu1JCMxgz4xR6r5W3D6Mr
 EwabqAJhRvO3hxCqpGUrBI50dndO4Rc4ANfDkP9v2wzKpPLC7RzpMg+4QQbXPM78/89H
 7P0CuUcHtIsJOD1ntpGSsIacecW3AovEtlS/J3QjG5tw/OSbl8rKXZHVTqBJQxxjht/N bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cux0rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 02:36:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40P13M51026106;
	Thu, 25 Jan 2024 02:36:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3184wn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 02:36:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTfcdY+ffYVCbVXa+JwIk3flsX7AVj5Dtp7Fw54ox0Y1lVIVlLn1GPDHd7E+VV7lvVGImmnYYwrfJA6oxCKTZZEowhtpVDwp1xw3adx+0wPhoUnrTyo+0OJIshDtnyzvwiH3ok8pF3Gu9cBcb7d0LDpTm/yIiMUEpM/E1GH/gYPcOr0lAIyS+2c47w3DflxhrK8K9k5fhcOvj5OEAdQS8w3qJMGhWJCloxWHjvJ7b/Q2n0NRdaaPaWrYENIhRanasI7jBrAYPiOxoyO+4CGr9dtBAPc1/GORNZQkjYsQO76awuo4tznkXKdXrYHWyOP1CUBUUqPBfE5Qi0ySYkMGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9DhpnuiY9e8D859HU845q0/d+8UmNoxDxHhvUfkNmg=;
 b=M/w98I1js/YomxNTshpR3M6jobM3Y+mwTeNCE2n7ovrpKg/br87bSe8H/UINyw/kw/S4vgm5Hrgc1lJtgEhN0oetUOo+VR7cXshyEKnhSqBpVssPvM2Fb5iaIXWRImRpmt0BvVZOwg/pqzF3eh0pF2lb+2nVCtdX/OVP9XL5vecI+rNVWKjRFvbIU16Ct1fcTqdCMAj9Bii8cImtEeTMsBWmV66CFJLsbykBQE3Re8VlJy6l3UF5Co3YQcilZ8PlG6+puS+kVJN4YjEDs/iDAw5cj5fdTzk/5n5QH6dqA3vcFrJWY+BBD+S5P66/6fmJK9yM8Py7h9W4s6z28NNdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9DhpnuiY9e8D859HU845q0/d+8UmNoxDxHhvUfkNmg=;
 b=Nrsbx6GSRZP3aKUKfm8A/Y418Gn9FJQwatuwOrYzWyct2LPMfEslGq5s3cnFLqzXk3tOL0oUf+M+JkKyj2shXPXdaa5W/IqST5O7ymQEWirim6fwxfhjUbIdjzd6V8fbt9wwBYJEHWNSCOYnEPqHgujjtGJ+lyDewZtRr/aikS8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN7PR10MB6666.namprd10.prod.outlook.com (2603:10b6:806:298::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 02:36:12 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 02:36:12 +0000
To: Eric Chanudet <echanude@redhat.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
 <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ufs: qcom: avoid re-init quirk when gears match
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttn2uoku.fsf@ca-mkp.ca.oracle.com>
References: <20240123192854.1724905-4-echanude@redhat.com>
Date: Wed, 24 Jan 2024 21:36:10 -0500
In-Reply-To: <20240123192854.1724905-4-echanude@redhat.com> (Eric Chanudet's
	message of "Tue, 23 Jan 2024 14:28:57 -0500")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN7PR10MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 60948b8d-acb0-47d4-b7dd-08dc1d4e6533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	W/0sXKLCe243yIh0BuhmYGY3c/6qVuaPKyLchkFGgOmMdKtKXpWOqSHSW4ppScWWfyNWfTVNoP2fralUxZQBCdpWXJrJAUbNKHzRxx4qDsgd0v5sXZSKDz0s+FBLH/Yup33s+Nuv7FKatIJ6nO12e5L4tUvcgDhC408Bg3E0n2TyP4pzo/8XnT+wrkx6LuaguUhqHk5A2u42yfaSBi9Rz0gEUxDdLJRUlsbhXXZCkZPjowb46xupyaR7ETwDjWlDU0eaC3aKoZvvkY9FoGtZ47HoZPJyGj5knec1A8guMwTqFL50RPaXHWPrupnEG1U1/a3WHY6qqANeb0np4fLZHZGyEJ42lr+xr4EVsduQrbUOil7v5guNHOngkYzRquCEjZzvDBpb0DRC7FFIg/km1vsfeuG1wfFJaeiotlhS00g6luylS2fuByJdOS6NnISsvzFLIhq5MBMnDbeQktmkmE1U8UNvdtaTSDienrvMRc54WwXO1yup+4a/VvDZjKmB4AIk71OMu5iocCQQnl/1A3Z6cTpavM4kgI51wHuBLxT3/PfV6XsfjesEQKB+15Bi
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(86362001)(6486002)(478600001)(558084003)(6916009)(6512007)(2906002)(38100700002)(8936002)(4326008)(6506007)(54906003)(5660300002)(8676002)(316002)(41300700001)(36916002)(66476007)(66556008)(66946007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gQ4c1SSdA/sZ3rIxli4VSUCPCXotrqX004kZHZSVMacjGr8QQBZPPMvTfZzh?=
 =?us-ascii?Q?y5TEsGranICY1QZSXteMzorki2EROLLTNuVnnNO9HlAtcXi+XN6pCDHRr98e?=
 =?us-ascii?Q?8atMDdb21MZLRCEw9jFNAGgSEWvh4h00ikQ0yc+tHNDZl6qqp/JwBL4iIx87?=
 =?us-ascii?Q?IPVzMrFq7wXdWuIwAhHQPIGV+p3BbTSa4dtqm5hnIj+oZ5DK69ONdzNqyo/Y?=
 =?us-ascii?Q?2K3JkPALUhyvOZ60wMkzaxQVQkjQK3gdctFON9g+ustkiiNn1SMasAel+Mxe?=
 =?us-ascii?Q?najAnFlEAos1JdiyZU8nBrzUmUZGnqbWIE35/w2SqXeMiMVHZTdzEjmKCkTT?=
 =?us-ascii?Q?LLkNju+pRs7ps7wDTOXi3qeLyGcBqbeII+gz0E6CB9rDob4uz9BUBerTAi6i?=
 =?us-ascii?Q?6N0ceJPlgHCCGf/fidzTxjp5bvlLtDHUp1s17OoqpvlcHSd0ikkf/WTvruE0?=
 =?us-ascii?Q?PoCToIbOLSx4Tw2wbs2qC3JRuwZv9RHzb7yiW1zF/k0z1rvSHrCvTxsL1VjM?=
 =?us-ascii?Q?yZlwLnk5C+hQVgRc25f0pGV2TdR8NxoEbX6yz/YTStSGc5X+wDW92x6aW33G?=
 =?us-ascii?Q?MtfBXdoF7ErP6C2AmSl10gdrxdHK/t7/KS4BytE/WFi3NWZdQ/5sTZyauJ2v?=
 =?us-ascii?Q?7KpxSGh4jFjlU5hgj6p5aeyAAR9rlYN6T40I98CtaSkIwykAwvGCsdkSvMW7?=
 =?us-ascii?Q?VJqYXzLEsEulPyf6+HZvk5hO6bReBbxxdycPtjyq5TpMSXo5KEAFhe3zQ3eZ?=
 =?us-ascii?Q?KTSkzpFPJWKX1xnJJ5tbnLcgourCu0lFKTwb/WN+YGkUttkJbSuIE0BEyqWV?=
 =?us-ascii?Q?wzTYU7WgsR2j8LFTvKbBGMEQAWUPqm4bls2XnHRmUmQTv76awdfNjpTwBA7M?=
 =?us-ascii?Q?W9EgvX+CDjsGmbBe2YM0R5XoCmc2UQO9kSob2+9RggO2JI6C5mSjJM97ESRP?=
 =?us-ascii?Q?Q18X/lDpRdwGYas49AdB80btplcDln0G/WKIQO4VlkmP2AgnDXmpmLUt6X6q?=
 =?us-ascii?Q?GqAsKplCUVSjjM9t67/sExqcfSu38TKSZz3E2JQ3vNwGpCNFOquagjmgnbWG?=
 =?us-ascii?Q?WkXxXo4SBIxpZtAvArRoVxXXpmYeJUcqssa3A5Ql3/WgBKCov6OYO2/78Amg?=
 =?us-ascii?Q?YKh4bHFLj5sTCPIPxDeC0oChDe9jchDv1SyVFEN9d4dy8bAH6aPyKfoeP0sN?=
 =?us-ascii?Q?2aGtWnQbszVkEnKrYlNPpHxJh48JL5onbi/RqnrR3IZdUEw5Vk0Qkysi0REN?=
 =?us-ascii?Q?/nMYtbE0TwOqWJ8DJRlNwus24f8/kac86FPnSZ1nKUXa+AVAp+za/g9MKjba?=
 =?us-ascii?Q?nQTkM49GzAx34TFoQTOwM05TNkX9xAekFHWwq2o9EDoB3zhYVTvGUMW//lyy?=
 =?us-ascii?Q?K2qNdthDBZPATIfNuSTXyM3+gN2jDbP64KZZpWi3jidZiho1QIMHsSB4qT04?=
 =?us-ascii?Q?oadnOjpZRLjHYw1xFMHcgvPNBVGZBN+L158xVD9Sibo05Cmy3dJtWgtW+jBv?=
 =?us-ascii?Q?t4kvrn1QYJ+nz0IAcfnnH4q6jyfJ/w+pMxkrZ/nYqCc86NnhMXgpxLQlE1cR?=
 =?us-ascii?Q?2L5YkPsVOi1KKOWWOYLXYdH99EXhScF/EL00JH3nE28jSpsk8RNgkkYoQT/a?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	M0Z3xcDKLI/8kXvz/VT8VWXhX0ejD7g9MyUwGP01pb37B7aIICVyKmNK1PBKv5eNXWnHxVffQ/NsPefvvwoHgcypKjDJJVzbfB3ifvs2+GQeBYV/NQytNHZhiTI/+UhOQ5PYKQgRT4EHgyQxmyfbZUT6nCe07qM3itrxeGbBki+YmHm2WZQOCSeoLuELgZVdxlKV63NzPUj9tkxYyvqIJxOjpmX4XqnOcVMVbp5tS2Q+yNf24se0DgemPccEsG/qjQRQNWwVfvWcZeAS2xaaX4HVv6xX/oa6VsExyOKseavxoCz/fx/KArPoV4vFAgFXK0rPskDdBI+FpRMiBI9HZa8uX13MfqO8qUd5Rpr0PXqP+QgT7g7hZQT9MCfbtroceRKlvu4l58FeYduLzqlnH9I9+OJjBIrMI4nmBWF6daPtT23m/zfWqsJNj4Ia/d0GPKHFCv6aBXp4To8CDhVcrm1HuZzkyuLmXoGR3AUdEO6XTBJMSbxEl9kRHU5fbNq4lSHT5ZEGHATgnwi+do9q0FqrlnnPdwONRNbiujclJ8Wbkg+fvqlobO87FltMNHMbszZrLvmOc73oud1NrLGKonu2y0ozWeaaU4yoQalLq9w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60948b8d-acb0-47d4-b7dd-08dc1d4e6533
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 02:36:12.3138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qvxiuEFDmMFtmx7jDiKOROjAdF3Odk44S6APN6ZkjcsRWYLhWlWD0FPYeJTGMEcF8Aw0U2mgU4dnsPYGv4GOMXyCfjvQ8QhLqP4TEzztEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=781 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250017
X-Proofpoint-ORIG-GUID: B1bSY4VOuZqa2Vu5hVqyBF1OUvXchCoP
X-Proofpoint-GUID: B1bSY4VOuZqa2Vu5hVqyBF1OUvXchCoP


Eric,

> On sa8775p-ride, probing the hba will go through the
> UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH path although the power info
> are same during the second init.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

