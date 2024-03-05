Return-Path: <linux-kernel+bounces-92195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9D5871C91
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405B9B25EC6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4830E5A10B;
	Tue,  5 Mar 2024 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="P0eZB7EL"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6A1DDF4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636286; cv=fail; b=Fyn9heG7+Zh1OiKdjsVMDRTrPuyRirqTwq6sc6b1sYMsLn+71HVKxP/EFfhmnoipS4YeQSeLEHTRhLvX8WYtAor2CP1ey12JS43KAyUh56dmlUJrXvK3fxc4dkfk9DmzUIfXOUmk2KQHxS1JNn+2JkMCHedzBcfLt0Kv4VvEJdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636286; c=relaxed/simple;
	bh=T6hp2poH8fAcnb082OagmWBhmv8yuCf5Q5pcfRBfuAQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DxN/u9meBsbpq2agY4LRNYrdMIjDMd7TXWv6S0TPOykUvbx9CxcALol/NU/zhmgYZdgE7LMssP4W+97X64TlYXI2emEEV/aJ1yfut1MDMovoyanohM/ZEXVJug7J0cQHb6vk/uuSQoULcYPjUyzsKykbah1cM0y1tIqygI0rUD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=P0eZB7EL; arc=fail smtp.client-ip=18.185.115.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.192.213])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 90F3C10001152;
	Tue,  5 Mar 2024 10:57:56 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1709636266.687000
X-TM-MAIL-UUID: 10f976b5-faee-465e-9c9b-47cef8003301
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id A7F8810000E35;
	Tue,  5 Mar 2024 10:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbNBglJrhummwBlyzp4gC/aiaviAbA7cVYVpKsoYDyZaMYd4uGoMKBq1TaSZPOyDq9x94cbredzz8fWw9DsjVjYmHBbY0e66u60r4baMoM/Swnh7+KQR7Z/ncHzE9P07xP6dC9mTtVImRvzt4Gcf7rmFf6ECBIbQBxzPLf/qS9mzdJ5EoLLykZvv/AGIB98+gZlNWi/mzHb4dxEtqSpRQvlC82i/t2TH8zJb9tIGpgd6Z3tfNAFoA2lTztyopMvTllcSWu99/GMWJrrR2GScXbQF4900dkQqHr9QaDjwwRi4Z+//x/SwUIpGVCgukdyrJ6a7AfWNvV4IdAO1MQQwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNVhq801vACmJl+OdkblwaDIJ0RNkA+XDHnkvOPRxV8=;
 b=GNmRZuULlc9Lk0SG9fq4ipQlMBtpAOz4YdaxIWdfLk8IynkQYnWfgN7/3BfsMBqbaVWXEbgUK6qiK2q+XDNaNWXQSGuLfcahVrvuJu53soGetAXv+iBr6r5YMsp6a4gkOR8Yr42osNLaQAqSo9wxySBzvkxhBdwrbKhEhUU3ZoCU3nd3A3nRMp7jD534Psy/vnZmini/fQzC2VEV+UbBxZlcDBgKD+4qX4RZJ8rnd62+29MGPiP0JUxKSFrdyOo/2Ghx3WyIBIf/jZGW+NeVHTzAvWwIoh9+Lrw7vWRYexEYCoytBPPoFWJ2b8Yeg0399uR0snD2lwIC6QGRoyo7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <7bfbf09f-67d1-43d0-8ecd-aedf3b9e2287@opensynergy.com>
