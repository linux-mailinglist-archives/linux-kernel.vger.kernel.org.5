Return-Path: <linux-kernel+bounces-145761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF6C8A5A74
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5FCB21F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D561E155A52;
	Mon, 15 Apr 2024 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bdG4rTtR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HbpPuD63"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B7B656
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713208655; cv=fail; b=IVfjJ8dcT2n4TCf+CG2WtDisl1nJLiZxMSYnUHOGqS8+RHCSRN9nouS8jVhL0GypX53DiEQenFXZxHilgJlyclERQ3LTvcwdgi9LtdbsNrG8YN2OMKau69hNu2XZZY361wmEQc2Zd/5OXsmrncXJt6/qwe6EwMP26MaLSl0VD0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713208655; c=relaxed/simple;
	bh=vSA50m+nVPBIrj2Y1OOrGBqOawEOUn7ETIu//+Lgzpw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gzk2VhqFG63khMjn+eli+D02WRNiHyNqOuEWBfSu28741OJuAbyVf4gmYWAoh9kASUROAC8wRduxbe/HvpZCN0f87ba8Xa3NbZNDQsXpaQRUKTliuh+jbmBpTPNaLFnieotcaCcoTEYnitbmQEtY32QN7lHVMWSylvB3IUBNG3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bdG4rTtR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HbpPuD63; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FIwxrE019456;
	Mon, 15 Apr 2024 19:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2eswhAoGImIviTgoM2Bu7m+vn9zrizAHCFnWEcw9hr4=;
 b=bdG4rTtRA19uVmILKiCpaSJrPyAd0zNqggVSsR+ufDjSXJZmzUgHQZM1hD0Nad2s5YPP
 M7nCnFE9hguiiHXF4fESpGvuZ3Qz9lo8ZBT/JMfYUx+xJmh7YcDoosPg4JESKvOU/U4C
 5iMlWeYZ991Yh/pEzxh89xgBadaesKm03WUwLdxejWAVa6lu2SECbhb5H5gpCqcsI9OD
 xJBaDvYdTXagrUa4HGJ8vApE4KBArayn/D7x6+iuHN7l+sbCu8FNicPBm1tp8WEAwmYO
 gAy+0b8qQUVFL7HSY5N5hYo1dkMnuJYhVZiTe6a0t8LzaOxAW31tHFwyCZEr46g95mYt Xw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhnubnev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 19:17:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43FIr9jR029018;
	Mon, 15 Apr 2024 19:17:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg67m9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 19:17:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo7TjSbdGQNIrywfmTStbJlEeXwdEHau+OYvWvL9RhH/CkwNLfVSiU5x3pXYXFmm+50GHET+B18PTLFTSVCvNwsqKiyzjZrsgyLpDnl5QU5TjfggcWpUX3dHOO5j9WEONRC0+3+z4QcQe/Hps+p/qjCNKlkZs2bLWjnCzulb4BKdeeqHbR8AvzHnAY21RZOh7qeRtuE6QFeoDZxEXkb4J50UywmcqVKKpDk3Zq8HxpHIG8mBB8FwlEqrYoebiVR9Pq2vgA72kTEdypvEv5sQnaQ+AhAsXiYpZPqqaTJcI4QYraCXiV8UmTPIxv9Kf2ZgyhYMavGw/7gsfGgQ3PwWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eswhAoGImIviTgoM2Bu7m+vn9zrizAHCFnWEcw9hr4=;
 b=Inyfre+/3zHToboUfU+NaBjhYKUuUUf6l4jej4YXnGarPir3Wa0YkDxDVCqFUeUrhZKQp2ditr3ePv/aK22EeAKOciTO5wnD2+MnzHH1Y43S8CHkzxNOYbvzIzW3wiQJlKAnbF+c0waI7Eo+rKl7TacJVfyeQI67feY+a+1bUNN1xQOHFlxav4TrlEVQEYmE+wF+YrsyDQxMBCa3J67RrjXiaSUvp0rJYfgmHezndtemAM09g7KQPpMtEFAtO1t7Y1uyQaXSCdGtpkwDNLif0k9lILyNpFk0HAcSl3vaW3/Aefm8iXqP2GpXApjWyKQHtCZsPwtNBg/rnukKCYxJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eswhAoGImIviTgoM2Bu7m+vn9zrizAHCFnWEcw9hr4=;
 b=HbpPuD63wcclgJZ44wOOppgqRWiSiXSvqM0dA6Shw0W9a0rOpBHvbvc04XwK/ADZJnDQ81cOfn7VoACdWXNLMcffRSeXOFXKV/WLbHoPWwWOhxP7s9ZRW97fU92UoOxpC1zvSrcLo/62oujgpf8nTDfDVanYo/Be+Bi/urKa31M=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB6424.namprd10.prod.outlook.com (2603:10b6:a03:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:17:06 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68%5]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 19:17:06 +0000
