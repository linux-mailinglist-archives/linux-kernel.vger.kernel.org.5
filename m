Return-Path: <linux-kernel+bounces-54174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2426C84ABD9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5A1B21143
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438B956774;
	Tue,  6 Feb 2024 02:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CYijiKjv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BEtHEZHP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C556755;
	Tue,  6 Feb 2024 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707184848; cv=fail; b=mg7PxQFnkHICzF0ummMv5oouuCsivyPXJX0LxOzP3KVby3siGcLDBa4SBGoIRfQvQozTQdiO8xBxqcBaz5CA/vWTPD719ZdHyhm0dVTTDSnLrXCoVXrLkzSGPb6iQ8Nk/R4d2D4VHfAc6Jaz9TZx4c3qqRuqjRTWlTYxuhUsWZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707184848; c=relaxed/simple;
	bh=QB94hZcavIj2/aDVYqUW+Cv2g0CDvJkIbXcZCmRE0zw=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=JqyvmiDEANYpAWLaGDgL68Yv2K/1X0nRtPIgDWwYz3CgVIEnrH3G2cM5xv5K4epPSaOC8UFeoe1W9jNoyACydHpHObYxxnH0blO8fDRWbNTLved4sU98ydgCis4vwbP+noPrIU5vXzWXHPfM8mupS7e6u9rv93I7Vdb5KrDVR1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CYijiKjv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BEtHEZHP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4161E5xD005835;
	Tue, 6 Feb 2024 02:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ezziOwHWfNXazdvN2wvniVk770jn6gjbKFw/Ik9VsbA=;
 b=CYijiKjvIZGUdYyRMOOb/S5ih+879/T36ERekL7T6uS5zQLFdQKyT3hHdyhWnMC3utIu
 Y5/qMGUBQS/OmvuA3FtVc2rtTRn5hCkLUrg7factv45C7sBCD/XwLCQYwPctkTywciiC
 2DZvsanWXRMouEQqgyrOMzvXfbdAO/WZNs17vebKdK11W63hMvKutvnhnNokuU8HhlRh
 hv849Brw4HUq+TqGK0/9Q1YmLDXUBDFDmFg+XSqPsZXxhtP0c+bL5ikDkcCgeleR13PU
 fM2wixXQgR+xtFbzVmj52diLUX5hs1UZvdQSkWU8PayhzDY6Kcb+LV4ZtVMCoEro7BqG ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c32nkva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 02:00:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4160feod038289;
	Tue, 6 Feb 2024 02:00:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6m5e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 02:00:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxsCdl0AP9xbF6jI7EH+O4qqegXD6NDdgv5SVOPZaYJS626Sp8SvazJnUCHuE3oAmUeuZVgW1gk1b/bcWvxn+V5lfccz+Mz/Nc+1bbgXnyYutYxJFRBr0RbovJMvoWHGCC0cwVWSXFW8l3QIBN0naeXR8zIY3+J/b0RO72L2eod0APNh8ds8x4VepwWq5btkwONCTBTsP5HGQjKaIQnxGtlSQcLNKQzQqR45sTnIN9nZPXOEeMSfpEtcbaMPYqTDzrtJS5I/EKdxfK4y2Xwdzzjes/XvWsC6yP/biFJRZ/+VMvooXRmUlAst5qtCVrdGUIaQgv5Lyh5YYc8Z/ppYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezziOwHWfNXazdvN2wvniVk770jn6gjbKFw/Ik9VsbA=;
 b=XKCFPb+gTfDuldqLnBda2M1kNPLp0XisdSa8GScDpM62DRlVD4caL9aBO6sv+IX3kBEKYYkF0QLOj0xq0kcQKoau3BRz9u+t5PuVXTjzyPcjYsJc8ZoT9itfl4ArmCuFlvbJcnukZdoR+EsJZxV/AGJnP60tSyg+9Nq0/h6MaQv3/mwMO0kPVMKOG240MRrb1h60X6lFHd+Tn6AkWso5W4UlyQkmjr4pYRqVbrlP+qGtFE3fnHLaMRpgsDOg7oRR/exPZe3H/U4XFnJaiGGiY7g83DSear0YuOIEtumUwR2G71L2+szxgZ1wUQzAygA3wyCtubIKeiPQX3oZrmdFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezziOwHWfNXazdvN2wvniVk770jn6gjbKFw/Ik9VsbA=;
 b=BEtHEZHP9pnsSy1Nsyz2DOQ+/Y6E+2l7o+bHvvC1N8ZBUxtmlg7tjgWGx1O44K8aYeF6ELtz3d4L9GAWVrwhSljpes7Sn9OR4Pnkbsrw95zJ1ymUJqwqXuOuK72sIQVN/lA6awwdFe2Xb+Ovr4jbiFxjY7C38za8ogQZQnvYXC0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7406.namprd10.prod.outlook.com (2603:10b6:8:158::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Tue, 6 Feb
 2024 02:00:41 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 02:00:41 +0000
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] scsi: tcm_loop: make tcm_loop_lld_bus const
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7cunygw.fsf@ca-mkp.ca.oracle.com>
References: <20240204-bus_cleanup-target-v1-1-96106936c4ab@marliere.net>
Date: Mon, 05 Feb 2024 21:00:39 -0500
In-Reply-To: <20240204-bus_cleanup-target-v1-1-96106936c4ab@marliere.net>
	(Ricardo B. Marliere's message of "Sun, 04 Feb 2024 17:48:26 -0300")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0050.namprd15.prod.outlook.com
 (2603:10b6:208:237::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fdf225-fc1c-441a-00f9-08dc26b76c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yrIVR7pRQuAcwg7L1h9ThfqPOItVO/2yWvYUgUUnB/+ohF3yb/+Ajmts3CJQHhrN5Yui/pgfdFZ4vgOIXo7BIP74Ys2uKSq2+BPJy3VL7cEYKmbn0/XemUY2GnEjl1Xidf+KqVyuj8cUEB2hmcaczFSaGS7M31yhIGvBnqmiKdwTJGpjAU8Jox3llkf1k0vvLdNVjc0De8NN2Bwo9z/2kongVZL86hHAeu3q2JTuZRlfV9q0eu/tLNnrkRAzbIvZf6jz/aBmBfICQ1RUIsNHuxEG/LmvHjXf9BU+0Ve5UCckMNSNx6gH/QEvyhJnB7zFs5ec9xyk+lB+ogEafD5fwAHKF0rB0a6akoaOREnI3yq/C191bj3r3tTCsgYutTHdafQT/NuXaT5J5ja1tXZfsgTt7uR51T/4L1044kIJo1M08UfdTNoMnzcKP6pXRYiQ4PIsJpiDG9sFPUIpiL/0pEJRRH2Sz408E07EIToLJtvKNH15c6OUks3K57WZ7ylg0BhdFomoPbOVWXbJpWQjSX2d4xZ+Uhv1JszX5Fw+kNqi+d1PBXilU3fAaHX9Nur9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(6486002)(66476007)(66946007)(54906003)(6916009)(36916002)(6512007)(8676002)(478600001)(66556008)(6506007)(4326008)(316002)(8936002)(38100700002)(26005)(86362001)(5660300002)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Qw4ODbv+SQ9JieftoKWD690Ziyf2eSbbwXFI6r+kUTOi2t+qLB5wAlL6sXJU?=
 =?us-ascii?Q?I+Mb0i7dNfJsf0MygPFNnKNRQUuhteigrSfDd93HKTG9unZIrQ7DoBcRLH8l?=
 =?us-ascii?Q?jOs+IQO9FvLeB9sREHfGdzNDr/ne8MGP2qWiSJHTpeCfqRq5YIjM426P90Uw?=
 =?us-ascii?Q?r+Me6raOuQx4Qp2xVbNifCu3oDFEriXCpG+neOLPos6fh/cQANhzxab7bKIG?=
 =?us-ascii?Q?XGdFn+W+I48Rmwc+X46iOOMSkIC4sQ/b4DeOgY69JjzUgvpbZdTXmLIM6wLV?=
 =?us-ascii?Q?wJyZYVkjLRr88fjSIyMyD3wMd2J7Cz6zILf8eJOdITGDufyJkk+e7oasRd6k?=
 =?us-ascii?Q?9XFu/CWWfmsf/UL8Zet4YnT4ctU53Opg4ZSjlbfFrrwB/MtZ0ttkIHzdY8vR?=
 =?us-ascii?Q?2ZFE2cBXfq+p8OKf7FQhGwT9/urPjhEHQdgkfJoM0h7HGFV80nAoQmms6o8j?=
 =?us-ascii?Q?z/rMgfRmu5OaA/94R/GBkng4MGU/zLylZwf0l1MMblUI27+4ZINMhSjzlBt2?=
 =?us-ascii?Q?6qc5hHdIHCRGuH9AOY4LSwqqnvV82SfUX8j0wf9PFkNtJmfdl4n85rD8kwOH?=
 =?us-ascii?Q?kY2TF9Nl2aQVIbq0gjQAGNubhKTNQjbYFmP7swPR/OYqgpfjuhfkVON43h0z?=
 =?us-ascii?Q?yr1k+dZItmH+ZkXchMcBF2V9jk4SxQP29gjzw5eSKnR6ZrHF8uWBfq5CH/MW?=
 =?us-ascii?Q?rzp58bGHiIMNy961PJxuu1LwZH47dLKJtWWbeCIEr9/MP/5dU1PyfVzacmLW?=
 =?us-ascii?Q?0eJyrphUxIP/uX1/afwysTqRaw1zhS9lllK0XQpjGaef+JG0hseKDYRJDxHl?=
 =?us-ascii?Q?Ca5mSgWqVDOjQSre2F+q8m1Mmn6pz7sBkwK+RKKK27WLunKsO6TrZOFc/UX1?=
 =?us-ascii?Q?HmXyPaseyZ1puN7SGqTFkutHa4cVkhv+lH3Jd/zPQ+03qq+yKLcWL+oThMCp?=
 =?us-ascii?Q?4do1Vaqkhm0j9eEiJSDItSEVkSJqzAMIYAMAk8TevFI0BeT2xiC8UhOoja1D?=
 =?us-ascii?Q?nC1eE67WjtgGvGfVg1yCSEbiqUyCKmGQ+r/ZoBVhwyTlfzNmdtTmXmBtenhT?=
 =?us-ascii?Q?A3v1M83izFnRdadOjiuHdDPLrd1caI2uOzC7CAX07lbMKJ1CCm3xZZtAK/cc?=
 =?us-ascii?Q?nQiAJXjU2wTeKq3m2KIDC+LQPARCGI5G4t5ioUkLLtED2l134PD3NWHxiDlv?=
 =?us-ascii?Q?HZ9OU7YVb/07ZsqBnXCZivGYTns/VNRcKyhlDJayzJPiU5LT8FClJGNJ+7yt?=
 =?us-ascii?Q?/0KE+lVbYUyGXBXoy6KLWVE/hdJ+NA41L/o/AbuhqfrkDGbZh0WM1V6AZIto?=
 =?us-ascii?Q?sEtFcmJjgIYmUYHg4N6oRPfQS5MvurfBpYAayxw/Ylc0mx1NiD8ijFkSHATV?=
 =?us-ascii?Q?sEtx1OzlknLKuNH7+JfF2vgHlIsamXIoPeVMXBoLwOK5QfdHRAZOwWIHnBNw?=
 =?us-ascii?Q?O8vOpmPhEjEaY6+BmvrAmiPAIS9hMknFPYMtBJa0/99VZOqocn8WTMW9T9Pf?=
 =?us-ascii?Q?DuDtG1l9vqdw7rIIInhJD4EEVdjpidV++/3w7/P7J0TaBF5afOMmCc2PegAz?=
 =?us-ascii?Q?nuRJXNk8Hr9sdCEP8PkAn81OlyzZrEppJjp6zG7uiXswcR/aqjvLSinjd9cA?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DkVCS+d3np2rQAOqNeSZFZCvmmuOJKbEvw3j3M+n0uXbePt06+SotIFQrLJH6THCrMggRYUElc1nMcNbsxJOzB2Gtls64Nlmzkx1RAm2kPlEI5wkDINoTsW0sajyUYzzw1MLEjQ0qxeNfLuMwoINgKiiowO2JGtEOwOHD7K32ngtScubupGm+Ht3D+Ftbz+EwWThuTZRZPCtK4xL0LKslEkGl3rfGVwjW1Pvb6p3Zn6CcIxShn64juLvLwR+qRXEKBUH0V/K74K9JfGLJKgoYKIirGUNXOcEf9zLv//mVWxK+cO2fmfRqeDNq+4vDUX+CLN5APvkWLhGNMSHUZPuN2hRcBgo1BgjyfLA6IxA/3ZiToKO6GoqMDnwK/kUB9k2YJOKJIoaIEioja8DXuQNo0qG/wIuRmj/RLtiS253/SS+7frevGe/gmO7d+2yr+fXKpN/zGFOYNdK3yi3ix5RVseAw8IDDqEhOqrQdJR+AAGrJSpuK6PS2I0uB827ljuKWX0WfXF+y4lTNBMI4lF/SFFxMNXTmeskBZKW95AJnXKMHdYhSvUgsjwimLdCJ4u0/4sjgLogb2sQQqg7fHJ3zsSumbDxU9sGtGR+T0bNflU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fdf225-fc1c-441a-00f9-08dc26b76c00
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 02:00:41.3538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8P1IAvw/nvrkBjUbVoeZYG8K8uXMAs137o8rUuh6djqx+wV+XdiYd98DXMVWfzpXiHhKmfL/WdouAMd9Bj6soqrSp3ckRk9PglaZc0U1We0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=815 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060012
X-Proofpoint-GUID: 2Jsp9S8z6KNRCR1LrK7nV4WJck0-YNUe
X-Proofpoint-ORIG-GUID: 2Jsp9S8z6KNRCR1LrK7nV4WJck0-YNUe


Ricardo,

> Now that the driver core can properly handle constant struct bus_type,
> move the tcm_loop_lld_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

