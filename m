Return-Path: <linux-kernel+bounces-36317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18DA839F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61926283C07
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AAA5244;
	Wed, 24 Jan 2024 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P6wEDnZT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AO4ZqDr2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86E73224;
	Wed, 24 Jan 2024 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063989; cv=fail; b=eKXwHqW54EToc2ddui33QXTLssSW1Y0JBVNvxRH542qV74MzYIds/MWN3ur4yL6R7Wz4x0cOvKOHl69lSvB3vGKOahfOwsNM5457exH/L6a/0cHa52O2HAwwAXbf2dsXWyLgR3noMrnWidQWdkKYiUEwBo35nBizJ/AaAVBGEZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063989; c=relaxed/simple;
	bh=U2OceLpWQIJzKEJlyD9JxwZCKgCTL408OuDihD53UsA=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=cpbMAW0w5nz/oCDuOBswoisehVQ3xrS5idDj0zuhB+ViYAOt+v3aXfR5TxmTg0PDqE701cA3S3uWBlXD63JN9B5b0fNloOWT+vaWrLS1UXxBSjueNql+aZdkzf6tnxoi9xYfKQuRKBu7YdFY5FhvMPFmmEtbNGVaY2blIOioHRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P6wEDnZT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AO4ZqDr2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NMxakt010857;
	Wed, 24 Jan 2024 02:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Fy7Zz3SyNxrjTWm3W0oBXLnMj482orNdCKvkVUL4aVY=;
 b=P6wEDnZTxq0oGqP8nW64olwpHTIAVXcg6sHU2URD77sWsRXc9BFH69Hv5Ez2VDlFCLXS
 jHtW3Rwu5L6T/NLon4N54S7bfIXH8OXw3Qhv/Le88YZpzrRx2xYENn3fgx2NNc86Yu+b
 HWN0Pz7rcJjTWUsziSn+z9kDBmVcBNho8AEgKC8dbvsmD3NXMtN4/O9mWZC0Z8dgiDLd
 e+nYShLrFiDeVT905MdQBLf5sw2me0fIjTG5IRsg3nxjKiOWBLpaJT6V0qLYMDdBcdW1
 tuWEtwpgL6D8e2AIDR212TKGF0xpW0PA8PTr55aUA4y3TE9f/KeiJ09n/0XdaiUhtQ+E TQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwfy22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:39:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40O12GcH005546;
	Wed, 24 Jan 2024 02:39:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs371rhye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:39:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6FEN1Qcm6KzpeF4aknt69h9NAHnr1GQNGvFd8D981vRuhoRXh3LVboUd5nIZe8X0wVE0TblnMuHVCpdWQR4Tz5dT1+S5Ix65gL4KGHwRbn7ID2+EPKGdvT0dd+XdPIyNTTWJNriv34oFEIav/pJi004toEVv0KcD1AbFCy7m2YqssD/QPEe6UAezeAMSGsoSVEoaqmx7v+MKaS40FGt8XrBz4QrNWbsMjrId1AxthirKjHHGAqkYX0to8bKMMCWzU9wrI8aWJVyYqLlWQm6E2nmlUqfrwBoqMHBc/OvZnATiLWSOHpeWmQsqQpziV4CeJDlEElf8CaHKucayvYU+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fy7Zz3SyNxrjTWm3W0oBXLnMj482orNdCKvkVUL4aVY=;
 b=n9IeszM2ECiCWiG5XA/5v7mXwBUmLz86T2RxDt+8KXGBmJUj/32gNgfcB6Q5oVR5kX+jdTFUKCMIWesGXWbXD7kaeX5NfXO7WmzEtIM98ZuMAg3bMjaZaaR5SOj4wb7jLDlW9C51HGWsBsvx8d0SL3MGCvmhgvMyZuC/IbU8zbX5lFwVz4WbSVd6qoV5EQtjWhhtigdLRyH0lJ+pobLZVpWhKpOCuRaR+n2mMZCqp+TSdid4n+1nriE227gwWxHfo8+gC+rdT8H4DdZALkLVozSROaTRB0c+MpRXtOvgcfsNW4ijaHvONiialLruCV6tUIYfyMjuoXhaPRePSPttpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fy7Zz3SyNxrjTWm3W0oBXLnMj482orNdCKvkVUL4aVY=;
 b=AO4ZqDr2x6XsHwK4ij46Ag1KuxmVEmz9JshzJ150TNLXRSDHA2CBYh1MvOy5cIdfPMGZu8Fc5K2Cx2JjB7qCtwwv7mQr0bJXQDLPMdRG6SKjjZc7pAQXPozrce/qyqweAFO2zNnZ8eg/9QKMmHOc0ugIh/2qjJisDwYQpmfAP6M=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7741.namprd10.prod.outlook.com (2603:10b6:610:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 02:39:40 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 02:39:40 +0000
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani
 <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: message: fusion: remove redundant pointer hd
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bk9bxxng.fsf@ca-mkp.ca.oracle.com>
References: <20240118122039.2541425-1-colin.i.king@gmail.com>
Date: Tue, 23 Jan 2024 21:39:38 -0500
In-Reply-To: <20240118122039.2541425-1-colin.i.king@gmail.com> (Colin Ian
	King's message of "Thu, 18 Jan 2024 12:20:39 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f95c84-995a-4d2c-201d-08dc1c85b69a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	87K0yAADA2ahFbEaxgTy+jiPgthLdgKIg1ckydTrSSyps5/5oXKIoKOQaHL7KKT5Rm5Mt/RV6NsZ6R+0yt2tr1SjquorzkaFw1WoaTouX5oAB60a38eT56L0eeL/tjLk21YZCoZlRL13sLnnIuRm4UEinsjZeD/LDa7YXU7tsQLtltCxy27b3XSc6xVvVUL4c4jM2oR85rgwXLdX5FDcsQjvCwg3rJc9m8V9QuK4+VrahBQBj21KLfL4bl1s093zV3xFDF8tsdqlKq2TJko1uPYm5JgF9g1BcqxO6OEHZRVwIOnfmKy+099erWDvADb3EIBxqWS06tLIzwg+AXhhzY6xuM2B15/fjJHwdpeqdREpj9irdGRu97CotF5zHGTzYDWYpe5zDWzflmleM/Sl68L5ZnzviQdLd13t6vqqZgRoHTwIFfjOQb/lYyeIOQFSlSjVeDoOVCXTWS6Lig9L8MY47NZ/UfoU0ecz14C5w4sgGZhMJCNAlppytSDfq8TkRLtgiSs/Ds8q9dssdKYsKhE1jsmLiil0c/ocPrCBfRFtz/CubrPgRmyhH7c83hAU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(8936002)(2906002)(8676002)(5660300002)(54906003)(316002)(6916009)(66476007)(66946007)(66556008)(6486002)(478600001)(26005)(6512007)(6506007)(36916002)(4326008)(38100700002)(558084003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?B2GdwRAHEbQiW2x+e115h77kQ3tBPtRDzH2AMvSLn8dTcX4WJAA15J3l5nU5?=
 =?us-ascii?Q?lgh2zbuBcPKIf4y6I3ZjDcIp1V/06CTQKAmUI1mbBhjwYmFUivyI9Y7HVN2N?=
 =?us-ascii?Q?9IMMdRwYOeVBlj8YK6u9IIoOfR04kW7XSJiPSaQk2+ZJtaQTLWWO2FHg3Hvk?=
 =?us-ascii?Q?tL561OOe6408YUQACCfkw5sZMtw8JGzI1vE+j/EqVh0OuWEEGw84InAkM89o?=
 =?us-ascii?Q?/uzy2i/Hj8ZqUdPo66xIIJBzyaL06kupfWrDhOnfyNkSJ5vjXIib5h5XNuXk?=
 =?us-ascii?Q?ELcLyShD5j5HSG/s5DMbk5iN/PIHTxjciijZKcziJ+AQ9v5MlCasgIA/tymh?=
 =?us-ascii?Q?nSAfmRwknMr2rL5DMXcAxtd5qcPhV/jLHSGrT9xhq+HzyeSKUvx/rGD4+dcu?=
 =?us-ascii?Q?RBHpZUf6czJGtnvGlszcg3Y2n29RtF4yNTZ1cYnN76mSQgloowWJRMMQ9f3S?=
 =?us-ascii?Q?Zj4Sob3UYgAaQ9b82M2bwIBJzvLx/GdQIS1dZ7NiVzucatejKZKD7hMJQX2h?=
 =?us-ascii?Q?sSRsZw5YQTBFsAPnAoxL6mgcMdSrjB/U/h5h9pc1Amevo+qzie0c8j8Pcp0T?=
 =?us-ascii?Q?dDr1js5doJs2AqgUiwtgv7B6qc7d9OaEmr2qsy70mrRF6i0TwszR4Z9edKOh?=
 =?us-ascii?Q?FCeX+zErUEw41VEaEkAh6CHQhxTfkCCrTcwReXABvEpYvOJ2uMYmgq/beVxd?=
 =?us-ascii?Q?7ZAXPosKqLKxwkGpZgVEcIozx+FoGKwqE+Kw/vMKhk8x1zyC7gOR2hAOmImx?=
 =?us-ascii?Q?jQW80meNjm2ddWA8PN/2aYXkxo3MlRfLIWxqK9aZwmJjeiEpjayrxgXFY4SU?=
 =?us-ascii?Q?Lpwnn4GtRf/fjiNNIeTI/crGkT6ss7U1AMcfkjwbxUFQMrVrYiSF4zEJnHte?=
 =?us-ascii?Q?8mX7bZksQk8XdKgyPaYQXoXpyzp28VyaCQhq8HtGTvZxhWAh8zG3tA1jmuwy?=
 =?us-ascii?Q?rLuBQ4jRse2pj3sfa2zOn52qdXmmLnHVicoyzBfy8aM7/UUnkL+vlMjsji7C?=
 =?us-ascii?Q?X4jiU+hoHNpwVguMfn9T2IiPzufqw602zDbWtqMSAYHCwMCwjR0Zbil5h0uL?=
 =?us-ascii?Q?eBt8QnV/0gw9SpFmNZqUMqUPc3GW6vl8hMKlyDVBATRv/nouRPwn0QxXlagY?=
 =?us-ascii?Q?gRrI+UbL6gcP17VxdWL9yOaY1kLuKmzDLZcH1ALFKcliZgqtBrsJm3jS566H?=
 =?us-ascii?Q?0RhsBdrdqf6maM0VsGNau310yDLs7sIyHPxR+rpAUMOBwtvJjgBLpcnh/deM?=
 =?us-ascii?Q?SxdGF41/5y/KUzR6IiYHDHoDOWZ8Ve55JMILTjrrqUfy7VQmrkEGJcUq8F3u?=
 =?us-ascii?Q?LuNc8YzADieCCo14PQ+qZ/HIgIG07CW8bQ+fH0Yf+uFZUlEe12NYME3kJ9uK?=
 =?us-ascii?Q?TD8Fn22DJImARA3Zm5DnK2TrlPnpbPuxfqm5fcbVy0HA40CP/OAYsU7CBR6C?=
 =?us-ascii?Q?vMagOdZ5qCiNsY9JiIriqy129qolJHtr9Cgl9qpXwXgGAlPA2hqt7UgevD+g?=
 =?us-ascii?Q?ehta/XDwtXEABTztL5Zo17vV6b5cGrnieOzRPNOo9uGMPWWTnT35KzY8FubH?=
 =?us-ascii?Q?ldxRYxnRqoOzgg2+pSv69EXMZbqxVcy0gSkOEkNJz23oh8kfut6dV0MGVjvl?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	p5iiiPVq9eZDBsH4CivdhTqEl71QvAG+BgFlIccMZ90LouS4oLIUjdlpdbrYFq3tzqXQSVRXN4DiaFvCenM93IMwvQWuap7Z+X2HYxZIF8fNdAgIPkAgaxHRO7bfa+b1FgtQK6VfiVig8290AjICDAo6Md+sRm/knDf7epqvaMICcflIuQMU4leZkgtRT4eeoP0SyUAKBAzQopONFB2AyehLBluo8bKBQXcqcskVWAVGA+vuiDQaeFthi9jkCYDKDOwLkuXh8GbURU1jCx7IH7Xku0Df1X2p69lCop2F88kX2osgBKDcUhaARJdoYY8DnOaQtYfC/wUv8VKg+PQ3rvGGFjc7tHrd0tLTIlYv4nKh6jPL4KnFb7DLfI7hKr82eWRytK7bkmCjpOJPLFubbqCoXzmtYSszreuNDl5I9xXejDoGB1keuqv/odjB5HiAMWEh4fPCli+E/kd5sX1di1+IgFOx1tI41lyxWcTUPLhYde9KgKEhmqLrOcTF01cMjflGawsYBpqtslgxAnOeiKcpWOmd7RPptNQJ9zbZkq2c4XOtWdnbQjQHqVcasEJlHJYtaFeiH4YqMOmSOAZ1h8wFoVQgaZWz6OgTgZKHP7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f95c84-995a-4d2c-201d-08dc1c85b69a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 02:39:40.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UAdopHKt0XYQbrlWy4KYv3BroDt8IkgJdDXQLsXjfjEzeQvspUynGS/7fT1unb32jRoZvxoitVurMKkV3xJkyzzmBf+OIuu/NnBTQrRMJqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=985 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240018
X-Proofpoint-ORIG-GUID: VIeUJEecwmxhkuebiQhrOmw4OmqPqs8x
X-Proofpoint-GUID: VIeUJEecwmxhkuebiQhrOmw4OmqPqs8x


Colin,

> The pointer hd is being assigned a value that is not being read later.
> The variable is redundant and can be removed.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

