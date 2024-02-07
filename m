Return-Path: <linux-kernel+bounces-56633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33C84CD02
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB561C21E1B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C80B76911;
	Wed,  7 Feb 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QgNnSXmT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mB9A1CyV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F407C0AB;
	Wed,  7 Feb 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316833; cv=fail; b=kX4xv8Rm8uE/2CN4pKla6B6n/vzlZTt1unCehUEV9vPYIdecI4685NEJLIieoY8Jn44DRauccUux0b7Vx8lY+PK3ZF3wf3fX580Ka6KL7Fq74hyj4p/bi373V5YkWO/FA7wEtdoOWysZn7DcDEHBRmF5OfLIJTlAsb/ZeG573h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316833; c=relaxed/simple;
	bh=fDg3zKiup8Wc4QgQC15O9dds+ezRi+MdaLcW8t/jBDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z+WVCL7bESV6G9YgW9cLb2R2fFIl1zo9EWa4JBQpIPB9c/1Zy0McJWzUzvFBlijo+KmcL+jR/w5VudlSeEQwwSoEjGSpFRaNbjt5Gnt5ksFi3QTjHWx48NkuOiSnwg5P/uOYmQ/HRsdPbXWp8yxYK0+TMxD6amtfJWfzHqchx1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QgNnSXmT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mB9A1CyV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417DWVZ9015899;
	Wed, 7 Feb 2024 14:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=C2k+tpKTrhgD7BMx20KcuNnKcxnA6AfzSBK3Oj3U4rM=;
 b=QgNnSXmTt8Q4sJfE9l4zuX2Zsn5HLQzJIoxU14/9EH7Nkavt6Jlm88D17EXNJm8VUUfH
 89YYqw8F2mkuWpN0PYRJiq4YWg1E8wZnw+85PG6H/RhqPRntV5TQ/KK5WDcty+wLw6Ds
 pUYNRvJJHbIrgUQJi2GZVrNC8aB7mqnyVdPQxU77pd/eGtdnl+VQo2UE3hSBwAVkvjQ+
 u9Ex+XbXjtKb0HMuLyuVfaxTrVZZWquiKr0q0rMlRCeM/nMT+5bkvke+mitlcqUFITHv
 1XsfTJbI4/t3ELCumP9U+Xioea7NqIYYeL3bfo8LbNgz3u3O1jlnIwW3s2xpC7nRaaZ+ Zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1v9tbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 14:40:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 417E4mYn036822;
	Wed, 7 Feb 2024 14:40:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx939by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 14:40:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/UIeE3C0DpNHJNLyFWgGAksQ74EI8905EdIMcvffOSnkx/CYjgM/asLxV8x8hOfhGWNFcHm+PHyDMRQGq/1uNbDNYkIB4rjL8Zn4PfWmNEzB+FSzn9wObtWCqKYVk+omDok3HZ5EY146q5OZz8L+7KFNGlovz3oNkOfA1AwJ57QOYWtTyYGzNy4vL3soYtem4lK7duXDUVOcx2Wegye8Q0Va92pLPhF+76B5+CNs7fp0PUcPENZSepN742thXGg1QbbxIXcJcMNss0DP4wTsMewbUlDjKwA1AqeAxPLyDys463fRN/dQV3QeV6e9lFuxfKPLZkoBaX8RuuA9bMyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2k+tpKTrhgD7BMx20KcuNnKcxnA6AfzSBK3Oj3U4rM=;
 b=biwLZNsR/w5u+r27SOelbpNdk29Wid+H6yhm2dG1wwjJfZ4byoQQQ6lS0C//ksnO6wD+c+DytEjjABy7Oi29nw/XIgaBCFq+DAsMYpq9DErWwvolEA4EgGse7iC3Qrjlnydxl6bNQqSUyig6m2xJ/akIuyg0syyo6fDWJu8hVLokSVYwDG4AA2xvWHl2kOuuHTZmsvWE9wlXq36axRU6CKmfAqXM1FTTj0Z8QVf/99ScZLNjH/ECO0d07H7iu56f0YxwJGJx58O0GNOXH03dl1us1A0VeDhlV/TS8zE78RixBdrCZyVMe6/isz8Vvn5L+sKUJDP7EwyxTnlr7nMHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2k+tpKTrhgD7BMx20KcuNnKcxnA6AfzSBK3Oj3U4rM=;
 b=mB9A1CyV9GL1BzqPdo0W/NtE2khZQEtKah3YjQjbvANX4ea/ddQtGKtOqywO/+cD7vwrB91DnXzFUdq4jziCH8t9CvHggPmhcZn6ztvO5k2JYRViMeLTF6ZHOZPKVdECfu6KNCw3PbGhmTkgsbJdcz6ySa4jKANhgOslIxHKhIU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7338.namprd10.prod.outlook.com (2603:10b6:930:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 7 Feb
 2024 14:40:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.037; Wed, 7 Feb 2024
 14:40:17 +0000
Date: Wed, 7 Feb 2024 09:40:14 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the nfsd
 tree
Message-ID: <ZcOWTkR+pbQpFwvP@tissot.1015granger.net>
References: <20240207114118.23541d8c@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207114118.23541d8c@canb.auug.org.au>
X-ClientProxiedBy: CH0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:610:b3::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fea709-858e-43f0-e7d5-08dc27eab3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YPDwjG0CLDNgqAUf5t03SmYN3/8OSlJkMIdwnjW1XXz8f5wUglldfQm0eIp5fiEAFAAZbr9NSIJPkuXLLfddR5s0NP1RFitbLKCigSuRixWh9usUZyUkL02od86orwrI5H91T8f8+8LzhqGij+hqoThHksMpYn569fyqjoh7nYLOPzJTNSUKHSNETrKYDlSjMtjgXrNsGJkhwAL7L3oqy3d/Oh/M1H7AiIxO6GBjy9wSDVemBJ18RKcpsExZ/45xTYxWFLQb1Z5GE4op4I+MzINSQ2GnqsBEx3gBFUlsl3GYWg3gE/Bz5nCFtxGzbEFJkWu9cauH0tvWYZi/1EQavBTo8/FGqwCPxB77tBjH6lWTLgATRx6JqoMuMFAPpHAKVyhezhHSeQQBMxhjpzh9j4rsT5NfOl/zG9g9YmkPG7mOyoNsLR2iXlIWNNRqF+BaRVHDnfvF0yuAjhk20qNSpUg2RXwY8/CaTp5gdKtOA/jVMgpBXQmq1u/JZezXhrXLZ186I3kEcqFFGP+0mNH021Ng54UzJiEt3GqXbOMaQ6zFTDveHfBefc9oB9ZNM+ScNT8c7ePSfBjcw21YG5wYI3BkD15PVJBsaNZmQhmZ1lw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(478600001)(6486002)(66946007)(66556008)(110136005)(6506007)(9686003)(6512007)(66476007)(54906003)(6666004)(316002)(8936002)(8676002)(4326008)(38100700002)(26005)(86362001)(83380400001)(5660300002)(44832011)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Mpp07OalTFvGo+DCkd3qPWC2Wn0IdJkJMZpJWidZGvWBo5ezB5zjKHrQ1esi?=
 =?us-ascii?Q?7juewEPpMFDz0NoQ4mX5hN9zZCFiazEZRwosxhvWPs1rKBgEzxkFZ+AToP3y?=
 =?us-ascii?Q?pCrOwrcPIawn9l9bOlhC3URpJ74WN0xAg5icaISq5Pt2T2p1WvVUeOK9j8hj?=
 =?us-ascii?Q?wvI1q/1biJpAjMpNgU113uvtypMptfazbpEdQYNdtH4jKgC2xQ8vfwmHNkTJ?=
 =?us-ascii?Q?ddLMV5auDghh4bNkM+RA2x55MN/lI4GMLWF8G7CJnJULkm+IgWoaRUk5GBQ6?=
 =?us-ascii?Q?Xk5vVJwKD2WyXZY+EN7xyrurGRzZeYNdAvFxcA10ffBzuhRHS3mucAvAvXf+?=
 =?us-ascii?Q?+4Z7EcY1serlYgsVlJaEfmx8/6m/RVwEypULOwCNLymiNvrX0dAh7I3UCfeJ?=
 =?us-ascii?Q?Z5SzN8O8nrKM37zlv9JaZYYJ5EkL4DXFKMOQfNQ/LtPXCqHl10Kq3SC057rL?=
 =?us-ascii?Q?J8QcvXaTpcty2d3y98iIYW0ODWzNuJTPpIP7o8xakcVLUX0fnZJSKGSLRO4n?=
 =?us-ascii?Q?MWnmuzI18/Msim9jUeN4iI0qok5mUNMebzg//K770cxDrXCGBTxf9gjCOiSP?=
 =?us-ascii?Q?oYuT67wxw1FRoolDn2bu8YIL5P2wD4ZrQdSH506vFKVaKelQKICE5mWDQ1ZQ?=
 =?us-ascii?Q?4CGzUFh9anqX0KY1+ze7h0NuSeYp35s8gXkWxunUOLBJtBHJsTlKcm8tXGgk?=
 =?us-ascii?Q?S+kA2JU/+2IsfiAINf0h9q+rbb66sN3yYuki//kh7cLCpJYH7dPG8rM5zYmn?=
 =?us-ascii?Q?HaTqxI9eg6lFqsq6Tk3v4uFXrY3n87l6qyjiGFDCUtOxujk2liQM2M9AMtXF?=
 =?us-ascii?Q?8iOL/+JrlZsFZa9SwhoViJPOUetKD43FemslafbgwHldmX0xs3M+wIsFtgMh?=
 =?us-ascii?Q?xKyKcRPyTqLo/QWow1Bg/Jb4mw5mwmGqql30YwCxcSzpZa/3VJfMQWFO1hWH?=
 =?us-ascii?Q?b9k4F9tLjq0pB467AsQF+XQrApKBdnffH+6Q8QSx5TbAfrggUmY/zJrowE9D?=
 =?us-ascii?Q?7hOEmME+hzkMmrurxjAqhqx4HDjtO9FbbewSusYnt+kalQw43qXwnhRNH5Je?=
 =?us-ascii?Q?d38IIwHjyFcnQl3PTmPP/T1+hbGREXyMg72/KuKiIRqyhQa7ALUmcXfIVznm?=
 =?us-ascii?Q?1Kzqg1eAstUJgWvTLsLTPyLOb3f4fxU4RNIOT9LtWSDt71+M4Q07G8tw65ow?=
 =?us-ascii?Q?Y2jObbfIpcXva2C/12Be78uqn1xu2rRaaQ7w4rJZDiKCDmZIUd8KzvK9FQ+J?=
 =?us-ascii?Q?HaMjrvMxoJfLD4FBHQKmpSZBC6+A09f5KJsBrZgF0njaRHrFgxRIw79Z6Edg?=
 =?us-ascii?Q?YiigAGXeGDJzLDwUHQwnQYMklA+TEz1m6LArt2Ra0qLI5sOSyhEOXktaOOO2?=
 =?us-ascii?Q?9v/PSZmzBdK6pEs8KwQ5JDWOp37k5+AkMv1JKYgrkL6iciKYZQtD8QsKVIHy?=
 =?us-ascii?Q?RZDOuV08mhLqE9s4DHrq9g+Agan/6KtF6MvKdf9QK4D/0ItDfos4zHVxeTOG?=
 =?us-ascii?Q?cAfRX73Wp2Nbea1BXCEgs5DKCuly8aJ1v/68P63acXhAlj22XO4UvVhDOxCf?=
 =?us-ascii?Q?OeHmT/lazfczaP46zO2L3hioFM1jpt9yY7J+0fiSJol+qXDLRot+YOhe1Vam?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/iYGsZnD2RN6FtiIElwszXxun9BunzvXTdy8+5MkKh8zUe0ArEn/2j0Jekyk8lIZ0ACMQt/sUmPMcobzpyo1UBdJYLEnHy8PFzpgrytZzhOIEcyLeqWZFmWjj+wdWXiZR71o8uLHzJCsj1eDkjw7DcWVvgjFATgpJreNdyIa4cztwUjwDsKPpkrMO9tAlXETWeIgMC+/Idpv8HIfwVoI3SaehiWqjaJ4Lpu4I/Ji4kkqRKcylfTmUsvjhZduG0IQISyn1Sx6kFjX1UwHx7kSJClHvVphA8OrjNAY7jJT914hxC4ovlCVdy2pF/HoqZDONHMOqqV/XdfbTm+vB7UA4SkVV2jx3zQcWneEijc1dljbHgqPuaGR+CCKuKVMKXMyXG3N5vXDOR/441jJ5RGOBPTez0LcouFlRaA/KHPDxPdHHTfhKrYhx4WJf831XGKQWwHs7ylpktrKHaHzFkSEMORBeL10CC2m19mKt3kPZlX9otiTkXnVowAPTnrarkImItZl0FBdjSAJuGsStDsqvyU9Gxwgse/+0C5ya8kOAVEfIXXAhXZE4hxluDcjfn5JvcZBqUeodylqrXEJTJnVqv71mct4hWSdONrwUfFqFMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fea709-858e-43f0-e7d5-08dc27eab3ee
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 14:40:17.5796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPEe/CWICwlq+AFtuwHtvZfA3Gz+9RbzYL0zZH91BQNRTYMxe7K2OEylCmjN5NYHvTrpKAQFJB+c1EkLO8xspA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070109
X-Proofpoint-GUID: 2Hly1gjroMQ2L0en_8piuWMSYntnwjON
X-Proofpoint-ORIG-GUID: 2Hly1gjroMQ2L0en_8piuWMSYntnwjON

On Wed, Feb 07, 2024 at 11:41:18AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
> 
>   fs/nfsd/nfs4layouts.c
> 
> between commit:
> 
>   b1f1961080c4 ("nfsd: allow layout state to be admin-revoked.")
> 
> from the nfsd tree and commit:
> 
>   7b8001013d72 ("filelock: don't do security checks on nfsd setlease calls")
> 
> from the vfs-brauner tree.

Christian, Jeff -

For the remaining duration of v6.9 development, should I rebase
nfsd-next on vfs-brauner ?


> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc fs/nfsd/nfs4layouts.c
> index b1e585c1d9a3,4c0d00bdfbb1..4f3072b5979a
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@@ -152,23 -152,6 +152,23 @@@ void nfsd4_setup_layout_type(struct svc
>   #endif
>   }
>   
>  +void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
>  +{
>  +	struct nfsd_file *fl;
>  +
>  +	spin_lock(&ls->ls_stid.sc_file->fi_lock);
>  +	fl = ls->ls_file;
>  +	ls->ls_file = NULL;
>  +	spin_unlock(&ls->ls_stid.sc_file->fi_lock);
>  +
>  +	if (fl) {
>  +		if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
> - 			vfs_setlease(fl->nf_file, F_UNLCK, NULL,
> - 				     (void **)&ls);
> ++			kernel_setlease(fl->nf_file, F_UNLCK, NULL,
> ++					(void **)&ls);
>  +		nfsd_file_put(fl);
>  +	}
>  +}
>  +
>   static void
>   nfsd4_free_layout_stateid(struct nfs4_stid *stid)
>   {



-- 
Chuck Lever

