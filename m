Return-Path: <linux-kernel+bounces-64873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6C3854423
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82764289316
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336316FAD;
	Wed, 14 Feb 2024 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b4482f8f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IuIrwN27"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8F04696;
	Wed, 14 Feb 2024 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899867; cv=fail; b=JOWp9VRHbbz+Mw8PTTuS5MogjwmWQyMgkgNV9oXazkC/lvwe4Gq/llE/e3FFBPM0ibT4bX2HKVf33adlpzJriwuUMZaEjOgmiUbSKUaZRCu/QX+q26dA3eHiHz3akMwRZugNM2de/nfvM/yYI52wvwwv7oFdzZKKnfxRpIPavN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899867; c=relaxed/simple;
	bh=Jwd1/HfM65/HRY0nXb83NdB1CEr9z2nUvg2GmyPIPUs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DsINzn/7O5Zo34aOUG3sFtyEUl6x6YYq3qQKXasEgEGdE0lEj233A2yv+zGW+DanBXXPKYsSdHrjLTi4+SSFIMoP6ljHi7/zq8Y602BzG95w0YMUTKmJccneBtEx7jBeJYr7etYf6jphk+Qnf5WvMWiyQyLG0zVePA4REmJshXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b4482f8f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IuIrwN27; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41E74suw006297;
	Wed, 14 Feb 2024 08:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YfkmvhRmKeLofm10+EfBkpIGvrL2t05nipxQ9LhUvwA=;
 b=b4482f8fergD/n9h5zMdv5jlMMJjKMFAvoptQc+vKLsWk9GuXzT0jBMVwtvyal4/TrjB
 3J+BW5GHpE59PWn54PM8J7zaoJPdnuwVYco6L0hNNnusqumBiT1uDXWK3d44vxOGVM82
 1T23HOOe1JlxtSzGEb3AIRYPPp86qXe/RZw4vYlYp8peLzrymsyodXK4yFBEOhMgi0u8
 Tpy1kf/fpvIIYk08Ncs9d4qAGHEEPG3hyr/RTfgSds1pCrdi3BaAgWRCeIpfEXYM0k4B
 c5Cll6SAY0/NrX0tltzcr/VmhVJ7lUC2SFiFP7meWTrH2K10MdC+PvHK6nDQiSQQOx9L tA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8rtcg5f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 08:37:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41E70iNY015008;
	Wed, 14 Feb 2024 08:37:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk8mn2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 08:37:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3ydr1RYzmh2V5UuD/1bYaIMbbU0ZPTkerqXp1mIs/hSDM1Uv8wgAHzwadHv+D18vdY941kM44sS0I4+svTFb5rhTbDMG9JFm2ODJWNP1DRMO76hG8DJyPtUMHBV6brGrAi1jV9DQMczHJ9Vn3pLZt2fd/fPnrzlhcd94jJuxIeA+ayaK4hOvTMPqYqsMef9hNNgQNpvOzZcIgrD65J7vd58SpzD37uQkqtLSSx5RfhbArDFMVPV9+XkP372Pw4wQxdZABwpRetQp8Db+qV8Je5Nw46WCiMQGXyZEBV6odDutbzXPc4Y7cZzMMYCpVzK9y4nJoWMUNA+CSVzlAIS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfkmvhRmKeLofm10+EfBkpIGvrL2t05nipxQ9LhUvwA=;
 b=l90vgIUVKSDsv9J+OF93QS8I/08ACTXJAV6rY7z44ZgizEmuE/Nh+/nnvl7/oNV2K3qdRBH2yI+Tixeu5JNUh1kDRKttBsygTd0a8Wye1+KhRun40Qev6nEACto0WvGPYIAAcQG63bmXoTIkYHtQYjHLin8WqjhRPt1jI2CZ572Yex5HFhIJPEeRCautw0rAOjSm6QFxk1qFxd/zd5Bodc9z6noGVFRztBu2ZoYHxsCAmvo7WQkhhjPMFl8ZKqXv6BIqJZY72PZQ6foz8/Hf3uJzvn7XgL9Cko0W4CgM5cgFI7Vwo6FwCW/GQ3vq5J/yYPBIjqVG6ld/TjCElQ7kgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfkmvhRmKeLofm10+EfBkpIGvrL2t05nipxQ9LhUvwA=;
 b=IuIrwN27DLIJci9kQwZkPwcmlSxUM/BGA+tPlvZasqku66mH30A8NHHWIflQNyZxQ9gAmWp4SoBJYvrAZvgChrd+dNR9g2yWXAMsZ3hygrwQ7uA3wcDA5+2KqNxtu3TZvcQYXT7MXoNVmzhQkqAljXxH3kqdWAoxBviqwyZV+YY=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DS0PR10MB7344.namprd10.prod.outlook.com (2603:10b6:8:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 08:37:37 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::6e32:a89a:f2b6:864b]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::6e32:a89a:f2b6:864b%2]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 08:37:37 +0000
