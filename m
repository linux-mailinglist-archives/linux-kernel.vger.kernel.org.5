Return-Path: <linux-kernel+bounces-156638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD018B0612
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959AC283EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8CA158D9D;
	Wed, 24 Apr 2024 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RXhNazGE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sKDAOJ0R"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05D01EF1A;
	Wed, 24 Apr 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951073; cv=fail; b=BtzGe9mAzRk9mjOrEk/P+4/wMSm1pGRyUGpNM9W+zcL7KzME6quBvc4HYE+1Z+cuLn23uhlu2eQySm52uY4GFlXkc4OY/UslVr9svV6i3dLYKEIMkRB8obpxJFLIFYxneSeVhUYXCCpXoruUvYSgovaXJ5fIL37ccDHVmHIT/4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951073; c=relaxed/simple;
	bh=Y/AFt8mmnGj+fw0H59PnBpLJRjSkoXD6PCEOHVEfkMI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=filcFd9KAxHUq/41AJ73v+7nlvD1SxZSb0J7v+7OFIofFFMSY9cNTqVxwsz9oRsEYIw5fX2EdnPkaKxm7HBvyZvFpyGJ6bHpIPCBuRYAls2ELXgVbWbcfBdfMkoPnHZVuZOmAn4aMCmZXVxu5VHgaK/hSU2qsImuMYVOUp65AOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RXhNazGE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sKDAOJ0R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43O2EI2I020578;
	Wed, 24 Apr 2024 09:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=V4Kt3mzDwbof/KlgHo+NHI9gncQoebIZqn/HX0ZJeIY=;
 b=RXhNazGEy+So2em8bpeqgtHFIcna5mM1R5N04WFXTWC7Iv113gigGGTbyC64THeR3hQC
 ZX4lNMKLlyMsVojfj2NH1ZixiVOMicZe5BQQRakuJ7vz0pVbDoqjgOSdNCJqPeM+D8hJ
 p7QN+8IppJ0KjS5H+kYbehSxIAjL5HcyMJG5GdvFL8bIo3N/AaQZ6IGOcHDWeomDDMrG
 j7Sf3fdo2lYNcmZLbvmomwZyLWx69UF4g9wgRNLHYLd7ifxehnLAoYBmYDRi2/Ihm30k
 Tjj6empYZIneBe3x2l/HXva3a6w88LhjRT1fZGdW/h63Dvyn18gsBSEK1wTVaETDBixd SA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2gadw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 09:30:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43O84auV030934;
	Wed, 24 Apr 2024 09:30:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm458j025-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 09:30:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBJVvDOcDR3hlbpFpUSjwiXhCc1Bp7/9qiqzdz6FpdJpcgGOc5g6g8+Fmv4Hebf1wCMpnYziUGdcQz4GgxOgQZ51+a+P89LTOCYBlKuTWRNKd3+QEURmr45BCctLWjoaB5caaLpbzYl2TaCMMvpsc7/xvQ7Y1FuxZd7IlO3jLRwl2sLBcn4DmN4neOCyttLbwsR/US9gG4gVcqqhOZDT4T8WxWtGIMujPQJn6isBFKe4iFhfDd8z0s8Dt7dn2jgt7UMnnaNCg2RAOAX0deaO5I2x8mtC+XUjkckmOQC3i5sIY3HIuFjVQ8B5YI6Og58zNI7VX9C2JweAzVCvNz/7Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4Kt3mzDwbof/KlgHo+NHI9gncQoebIZqn/HX0ZJeIY=;
 b=h4SpPY631yXxrfGTCeUepOw7yIljODIOpBTW7554EVjv30kI+kTklig8rGQhYj0gi1ELN/0lRZr1EzXqrbt6Kd2rGq6A5dUXWOoYk4zKp0gklZrqHKRtYNr7CdsARvZp0SMUBDwA+S16Hqc3gTBhlfLq/ySHJVTXU3O9VTGHxFRQsBdyqeXnZywbiJhX8Sq7GcB0T9nwsprpCzdtnbN96Nod1lZJ+kRJHvH87e5B+XkrErCeDopgp7QBs/Aqto6MLDTT5VusfRUhezFa1AIGBrzvkeYWjbP7uMa/YJNJgW8CkqRW6dTSgc909fi6FZBCSeoc+Ytk3itiVqyLilaY1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4Kt3mzDwbof/KlgHo+NHI9gncQoebIZqn/HX0ZJeIY=;
 b=sKDAOJ0RZm34kj2KLUNLB9x08e/xlGvry0cG05MODhR3lPVq6OOQLQrscBSaDt7y2UE26xu2jSdzvfrUVtdlMtTqpIAQhNi8IN5q4uVKoCIgzIQTpS1LFSxCCk9ByIlxJZ6UPQyMO+b0p1HXdRmb7cmyKFj8k+M24I3+q+rhpc0=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA1PR10MB6518.namprd10.prod.outlook.com (2603:10b6:806:2b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Wed, 24 Apr
 2024 09:30:39 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 09:30:39 +0000
Message-ID: <b42231d6-d92e-4726-8a59-7380e314db92@oracle.com>
Date: Wed, 24 Apr 2024 15:00:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/71] 5.15.157-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240423213844.122920086@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:404:56::16) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA1PR10MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: 7827f74c-583e-4bab-57be-08dc64413401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Ykc2dUlGNHc0OWVJczBMNVFhbUlBZ3pySkFBZFNTcVc0N2dmQk5lbjk5Mm5w?=
 =?utf-8?B?bDE0ZFM1UktZdXFLR254ZTNqaGZ2M2FTM2VPa0JwRVMwT0ljU25lZlNGZkMv?=
 =?utf-8?B?dEdBVW13MTFYM3hldm0xZnJwVTFnbTN6UGNmOVhMRmwrdXBtTVdVdGRNcGM2?=
 =?utf-8?B?aC9Ub0crQ25pNEJpbDFGWkxZNW54blZSZFk1S0hqdXdjUGt2Q21FVEZHZjZD?=
 =?utf-8?B?d1lpSXRQUHdXZkRhd0hMME1RU2M2Z1A5Z1BERGxYYlQyem5pc2E5Skg3dVA1?=
 =?utf-8?B?VjdzdzczSk85Y2tacEM5c2d0WW1nZkJZZHpkSWNnUjdrTWJ1OFRoY2ZObkxt?=
 =?utf-8?B?TlpTQzluVFJvRnZjY2x2aEVnWFVwNldDNE12NzgwMW1VditUM3NkYThlT3lW?=
 =?utf-8?B?QUlFR3JSOGxwQ3NMMTNXc3c4b1F0L01xN2IxNnVGNWFVUisvR3VaQjAyd1B6?=
 =?utf-8?B?K3JOVjdBcGwvWGdkWUsyZGl2aEp0Q0FKR2l0Qm1CM0VYZm5lbVUxakM1YmJN?=
 =?utf-8?B?blV1eGJJa3lNZm1DdENPVFlSMHlRUWpPalJOcWhTUHF0U210ZkozQVVxc1Jp?=
 =?utf-8?B?OVNySDV3RVludVFuQkZBbEhTUXFNT2hkTmdTVHlxZ3kramF6U3liYWc4VUVQ?=
 =?utf-8?B?SVdPYlNyNVFwNFB6TU1OOVRqN0VyYkJPQngwYkFoaThtVmRLeUl1S0F2Q1I5?=
 =?utf-8?B?c0pzRWJnNDN1bU9XUlhZRktiYlNscG9UZzhoRmRzUC9NaHVpTjQvcVJqQnZI?=
 =?utf-8?B?R2JHVE5lYVgyUUxiVHhOMGlJT0dSRnFtV0VYMUxLU0E5aXFjN0NXSU5tYitl?=
 =?utf-8?B?RzVHWEsrY3VRZHY3U2tJQnZqc0xZTzQ1RURRMUlLTGFqYXVqUHgwQStLK3NW?=
 =?utf-8?B?OWxTM0JLNkY3VFRRL3FsWEM1QXVEdHFZQ0FxZFNzV2pmMkN2R2ZuOGU1Mk9Y?=
 =?utf-8?B?RUxPT0Uvc0oyc3VoTHk0dkxySHFIWVdXM0VzcGNYc3BiRWlLcHJUS000NUJY?=
 =?utf-8?B?dWhTdG1kZTdVY1dROG9PRE15aGZma2NrKzVmcEdBLzVRNWZsb3A1OFpJajd4?=
 =?utf-8?B?UTdScXRSRFVEZW4vYzhQdGZmcTRMVEJQb0RHVUhmbGZ2VmpXUU0xdkQzUCtG?=
 =?utf-8?B?QkV0U1p2blpjMGZWN1gydjgya2x1TVl2MUZvbFBjb2JtUEt6SlVRS0VOa1J3?=
 =?utf-8?B?WUFyYkV6WDJWUGltRHJEZVdTU0ZRNHpYYkJLN2hEd0VkQUtiTXBIMU1Za0pF?=
 =?utf-8?B?Sk1aTHV5bUlDVERETDdYbXF6SVQyaGxVTWMraHNoUXRVTFpnZWgyTVpaUDZm?=
 =?utf-8?B?WlF3SmNOclhMNHk0RWREWDBVY1lLMytmeEt0c3cxcG9OWWh6NWp6MkExZURF?=
 =?utf-8?B?VUYzZnY5RXd2dHFVZTBXR2w2bGVncmZtdm5GUFRrbERIdm9KSWpsYXp4OUll?=
 =?utf-8?B?blYzQjlqWHgwYVlZQ3lrYXdIVVZoaXcrUVRMTFljemkyejdSOVMzNXZPaXU2?=
 =?utf-8?B?M25paHRyVlY2S0I0T1U1Qk5UNERKWEJmRmlLOHJLalREK1Bmb0NCcHcvWW0w?=
 =?utf-8?B?SjVtclAwVnlrb1d0b1VYaHBBNEZiOU9GVW5IckRhUVJQYzJvRkRGRjhNM09H?=
 =?utf-8?B?ZCtrbC82VlF3cjV2TnE3ZTZDTkozLzZJT3kyTjFNZ25td2xZdElmQkEwVENy?=
 =?utf-8?B?YXVxZXBWRzJrZ210V2tDcFp5R3ZtT2F3Y1UwUEpzcjNLMXlCZURSa2dnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UUJveGt5eWYyaEIyWkw5NWhxcHJDQ3BEOHVlRUdMd3FoNmF4UmVqUnQyQ2kw?=
 =?utf-8?B?ZXMrMldUZ2d6NzgzZklzVzJ3NnBRUVhDOHJXM2tWUGFOVTFmRjZheCtzZTdI?=
 =?utf-8?B?dGM5a2dkMTBmYW51NTFaWUJ1aWUvc2xqRnhDSHVHS2xEUDdPWlMzTDA5WkV5?=
 =?utf-8?B?QnBxWWZPR1ZDZStVejU0S2NZTHE0VVdsWDRxSjVuWnJuVFJ2dzNQWTg1RFdN?=
 =?utf-8?B?MlBjWXpMUTY0NTI5QUdkUFNYaVpCOFI1bWNrcFVmdkY2VHhraks1YUxDek96?=
 =?utf-8?B?cWY2cTBHT1NZVFFiMWk5NGhrS2NkVDlKSHB0S2k1L0YwbmJqMkl2cUw1a2c3?=
 =?utf-8?B?V3JxSm5xMllwUUs3b2V1ekpmaUZzcm1nN1RBZ3RiVEVzRVdWVnhsbTI0RkRt?=
 =?utf-8?B?cldkbTdQK1Vrc0VXUWlRMDhPZ1dpdnNPQTF4OWo1cVRaWTFMdUlmTFlkKzVW?=
 =?utf-8?B?RTJENHREaUJMTm0zNTB1NGdnMjQxTG45YUNTdEFXa0N2dzVHTS9iWGJFMnRQ?=
 =?utf-8?B?MTZtNG04K0xGNUV5enM1MnRXL3plWjQzTTZNQlo0VStUOWwxK2ppSVgxY1hr?=
 =?utf-8?B?RUNLcEM1UTJiMWhsa3FEMW9kZnlXS2Q4eEtnZUowdE53UnI0ZG1kVk1oSnpJ?=
 =?utf-8?B?NGk2K3dZcDRLZXBxVS9zM21DUDZrQjJwazd0dXVyL0I3aTB2eEEycG1kUDc5?=
 =?utf-8?B?dHZEeWs3NHNYcjAxRnM1U2dYWlFGM1BSV01hSWkzWUpabXFWaHNqWDBHdksy?=
 =?utf-8?B?Z292SHhwYnZSYzg5NENza29XVi9kejZQK2NmUDh3dWY0WC8rVEhWU2RiTWV1?=
 =?utf-8?B?cEZGUW1YTklad1VRZlMzVEVTK0xrdmQ0SmxRa0pyQVk5aU5oYnFoYW9yeFh4?=
 =?utf-8?B?TEhjL3dZZngvS1Q2aXJwL3lsZy9hR3ZQYW44Y2VIUWpZa0ZveFhVWStucFZu?=
 =?utf-8?B?aExESDdzcEIrb294VjBWRVYrVHFLMnZ5U2k1QmI3NkNrbHJCQWthUW80NGFw?=
 =?utf-8?B?K0J2VGM0LzgzOWQvTHhwRGhTQjlSWW53MTNaeTF6aHRveGZKUU0zUGl2alFh?=
 =?utf-8?B?ZS9ad2hwZEVMMHl0TDAwZkd0S3NSNmJheUFvY2oxaWtPdElmTlVkbFIrQ2lw?=
 =?utf-8?B?YzRGY04wdlFaQTNTYzJmcWJtKzBzOFJIL2VkdWlzN1hvVDdsZzBySXRieHY0?=
 =?utf-8?B?K3cyVldpQXptWWlNNlBNa0hZMXRqQ3RDTXRhMDRuTkY4dnh2QUdxcWg2dHpT?=
 =?utf-8?B?cTF1b0tjQ1BQQVord2FLQ1JMU1Z4MVIzbGhkbUhxL3FLUTJXYVZLdW41MUYz?=
 =?utf-8?B?UXBoem9EaXB4ZjUxS2ZqcitoeXgvaUFCVHYrd3ZDT1RpY2t3a3diR1oydWNu?=
 =?utf-8?B?cTUxMkE0TUJ1SW9UMUF4R1FaNnZ1eDh3TDBGSWdjeTQ5RisrUFNTVUV3QnlW?=
 =?utf-8?B?RlFOTWd4RnZaWUVHdnptcGZ5ZnBuaXFvZUFJbUZMRTBtMDc2THBFLzJMdTRL?=
 =?utf-8?B?RmdMd295ODlCTWFKYjR2YThGTWhsSEx1MWV5eEVKVldxemxvL21MTjVUYzlT?=
 =?utf-8?B?RjY4ajRwWHR3ejBHZHJKZ21KRDhnUGxBZzZwck1xYXZhQ1lQSzROTVErVTFa?=
 =?utf-8?B?b3ZraUl1UFIwRVN1cmIxN3Y0WUMxSUhlUk1sanlPK3ZIVlJqZ2xDeDlIeElV?=
 =?utf-8?B?T0YrSEJZbGFwbWsxWktnSmdaWXVWb3RwV0dwT2RpVGtBTFBKakhuYU1nMmR0?=
 =?utf-8?B?TDBWZkhNWkoybXlMb1h4Y3F3d1BYcGhaZ0tPTHdtMWJrUktqT3lyZ2l4cFhB?=
 =?utf-8?B?cXRhZkhrTFZNenZjclp2USthVGk1UmJtaHhabVJLdXhQLzBtQktuc0lFc0h0?=
 =?utf-8?B?dXBTQjRKRmtTd0hPRFZoMG1NdmpKbWJoTVp5V29DTkpybzE5dDFRRkFiaDdv?=
 =?utf-8?B?VGVtb3YzalJRZktqczZDMXgrWkNzTW91aHRpbXVPaEdjZExqU3Urb2crdS8r?=
 =?utf-8?B?c1M0WkdGUmEzT2lkSGR3Q2pyQWkzbW1XZTJjUVQ4cHlqT1U1a2N5aDFxeDVj?=
 =?utf-8?B?MVBTMEpxdEM0RHR6R2pIVDRvSjZKRmtPQ2pabDNqUUZxeW0zRXNtVWNZUmNQ?=
 =?utf-8?B?NHVMaFVJTWNqTzdHdXladG4rNDdVNTRTNHpwaHZhWm8xYTlpYU0vd2FBSFV5?=
 =?utf-8?Q?0ugx0CYENzyZjjleEfGsLt4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	H+CYXaMUq7NW0z2mHiYDQWEqQmCeLmNmWPMTxBuuURxKJpSzLjLKzwg/UBPZ0Z35xpm1ZFY+HKQynz1zmgL6F5T9IFyBTIEcNikRn5vRSPcPLVg56rMg+89f1bs+XmJzw1ZxbY5yLa04Y+tiQTRkAS2wjI3D2YaFKE+DU5R2x72gu2hlmqiKcOn7k2f+05843AeydiHcxgkqCnDGdwQf3Ag378nDuAwLqYMgrbpYzJ4sQkJrTm4gcgsi1ZMH4QBoZGZ18STjwvOlpOOzmZbhbZotpn1AfImnSlWyMnPYlUG5+zM54ofSx4D6ReMcF8MEHoyUP+Jn74PAq9FU5rsCfAb6jeQN/vB36m6vvbHyV2Tj9dpzHnKsou9jgrdSLRfcBvvOW4QIfczKK79brb/0L8C8kQSWcWQZJ92WO8ZuC4OQAXWJGEcivtycvS59DmnyU6czLsqOjDnP1ycdH50mJvldO3Fb/nrEu7Lf7hi5/fMl2qQkolbQapEwJvDPRhvCW77U+0HDCHuEj5EWCXb5aNWtWVDA3s2/5w08MNDnS0fMmceI2dwegmyUXulSzCHz1mZ2tH1xaHuzK7jOrxR7WKvg7R5pCa66QPNkA4K2Gj8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7827f74c-583e-4bab-57be-08dc64413401
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:30:38.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ly9O2YfjS9Wkx382jhLZiDrL0wrah3ywk0jBmFtTh0Xhiz9Jo7WAebZSjusrHxMwW+lEfLmjGozPs6eRgwgevKLBHW0wXgG90OatpAn8p+gmoAKfOPeE1mURj2/HYYQ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_07,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404240040
X-Proofpoint-GUID: FO-ObdBRNheXnl9npWUsni6QIYF4kr6j
X-Proofpoint-ORIG-GUID: FO-ObdBRNheXnl9npWUsni6QIYF4kr6j

Hi Greg,

On 24/04/24 03:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.157 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.157-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------

