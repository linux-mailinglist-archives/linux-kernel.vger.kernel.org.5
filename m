Return-Path: <linux-kernel+bounces-99361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31232878750
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCF42820CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9872853E2D;
	Mon, 11 Mar 2024 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="dAPNR3GF"
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5377C53392
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181752; cv=fail; b=XFSZNR5jA8RK44cXviAOqunqyOV1X9uuOw13XsGZDzjdNKEghrd94iLlDmNmMl0E+juv87pyQaWujYEUKh4oGceQBvQg6GL+dKnEU879OBdcIs9BhCzInEmKVS9WxpqMRnZc4qOO1gM67v43rADdHVrBZh5ZZMNtIIYvk4tIzkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181752; c=relaxed/simple;
	bh=qVg5zNro04J/Qp8HEvKilQCutULBeLA3srmn0vBK6Co=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mCozZMVQavU5R+JpFptM4k597kIPt5z/LbN+m24ju6DwQkWx2J9zWhhlhWuZD608aRf1zi59/BbiHuTLV39YLhVcZYDrkpdVJbdRVGEUULymroLaBjzj7IFmO0jMinKQRTW+0j3G/pvz3htZwuDxGDRCh2XtErrDKc8LtTKC08w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=dAPNR3GF; arc=fail smtp.client-ip=18.185.115.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.10.233])
	by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 115041011DD0B;
	Mon, 11 Mar 2024 18:29:08 +0000 (UTC)
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.197.65])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 7D2291000049D;
	Mon, 11 Mar 2024 18:29:00 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1710181735.682000
X-TM-MAIL-UUID: 5a03fc81-81df-4f98-a45e-097de836e455
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id A6CC210047C37;
	Mon, 11 Mar 2024 18:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmkSuS/KPXD/JO4WXuFDBOeCmxfZjg3N7wrayluAOwSDdwDKSNqxmNhfUWSBVxa0/f0VtuMXzYtN/XHDGKt+iJ5xtiLUYYJVK4otYBHhYzaHGDMCAnNtCdtufmw0iuydoBozciLXwXAahczPRJpDH1vkIDAQIqe9XO69DHGsqbi46TZG9jROXDuCqXQmUGVFwA28rUEIWEWZ5+FyPWqotRyBb6kXJKyJToJsb0MX6Ydbe4rs8k1Yg4b1nkeDBEQ+g5a/su3Gh/oyrS4vE5vgMl9yz8iAcjgTdVd/x0Oa9Hl9M1mwYby34vYzoYMlwYnpqU1s4Hk5fqz7Ox/c6vpPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ+rToqkRmitiaiU6nancbJeFVM6IQFsCWhqFmh3brw=;
 b=Td1W9SKlMIfz1ybdLxAe0rqaszq9TiMZ3HXJ5lXLQgXu9Xklo3I3nIeSFQtDrU7Nx6PHQGbi6x1NHsOHbIzQuG9t9a6lByUCQREhd9l0n/gDtx+Zgk2y6pwTc27DweDu6hQ2MJcxLYE3a8ain1nlVFuzywAmxFn/ylewrTNC1hMJlBrHaWbbK2B2QrnugUfAZRcjOmagFb4xnbB0R29j7HyaH86GGvfO/u9JUVg38p4a0TZ7UX2w7KA7CWXdGrGGYXDCIvK0xkxPovzSHGEmVwF1F21sHCv6ZGNU78NO8BFv4wTSEc1uOFu8NkWGsJnk9kaYPCg5fIiQE5KQJbrYsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <a4babfc9-f4da-4dfe-8431-eb819f5801eb@opensynergy.com>
Date: Mon, 11 Mar 2024 19:28:50 +0100
Subject: Re: [RFC PATCH v3 7/7] virtio_rtc: Add RTC class driver
Content-Language: en-US
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 virtio-dev@lists.oasis-open.org, linux-rtc@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Alessandro Zummo <a.zummo@towertech.it>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <20231218073849.35294-8-peter.hilber@opensynergy.com>
 <2024030817030063a909f0@mail.local>
