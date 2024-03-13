Return-Path: <linux-kernel+bounces-102462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BB087B273
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7393D1C211E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418354CDE0;
	Wed, 13 Mar 2024 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MqR7SLnN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MgomBJMf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9345C818
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360204; cv=fail; b=pjEaIyK/R9LRrsmf3IPd4gHdW8eCo65Oz2DEAGS7MOnYs7aTzmhdDB5dkIi1cQj3VwTSKQ/+2vLahHQgc6CEhM3XBm72+GlUwfMvgoU9vqdazxtrggAS55yFOf7JTuESAhq8Dc9lHRDtYLW/IWkm2wvaPSjMTeEyX2lZtPJZLjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360204; c=relaxed/simple;
	bh=/z0iPX9bLasBhv31o36ZVWD9AiL56eRzg+dD7geCdJc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gAxHiwPIlP46uHqDBvSAHHmkcVr6mrS4W8Aav51dZTnBY6Rxi5gzjEoFxrsfx+mpVnjaF4VSnbuqvlMf+V7AEjoFQ8+M/Br8At9uui1R4E20z2Zb55f2lI3PUV1WvbfAR82yS5mfYJ0omWIWtoowF7TF0TLlR+BFfWw4T3n9HsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MqR7SLnN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MgomBJMf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DJOSVD028559;
	Wed, 13 Mar 2024 20:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3HwPtT1XUXL2hGjAtFTvIcjnjmhSf9jt0R6J51mHMuY=;
 b=MqR7SLnNIGfQZ6vtQtFzlS8MhlWIrYsVCzFGYW5h1IQ4ci6kF7GPEJVTSI0UJyprJX4D
 0oHzcGvzlFFWHTC8yhQiAg0UEjRwNQPFwuT5wCfVoi70UczpNEL7iSIST6EHaa9M1tLN
 ZuaNlaWpSOnBST9NWnzs37wKpWoVwPgJ4CU0OeU2fl0WnF735XgjVHCqSjdiUkTPYHGm
 JGMf+JiF18QftHuQCIrP+SbXVdh8RYdDPCzs+G85WMNNVG+nWZfduFw3g6uVZpEqWKkE
 KmNliUhSz7A4wVxG/dxOllllWF8Hwped15iOAuCyqGrBGOxx4df4GNo7HTHy2jrCHnXW wQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrec2ht89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 20:02:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42DIjRM4019753;
	Wed, 13 Mar 2024 20:02:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre79c0f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 20:02:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/mqc1S5CsDBooC9PY525iQYcnOltala2/Zx2LCHW6AU+bHGZGha2pvBw1liqIiyCmqJCqJNbSQGUanOBxJIMqH3P9LtahH/Hrz2xPOY8wmeYWKyxaD5zCspR0cMvNZ5N1plcL8BwgGwGad07RzupzsTG2P3ikV2Y7MtkZWvVw3tYjMjm+YHP/diJ0YS6qWNPtPlabHSwCuyts7tz4LCLKb9eIfIZzMkSo1YXrSG28+OEGg0Zt428GPCqg68+fB6z5bP6tABy4VG2wj6t9A7Od16LcLdvBCRxvwxUZqI8wGQChcN6Z+AdnXQHB3Chn+1ziJSBuJjjcm9wCCuf4zScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HwPtT1XUXL2hGjAtFTvIcjnjmhSf9jt0R6J51mHMuY=;
 b=OjyVlN/9VNdRPoWrVTWK6Xg3qCEjCUXoCX5fTL0WrVaOaOQB2hU6sipN85uERiZTca7zJkIuM2QF5z9wjlF+P10ZIfwnMCg8GG50iNazzhhht3q7/ijezMWNQaDFzUdE/wyX3k8KKtbR0rLWLtTnR9qI3bNq698vv/UoaAWGZKLDlVEAKXDZKa/iQ4X2rEKab7bK9vmOwNB1mW9HxBfOrgHPbysyK7QmIab7A8THqL24tEAZoslyPziLQ13wthMCKdsNe1+hiDErYAJf353jwc/bcL5yekXoOsipOHYpZicfQhCSSLmBeFh2+2n9rkX+2mbA50Uavva5Jf4pWxmPkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HwPtT1XUXL2hGjAtFTvIcjnjmhSf9jt0R6J51mHMuY=;
 b=MgomBJMf0CtjBKeUpiakjHAIZEi5K7QD8X5A48MSZI0/ZuFfGT1LuPExvhIo64FPLVRloS4fV+HWSglt6cIg99DrCngsG03jNurr/dLxq6WT9jWgqfb2/Ao2sYXSQefGt20kWHvrdq71FpZgBLpklkmseDtW190eHAXR0knDrE0=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by DM4PR10MB6910.namprd10.prod.outlook.com (2603:10b6:8:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 20:02:47 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::88ef:4ee:6255:5391]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::88ef:4ee:6255:5391%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 20:02:43 +0000
