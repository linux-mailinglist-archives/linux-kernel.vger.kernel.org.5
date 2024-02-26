Return-Path: <linux-kernel+bounces-81177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1FF8671B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3021C28344
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901CE383B2;
	Mon, 26 Feb 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="Mbu99xke"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DAF1DDF2;
	Mon, 26 Feb 2024 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944124; cv=fail; b=MDMtPPYeS4eCx/sp9mENPVY/jK4Hv4qQUPkCx+uATAqXCbRl643+aFurXc2S+eZBoJL3fD4futWrz8ZOCVxsAYH27mxicjEinOBzBcMLTfKkGtcHJvL3wdm9mcCsZILs2L6/1kifQp//IBejGgKuddCGavrR2c1BcrsD9ghSlZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944124; c=relaxed/simple;
	bh=gmV95yanGEVmr54e00x8cDTs1u2L08OS3U8q2cys8Ic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cb/nkQtHVeOAMjIAPwvdjvAdDb1G8R4fhKfO1wq0rdSInzS2H9sKBqRLbpuJyHjHw61Xmag6pKl0C8iEDgiKmhlOyM19gn7N6Xof8BWpD9bILAlPaCGSIesBAKNdo0YvKKGA/A+Uwl9RAlP+N7E3PEkbrmH+w4fziVDqs6/r86o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=Mbu99xke; arc=fail smtp.client-ip=18.185.115.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.168.141])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 86911100027D7;
	Mon, 26 Feb 2024 10:41:54 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1708944113.875000
X-TM-MAIL-UUID: 6b4ca7f0-7456-444c-892d-b0295237a23c
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id D5E6F1000040E;
	Mon, 26 Feb 2024 10:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kh0IAp09/KjVDQf0Jlcax7wAKmjfM2fQ5XhiTRvaIwOG5lHRemuQm6eWrwB1zloDp+7+In3TWNCRiJ08HgAWK3/f34a6CMX0bLuD4na2Tqg3WUJ/w9MdPONonHAXm/iOirOMzg8ZG16SNWH9ERWcmwEFi3O4vibe0DgqDzXkRdj/Ur0IikVqVR1WB4xw247D8CIm9i5D+rnd6xXW54hZfFy+ewPBEukanepO5uuUiYWhjd6ce1xGI5gzkHsUZZQQ8KKtSQyv0iwBc8AGZCgXpSmvOIfvWDWVhZvRWSc5T+29RqT7VM/fuaBguhbMFAAEtC1LwIkR/BRIdLjnfFl4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKElpFmBBKMTyzI5pIW0FKMe3jSL1IINxd2bvMXe1W4=;
 b=JmMpLzeC/3Ir8N9OtmlL4LinwfdVWkfrXu315twQQnJuuivZl1lQBPVjjPyBTX11sBP39IhSTbY+z1sjST7mtOpcVFk1gZJaLEwGafcfHFdxG8me7R6dBdh6Q62vI9iDPsMnrE4rjrinxzoY6YsmKKZAwW0BipxTg0A5RP5CDu4WeHEit6T5ICvj1Y4pw2LstMRbzWEZvvyrvtJ5cOIj+61Z3roadH9RHJVyyy5DoQNqPRpvZISPfs2P0HZZqb/PflWIS5/leBtKHVkDT+3O5UbOZ7/1bRbizVH4nY2CLjIPCSsACeA8puRuJe3hi1o6DNn7t7U+AtcgMmA905K64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <dff0d0a1-628b-4346-987f-94ceb4e08e93@opensynergy.com>
Date: Mon, 26 Feb 2024 11:41:44 +0100
Subject: Re: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver.
To: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
 Mark Brown <broonie@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
 Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
 <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
 <a7f80f14-e8be-47fe-aa2c-6b40a3fbebd4@quicinc.com>