From: Peter Hilber <peter.hilber@opensynergy.com>
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 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
In-Reply-To: <2024030817030063a909f0@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::11) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|BEZP281MB2947:EE_
X-MS-Office365-Filtering-Correlation-Id: 6011367b-c9c5-4063-aaf8-08dc41f919c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eHCoPt1noziRqYMucg3fB8SitqW/7ySy257y1uNEZHfYA9YwdvCbe3yIXVKlX60PLWtxbBmri8iapUKbV8xcoLAcfv69OTjcoclZoDAg+dv6MctlGQbVGUTLsog1uSoRewhx+C6Ohe/ED5oEMlQzkiVYutdHxYpJUSL+hngNROxM1olv5hhgmjSS2NMsPz7Exxp5sRqYgpM9aiJ+hOo9g3k6uVf49pSEeZxpI6fN/i1WzNSqK48aL8kDQ+wpM1SXXYbKIkgFtBenRJ/sO4R7qoeKnK4x/jiL/yCXeWITjjQkqlsSnnJGLspuoXH8jxhq26VDZoFPHUOXgGD4S9Ce1g4dTCIe/EnT0Ltla9Qapy/pUZOwN1luzdN7GhmSy3eIvBoY2tvcoc2eacAKTsdjQiP10W/3szkxuoOb3RRuZOVwuYXe7yqGjfazzJJfBi6JZAJwS1L2R0AjvtKSWLf8kumNp0JKHw9YlwUfDiCy6dG/Wpih/LnwO9gs3dERxOt3Wn0S7zH51OPimftuJXDnYwHX2uqv1PxTvfERilV9+cqxWHSxzi3vYAGpLNGJOy0vyuUOPuMTrOhvlJNAh7L0bJH1SME1PxE47hRTIdcCLxw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjJ0VTdzZmhoTGlOOVdhVlQ4RUN0N1RvSE4xcE1CMzUrQXEzaUY2UjY4b3RD?=
 =?utf-8?B?OWFOUDhjUTljc2E4TElOeWJsL2xEOFdjcDJBR3dpaXZJVW40RlV4NE4veENC?=
 =?utf-8?B?bFRHd0gwbXE1SVZnc05jR1VHejFaMTBFUWlnYzJuRDIreXVBRzgwRlE0dkl5?=
 =?utf-8?B?ZHpNQ3BQTVkvSEhNVW9lSVgxQ1JXZEc1ZkpnMmZWa3o1M0JtYTNNandMcXFw?=
 =?utf-8?B?b0JGaHpyUGNiS2xEemVWUXAxOFlzUWhTbVFoTktUSzNON3JRSG5hbFlQZG13?=
 =?utf-8?B?ZVQxUFFFNDBmdnNPVzJ4cFRjbGlsSnZhSWQxU2Y0NytlVXhoenJuYzZiL3Nh?=
 =?utf-8?B?SGRHV0tKWUpwRGZrcGVXZXNCWjM1VDNDWmo1a2VhTXNWM3lqL3ZCNDVSQlVM?=
 =?utf-8?B?VHMwZW1TWFU5cGFGMC8yaG5tWkxLWm1XNDhYVENoZWVCa212eXRNbEdncGlp?=
 =?utf-8?B?T21rb2trYTBQR2hFVUNGWmUyOTBqV0pXM2loWHZQVGlwSHE4YkhxT2FDeFpY?=
 =?utf-8?B?MjU2V0dZYVlBL0ZwRldSTHVLRGpteWxoUlN0aURKRDdnb2xUV3NOK21uRTdI?=
 =?utf-8?B?ZzdHaGdTZy9MWDRXVlBzS1V5cG1pbDg3NDBrc00yRFRKN0ozZk1mRjVpSDZT?=
 =?utf-8?B?WXZaendNakdLTng0L0s4NkxaOC9QdGhFQ2c1aUFEZnRYZ1lLNzZPaGRvTnd0?=
 =?utf-8?B?OEVRTUNBeExqVlRvTS8wMDlEbnhjN0c3V1lmTzhwdXQyWDU0REdxblJxR2E5?=
 =?utf-8?B?dzZKRE9NZk9MZTkxOUlpK0diZUtaL2N0dWlBV3ppcDhjdnErU1V6L2NOSFY1?=
 =?utf-8?B?WmJubC9PeVZIN1h5cHNBeGM0eWNLaGFlQ3VkY2JwUTFySlEwTG1UTjJkWTFJ?=
 =?utf-8?B?NUhFTmVJZUc0UThYMkhBckFzNmFHVnFUbVIwLyt6aUl0ZGR3SlJwL0hUSnF1?=
 =?utf-8?B?cGZmTjk3SGFXTFp0MWlqNll1cXZXUk9CZ3M2TmU2aFNrN1JqOGlONk9COXBM?=
 =?utf-8?B?RzJrNzlSQ0hpazhSRTBQL3RGVmxlVkpaUzNBbGJvNHlPN3BFbXpqb0c2aGVl?=
 =?utf-8?B?bElIbUYyQnRZL2VRMzVIM0k5T00yU2ZVak5kaDJaSlZsTk03ZUNja0Qzd05O?=
 =?utf-8?B?Y1duWldsRXF3L0hRbWJObTkxam9YU245dDdTaDVzWHQ4T2QxUi8vU2xXTGtB?=
 =?utf-8?B?YnNPeVRaRTE5N3hxd2x3RlJMVnUyeEdRL0ZzemZyRFUwZUVuV3gySStoamZZ?=
 =?utf-8?B?V1lscFRJSnNpZE1QUW50aGVkR1FQRkVTQTBuSFdvb1lydGR0a3hPdjcyS25y?=
 =?utf-8?B?bG5GNFN2YkNwZklPczJmbVZvaU5INmV3OXFIWTh6dzhnaWFqM2xnY3d4UjFS?=
 =?utf-8?B?VkNKcUR6VlB1UEJOUitkZmJFNWplaTNMYmVvcGpSdU9pcUpaTTkzVzJ1eEdq?=
 =?utf-8?B?NWw1RDdaVHdvYmFWWmRmeVZhWWNoMXptczJ2Zm1nekZieGJ1WkJFYzRJcHhS?=
 =?utf-8?B?d0E0ZWFHbjZ4Q1VkQmhpRFZkT1hySWdPY0hNVUhCRnBjOTJHOWt3Ni8ybjN6?=
 =?utf-8?B?eGIvOFFhdi9jdTZwY3JNYzBUWkxQY0NOZkppQmFNMmJTT1RQdzhuZng4R2Vx?=
 =?utf-8?B?ZkpvZ29ERW1TbkVVZUJab1JTT2lkZHB1VEF0MVB2YlRtREllSUVPOVhkaUh4?=
 =?utf-8?B?YjJoTDVrR0pURlNyRFBOSHUySGd2R0g1QWJvWkI0azJybTZFa2dmUWc0MHFX?=
 =?utf-8?B?cnM3eHNZQXpDemZDZ2JFS0lNOTZZNG5SYzFoLzZQYWNtTGZJVWwreGdid2h0?=
 =?utf-8?B?V1IxUDRqUExqblRSNUhUeEVrZklzbUlaOXJndWFWblhpNkNTZXBiak5DYlRa?=
 =?utf-8?B?Q2dBejNiUlZwakl4VTBMd0ZVQTdPZDExQUZHSnBEVkVsNThCMkZERnNFcU5j?=
 =?utf-8?B?eGFwWm9pRWJFSVFYMEpDeUdFeG1UOUdIRGNoNmFBcWYraEQ3dVJONStBY0xt?=
 =?utf-8?B?NzVva0ppMVlZeHVKUFFidE91eWZQdjlHdE5OMGdLUDFlcmhESTN2dWhTcmF1?=
 =?utf-8?B?Z3V2VXV0RUlhdk5KZW8vVkxJMzR1RmVrcTE1ZFh0cklzU2crK1N3YmdXdmRs?=
 =?utf-8?B?c1NJOGpmL3NlbTFBUnYzWllPZW0rVG5GUWRvK1c5YkZDMnJJUjdSaVBJTEE3?=
 =?utf-8?Q?t/vYCczOzzBBD5fM+jsnUFKg5X3yD8JXxti2U2JtWDjr?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6011367b-c9c5-4063-aaf8-08dc41f919c7
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:28:51.5836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UOAtlAgzUbuJV22s3A/A7cbH4fVWd6mk7L2xOd/X5QX8S+FQI5wJ8LZzl+OmRnkck7jdP80C1uwlmJWAgpdfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2947
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28246.001
X-TMASE-Result: 10--27.836900-4.000000
X-TMASE-MatchedRID: H0/uSqZo4D75ETspAEX/ngw4DIWv1jSVbU+XbFYs1xKhgsXxlmwopgln
	xsqTOcV2AY7kuYRZSdTJg79EYBBhLZEIC93suCa5Ftp2NONUJDbgOJe9wsMrC7dQknz6f/hFXR+
	HDhMBn8cCw1sSxKVRyvBGuWOvGYCIemLHeUHHKFLxjWAMewuQQmgHItrnhZs1zNDP87/xT8bDmd
	nLZf43HglbZ9hc61BY89Z7bNo8rwF9UbIZwV24pJHnqg+UkwTPB4BMfq4SzeJleIkVxMgTA81cE
	mgnltzMORoZNSkXTnpkhLIWZXteUtKh0uXRKp2yS74sGh2G9bF2Tr80kEaYUKyC+kQhC2Di6iGp
	UBCWjnQ2ChKBhrtiFuPgI/uZv8ez3SA8Rq7EslFe5ee5ItEt/LioBo3qy9pIfN5l7ipRk4geM/O
	6FDx6AvV7jalSHEIp0Tjgls/gy++kKR9NwAkvVp1hE3UvZVrYYk1isaGgL9Lb/SYbCfi2f/x6mK
	cE52cQ8YgxAgr12MgKEYTMq1mpJIdBoDXHz1XDRYNhzuZZjRAZ8/pDtedih5zYnFsPfA8Xpomw7
	owLzeySIg51D4kFcZXWHqKOxvV4rQDJT+IEXRbE70Mejctgq/rDHrB5YKTLqBDcOVrGCjOwuuqc
	48T663ht3q2IwW5dftwZ3X11IV0=