Message-ID: <7d749469-4e6f-ab0f-8fc9-4ae19ed08a25@oracle.com>
Date: Wed, 13 Mar 2024 16:02:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] sched/debug: Use unsigned long for cpu variable
 to prevent cast errors
Content-Language: en-US
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira
 <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling
 <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Cc: Suleiman Souhlal <suleiman@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        David Vernet <void@manifault.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney"
 <paulmck@kernel.org>,
        joseph.salisbury@canonical.com,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
        llvm@lists.linux.dev
References: <20240313012451.1693807-1-joel@joelfernandes.org>
 <20240313012451.1693807-6-joel@joelfernandes.org>
From: Chris Hyser <chris.hyser@oracle.com>
In-Reply-To: <20240313012451.1693807-6-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:208:32f::16) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|DM4PR10MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: f9640081-8216-4132-3ebc-08dc43988b80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qSVbuQ3il2j8hfzbIl94EhpZhqzfD462vKzGrNFWG4JfuLl1lMqU94s29kULwRk9qbglbPMwMCf9vYLc7S8DkJVcLDCbY62IwiRp595dn6XXcuZ4sN7EHRN72b2L8U0KlNGCyHA7kRk2v5PBVgKnUqLLM21J0JxulpWk/4MOArEnvbkoHEdBdoPhaV72nEaCJXAAdson8qXQt2tCcAJzfK6l7f5ZU7QM+zN+ctbtm0HeTvrlo16bxhoff9pORYifu8mlTZk4VWfuGEaviSpULMshh+aGSAvNVatmc9pnklrWPGXhSk2mr32lIuHLxm06puIHWd80hUkiqxqbytTcZzgGmvhQaaElFwITcJpH0GNcWBhakGRxXy4Ws/VMpTbjKpjxVkxRcKyix2zS2Z1J+AnOplXNrFA1vFYnp3+EdenZ7tK772KhNYIo5rPPImPR7GLdrfybWbofHiTznZPH8XzLYjkgQiLxhQXts3F2orR2vxHT+6PpFl+U2nDzMqUK9HgFLpgd0nsEwIy3+P/V5kPiUS50WHiSW2kc3gz0Kzc9ADIKMeEkR4oACzUODFzJ4ARelekOBqtjV6hWf6pWGjg/hqGODTNO8imd6fDuO8rqBGEcXlftNLwpZdkjypbfH1zWOqHWaY/9J+1MytSUKRtIMmYzT6vDk+Dp765E9F6ZowWxE7RR2te7QrzvwSPlq1Mhzd1/fxOwsB48Zr71Qg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c3pWRnltaWRrTkZ2TlZpakc4TTFKTThzVld5cmx3NzFNYnQ5Z2lxNUc4VlQ3?=
 =?utf-8?B?c25Ob2hGSlcrSmtzRjJuV2lPSzd4MTNKcG1mN3lqdUplUHJEVGF0V3kyRm9a?=
 =?utf-8?B?cENMYzFnaFJ6NTI0a0EyY0llNnI0R2h4clhUZjNuK0VPYisxMWV6TWkrYXd0?=
 =?utf-8?B?c1loWXV5RWJITlhZMUErSE95TlZpQThjMDVHQTBuU1lWRGNnMFB0Njh2UG8v?=
 =?utf-8?B?UVEvSmgyTlZhWVhnNUg2RGUrVHFrdlM1Q3N0VnA3Q3dzSk9uQjVzOEtUN0FD?=
 =?utf-8?B?czUrSVgzWjNvSS9JSVV2MDZFT3REWjlHajYvYmpPa2lwS3JkL1EvSll6V0VV?=
 =?utf-8?B?OXp6d1E1SG5wZXEzYldsZ0xUQmREMkphaCtMWmZvQzBYZVhzK2lZMU1jNnNO?=
 =?utf-8?B?YlRkTEJZRjBLUm9qZXVlVmV1U2IzaHVQR3Vhb1h1YWUwTVkyUi9XcGxXWTc0?=
 =?utf-8?B?Z3VmS3l0S1c0WVlKWFRhUS91WWE0OVcvQkdpYkYrOGsvdEpUeXpISVVmNXpv?=
 =?utf-8?B?Y284V0ZZdzQwMStQVy9rT2NUZ2ViOWRxbU5jV0dKWDFTS0Zna05WTFRoS05X?=
 =?utf-8?B?WGhVb2gxUENHeTRMdWVRRzVUNzhobVpxRXJXemtucUUwbk9TMWRxWnZRVyt4?=
 =?utf-8?B?dkFiS2ltRGhiSUM2WG0zQUkyYytIMXU4VGNmaFR3bkcxNzlsYXBSMG56dE41?=
 =?utf-8?B?NFFzL1Bwajc4ays1K0ROSFJlaVBhNVBnM3h4RmlueUZGSUZ4c1k2bVF6MkRC?=
 =?utf-8?B?QVpXcDFBSDBNUFBRZGZ5TlVCTFY3ZGQ4ZjdPSWtLazdOWHBHV1FrL1V1R2Nz?=
 =?utf-8?B?M1pnMHNLclcvRzd4TStmeUYyMVNRMWdWOGczcVNoUjRacnlzakhaTVUreGQr?=
 =?utf-8?B?c0ZBR2VRTHVWaDRLU1gyMjZUQjdFSGFRa21oSzlhZjJKeUJSOFlDVGFQQjF1?=
 =?utf-8?B?SXdMOU16aWI4S2w2cUtUR0RudGs2Y3djenVKZytBVEFaNTdaaWI4UWNPS05y?=
 =?utf-8?B?UHdjYVpOU3pMNVFwbENCZHlOT2Fqdm5FVUtwdzlQeXRSd3dOLzlkZTBPQnR4?=
 =?utf-8?B?ZHh2ODVPbnhkWjYzdTJzcDhEaEVNSFcrcTMvdU5JSGVTakVUd2ZhN3RSZ3kw?=
 =?utf-8?B?MzBNQ2Y1UEZnNzlXSURSYm9NUkVmSWZrV3NycytkRi93bW83NjhZT3BCaWNM?=
 =?utf-8?B?ZHFsT3F1Rk8zNUE1Ni9tNVJFdWV0UjRzZmdXNFc3RFNCWmNvQjltS244c095?=
 =?utf-8?B?RUdESTA1SWJFVlk3ZXlac3RBTnlOMm9FdlZ6N21Kb3hLcFprYVdVMXVVb0xL?=
 =?utf-8?B?Rk9Fdm1pa2puVEVFVGxkNVFnR0dzQXV3WXAyamtFbXBhbFVadS91YmdZODJz?=
 =?utf-8?B?UW5tMEdIKzJzRGJiRWdPMFhXbnNRSmNKVER4WTJkalR2VlA3K0hOUjRMNjZp?=
 =?utf-8?B?UC9MVFZZVnpucGEzR2Q4cDlxeitwMFpoT1dJSXFYQ0VhTjBrTG5JcEVmbS9o?=
 =?utf-8?B?UStYU3dUODlBaEFsUld0dUZGQm9rcTRkVmFDNHNHcU5qS1F1VnMvbjNTM2V2?=
 =?utf-8?B?Z3R2Q2MvZ1lqU2RiMDRvYVdmQ1QyMkE5STdHL1ZrUVB1TnpOdjlFbkVGcTRF?=
 =?utf-8?B?SnN1WHV3YlEybUFNQlhJcXltMnlIKy9iQUFrVlRNTVhpSzlIVEdhRFlySEJw?=
 =?utf-8?B?VnR5dDhua1VKeXVWRms2c1A5cERVbURqQlp3aFB4QkRZZVZrcExCZFYxUjNw?=
 =?utf-8?B?L3l3OEdKZFk2NmNPbWZvLy82UGlpRzdzQlc3cHN4WDJqQk9EVjNqbGFlYkE3?=
 =?utf-8?B?elVBODFrOW5nam4yd1g5akd4YUdKWmtPL3NtQzk0MjBrMDZNVWVRU3ZCb285?=
 =?utf-8?B?WmlROEZSOS9KVUV3M2RCYUxPVFhYQy9mazRDaUE0NzcxSVBhWTZQRG81MFRp?=
 =?utf-8?B?cm5ueTcwNkNVL0pOM2k2blp3RW9ENDgzTi8xb21oUmI3Tzk5Mk94NmZlS3JK?=
 =?utf-8?B?SlFCQ0ZzVjB6eWRhczBtN1VBWkJlWWdkR0dmbFdEZlV5ZXRDd0J6Zm5GTThh?=
 =?utf-8?B?QUdWU0YxYlhHamxqbUQ1UTJRVlpURHhFN0o1NWJDVVpIMTA4dnlSd09kdEdx?=
 =?utf-8?B?eGxhYWJRS0EyQXNGMEc1eUV4RmZLcTNac0lTVnZ0ZFhvZnk3Nm8zc2crUk52?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	stS2IMmR2GfdNAQDO9W1w5yFV7dAxah+b74cogrGrvSghhyYGRPbShPvKkMswSmbcXLW/gf55hiD4YaP0geJ5durkFT7UnoOMT7klzhOOps9nIlO5ZSIblloaXOPlaHUwSJDTSnFl6yIMr2iSJaQWS5o23FMDqc9I/2mOVWRsY/lNZ4xX+fBX+xuwjVAMF6MsX7kIm7nE73aLQnb0zgKfxCkIgaviEVjeBIldg+kMw2JXMp2eiga3SXju6fokVbciJ2QbSzw3RaO8bYWxCgBdPPG13HLabl0wPZnHp25JZIpw93D4eg5xsE2Ax0mcVHLR8EcatL+jZF4rmmJxje6eoGHPj8RaSmpf5pPafz33zGx9poUd38qqPxgnv67KkA7DK3iGPa1tEc+5KmORH7TLzjIC2VBBPD2RI1UDbAp3tdbbNcX2f/87meuJfOuqUEo7KIlhx6XkRrL1wpechfNPi4UlCx6auNXfieFuXm3/QtavN5BXaBHBS0Vpz3vi4VXP1siQqhkzOlEJ9MV2nrKJroyWRH28NzZazLEeYeGWPqx11TCw7Lxb91RvA0BbGtVIG1K+sgOfhEh9uC5oTCZ8vuEYbxfBMFST71877y/hoc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9640081-8216-4132-3ebc-08dc43988b80
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 20:02:43.5953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Umtqa0XVzMtluoOdktXtUsqfMDwqsXQrniRqJcMFDhOp+mLPLYT0J2yXx3aNGMJnjlgljXqLRZ/l4oobFRCiqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403130154
X-Proofpoint-ORIG-GUID: wWiR7o6cUUhRHM1xv1aXxK8F63--akhv
X-Proofpoint-GUID: wWiR7o6cUUhRHM1xv1aXxK8F63--akhv


