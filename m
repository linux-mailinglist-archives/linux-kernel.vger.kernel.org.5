Return-Path: <linux-kernel+bounces-107689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7296880039
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D19B21B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F2E651B1;
	Tue, 19 Mar 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="bBIWj/Bp"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6862914
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860770; cv=fail; b=LlsimVS5m4wmTw4uDH28WLZFN3x++nIjL8nZTVDNMf2pZOJ5/fvx7yhaj9vyxq7jjopI5wqbWYO1qK/coK0vV8GgnoJ+kamo8vERcX1ppZFrRpYwslQbxvdWZ1N9OLAxWmz4J6skfqF3SJfz4byu3+U73CqK2zpHLEln30zS18Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860770; c=relaxed/simple;
	bh=KLyhDukYztrtgoTswqT1EaIckIl4RDO5+DpjXw5ERys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ce2sc5DhsGfYavtzgHvn7bLkZTd6gRq5A1T+dP7u/wz25O0fTMjybdFQ2odEugzYrlmNbgI8+B1vQFps0Hnk78AUqROpkxBwZ5WjPsbIPbXdnt1M2PGsKk0hOVyOSjjPvekXsOn8cDfKlFEma0ar/+NcXwj+hs0c7vYe4oeLwpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=bBIWj/Bp; arc=fail smtp.client-ip=18.185.115.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.199.142])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id B02CD10000E07;
	Tue, 19 Mar 2024 15:05:59 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1710860759.342000
X-TM-MAIL-UUID: 20582d64-9a82-4612-9fdd-d140c294571a
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 53B2510000E42;
	Tue, 19 Mar 2024 15:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAzxleGDKOdepS2sMT8qFbYrNrfsdvTqRsc6HlogZvi4zUTbTd7lxS1riflrMLyezWnwfUBQueJqnPNX3IkjhYhgdItKtZhlKwe4q0a0cq+v+wcpp8ia8kG24/U23HRxkMwKCNXJdwAoMcDuIsWrhGK+HLSLZOQn/KuvXAVdfwYNKUU/llXjlj+4rNmM0JCFzv/Yif/Ui3+pO15U8aj64k+nxr7640rtwu5ZNCDis3EC9QGUOP7IomNBHfToIkrApjZ/yQeNTVikoxy8cqodThgtwhKqP54cgAu7gEXNU00Br2NC6zxto0oJPlPwm9jey2q1QxCp0dsMCQ6w2ShndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4J2DHucpbtesG0mWMDdM1z74HNyi7uZKL4o0RbM430=;
 b=a8VG7ibFpskVw0eJ3pxeFovkURH/h/LHZRyGd7q/CEjFZr2hfUBIHs9uLJ7bOb+X3W3gnAEx7kzUrsOkOqWGK1t0qROzpABJetK/IVOJCY6yJ41TAt58ForJI2xU6YjtYutP6eGVGgCm0RI0rK1IdrGTN/XSEc8fU9tck3jDKEUICsNn6Trwn9c7kMOjaAlBbxfLkCCzOkCEchOh1IwvMwFWLieV6IbyQilycJdLMMfKe7p3r7mlmhZ+mHWiKNV+UQ/sU9aQv2Bo5Evy8SMvkOKuUgjzs9p6X6YtbmXIiClZZC7il46rUiEB0ygFP54GnsL5wkAna57/FXdcgglG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Message-ID: <5dedcd26-ed59-415f-b978-87a546a0816d@opensynergy.com>
Date: Tue, 19 Mar 2024 16:05:55 +0100
Subject: Re: [PATCH v2 3/3] virtio-spi: Add virtio SPI driver.
Content-Language: en-US
To: Haixu Cui <quic_haixcui@quicinc.com>, Mark Brown <broonie@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
 Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
