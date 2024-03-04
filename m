Return-Path: <linux-kernel+bounces-90461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91FF86FF81
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49053B23C79
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B93717D;
	Mon,  4 Mar 2024 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="length tag value exceeds body size" (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="aBpfiSg3"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522A820B27
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549562; cv=fail; b=DJ60dQmzSFx3ii0G6xS/udRGygFjimerchWjzZMCaUPB1lFRA/njIEcGnaE1sRadZNfNwcb+3kZ9uh100n98AmgvPPYHVokrc8qzQIjtcligjo8HSjvJ0Xr3X/BPzfYpYj6/eOexUJTTtDtgyZ0/9Zvw1QeDxc0Pj6FJGkg7SaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549562; c=relaxed/simple;
	bh=2EJbK/5ygxVIU0MtZzoeJ+3PVvrZtbIeDJcxuItXh/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HKdPAk64m6svTEEkygVPujlMCeBCxXpZ3tzVlNPNlunM4RdBpRQcj1eh7p+FK3cV8QaGmMhI4dkO5ddXR2yXV9PPVl0W7Yoac/2mCpbftPnnhOvz0Jn3UzrzorqQcTKtQ5/CHFUK+lzjvUKz80qd8otAziy2nd3o9BPtaTVNEzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=aBpfiSg3; arc=fail smtp.client-ip=18.185.115.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.187.21])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 264EE10000D78;
	Mon,  4 Mar 2024 10:52:32 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1709549551.517000
X-TM-MAIL-UUID: c571b615-3d26-4be7-9446-8e5a1f9e6690
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 7E7AE10003818;
	Mon,  4 Mar 2024 10:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irN5RxNzNr+d0qTZQMnbu9Sav5v3gIbXQViwjKWUdFu/gcPb3gqVnhctttQa49oBWeqiHRrFk1ugaDfHpY/Bo0GJh5M0Uj1GM42N2teS9xnu7fG7hZf/JrRAf0yUJ3M1pq9rbv21ymOojqm8F/ueicTuXo6tMN4kIb4FYpMBxnkFeWQT56RfOcTnnhckYG9tq6R7AaFNtLgqisGfbTemBpbIEuIpzLcmw7ygEZaZIhZrZl49KKveNIb33pZZVX2aLOlLGMqr21B2YX7EfBE0lj8SOi8e5URRxRgcqcNOLqNHQKL90mFM/wLN/kXuPfGzvhqRhy0kvG8JeO06+DvJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y13xfgudq5RtE1JGriLFnoB+HoYinTnjtwqy4s3kbuE=;
 b=IF6ChjZzV/s+In3j8/UoM7hsbu1P3oumdFq4FzwkDzjFegw1ZkHqiiKOUm4JMRdr4+Z/9zL9ANo/92ipTqTrbNWB9upYIbpr6dXI2GA1xXpmTD/6qs4dmD77D9CjveJDxj6M1pqADehW/m+ta9KgFiQhrxU2r81fDC4QCzWoMK318y5RC8gsB96noQ/e21g7WSKW30dNd/9Tm03NOOGXueCyrPAw1IxonCSsYGwJIvy7FElVaWTxz/h9UaXPP+LjK341sp3vJ976LaKw0Q80xKe1+mT+oufflAnLivTXtazIYGhQ8R4J1pyBJTRu85RbwdhSjayoEt86ViVnjtyIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <2a911f96-eed9-4adc-9043-27fd1d3a7ca2@opensynergy.com>
Date: Mon, 4 Mar 2024 11:52:28 +0100
Subject: Re: [virtio-dev] Re: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver.
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
 Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@kernel.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
 <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
 <e2e5a7a0-7a2b-40d3-acf7-6f0b91bd5d40@quicinc.com>
