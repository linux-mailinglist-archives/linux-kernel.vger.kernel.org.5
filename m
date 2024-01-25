Return-Path: <linux-kernel+bounces-38932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BECCA83C8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4799C1F21CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B5713DB87;
	Thu, 25 Jan 2024 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FfTmPmoO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YE2R03pb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956612A17E;
	Thu, 25 Jan 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201071; cv=fail; b=fJ9EL9+W64Om2zuP0TFS+Xmx6vee0cHg2BOtkyhdP09dhxUCZGRiz0EPhSa7Dh789w53Ms7Ntfeh63Odjy/JwI/4bbVQZKKQlAXo/xh6YVvSWXw1iAL6JJfHPidT8CTpL5qO7TJW20MPeBzi/e6LZPai5qyLXJm7CnVPi3TIweQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201071; c=relaxed/simple;
	bh=E6e/JvuBGXJBonHJWJy4NqkWaTJgdVknsngRp3OKOts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S5nL139tUZSRCVhvFKCFYewXVcCRQLT6t+ts1bp1Vo60MJuwzCB5g4Gj+acYkGa7L6B9EfkZCdQICnVrCRjvS+E9KJyDG8Q/ybeOhPHgaYMEmOpNKCvZuwl5VJSka1+loML6qC4W9sSwPwjIY5iXw8w78g5P9sCKIXN6cwT+ZSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FfTmPmoO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YE2R03pb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40P9xc3Y011487;
	Thu, 25 Jan 2024 16:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YSf7QwM7dfmukE+Uv6UrqGD1sxWgyS5BmDwzxuYXwEI=;
 b=FfTmPmoO0biHwCbudPGY7rinHHHnkcVb4mgQJxJAMhXM/kIEV7bhsmysh4SKZfRs3HM8
 oOkolWEpu4scIcust+ZgMmaS6+HIbPD88JUfL2ZOcY37aKZtYuQ3JV+KLnotizhUuzjp
 offvoX4WR9yKplq3aK1Gh/80+G16Z6Q6sSDsg00LZBfD+Bk7fCzpyfzCL2lhLGbYVklc
 uveWwS3xg4KtLfpBNTEwNADPXrUI3CGLltzNSvWUzJQoAPFW03JyOdRHqYc3dyaM91XQ
 4xv8pJGp+XClXlFKdnL7wXdDmg5Ife4HYTm0cpFr+OpHbvfsRyTWOJJIAsNUcraLoLX6 Ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cuymuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 16:44:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40PGYdFS029534;
	Thu, 25 Jan 2024 16:44:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs33wyy31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 16:44:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqC15QLYNBceVkgIMnJsFVD590OkBZLpOuEOhR1ip9EzhFrAMGEugb/voNU83hmwrxJRgToN3Mm1KqlVb9/EH4YSGSCG22lc1H+7vahGMHsbcOQKl99HbNJT81ZyR3ssuNChZGznsRBVoN1DE8JKojoDz2s7q45PpJAS2dAJJAr+AvWxZfaOz3RQ/XVuk0cJBspQEaNCAk5tN1Z8qofH1Rmgo6UBe9q9p30kGVSx+AN8UIGZYQWWrnnPKRleoh9Dk/P9bbu0RQ589XWWgGJmU1AngaYcTjLk8ygOYWprPHIIwg1X1LvaqA606Fp3XEHkSQyH+ZkywNgF/+fxr/JU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSf7QwM7dfmukE+Uv6UrqGD1sxWgyS5BmDwzxuYXwEI=;
 b=oKiqhH0BZHfn74vcBw0bGS94S/nbETsmeeOtxQE2gJM4wcfXYWG+7JnC39YlKsg+k8zNK3nQErki7oj9Wb2PjyZH9uDXnZbzcFFQhOv46hmCuXpiEtnqgGnojymjouLHoWrZTe9uLez7LXk85mq0ggWx0xmtHGnVwfZ8Xbj58oGG854fQ5AY63RFpu3RYC1YfA4k3uvZBxwJdQXBDVaDMxUMY+iHjO7ho5DaQ2tBXaWiEhmSNWQc4DlCS3zOhINqZbdrHctyf/FtGbehPnsLNWPnAWG8KXH8AlBqvSml1rSozmwgXHrBAialgdROD18VtfSjcQZ5vLPG0gpKwIGQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSf7QwM7dfmukE+Uv6UrqGD1sxWgyS5BmDwzxuYXwEI=;
 b=YE2R03pbxMJeoRpPwBTahrm2LakKy4KCaqQq0AXZSTLfFuJAIcejSItWUxXOw7pF5e1gJm/D11+o55J2HNbQ1ta1rj2xfh93BrXKrdGTtDk5wLoQwX0t28aAO0SWZkDScllfC5JIstMNvklTMxHRmABR+KEmNH9Y/E1TpoT56Og=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by CH0PR10MB4873.namprd10.prod.outlook.com (2603:10b6:610:c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 16:44:10 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::1b4d:a7ed:2ace:8f3]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::1b4d:a7ed:2ace:8f3%4]) with mapi id 15.20.7228.027; Thu, 25 Jan 2024
 16:44:09 +0000