Date: Tue, 5 Mar 2024 11:57:43 +0100
Subject: Re: [virtio-dev] Re: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver.
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
Content-Language: en-US
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <c7c939c9-50e0-4d86-bd44-d8b4b90ca14d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0372.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::18) To BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:2a::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2581:EE_|BEZP281MB2567:EE_
X-MS-Office365-Filtering-Correlation-Id: aea55d5e-32fe-4b51-fd9c-08dc3d03165d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	luuWangsyODCr43CQIlnsxSHJR5wX613aNoT/gkne1Dk5yDXjOwBeu5ALcZ1AsGN2xf5h32q3ggmk71lKtXwlZg0S5cmgtxFWdVGk9950F5UD+i3MZfEfl1NIxrJuM2Wh4JXfGYvqWIo8s3x2FIS03wnUN2ceL4seJhQQYumjSX3ad36MARHLl1MrcFjL0Ubz2PvLMrTxS7gz8Q2vbilS5GFdTLECb6BYGffYqjvGQeGaChgXlin8JsLktrNatNuOhzEXDLU08l+ENOj7yb0A59CZxpQBMf4YmEzvzHOv93RFIk5te9ZqmdCOD2hpcK4d2aBvSWEdpuZZa0gG0jhp2zDwuj/glinTMnYhCN2PukoKWB4QhUAWdN9eonoRxPRL6XZwe/cNIMOYYFm2jdLZGJ+n1sNDSnK3ngpM1oi65gh2OsW4gp0Q46k/XFm+aX6CggEZv7mp2Jp3hN+bQddEjGNBy++/2taoXko+4hw3T4g72zeqrYHq8XMdUYSMVqgrv0gtwWqHbdL6fi2k+Z6ZLWMjm3rjcNFM1A8ZdxTgdELs5EuHKeMuzQc0YhLO33M5i9epePk4kKAhKm6PQhagTiIQRVUcJdNNyMvhDN28DeRa/BLg0ySvsIR1Jd9Clrb+IKywpalMBtYvAZaEToYOjnWx7cMnPbsIxjyHhYE3bk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1VHem1TNkhxY3Z2Vmdzd1VmVGQ3Q2Y2VXlWZGNxQkFwV3VtUmtkcDQrOUsy?=
 =?utf-8?B?blBVeHVLWnBOT3hiZWhHZ1FadWovZUgrR1ltN1NKTHo0ejdzQkQya2dnZysy?=
 =?utf-8?B?S2xRaWdBWTVWUjFDUkhiNmpOVFpZejAzdFVEdU9nU1RlM1NIT09vMWh4d1dw?=
 =?utf-8?B?cHZqTnMwdEpLMlpjRnhpbHY3N1dEYzBWMENudTQycmc5RXJleHVRWEtqblBB?=
 =?utf-8?B?RVozdEJqeTYrOVF4d3l4WUNEU3I2NkpuamNTT3lJeGdxZkNjRXlYenVsZ3U3?=
 =?utf-8?B?eEFtMWdZVUd4aEFFVUllOEZOd0ZJa3A4aWZ2cTFXaTBzNFp1QnEzeDdSNG9E?=
 =?utf-8?B?UTY5TmJ4Y0ZuZlJkZ09YeUJQbXVFek04Y2Q1Tk9ML1VsWU5rbHR0OHN1WS9Q?=
 =?utf-8?B?b29obXRjdHlIcVArOTg1c3oyaXdGYlM3UVFJMVg1NmJjTk1hSktQQ1BTUmV4?=
 =?utf-8?B?TXhoVTBEN3hSeHRqYnZ6c3JBUnZUUXVJNXBQa0x4VE51ZVNlMWkzVW9WRUkz?=
 =?utf-8?B?alRJM2lzREJBdUN0N0J5MGttYUtFNFZKNDNxLzRPRFVnR3B1ZS85TVZUMDhE?=
 =?utf-8?B?a2dZdlNkTExYM1IvUnU5MDNLVEJqeDIxUW00N0g4OXJPektnd2JaazlDeTNv?=
 =?utf-8?B?Z1ZXekhFaW8xdGQ3bUthTGU2c0l6OXNBdnRSYVFzd2FtSFFmTGp5TUlQRXh6?=
 =?utf-8?B?MjR3MkRNVFNsOUROOE1pTFV1TGFxb05WeEtRNjV3OXI5c0owTldqMkVBcXZH?=
 =?utf-8?B?RTU4RE5zSWkrRng5UGRKWHdGZHQwNktQNHY3TUVOZmFzL0RDTVNXcnFOWFBP?=
 =?utf-8?B?ZVBkc0VYakVwRzJya0tKTE9KWUltak5XdE41UTZpSk1jakNlTndXRHdSemxh?=
 =?utf-8?B?SDV5cmZNYW02RnZxUzd5UkdpZTdEMWxpWTRmSkRQNEtTemxkdHFIUE9XOEti?=
 =?utf-8?B?cE1YM0VxQ1B3MVp2UnBFUlcvMGF6dGpKRGx0RTlwUWMwazBScDlEZXVsQ0tK?=
 =?utf-8?B?bFMyaFN0dWFxeEVqL2Yzb0tsM3ZocUFDd20zNUI5VHB4NFNnYU1tNTNuaWVR?=
 =?utf-8?B?ZTB1Ym1BT3pDU0J4QTVzWnpyeXFuM2VvZnRDVlo1d2xodVJQRU5YQUNubkRR?=
 =?utf-8?B?bGI1TDA5NkNWVnVPdmhhOUs1K3oxS2FISzlBYWtTNlZmenAvQ2d1amMzeUd6?=
 =?utf-8?B?ck5Dam1sczE2Z2RqQmtTcjdzajRzdWp1YTUyVU1DWWNCNU5WQVJFVkdlZVZC?=
 =?utf-8?B?eTZOZUlYQlA1NWhaSmlkNTJHVHVNWnBvZ0VHMTJaYXB1L2ZXSzYrNlFxd05Z?=
 =?utf-8?B?cmtxV2NMVlNYSjE3U0ZsZVRycDZ0T1Y2VjkwLytMYkdCL3NrdVJTQUpTeEY1?=
 =?utf-8?B?cDJvN0pxWTYwcjZVa2N0MXZyTnBWMUlZcVlCT3RXMnlqZFhOaEkwRVdrMlh2?=
 =?utf-8?B?MEcvTEFKVmZFM0Jlc1VoVkx4aXZGeWZ1KzBxVjJRajZLUm1pbkFSQUx6VVNy?=
 =?utf-8?B?VjNrWC9DTXEveVZJMGNTZDhUc1g0eGxybmJiZmtzUFBEWFQzVXlSQXVSWlI4?=
 =?utf-8?B?T1dSK2x2emYvVWZXeXJieWtOUHRCMFYrbm5OR29Sa3ViWFkrWHcxUXdnSkcv?=
 =?utf-8?B?NnR3WXJSZXFoLzRDTVBvQVV5RFJSN3VreUp6amk2bGRkNGR6c3dyUGZTTitW?=
 =?utf-8?B?WWRQYWhlaTA4dDdpbk9SaTgxYUFHWVBValZ6NWF1VE01REptU0QzcmtDOTht?=
 =?utf-8?B?Zm9LY2hXbkNxMDBUcWtSRDNXTVBvQTkrdDBlVFRWMGFmbERTQXVIOG1La3FC?=
 =?utf-8?B?Y1lVWEZ6bUo5T2kvZFY2LytDaHRKWXBxRzhCTktkZUpBeWtSQUQvWTVvMjd1?=
 =?utf-8?B?WlhRRWZYampjOHU5dWlaN3h3Z1U4RW1jcEx0R3dwNk1kZnY0aUhWWUMxMkJj?=
 =?utf-8?B?V2dKelZRNDB0OWZWajZQT0N1SFdSTXJ4aWlXWTM2WDBTa2VFY28xMlJDWldi?=
 =?utf-8?B?TFNDVVN5QUdnbEFwSXdoSXNXWDUrZnNSajVXb2ttMTJTOGFSUldBalpESjNQ?=
 =?utf-8?B?aUFjTkFlcVNIKzZFNTBpUndseGNRTUJPUTh4dWxJMzViV2Q5clMyZXlLR2ti?=
 =?utf-8?Q?+Lol/qtXLm2+osarmMhkGbAPD?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea55d5e-32fe-4b51-fd9c-08dc3d03165d
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 10:57:45.0800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvE5W5e+HKL1r07NbxfXXgJpTTX9sauoCr7Fh0zVqpG7IzDZuQKAJ7ro/Ocs0SlrYLWNlItjP8bYSDaH2yTBag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2567
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28232.006
X-TMASE-Result: 10--26.362500-4.000000
X-TMASE-MatchedRID: 0dFPYP4mu5T5ETspAEX/nuT5AnjO7TXt64sq6ekYKa0iAtbX5e9GpInl
	unnAL62Qt+9V+AzQYjOhAPOGjhG7BvE7RqIGj/oUgeiGYvM7ol64qAaN6svaSAVfUmpo2uI4NlH
	NCjMfVpFVrx+6i2Ls7gYC5Nk3Edxoz1Z785+sazCK7q7iyFn58aCfX1AcCU7MMivUq/W3smu2rF
	0xZKBGAH5PgW0EWqy+SGHWXiY57CbIRZiBdjEnm/gxOc6+WoXcD7q0B2/DERxbdygp1GRK2UgOA
	/g0IlH0E6+b2Qm9X6xuLgmZi5w3emsOdyTtXGn1bAQSvnY/AMUrGV73AsU0Z8+b4dvynxi2f/Ju
	iJSM2N9sNy51GTv33+IIoRYumX2/xoRD2AtwHpFsia8QaseTQgoSarYdbAHqWRHHmQjFTMnTIFW
	tewtG/N9cNTZyIRQyldYeoo7G9XitAMlP4gRdFsTvQx6Ny2Cr+sMesHlgpMsEl63CRh3WtnGDuy
	8y1qkuA/3R8k/14e0=
