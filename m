Return-Path: <linux-kernel+bounces-101291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D487A527
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B356C1F228DD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80494224E8;
	Wed, 13 Mar 2024 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="RJ/U/29p"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34891755A;
	Wed, 13 Mar 2024 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323168; cv=fail; b=UdF8pv9ArG/y/vM6j4Cc7OAVbXl9eh6NeiatC5Kn6loVi+3dtkA8qnyoRPIbxI+KM15+Krx2MKD0LlKtOQ2mIbqOmGVBd8uIf0JQEofBgipjcmmZt8ChtUCSG2aK7dLN1DKbF+Rkn0Faq7QuE23/IE6aolPH+oNYI0PwP7tNr8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323168; c=relaxed/simple;
	bh=PXkc6Q1y/xLPmSCqmQN+MOUvO2eK6nBtrzgd2DXYvu0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SI5+IcN8sy9F2YgFY4kTB2raVw6PXF14LRZ0VzYR1JLjZzDMDWOuZYhWYEm45550lmUsdfUfO53dHHPL2uDavLoGCdGweuvf4OfmIVk0NyXiD7QMfZR2txjpACeAed0P6M8XVMTHxZZQ9PJu7IgR8Y9f6G75lBTGja6Vo26+R/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=RJ/U/29p; arc=fail smtp.client-ip=18.185.115.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.169_.trendmicro.com (unknown [172.21.162.72])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 93C6310000E32;
	Wed, 13 Mar 2024 09:45:58 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1710323157.570000
X-TM-MAIL-UUID: 24bcee42-aa17-49ab-82f0-b12532b9d98a
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.169])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 8B81510000E35;
	Wed, 13 Mar 2024 09:45:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iG0DwcSqnFssyNoib9eoMaOaBzQxpZVU8kTsg/DCCRAHrrl940rOyCyipebLVC1fjIkf0nKXgxo/UXyUbIAWsbSCttsLgMVMtMnsH9Elc9IacQWGbMIkMQeOeDj5P0Cpgx9KPEv/aLzIjY9grab8TU7Gu25Rfqdp2lzp75mtX1P9Yrwi208odtR/ryueItR2sAKSbR4KbHyQ4kBsbu2lpnYfURidYQscLlBwTFDGx9STwcjdP88rEtPSXpLY0cwih6OQpnSRgrOmKpC9xUHuuXU6iklYMCgcNI8PW2BSActLqr1jYJf7DZIwRPsbHES2foZbSLyDSgWn5wrM0Zq5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjIFzfyLzy1iqOL2tr8IkXMuhoShddoBboBjhNaJNP4=;
 b=lWjUmqg1M7f+OnwfEqxfZeQpLSVQDktNj4XqBXmJrj6d4+TTT3JMxdV0GkFzR+d7RBcpauoQO15pu/Ljh6lwAO5utYFflFFbTEIkIvoUIAZULscpWlEWUVw0eooosdPBQ8iU7oFFVuiHoRTfb+Rd+040sjKtHbVSEg9+EYAdCVv46df9gWem5XxwEsA3FKy7VJ0QdxFVdoTzhl8nALVbtywDmzodetraMmLHcbfIQ9NVoOVy26ko9Emp5f4zALjnT4V4yVqG7s8iUo4XAVxOmHRrhIUbk2X91ULXEne/qnmpLK/z8Ht93nzmCUtdHuvQwK+UnldY3yr5SWMd425fcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <d796d9a5-8eda-4528-a6d8-1c4eba24aa1e@opensynergy.com>
Date: Wed, 13 Mar 2024 10:45:54 +0100
From: Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [RFC PATCH v3 0/7] Add virtio_rtc module and related changes
To: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, virtio-dev@lists.oasis-open.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Cc: "Christopher S. Hall" <christopher.s.hall@intel.com>,
 Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "Ridoux, Julien" <ridouxj@amazon.com>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org>
 <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
 <667c8d944ce9ea5c570b82b1858a70cc67b2f3e4.camel@infradead.org>
 <f6940954-334a-458b-af32-f03d8efbe607@opensynergy.com>
 <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org>
