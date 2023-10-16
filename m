Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDA57CA4B7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjJPKFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJPKFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:05:44 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2108.outbound.protection.outlook.com [40.107.7.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70736C5;
        Mon, 16 Oct 2023 03:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM3n7liUu3dZj1TxyCL7BJrvrpRkSgowPl90w5qb2oBZNOIXMx1GNOvyajLDVOtdbnH5+8qU2XpVWclUHpsSpTA0lB+g31WKPbfxE6V3DAfQJd95c4xr/hCX6L5TUJOAnJdkTHsKFjuqQdDQIrUH01H67efJto8iuFwmgtB3l+1eyryvacTgRkszrQnwO+a+/IDH6/5ns7FF2rduSziKJJwvgW6GS84pR64nuZxfP4BEYKTcJekS3QNXQGJ5GeWDzYlzUSKduW+qLjj0kcHpgjEw0lfWNQ710E73ZsG7iwvgRAeyDOOlOxmO8QJb/BPvjzpQ4mUiN0Ry7Lx1k4W3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK+nQ/aMTi6LcVEwQE7+hfklxUPcAUPCgwqTzeWkiKc=;
 b=MYrxZBEAScce6SF77+3f3JH5wmFNlIi7zL6uFiAKO+KZPcXmY06Bw335VWhDW+97AjFarl1xZ9vtM6MTmSyQ5mWyhGJgxH2X6JxKYwxvSkgiKwEKdt6wwzD5MbQ0huaI2GmLQ7SZ6kV9e8VA2rjjIIBZ9UsM710EC9JCeB6L8dPUOTGRsjwe0vNq7MLQ1wo8kH25RBCSkwqFWXFUD9KzJbHQKd7rS4Vn5Y9qG17BQaesYVMEp+Dp/DNDh4lh/+mCGimAzPe5ilYhsve/L5sONG2r1T1fz5ssZAbUD4Xsd0l40QZ+j/O9ReQX31kSV7P3K6Xfj8qx7cEx7BF2y3oXag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK+nQ/aMTi6LcVEwQE7+hfklxUPcAUPCgwqTzeWkiKc=;
 b=IqphAAZG7kFqXrV4vtq77OKvCBkKw19lSw/46X5QLUHqHpYCBNaG9kqgf5qlsIkMbdVz7PluHlJQ0Ymaw/KTtVt3D+dVd/iQ+QXyLYpgV+yxBDu2g75ZRBsIYuoFsYk2oXfov98cgQNVNh/6rPBEloytnOMxs1xB06DFy25BRGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by GV2PR02MB9328.eurprd02.prod.outlook.com (2603:10a6:150:e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 10:05:34 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::4ba4:83a5:e60c:3a5d]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::4ba4:83a5:e60c:3a5d%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 10:05:34 +0000
Message-ID: <948548a0-d132-4f5c-819e-40bacb367be4@axentia.se>
Date:   Mon, 16 Oct 2023 12:05:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] iio: afe: rescale: Accept only offset channels
Content-Language: sv-SE, en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230902-iio-rescale-only-offset-v2-1-988b807754c8@linaro.org>
 <a0a55276-297b-e2b7-79b3-e4aadd39b400@axentia.se>
 <CACRpkdaMj2XFcwqaSiRSA2A41zYsW=AG_Fi7v7AjbuLBByxVaQ@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <CACRpkdaMj2XFcwqaSiRSA2A41zYsW=AG_Fi7v7AjbuLBByxVaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0073.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::23) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|GV2PR02MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab652cd-f98a-49da-fcf8-08dbce2f6fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwweGcKDodQdpgQOgEiF+omBDbBd5Dw2i82m13ug7XVfu2UlAu77Lu6Bb+iVCrqU03044V7jnJ4lIufmn14eCUTx3RbihHuR20QflwEZc3zecCwedtkI8FvGSqqUSMubqokqidp1UpWWs4I0BsRReao3hgyWAXsWKmHuAooGaXH4noSc5f9XEk2bR42hV/4H4P+oD8xtzzp0xzxSUg8hOgN1VrInzDv31LBdO+XjqEWKm0fxM0MvPXypPk3uwRi1Vy5P6/uQfGjSvL+Udxg0ndehO701i/Eh/AAqldT+9J1P+IikSLQ2hapVJeAyQnnMrwuivs6NcJfSVpI+zwFJ2O1a5b0FwmIuqgP95ywONFQ+hhg3CaQTiA5Zp+y8NoqVev4NDUwP68Kkbu7ZEC3lTOl84kpDd4l8SoI8pz1v5vZkOn6DZsNMUuwTj3D8kRU3o7qrq1+tBODTLxl79aJUIgjYEOBgYDbI77alSxYetdDaZa6gcYnVDiUL+p4yfiNpTF0J427ZNwx9RQfgaMZD5h8a21sQXtAJbqFVOrTP0B8TKjuaMibtZ+MKDT+hegLmY3ZoWqcJd247cJJqQ8zFtwuwOk0K6oJZV0xGttKDTVy4I5lVA4gwQ2lsqRWlesMPotWHZ5PWl5AOWfrJXue6mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(346002)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(478600001)(6916009)(66476007)(66556008)(66946007)(54906003)(2616005)(316002)(6506007)(26005)(53546011)(6512007)(4326008)(8676002)(8936002)(5660300002)(4001150100001)(2906002)(41300700001)(31696002)(86362001)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1d5QURXaFp2QndPTTdlUHUxZi9kSVRLUVVuVjNzZnZWbVpBVWx3R0I0QjdD?=
 =?utf-8?B?Sm9CR0ZyOHh1Ujk2TG1Ub1FUQis3K0NXYXNWU05WTUQvWTRHYWZjNjRlTEVJ?=
 =?utf-8?B?Z2ozZUpXR255aCt2SG1ydHRTZ1hBNzl4cnV6cHQ5L0pxRFB2NVlqai83QkZX?=
 =?utf-8?B?cWNoVTlpY3N4MWFSaVYwQlhEV0NqV2RxUGNIKzhyV2RVL29UcUFuaU5jUGpL?=
 =?utf-8?B?TUt1bWEyeStQUk53Tk9rZjc3L0JhZ1FKbHNhb3BrVkVVMVBBRmpzZFdmdFlu?=
 =?utf-8?B?bEVMazBCK0phbmlCTWxQMDIyUWFXVmxCVHFvaldUNXdERWRQT0QwS05YZU5k?=
 =?utf-8?B?MGR1Z21WUkppRHgxNkdheUx1aE80RU9oWkZTQmNUczFTQXZ6ZFlwL0JmTnFn?=
 =?utf-8?B?TEZaL3dScEQ5S250U2JGdVRJNVlVajdJWWlhbDNOamVrT1FRdm9vYklTbm5D?=
 =?utf-8?B?ZTZ0YUVaeVJBWCthMW1VU09wdXJ0bFEzc3F6SmxPSEtuNDJKUjVnM1pSUkJ0?=
 =?utf-8?B?Q2pGdkdhNWpwMFRQUjFxUEg5VUpsdDV0Z20yV3VQeFVQSGVnMU9xSUlLeGN1?=
 =?utf-8?B?cjA2bmc1TUl0YzFqR1JMWDZvVG5vN3o1Z21ndUR1aDk4c2NEYkZGUXpNU0ph?=
 =?utf-8?B?MlVSQVNrYUY1d2c5c3M4aW9wYm5Pc3dKckZaTW5ZVmJTQXNUeHMxY1Zyd1dy?=
 =?utf-8?B?WWk5cFVuR1I4WTJQVkpaT0d2NHRTMEFVQXB6WlJDMWY4U3FqMlVyMUppRGd1?=
 =?utf-8?B?endLSitEU0FXS1E2MzlwL3FCRzdDWU5RRUhSMFcrbnFKMUdMOTJjTWhHRTZU?=
 =?utf-8?B?dVNUZ3dGVmJuQjA2NWRWc0NPQThTdEZYQW83YnFxb05zZ05hZHd4a2pkdGdo?=
 =?utf-8?B?d1BQYkhsU2NTODFoc25LU1Nwb05IODFwOHp5NUUrZndQbnhPeHRSVlcwVTZl?=
 =?utf-8?B?dU9OaHRCaGJQMXQxNDFqTVFEdnNaZysrZGdrcEh1OHJRZW5WUDBzRDRnZ1pJ?=
 =?utf-8?B?ZVl0ZmNtdHN3ZmJ5dDVYVGpvUVFJeGJYS1NIVTlRU0pWUFE0akJ6NjY0clBO?=
 =?utf-8?B?TmxrSmpuZURHcUh5OVV6MGxEYmRSanlraHNKd3dOMFdnYUlmcGNRMDFCeVZu?=
 =?utf-8?B?cjRPWUdCVGNNN1JUN1JNQlMzbHlTUXk5UFp4RENzbXpMZW10NXNyTGJremxR?=
 =?utf-8?B?cVZ0S2lTQUtzM1piWk1wYUlsbXlPRFNGVWlYMktUb2xqYzRxSTJhUnZSdEFz?=
 =?utf-8?B?UUUxNlB6WGZrQmlhZUljajhoV3JqYm5VN1FibVhyR1hwVXhmUGNpb003RWZE?=
 =?utf-8?B?MlNHUUZoQlVSMWwyZStzM1dDQXEwM3dhWlg1b2diajBXWkx6SzFEaHoxTFVV?=
 =?utf-8?B?NVV6TFhUdEY1SGFOSnZWWDlQRWNDamJMRDdvZG5ReGplcFZSZUxUN1dmV3I3?=
 =?utf-8?B?OE1kMjJ5QTNhTXZKSlJKK1hTa3ZKK3RSQlpKdC8vb1J5S1FseGFyMzRYTVJG?=
 =?utf-8?B?THVYYWhsdDFhSHV3MHNtai9KK2pmdkwrQTRZb250V0JkdVdnbDZlQUhwWFht?=
 =?utf-8?B?NnZjMEpXcXZlWkNBY0lyWHhQWHRvOEp0UjVRUGxybVBnZTdzQ28rak1EdVYy?=
 =?utf-8?B?S2o2bCtXK0RWM1JFc3dnRG5MZUlXSEcwSmtaMU1xSGplTEQ5Z1ZiMXZFb0R2?=
 =?utf-8?B?NTFIODhxdUUwMlJTZlR0U1I1M2tKdVl3RitlaXJLVjFGTzVZdVE3Umx5ZHNB?=
 =?utf-8?B?SVdmTGxUUThZS2Y5Ukd6azBoYkNoekxuQ2gzS0pMVi91WDM4R09FSDNrckxG?=
 =?utf-8?B?TkRxR2hiQmpzNFdwck9BM0VoYzRCNVk1ZmgwWXJqUnd1M1hBOFNoYjZMQ3or?=
 =?utf-8?B?WjYxdGhycEl5WWxid0lEL1pmNFluOTI2NjAzU21pNlVJeU93MlBQdVBDRjlh?=
 =?utf-8?B?SlBsSEFvUTlCQW9sbW9lMGhXK1VpTkZzMEpOSGZtcHg2eVF1QVdWQlIyTkFr?=
 =?utf-8?B?aUZDSW5hdFd6Q256MW5pVnRrTGt0TWI3VVdwSkZUbkVQeDNzbE1PeGFUY2Rr?=
 =?utf-8?B?VnBtRmFIV3BDTHV3VlZ6SVBIdFJzMEVhb1hKK0lCT3VlRmtDNU16anpCWHFY?=
 =?utf-8?Q?VsupSpGr9FWAN2hzstSK2QaL4?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab652cd-f98a-49da-fcf8-08dbce2f6fdc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:05:33.9881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5s7MIbtQPLF0NGhLHiL38ExmVkKSTf5/eDKvpL1DvTzd78x3/BzZGEpFl++r5Ak
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9328
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-10-16 at 10:39, Linus Walleij wrote:
> On Sun, Oct 15, 2023 at 12:38 AM Peter Rosin <peda@axentia.se> wrote:
>> 2023-09-02 at 21:46, Linus Walleij wrote:
> 
>>>       if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
>>> -         iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
>>> -             dev_info(dev, "using raw+scale source channel\n");
>>> +         (iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE) ||
>>> +          iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET))) {
>>> +             dev_info(dev, "using raw+scale/offset source channel\n");
>>
>> If the rules really are that when not provided scale is 1 and offset 0
>> (reasonable of course) then the above still looks suspect to me. Should
>> this part not simply be
>>
>>         if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW)) {
>>                 dev_info(dev, "using raw source channel\n");
>>
>> in that case?
> 
> The patch is based on Jonathan's comment that while we currently
> support raw+scale, having just raw+offset provided is a possibility.
> 
> The if()-clause above (which I guess you are commenting) is meant
> as "take this path if scale or offset or both are provided".
> 
> Just raw (with neither offset or rescale) doesn't make sense, since

And I don't see why not. That's the crux.

> the AFE rescaler does just offsetting and rescaling, in that case the
> user should just use the raw channel. Also it would then take
> precedence over a processed channel (which applies rescale and
> offset internally) which doesn't make sense to me.

Why isn't it perfectly fine for a device to provide only a raw
channel and then expect that to be interpreted as the real unit?
Why would it need a processed channel when no processing is
going on? E.g. a device reporting the temp in the expected unit
in one of its registers. Or whatever with such a friendly
register.

And if the above holds, it should also be perfectly fine to run
that through the rescaler.

> 
>> Or was "raw + processed" some kind of special case that we want to handle
>> as processed? If that's the case then we need to have more complex logic.
> 
> Processed is on the else-path, which will be tried only when neither
> scale nor offset is provided:
> 
>>       } else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
>>               dev_info(dev, "using processed channel\n");
>>               rescale->chan_processed = true;
> 
> I'm not sure I fully understood the remark, please elaborate if I got it wrong!

I agree that the patch does exactly as you intend. I question if
what you intend is correct, but since I don't know the rules, I'd
simply like to have the rules clarified.

Is that clearer?

Cheers,
Peter
