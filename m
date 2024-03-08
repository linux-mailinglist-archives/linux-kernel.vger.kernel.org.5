Return-Path: <linux-kernel+bounces-96836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9288876205
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9A01C2120E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C15154F86;
	Fri,  8 Mar 2024 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="BOcfflVo"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDFA53E01;
	Fri,  8 Mar 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893943; cv=fail; b=ZWAXeIpCnq696tKSbOvdWTFyhLe2tU3ZG0mkrbWT0vzzG1wkz8PeUxYM4pBJfJ3nMBq6FgObatq0ZkDLIXRpEROq534cPhXwiFeegFmWULZ+VDxLSxp93HnmIztOAmC0NtxJ3JNhEhp6YRHz/z1BQVz44fWjnH2/FcX16yhapgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893943; c=relaxed/simple;
	bh=C2CoK2SBXvqATY2UW33Ttd/DNF/n2s5E7TwQxAobdI0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QE42F3jGsbdhnytImymgnJmqCu2pH16aTsEi9qNL8SSDCm9TfoYWTrlGZUBGE7v2AdGbeWOBv9EoYTxwRRz81ICGH4X+7jmIhLtq60qzLSmBYN2xcCS9kVjY+KqTygcWcn/VvrFZ0oL9eF/DLrR9fWzoBQjzMa2Hp7ndaq4DDOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=BOcfflVo; arc=fail smtp.client-ip=18.185.115.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.191.80])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 4D09B10016AC4;
	Fri,  8 Mar 2024 10:32:14 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1709893933.528000
X-TM-MAIL-UUID: a53b319f-2d01-42e1-bc7a-6e28a4b2de75
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 810A01004553A;
	Fri,  8 Mar 2024 10:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbCyTm/GrE25lMgLIaOXx9GXQ7sPNgg3WgbeaCInaIeCvBze1Ah7rDf9cKG87BCwPP6aURFmkqGJ2PyarPH2r0Gf1Hcq0Pj2wp+V5bkimZYDdKMAY+i+W8jQ0UkQIml6CTqqV6kQdKULgMk6ccAzcfthPxuCp7UOWc8XEC/xP/AMMTCMETO+9qv3pm+FOPzPCCvrgJMkH5Hy6UJE27PDZnh2WtsuS3TOVkH5yHM1wVbkxyX50Z7+Ga3fLFR76mNN5kcxyTwOfMxCjpbG1hN6cXUmzT9m9wAFdxo9mLNko4854spDHCY/yZzp5ycVxVbNemRJFL5mUWt2FqgzWACyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NDBUKCcIfAuGP0D/0DC5QqQ+rexlBFUyKpA/56yB9o=;
 b=fScvVQVJT0rjIe921uEhQnwkGZN705qoUuLgtVuKWPv1prpCKatAuRrmMUDfla6B9lh06YT5RPSzg27j/le4cPyWjFH5B/bsU6nSugN9AlwXx2+OA3qIKLW5VJlYTU2JTHu0igJILzhYd3QQgO5K+mDka/R78VOlT/VGooy5vhLu58SY5YqqEsOssgjRg5gkPi/r/Drg3Azr+JHvUqemOm8fr3tWJogTifFzJhhIWUUFzN4BdkuaCCJDtIw4lDq/Y4otKQ7naa/Vy9M+iOOe4KelZjE/5aEDePolwskmUEWjMpIPhsJcv8ZMnypFNp7OF1HdEssV93hcGjYzYksr7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <204c6339-e80d-4a98-8d07-a11eeb729497@opensynergy.com>