X-TMASE-XGENCLOUD: 55d99290-6052-48e6-abbf-639897d38575-0-0-200-0
X-TM-Deliver-Signature: 179B4D5EF9D289FF1F82008996B385F4
X-TM-Addin-Auth: 4htyWauoXcCbYI+kxRK4UDBD1ljf9RXoQ1GAVpUeK0bCjBH9IJkcqNqGMyE
	PiV4YdkJ4TC0y0fb85wPs+GcqKWqHd9sV2PTrvS74XZT5hMGPmjkUqd75wIEucGR+aTAoqToed3
	V1MtADmCr70H1oxALtGGGwAv4qi1XAcuDTcCGezStYVIBjQMb429LLj8gVHdJQLrohuBl2gETnq
	XH5VRhfiqu9U3HCtqiBIoJLB6YidRUEsjX9NOWT37TZ/CTEnj8KeIXiGuURKf830HF1nb9vgIN6
	ABwaHdqqo5kD7JY=.yNqbUX3sdS9gytbv3qMRtkSNl6lRfs1Y2XiqbpOM53P6zye4s4vDx9s1vZ
	oRADNjBvDZukLiBTCvDz+2tdjmsFsMo832ocIF4ttEiL2O6Ga3q/TCcaZijuqI6sCPiecSkcwfO
	6bhuyg+JswiYiTtLYmNtawP/cgQokQyJD8X0tHmm40vEPnEYrjJ4d0mGdIs/CDhJkqB7auOUCjb
	pEjyYLRHX0ET0hLURNRCn3t8kV5DGMg6FFSmIdW7Z1RXrdDc5PdNJGI7uSyT4+WfsNBj9NYW6vH
	CUzJcnJpovI+xvbenv/Rfw68Rdb1EIznpkqPRAIGL5CWICqBKiadP82/IUA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1709636276;
	bh=T6hp2poH8fAcnb082OagmWBhmv8yuCf5Q5pcfRBfuAQ=; l=3173;
	h=Date:To:From;
	b=P0eZB7ELk+S9akQPIO3A1+RoFTyQQbJircmsSiFuWQTz8GYifwAb6v5O+7QDdCrun
	 6VhPGS5wZ//mrcgGHiJ6TImxDKKKkXm26gRCaAs/R6zdMrSXRse37HnWPEiBChsKhM
	 g38x979FMOxZ+VBjOvLn6Wh2TxVJhhk4gI86XCM3nm5KKASYaPLLPf2GY7JhYh5QO/
	 jpAzKiNqQvr/jJEVUCrZd+SwLjcnNyAmmXtMr8RPs9y9BXTPqcphrqkAQ4EsKvvCJ/
	 IkyXUD2rAFN6UHsb0i2Zg6iG9uyycLKVU4r0674DBo/RSF2cgSHbfzgTKWK8wYpnGr
	 EFrIVL+CWHHvA==

