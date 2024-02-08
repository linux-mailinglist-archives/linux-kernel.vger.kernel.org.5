Return-Path: <linux-kernel+bounces-58206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AF784E2BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE8729367F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCF478697;
	Thu,  8 Feb 2024 14:00:15 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2065.outbound.protection.outlook.com [40.92.74.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F149A763F4;
	Thu,  8 Feb 2024 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400814; cv=fail; b=c64nm2Lp9S55AkSQKLRu4a5N2CPDMOwjmOvoSoKIN+wFPjXhZKuII5UNv8G6xYobHRvUSUbFOpQc5CGRtyNAg9B00OSrmWNx1HtYBAXgcDDRjs4DK46/3loOz7Eq7h5C9A5ll6fKhhs7luTb1dWHRyIagg8ItnQ1Lv0O3njvIr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400814; c=relaxed/simple;
	bh=s51P5mCIP689LwtbZiNR1J4GKnrXrTNVybQg2qWWLfE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VZCaNP3jkU+gwR+viAD0YkobAzWyaPUosXoyJSp+KsNWEpquObo0SkQITLEQGApR2n6BIMHgIamVOSRSBZmSWJ3El2Y8OzBdGEvBenZ9PqfImSs2fAlFQppme0RjlfNUiT7BEirU9kRlcP/qmVBy9Ck003cV0TtoRb5kp56aerE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; arc=fail smtp.client-ip=40.92.74.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQLogWDEI6N1u6kcGSyUzhIp2Obg9st8jUZC5gfFpMlIjMio90Vb2bnld0oi7jO1DlmFLtEUDL54hJh+rG+0Jyv8/02GabJlp3fCefSY6pKzkmpRfz3dslgiFp8+ZnDpNZYhj+hh3TAgbPHBN6kz67OrWV5fA0a8s126SAotiE9POfFyg7+YaV8oeLyCni9B0SwAnvrwTYesNe2bd0KPV4MEXtoDEQvlZtw6Kh+LQxspgHFrWcIm3kn4Fz2z1tYjeE6+llRk9WTRCKDzBdpWSJ5vnDuf+wwG3pEIxYJz2r6hSrKb7Dwv9usEpZbjjStX4ylxZKstF3LAuO7DG0mNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFQVvZ5C2382NWakWuNfO+UVhXu5iMC4JKT45+HGkCY=;
 b=U4qSbJ/fYPefQDdmhJmZjFHwHOXC34HArHUeGoAce4spPgIyIRxOiavu3L3240gNugG0fXiiOsp7hQknHHWJuJAxyMHCT20PfmczXHEPPDbk2vZ1UZ7I1zbhQpMFsEt7pWydPYzZARXfGYg0sWa53k6AkFGAFISTT7+RdnaLqICV5zyrkWmtc31OKLsSdKKSLe8i1jJtumWk7VkuinKzo1ViVDzDlwL7tT+velf4VN2vZSvphDux2a1pofanBPny0CK9P1/G4hX1FXXdA+8Yt6xJlnJlU5i7iMekEk38EvRtIlvbxTWBD8rAUaghVSsfAay1YzKcTpU0AeOhJdltrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by PAVPR03MB9212.eurprd03.prod.outlook.com (2603:10a6:102:32d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Thu, 8 Feb
 2024 14:00:10 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%5]) with mapi id 15.20.7249.032; Thu, 8 Feb 2024
 14:00:10 +0000
Message-ID:
 <AS1PR03MB8189A24B92030AA8F011C7B582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
Date: Thu, 8 Feb 2024 15:00:08 +0100
User-Agent: Mozilla Thunderbird
From: Sergio Palumbo <palumbo.ser@outlook.it>
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON ONU
 SFP
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AS1PR03MB8189AD85CEB6E139F27307D3827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZbZn8oCiyc1aNPuW@shell.armlinux.org.uk>
 <AS1PR03MB8189B99C360FB403B8A0DD6882422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb0t+zKHx+0wTXH5@shell.armlinux.org.uk>
 <AS1PR03MB8189D48114A559B080AF5BEA82422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb1+p6FiJwUF53xc@shell.armlinux.org.uk>
 <f8cf41f2-4a90-4ef5-b214-906319bd82d4@outlook.it>
 <AS1PR03MB818911164FB76698446CFEDC82472@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcI+7grKa33oLtwc@shell.armlinux.org.uk>
 <AS1PR03MB818926990092981B0E09E60B82442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcSZtLSWd09xqc10@shell.armlinux.org.uk>