Date: Fri, 8 Mar 2024 11:32:10 +0100
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
Content-Language: en-US
Autocrypt: addr=peter.hilber@opensynergy.com; keydata=
 xsDNBFuyHTIBDAClsxKaykR7WINWbw2hd8SjAU5Ft7Vx2qOyRR3guringPRMDvc5sAQeDPP4
 lgFIZS5Ow3Z+0XMb/MtbJt0vQHg4Zi6WQtEysvctmAN4JG08XrO8Kf1Ly86Z0sJOrYTzd9oA
 JoNqk7/JufMre4NppAMUcJnB1zIDyhKkkGgM1znDvcW/pVkAIKZQ4Be3A9297tl7YjhVLkph
 kuw3yL8eyj7fk+3vruuEbMafYytozKCSBn5pM0wabiNUlPK39iQzcZd8VMIkh1BszRouInlc
 7hjiWjBjGDQ2eAbMww09ETAP1u38PpDolrO8IlTFb7Yy7OlD4lzr8AV+a2CTJhbKrCJznDQS
 +GPGwLtOqTP5S5OJ0DCqVHdQyKoZMe1sLaZSPLMLx1WYAGN5R8ftCZSBjilVpwJ3lFsqO5cj
 t5w1/JfNeVBWa4cENt5Z0B2gTuZ4F8j0QAc506uGxWO0wxH1rWNv2LuInSxj8d1yIUu76MqY
 p92TS3D4t/myerODX3xGnjkAEQEAAc07cGV0ZXIuaGlsYmVyQG9wZW5zeW5lcmd5LmNvbSA8
 cGV0ZXIuaGlsYmVyQG9wZW5zeW5lcmd5LmNvbT7CwQ4EEwEIADgCGwMFCwkIBwIGFQoJCAsC
 BBYCAwECHgECF4AWIQTj5TCZN1jYfjl5iwQiPT9iQ46MNwUCXXd8PQAKCRAiPT9iQ46MN1PT
 C/4mgNGlWB1/vsStNH+TGfJKt3eTi1Oxn6Uo0y4sXzZg+CHXYXnrG2OdLgOa/ZdA+O/o1ofU
 v/nLKki7XH/cGsOtZ6n3Q5+irkLsUI9tcIlxLCZZlgDPqmJO3lu+8Uf2d96udw/5JLiPyhk/
 DLtKEnvIOnn2YU9LK80WuJk7CMK4ii/bIipS6WFV6s67YG8HrzMKEwIzScf/7dC/dN221wh0
 f3uUMht0A7eVOfEuC/i0//Y+ytuoPcqyT5YsAdvNk4Ns7dmWTJ8MS2t2m55BHQnYh7UBOIqB
 BkEWLOxbs2zZnC5b/yjg7FOhVxUmSP4wU1Tp/ye+MoVhiUXwzXps5JmOuKahLbIysIpeRNxf
 B8ndHEjKRl6YglPtqwJ45AF+BFEcblLe4eHk3Gl43jfoBJ43jFUSkge9K7wddB2FpaXrpfwM
 KupTSWeavVwnjDb+mXfqr4e7C4CX3VoyBQvoGGPpK/93cVZInu5zV/OAxSayXt6NqZECkMBu
 mg7W7hbcQezOwM0EW7IdMwEMANZOEgW7gpZr0l4MHVvEZomKRgHmKghiKffCyR/cZdB5CWPE
 syD0QMkQCQHg0FUQIB/SyS7hV/MOYL47Zb+QUlBosMGkyyseEBWx0UgxgdMOh88JxAEHs0gQ
 FYjL13DFLX/JfPyUqEnmWHLmvPpwPy2Qp7M1PPYb/KT8YxQEcJ0agxiSSGC+0c6efziPLW1u
 vGnQpBXhbLRdmUVS9JE390vQLCjIQWQP34e6MnKrylqPpOeaiVSC9Nvr44f7LDk0X3Hsg3b4
 kV9TInGcbskXCB9QnKo6lVgXI9Q419WZtI9T/d8n5Wx54P+iaw4pISqDHi6v+U9YhHACInqJ
 m8S4WhlRIXhXmDVXBjyPvMkxEYp9EGxT5yeu49fN5oB1SQCf819obhO7GfP2pUx8H3dy96Tv
 KFEQmuh15iXYCxgltrvy9TjUIHj9SbKiaXW1O45tjlDohZJofA0AZ1gU0X8ZVXwqn3vEmrML
 DBiko3gdBy7mx2vl+Z1LJyqYKBBvw+pi7wARAQABwsD2BBgBCAAgAhsMFiEE4+UwmTdY2H45
 eYsEIj0/YkOOjDcFAl13fD0ACgkQIj0/YkOOjDfFhwv9F6qVRBlMFPmb3dWIs+QcbdgUW9Vi
 GOHNyjCnr+UBE5jc0ERP3IOzcgqavcL5YpuWadfPn4/LyMDhVcl5SQGIdk5oZlRWQRiSpqS+
 IIU8idu+Ogl/Hdsp4n9S8GiINNwNh5KzWoCNN0PpcrjuMTacJnZur9/ym9tjr+mMvW7Z0k52
 lnS9L+CRHLKHpVJSnccpTpShQHa335c5YvRC8NN+Ygj1uZL/98+1GmP1WMZ6nc1LSFDUxR60
 cxnlbgH7cwBuy8y5DBeCCYiPHKBglVIp5nUFZdLG/HmufQT3f4/GVoDEo2Q7H0lq3KULX1xE
 wHFeXHw4NXR7mYeX/eftz/9GFMVU29c72NTw8UihOy9qJgNo19wroRYKHLz1eWtMVcqS3hbX
 m0/QcrG9+C9qCPXVxpC/L0YLAtmdvEIyaFtXWRyW7UQ3us6klHh4XUvSpsQhOgzLHFJ1Lpfc
 upeBYECJQdxgIYyhgFAwRHeLGIPxjlvUmk22C0ualbekkuPTQs/m