Hello,

I took next/stable as base giving the exact tag/sha of the current 
next/stable so that it's known what was used as base version even when 
next/stable moves. The ordinary next tags are currently not of best 
quality, gets better, therefore next/stable now. We were on v6.8-rc7 
yesterday with next/stable.

VMM is qemu for the driver you have. But it's a specially modified qemu 
which allows that we use our proprietary virtio SPI device as backend.

Proprietary virtio SPI device is started first, this is an own user 
process in our architecture. Subsequently the special internal qemu 
version is started. The virtio SPI driver is compiled as a module and 
inserted manually by a startup script by "modprobe spi-virtio". The 
driver goes live immediately.

In this simple setup I do not have udev rules (no service supporting 
udev => no rules) so no /dev/spidevX.Y automatically after the driver 
went live. What I'm using to test the latest driver before sending it to 
the mailing lists is really a naked kernel + a busybox running in a 
ramdisk. The udev rule I've sent are used on some more complete setup on 
real hardware.

So without udev I have to bring this device up manually:

In /etc/spidev-up.sh there is a script tp bring up /dev/spidev0.0 manually:

#!/bin/sh
SPIDEV=spi0.0
echo spidev > /sys/bus/spi/devices/$SPIDEV/driver_override
echo $SPIDEV > /sys/bus/spi/drivers/spidev/bind

