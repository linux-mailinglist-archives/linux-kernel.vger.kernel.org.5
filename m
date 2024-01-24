Return-Path: <linux-kernel+bounces-36719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3675B83A575
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB183293027
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FD117C6C;
	Wed, 24 Jan 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A5Es/1E4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fU7ap/YF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A5417BDD;
	Wed, 24 Jan 2024 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088668; cv=fail; b=WkGBFPLxWNTsqhTTc0nj4vhD86pnQlZNxzNFenDw1tlW8N1GoGXZzCY2Iqht0p0qKr3h9FKATi6hKNuY9mmQfV/zNxpeweoR3xncIgZwhLc6V2PHrxePH9lPescY64u6jYpBeN4Ijqg08i00bY66w6RPD6A8NF4r90DcQ8+sqTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088668; c=relaxed/simple;
	bh=IH8E+01yynzd7rZV7mBwvvpmNJn7pKXZvOwCU1IS764=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AeBpWKhphqzNmmgMFkAY2ASYMOpW3x8JxHA76a6XNlLzUZ0Rlip6Hh8Ry9CaLps+nJf68IgG02vWhzYNls0PPvvsFobczUKNkOeoumKN4aundmqB3NIPIwchtdOwFxH+rjIvHbMSjN7rqhC03DkaGqd7tDtNBCDYA+lELXUmcOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A5Es/1E4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fU7ap/YF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40O2xPSo019941;
	Wed, 24 Jan 2024 09:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VI3ZPBCTWrxVKMKoPdmb/nvIZIPKo3cQqzbg3osP6hg=;
 b=A5Es/1E409dtxRqyAwAY7VubnjPNqQWiC9rVx7ihQbzkEk5IIspDbnLX4PYjyqJ8pF5Z
 wvrX7MUlrQOKtDjO1ZD1uNybaEMppxv2ChIaLeNaVSAXv2Rk0sthohJa334QWp38jfpj
 mKC5IkqopcOPev9pQly12yS8aocjHqlCFu+Uec9OlkBK/WUJGPBNkFIySLe5YxPqu6ow
 xXj8jghqfm/OV4JXU8C5Hpqmfjtdc6r33w/nezNwxyJNmPxGnZa4xPu5kQLQRLzV9Iy6
 pBH5W5LZBYmLUqtfXyWjyDxJ687kHQsinfYXGjj1BZox+0mm9KE7lLNC5U95HkgFF5Ib rg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7ac0reh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 09:30:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40O8bCsG005437;
	Wed, 24 Jan 2024 09:30:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3726uu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 09:30:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF7/g6XjEvUbdywSmeqrzdnmPj0hjh3/f7Xqw+VC2+NK1CAxj2rnq5qHMHHwyVMqyCU621f4COHHDc5G+elp9PB1g/mnYI+abcD4GjceXh0ZVOCKgBI36EU9QeJ7O689BTBxo/lNSWN0nRlzGmMqn5XfKy0KzreSBe/OcJwj30sYgZfVNPlJuvZIQBTUg3Rdjgt+IT+BQWQvdf4kppPeD+5MFaxMnJIuy9w21VYApFD6D9VrtYN+sxhP4Fj0D6v/DHwHgBjhUBaZwgVRfZu56PCHZ7enqLz6s3s6g3DfuFSDGNiQI0d7Vu142Qd43yrrc1/RNOqUvawX02KrPvPdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI3ZPBCTWrxVKMKoPdmb/nvIZIPKo3cQqzbg3osP6hg=;
 b=mR/omvxhQPxT/R3xFHUgsP3i9wUEW5Yp/Hz/MfiHce4sQLLfPcTk0Hfc1qkkec7su1dCnofqm9ZYBTioR5fSHT9QzevL5KjiVzH6WeC25niho4rX/OMkSgwnF9ZKg4K3lMagyluJMr9hcqK8VKV5/L2bYjfcGQKV6Iy6UZMvZ0B+fWsC3Aoe9u9XckZce89FHL/E/UYx7nvZTLTsLoZNPs2hsAnIpXY4mCWiboF+xtrciTI9yuPcq2Qsq0aEmb7H2kx/51HFFpgnst6VgQh2f0tIHyo7zrJk489OoV2QMDqmi6PwEJ1RqyTl0HGJ0Mhk5Y3T4g9LNS/NlgY7R7DT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI3ZPBCTWrxVKMKoPdmb/nvIZIPKo3cQqzbg3osP6hg=;
 b=fU7ap/YFdVjHSW6F0f0Czay5c49tFXIZtDvpb1Y6dZx5RF4+mt5cfGRrwDeILFkJiCI0BpA/Fis6WbnBl1GGv1pA+q3ODgdH92e9DuFTKYI3w9D+k02VtuxSPPYpI7NlQr6Xkwy40f5MvsyFILtAXxPpWTdDEWDoC/MwzWEok48=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DM4PR10MB6767.namprd10.prod.outlook.com (2603:10b6:8:10d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 09:30:31 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 09:30:31 +0000
Message-ID: <535a0cbe-8386-40e6-9632-bfb78a2dddbc@oracle.com>
Date: Wed, 24 Jan 2024 15:00:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/374] 5.15.148-rc1 review
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
References: <20240122235744.598274724@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DM4PR10MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: abc1a883-e97a-45ee-c79b-08dc1cbf1bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	70ZOFuz9vKwQOptOILqbBhR5dfvEMTzvV/vL4q0YbCnHQ2W/LvYTw1B4PLQiUgOeONR/FOpkDgXGHSdUl+REoItb8Hi/yFmIWysN6o1X5N/K1uZvh7TxH3exGWEdAkNJGRH5K0DRrH42d8mv8NnSHxCtLQnK3NmIjx5ZmXK7NHITk2EA97Ur7EyDQ50IGrMYdIkZTODkdtfhFzCgU391CaVHUP0iP3IhDTfyX7BK5a/qYlw1pBNQCsq3VG4IHVyw0dKBCN07pDoGZhWLLHD1byUiKU1q5ClNRUbOFxA9srAJhKAEv0vxEqAE5PKT2RATro4GECwxP2qUvL8wosf7DMKWN/MoJzYi1IUhckGluwfIaw3MsEjZCjp1UT7Ik+zT47/kGwvYWQyuixLO2R6OCUsO7pkdlW40FYW+OTIxA8b9U1BZnQWs5xTfh1fLGiEcVIRJzY+OgG09JRyPP7izVYF+ZBWpTkYI9IiqM7u1uTHDx9w5438ARTyYncNe7uRbIQr7dMH0X4skNS/h0wOvU1zoeMPnr8SVM05bAZtvk+dsd7lCUcyqZpCr3lkN1IQUhcZQEiU/wpCS4kAuHKG5jAL4iflSL5doqXBOyk2YotyHDZv6PX9oLdsE65Rn9Wt3EvaCF8CT3wV98cvQ1B7dXw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4744005)(2906002)(31696002)(6512007)(26005)(86362001)(2616005)(4326008)(8936002)(478600001)(8676002)(41300700001)(107886003)(38100700002)(36756003)(31686004)(66946007)(316002)(5660300002)(54906003)(66556008)(66476007)(6506007)(6666004)(966005)(53546011)(7416002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZmRKRU8yV3ZuN0VFNjFhdEF0a2NCbEd0Z20yMW1udlVSalY3YS9WVENDWE81?=
 =?utf-8?B?d0g4SFdWc2tWaGN4OXkreWxXeVU4R0NCMjNKMzV3UVVHTFlHUk4vaXMva3RT?=
 =?utf-8?B?TlpKS2hqU0FlTlY4WVY4cSs0bHY1SW5DRXBSWXI0OUxMb2creUJHdlk1Ni9o?=
 =?utf-8?B?VHNlc05QVUpKQmR2SEF6cTBZc3lhYmNkYWxaRzFyTnk1R3pBYWhIZXZ1a3pC?=
 =?utf-8?B?S1lkQ0pudERTb1VkVzZNSkVtcm5IMWhJdVYreHNOMGFPcjdEbG5Oa3FMTlkx?=
 =?utf-8?B?RjVjNzVJRjA3cE5kNlUxYVI2N3JkR2tEWDJxdEdIcHdOM3p5Q2wxZDQ4akxa?=
 =?utf-8?B?VnFPcU9MdUg2dHRIdVFBVE00a2ZiZGdQYTY4TlVhR01maUFyY2Z1QjVvc0lk?=
 =?utf-8?B?SUFGVTArZmJYQk9LYWxzS3BHTjl1dWp3RzRmL1Z6anN0dXJqUnJOZVdXbzQv?=
 =?utf-8?B?UG4vSG4xSlc2VVRIN25ZOWVGZk16QTBGQWFmZzBGN01CTFQ5SGRWaVRRUW9t?=
 =?utf-8?B?MVZ1bHIyRlZXWXhvV1NDMXhiN1M3S3lkOUJpU1dNSUx1WTNRSzlLek5uYldR?=
 =?utf-8?B?NzFkNlJxZVhYTDUvNGx4ZFAyZDNxNktYb0ZXbGlLWWtaOFZBRzB1TUo2MXlW?=
 =?utf-8?B?b0dRbEN2ZktoT0pRQ3NUYjkvZlJGcXA4ZUw5ZC9jeG15cWxwbVdMNyttU05t?=
 =?utf-8?B?TC9ROURibVFRRTBJMlhiR3F6RmhjblNFUHJvbit4TmpwUklMSlpEVStFbnZr?=
 =?utf-8?B?UURjSlRPZmZPZ1FKdDNTem9rUUR5VXgxVHpRVkZkLzZMdEptd1d2UExTQVhG?=
 =?utf-8?B?NVV5ZVIvd01RYUU5K0g5dkFjTlRXMVhtazFLOFVVRWo3UGZKTjhQdTBHaDVv?=
 =?utf-8?B?TFkvaFJiU1p3N055OWd1azA5SGJaNWZ2ejllclpsaXorem4xNGVQeHo0ZGIy?=
 =?utf-8?B?WUE1UmhzcEFtOW8zT2pHOGZialRpVUxhNmJmTVdoVUNKMnU0YWtGTEk0VWVQ?=
 =?utf-8?B?c2xzRDZxckRVVGYwS09GN21LbWx1R3dmd2k1M3BYOTg2ajdKazZpTldPN094?=
 =?utf-8?B?N2xoM2FNazlhRnIzY0hPbE50TGh3dkt1dkVmUFJneXdkVUt1OEdqV1ZseFM1?=
 =?utf-8?B?MWZhR29HbURneGtSUE9KYWVaYnlIVWRnbVZZVmsydjZXMm4wb0tTb1JobjFS?=
 =?utf-8?B?MnAxYmxqTThmQVZCL2ViSUIwYlFDK2NuTDg5WitYejl3b2VuelZDeVRncnNZ?=
 =?utf-8?B?WlBWOEpWZk5FK1FiMmE0N2NWZURXdmFHUm9lVkFuUGdoc0tQM0wrQnNSWmdE?=
 =?utf-8?B?UzBpNWJ4OGlhZ0EybCtLdDFCWG5xamdsSTdobG9Xa3Y0dHNDUUl1a2hYRTl1?=
 =?utf-8?B?VTBOdkt6T3ZqbTd5b1c4QlhxSytjUlVpVFI0TkxqYmZyalErMDFyb0U3b1NW?=
 =?utf-8?B?dEtyU2xLbkpVRktoQ0xweDhFTmFGVWM2M1JpcVFXVVgydDBkS0pxYWVCMUhR?=
 =?utf-8?B?M1dvMktUQWpkMktwNE4vejg5VTdDSTFxTU42ZjJMRHp1UzlIYk16Z2xXaUFl?=
 =?utf-8?B?WXdPcUlGaHVIRGQwalB0d2NpSGx3VXA4ZEtCaCtlWGttRVpUNENCbnhDWWoy?=
 =?utf-8?B?N3VRVkl6ZmxKY2xCblZEVTdpMGdpTkhCUTNTMzBtcUw3ZlhzdUZURDNCYmhj?=
 =?utf-8?B?S0pmTENnNGsvYWE0dVVaWndSR2pjV3lxOGN0OEhaT3RpSEZwUDdaTEhrV2Vi?=
 =?utf-8?B?V2QxK0IwWDN3TkMwYmZscGtVaUJkMFpTRGpnbndHV0V6aG1tdmdxVEZhUzlC?=
 =?utf-8?B?N3JZeEx5SjlXak1oMTFUWGxielJvdEpmcG1GOVlkdEJzbkU0ZERRcUlmdXor?=
 =?utf-8?B?c0pER0toVWZaL256anNYRkhSb2NqZGVTNG9zeEQyVzhVbG43TjZ4RnJkYVVE?=
 =?utf-8?B?ZWt4eEl4MkdsdmdnajlNeS8zeFZPampwc2dKT0FJVlk3Qmp2a0d1Y1F2OTdN?=
 =?utf-8?B?bTk3dHd4S1ZBUWdZSzhFWWVUTG1wRlA4OVZ0OHR3dnNYVUdiWWNzNVRSandX?=
 =?utf-8?B?MHJVZnBOVGxRMGdoc2VvMittaUxqYkNkSjcwVis2eTM1OURCVlduMW96aXBk?=
 =?utf-8?B?V0Rrd29xb3VLTUNrMWM2UGE4S0R2azl4MGJ4bUFodnJ6YTA0dFE4dHRsemRM?=
 =?utf-8?Q?meUbe0fwItLARpxK3xGeo5E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TSFw1E4LVVtwfwyeJewz8raxrtjs28JI4m2LPvzfk8aKB0aHHAY6rj9oAh9qezBnRaCdd08BPPYfGXeQa1wyXBT9L9GfWSocvauBbhOgY9HnURnwOFlOz21LS8Z1bZPry+EHJYc+lcUM0sZFN7t1+pqCy72sslyAOUAqVfbxtJ2G0EzzPHeWWuk0fn/3HfIDVGCJLkcy1sKLoQHwGXEBTxhMrfdtpS1CzyykpCEH4i0QmCNrPOF/KZNlqsUmUJy/hmQv479bATXLyDo1+wWjFBGkqZEti3g4RNb56xFhFTnLH7BCakZuvbqAmogOzT06wboYwSxw+zp03X6RC+8Op5endh3jRn3AmXejNyJHqOTB4GiBNCm2Tpo4YGLHYzwLO+fk7Akp8sANuXoPg6QJ379lEC48vGCBAd4gWMPreOZywVYGsAI6FZjlSX6psLFXWHjPI9FCwWZZKH1qCgtpgR+lv292WJuBGFap8Cv+lenLp+TomI92YhbRNE8v+r0q/6tEUU4jv8Je1i6P8o2SRwG4q+uBtoLSpgfGzeiVKJhGSXMkklsqxRkiQq2sCrG5R7l/bbIqXPD/+44H2iSYbQ3Pn5J6IoJi4crDC+Wgrks=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc1a883-e97a-45ee-c79b-08dc1cbf1bf8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 09:30:31.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/dSnPDfabWCD/12g7OvSnJkahyZhIyaNti05DgI/h8M6PgMtfxBBaA3eqoD+U8pSaCL8jzgqkhytCBHVamHEOOSro8gckYG7kGACjbNGvl2196QByy0gMsF3MOdH9R8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_04,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240067
X-Proofpoint-GUID: tyju5eq1pjGQKMHdmS9iRhuK4za9VcdO
X-Proofpoint-ORIG-GUID: tyju5eq1pjGQKMHdmS9iRhuK4za9VcdO

Hi Greg,

On 23/01/24 5:24 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.148 release.
> There are 374 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.148-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