References: <20240304154342.44021-1-Harald.Mommer@opensynergy.com>
 <20240304154342.44021-4-Harald.Mommer@opensynergy.com>
 <99afc631-c02b-42da-a8d4-87c65087f390@quicinc.com>
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <99afc631-c02b-42da-a8d4-87c65087f390@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::8) To BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:2a::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2581:EE_|FR2P281MB2670:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V0IOrSe9MNERj5p7bK9loDHYKGgvl+AbuJB665KuZQAIr0co655ujq6dCTsYMTE/9D8hIKxqBUVrBp1NLxVlCcatvEjUv08wIorD3rZAd+8eDKiBkxoMQON1bRbhw7wmuVkXqPMvYNZT2m7D0VDN5EtXtZjC9HrtqNO0cInNGwU6sp+JLW72OtLxEQDxi81RWwzQBtZaFyl66Ytb0p14KrtGmMmshVmDZ9OoV1ooI87qGCn0nefUBWr65r9ez3wBjOufPTUwUPdu2SDopo6UkGrYsqlItImQ47D0wyq5TvAeF2gUVSAVLe2qZQ7ffS7ZlJjECU1gc9oki5K8ibige7Q2I7jqicsDMzHTJNQqF7WNUZ0cqJJ42/32txWVsWInza8f26otf+6t4Zu1Q/FxeDckkuJLQHiGJi7HHhodIWLMCz/kn4Czn/Md9qPXR/XPc1qNKGc8odCiGt7ZkZsaQfJpIUuB6042VMsmZkdSV3x2L3MKfiYbKaiwaODJu9g1slBDPOLg+ltlbymZCqDFxudT4DeEdVkQV7Aj6puocdC0r7XDx3Xn5IEqIS+nIxH3PmnQnu3BXgRpOOsHIqol/FHsTUgCnCh0n2jHtKLMXlOyyxUj6hHaIk8BI33kFMhdh0B8Js9dJ/34ncD+1lVIVpxm16AQF40A1xGoe577bAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjJPU2hTN29KTXg4OHJ4ZFpVUmNPSklIcDVMdHBYMlNVckt6V2paQkNPTDNs?=
 =?utf-8?B?cVoxQjlYcW5oU3hvQmRuV0o1aVV1VnNXZU5BTHZpcGUrRnpQMms0R3JuSmVj?=
 =?utf-8?B?dmUwSjZwelZJSnQvUFIyVllEandHMXlaWjNaSGF3WDUwRUJwVHg5M1ZXOEtT?=
 =?utf-8?B?ZzkvS0VtWlB6ajhMVENHQzc0ZC9YRERMb2RsZmhweXNwS1BtU093K2htSk82?=
 =?utf-8?B?Y05SUVl5ZGk1aUJDQWQyT3BNWFRrLzNDaWwvSTA0N3RyZTUvMStZeE9hMit1?=
 =?utf-8?B?eXJza1p2MjRUMElLcTlXNGZ0YjM0aUJaaG1KRHMydWZaT21scEU2RlRpMERK?=
 =?utf-8?B?R2lRQnMwNGlMQm1VWllTZDdzd3RLQktyZXROdHdNZFRTY2xmaWVETElOMGg3?=
 =?utf-8?B?MUhCNE80ZVZMOThSS0o3NUp5TEl4RVBwMUVyZ3V6ZDJDV1FrYVNOZE5XWFcz?=
 =?utf-8?B?UkdDZ0hhTUF6MTMyQTNRTFY1Wmo5WHJWc3k3V05XMzhoNGZNM3pOdWR2WDd2?=
 =?utf-8?B?SnpDZlNMNWJ4MytDTUFKZURwSGJEN1p3Tkw0WUYwaUo0ZDRFVUlmdUtZek90?=
 =?utf-8?B?R3VPMWVpQkx4Mk9QY3R6VXVqb2tmYWk4WkNrc3dyWDhWUEMzV29rNm5YTnhm?=
 =?utf-8?B?VlFnRHZQWjRuVmluVS9USzFUd1JZTW9uWlRNeklJa0NSTEZnQW1PVDZCc2tk?=
 =?utf-8?B?cHJrRlRINVZiQmFNbkJYMjhEMitRVkNwc2dzQ3p6cmI0bU9nTnkrNTNabGVr?=
 =?utf-8?B?bE5aVGtUZi93ZVRPcUpqd1BTWUNOV0lnclpKT3RxVmtuWVpydW9iUS94OGw3?=
 =?utf-8?B?d1A3aUtvekFIakdLWEptcEdFSGlFNjVXaVJ2K2xHaDIrUGJWMUVWSWpWbm5J?=
 =?utf-8?B?eFl5R3BsU2NRY2lXb2hML3JDbVBla1YwcjdBdVJMOGY4aE4wbVlJT1NLT3pU?=
 =?utf-8?B?NnhzSXY2ekczY2JBU3MwU3Y3enBDMDc4REwwaWR1ZXhsQUxtN1ROZVRMcDhx?=
 =?utf-8?B?VUFsOXJ3QzRvdHl1Qzh2Wk1OL29JYS8wUTlzNFNCOTJLK3NMRTI5Y2daN1Y3?=
 =?utf-8?B?ME14SlRKK2JYMzhnMHBsVStsZ294QlBsZlJBMjFpYXl5Z04ybEQrMlZVK1hR?=
 =?utf-8?B?WWo5dzFzMGFXa3VBeTh6b0lGL0thdGtaSjhWSjQyUEdsQXNyNEVGZ3l6M2NL?=
 =?utf-8?B?aDZ4dzM1QjJ6YWRDbm5weG0yQmVOVUhsaHdHT1NsWDJPTWt3dXNOZkhnYWlq?=
 =?utf-8?B?d3c2RWloOGx0YlZ2V09LRkVXeHRweWlkWWtRVG5yWEVCRTRCK2pSd1hleTk3?=
 =?utf-8?B?WTl6VXdlSXlOTWpqbjdQZWFMbk5wTDVYT0oxcWMxaGtxbnpvMDBpQ0RIZTRp?=
 =?utf-8?B?SGx2UkQ3MXQ5WVpDbStRMDBRS0pseVdJSVBYQXpzVGJIMVJrNGY3c1pNVmdQ?=
 =?utf-8?B?R1lBTXczRGFvOUVWcE9kaFA5S0tjeVNzRC8zaFBJZnF1eURHeEl5Q1BjT0F1?=
 =?utf-8?B?RmtuV093a0JRR1UwdTVYcWFqK1lBeWIxdEt6Um82QXYrTjRoLzhzTFZlUHh0?=
 =?utf-8?B?cWY4TWJFWHNyeFF6SVZJTk1lM1c1dVZvaFlML2k5U3luK3JwSFViTE5wVVlN?=
 =?utf-8?B?a016a1MvL2swanZrYUpXTUc3WUQ0WllJbUt4ZlBObXJwQVJ2WCt1U09UM2sv?=
 =?utf-8?B?TFJjRTl1TjQ4YVQ3UHp4Qkl4cDNvV1cyVlhLYXdJMmhieXNMZDJlUXFPNjVh?=
 =?utf-8?B?ek42S01KR3U5R1ptWUxwdTRydkppZ09mK05Bd01zR0pTT0V6UUhtcnpNQzY0?=
 =?utf-8?B?dEFZcnE1eEVUWTgzTXBoaEx1akljRHVIYWJKWE5oWEJ4bGt6UUwwVWt5UmVJ?=
 =?utf-8?B?bWVKN281TzUvNjAyRVFFVXcxU2MrTUhJWEJXamFnQVdYNzh6WHZWZVg5YzJL?=
 =?utf-8?B?azNWQm42OXp4UStFM3E3YmJOOGNsYUtveVNEeUg0SXZydXNuNWJXbDlmUHEr?=
 =?utf-8?B?NTBObWpBbmtXbnZmU1dqL0pHc004RjlKMExHUDNkRGd1VU1LWTZBRy8zdEdS?=
 =?utf-8?B?WE5vVThqT25jZ3BoRXF0T29obGZWZ0JCN1dMRlFGM0Z5dzFGZGpHa0pXT21a?=
 =?utf-8?Q?CL2BB5jIXRZkGPw+Q6YsOWJLK?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57966868-2082-4441-1aba-08dc48261523
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 15:05:58.1526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1JhC1bBqRJFL1X15uyenxRsHlKrtDYRleK0LhYnwCseQiQe+DUPvD3MLe382gSTpOl1fql5im+VNw3/89bBmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2670
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28262.000
X-TMASE-Result: 10--15.526400-4.000000
X-TMASE-MatchedRID: 0dFPYP4mu5T5ETspAEX/nkkXVQaP16N5gdXztqOEBnB4qfOd233bZa1E
	3eK47PQvHe/Upp/4ecTU2c00Whd2/4ms9BCunzDsDH4m2ujwCtuFEtM7u1PJt/1+yNkFY3qaP4o
	cZuwLw49Jx48TqNIdl7H+lELTBl4s/7zDDoXJoQ01wGjuQ0TIwysZXvcCxTRn5aLISmJsQyU8ng
	ic1rrgiDmZupOyubC2sg3rueGAZs7ZSZojEviuAjZ4NKr/TszH10/soz7yB7H0Ab8aOZu0ArRZU
	QZ32S1HbhkCAaAHjBZlvSMRVSGieWDT+Wb3xgCrwptnSAS/aGQDlcboR1QH12o6O2V7nV87CvBR
	h7+RgCUYXZOLopHn4G5Jc1hHAthj6/gZEQCNScu5kTI8BpRqcpbOkYpZpyLEp92zxqYVNnt+cbd
	mqOGVk8Ow65JkZhPUldYeoo7G9XitAMlP4gRdFiT5U3lJ4T8K89lXv/QVq2UiVDZDa7ea/d/upP
	exrMg481iVzvxB4Fg7uJKuSvzgWWkxewMv2is+aUtZwjXtiLO4QSeL4UvEmw==