In-Reply-To: <0e21e3e2be26acd70b5575b9932b3a911c9fe721.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE0P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::23) To BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:77::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB3267:EE_|FR5P281MB3815:EE_
X-MS-Office365-Filtering-Correlation-Id: 4509387d-3d31-4514-7d0d-08dc3f5b040f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	46Cef4S+HykP4u0yo7N9ziwpCsJ9hTpbMA2vGr9kMBEsY+HCZ1QqL9ZrCxLsnFVi2Bzv/bfqRTRp9FDl6q87i3g+h4Gy18v8oWUyHuVN2/60wHIf0a04OOOR7mLguboZ451sHyTXnluyFawPQ9rhi+t6f0d5/Y4oNDNaewsK7mQQ1CoUuQU7A5VzgL0OOQpnAfdF/9cAEUU8RShfnVKj2vMsCcFhJL27unYlwYnyG7Y1/mQmbjq7QJbzhc89kEYwW5GCYboeaGeSnSbJ9rpjCdnjYYnZC57dnUQGwsA1g/WradDw1mbJIb1NcLyEERqlEE/cr6HkwPBwBtRE2bpQ+7MM0ZL31kjhjXakdbkpS/fSoj+poIHip7Db2/TQN+HejDlwwRNX7uB3ofl1KZbFUb0G335ZHxocXwD3D5SkxfPOyOHBwnV31aSLfui8A/5Ag+p+bZcAFnVyWHTy6gFqVkYRt5m6iKvocoo4JQw69Y3JUyNm7eUlZmheUwS59WigyKN+BrQ6HrRGZJSKNXSQsmy1K6mEOojFFgddUc0KIuz8oQe5WuFYdSZAkimWscz+nHDuEAqSkH+Qvqn7s3xfslcnC3+5z1zSTrpcczujU+OzOIMjOnaiIQg29joRkLdKt7ibjCrvjS4mwi6A332NrC3cPAeGAN9Lc2Xd/r7/xSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXIveVRLa3VJRU9GcW55VHQwc1h0YVZEaTEwaFBoT2NrWWdkR0xPOFArSW1v?=
 =?utf-8?B?SHFmZU5ieUIrTnJta09NbU9kOGI2eVYxODlWOTNEZGd3NG5rRzY5S0RsdlBV?=
 =?utf-8?B?QlRaWkZHeEJEUWdlc2VITUdGSktRNGNCZ1N1SXVMbU9Zb1lJWkdkT1UzdXAz?=
 =?utf-8?B?ekFRL0tBSkptaGNLbXBPUTR3SzV4bmRzVkU1VFdaT1hnK1Z3bVlhSyszb3NU?=
 =?utf-8?B?azQ5UDd0TGxsY3JXOU5yVnpLY3hySytLV2hyd0NMZFlBL20rVmhiRktrRnhx?=
 =?utf-8?B?SVRTYU1SSys1bWVQVHlyMGZZTWcrRUlycEwzdFcxS2FiK1NyWUhrZnBHT0t6?=
 =?utf-8?B?NGg4bFVKMnQrUHVoU0FvMHdyU0VYa1g0cGxsMEFQcjIxNzlWMXFkbEg1UmdF?=
 =?utf-8?B?elJzaDgvZUJsU28reXdXaGFGWEJ3bkhjY0dwWis3Ymw0dDUyYktndXVvZ0N5?=
 =?utf-8?B?b3RDUVhFNy9YaVZEVWpvcWFKQW1CRFBSS3pWNDdYTzllYWhWbVpwTkJwcFJi?=
 =?utf-8?B?RGpudGM0dDRZaUVReHlIbzNpNE44TzJ3emUyZ0JHekVMUzgvRm9ZeWIyd21R?=
 =?utf-8?B?eEVWUGdJTTQzY2R5bWNVUGNjOERWb09SZUU5dkI3ZVBMeldOK3B4dTJOTXlP?=
 =?utf-8?B?Tlp2VXRQVTdUWDloenVnaG9VM2NRNWJGcVd4eGFDL1FQdFZnd09lTmlycmhZ?=
 =?utf-8?B?VXFvM3NnVDEyazlZMkRxZXh0Q3hSaHhPVWtPLzU1RW9RUFllS012WWp2ZEV0?=
 =?utf-8?B?anMvaS9kdkppSGhRSDc1aHpOZXdud3ljTG9FSk80UUlGNSs4SDZlUHplTHNo?=
 =?utf-8?B?blVWTU1hNHg0R3Urdys0WXJjbk9iMElSQVBGbGY1Nk04M1RwSWNxb2lGVnpZ?=
 =?utf-8?B?YW1hUnVDMW96cHIxL1pzWFpwY2FqNk16bUEvcjNvejlmcTNDMFZDMFNtTDFy?=
 =?utf-8?B?a001Zi9mWDdURmo4M0U1ZUI2Qk9KR1BRNU5NY0VROEo3TVdZOG5RN3UrSnNl?=
 =?utf-8?B?Zmo4a1ZDQ0M1RS8yek91ZjdiZnlETHlhZXBVVGRRcmgrZjFoL3EyMVVCc0Ev?=
 =?utf-8?B?YThTenkyeWFkd0VWUWVHeHQ5QWNxdFBlQzYxbkFXR0FDMFpKbWlvOEdsbXVh?=
 =?utf-8?B?RUl3YmprL2I2UzJGRVNYU0hpMjBQY2N2b3dYK2twZ0FZZm0vb0wwU0pJb3Z3?=
 =?utf-8?B?UEtBQjVxbExXZmRTV2JHcXQ0VE4rTHRMSlV6V1lTUkNzeXM5QW16My9YZDV2?=
 =?utf-8?B?T1M5L2cwQ3RHeURrdy8rZHdybnZUa3JONzNoTTFrak5KYUhkNE5PaVhMTDV5?=
 =?utf-8?B?MnpFYzY4VWp4aUs5S0hJVW9xaG9LTXY2U1BJNHlRNFdiL21ROWFhMDNFU1Ay?=
 =?utf-8?B?cC8vU01nZFNIYWJldlQzMDFKUEhyUjZveWRvSC9mSU94U1BacWEza05XTWpw?=
 =?utf-8?B?eENxV1BhSjJhWFZCR2czMzV1M3lKLzdibmVnNlIrNVM1RlpFWXdXY2VEMURC?=
 =?utf-8?B?bzVmK3k0RTljM2RSVzA1K2RkQ25nZDBSWG5nSEhENlRvUUR2R3VvVHBsdTAr?=
 =?utf-8?B?YWtqMWlYV0JWUzZsMDBQbnU5Q1lmNzVNUDlNRDBlUjZTS2JBakxmQVVpejBr?=
 =?utf-8?B?WnV6Rk9aUnpydUp4TG1oZUIxL0Y1NTZLVjBCdktLaHFlOENUbW9MdDhTMEtO?=
 =?utf-8?B?eFdCUFg2aGp0eU1LVk5ydzhoQ2Q4MzFWMmpmUnhZM1J5cDlBVitLbmppTGlT?=
 =?utf-8?B?WDhrdHE4aU55eHcxa1JhTElCSnJZQmhxdmZjbFI5TitEOG5kZkF4N2dabGdL?=
 =?utf-8?B?WWw2OU5PUjJSTHd3T1pWa0wzaXFObmM1SDlPL0J2dXUzWUlTQ1dDaGFUeXkw?=
 =?utf-8?B?YmZYSzdmdHY1V3JFcUh6aEVCSzgxdXl5Wk1yMVF5MWM0SHNsNktRM2FmZDJv?=
 =?utf-8?B?c3dxd0xDL09vWktMaVNJaUxWbVBIL2hvMkJkSjhIRXRpdUpTRDh5bWZjZ2Rx?=
 =?utf-8?B?MnlrclNCd21hWGZMeEErQzhJdWNTNUZuQzE5blV1cGpXTFdwNUEyVGkyTnpB?=
 =?utf-8?B?ZWRtUlYzQXRyMTg5c0VYb0ZxalMzTzhMS3NUcys2YTJqUm9nN2l0eGFiMGVD?=
 =?utf-8?B?T3FSNWdpdzArLzZId2VsdEc2UmZhL2RMTkJvbldUc1hrK3V3aysrQmZmbWNo?=
 =?utf-8?Q?ei57SEIOsNenXlKCrAeZPUYcAx4FqbHr9PV4iLmDlFGC?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4509387d-3d31-4514-7d0d-08dc3f5b040f
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3267.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 10:32:12.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKLcPPL1KDbDKL3R8MgmtI/FjfVi+LDiy9zJhL1R86qoO1m3XgvSLvVxMGSAG2bZOTM63eytDR7nHz8o5lL9ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB3815
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28238.007
X-TMASE-Result: 10--24.827500-4.000000
X-TMASE-MatchedRID: DuKherWvI/v5ETspAEX/ngw4DIWv1jSVbU+XbFYs1xJJXHHppxcL+guw
	LgBjpm/nnQvVnz410Dz6j/PgiNQvzcLotj7n0KJrI2nKN0pwPwE96LWLzASHpKhyOgJZ8qjDqcy
	Z1+bU/S3w2c8rBDowBch9DhE5g7fSpHdzONCglUTMcQGB8n5+Hk1PNCqyOwZWD++CmrqtFoBCVW
	t3+stKHyIgzteBoWa75OUqZsZPKy2ox866AU1GPY00PILgpqtbo4iCakRRMU3iP6mVQIH9OuQcu
	44gExj/Q+UQAwic8DS+9tKsfC/geOy7cHIDvd33MmIVY65PZO+DWVd0VaNM6B0zidHibHUaIHGz
	oCFPdPCvyWEno5kC/Hu1BDoohaIzKGlixfC+alV6ab/VNpF13WfFhrQRTFVCBVFM4/LXBZvOjag
	0/IdOhFLWq9BmBWr02LZ38qOZjytrHWQQ9NTqqjnP3JZqsdOaB4BMfq4SzeKHLFEWrGCxdZ6P7M
	Jw+qHxdx3wrdHBi+iTkCDL6LoowENxy9WmiY0xQa3X8PKJQnSexJFd1f8r+4ndKaJ31Y39S/dg2
	O/aWswxE+i/G78oxd5pHhRZTbY0olUad9BXhwKsDg0jvRbnNRqklYkipn3P2ubnxCjreJ8GSC3R
	rA2rwpFzg1Jj79WnrdFYBbKNQf4+o2z1dltgT0I9AEPfED/dqvJX/aNGr9cSCDdzAMeX/U7zkly
	hPTD9b11gIyjf/wu/2tJ3foSBQj4yqD4LKu3A
