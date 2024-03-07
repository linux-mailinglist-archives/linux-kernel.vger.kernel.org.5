Return-Path: <linux-kernel+bounces-95399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84418874D34
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA0A0B20EE5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1787128812;
	Thu,  7 Mar 2024 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T4UPuKT3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W4T1pNzc"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31912837A;
	Thu,  7 Mar 2024 11:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810263; cv=fail; b=ZQlq6AoF1MOWmbMh+YXdovWoMsluVtrTkJ8TrRDE7pS3CTB7YdKZWgk8tvHHDNqGl3gtP9efSZ61lzWMKweYgtuVkfq/4/CA4pP0za/9U2wLi4aZj16WzC6wcPrDQK78zSffBA43qo8P4M7Ut3Ztzk0/Hx5FGbSR3pj8XxL7Myw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810263; c=relaxed/simple;
	bh=NUYwkTwD/RN6IwrKB+HHo+tVkEy01+3ghYOUOsdd35I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u55v+IjRbEuQbOH4prq5ueM81wKpJ2mZqL8S017r42Of46I36iQTA9mqlESVCfuFGSlrLzRgG4FUttItTqb8W8YlYzgWk5qhq0djan/US2zvYwYluxl/MvnjdTked2xtiwOjXA70+WF5bUMsFLicPChBHpQMyxCraetGmZgc7ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T4UPuKT3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W4T1pNzc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4279nRaD012688;
	Thu, 7 Mar 2024 11:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OTb4yAS3EOtNEMSAFf9o+tNfyTxv3ihDI7C7lCPJrv0=;
 b=T4UPuKT3Ke9PhhRXr+PES+5oYl479dhKHpcYRVFBujYAe9sZpaLuMhRyeK96sexIFj6s
 kzrSLJxXpGw9LhYUWRO/kzLxk60wb9VrUKtYImdeZSlfOmWo8is9VaCfjKGsS/Fwnaku
 RbJs+xKMrWAGG+JUy4pqyNdsrfed1o/Siy4pMDuyPv5x+uNfk99m8BeNuoUGNw1Kp89j
 NGSags7WWLQgroLnPnH7zpioVwf4P2KDUQzLYV7xjpx3XjBHuPX68rgJChmg50nShYPd
 T+fcOBfmBPUruZRwwvqUU5Lb2y7zfvsvRRWKwX9IUjBTc48608X754+IT7K7MGZFcKZC Rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv0bkh02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 11:17:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4279U1OL016099;
	Thu, 7 Mar 2024 11:17:15 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjb3c19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 11:17:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hT8LucxmR+jrE2FxchLAzA671jWTTqS/X71i9eGR5gTGqA6FI/MXVlXp4EEjyv+OGx/a6/LbR3V3lxuh6VNYwIwGk45sJP4NxHyLKXyoAjkKII+0PhThJq5CB4xN9kFG5oUSdRrPAkr3jHutchkAIwd+/HIetrOKrP9gZH8QE5GbwYdZNcN92fQo3aIWJqReO4OwN+WrsTb1Vr7XUnM07UeVs1sxIINkjnCH2WpYSQwRg0qRKKeHbFxnEPglYcTUQT4hogISVNlLlIC9jCKmeho7oU31QU54xSOAn1aOZLUBgcRQAvZFRUF3a5+xZhABCrha31/a0kvLTgKAIQ7qgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTb4yAS3EOtNEMSAFf9o+tNfyTxv3ihDI7C7lCPJrv0=;
 b=JiRUxyZDR3YZicVeF93g6qoPXqM+ZYcq2KwWFeI9ERji4bR0HyUDDw9cHYQ1gPz1OsbwsBDQxDe3KFaaeNv5WlEgaY3dx4XCQsGBPBE3naqO+nAIBkjtumM78mY7NTI93DQY4OJKR1bZvdEVW4jlj1sq1D45f7DvZVsszReGqkXvxnRyqqCOqWUAkWzrzx0qvXbo7qpxx5GZGLYchiO46kb22yd6XhjXNgSgJaVIWyhb+PtkkAgwKY6oLo14jUyq0+JbSoQgFUQCDdAb5UdFxTuyUa2aaQDAuWQxP+3pcmOpE0veL7XLiCw+4uonH2Qte/Efz8plyuhuIFoVgxWYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTb4yAS3EOtNEMSAFf9o+tNfyTxv3ihDI7C7lCPJrv0=;
 b=W4T1pNzcnicQQwK9KsFkRTTU9alwebHpHZjcXnp4LffG17x+8LHv7kBxEKKh8nazgfeMnxnEZvRgO3tMCDgKPNNh5pDsv3SLwfc2R3EW1kgtEnoKvwST5EezLq4yClm3wQnHJ4DGMZ3KO/YUnMmeb82VrSh5zoN+kmiqCnjSk+M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB5821.namprd10.prod.outlook.com (2603:10b6:806:232::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 11:17:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 11:17:12 +0000
Message-ID: <c1f8280b-3f8d-48ff-b5f3-40c3840f98e8@oracle.com>
Date: Thu, 7 Mar 2024 11:17:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes
 group
To: Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
        Jason Yan <yanaijie@huawei.com>,
        "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Bart Van Assche <bvanassche@acm.org>, TJ Adams <tadamsjr@google.com>,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-6-ipylypiv@google.com> <ZehLpV06mpHxjecc@ryzen>
 <ZejYb4ykeF7Qx5a5@google.com>
 <c3ebaa55-d05b-4f11-83a8-2a0fb85044cf@oracle.com> <ZemQBLMcJP617WDC@ryzen>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZemQBLMcJP617WDC@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 47aa3c75-4109-4e9b-cae6-08dc3e982313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NYprP8Yl9bxVBSJkMVdoylTDeULZhUXjtsakDsZnp2yHvooHoPtiD7qXwZ6tnVfehdc3tK0mx+roqDhKepCNf1NrFWR/ENWur4yckw17NdZoq9+emP0CfwKZLaUoybK6xarqKH2ROR8PD5vtmZEiQZGoflhhSmcMz1EXmrvV1mXEVEWFmarR2PIrb/DE37snYjPB6G9pcMm/IUzI0ns9TTXud4GekNF1uShlWpPKkqQ4C7tNzbNd7gMlmyco4VU1S+BKUUv8yWMyqcVZeUstpttUZ+B9NP46FOEixRgqSSvc6jF0irH5Qnm7oKpsRVTX/RQQHNp9HTvfMsQgUFhgI4igfnit3dvzlVUBK62Vma8IfFIel01s90JEOpykDX3sFc/EuXlYdB+/5LCclux8qxSQ4IuzMQOBkJBtEzQET1OZUfGkROlVbMByhcTmFD5XGSpn498CNEm0qc6NjhkcvnYll9V6QROeaytIaXoLL8bIk4PDlrsZLxjtKhsIbQDxbzR/5o8Hk4FNiDTCpyX6R2ZDx21mm+GyhuQdmLwndDtRGRJ9G2UYopyeiI0euEHfRrLIJazMW8Z2lksnFRceeQTDHBiQUUi+u1pqyNHd4mtdcj1Qh9y4/iboxbRy8tmRaoMB7XHrC/bcIxPaKSVKxe2wXEbN6ae/+QYeKowzkhY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NlVjdktUU0tLdmZoNC9oSFNIM21sWjQzMkJvK1kyWFdpK2xMc0YvQVphWlRV?=
 =?utf-8?B?MWNkdW4ydHZ4OFNXNEd2Z21RcFRaM08raElxMVprdzk1NDkxUjZvNkZidVB1?=
 =?utf-8?B?ZTBCeHlFSlZvR1h4ZURQaVF4cjhKOFYvc1ByQ2dHTEpUZkRnd3pkQ0YzZEx0?=
 =?utf-8?B?ck95VzlXT05vSFhXOG14VCtEclFjNWw0WURoMW84c1Fzc1lqaExsVjBVRmVk?=
 =?utf-8?B?bDFKeTJCelBNY05rWDBnZFovS3pqYVp5aWpiMmh5VVpzU1Z5TzZmUE1iQ2tx?=
 =?utf-8?B?ZVFCdWxZMXVuOWIrNHVOdnVGVU1OQUpWTWhWejY3R0xyREgvSTUzSXY3Z1d2?=
 =?utf-8?B?Zkc1R3pnc05CZnQrL0Y3MEtiQ1RwTlBnM0NWSWloMm5VV1dSV3I3M0JHd1NV?=
 =?utf-8?B?KzhXRGVsWlY3NHBaTE05RG9nZUlDYjFJWGVya0VwOGFTaDNHVi9SUjhLZk8w?=
 =?utf-8?B?cVlBbjV6R1p6OWJaNC9XS3FOdEZySGVrM1VjY1lPWStGVzlqWDlKbkptM3gy?=
 =?utf-8?B?TjBoUTFaRkhoTm16M2FISW1lRHNsOUdnL0hkeXdSVDdsaUlnV2JKUjduUFps?=
 =?utf-8?B?TE5VUEJVdGQwWnZ1bHBXeEJNdUtyc21jZi96bE4reFR5ZktreXJJajN4emls?=
 =?utf-8?B?R0kvMWJ1SEV1YmVYT0pQdEloWThEUHBjbURkOWtndTdJdVB6cWQ1Sys4WDZK?=
 =?utf-8?B?Uk0zQnY4WlFvZWIraXNIS0t0NXd2aWZ4RldmdmdheVhCVVhnVzQwM3NYK05E?=
 =?utf-8?B?Y0xObGUvRWNOMW95VFQwM2dkSmk5dk04TkxLMWdNdEVjQ21iVndwZ1k5bUtC?=
 =?utf-8?B?M1hLUVpPRjhwRVJHanI4aWRKRU15NlhQVS9oU3kvcndIRTI4SzlmTTc1SXZB?=
 =?utf-8?B?M1ZFU2l3MGJ6UzBncXhIanZ6cDliWFFacHo0Q1FhMlRxVjFrbjhvRWJGWjVR?=
 =?utf-8?B?TEtMMHdQaWl1emFpRHQyRTFUbUhYUGEwR05QSXJFMlhkRDBPMUYzSGRleElW?=
 =?utf-8?B?Q3BJd3VqM0MzYy9mV0lpaHNqbERTQjhoNzhLOFdxZVNoSVpzSjlvRlpteDlN?=
 =?utf-8?B?blI2OHRVL2NCVVpteWNNTEVuT0JGZCt2dEpyT1BuSU9hZThCU3lxVHJwU3VC?=
 =?utf-8?B?eVZWcE1wUjRKemdwV3djR3h6bC9venNHYzM4bk1nYjluWEgwbzVxcGRsTWxv?=
 =?utf-8?B?T2xSN1BvQnNIQkZEeHlDZHpQdmhIY0JmbWM2OHAxZXlMYzYxYXVJaVpGZGZk?=
 =?utf-8?B?UWNOYmJzMUxwOUxselhBV2JOYmE2eEtyem92VGdNUnNvN1hCUUpnK2FqTXBC?=
 =?utf-8?B?a0hqdGtjWXRrM1FnMEdHN0ZYT0M3c1N4Q3p5cTV4VnlFMWkzT3R5S1c4aUZC?=
 =?utf-8?B?R05QNUEzLzVlb0UxN1NRZzB1YU8xNkVoS1E1TTZDd2xNd0hrTFNVdXptZ1R3?=
 =?utf-8?B?RThqcUV6Wm9ScVB5OHZweWVZOGVMUC9KOG5YVzZmMjU4TGkxZWxaNnIrbHdY?=
 =?utf-8?B?UWkvNkJ3WEV2Ymp6Qm8yU2g1K2UvSFM0YkVQdGR3ZHJnTjBSUTluUnZZMVlj?=
 =?utf-8?B?Ymg4djNac21haWxZeXpxQnVuZzhaVURhaU90bVM5enpOUzNmYzl0Y0o2UVlS?=
 =?utf-8?B?ZG9mQmV0alJ4QnNQTVg3d2plV3Z5R2lsMkw5WTJCc29BOGZ6dThiMFFsUVN1?=
 =?utf-8?B?Lzg0NDNXM3JRMlhiNzVUeE9wVDdqdThNNzBzcEs1ZE5YOFhkZXVTeXR1RjZR?=
 =?utf-8?B?MGFvbnUxVjJMV0dnQnFoWlJ0cVdLT0lWR3VNemEzVGt1UHhXYmVjTkNQUXN1?=
 =?utf-8?B?OEZGeStINlFWRlA1SVM3MVNYNVFKNFI1NnNZTW8xNjNQWWQxWFFPK3o5UHVi?=
 =?utf-8?B?a0gyclhIR3dnU0h6dmxXTm5ZTlQ5dDhTSFFZOXJtMi84d0s3ci8yM25jbjBQ?=
 =?utf-8?B?YzhUSU5Yc2NXMVB6eDRLSmlkdS9tZXMwSHc4cUg4MXhGT3I1WDRXeUN0L1BT?=
 =?utf-8?B?UVVldDZnQ3VaWkZ1c2ZuNldYckNDc05kaVpvWGs5V2JwUjhOdWdISm5tQlZZ?=
 =?utf-8?B?ZXlTOTQ1bWFEOFlMQlZCaEJIaWExWVA0SVN3WDRyenpXQjBzU0tLK0tCelE5?=
 =?utf-8?Q?CTXUlho3CLDakuN8zZ6crxadV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Y3X9b48xJU6S3LqOlrn0u1OQCiaYg1/q+LA5msY8T4AnVuUPgpwWeALOuZgtjPIrbpvf5FS0/8vlsMPE+Dr9V8l4lu+m7m1cbafZM4oic7wwVR4O6SKNjoB1OkxuJtqAvkNl1IQqhhjs2OXmQZu9b3bEcT+j7uLp/lun2IcJ91Chvb1WudmfmMhxo+dS5gEa91qAz7stMF7rfH5KiEOt0y4Rqu3IsP9VzqkhKPDJ+jQPklwL3ToX1CTB7XrXEjsGjPQDo4r6FDJRAzMeZcrMPb9abiz3ZlqYOPZWnMZMz5Tc0HtK6Vj1H0kIwTnytyOyl2Xihf6RozW5Cw02/q52fMdZSnkglIlhus/MqNesqTC2wa11zCqoIfbzakhKqcmRrnb1brfItwFIPEoI6VXJ2fUZfEljpHYU9l7voZ82HHhcKuScFFWiosZ5UNeqXyBrG5+PUhSPkjFpec+SpHhIDAYEGY129BVaumpM7Ipaz5HsiifCjkDG7nsMFEoZwsBuwAOv6NSEFqGyqCPHlAPXCmbA5gQQYvnmhw8PgjkKhgOWNxVqEV/dTXkhLZefL2BAtxbgE2ZfHehbUdazoiVeEbi5yFe8iwfPdv2dmV5CZuI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47aa3c75-4109-4e9b-cae6-08dc3e982313
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 11:17:12.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0PTQecoo68nefMLdv+nO/BUDPXXvo2N8kw7JahyH4yZ1QF/rlB63KWDgaLIDf4lG38diCW5DXDal5Sd1cO52A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_07,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070083
X-Proofpoint-ORIG-GUID: ctlxi-3F-hA-Dlo5CveDkSLvb1wIpJsX
X-Proofpoint-GUID: ctlxi-3F-hA-Dlo5CveDkSLvb1wIpJsX


> John, now I'm curious, do you know why hisi_sas_v1_hw.c is implemented
> as a libsas driver (instead of a regular SCSI driver), if it doesn't
> support SATA?

Using libsas is not really dependent on whether the HW supports SATA/STP 
or not. It's a protocol layer thing. Considering the SAS protocol stack, 
HW for drivers using libsas have implemented only the lower protocol 
layers, and SW, i.e. libsas, is required to manage upper layers, like 
Port layer and above.

BTW, IIRC, v1 hw did support SATA, but not STP, i.e. directly attached 
SATA only, but the SATA support was even more broken than v2 hw (which 
is quite broken), so never bothered supporting in SW.

> 
> Was perhaps v2_hw and v3_hw implemented as a libsas driver first
> (since they support SATA), and v1_hw support was added later,
> so that it could reuse much of the parts of the existing driver?

v1 driver support came first.

Thanks,
John