Content-Language: it
In-Reply-To: <ZcSZtLSWd09xqc10@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [Dh2hTfkmt377C10+11oGgEuSXmdmbu6TWJbwp/z1L30vtlTv+obqlw3ixy3JyZq0]
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To AS1PR03MB8189.eurprd03.prod.outlook.com
 (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <0a366809-c3df-40b0-b59e-766249291916@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|PAVPR03MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccae740-904a-4fdc-9044-08dc28ae4396
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gJjOJVSBhAu0T3Ef/xT84R9hE//At6t83PXvTCbVd/9PbWX54xFeGouYOeBORN5JxX9UP6ph1aYV15ZMpU4Gs6TEiWLv2aA96V17nJ/4Op/vyPvg6U4+jCS8qSKi3znmkgRCPu2BC9KN7rInt3YSUal2GyYySgQksdIr6Myl4n9p5uBDQepmFKzIyIcla45Di4sflRO/6qZO79FTgUcaO1e2qSdxfhNBRkqETlFUk6QuckuZeoYgOyMdAr48pltFIiawqEOhIezKK0eEF6fM/DFbzjewCUxQwiA6gbdQ7U6gW4nQqQ1eEw0bI/NOvhpF9yWGfH4ho6paPFSsyL5h+Sns8ZKTxvLiuu82PJCtO72NhiY+QaFV4CBhMD0dlAg+/txVJxV7oaz7PXtyNrVn4necOcwETNS/5mXk1wfIVQ0hzez9/dsJkpfrjrDelZ/DPBKC7DZd7lhaeATTz3U2z2grM9MmSHEYwmvZde/+zsZmk0RtDLdIUUTBnjPLR1e0nJAuUpIezK/QHHRsm8qM0rtcUss9DIcQe4A/W47uBjbgCyaPbvoBxLN+Uks1FW1s
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW5TdnV5NXF2ZFlXeWZveCtSazNPL0pWK1R6ZllpMUxFRURhVzQxaG5IcXE3?=
 =?utf-8?B?SzRWa1BZZFdHb2hCanRHNlFvMm5nSDNEOEx0dHJDcGxVeGVkbzdNWjNnSmlk?=
 =?utf-8?B?ZVJ0Q2xmMGxCUUh6V0V1c2IwUjZmSWtqVnc1RlkyMFRTUnFaUTU2c3BlUFBi?=
 =?utf-8?B?dUE4a1lORDdDcytKZUsxTmhWaDZUOFBDVkNoZVdFUmlPL1Iva0tvb2ZIN0hv?=
 =?utf-8?B?WGo2aG5ZM3FoSGxyOWFOV3FhUENXSi9EL1pBck5nUDdsWUdtczhSdUNCSVVP?=
 =?utf-8?B?NzVPcGI2cFNHVTEwa0FxUEdMZUEvUlJ3RDdJa1c0Lzk5TTlERC9SelZ5WFJF?=
 =?utf-8?B?N1hHcnJqZlNraUNWVERVSkJFZnB1RGxmYWhSSlg0WEt4QnFIOFo5T3FvUjJP?=
 =?utf-8?B?NGdrcW1CYWVOMFlFdnJscyt1OEVkTzRoZ2lvRlpuWTA1bUJWbmhCNG9QSnBm?=
 =?utf-8?B?eHJpaFpneGtoOFdQam5QaU1ZL3BEcTZZaWYvckJMVlV3L05NbjNxeXVleU5j?=
 =?utf-8?B?UGd3RGFVZldlWlpWeTlaQVBkTDQvUWxYcWtuSDRjWnlEZWtabnU5RW9YR2Rr?=
 =?utf-8?B?a0FUQ1Rmd1NwaGdYUzMwVUV0Y0VQdW90YU9mRGZpOG45T2t0RmNDSit1bnFm?=
 =?utf-8?B?V2NwczNjUjBzZ1FkbEV4enpmT2FsbmNFbGVXT0tHS3NaVU1WN0xISUZENURq?=
 =?utf-8?B?ay85cFMySFp0UFhSc3ZXUXNhM0cyeUFSTG5teWhTc2ovWUJQSE1RdFBVazNB?=
 =?utf-8?B?ak9jVEN6NDdHejE5OVBkY2JSeWQxQ0s5cWltY2czblVHN2dsRVN5Q2Y1aS9O?=
 =?utf-8?B?V1B0L1NUbVJMRkkzM0tUSkUrWlcrTnNqeVdpTFl3MndPYWRNNE1qSUV5cnRM?=
 =?utf-8?B?V3JMRWw3Sy8rbWR2bld2dFFDYUYwSlRZTlp1WEorUkc0djUzOUpudFcyUFJM?=
 =?utf-8?B?YWVHMUN2UUd3Zjd2L3YwdnpBZ0p5UDMvR1cxUklua0dlbU5BRjBWYSt4SUx5?=
 =?utf-8?B?YkhYbVFGV3ZROFVub251cURVK2xweHFiVGdncXlCNnVuR0VzZWQwcmg3MHow?=
 =?utf-8?B?UU9adFRoWFFVUXlMQkplbmdJbk9HdU5aZEVKMTZDTkRZdyswQWd3M29JWmNP?=
 =?utf-8?B?cEIyNmNyZTZnMlZ3d3h2ejhSOUJTYXYvbEpaMmJYODRBMk9sWjh5ZThMY3NE?=
 =?utf-8?B?dkZ1K1AwZkQ0QnBTc3RVVEJLQmVET1JtbTBkWWNWZU1UQzJ6YTF5MjhBVjcx?=
 =?utf-8?B?Yk1TWjcyL1FnRHNuTVh5Yys2Y1llc0dESjd4dW9yaGtWdW82VjMxaU5Kekw3?=
 =?utf-8?B?N3c3RmwzbXZaTHVubWRMdFRsckZpNGpJTzhmcE56Qm5qZGlYelo5L2pnbzQ2?=
 =?utf-8?B?QVNRL3A5OEprbFlua3pYZklhUVFYZ1RJT1cya2ZDREhVeXd1TkR2cld0M1NR?=
 =?utf-8?B?bnBlaXB6bXE1cGFRU0l3d25sZ2NudU56Z3hET1ZjdXJKV0NJdmFxQUNCRWtY?=
 =?utf-8?B?K2R0SHptaHU0RUhUeGdUSTB2a0VWRUVBMS9JUjdBOXVxWEgwbHVZMlRLN25Q?=
 =?utf-8?B?UTRjNkx6N1NBMGZTQW43bCsyRlpJM2EwMmJWYXNBeU9nVWhDaTExdDFuMFJ4?=
 =?utf-8?B?QUhoMG5WRzBuaU1KMXlUS3hXTStIc2J2K3lta1ZYa1lCUWNQMEVuVVIyNjNo?=
 =?utf-8?B?UG9IM3VKbUJMbmZHa05zNE8zUnk5Vyt4Nm5QakxURFRhUHdyQnhxcWJkNXVQ?=
 =?utf-8?Q?4qP1x2IrTEk/bqej+A=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-76d7b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccae740-904a-4fdc-9044-08dc28ae4396
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 14:00:10.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9212

Dear Russel,
this is the first time I do such a test and kindly ask you to help me in 
preparing it.
In my openwrt environment I have found phylink.c file in two different 
directories:
/build_dir/toolchain-aarch64_cortex-a53__gcc-112.30_musl/linux-5.15.137/drivers/net/phy
/build_dir/toolchain-aarch64_cortex-a53__gcc-112.30_musllinux-mediatek_filogic/linux-5.15.137/drivers/net/phy

do I have to change both adding a line:
#define DEBUG

before the first #define line:
#define SUPPORTED_interfaces \

and then rebuild the system?

Thanks in advance for your patience in teaching me something totally new 
to me.
Best regards

Sergio Palumbo


Il 08/02/2024 10:07, Russell King (Oracle) ha scritto:
> On Thu, Feb 08, 2024 at 09:30:48AM +0100, Sergio Palumbo wrote:
>> Hello Russell,
>> I did the requested test
> I asked for it with a kernel that has #define DEBUG in phylink.c, but I
> see no debug messages from phylink in your quoted output. There's no
> mention of what's going on behind the scenes, so this gives me
> absolutely no new information.
>


