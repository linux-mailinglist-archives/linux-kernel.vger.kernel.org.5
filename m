Return-Path: <linux-kernel+bounces-142473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA96C8A2C03
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A7DB221BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006AB53802;
	Fri, 12 Apr 2024 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bSjSEzu1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LUfH9aGR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D02D41C79;
	Fri, 12 Apr 2024 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916730; cv=fail; b=gucw6NDtGqRwAj6WO5nSTfNOL6Xpynp/euoqV5jYZAXxH+VMseFt5Qmg9YQPjDebIG2U//ywZ00/h/spOYQLg7KCN7mtfWEZS0tfvFnmn4oLzJlbqd37r0+HBUKY0DafwQYR7lpCcqxeVqbSmnhOckCjCwEZU2T26xGjK/tp3Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916730; c=relaxed/simple;
	bh=UjbFw52A7e5nlyD7J6qv0K0YP0HFM8y1TdR6ELmJcXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oxbmW3CTMOe+De/pESnopS5cdeCwpTmSPo1HHMBIKS071w/hpHE1uHN+XkzivIwBawCe+4alo9mRafnjhsh57/x2CbBJaYEza33oYSEYvLifJQIKqHOeW1gpwIw+J1IgroLa61cV0/cQxhU50vwewb2uTYFnXKavGt0pUJmOUU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bSjSEzu1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LUfH9aGR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43C93xna026498;
	Fri, 12 Apr 2024 10:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ly7J3wvMmeGA4Ozsb7SeCFyyfSDjjSRbFejXZCHXywQ=;
 b=bSjSEzu1OYcoPOwlGK6XCo/Slap37rgy7roN5+UHiFIiflBYdU0g8HVVj1Fq85WrF05T
 eU6kjAUAO/cYt86/4ZH/r21I1pzcj4gcH93LcGmjs8t+MFf6QvMhA+IytGXcOTrx1LbX
 +4o7dnRn/9hcHbFrzX9YEdnLOo2lmnRR4+U4ntYoRnKGxx7ci7vcsqsyelrep7qDhpJ2
 F+/AptD0HVAIIzTrrdCeU7NHSCMV0Nltu8zVdnWr4toViNa05BQcKcNZYOMAA8eHAdzb
 P2pPKSIHvDdF9ixkLoRciXOzb1tqHvIoggFl9XIr4upoHNkGYWw0wSELQNLPGkWxdVb0 tQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxedumwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 10:11:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43C96SQ3026429;
	Fri, 12 Apr 2024 10:11:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xdrstvrf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 10:11:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJiDQJULqQQVcTwzDQzuR/mzHU3ZJw9Ee8mOMfY7Cnb8xvmpHTznHWmrVSoxOIe+I9l1ylXV1jfeOyTdtJMY/6IAgl/4tXwpuT1f5iTf98JKPps0IxsvH2V3QIhkSMVGu3ckM8QB0Kp28swR0O333Jbir8mgXl2TkXLruRs6959wJ4MOwwd8LHiu1hD7KT+nhsfGFbQw2DmbC9QyvWTV3O1U+ybqCsu+6VgCx4YgFb46EqaLPfasilZwdeaBDFiCjUMSOS/onb0C+A7KjEti9MqqzFdlIreBuGBlZ9l5UXvJB8+4+rZfqNHhJN+47NqZyYdcgXbxkjoCkhSvWuALTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly7J3wvMmeGA4Ozsb7SeCFyyfSDjjSRbFejXZCHXywQ=;
 b=EOMEgHTp+TT1p0k6VBf/QmL0UK61wxyirXUmXSAQN1EmcyWBctqaXObGmF03ZabkNgrMTPNlz1sPE6pBngQjk8WclfOW0VOqurC1FjcSgOWUOF5DtokXlpOHYf7MM17FZujMEFjdwEbrZZ0FG4zhXQHmRP2VMuxYBLbf0W0IVwBaDUK81KqgatI0/s7dEB6FsrJJybBE+yaB+Cq56abo5KqZ6Ku8vMFoogir5IZPzX8+q4N6oBk8dAVsWGg1psA685kiY+rEwl7yDa+4wvNDqPR3EgrOrfVH7wPKU/N9mnBwXY0z2nLZ3cp6wbaOWkxBmbQrFU08sOCQ2q78O16dUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly7J3wvMmeGA4Ozsb7SeCFyyfSDjjSRbFejXZCHXywQ=;
 b=LUfH9aGRrHX/teZphY62awwdzUhNwbQG/Lmrhwn2gL2kcScXlsmaXSSDzQx/F1+whmISdDfRW4mBeeNK9DYsl2maVX3aC5yZxp8VXPseduzF+tK/mMNu5BcmROlBSZmgcARIH3ryDrFue8OL2Wk1x2UZQmEyIRvgTrG0YT79YJQ=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 10:11:40 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 10:11:40 +0000
