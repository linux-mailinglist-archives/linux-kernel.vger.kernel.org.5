Return-Path: <linux-kernel+bounces-37889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB583B729
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A21AAB222F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDEF5CA1;
	Thu, 25 Jan 2024 02:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PHci5UbZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZkXz/zOv"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C3D1388;
	Thu, 25 Jan 2024 02:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706150070; cv=fail; b=RX7xprT5WO0e77KSwlcI74QgeZjR2GXOrimFaY+qtHtWWKFtyJK997IXyUimhIXMnJgf6inPSp64VOVPE0sTxswxuGXFGrztB7cXdCNxUFlHvtty0/JjHiz09AqSLa7FpIS7uOWGGFPtwJ6gNDvLZDFt+Uinre/Pmah1nNgGGvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706150070; c=relaxed/simple;
	bh=3dJHMDwYyJei8lHjygQyDyEQflT7g9YefQVFqlk4lw0=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=MEIm0pyMHoYOFBv+gwxAi6204qHIoUMnQgAZiDvZhJgEs23lowo1a+v+TZ7pOyYVTmCghc5sUS54PNYHFtB449lxbJq5fQtHkb9ruc41lNZw2XLOVowRtVCXIk1hqyXDnFYfyF/kPTClle+0m0MXtgxuWg8M+jOuK+N+t/eKv2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PHci5UbZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZkXz/zOv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OLcKUb012346;
	Thu, 25 Jan 2024 02:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=laakxzH8ULtvlOFZIR0HhwWKugI+7l/ENgLalitk8ZI=;
 b=PHci5UbZG81k1GULjFgWlSGR9X0dcRNgVW2z2o7NSOlYvzTf0ufB7rbt4sJQr9wPh9Td
 SPKtpGAPiBqkFqtkg9k4WlHOKBTJge6grsVrfHDDDSr/7nvb7EFOcpNrbjJKk6v6lOMz
 y8j+ArMs4sdAkTzgRvIWbIyrQx1Rn7W/IgPR7WMufmcafU7snx8Jmso5BibDheBSjwEm
 NhSb3ZsF+P1mQsuqTL8eU2aoMlxFB+/Y3hFQcQWROCdpBeEkLoH80/oEc5FciQTaQuJ1
 erCvH1CB6U+PtluDyIg/1tB2Kz7qp9OWrfWmKQfVJWBMtQcXkhSYqSyEk+IHC47XH/yU zQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79w602x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 02:34:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40P1lYxO026032;
	Thu, 25 Jan 2024 02:34:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3184v2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 02:34:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEpliieNjIp53z+2UJzH4gzYAgWCmUB3kGHZae7ewP6+BucKdW6g4GjYQRPTdKBSevjInCPQEuX0nuGVe5QBsw6OQ+3UcFKgnS35OG1GIozQqX7gCoNB2MUl5Sagnax4XLC+erdyeuRSPU1rjdqeZS8fV03iio3nbcacvXehRzu1JUS6CndxQMYqAFNRcllOiL2tuVNIg4yjIW9jPQuGGS0Mpvu4YqcN4R6EN+15Z2L7V2WGYZLZr5IHo0OyAzoqWo/8n0Kh/+I9oCERDK9h2IQ6MiFJgfChLIDk3c9MGkeJjfAMOJtkiux5csYuJkLxN+Q41IFr4tTMlkXKwtwyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laakxzH8ULtvlOFZIR0HhwWKugI+7l/ENgLalitk8ZI=;
 b=a4ONHxdIQ52dWhuGDdYO7tgzH1wRcpyNzw6qNP+bYHk5KM5vL1+YshOHIos+589AgJZaJ8erFXusLv2r8zhDZEPzlpRjR8eMxeyCO3iDMcmPn6MKBzfnixFO95J4WPSWmLMgAih+Xa9UHJUEdulG5Mickb+XxaFmFa3PDWYeRfHMolUWINvjZkgjS7+VYznpdw2SVldRzi7UhpldfOTJalwLEtXinoaN5MBmwZaZoiIPK7Xz1Ur03lPFqBgMfYmNUHRsUc42OgrIRg+njcZ5nH872wyK82Qt7eS+qNONjKfQi8m7u68DvuLDKejlQA9iwACQrdc1TSxpZfm7J7wVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laakxzH8ULtvlOFZIR0HhwWKugI+7l/ENgLalitk8ZI=;
 b=ZkXz/zOv3drxy+4xkLBvDOAyKurbMi/d/DrK6V8mwr16Yug+sLprrFWsEGNfk7lvN0Pbx2JdD3UtuGWOD+QLtu8Fsgkx2sf1Mua43faCyqF8k2ipXSXzXlua4FA2s9CELTF4n3Vwm7qIMsf5SjKMF0g0MQY1j3Ag9QO3/SgtDtU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN7PR10MB6666.namprd10.prod.outlook.com (2603:10b6:806:298::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 02:34:15 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 02:34:15 +0000
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
 <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>, echanude@redhat.com,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: qcom: Clarify comments about the initial
 phy_gear
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zfwuuoo9.fsf@ca-mkp.ca.oracle.com>
References: <20240123-ufs-reinit-comments-v1-1-ff2b3532d7fe@redhat.com>
Date: Wed, 24 Jan 2024 21:34:10 -0500
In-Reply-To: <20240123-ufs-reinit-comments-v1-1-ff2b3532d7fe@redhat.com>
	(Andrew Halaney's message of "Tue, 23 Jan 2024 13:13:36 -0600")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0135.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN7PR10MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: d53d3a77-d2b4-4973-3b1b-08dc1d4e1f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ybn75NOXNL//9H0yfqUG17tfQ0VwlMZ8f51xa32lNwnJRU00Txe6R6CxfABQS5RB8kZUDxtwSiUFA4gzyRWxfTL6fc03Rer8j1GyEiV5NbAZfsYu7CXaE70INSirEOnmbEDiI1j37cGyjXSjYJKgmsTEF8usJkzySN+gRsvJEJ91vBWVoJjsVJ67EXGmVJuY9Uh2yTCw3piEtmrXk4EcFFAqRuDCRmQSIviRnMCJ+tO21PitIMNsecYRHrOehG8iCAEexP9OQn8MCRymOD+sVpLRoDnWGTEoHHQH52L9Po4Gzg452XQhpQ0lHbkaF/C/sPobCPXDzanWl/ddVfc2yNX0j/d0yjL1dIzt/OfZepX79VMEV7IwDoqszLi1dRZicFenD41hws/KEz4cBUZ6dN/2fmDDtCKpSqQ/thQfj8UJ0edFzcgNfKuMx9Qeqg3iDOCdGbyFrhizrAXQRSRtEMqMF97aewb70vkH+AL9OvIa4XR9mmKJY3xEIHiOgOyaOONKvRl1T4U9cE1dxajq2nN7NVoEQYEX1zZItX/l+e82o1ysefWIxk0ohVHrN3kd
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(86362001)(6486002)(478600001)(6916009)(6512007)(2906002)(38100700002)(8936002)(6666004)(4326008)(4744005)(6506007)(54906003)(5660300002)(8676002)(316002)(41300700001)(36916002)(66476007)(66556008)(66946007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qlaKxM4ArL9xNwiE/iz43Sl4rSMkYX3xHri2HGKPSdL/OAuBLZyc/v0g2sk5?=
 =?us-ascii?Q?IOJcT/N+w8G6dggEvK5CWGwOYZ6I4G9SAF6JzC3yTvSvKFcTWikEo1vAKbja?=
 =?us-ascii?Q?5jxU8bjPAvCIFwDmD49SS4FdSbs8Vp5ELvEwXYeMr+N2Q7L6/wkcbHAU1vOU?=
 =?us-ascii?Q?wBfiWjE9bwH2IFlqNPv81FMs9Cv4nM4zx0+hZpusGDITkIGT0QUyM/F2CG+c?=
 =?us-ascii?Q?E/hCRKfVCRXOpXmBs5shPDAzZDRMiHuZVKbfpNXzZsbvzWMLGxy4B8kCeLn3?=
 =?us-ascii?Q?erVln0XiVK3d3kExPEG6GnCKU06muRitxttzx+WaS80V8KFyoA1+Rso0edtB?=
 =?us-ascii?Q?ay5k/hJgI2M4bZuumUDfoqEaSh1iudvGUDEeneCpi7/q3isrMK/D/jmYcDyi?=
 =?us-ascii?Q?DWbm7wTRc34zD28E2A3wshXE17vPw84aMtdKCyor6kNEiYBA7H4YTlmjDawH?=
 =?us-ascii?Q?lkSUkBMMLzXt4zdA2hQblofzDcKU4zDBl46PJlk3ePKl2Aq3Ki2TNa36rR0F?=
 =?us-ascii?Q?0nsGqwa18/tBecbHsde1ORxIM/Ft2+IkpvB1gBfNceo6M4I1F+uMlcxOtryp?=
 =?us-ascii?Q?7JO7H9KAe1VLv7Hui9KMeDupqtOhBRx0YaYzvfBMraLyNlQmJp3PCc1TckGx?=
 =?us-ascii?Q?y5lojC94BESswNzZyGvf2feEdkEHzMsu1JviBu1uFiLcI3DUI6OS+lJqYSqy?=
 =?us-ascii?Q?k/Gc/uHNuUXoruuBnr5NMyosllet+0wGTzFCI6I9iy/dCzKDUTaWB6nd8Px7?=
 =?us-ascii?Q?dkDCDruY4nAz4dy17XFpKNA+nKfQKO7R1UR4t5+Chw1d+gRxGiTosp/TH3Pu?=
 =?us-ascii?Q?omAdNuSgQDXweygxWk8xWWq3UnODm+JyGVul7ikdofQ0GQEbvYL+69qtOT9h?=
 =?us-ascii?Q?hUAvwpuLNYzWXzQsyB3472PVCJybiNOYgwgXrNFiWAJ/ihrM5kf1A8LEwxQz?=
 =?us-ascii?Q?rnkUZzlOAV8CnL66oQRCtYeq7zTIxTemcVzwyMG2kc99qDdgB3JN0WUjhumZ?=
 =?us-ascii?Q?xsnrIrPmvGZw7PFz20BwpYIuJveHoThXwqwaN8RwVvyhUNW0SxrunmXRRc7T?=
 =?us-ascii?Q?0JRKD6LPXICiezwws1uGvc+8nZ4QNadtbCs3gbrzLY2cRyRfwl5WJFdDTYHm?=
 =?us-ascii?Q?NGurj2bWG2cqZF+l8DggT8V0pCP1WufCZdGNf71rBVKzHg0ZKG4c4w6KUFGq?=
 =?us-ascii?Q?hMPm4yzrzFqXjPHVwf6hsQh74vHuCJRfLYx21ympTmC2ULQWBQINlvIZ60nn?=
 =?us-ascii?Q?Fl2Zorcz+Z/+0TE+q6NJG+1K4uHZLL9NNSITC902nXg4DcPhNaP0IFzyXl4o?=
 =?us-ascii?Q?TrARPqL8myRjkJJ16VwXnyHyxLSmNb/IJNOPuxYF/Aun7zlyIPiOQhzqz0Jk?=
 =?us-ascii?Q?k0O4KwkHaAidRiSArTzrIrcwfjWsRMG6IPKq0HUm/HDU5CQEocZGzGCnpyDG?=
 =?us-ascii?Q?0gKNKauuBY4tJikqL9mE6F9E8GaPw5uROqdqcqyFgKvX46tBSYbPe6KOGKyL?=
 =?us-ascii?Q?M6bO/AnhWJb40ILEDCRjqfCjYi/WJiXpRH3ccK1W/tykM7RlDuvGindCze2Z?=
 =?us-ascii?Q?qdbUCYQRAkN86IBMPAIKk4ByR0fdyb8O06GgVvz3EueQmBCxMBQD8CIqH39M?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Zxs+Th2CtuZdRoKKVi3/L3PqWmpv0Wm4IBDCDFt9Fn1xek1e7nDwGOt5aZ87bTAJPwDl5AyvjTiZPBSJ857VEaVjN542AzkFv3CViFj4gFbkWQnG28XsuY+caMdZHxf1vFUGGqmO8UiT9w15zXZGVhisxKndhNPxhyvK319vzMbub3Ga8R0JVTQ8JTgiYLc/3Lt66XV05PrzdHox6aztukMjFJYe0E/2f294fc+J9lAAqaLnt2ldw3eKWsBIYKK6FwQKGVSYct8VY0PuIGOe23AYI7QG0/LBHE62bddrNIE80fHU2VAZgHSqltecm0tIQd+Fzmex1IcPHTH3UOf1cdbWcSR2Api/iS7y/3G3OtRkML9JKQuB4KHmEzEY+AiYA7Zq3DGfNtjBguM7uI+T4kD4jVwVeEBcJgIT/Zv1BSWV4uti26ArDJZDdpH/nhSS7KF5Ff9fr7pwFYTb8NsfoqwpQPsWli3hgOvjP3gsldKiMskLyf7/Tf0KwevcCHKCF1Hje5sXXV2ahu5FKCdeao7zhj8amNjaBJyQ3IQw/zyqoOqpf2ss5BnUPhnbYxaEer9QMA/UeLT+tlbX+LKGpfVUfspODl+vDMmpUDzyfak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53d3a77-d2b4-4973-3b1b-08dc1d4e1f6f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 02:34:15.2696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YRruP5jcbARvWMRSBMKfJNYa65xWsFpq5EGpar+GSn3Fa0wKndKo13vMz29kpbKutf2QGIySmLtu2uZjZvpnhNaA+ZOqE32SSjJiTTIg6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=814 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250017
X-Proofpoint-GUID: YWCMXgOkbXSt1D59nGzHuaInw0g3LwXy
X-Proofpoint-ORIG-GUID: YWCMXgOkbXSt1D59nGzHuaInw0g3LwXy


Andrew,

> The comments that currently are within the hw_ver < 4 conditional are
> misleading. They really apply to various branches of the conditionals
> there and incorrectly state that the phy_gear value can increase.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