X-TMASE-XGENCLOUD: 8a437992-942d-44dd-b654-d3a619298a44-0-0-200-0
X-TM-Deliver-Signature: 3A0727CF23DD49DC8ABD40FE88146FED
X-TM-Addin-Auth: oTmLLLIkAo/nfxp3JMX1B3RWT0RAQLtliplh1XquqQxLKuFW1aEhlKrWeSd
	0QqNGen0h1tEQQJjopxDV9fBQLFx6UN6P4lL/FJfvIm00fN3W+vzqGzEZdeWl5aI1k+SxdpDfuB
	GK+leZHtPRQnhmUU3sN0BwYcUwcvX1Zf2oZCN+JecbnJEJSCnfZVIuEKUywmt2+Vr+JLQHVMT+8
	zE1nVjMY/OWdssWdMKMdqUGw7HxYTiXRE40OzaPSOP8GdadMfc6igm5CDv2yZzU808K11sAB9pE
	tNlJ+ROzcLzqE9U=.Xz6SSmcV08V4KeyS2QtGrr098+LWFWXDoIM4hH8VvgG92hGgnORApt/rez
	E2YGOBIleEbEM3C93+F3ZivwHVJeFFqvKSGsw2VDxdFJbWypZU067XMtQT9NSbI4mKRybaCD1Yv
	whbBnWUrQLK/hu3Klebv1Xxyf+1otuwrq6c5CYJ40zVpxVYuSvjg1CuMu/H1TqYHMSPRZcSKDOl
	+b8rGYpdphSAv/W3/AwCcmuGDFcyd+YjvXfkpjvenRiic+zXaCgjblq8O+5ClBDeL66Be0l3NRK
	ocja5eTurHIq8k/NxwxVapR0ia442I/gdmCiHrYnUo3TIES7msiT7nz2lXg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1709893934;
	bh=C2CoK2SBXvqATY2UW33Ttd/DNF/n2s5E7TwQxAobdI0=; l=5763;
	h=Date:From:To;
	b=BOcfflVoFUwVVuaCTjEUaMldyv+opXW6YwmqGV3hw5NiA0NbWB3XGrFMydDQZ5iZc
	 K1b5z1BJy6HuWF2jYdONbBdSGATXCfPoxtUe3MUbAMq48dJxSqMoF2ImVzp4yjy2TI
	 xQ0tyKNsbYz+fUDK58ROnH+ls9mA5MRlMRjdyeCwdznJ1Bz4aRuDDvwl0u4gr6Co4B
	 e1Uzi7jqRwVXYLd9cTeB77cFaQtTz+KTWz+beUm7z3nx8shP4vr7GQbrESNgMt/Dqc
	 2QitOHmLFLF+Iv3N7IDU8iHRdK0n4YpkyE+5KMIZTP/SseUzvfsNKaxhmhp5SlifdL
	 Gui/h6U54NMEw==