Content-Language: en-US
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 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
In-Reply-To: <57704b2658e643fce30468dffd8c1477607f59fb.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::8) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|FR6P281MB3839:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd5ab4e-0400-4a6a-244a-08dc4342616b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uOkdJLBufJznSwzQXVdjqDnr2A7/mWfue6xXcznFBKShFJh5tuYo5D0jbjFoEuokQAqlXwSwhmI2nKpXd2u67T2yQO4ZV4/ze10idSS0gBSnl73hpFyBThFFeF7RH9faUZ+/Joktuf/RiiXv8yTGMtus/KCwGsiyZ2i1VbExweV58kt0kGmHsYlrEUBt6c/tcmExhd+LpxZdLJReDsEdOGZJxHtm6odpGtFU/pqPkrf1w1Y0xuWY7djVRuqxWvNf18UeRAy9HwaIBO4VPIqHXQyQyUEPFJXo0mBaTY6vLfGX78rE7Yrd6V+B1dnOpK8AwPP0xyorybwLzgQGRwQ2jAT0aTH38fR9zmv0IaMFM8DaBXgR6wylOzoEnc4ARXlxBn8FRtJd6CYRziy1A+KeXHan9mz0w72eon/1dWjZIXKGT18kpUW7El72+YU36PP8XKqauSJn4HyulUbpiGtV9S2oCnZ84sSHpMtnQGowBsGvNd57UkH1mpPKrPEDDPNxhONKvcUzXCWoWiKiNiYpBo7QjsWhozKBxrF0TKyhW4jSDICsFGkgSKvONC2ZNYcXbinUZvw+lOVmbl9Jr1uZtzHol4nEsmirRBld6Oa3aBI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGVQRVJLRHBmV2haMUl2bDdMVTBWQU9NZU0yYzJKd2tDOGFNYTlvcXlLR3Az?=
 =?utf-8?B?cVhxS2VKQjJNcnZUWFpUbDNrSkJBb29EbzhobzRXSjJWNStvTTBHeVlBcG94?=
 =?utf-8?B?TmxIRHgyQ1pSNW9tVzdpU3pIeTAwbDdhdDRYTTNGc0tDbCs3bTNSY2dmSjFF?=
 =?utf-8?B?eFhDQ2pGc1VvVGFseGI5eTJWalJVZVh1ZzlMNzJYMms2VlFrRlB0YjFkV2Nj?=
 =?utf-8?B?QzNqczVUdTRBTXEvSHYycld3SURONFY3UTdVbXJuVlFzM1JLOFFuYWhZWkJQ?=
 =?utf-8?B?Rk1ITm4rQ2F1ai8vYmZmeDVvWlhxRnppRU01a3RzMmMvYU9DVGhaZnZ6cVZX?=
 =?utf-8?B?S2d3M1cwMWZycWlYenFuK01VckVFWjhPMWV1c2laY3VUN1JGTlY1dndSM0da?=
 =?utf-8?B?WDhRSVdzM3pyMzV3Y051QisrTzRuUE5jaWlWQ2dGMVJ1dEowTW1qay9WVGwr?=
 =?utf-8?B?bGs4Nk95VjhBck11cWRFc3JoTUhDQmlGVFdxQTFCQWlzZ3l4K3lFRWhleFpq?=
 =?utf-8?B?S3FRSTlWZTdjd2REQ0h3dGxaWmNjeGs0T2lTMUJaWlNQZDcramZsNmNaUXNG?=
 =?utf-8?B?Z1RJT0NZV3lYMTVwZkx4N3MwYVVKMDY5VUs1ZGhZU0VXUjg1aURJR1JBSUZj?=
 =?utf-8?B?eEpYRUEzVlo1UEhWUnVLOHJGaTRiUmNFb0FSNjltb0JCRm5VWXd5ZkZ5dEZq?=
 =?utf-8?B?ZEZzMVIzUG9MVHRDSHpxaGlDU2pKNGhOa0tnN2U3cEdWZEp0MzI1UldhU1JC?=
 =?utf-8?B?Z0FUMFZ2L21rMU1zZ2Jad2o5a2YwdytTN0t4bGZyTHhsNjR5RUlhOVB4MXp4?=
 =?utf-8?B?NGpVWFZNSjVPZDY1bHhadm03dWFHNTBvWG85OWV0RFNvQzJtK3pJay9CUmNo?=
 =?utf-8?B?alIzY3R4OVNQK3B4OE5HSnRGVmJ4QktSY0kxQzlYYWQ4ajNEOHcwYkZZOEY0?=
 =?utf-8?B?MksxVmo4bXIzWi9pWEY2eG01dlprRWx0UUFHSmVsRWlPU2I4OW1BY2JZaytW?=
 =?utf-8?B?UWUrNXE5WGh5c3JlM1lIRmx4SWk0RWd5WjJ6Y1ZWTVFXQVBqa1Y1NWpXeXI1?=
 =?utf-8?B?ZW9kdGxncVR0VWl5UUNONGxLbGtERHpBVDI0MXloc3FrY2MrdWRTSVZuMm1M?=
 =?utf-8?B?eUhpRHVId0thcm5WR0ZDMGNVd1prcldZVVFzZWZHZnNwZDQ3cm8yVjZyVkRD?=
 =?utf-8?B?bnBSUnJVSkNyYTR0dTBOTzVFN2RZbGEvWVRSekpUYjJvWXd4TTY2Tm40RmFv?=
 =?utf-8?B?VE5hRG9HcXZZazBvMmRzS3AxUDluZ1BxaFlXV0ZGNytrZFpMbDlpUTRQT1Ft?=
 =?utf-8?B?aFg3SkkvSEdBazVYL1p4NFVkbXRYb3ZENXZZd3UyY25MZVZHQ0dhdGpReGIy?=
 =?utf-8?B?ZFROMXNvUzQxaW1LRUF5OE1VMnh6b3ZLV1ZHTEZSNy9aT0cxbHRYTTFkTDJr?=
 =?utf-8?B?T2t5MmRrQTE1K3U4VWNLb1d2SXU3cHJCck85RDkwYktyeURmZWJPZStmYlBj?=
 =?utf-8?B?ckpERmk0TEdCeXVNblZoU1M3RERxNlB5QjlZY0dHVDNEV2NmQmNWSnZSWk0x?=
 =?utf-8?B?YUc4TWRCcTg3N0s4b1ZEOGwyZ3hGSGtkaURxbXhYK1A5cTlycXIwNVgrby8x?=
 =?utf-8?B?NE9DelV2YzN3SDhIS0ZXZW5QeXBhb3V3b0lyS29mN3h2SVFOTStFVUUydmdv?=
 =?utf-8?B?ckRSYUFiRm9xUWM4Y0JIaEFaTWJEc09pZDdmR3NvMmhkRFoyaVZKMUdJUTdj?=
 =?utf-8?B?aEVOZ1k5aSsvU2swNFVZTDBkOE5DR2VCd0hGTEVxVVh2c2ZhN2c1ejlGaDJa?=
 =?utf-8?B?RWRkSXFYT2g0OVhLcVdWbWVZRzNWVDFsZytVY1huVUk2aXovS2tXQWtZT3NH?=
 =?utf-8?B?eEdhNmxIdzhLbUdYc01ESG4rQTNlSUZFcEI3Q1MyYUpLb05xQlIwUjhpeno3?=
 =?utf-8?B?T2VkYXZUUVYrcG1ZZXE4L3QzYUQ0a0ZJMjVVbVB0OGVJTjhiM0t3ZTMxYll5?=
 =?utf-8?B?UDlUaHJrcm9JNk95aXRXWk56ZmZ6VnZ0N2RGSE5UWEZOZW9XODg5NEV2WmRX?=
 =?utf-8?B?NDFFZVhYenRHd2Q5a2NsRkorZlhQVjhueVE4QjRRRUx1anJjZFRpVFJaak4z?=
 =?utf-8?B?ZFVqclpXNU5tNXBnTndpdE5kUGhpWDhPbHQybU8vRVJVc1FtN1ZSYmNDM1NU?=
 =?utf-8?Q?nDlndx8Gpl3CIWBm10eaOqCSdFKeUzSP1J0RujJNMMOD?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd5ab4e-0400-4a6a-244a-08dc4342616b
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 09:45:56.2599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MY/K99agy4E4iCWT/ARQ7zuveuF06J9hGml2lf/kDMyfVpQt3RAJGtYtvNATxR9n3xlGjmJH61vf1Q3sqtevrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3839
X-TM-AS-ERS: 104.47.11.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28248.005
X-TMASE-Result: 10--29.750700-4.000000
X-TMASE-MatchedRID: hwsFDxVJcFn5ETspAEX/ngw4DIWv1jSVpolXqDXvwwrQXKc7SWQXhV5O
	0ZcKtJ+3ZwtVhsMoo+es13uOHE2/TJ+6mDgGLOel6x+Q+uPsJqqJnltxZVUTwMhgx7IMKlK+A57
	5Fgb9o5XCGBTHaIx6t1MoTp7f0vYrSdh0GhWtPnkQ9JMcGBx+/lIzqo1F8yQSZ/Fsy/Dmu1OLOr
	/4qeMXbkMOBMsSXDvuDLK81XvTJQNrDuWoylbl+ro2KXQsvVZSH4dNxokwGCrPxctgaqKz4SFFg
	1hSC6gbHjM937hQG5syrPZ1IMi52Om0aBkKFibTXAeS+w5YgSWTR6juYHRwGYvXantxmoFYjIMg
	84C3nGPdUhbreRF2wMmWCN8o9r3PFiY4JxbOOO+gbRFHRBZMHlt0YEdszvuKOoV8iQCgGXwPmg0
	2aADwvwosa9tvll+RGtu2AyLNVwfXYXKnv16lizqPTEE7CIv/VxlZxoe7dBaF5sLHIpSs1+7AmV
	tWDTd41K/luJYJ4Wc3bl+lYKOWM6BigdDViTQPsX4aFYAMIYOVmuhG06IIbY4aDnV/nRqfTXDS8
	cy9aRfAiQqgIH6gqw2qGHmqs3EpjEboraSXRVqDtrKaVShBjmtosvoan1Q8D25MJwZSrJRdA2Oh
	CS0zz0KyMeSIPDso6YsRabQU5VCpVgGmsgmWE/GNYAx7C5BCi9V1e7G8XUgyK9Sr9beya4tv7g/
	305MuupoogdfVK+Jd4x1IUlKnFI1g3zDt1sv5WWSz4drjSLhUu7T7mRB4coRSKUQPSCOyeG3erY
	jBbl1+3BndfXUhXQ==
