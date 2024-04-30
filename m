Return-Path: <linux-kernel+bounces-164383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249F08B7CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE709281BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6365417F385;
	Tue, 30 Apr 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cucZ6LHZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PkpTntoJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA3B660;
	Tue, 30 Apr 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494720; cv=fail; b=cgBbA37Tj2XoFg1qDIFzXILWFj1NfEilcPaj4whdQkx5JYny0UX5fd7smlFVdwKFr7Mt3edgadVaC0UhQ5bHhDtWxJ9YAv25qcew63ssBfr5yGnjEpm37zc/eGrJ2xtDIIk8eXVFfsVsT4lyqZCKTjLUVxvzdvOmfvK5loWENrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494720; c=relaxed/simple;
	bh=N/pEmFNGPuqOZ2wsOYgDnymz97yzRT7KhLwefNZPUsw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ph8Q5SUuRnX6UecePiyQl+fbSW1T8D0iRwZfFvxJJCu7WCMYfHqs5vKxe/xfBMZ4qsowRQ5H07QYfB0y/G8u1mcQFGvrDEw8qSwEn1NKyBpR2Zqd6XWuVLQ/9aQOjVs4LqnHjISiBi8gs8c9Jzhu7gHHRxQ+cG44n2uKAt3K/I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cucZ6LHZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PkpTntoJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UGQglE032140;
	Tue, 30 Apr 2024 16:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=en5HOxq6U5AYojHMqs1EOhUGLc2HsSuXVP/RfZiiEfQ=;
 b=cucZ6LHZo6OCoz4sbxsj+DvKBuvtm9GzemfVvNyBv473JO716cKpKeY+0FIu4OriDZP9
 NYMeq+A7TxKyd1OWOEQ1kA3htAdwOiaPlEL6P+kKNRdMk0yk3vG/jnzL6HPKYUd8FQDr
 Nq/xJTRV3FPVYtsi/ZNEm644cnJTF+kcvBHfQXmbe2FjfK67PYkbEaFad4kar3iIYqEo
 UM3MGZ3P0gMCmpPXiSf5/231U4ESaeKB1IzmX6dhNkGGg83NTG1AUNOSnNFjTm1aRHC+
 oEpIbyX17qGaikDxBwClGS05/bRSnu84np5wUvAdO23TyYv/T4+umD5/wIYzuG3uwbpa wg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqy2wn5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 16:31:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43UG3ZqZ016695;
	Tue, 30 Apr 2024 16:31:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqte71gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 16:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRYfd1itMbb22Pe5OHNCiivpku421U6C5NXKiPsv68TajmPbQKwRiGSwXrJQJcnJG3GKCAbVXxQytGneG6DxHRxaT/xLlA3JAl2lOk//KklwO/DC8SRK8yPUj8rdGI4fu9mo9/wZQCKc8M2GOdV0Y/ogvInQPtx1XYbMclNJQHeq1CECoXNdfZAhBDgraHzBmiy1qm3Q+24GIkvLL1STUjPPg9QrwQosBax7PoHk8B3nkoM5KC4a4Hev5uFwBxNrJkuyEnO6tXjdg0eRSXZh8XQdSguFxz2TjyaUFUVhIuq0Rs6rtULMKLn1AWZOL2I7ULVV9liHzzZgP92VgDmN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=en5HOxq6U5AYojHMqs1EOhUGLc2HsSuXVP/RfZiiEfQ=;
 b=kKmf5BNI0ojNJmzSIeHMoa2Os9JrA73AWEfj/KCboAI4dk7Mndbu1gV1ym+Z6PXHiM1AFCfH7cfHgiYncnxg1fhk5ddD900zjia7hq0C/68yFa0I3CpeI6fpAeX+VCl97cxRxcPKROYuC0YFzDJYK7U3y9MqO3B/Ots1FaZYefH0aUG3ywQjuU/ehstSAraQgj7D2wJcbKYtpLOzv1to6rExXztgoN3urA1c5dN2ZD8C3g1L5brkb79mRS8zbEhZdgF08cCGTfPLCxfjT1VF+XVg3aZd5al+D18wX2GMg/Elqsi3ajftMSN3vrvfau5V3DqOfZYz6XZ+U8RfYHZMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en5HOxq6U5AYojHMqs1EOhUGLc2HsSuXVP/RfZiiEfQ=;
 b=PkpTntoJQt7upuZhKX5BohM1lZ+wXnDG54YsLVRpJYSsTn6PTja5tcrVge76cH6DjYGf2qz0bFsIpMc8w5fRfqYTwgmjpnWOdrlT3WxO48WYLNJQ/AVcSrEE+NF3+EggE3R8+AywD3EhEOce3BIUZsPi3P0NJ3sfBKxOVZWexek=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 16:31:22 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 16:31:21 +0000
