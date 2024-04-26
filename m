Return-Path: <linux-kernel+bounces-160588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9568B3FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C78B221C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA1ABA46;
	Fri, 26 Apr 2024 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="deGd29Sx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qGdyAsOG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553B14A96
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714157610; cv=fail; b=eC2W7xmMW4gB/Sg2H6BIc0y5O5B6Y2FZeq7HXeSdY8q+2AfhP05f5Y1SPgCjDiALrikmjQn0zzmaBGa+GZoQAOodjd8rASMT29iDTK4SidXO7wRbVP8qaEygJYPxyyxxD4tPf651kazpYT2twCKc0pZWvTPCwIp9+CCcp9jtO6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714157610; c=relaxed/simple;
	bh=sX7PArRSfLUM5sXkcxs6yODVg9SvmfA2ZslCS/TTxmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=parNFGqrx1+tHEqh9e/IA1v5MTSWE9FletilUzSQvSeVs1tQCHXZZH4I9TZre+zNkc7t0l8SCIz43H4vIqLecLA/YpNrtd0bKMHolWEoEuVfmh1K6WpJGSAB1RIsojV+P3CYR0PXQFzT4BieVjMTnyJfDeLUja+fJwLIcWbdrLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=deGd29Sx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qGdyAsOG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QIZpKc012453;
	Fri, 26 Apr 2024 18:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6jUc6kfV2O9qyWLwwBwroiLcGXTNoVj1egJft+xhsPM=;
 b=deGd29SxxXgNehoBUhfUyYJstPChFsod2dQBcJJq5TkoqBQj9AuFRy/SndwaXnXI7/0n
 40Z/Ac7KvwThGSV6PsLWsZwteS9GzFLSqOz0p4Ozrf+o2DvmMD3s19Jf4NBtv4F+B6oW
 19HTHC5qMmib7HMXsrBzF3wTslS75Uco01BqS3BGa54VIFT1vbn74tw2nMvBYHzXyL3W
 p9CgKjdn7qHTRRAgnAW+jkiRUUiKggQfdoOpGxlkuMp2kh773EVRmRRRy5nawxIIIPbd
 ZNCAoKoRwqo36cn6rppPEaDQHtcN5062CHa85eza7KxUoVbii0zRlzJhNID4e7M3mUPh zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm68vpn0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 18:53:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43QH4NB1035787;
	Fri, 26 Apr 2024 18:53:07 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45c0ha1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 18:53:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4kePwLYurFbP87E3V524rhu/b2ew8ujGlRKIJiITyzEXhCXMzKWHuv+ZJMxOn/Q9vxbsrspmJb3OjUyvGIkpYLsFxMDp6T3Pej7tnRmEwyZXq+9kGqMJMRCeUuqqAmS6VaIMTjk7z/9+nv7OeYpwL3b8BScierbFdmNkFTB8n0XYP9OKD3qg4039h25KxUpcpDGy4h3UE/2xbZFUNFgbfvGAgCj1jTA6PFyeKTbtyGPDIHt5eHNstYdBQF90gC7WeuyzfqAiaT97vJwGuKVhsttoJFEHnua1uyMl9JdSTvj+BTW7gd6vB7X8GolfAlPxBXUQTUU6+UYHYD3e22E5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jUc6kfV2O9qyWLwwBwroiLcGXTNoVj1egJft+xhsPM=;
 b=gJZz63oxUfvNoWBq4tMwHcHYgyDjGz2qP9QDJ8WcwdbvJNX5/iYAykzBT/5enTapbxZ3CVpHJL7GKJ+5YbY85ZZRokO0GSNZghIl7D/tsn/Tnc/W0OWW4LmzoXZBcldiynNboq45jxNT7Ukwc1ADWgBHqMc4P2FqZB99RF5Y2Zae2Etql19TCKY5Ug7MQhTML5cXuN8cLdY0cHbCG4WGmt4xkjUjhhAK7e+mKaiA1ZuHHgdOIxhWYzmj2yaEidrfqjA/wcDJ+JUKc8p5GQPlIWglGYJq76wKwop1WSRD3THlGlTBItc1/Ef/3NpF19w/eGvvz3qNAR5yNGKW84pcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jUc6kfV2O9qyWLwwBwroiLcGXTNoVj1egJft+xhsPM=;
 b=qGdyAsOGloQzgqCilO1ZW+A9WqPuq9/JfCJNUZVcUlXMifwmoNPMZir8CWpJ8N5nt6/EsgTqPix1P1EOnTl1i39zvoEY9H4MZOsk/f/iurLRngjIQ1xPJ0x4/cMwwr1/lmYThHsE/2BUUKSPAKPF27bLHcf1ah+CZDh2I1oWAhk=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS0PR10MB6869.namprd10.prod.outlook.com (2603:10b6:8:136::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 18:53:04 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%4]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 18:53:04 +0000
