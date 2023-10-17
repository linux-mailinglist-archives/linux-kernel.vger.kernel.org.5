Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADBB7CBD3C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjJQIUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQIUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:20:06 -0400
X-Greylist: delayed 490 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 01:20:01 PDT
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995B593
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:20:01 -0700 (PDT)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.9.43])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 1E65710998A0F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:11:54 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.196.113])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 2B89F100021E1;
        Tue, 17 Oct 2023 08:11:46 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1697530305.624000
X-TM-MAIL-UUID: b31f0a6e-29cf-415c-8686-2caf44f115c2
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 9897510001285;
        Tue, 17 Oct 2023 08:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRE27YsJs17t4edkCIYO68CNBwMfqj2XQoXqMtoXaaofxXmBct2jeNaq/AXJzZZy1NQtS8iFOOy05V5Y+yfxrYST4meZd0EWmN0kh/U/jdQ11VGx8x4Nfb/Y6VUwNvW0YMLJFoiJY+QSZVzDihTLUk771k3KIOMhNgK1heE0fbw1atOIdShnEYdaHzIB5c0xXLpJYoYvKUxDFtxznm1BmlWfSkD2L4vMFISCsIpdX2mLN2IX+C7m3iqhSULY1X2qht6VaDQx/7n+ebUlloQ5+trx6BnnDgOKqJezNPEpLX3QaLNworOMCQJNTJ1+JMYaFq/pBV/adIayuyy88/CxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbrB+oovZlsolrqWuTFmxhjIjrg8bn6xnv+DTNLIKSA=;
 b=YGMTg9NvfefXG+qR9D/NidnW3orqvmH06SbMMl+p/7uYOe+8m9zUFERoBiJPNdWa38kSvdOv0rWmaCwmcJDi9w9UYtOyYqy+MdKbcWUglgq1vtV/Z6WWcN/awI4GgRkUmU9HSfBfgn7+BpUb1GRWZvqEX7H2rF8yg3X7uUDo+waxgRCGr1u5yGEyQz7zQumQimobvUfejg9IyDTnxgYgkywlFfKryvg85PVAhVY3SYNC7Vx5vt9BP01kuo4hwyEbDPQDyQoANt2m1ka7F/FnnBtpAcHkLqugNJniq0vo24xaWLuCiVjNPAYEULymv0rHsAFB2jy2qeeWGBiaa9C2bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Content-Type: multipart/mixed; boundary="------------5wSxwIAIFbg74K4UEUVVU5hV"
Message-ID: <6384c982-2b6d-474b-bf29-d495422aff20@opensynergy.com>
Date:   Tue, 17 Oct 2023 17:11:30 +0900
Subject: Re: [RFC PATCH] ALSA: virtio: use copy and fill_silence callbacks
To:     Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, mst@redhat.com
Cc:     perex@perex.cz, tiwai@suse.com,
        virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
        manos.pitsidianakis@linaro.org, mripard@redhat.com
References: <ZSgMeoMx6NX2zCx/@fedora>
Content-Language: en-US
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
In-Reply-To: <ZSgMeoMx6NX2zCx/@fedora>
X-ClientProxiedBy: BE1P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::16) To BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:5c::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2374:EE_|FR0P281MB2336:EE_
X-MS-Office365-Filtering-Correlation-Id: 939da832-cab8-4756-122d-08dbcee8b330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3RtIZdc9Gib4NrFTk1ytC/yVDgEI2uHnkXieJ1fBUHN8CvCTLbRfFPG/K+MkozBck759MoI5Hec58uJ2SO1dqA1gRGn81b2TD59LLsmxMN9KrtOjYWLXSD2isyO+ykoQDsWcXOD0Y+AMtRvbvcKpi+90Ateos0VWRuQIZD8wCZFkKkrp+1+dYC/MibQl8csilk4BRuSPjoFxZyS3pyxKM13BleYiXcRVFTyeh6K2vPdD5w2lsdmOu2PxRRVOG/Smwzb3Yg/X9bqdk/cxzfNZx4q2/7jR2vpQARJ7Tdr6QzBpCT35kCHmTEf13sEHb54MYk4h3OYznTi6uJED23XP61h/cOT04ImAHOrRxP/5bWb8WNxQMW/1BHcqrssYloOGTcDhHGrd5kD6+Je4lp5fonLUvw4WkrEuAG05MTuXjIDNW7H9JBbpKY+gA3Y4nbqFKvaQqyFBSvUGRCqd+P7JUJ1ELNBt6V9h29PVT2lkauVjjC9F/CVzfBlzdx6ys/UeUZ2v/vk/exgFofCz5xKfn24s69C7SMnjhiiv8IOhAnT9zsQKWVhvx8Wum9VqZVCOUovP+T9+bUB5j8FcVx7bxT6fxyIgpVQWcnnocPdGlKZ5ftKtP1osZ/if1FUCjGEaqTz6wGjOq1d8H93uKhrkKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39840400004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(66476007)(478600001)(42186006)(66946007)(66556008)(316002)(83380400001)(31696002)(86362001)(38100700002)(53546011)(2616005)(26005)(33964004)(41300700001)(44832011)(5660300002)(235185007)(4326008)(8936002)(2906002)(36756003)(7416002)(30864003)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmtxM2RxN1ZRNlByaVNqeC9tOFpwUGZldWpUaWptZkRpS0twZDB6SlJ6R2FT?=
 =?utf-8?B?N08yZk9PWmpLUi90VlcweHJlbkRITndkSlFhR0p1ODBENzlvOTVyNjA2OW9I?=
 =?utf-8?B?MEFjK3J5WkhhbW1oTDJhRGhvejkxS2o5bUVvK3BLeFFHK2Rla3dhL29mT3Bh?=
 =?utf-8?B?aVNDcENYTk1PWXI0QmwzV2Zucms5bmZmZkR3bHdHTlJxMHM5cTNvYjg5WGNy?=
 =?utf-8?B?V2VXako0VUxhVncvdnJEOUZraDNKdEo3MEViSDQ5TzJiWUZKTjJuckhlR1pS?=
 =?utf-8?B?UmpJVjhzdWlHM20xanl1U081RHNXN3dSd0JEaVBLVzk1bjhQT1hmZ0k4UktN?=
 =?utf-8?B?WVNYb3BNcVlyZnhTTUJtZjlBRXJ5MytyVzZ4NUtWMDhJK1FSMW5vQVk1SHlk?=
 =?utf-8?B?Vk5yRy9TZ1o0aHhpK0ZWVG91TXk5cG9sS2UyamtFV2ZsZkNvTHJQOHNLQkNB?=
 =?utf-8?B?TGt3UWpwQzFrS2ZKV3o1aUJnQmMzTzZDU0U3Y0tHbDV3K3NoajRwRFpQRjVN?=
 =?utf-8?B?MTAvVmlLNkNzZXExZTBEM1RBQ3p1SGh3Y0tkMTN6cnN6TjBkS05yUzY1aUtY?=
 =?utf-8?B?RHVvL1c5N3RNZG40TW1pSW0wbjlRUDN5SlkyRHV0NjVEREJtbUtlbEtvTFJL?=
 =?utf-8?B?NUxRNHFYQ0Q5RHBob3BoUCtGK2dOWkQ4YzVPNGdMek8rNlRnNlczZHhsQVFn?=
 =?utf-8?B?cEZqMklpS291V2JxTGNWVXhJeXFIOUNwU2d3RVJtTjd1Vkk1T1piTHBIMVVB?=
 =?utf-8?B?TVlpWnQ1b2g4cHFtdkVGczBzbCt3d0dwRElmUkFoeXlCSFp2cUc0VjkydERO?=
 =?utf-8?B?N3hldXZVcTNxcEtTTEF4K3NUVHVmSlZ3V2MrUUhYWXM1STJkTjZ1SUhON3Jh?=
 =?utf-8?B?eUZvRG0ycmdoUjBOUllhRHMycU5IbkUyRTNDQ0hXdkZTbVFmaEJWbDlEZ25N?=
 =?utf-8?B?Q3FhamNkekQ4aUJqOWRaQzFYMUNQWEVJQjgrV2Q1bWdSZnRRV3hHZm5uVTRs?=
 =?utf-8?B?TjNjVkhNUjRwNkNqblN6ZWxXNWpyT2lYemE0eVZ2cVREbGc3OTJVRE1QWFcw?=
 =?utf-8?B?L04raEJOZ2ZlbDVxRW15Tm1TblBOVEVGbFMwNUYwUWw1NWFad1BScE1jeC9q?=
 =?utf-8?B?MmxTbnIzSGxjVlR1Tm5ubzVOY1BWR2sxdW9JbnBVYmtYWGhuTlFLSnFQVkp6?=
 =?utf-8?B?Nnd0djB2d1NiTXdoTWwzTlpuZitXVjFIOC9ZcHBpVEJWSm45NUtQOGx0VzZm?=
 =?utf-8?B?UTA4ZEJoNC9jZFp5WTQxTmdhTld0SXNCZ2FxODYwMzZZNmdvTlpyUVFRVlli?=
 =?utf-8?B?VFhHNlRTVytFYXcrN1FEUzRnZmMvVkhCOWxlR1BnMFRmLy9OeFFOTEczTTJL?=
 =?utf-8?B?SzJlWUVERzZLeFNJVzlLZzNGeHR6QjhyNm9NSmorZ0R2dk9aSVpmZ2pJRi9B?=
 =?utf-8?B?ajZicGRVWlpwTGZIRmtXRC9ieW9uZUxNVFNCcWZpaGgwTGJLMjFaemFMNzZN?=
 =?utf-8?B?RUVQbmswR2o3aDR6ZXh2SnFWY0hBQWhmTVFPZUtSVUkrcTBNZEh3YVNQMXJL?=
 =?utf-8?B?TXhZR05EQ2pvR1I2SnVLTVhXTTBJRXhsekduVHVkWG01THpWdkNpa2o4RGk1?=
 =?utf-8?B?K0dua3dhR2RpTHRNL2ZGZEtmUXR2S09aSThBZElXNTZjU0lwK0NZWGdub1Qy?=
 =?utf-8?B?UWlPTG9RTVBWb3RwU0VKTHpnNmZZWU9nT2R1aHRGM1hOMzBvVnpjREErM0Jl?=
 =?utf-8?B?U3E3cW9DOHNDQkJyOG5ydTZDWE5FeXhFTjduSmt3RlJwbzRFbk9lYURVaHBm?=
 =?utf-8?B?ZWxXeklJUkorUTcySGNRQ1RSL0txaVFsbTVtdXY0VG5EVC9LdG52VUI2TjBC?=
 =?utf-8?B?VEpWc2Nmc09aWUFmOWpLQmR4azZZbmk3dFppZmUvbCtEY0RDb2xUU3FqQnkw?=
 =?utf-8?B?NjdPN0xLbmxla2IrZDNMRE45QmJWZ3A3VmRkYnlKd0c1RUxZZVBnRVU2TU4y?=
 =?utf-8?B?OHBYVlUyLysvemF6OHVFc2Nrc2thdFR3QjFJU09BR2w3K2U1OFh2bE9wUDZX?=
 =?utf-8?B?c3RQNkdDSzlpbDFxdzg4enZGR25IVUR2OHlKUFMwZ2wveGRjL3ZUTk9OV1hp?=
 =?utf-8?Q?HcJyA/KuWrKxkstk/AGpJ0Hqq?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939da832-cab8-4756-122d-08dbcee8b330
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2374.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 08:11:43.8303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3w7T/xXAxtZvgudg/N9elnOzGWh8A8q5rWxy0REcpuP1jkelTFtU8YJHisGUUGM7yt5CiBO23tRexPVYeGDR3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2336
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27940.006
X-TMASE-Result: 10--33.263800-4.000000
X-TMASE-MatchedRID: 6OB6z8J7vlHb9FS28tHdcZGPSO6O5JCao4iCakRRMU13UOL9JcMKjtmf
        OvGYKiTYVw0Hm1foGgLUPeYV/AzEBlPRFBC0RHkPDDgMha/WNJVtT5dsVizXEvKRRDf7VCkpTdI
        L1uQT1jI2vloDwxXReRzJ0wDp/7VY+6OAjxbdVB2t/Tca+iJ/9+fShpTpYz77pZd6jUkGtmDDmd
        nLZf43Ht77mXRNIBCXNaDWijGbB53W+2YUVNe1Ywvpq/ti8dx8e7c6tEkXezscO9g0wIXVO79U+
        uceYFnjaHUl2AwNuk+F8FPxso5y0WSgE+QHk4H2+3f6eMMms7gGAyO8UPwf/chGESF2QtYSi8+I
        Gr+Jb3Uyk/Hw4XN9jU/+LL3tkSXkQrGWBYGHVP07cxOrTsG6RCW82bsC8fuFZAvO4QbJLKNwk2X
        uU2aD+n7IEsrGVz2MjdDhGuJFbM8Asgl6PZgqJC6854ELk770UjOqjUXzJBK3+N/b9/jBFd5hLj
        7OjPSxky6b1p6qbktEvQzD16INSHSid6aim3FY39nur6FlBV7/EYhqcx9Nu6jzcFhHfnxu75PzL
        Av3ywa/kepMMxSwrQvjx30v1PWnmYcrH7n1/Zq839xuIQKj/YsWJGFVmRxVQg/DWi2s2tEojxAN
        JtkcjpHaNnNrIRLo5Ut5abjquGI9ykzKox8BecVNAYApHGPk2j7jyCKpnCe3Hp9onN135Wp2VXU
        uZsR8A/lH/MvdoiadAEYv/mZFKZBlLa6MK1y4
