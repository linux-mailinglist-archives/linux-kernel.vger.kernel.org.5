Return-Path: <linux-kernel+bounces-92278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2A1871DD8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD0B1C2365E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7705A4E5;
	Tue,  5 Mar 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QpLRYBqw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C8q5MQKV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6D54917;
	Tue,  5 Mar 2024 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638245; cv=fail; b=G3uwT2xv5nGmSNtO1eetXcpYL6oI5YveDciDJImcnP74o7xNvjx/QWXsjrH0nVZ//R68be3RLptGDF+/wkP3BXRWgcjlN80WlVw2A0BALh+qRiPMZJQxKv2gUEeXAZqQ8y/s/jvDeVKpfNSAmCgTwBRzH9Ln8TjbV1ZCgCClQA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638245; c=relaxed/simple;
	bh=GWqeTaKlXH5+heqRcSscEFBYDrLjYqjk3fLU4+xHw3U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LGBlbNktJDSVV/WzDT8CEFFoCUALn2Vg7t06ECSY+pSf81DoWUmUJKkyadycVfdA2iEUoJPt46TRlDcUWN7HrkUcRE7GKhjj2actkBJHehcerUuErN9hwxkg6TBSEPrS/yOtkTPok9nHxp4GkluxcvFFeaBfuwmu5Y39eNNqOHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QpLRYBqw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C8q5MQKV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4259jUku013901;
	Tue, 5 Mar 2024 11:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Cki2Xqm1wdVKODKDQ4OziNG99kfXjTYtvaWfDbO2XbY=;
 b=QpLRYBqwpe7xSw26XZEXN5MGc2bbRx8WXHL2XXv+y8UUdF9l9Wb22kNrqXNz3P70+UkB
 2PKyp8tFwQUM/+0a66T9qUv1Aag2fG6HdnSvxLpK6aa8jPEc5qq6TWi1Db5ibBy+bDCV
 ASiDANluXvdUmdwd4a0dYbi/typMzqnT1ZMNl8pf+Kc/98vJkNBeNvTjmj8/wAlFZEVK
 RQI7gCYST+uBDHdTmBTrFlLAj1n5UV/fsEF2GHVNvxzGfD0GnCvh2wMZ46d/I3oHgVfv
 W3vU1IgNN0yZrW3zIg2OKS7kI525aS1oCNxX058J0FeGDGwxoZh4RkkC3bzHOzRvXujN lA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnuwvsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 11:29:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425BPFuW025770;
	Tue, 5 Mar 2024 11:29:18 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj7dgyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 11:29:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRuw6yTKp7pgEut0DoPweFCPgronUpSiyh3y5K/pc2keH9IuTqITvrorAPfOmM8vZ/Huaj0i5jw4AXSsdQ75X4+i0aEW432KfOqlxfnbUI6JB5nERU9msI47ry46+nNCb4gfaWY2ThTgTqyUCUk2QIN1aDiJtiF0kfyT//hxk1E4pVt0hZfhAujOdJ7HabGQJx9nj0SXooKALNTDoN9tlSZIUrPgY1b27yplhsbd6fdnRMWPUNdjQ4B6iXv7/Z+FfDVy8b2qmzezwbTBqmelgd0T8Dm/MsesI97naYSKfwZdY2xKtISuhUrJ+ZZBFgJTiJXMx+SQFmrkJLWLoZyHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cki2Xqm1wdVKODKDQ4OziNG99kfXjTYtvaWfDbO2XbY=;
 b=iUSrvvtymMe3Dvzii7elcFtpphmV7O8YOSmEY7mAE1uPKwN7DZ0h0tqux47sz42x6cDjI7KXcK4OyP1UXTKRRjd3ri+v4GusfJAGu/A0D/rhkDWiXvwFJ7+3PQrIIcnMVdAiXUklfekYTa1F1bNs9M74mP3Sbn4bUMX2lOIuOxFWkqg4SbS6mqb/D4yQhTn0NhTHbe29yE5IClNP34g6SmU1xpiYZMDjx05QcayqJ0TLo2cvyGcmn8rb9OJNucl0hy9RDGllCogshebbybYghnS8cQDeSflLGmkcF0CoAmKjBr5AbnE4vtK5MsDeCy27krmL0H46stUYX0VxId0PUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cki2Xqm1wdVKODKDQ4OziNG99kfXjTYtvaWfDbO2XbY=;
 b=C8q5MQKVi2ouXp2p9zm276H9ARcaU/530JFZM01Y5hH2vv7lhFvgGC/jdeELF1MKzJF89ccb5BBjsyfrQbl+agxIFc/Opr9+hwmCH78ABsPifLUzAwBThMaJ2GXBEsIdfgEUBq5umb+ip4+tQzIEs4fBYJ6f/QnR8sOQwPUhf94=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6284.namprd10.prod.outlook.com (2603:10b6:510:1aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 11:29:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 11:29:16 +0000
Message-ID: <3fb62749-8c66-47ae-9b8b-7e670ebf4841@oracle.com>
Date: Tue, 5 Mar 2024 11:29:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] scsi: libsas: Define NCQ Priority sysfs attributes
 for SATA devices
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <cassel@kernel.org>, Jason Yan <yanaijie@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240305005103.1849325-1-ipylypiv@google.com>
 <20240305005103.1849325-3-ipylypiv@google.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240305005103.1849325-3-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e04042-6f32-4abf-5301-08dc3d077d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2dXooNNZfl/p0GIngxMxUAFD4g36lVcFd8A3nmjNz3bN/Kza/b0UBnD2v2/Oos7sRcQfCLEi+ceSKFwNqWTFzI1Jw8NmvY7MJxV7eOH7eDZDVFoLzmPWVEKnSoeYBjC7ZgM28qS/73mPLI54ChsBcUsOYi9zvrH3cvEb41jmtzPh99DP4lDl03m4n7ZrrL92I90+rIxxVpF3skv7hSlC8n0m7kabQBREwDZhk9cfqpw3LQqJ+vei6TUBAqJUdL/rqHdZ0xe/cg37LjTxUKYT3oOaVKSHMfBc7KtNy4YcWlvsPR5bS/6mjnXSiEGaCY52g9kES/gUIjw7ZGJjfStqmuvNXRJTUIYxHeC/r8833gn4ktklLBunvuHl55iQ5uPArw1pwhzLZ6inuStLKXBUPZFYLQqOFs2safqnrxUDmpXsPlM1fG1wuNVEfU1MbgpgUfsQ014FzX5QPXl413Y+0ldglogE0RmL1LDdiixIct4/po3/bYNYoSNxsFwG1mMVsQqljxE+0mzLmiJG4h+v8+XB+rf68p+GmNgoe1hlFNdIAafd3FOiT2clyw5H/GdmvAduuupY5imHvUOD5V+EEJwxMnWIFiEBg3QBuYNWi9mvsTsJA/leKDC/o0F7/XdKooIoAuscbEHzC0mtQQIEI5XUrWuOAgTEiZe7mM6SjgCwZF6eJohnq53V0dvUyfXh/lFjSqwge6TvU06Lsn+VWw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d2Z3Z3dVZjZOdVVVaHFUZUxDTUUra01uamYwbkU5UUNZelJIU0xKVlNTMHlJ?=
 =?utf-8?B?M3M4TDJYaXVsK2FVU1Npd29hWmtNRTQ0L1l0YXlrcTUwTVJNbDlSd3dlRHhC?=
 =?utf-8?B?bWJ2RHlyd0t4MjBhU0VpZUFJNHV2SmdKZ3FxcnF1MTlFWGZQaXMxc3YvR2FB?=
 =?utf-8?B?STVWcXU2ZW1UeStzT0doeHpVVkdUcUdOV1RFSmlTSDJkS3hZRlNmVmpSM0hP?=
 =?utf-8?B?THJaM0psNDN6UUM1SHIwWU1uZlRTaTQvQVljbEdLN2ZDNTNLa24rWUZpQS8x?=
 =?utf-8?B?dUYzcExTVjJZbjkyam1xNktqb0JyTmNEcDBqZmI1V1FiTEVzWEVpendnQUNm?=
 =?utf-8?B?eURIV2RvdVpSS0FoMjFFWkNNR1pWWmpoTm41bG1IWUFXRTEzeFdEdG1iNWo3?=
 =?utf-8?B?cnF5cHBOV3gxeldSODlvNWRKeDhBWnZnYXRwTTJuWUc3RGxCYUVLR2RSS1lC?=
 =?utf-8?B?aUFrb0dyTDlvVXJURlJQZXBYM1RwRGszNUhmV2VFaU93MUh0VjZtMS9yVDdS?=
 =?utf-8?B?bDBjbXFQU2RoTklpclMzcWtQakNoNHJVUVRBeUlJcGo0dFBSRGxOYXN1VVEz?=
 =?utf-8?B?SC9xM2RiZkNWeTFaRnNBcGNIWjVyUUd2RUhsVFRsQWRXK0h4V3RVN01uN0R4?=
 =?utf-8?B?VitaWkVNblN0R0NwMHc2ZVpkbzJNdDNKZEFQWlIrQjNiUEhQckFOZlE5b0dn?=
 =?utf-8?B?OFVKNG92aEppMWtNbGFVTUtEcnI2emM2a0JhUUFkSFc1Yk9sZ1A3Wi90VGhl?=
 =?utf-8?B?Z1l4U2NyMXFOYllCRDF2Z3VIM2M3dURVYUl0aWtodHVybERLTVdhbDYwaWlr?=
 =?utf-8?B?bHUwTDA2UG1ZZGZjRUE0MVY2ZDNWNkV1MXJPK2d5b1Z2Y2dKbzZBcGRvYUFW?=
 =?utf-8?B?WmxnVjR1RmdrNEE0bDlDNDVXT1U1OU4wUHRIWGROTy8ySzNHTnplWnozNWZo?=
 =?utf-8?B?amFxTlR1c09tM3RhT1d6T09SdHFraXNUVlBsdnFqK2FKVW9Pc2tlUUxwM3hI?=
 =?utf-8?B?eDlrREE5dmxkY1A5S0F3alRKRklpTGs1YmkxdkVFQXVHSERZdXlFTWh1TUJO?=
 =?utf-8?B?aDM3clRTS05ra3NKcWxTcXFYMzdncUNQN3hqZS8zVFQ5VTNKYm1Nc0FIRHAz?=
 =?utf-8?B?TGU5WXA2d242ekxDZkpQRVkvM2RCK1pJckliMmwyLzBoK0lOaFE0TVlnWEtM?=
 =?utf-8?B?MExaalVZM2cyRHNQTXdFbWt5ZFg0MFRwdEZjbXp0L2NpRnA5NnhOVnRYNlds?=
 =?utf-8?B?emo2d1U2eDNJM29uVHJJSkFnb1Vac2IyazBSSWdMdmhDL04yY0RQOW16WHZ6?=
 =?utf-8?B?NG5PT1JBdnlrbUFWMkpJc0VoUDdJY2t3NVFXMkNsZkt5UzI2N1ZQRmJJKzly?=
 =?utf-8?B?bGVXSmgyZ09pTkZ6ZU9oNzNJc1ZpejRSZ1YvTnZ2ZldUWGZqeHFaSDcraE9J?=
 =?utf-8?B?VXo4QzFIcnFXWWJDNTBmekkxREovNFBPbXhTc3VGYXlqNFF2b0l3TmhIb3Ur?=
 =?utf-8?B?MXV4TlpDVS84djNiK0xtR1AxNGlsT2RldzNCZ2xhckNSaWN3TzNvYzVHalVl?=
 =?utf-8?B?Q0ZEWlorMnhOcTZ1VmZJZTlzaFlKbTVFVTVabFpkdXJWdlZuRFJNcFhKcTFk?=
 =?utf-8?B?OTdmQ3o1RlBGNllmQ2VoWVFRYS8wZHFBVUJIUEpiN0gxMjdEbjNCNVRISkgz?=
 =?utf-8?B?VzNmQWVaTGdlZWs0MmxXcVIxeml1cjJ6NGl6OVdhdWxONnE4Y2lRWDNCQjhw?=
 =?utf-8?B?MVN2VjltRXZYUDkrM1F5WmMxc2REMkIzYVk4ZkhjdVRlYWRvbE12UFkzUVFG?=
 =?utf-8?B?aktUNi9nTC9VYnY4NVZBNDdWa1IyV2hoWFBzc1B6ZlpkZFd0V2xQR09NZ0hP?=
 =?utf-8?B?cEdEZC9NU3VpQzEyelhpYWMrb2V2bkU4Ulc5dEZoREdUUXMzalZIZk1UYUpx?=
 =?utf-8?B?cVdiekNObXpqRjZrbi9WRzNydVQybTJ1djFUajhOL2ZsZWJ1SERaN3IvdWFy?=
 =?utf-8?B?OE8zRy8wR2QwL0MxaDFFQ1BRM3RtQ1NwVUNCMlNzTFZlMVdDRE5zQ2c0djcr?=
 =?utf-8?B?d1VxRVBYc0xJeW1adElqMmNSckhOQXE1Z0gwYllhaC8zR3VoYVg2cVdHWE5p?=
 =?utf-8?B?UUV1OXBPVk5aTjFMbWhoWVY4emxWam16cFJMSjVSMHJja2NBazdQYUowYU9H?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9unOMZ30a7u1H629fNs8bBK5KeOXYycog5QF7NmK3bBGqPOKQX0Uj4YaTb9w6VipC32o9bASXpXFwAhFNvn6FCAnIbAm010xOSmjXRvzZ6hzfXvku69YuA/rFGfjXnMdt11D9E2myyVneNFyzmC4AcAitVE7iRtOev5JzuCdCNs8NWXNLpZuychdok5+MI9iMuXcBBZTZBDKP+SXsibqp6+u/hJfX6T1W2I8nizk9BACAB6yoaQyAsu+MBkjqXQIJqLPdRSK0hopiblUISxw8l3bIPgTObmMD00RqozewOfkIyyoD3CFXuzGwtYtMCNRb6ARk9XkL/4IenRDeyvx7wtQFWLjjUkZGysUmKw3KQA8ROAfBXE5GvznSoHDZg5sEfEo27Z3+DQTioqK/gks/4Irfm2eFt/V1Nmw7eWAWXk+0wCs11vJmRnEHBfCW+nJziDJmsDhpVZdWti4rQpDyORY7+0GRl7G+74bX9VNzHkr103Buej4STJkxS7qOVzk9WiIXMQw6m3wCXHTQkW485Y7sTKBe06dkHZGy8U8zWRqoJuebFfHnm4/Ibgp7iAa3ZdkzsfoN1csPrxd9HKXXId6bWeJWrvBXc0lezGgsjU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e04042-6f32-4abf-5301-08dc3d077d9e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 11:29:16.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIsbmX4YT2b6qQKxKa7WkiqIgNxxhF4NTHdXh/xjLZTFSKlhpilfX/Lm9QOXDRoDGsr/9b6I4vEpGYb/vfa+Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403050092