Message-ID: <ae08dde6-1884-4914-a512-0ebae8d68cf1@oracle.com>
Date: Fri, 12 Apr 2024 15:41:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 000/175] 4.19.312-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240411095419.532012976@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240411095419.532012976@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0170.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::11) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: b500c036-fa6f-4d94-1469-08dc5ad8f235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	s3zhCBgMVTkW7P9/LGOwo5GozLBwS60499OlkdFR40Jak4TOuUi6AdPQOjQnfQBFl0SdsikhRC3VlgMt2nBhmP929hxhSxLkleYbvlxKxWspR4mEoEBQxufwFQhgujoxsSKvEnIxldxLu3puCE2cpaihkxrRqQqH12OEcjTPLooThsSoh+/JKgbSuGAQ8Hts1r7YkUCtkTEiS/Qfwx7e9HO8o2FM8uS0wKL/UyrnOKfIBK+KzTjRtb6vHybUzHRaocW+TrZWJQx67LV7kMPE8gsvYbfJJMwbRjm+LcWOQ6HQnOWPMpqRKoc2OyEo8eumFlJzKOWMmYmQsaGzogDvDLhH46hhbnQA+j8IUGLQiYWWcq1z4Mrg8f2iAcet9tQFx7FiYId9rxC9Tk9wWfR8I44llq3I7DICkYB7ou/3vZ4iLn5F52s17bhsjSjg2f+WjzvWFPmoEPLN0lacTHfT2HeDNvn1iLOhBsDtN/vx/LCNwnT+9/4sWB32xhIf4n1bkUx5MW+NwXuFOxCFXewDW/biJs+qCEctSqOb3mZxlD4s3p75kbM4EKvso/KC3hWOtR4DncpRMtUKBwGTLNoVwUJ3oRJsWXLDXvFeQNlYtN3h0swKpsAf52zAiQBROk8KpUK/vFxgpUK3FwBrmpxusRvr2r6jWD+Aw89sJyrc5C0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NXgzdzFpenE1aTgwVjBRbEh3OTRHc0RHTzZVMzdmbjgyUFBld09oRk9RcWtR?=
 =?utf-8?B?WWp0VXZwYzhaL1ZTUzFFWXF0ZzU3cEYrSmJGNWpGQ255eTFtSHdjT1JGZkRj?=
 =?utf-8?B?bXRKdzVVbDFFVHBqYnBEcXNYVUdvV2ZSR3ZzTTBZalhqOXo3QzBrSTc3MTBt?=
 =?utf-8?B?RUQraTB4ZEFkOFlTSU1rVHhaZkxwMlU2YlhmbHlyRDE1TVNKOWpMYUdkUHln?=
 =?utf-8?B?RThETGJOTmZTUzZZakxLZGVsMFI5QXpPMmI0NjZ3OVJ2WEJJZVU4MFpOSFpK?=
 =?utf-8?B?amF1WFJTR1JBMmYyMHo1bVAwaXpDcEU0endDNHNqWE1yV3ZEMVBHY3ViblpY?=
 =?utf-8?B?L1Y1N1Y5S1N2Ny94dmEwOVJ0WExISXczU2RKSnUrZXNrMGlEQUJ6cy9KLzly?=
 =?utf-8?B?QTdhSFNuVVNucTloNVdmUHo5QUVzczlNRlozYkRvbk9MS0FHQS9aVXExWTZy?=
 =?utf-8?B?emJ2REdjcXFReEFQc2tmTTBvQXBaMThVWjEyTk96bE03bFBrVi9raFhYREdv?=
 =?utf-8?B?RVZLeVFjQUdsRWZTWVRsaFIxSC9DbUxqNjlNNGtFSXoydHJaTW1IaWptMTl2?=
 =?utf-8?B?bG1uSndmYm1DTlNZZXp4bEg1ZzRhNDN5bEw2NnNCbG9lNzhEVGJRS1BFNWZq?=
 =?utf-8?B?YTh6cHlmM2FjbC9QckYrRmhJRXdJOHd2ODMwV3U0Q3MzRmYwVFFpcHU5WFRk?=
 =?utf-8?B?MHdZNk9XWlZNQ1RaT2h5RW5XY0xmZ3VyclYxSDQwWkJhWFNReXV2ZWR1UnJB?=
 =?utf-8?B?b001N2dPYTlYNnArblhrQmxub25EK1h3NUpkUFRORXFReTRhOEE0a1hlVWVN?=
 =?utf-8?B?UlcyUGpzSkdFSEpGdEp4ZGg1Mk1PckZJMWRraXI0NkliYVgzb0Y2bXFSSFhZ?=
 =?utf-8?B?MXVlRnVyNktzVXRrQWVUOHQvOXdTUkNjUTVZKyswV0pJUHFmNk1nTi9PSito?=
 =?utf-8?B?dVNIaGNNYzNjRHJqOHhOMDgrcEl2Z1dEOTRxdWpKdG9zVTdNUnVlY2tCay9t?=
 =?utf-8?B?UlBGS3lRSEJxSStyZVpQV3RIbnhHd3oxMXpFOEFQVFMvUVdpTlJWNWRUbExL?=
 =?utf-8?B?ZzhVekE0WjZGeDB6bWlnR05Hb1k0N2xKTDBTTHJrdHIrVlZyc0pkajNNMHhn?=
 =?utf-8?B?aXcxT3JOK1JxRVBBMEFianVteWkvZTYveXBqcWhzK0dUYlVpaG84NG9RWGxX?=
 =?utf-8?B?STVVUWNDUFFFUEpkMyt5QkJKMVg0cnNqZU5Jdm40T2lIRitYdjAyYzdiS1NB?=
 =?utf-8?B?QTdmRGZucWlPMkhySWo1QktkU0RtODhLZ2V5emdxazVqdWVYUWlhZW95Zkxq?=
 =?utf-8?B?VG9NTU9wcEVGMTVvZWRmYkNRdmlGeVZtNTNNL3hHZFN0SzdoRFhYaGJCTTJv?=
 =?utf-8?B?YmY0Z3dPVXJYQjhmWmgzS3lydHpHVDFnRHNTemxSWFIrdTdwcm1NRUZTbTdP?=
 =?utf-8?B?NzdwR3JvM1NHR1BFVkZHQmxRaGVBNjU2dzJiL3FMSGVWOGhoU0ZCSHFoV2U0?=
 =?utf-8?B?SWFrU0NmbGpIMXZ1NUd4WWtKKy83QjBsNitxTmdoc0NVbzZUQk1uZmt0d3VV?=
 =?utf-8?B?NERmaldDNnZiOWNEazNDcExGcFRJRmw4UWhiTjZpVjdmbUhtMHhpZGxlcVNi?=
 =?utf-8?B?NGFUWmdMOVFEOVZBVkxJdnpodGNHU0hvbVZscVpqVUtkYnFxdGk0TnplVk16?=
 =?utf-8?B?ZnJ4U2VrVkMvMU5Xd0hZMWtpcVAzWFM1a1BLSTNOSFE4TXV5NzlBMXZpVllO?=
 =?utf-8?B?dzJnQW9mdXgwdWEwRElYT1Nyb2EraERvcTNGazdGYjhKR2lFYVArUDZCdDhh?=
 =?utf-8?B?bzhXMnNjRDF2RmhWRlVCZnNPVG9uN2MzVU1pVlNVUk91dHozR0ZKVmd6MUo0?=
 =?utf-8?B?QkN4MHpUMVk2cFJSaUlzU05LajFLckRrRG96aU0wM2dhaVIwOFpUUk50dHhz?=
 =?utf-8?B?azB4U2psYm9kVldJUEFsT2JIdDZFSlhKNmJmZFJmalEzOHpnSFJFdWprdkNY?=
 =?utf-8?B?NlJZZ2V4Zng0RVFXWnRXelFnZFBWMGwzV0oyN2JILzJsVmJpZ3h2bVNaa2wr?=
 =?utf-8?B?eGZyYk1DWUNpUmhrbXhTeW5wVCtnNDgxU251TDNJaThGbSswK2Y1aFJUM3hE?=
 =?utf-8?B?cW1Xc2hrV0YyOXgrS1ZGZ0c4TWZrdXloc0NMUkVYU2pFSy9uZE5tY3JySmpB?=
 =?utf-8?Q?41x4Du4Dj0SoHhCDJ3e9XzQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GJ6KDiuqAZ66Ywnn/irmLtSGyNIAAkvAM7Q/m/MopC0LuAGsXINeRFU+WpZri6mZXIT8Ngn14MGpwWWmvG7iQZ6f5z98wFXpY/CW7CGgQCMG6o73CoXRV+jOjlhkkgw8SOeMYJqL8CxQL/gCACb6r6XbuqmCVIlrAaOYFu9joz+LlPilr9PFcXMcoooIddNwrmjTeHL/q78UojrQ0FegdaPFcZp0IRhChChj7wZ8aVOJxY08Vu5y9BvST8f5J8Bd9A5DOavAeyLzBiPf8XaL2To+Eyih2xt/F7wj3mYWoqoEIb7/A3KES4BJPnNl8v/aWQWdjYJflGTb7Z1JYrCIB7vG/x4YSZhtbgqu0nvo+/XL7othI4T6WL/fERece2tdT98rRFwtd586Z563+qT62VB8uQSrCBmhymR5Rqh3i3QV6WC+VizKl30ywpwJsb+7SxpvlamcCMDyafvioz129nvjAkbruHAXyBdn3J6dmoXLEPcJRE3j4aFfpEtK6xxK9/AVU3G+OilbmpTKc1t9Nt5yckgQOiePn3wN6lcGiN8bPLJZUmCAPuyUP4v+GIluqSeCpzGVydg09mSXxOtLqHR5UaygEbAJ0ZLNR4VdDLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b500c036-fa6f-4d94-1469-08dc5ad8f235
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:11:40.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BklToR3ZNFNSv3I06s8gk3VTtAZ/9k2D3pGtQ0qbdU/kyco7V70AEf8Q68PUoW3CvpfFf5MvZMPaohZ2yDckqvzb01D1so2X19l8f+dapuAOsk1zN/M2tSOmwjDk1bd0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120073
X-Proofpoint-GUID: rXUTTj5rm31dCypUU9unoukbvE3dovlq
X-Proofpoint-ORIG-GUID: rXUTTj5rm31dCypUU9unoukbvE3dovlq

Hi Greg,

On 11/04/24 15:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.312 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.312-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

