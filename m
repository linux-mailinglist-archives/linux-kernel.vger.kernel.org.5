Return-Path: <linux-kernel+bounces-94247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E155F873BEF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98638288245
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD301350DB;
	Wed,  6 Mar 2024 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="QwRLGa4x"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF7135401;
	Wed,  6 Mar 2024 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741927; cv=fail; b=pr2rQn7EJZS6/NkSJZ0QkYUcKdbb1wbYbZgoVHw1F6CPSk3Fa6dDSQiVb9QD4RF3kiubedifi0ERCUzwIMWaHRDTHfpnuNW98nDHiCtIydFCceTWL58WVXYBOSdkCidIRKbET5luiAsk/K7LQi2TiX29OWOgiG+NO4QPj/yq1OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741927; c=relaxed/simple;
	bh=qHF5xsjCl/t5lG9uA8G7tKDrCPk5ti9T2SQHsbLAsao=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LubAgxGazQrWb2VTMcebRortphDvUXjQIhssA/ZiwYI+LkJCaumvFuzRVPBP5CclRRYWp1s79FlmfcQ0Fa+0Ox03TVGUbIrQ4f/xVLgx+MWZmNdzuMh00k4gpLazJgm3ciyN6cQFoxI4GmpjVrvAyony9QAzP4N8IWtTOFPaKCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=QwRLGa4x; arc=fail smtp.client-ip=18.185.115.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.192.213])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 0D53510000E32;
	Wed,  6 Mar 2024 16:18:37 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1709741916.174000
X-TM-MAIL-UUID: 50cf4319-5797-47cc-851e-e4517ebdbee5
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 2AAFC10004DBA;
	Wed,  6 Mar 2024 16:18:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9ZIcyrbcjMppFopkG2vuzo3cyHrAMrhD559omTCk4WSV4rORj23mHpR/DBzVSgjpt1k+sAL4Y8eS1flfDFJQhAf0EKVKEvHfqo1O1BCfGOLHVfPRxSMt4+6Jx4Pem8GrXVIU30GXy0oH+5ql3MRLlhkOrXWACy2rswrzF5bnm+2mpcD92WHWdbommk1MN3Ac+U5Rr9K4hn8zvilktwEn8or539yWaTkj7TQEdQZ0lWEwSYTcpqxZGxJAWXMuZyXOloyOUxdzOexDiPINLx7nPvEkSIxY/sU+8IgFfWVXusFqwV2kYkjTMWerlF84Rig6qK+ryDbpva/tqzm1VtDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mW7nG2z0QEehmCF1S3VphbkI8g7NP8wFs4yBbgX9dsM=;
 b=T/Hi3hhrXUXjBYjJCvOLcty8LXR++yn9Q0eUdCtXxnCNNRgqgGOaGfH3SD+Kxu4xQhGQqkH6S+plsKHoPciHpy/1l2Gwz23DEikiWe9oseGi950vzXWJzjj6D7QejUC5aj+PDD3FcgoYZSG3tT0rwySDjsmRgfqFuBOhTMvTFYS99cY9JSpu6luvndva0IHaytcYBzpiq+zgV3KUFTdGFDkf7C1dpozYCayVeuUKk2HKSXGSChKIMCACZ8bOG2QFb+FJGJAYzPzLKmA5YjhBnTa0d1/j4snqpgUEQftB9SPiHJhGtN1Su5cg8fvIvk3NNPAxhiPGH3+swns3gcjf+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <b5e3ed19-15a2-4dfd-a1af-28d11ebefbcc@opensynergy.com>
Date: Wed, 6 Mar 2024 17:18:32 +0100
From: Harald Mommer <harald.mommer@opensynergy.com>
Subject: Re: [virtio-dev] Re: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver. -
 Correction
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
 Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@kernel.org>
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
 <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
 <e2e5a7a0-7a2b-40d3-acf7-6f0b91bd5d40@quicinc.com>
 <2a911f96-eed9-4adc-9043-27fd1d3a7ca2@opensynergy.com>
 <c7c939c9-50e0-4d86-bd44-d8b4b90ca14d@quicinc.com>
 <7bfbf09f-67d1-43d0-8ecd-aedf3b9e2287@opensynergy.com>
 <58d1487a-fd3b-4b31-a133-3181359e0c61@opensynergy.com>
 <a8e5463f-787b-44c3-842f-c2d7f703d26e@quicinc.com>