On 07.03.24 15:02, David Woodhouse wrote:
> On Mon, 2023-12-18 at 08:38 +0100, Peter Hilber wrote:
>> RFC v3 updates
>> --------------
>>
>> This series implements a driver for a virtio-rtc device conforming to spec
>> RFC v3 [1]. It now includes an RTC class driver with alarm, in addition to
>> the PTP clock driver already present before.
>>
>> This patch series depends on the patch series "treewide: Use clocksource id
>> for get_device_system_crosststamp()" [3]. Pull [4] to get the combined
>> series on top of mainline.
>>
>> Overview
>> --------
>>
>> This patch series adds the virtio_rtc module, and related bugfixes. The
>> virtio_rtc module implements a driver compatible with the proposed Virtio
>> RTC device specification [1]. The Virtio RTC (Real Time Clock) device
>> provides information about current time. The device can provide different
>> clocks, e.g. for the UTC or TAI time standards, or for physical time
>> elapsed since some past epoch. 
> 
> Hm, should we allow UTC? If you tell me the time in UTC, then
> (sometimes) I still don't actually know what the time is, because some
> UTC seconds occur twice. UTC only makes sense if you provide the TAI
> offset, surely? Should the virtio_rtc specification make it mandatory
> to provide such?
> 
> Otherwise you're just designing it to allow crappy hypervisors to
> expose incomplete information.
> 

