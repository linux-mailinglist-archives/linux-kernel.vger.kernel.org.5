Return-Path: <linux-kernel+bounces-83389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9711686979E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091EC1F26BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F21F13DBBC;
	Tue, 27 Feb 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BDr7qqKP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JmUTdN1L"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D313B2B8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043798; cv=fail; b=sbA7Qt6Yw0EN9kZBmXnjM8g/S91fS72Fu0FJDoX5E8jX9UexUBVYmTpyhTl31ITqojVUNB4ljZ6SwAnwdoJAhXBPqJlWzo7kGJhW6HYGwCmGTtwdQOtPF/EHeU3rAfpMtCe0M7OF7VWu+BkwDXBIRjR270N9nf7znm4boNxncuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043798; c=relaxed/simple;
	bh=QOHSZ0IAdvzXqvoHi1diPt6meKSv5zI65NatFQ1zLVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ax8AznbEbsuVeyc/tZeIXLiJI1FE2la/wcsvDbXFcltaCDbYosME6yYkgcdRbU8x+IawTLbPsedDfT5rcO4pPXpb8Z6MZYoGrLvK87gciFvEqED/DBjEElXIwWJiGhhHlYErCGp8/cFqoF7ftB/GxuhxcagaqRJ0tOkpBK32txg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BDr7qqKP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JmUTdN1L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R9JcCv012540;
	Tue, 27 Feb 2024 14:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=sED6zgeh9f0yMzM+aVUHgn2ymYtjpgkDBuocVGUAmWQ=;
 b=BDr7qqKP+0YvXOJGDDAVdnD0ka4JCO8t0aU7fLURh+Xna7QVcbvZCK521WtgGV77x7Wu
 J+3RCbADebQBBKp8yXAGnTeSp3zJIF0Qijib9Eokay7NGGicouoLpN84c7tfWhf7Fc9h
 W1zorfa0Wm1CBu7+1/KHNElymYlwXtjNuDBJnM59DlGe48HzWLFNS4yFzy9x98aclRlE
 MqIfApxmFypPcoLxh9XDn9zP8NdN+OupQ8VTTHVqH0xri4/fjDuNYMXWe6JfkVR7+gMV
 q3yrUZNr5Ejw5HKKNWHOt6mBwfsK+S7Lb76RrC2rjKaTqJpuutRgylZs70t/+yVMU69B tg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bb77rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 14:22:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41RDoFH5022470;
	Tue, 27 Feb 2024 14:22:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w7fa2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 14:22:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZ0RYw2V+3iK8rw8cy8NGy29Wy9JCT81c9gmxTRa3vezL4VsexktOGEebdxDLMbiq2xVnqf0m0JnxeDkeX9XyQjv0PVwlZmWEXcJb+UrdieZAYPgJ4BwR0Jim4HzD26tD4feXX6qpmt1+DKqdgy0mAfJ12ZuMCQhFQ9bH/TuHKlUIkDx6wFNYncjEEUnox2hkdAwvQ+rud7TMKpWSiNeaJxcXARdNfTr2uyY9zUrL4IZThI/ccg9PqUUQ7Z6M9/ZhPFWXulZwTGAWLcHN9dK0HfT58h5eUymOFzovEYksjntqrj0pOT/1fMNtZag/G1+Z32kcKK+tVzI3qexJjNJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sED6zgeh9f0yMzM+aVUHgn2ymYtjpgkDBuocVGUAmWQ=;
 b=P2XlLlmA2bz66/u+OORtpOtmyOfx7dihbOxe3+od0APhJlTVaD5tgDEtntBZS/4l4Inj0w0xP9nYco4RG/lZ3U6nYi2M0TrtyXdJWZrDsr7S6/h3cggKl/NxMbdEd9VmPDD2tCLoCB0yaaZPuxKMnrn+cA5bGnHGVHzFGM3X5DiUvDoooslFIFeXjOhbApPVUxyxXUH1iBKJgSlzXpPMOQ+YDoCtJJ0YpNiCG/PeqNnnbWb/tPQP6LkWps+8H+oTBxmk3MA0vg/n+xCTJBDr8IrFUlw8xVpjmYAJqrd/+v6GLHGi52Pl1xOf/uUvqJs52DBV5srmy051diP851A3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sED6zgeh9f0yMzM+aVUHgn2ymYtjpgkDBuocVGUAmWQ=;
 b=JmUTdN1L2xfOfRhpTeCaeE2TOU+woG4iJkvpoWuTrpKGVMoT/CqVV3l/Tg7XFFeWpIKwps2MCugVzeNlWlEJg8mWH1ihgAaJAimem9fPWxwsGF0pz5N1Tf3UMxHoIYjL7Wl5RgMAADNlX8tUziGKDU/2yOt1fKbZSJdwdWYYoCA=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by IA1PR10MB5970.namprd10.prod.outlook.com (2603:10b6:208:3ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 14:22:30 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::3423:a746:a27:81be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::3423:a746:a27:81be%3]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 14:22:30 +0000
