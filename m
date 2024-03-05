Return-Path: <linux-kernel+bounces-92793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A67F987260C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E41C1F21B2D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE94175A9;
	Tue,  5 Mar 2024 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="PjmoWnce"
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271514F64;
	Tue,  5 Mar 2024 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661274; cv=fail; b=AoVVQD4JuWZUpW9xwl4u7d5rOH0roFm5o9E9/Ku+q6UAZgswSCrepEm0auSFZsn141QdlXM71EF/IrgO5qld1x3/RyVE6wLtG91NGWpVbE1d6+CHrqKWmfAx9IfI8WIFIsgdaZjkjA7iNZWhvUgYOmfKoLF4b02COpNlDuAAp8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661274; c=relaxed/simple;
	bh=BR7EFOfW8jAA6R1S+fPdTThKyEmlwFd4ibYYREoeNRQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=arsEvEZZDWnWIER1LOBQPxAQBSOwl4d1U/ZlgsBvvXMRKVOz10GlOFB5R3KcejGa8EtGnDUFmmYT6M0JLSO4bQ+lwCdf/9F6WsOERL0pmH68huzCRaul2Y1+PANruRUQxtrHP6jwH1bhwThcd7XqxbEnBksQfaZtIqjE8/VoJtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=PjmoWnce; arc=fail smtp.client-ip=18.185.115.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.10.134])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 69D741015E893;
	Tue,  5 Mar 2024 17:54:23 +0000 (UTC)
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.187.21])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 5EEDB10000478;
	Tue,  5 Mar 2024 17:54:16 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1709661249.673000
X-TM-MAIL-UUID: a191d486-2280-478b-ac1e-6a2795debcb6
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id A46B110000316;
	Tue,  5 Mar 2024 17:54:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imlV2EyxKHSMtxYy3vM2PiZxTJ9iDBSTI6z9wV+WPEWEdPmyszih3dagY180DhdkllTIkKuD7XX+iwOWLezaw1QStaV/1RY2ykCHv9cZr52NOMoq1v24pkJO7crfitE70uES9DtSPUN3JRXPLl2k5sprBOevSRWz9YcS5ge0F2KZAnAFZyZ/08kobhpJ8bvHxDMg5fQlQqN2q2G9Ek1KSNweeOwYN0DDCk5dgs1ZaUXm/RUUjKpy4+dRVwXBg9Tlw7/oTDU6RQOUnKuXQcHutzkMQlaI1YHxnqkQMidLoNmXHK+0gfabPXQ4y/tnOVT1pvD4PRLwxfVnSM4F0OR7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMLvI1DV4chon6MRPKJTvyq/IyHf0zeovhipgH6kHQA=;
 b=WcFc2pESW/6xWrZz/eXlHuz/BpukCtOjGerS7lqsMIFmQSJrUqj1KjehAcMr+i8lM2Qlvljm4iO8/mkVnXnmqVmJgVTRHGp9QABgETGNHm3lZ8PTx9qPnl56gjICb4XxUr+3uG0wQutpRPv6E36WjE/z1Z62sYZNtuLRpTipdmE0nP/TVJlIrl8gXbO2Uzrcm4/PKwSOhiFJtPRnruAIPmG4kkb0EM+pz22oMskl2qGyf3FX8lDYI9UJtLfEfZTe0AaDZm8/tMVJzmpEldabM80jj7jEoLNfy6yCsuEV9Dr0V1oqp+TswhNOTEYYCZvh/JqPLB9/+bcdoYSu1VOCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <58d1487a-fd3b-4b31-a133-3181359e0c61@opensynergy.com>
Date: Tue, 5 Mar 2024 18:54:06 +0100
Subject: Re: [virtio-dev] Re: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver. -
 Correction