Hi David,

(adding virtio-comment@lists.oasis-open.org for spec discussion),

thank you for your insightful comments. I think I take a broadly similar
view. The reason why the current spec and driver is like this is that I
took a pragmatic approach at first and only included features which work
out-of-the-box for the current Linux ecosystem.

The current virtio_rtc features work similar to ptp_kvm, and therefore can
work out-of-the-box with time sync daemons such as chrony.

As of RFC spec v3, UTC clock only is allowed. If mandating a TAI clock as
well, I am afraid that

- in some (embedded) scenarios, the TAI clock may not be available

- crappy hypervisors will pass off the UTC clock as the TAI clock.

For the same reasons, I am also not sure about adding a *mandatory* TAI
offset to each readout. I don't know user-space software which would
leverage this already (at least not through the PTP clock interface). And
why would such software not go straight for the TAI clock instead?

How about adding a requirement to the spec that the virtio-rtc device
SHOULD expose the TAI clock whenever it is available - would this address
your concerns?

>> PTP clock interface
>> -------------------
>>
>> virtio_rtc exposes clocks as PTP clocks to userspace, similar to ptp_kvm.
>> If both the Virtio RTC device and this driver have special support for the
>> current clocksource, time synchronization programs can use
>> cross-timestamping using ioctl PTP_SYS_OFFSET_PRECISE2 aka
>> PTP_SYS_OFFSET_PRECISE. Similar to ptp_kvm, system time synchronization
>> with single-digit ns precision is possible with a quiescent reference clock
>> (from the Virtio RTC device). This works even when the Virtio device
>> response is slow compared to ptp_kvm hypercalls.
> 
> Is PTP the right mechanism for this? As I understand it, PTP is a way
> to precisely synchronize one clock with another. But in the case of
> virt guests synchronizing against the host, it isn't really *another*
> clock. It really is the *same* underlying clock. As the host clock
> varies with temperature, for example, so does the guest clock. The only
> difference is an offset and (on x86 perhaps) a mathematical scaling of
> the frequency.
> 
> I was looking at this another way, when I came across this virtio-rtc
> work.
> 
> My idea was just for the hypervisor to expose its own timekeeping
> information — the counter/TSC value and TAI time at a given moment,
> frequency of the counter, and the precision of both that frequency
> (±PPM) and the TAI timestamp (±µs).
> 
> By putting that in a host/guest shared data structure with a seqcount
> for lockless updates, we can update it as time synchronization on the
> host is refined, and we can even cleanly handle live migration where
> the guest ends up on a completely different host. It allows for use
> cases which *really* care (e.g. timestamping financial transactions) to
> ensure that there is never even a moment of getting *wrong* timestamps
> if they haven't yet resynced after a migration.

I considered a similar approach as well, but integrating that with the
kernel timekeeping seemed too much effort for the first step. However,
reading the clock from user space would be much simpler.

> 
> Now I'm trying to work out if I should attempt to reconcile with your
> existing virtio-rtc work, or just decide that virtio-rtc isn't trying
> to solve the actual problem that we have, and go ahead with something
> different... ?
> 

We are certainly interested into the discussed, say, "virtual timekeeper"
mechanism, which would also solve a lot of problems for us (especially if
it would be integrated with kernel timekeeping). Even without Linux kernel
timekeeping, the virtual timekeeper would be useful to us for guests with
simpler timekeeping, and potentially for user space applications.

Our current intent is to at first try to upstream the current (RFC spec v3)
feature set. I think the virtual timekeeper would be suitable as an
optional feature of virtio_rtc (with Virtio, this could easily be added
after initial upstreaming). It is also possible to have a virtio-rtc device
only implement the virtual timekeeper, but not the other clock reading
methods, if these are of no interest.

Best regards,

Peter