Message-ID: <00057b93-b5fc-4536-b13d-cd3b6cead5b1@oracle.com>
Date: Wed, 14 Feb 2024 09:37:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Documentation: Document the Linux Kernel CVE process
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, corbet@lwn.net,
        workflows@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
References: <2024021430-blanching-spotter-c7c8@gregkh>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <2024021430-blanching-spotter-c7c8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0089.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345::16) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|DS0PR10MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: e52b87a5-e556-4816-6d62-08dc2d38326e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lYmhqtR5wufebCyN2hSbvCiuawAitO/SOc/OPR6tTwyageUXGBL4fbX8C3/fkt5StlzBya6ZDlkVAOcgJlyA0ruCiPx+SjurX4XoPFDoWCyEHogJEEDctSAKE1QJL7TUYwVzjF8Jn9lyBPkQi7C9oY2UJAKRfy/3wAzAuOWYXW/f8nSs3ufmRS5iIJLgfrsSe4qeAnHhqOnQJHx3iNMjbPs3bMRRDLMI0Y8tnFY+Oilk/pEpVFcOXjbrLatTZAoA1M4MUydzPhn2NItt+Whwm45ZJO5RxBxQ95WkzaFqlBkmz/KcF9pRSY4FnUW/wejEo8gB90fhrOhSmQZeJ/T19N0TnfQb2o8jZmYf+eCe4SMiaT5amWcCErzZ2ijEdwsEuFJPN2JYErNGPD/CtgeFvpqpK/RuImCsrRX+edLEqAZJRXVUKvEoZUxQXaqVON1BSvy4oWNEk3eyj91+OCj1xY3Y06pcpYSLtvytfFZp4A9GFNwOMOEgDkIKe671PKRJyntL6xsDdg9EkVhCkCvyg+wUt1kvT0MQbMC9EMvww+GSXCRdDQW7xvs99rm02y88
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230273577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(44832011)(38100700002)(5660300002)(26005)(86362001)(31696002)(2616005)(6506007)(6666004)(53546011)(6512007)(83380400001)(54906003)(66556008)(316002)(36756003)(66476007)(8676002)(4326008)(66946007)(8936002)(966005)(6486002)(478600001)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eVdjNFlpeGJGRTNHNEQ0OVdkTmxZWGdIdWhZdnQ4SGE2STBwT3J1WmRSZUlx?=
 =?utf-8?B?bks0NzVFMXZ4R2plTVo4cGxyMmNMeHFPRTI1emFqVjVzWHlmVWEzWEJoaGRQ?=
 =?utf-8?B?bFNSZ3ZWSFlUZ0d4TTNhNkVlSXRsVElUckExVHRpandjd2VUeE5XRXN6T2ZC?=
 =?utf-8?B?REdodkZsaEt1V3NQdFR6Vll3a0NQcnhVQ3gwbnNTT0g0NGpyWXlOQ1ZldzNr?=
 =?utf-8?B?Rk1IUjZBMjI2RnJZeFNhaFdXUWZabm9vOVdycnJwbmtXWnV5TlZGNUZvNnlP?=
 =?utf-8?B?ZDVhODFFZU5kY0tIR1hyQi9QUmNTTzYyS05YdnRrWFVUQ3NTcjlGeHJPMHEv?=
 =?utf-8?B?SlM2V01abW92dURZcXhrTjJ4dVVqdjdjeXFPc3doaUgvV1BzRzhnSU5oUmRK?=
 =?utf-8?B?VDBzOU92OGRtVi9KVWN1MVl2ZTJiazdRVU9YZkFnVHk5V2p1QzFNTmk5eEVM?=
 =?utf-8?B?TlRLbEY2KzNSV1JDSXdzK3p0QkVDb2NDRXBHdytWZnppOEhEYmxRL0tmeHgv?=
 =?utf-8?B?TndQMWN3RDV1NEt4RXhTNUVsemx6Smw1K1RRUUhzN01od3VOMWhOMDZYR3JI?=
 =?utf-8?B?S3FBU2pEUS9KbmN0dHFBY0RLWDlqd2w2MDBWQ3MrWk1WdW81bmEyWWh2d2cx?=
 =?utf-8?B?T1FSUy9rUWs1WlBuK3h0c05UMG9HMmVoaFRqMTZZaWc2aVNQOVQ5OEIwVngv?=
 =?utf-8?B?cWk3b1FxUmJLWVdnZWJ4ZkxxMDErc2lCS3FnRlYrbGU3RUR0Y2Y2MmZIKzNv?=
 =?utf-8?B?TkgyakJrMEtxai9PdlNqVVhoRmk3eHY5NG1SV1k1QTlWTG4wSmE5Yzg4VHBt?=
 =?utf-8?B?TVBxVDFJdmdNaUJHeDgvRXlFeUZZZThyT3R3WTdLU1dMWHFjT0llcy92K0pL?=
 =?utf-8?B?Y3lWekQxWHpaZGpWdmczS2ROUXpJOTRqbFZsRUxxSk9EZ3ZENDJOc2VvQ2dF?=
 =?utf-8?B?NVJ5SXZVMUhzOUhTM3o5dXQwNys4M2t5aVltTlRpNURSbGRCNHRMc2RnQ2Fi?=
 =?utf-8?B?NDFtNldKcjA1WEVKTUIrVmpHWFhYQ2YwTFZReVNIYXBmeHVKblNDUlRHTmZD?=
 =?utf-8?B?WGY1b0xCbURuazZSOVpNVWNQTlhOeERkT00xU0lFL0ZaNnlYTzBTdnY5WENk?=
 =?utf-8?B?WHZESGNIamkwN3Ftb2sxc2dXYXlYUkVDaHdrWHF2QllQZC91S29yblI3VzZp?=
 =?utf-8?B?YlRENkJ1dFhiQ0JoM2NyaWdrSTRLVVE0ckgyL21iT2V1Y2M5U293elp1N2FU?=
 =?utf-8?B?dDdNZjB5N3MzVHpTSmg0Qm5tM3kwZmFsTGNuU1JXMkRwTzNvbGpmT2kyTzUv?=
 =?utf-8?B?Y09GbGlWWDl2cFhrUnp3ZkJnMnJZc1YvRWVQdFZ3VE5GODltY0FzN3ZJc3FS?=
 =?utf-8?B?WlR3NTAwSkY5NG5OVjJJOGdlbXY2VUJWS3NaRmhQOEJXNzBqQkhlcS9ONnlW?=
 =?utf-8?B?UGNZby8xQzdLYmtJcll3WlpvZ1lKQ0dTTEVVUVp0cHFkdDhqYVVuZ1l1eitE?=
 =?utf-8?B?eUp2WDIwcHJ6N3NQYlp1d01kd3QvanRoUUFCcmY2YXRDUHBTWnFpNm1wbWVX?=
 =?utf-8?B?TXBsYkhjQUFaMXY1T2RYYnduU3lZTDNNZ0w5SWdXZ1I3MUF0NjF0L3ZxUHYx?=
 =?utf-8?B?aXJHUVhmUjFOMjNzU1U2ZTZFRk9tZ0hxN1ZZZUpMbk96and4ZkIwUXIvNzM1?=
 =?utf-8?B?VWpTNGhFMTA2REVHdHI4YzFZZXNiaUJkNzVldFhYWEFMV2E3TllmTjVYb0J4?=
 =?utf-8?B?WjhHeDBJSlliVkNWbDhKVEhoRm1vNDk4Z2ZodVc4SGJYUUh6dkZBYnk1ZVE4?=
 =?utf-8?B?YUtGZy9XWHJsSmdJbmlNa3JabHNEUmg4ZFlpOTk4bmJ3RmlHRENmOXpENFpR?=
 =?utf-8?B?TXJiL0JrM3FYeHhDWllDb2R5eW9hUXpmSHhTeW4wUFovcnh1QmV0cit0NkxB?=
 =?utf-8?B?eHQ5b3VMYW1haTIxNFlXY2V2dnlIS1JlNHZOc29CbkZjWFJMVU1RTEZxRzFC?=
 =?utf-8?B?T0pReHVqTER3dDJLTGFla002czYyOGxXYTRTVmN6WWZEZFJ2RmprQ0xudTBO?=
 =?utf-8?B?cGhWMlVCa0t6S290aDNHa1NGNldleUVKTXo5elNXbERqSGtYeG4reEM5bmJH?=
 =?utf-8?B?WXdha2RydXZoanZmM0Y5ckFJYzZQaXNPQWtQODRROEZ5b21CYXJDZXBHdVFP?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UVQm25ZwsBkj6FGgfhQ5mGe9UMjAge+PlIOSgV71cw2zyGs2+CtJY1Bt/BtQwZlBRbdQNn0NN+JEnmP/nPdUG/eaqB8lwccOh5K/4O3FSw95diKRmWq3u1mVCIDi759aQB8iLrAgTEs/nUgVK08oEDaOXrkEyu4gcdoA0XfTxMaey/Geb1r2N516+b6qHdptvuFw6OYmJe8whDQ9PWZiKLxtI0G4vNPTFRRbq2lKByC5a7faIv8VCtBcbIvtlIE4V/Q7PKd0AiTW3b4iGeCCMFz4m294fnb4LPYe1+srHIGV05fN/Mb1A2uRAXFS2Qa8OGYroB6+C72K7F1u2WEdB368j6jI383VnzteKFGqvbYU8DQ4q2qeg9DlqomxL2Gz1SXsn2cOHnF0nPQZzxtr93noUeyd7iUXBB1MI6PAfXDD+esLPNz2bCMTtQIOzlnznOgI8XuG797m7mXUYqnJwxB02jasAbSBmehQMw8czSHv5N3IvCfor0/llPHchcB5MUL5NB5em2Usl1aqe/kZUbZiBp4KJXX4fnaNZZjNSsiNgsUGtF6hGJQ4e5ULkD3Yz4Ru/VHOju3XSthzZ9LFjk+At0+4rp/bUB8NxGheJQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52b87a5-e556-4816-6d62-08dc2d38326e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 08:37:36.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2amiMhD4XtF3CloYSDph29ky5t56yOkYeys6en2RPn+9T7snYYrGGGuCBzo+G7QGmawawCRJcHFfmbeUkT9znjyY5HtkaTHtYcK87QX4ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140066
