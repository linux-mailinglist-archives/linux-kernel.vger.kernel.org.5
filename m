Return-Path: <linux-kernel+bounces-44914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30265842907
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D17AB2330B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6421272C8;
	Tue, 30 Jan 2024 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fnhELjXR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sKJor+dw"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEC4823A7;
	Tue, 30 Jan 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631860; cv=fail; b=XTFh2FV6jEqoCboiHaNjaHKbo58r3VLVJg/+lN9aUXKorwunofQUxhjyj9TVi56BtvHTQGFEoo7Jz+D24R24p6zzWHjnkx8/nCVWU41qCGh+XMSOvaAPfPiQYejoGiPbyNPLv+cMKAQnOezqlTcUjms9peBKoCzvn2frfcZS+IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631860; c=relaxed/simple;
	bh=Az8gzBN8/6Zk8WAPcqCDJFBcU7PRS684vTMJr5aMulg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EwfLYHgX0XLWzQ7STMA/NFdDQo0mpjdbvnFWgkcAKAr3iK36zITcz4RiLa2FfHeEz1UTxENwNws7MMge9HI+WxphyJF6lqsU45t2SRTSl09PJa/Ed9QUDkMp4/BAFahGs2bWx20AzvkT6nyqJCFeDUg2n1ffMTufj5HZGA+uROQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fnhELjXR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sKJor+dw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UCA8cR020796;
	Tue, 30 Jan 2024 16:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=4tD0cM0reAOzfKN3Ldh/6PYJpDWsEDewF4tLwucqCw4=;
 b=fnhELjXRS0g/DH6dj+MIRXy1UA5xti26QPv3kBw0cQJoiY7QKYgTNRP/Rc9/r4hBq+WU
 Wi+cc6B8NcYXDUyd64NeCXh2ZEGXRKkI4t7SFzDzMf04lD4g0WgIUq8FRq+5mg7RCqpd
 D7Au2KimapbJv17d5DoFlhdSALz2ste34AgvF5H03s6SdHr1kXKIb2amnjP/Jpf/IqjB
 LlKRZO5W+1YUvpVe2CaE00zGu1VQ43nqO/tMNeh36n3UQ3yb1q/qw6nxRYiFMc2bw+ek
 NZBw80fyvvFdgMmWMUVVMwrGXXG2cb3oZHVVHWKc8JNO4vMosWlNxF9lFmr9dBnrEpKr pQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuy8nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 16:23:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UG4sli014630;
	Tue, 30 Jan 2024 16:23:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9dnf4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 16:23:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7emHUQgIjJ1yMteOPLFpiocfcge0h+dWmexapaBQLRt/lJ+0HS/UMdoZmw8h19zxa4cncpukbVx8dynzQLQxL9cK4q7AgMDg/HmHWHoZa1G20Bbz0J2i6z/8A8RDEPaqvEMlqQA5v0EnR6XijK+yAhommLVRguHVCG33Bhccv79eIqlnqcekqWCUwmdpZ8CPguYa+OFjtb9j4eihgjxK3/9mOQ4l700DwITJhnkB408pKD/NDYLt0BiLpJKkm8TtZYOI1sNl71bffVHjf+eAg9uL1Siw6fNrus/EjF0bKcOxrJseG/cUBzwjwFTCNCYCD7S8wWF1uCS4qkt+8mnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tD0cM0reAOzfKN3Ldh/6PYJpDWsEDewF4tLwucqCw4=;
 b=GSbIgzKZ4y1o0Gh7enyGnIdhnwyvlG7Mhqm+rCIZPVm2JYJRb0Q6ia8wrP2gNEK+0Wgq7+Kds6SJU4kxbatrQaalaC+cMczWOkrge5tUd6eDZuCwHz2A4+JcMcwlucDR0Zh8jSc6+a5paFh3K9kxN6bGp+bGMCv2xYLlRK/tnrXd5anTKOj9odR2DMS4PTwZRrJuBJUDs8Qgk703him1K4K7DcM1g/NzGTfq9Zwdrme7Q2+wnd3qBbc5ICd/r75GohQwOvCaBLyTNKD7X8ShCEL/hmDfh+wHOkPXtaWgehd5/6G4Foj1fPFp5M92UeupSVVoWZyCRHKFr26B4yHOyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tD0cM0reAOzfKN3Ldh/6PYJpDWsEDewF4tLwucqCw4=;
 b=sKJor+dw6An4lnUTT3QRZpLkTmaNzOlzh1+XNpUl5janAuUxjRhrVvehuV+kbc75yYdNk3Gk/TpHGucgfQYoVex3OHPGxNp6ZRb3ovr44R+wnVsELtHtuhB6dh4FTntOqjrBH2YHi1hbu1ivMgltr/T+kmJjjvJBFyjuIRwbQS4=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DS0PR10MB6101.namprd10.prod.outlook.com (2603:10b6:8:ca::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 16:23:41 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::5997:266c:f3fd:6bf4%4]) with mapi id 15.20.7228.035; Tue, 30 Jan 2024
 16:23:41 +0000
