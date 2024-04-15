Return-Path: <linux-kernel+bounces-145751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5257A8A5A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD62C1F21914
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FAF155A37;
	Mon, 15 Apr 2024 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W9wgZdbX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jcxaMfGo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBE01552E6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713208018; cv=fail; b=QmbtHklDqc/PsaJXixbE2YEkU4b2JCXgPnA8Nx9mdB0Ax7p/oeEg/xZ8oKonpXh+QFIG0Mf8a0Zo2x5W3ApH0hzYc7hfQz9I6JlnvRVUSkWwBjapilFhXzcnMegMfeGiUNr3uRWTT/TjXT4HVvI3+Hax40tHRXLt776fdv8txCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713208018; c=relaxed/simple;
	bh=ikrql6TlV29mt5GGbjvfss5cxL1QoL6VQIigoHC26F0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aBK7LG7x0DOdjq5J9GIl9/l874FEOaI18zXKHmUKd6BGQ5gZFbS9Iw66w+oWi91wiVD41HKzOWl+VK8/5nSib8A0up5CHXnltfMU169WLimypljBAUO7vHxnMm16S3+spuG0k90pn0eQwuV9kMQx1WqeVfi1punUf2cnpwyOvYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W9wgZdbX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jcxaMfGo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FJ02wI031972;
	Mon, 15 Apr 2024 19:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=JjjiPJi5af2UzMpY4BRwG2mcDmMB/iM3ly2T+HnI4ls=;
 b=W9wgZdbXdLSNoZosH5SiKm57EwZtSierHRl/2Y4H2gfNWlcZoYrboAtWn4oAaTqkJ07X
 3KldTm0WdK6y0VuV+YEbmF4JiWGmC9ZSPbdbzNuoSpHgVBRpNU/McuYvbdpuphZoICod
 xKAhAaFLIIp15ORhmH7Yq4ercQy90i9NBnAyNXnXYtCFueQ9yrbkp/bDAkxzt0Zob8Ih
 BM7VzsO9YVQVYjhQ4IGDns1ZFlkKX5NF2Hj58D0Ut9VuChJvJmN3ik9cSRptPj71Px6D
 rvwj+qc9DQzQu3DY2SmbSqlzU0frKdaHScP3nhSiG1SMk3Lbp8gBJ7cokyvo6StxaOyk hA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv3gv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 19:06:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43FI6QWe004289;
	Mon, 15 Apr 2024 19:06:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggcf9bs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 19:06:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTfb0K94EnBbUzO4B9ymxZiJiVZzjQbHTk4E82WPncC1deqiUp0Zw5BtG09n5oXwl2uNXiq7X0TFMRF5Zvu1JM7Dymm01IuRZguRekfKq5yrl2goOi+HAZtfRr0OpCIrMU60/ufyoAxxBFhokU/AFNYgyuzZVm4VNPpK1wOPIuTbKnkxMfClLtOkVX/feqxgXvDt3ikpo7s5Ab5yN4sHpo736K43+D6VO06n8bFFeW+EPtK4ABr6/k0GpoFaXzJDFpuALJmGj8xnrIVlGrF4S2lCCOxigQAMnToCwJgy+6v+ENpg7XCbY/LQJlfPuahEzIAsas0BPk9MsiWKrEPB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjjiPJi5af2UzMpY4BRwG2mcDmMB/iM3ly2T+HnI4ls=;
 b=jL8I5dQwmfrZ3xq/L7Xg0H/Funq11uosJGtWMceJ60SpTtfU5mET/siLLiS2QCITuVpVaYn0B9+8DSaG5u7fdF6Qr/umtzf/wlXWXXq94RCA4BH4OSKNsAX03cQgIpZn5izX8vQM9a3eFTAt4Y20CPSTa9v7+k6oQzX/ocizFb8ebEHEVDHr8jl46Zgk7DrbHpArQCl+aAB1gskXgqtInzOFqDP96k0cnbF+hJa8iApcvx8NdnNv9TxMqN2dbpckWdCwO+9EUQm6tkd+W0WdfiLt30fhnGN5CkcqGQMIopofwe4RUvnwoeIKuk701DmvupWj4TuxmxDqGYtf1ZIHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjjiPJi5af2UzMpY4BRwG2mcDmMB/iM3ly2T+HnI4ls=;
 b=jcxaMfGo4gCdBnrsyFkKeWWnTILDZSSOtfvGNIbptJ2oBERNmL+rnfxBNi/j3wl26UXP/cDL/yFINZwHuhOKflk/x8xlGCF065h8njRBA6O96pOJWTziT+PUsQPTkD0tIg/kVIHZwyUJ/+P3tMi00gK6juOg2k4gzPFEJJ0wmCM=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH8PR10MB6360.namprd10.prod.outlook.com (2603:10b6:510:1bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:06:29 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68%5]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 19:06:29 +0000