Content-Language: en-US
From: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <a7f80f14-e8be-47fe-aa2c-6b40a3fbebd4@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::13) To BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:2a::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2581:EE_|FR0P281MB1756:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c56836e-4d2c-4258-fb41-08dc36b78b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qxupsptz+e9cvfwIqPCEgzm1R70UM+Okvaz20TjCkF2oHeAAJW0+RelV/G//BrZrcACy8p/9i++8YVZj5+5WafdmlsrjFe4Uzhz/gLZluYTOJJubWOZqtkoQKlSix+FClLPN2nY55VZr7F/+qEiZVlZznY7mkXLQpdiRT8fbJY986Yy8x4Fbqp5ubTIvS7pJh3O3pQZ636Rjy6SzMrbZRgNISFEU5eG2vUW60nj3hSdLu6epvrVhCHpAXrR2PClu/kXGFAe2wUkR24eaOVj5x0gn8Q5BjfodXGGvLHnYsv+Vs8i+mjf46hQTPOIh1RnKKvfE26z7Ddvlx+RbeAqkjOVSoiujXJgOr3LW81+wzlpPS+YUkD6eKsAeXcT2eHyrLT0UiE3VsSIZXk2yCemBGLgUqLQRK0yjEFs5loutrRprA761s0UDZHukAd7hiYwMj6yqpA/JqThhfwpU0b5/tlfE5Z5i0qBY+FfgHVB9V81c/X57fNwVVAo8t0d0NUBhR+TlynHKlqLAOgF4o6/g5NFJJbk30/KaGUYFm7VaXmXvEmwXazaSsfJpwE8DV5KjFfBJ3Ko3IFlogz2qEYR6bfsrQt4t73aFsyXL/epcKTrCTTkojBfjja9xWaXHBP/H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wnlkc2ZYYnNnUXdBV0dnM1MyRUtRSEErMlNwNzFTblF3N3N5TVlaZDlpZnpO?=
 =?utf-8?B?T0lNUkdpcGx6Y1QzS2hIeVNhUER1amJQTE8ycVhERGpaNkNheVpGcGIxQ3J6?=
 =?utf-8?B?Sy9nYUlCNWZidEtpZGFCVndnNU8zZ0x5ZTRoYXhNVmNrcmtoSWR3MHRHNTBv?=
 =?utf-8?B?VGl1VDM1WFJ2NFFqNkpXVDhEOENEN1A4eEY2MW02dVRDa3NVOGVTakVGeElL?=
 =?utf-8?B?ZGVWbDZzTUlsY3ZjWnN1L1Njdm04NGc3cE5yZjlUZUdZUzRMN0hZUnh3K1ZQ?=
 =?utf-8?B?YnJwdnhKUUp2UmJ4Q3lpd3Zsa3RiRHlBb2pwRElDZlJ5QTV6WVFmVm9BU0xO?=
 =?utf-8?B?RlZFb0lTWk5VWkc3azlTZmY1ZXNQZkNKNlVuUUYzT2ZxQnUweko0QzR1VThI?=
 =?utf-8?B?STFFQVpTRUJLYmlWak1QZG12bnlIYnlLdEZlemZHb3UyQjVrRUFtM1NQV093?=
 =?utf-8?B?S0NlTlNtcGVzMjNDY1JYS01DRmw2ekJGZm03VEc0YzFHU2NkWWUwbDJkb2hp?=
 =?utf-8?B?Mm9kTlAwUFhKb2w5dUlLV3ZGQzExVnNtYjNtSzBOUUh1WENqKzVzN1dRZ204?=
 =?utf-8?B?MWdkd1VQRkpkeElUWXFXWi80U1RWbXpLWFVZV3BpMGJUMUgxVngzYVpzTGlm?=
 =?utf-8?B?UW5DeG5kUEhOMVVuYkg4UzZRUDVwa0NCL0xkTU85T0xGb1RxSk5NT0VaNDJD?=
 =?utf-8?B?d2ZyQ2NHZUk5SzBYdGZHUHl0TUYxSENmK0hNOXBjMFlTZzZiMjBTMGtNaGNG?=
 =?utf-8?B?QUR5MUtYL3JndGppc1l2VXU5YlkvanVPTklKVXhaWFFDRmorTDdDa2V3ZkQy?=
 =?utf-8?B?a252KzhaRG9YcTZZNXVHTFIxYXBxOHFSNE9yZkcyNHZtNmNxb2QyY0hZenln?=
 =?utf-8?B?SFB0RHZ4WVpKTlAwa2pGT0pUNEtFVzdZRTVLMHNoL2tSdDNoY2xQRmtxU3dl?=
 =?utf-8?B?V3lUa3ZERitpKytPU3VWbWJJaTh1WEhqQlpMM3drZVJHWWxML2JBVnBncGdV?=
 =?utf-8?B?elE3cXBQVDJPWkNrMUJMNFZCU0NHZW9zMmZ4OVFNalVXYkhpR3NBWnM3RUdH?=
 =?utf-8?B?N2djTENXYkpyanM5UFFvN0VCaTUwdWhkN3BZcW03WUwydFdESFg4MnI1WEk3?=
 =?utf-8?B?UXdmTnNvRjBBODFlMmRoeWhDTTU3eWt1a0hncmxNajlldWtrWitMVkNuZTNL?=
 =?utf-8?B?dC8xbzBac2NwUXhLaFNVTXRROStac2NuQndkK2x6dW5kZUtuRUFqV0M1Y1Nu?=
 =?utf-8?B?cDc5eHYxdk8xZGw3bHFkRkN1Mi92eWV6dzZ5bVprR01hY2Q2WUJQWnljaFVu?=
 =?utf-8?B?Mzg2bjJHMjFta0NpTHdoU0JYT0Zua0s2WllWZGRwUGZudmdjS21NdURDSEU5?=
 =?utf-8?B?cmIycnRaUmpDY0FxUGFWWFRaYjhPbmV1ak5OYmdHc2ZmZlBHMmIzS0l0Q2N6?=
 =?utf-8?B?d1VOdGdndzRyb2xSWEpFWEFnRVVSbER0SXF0MVh4OVFDVjZ2dXVPUnFJZVZp?=
 =?utf-8?B?ZzhRbmZZYmY3c0RnL0RtRmxqdmIvWU1pa1lveTZxOEFLM3lpM0RJeHV2c1Ro?=
 =?utf-8?B?TTR4MERFZmd0aWtLcmQwY0FIWHU5TE1UUmloWjRpWnBLQ0ROdXRKQ254QldX?=
 =?utf-8?B?T2ZmV1R6aTN5VCsxbGFnUXR0MURWYmFVNUlZTlBta1Q5STArYVVOSEpPQXFG?=
 =?utf-8?B?RDY3TEFrc0VpTVpDLzhzR3N4YlN3alJZZWJBbGtKbjBPM3VpeHhpRmxkSTZa?=
 =?utf-8?B?MkRXYzlTSWM5VGdwTG9waHJlQ1gwSnBrL2NGVUtEVzRwSDUyTWNuVFpvVlpv?=
 =?utf-8?B?QnJiYy9QVVZQU2l1dHZ0NDlKT3BwOEF6S2F2R3d3cTFLbjdnKy9aQ2t1MVRp?=
 =?utf-8?B?Y2VlTDRiYVFsYzZUSUVGK0VlTytzSk9zdnNWbTN4eExNODFUMTdjQ05KVHZ0?=
 =?utf-8?B?UWp2TjIyanFPY3BnclBEeDBsLzBhcmxnOW94aGVoYndUUUhpYmtKZ2JZb2lo?=
 =?utf-8?B?emFuWUxqYW5vZTFHNURHNnlPQ01sVTloRjJ1c0V3NE1FbzBWdGxMandlSlZT?=
 =?utf-8?B?VndZTG5sRGorbElkRkRvZjlhVjlTMjBydTl2aDM2RURzcTZySUNKYXdJdXdq?=
 =?utf-8?Q?PyiXpb97vJm05klCOSqNiNNVm?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c56836e-4d2c-4258-fb41-08dc36b78b4c
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2581.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 10:41:52.5987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5leqguajNhXJcjur6XCqjD8jGoeIsLKm45O0Xuez1dDWG0yrRvHcSSQyWX8VUgGWd+Y/oygDyWRdql0qBOA1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1756
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28214.006
X-TMASE-Result: 10--13.718600-4.000000
X-TMASE-MatchedRID: VfovoVrt/ob5ETspAEX/njhwkdlRfU8ZlR7tN56aWVVjIOKZDN+g+0m6
	zKX/LJcmJ5xdl1rCNt7PziTkqPLBOmSA+w0UOvf9eJchdZcr1K24qAaN6svaSOEKbxqb5I/n56v
	0NFZuss1qIM5/H+TLbxuAJff7ZU8w7k43s4afRRFkvrTiSNWDZBiZKydD/SzE/JzGo2g2eJB09D
	YlOJop4oHrIjEgiLxLBiuKRLhh9D80Dh19drZKIh9J1/VzLQh9RfNhf90JtJ8weIyZbRlQ24XrN
	S+xKlbqsQO6Vch/CfbVzTgENjEoti1i3WRyj1AdO/mB2+12nNVaOxpgjiWHdR/88i/oAaosv1EX
	h6vyDXDbj/aO90uQW+SBh3nQCfKdQJx0O0bPeyU=