X-TMASE-XGENCLOUD: ba6a55ff-214b-48a0-aeb1-f9e23957a267-0-0-200-0
X-TM-Deliver-Signature: 2BAFF5F16DDEEED15BDFF351669B6237
X-TM-Addin-Auth: FscEKb+oAPksLlSkuvWU7hi0hb+E1/+zaALwZo4U2Hkj9o7PjGPMzyK4Tkr
	oJv4hBwc5DTfYXY6wKCi72xNUuyNn4r1fdFkOXwMhABXqjvmsIORX79sujBzHrBgVerNKj8HHYh
	3R1q/+yXhTGLvqVPI/Rx8Y3NhjgyVbJ7vyjRmx/nFLLrWcaSEZm7zsqQyaRp2bmvRricZhSwOTc
	uA47JVbvJaO4UPeTmlZnYLOTuojSVmytC3Z0wo2dlQbOMr6cATgkVag/FvmNTke1mF6Wvl6aTiI
	JsK2Gvcp0uUpuBI=.WJv1BC2bv1JXN8aowuhS08y0x957Uh+hS8R7jWA8OMkFy2bVLtMBu4sPdq
	1Agj88MFgymbxZDgWp0Y/myFt7ZcU6yTr9kzhEhs6ctjwCQ/tGlryn3TsEzjfPBwq7tUze5RIHi
	dQXMZ4oHLQostrXcTUDvbBMXUKRhdCs61IGDrlNfmxTXP3OOoThk1KeuCEBjktu8nCotJJ9uDxq
	9UVyRJM9I2oqOazqPVpIo9XEb1X5SYlOy52tjxdi3hcKR9Ua6LR23BL2yueazXo8kcH67p3JfhO
	nCDR/8gLBCaxYhmc8a3d9Q6kpdyPd51kIncHDpf4BMLlMMEDpuwSI9YJKmw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1710181740;
	bh=qVg5zNro04J/Qp8HEvKilQCutULBeLA3srmn0vBK6Co=; l=4988;
	h=Date:To:From;
	b=dAPNR3GFKnoMpPzbfk8cy19J8LU6KcDd/3G/hJ/zwwS+M7fvoI8UKS3QKkuksg2KS
	 O6AxTY+9JKT760mJR0r9KDoT8vBT7iZQvkIiZCfCUN0YpptDtvvLgKAQVGSzlfkgha
	 P38bJ504L28YcAQzU8XuVqR0yQTmjG76cKp6WVIzgbG0K+9KHwNKoUjGhiTQzbrzbd
	 EKU6pukqFX3guKXOd9anL8yuC+Vd0EFF6BNL1VAeJzoJIQx7cuqrdzngNRkVS0jkET
	 Yp79f19Gq03zEPLTimE+wR97xajiFJcSEm0WeveyZq2a8vwUHhuHh8hEAXEgvh0hl2
	 FHaoT6cy6Ai6w==