X-TMASE-XGENCLOUD: 38d1e1b5-acec-4690-b1b4-f20fa81dd902-0-0-200-0
X-TM-Deliver-Signature: A078A070839785BEE5247BDF0D1A9DC6
X-TM-Addin-Auth: VrrKMsHfhnFRq/ofEJJl+rjwQoDGb6brLotK+j4o9ivaahCgbRYOyik6Q4R
        4S5gzlemnhMWEohjqPVbbJoKv/1NPhkw10zvszjpT+5KFc9COUS0Nvva75cxrsmEL88aAOVhotx
        Y4o/ij7+nBD0ZwaKsDZWPwX/2XjaJE4MqBXMJ1IJkV5bLnRROiBlcayqP99aqwjakIIFxC3glq/
        dl5818sOn9wPwnYcZLh6LiU4qO+zW28vb7DRntzL6PQ+0om3THzS5s/bliZapBpmxz9J/HE9SD/
        DoVIaKK+f901TMA=.BQ8Y6GYiP81tndLGtMQXSsxU9iuwTqwiV7wrpZCNBCVbA2dAWSF7ztQfxS
        yoANlvmeuTNh8PWuNzTndAXle5hHCAsxGUWbDJRzRg2EmfnOb4YiLm5Zj6BJBxwQTAErWtRt62Q
        8JWZ39ySfJQlZeXiZu4aa5P0R8/hiwkZ1M9l86mgltmX7JhCoy2HoPvj5EI+JhtxGIum1wtVbqI
        16LP0jZcbxFBjqNgt+jEixg+/XxetX7ipSUaktT/faMJMppJrub38KW1tuqAXHq2kBdu/67lIhj
        rcVH5XqC78dNDB/9V1nf/yka9BJZxgLrx1/RjWof6A9hisvJowFwmuqQ8UQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1697530306;
        bh=T3ANmmB8l5EXi6X401WZVQn36PZqWU833Vd/WtgkIbY=; l=31308;
        h=Date:To:From;
        b=bLf6nPPMLFuVt51Fe4oPXk+r0uWhC3GkiEBcEXne9ExhwrZKlLGOm57zRW8o6Bq0z
         Dq3DJPNNay/DcGQSv/O2BZ8t3WbPyHCm7tJiveu8SQSB9V5go8+BtoGUh6OSnqGAIX
         1FcAZ9G+FGAAv3TmIZm3oAZRm+wfHEomdYJN0TBBS63emyAabyGIMvDph+mX/fgKr3
         jOogTEpc4H17wXjny1NvZmRdLJm8j/CDvJBRuCfqP+WQM7bwJ+xoLDbJknFDVt2gKT
         lJoD1fN/mFNBucmXt8rtSW22IJ+0ROHJNjeVeA/mekS9SL5OFFRdEvZvzYKD+CEkjA
         ZJHiRwQuBQ0eQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------5wSxwIAIFbg74K4UEUVVU5hV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matias,

Thanks for your help! I updated and corrected your patch a little bit (see
attachment). All changes were tested, there were no problems on my side.

See also a few inline comments.