Message-ID: <2ef7d741-3df8-402a-967f-53ec77c73e2c@oracle.com>
Date: Thu, 25 Jan 2024 08:44:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Song Liu <song@kernel.org>, Dan Moulding <dan@danm.net>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, regressions@lists.linux.dev,
        stable@vger.kernel.org, yukuai1@huaweicloud.com
References: <CAPhsuW7KMLHHrcyZhKS_m_fwWSKM66VFXaLj9fmY+ab5Mu3pvA@mail.gmail.com>
 <20240123235803.8298-1-dan@danm.net>
 <CAPhsuW49L8B9K8QFg68v=zG9ywMehUTD18DaG4PexEt-3mzQqQ@mail.gmail.com>
Content-Language: en-US
From: junxiao.bi@oracle.com
In-Reply-To: <CAPhsuW49L8B9K8QFg68v=zG9ywMehUTD18DaG4PexEt-3mzQqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:510:323::8) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|CH0PR10MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 346a6f74-07ab-420b-7f6b-08dc1dc4da57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BIV6nD6/gYVK6LOnTaUatZu+ZCBHxC32qncpD1GYuvtn7V0v32C371YTsUbsMkDSHFSKGITj/vi0F4xPwRa3WMelWV8kNSPAL2Bo6id4yuJP/QuPNGi/iDjXBQEDT6JatZuCJnGsXAFf/kD8Xqd8kcsKogSgT1qXs9ipNRGHnpRy1WbLd8SR2H4HYZs8+Lm2VEja3rJ5zneNrXEXMnFNeoK8gJh7/LLmxZqA2yyhcFGCYhk6Ad9egjXPm0yilrxep80/jdoaCmSm8w7tkDpdYRw7lB0P0IB2FWMeBkUvkE9nSatZDOgsrSl5AaYax0zLn2f+P/Ja9/JUzkyZ2crZqXXxtNyWJQuVgLwIubtBrgmIVp6nkgQFS+MkoJVU5//rf8OQuOdHOtA1SaJTZh+LZyv+b4MJlALznYoAECXTTdpazCz+GQljSLjERX1U0wCY2PJqFhGjGpzx9xquhklsN7pRJSbxm87cb+ivcgiVmLivXAsU7UYEWWwfiT1qRYBHpQAkK4ALNvn0VUxBqco3MWj0RaW8J6Z8qQ9RoKBF11O4m1WDzyUf5UdrvhWf0AUpKyU1dRgsxFC+SqGUTp91qmxLMyQTLjC2La1WmpIB/8cOd58GTqtXr6vqq4mWZkzV
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(2616005)(26005)(6506007)(53546011)(9686003)(4326008)(6512007)(83380400001)(8936002)(8676002)(6486002)(478600001)(66556008)(66476007)(66946007)(110136005)(5660300002)(31696002)(86362001)(316002)(38100700002)(31686004)(2906002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a2ZaOW5MdXRXTU9OZFNuL3VacFBYNEZvclNRRmhPYWpjeXZHVjNBQ2NhZkUw?=
 =?utf-8?B?V3JaRkF1blBSRHh4WG9kYzVSWjh0dzg5VEV5Zml3VkcyRndlQWwwM2dCdVg2?=
 =?utf-8?B?R1dDUGNLTXdoOTdIOFdhWDNhcjZ5a29KaGVNTHBZeXFtbDhmZUZPZCs3aWFK?=
 =?utf-8?B?N0NRZWQ4cGcvWXNDSTdPODNhemFiTkg3QUg5eEh3eEVDUXAyc2Y4bGVuK0Y3?=
 =?utf-8?B?eFBxWFUrbHhWa1RLK0Y3RWNLcENZazhIQ3ZpTzZ1OHk2UDlDdHRkRXgxSzdo?=
 =?utf-8?B?dk0yZUJjZkhqNkR4MWVWWFBLSDJadUNHa2RkbzNNM21HRFhwY2lHR2t4Rm1C?=
 =?utf-8?B?VlRDcDAzbnRhQ2cybmNWSlIvWFI5REZkVnoyY2tQL0hCRFV6QzVKU1F0K01W?=
 =?utf-8?B?UHJzUmVGVTZDZ2tTRTVmSkc4cXcyUmlCeXAzdGppcFl2OUlZZXlpc3dEdUZ2?=
 =?utf-8?B?dFlkRFA2eEVlek52dUM4bWp0djJtQ2JUWjVKWjg2Z1cvRitvalROcjIwWXFX?=
 =?utf-8?B?dkhiZDJBRWRsc0xYYUpWQmJ0dXcvc1p6Y2VmbUpBM2tjMmF4bFBidEVETEpp?=
 =?utf-8?B?OTRhS2s5VkVicHlyUUxmRUo3WFFCVWVtVzIvQXB2YWFPM01xQklnTWVxV0tG?=
 =?utf-8?B?V0diMlBTWDJack9lU293c3NmNlpMbGREcjV0MDN4NWhGRk9DYXpUOXNZTjFy?=
 =?utf-8?B?WGJvZFliejBMbEdITUw2SDgrTHZJRzJPaEpMWEMxUlBEZlVyYXNmbkJKRTkz?=
 =?utf-8?B?elB3QlAyTUVEN096YktYcFAyK1k4aUxNckZ1NHZWVXdwbDlGUnZobVJrQnlm?=
 =?utf-8?B?V3VDQ1lJUlBNdjZJOFhBc3Rob01IbUQ0eURxbldsZW5JeXhreHplODFSVmhl?=
 =?utf-8?B?SURwbzloWHhwUkNqZXdYWGhyS2ZkQWxJV091bUZxU1Zpb2RENzVxNkxON3hH?=
 =?utf-8?B?MDc1eCtoUFVLcDdTQU1lNnVMeHI4ekdwVm0xbmVKQi9DRS9LcG1uVkJKUzc3?=
 =?utf-8?B?SUdzRThBeXJYZ29QTzhhdkZHd3NMbzN2aWxpVWF1cFp6YUlhVjNLWDRNY2hz?=
 =?utf-8?B?aElOZ0Q0VlZRTXhYbzlZRlA4VTl0VlJHTmgrWm5pcFdoTHlBYjlEbWZ2NEph?=
 =?utf-8?B?N2REWlArUnFIVk1aYmRyMFVWNDJScVhaQTNKVTFJVFJrMjVCN3pwYWFmRmFa?=
 =?utf-8?B?TVNwNTIwNkxpOXltUTVkOEdEZXpKaWNBd05odUE1TVM5NExNczJEWUsxMGwz?=
 =?utf-8?B?QU9FR0NHajViaHdJRU93d2VjcDFOemNMT3YyME9TK0sza0I4WGlNeVQweDRi?=
 =?utf-8?B?RENhWVFuditLZndISzhVdkY4Yzh1NzVCcUhIYkJmQ29EblpsZlBOVEhLaEkz?=
 =?utf-8?B?RlNuZkdUellQV1AxS0NGdXQvMlVncldPQ1YwdlVXdXcybmZYczdDZ1E4enI5?=
 =?utf-8?B?U0t5RFVHVml2REFFaG5hcEpnSHc0b210TnhPN3hrZTU4aWVHMUZnSzY0MFpt?=
 =?utf-8?B?cG5sK0hmRlhraGszMEFCazd2WkY1cG8yaVgvZ0tBeGFXZkc3OUYzRGlMVjdr?=
 =?utf-8?B?NGhaR3hoUUlCeVR3TTZpUzBIYTVETUxvMmxVaFJPUEhVdU9YZU1NMFE3c21D?=
 =?utf-8?B?MlFLeTh3UVo4YzgxbWQ5eDY0UEhsRFRtWHBieURNV0k5Y0UyWUY0dmc4U3R4?=
 =?utf-8?B?VVB1NzFMQjVjWDJaSWIwa2k5c3NyWGxuQThBZldHbVFmMndCNnZVM214RENK?=
 =?utf-8?B?UnZPTWhFeDJjZkM4Yjk3S0xXUG12VkNaS0oxd0RxYjAraC9waWxzWTZQU3l3?=
 =?utf-8?B?Z0hyMmNaY09iYmpuQ3g3aUN1N1hteVhaWXduZm9yYkVsemZQRkwzcGR0T2lO?=
 =?utf-8?B?aElNMHJ6eUtyNnhvbjN1bGdkN3N2WnROY0FJNjN0amwra1N0eVBZdGJBNHV4?=
 =?utf-8?B?Nkpkelp6ckVuZnhRazFKVVQ0L3YwblpKbDNEaGk2ZThON3RYR2NzVStXUmZq?=
 =?utf-8?B?UjAxZXpnRklqQzJ3dGU1ZnRsRFI0S21zNjlNejNtaG5jRmVtaVdvWHdVN2dZ?=
 =?utf-8?B?OGVYMWdPbnh3UWZJTWYvWmJBTkdCN3FndDl1WEdzc3ZGZnoxK3h3d2g5OElM?=
 =?utf-8?Q?MmOIlHikMCF+CIc81j1lcHRUa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iCbMKdWz5V864+D4qeEGqCw8j8I09oKxVONcQowZmhq3Gc0k+K72jtCVeuVJTspuzIRLjhEmZIDMJxgWGHNo1aDU2zsUxxVprDqhLFAvsS9K0Z2TzKaWssJescEfGLkXhScj3yh/FNhP8sx4h45xOyJZzXjUlRy9UYaeSULs+41Tfvrqjk7SBHW007db5p7VnFe39pE5juHumQk49tkI/dj9HiBQPL+xpSPsK+W24zWVWepb7CGC//NQr9Xv+CUnTM3F/Z03agvtQjzCIdkmWwIMakSvEOR2KpVU9KMJzPw4FYmrAzPRHx57xcrrU03YHahmY34kK/DvudSEL1rRPs4vYiL3x5J3g3VtHP38dMTAPgh4DnokkwSoeTKKufB7ckMmaBRCbB0jnBFNPHkZ8+vbOs875vJxP9JoE1v4QpAy5mR+uOjPLLJ1lrBUqX/XoMRjZkHjBowWtKHeUl7u94r1mEiDAXELMFoifnLTqj73oF5zg9DptNKOt1TIlElZXefLG7JA92ulQc3UsDpyvd4Hb1uzPmQ4zJYqQ67r0QVRO25H+ypchyWsjewHQjclQUe/lksMKCC0ND9fsD6yeMiFATi/W6vGkAPMIF+8r+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346a6f74-07ab-420b-7f6b-08dc1dc4da57
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:44:09.5173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5To3TVzzjxjpVG80iQg5I3WHVKlwWBQ0StXPKyEonDUks7bAThE18jinzBLvTWnO2ko+8SDK/yei1gyTPePUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_10,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401250119
X-Proofpoint-ORIG-GUID: 0nSTJ6IHrDQQJ6H0VMlo5sPbNSlPwVt5
X-Proofpoint-GUID: 0nSTJ6IHrDQQJ6H0VMlo5sPbNSlPwVt5

Hi Dan,

Thanks for the report.

Can you define the hung? No hung task or other error from dmesg, any 
process in D status and what is the call trace if there is? From the 
perf result, looks like the raid thread is doing some real job, it may 
be issuing io since ops_run_io() took around 20% cpu, please share 
"iostat -xz 1" while the workload is running, i am wondering is this 
some performance issue with the workload?

Thanks,

Junxiao.

On 1/24/24 4:01 PM, Song Liu wrote:
> Thanks for the information!
>
>
> On Tue, Jan 23, 2024 at 3:58 PM Dan Moulding <dan@danm.net> wrote:
>>> This appears the md thread hit some infinite loop, so I would like to
>>> know what it is doing. We can probably get the information with the
>>> perf tool, something like:
>>>
>>> perf record -a
>>> perf report
>> Here you go!
>>
>> # Total Lost Samples: 0
>> #
>> # Samples: 78K of event 'cycles'
>> # Event count (approx.): 83127675745
>> #
>> # Overhead  Command          Shared Object                   Symbol
>> # ........  ...............  ..............................  ...................................................
>> #
>>      49.31%  md0_raid5        [kernel.kallsyms]               [k] handle_stripe
>>      18.63%  md0_raid5        [kernel.kallsyms]               [k] ops_run_io
>>       6.07%  md0_raid5        [kernel.kallsyms]               [k] handle_active_stripes.isra.0
>>       5.50%  md0_raid5        [kernel.kallsyms]               [k] do_release_stripe
>>       3.09%  md0_raid5        [kernel.kallsyms]               [k] _raw_spin_lock_irqsave
>>       2.48%  md0_raid5        [kernel.kallsyms]               [k] r5l_write_stripe
>>       1.89%  md0_raid5        [kernel.kallsyms]               [k] md_wakeup_thread
>>       1.45%  ksmd             [kernel.kallsyms]               [k] ksm_scan_thread
>>       1.37%  md0_raid5        [kernel.kallsyms]               [k] stripe_is_lowprio
>>       0.87%  ksmd             [kernel.kallsyms]               [k] memcmp
>>       0.68%  ksmd             [kernel.kallsyms]               [k] xxh64
>>       0.56%  md0_raid5        [kernel.kallsyms]               [k] __wake_up_common
>>       0.52%  md0_raid5        [kernel.kallsyms]               [k] __wake_up
>>       0.46%  ksmd             [kernel.kallsyms]               [k] mtree_load
>>       0.44%  ksmd             [kernel.kallsyms]               [k] try_grab_page
>>       0.40%  ksmd             [kernel.kallsyms]               [k] follow_p4d_mask.constprop.0
>>       0.39%  md0_raid5        [kernel.kallsyms]               [k] r5l_log_disk_error
>>       0.37%  md0_raid5        [kernel.kallsyms]               [k] _raw_spin_lock_irq
>>       0.33%  md0_raid5        [kernel.kallsyms]               [k] release_stripe_list
>>       0.31%  md0_raid5        [kernel.kallsyms]               [k] release_inactive_stripe_list
> It appears the thread is indeed doing something. I haven't got luck to
> reproduce this on my hosts. Could you please try whether the following
> change fixes the issue (without reverting 0de40f76d567)? I will try to
> reproduce the issue on my side.
>
> Junxiao,
>
> Please also help look into this.
>
> Thanks,
> Song

