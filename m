Return-Path: <linux-kernel+bounces-102315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DE987B069
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47951F2AA93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDBD13B791;
	Wed, 13 Mar 2024 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="OtREPB5I"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4F13AA56;
	Wed, 13 Mar 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352271; cv=fail; b=UebGzV/MFlv5e5kfaKv6Dpw5hHSOCpTWQyrI2mtDS3j4qsW1QvedyNGkYx3VBGj8Yg+v6vliExauIVpZIvwfWXPwRzbJ9Ke3sQ9GB0TRdJ09kgdzq+cFsrvCm13cw8KUJgaMk+tPnzmeaMHFtyyebDXOTWiK3UI1nEdfqnjrvdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352271; c=relaxed/simple;
	bh=mYWuSMrJbBLa/8UDjPLBrwLl4h8sxRn6vmPS8fw+TQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oQGV035z+kSbosyGZJ472uQHmPDtYIpX3AfSOfJNvzbFLSa7VwuGcuVQSY4B9uLbp147YNvB2DnWlkh56+S0GYj6gmxPRjSHAsap6TZF1f47DacJI8WLFWHesrYaGXJkuGOXpmXrunG98R6K05CFCfnZhrx4QhDL2v221jiUK3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=OtREPB5I; arc=fail smtp.client-ip=18.185.115.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.187.21])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id EC35510000D18;
	Wed, 13 Mar 2024 17:51:01 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1710352261.171000
X-TM-MAIL-UUID: 1c1c7508-1de6-4eec-ae1f-6c9f08372cff
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 29E7A10000315;
	Wed, 13 Mar 2024 17:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mV8MzeFPMSLSST1ozjq09XEztb51t6vM37AWjAqQTBYGQPJHXJmaCVS4s9MYJaPW7A/nFYVU65TTahy48Q1qF8ItrvEGeQY5HazK8IEjOrQVisKmj7ZrVZqL/BkwydJuOOxahkSplw4St7EcDdSQCN8G/xBEh7toqlhSGM9PmCUGR98PNxGiPylNg3OF9KaIW/NomSayKIGPaWQZauylMtkPEPopUgXI4QMv7XL2y28sS/aLStrLAbbMFxzcIrfU6N2OXiRWtM4hN33EEPWdm3fNO/HxkWd6EGP+kcH/9kwz+tf4eTmArvUztrDBkdzIYZuQldFLNOAjqGtdlfSajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAAiIfL7Gvi9jOp4TFBd/3otjvwDmGqEbbjv3Fn3u2U=;
 b=edFKTV/bPe3lJfoPUCBalfLYoXVVPrccBXJRR8B4+PIbHQlw3bwooH/9Lg9mCXXZJaWc1pNRB6wntf7yaqrB22EAZDmrFJCHwEdECGTzFiUuSug5PkOoEtkhTFxpnlmCPJR2wRNkHlUks8u1/0Ojf58YaSkVxK6EpF+sQLxzP4T0dBRKuFoXqn4p294FQDXZpY6IflUEf5HEm2JW8ZSo+kOOB2tEWUGE+zrVIHwvrHEwVMPgMeEieukgqAWF5k2VKA3Zdb0IGrLp2W1F/5A8o+4EZ9WjACGOYN0Xf5h0JXfRVk0tVxQHoEnwZ4/Yw33W00bWA44YHH/KVR5dyWXcXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <a0193f93-64cb-4935-b70f-aeee66eb6d44@opensynergy.com>
Date: Wed, 13 Mar 2024 18:50:59 +0100
Subject: Re: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 virtio-dev@lists.oasis-open.org, linux-arm-kernel@lists.infradead.org,
 linux-rtc@vger.kernel.org,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "Christopher S. Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>, "Ridoux, Julien"
 <ridouxj@amazon.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org>
 <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
 <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
 <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com>
 <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org>
 <d796d9a5-8eda-4528-a6d8-1c4eba24aa1e@opensynergy.com>
 <202403131118010e7ed5bf@mail.local>
 <dcd07f0b733a90ac3f3c43a4614967bbb3ef14ad.camel@infradead.org>
 <20240313125813ec78d5a9@mail.local>
 <96be7312f7bddaf06c690e082a8028fa8b511deb.camel@infradead.org>