X-Proofpoint-ORIG-GUID: i2-nsFsEDhxr9vYybJPWMpKazTdkWtIU
X-Proofpoint-GUID: i2-nsFsEDhxr9vYybJPWMpKazTdkWtIU


On 14/02/2024 09:00, Greg Kroah-Hartman wrote:
> diff --git a/Documentation/process/cve.rst b/Documentation/process/cve.rst
> new file mode 100644
> index 000000000000..6465e6a79c18
> --- /dev/null
> +++ b/Documentation/process/cve.rst
> @@ -0,0 +1,120 @@
> +CVEs
> +====

Document titles should have ==== above them as well, and then you would
need to shift all the other headings in this document (i.e. all the ---
should become ===).

Info here: 
https://docs.kernel.org/doc-guide/sphinx.html#specific-guidelines-for-the-kernel-documentation

> +The Linux kernel developer team does have the ability to assign CVEs for
> +potential Linux kernel security issues.  This assignment is independent
> +of the :doc:`normal Linux kernel security bug reporting
> +process<../process/security_bugs>`.

These documents are both under process/ so it should be enough to say:

:doc:`[...] <security-bugs>`

In fact, when building the docs with your patch applied, I see:

Documentation/process/cve.rst:15: WARNING: unknown document: 
./process/security_bugs
Documentation/process/cve.rst:42: WARNING: unknown document: 
./process/security_bugs