On 3/12/24 21:24, Joel Fernandes (Google) wrote:
> This avoids compiler errors seen with clang:
>
> In file included from kernel/sched/build_utility.c:72:
> kernel/sched/debug.c:532:47: error: cast to 'void *' from smaller integer
> 	type 'unsigned int' [-Werror,-Wint-to-void-pointer-cast]
> debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &fair_server_runtime_fops);
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>


Reviewed-by: Chris Hyser <chris.hyser@oracle.com>


> ---
>   kernel/sched/debug.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index c6c0120ff105..2590041696bc 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -516,7 +516,7 @@ static struct dentry *debugfs_sched;
>   static void debugfs_fair_server_init(void)
>   {
>   	struct dentry *d_fair;
> -	unsigned int cpu;
> +	unsigned long cpu;
>   
>   	d_fair = debugfs_create_dir("fair_server", debugfs_sched);
>   	if (!d_fair)
> @@ -526,7 +526,7 @@ static void debugfs_fair_server_init(void)
>   		struct dentry *d_cpu;
>   		char buf[32];
>   
> -		snprintf(buf, sizeof(buf), "cpu%d", cpu);
> +		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
>   		d_cpu = debugfs_create_dir(buf, d_fair);
>   
>   		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &fair_server_runtime_fops);