Message-ID: <ce137fb8-d037-402e-8096-82db2ec4c07b@oracle.com>
Date: Tue, 30 Apr 2024 22:01:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/80] 5.15.158-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240430103043.397234724@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240430103043.397234724@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:820:d::13) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BLAPR10MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 25022fd6-acf7-4148-17c7-08dc6932f817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b0tpUXhSSHZXbnR6MVRWTzNNdVo2Y3VCT2RTbE5HYU9HTjVKdWRyazQ1M1Fj?=
 =?utf-8?B?STNVL3M5bjhTK3VIb0JPMkd0MFBRSUJDY0w0M0V2Mkwrbzh1ZUdmcUY3bXZU?=
 =?utf-8?B?VkRYUUZTOWlQVzR1YVprNVp0b2lsWU03Um1iMDhBUUhaREl4bzJxcmxRM0o5?=
 =?utf-8?B?bDQxYk1Eb0RRLzM1RENsNFBlK0M5cXRXVnpMRk8yTi9HVWhOS2FqSHJheTFM?=
 =?utf-8?B?WWdxcUk5akZEQm9mUU1OOXVzNmxmSEU4K2FueFJ1TFhVM0lPRGkxR043eXo4?=
 =?utf-8?B?KzEyUlJMZ2VJUCtuRUpkZzBUOEtsUkVWaDJoeHI1NW44YmZSbU9RTGVtNjlx?=
 =?utf-8?B?Z0xBemZ0d3kwT2oxa0p5bU02VUx2d01USnJ1aHdHbzZtVlgwMWRPcFh4aGRZ?=
 =?utf-8?B?U0w5bW4zTUZQN0hQUzVxLzRvOE9FQ2xHcFVuam9wWVpnbVJXU3pNVW9kNFhn?=
 =?utf-8?B?NzhmOFFuVUI5UUtkc1JnOGNhdXRTcmJNYzY3M09lc0xQVENwMkRsQ2JzU2U4?=
 =?utf-8?B?d1ZKM2gvaDdPL2xmdmw2MXBHTmd1ZXZZSjdhVDJXZWxTSkZDNVZLMytoWGJs?=
 =?utf-8?B?YmJyTm0rUms1YUlLc1pKVkl6SzNHbWVQdkxCRFI1RHNpT1duai9nOUZVcnpO?=
 =?utf-8?B?bGNiaHNWTm4veVBmRDhlYWI1Rm9uK1dpU2h5YlZlOFg1MTE1cEl3Y2hVUW5l?=
 =?utf-8?B?Ym1aVlhoZmttVWdVSFkvRFNkUDZ4d1FBNm4rNnV3RG03aG5XemVUSVNjRmd2?=
 =?utf-8?B?Q3phMkJEMUJtNno1S0szWXNTM1o1aHoram5Pb2UwS1JRVUkxRzd3MUNmbElE?=
 =?utf-8?B?dktic2d2NzgvaXg0N0xRRTJPRmlDVms2NWJCckFicndDa2ExcUlONmF2amFi?=
 =?utf-8?B?Qk5TYXJqMDJKZFA4V3VFZmlNZFBpbWhhV0xoeEdhbWpZa3hQdFVxTzNyY0l4?=
 =?utf-8?B?VVNWY0Nic0docVkvcThGODl1UnprUk1TZ2pWd2FnWlhqUmxDY2hCOW9YYkk5?=
 =?utf-8?B?UWR2V0hMNTV0WTBQYnpTaDZNb0hRWXAwZG9EQnZoN1A3ZGo1a3NTSlZDUCtR?=
 =?utf-8?B?MDV5ekJpMUNocU1zaDF6MG91MVJJVFpBOGlMTVREWFVUdXNnWVBIcTZBTTZR?=
 =?utf-8?B?TmlNREtTYUZVWlB5UFg0Q1VnbWZOOXVPM2ZOMUVLNlpiZWF1UzR5WUhSdW5D?=
 =?utf-8?B?Ri9IaUpQM3Z5VmdzY1EySzkrUWVSeGR1RXJPY2MzV0JsdWs1ajZQdUlKYXRQ?=
 =?utf-8?B?VVE4VDd6ZElHNWthM2ZBRDRsRVkyYWpsbCtCKzRjOTd1Uk9lTG50K2c2SVRD?=
 =?utf-8?B?b1FHUFZxa3BlcU03anpzTVFYYmpXaFJ0TzZYT3Q0b3dHT0E3YWRlRFVTMnB2?=
 =?utf-8?B?RWUwQUZHYVhrSnh6R2hRZXI3L2JHQjFDeUthQTR3M1ZXUDJqSUUrTVEvQUhi?=
 =?utf-8?B?YUZ1ZmRQR2N5cHFpKzcxVzdXNVJmVFlaR1ZhWENsdWNxU1kwVldnc1JBNW5h?=
 =?utf-8?B?Ymx0R0RZUDJwMHk3M0NyM0JpdThjVlB1TWs3RFFVQjBHSkh6QVR2UDZ0cXl4?=
 =?utf-8?B?NW8vYXFkKy85TW41NlFMVStHQkh5T0k5c2RyaHo0anBMS3VBM1Y2VnhPWDd5?=
 =?utf-8?B?WDBTbUlMQnc1TnVKQjBzcElsNTlWY3QwUnhCM2JHanBTQzQrV3JRUVdaTW5t?=
 =?utf-8?B?TlBReDRKMjNzNTcyNGNwWUQ0ZEtUdkphZTdQcitFQXBYNmd5bm13Qm1BPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SUhwdmtRNzN0N0kvZkNVL0s1N2wwdzVoNHFUdjZHOFViQkZBS3FLckJxaUhU?=
 =?utf-8?B?ZFR5ZUVsTXY5UlVYcUxYYXBYbHExVG8xYlcrR21jN1hIVzZMN1lwWWwwRjY0?=
 =?utf-8?B?NGtOZGpnNWNWWTlxdTVvU2ZVYndFL1E1OWlzSVpJY0tsMkVKc0MzajhCOVI5?=
 =?utf-8?B?L3Aydm9WSTlXSjhGL3I3VmtSTnl0c3lUVmpnRTRZNm40cEhJZ3ovTVFnU2VV?=
 =?utf-8?B?SHVRSnlXMmJDZ3BQUHlCVEdZR1ZJem5OaExZOUxCd3NIZFloazBLQm1rdVlm?=
 =?utf-8?B?OEF4K0FNbElZWE9YTis4UGlKRjhJbld4d1BwOUlHUDk3NjhGclJRS3oyWm02?=
 =?utf-8?B?aTBCZWhzS0crQVgwMXMvRjlFZ3piNG1peDNKR1NENFE3MmVCOEczWFJEQXhL?=
 =?utf-8?B?dzJQWExkNlJDdk1Ld0YxZERBSzZ3a2phNHRjSzU1cm4wUVJkM1VhVnVmSkF1?=
 =?utf-8?B?L0EzN2F2NFhNaVRGanZZcmhiZCtKWWpuZU1LdEhyemZQSm1yV3VBbFV5NWZn?=
 =?utf-8?B?YTBEcWxEZWFmTTZMbkt0VmIrY0FYWSs5WjdIdGdHSyt2YWZ4KzJSQ21JMUdS?=
 =?utf-8?B?cEpIQXNDR2pnejkxaDdpNFVFdkhib3NxajM5MjRraS94c0pLbUtzOFNxbGRm?=
 =?utf-8?B?eXluV2NQakJjNFBaNzZaK2l5V0JlbWJYeEQrRFlFZzNJcW9hVTYxc2V0NjRy?=
 =?utf-8?B?NExjOXdLejcyWVFVVmpON2NJQVZsQVZkUXdQUWx4OFV3d3lLejVYQ3pDcmJn?=
 =?utf-8?B?anNxNXg3MStBWFpEZ2FyV0FObTJUL2ZJeFhENUl2c001UzBBbVNlV2lrZnhF?=
 =?utf-8?B?WElqMGVxQTUrd2VlV3lxTzcyVzh2OXYxK0dWSWxyWTdMQm9maHYwYmxYVUlY?=
 =?utf-8?B?WjRTNzQzWDJwZUpuK1FaOGpwSm1uYTJneGJQQ0Nzam5taGZZVjR6dW5nb2Fh?=
 =?utf-8?B?Z2ZORHo1SEFqUDlGcnB0TGRLZTZDRmVZK0c3UStNbkdiRDBvemhLQnRyMnpK?=
 =?utf-8?B?VXlZS0dLeTl6Z3pSbUhwTyt4R21xQ1BpdWRuRWZiNEJ4K3MxSFN4M0h2d3Vx?=
 =?utf-8?B?ZXdWWk8yV0dOSDhrWE4yLzFvOTgyZTg5SlRQVFdzcnBsRWlRMnEwbzBqSzBF?=
 =?utf-8?B?b0h0RUtRT1BGdVB5ZUVTMEJ4czRmbjkzWG9kTzhoSjVlNWU5TWg4NXltS3k0?=
 =?utf-8?B?STBuQldtdTV6MTFqNTRISzNqcUVKTWxVSWpVMGZxTE1vTlJDM3lxR2ZjRld2?=
 =?utf-8?B?ejVNdE45OCtJT0tlOGcySUFmOTRKcEcvR211amRBNldWbEZSVjJ6RDlncWdN?=
 =?utf-8?B?R2VKcERmSXZTRkRERzVSOFVCR1cvczNyanpZRTZHYUNaR3I3eENZMGRqbG93?=
 =?utf-8?B?Z0pHMEQ1SGlRUWR6elUwMUNiS215VWt6a2VQZTNCTjN3QXYzenMvNDZFbjl3?=
 =?utf-8?B?d1lLak5tNTVtOW1HelVMOWxtS2VER3ovd2ZGMmNITE9vZWZ6QUs5b1NFeHZt?=
 =?utf-8?B?bHN4Vi9FekMzRFVZVWlhN3JBVDlFTHJnZXc4VlgvKy82RmdQK0lTaGpOczQr?=
 =?utf-8?B?c2RrNVFQYXNtL25KY3pPUlYyR01kcy9JN0VjVzd5ellRS3lBR3NNK3paMnlH?=
 =?utf-8?B?NHdKMjdVV094c2VDeDZTTWd2d2VJVnc3WDdkYXlrVWIvWU5EMFFqRUsrZmJl?=
 =?utf-8?B?dkVkWVI4YjMvYlY3OHBpbDhUSHhUcXlPWmtZUnpoaWdzTloyMkp3a09ncXlh?=
 =?utf-8?B?M25OcksrbUFISHR3bktUNWpaNDZTMStIb2ZwU1RmZnVBWm85K3ZCT1RSZFFC?=
 =?utf-8?B?N2w1NkM3akl3VGxQUGlWdlpMSkRTNjBNdWZoNWtYakNJWVQweEN1Nm5qcHE1?=
 =?utf-8?B?ck9sdnlxUHYzaEhMMlU0c25WNEZlT3hMdTJIdUVvazNEaFUyNENUcXFYM20v?=
 =?utf-8?B?TFk4MDFpT2VxdnhGV0JqZmI5bjFiSTUyNzFMbDJPZW9QaUlGSmRMYXl0c2pm?=
 =?utf-8?B?Z25lU0lyY28zcG1WeHhMRkxzai9lZ1I3Qi9JN3c0dFRSUlFZMElNSXBFWVd1?=
 =?utf-8?B?N0FHOFlwZjMzYW5VcG9rdnFDQm1hSTVIbCszNmJ1OWd3SzdzQVNvNVpFeVNV?=
 =?utf-8?B?LzA3SDBHNTZscVR2Z2xESHk4eGRKVjNOUFlueVZlQXpqM2pmTlBaZHhiODBW?=
 =?utf-8?Q?0HUcg9RT0YbVTCeHcQy+9vY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sHbGywhfc1FKQMP4bqmf9TRD33cT02NT9RVz7nqTg0+gMISwwo1fmYqdVOUdrFTXm+ZyG1o4rfKdNoPVqCA411D1c4W3nx8MoUFF6QYIWWaGsS65pmKyjVTzU8Ai5qOvOR3JnX5UWvm8o3b/XeZrVepjtTZToAKIDo7nxb0lr+CXJjhTHYjtiWfdHSGBOvMeGBR/w0L9GFgc0ger65TuqES8A63YLdn5iPAr7CJq1NkBCaLNj86RlCQeU85SJy0GcZMjzcGF6SHyesOboJZ1EWHIlavSMbU08sJKrM7bW8AtTyxXBpRcRCY4spqjtBcWIob0sfe9iRvZAjG18KZM2tffZtNHpCSN68efGoFjuXSUpYh6uvyWg2RKVnbtOoHCVLFTAReT/FL4yaJTsQnB2zKyOSzl053VLVRm8y7Lxv1H9mj7zT0FtNtjNOcFSPqTaEOBn6ZvZrvks6kPOes4HrMSTymE5NAIEENeuQrcXwKSlVOFbM90eWobH5hU4NdzNFWKgComm6AVUpqdlzjDqXsfYkthdd4KPiKRF0TPLeyIaK6gzd8RMbqhIX1s9TRWVgdsPyK6RWVwUpe4tulodfbodwqw+KzXGkXnaFA97FY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25022fd6-acf7-4148-17c7-08dc6932f817
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 16:31:21.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCYNvvoopKpyBYvUVE3Ff2/lc288eaa1yVMPSfH09tzFmc3xTO+6sruVtETllRkqlgi8IWuIqW3jiemUetWGApSaPyaFaLkiKMbBkd1mqiebFhtrfMB5Cculv4263AUh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_09,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300118
X-Proofpoint-ORIG-GUID: nTrAF-oCURmjDGs1LMbPupyst3jEPw2l
X-Proofpoint-GUID: nTrAF-oCURmjDGs1LMbPupyst3jEPw2l

Hi Greg,

On 30/04/24 16:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.158 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.158-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> ----