Message-ID: <c40cfd0b-f045-4887-a955-fee7e0392cf1@oracle.com>
Date: Fri, 26 Apr 2024 11:53:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory-failure: remove shake_page()
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, linmiaohe@huawei.com, jane.chu@oracle.com,
        nao.horiguchi@gmail.com, osalvador@suse.de
References: <20240426171511.122887-1-sidhartha.kumar@oracle.com>
 <ZivlrMAwRI6xJhc-@casper.infradead.org>
 <d05cbf22-f3e8-414a-a2e3-03e0b857eaca@oracle.com>
 <ZivyC3vqa2BIBoMj@casper.infradead.org>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <ZivyC3vqa2BIBoMj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS0PR10MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: fc22077a-9358-44a4-d410-08dc66221abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZEdjTWF6SnV6VFF4bjZOZUdJaDJqVkNFLzNicTUycXBpdnBaWVlZQ0FxRkNM?=
 =?utf-8?B?eTVQZ3hRVmhpWXI2czBZY2JUT1E2cmR3MWRJZEhBTS9OdUJjVXZiSUhlbFp6?=
 =?utf-8?B?RWlCTXpraFpoRnhtS2taSmVQQlNoNGgxak5GNnRZUUxyUXMyK0FhQkk5bzMx?=
 =?utf-8?B?UWd3a3p4cWJrQy9LWjdzdGxCcVNwVDdMekcwY2Q0VGpvWklZc0wvWjdhOUs5?=
 =?utf-8?B?UTZEQkNneFRqOXE1Tmd0OS9zbkNLOGFzZFBtTFRjaDdFSXU1d29GdHZSc0oy?=
 =?utf-8?B?UG9qVWxzOHpGdjZuUUJwVzB1YTZkbkdNNXdFM0h1VmZ3SzdWbWVnMTQra0pJ?=
 =?utf-8?B?SlJLOUNDeGlka1M5dGtWbytSdFpleDBHUGNLWStKOSs2b0V5Mis5aGgxUmZH?=
 =?utf-8?B?RCtDUUtxbnNoL3JEcTQxRkNyR1c1U1R5RjIyZld4TlNka0U4M3NNNFNSLzJ4?=
 =?utf-8?B?dWh0Z0JZSElKZkNaMEI2d015WHQxaFVJM0tJSXBOTGI4VDRObHJadkNZdys5?=
 =?utf-8?B?a2EwZ0FTVTZuTEJJS1o4RUtCSk9yZGt4OGR0dzhnT1J4OUVYc1p2N0NxM2dn?=
 =?utf-8?B?MHF1ZGc1eG0wY0FkYjVYQVNxY2NlTHVSWjkrVEk3Zm90WVNHOUJ5dlhyaWE4?=
 =?utf-8?B?YmljUEpzNDJlMHMvYXNwZ1FHNTZmVXN1UGJFWkZ1VmhVei9lMTIwMjB2UkFN?=
 =?utf-8?B?WDlodTN2VUlmMWFKOFdrK1hzRWxGVndCV3M0ZlZoVTVYZ2I4QmZGcnM5cStL?=
 =?utf-8?B?LzAzdEs3ZEZOZkJkZXZsZWZHMGpuOHlMWHB5V2NqTkFmbUVSUUNJcHJMaVdX?=
 =?utf-8?B?b0VSbUdWMFNpQkdkMTFPaE1GUjJTeUdnaTJRWmNLR0FmTGpMNlVkWHZiUDFP?=
 =?utf-8?B?YldNclJHT2IzdXRzaEpOWDF5Nm5keWlBMmJEVXJEd2tLR3RDNzloSVhQTU1X?=
 =?utf-8?B?eklBVzFjdWNoTlBERldhc2YzbHBNYzJDbmQ5b0kvcmhEdU4vVXh5eGt3aTJ2?=
 =?utf-8?B?VG9MNzZqcG1mbkE3b0tPYks1a0dxZXNLM1JKbkpZWW5aREYrL3VpOHMwQU1q?=
 =?utf-8?B?QU91K1ZIRWp2cW5CaVB3NjB3T1l4NCtIVlo0dTl0V2wyclBrcklGVk1obGlX?=
 =?utf-8?B?cTdpWUlFTUIxS3g3NENnT3JnZ2hLcXU3Uk9jWUVSZU1nS1laTzRVTXU4VHhM?=
 =?utf-8?B?dDQxa25GYTJlcjVjN1JFNE42b0M0THBpUGNWVTZqaW9sSjdmdzkxTHZWZ2M0?=
 =?utf-8?B?M1JzeENENkVacXpITzBqTUIvNFYwZE5xK2ZRVW8vMEJqYVdZRkRTcTZpYUVP?=
 =?utf-8?B?VUFqc3c5ZFVuRHhHVGUyTXllY3huZFRYQ1VvZEJYSlE4Und3MU1OekxraTRJ?=
 =?utf-8?B?ck1VUXpDa2FIMDdEd21WTVdhRkVIVmNHL1FMbjduVE04SXlKN1EwMUFNNFRy?=
 =?utf-8?B?ZWxYMWROT1UrSTJOUTdKNS9RVi80bDBlVnhhN3dPajVCT21FeUVDdGdXVEVi?=
 =?utf-8?B?RWYvK2FkRzl2VUNmUHlmaDlhNXg3NG90NC81eGlFdEdIU09zVlZubDVjYUdu?=
 =?utf-8?B?WHFYSUpEQngxZzlsUjMwRHNuc2R5bkFsbTgzckFUTzk2UGR3d0FJelhKYjA4?=
 =?utf-8?B?MWdLM3dKTGhMT0JISk9CbWR3NzhwNGRmS09FZ3kyZ1ZaOHVVa3lIYUt5UWN6?=
 =?utf-8?B?d01XazI5S0p6cFNUN1E4Kzg0SWpJbXJSVWt2YW5abVRsaDdQQ3BnRGdnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S093YTU5UU9nWGJZMzJCb2ZPallORVdkb1luWWpjOWdwMmxWb00rNjBVYk42?=
 =?utf-8?B?aDNoSXkvby9BQzJjV2sxZytDKy9sMlJuVGUzWGNZK3MxN0ZBUnoxMnZKMkc4?=
 =?utf-8?B?YmZoeEJISkdyaGt2bC90Qk80WWxqSVFWR2R5dENvem11aFg1Y0Y2ckY5Njdi?=
 =?utf-8?B?TWIzQnRKVnJEdXUwMDFXdmY0T3JpVVlseHJaSUhJOHJwR3IzK0FDdHNEVThv?=
 =?utf-8?B?bGN1dHdvOU56RE43a25uMHVMTWNtWXVGUmhPNnRHdFh2OTI2VnAwQTBldUlD?=
 =?utf-8?B?azYraCtoVVIyWUNRSnR4V0N4RDJ0TFg0OFh6czZDL3pvT1crSUg1bGZoTmU5?=
 =?utf-8?B?N1Q3WmpsaFQ0RWlGSGdiRlBTQVBaeVVTZFk0VSs0UHhoMi9vMlVzYVZTZURD?=
 =?utf-8?B?bW9vT1dpUVV5UTdoa25Kd0xBSjV2Wk9MTXhjTTg0WXhJTVdSSUJwWnpGM0tZ?=
 =?utf-8?B?UDJ6bWZVYUZYRjJuMWNqZ2NDc3hJSTZqcG4xM1N4dUJvdnZMSVBPSUlXSUdy?=
 =?utf-8?B?VXFHREplaDJlSi9yYk1pRUNISFQ0YUNnQU5lazlDVjIrN1l3RTFSQWZyVGpB?=
 =?utf-8?B?ZXh3WktXUW10REQycnBiUXJaRisvdlp6WXlYVmJXczVaclRYK011WGErL1E4?=
 =?utf-8?B?aUIwTUZtbjZFaWZ5VHhMTXZEbG9kWnpSM2R4djBEYlNTYkJ2WG5sZUVjV24y?=
 =?utf-8?B?ZW1iZVVVZzBrTmFiR0RrWUVhRlFacGhOWENOQjRrKzZSUitqMnc1Q2RiYUpP?=
 =?utf-8?B?ZmJZRkZObkhmdGNkcmt4dGZtU0FzU0ttYWpIVTVINjE0YkY3UXBrVG5Ub0lV?=
 =?utf-8?B?MnhxWU5pSC8wWlY3R0dSbzBtMXBhT0lLWEFPL2dFN3J6eGNyejhQVU4xWE9L?=
 =?utf-8?B?YWpZdG1aOEJqTmxwS1BjOG5RS2QxdXBjMEtjeDY4cFo1eFp1V0NkOGhJUFVV?=
 =?utf-8?B?b216QjI0UFlHSDd5ZVR1TXBTNHdKQVFBVllpT2hkNVhYaVZLNVlJZWxpdGRH?=
 =?utf-8?B?TThGVFA5QjVidUFOQWtZcjFxcmdXTDdUaUZNL0x1cmpIU0J6SDZDdU9XZzRm?=
 =?utf-8?B?UnMzdUpTenNPQWxmT1RCNmdCeE9XN0FRVnNGTUIyMUdDenFmK3BoMEhrMzg5?=
 =?utf-8?B?OWwzUWpFenp6WUducDk1QVhoK25iWEhaNTB2Qm9DSW1NUEExSmw5NjFiRjFp?=
 =?utf-8?B?MnpTZlp2S20yTnRReW8xQ25qb3VmUUdBVHl4alphOFc4NUR1R3g0Q1YwRGxv?=
 =?utf-8?B?d1ZZNFBncWt2VTB2UkpXbEh3clA3SXByM0FtelVEZmUweU5PNi8ra1BxYUZM?=
 =?utf-8?B?QlQrUnJkVzRiUkxCRHlBK2wyZkdLMVEyK2w2SnVVMGY0UkFiMDRnQi9WUWYw?=
 =?utf-8?B?cjAycXBLQ2Ewa043Vzd0YnpKNE1HQVRMQXU3YXNoQkI5M1ZuajJjUC84N2Rs?=
 =?utf-8?B?eTBWUG5vZm5PU09mVzliYzB2aXdRWGo0bVgycnNpdnJzTy9xUlFpYm0rZ2ZS?=
 =?utf-8?B?VWxTWEtORSsyUmt3OE5sbVlPY0JISkZDMmtudmR5UmdzT3ZMcE9lQURSSGxU?=
 =?utf-8?B?TTN4Mm1oM2VWdWlESjVSbFFUODQrb0krZlR5SU44SXNzdVd1ekhITURKRDVq?=
 =?utf-8?B?N3lvaGwwR1JIVE1JOVk5L1ZOTXZJOGl2bnBKWC85S09UNU41QkRKWFEzYlZR?=
 =?utf-8?B?bXlXZVNqV1c0RXRCajlzN2l1NUM5MnFIWG9SVFVsd1pDMWc1bWhmUjBDK3hP?=
 =?utf-8?B?REFBeDdwV1lDNUhGLytpL2haT0pOKzRYclVYMHhnQVVsQkpLTmJSTXNReTU0?=
 =?utf-8?B?bW44TlRtTlFSSUR2QnFsQ0R3aEphcmNieE15ajdNcEphN2tPR1oxSldWOGtB?=
 =?utf-8?B?eGhUakQvNy9BRWkzSHlDbCtLVktJcVgvZjBRUTJoaGk0YitTQlRtMUx2NEIz?=
 =?utf-8?B?dThBa2k3dlFUVlRsTDRDeWwreTBrbUVBNCs1ODhQNmZXeXFUZHhkSCs2T205?=
 =?utf-8?B?K3NkZHVaSUswWTk0czRFUUpZNDVYREJ1TGFWWDk3eW9wSWpVTFJLQ0RUOVhz?=
 =?utf-8?B?RVRKeE5xWDF2RjNGZG55U1lrZ0NjK3I0MU1IZnN2dXRUdzNPOHh2djc2TWt2?=
 =?utf-8?B?RFV6ODFaSEFzclZxT21Ramowd3ZWRlZ1WVFHN2l6RUo0YndCMkhVcnpCbGJR?=
 =?utf-8?Q?Q+3Pr4IURo/1ItRzkBH7BeU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jGTsKYyTBnJIBehVKH1exudaYRqRCdwcYRmeW4EjCYi0FqMTDVmGRmfqx3TYvExUCp3gMyIi6S6z4ZEPBc179OLpuibgM7aGAp3W8iPFDFwX4ZtRyj7Y2T2XO1+uk1CvW6Ja2COwQecBC8naLjvHmh5tHPbvnz9uJMUyggCX4O1xPVk/cd7m9mAnlFkPNUCEsyrXvhzLvQ70PupgsM/vBH7mBmaVNa2VZPzq6V1sHewZBQh/+DYcuaDtazSKKIM5HjRQCJqQHnntBjGBA3uV0BexK1S47UrriI2noAuLuwlTjTQraoEjKq3MTwEwBxgSPVQx59t0qvZp9jOQ4diruoyTJtUMowgpulwhAuQeFGiZFTOo3BNWSq24b96MqLyBp8mweCHFFSsYRHzr7/WUCGdg0WyYlmPVAQdzIHwuZUoU/++dDcbV/JRzOVycjZ4l28809OBaOuQfFtj+ZNVV6JTc1uLzOr321Q2wAZwGcg3WmFDMdbZMz8ZtHLAYZsQdRPxKB1S99p8FX8Z2958aSnolw1cfbBWIH2FB3MkB61Zwfz+hmfD3FkTAdacdGb6IrBWQfjBL43MytrDY4PXjxkbvqj+4vmJ4Fz7BuQiqHT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc22077a-9358-44a4-d410-08dc66221abd
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 18:53:04.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tOCW0QvDnkY5gkdxdJLp5LclHyHK5n8Ss4ZdBzCLt9ZLr3VoagvxVD6iI24xZg7YL9twf27c+cDUu1roM3vpHkanFqKqp43g1+SMyODmEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6869
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_16,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=982
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260129
X-Proofpoint-GUID: qo9WyMshD4RD0p5JkdzNJXx_MP_i2Q5m
X-Proofpoint-ORIG-GUID: qo9WyMshD4RD0p5JkdzNJXx_MP_i2Q5m