On 13.10.2023 00:10, Matias Ezequiel Vara Larsen wrote:
> This commit replaces the mmap mechanism with the copy() and
> fill_silence() callbacks for both capturing and playback for the
> virtio-sound driver. This change is required to prevent the updating of
> the content of a buffer that is already in the available ring.
> 
> The current mechanism splits a dma buffer into descriptors that are
> exposed to the device. This dma buffer is shared with the user
> application. When the device consumes a buffer, the driver moves the
> request from the used ring to available ring.
> 
> The driver exposes the buffer to the device without knowing if the
> content has been updated from the user. The section 2.8.21.1 of the
> virtio spec states that: "The device MAY access the descriptor chains
> the driver created and the memory they refer to immediately". If the
> device picks up buffers from the available ring just after it is
> notified, it happens that the content may be old.
> 
> By providing the copy() callback, the driver first updates the content
> of the buffer, and then, exposes the buffer to the device by enqueuing
> it in the available ring. Thus, device always picks up a buffer that is
> updated.
> 
> For capturing, the driver starts by exposing all the available buffers
> to device. After device updates the content of a buffer, it enqueues it
> in the used ring. It is only after the copy() for capturing is issued
> that the driver re-enqueues the buffer in the available ring.
> 
> Note that the copy() function assumes that user is always writing a
> period. Testing shows that this is true but I may be wrong. This RFC
> aims at clarifying this.
> 
> Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> ---
>   sound/virtio/virtio_pcm.c     | 11 ++--
>   sound/virtio/virtio_pcm.h     |  9 +++-
>   sound/virtio/virtio_pcm_msg.c | 50 ++++++++++++++++---
>   sound/virtio/virtio_pcm_ops.c | 94 +++++++++++++++++++++++++++++++----
>   4 files changed, 137 insertions(+), 27 deletions(-)
> 
> diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> index c10d91fff2fb..bfe982952303 100644
> --- a/sound/virtio/virtio_pcm.c
> +++ b/sound/virtio/virtio_pcm.c
> @@ -104,8 +104,6 @@ static int virtsnd_pcm_build_hw(struct virtio_pcm_substream *vss,
>   	 * only message-based transport.
>   	 */
>   	vss->hw.info =
> -		SNDRV_PCM_INFO_MMAP |
> -		SNDRV_PCM_INFO_MMAP_VALID |
>   		SNDRV_PCM_INFO_BATCH |
>   		SNDRV_PCM_INFO_BLOCK_TRANSFER |
>   		SNDRV_PCM_INFO_INTERLEAVED |

We need also necessary to disable rewinds, since now only sequential
reading/writing of frames is supported.


> @@ -471,12 +469,11 @@ int virtsnd_pcm_build_devs(struct virtio_snd *snd)
>   			for (kss = ks->substream; kss; kss = kss->next)
>   				vs->substreams[kss->number]->substream = kss;
>   
> -			snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_ops);
> +			if (i == SNDRV_PCM_STREAM_CAPTURE)
> +				snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_capture_ops);
> +			else
> +				snd_pcm_set_ops(vpcm->pcm, i, &virtsnd_pcm_playback_ops);
>   		}
> -
> -		snd_pcm_set_managed_buffer_all(vpcm->pcm,
> -					       SNDRV_DMA_TYPE_VMALLOC, NULL,
> -					       0, 0);

It is not right. Buffer allocation/freeing is controlled by the kernel
subsystem, so the driver doesn't have to worry about it.