Content-Language: en-US
In-Reply-To: <a8e5463f-787b-44c3-842f-c2d7f703d26e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0165.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::18) To BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:2a::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2581:EE_|BE1P281MB2545:EE_
X-MS-Office365-Filtering-Correlation-Id: eebfdfea-6eb1-4928-3075-08dc3df9125f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0RD5VnATF0w4sNyfapVOZ/9xHMrG5FTpY6PDKf8B7PrfZQ2AiNjb79RUwdk95npOiV3BgNRVqV0GC+jy1M2cpqaXzeHjuyaVLOMpLd7R5h6qd4crdcntVU+lhMKbzw0wFr6EjGr/mo7XfT74mOLg6F+ZQSQQfXNp/b9EaSiPGQM8lhjGc29cybkm05CDPK3mL4V1lzu0PDSg4wuFwlu4OAQctAmeTgsIA3f6REDJsMdBvLXdhpoGunhE8w0oqUxK3BXVscGY1JJ2WJ44MUbDW+OwUyof99c6HuYuQS/VOFamecSynMy/GELJ0DQ4wJglRZxDwTMAFdRdMXucIvHI24ukY2mp57k7NE10sPl85gFsupTlJZaYWEnmCRXvKJXBgnBSD1mhffAFwJzvARb+1jAgyInGBmT2lpIAWUGv0fyx+nxoumYODzMFmtB7Mp9xpYo5b7lyAZMXrJbWEjIZQkFZnKWklM+f9EZE9taAwiyOxyuhSK3+c63pkjs0YfX+gS6c3cJ01vAMizKKtNxQLoHz29ixPbBgPJpcFBOTzl6c57K9NdN3RA0MGuXSuIKgtqBAi2w/IVavju+ycXbZeVCcoUaqhyg+BW52Ez6i1V4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGV1RDQwNE1Mb3NDRXBUaVd5QnRleDhGK1h3b0ZEK0FXS0FwWmRtL3pZMGE1?=
 =?utf-8?B?V0pjWXhjMVN6dUdwRGFESktvcDUzclZKU0xvMzB2VElDQjQwRTRVSUU1OTFh?=
 =?utf-8?B?Z3BRNDczZ0U1MTUzcVRnR3JTVk10bm1RbFVwYnRvQVNsdzVhN2VKUWhSTVBV?=
 =?utf-8?B?Z3ZveGFXMm1MYkMwV1NVTklGaEo2Vlh0V2Q1MnAzYVZkdmVBTkh1RUsxek53?=
 =?utf-8?B?cFg4bmhtZnZxNktUN29JSFBOeU9ieVhWaUx0WEZOTmF2WncyWkhrUUZSSmFr?=
 =?utf-8?B?V2w3N05qNlpvYTdES0wrWTBvdk5Ta0ZyaXRPbjB0MkFKUTFkM3FVSy9jNjNV?=
 =?utf-8?B?S3RyVkY3NGNkQWY3NzlSd1VTeXBTVjJlazNoQkVmeWcwbmZzNDJsK1FxOEpV?=
 =?utf-8?B?VHRCUHIvcEdmMEdoNDE5Rm1rdEh0U0d1R1FhU1ViUFNZY25KOWs0U0NqR1gv?=
 =?utf-8?B?VmRIUG1vUy8zUzFIUHI0MFczVUl0eVhzSHhNS0xNb09xSXRhUUl4Qzhid1hM?=
 =?utf-8?B?U3lNQTd1Q1hqRUZndGFCbzlBY01mVFhkcFJOOTBIVnkxWGh0LzVLdUVxb3dX?=
 =?utf-8?B?T3BUSUNRdU1RQ0VOWS9qeEllTmNxbjBNU2xyN0ZTNDdtSEJhYURUUWh5L1FY?=
 =?utf-8?B?VWZRb28rU2hwcmhPVmszMnhGTDY5ckxUSDhOU2U1cWVmMDgxSEhPNjhkc3NU?=
 =?utf-8?B?T3owSkJJM3pvRk5BM2tZZE5IM2FTRTNhSElJUEI2NXcxMGxlQndRN2JiMHhx?=
 =?utf-8?B?b0FiZXBJZnEwOFdGa3hQbDg4Mk10SVBLWkIvTGF3dzZSVVJhcXp6Y3ZBVXhB?=
 =?utf-8?B?YlQ2VHkwZ3FyNFgrbHhvbEtkeEtuY0ZjMElmZHJ3UjRDWG15bDBXUmdZSXRV?=
 =?utf-8?B?azROZCtuQkMvV2xWUUpPUjRtSzZUZ21GVklvSkh3aFpjK2FZd0sxQmNwSVNj?=
 =?utf-8?B?Rm9yYVJ0bjNWMUg4RFZ2SUU1SXozNkxzV01lbE83SGtmcEJIS21SSDZUNWtk?=
 =?utf-8?B?RjUvOEU2MldlZzlIRXJtUm94aDEwbW5Gb3NVN0YzRFRDOVVQdkpVa0tsU010?=
 =?utf-8?B?Vmh4TGFyeDdtTU51cy9abWplaGdUd1lRZllKOTBobzkxbGRubldKQTNyQlRq?=
 =?utf-8?B?WDFhTnBUS0ZnazEvajJQbGNNUEFMUnkzM2VtZnFFdnlyUVp0VFpFZmkvQnl1?=
 =?utf-8?B?ZXJQWEJWRkRQSkpOOEE0ZitLL1V1d0J4TUtCeHBtOGpDVkJIUE5LSVFYVitQ?=
 =?utf-8?B?Sk91WVZhNXJtdzRlU2dPclRGUEljblZad0hwUkFFc1BDWDZ4NktoZWFDNFRj?=
 =?utf-8?B?dzMybVkxdk82dzh2emZ2YWNyTkxXZ0NqbElXMUFZSmZzbFU3amZCNkU3WG9N?=
 =?utf-8?B?T1Z4MjJNNGlyTlBSWU1wNmhsMmgwNFc0ZTlVZFpxaHdJYWt4Z0VQSzBVVDZV?=
 =?utf-8?B?eGxPZDFlNk1TdnpPQ0FtM0ZVMU8vSnZmaUFBYno0T3JsNlduL0dnTEdnL0Jy?=
 =?utf-8?B?cXFBb0Q5WGpWYjBKM1VmWVNhTFFTdmwzVTRadDZmbEV4ZjR4bGVOZjBkU3J0?=
 =?utf-8?B?cVVoN2FIcEt0cmlETHJnVDV4NXlEb2R2d1lDdGM2azBQRS8vRHZkV3VCOXlH?=
 =?utf-8?B?dG9uWi9JZ2Zqd1NVaVlQalFTVHBRVFUzMVZsQm0zL0J3b01idy9tU3RUREtQ?=
 =?utf-8?B?cVpYVTZqUUJ2R2pqWDdnZVYxR255bk9Ydk9RWXFCNENuZlhhL0JVb3lINXpk?=
 =?utf-8?B?V3EzUDZCaW1nTmJRa0RRRTNta1ltT0lvaVpGRmhIRnk1dEdTSmRHcG55bTVI?=
 =?utf-8?B?V1lZeDN0dWJkQ3pvZzBPY1AzWUlGRGFJbHRaQzZrbEp1QVVUR0dROWtlTmxS?=
 =?utf-8?B?aUtxU25IamIwdUlId3gvMUozSTBiQnFYL2ltUzJOZDdlMFRoZXQ0OHkwaEZu?=
 =?utf-8?B?TEwzalFvNlZaUm1neGdpbE5pVWhHS29mU1FqSjF1TEtYbFo1SHdlclp5V1Zv?=
 =?utf-8?B?MGg2eEhYYTJBNlZPcnFnaVBxUEQ1TS9NUTlLcDhramVFaW9hTjFKdlVHaUlV?=
 =?utf-8?B?amJ5cEJhTDN3MWUvRTV0dVRQWlIyVXFpTkplWVprVW9MTnNxVXFGaTd0a3F6?=
 =?utf-8?Q?iTjKk+1jADjCf8z6dtM4g+mp+?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebfdfea-6eb1-4928-3075-08dc3df9125f
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 16:18:34.5489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rx/bXvZ23tPItWItfATKnJflnpasW5lZAL+Km8NCGK+RTBN8De15+nqA7wUbyFNy5vum9yQ1ruc0BSppCUYxHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2545
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28236.000
X-TMASE-Result: 10--41.905900-4.000000
X-TMASE-MatchedRID: IDdx3MBO6ED5ETspAEX/niVDHvrOXL2jIyQ2IZ1g8ya3UJJ8+n/4Rdab
	QyTTNN0kmIzfJRxq9u2ix+tDlDEsd0/Dqb97uFLaO9AbTF0WkMIvnJK5AAeZkCgRAX0MQ/gdArd
	COU47qNkCPTRCBb4danHWwT8U4CQIU9EUELREeQ+6Nil0LL1WUsogIowo7lY9PtCfWUwJAdi7Pk
	YNEvS2M0qSwuYCRXYwyqccp4ob6FgRrwTHWaGyeHEayD3+TWEclZroRtOiCG0opiVY+XbpK+vAO
	CR+ibKnVBVSfA+2tktW05tTtat4tcz74oElhNRBVj1dhrWbzEBISqO7uCT8S/o3KCYqHuikvdUJ
	yWRl6YbWaHdXYb1A76ab1IdOxd6cvJeJrMjRU15sia8QaseTQvhwJOI9xff0GOakA6he6L4hkZM
	6y2jW3wkacOPVQeLrM7EKeMV9vIWJ7iAAzs+OL9F3EvIpSLuils6RilmnIsTqgUcPYeDFEPxpFd
	/BlOJwEE1L3X8paZnwRoSgQ5OrkmKHID1IcblycggXrdxvGwr+zyvVbQC1Udrm58Qo63ifC+iyf
	s1TRXY6bQZruhL3u0gMsEzNUf152mBJWq/nyFnU0ho7mxaK+EjdGsFzQI8FhFl/FiEnynZcRgSN
	UhN0V860u3mbccftpkwnga5smvlZrEqHzAW1zsVNAYApHGPk2j7jyCKpnCf6eDrkstFBca+eCSM
	eOiOkA/lH/MvdoiZkzeNs4Fp1DTnxJqun3snzJQhrLH5KSJ0=