Content-Language: en-US
From: Harald Mommer <harald.mommer@opensynergy.com>
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
In-Reply-To: <7bfbf09f-67d1-43d0-8ecd-aedf3b9e2287@opensynergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::15) To BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:2a::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2581:EE_|BEVP281MB3430:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff3539b-5386-47e7-9e0d-08dc3d3d4142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9mgoKP2hdXiPQCSX4dhVTe68aF6Po8NJ1hejVYbPaJaoV6OAQt5yvJooy4o9i5VevAvO6e9AIgFlfTNLBe6ih01RNn067GM79N2pUAiyJgINNBd8J+jUGNI8umNIEeBcW4J100+6tfJwXKEQcpVNokYe6RpaXUjnjWiCAbu7mSACaRmnOrLoNZiXliStn4RzZ0ISzzpfhlXH3Ufrcp60K6bhV44B6bWvIhxzkkKa4Af1ZkScrq7J/xbvfhr9FIGis2uKCxktCkNg+2bKP9GqZjQB7PXY31OYE6e42g75zCbejf9ttZsV/dlo1KyVOB8uN4SiCoUXA47f3C/9inIzKx4bD0uyeFhVSSwhphInSbX23S3amGwLdrFJCspk8gZVPQ7nn5yR4rKvuvK+3B5Gn103EovE+Uywy0lU8tZihnI90Noqg2wMKoqj5LkU0SXPRTgcji2DblapoxSDOhnr64t3neaMuOcWZf7TI/FANqEyc2xUA2WwMJEWhCavATl/7EfW7ZpOvGDN1TSdWDVL+Dmw4QjCbuN3h95SE0aztr9oP3FfKYnJ6gJII/b4/vYWuO/Pu+c34ZCGA0VkGllI18b+ZqWvpgdz5HywhhMMU+U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czJzV3V2VFByVnpEVWJiYnNrUURqYVdvRkYrQTN1aXE5VzZNSVBsRjhxaTRG?=
 =?utf-8?B?M1ovcUs3d3lqdnVuT3Ivc0ozUEQ1SkhHVklCajFWSk9WbnphOHpPUmQ1ZCtC?=
 =?utf-8?B?WmUzUzRyMkdOUm9PYlpCdnlSazluVCtPTmQwOW85SnpoMHlPbWdOdTVTWloy?=
 =?utf-8?B?V0dacGRVckNrZkMvWGJta3dLc3FpOHJwQ2M1eUg4NE41WkJuRnB2RWZaVmNE?=
 =?utf-8?B?NFRTcmRrOHd3ZkxLTGozU2JHQ0gyUEhPbFZIRE10ejBXYlptYnJLOGNSQTRG?=
 =?utf-8?B?cGxNOUxIUEJmM1U0Rk9Ed293TnBiaEhYbzFOb3BEZ1hzRXpXbXY3TG9pcVp1?=
 =?utf-8?B?b2hhK0lzR1pWQk5VamdJa3ZvRFQ5ZStOUnpxYm9zeWhoVWk5bEVSaWdadTZ5?=
 =?utf-8?B?eEpoRlFBdTJwWnIwM2ovTmQwN1daQW9xTGVNVkZkV0VqWmxJaWtIcVdYZW5P?=
 =?utf-8?B?amZYWmZMOHRFVENmcnRXT3hTNTVLZ05OYTU1ejhWcVoxZmErdXd4aXFDdHhQ?=
 =?utf-8?B?TjlkYzlHTTlmQXFZc1krV1pTNzQzd1hjOHY2RUF2R3MyOEVSK0IxYWRQazlP?=
 =?utf-8?B?OENDdVAySVRTSEJuL2lNM3hsb1FvcjA4cXVyVG1waldvNENzUzNJaHRUWktG?=
 =?utf-8?B?QnBRUVh4YWlnUS9IR1hmUFIvR3ZDeEF3Z29nTVpPQjBYaVREd1FBM3dscDNX?=
 =?utf-8?B?ZlZJdlV2bDBZVjZuZk5EY1I3aWNTd3VuOGpRVHVNYXN2QUwyUzBmWjQwTC9y?=
 =?utf-8?B?bUc3YXBCNVQ0UEU3OHBMbTBsYk9aYVpRTDh2YzBFVWFxNkoyVUlkREpXbjEz?=
 =?utf-8?B?bHRZVkdjdFJGdm9PQ2tydVdxZFNoNzc4SDFCaThXdnUvN0tCaFlzN3lwL2Qx?=
 =?utf-8?B?NEJvMEFBUVgrVzVQT0pER1I1VmRIbEQ4b3U1aE8wa0dGcnVCakd4QVJzQThv?=
 =?utf-8?B?S0hsckpFWVptaWRDd1QzNkFSbkJiRFR4TExGT3RQak53cHNaSU5KUEhwc1Nh?=
 =?utf-8?B?azZUT25tRHlyVlp5OUhkMGNudnRjQnJwTW9ReXhTZkdXbCtmZzdMeEg0MFZB?=
 =?utf-8?B?WlZaRzVYUXRtNTFiL1FxczVJSWZUV0tZVnVudWFCNXhRcEFGWkZWcjc5cVVh?=
 =?utf-8?B?cytqdUFyclBiNEhNUUZTRkRwN2gzZWNlczB4bytxeFYwekhUYVp4U1B4c3hh?=
 =?utf-8?B?Q3hLTUlZcWpuenFoVWdGbExETkZLSEo1RjVrbGpjeTVwTlVhVVFxUlROZ0JY?=
 =?utf-8?B?V3h0L0VJZENIdk5DZUVwRUZOczBRemh4ZTFlRmtKUWh0NkE1MXcyR2VqTVor?=
 =?utf-8?B?T3ZlbURMOFk2dnp2ZzNva0ZUOW9OK3ZEQVdlZk9SakJTZUVHblRReDFMNEg2?=
 =?utf-8?B?cGdsT1V0R3pqK3NrVW1ienVsZWhKZmRvYWljSy9qeTVwanF4c2JQaTk4aHdj?=
 =?utf-8?B?SFR2MUV1RWRoN1BwR2tVU2R1ZllSVW9sNzBRamM2ZDdiV2FrMFFZT0NVL3No?=
 =?utf-8?B?MW5wRW9YQTNYNUgrWnEweklOeWh5TTM4Tk50bis5Ry9xMmVTNnRMWjJ6TDUv?=
 =?utf-8?B?VDcvUGhDTnNPYzF0cUxZYjJQQXArbVUrQUg3OEREOXl5MjZrbFJYS1RzK0dJ?=
 =?utf-8?B?Rjc5b3FFQS9Pd2Rrb05CZFpkcG5kVE1vNENWdnZSUm5WeTdjcjZzOEVnditS?=
 =?utf-8?B?TmhkaGFVQ1pDZVo3Y0M1WTU3cXJ0d0ZEQjV0OEFUT01CYXBGRCtub0xGYVN5?=
 =?utf-8?B?dTY4NjdlQXN1UEVhN21wLzI3Y21PVGZKcFczV2VuZDNhTktTZGNtZGFzVmxv?=
 =?utf-8?B?Q0RwSEluY0hqeUZDVmpQS1R2ZlhnTm9NWjV2S0RTa1AzcWtNL3UwT0MrSWVU?=
 =?utf-8?B?alAzYUtQQXoxTG1DNU9pdzBOQ2lSUXlBYit1VWxBL1RNTGNXblRMSVZXdjBu?=
 =?utf-8?B?ZUVzY2kwdXVIUFJvU2EvWXJUVnlJdnVpbnhPcU1kUkUxTjhUWkVkYW16eTRT?=
 =?utf-8?B?RUlqSGZoditGQmVoNGNXL2s1WnVvbThTOUpVcENzcWFXQWNwUmtkWW5FS2J5?=
 =?utf-8?B?cGdKSVlrcDgveUhleTJkR1VGUWpMbCtOeENQU2ZvYlJZSEFqeUNUekt1ZTkx?=
 =?utf-8?Q?xyHL9cRQ2AL+rauklwCQsVJmo?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff3539b-5386-47e7-9e0d-08dc3d3d4142
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 17:54:07.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kX2pfwOXp/2MkpHgEn1n2ib3owZNsnyvEyx1lARuUuRMqgYUTKzxG4awxMbTUSu3HEhR8ojDqLP4zak9RhkWKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEVP281MB3430
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28232.007
X-TMASE-Result: 10--36.445800-4.000000
X-TMASE-MatchedRID: cxtZ8fwm3r/5ETspAEX/nicOunEIf0eXnsSRXdX/K/vUxxaDlU1CjwBZ
	pcD15FOOC50TUxe4kak4GwDVFPXYmCZ/F52Jg32US74sGh2G9bG4qAaN6svaSOEKbxqb5I/nrz3
	kcR2iFKt0rX74+8mpaoo7UX8gP8ZMjKMvpspSbF3wk9EZBtqQN+vWxpJJF1Fr4EXZbXg83i6DCS
	dOycy8k6jxfY0FQDSQRDx4kLj3aK+zojX5FsY99UsfZgIcSmI9XpSxZKDDzFjlbwjdfEVENPV4n
	eh8a5o6acnpCw9+/tSMvuRh8qnjUBH4pydzeozMRYNhzuZZjRB+rvFZ7FWrXEtsPowCNX8dBZ9s
	L54LFHDDEdyTYYzGzUHBZlZEyEfcwZmUiFxEyZBBOZh4z21cujrXh1RlDGfgCrmx3Yw6A+hawvx
	Gn0FdZmlD5QbCMj0K7/V3MvaSOVhAQKmLPHQAuboLCoN4YJzMq+3gIHiwfP+8hJB17FbvCROaya
	VCA+ghU0X2MVCAvMH+1G4uWuwl30c9f5KYEFBVxU0BgCkcY+TaPuPIIqmcJwIVhjVUsrMQv6Zhl
	U4huIbQ+sS71+DOCBAOLNGeu33dqDtmjlQ4FGmiWLhmiI4dP+k/y0w7JiZo
