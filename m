Return-Path: <linux-kernel+bounces-88382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C34A86E0D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1823286ACA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE056D52E;
	Fri,  1 Mar 2024 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RfhlYots";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CnYd1/Df"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9F79F1;
	Fri,  1 Mar 2024 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709294695; cv=fail; b=XwmT2IdxpMb9TrRAg69ceV74SddK2MZ8voTPeEaYGOzv2Bcu1D68cYZTJYXKHFrGaT9TCTWZmkJo2pg+/Pq63MUL62OWCRA7zyv6HpFWEwG03D3K1R0UYAnnf/EVBuR3VIUlQU8ThW11c7MDEdUHNtyLxtLOLJVihMmO+4wk/JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709294695; c=relaxed/simple;
	bh=ef90x1vek6XGygwtiVkm2kxs4YFhAXR1jn2RVO5tHDQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ChcaUCOEnZEbX1rPce2ANgdznuvb6rK6iyt9k7ufYGd8ctCNFRHi1v1QEq2zh07gHxukv36MVNrF5RVZteuVD3/TBlGK8QScfJFqxHsnfjQVbJGjIqJ+o+k23h+5HGYqh4zGlEycqY4Eb1w/+8wvnrC5gQ/GTD3mNo4lCVjqelo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RfhlYots; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CnYd1/Df; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4219Hwxs000699;
	Fri, 1 Mar 2024 11:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+ae6kMWUsCATFSOS///ArNYgx8EmzMVGeFu6lqY49wE=;
 b=RfhlYotsHxbjbWfFKPB+zuBfDKd81wbVtSeSx/+s4bJJvD7aV1LkaY6JgHawWRVxgnFH
 pcLTaoVzj4g0v6HCXPDivo5ws5RM+K+ykIj+PfmDcHKs4JL0Rohw5+vKN8oXhRXSHeem
 D0RwE863PFoe5lIaBgsCHUPfEMxaOiqmN10DSGAvjXzvuxxxuny4aTBLsDdfwMMIExqt
 IU9j+uZGWdf2qCyRBHeH/uSjDz7wH6lGW2E+3CJAiNuWAeC3b+Q6oFi1xEd7GoEtEJhA
 YyDs2lPJYjzScQYIHVytZd+lw1mEdgSlYl+i0ofX2mn89t+X/puE+kuZ8fSa1PgTLRfW sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82ug2jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 11:59:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 421AwLHh005714;
	Fri, 1 Mar 2024 11:59:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrrbxg5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 11:59:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4ahXqLuUvRJN2hcdwpZWNG9Iv4TMg7wTBTY1s3B0oLDv4vmliFIVDGWi7kibGP6Ng7RSfwdaYVJ/ud1FIssGMHVrEsygaqzw62zei/RHKz5cCdAOi+K5emRoNFQvdgmBfTDPT0fEOsyvltx/4V6wb120YNAqHfLopETSJCiBDtNFy9QP1gz43c025ntr9u4R3o7ohWc8DpSrvf1wNOYW7Y+HQysTum8T3h4/jfS7ZtXdgmQyUUzEo26Ejn4KgeNupGjSXXGl/KJ17XrCunzGv4+Yii4Ym27CpSLZA3IA90HP/80ycd59fizgaNKK4RU2IOsxshD4HgwTfpyMM1B0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ae6kMWUsCATFSOS///ArNYgx8EmzMVGeFu6lqY49wE=;
 b=ZvfQoxb78moYuF9HCVWYIQMMsa9/KclBkV+VCca77pguSQ/O8TOg7k2Edd4CumROkcJJys7juT0BS4+0HmxlnWoqSudrTW2sRX7akbt7uEp+FDBYbJ/zz391AMyoSHnOAGHchWQJkHPZ+GZMq2neT9tnAh8AFX1EKFtxZlNn/rH/vJBwCXeOiDwptyC6rF98Eohxufr32heGV1X/WD7UyG/CtofY/Z03tH6zR2d5C9wfoov8L8a/XXzb9gVvwQ1HGZGzXyZpLxVEY6QzVejqB3p5MIqdLs2XJqQd56Ok/Otd63nMNvZ5qtGRDvK2+8aRpX0gt84zjuI15i2R2Hh8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ae6kMWUsCATFSOS///ArNYgx8EmzMVGeFu6lqY49wE=;
 b=CnYd1/DfSNFq/F25EWhJMU2kJIv4vi+v7PiS4tsx7mfeIB9Xt2n0lQz9MsFvjFw4NXGGk5MEceZSF/3v3PHpBF22Vg+o3/pO4hwaz5cAabh+B8UQJCdJBVIxo1aAdhln8I98tYCe+97d9kO76i4lRyhnf/k/GLa1PuMEGng9QKM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV8PR10MB7823.namprd10.prod.outlook.com (2603:10b6:408:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 11:59:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%3]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 11:59:06 +0000
