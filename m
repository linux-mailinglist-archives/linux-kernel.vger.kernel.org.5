Return-Path: <linux-kernel+bounces-29380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80573830D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3BC01F23C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A82524A1E;
	Wed, 17 Jan 2024 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d1BUSw1F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BLnAcw7a"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E54249FE;
	Wed, 17 Jan 2024 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521437; cv=fail; b=U96ySLyezYmZbs8ASbYquQeUME5URUw49uGXkR9Iwb/YEnGRcbfYc3Z+aTSjTmzuU94sGl1Rc4EgZDqmKSbnIzPODigf3UWvIir5N3tFl3IUvHekBcp7/4KALM5SAMxtg1lqJAEK4J6smyPC9DXc54GGhnMbVngqnXQlNKYqI8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521437; c=relaxed/simple;
	bh=LeXJo0m+dHS8QXgQrGNFVo73fFFPbNs/FwJCiB/YLTY=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:To:Cc:Subject:From:Organization:Message-ID:
	 References:Date:In-Reply-To:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=m9nXhhDGiwnFWgDCFmRyBBuEzeQKxNO1cnQXXGtxKHN2Evba2xyJdyICS6V6u/7Ei7sK+tQTMqWsYdHzIXXioG92NqAQl9tG9gGZRFpXWid3ZhLDHOfk0s0P5buASRL9qqqBkuydrHptgdFz9Kk9WRLZOB0jr918ArarhUg1ywo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d1BUSw1F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BLnAcw7a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJcsPA023615;
	Wed, 17 Jan 2024 19:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=TG9Ro+oilu4nW2OFBH9vZNDxaTjqnqbQ6uHS3Ns7f5s=;
 b=d1BUSw1FQZfmS0x7dpog6iIoaZy+ujH5rwgYSs+QHxnnitds8BaIz0X4iRxryg2X8D+J
 Sm9elV07EgyU5ESxNDEPHS10KRoJsT2BgESoXbIreN8Dp/3KoxwDWDNvMAPGjlYdorQc
 g/4tFndrpMN+y6yJEQUOvspzr2E7U0Fj5oYsfCWnW1a4ZcgKxam7bdP/D0TA7iO6eydN
 pAYcOjAcl2kFderrrXpaT17oJyrK4FyEY4GswLo5WUxW8K23cbNVKhgiaVdvCnPiHFb2
 ZjDCwNiqx9BHSidprEsguFH4Lry5w0+L+4hcE7XFvhRtqHZycoonrm2BzZcjvYQWBfhu WQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkqce0fhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 19:57:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HJBJg6009420;
	Wed, 17 Jan 2024 19:57:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyb0eab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 19:57:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy+FBqQRQWctmzLnBS8uZLFtiyHdGvBRsOYd9oh/+iIgOCbeJCMx8IP/XdSAASN2HFEtKH5hBxB8dfd8nSbtCqi767ZMzKAxoo2l/2Z5RyPXrt7Cib6JkDqiUTIdJmRTKOwbtoJ6a8pyAx7/TCNshWWmi0pLDEYPnhEWWF6CdYWppLwd1NrJRISwmVMxSLw3FdHeipNu05VoOz/9PwQKxU2ELJtena4WMeJ3jNCgyUJDOK+3/qQEBsZ+HlbJpJsNWhp6S/itmq8KO83IEEp+t3OK4FzRAlt7PgIB50vG3UIMbgGhChI8toppNHBGksRZBaFsfeVlfzOzwvw7ovJvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TG9Ro+oilu4nW2OFBH9vZNDxaTjqnqbQ6uHS3Ns7f5s=;
 b=T67PJaaL3e86kSZyissXKuYfFbA763nNjKceRJ9uJHImNXZrRsYNLyjkPNMcXeDLJt+7uZekR9jX0WwBlBsiEWllxahd7kGz7OHqh8Cv827YTBCMVDEEI+nEritAYzHJ8oKFA1o1KJSzx+jvNdVZ5P2cCtsYplwL1bAqFFsHA/SanWqXBby2lhAa570459qlbus5rXkW87uyoeIVL3fRP+eLl4WS9YNJsEdpuXY2CG3a6Gz3r6FN+MmcAcetf0rKzfI/OS3IKYp37ZL0jnuR+mqXH2k5IHUbWtwBS+VzX5A/LFzxLS0eA5KYprzl1kz47dukq0Q7ykucsKeUkIxGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TG9Ro+oilu4nW2OFBH9vZNDxaTjqnqbQ6uHS3Ns7f5s=;
 b=BLnAcw7aZ8TysBKqM3wExx2bkaIVjC6vdBsjf/rjyvBWz2hCtueLF5lMsh8SeceGPixMfPSbFngbwxnlct0s2eOQVCngu5OTxTd18IfUaRcUVR0Wny6CNsMnzYFDwTRzWU9tfwms+jGbmRkiOCDsWenYDodRv1d8xX2gRxWdQXA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH2PR10MB4119.namprd10.prod.outlook.com (2603:10b6:610:ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Wed, 17 Jan
 2024 19:57:07 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 19:57:07 +0000
To: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        martin.petersen@oracle.com, mikecyr@linux.ibm.com,
        target-devel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update ibmvscsi_tgt maintainer
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v87r20wj.fsf@ca-mkp.ca.oracle.com>
References: <20240116215509.1155787-1-tyreld@linux.ibm.com>
Date: Wed, 17 Jan 2024 14:57:05 -0500
In-Reply-To: <20240116215509.1155787-1-tyreld@linux.ibm.com> (Tyrel Datwyler's
	message of "Tue, 16 Jan 2024 13:55:09 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH2PR10MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 16cbb6e9-7a86-4809-d7dc-08dc17967c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AnrxB4wXZB4W7xWPNvB5EPEmtxRg22UrKACUhE7WcNNOOWyOEDVT1g54EH5qqtft2Zvi8YOYpYiCVpiji4vxRwcsqE8G8w/eJ1xzLkPLpXMyhuzowzHsL5TBAA4w7NAYxjvfUxIHSm7EwVQ0p9Oa5jf1Jq/iFnR180qC8rk0HNCQshNL4y3M9ExjJWfZUrhTGfHneGQ03nhERGhq4l0ds7OQDlIPV1r3WRIhGt7q2MPydiENSXO++yX+dv2lJaei93RUI+QUSF1o6KDdhjmTfs9OWNU5sBdijikUq7XMnvBH5DP9mZeuT6XNRacFL3Ks/rQeIK6RPZvTg+XjUM6JeiC2EVpIyupFSG2yGr1229MyeQa3W4gHZhQO8XAHiiKJpeke83T2urE0FY44ZysCvlkoEMUx2F3mvuQOgavXuhheL8MU4hPEwvQsDNLyfxnPz++jB3/ddcaKTBayPwJzJZntdyR3xh9CaahhcFnM+s2EVBKANbE4TezAKDXme4fduykw18EMk7+CtNxSPrfLCextIg1KmeVedmU97gjBcZ8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8676002)(8936002)(4744005)(5660300002)(2906002)(4326008)(36916002)(66476007)(6916009)(66946007)(316002)(66556008)(6512007)(6506007)(478600001)(966005)(26005)(41300700001)(38100700002)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rdgSbyrUGGhm2R778RLer7PKUTCt8quCnqOdDZT6xH+GLG+rnPZtlAQMoSJ2?=
 =?us-ascii?Q?N3kcMmMFDANIYjNFbH3NOX35zewE18Ue94bGxWNNbHcRKyZ4SsGvwR6QcL09?=
 =?us-ascii?Q?PH0P/5lw8w3evB4umjltm5P9J3kbhcGFnmYAjuWnm+FDCjwjp7BFyWsPbBCR?=
 =?us-ascii?Q?23PCixpnvlvBh2aaJoHUHvFvwJR+hgdp9ktZsht7yHzKs+CDxMX7mQLQqx8j?=
 =?us-ascii?Q?KrnhHP09qHoI9VsAeiiTNo0PU9kvYyOLBr+iMSt15ezpuMGym69c+3wN9Is8?=
 =?us-ascii?Q?oDTX8rpFwJlZGwYmI87ahxqsmSU/GUQ+pkP5DGQrpPRSkSUwRVldCEjqffgm?=
 =?us-ascii?Q?YWFOPIqb1bJwtRhB1KYibOhXld6Hkj1vkOxkcenPIpikV3s8CxA709Rk3tfV?=
 =?us-ascii?Q?7sg1sRfB8kZd1SaX4Oe741nIrV4Gwckp5auPjhniX80Utx7cyscrUXxV/A5G?=
 =?us-ascii?Q?TfdcOcwJo/QY/Fc/6WN2ItrIGYSKC1hErYW/HLvNJwPzLG49gPB4R7AfUjcL?=
 =?us-ascii?Q?TzX2keF0ocpgHK8Gmwq5zURrBgOpBAHhq/mIBaxpTjeE4PPD2k/MFs5R0k+9?=
 =?us-ascii?Q?5xYJCxWmlpMoQnmNtRbpYNyUAgJq2hJa28nOy4V28W93zgNBKE/mjSASqDtw?=
 =?us-ascii?Q?I49I6QqNl3+ZAwhF5wGgDYnqRU+db9ov6Cnd5bSXbvb1uZVzyMCswskmpvEx?=
 =?us-ascii?Q?lfvmuVutmGxcyoDUO7HdfwG8FziO+lg/JhSHB1CSSm8lEFjJCz+xi34WUwI+?=
 =?us-ascii?Q?7KKDEIDA4amx+jPfFLzHIsDRryYLwrIrq5oXFEw76vCr+f0smhep8u9KTzGx?=
 =?us-ascii?Q?0KP2k4shfCXzJHZtD67e4BDB5a/2OpngisXG1nqODvLe1S2nwcHzXqqKX8g6?=
 =?us-ascii?Q?9Ewo2gMPvXEwyuTJ/v2aKbbZfHYex2ildaA0Z+t7EDKqPVpQgwTt2seCje3K?=
 =?us-ascii?Q?pEsk5p0MTwztcrv6ZGdwK7uJVBxZdziHnJUt90cjVehWdLXJNU7edURaKeAe?=
 =?us-ascii?Q?VaPXfNWBFuwFOeP5l4ygHUf2i8PDr2BURCMwnoepgu9gIE19B9hGuvC1nbaV?=
 =?us-ascii?Q?urfkhOl5H5/bhBkgFD197qQ4rYeJspiyFTb39JSbHmPbQZGsTvOcV/YMqlad?=
 =?us-ascii?Q?7Fa25X4SduZIikVVdidDU8gnQInSbXhe3eCKcBwuLsJirU+c2nt2bTeNGxYi?=
 =?us-ascii?Q?e5OHd34U1u3qvwt95v7+RzGsZ+dyPZjGAIh2WjY6c1203DliEs0+6/AMNqFK?=
 =?us-ascii?Q?u/ji0rIZeoy/BC9JfeWnQFwA1dJJmLSHE0Xos1woWE0nDxC8K4pyfJw/K9h4?=
 =?us-ascii?Q?jpqWd2CJTktPLD1JqGwHpmWBcgt/qRXV7JKscUGxr6uE/7QF+9QfTZEo+rFR?=
 =?us-ascii?Q?/9TD6T1zdV0WexjU3LTPk1KKO2zQwi8W/bhq6FLad0KzJMgGT181/2qiJRUC?=
 =?us-ascii?Q?xwPO86U7pCJ/FGO9IGSIDEahbYR8iuKPY3K/j+4PcFdwWdRT5fMnDwloEjZZ?=
 =?us-ascii?Q?4hbI6lW2dIxcRSv91OxU2KnCWkF+E10it6V6Xk1Yr+8fE2j1hdy/EAi/3wn2?=
 =?us-ascii?Q?DqPHR96Gp7VlkqXLeLp2ndUpv4SfLQI9zboNMS7gqpOPe6UIUncKIdPbODcA?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jSrfCBVgUA5G6OA5ec8SkpCgs0Uct399SgI5hzrgwRGycN7ZVkwQvR2AMDPrzUvt6d/qSyH0oNLKA2KEmpUxtcbjBvOFm1FxEvodo8PEtMa8s7d30+CxWYXU9adaL4ja1Mp8pJap7f913vqJ2Nfnuu2zGX8skIgK5IqzQHLtru2XIBjfqqEhhmRGNmyDeiNp+1099aRLGJg1++MFXzqTwQMzP5eNUOxwyo6Qc2peyWgBQnwGKziTAHUsOmIU9D3NGur2EK8Xon5j1qPhP3dDo7exJsrOz+s8SC1SqO0gEtwT/TC4zQJX+vYgK5B5o9/zQhL7LH4UMgelMzdFmWj8M+dIQkzoUBw2DW2Iwztqeim0ixBjo+n3NtFTnMps7UL61gUPnroPbnVHN80vffCSIG19vtMwwWRkfqWbIq/+RyN3MwNmI8NzMARma8983iWJZWajOkcD1bXFXkF3TRfLwB7IrC/sqfAQ0Wpgxk3dvgThdQ86AbVL4Pb7FDnAelLOnJnyiicnN+eUBTkPk4cTL//XRiVufVXiPdPEH5DSJ2H+OanX3dSHeqeSBZNLF/QpXrCPoGIA+mcZSRR/D1U12DzB3MG/qWT1YP9VPepcsb4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cbb6e9-7a86-4809-d7dc-08dc17967c1c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 19:57:07.6037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sde8K1BTlgtHhJnCTVt1Eyj6iCplN5NsOLhubinB+8ezbQzzBeABSQsfEhKtsK+kqyb7Hb3jYrYHeLBfsSJTk7u9YT0ID4TyIG0Uew/3Q2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4119
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=963
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170145
X-Proofpoint-GUID: yFYT0Z9H3dnZK7zm2VTsciwk6FBQ5qcp
X-Proofpoint-ORIG-GUID: yFYT0Z9H3dnZK7zm2VTsciwk6FBQ5qcp


Tyrel,

> Michael has not been responsible for this code as an IBMer for quite
> sometime. Seeing as the rest of the IBM Virtual SCSI related drivers
> already fall under my purview replace Michael with myself as maintainer.

Applied to 6.8/scsi-staging.

It is now incumbent upon you to review:

https://lore.kernel.org/all/20231212-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v2-1-bdb9a7cd96c8@google.com/T/#u

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