X-Proofpoint-ORIG-GUID: hKAvgLIEZUfjbVfNG8Mrgn1i41fp43gC
X-Proofpoint-GUID: hKAvgLIEZUfjbVfNG8Mrgn1i41fp43gC

On 05/03/2024 00:50, Igor Pylypiv wrote:
>   
>   static inline void sas_ata_disabled_notice(void)
> @@ -123,6 +125,10 @@ static inline int sas_ata_add_dev(struct domain_device *parent, struct ex_phy *p
>   	sas_ata_disabled_notice();
>   	return -ENODEV;
>   }
> +
> +static const struct attribute_group sas_ata_sdev_attr_group = {
> +	.attrs = NULL,
> +};

I just noticed a build issue.

With CONFIG_SCSI_SAS_ATA not set, I get this for W=1 build:

In file included from drivers/scsi/hisi_sas/hisi_sas.h:29,
                 from drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:7:
/include/scsi/sas_ata.h:129:37: error: ‘sas_ata_sdev_attr_group’
defined but not used [-Werror=unused-const-variable=]
  129 | static const struct attribute_group sas_ata_sdev_attr_group = {

I suppose that marking sas_ata_sdev_attr_group as __maybe_unused is ok, 
but less than ideal. The linker should strip it out of files when unused.

I think that this is also ok:

#define sas_ata_sdev_attr_group (struct attribute_group) {}

The compiler here will create a empty structure and have 
&sas_ata_sdev_attr_group point at it.

Thanks,
John