Message-ID: <dc3fe8c5-e552-48c1-989a-1fbfd89d1109@oracle.com>
Date: Tue, 27 Feb 2024 08:22:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: remove SLAB_MEM_SPREAD flag usage
To: Christian Brauner <brauner@kernel.org>, shaggy@kernel.org, jack@suse.cz,
        jlayton@kernel.org, chuck.lever@oracle.com,
        zhouchengming@bytedance.com, chengming.zhou@linux.dev
Cc: amir73il@gmail.com, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, Xiongwei.Song@windriver.com
References: <20240224134925.829677-1-chengming.zhou@linux.dev>
 <20240227-erlischt-filmpreis-b637a1cd3693@brauner>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20240227-erlischt-filmpreis-b637a1cd3693@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:610:32::23) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|IA1PR10MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f83242-1a17-4674-8195-08dc379f8809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WJoZVwnP/df97dxlXH1Gwuz++z7hqO8kbamOK5ybbc+FTr0UaWOqYl+7I13yBJTpa7uZmvcl60be/x2F9oEhb7yjVtpFbivMM5lq202JYHcrm9J++WdRsp7TcXeRDvMTD7d8HK67IYTFMARE+gAytYl0FCaaB6wclOOEca1Ep0DzpgtXXrsqNzEr+QhCHqbj+Nk84B5j+pNFvmbzXfihJ1Wiiiye1pyZPRowOaPvBSQ2twi3qfY/5rn0PDfjLbA3m+wCz3C0X6pA1Jqf03I2bwYT1/Uot+uFWxGcZGwat6sTu5w2BYU9c8rc/BVzSzfNDnHWLwzhKQ0lZUlBf+5Fc8xow10+ucC9+XJvIcUHcxyrh7OjAZQDtYqip9WHLNgd9F/7Xz2Rh/etSa2lN10XtxaNarMPT3yaF2ajXh2Z48IfcO170+StqAv4UeXVoadzMlyNz+NTPphCQpcLcSpYZ+VO2jV6bsE5pZAaYiacMwQrD62vfmNFdONLjNdomwffx83+i1PpYA+hA50VtQsB/C0IrOH/hsvi7RUorKK+msXQBB7KlgS/Gg9luJAiPbZJ4gZ/jgfoqSWZwVxmRRxjMbNUezTMro6PBDf4HlidESBm7hh9q7ntoj/XwAoLhx7k
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dHNmQjNqUlJBemlMM1EydTJlTnNVNWg4YUlFdkZ4QjY3ZEVBdEg1NVRJVTJK?=
 =?utf-8?B?NVA0QXNiSy9JTE5ZaUtld3ZuT0haTnNxdTd5OXpRc3BNUmVXdWJkVjIvNmYy?=
 =?utf-8?B?MEtBODdMdnpKMjhWcERzd2lrcGFjbWkxTEdvY0FiNmdPb1h6SUJGYmpMUGdF?=
 =?utf-8?B?RFM1bVVvVmpmaTZHM04wYm5obkx6LzIrb1lsNTZGNGpkTm5rQXEwUmlKQUwy?=
 =?utf-8?B?WWZUVko5UzQxMXNWYVNpdWpMa2tVbldWTlFLZjRlSmYybms4US9WRXM3ZDQr?=
 =?utf-8?B?di93aVJzYVFUc1JOOUl2OVhhTS9KQ3lmaFJ2ZkpSVFkrNUEyb2F4Z292RGVh?=
 =?utf-8?B?bFlmeWtGKzRSSDVEV2NnZEdyakF0OGI4N1JxKys1ZU1JWDhjV1lwQmQvZXFv?=
 =?utf-8?B?RlBRb3hoUXpwRklXM3RQbGltZVV0QmxBTWpxdkJFRjh3UGlqaWFoYWF1TC92?=
 =?utf-8?B?MEtLOFNybnd0di9LSC9MWHo0dVlpU3JNUERGUW45eWc3Q1AvRFpmMnR5bU5r?=
 =?utf-8?B?UzN0TXF0cDV0TUhud3M0OXlNSXdSdTRoMHJEbFI2QThWMDB2dlhlT2xaUEpa?=
 =?utf-8?B?T2Q5eHgvbTU4WVBmVG9DT1IwNFkxSk9XMVJJaXBKaXdYUEhTU1piMnJGQUc5?=
 =?utf-8?B?ZGt2cWdJNVFFUFJnY2tIZXRZaUhPcGFHOVB0NzQyTGd4dmVvN1BwckpHbzAr?=
 =?utf-8?B?OXNOVFcrS25TME45YnppOUtqVDBZN1RNREhYRzdhWW1CSit6bU83bktCa1Fr?=
 =?utf-8?B?UFc1QXJjZjJXbVZydzJGWEZSN3dmNnM0SmExQTVtN21mZ2V6a2o5M0RlbkZa?=
 =?utf-8?B?WjRsZ1g2NkdmczVtVXdLSTl3OXU2c0V3dHFSMGxWM0dFMXBVYUptUk52Tndx?=
 =?utf-8?B?dUU4V2VmdHJjZVJDTG9hSlVxV3lsaXFwU2xGM3JpMUtPOVNqVFJVOFpHeXZ4?=
 =?utf-8?B?b1oydDhIemFXaEdnOGNhbVVDNTFZV1VhWVZBMTJpNzgzTFJFbEYwMXBXQU5V?=
 =?utf-8?B?UVByVFgzRGxVbllSdVdIYjMrM1RCQ1g2MXlkMUtoYVFUMDRITzJBeUdreGpP?=
 =?utf-8?B?ZERzNy9raXdDRlIxcHhNeUc2WjJVUDU0YU81Rk9Zdnk1aUV2V084bjgvSUtW?=
 =?utf-8?B?TTJETzFUd3FVR3dMOHBwWWpWdm9XWFFYTzlWZ05GQlV5T21zQ3Q0bzQvZ1ZD?=
 =?utf-8?B?R1FNREZ6Vnl3ZU9PcGJHVHhWZzlhcHM3cjAzYlR5bk1Qc3lVU1J6QXUraFJs?=
 =?utf-8?B?SWpYSSsxMFo1dWxkZmY4YWxKTlpVR0JFUGhJT0NvVWxFV2VOa3EwbEFTeFRT?=
 =?utf-8?B?VEwzM0d4V0JlNkFPTXZ0WG8zM1VkcjRyMEhNem5aZTluVG5LWU9qcDRBcUxN?=
 =?utf-8?B?V0ZjMXFUZ3IrK254YjhSaG8zaHRQN3hWNXNIdTRkSEhWaUJ1a0dKbWtLaDBJ?=
 =?utf-8?B?elVnN01VSGpLMVQ4R1pzZ0pkaWRpcWZVQjZUZGNsbkJ3QWtvZUpFNVdMbkpl?=
 =?utf-8?B?MFV3NWFid1hSTDdDb1JZWUY4cGwzdHo5cDRSSTVEdHl4WllzL2JNWHNZTHpR?=
 =?utf-8?B?QlJnY3R6ck1Kb3BYS3JpQVM3em90M2lTSUh4cWNNQzVxektzTGlKcU94Z2U3?=
 =?utf-8?B?cXNFNDQ1aW1GQmtJSmJzQVBFd1o4K2lManFCRGpMOHhHV2xYamRGTXpzVWoz?=
 =?utf-8?B?cDVSczFjTjZRc200S05uNkIvcEZGd3l6RTRmWjcvR01uNWFrN0RFeEFQUzRi?=
 =?utf-8?B?UkFJa3lFOWswVWt2NWxTc0I0bG5kdXI4K1BqS25tNGFaSzJzSjJYYTJNTnda?=
 =?utf-8?B?eW5LZzBzejJqSnUxTVdHT25MWG43WXhIZHU3aENiOWRnVlNqQXc4bFdqdTBJ?=
 =?utf-8?B?TjJXRWdrZHVlbmtuOXlVcWkxUHRWTGpLUTlEL25zaWZCMXAzcVpHc0Nxd3pk?=
 =?utf-8?B?UnJHeTQzVnpvZy9GNGFwZWxOaHJUTGJaTWNLd3lMSFROQlkzU2lPdVZuU05o?=
 =?utf-8?B?cmd6RHhYay9ubDJjdzc0ZEhZeFYwWDZXTmt4MXZEdUFZZGRzdGRqSTRYYjhi?=
 =?utf-8?B?c2I2VnB3dWRoVmZEdzRjWmoxQXNEaTBGek9INUZJY0NZczV1WGxHRjVjNXdp?=
 =?utf-8?B?dDZNNm5TU1ErMmZ5OFZLODJvclVpZkptVi9yZjBQTnhIOUdEdEFQV3ZsaG9i?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vvpXHUaut2FD4aTGO156Vmm6il5LMrf8RnofkiqQyWbpfRrv+RVx3vIKTR9tWwODIODT35xoMQc2yiAD0qjv6QbaHiqOMBpUtpQFs6Dy7s/qvc4pkuVJZb0lgT4xWh+4qUXXCq9VuEaWNVu1drObb1ZZHizwaOJTVDra6d8lb1AhVb3L/YCPdQ+fnA9laBHEDSLKkQPaZzejfNSvIk7lktybRRdKKMJ68s3kdgF/Vc3qlVg/WAlTyQQTW95ako8LxmTNzkxItKCd6KIxL0unufKgB1YuRiBRTJY6NTUEeeeyVygeodYFJCzaMm6L9wbTHfKOhMvUxBtqAYeVp2PpX8OrBWzARs3tJ/vN12CZ3EHx6jBaJqQt6HFEM5GQa6Ekp5aU+LLwrWF4kEIV0+9wWW1UfGA9qkUZ470sDPAioJPDZwfNTBv5W3gWfMgNripM/Y9Zj6g01yUEn4UtHMoPcBeDy9nbbZ084vZ6noOuU2SFRstNVmLyrL7BCcvAMZVIiNo9xM7UdnEJv51Ij755iDkHeQLhoBFtIcKuSX2eLHtas3Z4SZtb0gv54Emrdc2Zo1Dn8ZH+4Rc86RaZjtuixFFyVAoYa3qdZrDtxQVAZzc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f83242-1a17-4674-8195-08dc379f8809
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 14:22:30.2817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlugybW+irH9Mahf1Ntwwxw5blcMGWh5p8YkGUOSHlIfJshzcJZ7Ea0rDxYvh7/cFP4qmUrZor583vcdYdixgnHFeQJwaogWXL/ba3ZutnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5970
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270110
X-Proofpoint-GUID: i6qmMzR2ZZe0CcXsoLE5EbbouZHLaPdH
X-Proofpoint-ORIG-GUID: i6qmMzR2ZZe0CcXsoLE5EbbouZHLaPdH

On 2/27/24 4:52AM, Christian Brauner wrote:
> On Sat, 24 Feb 2024 13:49:25 +0000, chengming.zhou@linux.dev wrote:
>> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
>> its usage so we can delete it from slab. No functional change.
>>
>>
> 
> Updated commit message to point to slab removal.
Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> 
> ---
> 
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
> 
> [1/1] jfs: remove SLAB_MEM_SPREAD flag usage
>        https://git.kernel.org/vfs/vfs/c/6259e5e07b76

