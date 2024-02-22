Return-Path: <linux-kernel+bounces-77248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C03C860291
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CC11F28371
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32380548E4;
	Thu, 22 Feb 2024 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eb1fuUS0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R2UJorVO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D0E14B83E;
	Thu, 22 Feb 2024 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629748; cv=fail; b=kBKbsKQpDYwBWEGixm4qCJjb7kQbtQcNICTN/vRCu2M0IUWWTVejuuR2vsB40ROHkSvXRxj9ylWTm+TBp0KiBYcvQRvNHd6aOJPBD/CWIa9J3yveYOBI3GVkHdXg6iJA1WSF9owv+GFhBB4xctVPujn2fy/MxumK+goPCQ1w8fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629748; c=relaxed/simple;
	bh=IVw75/BAUz5XP2L45iKcOQCVigTMdGq18ZXm7CDUOMM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=onp5cI8Ej4PH2pix0g1/Jf6IuBlRwi6SZJlnbbo+DUq51gy5rTJ2Ys743WN2mS+U/ZHncoeHazP8Y+Nqj8tj5irr/OJdAS4Opk9yjK9VnC45sa1DAkpmSjr2bAVMkx5X/2rKRggmKrjurlmfZV8Wyq9X47jSG+S14ZP10DumrrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eb1fuUS0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R2UJorVO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIQS3f027798;
	Thu, 22 Feb 2024 19:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VkgVc+CRIbKkM7bh0D1oIYDk1vbjNFlNqGL4eRCXwkw=;
 b=Eb1fuUS0wwH/rfLUvIUYPdfWj5C3NQlI8F2fHs7YVjnIi6rIgw4gmjsJmDM1YxKSXj3o
 7GM2dZPyFUf2SOik6GWCNZEZdJQo8/wqRP/XE6kKAmeZQ37ggeYX2foaeoSsV8+a1uRd
 1RZKA/7sJyyVNQd9EabvYP/Nsevr0uPmN9DsMr0His9COzVC1fWe4RlneK5qhfH4OWB2
 PvNKbt49QRGy5VbY/QVtbkitxzz8Nbs9K6o6Ua2YFnFwIipsm9kAI8/F78wn4hXWFYfn
 z9oUXDrmTjm4mSjza0zMwaEd578uXXv2hNCMdlqClUYrse+J6jmOWZklpwLu+zQ7wj76 Iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu5hew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 19:21:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MJCfMh022185;
	Thu, 22 Feb 2024 19:21:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8bahr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 19:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXRSkBQTDufWU4MDBtNO1hszCLfJieB0Kpa6CRQEusr/6ZJ8gR7R9x2z0FP0qSg7mJOxIZUwaUOLgW3TEgWjTKjl0fDAPMhR/N65qzn2oIyyDchGCQkwwnxWUW4QTsP1O5MYutkliimxqrnpMUmn9i2vrZLs4klUGgT0f2X8yLB+I/Hi5V57+XyqmZmvEh4krCUXqRgga9lDj1iIZCc5A+dVN+NQziDjbOYCivtDbFMRj/nZFLDf6knjjtbs0+/9vH/EG8Hlzlkn/UJRJ2wHQctxiC8PSK4tunEyoUR9wwHHi7fYqObrsOfkUd4EhdgxDrWfVwhbWIUDI3Az7lGkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkgVc+CRIbKkM7bh0D1oIYDk1vbjNFlNqGL4eRCXwkw=;
 b=OCGaJzammv55E1BDPaPi316naNA6R36QWng+2YnPy/dUUIWuJwCK8jxgmBY/YbQEm5ym+Uj8LNT65E7KXlEKbn+3e8lYKGJLvEU2kTjJjce0KOxLydYUIqzIn3myal2PibtEpEDLRHb6aobj2FmX3WiFGfMpRS2+9CiS6c/JZZ8UwrxRfctAfMKP6b6CdcZmFv9D0WJ7hvngAIZ98gvU6OFVTEOJmdcsgKpc3UP0ztvIGD6IZ+PRRnK/UQqmxe31fwimaxNorNIe+mFQCsI9wfm4K+K7LBRMh72Gh7MZsa7B0fClfwPLxsEWPFHwCe55IPiVhSOvJab4c+/iYoxMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkgVc+CRIbKkM7bh0D1oIYDk1vbjNFlNqGL4eRCXwkw=;
 b=R2UJorVOgbCZWW3H508uzgCMRlU5+npFSKdh/C8+af/J/+MN4xn2xA3lgg6uAO8UhbezamfN992AjPneqRFg9f/HQEE1BXCJoFxuRAsYyoYTBn6fs0WBGSKk0meuRxdwRTKy3YbRHLl5rZMguxYoMuAvgg15QYNw0Hpv+JtwjM0=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ0PR10MB5765.namprd10.prod.outlook.com (2603:10b6:a03:3ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 19:21:52 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 19:21:52 +0000
Message-ID: <3110cd8d-2f23-4e8e-99c4-3c80e9a11cc3@oracle.com>
Date: Fri, 23 Feb 2024 00:51:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/267] 5.4.269-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240221125940.058369148@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ0PR10MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d85edd3-8d3b-4411-5294-08dc33db8615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	D12+pHy3EAbQwu7e8pNCtFvsVP7FbJkxu+2oE6Ywpo9sbj3UIp/3TSqfquSma7iz2r2+O7VZIUPBtAthGfS4LQt60R5KzQmRx5yBwAoS8FmkedT39MIMQBpWSW1ibxg0trrtweNvEm5gxV88jt6HtPqarKPhL0A+36YyTWlMPJdmK5yLXah2+lHELdE1bNU9AfE3sp6qzl7EpDh85tEP45oHOB8Dzl9Qhqdl79qibuSrcr5W+uLwQFzsDPSp8jOuy0/IlJdomWrOTuIOeLv5iGzI4a4VbtsWhBfog0yWo7T5FEMvDZn7cKITxEq43diBJ45ED/krf448WO4tpvWzjEu8/L5u1Jh/VXQC+9KIx07Sq1HXvxvsUNnF49n2L0MlAaaDRZY5TPWGm/BrfAHJcpNc1zfHr/LF4Qkphu5Uc1sWsvUw6bn/X901gQmovylGJ/CBEN0lbzjZMUg4qIZCskARIfDADhXs1CP2Sr0UQc64rahvrVbuDJQyAvR5VOD8NVdUvwGIM/kvpGsIjRxEhw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YTQ4Q1ZsZ2lIb3ppek5OdzIrd2l6aG9oTjhoeGhOdytOcDFCSHpRZTVadVg4?=
 =?utf-8?B?ZHFtSEFBRE9OWmFlVlJ2cFJ3MHMzSTV2NDBmbjlrdExrOHpTTGdaSWgzZE1J?=
 =?utf-8?B?c3FUMGUyTjE2S0JXUUdpVVVQM08xWnloanN5Y1h5Y2MzQlBFb3pCNWpuYWhp?=
 =?utf-8?B?Zk5QMDByR21HMzFwRWxDYVhGWmwxa2psNHR6QitGTGJDSFJtZlZWdytPRVFj?=
 =?utf-8?B?OE9QSlV2TUlEY2xhamFpOEtxaUdWVFgxd0dUbUFIWDVOYmVnRWxta0sydURw?=
 =?utf-8?B?aVU2bTg0bFBITmUvUkJyOTMwT1ZFRFJEZ2NBMTlFVENqNGZDV2sxbUVaTkJO?=
 =?utf-8?B?Z01HKy9FaDRTTjdSQWkzNWEzcllVYi84NXhtakxnb1Vrb0pCRlJBZHFjQy84?=
 =?utf-8?B?d2N2RmlvaVlxNHBUZC9CbmExcUU3RWIvNlBnVGlPVTR2VWZnVXpwdFp3S3Zw?=
 =?utf-8?B?L3lTTVBHaXFBT2JvekcyT3dJY3hid2cwSzArYVdaOUl6ZzAvZ1g5ZjV5SUpP?=
 =?utf-8?B?UU4xc2VXOFRUL2U3SjZhandsUG5LbTA0S3diWnZVKzdLR053K3VsNHd6cVB4?=
 =?utf-8?B?RGdhOUVVM2ZjVlJIN0pjVUhBQUQvdER6UW9ZZ1RzeHV0WWdidHZxemY2YmRX?=
 =?utf-8?B?OWo2L2JoQy82QkNycFRzTFJNd3lqcEx0TEd6TExpVU5vN2tTb0YxK2hTY0xP?=
 =?utf-8?B?SGdJYzB2UzMyQXBUUzlNcE13Z0FCZjJycTh3MVVtaHgwWVNxdlBOa2IvT1hh?=
 =?utf-8?B?S29nNXBMS1RXV0pSQkdkWHU0S2t6ODJFS1Q3Kzg0eE5FVlBaTWhvbVZaTERw?=
 =?utf-8?B?WGZtVEEwUUc0MDlFZ2IvL0c4U2JsV004T3NWYkF4SkhBSk5USmNsWklzK0Jv?=
 =?utf-8?B?dWNPeEVQNUZ6VEd3ZlFwS3BiRy84aFF1aE9tRmhEL1o1cVF6ek1zbG1UVkZp?=
 =?utf-8?B?Z2paOEMvNUdzbDRwSkpiaVBjNk1Gb0x6eWpzWS9rTjNtajc5alhtNE9WeWRz?=
 =?utf-8?B?ZzRyVkYxNHlRM2hIWGhxWnlUdk5SSnowRTVxSHVDNVlmVXllVlUzZkh3VnNy?=
 =?utf-8?B?dzdPQzFaT280djduZllsdnFscGIwd0hhazdnTDlFVEx6d0NKRGpKY0VFU3lw?=
 =?utf-8?B?SzM1NkxZUGpBN3hLb2NxYWNuOUV2dmhTUVRxRzFDaysvS0dHc3JUaGJXWjl5?=
 =?utf-8?B?R1o5S0RSTloyS1lCZzlSZUIvdlZaT0paNHJDTnhOTEg4cE5BYjMvMVhsc3hh?=
 =?utf-8?B?bEdVOGpPVVhGWFNmaXI2NGd2TWtHYldFOFpjNjFiU1Irekdjdk9EcDZ2Ulhl?=
 =?utf-8?B?Z1VBaWoxZUZGYzl2dnNzU21FOE14RnZSeXgyeWRzQ1R3QmRWc1hDWDlXdmlP?=
 =?utf-8?B?cmNMMDZ2YmhvdERWdUZ2M3pzWXAyQVJRV09CZ3pZSG1VRTgzZFBBQXhZdmht?=
 =?utf-8?B?cHB3dXZSRWZhaVpLL1hqNzdaaDdrTTJWOUdKTFlRM0c0K0ptNHh1dFlqZURZ?=
 =?utf-8?B?M1hJNFJQWmxCb2lzeTBtSSs1VkNqdkN5MDZRNHNCaVFDSUJCamRZWmpHU3pJ?=
 =?utf-8?B?cGxPUXBKL05FSXdkaWlDOHBrU2haVER2OE9vWU9CNlFhYlpQMWlKYlozdFJK?=
 =?utf-8?B?alpMV0VNK1BWVDBZbnZveUJlcjVQdytnYnVBSWVaZFI1Sml6SmpLc0xOc0JL?=
 =?utf-8?B?OEVRb2pjRmNsajFPdlYwdCtlY2FNVU9mMy8xZXhJcytFTitrNGhUUEExTkdX?=
 =?utf-8?B?TmRENnhSV3JNSHVKZFVBUWNmbnVhR1dhQWd2bGZHWFMxWnVRdk1LRzc0blFQ?=
 =?utf-8?B?RTdZUVZjUkNrNVFuN3NNV09pejRpczRHVlFyVXVydlVpL1VIN0U2WmVjK0ZB?=
 =?utf-8?B?cmtsZUszdnlJUEs4NWVNQjUvSDl3dXJFQWpuTlIyVmVIRjBwdWFtSitTUnpL?=
 =?utf-8?B?alIzd2t4Q3dsTEgrKzJsS3daVVNid3FmTmNQUlh6Znp0blR2dTBxcG5Xa2Nx?=
 =?utf-8?B?dFZIQUY1aElYc1RMd096TzdjTWVqOUQ4ZlZDNU1TY01lVytQTm12TEcwNEp5?=
 =?utf-8?B?dm84YTlmTSs1Y1NDRlFLUEk5bjJBbnk4ZUxVZkR6U2pqeU5oUU5KYUFDYlp2?=
 =?utf-8?B?T2RITnI1aWJ1WHE0UlhhSTNJZ3FIdUdCMTh6eVMzMmFSNi8rT01mTUFlcXln?=
 =?utf-8?Q?XjlpXF+9EEdDLhydPsKnqp4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IZ4Mk+alR+cyjFy5Bc5NSAHaJcJfQSFiiFnTcVlV6dEpnOd7netoKlnQNU8s1JbMQF2MyUsHPBYD1xNgDNEpI0pNBgfVh1X336WHwQrdTdhCj3BJ4vquVqxWw8KCwR5kSheJHNhTYHGoCpkf0HhpLPjBAst5/rvh/gbYcQh+uouNbtJlr1kF2CAvLyUJvdwTFrOxwhI2ts9CGkAmk+f6VU2vO+kxDaJnNBgpA0D9rG2+0L2+nuQz/o3e0vboVGufqy3kWOGx+PX6R6srdzGeSqjGZllkibMUV1wkdvgYXFItMLaeqyVq91TapplxQLsbprgQqy5HCv5PJQHUMo3IlP3RqESW/Um7W+pncgXFBrOjy5JUEM8ob31zDGxCePOcRkKGp23X9rxdVpd7K4jaVUT3Bgu9NlpwsfXy303aQbtVs9FZCw1R2sixL7Z+Ld0IQ2JDVo7n3yWWSNURoaeYc+eqrHa/UkMUuZRr58WhwDqrzr0G8pHVHEOcqTkievmRRY1/W6Q+2cb44mf1TSWBHIWhDHyspOdl4/TQXaS6BUSs1Pj5+3o7IGEpKi/cyXVaKvnYQixTw1e7PWjVl1D5LlXt0t7z9+iw2FP6H6/YQF0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d85edd3-8d3b-4411-5294-08dc33db8615
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 19:21:52.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ceiSbeH99JokXkM4IiD/G+VloPRz2S7eQBZTJlQ7Fyv2T/OvbSeGmXtkdvUbwF7M02s9Amvi3JOCvEsN0BPTw0Nv8+pK499dl6SOVLFFQUv0KiWEzzN5ZlsHbHltFng
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220152
X-Proofpoint-GUID: dQGFWnl5IxbQPbaEt9mPNw6Zsxz2uH4-
X-Proofpoint-ORIG-GUID: dQGFWnl5IxbQPbaEt9mPNw6Zsxz2uH4-

Hi Greg,

On 21/02/24 18:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.269 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 

Built and boot tested on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.269-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