X-TMASE-XGENCLOUD: 5816427f-8f6a-400d-b23b-1a79237e0edc-0-0-200-0
X-TM-Deliver-Signature: C9F2B29962CF2CC13BE2300DE7885523
X-TM-Addin-Auth: jupNo32+3e8EuvijGSIjP7iahVh0fEI+4/PVamuQnl/r1HZ7MAVRRL+gEcW
	MF4yn8uTgF7rC5vrscsJ8ZJXgJozPic0VDgSsCGJJ9WnXQFEg7hCVaGvkD56GtxdowxnobWtMQC
	dZjjdsrLZVUSmyiahkClr1GYZsVts2HwLpUpYkwkYLvah0q7DcyF2oTWS9BCjfLd7+ozP1liOyK
	0iTmoRC62iZvu/lOWDnOWPVZbyqg8FtUrtFlR1v77xGNnxQIiA0XRLOOifikXqgwPsBBcFfpWX8
	ay5B/IVUM4+s50A=.qLBn5isGt/FsbSTdCriTu1FrjPMfbbdqvn/3iI9MfIZtJmCYSxz2IEx9jW
	Y/O7etydzaMpW4hYjyUVhiJpWdWnih4AvyD3n23yC/8/4b6xDSHglUhoFsa6LSjlgIuT4UkRcM7
	xrEIwOlWqShOAZxfg2TV6mJOskC1B7plqG2xQX6amfpTQow70pw3HOuFr/a7pSFEC4hoDWe+UZR
	U8tjkZjXDcUmN1y8RjnGlZzmHFkY9qLZhfa7E/UPJjsNaaU4uqD2mKusKlBF1vZarXzFclXSZkU
	uXBUMieD/psRzRosTEVQN6fjy487J/WhWXkHF9ou+4bdQTXSb5JgqYMVkDQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1709741916;
	bh=qHF5xsjCl/t5lG9uA8G7tKDrCPk5ti9T2SQHsbLAsao=; l=7704;
	h=Date:From:To;
	b=QwRLGa4xiQ4s4w6UMjETZX4m+fB2dwKBJ0P2Wr0x7cGyvxNFH8S6W+aEGhpWJQvP+
	 eegmSNP1IKbwHIAF37R3vC5fXbrKsDl8ywsEXl5Js5nkJOJLQRIXJ8otF/7Cp4UseY
	 KcJ/rsL6LtwPJMjiUPPNz1B/piDT1t8AkrV7dLweygXtQoEAb4x0MWOUjTH5ZrXiM4
	 xLV3MtB92svCZLDWXMABMIs525WdXlolW0brjiWiSrgVa/5BSJPXBPi4dJWDjL8LSw
	 1Omo4fkG9KaN6ZY7iKb9OErAbwVk7/dFaHJH3F44MMDF7GCeNZFYqbRoF41iYYmFhG
	 WkzR2WCcnys9w==

