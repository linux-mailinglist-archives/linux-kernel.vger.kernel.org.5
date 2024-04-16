Return-Path: <linux-kernel+bounces-146444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FF78A6561
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D5D1C21831
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7792A84DFC;
	Tue, 16 Apr 2024 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P/xlKw9t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WhJNQH4X"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1966E7FBC6;
	Tue, 16 Apr 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253559; cv=fail; b=WpPBGCj1APwAnSrTqN4QBYVVZJRWnfp5kvfzdCEUa4XIfuEHRB/NoWX+kuQ83F++ZqpzvNQ3n07wxVkcI4/Lrait4yGN8sPPxT+L5SSYbXQVXtN9tpRf+VIK6HLS/kpbhLzSdqP/881oAr5kGDuiBe/uy7+oodzgnrUU55ChWw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253559; c=relaxed/simple;
	bh=pWV9fUsV3FyjEg9hq5O5QnjWA6kUlDjY6PBNI/BbA8Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bM6rO6Rb4yYPI8iqr/mmkp9BxHOEvZ8vfn7WZ72RKW5Mmvq5UjvxVL3SlIQGTQ/RcvlO/+DNAwF/HrTEYpKqP2x/A0FNJ7zH39spCpZn23zUqeR6/fbcx4muvjp/rNg/qhY3Qddc3s+MbdUnVTsXBxJcCPxbc4UQWngmQZP+kPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P/xlKw9t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WhJNQH4X; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43G5FGqG027756;
	Tue, 16 Apr 2024 07:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=qqOdr0Ab1ZxIG/cvvALFsfpdIf/pvw2o2ZaZ9+NwGMo=;
 b=P/xlKw9ty54cAhiDiPEof/m9ANki3DlaTFZFnEBFAgfB2gcLLmphxKZItNg0kawMsnCt
 5/bcH1W0nYUM4SnFolwABUjHylZOVv9PB1FLVsJbC2ZI77Y1c5dih4JW1J5pZPfV056g
 yJFI4h+W8CjJATZoMRpk65wM0cz3rJK0Iglmq5B6gAXum7OXj6jtvshgZIrQ4dANDuUm
 NySbjgPsD+rqiB9osHjzawmxmkyv0WOTsxonANHw4aC0xWLLOGKOwqwwiIMqCRVG5fdd
 hwWifUKMXddo8VrzxbwE8WS/5TaASxNAn/+qyfyG5cfZL8X7P/56cDuEPtOF6DC9pxbE NQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgycmkm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 07:45:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43G7RaG0014297;
	Tue, 16 Apr 2024 07:45:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggd46u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 07:45:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls8JjC89eqEfJA4u1VKr+Ehpy9l12uBb9xa2ULTdSgbZJRMoG9IFMRdxhlliHWhlv/iDLm/xOCYm4edKwNZf7GPJeTOJExleiNSMqLtC844yqKt4zv2DBTABe3NdFlwp4gmJJT5LFt7A0BFRC3o2TTc9RpC49CNfb/JmNEtrDEwXT95ssLsrBrvqHiolxOXM5WtgFNd//fU+iiGnM9+RvQSBycs1sdtgQKXqb03weOU6Ef2QwsIoNyh5n13lvOlfxbsWQwgRrzqdM8oPw9fU+G/fIHdN6a2tRBDF42KGjOsTQsje6/i848ii94VmeaZxfVjIBpGEwBPm++7NUA/LwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqOdr0Ab1ZxIG/cvvALFsfpdIf/pvw2o2ZaZ9+NwGMo=;
 b=dCsPfbwXm/I2HeYFQGmjnmkxhJWaNaW+/kz27whDXC305fbLNY5NskA1Xe37HWKx7sPJgPFmGTN4u/J0vGbBxovwCOmnuUtyxM41pPBIPwuciOajKfUXdZnIkQU+9uFkVAPAtjOBAPX5V+L6VkkxnqA5p9tf0IlWIbQ8UJKcL5rioHoqM89hg8h52XVtKR4LpsUYctGGUmZNzMJ4AcayZNiMPVIEYBHHlYX7T1G3htP9+fYSM1y2qViQceB+rEUKGU413r4dIeGbgk8hSnOoYZypTVRN9Bb/71PlcjowE0BmnQzo5WW94T/ihouKQq31KDLChKB+1Wh7yyaVofnh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqOdr0Ab1ZxIG/cvvALFsfpdIf/pvw2o2ZaZ9+NwGMo=;
 b=WhJNQH4XXl6uPsaTnKDJFMdbbMnd62E54cN5nVmbrh/JZV4tquu4bv2Yh4+c2OGG3Qr/7AIlRCJuf+6UaaB5mTdToMD6g6K5mCbs/SjbsQgJpWU4SBrKqWpOhgOrqmNlcXQHB0NjPuONYcbL9zfsNZPQJYRkmKXfZF987MNlI64=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 07:45:26 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 07:45:26 +0000