Message-ID: <6eec8880-798c-4835-becf-976cbf8fe72f@oracle.com>
Date: Mon, 15 Apr 2024 12:06:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/hugetlb: convert dissolve_free_huge_pages() to
 folios
To: Vishal Moola <vishal.moola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org, linmiaohe@huawei.com,
        jane.chu@oracle.com, muchun.song@linux.dev, nao.horiguchi@gmail.com,
        osalvador@suse.de
References: <20240412182139.120871-1-sidhartha.kumar@oracle.com>
 <Zh1xslaqduUr4MHF@fedora>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Zh1xslaqduUr4MHF@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0179.namprd05.prod.outlook.com
 (2603:10b6:a03:339::34) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH8PR10MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: df4a0013-ea13-436a-c9ed-08dc5d7f2820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0i0rkdsvmhlLzpa3NIb4NdxOfFclkPS6z47s1AqW/yRmqDWvEnBNb02EJ06LkqQf6pJajHRX3UkW53wtTYimCOyHLZn6evTEzKSiFeD3fhkmCD8a/Izn+oxmQjv4C6wosvsYOmLh7KBq1BWA5szFfdS5nohShD1HhP/EHNYhwmC8kpE2JlaJDf8WnjmG1gLiiT8YnB/6zfTX0ijeYFOi8uiHAjPZ6RtI7W7bchyoH5Nedqh7H2SHee7p1sN30a4F5MotDp4NDqzoVhAKb5v2BZUnJgEAm0/OR7dUO71vNzuZwnOsinphF1+vThy8Qbn8a7mwMyRh6dvlYMZnIJyqCaUrKcp/NkhNL58atpdFrG7zlxzQAR8YVNuM4ssl6vnuR+a3eLMigoylftfFVl1W2F9onoL0Ri3DiWyuTWyBSbRypppwPkH0rj7PsOYWhux5V4XWfH7at7stbRvxvIHs7Z/5pAlTG+dgkqYvMMm9REIQJh7niwsH6TeAkGT+orifXYKMZDc1slAbYvN5efZHkI7xFCtNOdfn10Uet9Oppd1pvvMnPXXFAljvHSdfrnHZV0Tc2I1BNZrt7spxDg/Ewy+B24wnFxeHsI2DUp/SYomH75/1RIeWL6/ucriULt0X+KlIdSkIKvFiOqFWYoKyCD3kV8WeBT9CcmKyIOL6990=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RmNDbXdHejRleTFxdGtYcEhGMXBxaWgzeFMrT0FFaEZNNlMvMWRFbmFiMHVx?=
 =?utf-8?B?YWFiNk96bGhHRVNQektTT3pPVXc3aUsvV25xanExT2tVemFTVEgwcVlQVHA4?=
 =?utf-8?B?Tnk0SHY4ZjI5alJtUy9mVzhFTTd3d2RvQ0U3WnQzbWZjSG1UdTM3NWZZWXdR?=
 =?utf-8?B?UFJwWko4OUpYRENVTlcyS0JFMXdYWEtxcW1USEJwcFFRY2dESUdoelMwTkRL?=
 =?utf-8?B?RzEzTFFpZzhqbDhSbzFITk5Pd0djWmdoNVkyRGRtOGZpWndUSWlTZi9VTFVR?=
 =?utf-8?B?NkZOT01nQzZwQXA4OU1zUkwvYlp5Znh6NEpMOEtJUVlKNEpKSENScDgvYldM?=
 =?utf-8?B?Q3I4S3FuZmd1ZnY2c1E1UHBSSFpJZ3J3c0VZTkU0MEwrR1B3M1I5TEpOTWFX?=
 =?utf-8?B?NmxuUHRHb2FJTDlEcE9sTDl5QXdnNnlFZGppV3ovS2k1M1FYVWFwUnFxQWgv?=
 =?utf-8?B?a3dVdysra2FQcVgwdTE2bUdYaDdVdm9GQzk3dVNxVStTdmtzcFFDeHY1aEVZ?=
 =?utf-8?B?ZkRhYzBiVU9nSGY3d2RrNlRqYS8xQks3VVZMNTc2VU5ldkg3azV2NlhvQy8w?=
 =?utf-8?B?MWkzYU1sZ0ZjOFBSbXp5TFJtQlFVRHIxYUM2clNIVDhyOHI0YWF5ZUU3SUxr?=
 =?utf-8?B?cktqYmpCeFVXUkVzd3B3K1U4eDJXUTRRN05Sd2VwK1NZblVraVlQVEd5VUFa?=
 =?utf-8?B?bElUUFB5SHpJMDhxN2IrS1g5MHlRT0J1aDFlVjJTelNGODVoSFpiUXY0VXlp?=
 =?utf-8?B?RTFJeDRnZmtaK0EyZi9ESHBqY3dkdi9kRnZnR0lSTVRwd3crZUlVUWM0Y2Fi?=
 =?utf-8?B?bGZZQmF5N241ZjdJMkYzcXZ4NWdEc2xUMGFxa29aSkFZMDZhNEgrUXFSSm84?=
 =?utf-8?B?UUhpVnN3emxTdWpOUTQyZDJZNFVuZ2NRdEJzbCt3Z01YWVZIWDhlZFc3NHVm?=
 =?utf-8?B?SlBUcitCMkFwOEZrZzJ5R0ttdjFkQW5kbVRkMy8xN3JmVU8zVEZiem9JaTgz?=
 =?utf-8?B?bFVLb2NlZHJBeFN6ZS9sbmNXU1NaZmQ1TFdtNEQ2N2FhNS9rUmxiWElDNmEy?=
 =?utf-8?B?YkNZN1NaSitkTUJiYWlQbnVhL1lNMjAyOCtvUE9kZ3h6L1M2b0VhRnU3TDQx?=
 =?utf-8?B?RXJYdDlYbVRnc3pXNE9zbWdkcGRDR1FubTZwOWVETVdIRU5aV1ViYUJRQlo3?=
 =?utf-8?B?citMdmEwS1Frbmc3V2svN3VKZm1qZm5ldUVGVUlzKzZMRDJPU2VsNWlaRS82?=
 =?utf-8?B?cGhTNjVpaDJxQzc2YU45T3N6emFCRVZQdDJ3RXFCVHpiNm5jMkdMUDA0ZmEv?=
 =?utf-8?B?elVIL3dYZWlUWjR5MGxDMk9aWmQzQXQ0ZUN6S3ZoK0tHK2ZPVEx1cXozT1hK?=
 =?utf-8?B?WlRpSUhSNFBiKzlJTHVidDNGMlgyejY4RjdHMy8zd04wbmVWT2Q5dzlEcGd4?=
 =?utf-8?B?NC83SjhVaUYySFZoTkFESkUyK3JmMzltd2xOUWdXVUhXUlgwQWlLa3hHMTNm?=
 =?utf-8?B?SjNDUnRmbHFBQjNVZEVCbE9WaiswWTh1YWxXY0ZNM0Iwck1YdS81a0xzM1BR?=
 =?utf-8?B?K1FINnBIUzBMM29QZm1lWFpGYktNRjRSTVErQzdwYkxvb2F3L0d0OGlOWE1r?=
 =?utf-8?B?WkQ5eFZMRWlzdnJUOXRUVmNIWllSdVhIUGhzM1FFYWpMZmJ3WTJBdW9BYnBa?=
 =?utf-8?B?NlE2SDYvWDVVeUl3ejJMb2YzNW9Ubm8rRHM1WWx1OFBBeEVRZG9HYzZtL0U0?=
 =?utf-8?B?ZytnUExPQ3VnOGtucU9ZTDhheHpZUjJ4cGpwYXBmSDludTlUaGE5bUdtcGxS?=
 =?utf-8?B?MStLSHU0TlNrWEg4TkwvNGZpT0hxdXFJcERsWW8zZHZWclhjb0xKVjFTWTV5?=
 =?utf-8?B?anczOTN0VytYTytGb2lNd2xxbDhaQ0RPaFMyRlVHZW9kUmF5RE5vOGtRZ0FR?=
 =?utf-8?B?MG1ycVJ4ZkhVbzF6dmZLVi9XMzJyM0ZTcFJKZHIwcFgvblpMS3BVWEFjZ29a?=
 =?utf-8?B?TEdzM3RiSDBrM0hKbEZzUkNYRWh1MUhtV2MwWXN6eTMrc0NQS3NnNEVQRUxU?=
 =?utf-8?B?REUzYWZTbUJSYWJ1RmJDMDdBTkJxUHpaZzNMVU8wUmxxQkhmc3dScEVnKytX?=
 =?utf-8?B?NkNYeDB3TVVnQVZRTUpQOWxOK1M0OTJDbzNCU3YvYkJDSGp1ODA3Q1FmSlNp?=
 =?utf-8?Q?tXOTOEo7R8qbP/7BiH7X7gk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hAc1M1AEhxv8z8BUmazy2kv5MBiKEASZFj40ilz9B5rrGJqqtsDVYuRSPBFzyS7Lm3pPO/iw9cwvO5EzZyajoEKvvR178RftqeI/k/cOarUDima3g6TO8U4U4rJaaEXieccFPWoAHC7QDaj0qvq5w7kIu9fWRGYHYhrNtvvshtikiWfsLOdX14m6clxqMfo83ZFDsIUM/C2xGiAAfATLyPtKQs/YQJoblrIZs9fdDyqavjdbgdZBq1ZOBHLftOg1/lTWdHOkrxHvYjvzzKBWn8UAVQ6iZA4k7AbJDwTaciuQNapJvyT8OVY7p2EDCvpKaGVIAfIZ2KO9dymX3hMkA/HmG+mJtZeGp0ZGtlN88WZ6GS8dYhPhq/9PU2X2K1m8TwsepRNyK1SXbzQrNvt1WyPyL/vn9iUZZOz/w3vngvLmyyFpycBjRlm3LFXaPaGE+qecnz46Sv3bUnpwSqecqloIencXiN1N6tps9ranQEZVwKX6YkXglX3ldDYk+QhPSkpspJJ8+gWb0KFQV3wILxG0CPHpPpHo+D7ww/9r1jDntuDg1v4LyTxPhlhYfJ9xxTgECpalUNxevpk5mxPJqZIlGnf7yT3aiYvpMRz0f+w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4a0013-ea13-436a-c9ed-08dc5d7f2820
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:06:29.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2a05sNZDiPuPvlXo/M8CL4Qt7yMHHGvT/ClwdHZDYHIH+3+Ci2xi4iUSyJrrjM71qv4YQ6wWmrc7j3Pi4sepgdtxvBKwO3orMkizlIAPd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_16,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150126
X-Proofpoint-ORIG-GUID: MjOwZISh7Z42r7KRgLCZqyASB5ayHMVI
X-Proofpoint-GUID: MjOwZISh7Z42r7KRgLCZqyASB5ayHMVI