>   	}
>   
>   	return 0;
> diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
> index 062eb8e8f2cf..1c1106ec971f 100644
> --- a/sound/virtio/virtio_pcm.h
> +++ b/sound/virtio/virtio_pcm.h
> @@ -50,6 +50,8 @@ struct virtio_pcm_substream {
>   	struct work_struct elapsed_period;
>   	spinlock_t lock;
>   	size_t buffer_bytes;
> +	u8 *buffer;
> +	size_t buffer_sz;
>   	size_t hw_ptr;
>   	bool xfer_enabled;
>   	bool xfer_xrun;
> @@ -90,7 +92,8 @@ struct virtio_pcm {
>   	struct virtio_pcm_stream streams[SNDRV_PCM_STREAM_LAST + 1];
>   };
>   
> -extern const struct snd_pcm_ops virtsnd_pcm_ops;
> +extern const struct snd_pcm_ops virtsnd_pcm_playback_ops;
> +extern const struct snd_pcm_ops virtsnd_pcm_capture_ops;
>   
>   int virtsnd_pcm_validate(struct virtio_device *vdev);
>   
> @@ -117,7 +120,9 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
>   
>   void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss);
>   
> -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss);
> +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, bool single);
> +
> +int virtsnd_pcm_msg_send_locked(struct virtio_pcm_substream *vss, bool single);
>   
>   unsigned int virtsnd_pcm_msg_pending_num(struct virtio_pcm_substream *vss);
>   
> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index aca2dc1989ba..9a5f9814cb62 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
> @@ -132,7 +132,6 @@ static void virtsnd_pcm_sg_from(struct scatterlist *sgs, int nsgs, u8 *data,
>   int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
>   			  unsigned int periods, unsigned int period_bytes)
>   {
> -	struct snd_pcm_runtime *runtime = vss->substream->runtime;
>   	unsigned int i;
>   
>   	vss->msgs = kcalloc(periods, sizeof(*vss->msgs), GFP_KERNEL);
> @@ -142,7 +141,7 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
>   	vss->nmsgs = periods;
>   
>   	for (i = 0; i < periods; ++i) {
> -		u8 *data = runtime->dma_area + period_bytes * i;
> +		u8 *data = vss->buffer + period_bytes * i;
>   		int sg_num = virtsnd_pcm_sg_num(data, period_bytes);
>   		struct virtio_pcm_msg *msg;
>   
> @@ -186,10 +185,12 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
>   /**
>    * virtsnd_pcm_msg_send() - Send asynchronous I/O messages.
>    * @vss: VirtIO PCM substream.
> + * @single: true to enqueue a single message, false to enqueue all of them.
>    *
>    * All messages are organized in an ordered circular list. Each time the
> - * function is called, all currently non-enqueued messages are added to the
> - * virtqueue. For this, the function keeps track of two values:
> + * function is called, first non-enqueued message is added to the virtqueue.
> + * When single is True, only the first message is enqueued. When False, all the
> + * available messages are enqueued.  The function keeps track of two values:
>    *
>    *   msg_last_enqueued = index of the last enqueued message,
>    *   msg_count = # of pending messages in the virtqueue.
> @@ -198,7 +199,7 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
>    *          spinlocks to be held by caller.
>    * Return: 0 on success, -errno on failure.
>    */
> -int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
> +int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, bool single)

I would propose to make this function more generic, specifing the offset and
size for the modified part of the buffer. This way no assumptions need to be
made. We can also guarantee that we only put fully written/read messages into
the virtqueue.



>   {
>   	struct snd_pcm_runtime *runtime = vss->substream->runtime;
>   	struct virtio_snd *snd = vss->snd;
> @@ -211,6 +212,13 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
>   	i = (vss->msg_last_enqueued + 1) % runtime->periods;
>   	n = runtime->periods - vss->msg_count;
>   
> +	if (single) {
> +		if (n < 1)
> +			return -EFAULT;
> +
> +		n = 1;
> +	}
> +
>   	for (; n; --n, i = (i + 1) % runtime->periods) {
>   		struct virtio_pcm_msg *msg = vss->msgs[i];
>   		struct scatterlist *psgs[] = {
> @@ -250,6 +258,36 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss)
>   	return 0;
>   }
>   
> +/**
> + * virtsnd_pcm_msg_send_locked() - Send asynchronous I/O messages.
> + * @vss: VirtIO PCM substream.
> + * @single: true to enqueue a single message, false to enqueue all of them.
> + *
> + * This function holds the tx/rx queue and the VirtIO substream spinlocks
> + * before calling virtsnd_pcm_msg_send(). This is a wrapper function to ease
> + * the invocation of virtsnd_pcm_msg_send().
> + *
> + * Context: Any context.
> + * Return: 0 on success, -errno on failure.
> + */
> +
> +int virtsnd_pcm_msg_send_locked(struct virtio_pcm_substream *vss, bool single)
> +{
> +	struct virtio_snd_queue *queue;
> +	int rc;
> +	unsigned long flags;
> +
> +	queue = virtsnd_pcm_queue(vss);
> +
> +	spin_lock_irqsave(&queue->lock, flags);
> +	spin_lock(&vss->lock);
> +	rc = virtsnd_pcm_msg_send(vss, single);
> +	spin_unlock(&vss->lock);
> +	spin_unlock_irqrestore(&queue->lock, flags);
> +
> +	return rc;
> +}
> +
>   /**
>    * virtsnd_pcm_msg_pending_num() - Returns the number of pending I/O messages.
>    * @vss: VirtIO substream.
> @@ -320,8 +358,6 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
>   					le32_to_cpu(msg->status.latency_bytes));
>   
>   		schedule_work(&vss->elapsed_period);
> -
> -		virtsnd_pcm_msg_send(vss);
>   	} else if (!vss->msg_count) {
>   		wake_up_all(&vss->msg_empty);
>   	}
> diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
> index f8bfb87624be..a208439dbff8 100644
> --- a/sound/virtio/virtio_pcm_ops.c
> +++ b/sound/virtio/virtio_pcm_ops.c
> @@ -238,6 +238,11 @@ static int virtsnd_pcm_hw_params(struct snd_pcm_substream *substream,
>   	 */
>   	virtsnd_pcm_msg_free(vss);
>   
> +	vss->buffer_sz = params_buffer_bytes(hw_params);
> +	vss->buffer = alloc_pages_exact(vss->buffer_sz, GFP_KERNEL);
> +	if (!vss->buffer)
> +		return -ENOMEM;
> +
>   	return virtsnd_pcm_msg_alloc(vss, params_periods(hw_params),
>   				     params_period_bytes(hw_params));
>   }
> @@ -257,6 +262,11 @@ static int virtsnd_pcm_hw_free(struct snd_pcm_substream *substream)
>   	if (!virtsnd_pcm_msg_pending_num(vss))
>   		virtsnd_pcm_msg_free(vss);
>   
> +	if (vss->buffer) {
> +		free_pages_exact(vss->buffer, vss->buffer_sz);
> +		vss->buffer = NULL;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -331,15 +341,18 @@ static int virtsnd_pcm_trigger(struct snd_pcm_substream *substream, int command)
>   	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>   		queue = virtsnd_pcm_queue(vss);
>   
> -		spin_lock_irqsave(&queue->lock, flags);
> -		spin_lock(&vss->lock);
> -		rc = virtsnd_pcm_msg_send(vss);
> -		if (!rc)
> -			vss->xfer_enabled = true;
> -		spin_unlock(&vss->lock);
> -		spin_unlock_irqrestore(&queue->lock, flags);
> -		if (rc)
> -			return rc;
> +		// The buffers should be exposed first during capturing so that
> +		// the device can consume them. Capturing cannot begin
> +		// otherwise.
> +		if (vss->direction == SNDRV_PCM_STREAM_CAPTURE) {
> +			rc = virtsnd_pcm_msg_send_locked(vss, false);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		spin_lock_irqsave(&vss->lock, flags);
> +		vss->xfer_enabled = true;
> +		spin_unlock_irqrestore(&vss->lock, flags);
>   
>   		msg = virtsnd_pcm_ctl_msg_alloc(vss, VIRTIO_SND_R_PCM_START,
>   						GFP_KERNEL);
> @@ -450,8 +463,66 @@ virtsnd_pcm_pointer(struct snd_pcm_substream *substream)
>   	return hw_ptr;
>   }
>   
> -/* PCM substream operators map. */
> -const struct snd_pcm_ops virtsnd_pcm_ops = {
> +static int virtsnd_pcm_pb_copy(struct snd_pcm_substream *substream,
> +			       int channel, unsigned long pos, struct iov_iter
> +			       *src, unsigned long count)
> +{
> +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> +
> +	if (unlikely(pos + count > vss->buffer_sz))
> +		return -EINVAL;
> +
> +	if (copy_from_iter(vss->buffer + pos, count, src) != count)
> +		return -EFAULT;
> +
> +	return virtsnd_pcm_msg_send_locked(vss, true);
> +}
> +
> +static int virtsnd_pcm_cap_copy(struct snd_pcm_substream *substream,
> +				int channel, unsigned long pos, struct iov_iter
> +				*dst, unsigned long count)
> +{
> +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> +
> +	if (unlikely(pos + count > vss->buffer_sz))
> +		return -EINVAL;
> +
> +	if (copy_to_iter(vss->buffer + pos, count, dst) != count)
> +		return -EFAULT;
> +
> +	return virtsnd_pcm_msg_send_locked(vss, true);
> +}
> +
> +static int virtsnd_pcm_pb_silence(struct snd_pcm_substream *substream, int channel,
> +				  unsigned long pos, unsigned long count)
> +{
> +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> +
> +	if (unlikely(pos + count > vss->buffer_sz))
> +		return -EINVAL;
> +
> +	memset(vss->buffer + pos, 0, count);
> +
> +	return virtsnd_pcm_msg_send_locked(vss, true);
> +}
> +
> +/* PCM substream operators map for playback. */
> +const struct snd_pcm_ops virtsnd_pcm_playback_ops = {
> +	.open = virtsnd_pcm_open,
> +	.close = virtsnd_pcm_close,
> +	.ioctl = snd_pcm_lib_ioctl,
> +	.hw_params = virtsnd_pcm_hw_params,
> +	.hw_free = virtsnd_pcm_hw_free,
> +	.prepare = virtsnd_pcm_prepare,
> +	.trigger = virtsnd_pcm_trigger,
> +	.sync_stop = virtsnd_pcm_sync_stop,
> +	.pointer = virtsnd_pcm_pointer,
> +	.copy = virtsnd_pcm_pb_copy,
> +	.fill_silence = virtsnd_pcm_pb_silence,
> +};
> +
> +/* PCM substream operators map for capturing. */
> +const struct snd_pcm_ops virtsnd_pcm_capture_ops = {
>   	.open = virtsnd_pcm_open,
>   	.close = virtsnd_pcm_close,
>   	.ioctl = snd_pcm_lib_ioctl,
> @@ -461,4 +532,5 @@ const struct snd_pcm_ops virtsnd_pcm_ops = {
>   	.trigger = virtsnd_pcm_trigger,
>   	.sync_stop = virtsnd_pcm_sync_stop,
>   	.pointer = virtsnd_pcm_pointer,
> +	.copy = virtsnd_pcm_cap_copy,
>   };
> 
> base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin
--------------5wSxwIAIFbg74K4UEUVVU5hV
Content-Type: text/x-diff; charset=UTF-8;
 name="0001-ALSA-virtio-use-copy-and-fill_silence-callbacks.patch"
Content-Disposition: attachment;
 filename*0="0001-ALSA-virtio-use-copy-and-fill_silence-callbacks.patch"
Content-Transfer-Encoding: base64

RnJvbSBjOTAxOTQ2OWM1Njg5ZDg2MGVlNmVhNWM0YTllYTdjYWE1MDA5ZGFhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXRpYXMgRXplcXVpZWwgVmFyYSBMYXJzZW4gPG12YXJhbGFy
QHJlZGhhdC5jb20+CkRhdGU6IFR1ZSwgMTcgT2N0IDIwMjMgMTY6MzQ6MjggKzA5MDAKU3ViamVj
dDogW1BBVENIXSBBTFNBOiB2aXJ0aW86IHVzZSBjb3B5IGFuZCBmaWxsX3NpbGVuY2UgY2FsbGJh
Y2tzCgpUaGlzIGNvbW1pdCByZXBsYWNlcyB0aGUgbW1hcCBtZWNoYW5pc20gd2l0aCB0aGUgY29w
eSgpIGFuZApmaWxsX3NpbGVuY2UoKSBjYWxsYmFja3MgZm9yIGJvdGggY2FwdHVyaW5nIGFuZCBw
bGF5YmFjayBmb3IgdGhlCnZpcnRpby1zb3VuZCBkcml2ZXIuIFRoaXMgY2hhbmdlIGlzIHJlcXVp
cmVkIHRvIHByZXZlbnQgdGhlIHVwZGF0aW5nIG9mCnRoZSBjb250ZW50IG9mIGEgYnVmZmVyIHRo
YXQgaXMgYWxyZWFkeSBpbiB0aGUgYXZhaWxhYmxlIHJpbmcuCgpUaGUgY3VycmVudCBtZWNoYW5p
c20gc3BsaXRzIGEgZG1hIGJ1ZmZlciBpbnRvIGRlc2NyaXB0b3JzIHRoYXQgYXJlCmV4cG9zZWQg
dG8gdGhlIGRldmljZS4gVGhpcyBkbWEgYnVmZmVyIGlzIHNoYXJlZCB3aXRoIHRoZSB1c2VyCmFw
cGxpY2F0aW9uLiBXaGVuIHRoZSBkZXZpY2UgY29uc3VtZXMgYSBidWZmZXIsIHRoZSBkcml2ZXIg
bW92ZXMgdGhlCnJlcXVlc3QgZnJvbSB0aGUgdXNlZCByaW5nIHRvIGF2YWlsYWJsZSByaW5nLgoK
VGhlIGRyaXZlciBleHBvc2VzIHRoZSBidWZmZXIgdG8gdGhlIGRldmljZSB3aXRob3V0IGtub3dp
bmcgaWYgdGhlCmNvbnRlbnQgaGFzIGJlZW4gdXBkYXRlZCBmcm9tIHRoZSB1c2VyLiBUaGUgc2Vj
dGlvbiAyLjguMjEuMSBvZiB0aGUKdmlydGlvIHNwZWMgc3RhdGVzIHRoYXQ6ICJUaGUgZGV2aWNl
IE1BWSBhY2Nlc3MgdGhlIGRlc2NyaXB0b3IgY2hhaW5zCnRoZSBkcml2ZXIgY3JlYXRlZCBhbmQg
dGhlIG1lbW9yeSB0aGV5IHJlZmVyIHRvIGltbWVkaWF0ZWx5Ii4gSWYgdGhlCmRldmljZSBwaWNr
cyB1cCBidWZmZXJzIGZyb20gdGhlIGF2YWlsYWJsZSByaW5nIGp1c3QgYWZ0ZXIgaXQgaXMKbm90
aWZpZWQsIGl0IGhhcHBlbnMgdGhhdCB0aGUgY29udGVudCBtYXkgYmUgb2xkLgoKQnkgcHJvdmlk
aW5nIHRoZSBjb3B5KCkgY2FsbGJhY2ssIHRoZSBkcml2ZXIgZmlyc3QgdXBkYXRlcyB0aGUgY29u
dGVudApvZiB0aGUgYnVmZmVyLCBhbmQgdGhlbiwgZXhwb3NlcyB0aGUgYnVmZmVyIHRvIHRoZSBk
ZXZpY2UgYnkgZW5xdWV1aW5nCml0IGluIHRoZSBhdmFpbGFibGUgcmluZy4gVGh1cywgZGV2aWNl
IGFsd2F5cyBwaWNrcyB1cCBhIGJ1ZmZlciB0aGF0IGlzCnVwZGF0ZWQuCgpGb3IgY2FwdHVyaW5n
LCB0aGUgZHJpdmVyIHN0YXJ0cyBieSBleHBvc2luZyBhbGwgdGhlIGF2YWlsYWJsZSBidWZmZXJz
CnRvIGRldmljZS4gQWZ0ZXIgZGV2aWNlIHVwZGF0ZXMgdGhlIGNvbnRlbnQgb2YgYSBidWZmZXIs
IGl0IGVucXVldWVzIGl0CmluIHRoZSB1c2VkIHJpbmcuIEl0IGlzIG9ubHkgYWZ0ZXIgdGhlIGNv
cHkoKSBmb3IgY2FwdHVyaW5nIGlzIGlzc3VlZAp0aGF0IHRoZSBkcml2ZXIgcmUtZW5xdWV1ZXMg
dGhlIGJ1ZmZlciBpbiB0aGUgYXZhaWxhYmxlIHJpbmcuCgpOb3RlIHRoYXQgdGhlIGNvcHkoKSBm
dW5jdGlvbiBhc3N1bWVzIHRoYXQgdXNlciBpcyBhbHdheXMgd3JpdGluZyBhCnBlcmlvZC4gVGVz
dGluZyBzaG93cyB0aGF0IHRoaXMgaXMgdHJ1ZSBidXQgSSBtYXkgYmUgd3JvbmcuIFRoaXMgUkZD
CmFpbXMgYXQgY2xhcmlmeWluZyB0aGlzLgoKU2lnbmVkLW9mZi1ieTogTWF0aWFzIEV6ZXF1aWVs
IFZhcmEgTGFyc2VuIDxtdmFyYWxhckByZWRoYXQuY29tPgotLS0KIHNvdW5kL3ZpcnRpby92aXJ0
aW9fcGNtLmMgICAgIHwgIDcgKystCiBzb3VuZC92aXJ0aW8vdmlydGlvX3BjbS5oICAgICB8ICA5
ICsrLS0KIHNvdW5kL3ZpcnRpby92aXJ0aW9fcGNtX21zZy5jIHwgODcgKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0KIHNvdW5kL3ZpcnRpby92aXJ0aW9fcGNtX29wcy5jIHwgODEg
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0KIDQgZmlsZXMgY2hhbmdlZCwgMTM1IGlu
c2VydGlvbnMoKyksIDQ5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3ZpcnRpby92
aXJ0aW9fcGNtLmMgYi9zb3VuZC92aXJ0aW8vdmlydGlvX3BjbS5jCmluZGV4IGMxMGQ5MWZmZjJm
Yi4uNjZkNjdlZWYxYmNjIDEwMDY0NAotLS0gYS9zb3VuZC92aXJ0aW8vdmlydGlvX3BjbS5jCisr
KyBiL3NvdW5kL3ZpcnRpby92aXJ0aW9fcGNtLmMKQEAgLTEwNCwxMiArMTA0LDExIEBAIHN0YXRp
YyBpbnQgdmlydHNuZF9wY21fYnVpbGRfaHcoc3RydWN0IHZpcnRpb19wY21fc3Vic3RyZWFtICp2
c3MsCiAJICogb25seSBtZXNzYWdlLWJhc2VkIHRyYW5zcG9ydC4KIAkgKi8KIAl2c3MtPmh3Lmlu
Zm8gPQotCQlTTkRSVl9QQ01fSU5GT19NTUFQIHwKLQkJU05EUlZfUENNX0lORk9fTU1BUF9WQUxJ
RCB8CiAJCVNORFJWX1BDTV9JTkZPX0JBVENIIHwKIAkJU05EUlZfUENNX0lORk9fQkxPQ0tfVFJB
TlNGRVIgfAogCQlTTkRSVl9QQ01fSU5GT19JTlRFUkxFQVZFRCB8Ci0JCVNORFJWX1BDTV9JTkZP
X1BBVVNFOworCQlTTkRSVl9QQ01fSU5GT19QQVVTRSB8CisJCVNORFJWX1BDTV9JTkZPX05PX1JF
V0lORFM7CiAKIAlpZiAoIWluZm8tPmNoYW5uZWxzX21pbiB8fCBpbmZvLT5jaGFubmVsc19taW4g
PiBpbmZvLT5jaGFubmVsc19tYXgpIHsKIAkJZGV2X2VycigmdmRldi0+ZGV2LApAQCAtNDcxLDcg
KzQ3MCw3IEBAIGludCB2aXJ0c25kX3BjbV9idWlsZF9kZXZzKHN0cnVjdCB2aXJ0aW9fc25kICpz
bmQpCiAJCQlmb3IgKGtzcyA9IGtzLT5zdWJzdHJlYW07IGtzczsga3NzID0ga3NzLT5uZXh0KQog
CQkJCXZzLT5zdWJzdHJlYW1zW2tzcy0+bnVtYmVyXS0+c3Vic3RyZWFtID0ga3NzOwogCi0JCQlz
bmRfcGNtX3NldF9vcHModnBjbS0+cGNtLCBpLCAmdmlydHNuZF9wY21fb3BzKTsKKwkJCXNuZF9w
Y21fc2V0X29wcyh2cGNtLT5wY20sIGksICZ2aXJ0c25kX3BjbV9vcHNbaV0pOwogCQl9CiAKIAkJ
c25kX3BjbV9zZXRfbWFuYWdlZF9idWZmZXJfYWxsKHZwY20tPnBjbSwKZGlmZiAtLWdpdCBhL3Nv
dW5kL3ZpcnRpby92aXJ0aW9fcGNtLmggYi9zb3VuZC92aXJ0aW8vdmlydGlvX3BjbS5oCmluZGV4
IDA2MmViOGU4ZjJjZi4uOGI0MjkyOGE4ZTAxIDEwMDY0NAotLS0gYS9zb3VuZC92aXJ0aW8vdmly
dGlvX3BjbS5oCisrKyBiL3NvdW5kL3ZpcnRpby92aXJ0aW9fcGNtLmgKQEAgLTU3LDcgKzU3LDYg
QEAgc3RydWN0IHZpcnRpb19wY21fc3Vic3RyZWFtIHsKIAlib29sIHN1c3BlbmRlZDsKIAlzdHJ1
Y3QgdmlydGlvX3BjbV9tc2cgKiptc2dzOwogCXVuc2lnbmVkIGludCBubXNnczsKLQlpbnQgbXNn
X2xhc3RfZW5xdWV1ZWQ7CiAJdW5zaWduZWQgaW50IG1zZ19jb3VudDsKIAl3YWl0X3F1ZXVlX2hl
YWRfdCBtc2dfZW1wdHk7CiB9OwpAQCAtOTAsNyArODksNyBAQCBzdHJ1Y3QgdmlydGlvX3BjbSB7
CiAJc3RydWN0IHZpcnRpb19wY21fc3RyZWFtIHN0cmVhbXNbU05EUlZfUENNX1NUUkVBTV9MQVNU
ICsgMV07CiB9OwogCi1leHRlcm4gY29uc3Qgc3RydWN0IHNuZF9wY21fb3BzIHZpcnRzbmRfcGNt
X29wczsKK2V4dGVybiBjb25zdCBzdHJ1Y3Qgc25kX3BjbV9vcHMgdmlydHNuZF9wY21fb3BzW107
CiAKIGludCB2aXJ0c25kX3BjbV92YWxpZGF0ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldik7
CiAKQEAgLTExNyw3ICsxMTYsMTEgQEAgaW50IHZpcnRzbmRfcGNtX21zZ19hbGxvYyhzdHJ1Y3Qg
dmlydGlvX3BjbV9zdWJzdHJlYW0gKnZzcywKIAogdm9pZCB2aXJ0c25kX3BjbV9tc2dfZnJlZShz
dHJ1Y3QgdmlydGlvX3BjbV9zdWJzdHJlYW0gKnZzcyk7CiAKLWludCB2aXJ0c25kX3BjbV9tc2df
c2VuZChzdHJ1Y3QgdmlydGlvX3BjbV9zdWJzdHJlYW0gKnZzcyk7CitpbnQgdmlydHNuZF9wY21f
bXNnX3NlbmQoc3RydWN0IHZpcnRpb19wY21fc3Vic3RyZWFtICp2c3MsIHVuc2lnbmVkIGxvbmcg
b2Zmc2V0LAorCQkJIHVuc2lnbmVkIGxvbmcgYnl0ZXMpOworCitpbnQgdmlydHNuZF9wY21fbXNn
X3NlbmRfbG9ja2VkKHN0cnVjdCB2aXJ0aW9fcGNtX3N1YnN0cmVhbSAqdnNzLAorCQkJCXVuc2ln
bmVkIGxvbmcgb2Zmc2V0LCB1bnNpZ25lZCBsb25nIGJ5dGVzKTsKIAogdW5zaWduZWQgaW50IHZp
cnRzbmRfcGNtX21zZ19wZW5kaW5nX251bShzdHJ1Y3QgdmlydGlvX3BjbV9zdWJzdHJlYW0gKnZz
cyk7CiAKZGlmZiAtLWdpdCBhL3NvdW5kL3ZpcnRpby92aXJ0aW9fcGNtX21zZy5jIGIvc291bmQv
dmlydGlvL3ZpcnRpb19wY21fbXNnLmMKaW5kZXggYWNhMmRjMTk4OWJhLi4zYmMwYTYxYTA0NmQg
MTAwNjQ0Ci0tLSBhL3NvdW5kL3ZpcnRpby92aXJ0aW9fcGNtX21zZy5jCisrKyBiL3NvdW5kL3Zp
cnRpby92aXJ0aW9fcGNtX21zZy5jCkBAIC0xNTUsNyArMTU1LDYgQEAgaW50IHZpcnRzbmRfcGNt
X21zZ19hbGxvYyhzdHJ1Y3QgdmlydGlvX3BjbV9zdWJzdHJlYW0gKnZzcywKIAkJCSAgICBzaXpl
b2YobXNnLT54ZmVyKSk7CiAJCXNnX2luaXRfb25lKCZtc2ctPnNnc1tQQ01fTVNHX1NHX1NUQVRV
U10sICZtc2ctPnN0YXR1cywKIAkJCSAgICBzaXplb2YobXNnLT5zdGF0dXMpKTsKLQkJbXNnLT5s
ZW5ndGggPSBwZXJpb2RfYnl0ZXM7CiAJCXZpcnRzbmRfcGNtX3NnX2Zyb20oJm1zZy0+c2dzW1BD
TV9NU0dfU0dfREFUQV0sIHNnX251bSwgZGF0YSwKIAkJCQkgICAgcGVyaW9kX2J5dGVzKTsKIApA
QCAtMTk4LDQ5ICsxOTcsNjMgQEAgdm9pZCB2aXJ0c25kX3BjbV9tc2dfZnJlZShzdHJ1Y3Qgdmly
dGlvX3BjbV9zdWJzdHJlYW0gKnZzcykKICAqICAgICAgICAgIHNwaW5sb2NrcyB0byBiZSBoZWxk
IGJ5IGNhbGxlci4KICAqIFJldHVybjogMCBvbiBzdWNjZXNzLCAtZXJybm8gb24gZmFpbHVyZS4K
ICAqLwotaW50IHZpcnRzbmRfcGNtX21zZ19zZW5kKHN0cnVjdCB2aXJ0aW9fcGNtX3N1YnN0cmVh
bSAqdnNzKQoraW50IHZpcnRzbmRfcGNtX21zZ19zZW5kKHN0cnVjdCB2aXJ0aW9fcGNtX3N1YnN0
cmVhbSAqdnNzLCB1bnNpZ25lZCBsb25nIG9mZnNldCwKKwkJCSB1bnNpZ25lZCBsb25nIGJ5dGVz
KQogewotCXN0cnVjdCBzbmRfcGNtX3J1bnRpbWUgKnJ1bnRpbWUgPSB2c3MtPnN1YnN0cmVhbS0+
cnVudGltZTsKIAlzdHJ1Y3QgdmlydGlvX3NuZCAqc25kID0gdnNzLT5zbmQ7CiAJc3RydWN0IHZp
cnRpb19kZXZpY2UgKnZkZXYgPSBzbmQtPnZkZXY7CiAJc3RydWN0IHZpcnRxdWV1ZSAqdnF1ZXVl
ID0gdmlydHNuZF9wY21fcXVldWUodnNzKS0+dnF1ZXVlOwotCWludCBpOwotCWludCBuOworCXVu
c2lnbmVkIGxvbmcgcGVyaW9kX2J5dGVzID0gc25kX3BjbV9saWJfcGVyaW9kX2J5dGVzKHZzcy0+
c3Vic3RyZWFtKTsKKwl1bnNpZ25lZCBsb25nIHN0YXJ0LCBlbmQsIGk7CisJdW5zaWduZWQgaW50
IG1zZ19jb3VudCA9IHZzcy0+bXNnX2NvdW50OwogCWJvb2wgbm90aWZ5ID0gZmFsc2U7CisJaW50
IHJjOwogCi0JaSA9ICh2c3MtPm1zZ19sYXN0X2VucXVldWVkICsgMSkgJSBydW50aW1lLT5wZXJp
b2RzOwotCW4gPSBydW50aW1lLT5wZXJpb2RzIC0gdnNzLT5tc2dfY291bnQ7CisJc3RhcnQgPSBv
ZmZzZXQgLyBwZXJpb2RfYnl0ZXM7CisJZW5kID0gKG9mZnNldCArIGJ5dGVzIC0gMSkgLyBwZXJp
b2RfYnl0ZXM7CiAKLQlmb3IgKDsgbjsgLS1uLCBpID0gKGkgKyAxKSAlIHJ1bnRpbWUtPnBlcmlv
ZHMpIHsKKwlmb3IgKGkgPSBzdGFydDsgaSA8PSBlbmQ7IGkrKykgewogCQlzdHJ1Y3QgdmlydGlv
X3BjbV9tc2cgKm1zZyA9IHZzcy0+bXNnc1tpXTsKIAkJc3RydWN0IHNjYXR0ZXJsaXN0ICpwc2dz
W10gPSB7CiAJCQkmbXNnLT5zZ3NbUENNX01TR19TR19YRkVSXSwKIAkJCSZtc2ctPnNnc1tQQ01f
TVNHX1NHX0RBVEFdLAogCQkJJm1zZy0+c2dzW1BDTV9NU0dfU0dfU1RBVFVTXQogCQl9OwotCQlp
bnQgcmM7Ci0KLQkJbXNnLT54ZmVyLnN0cmVhbV9pZCA9IGNwdV90b19sZTMyKHZzcy0+c2lkKTsK
LQkJbWVtc2V0KCZtc2ctPnN0YXR1cywgMCwgc2l6ZW9mKG1zZy0+c3RhdHVzKSk7Ci0KLQkJaWYg
KHZzcy0+ZGlyZWN0aW9uID09IFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0spCi0JCQlyYyA9IHZp
cnRxdWV1ZV9hZGRfc2dzKHZxdWV1ZSwgcHNncywgMiwgMSwgbXNnLAotCQkJCQkgICAgICAgR0ZQ
X0FUT01JQyk7Ci0JCWVsc2UKLQkJCXJjID0gdmlydHF1ZXVlX2FkZF9zZ3ModnF1ZXVlLCBwc2dz
LCAxLCAyLCBtc2csCi0JCQkJCSAgICAgICBHRlBfQVRPTUlDKTsKLQotCQlpZiAocmMpIHsKLQkJ
CWRldl9lcnIoJnZkZXYtPmRldiwKLQkJCQkiU0lEICV1OiBmYWlsZWQgdG8gc2VuZCBJL08gbWVz
c2FnZVxuIiwKLQkJCQl2c3MtPnNpZCk7Ci0JCQlyZXR1cm4gcmM7CisJCXVuc2lnbmVkIGxvbmcg
bjsKKworCQluID0gcGVyaW9kX2J5dGVzIC0gKG9mZnNldCAlIHBlcmlvZF9ieXRlcyk7CisJCWlm
IChuID4gYnl0ZXMpCisJCQluID0gYnl0ZXM7CisKKwkJbXNnLT5sZW5ndGggKz0gbjsKKwkJaWYg
KG1zZy0+bGVuZ3RoID09IHBlcmlvZF9ieXRlcykgeworCQkJbXNnLT54ZmVyLnN0cmVhbV9pZCA9
IGNwdV90b19sZTMyKHZzcy0+c2lkKTsKKwkJCW1lbXNldCgmbXNnLT5zdGF0dXMsIDAsIHNpemVv
Zihtc2ctPnN0YXR1cykpOworCisJCQlpZiAodnNzLT5kaXJlY3Rpb24gPT0gU05EUlZfUENNX1NU
UkVBTV9QTEFZQkFDSykKKwkJCQlyYyA9IHZpcnRxdWV1ZV9hZGRfc2dzKHZxdWV1ZSwgcHNncywg
MiwgMSwgbXNnLAorCQkJCQkJICAgICAgIEdGUF9BVE9NSUMpOworCQkJZWxzZQorCQkJCXJjID0g
dmlydHF1ZXVlX2FkZF9zZ3ModnF1ZXVlLCBwc2dzLCAxLCAyLCBtc2csCisJCQkJCQkgICAgICAg
R0ZQX0FUT01JQyk7CisKKwkJCWlmIChyYykgeworCQkJCWRldl9lcnIoJnZkZXYtPmRldiwKKwkJ
CQkJIlNJRCAldTogZmFpbGVkIHRvIHNlbmQgSS9PIG1lc3NhZ2VcbiIsCisJCQkJCXZzcy0+c2lk
KTsKKwkJCQlyZXR1cm4gcmM7CisJCQl9CisKKwkJCXZzcy0+bXNnX2NvdW50Kys7CiAJCX0KIAot
CQl2c3MtPm1zZ19sYXN0X2VucXVldWVkID0gaTsKLQkJdnNzLT5tc2dfY291bnQrKzsKKwkJb2Zm
c2V0ID0gMDsKKwkJYnl0ZXMgLT0gbjsKIAl9CiAKKwlpZiAobXNnX2NvdW50ID09IHZzcy0+bXNn
X2NvdW50KQorCQlyZXR1cm4gMDsKKwogCWlmICghKHZzcy0+ZmVhdHVyZXMgJiAoMVUgPDwgVklS
VElPX1NORF9QQ01fRl9NU0dfUE9MTElORykpKQogCQlub3RpZnkgPSB2aXJ0cXVldWVfa2lja19w
cmVwYXJlKHZxdWV1ZSk7CiAKQEAgLTI1MCw2ICsyNjMsMjIgQEAgaW50IHZpcnRzbmRfcGNtX21z
Z19zZW5kKHN0cnVjdCB2aXJ0aW9fcGNtX3N1YnN0cmVhbSAqdnNzKQogCXJldHVybiAwOwogfQog
CitpbnQgdmlydHNuZF9wY21fbXNnX3NlbmRfbG9ja2VkKHN0cnVjdCB2aXJ0aW9fcGNtX3N1YnN0
cmVhbSAqdnNzLAorCQkJCXVuc2lnbmVkIGxvbmcgb2Zmc2V0LCB1bnNpZ25lZCBsb25nIGJ5dGVz
KQoreworCXN0cnVjdCB2aXJ0aW9fc25kX3F1ZXVlICpxdWV1ZSA9IHZpcnRzbmRfcGNtX3F1ZXVl
KHZzcyk7CisJdW5zaWduZWQgbG9uZyBmbGFnczsKKwlpbnQgcmM7CisKKwlzcGluX2xvY2tfaXJx
c2F2ZSgmcXVldWUtPmxvY2ssIGZsYWdzKTsKKwlzcGluX2xvY2soJnZzcy0+bG9jayk7CisJcmMg
PSB2aXJ0c25kX3BjbV9tc2dfc2VuZCh2c3MsIG9mZnNldCwgYnl0ZXMpOworCXNwaW5fdW5sb2Nr
KCZ2c3MtPmxvY2spOworCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnF1ZXVlLT5sb2NrLCBmbGFn
cyk7CisKKwlyZXR1cm4gcmM7Cit9CisKIC8qKgogICogdmlydHNuZF9wY21fbXNnX3BlbmRpbmdf
bnVtKCkgLSBSZXR1cm5zIHRoZSBudW1iZXIgb2YgcGVuZGluZyBJL08gbWVzc2FnZXMuCiAgKiBA
dnNzOiBWaXJ0SU8gc3Vic3RyZWFtLgpAQCAtMzA5LDYgKzMzOCw4IEBAIHN0YXRpYyB2b2lkIHZp
cnRzbmRfcGNtX21zZ19jb21wbGV0ZShzdHJ1Y3QgdmlydGlvX3BjbV9tc2cgKm1zZywKIAlpZiAo
dnNzLT5od19wdHIgPj0gdnNzLT5idWZmZXJfYnl0ZXMpCiAJCXZzcy0+aHdfcHRyIC09IHZzcy0+
YnVmZmVyX2J5dGVzOwogCisJbXNnLT5sZW5ndGggPSAwOworCiAJdnNzLT54ZmVyX3hydW4gPSBm
YWxzZTsKIAl2c3MtPm1zZ19jb3VudC0tOwogCkBAIC0zMjAsOCArMzUxLDYgQEAgc3RhdGljIHZv
aWQgdmlydHNuZF9wY21fbXNnX2NvbXBsZXRlKHN0cnVjdCB2aXJ0aW9fcGNtX21zZyAqbXNnLAog
CQkJCQlsZTMyX3RvX2NwdShtc2ctPnN0YXR1cy5sYXRlbmN5X2J5dGVzKSk7CiAKIAkJc2NoZWR1
bGVfd29yaygmdnNzLT5lbGFwc2VkX3BlcmlvZCk7Ci0KLQkJdmlydHNuZF9wY21fbXNnX3NlbmQo
dnNzKTsKIAl9IGVsc2UgaWYgKCF2c3MtPm1zZ19jb3VudCkgewogCQl3YWtlX3VwX2FsbCgmdnNz
LT5tc2dfZW1wdHkpOwogCX0KZGlmZiAtLWdpdCBhL3NvdW5kL3ZpcnRpby92aXJ0aW9fcGNtX29w
cy5jIGIvc291bmQvdmlydGlvL3ZpcnRpb19wY21fb3BzLmMKaW5kZXggZjhiZmI4NzYyNGJlLi40
NTY5YjI4NWY1MjAgMTAwNjQ0Ci0tLSBhL3NvdW5kL3ZpcnRpby92aXJ0aW9fcGNtX29wcy5jCisr
KyBiL3NvdW5kL3ZpcnRpby92aXJ0aW9fcGNtX29wcy5jCkBAIC0yODIsNyArMjgyLDYgQEAgc3Rh
dGljIGludCB2aXJ0c25kX3BjbV9wcmVwYXJlKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vi
c3RyZWFtKQogCiAJCXZzcy0+YnVmZmVyX2J5dGVzID0gc25kX3BjbV9saWJfYnVmZmVyX2J5dGVz
KHN1YnN0cmVhbSk7CiAJCXZzcy0+aHdfcHRyID0gMDsKLQkJdnNzLT5tc2dfbGFzdF9lbnF1ZXVl
ZCA9IC0xOwogCX0gZWxzZSB7CiAJCXN0cnVjdCBzbmRfcGNtX3J1bnRpbWUgKnJ1bnRpbWUgPSBz
dWJzdHJlYW0tPnJ1bnRpbWU7CiAJCXVuc2lnbmVkIGludCBidWZmZXJfYnl0ZXMgPSBzbmRfcGNt
X2xpYl9idWZmZXJfYnl0ZXMoc3Vic3RyZWFtKTsKQEAgLTMyNCw3ICszMjMsNyBAQCBzdGF0aWMg
aW50IHZpcnRzbmRfcGNtX3RyaWdnZXIoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJl
YW0sIGludCBjb21tYW5kKQogCXN0cnVjdCB2aXJ0aW9fc25kX3F1ZXVlICpxdWV1ZTsKIAlzdHJ1
Y3QgdmlydGlvX3NuZF9tc2cgKm1zZzsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwotCWludCByYzsK
KwlpbnQgcmMgPSAwOwogCiAJc3dpdGNoIChjb21tYW5kKSB7CiAJY2FzZSBTTkRSVl9QQ01fVFJJ
R0dFUl9TVEFSVDoKQEAgLTMzMyw3ICszMzIsOCBAQCBzdGF0aWMgaW50IHZpcnRzbmRfcGNtX3Ry
aWdnZXIoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0sIGludCBjb21tYW5kKQog
CiAJCXNwaW5fbG9ja19pcnFzYXZlKCZxdWV1ZS0+bG9jaywgZmxhZ3MpOwogCQlzcGluX2xvY2so
JnZzcy0+bG9jayk7Ci0JCXJjID0gdmlydHNuZF9wY21fbXNnX3NlbmQodnNzKTsKKwkJaWYgKHZz
cy0+ZGlyZWN0aW9uID09IFNORFJWX1BDTV9TVFJFQU1fQ0FQVFVSRSkKKwkJCXJjID0gdmlydHNu
ZF9wY21fbXNnX3NlbmQodnNzLCAwLCB2c3MtPmJ1ZmZlcl9ieXRlcyk7CiAJCWlmICghcmMpCiAJ
CQl2c3MtPnhmZXJfZW5hYmxlZCA9IHRydWU7CiAJCXNwaW5fdW5sb2NrKCZ2c3MtPmxvY2spOwpA
QCAtNDUwLDE1ICs0NTAsNzAgQEAgdmlydHNuZF9wY21fcG9pbnRlcihzdHJ1Y3Qgc25kX3BjbV9z
dWJzdHJlYW0gKnN1YnN0cmVhbSkKIAlyZXR1cm4gaHdfcHRyOwogfQogCitzdGF0aWMgaW50IHZp
cnRzbmRfcGNtX3BiX3NpbGVuY2Uoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0s
CisJCQkJICBpbnQgY2hhbm5lbCwgdW5zaWduZWQgbG9uZyBwb3MsCisJCQkJICB1bnNpZ25lZCBs
b25nIGJ5dGVzKQoreworCXN0cnVjdCB2aXJ0aW9fcGNtX3N1YnN0cmVhbSAqdnNzID0gc25kX3Bj
bV9zdWJzdHJlYW1fY2hpcChzdWJzdHJlYW0pOworCXN0cnVjdCBzbmRfcGNtX3J1bnRpbWUgKnJ1
bnRpbWUgPSBzdWJzdHJlYW0tPnJ1bnRpbWU7CisKKwlzbmRfcGNtX2Zvcm1hdF9zZXRfc2lsZW5j
ZShydW50aW1lLT5mb3JtYXQsIHJ1bnRpbWUtPmRtYV9hcmVhICsgcG9zLAorCQkJCSAgIGJ5dGVz
X3RvX3NhbXBsZXMocnVudGltZSwgYnl0ZXMpKTsKKworCXJldHVybiB2aXJ0c25kX3BjbV9tc2df
c2VuZF9sb2NrZWQodnNzLCBwb3MsIGJ5dGVzKTsKK30KKworc3RhdGljIGludCB2aXJ0c25kX3Bj
bV9wYl9jb3B5KHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLCBpbnQgY2hhbm5l
bCwKKwkJCSAgICAgICB1bnNpZ25lZCBsb25nIHBvcywgc3RydWN0IGlvdl9pdGVyICppdGVyLAor
CQkJICAgICAgIHVuc2lnbmVkIGxvbmcgYnl0ZXMpCit7CisJc3RydWN0IHZpcnRpb19wY21fc3Vi
c3RyZWFtICp2c3MgPSBzbmRfcGNtX3N1YnN0cmVhbV9jaGlwKHN1YnN0cmVhbSk7CisJc3RydWN0
IHNuZF9wY21fcnVudGltZSAqcnVudGltZSA9IHN1YnN0cmVhbS0+cnVudGltZTsKKworCWlmIChj
b3B5X2Zyb21faXRlcihydW50aW1lLT5kbWFfYXJlYSArIHBvcywgYnl0ZXMsIGl0ZXIpICE9IGJ5
dGVzKQorCQlyZXR1cm4gLUVGQVVMVDsKKworCXJldHVybiB2aXJ0c25kX3BjbV9tc2dfc2VuZF9s
b2NrZWQodnNzLCBwb3MsIGJ5dGVzKTsKK30KKworc3RhdGljIGludCB2aXJ0c25kX3BjbV9jcF9j
b3B5KHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLCBpbnQgY2hhbm5lbCwKKwkJ
CSAgICAgICB1bnNpZ25lZCBsb25nIHBvcywgc3RydWN0IGlvdl9pdGVyICppdGVyLAorCQkJICAg
ICAgIHVuc2lnbmVkIGxvbmcgYnl0ZXMpCit7CisJc3RydWN0IHZpcnRpb19wY21fc3Vic3RyZWFt
ICp2c3MgPSBzbmRfcGNtX3N1YnN0cmVhbV9jaGlwKHN1YnN0cmVhbSk7CisJc3RydWN0IHNuZF9w
Y21fcnVudGltZSAqcnVudGltZSA9IHN1YnN0cmVhbS0+cnVudGltZTsKKworCWlmIChjb3B5X3Rv
X2l0ZXIocnVudGltZS0+ZG1hX2FyZWEgKyBwb3MsIGJ5dGVzLCBpdGVyKSAhPSBieXRlcykKKwkJ
cmV0dXJuIC1FRkFVTFQ7CisKKwlyZXR1cm4gdmlydHNuZF9wY21fbXNnX3NlbmRfbG9ja2VkKHZz
cywgcG9zLCBieXRlcyk7Cit9CisKIC8qIFBDTSBzdWJzdHJlYW0gb3BlcmF0b3JzIG1hcC4gKi8K
LWNvbnN0IHN0cnVjdCBzbmRfcGNtX29wcyB2aXJ0c25kX3BjbV9vcHMgPSB7Ci0JLm9wZW4gPSB2
aXJ0c25kX3BjbV9vcGVuLAotCS5jbG9zZSA9IHZpcnRzbmRfcGNtX2Nsb3NlLAotCS5pb2N0bCA9
IHNuZF9wY21fbGliX2lvY3RsLAotCS5od19wYXJhbXMgPSB2aXJ0c25kX3BjbV9od19wYXJhbXMs
Ci0JLmh3X2ZyZWUgPSB2aXJ0c25kX3BjbV9od19mcmVlLAotCS5wcmVwYXJlID0gdmlydHNuZF9w
Y21fcHJlcGFyZSwKLQkudHJpZ2dlciA9IHZpcnRzbmRfcGNtX3RyaWdnZXIsCi0JLnN5bmNfc3Rv
cCA9IHZpcnRzbmRfcGNtX3N5bmNfc3RvcCwKLQkucG9pbnRlciA9IHZpcnRzbmRfcGNtX3BvaW50
ZXIsCitjb25zdCBzdHJ1Y3Qgc25kX3BjbV9vcHMgdmlydHNuZF9wY21fb3BzW10gPSB7CisJewor
CQkub3BlbiA9IHZpcnRzbmRfcGNtX29wZW4sCisJCS5jbG9zZSA9IHZpcnRzbmRfcGNtX2Nsb3Nl
LAorCQkuaW9jdGwgPSBzbmRfcGNtX2xpYl9pb2N0bCwKKwkJLmh3X3BhcmFtcyA9IHZpcnRzbmRf
cGNtX2h3X3BhcmFtcywKKwkJLmh3X2ZyZWUgPSB2aXJ0c25kX3BjbV9od19mcmVlLAorCQkucHJl
cGFyZSA9IHZpcnRzbmRfcGNtX3ByZXBhcmUsCisJCS50cmlnZ2VyID0gdmlydHNuZF9wY21fdHJp
Z2dlciwKKwkJLnN5bmNfc3RvcCA9IHZpcnRzbmRfcGNtX3N5bmNfc3RvcCwKKwkJLnBvaW50ZXIg
PSB2aXJ0c25kX3BjbV9wb2ludGVyLAorCQkuY29weSA9IHZpcnRzbmRfcGNtX3BiX2NvcHksCisJ
CS5maWxsX3NpbGVuY2UgPSB2aXJ0c25kX3BjbV9wYl9zaWxlbmNlLAorCX0sCisJeworCQkub3Bl
biA9IHZpcnRzbmRfcGNtX29wZW4sCisJCS5jbG9zZSA9IHZpcnRzbmRfcGNtX2Nsb3NlLAorCQku
aW9jdGwgPSBzbmRfcGNtX2xpYl9pb2N0bCwKKwkJLmh3X3BhcmFtcyA9IHZpcnRzbmRfcGNtX2h3
X3BhcmFtcywKKwkJLmh3X2ZyZWUgPSB2aXJ0c25kX3BjbV9od19mcmVlLAorCQkucHJlcGFyZSA9
IHZpcnRzbmRfcGNtX3ByZXBhcmUsCisJCS50cmlnZ2VyID0gdmlydHNuZF9wY21fdHJpZ2dlciwK
KwkJLnN5bmNfc3RvcCA9IHZpcnRzbmRfcGNtX3N5bmNfc3RvcCwKKwkJLnBvaW50ZXIgPSB2aXJ0
c25kX3BjbV9wb2ludGVyLAorCQkuY29weSA9IHZpcnRzbmRfcGNtX2NwX2NvcHksCisJfSwKIH07
Ci0tIAoyLjQyLjAKCg==

--------------5wSxwIAIFbg74K4UEUVVU5hV--