On 08.03.24 18:03, Alexandre Belloni wrote:
> Hello,
> 
> I'll start by saying that I'm sorry, I have a very very high level
> knowledge about what virtio is.
> 
> On 18/12/2023 08:38:45+0100, Peter Hilber wrote:
>> Expose the virtio-rtc UTC clock as an RTC clock to userspace, if it is
>> present. Support RTC alarm if the virtio-rtc alarm feature is present.
>> The
>> virtio-rtc device signals an alarm by marking an alarmq buffer as used.
>> 
>> Peculiarities
>> -------------
>> 
>> A virtio-rtc clock is a bit special for an RTC clock in that
>> 
>> - the clock may step (also backwards) autonomously at any time and
>> 
>> - the device, and its notification mechanism, will be reset during boot
>> or
>>   resume from sleep.
>> 
>> The virtio-rtc device avoids that the driver might miss an alarm. The
>> device signals an alarm whenever the clock has reached or passed the
>> alarm
>> time, and also when the device is reset (on boot or resume from sleep),
>> if
>> the alarm time is in the past.
>> 
>> Open Issue
>> ----------
>> 
>> The CLOCK_BOOTTIME_ALARM will use the RTC clock to wake up from sleep,
>> and
>> implicitly assumes that no RTC clock steps will occur during sleep. The
>> RTC
>> class driver does not know whether the current alarm is a real-time
>> alarm
>> or a boot-time alarm.
>> 
>> Perhaps this might be handled by the driver also setting a virtio-rtc
>> monotonic alarm (which uses a clock similar to CLOCK_BOOTTIME_ALARM).
>> The
>> virtio-rtc monotonic alarm would just be used to wake up in case it was
>> a
>> CLOCK_BOOTTIME_ALARM alarm.
>> 
>> Otherwise, the behavior should not differ from other RTC class drivers.
>> 
> 
> What I don't quite get is how this is actually related to RTCs. This
> would be a super imprecise mechanism to get the current time and date
> from the host to the guest which is what I think your are trying to do,
> especially since this is not supporting UIE.
> The host system clock may come from reading the RTC at some point in
> time but more likely from another source so is it really the best
> synchronization mechanism?

