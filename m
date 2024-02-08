Return-Path: <linux-kernel+bounces-57391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9CC84D7DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182CC1F22C58
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFA61D52B;
	Thu,  8 Feb 2024 02:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GFYW9jEq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fNBFz2cM"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6D1D524
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359781; cv=fail; b=YL6gj8y1fJdoQ3hzI3msMXN/C2YcZtEU0n2oIOnmBj2y5rlIVHu8KYVV+k9TKtQM98R1EOya8Y8dF7JMehJcTKEzfZIsfxWzcjI9wr5+caGKN02qWX4YnXM1iHkykjxwT8PK5bEqPYHDf77auwzOq6upmup79P2jU5rB2iY2d7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359781; c=relaxed/simple;
	bh=ZBiRY/cAwpmURUilkRtcaUoxYHhe6HkrV1y5DQD62i4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qY3xW//CwxuntfX0n2+i/UyhB/5kh6U1Aa5TymtJ3+XuOQxpb1LGZ0sxa62oB/oFatIzJ5fzRbAt2bQAG2iVYuvOwKCiE2f55QYMQlBeMwNb2x+2C0W8J09ttNCPgksO3Cm9oIdj0W+DfdfLE2IaCfrgBZBAX64tb6rJq0T+cTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GFYW9jEq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fNBFz2cM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417MbSu8017681;
	Thu, 8 Feb 2024 02:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=c4jSRB/RKcLR5xyeilV6pI9wuIr3bstI5hvg7k43mQ4=;
 b=GFYW9jEqjNjiMrJ8DyqAsveDQzDpQMY/K3X1LKQ2Mvq3nO+WSUXktDsidwDH8aS7AooM
 3RQG+U93hlIKD+tnbAlT5VPCf4Wn6rKlni8h3uVWQweRng3tFGHlq5Jo47NVFMVwfJvc
 IiuSSYsIzFazZfT5Wj64qt7BrrQKfwwF7MJkupj55qHgwYKYxJtWwGNi/ee3/Z1vmxv7
 ZPbx3CCvxunzj+4VktMXt4gWH4O1AcgTZ3MREpMSADhhls+sedcWQomCNYR0DqiTDfkN
 JejVhd62uNTwgHe/txNdSad1sGNBQ9XiEXwmKHRH+Y4ScdJ1ph/kDLJqsQaqTzdmdAbQ pg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbk9bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 02:35:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4181xopR038468;
	Thu, 8 Feb 2024 02:35:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx9ycf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 02:35:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWRH6Q7ylyM5Awa/23FQJoDn43GGPEL8RGZ+rMSkxKWKaPX/ZIkKlD6klA6Xw0NHDpjJ9q9CHuGdiEGWxtL88vxw+QbpXzhX0Q2FxUE2zBxYlMy08cIdn6E3dgiR01l6D3sgoeFDSH+YMEwIDuINy5odMcDgvaosxFfVdrTiosFop2ktJymXw3bA9imCNhxQgO0hcvO0IvQHCrXgH9/waaOxpSm01YMOlmi7ZtfkhvHa4uJLVOpyxif4wgtvXwrCa4tP9Fp5k9bX+JksWpDD4QUQ9OhcM+7uUWLE93k5gDdUS8LXQkfN9nr53+L8CG21eAVTw3jI8QZSU3y2ucEpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4jSRB/RKcLR5xyeilV6pI9wuIr3bstI5hvg7k43mQ4=;
 b=iMXWzWVrk70kNXvNzG7fdKtAJKsVDy72eQMFYDe8VU50ICN4tBp8QjvkC6MkJzTIXfjaQ+aQGEswwnKMPQl6moRMxzq0xSLkHA+MnhkrDb07TXkQEtHlT5CaWdx2tUhgaeX0nUMARiwD3aBJYgV1EOEVhdNTO0Wa5rAVPIfjjpX/sN/viMx1NJy3vLlUNvgoUAY1ykoXK/vc4vxeYMB9KK9+XuADAHMgP5clQBo9QMZY5eGswF6UIxzz8NQYF0fkJt8zdNpzUnTYY7B8XKxtQpdyBly3zBWZQFD2+0iqZhwr7DhGSExGXB59kum+4U89HURfH3FrzhxEp6phe7ZUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4jSRB/RKcLR5xyeilV6pI9wuIr3bstI5hvg7k43mQ4=;
 b=fNBFz2cMKEayFmOJJ0n0j106++WWf9tbTh6pCBVt/9dBPRr0dyf3xLI4Br8qO6wmDrBtwcvcB442sRXcunaWtj2tpnosGde9pA/f6L4CmMf/elX4RpOp2oauq6THEUmxS1gmfbOZ24lvZxgJw+5z+RkilJVZycmPxH8WxM8MgDg=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DS0PR10MB7246.namprd10.prod.outlook.com (2603:10b6:8:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 02:35:43 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::210e:eea7:3142:6088]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::210e:eea7:3142:6088%5]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 02:35:43 +0000