From: Peter Hilber <peter.hilber@opensynergy.com>
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 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
In-Reply-To: <96be7312f7bddaf06c690e082a8028fa8b511deb.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::6) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|FR0P281MB1561:EE_
X-MS-Office365-Filtering-Correlation-Id: 9852b4b7-679d-48bd-f770-08dc43862497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w5iQIZJlCbLuqAx3HMpndLFZV6nLKRT2Bx333cAtkXJ6kV48k8IhYR6wi07KYNuSsePGaFtJspMXp0TMUE0exe0iHvHY2Jc6Z8eNqcCu8oTHKVUlPbBsQ7/k+sDMjeRwdmJIpENdecIVpcDRi7fIOY9cVxjXq0BueChG75NBbSnp0NPeL89YuXEmlgNU0xQSpJOzHGlnabr38SzORuE7rxo/KmD3bgZvTlLucjr49Kb2/ul1ZauFyHSO42TKDJLp1cusDn4GCFW5V9Gb8o1vcPImdtBbB2QmpQVNyQ4/KGI3jly+Y22HT1oOrIgyqrNCMTXg7Og9IiXgwUfVq4wQDoJFF5uk8EIptWnIo/xOTzCjdgSu0EdDwrJOAgp3Zcaxe1XOr0MEQgvrjJCM0Sm/WcEKxdpIpvrTdLGPITzuMaAZYVbVH0SIEhrd1YCeJ48w59ty4qxrYBre3HPqdKAu1dBbid3wDsJgD/Xn1LDHEuuNcs7KQNzjEsWDc3koBvwKgEI+vMFsi+APuNGfF4gWdfmyj3BxLqLnzudCr8jgCDbrilSG4bXJ8gOJ6z9yTNrkECJwUWA5D15Bj/SuLag3OcmG55UsYc1YyOZDngUX3ebPRqv1g6HAcom0Es4+WqR5VUC/MfYAxnei7SDvzZCJU6B9vQJDd/yLVKv9ijhJ1pU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXl5K0k1TGRlZjN3RmZLYlJsU0JnVk9uK3B5R1Rhc0hscjBpWFFVbU01OHJp?=
 =?utf-8?B?THZGNjZia1NUeE1SSWtITlpxMDBWK21LeFdVWWhHVUZqWkl6bDJYOGhDMHRj?=
 =?utf-8?B?c0tRU0orNEt2SnU1a0RVaDBkdytnTjNTVksyU0RPQjU4VkpiZjhoRGVXbTRB?=
 =?utf-8?B?ZFUxT1VRbGZUTUNReXRQbEc2ZUJKUUQzYjc2T2drWnYvVVBhSTlpWVNjSnI1?=
 =?utf-8?B?bjk0Y24ycDlTRHRueVJ2bjhnTk9kNUNCWjBzL3RYbHA1dzlaOHJZbmd1MFgx?=
 =?utf-8?B?cFBCcUhXSFFnNzNKaEFrMXhCRVNnL0lXemx1cnh1cC9TSW0zcFROZ1B0YjBX?=
 =?utf-8?B?M2g4NUlDTTV0dGxzQi9ZdDBmMGhaOWhMU0VJeThMVnpCcVZuR1hTOThJNVBU?=
 =?utf-8?B?c2ZsYkZvL0V1bWYzdmtSdVg0ak9EWkFvYjRpQjJYM3V4SXNyWDk0cytYc0dM?=
 =?utf-8?B?Q0YwU1pDbmg1ZFBOb2hsMUNEOUhRODdJZXdYSVZNOHJEM3RQT2lxdFRkNFlN?=
 =?utf-8?B?LzZwU0h1MUhjTjNNbGVoV3FVaXVCYTVscVA0NS9aY3RvWjJ1RitzR2pwTXRW?=
 =?utf-8?B?ZUN1RHdjOS9BT1BHQzNEYmM5blhveG5MRWxkVlZ5Nk1xb1VYWDdVZlpVZ1pB?=
 =?utf-8?B?aG9YaFJra3NEbVRVcXlUaGRUTjhOdTRoV2FpZDdxTkxvZ3Z4allyK2tTTmx0?=
 =?utf-8?B?MjlVQXBqckVqeUt4SkpPQ2hDKzJiV0dBdVBvNEJwcGxJQW82cU9oQkNWNHE1?=
 =?utf-8?B?cGlyT2N1ajZnL3lSSkJNVlVmdnNZSzJRc3dqenpQVG5lcGhwRkIvT20rWmZZ?=
 =?utf-8?B?SG01OHh0ZmgzUmV5a2E1WnhLcFhzVml4cG9rNTA3QTIwbzM3RTB2QVVOZlRv?=
 =?utf-8?B?TjNxNjNTKzIrMlphMms2SzdUYjZobzBRNzkzWml0WkRuNk9BRU9va0hlakFS?=
 =?utf-8?B?ZFh1MUFSaXc2d2xEbVBlZ2huejZLOGg1L1hRMHJLdHhnN0Nya29lcXJsM1dE?=
 =?utf-8?B?ai96dk5hV0xxdFlWNjZ3R2Zaa2dBYWFveWY2b0t3bjRoSlhoT2Z6K0dYN1pj?=
 =?utf-8?B?NnhKY0xyaU03bmo1R2ltNXVXMmIrNC9Qd0ZhUmtjSzNSYWdvdTdlK3lLRzRN?=
 =?utf-8?B?bStvN1NzS3VvK0Q3VWVyUlVwR3lETFhqK1o5ckVvMDdaVk8xdzU4VVJkbHlM?=
 =?utf-8?B?TFVINnVhWExEc2ZIUFZpOCtXdm15TWNmT3pjdnVvRVY4U1NZSTltUmRtWGt0?=
 =?utf-8?B?dW84RUJKU2JIYXZ0akd5a28zMWo1TWgwTW41WW5TZmM2elhydytsV2gzdVhB?=
 =?utf-8?B?cWtEWXBOcGVBUWhDaTE1SE80K3hMaHlSbk42YW9udmdIK0NQYzlOZENnQWZj?=
 =?utf-8?B?ekJsNjE2dlg5ZStqSnZQTjVheEVHU3A0Y0NjWncwV2pFMTZ0UklISGx5SGdm?=
 =?utf-8?B?M3VYTEZvOEVIODVxZVBIeTErN3RYZHMzb3hJcVZaSmxtZXhSQ1hmeXhtZndG?=
 =?utf-8?B?SmZ3UXQybUdEZGhDdnlhYlE4Uk50YzNLRUtKV3FJM2tPaDFFbDFXb0g3bUc5?=
 =?utf-8?B?ZnB2UElJalJOcnRhZmdCZ1hsY2hBckU0a2d3Y3VlRW41d2J3aGs5b3N4ZFV4?=
 =?utf-8?B?R1pYbE1ZRTdFZ3d5M01uclRkMlZ6dGl6SlVpeGdOM3kwTy8rTUphM2ZNaHZ6?=
 =?utf-8?B?SVd0K1U0VkNNUkpwd25sbmVtbzNtV25FUG1wK0NLYjZQaGtrK05JOUlNcWJN?=
 =?utf-8?B?dDk0b0ZXUkNYeWhoT252bEFydHNSa3VlUkkrbEpCczNkd3BuUUZNZ2Q5b3Yv?=
 =?utf-8?B?d0tiWWtsb2RVcGMyd1cvL2g3TkhOSlFTa29KOWc2VnFJcTlDb0VMTUtweWFs?=
 =?utf-8?B?R1NMcExzaTFuQjJOcU94cUZZanhYakVuSkwyUnNOZGk0Mng5R3lXRHg1MEVH?=
 =?utf-8?B?S2Nta2gyN09vUTR2K1ZUVVRVU3I0SkRWeGNoVnE5ckhYcjJiWFlRRndZdGFE?=
 =?utf-8?B?bUFqWWUzRXlVTk10UGNPa1VLQng4T2pGQWZiV1MxOXVSZEJyNnlicXh2TXlp?=
 =?utf-8?B?N1FMTUlYbEk5RzZqdVZtNWE4Wk9TdWlLVmNTMVRhRzl0b1pHR3BDVHV2dGhz?=
 =?utf-8?B?T0J5dHBxTEF3bVk0cjhablVOcXM2MEFadmxTMWhzSWIwL3p5Z053N3BRbHNC?=
 =?utf-8?Q?FspozM47rtjMEnTEDP20CM3dGUkGx9HxcwrUWpVdbh0W?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9852b4b7-679d-48bd-f770-08dc43862497
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 17:50:59.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2L773XdfZnZTULry0wJfGO8Z2QQ8uJ+Ox1nYvpnPfdjm8kBBsyrzkdP2CTPm75CxEY+wMRVCg4Nm6sAswhGug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1561
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28250.001
X-TMASE-Result: 10--24.653600-4.000000
X-TMASE-MatchedRID: 6lay9u8oTUP5ETspAEX/ngw4DIWv1jSVbU+XbFYs1xJGfNnpQ3SshQ+D
	YR2hJ/21ldsfvOgm5Qz6pWH+lLj2TAK5r8WunyGIJUMe+s5cvaMs49QZH9p6LNrm58Qo63if6UK
	4rxM8447VVW3SFJFaxnSbx7zv3jxl/PZNxlrIymH4MTnOvlqF3F6UsWSgw8xYQTCUAf8+V55x0Q
	LoRDtsfXor4EejHFA7RgJOi57JZ3OiMV4zWiiE6RQtns7Ax/rnOTa4xErHZfcLDzQJD3kt0O/yM
	kwYZmJ2/XHRUQjr1ZlTQxEPP9PT4BpjGlRhsJl6nRTJpY7VAKe4qAaN6svaSHzeZe4qUZOIxwD0
	DFG4dtzP9mBYkr9eJ7AraGot/WjgjLp5HPO1rhIMfiba6PAK29o+48giqZwn+ng65LLRQXGvngk
	jHjojpAP5R/zL3aImZM3jbOBadQ0WtOyzfwL8xlo7GmCOJYd1AqYBE3k9Mpw=