Content-Language: en-US
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <e2e5a7a0-7a2b-40d3-acf7-6f0b91bd5d40@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::8) To BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:2a::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2581:EE_|BE1P281MB2961:EE_
X-MS-Office365-Filtering-Correlation-Id: d139178f-a587-4d97-4795-08dc3c39301e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xYfxHmEijm8ZhXMXNCcAgNAyo9EbVQ1IgfS4Gc3Kjcx1CfT40xEHgVlyAGVnC+edEfHdtWGO0Gbyg5aYW2V7EOucK3fzzxXj8j7y3KvfQyeiQWt+wEgt4O5GtJAXtGxw2B+1g/7gwCsntY2jpKQDfy/aqddkfYOydyUAS9+A/QLDzSVbaNg0dHzVkN2FEqX52eRuLo4jnDNHtCinPG2ZoliF6SFlly6MfW0NVt6w4nMoEG+AiRSXUmk7JCYybrluFlJzOkCxwaP3v8bBzMPmWPJPaksa9+/GGfKcwx9MCz8AvGNGkLx9YkRvAKKYiQFNlxeCuCkdTt9FTiL4sijp0fLaRD8mTlX1FeYjnLjpjI+pPexHVa/OFILXzh4IFyZllD/fiCqpSnbN2zL7VlX1gKQV4QOKp4UW6M+cBPcz9LUMvLOJB/FAedW29vGbZ0pc+k7NarOkkw3O681Tnv1HmThT9dTP46A6fugxvXTrzZlgrVKoD/XN7MW45UNK3001zOjBx4+oL4Rxv4w2ClBHUV/N14TjKa4+03dpMcHpPS2D+t2JdHrkMPLMQUCH5daiL2LjTXrwXtakfWkquornYI6OVyypZKudWScFJXPmuMg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHFidkh0b01OM3BtQ3JKTEI4ZThzVkY1U0JNU1pocmlNNGFzYU9SRWtOc0dy?=
 =?utf-8?B?NU1Oa3pjZGNkdHVqWjBCTkNSc2loYVhMT05QMDRab2YrTFlhbDVrZ0dkSm50?=
 =?utf-8?B?UkpFL3FCSzUxdGVvd20rRW84c2txUG1uTjd1NWVwTFo3NlU2SnNxZXpGaUxi?=
 =?utf-8?B?Qk95TjA2WG8rbXo3RTRlQU5OSUh1OFlVTGZPTFYyUFJSalZJaGJGVVNtMzY3?=
 =?utf-8?B?MDlwcm9QRStHVzNONFFEaWhFTWdRZXVNUHVQWVlqUE52VmtiRUl4dW8wZzlK?=
 =?utf-8?B?RUZ4amhJZThtS21nbFN4SkExRWpzYW1CdVk2eWU4KzhNVEhRVGdnRWQ0d0hG?=
 =?utf-8?B?VjlKcUJBd24zUmNCYnVvdnM0cy9QRlRaSnpZL21hUEFpSkVMTHZ4ODlOV2VO?=
 =?utf-8?B?NlNvNldabUxkTXlkWjFUclJqSVpJUFk4ajZkV01QUk1mSHpIbzF5MUt2ejM5?=
 =?utf-8?B?VXNzVWVvVHB0cFR4aTdVclY5dlBwVFdPUmtZdmRSTnlLT1ZhbUM4VTM2b0tI?=
 =?utf-8?B?Z0hiQ0xVbEpTMmhzRlRnME9iVVhoOHpjc3NSdEJOL2djcjl4Wnljb1lIalBG?=
 =?utf-8?B?aE5vRVNwZVhQTVdlTmFnMFMraWFWbDUxQ2c3VXpFWUM4M0NHaW9leGNKenU3?=
 =?utf-8?B?bHZZYW9GWmpFZjhldnNLZGlremN1UXZRNVdvY1NQcGRGcUZaVlBYQi94Q0Z6?=
 =?utf-8?B?d0l1Y09ucDQxWmJtZ3Z2SW80b2djb3BRZUJCMDhvWXQrYk9taDl3cnZmZnAw?=
 =?utf-8?B?T1BvM0o5UDY3MlZtRVV4SXp1TitZWE5WRU1QbVVtc2tEWjRNcGJua2RyYkRw?=
 =?utf-8?B?eDhSVDN2dlVVN254VlpHTk1sc2UyUUx6SlBtbnZwQ29FcEd1RFl0Y3NuWXNo?=
 =?utf-8?B?Nkt6a3dLLy9mM0JZU2tDY0dkOTBSQnd4SHV2T1Jya21FZHgzdWhHdXZqdnJY?=
 =?utf-8?B?VFE1SkxoVlBEN2dnc2xhd3dtU0NSazlibVh3Rndpdk02L0FZWWVEbGhLamJI?=
 =?utf-8?B?ZkZuQ2oxdmFmVld6L0hGZEg5YU9TNG0xd3RsOHh3VSs2NEtmTGtmVGgyd1JX?=
 =?utf-8?B?Yk8yY051b1dEczY3SDNLc25QWGd4S081SFFKN2t1dnVmdGhOb2ZvblpHbTV4?=
 =?utf-8?B?SXdoNHplZGExK09yRFRqMGJyS3E4MWs5MjdDMzRjaGNJbnZpd3NpZ0NpaXBX?=
 =?utf-8?B?dDhjU3NyL2FVM0UzUGl0Z3dMQ3huVWhUd0htVENnWk5VTlNRci9WMnh0RXRL?=
 =?utf-8?B?bUMvUURYTzBSeU9sZmNVcFZIdVZmUitNR2MvcGtzNzlmbmxiVTFFS0M2YzdC?=
 =?utf-8?B?TDdGLzMveVk5OWxIbER1U3o1dUJOZVE0eTVTTHB6bFZaM3pwdWkvekVlaXRD?=
 =?utf-8?B?cWZkY0d1UEdKb2poRUZ6K2wyNFU3dE9mbGdwNlMwRlVjeGpmZ0FBUXVOa0pO?=
 =?utf-8?B?bVFlVFAwRWhoTXhmZEN4amREb0JFSUR2Sk9xZmVRajEzQy95alFBb3FESGo3?=
 =?utf-8?B?WVUxQm1zU09tNW1xTEdreDlvd0tWRWkyVGJMMDRkR2F1aFY1R2NhS1h4bG1O?=
 =?utf-8?B?MzhIRFcyYjNPQUFraVpGQU5jdDN0WC9HbVB2ZkY3Y3ZJdldvZDhiOUxQQlA2?=
 =?utf-8?B?ZUFBbEtiN2pEblYyTU5ZbTk1cUV3Vkl4TzFORmJXNFZQNjNjL1hubEVsd0dF?=
 =?utf-8?B?cWJZVHdzbVlqcTVqczFyUy8xWHo5ZDJ0eDFsMVB0TEMzV0I1M0ZTR2xVd2hV?=
 =?utf-8?B?WlRwaU1Ja3FnRThYOWFnUXZ3WGNMWXVLb0JITFdnS1U2VklpOU95elpYMnpB?=
 =?utf-8?B?dkQ1cm85ck1PZ1pwVHJpMXBVN3pLd3Avc21pWU5BNDk3aVc4cGk1K3VQYnVY?=
 =?utf-8?B?WVl2UzQyVjRCMHFaR0JYYVFEdmV1RjVvVjRlL0xjazNGb3d4TlkxaXVFQkg1?=
 =?utf-8?B?ejZ3L1hPM1hPY2tDdWR6UVh6N25ZbDZCNkZUNEZZNUluci91Tm9qblRvZStO?=
 =?utf-8?B?ajJHWmVGV2FoaC9DWm1KUWt1VE5YR2dJM0dkekZISGJEbGhYRGtsd2t5Q1Fl?=
 =?utf-8?B?SWlaalByeUcvVkJtMU45dW05TGFXYjJhUkRNZTdtZFFjRk14OXpVcDl2cGto?=
 =?utf-8?Q?N/MxTfu/bT8aJCjoGpTCpBf0K?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d139178f-a587-4d97-4795-08dc3c39301e
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 10:52:29.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZnghOUWTYpHdvA4xD6L+ieSsZuL7E9Nw3hW6TCevIRtxrtIG2GGX5h8ssXWccDg7PpzOSGK/nO5y7382yXFbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2961
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28230.007
X-TMASE-Result: 10--11.003600-4.000000
X-TMASE-MatchedRID: +f/wAVSGjuj5ETspAEX/nqa5LaHlPm0+lIhi5GPAGePz2Yw1u2rzYale
	AY/HO21x6XFkdlUCIyAcekl4M+Meg9UjXOu8+oRG0RneM2u5ms8HgEx+rhLN4kEwlAH/PleeFOW
	EvH47XvNKksLmAkV2MDYtE/masocfd5ZQIOSj8/NFg2HO5lmNEFpMWq1GqY9jK8Ly83vNygKdIg
	JJy+kP2f68Ru4w4JZQmbbXKzEIQAWt7/EsM7+op0gfObGUdKnY+HAk4j3F9/QB6AbJ4VK4Izftu
	lYyST+Q58O6RQImIFLKeq/WFUOWj4n8kUCxEWNKQj0AQ98QP92q8lf9o0av1xIIN3MAx5f95aA6
	lI7RRJqX9+pFwEzDVL/a0nd+hIFCI/NGWt0UYPAoAmkXCg2OrNCP/+P/USJwW8+9+e0PTy/nufk
	z7SpAiVBvRbisWRPR
