Return-Path: <linux-kernel+bounces-85524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE3A86B70A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2201C2290A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DD940862;
	Wed, 28 Feb 2024 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gqI7rzLs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qGEbrJBI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5E14084C;
	Wed, 28 Feb 2024 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144347; cv=fail; b=CZ/nLg0EYVlh2X4uPxr+5axK7AiqTOTA6kclyUGF03bjLt2jete4X9e2zsCCp8HD7wmn2PNriUwgFPE3j+9fTa0/tVSKwKKTLg9Eo3v7ODB0LUDAFV3fLzDs+0wPnJFbyK7KBd3A265u5jNrtF/lxP3CLVFmB3AuEIp8oSGWjWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144347; c=relaxed/simple;
	bh=yBKVpjuiqxjzBqG1HMoY6bsfnZDYrQ/43fNcUGi7olw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NdYCNj52cr+C+Jf5np8/MJo1qKkbUmkPRvd8UTHvuJigMq+7KOq2J+AQ1aG3sV96UIAsmLjP7iNsnQ8yWmVfHIQ0UL15EqEl/BIhsReKLSrpAGbjNaEwPLUD6vJdkYyd7xfPems1gt+JZ3uikf+8GEsPtW4lHniDyc6J6QwxvaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gqI7rzLs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qGEbrJBI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SElNSH016476;
	Wed, 28 Feb 2024 18:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=eCW47JPjPGD6SmPaUeoW56ewuocxSaR/Kw/F5fBLE98=;
 b=gqI7rzLstEXBI6kXpxwfPA7hHwMfAc29wARgFfZIAWk42/1yJupZ9i8xwmsDPiCl5txB
 FEbmInf30CFvNKIel51LAJXUr3WZeundx9V/dfi41RK7nOEU6Bf9W9bhd5G2KcXB2YU3
 Kmx3JakdkGinT9UmZ/4p7uHYmTnF6hhlvxF+FKJaNtYCrjP7K2WkIma75tByavSWhABh
 Y6yutK8uNj/AFH9bS/KPZ3k1ppyUz1z0m1lIcuYJL4XMyJT2vFUI6bSEL+4Z2pgNZbx7
 IuiWn9tbq0NFEVKvtOA8WFb6L09Kph8ifVqgGZqh1k53k1XaRKJ2PNtYlbvm9lH4/aBI Vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82uas9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 18:18:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41SIAosA009940;
	Wed, 28 Feb 2024 18:18:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w98q0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 18:18:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNqqs9gEkMnh4Q3XBawC8+KuEoh1z7j/JC0Y4IhX5HQVW/wLjznLXZluemj1/57FKwj5sed8omg5NRfhxSs95zkJZBZLGZWvg5HWtLWDJ4xUjbhJvUJ8j/YQWsyWZErhTvnXzqUmOFkOyizIKF4jvDvuBHGqlRSYv4W9jD3BUmdLAXCaF+TT/uOwo7G0cGod8UFGPRAmhrMb7wL8DSu7YLV2wXVjB8XMJp596X0uKEL4r76c93VULiIekWrIxKvlIdJaYaJw6T+RQpld1Lc1ofLXd1f/DGV4Ly6PYoYVKUnl44zrHGpweLqfzo/Dq+sBBOblK+kmc47tZYcaQ7E3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCW47JPjPGD6SmPaUeoW56ewuocxSaR/Kw/F5fBLE98=;
 b=G69s+v5X6jYFoPmvlWnVEiwdN9Xok97jd7Sk9BQveT1ztU9x7LOQdrYpVhWah6n7Xvj4mfNbNI1GWWIOde09KsOV/+6uVPhOhBbfH3+kq5qF1pB2FicXV6zGLwowIA21KEjJLYckFZRPxOWaQMEHb16uO4ZjTuitUG6RE7PL9Iwot2PG4uo0+snlFdvSn3GsVEXC7L4LVJQxNyH3qv3FG/ndCIjHCdCj2owQeQ7j8SmhXXBEjH0NkjyzbLkKuY9CAS0wh1E1rQ56ZNq3mA7KR+FBrwOmsi5bc6QS1303EVIM5R5F8iTQqLgRS4Hdtqqa1WOXzp1z5hIA+gUzUIMEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCW47JPjPGD6SmPaUeoW56ewuocxSaR/Kw/F5fBLE98=;
 b=qGEbrJBICmoTHFSTMZHhvqGkQITtmyXXe5dPWvbX94Xmq0mBu1qbKQ45HCGcCJLJpzpZcN2YGIUdGlO5BnNrhmtXIkYvQE1OYitNC2G8XD40j3q//d22YAXDte0CdOI9Bi+rUJSyGw+SyOQ+Fcrjh+HyeF5tuROOaZK2TCtksk4=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BLAPR10MB4833.namprd10.prod.outlook.com (2603:10b6:208:333::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 18:18:21 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 18:18:21 +0000