X-TMASE-XGENCLOUD: 0b6de900-dec1-4595-a514-b1d4ff51603d-0-0-200-0
X-TM-Deliver-Signature: B6048FD9759CCB852084A97F6CC55748
X-TM-Addin-Auth: /owzLet5oHJ0FGZ5Jif54RvmOWBXpd78x4bHjVaD80VPdwyH4HCuXjJOg69
	N1jZpSjw7uxHZqZ9lAplO6bvy9mknYB0ick1Jhh7mzNeoDQDrEpEeZmTy1xvWv+Nv97Pqzl6UxY
	1pPexlihwjWu3WhUPnZ5Z+/CtdRR5M6QnHDXlj/xabkWvnrQ1j3rgzQTKEPPlPI+0nlTj+nELVa
	Envpg0zbp0/9T5kT9UPco9+8bgzB3qks7dLJpzAVwxFTv41w5Rx2dq8qDTeeJs9fen6OaR4VYQm
	pFYbfWeD1rgaeXE=.pQBcZDOrVkUqSb+++bByVi87wJauXz0m76qmUFTvQujfAgJ12tJ3yaxLBQ
	2yGbV/WY4DmA+aUldMH0P9MVLGMwe9OLfeQVkXZN/vU2PByJ1YSkhOJnOUDMWkCUHxSCYC4rV7w
	80xRO6Y3fU3r2gmhIgGqIM8jXkkO8OrC+/yibzHYHQRj4pKh3vjATVLcJdvxVFL9EePrXXIvzOW
	71VexfrjizsNH3qsj08qptbUJlzxvppuVRWWESvGytcvXQ+AqsZNBqbmElFnRU+9gDdlhXVQzAv
	T9PvyLJgUBUshsX36dsRYbqnCpBczqqDSofft+fzfKbPNXjHTehKzb2/DVA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1710323158;
	bh=PXkc6Q1y/xLPmSCqmQN+MOUvO2eK6nBtrzgd2DXYvu0=; l=6311;
	h=Date:From:To;
	b=RJ/U/29pcUfs74gbim4kwyXaDx4DFrZhLLroflt1yOkp39r+9BQqfh2Bs7m+9zvWE
	 nKwN8RfJmMc2sBORdi9v43SRSWRc+Mj0qgCD1P4ilJDyJJ8V4OaRrNyA7YHH6rXvqt
	 too8A/jf0FJg/KVj5PoxNlCpqSCMKssnkPN6DYDfCV9vFkA+IYW5Tn+H6MeUfW9rv6
	 i+cm2/MqNc+j7tbfVmEMAxNtRFG8Q+hScurBWaSu0hxekaxvU40spLn+dsKFJ/GqM5
	 WhExu+uqfZ+rxMIxKrjXYEZ8+qcslXZMFrr4ee6hGBf0I8eNit4j3kGl0EGRn4H9g2
	 BT0foxj7XDHXQ==