Message-ID: <63304f6a-d26f-414a-8c92-14d740774379@oracle.com>
Date: Tue, 30 Jan 2024 17:23:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Documentation: Document each netlink family
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, kuba@kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, edumazet@google.com
References: <20231121114831.3033560-1-leitao@debian.org>
 <874jevjgvo.fsf@intel.com> <87jznqewa7.fsf@meer.lwn.net>
 <ZbkebMW+xLqNhsoB@gmail.com>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <ZbkebMW+xLqNhsoB@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR2P264CA0020.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::32)
 To PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|DS0PR10MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a72aa3-8a49-44f8-cc44-08dc21afd28c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+ze1Mx3P3I/y0l4v8ahkiHInn7/3CkqtADPClXizOKqmTpi3ivlYkT8rjpmADRsbEYQi7jbNJnOpWkp7cbimAhsUzT5DQQAkK7nBp6X2vWFMVt5qu+Tny9XTXPUCAg0ervtNvX8FzLNOXbdWLsMsNzo4if8ssMSLkoAE06F/zDTbfrVlCglp7pOJRnOuOgq9HtVCTtlaxtmUFivfEXwvo/ta1e48lItACthlqtPKpz7QJOBmwisjfmzq3VVa21t7RFqzEr8zVwmFsbyXVzW/ArhD+mmPXWXP79f6acvbh9BIu2Li2xcvYBrEuTLve/+AmfZbC89f81K+w9EugE9dAsvBbRHi7vjMV9r6CUP8oJgc5XmOBU3qsl1JNVWLx6xrWcHfjPqnLwAh7pEAJJreW2qkUwV/PyAXc9UZ3osGUUHjv0lVOxWYg6156Bkndn7X638K8LNdVkO1nam+HyW6FQ+X3d/MuUs5nh4dzSfLpZaSJXJ0SXtGBHWXQXb+w5422It7j9mQWX5x1styvPQA/iZZ+FUPjrhwBHgmxVBoFUr21snMh/Pc1LQgyNvW7cb5ym+gDn3HAXtidbJTSfdPW3BsFJBhu3bVC51o5aQa69dGHJRcKMNX5CY6cDuD7xpKZuKnJApEYE3fZWpbsNAhnVga3QL1GY8hLBxhHON++O+vv7SoRgDCY4QbfIXfZ2xu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(36756003)(2906002)(7416002)(41300700001)(6666004)(2616005)(53546011)(6512007)(83380400001)(26005)(966005)(6486002)(66556008)(66476007)(110136005)(316002)(66946007)(54906003)(478600001)(6506007)(31686004)(38100700002)(8936002)(8676002)(4326008)(5660300002)(86362001)(31696002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ckM0UVkwWFZSUHdCWDJXRlFJdEZJV1FiUURNNm1WM2VUMzRYU2RuSE9sMC9m?=
 =?utf-8?B?N2dqYkNwWmJoNnhrblc1aHJ0TjlDS0ZmTXJoRlNzWFkwY3YvcHJLYlJjU0I2?=
 =?utf-8?B?WG5ubWxHV2Z3T0ZyVkMwUFNFQ3FsOVBlc3hZdDhHc1pHTFBlTE9lcVY4MTAv?=
 =?utf-8?B?UHVwRWdrbDVTcWNMd0l1WGlTcWJEdEFLYVFPZHI5N3JBRXJTVWs4dFZHeCt0?=
 =?utf-8?B?elpETkVLZWcxOGNCVm9XdlZEVVE1WkZwMnFFWWsvYWZmTit1YStOcjNzZDZQ?=
 =?utf-8?B?SURxQWNHMGRrNU5reWxCYjJ1Y2M2MWd3OVZ3eFRISis4TlZIb1gzQVNhdnhB?=
 =?utf-8?B?VHBZNXhycnIrMDlxMHkvVzY2bnhuWkY1aGdQNlBxQTU2UGk4MFQ5YVhMWTNY?=
 =?utf-8?B?L09SZ3NoSHRWd3pNNHhHN2ZYemd5cGVaNGNQOUVOcngwaTRTRGxZR05LZ21h?=
 =?utf-8?B?azRmSGZJN0xjU0F3TEZWaWF1STJRbkRqTVMyWXl6VlhPait5aWdhUWZSWlpG?=
 =?utf-8?B?YUMvWUY2M3NiL2I2dTlHMTk2b1hVT1krNDdEZEpGRHZIdHN4Ym9DdmJBVTZt?=
 =?utf-8?B?UE5DdG5PUFMwRWovME80SnkrWUVEcDFNNGtYeEx0S0hVUWx3YkZqVUdzazBC?=
 =?utf-8?B?VEVRQVlOMENMZTZRTlUrR0Z4RktXUjJhU25aanpUMUo5SWlpYkNUVXFoa3N4?=
 =?utf-8?B?YkFEdzFxL21ZQ1VZbjZoS2R0clVhSVpueFVPZW5YYUhVM3Y2eGtEeU5QTXVq?=
 =?utf-8?B?Mkp4MzE3NnhmdU1wVWZ1MGFiT1pvV1plbmF1Y01tUlFlQnJ6emp2Q1p0d1g2?=
 =?utf-8?B?cUNFVFFiUTVWelRnOWVWUEJFS2R6S0lEbUJ6OEtrblhHa2xpNmFMYnJvMm9D?=
 =?utf-8?B?RG9EOXlOaDRMM3N5eGEwdUFDK1lLVnFZTEZPVUpRZHBITGJ3b3hBVVhFMkFr?=
 =?utf-8?B?dTBHVVNnU0hJV2czOHljVTQyR0t5RzIxY1h5Yk5QZjhJSnRKWTZFa0xRcy9a?=
 =?utf-8?B?c2lRa1lrMHZyL29DdlI2S2U4dEpHVG02dkwxTEYreU9nTzZYdkdpQXYxdHJw?=
 =?utf-8?B?b0kzNGZad2lRV2liYVI5ZkhrKzRTSzlqdTVOTFNzY0o4ZnVzNmJXalNVSmpm?=
 =?utf-8?B?ME02VXk3SFNMUVNYYTJnS0V6RXNjaDZNTXBTczk3ZFFUMytVcVBOQ0EvQVdP?=
 =?utf-8?B?bitBMk9pVkd3NzJMTUtUMWxxKzZFbXNSQzhnRzNtSDR2dXg0dDVWUDJmalJM?=
 =?utf-8?B?MmludStyVW1CbEN6YWFNK3ZobFZ6eGVIdXhzSHBGeDZQR1gzWFNtbk4zMCtR?=
 =?utf-8?B?OE40QTFmeStyMnBRQmpxbkNBQ3NOR09UdzJjWXJodjFIdDB1MCtJZitqOTJY?=
 =?utf-8?B?WDFQWm1uVnl5MVlIMXJGSDFDL0tPelBpWFdBL1lZR25pbk12SEpEamhFS0Nu?=
 =?utf-8?B?NTNYZDRpODlJQU5jTVNWTDR3UzZlMTdjbCswVWZCM2I1L0tIQUNObENya1Zr?=
 =?utf-8?B?WkUxQ1dJSFoyMHYrdTFheVV6bnUvZDU4eE1DZ0huaTlkM1hHa0RvRlpDMnFB?=
 =?utf-8?B?RCt1MVVxcTR1WEZBRzVieWN0dDVDL2R1RnA2REE3NlBYUVVIVXpIQ3JsYUM3?=
 =?utf-8?B?dUdHVXBPSXBXeWdkWi8xVWE1T0k2UUZrTVhwNWF0c1pSZDVzeklOUitpOEdN?=
 =?utf-8?B?a1R1TFArMk9YeVA0akN5L0hKOTFySkVSZThVQTExcUdXY2tQT2VOendIZTgy?=
 =?utf-8?B?WUkrN0lmOFlnSG1GNi80TzErSjVlVlJLS2oreHg2OGlDdnRpSnBSSlhjNHIr?=
 =?utf-8?B?Nm5sMHMxTWZsQ1pNNVp0bk5zcjVFRkpwSm43cHNhZTNYRWUzTG9GUWtOZTdo?=
 =?utf-8?B?ak8rdmR5a3Q4dy95OEhqMElkQlpGT25xaG1Mam5KK0J2WUltYllISC9KWGFt?=
 =?utf-8?B?TUtuOVI0T2V2VjkvTG80eElPUTZBRlFrK0QxRWE5ZnYvWHFlOE4xcGh0Wk95?=
 =?utf-8?B?Um9HbVZFdEgxNDNMQUZXMGJ3N0NGSWljNmVIQmNod0ZhZjJwUTF4OXp2UEFG?=
 =?utf-8?B?QUdvYzBZcDliZnpVNWw2Q0JSWUNuNklxTFRLTDNGc0M3STZZNnVJdXRXUWhU?=
 =?utf-8?B?a2xjZURPN1RUMGZLWWg2UStNeEVXMzVUZVArSHVIRDZvRUJ3LytTNVF0RHFY?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	K3vxsMM4gJooKx5EkJj5Yjx4xfx1LT0C533SjjigzJjn5gnuolFRnnDUVnwRXV3vFij2CKNnJW093L9SXnOcNevjgTjbWLsJfMTqONA0SC7I9+YcBA2lH70fJmRRcu58WwdK+/0P5NWCDZmmkFqOwenfSpF6XG5b/qWITqGVMKBWj9Wc3WFuEjYTFZaWR1zgnGt7FqI8OahlxdICB3FLVv5J1saK3xMBLW9T5S5VOeb0riYhrkauBxgBR6vmLQYIZJe9JCwdrUCk5gnrQrfjQn4ixSywPAqcTsOt+g9iBtfgcCtQUCwzLTbIs3Gr72wF5PVOuZJXOgMkGFwiPGESFN1RxYABYnTdyP2Yosb9vDHen7C2IhlWue6Y70FM1qUm7BPfIePKEJD8LJhy6yOmjQTfnHmfSyFthbHB9FN9mPrsjUp4J/SboI9J48+XEm8NaI+khyPS97R5bhC5exd6ZYMi5f84N1iVAmFa3Lspcz6HC82SSffmJ+ytPDwnK1AkLtr7PVZ8OU943jacHoYfLx9haIpE7bUP3N/AxAJ58VIOj7btsgfByNTsmSBNH4k1ieKbu884S4upwUIzigbT3GLsH1RdPapc/U0qcEuEPj0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a72aa3-8a49-44f8-cc44-08dc21afd28c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 16:23:41.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2IUFt8wUrPZ+Tz2gOIhV3yTkKK5O+HuDo+ebE7HU2J1JQFxfoeTLIfBk9LvrqBIMaVPLWPAdXQcFqszi00GmIjvugB8hr+9TJIeolDTGnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=871 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300121
X-Proofpoint-ORIG-GUID: S10pBbbnre91zn59ESaOjJKaZFC8VOYq
X-Proofpoint-GUID: S10pBbbnre91zn59ESaOjJKaZFC8VOYq


On 30/01/2024 17:06, Breno Leitao wrote:
> On Tue, Jan 30, 2024 at 07:22:08AM -0700, Jonathan Corbet wrote:
>> Jani Nikula <jani.nikula@linux.intel.com> writes:
>>
>>> On Tue, 21 Nov 2023, Breno Leitao <leitao@debian.org> wrote:
>>>> This is a simple script that parses the Netlink YAML spec files
>>>> (Documentation/netlink/specs/), and generates RST files to be rendered
>>>> in the Network -> Netlink Specification documentation page.
>>>
>>> First of all, my boilerplate complaint: All extra processing for Sphinx
>>> should really be done using Sphinx extensions instead of adding Makefile
>>> hacks. I don't think it's sustainable to keep adding this stuff. We
>>> chose Sphinx because it is extensible, and to avoid the Rube Goldberg
>>> machine that the previous documentation build system was.
>>
>> So I feel like we've (me included) have kind of sent Breno around in
>> circles on this one.  This *was* implemented as an extension once:
>>
>>    https://lore.kernel.org/netdev/20231103135622.250314-1-leitao@debian.org/
>>
>> At that time it seemed too complex, and I thought that an external
>> script would lead to a simpler implementation overall.  Perhaps I was
>> wrong.
> 
> I think you are correct. I personally _think_ that the external script
> is better, mainly because it is self contained, thus, easier to
> maintain.

 From a cursory look at the two versions, the actual Python code to read
the YAML and write the reST is the same in both cases. (Breno, please
correct me if I'm wrong.)

It should be fairly easy to support both methods by moving most of the
code into a library and then having two thin wrappers around it, one
being a stand-alone command-line script and one being the Sphinx extension.

The stand-alone script could even be put directly in the library code,
just wrapped in "if __name__ == '__main__'".

A stand-alone script might be useful for debugging the output without
invoking the full sphinx-build machinery (i.e. basically having an easy
way to inspect and diff the output when making changes to the code).

Bottom line: This particular thing looks like a false dichotomy to me.

We should still fix the writing of .rst to $(srctree), though --
our use of parse-headers.pl seems to sidestep this by writing the
intermediate .rst output to Documentation/output/, I'll have to look a
bit more closely.


Vegard