Note the hyphen vs. underscore (it should have a hyphen like my line above).

> +Process
> +-------
> +
> +As part of the normal stable release process, kernel changes that are
> +potentially security issues are identified by the developers responsible
> +for CVE number assignments and have CVE numbers automatically assigned
> +to them.  These assignments are published on the linux-cve-announce
> +mailing list as announcements on a frequent basis.
> +
> +Note, due to the layer at which the Linux kernel is in a system, almost
> +any bug might be exploitable to compromise the security of the kernel,
> +but the possibility of exploitation is often not evident when the bug is
> +fixed.  Because of this, the CVE assignment team is overly cautious and

What is the composition of the CVE assignment team, or is that secret?
Should this be a MAINTAINERS entry? (s@k.org is one.)

> +If the CVE assignment team misses a specific fix that any user feels
> +should have a CVE assigned to it, please email them at <cve@kernel.org>
> +and the team there will work with you on it.  Note that no potential
> +security issues should be sent to this alias, it is ONLY for assignment
> +of CVEs for fixes that are already in released kernel trees.  If you
> +feel you have found an unfixed security issue, please follow the
> +:doc:`normal Linux kernel security bug reporting
> +process<../process/security_bugs>`.

Same

> +Disputes of assigned CVEs
> +-------------------------
> +
> +The authority to dispute or modify an assigned CVE for a specific kernel
> +change lies solely with the maintainers of the relevant subsystem
> +affected.  This principle ensures a high degree of accuracy and
> +accountability in vulnerability reporting.  Only those individuals with
> +deep expertise and intimate knowledge of the subsystem can effectively
> +assess the validity and scope of a reported vulnerability and determine
> +its appropriate CVE designation.  Any attempt to modify or dispute a CVE
> +outside of this designated authority could lead to confusion, inaccurate
> +reporting, and ultimately, compromised systems.

Just to clarify, I think "dispute" here is used in the
Mitre/CVE-technical meaning of the word, correct? I assume people will
still have the right to say "hey, this doesn't look like a real issue
[because of X/Y/Z]" on a mailing list.

> --- a/Documentation/process/security-bugs.rst
> +++ b/Documentation/process/security-bugs.rst
> @@ -99,9 +99,8 @@ CVE assignment
>   The security team does not assign CVEs, nor do we require them for
>   reports or fixes, as this can needlessly complicate the process and may
>   delay the bug handling.  If a reporter wishes to have a CVE identifier
> -assigned, they should find one by themselves, for example by contacting
> -MITRE directly.  However under no circumstances will a patch inclusion
> -be delayed to wait for a CVE identifier to arrive.
> +assigned for a confirmed issue, they can contact the :doc:`kernel CVE
> +assignment team<../process/cve>` to obtain one.

Same here, this could be just <cve>.


Vegard