X-TMASE-XGENCLOUD: 4df6127e-d3e0-4011-8791-e500fb1c28cd-0-0-200-0
X-TM-Deliver-Signature: D38747910904335B18AC42CC3972862B
X-TM-Addin-Auth: tVhjPLCPYZ05y9/lTU4lyeke1jMH4emRhhCDkcELo3xE6hjYfU6z52sXPr4
	BPFbTOWUbAJDBe+681rjnbI5Uj5BIjy5HDVaL33IVXLbEtb0UYYOvjiOnPcAHZmOApjumN5EmyI
	OUG+Ktfh3iYtJ2wTcl1zbScYAem0a7UkvnbG/YJ1L9ijHU6h560QoBVbkdJ3fQr79zO5yIiWrBL
	ARCDt6JlvdOS6sJ5t7RtOzrKjagy3APTEUvawKWk31g6XOUqIJ9aO1CRlPKlmR0vNW6+YOpUl3m
	cBREwwHFWMU9fsA=.0bZi6aLUzP44CAP80YmNbndFKIDA3IYdq64Dcz6RhKhun5zrhPkNxeuCWC
	dmaEN4hIx0l2g2RQDhDwJ7IjcISm9qVJAVgtpIlJMfIl/Y98iEGXFVCL6iOBa1xcaeBFRwHUkxt
	gMtMCpfbhojKgKqLdizpWGUbsNIoFuvHCUZv+cIZI6KLcfsuKk3LifNQ5FpfYBVLq+yW0YuX67X
	5Eu4owBxiSpRNMAobYtiDiDTA3g+5ofpqoGH0mMyyJyHrrqottGTjuaCjRQaQ2DwYs6NgjmMslw
	qZEDa8MsGLijwj42VzSi08hLzph7S1OOBZuHp4I4rRN5H+Kv09eE9o4WtoQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1709549552;
	bh=2EJbK/5ygxVIU0MtZzoeJ+3PVvrZtbIeDJcxuItXh/Y=; l=1548;
	h=Date:To:From;
	b=aBpfiSg3T8yseRpmsLVZBrdASpL3BVURZcoMFNZ9fBTWfef2BUF9Y+0Bq3TZGiZ15
	 ucCA0U+BwrcklQ96BS77XCm+zXPyvo9rK/9iToOuOIj7ClZhfJpuJYBiFsvUf9FfDm
	 KZLvRdN9NulJMnSAd3CxSQ/0bZXCvtB2j9CkVjBMUCC/bHX4o6LmQ+b2I1DOP2bsFG
	 ggsZ9ix3bWkHA47ryf924WZcmrt3lAUYZ3eFskkLDs1APBVNGQTJOO4R+nXyhvhlrR
	 WkQIL6Dtm7CmPec9DxR+PI91y9fWOV/YzRiC0WJeNQZ/Yu0ZCZ5qgyj6vIbv06B9mX
	 54+mrbqPVcYCw==