X-TMASE-XGENCLOUD: f2ddcc2c-99d3-40ad-9b3c-0ec4eced5063-0-0-200-0
X-TM-Deliver-Signature: 8A1917135A07332EEA3056C31EDCFFF1
X-TM-Addin-Auth: S43XoeiJPsghTJDb0e+y9fvdLWyfPh4xtvqZq5KIwQ2PJFunNKQ38Xl0rFG
	LYUSkV5GavFkwGqsaLcrtVfHlZbj3M/vyRrqvLUWXwg2qCuGuPyqaU4eFo8F1u6Qerpe1mqkkLx
	qgnbBz0X6jI+hz0rEiS+Q4Ek7SG81sXiLjhGst2wKi2CS9e02WAeKrgR5KnOWDvtm1PJ3I5+S+W
	cFdxnI0J6504s21HAlDhKhjV2VgvuY1NMSUmyxBLq16hodf9gbxV2mMmYS24qYkRfGlT0N2XXCD
	tfFKHDyELAG0QOU=.NtuouYeR25rl1RhwqXgb7GAcjg8s1VhhiI13tYVh9WXXMvK3htd8gLUH0f
	pVPWULMAcYKscyHMFr95ij0GLCAUQfb9GwiYG9cT9WFL1piTfHGB9NcGV4nbdSQV/EeH5R11go7
	wWyEcSmKmscAs4Xo9zV1E4mOMYRSmvLIs7xWjmj7M8vxs/czMvDxDUNH/bUS0aYuUdek5mp51yI
	MGGcviltqyd+uFrCtm4CDH8/q0mxOCeh860zlZRL85bOJnF2WA/cFSSTitblKrexpOWbGLrDy19
	tQ0zsKKrO2eUx73zHtLCx2AJvJCOmNZSu7kl8QnN6CJp7P7aD3aI/bxV8Iw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1710860759;
	bh=KLyhDukYztrtgoTswqT1EaIckIl4RDO5+DpjXw5ERys=; l=4998;
	h=Date:To:From;
	b=bBIWj/BpUVIk9BqZq3rWnbi7z+ekyYwiq8tvb1N9tmEw9+QPay8+9P9b+yslB1sfh
	 raqRX9/L1TFemYbLuNQhdlJrpoOfQsh2TfXDh0jWwDpVDe7HjnrCNuSkcxKrB7Kryd
	 A0o8EMV21K1vdJQ5snTSIn2vdw+GfiaPq4SGYxDQmFxCekKlibUMWfHfJsLKrSptT9
	 s59lbTFKo9JY9odDt4KoBQ3I4zCaLc5oNzfJd8lOveyx9c8s9BF7DSyh0cSwqrHjrn
	 H1OmIAZ2WEph5njxiHEtTPpDQvyzmDGBj1bw+kGKOSL1surfU9jQXsCoDHyVdVueYM
	 FgKBlERHGDMmg==