Afterwards there is /dev/spidev0.0.

In linux/tools/spi there are spidev_test.c and spidev_fdx.c. Those 
(somewhat hacked locally, and I mean "hacked" to be able to test 
somewhat more) are used to play around with /dev/spidev0.0.

I can do this on my Laptop which has no underlying SPI hardware which 
could be used as a backend for the virtio SPI device. The proprietary 
virtio SPI device has a test mode to support this. Using this test mode 
the driver does not communicate with a real backend SPI device but does 
an internal simulation. For example, if I do a half duplex read it 
always gives back the sequence 01 02 03 ...

For full duplex it gives back what has been read but with letter case 
changed, in loopback mode it gives back exactly what was sent. With this 
test mode I could develop a driver and parts of the device (device - 
real backend communication to an actual SPI device) on a board which had 
no user space /dev/spiX.Y available which could have served as backend 
for the virtio SPI device on the host.

Slightly different module version is tested on real hardware with the 
virtio SPI device not in test mode. "Tested on hardware" means that 
device + module work for our special use case (some hardware device 
using 8 bit word size) and the project team for which device and driver 
have been made did until now not complain.

Regards
Harald Mommer

On 05.03.24 08:46, Haixu Cui wrote:
> Hello Harald,
>
> Thank you for your detailed expatiation. To my knowledge, you took 
> Vanilla as the front-end, and VMM is QEMU. Can you please explain 
> further how do you test the SPI transfer without the Vanilla userspace 
> interface? Thanks again.
>
> Haixu Cui