On 12.03.24 18:15, David Woodhouse wrote:
> On Mon, 2024-03-11 at 19:24 +0100, Peter Hilber wrote:
>> On 08.03.24 13:33, David Woodhouse wrote:
>>> On Fri, 2024-03-08 at 11:32 +0100, Peter Hilber wrote:
>>>> On 07.03.24 15:02, David Woodhouse wrote:
>>>>> Hm, should we allow UTC? If you tell me the time in UTC, then
>>>>> (sometimes) I still don't actually know what the time is, because some
>>>>> UTC seconds occur twice. UTC only makes sense if you provide the TAI
>>>>> offset, surely? Should the virtio_rtc specification make it mandatory
>>>>> to provide such?
>>>>>
>>>>> Otherwise you're just designing it to allow crappy hypervisors to
>>>>> expose incomplete information.
>>>>>
>>>>
>>>> Hi David,
>>>>
>>>> (adding virtio-comment@lists.oasis-open.org for spec discussion),
>>>>
>>>> thank you for your insightful comments. I think I take a broadly similar
>>>> view. The reason why the current spec and driver is like this is that I
>>>> took a pragmatic approach at first and only included features which work
>>>> out-of-the-box for the current Linux ecosystem.
>>>>
>>>> The current virtio_rtc features work similar to ptp_kvm, and therefore
>>>> can work out-of-the-box with time sync daemons such as chrony.
>>>>
>>>> As of RFC spec v3, UTC clock only is allowed. If mandating a TAI clock
>>>> as well, I am afraid that
>>>>
>>>> - in some (embedded) scenarios, the TAI clock may not be available
>>>>
>>>> - crappy hypervisors will pass off the UTC clock as the TAI clock.
>>>>
>>>> For the same reasons, I am also not sure about adding a *mandatory* TAI
>>>> offset to each readout. I don't know user-space software which would
>>>> leverage this already (at least not through the PTP clock interface).
>>>> And why would such software not go straight for the TAI clock instead?
>>>>
>>>> How about adding a requirement to the spec that the virtio-rtc device
>>>> SHOULD expose the TAI clock whenever it is available - would this
>>>> address your concerns?
>>>
>>> I think that would be too easy for implementors to miss, or decide not
>>> to obey. Or to get *wrong*, by exposing a TAI clock but actually
>>> putting UTC in it.
>>>
>>> I think I prefer to mandate the tai_offset field with the UTC clock.
>>> Crappy implementations will just set it to zero, but at least that
>>> gives a clear signal to the guests that it's *their* problem to
>>> resolve.
>>
>> To me there are some open questions regarding how this would work. Is there
>> a use case for this with the v3 clock reading methods, or would it be
>> enough to address this with the Virtio timekeeper?
>>
>> Looking at clock_adjtime(2), the tai_offset could be exposed, but probably
>> best alongside some additional information about leap seconds. I am not
>> aware about any user-space user. In addition, leap second smearing should
>> also be addressed.
>>
> 
> Is there even a standard yet for leap-smearing? Will it be linear over
> 1000 seconds like UTC-SLS? Or semi-raised-cosine over 24 hours, which I
> think is what Google does? Meta does something different again, don't
> they?
> 
> Exposing UTC as the only clock reference is bad enough; when leap
> seconds happen there's a whole second during which you don't *know*
> which second it is. It seems odd to me, for a precision clock to be
> deliberately ambiguous about what the time is!