X-TMASE-XGENCLOUD: c0f7c5f0-4e8b-452a-be24-7d3e439f13ed-0-0-200-0
X-TM-Deliver-Signature: E07DC4BC85C0FD050F0D3EFD1A91C1E9
X-TM-Addin-Auth: WSv/rwECalh10M9zOsDRgNbaIMHBlDm+b+ZRhmWd8GRgqBlNJqomrljCqLO
	D6pYYhl81UDTlMW7P+JqHucO08Ks6l3xWXgg99HK7fbUUhX+cz68ch8R7dy58VkFdp3rPTAuyGy
	zIgfXj61Sud0LB/LnVfRUZlAeEr0ZUjlchxTPkZ7avTwGYIyHH0XoqO/3gEkPIXFZ17pq+J0qQk
	I4k11Rm6sm2C2U9x52xnJWyGkV4ELuMkA4Su0lYnohl03KQL0Xhmi4xUztlvS3wGVlhDH/gzvl3
	nQLCUSmH8jYTvKE=.uA+b8uvVghVjY6EXkEJX3kFJcSoe9XLCICpACWGAWjXvOFmNMOHULEMlJN
	FJxQho/hmy3//Bb5C9iEM1BJ/nLRC9FCOn6QGiNmef/H+0tCT3PbedXEHnYPliyUrGSWGEFHpPc
	2QBvDkFnN6DNzxqYrTUwxzoE0ni3ZG7SZWSuZSpg07d8rCbVeCDZp2Sz1PGv30s1zl4xlSqOSc+
	EByC4UqYLQOOvx2ZVIos0CDokOMjSBvSOjO7fTvhIwxDl38BEEwZ57zdwUBlNvxYXngalRIZh3O
	8tltIq+lV89SI/hm3LvPXaWUn0fWoR2gbySdxmfEDeBqDyDeWSSgVV22ODA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1709661256;
	bh=BR7EFOfW8jAA6R1S+fPdTThKyEmlwFd4ibYYREoeNRQ=; l=4272;
	h=Date:From:To;
	b=PjmoWnceyBrb0IOUIl06EnCW9VI6rViTZBUcf8194djAudsN+gtJba2dotH0n3WI7
	 9m07xffAD82Km9G3hSHzmaKn3oZlAYdOQyxnAO8LqRBzFrq1XL/gXCVtfC0JAsynyI
	 Hr99RC0XTy4fnVm93ymdihlp2okFVob3ivpYP3frm3FrCyQo4up7Cz/4DMK4Al6wjS
	 rCoxhsbl78fDzwfQWwQpa9vyTCZtXWetpBlW9ucAjwqTeZvXQ3pMK/S2HLJgS61/LE
	 8s7rvgWFvcqTeebcNM+mOnXLD9Z9HXKxI18Bo6AfW4+UFOUHSozS/Ze7eu1F/s4rGv
	 M0utUrbr1cNMA==