Hello Haixu,

no, I've not touched spidev.c. Nowhere. I took Vanilla next/stable and 
applied the patches I sent.

Run the driver as a (somewhat different but comparable) module on 6.5 on 
hardware over virtio-MMIO. Probes and goes live.

Tested on next/stable using a specially adapted QEMU version which 
allows the usage of our proprietary virtio SPI device over PCI in qemu. 
Probes and goes live.

There may be other patches in the setup we're using I'm not aware of but 
not this one.

Only in case you're using some locally developed virtio SPI device on 
qemu which uses PCI transport:

SPI has ID 45. Means 0x2d.

https://www.qemu.org/docs/master/specs/pci-ids.html

1af4:1040 to 1af4:10ef

    ID range for modern virtio devices. The PCI device ID is calculated
    from the virtio device ID by adding the 0x1040 offset. ...

lspci on qemu:

/ # lspci
..
00:03.0 Class 00ff: 1af4:106d
..

/ #

You see something like this?

Regards
Harald

On 04.03.24 08:11, Haixu Cui wrote:
>
>
> On 2/13/2024 9:53 PM, Harald Mommer wrote:
>> +static struct spi_board_info board_info = {
>> +    .modalias = "spi-virtio",
>> +};
>
> Hi Harald,
>     Do you add "spi-virtio" in spidev_spi_ids in spidev.c when you 
> doing the tests, to probe spidev driver?
>
> Thanks
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