Hello,

thank you for your comments.

The main motivation to have the RTC class driver is the RTC alarm
(discussed below).

As for synchronization, virtio_rtc also offers a PTP clock [1] which will
be more precise, but which needs a user space daemon. As for RTC-based
initial synchronization, my idea was to propose, in a second step, an
optional op for rtc_class_ops, which would read the clock with nanosecond
precision. This optional op could then be used in rtc_hctosys(), so there
would be no need for UIE waiting.

[1] https://lore.kernel.org/all/20231218073849.35294-6-peter.hilber@opensynergy.com/

> 
> The other thing is that I don't quite get the point of the RTC alarm
> versus a regular timer in this context.

RTC alarms allow to resume from suspend and poweroff (esp. also through
alarmtimers), which is of interest in embedded virtualization. In my
understanding RTC is ATM the only way to do this.

(I was indeed thinking about adding an alternate alarmtimer backend for
CLOCK_BOOTTIME_ALARM, which should deal with the CLOCK_REALTIME_ALARM vs
CLOCK_BOOTTIME_ALARM issue which is described in the commit message.)

> 
> 
> [...]
> 
>> +static const struct rtc_class_ops viortc_class_with_alarm_ops = {
>> +	.read_time = viortc_class_read_time,
>> +	.read_alarm = viortc_class_read_alarm,
>> +	.set_alarm = viortc_class_set_alarm,
>> +	.alarm_irq_enable = viortc_class_alarm_irq_enable,
>> +};
>> +
>> +static const struct rtc_class_ops viortc_class_no_alarm_ops = {
>> +	.read_time = viortc_class_read_time,
>> +};
>> +
> 
> [...]
> 
>> +/**
>> +/**
>> + * viortc_class_init() - init RTC class wrapper and device
>> + * @viortc: device data
>> + * @vio_clk_id: virtio_rtc clock id
>> + * @have_alarm: expose alarm ops
>> + * @parent_dev: virtio device
>> + *
>> + * Context: Process context.
>> + * Return: RTC class wrapper on success, ERR_PTR otherwise.
>> + */
>> +struct viortc_class *viortc_class_init(struct viortc_dev *viortc,
>> +				       u16 vio_clk_id, bool have_alarm,
>> +				       struct device *parent_dev)
>> +{
>> +	struct viortc_class *viortc_class;
>> +	struct rtc_device *rtc;
>> +
>> +	viortc_class =
>> +		devm_kzalloc(parent_dev, sizeof(*viortc_class),
>> GFP_KERNEL);
>> +	if (!viortc_class)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	viortc_class->viortc = viortc;
>> +
>> +	rtc = devm_rtc_allocate_device(parent_dev);
>> +	if (IS_ERR(rtc))
>> +		return ERR_PTR(PTR_ERR(rtc));
>> +
>> +	viortc_class->rtc = rtc;
>> +
>> +	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
>> +
>> +	rtc->ops = have_alarm ? &viortc_class_with_alarm_ops :
>> +				&viortc_class_no_alarm_ops;
> 
> Don't do this, simply clear the alarm feature.
> 

OK (sorry, was obviously very inelegant).

Best regards,

Peter

