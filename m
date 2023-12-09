Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B8180B112
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjLIApx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLIApv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:45:51 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2094.outbound.protection.outlook.com [40.92.102.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8041703;
        Fri,  8 Dec 2023 16:45:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4jd7L+OzbasBI2hJODhy2aiY/wta8e3l3o4h3szXXQ/TJmnHLJOVraFE7kLoE/qirRjUp6icbJBKoL6FuHhiQ49fo/fpE+HZHQRsEatJh0sLkJXjA7/Iuu9VFy1wbwsYt4Ny1xJ2UfqRJgbM7sW+nwkmN01t5nyl9StW0vig9tFE4iPW/LFQFx8eiNXutOTUuqbZSYxfLEdaL4Mmrq1SNjBn3b1CktAHJyZSmt9Agf8lxTstwK+TfJHizDXOa4KRAzDQNv9i3TdGjIuNYW8OPueG4Bxsr+qIt+veEDEdBY+4tsQGM8WtsJ8tGUOhuQEAMKcVAj7XN/bgcZBQyR4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmgnLS4VCRGBuq3sXj+wQhh4bgITo5oy1SjAc5yNCGE=;
 b=SfS6NJnsqmMwAoHosHlqeZSIHtx+afepANq1ae72z7eVoxQdWxaY08LOSB6jZ0XB1d+3VSbYrtQrj5RPos25QhBafYs7SvOzWahuHWfuBweyi69IxyNp0AR3IM+z19lEPthAMYr+pgBO3G2Pds9mBWSGWDVWHvR3DlX8eCCAe3HqQg1j+CzluqbBrmZtLeNsSggjuev6wkmaKMchHsTxXLoXWju1TeI8leeW6lDqXoS5ZTVi0hXA+vvo11H77iotfEtfeXuik/Tnof+b9cw85W4MiZ6gq1LLIYUIK9t/QHAGKMP4SBuS3go8A4oTW79omBxBRicoL5xL+9SSuEcLZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmgnLS4VCRGBuq3sXj+wQhh4bgITo5oy1SjAc5yNCGE=;
 b=ibc7knpsosgN74kW67LIBA/98SAZFQvJ3vTY7KAt/ehYvJXgxZY/IdzO/Snmtaxppxj/DwC4h8sAywmxrTYyt+D+6Qit9EA2KQHtwhOEPUolCUrdF4TKuKoa5+UV+PRtjnCXjjBzwAWjYi2vSAMwGowUa83sVZDSy4L9PVVqlz4UnDKFMmeUBevPdcJK/056KdDHvxBIynB8EGtJFLfrwgKT0gf3KKMwTZv7DYdfkE7xl49ftqC93dTZ5OkZtJw2em20P37dijCxiwQUfO7PChkSDS33qXELCUVzAQC2x3Q4dA2MBPI5DcmA+WQ5j8Q2l13HrwuO5J9BxAzfEgmuIQ==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN2P287MB1962.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.29; Sat, 9 Dec 2023 00:45:46 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 00:45:46 +0000
Message-ID: <MA0P287MB0332B80557FB1BEF45C08D8BFE89A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Sat, 9 Dec 2023 08:45:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] clk: sophgo: Add SG2042 clock generator driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
References: <cover.1701938395.git.unicorn_wang@outlook.com>
 <975f9995584dfa8af751e96a1f4d2c7991551a35.1701938395.git.unicorn_wang@outlook.com>
 <c98c123f-1c07-4cfd-aeaf-ced7fe08cf42@linaro.org>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <c98c123f-1c07-4cfd-aeaf-ced7fe08cf42@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [D8PTCm3vgJrUBVCDrDqPw64CWxBTLpwT]
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <77199b86-012c-4265-8c5d-1666c9b5d26c@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN2P287MB1962:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab5f43e-9da0-45f6-47e0-08dbf8502ba1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cxeT9iY6sv2hvNcmcwU+1OLw+9ofzVzZcJE14T8Hvymu8/jI6tm0Q6ieUI5b80TNz7HdT8a44EXtN/idRpRr4J8OlK0VDb15SSDkPBER/9iXsWdSl2XFSCpdBlAQb1Amuyh9CeRcTS5ybgUzcebJW2GUGd+rRmgLqajADiTkNvptUvI5/dxw8zdnZzW5L+eod9Miux8QL06De2UQYx9CYZB6KYbg1y9pJP2lNIKW57flo4A3ZpkkjLpDlhlCcHAjE42ysgTq3zm5QC8miZymJbSB0YYtlQikXQE/fbus7cFBZ33DHOvEE/I8k5cbHnLhTNldn9e0jF+N8ljjmtWMJIQh+1Xh5t6P/XX4MwPXN3Od+uN7nf5NZF36VUQIZ3SPjwvonKr9XyEJkXLf/QJA91xsmm04Mqa01OWIYFLl2FWRnlJvzGPJTGaV0alsdf0s52fIF6SJwHOGltC9z8NXkQYTDyfLOnsrDierv+5bRwcHBHnOL36IeHcuN2aikMWgEKBrUh/QZkGeQV7wyfe4oxEcmf7TQyHsh9AP4jHXuQLFR03JlDleXRNfKvWQJHm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y01rak1UWkJNdS9Mb3Zyak9MbjJOcXJtZ09Pczl1VTlHT3Y3QUVKTm9RVnd4?=
 =?utf-8?B?K0NtdjRGUVhXbE8xMWxBNHVaSW5Pbmd3czNoV3BwZlAzdDNLVHczSUpCc2tP?=
 =?utf-8?B?UjJNc1dZVHhzaVZWdzZIRXUzd3N1WWlHS29ydXVMcE02T2lza2JBbnpvbldu?=
 =?utf-8?B?OW1GdktVcGQvRTVVUDZid1ZrZ21aMGhha1Btenk1QSswSVVRQ2E3ZHVFbGVO?=
 =?utf-8?B?aGxQMDhoaW45eGkvS1JzR01uMWZCZmE1cVY5ejNVUlU3ZG5GdGdhc2Uwb1Zo?=
 =?utf-8?B?ay9yZW9CR1dTWFZrWHVDVElxTmNWWERUTG5zR1ZmNG1rbTVSTmZ6QWhWeW03?=
 =?utf-8?B?VzJSelE5enJERG9LR0N6Ry92eGp6RldJWk1Rb1BWN0FwaFl2YkdVdkw4b2tW?=
 =?utf-8?B?NU1SL01teUx3WVh1Rjc1d21oS1FScGc0dk5xa2x6NFJkT1NKbU1nRHlrQWNP?=
 =?utf-8?B?VldmN1IzcWJ3d0JOdDZtSHdWdmFiU1V5ZXhGc3VJSjRNVkZaWFlqek5FNUFr?=
 =?utf-8?B?NmJqZmRIakRua2F1cWxGSkprTy9YdWlKZVNTTEJnYUxiRW8zaGRNVThOVTBI?=
 =?utf-8?B?Qm1jTkxxakRpS1lDS1MvTGZoOXl5akhDWFpWYTJxZXNhMElnRmJLbXE1YkFk?=
 =?utf-8?B?OXA3Wk5RM2NvVkkwemFQNXJ2enlTbnRaQlg4Mm14bnA5ZXhlZlJSa2tFRnBk?=
 =?utf-8?B?Q291eDFWdW9GeUtVcXBGVDhBZGYxaEU3ZEhsUlo1TVFoa3BLQjMrU3BrbFZW?=
 =?utf-8?B?akpFanF5clV6OVE2ZUdUYWo0aXJjc3lkWFc1eWlKKzJZWkw4WlVyK0lrSlVP?=
 =?utf-8?B?enRpYVNPNE1KcG9pWWRvTmFzb3ZRWHJSN2JWMzJQcHVTSlBiRmRIMG91aGpY?=
 =?utf-8?B?dGs0TnN3ejY5cVVTWkt5Y3JlTzZyTGJKOVBtcjJjMk9keDRnVyswY210MlVN?=
 =?utf-8?B?M2lObnh0R3ZGR3daaDFEbkpTeUE5c1dFb2pWdm0vTDRHQVdIODQ1cHl1ekpt?=
 =?utf-8?B?NkRrT21nd1QxTHIyblQzNHlTSlM1Z2xoT2ZHVzhndnVpaUlwaWFlQXd4RWVu?=
 =?utf-8?B?N3VlUHRxVVpzOGNCTXJmTEdmWDJ6RG9FZUsrbVdYRDh6c2x1ZHRhaGRzS1Qx?=
 =?utf-8?B?YnZkdXZBT2EzcmIxWmlpaU5GQkVBclAvOU1HTWUxZlJhMjdSQzBQYUpLKzBS?=
 =?utf-8?B?Q3hEUDZPTTNpZWhZNnUxL2l4RGFpZ1RXV3J3UnJ4NWE0YkV5TUdhczVMVFli?=
 =?utf-8?B?dGRwNzFSWDY3cDRBc051TVFzL2lkTzBleVc3MVV5R0U3RUVEejdVejQ3OXBr?=
 =?utf-8?B?eGZ6U1IvK3pEbjNXOEEzN1d0RE15L1VxTmhPd0I3dUMrM3hIME1zSGhzRVJh?=
 =?utf-8?B?Mk9ZdHZVL0Mza1lIeXoxY3Q0M2pPdzFQQVAzcUdoemNzeVpFZ0ZKSnBRNjdp?=
 =?utf-8?B?dlp4ZG5VaHFURUwxWGRoL1NjYVdPNk1HY0Npd002Wk84dnc1dVJYNFNjcVlp?=
 =?utf-8?B?VlF0NCtLYy9xZHJ6YVFhR3BSUEdtU3ZBVUJwMjRFZ1B3VUhkUnZZQVZxT1Ns?=
 =?utf-8?B?OUZWUkJoQzdFZ3pJbWFGSi95RHZ2LytvRHRXamRvdFpraWRZSUozeTM2aEV6?=
 =?utf-8?Q?N7X/1YPo5W2Pd0gok/2yG21avXmTexjvF3QUhgF/oCaY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab5f43e-9da0-45f6-47e0-08dbf8502ba1
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 00:45:45.0773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/9 1:36, Krzysztof Kozlowski wrote:
> On 07/12/2023 09:58, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add a driver for the SOPHGO SG2042 clock generator.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> Your driver still at v5 has so many build issues... please be sure there
> are no new warnings reported.
Yes, I also noticed these build issues and had a quick fix with v6, 
please review v6. Sorry for the confusion.
> Best regards,
> Krzysztof
>