Message-ID: <9dfd7670-9770-4ddc-b3d6-d039483dede6@oracle.com>
Date: Mon, 15 Apr 2024 12:17:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/hugetlb: rename dissolve_free_huge_pages() to
 dissolve_free_hugetlb_folios()
To: Vishal Moola <vishal.moola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org, linmiaohe@huawei.com,
        jane.chu@oracle.com, muchun.song@linux.dev, nao.horiguchi@gmail.com,
        osalvador@suse.de
References: <20240412182139.120871-1-sidhartha.kumar@oracle.com>
 <20240412182139.120871-2-sidhartha.kumar@oracle.com>
 <Zh1y25IizELqexR2@fedora>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Zh1y25IizELqexR2@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 54579610-168b-478c-53d9-08dc5d80a3b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BFmjIxhtqslZLt8cxaUct+Py1aw6kM/XJ3GRtKt1+Baile+bcEAFSPSNitKVa1sP2iuRInKQA3t5tRAnfgj/4pgycZKhSsKt2gzqAQMjyHTxLy7h0vBnQlTH/eZ5pwdXTXoEFnkpdGs1BD1OSYlVNzsgOIvIoo+SsAguOq0LjMxUmGGeTEnrGsXNbTaF8Qt+qsT1LMIYoUeYe7ZDZOA8pS5J1rntlB+pYNyf2cN4bclSs3KIEU0uccgpJA1wySWJjzn3mM7zfsoe77A0T/9ogijkqao7/iSduNkh3QF6zAI1moFyVcmHAN8Qv/HWl/zehXrR/GIdxGre/U4lJNi4MhNVxulTIntYG3U11Zoy4QymP658CnrRkTk3j3B9OXnDIJviGHi4c1mxNn5f2gzVpq0lrpA7AixDrMso/64545vkv6c7xmAXkGVhJTO/eDnUQyAPwA+s7Iwqyf06iiTCa9za9ifm+Pr2DhrWXYXlUAIVodqMR7uSxtc1fVvpPNi8mW9OKtIYqUGZ8S0+qJtXoEZPegIrhFQdGKvEHD1BQL/+owVLtiBt10PaW8ZzmjXIijpDh0rKKJYJIDt4bIu9yAL6FkzOu4QePefS3nj6xw/EVg7Jv+yfA1eMGqwbq2xwQvdcNrLypWMggHA3YIeH4mR6IU+yKbH75JJFM1vWamU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SEpFTEI1Y25WR3BrL2lYVUxsTStKcEp4N0JRU0tPLzFSM0lVZU9YbnVxLzNN?=
 =?utf-8?B?dzU4MTlnVXhXMHp4WGNMdktveVArQ2FIU3RIL3NsZkNZaTlHK0w0d1NIdzlq?=
 =?utf-8?B?TzVFWk5wMlZvUy9aRFNRVE9ZQmhURUZKaVNsQ2hHUGU1elB6NFp2cmFRdTgy?=
 =?utf-8?B?blNvLzNqRmlyaWswb3RibUk5UmdvUHRMeFovcklTT2pyZDhYcVBZOGtzVEJJ?=
 =?utf-8?B?U0JqNVhKMVlCYTh4aHVULzZFUGlUOXlzUUUwcDdMUFhSWHRQQTRTSks1b3Uz?=
 =?utf-8?B?UUNuQTQvb1dlZjErYkhUK21qaVd5OVZ2TTJ2aENLSWgyWlBEbk1kMjJscnZ6?=
 =?utf-8?B?MWhCd0RLVzg0TWJacEE5NktHYkorbnV2Q1UxKzIxL1pIOUVSYTFSTENPN0pH?=
 =?utf-8?B?RjArZU5hOTE1cG8zYy9jaG50cXdzN0Z5VFZqUG94M2d3L3h1SkdKRjRVYnhN?=
 =?utf-8?B?aFZ0RjYybXc3WGpjYWxzZEp5Yno0SHN0MThzUzJkaTd1RkZFOTFSQktiaG0w?=
 =?utf-8?B?NnVnamIwR1A1S2NpODJUeTVCUGUrMjEwVVhkN0RuN25NcTdrbHV3NEVNL25i?=
 =?utf-8?B?enk4YVJWY3VkK0NJazF1Z2hFeG4xY2RWalV3OHJUZjdhTGxrWWxjNUxGTjBU?=
 =?utf-8?B?YXgvME5tZ1ZqeHpIaWRGYUdYVDJGdzU1MWlJRnRLZ1BTeHp0UlcxMm9Xc0dU?=
 =?utf-8?B?UFRic0tEc1pVSTZtbEM3cFZ6NE1Yc1hiZEduTU55MzR4OXNtT3R1U3lOTmw4?=
 =?utf-8?B?a0I2bzAwSVVGdDB1ZjRlOEVLT09SVncxNmpvMVVjdGN5Qm1pTVRscWxOalFH?=
 =?utf-8?B?N3R2clJ0TXJiaWNZVUw0Sm9QL0NEdFdBRnBmejNCS2Y1TFVIRjJSVkp0TjlW?=
 =?utf-8?B?Y3dOOXFaWVY3MytVMnRMYTNLd0RWQWpiSExTOCtFb0lQR1lrOEV4Z3FITDM5?=
 =?utf-8?B?K0Jyc292Tyt4ZkowcW9VbWdJZS9OSzZ2UzVpQlA4bXAzRHFoQzE1MU5xTnJD?=
 =?utf-8?B?YWNzWTByVU0wUXpXc2crS1lMNmVDNXZ5WUJPM1NCSVhtTi9rRENXaFhwRk02?=
 =?utf-8?B?WXlOWEcwbS9IMjRlWGdwM0E2R3BKTkRseVEva0VQQkhLb1BQYTRXNExKYWps?=
 =?utf-8?B?cE5NK0JyYUR4TlE3a1FESXB0SU84bHJIWWlVV0JIYzc5d1Y4VUtKYk1pWWE1?=
 =?utf-8?B?ZzhkR1hyTnpvMFpVR1AvRWExdzJiRUtjbVh0dkFxS3Mzb3Z4cFhIT0ZuM2Ja?=
 =?utf-8?B?ZXJENEFabFE4TXVEcjhIdW1mN1VydVhNcmI3VlAzMnpWUU1YckNjaTlmRlpD?=
 =?utf-8?B?Y2lHY3VxMTM0WWJmVG01M29GaUZwWHVacjNYNGp2WGR1dGFXcmZiNUc1MnV0?=
 =?utf-8?B?dGdlenlJRlk3dWF2SThEL3l5QW1lWHg3eW9VTDBJSGFpOXJKVFNYcVFmcXh4?=
 =?utf-8?B?YmFOZ1pkSG03Z2xwRDZKWUtUU2VUWkIvdHhTbGlocnhRbTgxRGJwWmRCSnhj?=
 =?utf-8?B?bFJXUUFJRnpmYmUrdnFNUyt5Y1Vxb2F5bTE3UmNOQ2grSUlHRXgvZ0JXbHA3?=
 =?utf-8?B?UzcyVmhmaEU0TzZ4ZDFUbjN4bFpxV0NuZ2Jkd0lkU2NjV3dDd1VkaFZsMEdR?=
 =?utf-8?B?OWhmV3NOSm44aEp1bXZPNk1sbHJBeDFaU1kxQXVTV0E3Vkl0aEJMZkN3eHha?=
 =?utf-8?B?V3ZlKzdTMXZFNkROSzFSYTRZeHhXbGhlcUFmdElUNStPQzc4M2Q5SG5pVjZw?=
 =?utf-8?B?cnVSMGhCa3F3em91RnJQN2kvbDR3dHJiVnBVMlRYbDB0UXh1MW5naW8xOHo1?=
 =?utf-8?B?RnJoMlZ1L1lpc25oYVJHUHJ2blpwUm5mMGZkeEpqMDRlcUUyYlVqMUVjamVG?=
 =?utf-8?B?TE9sZENReGx5M3Y1QUp3ZzJUcm43dmFQRmlTSGlKOU5zUUNYSmFIWi9hbTBU?=
 =?utf-8?B?MDVZTWN6bnBBUzEvek1xSUJYMEhQSnJZVE9UbWE0OG5lNWwrRURIWjJLMGdz?=
 =?utf-8?B?bGRuait5YUg2VjJmY2trVG9nZGsvTlR4b0dIbDRNQ1Q2ZUg5dXFXTUhYRUZS?=
 =?utf-8?B?Tk1ZaWlVQ0R5R01lZ3NrTE5GaVlxTkpmTWZndFlOZFkxeUliSGZpY2RsOFpU?=
 =?utf-8?B?bGloRWNmV05kMjV6c2YrSzVmejdRSWtyTVdESWdpaTNYTkJmOHg3VkpZNG02?=
 =?utf-8?Q?at2WZjKAoaD1eMnrfkQSVa8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FCKT1R9/r1rcZflWipLD0IiSmIXhuenY3u+mMIWH2gyFNu3WQrep1c5pYVmXH/Go1wVDN58APo9xhFb/q4ViYSuRsELtLI/DeadWIPNyb9wCSy4DHMmHBfunU2JWVUMJGBBCx4od+X8r9GnE8+5PihrWhVBJDxXNyubY0I8Ng7sVctmPUtHTENj3P/yazGuY4Jo2Ywph04ak1Hc2aiffG4OSZ3eUJHkWt9TnlRLVzsY38fEeB683m2C5BJKy/RmJFwFjrc2rRvT/87LRqB9ADQ1Wkp2cuSvA7ut6FFNNFfcDrQcs4a0y3JpMP3zjhipVjAx35/rtYLERozDovqvkPwhZeCkOgUdoTwr9M7+8oKlImU0EukM1Wu7PPeSSdOi2+dGDWydvHjiDqyPdEF5CNQOlNX9nlkXEwTk2LTNCjcXQpMu5WCLE5UfQ5M4H5lzd8uNOOdN9fWKvidY4haFn85O8hJrLiIjjyJw9CaOJv+6wffFqEJ12bQid0v6u7BIK+4PDykl7G/buKW3YdXG3gV+LuV5I23u7rJs9EHxgjSE4dseS7Ft4t2bpfOapyFAATHXO+OnTMuITz9NaWXuBh2OQ36+XKtwlohOlzuURTX4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54579610-168b-478c-53d9-08dc5d80a3b9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:17:06.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWPhYraYenn6rDBRBPFwaYv4NE5fLxY5oI77GTTyiPgVsSKPSVAbvMpg8IEFoIEI+Roq0t5olLR0td9od/+YIohj9PbSsQGTJGFqCq3fosI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_16,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404150127