On 4/26/24 11:27 AM, Matthew Wilcox wrote:
> On Fri, Apr 26, 2024 at 10:57:31AM -0700, Sidhartha Kumar wrote:
>> On 4/26/24 10:34 AM, Matthew Wilcox wrote:
>>> On Fri, Apr 26, 2024 at 10:15:11AM -0700, Sidhartha Kumar wrote:
>>>> Use a folio in get_any_page() to save 5 calls to compound head and
>>>> convert the last user of shake_page() to shake_folio(). This allows us
>>>> to remove the shake_page() definition.
>>>
>>> So I didn't do this before because I wasn't convinced it was safe.
>>> We don't have a refcount on the folio, so the page might no longer
>>> be part of this folio by the time we get the refcount on the folio.
>>>
>>> I'd really like to see some argumentation for why this is safe.
>>
>> If I moved down the folio = page_folio() line to after we verify
>> __get_hwpoison_page() has returned 1, which indicates the reference count
>> was successfully incremented via foliO_try_get(), that means the folio
>> conversion would happen after we have a refcount. In the case we don't call
>> __get_hwpoison_page(), that means the MF_COUNT_INCREASED flag is set. This
>> means the page has existing users so that path would be safe as well. So I
>> think this is safe after moving page_folio() after __get_hwpoison_page().
> 
> See if you can find a hole in this chain of reasoning ...
> 
> memory_failure()
>          p = pfn_to_online_page(pfn);
>          res = try_memory_failure_hugetlb(pfn, flags, &hugetlb);
> (not a hugetlb)
>          if (TestSetPageHWPoison(p)) {
> (not already poisoned)
>          if (!(flags & MF_COUNT_INCREASED)) {
>                  res = get_hwpoison_page(p, flags);
> 
> get_hwpoison_page()
>                  ret = get_any_page(p, flags);
> 
> get_any_page()
> 	folio = page_folio(page)

That would be unsafe, the safe way would be if we moved page_folio() after the 
call to __get_hw_poison() in get_any_page() and there would still be one 
remaining user of shake_page() that we can't convert. A safe version of this 
patch would result in a removal of one use of PageHuge() and two uses of 
put_page(), would that be worth submitting?

get_any_page()
	if(__get_hwpoison_page())
		folio = page_folio() /* folio_try_get() returned 1, safe */

> 
> Because we don't have a reference on the folio at this point (how could
> we?), the folio might be split, and now we have a pointer to a folio
> which no longer contains the page (assuming we had a hwerror in what
> was a tail page at this time).


