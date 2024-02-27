Return-Path: <linux-kernel+bounces-82584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CF48686AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E8EB22BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A737F107A9;
	Tue, 27 Feb 2024 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QyDafewn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mqKcPiDA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F0937E;
	Tue, 27 Feb 2024 02:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000260; cv=fail; b=K7cQ3PD9EdsH/t8BsHmDZdU0w+bmP5iwqefXYllLB5zx8gi59VpuynR/8a1J/YI4uOulMQAg+BxUSbRujD2zes374lxs26xGLR144betKHlCyf/JKuR4fCPwbkVM75MQRYE6sF0Ki/tGPPtL1Kfdlu3gD7Obke363H4Q9Wvhe/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000260; c=relaxed/simple;
	bh=nqgfUsR7OxJKB9DTv9N9eSPXQC98fuZXT5IQluq7/7I=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=tUYA+18kSeW1Nwyc200hrOP27fuj0YOu6GacnvTSIdB6Lpx9WwoSKeq1Y26sQG6/Fo7vLqfkMyMBzf8zcRtNP99gZ5gRuEomKW0PlZI1LGPgpzDpyzTOl+OWANo4n6Mn2l3r0dTC1PejsCTWm6/FlxHIyHf5IzqbDBakphIwFng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QyDafewn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mqKcPiDA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R1EAW8002950;
	Tue, 27 Feb 2024 02:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=GxDwf5z3ZYV/YAK5dbOmk1wVbXP/UdwQJTcGnGUWIoM=;
 b=QyDafewn2efyuuHH1wMnLPryQrVBfBE7G6yii71YWevWQ+SxHbKeIvkv28mhpXmTzFlT
 ke2cakzqQPYEuvoph7Wu2ZtFM1x2rSgSBGzTDR04ZU+CNaEZA4MPcdH9k/pU0GxVIYup
 48NUoi9ptMm8vg+eD4YJTQ3d6ZXfXDEfuledGZXq1OiJQWoPKteC7vRvDrM7jhIZ/7/y
 vInxqAqKH0lrZTnRTSrMAjh21nk5Xl/pCnvS6QPrJIj46jHgfYT2X0IZ0KGojvYGSY/r
 fWCWYp2qZYAXfk7xWed5kJcrcs3AEQmzoIXCV4aZjmKrwPwXPyF8zjZjiWKwiM7kd0h1 DA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bb5vq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 02:17:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41R0NQvl009760;
	Tue, 27 Feb 2024 02:17:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w6fw6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 02:17:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAorzX/u2HjkcJ4oZYAl6bZq/u14nkBmqWkZpxlPxAbCGBB0xfeitGs3B7s/6PhM/ROhElPHjineY1AANDQXYsakydgijvAt+BR1qjQwI6ZLwJfMAdOs8XrG3Yq0q/s84jC8awRbjfKFGe3n043111cB5SieX63nHc+1Jby/RrxHQxlYB834R7JOfCoYtnFZNeRa/SD4dbSbSvR27JoVMgSUWRqzkyM2d6JsBAIY5TP22HAHcQ027sUsceD6iJryVxPgwYsLmPh1EXAi2lGlaKIxUEtPTSz3QtxG8fiVAKxODTG4wTj8QG+mnJZxGxsIDIk86Skcyqarx2ao2aL8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxDwf5z3ZYV/YAK5dbOmk1wVbXP/UdwQJTcGnGUWIoM=;
 b=NqYgEtCIpBi0VJ7HQgmdnEUOT47DGM30WtorIllHewf8+GSgz7Bktomd3oc0n3Ljl8tndzRSRErF/oK8k/16JQzpg1fCMEPaVfCrC3/eVhvOpipPvSAOTbks62+29kXWROWkkJz71OTqjFwmoUqaYI2yrrDHwhWVHXX9GioHtWoar6O+9aE76wSnLJJCEj1AvmMFM2n6dk/nSp237sFmQfJgxg6QZw+O4J3FruNi0CLA2Odbwu4qaQJfh86Yz+VVmkm4NIQiFn3q/8rpzyduHmLg5JsfqT5JHcRISqF+lcbuxik/7xMX4+qJwLeMvi421Irk+/hdxV6mTYhfYE+weA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxDwf5z3ZYV/YAK5dbOmk1wVbXP/UdwQJTcGnGUWIoM=;
 b=mqKcPiDAVywHHxTXQTVCEGrpmoAIn5X8AWPqmeOopoXEY1QYTVi3vmRrFSlajQJLLlQNubvGM+0IsWvpQpo5u4e6qTBkPqS4eJpmNHhBt3eKEzNBh0Er+mFdSJ4g2vhxuJI7xsFwOtpMdMs7oTRxw45rdZ9M2WF+iLO8MFC9HGE=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 02:17:10 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::e542:e35:9ec8:7640]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::e542:e35:9ec8:7640%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 02:17:10 +0000