X-Proofpoint-GUID: A53tBrfSRW3XLH7odHhcHpT2u1W30cFr
X-Proofpoint-ORIG-GUID: A53tBrfSRW3XLH7odHhcHpT2u1W30cFr

On 4/15/24 11:32 AM, Vishal Moola wrote:
> On Fri, Apr 12, 2024 at 11:21:39AM -0700, Sidhartha Kumar wrote:
>> dissolve_free_huge_pages() only uses folios internally, rename it to
>> dissolve_free_hugetlb_folios() and change the comments which reference it.
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   include/linux/hugetlb.h | 4 ++--
>>   mm/hugetlb.c            | 2 +-
>>   mm/memory_hotplug.c     | 4 ++--
>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index f4191b10345d6..9ad7b97069cda 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -862,7 +862,7 @@ static inline int hstate_index(struct hstate *h)
>>   }
>>   
>>   extern int dissolve_free_hugetlb_folio(struct folio *folio);
>> -extern int dissolve_free_huge_pages(unsigned long start_pfn,
>> +extern int dissolve_free_hugetlb_folios(unsigned long start_pfn,
>>   				    unsigned long end_pfn);
> 
> Same comment as the prior patch.
> 
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> 
Hi Andrew,

Could this diff also be folded in this patch to remove the extern per Vishal.

Thanks,
Sid

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9c96ef4d290a8..1bc93e7e315bb 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -862,7 +862,7 @@ static inline int hstate_index(struct hstate *h)
  }

  int dissolve_free_hugetlb_folio(struct folio *folio);
-extern int dissolve_free_hugetlb_folios(unsigned long start_pfn,
+int dissolve_free_hugetlb_folios(unsigned long start_pfn,
                                     unsigned long end_pfn);

  #ifdef CONFIG_MEMORY_FAILURE