Message-ID: <189c8903-4976-466d-9be5-249d3cd5e399@oracle.com>
Date: Tue, 16 Apr 2024 13:15:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/45] 5.15.156-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240415141942.235939111@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240415141942.235939111@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0128.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::18) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS0PR10MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6b703b-571d-4aca-f335-08dc5de92e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GAbEr7uu6+ET9/+B2Dm5w8Uq+hVDt6nVIFia6xKObtc2qp/dQINPcZeb69qjDcRWPUn49j94jsiADdKnKKQ+4DHtXU5IuiATQrjQCIl7nUF0kV1GcPod3FOOlQztXjIogeHjuOLhauomfr3YScsn6EO1V7RoBDnMbbcpQgeBeMg8GVUUMlyCtueskH0sC+BgenI6Zbgd/g20duzPBslsH7NMEO6qQ5popLS9F3H1rdP1EcWWojD1gRdI+g9Kh4ncQPLYXAb8d/M+3YkVHJ2w7fMNxJK6Y+FK8WNQt5PlvF2RlLfKmsWo/o0wMMm3Ls+CepwA4LfULHm+2RdPwVto+O7miYvW71dzt+VU/lF8MBtcq9JbM+2uwi65Oz9Vdq86RcvuJ10LzNY9p0aelTAiHklNOpYxRZWgWn0Bofd0TsAF3+ncYJ71xeTdjt/nA3rkokeGiMaibCrePzE1XzajGaRNsXe23XSqqiAdfc1tDLLIaKJiCcGLv/0DTPKsZzPIOK7LIXfRPHU1OYkpSNahUGY1Lbb7hqz4rmy1iUHIFSnNtFjBeRjbqyQkaHh9R41Dyh+RA34JGUrJOR095mXejsy8Se3uU0lexaWXYf5AXJwmDAVD1QbMOedDeAVwsnfmzL55VJBVOXYIOvVYn4lGMbVb75E7kTtoOIWJ+zo2Mww=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MXJaWkcxZWZSMlI0MDZ0dlJtcWlxOFVMck43a09ZZmVKbDZFWVRxMXpXcXNU?=
 =?utf-8?B?eEFOSWFZTHNxZ3FGVVpvclBSM29OUG1mSXRYN2c0eFRUcSt2VU9zRXNtbXRO?=
 =?utf-8?B?cWJmY1VnWGlSWDdkcjlzaVBnN1hVNS9qTkJWbEgzTGsyNnlUbThRTlVHak1L?=
 =?utf-8?B?Wk5oZ2NibUVlaWtqRXB3V3Z4ZjlVWU5DNGVaMkZUR3FFeUJZMEJwUUFxVWNB?=
 =?utf-8?B?T3c5b051cThtR2FnbjM1RjNFYlZVMWVIN3BnNEdudFZCSkYzS2hSeVdpYlBE?=
 =?utf-8?B?UWh3MmRrVUZwZTE4dGFkOEpXUWpOSGk5d1NkNmNDenhoUGNYeCsxREFlRUlY?=
 =?utf-8?B?ZEdqZ3BGZFJadW44cURsK1d4TVBYZ1dlcEZjRFNCMDNwUno2SU1hSWRBNStQ?=
 =?utf-8?B?QTdrbkYxU2JuQ25TRUtQUndZZ2ZXNk9LMEJMLzVjOHNHdXc3bDZjSExBekFD?=
 =?utf-8?B?ZDEvSnpCUXIwaVQyMG84U1YzTmtJWWYrV2NVMWlNWGhkVGdvalowR21QUW1i?=
 =?utf-8?B?Y2JydWh6SW1qM0pHQXBlNU83Z2d0bWRsb1Rxb21rNnRTa2srWkNFek83clEv?=
 =?utf-8?B?Sk8yY1dPL2EyYVg1bGhVVEl3WUxsNU5MdWdYWWpHakNwb2t1UzNaVzhMNDBp?=
 =?utf-8?B?cnJVRkNzTU1xUklDbmcyZHl2SjR5WFNEc25SU05HVnA3N2xxYTdOL3RZdzBL?=
 =?utf-8?B?dzhZa3VlMit5TmZLeGYwL3lNKzBKRE5ENElJRUtsSjRtc3BKTXhSc05Lckpr?=
 =?utf-8?B?Q0JmOFVHV0duWDg1SXFYWnBjUk1RS3NZN0NDamsrOG14RnpQWW00b1hUdjBU?=
 =?utf-8?B?Tk1kc09seGVHTW11TFRsc2poYkxGNzVqcGNPSDIrUnJiMmJVS2VLcTBiSW5P?=
 =?utf-8?B?NVoxWmI2M2cwMkcyZ0pFaGtPRXBiT003Sk5JTm14RjBhNFVOc3J6MU16QWt3?=
 =?utf-8?B?QWlEZDJSVUtVNTJEcFZpZnFvSldDcVNaZGNrekxFc3JrQ3VteUdVN09KU0Fa?=
 =?utf-8?B?QzV5YzVnQzVqamdSMmZmamdDSmY0TWtFZXRkNHlCTWNGUU1ndUFJM1ZSVGQ2?=
 =?utf-8?B?dHdxbnJNMHFuMEVKck41NzRWdzVmSjI3R1VzYTdxRFJuNVZuSW1zdkxxYnlt?=
 =?utf-8?B?NUdNZTBnTGh5ZHRpWXRMSzZsaGhoeHkzN3ZPeHBudi93YldiOWlSbkxxQWpw?=
 =?utf-8?B?SWl6a25KcGkxTGJXY1NZRlZDUVdwSXV1SVN3ZHlTUjJOUXFkUjJzdWxrUEs0?=
 =?utf-8?B?VkRUWVhHUnRIS0Zla09zUXJsUVNUcGxIQXNvU1JKN3lYRVI2cTZDNGFXQlF6?=
 =?utf-8?B?d3hKU3ZuM0hGZENENWpnMjNlUzlPRjlMbEtabG5ZemtxK3NiUnMrZFdML2Ir?=
 =?utf-8?B?ZmhwZlFKeTU3TmFIZ04zcGUrakZiZzczdU1YbDN6cVpvWTRqcXVoa25JeHpC?=
 =?utf-8?B?aHZJcVMwV3RiZHQyTWhPbVdmckJHM3oycFFBbG5qWnM4bXplMW13V01wV0k3?=
 =?utf-8?B?dFZwb1VQcHo4elR0dk80MmhMMmEybThLUkNoQ0dEZnZrRFpKNEREYXhUNFRB?=
 =?utf-8?B?WUY1aENnQVZSRGpZVUpPcjJ4bXYzeVROdmxoNEp5VWY2VFpVQzFBSG5DNUEx?=
 =?utf-8?B?ci9vVkkxVjlrenhyTGZQTTlya1FraHZRK1ExakFIQTd2T1lBRXY2V096WHFF?=
 =?utf-8?B?bklma0FGM1M5ZTl5SmNYNkRZbVJqK1BkYkxZeGM3L0RCbE5wai9zcXk2Z2VL?=
 =?utf-8?B?MnEzSHZPR2lWdmNVV2ZjQVg2R3hrb0NUaGNSRjh5dkl3RzI2RVFEZiszT2lH?=
 =?utf-8?B?QXRwekVjc3RMS2h3MlYxQVFuVElJUDcwQng1QUdoK2hYd1ovbndtaDVDSll6?=
 =?utf-8?B?NmhxQW9kMWc3elo4ZnpQcXg4QnFqODZGQTkzRjAxRXAxYytId0ZYYkMxeVFD?=
 =?utf-8?B?VzFXMGwxV0xXcXkrbmZUT0dtbGkzd0ttNTZFL2JMNEo1ZEtGbVpRVm5Od2Z5?=
 =?utf-8?B?KysvbVV2MlVUNjJCbmJGdXJ3UGRWcE9YcUFyaC9HSkhPQzZQOHMzSnI4WXpT?=
 =?utf-8?B?Nm94WVNtQm1nMDhjUlBkN21DQUZBaHFsMlBoUFRIZG56SFVhTC9vcDU5RE12?=
 =?utf-8?B?TlRXTHBhMTVSMk9uWDlZeUpqQk5icWdJUWljbC9OV2EyM1hybitHZWE3SkJY?=
 =?utf-8?Q?PXqv+TpovzoATiToglD5Ah8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wf80Wk/7jIQ9pIH3e8NRLQKiz2LDhnDeDe0fv7CsO0frpcUwLiHlO82/Z+b/l+RoNDGitfyjeXuiIN4LuqxxHyHtpkQ8rydDnca8Wu77yHozyekEe3DPNAzvFd8KbauV8hv9h8nFvbgm7PfXhuxNKOZEYkZ5rkbg26b/bgpibu164xQaLMYNBcILe78XHXTsJb/m+1iJ96ZoF6xI+Y8zrH650evQNmv+R7rR7NKU7BIja32kBzCXy/W3odDJyBezhUB+AyVItU8rg43eQcTxXybcqjoWxglh8qLgav5UCYyfnROzFGdtS572JMvR15jUCylwQPHB0Cz/r/+VQKA4L6e9iVAAqLHnaAOlamZTojRLOO1QHix8cmWdsdD3oReEd9DZqLi6YuNYddyvEoYUK/xzW9eH9qUODXkuKiGrSQWXiGnvLsLyhrEpBEBgeXYhvOJC+8LeAz3ObTqaaXiqUEgT12o0RCf6b3xzEyqwmrKxqsIHyW8nvGnAjYSnFVJGZzIpVbz/3/43AaWkTPtCvFPCVbShcERC9ULgpgcX5BWa1Lt23TJEM/AHaK2BckrY51Y8MzSWlS9Oa3KNHsrk8ZRNcmlH7u9uKc1LwO4VGE8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6b703b-571d-4aca-f335-08dc5de92e34
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 07:45:26.4665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiNHs0b0Kh7fuFLrp/lPmKehzVDgmYHtMAC3Pph7F4oaxwOZB+VQe8Z6GG9GbrLhctGHjSYx04N/xa/kgatPpvUTrP2VXqJSCKhTiMkOqilwuXEygAyd/PmZBCzTc0aM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_04,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160046
X-Proofpoint-ORIG-GUID: ls8D-x3QmKcRuxaXcTJD_Cgb_9-bXOYM
X-Proofpoint-GUID: ls8D-x3QmKcRuxaXcTJD_Cgb_9-bXOYM

Hi Greg,

On 15/04/24 19:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.156 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.156-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