Hello,

looked again at my tinny setup and I've to add a small correction.

It's not the way that I've no udev at all there. What is in place there 
is busybox mdev.

Relevant part of /etc/init.d/rcS:

#!/bin/sh
mount -t proc none /proc
mount -t sysfs none /sys
depmod
modprobe spi-virtio
mdev -s
mdev -d

If I kill the "mdev -d" process my small script below does not make the 
/dev/spidev0.0 device node appear any more. Of course not, there must be 
some user mode process which does the job in the device directory.

Regards
Harald Mommer

On 05.03.24 11:57, Harald Mommer wrote:
> Hello,
>
> I took next/stable as base giving the exact tag/sha of the current 
> next/stable so that it's known what was used as base version even when 
> next/stable moves. The ordinary next tags are currently not of best 
> quality, gets better, therefore next/stable now. We were on v6.8-rc7 
> yesterday with next/stable.
>
> VMM is qemu for the driver you have. But it's a specially modified 
> qemu which allows that we use our proprietary virtio SPI device as 
> backend.
>
> Proprietary virtio SPI device is started first, this is an own user 
> process in our architecture. Subsequently the special internal qemu 
> version is started. The virtio SPI driver is compiled as a module and 
> inserted manually by a startup script by "modprobe spi-virtio". The 
> driver goes live immediately.
>
> In this simple setup I do not have udev rules (no service supporting 
> udev => no rules) so no /dev/spidevX.Y automatically after the driver 
> went live. What I'm using to test the latest driver before sending it 
> to the mailing lists is really a naked kernel + a busybox running in a 
> ramdisk. The udev rule I've sent are used on some more complete setup 
> on real hardware.
>
> So without udev I have to bring this device up manually:
>
> In /etc/spidev-up.sh there is a script tp bring up /dev/spidev0.0 
> manually:
>
> #!/bin/sh
> SPIDEV=spi0.0
> echo spidev > /sys/bus/spi/devices/$SPIDEV/driver_override
> echo $SPIDEV > /sys/bus/spi/drivers/spidev/bind
>
> Afterwards there is /dev/spidev0.0.
>
> In linux/tools/spi there are spidev_test.c and spidev_fdx.c. Those 
> (somewhat hacked locally, and I mean "hacked" to be able to test 
> somewhat more) are used to play around with /dev/spidev0.0.
>
> I can do this on my Laptop which has no underlying SPI hardware which 
> could be used as a backend for the virtio SPI device. The proprietary 
> virtio SPI device has a test mode to support this. Using this test 
> mode the driver does not communicate with a real backend SPI device 
> but does an internal simulation. For example, if I do a half duplex 
> read it always gives back the sequence 01 02 03 ...
>
> For full duplex it gives back what has been read but with letter case 
> changed, in loopback mode it gives back exactly what was sent. With 
> this test mode I could develop a driver and parts of the device 
> (device - real backend communication to an actual SPI device) on a 
> board which had no user space /dev/spiX.Y available which could have 
> served as backend for the virtio SPI device on the host.
>
> Slightly different module version is tested on real hardware with the 
> virtio SPI device not in test mode. "Tested on hardware" means that 
> device + module work for our special use case (some hardware device 
> using 8 bit word size) and the project team for which device and 
> driver have been made did until now not complain.
>
> Regards
> Harald Mommer
>
> On 05.03.24 08:46, Haixu Cui wrote:
>> Hello Harald,
>>
>> Thank you for your detailed expatiation. To my knowledge, you took 
>> Vanilla as the front-end, and VMM is QEMU. Can you please explain 
>> further how do you test the SPI transfer without the Vanilla 
>> userspace interface? Thanks again.
>>
>> Haixu Cui
>
>
-- 
Dipl.-Ing. Harald Mommer
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone:  +49 (30) 60 98 540-0 <== Zentrale
Fax:    +49 (30) 60 98 540-99
E-Mail: harald.mommer@opensynergy.com

www.opensynergy.com

Handelsregister: Amtsgericht Charlottenburg, HRB 108616B
Geschäftsführer/Managing Director: Regis Adjamah


