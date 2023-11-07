Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30437E4AD5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjKGVjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjKGVjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:39:39 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2133.outbound.protection.outlook.com [40.107.13.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D49610E4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:39:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtEoeXgCEzHuYMBfsY7LLmia/LUSPXuTSs96CggwtXnBKuoFjJ0JUHSyUqKHWhkgQtJU0MH6tRVLe0/+uIoZmkkdCZTXiBbVYnfrEDOKDLQL5UPicTvHwv3X9qxWWPcaz10PQbu8yLZ/+hIEO7D3tttZfuYBhikcQQxFhEoMT/v8XK2deUbGcDfOfQEIOJjSIuwqauifeopbJw1mWxKZ/PU63YIuWKgd2JDkdoLjq12VjdEatN/O4K0VVGxIa5/qIwrsPiYLWGj6z5t7DviW0gI5d3i35CbyYDXpZSdlsQIN3DzHYvkp0y/JLNLF9DXsJTpiOEOnlibON1KxgU1JoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fybiYHz5/7NLiNNaL0FgnqkzSQVuge5wpUSzdwyn6+A=;
 b=PmGPl5J5wt5UJyJtROi2eIKC8QYt9jOgUdWRahKPyvaAJZqheE5G9co2nWNsrQkOepZzQhmhj4S7qy0wYacSpPYzLxqzUcUAb8Q//zKyRANEeYCP7UxmQLmJE5PY5PkLd88ed0Pdtgt5zPf/PWnEJ4TB3Vcfairwu+e/AfG5vtnTUc5PrGs8wNpBSqF20J7o+e/Z7s2mWxC2mJGFEap/IYK8PEU+OuK1TJVWY36T6dnYYd4DSxev46oAXOsOoUW8k0O1Mr1uRaVltaHA7OQavQhnpLqEuRLGMDxRX53NihG/PHDbbxzVpk0A0RqdMRu6/YjHp9DWFYeBWvzbsAT7ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fybiYHz5/7NLiNNaL0FgnqkzSQVuge5wpUSzdwyn6+A=;
 b=l7jx0+sUAVTXUotoVDxB1guNCsrc3Q/2/7vmziKeI2Qg5nhdMyTUAtO4iVG3LGH5n0vxFCKZs2E1wbB5aMfD9JvYQtLQQVIEHydjYe1JQu9lBV+jvUKpL4zR0dHIsUVmhMHQn8sANkVXBZW0tatijvakAqjpkfK1BxmfHilvCqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB9PR02MB7257.eurprd02.prod.outlook.com (2603:10a6:10:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 21:39:33 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::de22:5b04:df31:2d87]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::de22:5b04:df31:2d87%7]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 21:39:33 +0000
Message-ID: <c67a4871-a158-b7d0-42c5-cd8f31584ab4@axentia.se>
Date:   Tue, 7 Nov 2023 22:39:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: drivers/mux/adg792a.c:134:34: warning: 'adg792a_of_match' defined
 but not used