Hello,

virtio-dev still down...

I have to admit when it comes to device trees it's most of the time a 
fight. You will see below, fighting.

On 18.03.24 10:39, Haixu Cui wrote:
> Hello,
>
>     As Mark recommended, I reserve the virtio_spi_probe function only 
> and list my comments.
>
> On 3/4/2024 11:43 PM, Harald Mommer wrote:
>> +static int virtio_spi_probe(struct virtio_device *vdev)
>> +{
>> +    struct device_node *np = vdev->dev.parent->of_node;
>> +    struct virtio_spi_priv *priv;
>> +    struct spi_controller *ctrl;
>> +    int err;
>> +    u32 bus_num;
>> +    u16 csi;
>> +
>> +    ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
>> +    if (!ctrl)
>> +        return -ENOMEM;
>> +
>> +    priv = spi_controller_get_devdata(ctrl);
>> +    priv->vdev = vdev;
>> +    vdev->priv = priv;
>> +    dev_set_drvdata(&vdev->dev, ctrl);
>
>     ctrl->dev.of_node is not set, so the child node cannot be parsed. 
> I would say, it's necessary to support the virtio spi device node in 
> the format:


What you most probably want to have here is

   ctrl->dev.of_node = np;

for reasons I don't understand completely yet but have some idea. I may 
play around to get it.


>
>     virtio-spi@4b013000 {
>         compatible = "virtio,mmio";
>         reg = <0x4b013000 0x1000>;
>         interrupts = <0 497 4>;
>
>         spi {
>             compatible = "virtio,device2d";
>             #address-cells = <1>;
>             #size-cells = <0>;
>
>             spidev {
>                 compatible = "xxx";
>                 reg = <0>;
>                 spi-max-frequency = <100000>;
>             };
>         };
>     };


Looks in my setup like this:

virtio_mmio@4b013000 {
   compatible = "virtio,mmio";
   reg = <0x0 0x4b013000 0x0 0x1000>;
   /* GIC_SPI = 0, IRQ_TYPE_LEVEL_HIGH = 4 */
   interrupts = <0 497 4>;
   spi,bus-num = <1234>; /* <<<=== This here has been added */
};

The "spi,bus-num" is missing in your setup so you use the default of 0.

For what is "reg = <0>;" good? Or is it a dummy and only has to be present?

I don't understand spi-max-frequency in the device tree entry as we get 
this value from the config space.


>> +
>> +    init_completion(&priv->spi_req.completion);
>> +
>> +    err = of_property_read_u32(np, "spi,bus-num", &bus_num);


np already set so this assignment should play no role here when reading 
the entry.


>> +    if (!err && bus_num <= S16_MAX)
>> +        ctrl->bus_num = (s16)bus_num;
>> +
>> +    virtio_spi_read_config(vdev);
>> +
>> +    ctrl->transfer_one = virtio_spi_transfer_one;
>> +
>> +    err = virtio_spi_find_vqs(priv);
>> +    if (err) {
>> +        dev_err(&vdev->dev, "Cannot setup virtqueues\n");
>> +        return err;
>> +    }
>> +
>> +    err = spi_register_controller(ctrl);
>> +    if (err) {
>> +        dev_err(&vdev->dev, "Cannot register controller\n");
>> +        goto err_return;
>> +    }
>> +
>> +    board_info.max_speed_hz = priv->max_freq_hz;
>> +    /* spi_new_device() currently does not use bus_num but better 
>> set it */
>> +    board_info.bus_num = (u16)ctrl->bus_num;
>> +
>> +    /* Add chip selects to controller */
>
>         Creating the spi devices here statically, will introduce 
> conflicts if the same spi devices also in the device-tree.


Of course I need to create the SPI devices here statically. The 
"spi,bus-num = <1234>;" in the device tree has to be defined in a way 
that there are no conflicts. I do not understand this.


>
>> +    for (csi = 0; csi < ctrl->num_chipselect; csi++) {
>> +        dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
>> +        board_info.chip_select = csi;
>> +
>> +        if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
>> +            board_info.mode = SPI_MODE_0;
>> +        else
>> +            board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;
>> +
>> +        if (!spi_new_device(ctrl, &board_info)) {
>> +            dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
>> +            spi_unregister_controller(ctrl);
>> +            err = -ENODEV;
>> +            goto err_return;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +
>> +err_return:
>> +    vdev->config->del_vqs(vdev);
>> +    return err;
>> +}
>> +
>

What I needed to support for our needs was a user space SPI interface. 
You probably have a different setup and additional more complex device 
tree configuration needs I do not understand (yet). I'm somewhat lost in 
the moment.