Hello Haixu,

not really sure what you mean and where the problem are. But we will 
find out.

What I did in the device tree of some hardware board was

virtio_mmio@4b013000 {
         compatible = "virtio,mmio";
         reg = <0x0 0x4b013000 0x0 0x1000>;
         /* GIC_SPI = 0, IRQ_TYPE_LEVEL_HIGH = 4 */
         interrupts = <0 497 4>;
         spi,bus-num = <1234>;
     };

Simply added a line "spi,bus-num = <1234>;" in the device tree to 
configure the bus number.

(There is no device tree for my very small qemu setup to check 
next/latest, also no full udev, therefore I've to live there with the 
default bus-num which is 0.)

What I guess you mean is that the syntax of the device tree node should 
be changed having GPIO and I2C as template.

And as you need more parameters for the board info, not only this single 
line for the bus number. May this be somewhat for an enhancement in a 
subsequent version?

Why it's not easy to create the device node using the udev rule below in 
a full system with udev (vs. some minimal RAMDISK system) I don't 
understand. It's a single line, rest are comments.

# Bind spi-virtio device spiB.C to user mode SPI device /dev/spidevB.C
# Requires spi driver_override sysfs entry (Linux version 4.20+ and later)
#
# See also 
https://www.mail-archive.com/debian-arm@lists.debian.org/msg22090.html
# and Documentation/spi/spidev.rst
#
#ACTION=="add", SUBSYSTEM=="spi", ENV{MODALIAS}=="spi:spi-virtio", 
PROGRAM+="/bin/sh -c 'echo spidev > %S%p/driver_override && echo %k > 
%S%p/subsystem/drivers/spidev/bind"
ACTION=="add", SUBSYSTEM=="spi", ENV{MODALIAS}=="spi:spi-virtio", 
PROGRAM+="/bin/sh -c 'echo spidev > %S%p/driver_override && echo %k > 
%S/bus/spi/drivers/spidev/bind"

