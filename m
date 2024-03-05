Return-Path: <linux-kernel+bounces-92438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2633F872027
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923DA1F2487E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB14285C65;
	Tue,  5 Mar 2024 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ef9VDc/2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qk0ZjOYa"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB085C58;
	Tue,  5 Mar 2024 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645392; cv=fail; b=iuGF3TcFRVObJWDviywKqQJ39fdn7jBfu6BOF01G17dDEj0QtkSJ3CvKMSbYcdbPGhEL/QVvQfkfeSa3T1XGZSAN7UMwnbK11EPDK+ouMVdZtUz1Qt3Lc4twV5uAfN+4smxuuzjCKWqw7CjY8TaxgalC+Op1/B+uk3RZxZTiyCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645392; c=relaxed/simple;
	bh=Xzy2y5hzXZig0Xf/fHxRNV5eppo/fHf8+2TUPivSjJs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rF4U7ByGX0J5W21KlDScTynIm/wqQLEkgd4u4F8/s0qgdZbtBOnxuhLTY3PYLBTcnXJkzUsk5ETntbN2YTYqjnY3htFueClMLC2vxBefb/8jXNuVpQ7UaG9fT8MIsSV4DftzRwOvrLiwOZKXhG8kDYaH4ojscyEq48Vr6kMqgzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ef9VDc/2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qk0ZjOYa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4259hiDv029823;
	Tue, 5 Mar 2024 13:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vSttkAezAgaPBDS6tqHouP/9lWqk4Jt9DmSwT01ma0o=;
 b=Ef9VDc/2kmza/I32955lUa27EhFt2BqywMBJSo1CzhHGCMdLh0q3nmQRM71F9f/DQY25
 wc6s3nWbGwIbZg53e0I5XJgbRwO3kAa46q+gJYtriHXbF1nMdi1QeRKPnkoarUQfEVZr
 38GeyU9pK5ORqZbOIf+m9a8Zrctn7wEQPinWs1mu91oyyVCgCCfwxDbK8X998QdD9VpT
 GuRQ2w0ICdwjkNQZZ32S+4AbL3TB/m83C8HnspaTCuqz1ENgYbHr0ws7UJhZnEooECaP
 wRqlnCvR2ZOm4ceJjIAnX5GZpR5Wtc1dH8tmvd1+fTVon6FC5DeS/eczlny91OYotmPm 2w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkuqve48w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 13:27:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425D45pR040788;
	Tue, 5 Mar 2024 13:27:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjdka4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 13:27:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fwxsce2ZD6UpDDjtdZ32rdRHEabTyNcjCqHh1zqw1FPRZeeN+C/JeAs7H5RQkkOnO5b7vSvxdNIGfUNbcp03m2kgs5ZWvHqPBHQwscB7yawzvqfNebmD6TAAgSmXALlfNzRUk3qyGBwf9XEkUDFqwzFYnA45F1RpnPomWCZnLRZu2/AM3U6D0i4/OS7mnYH/xPsWGybN/IE8JNUHYp9McRZwLT3Aqnc+b8OMLg2b3TGYsfa1xzMCLf++dHXzYWw/ny+HAtmo9ul6Me0enZyRyUj74XIFxCCvVlL2RUFv2TMg8fzBycRMk6xDl/RK9d3pVmTiNMsNAYYcCRyWgGfO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSttkAezAgaPBDS6tqHouP/9lWqk4Jt9DmSwT01ma0o=;
 b=b6wA4bfU5eLUUXgDIFIC/LawjNXj4ZE2O/qgQVhb2rqTGUTBrU8EjlfRWWJmG29BqoXcpfuiD1zKndo/YifxH02GtFXHvDp8wVN4/xvd45cQG0/CHk0i7Z4YfM073vnUyYJApUQ2NKHoWYKQH1zyNBb0Yds5N2s7U6j1zQ4C2DOo8ixsfUGiDITIil0j+F3q6NfnYEYt0ITBad87TYe2TtGcEcIVt+/+yQJA7kitgwe99tkQMibvYv0phQ8sUdtkvjjgLv8GZsyCl597pOHi6vrQjJ0ysKaL4sgF4AOiW8y9CS7boHsewz/GGXPJUTvwjIv6mcv1a/yjSjLdSO5Gcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSttkAezAgaPBDS6tqHouP/9lWqk4Jt9DmSwT01ma0o=;
 b=qk0ZjOYaUy7KvvTAu2LPrMDaBeXk3VqHr0R0fmzLXl4h8lgfW/Dfs/W+6SUsHwjncek0ZbNzMaYkj+F2SlXX2RdjDPFuvedc6dSkbYmgJDSnr+k8T8snOZKho4AupZy5Wyfp4aSbyX92KkNXfiLsN3cE7JAhwhf7c2QWWXAeXVo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 13:27:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 13:27:21 +0000
