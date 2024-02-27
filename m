Return-Path: <linux-kernel+bounces-82623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD19868761
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51D828E0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBBF199B4;
	Tue, 27 Feb 2024 02:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fOJPtIcX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GZ7Wzm0x"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA77134BC;
	Tue, 27 Feb 2024 02:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709002024; cv=fail; b=Qp0e4aY6AgMjQrlG3DwRzW1djHK+0wzfGMr7ahZElBRoKqXw/OUCTWbmyiWC+tpLZ10a+zFqA1i2bDS1PG6SZkWAhow63lnP3wJaxg+k4ZZMjalMajQdrGUb0xumGCoAqo6hZRHnCAa0vWXolooy9rA3R0bIwFkEbm1zavIGvhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709002024; c=relaxed/simple;
	bh=nOYMFjs46j/87a96PacxemXL5frSJdHN0st31vjSDl8=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=BwUqs5I1HiCk2AaGKOEUY/oN1nTVAiABaa3G/hLgwB2GG0GuUp8WejysJ/abR1Z0XDkNHTRWV+DcTqKf6lfhJrcomoxJzAbnr5OQ0b3go1HeloTcKrv1krFtBSp3ilFHJmafPKQPpfgZlbLRaehg/0/+B19YlAi/br+A0+EOTgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fOJPtIcX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GZ7Wzm0x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R1E8WT024468;
	Tue, 27 Feb 2024 02:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=cMqEkRjiq9An9UO54ilS8d493nhm9HdvBy2jK7fV3do=;
 b=fOJPtIcXJnQ1mgh1DRaSMl6N8yDdUfRrdRt4VxwdqruLy8vSVZbKiiRG/UYvgyf+dz/t
 aY5wg8q9yGErWilpfdUQrr+lO5gXDg4xAE6bFug56VqfaRJ7Ux4MFroDlAj2oM/vY6iu
 EYPgnv/VXr6X80OiEYB0krGkSMhGkugzCpLTqOLgtoj5Kbo6XXzvAzZUd/B3OHdNOjr/
 Fyntcc/JKcDM8+UjFD8UuJcs5XEFMp6F4KqkuR26VJgwU9aiKxuiFnAj915V1zyJ9lFx
 /q+P/jJ9OGuYK10EjDvnF6NxGEoatZrOwPo5UwYFgtwm0UQyCe+pB8sqMSgbc4288Kh4 ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7cce1bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 02:46:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41R0Q9RV019220;
	Tue, 27 Feb 2024 02:46:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wgbdjbt19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 02:46:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ+BS5hliDoo6rT3Zzjrm1fTp00AggBYW0rvnGdvjOWIql5rWSLD2ad9bvLPaNP5RzRZlNbJBFxpKm7a5LSx22xbb6Xdewfeu9r6AGRVk3po3DziI9GHYkznu3FTXpRvbuxL4q/gx7i1DMEwagSa6RV7ruh2VWMrvn78x7iTEHdkVjOb8oQDadP7MRGiWE9ARD2irCecahCgVr/udB17/H1FFfLQKCdIbHNMZEhK4geMz52KBdoXknmNv93M3SwiYFUIjhAE7GUb0vA1NaF2gh7RgT5uxBM08sOKDeWuiyAju49D0j81SXzsq1UQPrFUHcicN0w+Cn9ZXTqjwP2jrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMqEkRjiq9An9UO54ilS8d493nhm9HdvBy2jK7fV3do=;
 b=MVLw6oQCSoBwG4uhrIj3E3w/5X2EfNF5HGz4pkOof/vBOAnu75ITI9tOn5g93CMV7GF3EiuYM8EgOuVIm5htikoucR1Fq9qS7sv/dYJmvAelv0x/c4/g8Z150NA2gBdF+JrIbJO/dytuqK2rdDNkn5FbgWnmUliHwHD/HkH/WBUiloNoreOC57oiB5x+b1pmZoqL0p8qn7n+NIKOyfbdAHLyayHOjG0zXCP5WvI2GrNfIpyZky5MnaUjI87Pj9ynDuv8QPyPToNySMNgw4pNP0qh/KisN2SIZSP6fzFP5d87iMFVqR4LSDPmjYXF+2CKux1Kt0Q6U6s/YX79DAygiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMqEkRjiq9An9UO54ilS8d493nhm9HdvBy2jK7fV3do=;
 b=GZ7Wzm0xrbticQThBPm3B9D8m2xHrZ2/VXCIPn92dnhxFnn8DpSirdt41i+YSAJdm7ZUhweEK8kaP4k4GkuLURPuNrpaYS7Fo5ItJlp6K4l2n3Lb6lmJsGwI91Tp8N6vzWAPV2rT99WJT2yNGEd7prLjf7uGSh6DOW73aJtviqE=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by CY8PR10MB7314.namprd10.prod.outlook.com (2603:10b6:930:7b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 02:46:44 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::e542:e35:9ec8:7640]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::e542:e35:9ec8:7640%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 02:46:44 +0000
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.com>,
        syzbot
 <syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com>,
        bvanassche@acm.org, emilne@redhat.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com,
        tasos@tasossah.com, usb-storage@lists.one-eyed-alien.net