On 4/15/24 11:28 AM, Vishal Moola wrote:
> On Fri, Apr 12, 2024 at 11:21:38AM -0700, Sidhartha Kumar wrote:
>> Allows us to rename dissolve_free_huge_pages() to
>> dissolve_free_hugetlb_folio(). Convert one caller to pass in a folio
>> directly and use page_folio() to convert the caller in mm/memory-failure.
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>> ---
>>
>> v1 -> v2:
>> 	- Change additional comments which reference hugepages to
>> 	  hugetlb folios per Miaohe Lin.
>> 	- introduce patch 2
>>
>>   include/linux/hugetlb.h |  4 ++--
>>   mm/hugetlb.c            | 17 ++++++++---------
>>   mm/memory-failure.c     |  8 ++++----
>>   3 files changed, 14 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 3f3e628802792..f4191b10345d6 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -861,7 +861,7 @@ static inline int hstate_index(struct hstate *h)
>>   	return h - hstates;
>>   }
>>   
>> -extern int dissolve_free_huge_page(struct page *page);
>> +extern int dissolve_free_hugetlb_folio(struct folio *folio);
> 
> You could drop the extern here as we don't need it anymore. Aside from that
> LGTM.
> 
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> 
Hi Andrew,

Could this diff be folded in this patch to remove the extern per Vishal.

Thanks,
Sid

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f4191b10345d6..4cd7895590b6c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -862,7 +862,7 @@ static inline int hstate_index(struct hstate *h)
  }

  extern int dissolve_free_hugetlb_folio(struct folio *folio);
-extern int dissolve_free_huge_pages(unsigned long start_pfn,
+int dissolve_free_huge_pages(unsigned long start_pfn,
                                     unsigned long end_pfn);

  #ifdef CONFIG_MEMORY_FAILURE