Message-ID: <99c1b608-3e2a-442c-89fa-6dcf79697fc4@oracle.com>
Date: Wed, 28 Feb 2024 23:48:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/84] 5.4.270-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Darren Kenny <darren.kenny@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20240227131552.864701583@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240227131552.864701583@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BLAPR10MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: 77508734-7058-44b2-44cd-08dc3889a507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5Wxw0RSpOBVlm3BXJoa7XVTMwzh9j2cLEym/LVL7wcFDNiE+NomD+OAzZxbC1j0Z2pq+VCzes4gDzuLOzcMgyaP/VDaLuNsPJMX5y8dcTorlleBfff6ZYdvrymQSJfunNwR8Ur6cHpP5dnBwLL/lXZ0IxRb6qeVhI5Cd5oc/dq2kygLFG2o5ZY4VZAHxS62SVfq+0QTYRHM9P4a6o5ubH0jgYOe1U41qjTHynVMgCX7IoXEbQ5oAhV6RlK0j495L8a4wJXiUZyx/veEEJAstePzwWxh2ECNwTNKD7NsmSO335wj+bZW6al4o4qsGQ3L42zrRlR/WR9h2zIX4QCjVEyeOpRIXmz5c//wH6cZ/U6oqhV8F+pcAieyvHNkjKOiBkTcyA0ZUBK5m66qPgj3zbQm0BH6Gqq+t+W6OAED4UHzPXv9zpRi9N/2QhSs4XS/Sc5LlTewBT5ytE3g/SZsUIJMM4RISv9gcEhz/TCiqZBqfe9b9WWaJlTQQx/eKLnpq6XgTW0z/HqpC2DLcS82Bz1mBxWM8YXBxoxCIF6a1Ed6lR4CH2xqW8fqJQsHAICPVYR2RVdz93/LTjuPaipfyh68nHw5YEXxxHePGG/ygwoeVL97h5pyhbyXBhbwSmJqF
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVZubkh0eU1Nd2RYTVpyUk1oNzI5WTAzdTNDSDV2dVJPNnRoV3I0a1Noc2hh?=
 =?utf-8?B?cjN4Yk54ZVlyQ2hDOUZJV09Sa0ZHRHlYZ2tOYWJoV0pHMERyNE4xaGh4dmo5?=
 =?utf-8?B?TEJSZmVTZSs2ZnZHTmNOSmxBTXdXY0FjcGlTUDZuejVhUWJTL1pSTjBkbkdC?=
 =?utf-8?B?QWdMWWlhWVJrVkpPYU5Pa1VQdG12aGM4bG9TTDhrU3ZyTDJwdlp2bFN4Um1r?=
 =?utf-8?B?NEdIY3FLNzYyMDl5V0w2QVFwWm5Id0VudnpmL3hLbjRYN0JIaHRGMWYzTmdm?=
 =?utf-8?B?cTdyd1hZL1F5UVZoSmJ4L1RvMnVLYXVjQ1gyU21CZWh2TGNIVG5xRVhMQmlz?=
 =?utf-8?B?VDJwL1hSWEIzcjh1MXVBUHY5SGZOeFZJVUxZSFIvMys0RHUwN3ZmME1ZR2Ni?=
 =?utf-8?B?djJSdnV4eEZ0M2N3dGVHZDRvY2hIYjlwRXR6YmFWYktJK2tadHVlbHpKaHNi?=
 =?utf-8?B?bU00OFhTMWN6V1U5SnNNbDVYcVNVTG5hTm9mN09VRzlnWGZEQWpGVllIaEtE?=
 =?utf-8?B?MldQbGRpNnZBOFZ5UFFvTHNDWXJmZW5hVSsxd1NPMW5qclc2d0lVTzNPbit6?=
 =?utf-8?B?TStwZmFLK0kzclpTRkVSTUI4WFozRSt1aUlkNlJQSU4vOWhCS0lQd21vWHdO?=
 =?utf-8?B?MDlEWktwWDgvaUZjNng0YWhtWEtEdi9ZWnVucEFjbWtDTWJ2RisrL1oxUkJn?=
 =?utf-8?B?T2ZwQXlGU3N0cDFiSVhIb1EvczBiQ3VmUnNPZmhLYWFJZW1hRUYzN3NSUUpT?=
 =?utf-8?B?QlhxREphQnViN1E2SFVNd2x2N3ZKL2JYY2VBd01IQ1NuYkVUOXpweFpvQmU3?=
 =?utf-8?B?MDVQbFZsN3FlaGF3S0lQNkgrQTB1eEx4VXBZRzVTUEgrekVicm5XN08rbjNZ?=
 =?utf-8?B?djVCK3paY2FYbm14eTNBTHlUOXZML0tGdHo2b3BzUGd6LytmMmtWL292SFhS?=
 =?utf-8?B?MEpJUU1vZFd5S2NaQlhiempuWnZWSVZOaEYzcW5meS90TGpycllxTkxmdUcz?=
 =?utf-8?B?WEQwbWJyRFM3cEFRbjFYS2hMcFEzQ2JVd25lazRXVTlmS1djUStwTllSemtp?=
 =?utf-8?B?QmIraCtQeWNualA0dXR4aE1Qa25tMzQrY0VydlNBdDZETHVndHFEeFNjdTA3?=
 =?utf-8?B?OFQ4YUJVWEVoRzUveEoranJrckIzaG9HUlpobnBCM1dCQ1crMlBBZG5lSHdV?=
 =?utf-8?B?Z2Z3Mmptd0RTeERjNEl5UTRoMmtndEYwYkJ2VHJUWnQ0Q1ZReGtCeldOTnRD?=
 =?utf-8?B?TEhrQVBxK2NGSUp3K2pRcjZ2ejc0Yjc3aUVDNFpPZHhMNmlsblpLdzRyZ1hW?=
 =?utf-8?B?Ukk3elh0UlFSYXU2ZDBWSFRnOEVjZHVxNzhjY2w0V2N4Zy9KNnduRTlUOGU0?=
 =?utf-8?B?S0owUTE0UWdsYjc4M1JWVmwwMWlrODltQ0RPekhYaGxjTTJOOWU3Q3JnT2Ny?=
 =?utf-8?B?RmxORC9aNTNaU2FNbWE5SndOTnovSStnYXFjMkpRbVdJVUNycE96VERHd0k4?=
 =?utf-8?B?U240ZFhDeVllODVMN2tMK25VakFDL1h4VGNGaXFKMENMaXJvZkptd2JkWGM1?=
 =?utf-8?B?MDN4SWF3dnVvdHNVUFlLeUcxUzBoSHB2T1lhYUcwZ0RleGF2VXc2NEFnVUd5?=
 =?utf-8?B?enV5ekFnWlUxczhLZkQwVVB2bk9ZdVdveVlmdS9FMWZaSUlPRHpPUU9VVGNh?=
 =?utf-8?B?VWRaQVd1a0UvaTZ1RCtsbDByZlFJZ281RWRkZ3F6NVIvQi9qMEQ5KzM2ZE50?=
 =?utf-8?B?NlhIR1RpclludVU0NTNMcGhKMlg1empLeUJFSngxZy9lSW9KR0JOWWVjeFpY?=
 =?utf-8?B?VnNFdVdKdnhvV0w0aFJmNGpqemtGSTdHdU9ldGVsbmtmM0dRRmVYSG9oUWlP?=
 =?utf-8?B?RkNkT2JrdVd3QjdCQ0NLY3VROFBvdytXQ21aTFJnT2VOWklxOXViVkF0T2VM?=
 =?utf-8?B?QTV6WHVJZW9UVDYwZVE1MGM1Z1laNzEwNC8xeG9JdWVtem9QSlR4T0hveU4r?=
 =?utf-8?B?eFFhVE5OUTVHdm9HRUh4cGdLVVMrZHZZSVppSDFaQWthOS9TTWdlRTJ2Q1B3?=
 =?utf-8?B?WkFjdUdDU01NWGhsUm0rRE4wNUkxN0Q3SUUyODNJKzZhZW1NNWNQa1Q1TXpM?=
 =?utf-8?B?VDBRMDQ3M1ZSeWk0dUlrakVqeTZNRHgxSjVQdFBPQmYveEN3a2s3WnBnQllT?=
 =?utf-8?Q?i134NMHnGIJ62Nw79AQxORs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cw3EiQwhKCxIXpIuq0ujH0h4HbjmEeyC+/qnTMOpDzWw59INv9J1djTOnvVRO1VcPqKkPGobXFwkWouYdTyCm8L195l4frTUw96IeV0j5/YnR22ZS0POaVRu2h2E6oi6ehwjzdAWLWKFyaE426CuV7aqEGX8j+kWs+iN6ECm7rZydA+6FT+aM8PggBsnlesmAjdcLjfk0d5yXptopaShDBLNspuWIDOXOOhzgfOmCnCKIjXP6inzkxXYgf5RpOJhN9oZcTjtmURsEwqVU9ERcVyRgu5bgCguMLBTjVwM6zoK+/rz7EAAuPI22nhLYpc3Dt0pL16jaonv4ojWhMzQ8FZCGCcI67jDF6sWbEnMWGb266ozW4Y5EwfLA5Uk4rPrdWeAMMfUXvir35IPfBue7+YZ6t3/QtJYtgd6PFpCL7U9Z/2a8zvV4PFXEvO/syem/MivqY6BI/qEcKQ7wOv6egk6dBgQ1S4gnhbpXUae+iCjDsOD/TRrX5WyPzesmDd/ngJ9S7xf9Pdj+CKfccuHle+pMxkC7oxiYy1xCqYFGHF6Ji5oIdmKHaSfDVzsub0bT1FwOh05Y08dxHrkV76fI8Wp1b9y70scLFnvKjwfLU0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77508734-7058-44b2-44cd-08dc3889a507
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:18:21.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4fkUuRkiX/s8lx1MYFy7v97QqDt2gUyWaxYDr146CAW1qPRwzxeRzUXzONAhO5y19XJDLPH7pDTay9TO5eLmocUIOJzHO/yPPkvOVDN486trQ10IjjlZgmXE9PwUhuf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402280145
X-Proofpoint-GUID: 26eUmFsroYo8hnxmXfEk34nlRKrf5gqR
X-Proofpoint-ORIG-GUID: 26eUmFsroYo8hnxmXfEk34nlRKrf5gqR

Hi Greg,

On 27/02/24 18:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.270 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.270-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