To: Arnd Bergmann <arnd@kernel.org>
Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru
 <sudarsana.kalluru@qlogic.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook
 <keescook@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers
 <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin
 Stitt <justinstitt@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        James Bottomley
 <JBottomley@Parallels.com>,
        Krishna Gudipati <kgudipat@brocade.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] [v2] scsi: bfa: fix function pointer type mismatch
 for hcb_qe->cbfn
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bk826484.fsf@ca-mkp.ca.oracle.com>
References: <20240222124433.2046570-1-arnd@kernel.org>
Date: Mon, 26 Feb 2024 21:17:08 -0500
In-Reply-To: <20240222124433.2046570-1-arnd@kernel.org> (Arnd Bergmann's
	message of "Thu, 22 Feb 2024 13:44:06 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|BY5PR10MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: ce897f0b-70fe-4c9a-e9a7-08dc373a3453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JlcCPTmrCHMs/8TKEIwtGXbSWlKoe72Hi7p1xf9RMnfT7yC1e+9+VCNagcriHUTKYfYLjfQsK1snANKmxsznXtYLGc4iVd/dm1PRCt4iYA8zKH/rqLK98Ie+rAJhMprfuyh7Sl0HoeXm0RBmBva5XNjptgEg9pzPbA13YEBjCjajx5z2KidkEIISu9YHTGjtnBn7Ip41GGamrG6adKdqcYPzKUZRkVv7/PGz9UBt7gEGr+9gR2vOr+cEPOUMXhyoxsKDyI9LH+iHFJNQ1/BZFKGWbfyJutpCchmfV7JXbY48mnBNxLm6NUjVCgPzpk2obQunw79Z+07UiqTDSxtd3MoVP8V7Uvd+ztM06AUd1gmreqtzxnsRqAPhtLV2JbfLkZBy6mg5irG4UKhPQTMAaHrGQN/V9XFd1SJGw+GsAa9HI2FNwBKCJ/j5/kPpS/i2vUoJBzdAODgOTAttPBg9OqoTELhANdNmfWJqAdmaqV/nUwD6wEPZFfvy89DJ1Q2eSrQkmEaBKQfahYXw3f+L81ABJsg57rugYXUoNMw7CPqOdhFphU1PlPr5ilb7CALX1ubEpQhSxn0V1A724XRMM/IOL4TYgx/+1KlEdBJ15K0BlMCuw6pdZ1I0NgMCOhfE
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+HjCRWdZ5LsVwirkI62JNItiRB8DXpTUEskRJjXEnq4G9hbgUq7QUDZQ8YLm?=
 =?us-ascii?Q?TM/8s8ERgiAhYM8gn3QcuPacaxY6XQ+L6ZcjCK98QY41Ru6bOTxHvlpxMsS9?=
 =?us-ascii?Q?PHkpHXh10iGShpnXVdnGSi/52NIWAILVF7KV6u2QEY9Cj4bPuqCuMjTnGftg?=
 =?us-ascii?Q?tNfgkigzcMoHBjU33iLYntkAJlT8K+7N310bcwVH/oYGqV/lCtZ/ZdGfrozp?=
 =?us-ascii?Q?GvDNq5SRtb6lwf7Qevu2Hr/0LSnWMR1YDeX4xRUTaC+4r8oxy479RM6B0TDU?=
 =?us-ascii?Q?FNgjK9+bwsvGeCMr94LmR57jWXUEfFqwMHtJj8cSaAkzEcZqa7npZaon2wXe?=
 =?us-ascii?Q?fd2uFxjvurhEhM/38ngbzWsZy74HYz9XGq1V00o5h7X2syratE7ax2BZz/mp?=
 =?us-ascii?Q?S7wlCUdsXoZ/NmXaz31fyOkoxgJ0SLaGQzA+KSopY5PJCQ7Tvq9PKGrzcA4D?=
 =?us-ascii?Q?rMR9cjd/inKDZrGaIx9zao1vHPqEtd1QR3Uayysj5L9qHvoqGkEk+zq+vnuP?=
 =?us-ascii?Q?qsm2xDoL09wVdcNHViXa+Ix44OiPWAlBO45QteikUFNlChHA6nbjGwN0MNdU?=
 =?us-ascii?Q?umWOftEBqYa63AwOXI1Ff12G83hTyl2VvSLzGYM9KILIoZqyBfeqvVYW3IWX?=
 =?us-ascii?Q?4vwcPDctR++nrRxyc3sPi/7gwpR9Ma+zNzico0E8s8oPOITs1f9OSpnZ6mV0?=
 =?us-ascii?Q?u1sbZFLoqOUqkJ1n8yQoLi6G25GsAtUY4FhsfsYLxDka6nX9sIw8HgVi7f9x?=
 =?us-ascii?Q?InpTK5OW8+voArQsSTatRHh8olL5/8Zn1WPbY04fIg/X9YTqrk0DG5LIx3Pj?=
 =?us-ascii?Q?Ru/wiwbeSIUHBBasRgAQGqHzGl7XFJNImsIv5a/iFlUK0a5Doxz+rUD5GUBd?=
 =?us-ascii?Q?RCILnsZpeqsKbd1vOH+W8OipdbpN84kfGfxtCpKgBC/iawYzAAbEmtKnUnC3?=
 =?us-ascii?Q?Y6c+mUEqi1Mp9JVRomUrq/xq1hdWxVoS8sGCfqpV2pTUu+njfCcfP/1uBLMm?=
 =?us-ascii?Q?2wFdNLOxRCslR03J4AVRO30lKjrFCE1A7pbuqalfpJUfNL6yuSsQCjvbEcRl?=
 =?us-ascii?Q?vORLFXFM7Nf2rACJePUD9l29zBbuKGNe0Fb+F7TtyTS94pKFik4PXbToxHWB?=
 =?us-ascii?Q?nTdfIh61sXJZRXtiblNB6KhUiCWssMJQ7JRv8y1kDDtVOB0J85xbgAri1VTC?=
 =?us-ascii?Q?A2TCMv7N7v65fjmYcIieZ/WGoLzf9f37pTicrKDrc27EUd5yr9H8C2pDBMLZ?=
 =?us-ascii?Q?63REkUNRxfVhTusCdRKrnhS/6QcAWN+IpDL/tVuxBihwc7k3LBAq9B05tgCl?=
 =?us-ascii?Q?9xFAYJ5AOdkMG6+6IMBnbYpa3kyyf/Mfn81qKedRon/eXERFvkLQ7XjBQWdW?=
 =?us-ascii?Q?EjPPf+L2kLXGzqZaWxMY1Z/VKOYbgxJe69ip8eUBbIW7RZLI+/55GzhZqo2d?=
 =?us-ascii?Q?38byu/I+yEYef3lrtnzCwET6q1BbHUEslrw2XN0lFp0nPGG38T2fCnINW8pi?=
 =?us-ascii?Q?1Iq/D2MeZbxXxJl2V2hvjBicw7H64A17T+ncqfTzkgHXwmN1O9d0fBKxm9TR?=
 =?us-ascii?Q?bByfMvrqd5bHHX/epbaO7y5py30WB71wBuOlM+LXVrDad3BF98nD1/ixlJjg?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MVummtrd6OF1ih7BSBKYZAS3pgCQJvX/OWJwOEkAS7RdeiNveQikwvMahQCjn/8zDB+0fc9EdGgBa1jDoSnh02QQzLukHYj/gVhXri36hvps/MlKI3h1kIhwLmg2KlPRH+pyZMgpCNQgZPccU9yuafWgLukac+xwYa7ot0XLYvXtpqucerJhzU7ei0DMOvOdVHHPheiHyzE4YNktyO+xuzTljl6AQXd/oHPvWnWY6niA6uN/kybU4q7O07MXRQBAEvDxkol9+uvGrRc1bd13kCTulRVhp2oXXO9+UCconEVwHijLmzAMtdBYyf8luqjFN4XC9HiA6tLx+eIguIiA5Oy3O6CysJryQ0VTIYPb6ncVbroRs3319oM2uheX2t74Of70L0rpDkUubPh/iS9V2ALUlooAeEVduZYaFhKCi4S76K/w7X9ZgsJ+asoAri/6Ml58LQWEcYkpp7cZrtKIOCtXpnde2Fzk+KabZ+MpB/V1wu349DB439W7wf5z5JHgCWCebLbFezrTQuu3UMwdZuS+BMI06I0vNAYUdGQGMTOud7szaAPGfJO7V2by8XQpAKcqiqx630O6RGcg6ZaL8+fLeuOEVO6ez1zdfZZi+W4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce897f0b-70fe-4c9a-e9a7-08dc373a3453
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 02:17:10.6048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrAjWOLThMHIwTMvmLUOF5ggr+Q5APHT2ncBvbDslqQJZ7ZyZTuQ8YYeeoGmMdx9CU8iPPdsdoArm+yca731/pY4aiPKBNbJOq9WzdkGNkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270017
X-Proofpoint-GUID: 2QYopMxs7sQXwKyKLS-twnW_-YmiBSBx
X-Proofpoint-ORIG-GUID: 2QYopMxs7sQXwKyKLS-twnW_-YmiBSBx


Arnd,

> Some callback functions used here take a boolean argument, others take
> a status argument. This breaks KCFI type checking, so clang now warns
> about the function pointer cast:

Applied 1+2 to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