Message-ID: <99e4e3aa-8b8c-44ff-8dae-320c90c471ee@oracle.com>
Date: Tue, 5 Mar 2024 13:27:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] scsi: isci: Use LIBSAS_SHT_BASE
Content-Language: en-US
To: Jason Yan <yanaijie@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        dlemoal@kernel.org, ipylypiv@google.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240305122452.340471-1-john.g.garry@oracle.com>
 <20240305122452.340471-7-john.g.garry@oracle.com>
 <e3fcc620-d803-c8e3-651b-9781ecd8e87a@huawei.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <e3fcc620-d803-c8e3-651b-9781ecd8e87a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9b1b6c-83b6-46c9-8e76-08dc3d17fcb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aukrATPupHc/B2U4mPd73xAjIjQTxVdb9u2aFPM0IR3u8t3ExCk/tM67fQTH0/FYr445S2WxYzvvcK7h8qwN5Sfyk0/4TOfNlJHF63dhBykO7+nUgRKVM23G4Gf5cALQdYzCj4fPh0g1fwToOQbsneC9dQnkVZ2aOqkNXGcFz84MmB/+hGRnnCKX2AwlmRkowtxM1YM9+PbGeHbdsgyBMJNmMN48JsFrsY3B+NBiEH5S/4QK3ptarj6JQt1bSZ6m63RrWu1ln0xEHeTLuJ3bl/jgv0ZBHJPuM5q9/a14A8BVN5jE8tn+IRQFDDRxKg44j7qsKfEk3rZEgfTlWvrJev6S0ghI0Y78NG8d9EiZEF290GHslfVXhGqorT4hSCFak/3QHDAMTh89eCh/4JCs1rWB4/e7u7eKGiKluVmmALzIZCYY79fSmO1dQfxgkZKw9mL9CaW7Y1e4TtAi8+uzoJPXw5+ystJqX7rXgB/rNih0JaStI3wBvARWS715PUob0wdyPkdUuy94DvC9xR/EBYtmefTGTsCrazLUhIh20O7KSgYuXdcjtg+OWTlP6LO+TlRc1aKRHQIqaxTQDGyg0DNspblxbdnHjS2R8PBPgms1v28jCmj8/OWrnF7H9EFs+yGt32Ak8w2GKkmtoPNDt4OJMn9ZHQjXWo4G86qw7pU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWFKaU94T0x5eGZPY3FQeWtDaWY4Wk01Q0cyTzY0TW50OHdOZjNDeUFCbmlR?=
 =?utf-8?B?c05peGlsaXlKTVRGM3lmaEZUd3ZiZnFBazNhZzFTNmlZVnRNOHI4V0F3ZnM1?=
 =?utf-8?B?SEFmM3dtMWwwQXNwa2hIUXQrUDE3Q2VUMHZJVGg2UTB3dkN4V0V5OWhkZ2Nz?=
 =?utf-8?B?YjVXSWg1S0Y4VVFRVGtMV2p2TWxwMWxlanYwaGovcEhGUTF2bWNDTW8yeVhu?=
 =?utf-8?B?R0I3Sms2bjkvbHBlQVhLdkdaYWVCcmlQSGc5OEpaREdYVkJzOElWaGNkWmQr?=
 =?utf-8?B?R0NUQituYzA0ZUVta0k5aHQwb1duRk42VXUxWTVuTVdFYTdQanJaY3gvMzJT?=
 =?utf-8?B?bm1TUW5vdlZKTzZLK0NhZjdWRHZJTDduWmswbVdnTlJXa3hvZkhPS3ltUXN2?=
 =?utf-8?B?dGZ2cW1PL3lYemxGcFdlWnZHTUxSd215NTBwMnNNeTdXRHBVdXlSOVp4QVFo?=
 =?utf-8?B?NG1QbTZKS25oeHBIbHJUbEk5YnRzMVA0aHFKUCtZY2pVaGhoamFidlVvY21j?=
 =?utf-8?B?cFFLREFWY2h5Z2lGTDNqTVdnNXNwZTgvNWNhTHkvMkdMYUdnd0xWRFFBTmxt?=
 =?utf-8?B?L3d4MlVRRnRvaDlEYjFjOVZNUnpwNWU0Z0gyQnp2dlcxV3dDMUNYMi9pL2Yw?=
 =?utf-8?B?WUdEOW54akljY2V1R0twZHZZWlBCcksvYzM0eEtuZUc0UzZzcTMyYzNyKzAz?=
 =?utf-8?B?eng1OXVsYXdaMzY2WUc5REsxTDdWVW5oTXk0TnJqekVnQk5RSDhJTDF6QmRQ?=
 =?utf-8?B?R0hpYnFCL2t6M0IwRGJJODZRT2N5QlkyZzMxcTk1RENTOUVFdU1oNy9wUHFO?=
 =?utf-8?B?V040dE53ekxPRy82OHFsaHArVHljYThROCtUOEdXbVh1aHF3MktmbU04bHNW?=
 =?utf-8?B?RCtSNXVoazM5aXZ6bmNiaTFHSmhwelZQKzNMd1JrN29ZRnU0a3NZV29halVB?=
 =?utf-8?B?Wi9EdTB2Y3d2ek1CL21SNzdHSEo1anRUQmdXNmtrU3hNK2krYUtUTzlrcFB2?=
 =?utf-8?B?Nk9SMGM3MXZhdEZRbnY0OWhDM2wxZ3YrZnpKUXpHK1V4aE5IOHdHR1djV1hy?=
 =?utf-8?B?dHFORUdJak04RzVwMllGOHQzeUdhajJZeUZJbFdldGNtQWhPMzJzTWtPS3Y3?=
 =?utf-8?B?bzE3ZXU5UEloUXFIcW5FUWFBenRCOG4vS1JRZXRxS1pXcEpRNDB4Yjg1UjRM?=
 =?utf-8?B?NlVnUzJFUXVoNExlM0F2cXVwR2NWc2VBM2x3L293NE5yOEdqSjJlZXhRL3pj?=
 =?utf-8?B?RGhDVXBzUUNIVW11ekFVbUkyVUFkTEtWNlBqUDNBaHl1WVgyRW4zdWNDYkl0?=
 =?utf-8?B?d0VPekM1eVZCeDJPZzBZL3RvaUZldDg0UTl6Vm96Skk3T1N6N2dQS01hMEQr?=
 =?utf-8?B?Y2dWZmJZdzNWZ1g0NVo1TCs5aU4ybEE5VTZpZytEY1E0UFFBQ3lHNWhOYTZh?=
 =?utf-8?B?cHBtQWFGdVFiZzVoYW5CYnZCWFlTVU1BRnJ3Y1pKSTZDNWlhTURmL0gvRmFo?=
 =?utf-8?B?dnBHV0Nma2Q5aldMcm02T2Zra3FiMVNweGRoZzFRZzJob2RlQlFqck1NbS95?=
 =?utf-8?B?UjNBQlBzYmxjOFhXOUI4OFR2aWk4U3hyU3Q1T01PVndPWjl1U0VXNWFpSjdp?=
 =?utf-8?B?ZWg0Y3ZPWVlJQU55YnQxdDBFejFLTm9YbnptQ0Rrbm4vV2xMVzJiTnNmTCta?=
 =?utf-8?B?c2ZNM2RuaC9Lb0NFWVM2U2Vsc2FYYjNFcnQxc1M1K3lFREJ3ZU5VZzFyQzgy?=
 =?utf-8?B?RERhRUV1SW9JUXk5Nkd6N1FHeTdSeVlWTkNrV2pmeFB6YjB2NkNXOFpRVDJp?=
 =?utf-8?B?bjJmOTY1QXdvTitxVkk3OG9TWkNSbVVlK2ZHNjlodERpbUlWTldWSjZZOWZy?=
 =?utf-8?B?K3BoemtqR3NXU3VMUVhaSkM2QlF0M2lnZEJsOTlrVndYNWs0dTZFUk5xaEth?=
 =?utf-8?B?V1NZUTRkQ3NsRkVVQSs5MXlQMEs2L3ZoZld5WDdPRlBMaEU0eTMyamJMNFZW?=
 =?utf-8?B?cEdBbU5rR1FWU0ZMUEhKNnY1ZTg4NE1lbEMvOTJOZ3d5OWN3cWtQN1RCcEs1?=
 =?utf-8?B?VjFnaG9zQlRXdVM2d0hoMDlobnN4ZFJPMkJqZFdVU2p5Q05QY1M4dWN6Yytq?=
 =?utf-8?B?YUU3VGd1cGdHK0ZwaXZUVTFNVjhkUDBWNndvUXIvWDFBeTY5cG9wSGV6cWky?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6RA4KAw2Tmn7umm+7Q+mo/Mjfp2pF8uxGPgwGqwHWarEIlLeXNLwtVRtwGPS3yzmO+gb+j82qVUHsbxQXe03C7hSKB7MHcWNTAaYQRl380wvSWy1my62lEPwnXa0sDTpRHkO/dgcmM0G+jaCG9H5tRA9n6LXra34tZcvyqBIB4+PZEumxYyOLWDsVPjDqKoMkNK95JatE5iM+9jnwu2cgcQ4izcX3q238gnqwSo4YgDPkvkBzDW5LaUBGK/3SXAKrhzR5sidi82AsgPI8ZXPq56nJW/z5xlrlXKOwkGifKGxl5ns/QCxK3wjpfBSxb146FISTxoTuVSpj70o1sOKIYNHdYO9h5bMAES/fZmkxZR2ukJ4KQ5lqK7NdYhYg2Bl3ZR1wfDOzbhc7gXiOEIUG+HQssNvqdDEeTvD66AG3TqE/E/P4+c2ciCjj5LkjAcTwYFgnJs0G6JSqc1VDiDkrGhklB/MPFt+tz74xNQ+zqXs+jOCUOLb2un7NbX7jKB7kuYIIAjO6VK6Qg/pCHm9LZK+6FUkiPB+ESkBpMe3BvYlVsQKVv5Jwo2Lxx9GEghQ3xlBTRiuiZarJKTM1mtbSUh8W0MBh4ma9n3zrbhbLvA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9b1b6c-83b6-46c9-8e76-08dc3d17fcb0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 13:27:21.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gt3YXyVB00NCKmYhTsuI9trzRTtCdkIRaYu7HWxcOLshRT1K9po4H4nG34fPrib75OjtLd8Rs0p+ynf22JdBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7082
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_10,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050109
X-Proofpoint-GUID: xPc9wyYaTpIZKUofDVv2a9UtArzbJgSN
X-Proofpoint-ORIG-GUID: xPc9wyYaTpIZKUofDVv2a9UtArzbJgSN

On 05/03/2024 13:21, Jason Yan wrote:
>>       .sg_tablesize            = SG_ALL,
>> -    .max_sectors            = SCSI_DEFAULT_MAX_SECTORS,
> 
> .max_sectors is not defined in LIBSAS_SHT_BASE.

Sure, but when not set, scsi_host_alloc() will default to 
SCSI_DEFAULT_MAX_SECTORS automatically

Thanks,
John