Message-ID: <21c3c12a-c591-4548-891c-9ac66f0a615c@oracle.com>
Date: Wed, 7 Feb 2024 18:35:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: mm: HVO: support BBM of vmemmap pgtable safely
Content-Language: en-US
To: Muchun Song <muchun.song@linux.dev>, Nanyong Sun <sunnanyong@huawei.com>,
        catalin.marinas@arm.com, will@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20231214073912.1938330-1-sunnanyong@huawei.com>
 <20231214073912.1938330-3-sunnanyong@huawei.com>
 <50f082a8-b805-5d66-45f4-2af58e99a67f@linux.dev>
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <50f082a8-b805-5d66-45f4-2af58e99a67f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|DS0PR10MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 748d058a-6b27-4e1d-b3b9-08dc284ea5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5yFyaIl/tgR+qTTAZ10T2xs+a2fsKSdoFVMOpkdWW/ozhJQIXLgFluyG/tjuxPz48qk5XvkmRZeq9zHQ0pTB/yLqEXSogBTfyndokDCSTAGiAJ+CcSCqA1blyzxrymjVtl2/jZHNYSX0w324y3y2t6fvZRJBtO9icjlJLZvQxMI/CYZf6c+L7IP+MxUmVNfytT5K6hApNnBV2MuJj8OQI4An/Djp82aozOGtINDl7Vqbd+7ZS2TArYabWHocP8tfE2XeEGGwuv4fV3qIwPJ4KHr3uDjR84uZjgsWltLvBHQW0WWHtZwIJq1NX6WSizM+aGgNRAvU97mY3eGnueGJcL+s5xrrZBKZ4F11wZuBXAF53O1kTaNlCvCTfTFX9XNr3nhO91pfEk9gUqokcvxtn3ChdB1uC1hIfbYzyhKnGSnAR0MrGh8oEOKl/ctzwHlcfkVnZj8fOQ3CeJ+IbFVlAizzXtwP02r6zAv8dA3s4C/00EjYvP4S2eSQO838ABJmBx0zoxPN5ZX7u1jI+9qIMIXu8cwoXMc+Ahu5SzzfKIOaVg96upxqt6PwkGMES7X2
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(31686004)(2906002)(83380400001)(38100700002)(316002)(41300700001)(6512007)(26005)(110136005)(66946007)(66476007)(66556008)(7416002)(8936002)(86362001)(4326008)(44832011)(5660300002)(8676002)(53546011)(2616005)(31696002)(6506007)(6486002)(36756003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q3VBRVBzT25DaFZDdGhiZTNROE5TbXNaRVhPbGR5VGliWEYrVFFDbkZnd2NT?=
 =?utf-8?B?YnhFcWMweTNyY0lCYVNJL1ppL2lHQW5STDIrU2RGcGhnVnpubnhvSW8zUjlh?=
 =?utf-8?B?YXFLZmc0UHlDclhCcnVoSGtDdnFhRUxBVS9rdVY4amhuMWh2R245d3BzVXIr?=
 =?utf-8?B?bDRuVWh1b0JBOEx6a3dEdVpTRGsvS1JWOTdieGpJTDdrVmJHdzgrSGgzcHRm?=
 =?utf-8?B?ZnkvNWovT3Q2akovRTJkUjZlTWYwUkFtamswYVBkZWlaRUZSaDhmYlA2OHZ2?=
 =?utf-8?B?VTJJRW5KZS84V2E0M21STWIxZ3RJZFE0MHZVSjcrdnpuekwzU3F0QUkyTVBT?=
 =?utf-8?B?TTBjT2tRcFFBTmxQM3A3UE1BZXgwdUZaVUhQcTR6ZnVYL3lKdmFybjE2dzhP?=
 =?utf-8?B?cW9kV1FRdGY5eDFnQTNqMG96c2RtdnJGdkprMTZYZ3duRmRUYlUxTEJiUVlR?=
 =?utf-8?B?ckExT2w2dGhCTDVRbExPTWE0bUFDak9tNXM3VTBiLy9iYlMzd2w5UlduZEl5?=
 =?utf-8?B?VTY5K2E0MHRFYkxmalBraGp6RkNCeTllM0YyR1I1amZUd1FvYU93SHBGN05U?=
 =?utf-8?B?OGdpS01sbUUwUkFTb2ZobEFvWXg4QVVIMlV5QW9CU0JqREFncVZRRE1CMS9n?=
 =?utf-8?B?cGZScTR4SzNJSm9CS3BvNS90aFQ4Rm5XeXozSzdTaHZLSDR6RHBOQXR2S3FM?=
 =?utf-8?B?ckYwamlaSGthTmg2YU01cE9LK1NlVFNMRmlEK2RuWDdqdE84b3pSNlBpeGhq?=
 =?utf-8?B?RWJucm5USU56eUN3L0VkLzNpZ1BhdTdhRlpUY3Q4SW1KOW4wWW4zR0VYeFkv?=
 =?utf-8?B?UHNkWGZuK1Z5SVVKYWZMZ2J4ek91TEw5QVFVcGwzM3J1Tk1QYWZxWGNoNXdS?=
 =?utf-8?B?TzltSDRFTVJBU1lLemxFQkpYMGdaRFFRT1JnVXdYd1hQTU1qS2xOMFNLa1F4?=
 =?utf-8?B?cklWTGxLcU5oWUhZOERKZ1pTMzNvdFlEb0RiVGVCeTZsL3hTUXUwOFFCOS9v?=
 =?utf-8?B?WFVUUjFlaG91QlBWMFFSVkFXbEVXUW9KakpSUDNXNzJEdW5nWEJTeHQ5dk5N?=
 =?utf-8?B?bWF6S0F6ajBwRnJrQTFBMkJBdXFNeTE4QVVoREpOS0JnUVduZ2x0OExxTjBY?=
 =?utf-8?B?WnVEWWZTNksrdUdSVkdZamI1ckRSQnZJZHNCTzJydE02U1plTHBKT1hTdWt4?=
 =?utf-8?B?SVB5U1BFNDNBeHd2WFZMUTJacEtoMkJib0dqa2x4SkppMkdFN0V2cjVMSHJ6?=
 =?utf-8?B?ampDRlFZRTFZTWlRUWtYMEVIL3U2eFR2YjZpWG5sM3JlaXJhbTZnenVnVy8r?=
 =?utf-8?B?dEpiKzZLODY1NUJZb0tFN3NvMWQwL0RBY1FMcEtBazlOVkprYXRSL0N0czVQ?=
 =?utf-8?B?MC9JSDdidVpsNHNsVS90eE5RemExWkd2S1BmcE9Ka3kwak96NzdQUi8yZVBL?=
 =?utf-8?B?T0lOOFdSdDZqRkdKM2IxTXpWS1YyaGNFQUxyY05tV3ltUzRIMlVSNEJrWXJi?=
 =?utf-8?B?QTdSK00zR1E5NkcxWXZ0amlHcFdGbWhia1Z3alRLQ0JON0JjYWt4ZTZrUTQ4?=
 =?utf-8?B?NGNIa3piY2VlbGVZNmVzcXBSUndkNVg2dmNBZ2VaM3FJTzNIT2s3NnJGR0U4?=
 =?utf-8?B?NWJpb0lNc1E1SzJIcWQwUC92b2ppazhaNDBHQTNIakJmeExsZWlaWmo1UDlO?=
 =?utf-8?B?dVpPVHdQcWFERllpczJ3bXc3eFdvYVMxaEpycEN2TGZiWEtGQXY0QWJYZ1Bq?=
 =?utf-8?B?bms0MWJ6UGhJbnV4WHRHM0k4NkhwNndQa25keWdkb096cVdZMWovYU53eFRT?=
 =?utf-8?B?dithbG5GM3J6L0Yya3R2NXZRMlZ6RWhPaExlZ1UrSmF6bFpBREdaK2RCbFh5?=
 =?utf-8?B?cFhQZUZEUnZJaDFHdU82OTVoMys5c295OWRQZitpS25QQ3BEMnVQTTVGTS9W?=
 =?utf-8?B?eXNtR1U4QWVPcnM0TWM1bGFLN0F3dFNSazJrbTJmN3pHSEJncS9IV1J5Rzd2?=
 =?utf-8?B?NHlmcW9KNTh0Y2tkTHk0QWJ5TXZBeDQ5UUV2VFcwd252d202TEtFTUtITzNm?=
 =?utf-8?B?QWY5WjV5TjhWQ01VcUZFbmhGSXQ3bG5HOUF4M3hjTXVFY3FCdDdlYWdkY1ZW?=
 =?utf-8?Q?l1ryR7o+CNPmqw/nbBkFY5SbV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Sfod7NJ8dyE97Tt4rqk1WUVrCLxrTRDZ/DnFceOBuMv6NTRBg9TCodalFNcW18G32WSR1xAp+V8j9r06nQZHDg6BeHVpSOP5GrYWa7cCKVEwT1lBthJb3Iz+TQgEsL7KfaC0Ecg1M85Jzuv9wAaJKnFxdc+t8kgDAw+nul62EgHq+N4MiItv/cAwEY3LDsgp1arCwCj5x3Wm0GjNUivtYLJgN3DpyHX5eZUCX4v1J70BL9lppTxuV4Q9oqUqvC6x1rMVbVwVbgf+jrgK1Gjb+ComBmxX8yM6d3f0KAWYssUak6iAmB4paICxaw/S4xDfaAQxjW8z5XnDHtp/Qu3X1JyS8dlcgAn+uvDmIWISxQJic3zk3WPJRUkaWMe0OZ2Olx/DeItMiGPAvnPcGcnaS+s1Ucf1gl3TuIr5oTdqRpKFmBdOQ1LLl9JtQ7OHAK6/hslL78WHCjQaqcGIQtL2tBchOcZtuzD3A/SJSMOwmSXbj/rhrTT8ahz6KneWfKwzOiitSeo7u55C/amvqTgdn0OjRlckCqA0z6Gtd0ra5+fELt/vtbz9nwC7x6gcy5J570wGwlRk/B4g7tN4X90Ef3rUlAe41W1x/QzgGd9Msdg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748d058a-6b27-4e1d-b3b9-08dc284ea5d0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 02:35:43.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbV/nfMu8rEH3lxkINatJD1ir0ap+Ks/Z0xrZ5iFeroRAXZ3VL61DfgE1KHDNsGRo7USUZmqg21OVXZD2rl/Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080011
X-Proofpoint-GUID: 3b5TTjHCpiPV9L2gD6KeilHYzW6kamV7
X-Proofpoint-ORIG-GUID: 3b5TTjHCpiPV9L2gD6KeilHYzW6kamV7

On 12/14/2023 8:36 PM, Muchun Song wrote:

>
> On 2023/12/14 15:39, Nanyong Sun wrote:
>> Implement vmemmap_update_pmd and vmemmap_update_pte on arm64 to do
>> BBM(break-before-make) logic when change the page table of vmemmap
>> address, they will under the init_mm.page_table_lock.
>> If a translation fault of vmemmap address concurrently happened after
>> pte/pmd cleared, vmemmap page fault handler will acquire the
>> init_mm.page_table_lock to wait for vmemmap update to complete,
>> by then the virtual address is valid again, so PF can return and
>> access can continue.
>> In other case, do the traditional kernel fault.
>
> Yes. BTW, we already use the same scheme to support arm64
> in our internal production. So the whole approach LGTM.

Glad to hear that.  I have a question to both of you then.

How long does it take to allocate 3/4 of 1TB memory to hugetlb pool?  
and to free them?

thanks!

-jane

>
>> Implement flush_tlb_vmemmap_all and flush_tlb_vmemmap_range on arm64
>> with nothing to do because tlb already flushed in every single BBM.
>>
>> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
>> ---
>>   arch/arm64/include/asm/esr.h |  4 ++
>>   arch/arm64/include/asm/mmu.h | 20 ++++++++
>>   arch/arm64/mm/fault.c        | 94 ++++++++++++++++++++++++++++++++++++
>>   arch/arm64/mm/mmu.c          | 28 +++++++++++
>>   4 files changed, 146 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
>> index ae35939f395b..1c63256efd25 100644
>> --- a/arch/arm64/include/asm/esr.h
>> +++ b/arch/arm64/include/asm/esr.h
>> @@ -116,6 +116,10 @@
>>   #define ESR_ELx_FSC_SERROR    (0x11)
>>   #define ESR_ELx_FSC_ACCESS    (0x08)
>>   #define ESR_ELx_FSC_FAULT    (0x04)
>> +#define ESR_ELx_FSC_FAULT_L0    (0x04)
>> +#define ESR_ELx_FSC_FAULT_L1    (0x05)
>> +#define ESR_ELx_FSC_FAULT_L2    (0x06)
>> +#define ESR_ELx_FSC_FAULT_L3    (0x07)
>>   #define ESR_ELx_FSC_PERM    (0x0C)
>>   #define ESR_ELx_FSC_SEA_TTW0    (0x14)
>>   #define ESR_ELx_FSC_SEA_TTW1    (0x15)
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 2fcf51231d6e..fcec5827f54f 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -76,5 +76,25 @@ extern bool kaslr_requires_kpti(void);
>>   #define INIT_MM_CONTEXT(name)    \
>>       .pgd = init_pg_dir,
>>   +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>> +void vmemmap_update_pmd(unsigned long start, pmd_t *pmd, pte_t 
>> *pgtable);
>> +#define vmemmap_update_pmd vmemmap_update_pmd
>> +void vmemmap_update_pte(unsigned long addr, pte_t *pte, pte_t entry);
>> +#define vmemmap_update_pte vmemmap_update_pte
>> +
>> +static inline void flush_tlb_vmemmap_all(void)
>> +{
>> +    /* do nothing, already flushed tlb in every single BBM */
>> +}
>> +#define flush_tlb_vmemmap_all flush_tlb_vmemmap_all
>> +
>> +static inline void flush_tlb_vmemmap_range(unsigned long start,
>> +                       unsigned long end)
>> +{
>> +    /* do nothing, already flushed tlb in every single BBM */
>> +}
>> +#define flush_tlb_vmemmap_range flush_tlb_vmemmap_range
>> +#endif
>> +
>>   #endif    /* !__ASSEMBLY__ */
>>   #endif
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 460d799e1296..7066a273c1e0 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -368,6 +368,97 @@ static bool 
>> is_el1_mte_sync_tag_check_fault(unsigned long esr)
>>       return false;
>>   }
>>   +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>> +static inline bool is_vmemmap_address(unsigned long addr)
>> +{
>> +    return (addr >= VMEMMAP_START) && (addr < VMEMMAP_END);
>> +}
>> +
>> +static inline bool vmemmap_fault_may_fixup(unsigned long addr,
>> +                       unsigned long esr)
>> +{
>> +    if (!is_vmemmap_address(addr))
>> +        return false;
>> +
>> +    /*
>> +     * Only try to handle translation fault level 2 or level 3,
>> +     * because hugetlb vmemmap optimize only clear pmd or pte.
>> +     */
>> +    switch (esr & ESR_ELx_FSC) {
>> +    case ESR_ELx_FSC_FAULT_L2:
>> +    case ESR_ELx_FSC_FAULT_L3:
>> +        return true;
>> +    default:
>> +        return false;
>> +    }
>> +}
>> +
>> +/*
>> + * PMD mapped vmemmap should has been split as PTE mapped
>> + * by HVO now, here we only check this case, other cases
>> + * should fail.
>> + * Also should check the addr is healthy enough that will not cause
>> + * a level2 or level3 translation fault again after page fault
>> + * handled with success, so we need check both bits[1:0] of PMD and
>> + * PTE as ARM Spec mentioned below:
>> + * A Translation fault is generated if bits[1:0] of a translation
>> + * table descriptor identify the descriptor as either a Fault
>> + * encoding or a reserved encoding.
>> + */
>> +static inline bool vmemmap_addr_healthy(unsigned long addr)
>> +{
>> +    pgd_t *pgdp;
>> +    p4d_t *p4dp;
>> +    pud_t *pudp, pud;
>> +    pmd_t *pmdp, pmd;
>> +    pte_t *ptep, pte;
>> +
>> +    pgdp = pgd_offset_k(addr);
>> +    if (pgd_none(READ_ONCE(*pgdp)))
>> +        return false;
>> +
>> +    p4dp = p4d_offset(pgdp, addr);
>> +    if (p4d_none(READ_ONCE(*p4dp)))
>> +        return false;
>> +
>> +    pudp = pud_offset(p4dp, addr);
>> +    pud = READ_ONCE(*pudp);
>> +    if (pud_none(pud))
>> +        return false;
>> +
>> +    pmdp = pmd_offset(pudp, addr);
>
> We already make sure it is a translation fault of level 2 or 3
> here, so we could use pmd_offset_k() macro to simplify the code
> a little. Right?
>
>> +    pmd = READ_ONCE(*pmdp);
>> +    if (!pmd_table(pmd))
>> +        return false;
>> +
>> +    ptep = pte_offset_kernel(pmdp, addr);
>> +    pte = READ_ONCE(*ptep);
>
> Please use ptep_get (which is supposed to do this) to access the
> raw pte, see commit c33c794828f21217.
>
>> +    return (pte_val(pte) & PTE_TYPE_MASK) == PTE_TYPE_PAGE;
>> +}
>> +
>> +static bool vmemmap_handle_page_fault(unsigned long addr,
>> +                      unsigned long esr)
>> +{
>> +    bool ret = false;
>> +
>> +    if (likely(!vmemmap_fault_may_fixup(addr, esr)))
>> +        return false;
>> +
>> +    spin_lock(&init_mm.page_table_lock);
>> +    if (vmemmap_addr_healthy(addr))
>> +        ret = true;
>
> It is to assign the return value to ret directly. Like:
>
>         ret = vmemmap_addr_healthy(addr);
>
> The the initializetion to ret also can be dropped.
>
>> + spin_unlock(&init_mm.page_table_lock);
>> +
>> +    return ret;
>> +}
>> +#else
>> +static inline bool vmemmap_handle_page_fault(unsigned long addr,
>> +                         unsigned long esr)
>> +{
>> +    return false;
>> +}
>> +#endif /*CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
>           ^
> Miss a blank between "*" and "C" here.
>
> Thanks.
>
>> +
>>   static bool is_translation_fault(unsigned long esr)
>>   {
>>       return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_FAULT;
>> @@ -409,6 +500,9 @@ static void __do_kernel_fault(unsigned long addr, 
>> unsigned long esr,
>>               kfence_handle_page_fault(addr, esr & ESR_ELx_WNR, regs))
>>               return;
>>   +        if (vmemmap_handle_page_fault(addr, esr))
>> +            return;
>> +
>>           msg = "paging request";
>>       }
>>   diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 15f6347d23b6..81a600ccac7c 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1146,6 +1146,34 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, 
>> int node,
>>       return 1;
>>   }
>>   +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>> +/*
>> + * In the window between the page table entry is cleared and filled
>> + * with a new value, other threads have the opportunity to concurrently
>> + * access the vmemmap area then page translation fault occur.
>> + * Therefore, we need to ensure that the init_mm.page_table_lock is 
>> held
>> + * to synchronize the vmemmap page fault handling which will wait for
>> + * this lock to be released to ensure that the page table entry has 
>> been
>> + * refreshed with a new valid value.
>> + */
>> +void vmemmap_update_pmd(unsigned long start, pmd_t *pmd, pte_t 
>> *pgtable)
>> +{
>> +    lockdep_assert_held(&init_mm.page_table_lock);
>> +    pmd_clear(pmd);
>> +    flush_tlb_kernel_range(start, start + PMD_SIZE);
>> +    pmd_populate_kernel(&init_mm, pmd, pgtable);
>> +}
>> +
>> +void vmemmap_update_pte(unsigned long addr, pte_t *pte, pte_t entry)
>> +{
>> +    spin_lock(&init_mm.page_table_lock);
>> +    pte_clear(&init_mm, addr, pte);
>> +    flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> +    set_pte_at(&init_mm, addr, pte, entry);
>> +    spin_unlock(&init_mm.page_table_lock);
>> +}
>> +#endif
>> +
>>   int __meminit vmemmap_populate(unsigned long start, unsigned long 
>> end, int node,
>>           struct vmem_altmap *altmap)
>>   {
>
>