X-TMASE-XGENCLOUD: 416a23fa-6c48-47e5-86eb-bccab6c1d32c-0-0-200-0
X-TM-Deliver-Signature: 4E213F93288CB2E65134247492E4AD43
X-TM-Addin-Auth: 8Eh5zKfzAMxpLXF6s1FqEDKC+rMvBOvz6yQqsWZm/Eycn+V+f7iR0gr/m3U
	EMFI2sIcngtohiSjaF5oHCwlzQ3b2cVorLBYrFUw4OLphzyGx5PkbTDfRTxKAdeyD3zaIl0fxc2
	Qs2GJbjYo1jQ6cFg/FNXu3xRZw2XKzcPkuF7wSn64IPoD3kIOyCRpe1Nyo619f/R1ir+UNJyj0g
	hsJpNYP1c88SiVBVVll+JF5JdOvQB/1VDdE/lYkx8ho3V1NeoAynDz3yr2OWEqzRHq8h3U1v/G3
	eZUSJD2X0d81xog=.F12c5HQjFYrFci+TLx8WAUfllbLBskmOZ6ULhqpVLSnb16QF8CgR66+VuA
	U/VNNJXBQDwanmqjmx71kN6Lnbseo/kinM4LqNqPZUfTYn8vRvrVYv0eRHQR0FBpya9m22J9lYm
	rQ8ciLw1v693PbmQuwrimUXFPMn8vFR6g83H76QbBNpVJMIJ5ON7kiAF+uPyv3KuxUXQDcfB97H
	17IPU/+/PCc9TtVpC9QNggSMXHsx40j4eOvY7pkYy4otr9nRHayFMg4novszwT1PxIfP1GDW7PA
	uafLGb0QkHeeMkWmP3r4cqQ6SgJXg7WQ2wJyF3Am7u8zPeCF1cUdj0hMdOA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1708944114;
	bh=gmV95yanGEVmr54e00x8cDTs1u2L08OS3U8q2cys8Ic=; l=1579;
	h=Date:To:From;
	b=Mbu99xkeOTPPDVSJbiUNMkDB8Cm9ZYXgQQdr2klVN5F0DX46qvhx7kesD8XgTMsZz
	 4CKoiq3UU2sLM5rwRkycXgw/TvC7RFjBvFySbJeh457kDSzS1sh6CL3ZgFabmWyoOe
	 3FaUESoc+zbfYsGsoDrdSon4BU10eCaaw+LDWlDADOFxkFFUGF8hrXuNV3OveDSyMU
	 jX4bClLx8miWc0AcUZOdagsHSCm4J2BA6Rz2WqQRtMABM5zRDMT9ERxVt7OLbePHFJ
	 kCRV8rX4OfmEBIIZs2o01TFTeO09z/jDQSZebFvCYzyef8CtsN8ye2qWMWjgx0fQZK
	 lBOq0I6KxSVPg==

Hello Haixu,

I was on vacation, therefore no immediate answer. I should not forget to 
set an OOO reply before going to vacation.

On 20.02.24 09:30, Haixu Cui wrote:
>
> Hello Harald,
>
>     Do you add the "spi-virtio" in spidev_spi_ids in spidev.c when you 
> doing the tests? And any other method to expose the spidev interface 
> to userspace?
>
>> +static struct spi_board_info board_info = {
>> +    .modalias = "spi-virtio",
>> +};
>> +

I've a udev rule 50-spi-virtio.rules installed which does the job:

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

There are no other kernel changes.

However for ancient Linux 4.14 there is no udev rule and the board_info 
looks, there

     .modalias = "spidev", /* Must be "spidev" for user mode SPI */

but this is only for old kernels we're still using in some setup and 
this is irrelevant at latest with 5.14.14 where was a documentation 
update of Documentation/spi/spidev.rst.

Regards
Harald Mommer