X-TMASE-XGENCLOUD: 3103cd39-6b70-44a9-8650-6f91b3615d0b-0-0-200-0
X-TM-Deliver-Signature: 9FCAEF6C9A60CB4CCCE77E2D07AFB7E3
X-TM-Addin-Auth: znvw6fL9EBLcfPDrFN2VRyEVtpXqAdeXUWIIX6E8jylQ9Mo5MnJyM3IYMr3
	WMYlm2OtfMnEVGDciN82ePfhh8udJsf++yVhevDsUKOpPJDFfUdNJ4gXfKmyfg8aZEE0aswkXGY
	8RIRKsUxzdOts5r9Q5zdY2y4MJdatpHyyfdTSC6fMLIj3hMuaDGxjXn1+/aywbg0GpI7k6ILAg8
	qCrFuyH5H/QT/8qZyTPfB8maLYgZaEeQHMcP61BZvTceUIn4ra5aJyFvMdWLIYHeFPWZ7fmPq8N
	LHg2+sRk0JvlsnY=.2hdf8QCKzvbTW1iOq8N/cuPKPplSktOUo3ivtlWO174g3TearYehhxmc8h
	qEYwJzR38zgvNG+uX4cAFDWrTdXUpGk8t6jGWwM2qb5FJxCLIoptaByiwJlXWxPhsOZiivu5kn1
	A2gLV8xfkKVglxTWV9sBo4+SWIDSV63zfQU98GHNKxfa3aDy9Re2E2bOTnskcuqwSW7T087iYPS
	z90RNcaV7grB3C/dSyA25YZX6NwZMy3gsWRdZX6tWxMrMbrD5qxmv3jfLRv25SxT2d6X3DJrTfz
	twyIN2zZszL/5b/IkYhWbZ/JVIK98JyT0GSltMCXCV1rCYOZcAbmoP9n1RA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1710352261;
	bh=mYWuSMrJbBLa/8UDjPLBrwLl4h8sxRn6vmPS8fw+TQc=; l=2498;
	h=Date:To:From;
	b=OtREPB5Idlesy8PgfogRTX8Y6Wpjfe8S8HNNfyzmymyVgr1x9QB1PkmYu+cmDW+qs
	 fDCPEU4UWDhMu6ooJIy1o5K5uHaoFxucY5+zyeHr4kZ17mPEPBBvE+i6tg/+oNOt1d
	 qXL8P+S/qqajD3bO9h8nlyCisGBoy/o+IgyVwKVpV320v5hBjUTl3HlHnD93pz+IMP
	 028dC5CuXa094wbDuu5pf3v6V8GkVd7LEvcmW2SruzUl4EFm7Qkn24YpVE3lpmP9OC
	 aZgqLzti9opnWeInXtvk3RUcFmw1w6diMIEyoz0UohMhJy12scidvBudMZur7FTZTh
	 vTJy6vwJ/47YQ==