Subject: Re: [syzbot] [usb-storage?] divide error in isd200_ata_command
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cysi4obq.fsf@ca-mkp.ca.oracle.com>
References: <0000000000003eb868061245ba7f@google.com>
	<99b0fb1b-37b3-4da4-8129-e502ed8e479a@suse.com>
	<9bbc5b63-33e3-44de-8bce-4c59dcce5e92@rowland.harvard.edu>
Date: Mon, 26 Feb 2024 21:46:39 -0500
In-Reply-To: <9bbc5b63-33e3-44de-8bce-4c59dcce5e92@rowland.harvard.edu> (Alan
	Stern's message of "Mon, 26 Feb 2024 13:13:01 -0500")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0064.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::15) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|CY8PR10MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 156bc20f-f3d1-4954-f304-08dc373e5551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8L2oxgD0szIDGfcZg+XB8x8kTnWI8Q4cgKhN/WqazU+orpeSOip+CxCwK+TFMW4ba09xw7in5BQX8tulshXPT+d+QFuRhBjjHKHLkGYmse+q5DTFrUFzYv0MmDNfZZ67dKl4DJIinNhF2noO1c9ReeNlPLHnPBfcxC2XkjQbid+ZyB5YvbF9rEyCQQl+4VjyhrCjn3u4t7QrTnH3RNfXKkZL3Vfkp6iMvV58Pk0cZy+hdygezxXpQYbqed/dGI9u1ne5GTw3NzoPZtkdz8h3lPU1ZsuvxdR2Lb21fWJe2tcKSqkKd/ntn/6imLd3pcC0TCt7so+rNRgMVwZL6BPx9GrYq8Lw574iFc2TrzshNGNqQ3onkSfPYmIAQQ7ZXcY7Vi23cRME2geIgbWG82Vw9L7WCk8iOmxiuE0wGx0b4s1/OaVhguGwaXW8PZOrABJYjv7B8uhuXxo9skml9sef+Uz4Q1ykTNz0QLX0m1q8eRmTLbzw1qej0C1rpgLz28+Ryq/ot/I51jgP86COSvHZb8h7Va6hNVxaTpjEqf2U6K1aMdzZKpn2alU6GRaM5mCBQrIMr+4gWEDRBowJZnp0Znb/VwJDyJ0lAjY/Cj4Izk03D6neSvykWOw3dUIpc5TMr7LTjfpO7+CjYfNdR/VSng==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KUv442u0SwS8bwgJAEQBdnLhUrX2wi58gpvCTrAO4N1QJnizUSSwejt/llIh?=
 =?us-ascii?Q?QOkeuQNf6r4tGq01m8U+Qiq/p9W2Qk0jMScJ5Z6VU3dQczaUbYmQV5TFsmpN?=
 =?us-ascii?Q?qgwoNSN7zlJUWVGJ3BN4JVFB6eUjORvzp6YCZhgkKPTIviJuqKeLa4cUICtm?=
 =?us-ascii?Q?Du1+7NRJ26EAU6EYYH9AxmLlKczm8v3FOq2k4+DTb9xf+AQVc4e9HuY7J80p?=
 =?us-ascii?Q?j0UVLYchuMWiUg+gPZ+a7fHpxzba3otIErUQUT5fnXxnASvN3JS8hWLPIdgj?=
 =?us-ascii?Q?mMiw4MwYXlZYZGsY/YPAC0rd3jBZtwrjWVDWowIfxpx6h9qCOrGlgRsdYATR?=
 =?us-ascii?Q?lTmXiKCl4GKlfMnJfcIgCREHSGEVM2fWApGokpXjqs14Li4LtADKP9pudc2g?=
 =?us-ascii?Q?aEZE+jgCnbv8K8Q+kqqrOrAH2fKE3AXC6y17bOOny9vZI2Q56sAKQn3MqCbr?=
 =?us-ascii?Q?ilfInU6Oxb63SyX09YZB7olrxKhwu8nfwbWfFRBToN+yYsmub8X0/VWW2Jqm?=
 =?us-ascii?Q?xTOktm9+F9qn+XKaQjcFc1Ar/jkit7YIVNDfhbTjZDNzbwWRoKCeOBYZm53a?=
 =?us-ascii?Q?gjcQc2HfIES4Zbg7+9T5tr1Q03WytTCBQKVqjVDMFsGVyDRDbtMwuF2B8CtF?=
 =?us-ascii?Q?8GOmoC28CvV1vXGS4YZHiKvCbFrv3w2p4BTXTrVsK6t2nKEzcxcVFeKTVcyg?=
 =?us-ascii?Q?kK5By75azgw+Ux7ylCoh202p5FSujmt4WPXpC4Czd/RvhTgBHnEoCkPoWgU6?=
 =?us-ascii?Q?wHDUgoJP5lTCjrzmJIKLVZvj7gjZXKNou9uzV+M+to+2P+xfp2kh5QmPTsNj?=
 =?us-ascii?Q?FK3Pt9trMeYGltq4KOOykHz1LayqEQnVDp7QSZBfD40sVRDkKsljeFrDYZ+K?=
 =?us-ascii?Q?l3mgqyW7mahqGztvMb9GWwQDx6L/e7l3wY9MwInPPqGcL/Q31PluXCpcwj27?=
 =?us-ascii?Q?mOBp8jEAfOB95UIsOyeQpdQIDE4AGj1pO+bJROKRDHtbtGEgraGfhjiu3K40?=
 =?us-ascii?Q?fH7mVzUSNv8xy/RqKt8aeUdB8F33qk2JEtiOchfZqbDOeclmHg1dLN/U25RV?=
 =?us-ascii?Q?wpVUhc+cvSdky5mPm8k8dDpwtj+8p++V3J3OKvK5DphpmyL1OEBLqJuiqtIT?=
 =?us-ascii?Q?DTUPc1VNRD7tolBfLr7/SDSryYHfLNC7ySTg5U7I2YYa+LH9rY9wsuAmR75r?=
 =?us-ascii?Q?DB30ZR0c8HBkdEEAkhfQx/SH0rUpXDg1gCcJ71X+kiUbiW9IbOnCsjtk6cS0?=
 =?us-ascii?Q?IqVWmAUQIl6/ZB+4Bt0lBHoQbed59Xd+rQY/JWJFq6dMSj4FSdvm/+R8fzfl?=
 =?us-ascii?Q?8Fd4QPZG9utPAaT+noDLQO76X/8tO0m96oieH8T5CjMSbbZcMAnJCJKUKGdh?=
 =?us-ascii?Q?pwr6dhTmhNwpp8QJDz4YvQmmDfrCWD2jn3m5romvgECjFDz/xSWmn6GBptDd?=
 =?us-ascii?Q?XZDtN+TMiHWtO3Xd/vbGKUZPInFzGUYHCIM82ilQCBvKC+EEZ3CLL+0Xrb21?=
 =?us-ascii?Q?9iZLd/rtAMqzKwzuvqiWULuC9ey8eFL9+KhlNmAg08vEcyy5DfsY9nn55wBH?=
 =?us-ascii?Q?LOfXDt1uWhjssnntAHJU7halkgDQ8Knt6w1MS8zKkDQ/nVapCWZg/bZUClFM?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7pr7VBkzfxokkDibF68/hSpFUv+GQRuZXHrLHK0SOYgWtsIkJBgcS6kPaAMfP+N/WgjbxnXoxRtxh4XD5OLBYWdUzqhIlTtebp4pn9FrTW0kcELErdeRHuOq0UREMMP6Ht5pjF3Bdw0HusBXPKsBOHraoVh3YRZiaApTUCgFdzy0+5uq6dgGkzotnEvPZ7U60uJGv+tWB8udPGh4eXff/vjmxqo0yosKhINAjWqQFKbGx4qNxptngM92e6xQqVfDMjkog3fgVa74q3vt/tU02NLQjHielEjRlQM9BxhVFVABshklcLjf2YKNGeGJVuo9Bj3bn75Qo180wmo0kc5leLYxGgpmpfecF3tduV+kWdX0eJYx41LrSqlmOjYfD5GL4ORKk3zrEH9dtBzwXhEkSHaVDFX8f4q952zfEstu7JsUnLK6BKn7T7l/Zsdx46RSIKHVQ/PP3RyRpOuGuxJIG3kpMdTYgU+gwiIiCgQXq9gyHrk/bGimCQ+EY/bwch6DYO6MD6TJdXseUjg6LOjlVxRNdWoJSFuaZi7SZCsmI/CkDt1ScE0kebF49kxbbY1yeBp4EOd4GWAn/m3R8QqFQtXff3m5BnfQx13eAx0+iBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156bc20f-f3d1-4954-f304-08dc373e5551
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 02:46:43.9405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWv6nKrB4MyHY0fiQXCCcwm6GzovmErls6UpEkCWSWD3+om4spAwZ/6Z9rRY7AQTaDmJLKe4pMaOcgaA8vHed2gCZYNVqp81p3+TzKjuM7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=968 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270021
X-Proofpoint-ORIG-GUID: 5gPl9eym5V9bJ0vOIvIfF2NUj3pGRlno
X-Proofpoint-GUID: 5gPl9eym5V9bJ0vOIvIfF2NUj3pGRlno


Alan,

>> in isd200_scsi_to_ata() because it must not be called before
>> isd200_get_inquiry_data() has completed.
>
> It can't be; isd200_get_inquiry_data is called by
> isd200_Initialization during probe before any SCSI commands are
> transmitted.

How do we end up with bad inquiry data (or rather bad ATA ID data)?

-- 
Martin K. Petersen	Oracle Linux Engineering