It may be helpful if you could provide a proposal how exactly the device 
tree entry should look. This would also show which information is needed 
in addition to the bus number.

What I guess is that you in the end it may look like this:

virtio_mmio@4b013000 {
         compatible = "virtio,mmio";
         reg = <0x0 0x4b013000 0x0 0x1000>;
         /* GIC_SPI = 0, IRQ_TYPE_LEVEL_HIGH = 4 */
         interrupts = <0 497 4>;

         spi {
             bus-num = <1234>; /* Is it like this? */
             /* More stuff here especially for the board_info I've 
currently no need for and no idea about that it may be needed by others 
*/ /* ??? More info needed */
         }
     };

Regards
Harald Mommer

On 06.03.24 08:48, Haixu Cui wrote:
> Hello Harald,
>
>     In current driver, spi_new_device is used to instantiate the 
> virtio SPI device, spidevX.Y is created manually, this way seems not 
> flexible enough. Besides it's not easy to set the spi_board_info 
> properly.
>
>     Viresh Kumar has standardized the device tree node format for 
> virtio-i2c and virtio-gpio:
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml 
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml 
>
>
>     In this way, the driver is unified, board customization only 
> depends on the device-tree node. It's easy to bring up spidev 
> automatically.
>
>     Look forward to your opinions. Thanks a lot.
>
> Haixu Cui
>
>
> On 3/6/2024 1:54 AM, Harald Mommer wrote:
>> Hello,
>>
>> looked again at my tinny setup and I've to add a small correction.
>>
>> It's not the way that I've no udev at all there. What is in place 
>> there is busybox mdev.
>>
>> Relevant part of /etc/init.d/rcS:
>>
>> #!/bin/sh
>> mount -t proc none /proc
>> mount -t sysfs none /sys
>> depmod
>> modprobe spi-virtio
>> mdev -s
>> mdev -d
>>
>> If I kill the "mdev -d" process my small script below does not make 
>> the /dev/spidev0.0 device node appear any more. Of course not, there 
>> must be some user mode process which does the job in the device 
>> directory.
>>
>> Regards
>> Harald Mommer
>>
>> On 05.03.24 11:57, Harald Mommer wrote:
>>> Hello,
>>>
>>> I took next/stable as base giving the exact tag/sha of the current 
>>> next/stable so that it's known what was used as base version even 
>>> when next/stable moves. The ordinary next tags are currently not of 
>>> best quality, gets better, therefore next/stable now. We were on 
>>> v6.8-rc7 yesterday with next/stable.
>>>
>>> VMM is qemu for the driver you have. But it's a specially modified 
>>> qemu which allows that we use our proprietary virtio SPI device as 
>>> backend.
>>>
>>> Proprietary virtio SPI device is started first, this is an own user 
>>> process in our architecture. Subsequently the special internal qemu 
>>> version is started. The virtio SPI driver is compiled as a module 
>>> and inserted manually by a startup script by "modprobe spi-virtio". 
>>> The driver goes live immediately.
>>>
>>> In this simple setup I do not have udev rules (no service supporting 
>>> udev => no rules) so no /dev/spidevX.Y automatically after the 
>>> driver went live. What I'm using to test the latest driver before 
>>> sending it to the mailing lists is really a naked kernel + a busybox 
>>> running in a ramdisk. The udev rule I've sent are used on some more 
>>> complete setup on real hardware.
>>>
>>> So without udev I have to bring this device up manually:
>>>
>>> In /etc/spidev-up.sh there is a script tp bring up /dev/spidev0.0 
>>> manually:
>>>
>>> #!/bin/sh
>>> SPIDEV=spi0.0
>>> echo spidev > /sys/bus/spi/devices/$SPIDEV/driver_override
>>> echo $SPIDEV > /sys/bus/spi/drivers/spidev/bind
>>>
>>> Afterwards there is /dev/spidev0.0.
>>>
>>> In linux/tools/spi there are spidev_test.c and spidev_fdx.c. Those 
>>> (somewhat hacked locally, and I mean "hacked" to be able to test 
>>> somewhat more) are used to play around with /dev/spidev0.0.
>>>
>>> I can do this on my Laptop which has no underlying SPI hardware 
>>> which could be used as a backend for the virtio SPI device. The 
>>> proprietary virtio SPI device has a test mode to support this. Using 
>>> this test mode the driver does not communicate with a real backend 
>>> SPI device but does an internal simulation. For example, if I do a 
>>> half duplex read it always gives back the sequence 01 02 03 ...
>>>
>>> For full duplex it gives back what has been read but with letter 
>>> case changed, in loopback mode it gives back exactly what was sent. 
>>> With this test mode I could develop a driver and parts of the device 
>>> (device - real backend communication to an actual SPI device) on a 
>>> board which had no user space /dev/spiX.Y available which could have 
>>> served as backend for the virtio SPI device on the host.
>>>
>>> Slightly different module version is tested on real hardware with 
>>> the virtio SPI device not in test mode. "Tested on hardware" means 
>>> that device + module work for our special use case (some hardware 
>>> device using 8 bit word size) and the project team for which device 
>>> and driver have been made did until now not complain.
>>>
>>> Regards
>>> Harald Mommer
>>>
>>> On 05.03.24 08:46, Haixu Cui wrote:
>>>> Hello Harald,
>>>>
>>>> Thank you for your detailed expatiation. To my knowledge, you took 
>>>> Vanilla as the front-end, and VMM is QEMU. Can you please explain 
>>>> further how do you test the SPI transfer without the Vanilla 
>>>> userspace interface? Thanks again.
>>>>
>>>> Haixu Cui
>>>
>>>
>