Message-ID: <dfe1b3d3-379c-4f19-b580-f280ed89c7b1@oracle.com>
Date: Fri, 1 Mar 2024 11:59:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] scsi: pm80xx: Add libsas SATA sysfs attributes group
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <cassel@kernel.org>, Jason Yan <yanaijie@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, TJ Adams <tadamsjr@google.com>
References: <20240301013759.516817-1-ipylypiv@google.com>
 <20240301013759.516817-4-ipylypiv@google.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240301013759.516817-4-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0032.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV8PR10MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 737b3f69-eb0f-4566-b91d-08dc39e6ff2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZX6jPpbGwkDMatv5zcLAQljAa5rdEEJrkkjH4q5CBi8tjns3T9Pv2RnUNbG1lXdgSEz8qGz8K4Np2UyLlKKwWO0cExremnei9NYwk+lEs16y/tNxB2IOT0zqHMSw6s6yYZGG/u3b/rFiDFK9/fmpo4PU5LlJxY0e60NsolHrw4Cr0nwtD6i1fpYL84BA2tIcqzExDF3s9zDbLUgBff3Ojl/O7MJ8BWfCcnTdK8UqDLiNHXVMHgT8EfkLs1MWzEYtQx9rPq5o9FXaMW7ntNVlq7/fop7G/kX+lNZ57/TfVnUBlRcbKlMyEBP1EV1M4z9f9hRnS6flXuZCULqbtXGKa050k+gFDlZtdNvz3pDFryFpnunzHnhYRHcUqbSRXoKI4pD2Oc5uA6ZQdDB3/no8rZ9DQYPYZSfI5Ag/nU5SczHWprDd7ma8Cw8byYzif1KX/Nl895Gn6xOQweAhc7por13qqxGWVw7V1vPXgZxUEwFwlpa5QqXxq6Nwfrl2YUoF32l7en3wBSSuRpsfKciHa1viom0GOoMUaYYPQFqtlrdqBAeFgET4Y+ELLBxqY88e03sy1aStqr7To5Ix12Za1D08h0KH+0AgfmGUBNkrWvlVxmZ4xu9sjRVM9yjpZs20cElEWOc6n6AlhZ156g+gwA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YW5pdU1vSlkvUGVSM1E3UC8yMHZQU2gzR1BZdENjRmNIdFhkQlc3dVdJZzli?=
 =?utf-8?B?bkk1bEdzRVo4SHQ5d1Q5VHZ1SHlHNWtiL0RqRUdtWUpJbmZwQnFZUVhjTURJ?=
 =?utf-8?B?R0FBNmVKLy9uS25XQWpQVHowZXlLanJucldIOHR4dU5mWERKVWhkeEJRMmN1?=
 =?utf-8?B?SG9DV2dQRGFuN3ZuU0F5c0R3clFhalBmMU1UdVBIWCt3dkk3ZUNoeG1LWkJv?=
 =?utf-8?B?RG9ZclNtWlR5bUVkdWJrVzI1Z1ZpQTRUK3hNYTRqQW81UEkwemhsTmVuVVJE?=
 =?utf-8?B?bnhKemE4dGNnemlGNWNONlFaQlN2bEk3K1F5VWVYejJ5QWwwSHF2ekJiN2d5?=
 =?utf-8?B?bGM3V1hUMkYxc0xBcjluUnk1b2xHemdRV1E2L3FjbnlWUlVXQU54TVJBanlY?=
 =?utf-8?B?L1BCWHNkMk9ZVGJIKy9nRGlCaEJHdDZZQWxKcTFNOTBsOVhMajRCSWNuNFd6?=
 =?utf-8?B?SERKQ0laU3FIa2lGaitOSFlIU3ZUOHBmcGZScHlibitmZVZ4ZWdyUGlXWnVI?=
 =?utf-8?B?TGtaNGsxZ3NTOGhGSEk1SjNWclcyaUpNbWFmOWF4VEpza3FsWFFna2E0SmRw?=
 =?utf-8?B?OGQrcVZibVlqMlcxWkxWRXExQm9tOGVjZnB2aThqQlJLR3ozRFNqNlNEYVh3?=
 =?utf-8?B?cjZLZTlTbHZUeUM5Q2pOYzFFV3lRQlpPVVZJblVTaUw4dUVvTnFWRUg5TEd0?=
 =?utf-8?B?T3VrRDNuajZFZ1ZUZzJiMFJXVnpBaWJuRWQrU0FKaGVuRUNiRnZLRnhFTFFT?=
 =?utf-8?B?SVJqQUNWL2IwemdWVkFldXJQTXk4UnY2d1NFbm50eFFubTJTV0tlN0ErY0hu?=
 =?utf-8?B?VWo1TTBtZk40WEF1Nmsya0EyY3l5L2Rmdm1WYmU5Q1lpRlVBR3Azd25FWHds?=
 =?utf-8?B?VGZsdE53WVYyeWtUVEk2UXBHUjhkNGxyTDJWLzl5SGZSdE5YYnRnb1kwYWlh?=
 =?utf-8?B?eVozSGhQb2lISDc0MTU2cDNnbXFDdTM2NnNOZnBJZWcyaFplenE4bmpINTlF?=
 =?utf-8?B?WXhKalMwT3JxRUFQMXdsUkR1MEtQYUZRSGpVQVpoN1I2NmFXVGJnU3BrYmFC?=
 =?utf-8?B?Mm1CSSs3Q25WWHI4d0RkSDVienVRWWxOV2xHL08yYVkrUU5nNDYyQmZ4NTJq?=
 =?utf-8?B?STBpdlJjQldmK1I1S25ROFNUNGpscC9YM2NmKzlYRk01RVV4UWhOQlVYMFNB?=
 =?utf-8?B?Q2JzZXkrVDFJQ0ZYVTdnbWpXTDdCMTlTRDdLaStwK2oyYXczSnBHTmxBOWRp?=
 =?utf-8?B?MVVQaW0yM040dy9vZ1dYdkxFbXBvcHhTNjFjYlJzcCtpcnB1QUJEUS8rQzBX?=
 =?utf-8?B?c2pZVUhHeGgvWjNtQURxaGx3ZVZuK0wwNEt5S2lBd0ZpaUJwRzJhUGUrcVB2?=
 =?utf-8?B?N29LblBvelVLcW1KOCtIL1dTOU16S2hpMW9BTURhWVRoZzlEMXRkU2ZYU04z?=
 =?utf-8?B?Z05HMmNHMis4RThueGVCSVl2Q1hQb2xtUGFhUFludG5DWldwb0QyYUZtQm0v?=
 =?utf-8?B?NGZYaVU2a3VzR2g4bkZpcWx5R050TFBEOEF6M2x1V1NxbDBVNVU4WTVlWDRy?=
 =?utf-8?B?YTJkeEhubXhuOUlqanlQSXRkWVN0ejlNYjZaTWsveU9WUW5YbVowNkVKNnkr?=
 =?utf-8?B?U1pLdmcyOFlkWWl5cGVVWm9nb1FNK0VjM1pMSWFqdkthc29uUUtYSzJHNFgx?=
 =?utf-8?B?dTBVV09PZ1N4bWFTVktxRXQrbG1zSWZCSUluNFBFLy95K3RIdVRSR2tWZkpR?=
 =?utf-8?B?Y0MraDJxRlBTN3NRNTBOVThBRlB5YmtvMXdTaXV2RzlpSHMwaGZ1amVXVnds?=
 =?utf-8?B?alpOVmxFaEg3RkNhZjRkc0VLSmZQQUJ2RW54R0x3WUZKZS9CTkhPL1QyT2xm?=
 =?utf-8?B?d0JFNVFSUXNmMFoza2ZDUTBnaXdrRHJ6elRpZmFpWVRzb1p5WlVwUFRhbDJr?=
 =?utf-8?B?dzJSUTdocWRNd1p3aWVZR1QvMXBYZ0ZMQmR6OWJZN0grMy80elRBVkxEVGt6?=
 =?utf-8?B?YmNlc2UxK1p3SFNiV1dQeU0raExrcVNhNUJTM3MxeDhsUnozTUd5ay9HanVj?=
 =?utf-8?B?b3pibVRJU09aREFSeWcwTFVZNHJEU0tUaU9EN2JPOXNkY1ZqUGNiRTNCeEgw?=
 =?utf-8?Q?f1CVLKpD2aHdsctQwe+3QrOc9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WS1UWdbL0bincP+H0p67jYwW6lGAC2LoKCtl+/J3u3tpIykVW6R6jlg86eCzg1q1q0h7ok2JQBrgHF1w5L0a0q3FQeejo907NSoqV1gesgxfMILmaQY67Bwh5SqisgjrsbDJamPlTSOyXceiMz3kR/QQnNaG9GICn5d5gF8v1OS7IzMJ9nUJSQtQmrRWWF2ikGMEroFLEESQekpi1jg9S9xjYxM9RyvhH5K8GoNn32al/+Vr7azM6B5dRJ1NnrcMSKr1axPJdtCzYlwaZIHpYsK//s5SdWLAZTBmIIskbhug6sgPnLRtPZWkIXYewQxGgDUwo24IK5h4Cfx2VP5a0WuIOF2CvKOC9tYvdJfwykfxMOfOWgO0T1kPVNpF64THqXbFByJhJ9VVEU5/ifTZIoFyY5zK8lbiWdnpj6baowFu0rDUKS+aXCqEqmiU2nVdWwik9yXbSj1lCjvD8Q5jKCh76EXUDu7mWYQeHJ/GsmgC2zthUismJbpL+OxoRy1LkrnLB04/e/DxfXmqb4v80aV2qjN+R6LuuhYK6AUOj/+FY1PTP+UL5cqXqOQquy/Je3FmZPsEjUJQ2LO0eD573WbvJNDP4L4y+FzWf7/1z/o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737b3f69-eb0f-4566-b91d-08dc39e6ff2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 11:59:06.8315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZJmGcu10FtmUemOM8+S3/uVPzuhJExr6G5CNArnfKm2v1dLcvcHf6z0xwzH47wwQwyi9rl8JmXTWv48NR7TEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_10,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403010101
X-Proofpoint-GUID: 2fX8XHrD6ImegeKNktgoC_JGn51wwvHw
X-Proofpoint-ORIG-GUID: 2fX8XHrD6ImegeKNktgoC_JGn51wwvHw

On 01/03/2024 01:37, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Signed-off-by: Igor Pylypiv<ipylypiv@google.com>
> Reviewed-by: TJ Adams<tadamsjr@google.com>
> ---
>   drivers/scsi/pm8001/pm8001_ctl.c  | 5 +++++
>   drivers/scsi/pm8001/pm8001_init.c | 1 +
>   drivers/scsi/pm8001/pm8001_sas.h  | 1 +
>   3 files changed, 7 insertions(+)

More drivers than pm80xx use libsas and also handle SATA devices - 
please make similar changes to them also.

Thanks,
John

