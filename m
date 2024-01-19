Return-Path: <linux-kernel+bounces-31503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20480832F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89404B25D0F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DD65466C;
	Fri, 19 Jan 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NVJwChyX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JghTTc2S"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AD61D53A;
	Fri, 19 Jan 2024 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689791; cv=fail; b=IOuiYZHyawQFvBJnmWVi4/r5krh3oeiLdMqbmZyJdy7dtN+9OQIiYVSuicPbRVlpp/t7m2BsJo9MQFu2xZUo4VcVen6BFcI4om7isB1jgOTwlleGa4ERcXYKhohNHb1Ef7ufGFKt4c63Tq8DPLnPkRX6R617GG7cEerY58zerws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689791; c=relaxed/simple;
	bh=5K13aAxPo7LWLlZqhLYQ61fnP/e7rg1pb1tzcTclcm8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RogCqOvgSUU/V0f2lwarfJ2hKTe7k8tlDKkcIfpsNPuimjzvbzyDQ6C+05mgUwxq4HhdKkCPRLqw4uR9hnqSHq3IkUAvwnJWRp30gPs4gmTo8fxeh3l33zgSaY2KB2sZ6YK2zFI3O7opaLM2zCZLD9Qw1NlmD0m8qt8IKYVKdmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NVJwChyX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JghTTc2S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40JGtAe9018955;
	Fri, 19 Jan 2024 18:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=UEkPQJnEZNg2Vh+RE7w8Ze9ltJnWwYAlZqH+u+cVeFY=;
 b=NVJwChyXHyUwTmn6hLsz6cM5bX7Q//de4sE5RrvEhtIYqn1oI+nXRww6KoDCRGgN8ZLH
 RmIO7Mhso2rt5cccVjjCjB0eQ3una0HBcQP2xuzUThJzIY4o1CDt+cElPGkrMLMEkT8R
 Xe4OfYk9czMh3MXWPJLLv/l+NVj0WnUOA48tHqVqXme7Wi4hEM01HQ0VxVP66701y6C6
 wCcRUI0doxc0SXbH7REjBqR0VFZGZPFL750ilyy20x8ySSNqmC7f+FzJc5qxFVFd/ySr
 wruNubk2pIePl5X5el9v5rP85KVZj8oHaF+kIxaYenQ5LxcuBQuG3Z9r61EdmHGSJ355 0g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkjba7dsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 18:42:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40JHseYI025823;
	Fri, 19 Jan 2024 18:42:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyg7fuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 18:42:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FipT3Ym7htH/mRYAIDpv2Z+n32Tql4bLiFX4vyREJmyVBSv5NE2dZF26IEj1oDl3T1kPUIQC3gBb4k2BnPd5Po2eXeMgAzRZe5u3inN4U9zySA75T+uTY08ZAM2QtZltl5JyL4npkFVQ5CU6z1zUccZQ5GC8l/vf1aGhAK87aA5HYRfccTs1IafbJ6XEOcPYlwXqDBMOqNvnA780/PIIUSre7nroiyHWvKUepLCh2kf5v5UyTVoJTburCISxCsO27KbRvWRBnmTuxHb7c03QoWNHCxCqSZZbvMjEgoUqeH43OBJSf6H0aqMGvrf3qVj8tm9IjPS1DiQ5TJ8BLUCauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEkPQJnEZNg2Vh+RE7w8Ze9ltJnWwYAlZqH+u+cVeFY=;
 b=HRD3OM25HpfXsc8D2SiMBcrgKb2PDTo0SGbynkoMXSZU9BN75XQgYvhQJLcZ9da3kHUO8RCphSYLzTwG1k4LQS813DulQDCadXSJDIm3Iqc0NeWVfX8zm5b3WXp85gu54snF+WxEvYtUXCh+olMQo/DSSawLvJRZQLKi4aH4ZVddpp3bxOvPMrc1BTTCj6bDPAX6FKCK183T3Lz3o92yYq20ejWB668b7P0rgc3rBZSteXoEyv81z+CPF8IlZ7fjizf36D6N3tbSW2MIrkP2erSIUNg6Byqf4D80OdAAHyPFREBU/OakhT1MoXnIMcTBi7GDftnE2e9kWNVtoAceKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEkPQJnEZNg2Vh+RE7w8Ze9ltJnWwYAlZqH+u+cVeFY=;
 b=JghTTc2S6Ohz73Bz8KUe81qdGH+nhqkSh/Tr4kk960tTMDgy+hGIURKhtAqv2gi7xxwUwkX0DAQjZj7UgwMph68w8rIBzcuxzAinf46kpNo078q5sUE2IkJ/R5tGgOqwZ44PF/DZJIC7UrMYwwDJxGfHOgcOCszsMo1GaiovIjY=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH8PR10MB6622.namprd10.prod.outlook.com (2603:10b6:510:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 18:42:23 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 18:42:23 +0000
Message-ID: <2eefe89f-3d96-431c-8dac-72c796daa65c@oracle.com>
Date: Sat, 20 Jan 2024 00:12:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/150] 6.6.13-rc1 review
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
References: <20240118104320.029537060@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0014.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::11) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH8PR10MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: adce1275-b19d-48a1-9a6c-08dc191e6037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zbM8McRTsha41eQtoLQ1id3FbEQcvV4P83VFYjwBAZre4OZMJ6kW1/GityaGQr2/iLwcJFZRntu/g4HjF+ObHByA80P2peQmVa0mQ5821LgKoFw5QgST4Wj3z95Lb5tLaCz82nDtmM0UVmCdhbM5HyscK2m/JQFXWU/ggV9FX8DNNEYHzSlrJz1zJVgkuVrrIBb3LZ5byEmT0j4/GUWZU8fA7f1d3IXMvWwNiOee7dPAWLeRW0oPr82GPQjW5P4tM/EPFGVbJABBujfwMSOf8V6ettbR676U5tKanKUIPSzq2yPyHAcwTAxNoY0/aAtKAazCh5hfGw+bIuLoXVw1VBWFctN8CqwPGCnLPfdcRy7GGrph+Z8XHjo63uaxM7TqGOX9mMqExReLXAawvQFmGs+EQKa+Wd+uUrpn4Nm9B3q7EZeYcan0ARlPT2p+WnCweXBy8ZKennXsBcWVy6oNrgX7y1xGqpvRS1ZD97wJNGPzGC92wrRWa3gl49eC39HsjXo0ohWwzVMbLXWZbYvrhFPTFGcDa69uWXYWAjrX38DCLQFER7J1BhsM8KzXLO5OWJCvY6ZoH7fYxrNGngBdcI22qoBoGbbgi4hZAeBkmjwpNGglYB/p1RbaOaUOFdinZv7xdqrVYLg72QuUdvq0rw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31686004)(6666004)(4326008)(5660300002)(53546011)(6486002)(8676002)(8936002)(2616005)(316002)(966005)(6512007)(6506007)(66476007)(66556008)(66946007)(478600001)(54906003)(26005)(107886003)(38100700002)(31696002)(2906002)(7416002)(4744005)(36756003)(41300700001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YitvSVY1QTZxMzgyL2l3K0RBNzFSU2c5TjhQTDFhV3dDNVl5cWpQOHBsTFJj?=
 =?utf-8?B?R0RLTFF3MnE2bUhlKy9VYW9GaUtNMnNJb1lVNWtUVnhwTFU4MWlWalBGWlIx?=
 =?utf-8?B?bzlxK29na0luWElPL1BRRUtKWXRRbTErVDVBcCtwNG9aN3ZpYzVyYlhrMnpv?=
 =?utf-8?B?bmVFelJEaklIN2V0cjRzNWtyQ1FwbU8xUEFaQzlsaFhLaGNJS2k3dCswMG5t?=
 =?utf-8?B?RzQ0endkTFpGdlIzYlNzSlcycXVIbDh4eWFQT2xHbFNMbTA0V0JzU3NPTVFN?=
 =?utf-8?B?eWhlK2JKYnAydWZxc3BvME5GelFMZUpaL3Qzc3pWN0VKYWFSYm1zOW1GTGly?=
 =?utf-8?B?V1o2UHZLUWlpd2w3bC9TS2tIcjA2WmE3Mms1bmlYN3IyUHp4UUpMOTZwc01y?=
 =?utf-8?B?ZVhHd0tjR2NHbFd4anRqTE1WK1lzeGFPUzYyQTdHTjFIK1U2T0FJMmt1U0lj?=
 =?utf-8?B?R1plWitvZ0FjKzYveHZlR2dVYXJFeVhnSHZaU2dGWnVuemhNNGg4N1ArMTh3?=
 =?utf-8?B?SVlqQzduWEY0alpzbVh0aDdSM0pIdXFhbnNYUWtrR2Nxby9wQU1LQUkzaENu?=
 =?utf-8?B?VVlRK09XVzExY1NXZ3BWc3VPZGRleTJNWURFYWpYb0RTd0hvV0w5QkNLOEpi?=
 =?utf-8?B?L1l5MHQ2OXhCbExndmJHMWhSbSs5RDdpRDNaMk81ejcwQ0dhd3Q2U3RHbkhK?=
 =?utf-8?B?a0VtbWdVVUV3L2hmanNqWUxYTnRLSXl0NEcrR1pzU3ZlMmFBU1hvbFRFS1dZ?=
 =?utf-8?B?ZmFvZExEckVPbmRMS3l1V0M1RUJWWTBFZnNFVktNY2VYYm5BM25wR2JRNUhL?=
 =?utf-8?B?a1ZtK3drZGdpNEdVUXcrblJCS0JnRTFYdFBjdFI0UjJEeGVoQU9yOUFiOW90?=
 =?utf-8?B?ZDUzVk1BNnlGdmNKb2xDeWc2MGpVYStSUDcvKy9VLysxYnVKdTNNYVd4UFlh?=
 =?utf-8?B?NXRzNkQ3UGxBM3c4ZlhYeTdiQ0NRS1lTVzBBM2YyZ0hHUWFtbVlYcnBlUnNP?=
 =?utf-8?B?Z0ZEZWRDVnpxMHkrY2VIWmRURTg4TWREa3JUY1JmUlptUHB0emo1bm1JQjkw?=
 =?utf-8?B?SkFjcDVSRjlyNXljazNBcWZydUU2UlNBQURnYlJxak1UMVJWZ3RZMHVJNUNR?=
 =?utf-8?B?WmkrdHllS2x0YkxhbUtaQ2pNcWp4dE1wVjQzU1M0U3RBaTJDblFvNnkxRU1s?=
 =?utf-8?B?azdadjdQaEs2YmgybnN2WVBOeXoxNTVqYnNwMlg4aCs2c21DU2lqdWFnWnZR?=
 =?utf-8?B?ZlIrQVNaS1FVSkVaazN2aHRqMng5NEptUlFoNlMrWG1laldrQk1zbG9CVU5r?=
 =?utf-8?B?dUpYbWdoVlFLWkIwVThBNGRpZi9FWEdWcEFONEVIQWFZcXRnTmdqeFZoekZE?=
 =?utf-8?B?bUpFbmgvN1hwZmt5dkhqVXpZeGtHV29UZ3A2WFNBZGN3aWNUenBrMU45Q0F2?=
 =?utf-8?B?dUs3cjhaRkVvZGIvSldrUWRGMmUxRW01TmVlUzNDcmxYUFpmejhFOCs2b2E1?=
 =?utf-8?B?OWU5ZnNEekx5dU1YUXVRK3QyMkZ4bFVpS21SVmlMQWVkUEVhVjFReHlMMzVy?=
 =?utf-8?B?OEIrbGJPb1lKOWhmTDRpSkZOYlhDdXZsTDEvN1VERFBIU1hHT1FDOXNnWEZH?=
 =?utf-8?B?Y0tUMDNmZmVraVBSbFdrd0VBeFNvdkQ2dVZ4SkN2NG1tTW45YWlYb0R0eFFQ?=
 =?utf-8?B?U2crUFVueVlBWGNPNC80aVZYdVRUZSsraW1ITDFqNFpaa05LSXptdDNuUWJ4?=
 =?utf-8?B?QlllV0RFYVRsODhpSmorYVQ0THdHL0tuS0d4R3BvaXhJZFpwQ1Bzc3Arb2Ju?=
 =?utf-8?B?TEtYa0RCVGpIeTk1aGZOZU5IcUUyVk43ZHRMWmFPZWd3TFZ0YTRHY2g2Tmho?=
 =?utf-8?B?NStWclNrL2RDOFhjQXkyd2JvNjVETzZOb2ZjbFZDN3p1d2NaY040NnR3bWVB?=
 =?utf-8?B?MXE2OXBIL1ZBdmtObnJrRDQ3NlBUc0FTc3V4SURiWWV0Z2xwMkwxMG1lMXcz?=
 =?utf-8?B?a1NWS25LRFZRajJFanI2SndiQlpQOVdiemRmK2dxVVBpa0hoanBYMXlTbGlV?=
 =?utf-8?B?OGpFd0pZY3FTZzVTbTZaWnVPek50VEVFK0tvb1NSaUFyNmcyQVRkbmZWcXMx?=
 =?utf-8?B?bjMzR21idHlmYm9jRUFLZnRMUklCQWZhcFB1QzI3RGZnMHlyMm5KUWhoeTdK?=
 =?utf-8?Q?DSJDlAK/tddyaXW9VW42R+o=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JaHbQxHcHPxaP2qia2/OoS++JHBLQ25BXAeQW22olof8lV9bK5jrkkcEZe3FTvWQga/OWqEMBpTCL8tjPb59RadP8gtJpI4xBSfcf47WJChQUMh1ASifZzr7OOnPvLR2IIQqWJR5kIq+Cx3Aguh3phnMRDkdqvCVk+vCtjS9l8zadCEz07odHHehJrQOb47zrnVRhNBWCbmfiHEMyArr/aM9/OnGqiuSuAjjg0w168fPfJnhbHiakpjqmplf7lIRidraZ/w3qGbTcXKJthCCwt4xuMw1wA8fA8/QX+TALuxCVwsw1HO6Qq/6/5nnZJkZeNz+OlTS876uO7bgTM24MvmeSgtWp1q8FO13siifgySXfU64hPTVUed+XuGIP9voADMaglwkXG9CWcuUBMKTnyebAPtsX6/+3hiM4qe8IGF3ui4RJB/Fi2PXSZZoQfFbtPm/+7WjcBkKls75mcJBQt89632CyX40/7bkulwYgC+BcrejTm7VD0p2BNmeY2KBRP5kP5LQUDJgkaFmcyDryey+NrhmdSHcs2Wj1za1xlcwC9ub/aVp8vBxZPRjqwpqzI8kDkRu4gXwtMhkHSWsM7boOlevyqOXowq90M/eKgo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adce1275-b19d-48a1-9a6c-08dc191e6037
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:42:23.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNlxcus/h8mfMvIEVOe7CbchkjX/9pz5ys/T54FP1kxLfuJswWG9oky6Q6Wzk9iQKIFVbefPS9NkmTFmRG+RSwqQBQO2HPQCG5KE7tDkI2P094bH0ta2Js18cWlfAu73
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_11,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401190109
X-Proofpoint-GUID: _df-ywI5jGUFm2RfEsyGJD3bVzeaMf9f
X-Proofpoint-ORIG-GUID: _df-ywI5jGUFm2RfEsyGJD3bVzeaMf9f

Hi Greg,

On 18/01/24 4:17 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.13 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
> 

Built and boot tested on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

