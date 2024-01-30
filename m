Return-Path: <linux-kernel+bounces-43730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0904D841870
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717EF1F26465
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8657D1E4A7;
	Tue, 30 Jan 2024 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gH/CbbgM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FdTON8Rs"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F7036113;
	Tue, 30 Jan 2024 01:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578672; cv=fail; b=MyhcCS9qztQhVq0OEVPJsMgOfPV993PNLXqvZ/NkB0SSRTJR9U98AawbIU/wOqusxkXm2RXRvIQQczcEmMVNYHilgeMkjZEwS7ZUUt7CIf8B4WTHOs3YFD79nOR1DQBUN2iihmnHY/r2qNpx1AcSKL98av50c7IhZi9sN1m5ZhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578672; c=relaxed/simple;
	bh=6I9Ijcp7uKqd6zGGjWEP1tYh4AY9Ks3FKGA5GEXe6Sw=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=HTBrV0vkdBfi3VIdqyBuSS611vaygga7wl1uLP4hui+LLsGZmWfVu2vbRNwkwIXbumdKkqwr+gMgEPdlnjKee1zNwjZbzqlNxjTQv/APk06n1boUfNtmeoiKK0h4DF1v7PmkchzprHJj9Wi69HjJOyV1dX0IR9M4cWHOsd/grYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gH/CbbgM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FdTON8Rs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJi2jd029706;
	Tue, 30 Jan 2024 01:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=HW0sJAYhnOyakWQtZAWw8b4BYzq3P40HEImqolmiDGY=;
 b=gH/CbbgMirqi3/D3Y4Z3QfOpzDUAGZY0ABT0+l5k5/OlRSiHvcZ/Eq4x6Nk86hvw7dwI
 Jzn1A1UFLgx73ON00UNhi3UyDbdxJcDhsgsQ0SiDQLRcl6Qx2CbW0oS1WHa6V70/iyPf
 xjQle1WcE0pjlhcmVce10OE7Vgdj+KjT129kLUkOfEn4cQkEJzl6+0YuSLKMW8IA8QYw
 KRssMIUVLrnAsxjTteSLauhXE2PUzJKhOcB7aog0IQnaiErCUzJ+mm+4ZxOq4ul9qDV9
 b4B6GD8KhF4meck0ewU4R3/EEu0aH9LwSv0GndwIodaX5hCKdRVjpvFp5B2ZOIGBeD68 NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8edbkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 01:35:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40U1C3uD031537;
	Tue, 30 Jan 2024 01:35:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96pvrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 01:35:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIl67nYN0ixK7tAkNgNpqnttLgmMSW2+XCO3HQdhJTe/k++sMQTvBwPB9EtRHYRgpwVxVsoVZUx6uimBNc29BMA83eCMe+T34SPlaS6sDShNeMRjtUnSrfxYvf7+jKZS0izd+8PuoiOvZakJICGe+Kpi4gGh12UIZjrKEVsEU43mxwUaczq8If1LJDcgHS7CMLgRUQF1NKb9jtA0WgMv1cxiqP1zapvp8jRfOfDumdr33kMMDrJiL6LPtR4MkUf4RHGcziqucGdCh8qac4yRI22LQkiYzAfXECVRgNFPlv7LVuZMlIrpqWuClAJKEFfxpb+IT2hQ7emuzACJnbeIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW0sJAYhnOyakWQtZAWw8b4BYzq3P40HEImqolmiDGY=;
 b=VO7wlpqt1iMjTuvpqy5Nr4eenxeIr8JblFwWb3UVOGoyZVSZ1b3uk1T/hR/r0mT2H1yN6VehuekcqG4HtWgbkZcAu+rcU2xopVQ69FOBEjS/YA97mueDANpGWsBcVFbvTnEkEarRh502gbsKWUdjFrhZ7C5HoQ7aK4bFq78Ns4ipq4zTl+X9kaSXZlj259K5/RV8niK1vRKrD5FNOh88jZXV4h+fFDjnuAavRu4bfWh1P0cRU0Mm/7aDNHD5xBs8X492VnxyNLWE8PUUY66TH5TUgAtugTE91g1RSRq/2IuuMeN2FEzgagsAgKUAbJuKYuDTO2p3etmXoUmNokM2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW0sJAYhnOyakWQtZAWw8b4BYzq3P40HEImqolmiDGY=;
 b=FdTON8RszmbsGFu7fEmE7XblR8fc50ccYWccCISKTy8S/kCOB0vPzy/jHWiplbnnfvecKHU7Z8n7+v6Zu6NgyhYNzbUxX7O1vW0xDinen3xFRKg+EzkV9C8JuJ3xb4uNTH5zA7zxL5blrzBmIZPShYI/jiTOz6o71Y36OrfeIrs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB6437.namprd10.prod.outlook.com (2603:10b6:303:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 01:35:29 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 01:35:29 +0000
To: Lee Jones <lee@kernel.org>
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Adam Radford
 <aradford@gmail.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Andre Hedrick <andre@suse.com>, de Melo <acme@conectiva.com.br>,
        Joel
 Jacobson <linux@3ware.com>,
        "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>,
        Richard Hirst <rhirst@linuxcare.com>
Subject: Re: [PATCH 0/5] scsi: Replace {v}snprintf() variants with safer
 alternatives
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1le87txgx.fsf@ca-mkp.ca.oracle.com>
References: <20240111131732.1815560-1-lee@kernel.org>
Date: Mon, 29 Jan 2024 20:35:28 -0500
In-Reply-To: <20240111131732.1815560-1-lee@kernel.org> (Lee Jones's message of
	"Thu, 11 Jan 2024 13:17:21 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0122.namprd02.prod.outlook.com
 (2603:10b6:208:35::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: ebad27ec-0a90-432f-866e-08dc2133be1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	axxjJP6ru6l7P7Tk4ujUJT/60d/a20nK+HsrCKdxfP8s3AZBRgYMA7Og3nul45YyOUukjgPIaIh1HyxVUgV0Y++4uqz2QF1K8j4/2LUmyO8xtLYbpTyoYiXsOONLbX/SDfahMIk/rPQi6GWAGA7HlbfoGdnmXspsBKmda+6w4xg6upf/9TRpypzmzPT7QgY9Yo1oGGj6rS/5wQGkmXrs6yZHd0767VVX6su+1yP6njyM86lI+nfxOdI1dRm+k4q3oVNW1K9L39nc8fLkk49bASUOFbeHfYXbIPkL+ctDJkAWIFh9FF4l8a4cNdK1crS/TZbW/xz9ZJVSp74Eaqe+EYY0gJRGqBjh6r1O1goI8EFd1sjtgymd1JmBli8AiiCX0H/sRs/txsGyKVOQqvlWK0IFc20xjZIYYDDKYjMJR4RagTWjJMmvppk0njbgRhILjysAQsdLyMdkEMCZWNO0O9ryS1wTbdmgc07miLnVj7HJWp8qyueMHXGO6G+JingfjS4rcMd5uu7bivfsZjtyrWynhha5BPVNyK7FrTFjYCTtGbEq0np84q2Bgw5VHMyQ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(558084003)(38100700002)(41300700001)(6486002)(478600001)(316002)(8676002)(26005)(66556008)(8936002)(66476007)(54906003)(66946007)(5660300002)(7416002)(36916002)(4326008)(6512007)(2906002)(6506007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2a937Gjt5bniYlLHigyQW8E6a87wpdhPvkXkJ5TfZVbN03K1eV7N5aMGokP+?=
 =?us-ascii?Q?/xomKicbecqRb8GA05/DeomBnb+KZIh+UxF6ux3X78B4ygbus8AATyPnzCvG?=
 =?us-ascii?Q?bowYklxY4KecVP3hr8if8VD+D7aS3gPVx4OEdjvEwvJZvf4KpzHM1J44RWqL?=
 =?us-ascii?Q?WNQYUz0Znm1ePbrY5yBkdqQdog1sBpfYABt239dCRj6pkbCUb/DDs1jZ10Ho?=
 =?us-ascii?Q?WTACPdxpZGE6nhzMI13qH2NJd6FbUbHUo6ytfdeVYsTSMOWud/MKf3odjM9t?=
 =?us-ascii?Q?Ys7ghhvoJHRaI/oaJe9uGgQRKM0WQ8R1B0uUfOWpkD+h+htVVzkjYaJoLLO1?=
 =?us-ascii?Q?a0KZbS1VTXHc/wsXxdItEHUx4hEBvi2P7nz2OKIDoP+8DDGnXQMPrKX9B0ia?=
 =?us-ascii?Q?vLjadsvnHTYhKRZLXkDt4IFkIv6NK4Jw8MzXQR546Xas3KxV358v6AR5mdBP?=
 =?us-ascii?Q?8NdD9LGBA/l6MiKxf0vOTiZ+B/VlTuKucIkcwQhdXM1woLM1KmVHwd9EsZTI?=
 =?us-ascii?Q?zeCwgxMBJ37/SGbAUkZjvu4r4DuW/08JRYjWAuUkoeIDn4rYMsyAOwudDBx5?=
 =?us-ascii?Q?GG/LnH6Fk7pEwgAUHIcUJPDFKXQ7SISYtqlfh2fXxYCNkI0FZhE2Bi/F9HxM?=
 =?us-ascii?Q?Ij2EDc/S1Aqu+mAYcCk3l1YDesKZzFviaMtTPGjb0P2BdSnmVH30wIz9/jm/?=
 =?us-ascii?Q?QHpqQg1Y91wY0xRgjrZPXW4YmBkxEN9gdUhqtlN2iNgdUF/LZgt8fooSM/XH?=
 =?us-ascii?Q?vRsCcfMQQwF1agHT6Rn99qCB/nGLZlGoql8X0aOJEII6DM1/D+nfHCeABzsF?=
 =?us-ascii?Q?BFWVwERTYW8Y6VeKDmNGTYnV2dsn/OpjwRxN14eDwBjI+whXppsiSEghMR33?=
 =?us-ascii?Q?JhLLDakl6l/YpXN+Yp0snjh++FCFFkq7QhjiHqJiZqroPMBleKtjnG9s40VX?=
 =?us-ascii?Q?lqRxY4hQCqLpkwA2xnrh6IP98JXAin0pawVN/POs1n2kMFe03yoX2g6VdkfR?=
 =?us-ascii?Q?hPJvZ+VFFZQ9PhBzt0RduUNmJeALajFR4+0z6uO2tGDrb0gHujD0t8RbrvNa?=
 =?us-ascii?Q?ZOrY0CVsbDLqp9jE0OcNmhKBPKV1TTNt6MogvOD6n3GIzs3DXg7gBaxksedX?=
 =?us-ascii?Q?MIl9mI1JrODZ7C5AbHq0Q82AWoj5LdHtOWA82KboUtVTnXwR8ld7HHxbT89z?=
 =?us-ascii?Q?nQoTR3gIxtJV7rkkPmPjFEblG4CKZdfOIemfwilU1lT463RwjQzCpTADVXOY?=
 =?us-ascii?Q?u+wk+T880dq+srFDIKmUGZB/oXk+DhrgCnM5hrx22UF4Jq0aGPpg6t8kkuT6?=
 =?us-ascii?Q?bTa6rlRw0K3T3l2ZPWPvVU7ScltBiw6C9JFh/gUGMUeDExXsrLb9M/b90jEg?=
 =?us-ascii?Q?3OYDq1Pn3VxGR650f4bFz93ga4FEaYq+CuG8pbrNImAZOFSvhA5OOyJlt3DT?=
 =?us-ascii?Q?BaXdwvJZxa9ZtvhAmpl6mPEJcf3SFwCg8N01L9NxWrYXM45UAg/RbZAMYXBW?=
 =?us-ascii?Q?Jhd0ydpfMruYZ/qzQixMqf9oWiwuguix5DbOxWdAwx8CD3Oatjr6doxEc2WB?=
 =?us-ascii?Q?sHqE3qaGP/zlqHLFVUVLZH8HBqqEIFZXgLV04tssIs2FYvf5FkBTy/yYQrEK?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KL9yamacZWQ0P2xmgnF4GbY82FCrHQNhdxsGN3eQVUk60ZuPcklW/ErFdTPrA3GSPdE+y6dgqpJ8GKRYRzdp2fDil+U4f+R8T71lu6ToSbQuvAhTGG3dd0dTlxdz5vB2wvaYJDNO/Yu/8yrXiRnvPq1njnIxFJ5lIZP/OtjX4qYQelkGMMMxFB1NmDUVzH5ptYpyuFvjheFdv7OEqlWnQi1dCnz6910c04Khj+y72p6DVGRkNv7tYSfEmyacwmcMeZo0hjHJhZZdZVSSSfhZCdncV0SV0sDOGpTpLY8ew7Zg1499DVUunRrax9nCd5bsJmyls9VotYMX7v/lB8xYp0bz7x67657lqLWDho1305MMO6jlnO1SsZwXnxKa5H0ne3qusC0zg0S5Q1pdjxMprb4f8M36EX9tR373QhiQm+qdBB3eoXJq49WBMcf8FpF47kciksYPeVs/6fTGb4YQrmapclsSXJRFAem09Zn+18BEEpv5ty3h/MkThf+LcepZVZroV3Av5qKqJtAU6F5TT7VZDfb0qo4BtrqbChHyv2GuIRjFteZL7dyXpWYNb0dS7IK1NQK1r38Ph4NTSXt6Bbvd6GXt11cMMhhSmC5Pzrk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebad27ec-0a90-432f-866e-08dc2133be1b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 01:35:29.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKA66f8SXdg0LDPcgqg8822yTXf6V+O7OtKhLE4DrZrQUQr+h99F7gfwY+wyZtuWAHygFfCLsp55v8tlF1CpcUWybT4j0b5okdP1WcaWo30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=867 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300009
X-Proofpoint-ORIG-GUID: JWjDTC34MvUVsTZCn_dlzqhNjiNYbgoX
X-Proofpoint-GUID: JWjDTC34MvUVsTZCn_dlzqhNjiNYbgoX


Lee,

> For a far better description of the problem than I could author, see
> Jon's write-up on LWN [1] and/or Alex's on the Kernel Self Protection
> Project [1].

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

