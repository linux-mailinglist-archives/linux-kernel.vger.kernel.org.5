Return-Path: <linux-kernel+bounces-133757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8767089A835
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE68284522
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4542D10A1A;
	Sat,  6 Apr 2024 01:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ngT+u1d+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O4PkMpK1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F0033C9;
	Sat,  6 Apr 2024 01:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366666; cv=fail; b=pjwNkqSuiBO7yAqu6VqAUQfI7oCnc6FNSOHDtZrHbwSd3iKaDA/CFiklxEoALAYPpPab5/UVDEdMhQGyUK5OccJALg+LaPCls0dNfpaDvOWI1Tk7r0BL3BLuBrWybVvKnIzjEpHjUFjiQWnYK/gbEMq8Iihmojn7IAhWaADY9x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366666; c=relaxed/simple;
	bh=Swn4IBUhrUGQ9XHn8rM53iLtfQqguRcopgT+eywSYIQ=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ubiQSDmzWwZU/KpelHKODLNUztkfaIlQAQwo0wL9Z3v+yZ02RjRXpxu807X1QxpwjT/JjQRj9RoPHEtKrmQv11YUfAUkps3PVogZONxTR6Cqfdhxf1U6/Kno7C6qqYbGL9mUaFzOne3UPQD3KJePv/jcXA0MNzTY2NWIgQPgnCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ngT+u1d+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O4PkMpK1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4361OJQq003804;
	Sat, 6 Apr 2024 01:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=2Tnm7SmbgGxWqoASEqp0Ghl4i5eWuGN/dv/bsfGqbIg=;
 b=ngT+u1d+2B/Q/f7hkPbbaVRvmmue0kNccqT74/yD8VpRec5a7Uzqdybeheoi+XSzvZfk
 S3bMYZaNpXa12o8pPqyufayHPRpVvnczXiYGRCUV9hMg70kXz07KaWxrMYjUFeA1gJ0w
 Ik8qTxtlWyKOVKpuvNnuQnrhwIDUVnfiqiDwdbL31GF6ak7PQDuk4P6Mw1uXeLm/UnsS
 3ljDAgBS3+p4J1tdwRnAIQMDZwUU8IQp3utO4xxvNoc/PkhSAvIIXqWFp2ehJEHfYz98
 sWyzrbPbVFw5++FQtb6x0X8z17FM4c9mSS7A/iX6I4dn6Vip9fgzZQlsOQn6glzD8T+j bA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9euy4jy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 01:24:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435M1sl1030484;
	Sat, 6 Apr 2024 01:24:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emys7vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 01:24:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgt41rBQP3Ve+HtdWXBEIQOqgxC4ByB8wAaQWcV1yWyhGZPkqzwSJcTNH4lBpF5ZUDmfCFTaj7yCY1TWkQ77BoVMhUKhNZqYWqCn9J4kYNo10qokJRGxr/+OrjH04VC96KN8m8jEFhUMyiTi2sJKY1Lh/XcPMg3Qw+MAvLQObWxavb2Kyb/Q52Xom9lHx47Lja3kcPAbMreqfEM+wC9Egee2/6KVhqwZEKL0qyZybLb2zZLcnbUG92Tkl0raSa+vFRRzqg8i0sbzl6FntPASK0U/H9zEHfI3nAuSygI2gvvpXolQLvS9Y2zkMpGrXL0benEanglndn7GFvNkVIC9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Tnm7SmbgGxWqoASEqp0Ghl4i5eWuGN/dv/bsfGqbIg=;
 b=oIZiQNxtNJoEONlKV/iQQFpt1oNcYGeNkXgOTOSVVAKz/vkKEWwZuASWhMpxLTJC6BJAAAT6SnJONxHz9nIpDgBnNahF82lB71dLR5EChinN/+rclyIyJNoLIOK/Eg5YgzCDbZuQ5nwP1l8JZPHsa7L+HWLs1qjZEeZ2TBjXDFa1b3hllnE4ongDUHrklv/HdD3qja2SEzgik+XodJooW77VSR6QFGrnoHAYothDuuZAIOwY/v8DLsS0z2aRonteNjMzAXfoEO5GVlveJ95avcOhMzZk+dPnhSPmGJ+sXqiT3Li8X16R+FThwCLa9TUNphBBqxX+gfI9MayTyijjdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Tnm7SmbgGxWqoASEqp0Ghl4i5eWuGN/dv/bsfGqbIg=;
 b=O4PkMpK1l2WCKhbC7fw+WqtVhqJW+06j+7wbPJZS+8weN2/sFePZOxsSm/blGQyT1Lz/BmVE5sSXzi4tAZuEE5OaZtWK7sa0aPc2Pr2Pz9gMqQM64uuQqk6bPsGOrjw9g0zbL6RBWwPye2Dtgc7wlZiQW9DAwFdWa5xlBoXNcJs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CYXPR10MB7973.namprd10.prod.outlook.com (2603:10b6:930:dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 01:24:02 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 01:24:02 +0000
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
 <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v2 0/2] scsi: ufs: qcom: Add missing interconnect
 bandwidth values for Gear 5
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240403-ufs-icc-fix-v2-0-958412a5eb45@linaro.org> (Manivannan
	Sadhasivam's message of "Wed, 03 Apr 2024 18:50:02 +0530")
Organization: Oracle Corporation
Message-ID: <yq1o7anqo62.fsf@ca-mkp.ca.oracle.com>
References: <20240403-ufs-icc-fix-v2-0-958412a5eb45@linaro.org>
Date: Fri, 05 Apr 2024 21:24:00 -0400
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CYXPR10MB7973:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JY9f3/C6+MZ1ppuujAvbfcjoujCODDEvSg+KIPsz3GHKHxdJsV3bRJKyjBY1EPrDDe8tRi4DUJvrI+3+MT6pYwe8AJryJxmf1z7ayTODVQvjA/2YvQwcyQB5jt0N8QPbTewaEbeamm+x0KRFOe7Qo+OoDTBEHfJMHcZVSV2ybPv7jNt45vhm4FaBB7PCX+1/2o2xb8QFT1FSsGnRQk3b3Rkg7S/Ow55UQQGpJzNa7tDtKNCmJGyRszXDXK+o1x3RQRmy0RmtrIlwYoh0a52Zt6pQFNTpKl3KmeQ6XBE8CS+rL6XrF74ZOfJcx2qK9xBMZKyP+oBneRempmj1E4ReJDOVW+F4o9xQLb2IDO/i7kGh75RUgwrtyhJ/sLydqDn6Z+g+fBFQdLZjsp0Auc39uwK4vdn/fdOpeMeRq/citpQ5WkNNuU9yUrQ/BHFcFaBEFdWH8LsKMAJAE61yNHeGqOaT8Ou6snAo24zEAnQdFSGW+HFqh9BnoBs89MnTrV3BJ2EfJujfGT29Tch6V19Y2N43vG/nNoXHhcCIHCxsGwDYO1Euhs1ksBcoc6FlrT+1gt3ygIpluLw8Xq5+dO3HBlewWeBOAC8EcVlejIFbZiPneV6xXIT9pakYrUzpxZ9O6fQI4D7M4Y74J1Hd2pnxOSc41M0IB1tSca/MT9qJwgw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IpCZ6S/zyTropqqyZTDQr7DkrKeOp5jf9+bSZdrVRVicu0Lnzx7U9jM9qVGG?=
 =?us-ascii?Q?DoT1D1ze6goLNEF1jsFRGw1pEuPBmrin2yPBww0hgKwFHouBVo3lGhvQZsqX?=
 =?us-ascii?Q?1fqx8PMWcWbBd4qmP2zzkHB4Tv06PQsJGrWA4Lai808eI4pCdPJ24Il1stOy?=
 =?us-ascii?Q?z6FbhCAuewWQzepV7pcnUgp5epqLDIkhWXRa4my4HJeFbix7k+Iz/bnShPrF?=
 =?us-ascii?Q?3EcqLTcFEs37i7cn7mloqPfXm+tWfbhyIV2m8gq8zUooQ5BJDTuGIK77zXpI?=
 =?us-ascii?Q?7U6BUflAhlJUxTHlS/bHTSYRtE/G6dh0tPN/RFoOBehdd3gecX+6eC/7STS+?=
 =?us-ascii?Q?MfBOxWMZfk1WouuqfGq+5h7qm4IFuLW/P50XVHjiC9WkUHJlVeV5VqbQQJrS?=
 =?us-ascii?Q?z03HbgvTZy8PyIv9eWPs/7s1QCttWtjVOyg2OjpdDXeqEy5Xcu7OaQDL+sTN?=
 =?us-ascii?Q?22ud7nkK9Larx1ohmiXeKOiv31AU4KckHa3LiJvDSZV+UUWF2qhaCbdL4uDy?=
 =?us-ascii?Q?j+2+IXMjS5jOvEp4PivUZEDPOZd3kBnJQycCwsjcN6Rr2WGyfBs2jYM2r/Ha?=
 =?us-ascii?Q?3klMblj0HPe4PC0TQHNQQcBmwl0x8wIrTcgpSmf+ijbvJRnqa8CVXg6uhSLX?=
 =?us-ascii?Q?vAXNjSfL55/QL+l3Pdwca/foGr+VS7Wg+6sTu6gjDIWvnKZfOhabXw281OIj?=
 =?us-ascii?Q?/e1qySAKpmdeY4WhRYD+tBjkHqG1+YpxV2SFqdzTvIe0ucxAmUVAGS+0dn4Q?=
 =?us-ascii?Q?6CMb/UXWRYDBuPG02eHifzs2BEefHHXJxGZW6wH2B4+f0lgSw4RpazgA57Sx?=
 =?us-ascii?Q?29xQnEJFjgAXLPtlHf4VcdIsoxmCDTeVvri7XiXdHrihwnIRLyl95jz1Z5BC?=
 =?us-ascii?Q?YzGnz0fFyKQm7dfcbiMOvpTJczOVVeo8HHh8QpbzgWkoRWr+Wiqb5SlJYsKP?=
 =?us-ascii?Q?xPaZT5KIBsxqdbPk2dT/VzvLhQ32zHrBzPBLjOZsGWeOLBDokf8HyAytGK3o?=
 =?us-ascii?Q?CAB+cKH7x/zAF9y23It47CDrlGZ4dW1TwnDYzGnhJnHvjtdrGflO8UKyA02r?=
 =?us-ascii?Q?xEvALPKyhkz8+Hmvo/v9o71Ajl5ZcqbJGsaS/CVDhJHH9WLEwPq8KdvWSHNS?=
 =?us-ascii?Q?MbMXPzMdg5tAsPfTYJH4uiy3LxQE81c4/A6keMUTkDNrQiU2dNgelTRnrzOs?=
 =?us-ascii?Q?ZKbFhDKJKsyt1tkmB8LmTgjsDF636Ki+1svYdvQtH8KtPWpeoXBC2Xg5My71?=
 =?us-ascii?Q?c/EwLMaGDaO5QRes/8M00c/Cj4MCFGGBPY2brjLQprRW/PTAlZLH89OFdhIf?=
 =?us-ascii?Q?ql3k39b7YaEiPVaVmRFbAjNqHcOsaKp+wCSUBC21joO/GWOJ+ujd8ICqWqVf?=
 =?us-ascii?Q?ivk4+80j5Jv2iU2oKG6C0ZRvgo+fXcOny90ckNOM3m12e2zEW2P2XeEUO+/L?=
 =?us-ascii?Q?HWG/fv0W6mB+1BtYiN6Dlm9M/F4scPkVdQTCc/q4l+hDQeLx61izi70QxfQT?=
 =?us-ascii?Q?oWy9BxrIcZAuHqm8hdNX0bBuM2+Zwt3vB/bco+sxu9OQB8CQRAVX1cR28LPO?=
 =?us-ascii?Q?JfPRAfTKGj0aj4/9XklOC6CJr2pHE6UyYJ4fW7OSRKYfvOsgUzjDFN2BOQYF?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5XzpYTuu14mBVW/vDQH16jyGcetpj09BFicDebdLxTBaWRADMiVDVwN4OIsM2Sj4h6IHnn1uSWlmw7J/Gxod3vakXRnkyBrgeIncVkor47k/qutfDD1OyGkpHkvLtknQVRoAB7Kb6OCriPuiGhrUFZMs6U6YPDRDYNEEzggS10FDlbZZDYvVSZQZfZoCIizNz91xEmgZqa+haSzuHvLTL0ipFDLW28wq3xEib/2EKYh3S4Iui8+G9c2m/Y5d4rEw5oixdp7u+27OtnQ2U1juM5vN69o1x4rGW6FpCcmzOijrMKxxbYEC19GSMeErKzwUJ+O/scC8hxCyxmB0OKv+JmUyg8rknBunI19nda3pW81buSjxmCpc6knxmCiqB8jz6UvXQ5BsNNmC01a3MHXSFW/NiNkMWYbi8FJWEyvh8GoQFlZSlrYiofLhupvb0guhiwqzo666nRbIDe+XGiCv58tO88DXQILNFHSdqpX8aFy9xszjFpET2ycEd1XItVxXmqSOetct8R9az1D4Fjjh5bs4t1qixlPTfvf4An/bp49UKtkV+YLU9mOs/04iMCZzEBBLOOAeg9miqf7VEoXxelIjnGi8wMuiIR0ZGXLg6Zc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535d1ba7-f933-4454-6e21-08dc55d83dff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 01:24:02.2676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrE7jhLPM6xuI0IK9nh5NnzLy/zXnqXsF398Htq+pDuX0rgdO68W7D4MQ3BLwI7slxyUqN7vuRK8ACGYdx+uHrmU4gdFd0dAW2IvZj2Npz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_31,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404060009
X-Proofpoint-ORIG-GUID: KyBlb0OiB29pm0edjYvU2GCKggo2foHR
X-Proofpoint-GUID: KyBlb0OiB29pm0edjYvU2GCKggo2foHR


Manivannan,

> This series adds the interconnect bandwidth values for Gear 5 to the
> Qcom driver and also adds the check for the unsupported gear/lane
> values.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

