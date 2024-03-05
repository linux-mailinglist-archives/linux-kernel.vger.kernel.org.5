Return-Path: <linux-kernel+bounces-92305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA22E871E29
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636A21F2482C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA9C5786D;
	Tue,  5 Mar 2024 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V5AYJ21h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gqLBgT9x"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E949548F1;
	Tue,  5 Mar 2024 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639039; cv=fail; b=Wk/7NXuYEA7ymstMSKzeJjLMKGH17v6cts0let4NBl7VkLIBe3fu8FVDofRS9qIPIekXsL44mey1jPmVNGEsbkvE0UCVdRhF+skeGVg+uA7VPrrPpNwm9pQKy/sK6xQvAsUrk2qsegM0gqk0hFjPi1f6clncoIQpg6fk13vNIrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639039; c=relaxed/simple;
	bh=1kp30DXIf3sHEn6m5Md/QFGk8ptt3x7PBcb2+yA4g4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=noGEA4W/XdXsG/NVZrCD/PScKTjx0cbReafHRpsw5AOntpTQ3in0K01pZ0wGoD0Sdhn7sjI4vBZo0Mg2dhDp2VY1QoCAaXJLBGl5dWmj8l7W1I0ykqZ0ae/jn3/iaE2QFqqzvczD+crXSogXB506hmfTUrCAvIvjjufVWyw8UBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V5AYJ21h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gqLBgT9x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4259hicN029824;
	Tue, 5 Mar 2024 11:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EY/wGRBZaS6DiRMayuk5Gl6KZNBLV2bTjvp3bp24DCE=;
 b=V5AYJ21hOS6CtZS8CwJy8/eiOJGMEsIX4EtZ6aRof3Jz7cxOKAY6nmpMXOYwxtJy9Tw4
 zOhW5lzgmCTN56ul1w2yAuTYwspAUCmoS+CaEs4NppJAF71rmyb0Q3oiyr0ItBg7B8/I
 Sp5dAXz6103EQqKmI76WywkUpGkFCihUMzQ6ADaxcEiSMocP1GrLtyJT5toR7h6Vjk3V
 VrT8qN9jNUlrw3lp2PmGHlTYJdW38xn53mU9T49M/kC27EMwY+pcgSXa292PGFK/OalT
 g7LJ+vgnZdaQxPD1EvETlfRVdVji/DOCk93OsqawN1QvkFVvqneIknBRQiI/VcS65mOm rA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkuqvdt18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 11:43:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425BWQ7V000444;
	Tue, 5 Mar 2024 11:43:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjdefds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 11:43:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIirkzb6y9Tm3OkIe0NPJCVNPFhLem+Pfmq8q1wDvsU02fxRuzv7o5hFSFS9ugb4oOTKu3UnMVPVaWUCpIMiYF9Xl6qWugUQbdc/y3x6MY3XNaPUInHt53xgNJ+3/cAKc58rVR0Xhw5zoeLzd+SQatVXSHoUTVVr57XUjr9liYwnqqFOnznqzGBZxY9fkJgYo5p20KBtP3hUSZP8fEXeUGsniG6QxwRBgvFPx7ihgnw0AtslK760Fwqc6KOiUaoeD64UluNtv4OFEywTw431DMS7X+MwyZmGDnIkDIiQSemudRfVh79z5FBvk59c1ZsWyN7KabOEQQzvGC7Hz8qy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EY/wGRBZaS6DiRMayuk5Gl6KZNBLV2bTjvp3bp24DCE=;
 b=ErMSMDh53gfwnC2vIk06yR+pC2GW5ToMQFqeMfR/DMGeQnGFvv+Y9nsZx6Af07syXaeevWt3nTcoheiezfM5m7gmYjHQ9w4VZyApVuQOjrafrOWrVwxIIX16hm+4fpGXOBj8vKFVz7HXkjJbgMs958hBvMCk+PD89j2T/DFamNJh3SgeIjcOfCmOU96B1GrCxQlZ7QOvmV/fGEncmIrw91FB7gvLOjp/Q/G6ZTla10IBj5fQU1zWxgtp7I4fgLjj2EiuemaZZciJfahfohCaViI8NFPyZFUWWD5Rr+HqyHXYniM3UKduzalwmtcKAUD/U1/60kX2/RQ/qVhNHq46pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EY/wGRBZaS6DiRMayuk5Gl6KZNBLV2bTjvp3bp24DCE=;
 b=gqLBgT9xjsFi3GzGnnwonEwx1JtPPVzpGp47IuDMIHjQE7sQzGL2kM3IX3WigZsVpZiRfdG2IFgxZ7Q48LNq1eXc2DV6INcsdxsShsu8xDb0tcuuh2lkvW5G27ewU+J2xQkxKz8OjclOROZ+dbnANS+JDVBQkvyu0qGfOnZBO3Y=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ0PR10MB5834.namprd10.prod.outlook.com (2603:10b6:a03:3ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 11:43:19 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 11:43:19 +0000
Message-ID: <e7bebcd5-22d0-4d13-b5c4-8648d4d6a295@oracle.com>
Date: Tue, 5 Mar 2024 17:13:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/84] 5.15.151-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240304211542.332206551@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240304211542.332206551@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:404::23)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ0PR10MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df765c4-9ee2-4dfd-428a-08dc3d097441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jT1MG2PmaCgp+8BKUo8Gf7zhewhB6yOLzb45d7n/8goaEZls7BZ8p4rpmGgxYifzrCf23HyhEs03SjZXmJSCkthmXsuQfIMuXbzv/DySg+iRp9Dk3PI3RoVn2vljAvygFzsOAAEyt0r4VkndwuC9qX3RGaAWp9qCDePP1DTbpSKsvpPh8jWH74TP+iF5/U4LpEfXZ2Q9fn5Jl9xrL1wYpVJk7ZMHXw5RR70ZBI96zFejRwsyZYRDKBWgdvoQ6SqToRKUm2LIM4i9sUt+2gHwtqibutGE60hxWNSqkdyngQJPS+cieoAsSKZZKgYA11ivXffO0qmqLuRj8vbY6HaoF66LrBFT1AIt8JUS7UKRczuGnM6px9YpJFxaarTCL9nsRecMQU/QI2gXTYzCeuMLSOTAqDDEgy8N50MLpOLccYrMYm48DukAEVaTxpufWQR8vO6f/QUCkuLZLGmAWLqm5x5/WcaIotukk0ydXRkVcywyMQQ6wd7/nDX6p/yno7/M9jMrNIg29eEfLw4xxWg+qDdmZou8rYdqEcWj/lpvJJo5KY0YuDgAruyxgeuUCJbaLlBjU868+UWmrPXsXD8EQDosJqKRP6xUjpsY22rye+4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c1g3OUtYT3I2WVFnRHdkWnhKV29LZWJPV29LMEdsV3pRcTdjVWlHNzVIa0wv?=
 =?utf-8?B?UXFrWGo1TXF0alhNa2t5RzRLdVdsZVpjdTRMeW0wVng5Y0kwVkR3QzNqK2NJ?=
 =?utf-8?B?Q0l3UzN0MnBISXZQekE5b2YrTDkyNEJXNUg2UWsrWlVpcnIrMjBSWE5KR3Nl?=
 =?utf-8?B?amhXS0pkcVRYRUducEVGTGZ0SXdxcGZ1a2JCMFVuN1V4SmpZck1ML2sxdWlW?=
 =?utf-8?B?cWw1MVlHRUwwU0Q1QWt3OXkzVnJpQVJyZWRRTlR6V0FoekxrMWV2OVJnekJZ?=
 =?utf-8?B?emExSmhGbStZNFhkai9HTGQxSjFuZ2UyYWM1TGxuSzkvTzYydTJaRzI1YWpy?=
 =?utf-8?B?dXNlWjFpclR6WlJ4bVFmUU5xUWNWR29GYnQ1NURWcUxYc1hHRTIrOGxrVHAz?=
 =?utf-8?B?T1ZwZ0J3dk9Ca21aOWVhdUYzT3ZsYndlTmVZTzEyUVdjSGZISVgrRDNVclZt?=
 =?utf-8?B?ZHErTTJKamtyQzJqc3ZwdGhaNUloTTF2SEJiMWZKRGk2TmxrYjdMemlFdXZ0?=
 =?utf-8?B?WCsvMU01MFpoM3ZrWnR6WU05U0djSUpyUmQzMnJUNTB2bkl0K2hkNVJUMFM1?=
 =?utf-8?B?UXlJZ1hERUxYNzRJZ21KRnN5eXpVZWtOMUdZek5xMXhXZThiSzhvQzErQUEv?=
 =?utf-8?B?OUlsTUpKN2c3WW80MEJqTkY4cFBLVHpla29Vc0NQU1lLVUE3TmFUNVFHd0hR?=
 =?utf-8?B?cmo4dGFhME03UUR5NVJ0YUpZOGZhZEVJOWR2bzB6RnRkRlRLYlJmNkZzcTJj?=
 =?utf-8?B?UGx1ZEp2STd2V2xzOVdtV1B2WlJDeXloalJVOHgrQTUwN1IwRzAwMFg0L3U5?=
 =?utf-8?B?dXhhRlU1NDRwVW1Hc3RGUEMxOEIzSE9BOWV3ZUJGUXQ2RXM2Q2dOY1JPcUcy?=
 =?utf-8?B?bjdmSDAzc3dScHNseTdXVjJCN2c4MmlFZFAySDUwenNSczZ3U1ppdmlZSG4v?=
 =?utf-8?B?K3hURUxncXdzUVd2cFgzZWo3bVpGUzhlUEgyT1RRTHNZT3dFdXJwNDVFc0xD?=
 =?utf-8?B?VDIrOUtKMGg3K1dyNEw4ZXJqYWkzRlZZekJudnN6STRkMUlLYk1OOXlPZmVn?=
 =?utf-8?B?MnFXREJvd3ZzWEt6ZmpISkpraUlFYXUxL3JoZEZkWGZpbGtFTVJJbUZwUDBX?=
 =?utf-8?B?aDBVZFlXN0orS0ZZSFVnR2NqZS92ZlcxcTRwbkc1M0swaFZ3WC9XOHV2YWFs?=
 =?utf-8?B?dlI1dGpGQjF6QW8weDFGU2tzb0FzUGVPYWQvdDFuK1lWYkxWVWxQVTR0Ty9C?=
 =?utf-8?B?cUVOeGtMeHhiUzNKd051aytMUzZiaVBKNUNtNytXQTlEa0lQK2Z2Ukhzb2VP?=
 =?utf-8?B?Uk9oQ0crczRDSE1EWDgrbGxXT0FSOEcxSVQ5ZUg4S3ZnTGZkRVhQM0Z6VFd5?=
 =?utf-8?B?Z1NVNCtPdU9MZEt1elBnRnJJVzY3eGxPYnJiM2xhRHlsdkFYdGxZVXg4aC8w?=
 =?utf-8?B?WkNOUVdQcUQwQ0hsdE9ucnAvazlIZHJlNnRjYThzZnlTeVNyTXRQTHZGSTcv?=
 =?utf-8?B?YWtyaFg5OEtwRXgwTzZMTE5TR0xVNUZpVmt0Y1hLSElmWEhaU2hlL0lSd2xV?=
 =?utf-8?B?L2dCNkd2MGRIbnFraXBXQ2hHTjFQR0hVSmQxeFJVcHV1ekx0Uy9KdEsvNHBz?=
 =?utf-8?B?QzdZelR3ZlBjUm9GbHhPV1QrVjJHMXFDcHRkQ3c4YWVvL3hUaEg3cUR5SVo4?=
 =?utf-8?B?V0REc0dQbDlML0dQUWVPTHBDcnlrWE1ZL1JjQlRVWU9vdDFuQjB6RVBGYm81?=
 =?utf-8?B?bXhQcDZubjBudGVoNW5adEkwRjRIMWlNMGVTNkdWSmdzQmlQd1Y5WC9hSDBx?=
 =?utf-8?B?QlhqMThLMWFMSkNoR0FlL2tGcXZsSXdaL3pmM3JkRC8zcDRTSDVteUlqakF2?=
 =?utf-8?B?UGFiOUE3Rm02aVdqOEcwZGJJb0xGU0Y3WTFmWG1ZSkF6UmQ0VUYzU3R6WmFH?=
 =?utf-8?B?RU0xVWhsSVVmaDN0cWpTSldKdGNXLy9Ga00wNUZFZTJDODZvSkVxcjZ0ZGxE?=
 =?utf-8?B?MXhobC9BU08yd09od25WSWljSjRKZ25JMHJDVW15RWYyb1k4UmxGMXNBaUdM?=
 =?utf-8?B?TGRueVg3WTV2c09CTUxKeXNYRXRUY2tmL3ZUTWQ1YmFTZ3lpNW5KMTAvNWh2?=
 =?utf-8?B?dzhHVVRjdlBwVmlKRlhEMkJtWlFUQTJBZjdLNkZkY0JFaWdZcmdGNzdpOVFt?=
 =?utf-8?Q?QGvyVeEebteUmacLI5ucmq4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vaGNc0StxByL8+2uko+DnrlbYMqM0LW5REbnAOFszhoZuhJT2kWuG8Tt+4UJdM6tgIFqBgeZM9d9uiNFneP44wkeqDOyAEzpqHBXfpogMOvS2bkt2IxBSu0wMfZ0GsTFiktG49Ql5WsWBgX46qbf1KOi+3bexPBoxtLQHeK41PYlIBZS4WGdFlpAQic9dyuPhyKiOm0iwYoLFCQQdpCzMAXK1I8EWkH1AWGp2ni81MKZgUlTMIHziIb1emb2BjBGIZW7D+puz2i5c8+JUgR+CH272KwIa6fKF6c4fhDHGP1WY5ajeXSn4wnMEX7dC9eRIInvik91mO2Uatf1OjOy7QL5wZ690bYOVG1Rb3cZDwByAv+VA0tk+Mcu4t8p9gR+MJVoJn8y7WOj6QGeyt1Ytfzqt7mP1awLiWauu7c4gHVwyJGPSeUoADCOPGgg2g1iwwuvAElP83/PH1n80+z8rPjKt6LR6bagzRS0f9KFd+1gV/HIx7dPX06vME/N+APdhPr2bLPdTJOAWTnrv6Kl0CLntW0GwzYH8GP/bmRwARoj7/beyHDtKN89HgQKiCD5pPukjexmVRAu04S74xjuOSr9BB/ngZSTIQv0fAMnNSI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df765c4-9ee2-4dfd-428a-08dc3d097441
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 11:43:19.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0gUpK5+I+rICySE3xCD47JCyWurNHMH63HK2EsJneXltlWsndY80GKPE+tH4GtbqGqGzP15RBCwpaTJeIS8XVK0boSmcQ0XM+1qnN2GTu/fG9kHyITCXNnvfJ6fqDWj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050094
X-Proofpoint-GUID: drar6HpZfJcGB1CUQ3WYcbb9zlvTtrLz
X-Proofpoint-ORIG-GUID: drar6HpZfJcGB1CUQ3WYcbb9zlvTtrLz

Hi Greg,

On 05/03/24 02:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.151 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.151-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