On 13.03.24 15:06, David Woodhouse wrote:
> On Wed, 2024-03-13 at 13:58 +0100, Alexandre Belloni wrote:
>> The TSC or whatever CPU counter/clock that is used to keep the system
>> time is not an RTC, I don't get why it has to be exposed as such to the
>> guests. PTP is fine and precise, RTC is not.
> 
> Ah, I see. But the point of the virtio_rtc is not really to expose that
> CPU counter. The point is to report the wallclock time, just like an
> actual RTC. The real difference is the *precision*.
> 
> The virtio_rtc device has a facility to *also* expose the counter,
> because that's what we actually need to gain that precision...
> 
> Applications don't read the RTC every time they want to know what the
> time is. These days, they don't even make a system call; it's done
> entirely in userspace mode. The kernel exposes some shared memory,
> essentially saying "the counter was X at time Y, and runs at Z Hz".
> Then applications just read the CPU counter and do some arithmetic.
> 
> As we require more and more precision in the calibration, it becomes
> important to get *paired* readings of the CPU counter and the wallclock
> time at precisely the same moment. If the guest has to read one and
> then the other, potentially taking interrupts, getting preempted and
> suffering steal/SMI time in the middle, that introduces an error which
> is increasingly significant as we increasingly care about precision.
> 
> Peter's proposal exposes the pairs of {X,Y} and leaves *all* the guest
> kernels having to repeat readings over time and perform the calibration
> as the underlying hardware oscillator frequency (Z) drifts with
> temperature. I'm trying to get him to let the hypervisor expose the
> calibrated frequency Z too. Along with *error* bounds for ±δX and ±δZ.
> Which aside from reducing the duplication of effort, will *also* fix
> the problem of live migration where *all* those things suffer a step
> change and leave the guest with an inaccurate clock but not knowing it.

I am already convinced that this would work significantly better than the
{X,Y} pair (but would be a bit more effort to implement):

1. when accessed by user space, obviously

2. when backing the PTP clock, it saves CPU time and makes non-paired
   reads more precise.

I would just prefer to try upstreaming the {X,Y} pairing first. I think the
{X,Y,Z...} pairing could be discussed and developed in parallel.

Thanks for the comments,

Peter