Content-Language: sv-SE
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Philip Li <philip.li@intel.com>, kernel test robot <lkp@intel.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        oe-kbuild-all@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
References: <202311051347.7J6bthD7-lkp@intel.com>
 <CAHp75VfmUXgx3nkFR=dZqffOu-LSnU_9u9GRYy0bTPLcdYhHbg@mail.gmail.com>
 <ZUdFtJeXBtx/httL@rli9-mobl>
 <abdb00c4-c2f1-96e6-9731-5a1773099336@axentia.se>
 <CAHp75VeBgdSYE6=2q6kc+N6JDg_fy1Mc5DUJdJBmyZ8nnX8ywQ@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <CAHp75VeBgdSYE6=2q6kc+N6JDg_fy1Mc5DUJdJBmyZ8nnX8ywQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::23) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|DB9PR02MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4434bb-d024-4e56-8eb8-08dbdfda07fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqHu9+JoqEG9nNW5RGRU7TwDOmQ2F9QY6t9dS89R7c5vd928ex/zTUsaGTZOeOI1RWnURdZBffsXmjCGbDFWaEq/CGFKEhOnrjfrIgLSSednR/AR6bwhhpsz/FLnPR8Q4DVjRp9zgu8TsLUJWjrZzX6WdJYYsO4MtRX2OGn3TX0fwb4eg+H0ft+SH9qK8WfumQx3QRzOqyQTflJgA+antGCZW9kaVu5+XnYaG2QdkX4k703aAC0b8pY+4bi3NlTC+jQceI3q5E8s5TQAY0HPU59iv8lCcDqx/icX1Mflaa3cdREZVxUfLco1ivwQPMZbhrPOsfkVYZridaq2l7pBc2W85OPdiuDScy/KssUuxxYbbceX9RtnSXHlQFRaag7t471KoPemI9qpOzHbRVxOBVf20AWzzVCwd4NcQO2vw6mcypfDEFraLq3qfUgn2IQWMglS4bODu0TMVwG1U5193ASCBHd4VGQnHl3FAEGSvSMW/EZIRr2f/ClBrFUQ74xYb9TjguZHtLakY9Xg92Q97zKflLbWB4FKA3iDnYV6rAmNcwmMMiFOj+ohKCoWpiImv8TaqNCAvB3ao7hEb1f3M77mWeM52mGm9BFo5ei16S9yb78/U63rqZf2cvEdGQQPDzWrbvrEg6XBk8huZUIvCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39840400004)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2616005)(36756003)(41300700001)(6512007)(4326008)(26005)(8676002)(478600001)(6486002)(31696002)(5660300002)(86362001)(66556008)(54906003)(66946007)(316002)(6916009)(8936002)(66476007)(2906002)(6506007)(53546011)(38100700002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2pja204N04yb2VrWjZEc3h6MEdCSWZOWXBOUVBZVmZHREV2MHVDSFp4bTNv?=
 =?utf-8?B?QnR2blg5Y2pZVjJtaDNSamF6eENaVEhOM0R1UllweEUrSnkwWDMxdFVwcTQw?=
 =?utf-8?B?MitBeVJHVjVTRTdadVJZZ2dLU2lZbW5YUWR5dlJYbS8ya2dBT0lWam12NkZ1?=
 =?utf-8?B?cHNBRFBrQlErSjBCTDZrV0w2a1ZFUUlGY1NLWjF2azQ1bzRqa3lQdmlHci8w?=
 =?utf-8?B?YXE2Tjh4SkQ5NEZLVmIyTG40N3FxYWxRT281SjJoVnFjeUN4VTQ4UmYwT0l3?=
 =?utf-8?B?QU5GYk9kbVU1VXBydmJZc0dBUWFUVVNnM3VuU2NWSW5WZWZYNytTYkVKQ1d3?=
 =?utf-8?B?TUtlNk45OXpYd3FnYi95UTJya08zUWgzWWp4alQ4ZU9MNHd0WTFwcnZrV3Jl?=
 =?utf-8?B?WXRKUGY3YUM3aUZnZDdxNHdoK3dScmp5UnBwekNtNDVFVmlvd3pXZFZDOGNU?=
 =?utf-8?B?YXpoT1hXRXZFdXpKaGZHTEFnUXk1YjBwZHMwb2JlM0g0Rjg5b3pVNWczd2N0?=
 =?utf-8?B?VlNNMXBrTk96MjZ4T3ZKdElPMlJpSGJiMUt4dXNzeTJ5V3ZpZE12UGR3MGJ0?=
 =?utf-8?B?YmRsOEpLNUx0ZzllNHRYZkZLenBkRE9sNVV1Y2VxMUhkOU1hUXMzS0taWE14?=
 =?utf-8?B?Uy9PazJmV20zazZEL0FEd1NQTUxpQjZ0dkx0d001aWNFMmljcWc0aEpiMlpR?=
 =?utf-8?B?VEg1L3pWRDQ0eDRLMTBlcHg0bWdWK2lHZ2l6eklqc3ZSVWRvKzRtZHpxNjg5?=
 =?utf-8?B?b2FWZnhOclc4LzZPWDJtT2Y0cWZZT29QY3Fia09rU056byswVkt5VE9WcVps?=
 =?utf-8?B?RXNvakp3ckoxUk9ZcForK0JyR0JDcEZiZEw3YVR6c1NIMU92Qm9QcmVob0t3?=
 =?utf-8?B?SE9takFacUlwT0FoWW5mdzBzWjRwRnBsQ2J0bFhmTnV5YUtMSG12OFVnTUV5?=
 =?utf-8?B?dWJyOUFjODVuc2psM3RoZERSL2RvcVcraSsvOVEvNDVtUGUveWRFa2s3WG1P?=
 =?utf-8?B?eWhXSzVMN0FjelZTSlZpQS9PZTEvbnBwS05NbXF2alVaSTdGdjRaaCtGWHFY?=
 =?utf-8?B?Z1FaQWdpOGdONWNwZWVIZ2FUK3JUbm5CKzJzdm9RSlNJQXZPRGhpR05XalEw?=
 =?utf-8?B?dVRhZ1hEazB4MnN1eXV1UkJDOWRkWjJSTGthRnN6NWduK01zcmdaTHBRRGFj?=
 =?utf-8?B?S3hpRG1EZENKWTNXYXRWTzgrb1puVkNqZUZvaU03RHMzYTcveGJJdnZRMENY?=
 =?utf-8?B?V3ZIdE5Rd3hCbGREQVVaTm4yU3lsY21xTzZkUVY5ZVQzYjJuaGFhM09paGtB?=
 =?utf-8?B?RnVBYjdUOTBLYTFMS3Awd2Z0Um12Z1NtSzhWeUJVQjhqYllJUjE5NjJQOWtl?=
 =?utf-8?B?V3VtMHJqTUwxUVdGaStpRTNCSW10K1lhTFN2WGxNdVJvU3ZHNGxsSEhTeHRD?=
 =?utf-8?B?TlR5V1NiYklGU01aWGRJSFBuVXgwT0xSbmlXS1BoWGt2Z0tEVmE0WUNiT0M4?=
 =?utf-8?B?cE5nbzBvQS9DZjBUNk8rTFpvVFA3dEZoYm1aOXI4ZVFjYlVmQ0lOWXU0UTkw?=
 =?utf-8?B?cExWMExKSXg2cm52Qnk2aGg5RGlDK3ZhTlZWY3Y4NThydzhDR3JGa005UFMy?=
 =?utf-8?B?ekk4YUFGbWNqVERrS0hmWUFvUGdZbUN3TU0vWUE3a2hqbmNTRkFyTURQUUpa?=
 =?utf-8?B?Y3pwa3JNU2tDZTh2WFE2dkdIRldhNDNuUDh0QkNZVnMzakVPdnNQbmpWMXZy?=
 =?utf-8?B?UHY4bDI3KzJaSm1ZbUJnZ1plaHpaa1hPa1lPTitiTlhsb2JmZGlEWTlpTEM2?=
 =?utf-8?B?RmNuTVNLSkIxWkdPWHFRSVhZZ2hCNTZ0WW9SZUFMbkNqSEpiUy9mWUJRdng3?=
 =?utf-8?B?TnZDVm9UMzVLWVlhTUthcW9ock94ZGdGSTFYQWxCRTBJTG8vSkt4bkkwQS9B?=
 =?utf-8?B?L21ZVHlISDllWmR6VHZmcDlSS1Vod2VDZ0VoVUlqK3dHdFRRVFBiV0JiTGMr?=
 =?utf-8?B?OUZEV2ZLK0xaM05RWVBweHo2QTRmRGswQlZFckM1TG5PTGYzMlNhcFdKTElP?=
 =?utf-8?B?SnpNQWJuMFhtc0t6T21QMlBPZHlOd0JsU2d6bnpxNksyK2pEK2s3YUFpQVBS?=
 =?utf-8?Q?o3X6p/TkJlPUraFtpJALpSsl6?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4434bb-d024-4e56-8eb8-08dbdfda07fc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:39:33.5027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylD/Qp7b2h8nZJlDqIIxCfIzFiI9PC0eeemsn3TqmqOglcGVkedQLV1/rlGgZKbt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7257
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



2023-11-07 at 20:59, Andy Shevchenko wrote:
> On Mon, Nov 6, 2023 at 11:31 PM Peter Rosin <peda@axentia.se> wrote:
>> 2023-11-05 at 08:35, Philip Li wrote:
>>> On Sun, Nov 05, 2023 at 09:09:00AM +0200, Andy Shevchenko wrote:
>>>> On Sun, Nov 5, 2023 at 7:03 AM kernel test robot <lkp@intel.com> wrote:
>>>>> commit: e9e40543ad5b38b848879768359fd13650529961 spi: Add generic SPI multiplexer
> 
> ...
> 
>>>> I dunno why it's pointing out to that commit and some (random?) people
>>>
>>> Sorry for the incorrect bad commit, Andy. We will investigate this why
>>> it locates to this commit in the bisection process, and try to avoid
>>> similar wrong report if possible.
>>
>> In this case I think the reason is that you have CONFIG_SPI_MUX, which
>> seletcs CONFIG_MULTIPLEXER, which in turn makes CONFIG_MUX_ADG792A
>> "visible". I.e. before the fingered commit, it is likely that nothing
>> selects CONFIG_MULTIPLEXER with the given configuration.
> 
> The use of the of_match_ptr() is quite doubtful, no?

I was trying to answer why the spi-mux addition was (wrongly) fingered as
the first bad commit. I should have been clearer...

I don't see what's wrong with using of_match_ptr() in this driver as
CONFIG_OF is not required here. Why isn't the correct fix to instead
put the definition of adg792a_of_match in an #ifdef CONFIG_OF block?

Cheers,
Peter
