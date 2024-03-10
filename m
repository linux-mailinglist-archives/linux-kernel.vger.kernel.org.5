Return-Path: <linux-kernel+bounces-98345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0018778AB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33657281861
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DBD3B799;
	Sun, 10 Mar 2024 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LA2qAyIh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zFO5qSvH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B0E3B28F;
	Sun, 10 Mar 2024 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710108112; cv=fail; b=TujnyS2FBY4V2Ub4iwzne9YW/nIKkTCFUheDdxrABoPrg87iXFRgOb4+FEB2JC0enDGpfcBm1iT0OYkXsiFuReSqyPQTAXRd5jgzjtixD6PK/yJW+S4sjZW9RnJ0B39OmhbmsMgSdNcJ2O/xcu0YtgQk8BJDOobl+bdcaqIrwQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710108112; c=relaxed/simple;
	bh=wkNuHXAQY/MvyNUQEBn/3YafsmDRD1RzJwI1gXw4eFU=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=UIXxP9LIOiiz7iEx3H8IIHMBwMGREi+YYhfVaoaDvEbmhEAkmpSfem28jPPYtzKKCtfnBLE/qwxbzSdiOdlEPzEujekWNMYHk/8pUPQRI8iyHR0mKYUrAvxu8vQ+4Z2IPZj5WONjlEKehIJzND/flDEPhCQntzNvW1IAxLq+k5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LA2qAyIh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zFO5qSvH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ALKk6d030484;
	Sun, 10 Mar 2024 22:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=pJpvV3j2/oM4AYH3Rj//EGRRTQeTFOOgBxSNeHUStQM=;
 b=LA2qAyIhgs497hxxZ7ll8rNzrOp6az3haoli5OEPwgJEGTGiAem9zLtY3eN83GOlTlKJ
 FZEfr2wnsc67Pxfj3NabaLzMm4EynvaxfDxGe86WtsGkL3u2iJqfKCnWhp9sudL+UhBm
 7IoUGLODH/nHFh6fmT4gGyu5JyJTFvB5NgkAwvuhpO5oR32MDREBmsF6oEsa/1Zv++D5
 Am4YH8vBVK6YlqtdDhKNO9IoREC3xbrrR+JopZiWUG5iC4tUl9eBl4nykrP6er1j5IgC
 VhxldXG/zlLE//O3ZTIUnB0BnaTKOjbdrbYZXL66bW1YEI76vzNf6MvIdZJO4O7/N3Gu xA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrej3sspa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 22:01:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42AINJO1037984;
	Sun, 10 Mar 2024 22:01:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7b6wxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 22:01:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETToqGn5EyTuX440M6D+gvgv/2caPThnS4WkRkQ3zIuw6KShenulW9jQ99j+i0DwdmInYll9sDfXR2A6VSuv4MP1MZQjgTeY15JItvCkBbtXOEbFtx2M4oMSLS0zaux3xqppTPzPF/ENVxq9SFEfvVO1yksVsM33jwE0OmEFZcOemkjYG5nUYsV+LLSqia/hAYc7Fa0xf1sXRDdZfURekBwik4oX8aifbxnC74DHdZWkMoD9/AkSrsaNoCxTywV/CHo8oxAsaOueVvG+bEVR8HPI4DEIS56NlglLRE2BGW63ZuhzZrigjFNtAqGPxWWWp7xhJPDF7Ajyjs+BZNVmXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJpvV3j2/oM4AYH3Rj//EGRRTQeTFOOgBxSNeHUStQM=;
 b=mPPiXa80NSdnjtOztNN5ixG1+v1yQlh6xEcuykP3LReHo7i5YIe+Rt+dQ2Zk0BT968UrPQzpuPf8rrFpXdHroCwwKdRE7UVOmHBe8WJypOlIv6IgKX3xcDFAv+4hb7uLajAyy+5TWboFkxEB0sy84T6vmtYK6EawDsP9Mdv9hKK7bDDCQ0MnHlkowUfqg2Q7PV8utL5ELqBJnECW/wjQTIP4ZoJP7f/6zOMzdxqc43L+QOn36ZNAie31bU5xB3wZVn8axKJxEvY/TqAzYIMkMHonQxVU7BCJGfsb9HNpqL2eWryO7NR4PIk7T7OWediGIaOg9ucuW+fWg6wLU28ldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJpvV3j2/oM4AYH3Rj//EGRRTQeTFOOgBxSNeHUStQM=;
 b=zFO5qSvHlmYShoPeMaUNM8zcTW/W2ef92RB9x6cYkB6Beu7yU7rhl3nLp/jeFRQ3Xe+nfwODL+TYD1gTbvZZvSRtGR+7jmd7FLkZHOfwItUEzF0oHwsV/DBKh3ve0Ufc0o5c6m5h802TCK1pLEKKsByd3XL/MiwF3mf1lJ3PB20=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB7729.namprd10.prod.outlook.com (2603:10b6:510:30d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sun, 10 Mar
 2024 22:01:44 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 22:01:44 +0000
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mike Christie
 <michael.christie@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: target: iscsi: remove unused variable xfer_len
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240307104553.1980860-1-colin.i.king@gmail.com> (Colin Ian
	King's message of "Thu, 7 Mar 2024 10:45:53 +0000")
Organization: Oracle Corporation
Message-ID: <yq17ci9eofy.fsf@ca-mkp.ca.oracle.com>
References: <20240307104553.1980860-1-colin.i.king@gmail.com>
Date: Sun, 10 Mar 2024 18:01:42 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fccb94-1c9e-4804-da46-08dc414dacc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0vFbiLeEia27ddzJ2i6zIokFTpC3Kn9/B/WdM9uRkJHRbQEbdW/yVAtyswewRjY9cY4n9lJsSOlTCqewOHymsRuiyYdM8aTq99lGAa9MHBCCwKAyaFeQNEygrGjfXRMNLen1Rl9TPshLXNLhE8hjxOq1UQ82PsGJ+t2uC80ByizTehgB8iIJZ4COwAu0Iu/U3w47eZXYNC8WbevnH92bKD4xhZl37ZAycG1dreyNtLa1RkBaq4bDUvISov6pLM+SmCMvBpNMxC3bw2XSpadL17O0yJLpKFJDmauNmWQK3TJj0/kLVU5nOuhkfbF2xLPpF06/IrhB4RYB/2wmsRe6eg6589yY/GT2DFyE3Qlw3K+B7T7aq5wWt8KNqaJpNcVx5q+gSrtf1pC2n0XLWNQ65bysSsv0qhBTLqfE1nC+8oOydlYRQXVDxT+tzw6F+TLmYPuecOXgXNrFqRattgXzZbml2ec+By4Thlu5EiSo0dIzIfKbJwiPosgAV9jRPNZVFZbFCbOHyMiNoSAJHzYvzAixwA5p8JPCvzoPybJe6PG+svZ6dTI709hzkYZuRFAJksoIA3NFK+pJi2/PzViGZqAAuEijqGDCgRymke11xN1PmTwoD2rLXlhiqz59eh8cpHnSTbqZFeuPIUsUvG+cSwaQPyoIozXYRH9GkPs4d9E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?z9RjJ3NTK3rM3HW6lUEyl8hTLH1RlXhAquT+KWgTQwXHzapNTQLnZDdKc9yb?=
 =?us-ascii?Q?oajnCYGqnzdG/Y9PDjXclC5DTQTCf665q4ghqC66Yr35food0WYCQSjKRmxx?=
 =?us-ascii?Q?ToexX5NeIyCJe6Jbbj+97X7+e62/7teyjxIFLnslkobMsrd+DZDvHj1AaQmo?=
 =?us-ascii?Q?Rv+Fv2oiCnqJWxGx2dQrJocOuxwpR4E85TL4ItL4ExKYFGTJCWeaZVqy/8CE?=
 =?us-ascii?Q?pKTXZp8qKZN0qPo2dLjrKZISPlfnZQcgfwvkt2MPpOkFi8aSv7Fh/bqiztqD?=
 =?us-ascii?Q?SxWJxrspsu9SmUHcwrt+0O3eIeH4EL87w5iix8vJeY4uKQgt8xYraNg88gQG?=
 =?us-ascii?Q?CXJOfEhvbmvoIVfCR4CB0Ead+Pnnngy7Mdl/E8OX08Ud4xKtZdX/NWO9blYq?=
 =?us-ascii?Q?iciE7oKjxRDwEHjP/qA4SE4/h7RP7MWAy0dj04f0CL5IHnqScHWedv2ZJx3W?=
 =?us-ascii?Q?8F0J4uFo+P9893Q90EaW+qmPI2TgCizYTi3jvIKtZQL+FoprknFBFZvUHJbk?=
 =?us-ascii?Q?zaKTGCE+r0usBZyWFdv1bZLZaA+a72V6+Ro4Kzvo2WqUD9F6iXpnFvJKMpBG?=
 =?us-ascii?Q?Z69OwrXWqcAmo4Pr2JRCweRiW2/h08FEkA4o7ui5uF+oPHEkn3AL4tunNus6?=
 =?us-ascii?Q?7v1HU6iAuI3OiaGoxN8xJz3/cX/VFyOHtwfA1BZ7mwj5qEU5KCtriOEo6BAq?=
 =?us-ascii?Q?q4INXhoKSb9Wx3RTHwbJ6+i7ravxvw/17jOxSYjAs21WDTl8Od8IzDLIUjkv?=
 =?us-ascii?Q?TAZuImtjQjZZq7Xx3od3QPgaPBdZLnRm4WN/pwVqLu5DlGRiU4HpLfKMbJDH?=
 =?us-ascii?Q?LZSh+rKbjKFoJAttenKRhnAOScN/VKrLEGcoeCjbUgV7uIFWYoNR9R7KmDyR?=
 =?us-ascii?Q?VfbuJHLJI3RhAooQchDcyMcDqkEAgQEaLom4PXHcEz01D/nfEj0AnAUryWCb?=
 =?us-ascii?Q?YhI5kvtiJ7McfVf+RRG2etWEwGmMRm/1D8PuTRxEe6kid8PHtJ8oSrPJVX6I?=
 =?us-ascii?Q?Y/3mTV6SVZ8JqBkQa5Cr4GF2m6JQFnb8nACXAqDuVuOF9ABpai4K8LIfnd8y?=
 =?us-ascii?Q?dMPWaoPzHW+ZkH5mXnfWYHvIQ43j7jE8xcRbbNMlhT+i4UMBS727Uiwf6IKN?=
 =?us-ascii?Q?0fR4sq2mxBe5Ek5L65gGRViRvlsbSKwtisJ+zkq/KsXLUf3870cHEZAioTAm?=
 =?us-ascii?Q?8/W5mOuZ/SJLCWWerQVz+j1j0xr64oYfD3MkP/wJWVIhdmvQhqXgusvO5ppo?=
 =?us-ascii?Q?YlFmuBcMBvxCKUpQkshDkbRlpVk1eeUw8v+BjYqU02f3oC/tLBeYXm5sTG2C?=
 =?us-ascii?Q?dg1VDhRE4+MVhO2a5MxdWJw39Q/A6Ax1P1yD6L/R0GvrR/IUm+cEstNVwuup?=
 =?us-ascii?Q?d4a0tQZy+tcBXf/2U6gzPDI71ccABtkjyeGXxyQ62UjPgcXrA1lOh/S48tVw?=
 =?us-ascii?Q?3/U68Q/0yQHyK2rQCZfhQ67rhgQJ92tbm/aRUQI3GV7HNQJm4I/pQ8wOt/i6?=
 =?us-ascii?Q?zYkLX4czzMSl3/k9iVQAmLS0N1RiJJJ8NlqiNKOyUYdo5FUsRXHeKaT//4MR?=
 =?us-ascii?Q?BU9ZWRfeGIWg6v8u9CyBOZ9ceEXC8fRKtwLiPfO9+wL54fazzOeqqj0GN0C3?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7PIUFvxk1pmRtMQVljGIm23QfYdCvnA+phU79NTPQkfns5RpOugcNx+Cgys2udht6Pu1MuyeJJvAQHZdaBEdnVVJrxTlX0qx4P8+716WovIneyGx8TYZBSGn40m7gSwMV3Y0hO1z0jtQ89iYLOdGE3009qwXXyFhRclJ+KHBeQ2kDdAHzLEfzQ+Ezeh1370GVIYDXcFSekkdh1pE8ZfRshDiQnPuQ+nGJFshvmTwoDUJJd2WVtQ4v2ddNjw2gYVAZapWF1aEm/TD8Dk/5ovImvV5uHLxeGwtetTBBNKNGr9Sij2MyRxrIkvRrrRIitQtLVJH15S2vAZN0mWU9O9Oomzf5khuvI9+/pZ6LNy6HhZrn4XOF9eU+dNDWT4mHTexPFXOhNFEGZsJwJXOjjly4IgIOX87gzA+nJDtbeHrfjiJawpOLbuO679ndohKI8heqssgxpV9Zu4fKGW2LqaARx7WlSrZTFCvfutXpoZNmwLrQDM1xAao5ZaB4k2lEouriZSDZe97u832WB24S3YQ5GRx+/t/nOTfVfacinntn6rgtCrAmXgU/rV1lu5um4GXc9ypf+IY7+NG/GFchENBdUub9O8h7m4eHeXshbQ4CrM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fccb94-1c9e-4804-da46-08dc414dacc0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 22:01:44.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: suSLQtq+YZtxGcstc0sizboiZZEFwVjXWWSAWOkf2FanjtPiLo6MbCYVA879cQPcan88F9L9AWvJRS4Z52iN3CIDR/rFE7/Ww0nmViHQbas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403100179
X-Proofpoint-GUID: M1dVwcRJxtp31QJzq9UU6UysxyWMiaai
X-Proofpoint-ORIG-GUID: M1dVwcRJxtp31QJzq9UU6UysxyWMiaai


Colin,

> The variable xfer_len is being initialized and incremented but it is
> never actually referenced in any other way. The variable is redundant
> and can be removed.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