Just to be clear, the device can perfectly expose only a TAI reference
clock (or both UTC and TAI), the spec is just completely open about this,
as it tries to work for diverse use cases.

> 
> But if the virtio-rtc clock is defined as UTC and then expose something
> *different* in it, that's even worse. You potentially end up providing
> inaccurate time for a whole *day* leading up to the leap second.
> 
> I think you're right that leap second smearing should be addressed. At
> the very least, by making it clear that the virtio-rtc clock which
> advertises UTC shall be used *only* for UTC, never UTC-SLS or any other
> yet-to-be-defined variant.
> 

Agreed.

> Please make it explicit that any hypervisor which wants to advertise a
> smeared clock shall define a new type which specifies the precise
> smearing algorithm and cannot be conflated with the one you're defining
> here.
> 

I will add a requirement that the UTC clock can never have smeared/smoothed
leap seconds.

I think that not every vendor would bother to first add a definition of a
smearing algorithm. Also, I think in some cases knowing the precise
smearing algorithm might not be important (when having the same time as the
hypervisor is enough and accuracy w.r.t. actual time is less important).

So maybe I should add a VIRTIO_RTC_CLOCK_UTC_SMEARED clock type, which for
now could catch every UTC-like clock which smears/smoothes leap seconds,
where the vendor cannot be bothered to add the smearing algorithm to spec
and implementations.

As for UTC-SLS, this *could* also be added, although [1] says

	It is inappropriate to use Internet-Drafts as reference material or
	to cite them other than as "work in progress."

[1] https://datatracker.ietf.org/doc/html/draft-kuhn-leapsecond-00

>>> One other thing to note is I think we're being very naïve about the TSC
>>> on x86 hosts. Theoretically, the TSC for every vCPU might run at a
>>> different frequency, and even if they run at the same frequency they
>>> might be offset from each other. I'm happy to be naïve but I think we
>>> should be *explicitly* so, and just say for example that it's defined
>>> against vCPU0 so if other vCPUs are different then all bets are off.
>>
>> ATM Virtio has no notion of vCPUs, or vCPU topology. So I wonder if you
>> have an opinion on how to represent this in a platform-independent way.
> 
> Well, it doesn't have a notion of TSCs either; you include that by
> implicit reference don't you?

I think I can add a SHOULD requirement which vaguely refers to vCPU 0, or
boot vCPU. But the Virtio device is not necessarily hosted by a hypervisor,
so the device might not even know which vCPUs there are. E.g. there is even
interest to make virtio-rtc work as part of the virtio-net device (which
might be implemented in hardware).

Thanks for the comments,

Peter

