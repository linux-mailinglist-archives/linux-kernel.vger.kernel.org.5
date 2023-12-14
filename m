Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65381813856
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443730AbjLNRU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNRUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:20:23 -0500
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C42A0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:20:28 -0800 (PST)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.199.136])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 047221000065A;
        Thu, 14 Dec 2023 17:20:27 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1702574426.651000
X-TM-MAIL-UUID: a4c0a978-4d78-44d6-94b3-697563e986b1
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 9F49910000E48;
        Thu, 14 Dec 2023 17:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhZ+vvMdlP8AcmFoIhAtphMfpnZsRHiE7zH+bTFyhCoJp7nkiszK1tw4oaHgxV3ipkkj8xJDWXac+QxxQr6SEo31kBWJBJ0eDz9BRMCG3z+IlcdYjOU1+/qhdjVTuQ0D/6tknHGf1jg6+eGyTNIbsaMZP5jQ0j8U6S0K4glwQvJhPt8r6xchfYILYqMvzsFzNqw2Ehv2uU9mzj7cyDstG31rry7HQVp+8jiV8NiMJpXg3Bb7Hm/EzRXDQ8N/yYRxD57ysWR+lVXqAhWS2UePGyuCO1X7jZVQhBcJiT4UzxIqZes652oenTkZmgISDynsNhPg+MYJcRVlUIsUFCw90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKIwyn/iWoEpWnQJMIk16o65gQjkD7Nx1yU5ZuEMECI=;
 b=OXe3umalUP4xSIoW+gWh5VDdwlQ88s4Jg7eTGgOwvgifY71VGP936Xpcqxr1D4OpHARot9n7exfPGPoYYQEJRVherwnQxQPC+YkbVDTTk/+EXai7YES58Lx68/BJkBw1LlG0xFyHA36rlHtLctGssf7SggIdHEFHNYLR3DmziFL0J64hPNSfDwhpejmoFvg+p6jnaIIDfVFR9gTX4zoBDXjqznCOobGJTuh03Om+fi2aIjLkALE4xerN56ZUxT+uBOPy/jCwm2eYQr9xtNEd8cmWpJ+NDGqdV7IaJOdzH5kHvUziuj0hb6eOeUHEVHyDD9KLFbrin7LoMJ4xYxoGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <109b15ed-831c-4102-acba-0fd3c82d6440@opensynergy.com>
Date:   Thu, 14 Dec 2023 18:20:06 +0100
Subject: Re: [virtio-dev] [RFC PATCH v1 2/3] virtio-spi: Add virtio-spi.h (V4
 draft specification).
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     virtio-dev@lists.oasis-open.org,
        Haixu Cui <quic_haixcui@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Harald.Mommer@gmail.com,
        quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
 <20231027161016.26625-3-Harald.Mommer@opensynergy.com>
 <20231212103411.wbjmr5mefmxfnsib@vireshk-i7>
 <87f06ede-ac54-48cd-8135-ea2c8f5548f3@opensynergy.com>
 <20231213063335.xaejh3565gkn5cvh@vireshk-i7>
From:   Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <20231213063335.xaejh3565gkn5cvh@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:9e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEUP281MB3414:EE_|FRYP281MB2605:EE_
X-MS-Office365-Filtering-Correlation-Id: af0bc46e-8779-43d2-5dd0-08dbfcc8f597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4btDVf0qTYpCuFmgSwnA7Gmj3TP1jzDDyOZbOUmn3TD+HxEQgSv2c3EAD0mexT8ldCIy3LOj890jpjXuXt526VYjTIwdFm7CS9dLneXeNkY5ZHI18lrsqCoKOYEkUwI4c9qorPBbDqJCoNOiKg/6hzLqUUSxq8GA4il6G88+GpBWyQ3C4aQpzwdkvzAKvS5M0tMQHPTiv9bbJBSF06OO+OyCf6ppJptVNmkCUabb0CWARmLPaBRJCY096HPhsZtJefTPQQcpnyn06Nrmq8/rcVpoT1RR8gbgaCCeHRZr3sVJXzBeOVddpGMo5VhZmFY/istMOiLw79u9Red2oRuYw8VgO7FzDAts+kRPSJE7aiPPuA+7dp8ZC26fXHaH0T5UuacpuCy6pgNuJZw9nYltUuwbb2UAmItr7Aw/5VVodlhh+gWpBNZqSrcqQ0gQe39JhM3E+wR2AdUcEUnOSivxmaMDxcbKzg5orr81nfTQvesoYBwK2EdIlRNU8K1wQlQ2xqWR88Q+EB5u++W+uXBtbQUjlguEI28EHWv3l+tLx/gzlim6joQwnHeFei9ouOa22nc8rflykZH3NaTPfgLy1ZWPzhpAOt7gX8Z6y+sBrXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(26005)(2616005)(83380400001)(86362001)(36756003)(31696002)(31686004)(53546011)(478600001)(54906003)(66476007)(6916009)(316002)(42186006)(66556008)(66946007)(8936002)(44832011)(4326008)(8676002)(2906002)(7416002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTNqSTU0ZmpLejY0ZGhvblFCSEg2czVhUVo3emtoMmZ1SnFKTmUrUU1rNmc5?=
 =?utf-8?B?cUxqSjJTTG9vZ3JmR2ozbWNDMHZBeEFZaGxwTFoxVUdMTVVKVDdkeTR0Y3F6?=
 =?utf-8?B?VjQ4aDRZbURYdXpYYjFNUUM0ZzhBY2wwdmFmWWNCd2xqeitDSzdoTWtQU3Zk?=
 =?utf-8?B?WHpHcStsNzEwcitRTXVPUFFyZDNwQWZSYk5saXBzdGFKQmN5aGt6azNFMWNq?=
 =?utf-8?B?L1hVdDBFc2RlaEo0SzhDYkJwWEtMU3d5c2g4bHMrUVBweWhBNm9nR1JUekNj?=
 =?utf-8?B?bTZEQXIrU1VLRmF1UGVtalVHcUlrMEx2RnVBdVZGRUtXaDgzQzZGUzlJcnpn?=
 =?utf-8?B?UzRZYjNCazhxcnVaQ2kzMHpvNjBxUlVROWxiWmNqRndieWFIWDBheUJ2THNs?=
 =?utf-8?B?QlBhZmJ2U2MxZnRSQlErN21hN2JzUGkwenlFWTQzcTd1UnVaZGVKa21YVWhK?=
 =?utf-8?B?dEVIMlIvbHdTVTFVaDNrZzNaaGpHcUNLTnBxTmpzc2J0VWtxeVU5YzNkTHQz?=
 =?utf-8?B?bGM3OXZPR1J5d1ZmbkFGZnA4bmxDRDkrYTVVa0laYU5vMEpTbDlrVVBsdHFN?=
 =?utf-8?B?MWpQQ1IrYWNhZkVCZ05LZ3JNWjNMUkxPakZua3pNV3l3OEM1Kyszemt1NjFy?=
 =?utf-8?B?MkJBaG5Ib1RrYnlmL1VsU1dQRXhsTVhwTFdld1JzeHgwNGs0Y0JvOXVoNmp5?=
 =?utf-8?B?eS9ta2RTN3RZb2ErZFdJYlM1V2pnSzFmVnNjcUxON2l3SGNzUkVtUXhUSzZB?=
 =?utf-8?B?NFd0eGtPbHo3R1lCdEJsTzh3b3BGOWVuQ2RHSVNlRnBmcU9FQk1oMWVmRk1H?=
 =?utf-8?B?NXZVTEtKbmw4Y20raC82ZTRVM2NVeDJDcnhEVEIxOVRvTVRxeXdyQ2dUem9z?=
 =?utf-8?B?VUxOSnBwYmhma3pxSGdZRUtVeWpuUDlPY2JvT20ySHBtclIxeWVNOUc0WXlo?=
 =?utf-8?B?YlJBaktOUG03N3lacXpHbGYyN0VOVHVJNEc1MXQrR04wQkN3Tm1zZGpUZGZ6?=
 =?utf-8?B?cmVndHZYQTl0UDExUTF2VnRoZWFlN1RJRWxKL2l5bG5OclJvTGgyai9QcmV5?=
 =?utf-8?B?akIrQ2U4ZUdTcjhCUm1hanN5cFdYbnUwUm1uQ01vTFRLeEkwUE4wTDdjS2h5?=
 =?utf-8?B?THI2RCtMUTViM3UrcWNlaWZ1YmVtcUlIOVZvcVdab01QL1BwOXp3NEpVbTl1?=
 =?utf-8?B?bnY4MkdNWGd5aVVDQmxnZm9UNkJXRkhwMmNjUDRiQnRYOHlPMzFpUWE2VzJn?=
 =?utf-8?B?NVhIdVFwTlhGVDZXZWtGVGNtVDZOZTNmRmZpdUhyZXVTWDhTWldTYkZxZFZ2?=
 =?utf-8?B?K2QvNVYyQVY0UHNpNnFCODZvbzNkNWxQUjFCY3JzUjcrazdoaE14bGkydUFP?=
 =?utf-8?B?MVpCc0NOaU1kV0hCY0RyVVRTeWdyRmZ2c0V3TWJZMnFWaExLbnlYT2RjWm55?=
 =?utf-8?B?dXEwR2g5WTNNTlZQdTd0VnFSU2tNTVBFd2tqYldxR1VsQWttMW5yQUpSNU1j?=
 =?utf-8?B?U2pKRW96YUpaWExsTXZLU1EydlY2M09OZGdYUVU3WS9lN1hNUkRGZkNSQzlB?=
 =?utf-8?B?bUpoV3RvTmZnQ3ZkaHRucngrOVd2N2FmbWFSMGt5Q3FmcTFpRmZSdVg3Qzkz?=
 =?utf-8?B?ZHNENi9mK3M5MklrNjZLNVY2UDBUaHhTdXBtb1pFaDBLbnRSRWlscWRobzQ0?=
 =?utf-8?B?WHVYWmVweDdWa0IwNyt3T0dIZDRHRGdudm1JK3JTbGxoSHVlMG9mVCsrbFVa?=
 =?utf-8?B?RmFnaFpNYkQ2NXBXeUZnQi9ya1BWUS85aUhCOFBVZUlWeFh3Q3lsWURubFhi?=
 =?utf-8?B?Y0w3dDRwVFpvTGZjOTNYUEV2dFdDQ3NVK2daWkFSOUlmTEYvSkw5QldOZ2hw?=
 =?utf-8?B?VzVTcUZUS1ZYKzVINThydDRNbEtVODQ0clF0bWxpT1NoNlY4Y3JtcTRzQjZh?=
 =?utf-8?B?TkJWb1pCM1lEK2JtVkJYYUViTjMxNEJsbkNGWUYxQW4rbW5RaHNtRHNRcENo?=
 =?utf-8?B?UHk4S0FFVitaR3RwdnZkV1QxRHE3a1NTUzg2YWduQnlUay9ZMVJhSlFHQlFq?=
 =?utf-8?B?K2VIME5DZnFiSW80ZVdZMmN1dFh4anhYcXNiVzVKQlBDZ0JkSWpjYUxDQllz?=
 =?utf-8?Q?qd+H7X/zhGFVA7n6CpAmjCfy2?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0bc46e-8779-43d2-5dd0-08dbfcc8f597
X-MS-Exchange-CrossTenant-AuthSource: BEUP281MB3414.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 17:20:25.0212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQGrwAD+aTQhHX5/fAiBwb4NLdJDvjQVZDbANxHb/tXIEltlCEXrE2RJVsF6l26v4p3W6xqB4hSiWN1LidPP5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2605
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28058.000
X-TMASE-Result: 10--13.814000-4.000000
X-TMASE-MatchedRID: fE0JoqABJp35ETspAEX/ngw4DIWv1jSVbU+XbFYs1xJbEiFeSNHjmghA
        ldnF4F9nvr/xYGrddAR2niii/WrAP/toM7gJNNcBWGSYKNZi9aXyQ6dAmPdzEgxiBe5NeGLx9NF
        KrIIXgXzgUzDjDzdfPOpveUyNkIpvefr7vldIUbwMfiba6PAK20Ip2pwQ814LUm9B/5XRwTroTS
        /4SHftFRMes8htdAThNGeRmiR9N6MsgR/6UiVnIRsM/hJVvJaGjXUhMb+lTxM7NXkrEITXoLD8l
        cJ8FcxMWelk5oubh9Lj7XeW3zdoXigqC57sXmuTRYNhzuZZjRBjihLPH6H5Tk1sg0HAQZRNvxu7
        Yq+NHNXhZgOr4Upmb7ePGfqO4IUPlQDYQnxtv53FTQGAKRxj5No+48giqZwnEgg3cwDHl/1qdlV
        1LmbEfAP5R/zL3aImJpK4F9wnIiY7AFczfjr/7Bc/AP75GezndL96RUd5CeGo5LxsHn06JQDAhJ
        GBUnW3Yk0d+RVwYxs=
X-TMASE-XGENCLOUD: 5a996b41-675d-4615-8004-bb97d3091d0b-0-0-200-0
X-TM-Deliver-Signature: E996C416EFD648AE2AFE579E7AB64DB0
X-TM-Addin-Auth: 3uLyNSPmetJRTvVF5niKHIzCs7pHtn1Uxzfw0w29czY0/phdali9XuyGFt8
        8ZdeQ3H3hwIezrnhhqMxu1aAQvio4no33Ip85TnF3f+SUBCfvpXRXlwxyscNYTGBfU6W+9+OPmx
        zhVgN1z0B6/A5YtLKEmW5A1LUKvOkaeVUi0W4Ru5zk8VoXPWMw49nx/kny/LHjbRXlo6ayfJ5mg
        C9KNEDC5rHILLYxAOhjM9F/HjPU7LR0+h6S6AZD25BLJOsorNGbO0sAPCFy6f8HglXOEhit+JOQ
        ZJya2Fv7WJJot8s=.aOWFvEAdaFRLMTQPBm7knv9KGNjowEPVKkOsp/dgkwWLVl2mrB66ky27dQ
        cS2jkc83KCQYVOSorFXV2lUhHV5pTE2XhRnxwq7tdd3ladk/8nPM1fpFTubZfAtuItGVXHdJT5f
        ycLeJr34zSwqJm0QWpIRwN2bU8gazguiUZBTACikFwsJUimwuwA7fQaOl1ckJ4+jge4mn8S5lb0
        5cjQUhPr+B1cCxrualP9CMnaOOq+lMVaxX9KJLEBLD5Yhvj4x3uJMTc5FppPliX2qWtR6AswAsc
        RYIyRzT3NfxVNudMd17dPg7SLjynIfk9JqTU8H7rcaWq0vvYGTzvz6HmmFw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1702574426;
        bh=tmh87jcGg1gJqvKPdLIw/1M6mMgTtvA0O8J/zXj/Xn4=; l=4582;
        h=Date:To:From;
        b=JyUhSlBbQcwH7SlaU2xfPJOX8KcbbwkHRWlWjARNdW61frit6+175MO17uXtniuZn
         bPKL8REtVVRikXwwDdU356AGpstRmo4utSF771Dgt5/Z9BHAbadrhPfSHTtbkMcKnI
         0icL0KKTA932CsABo3omcfhJlseBmoe4l2T6dfzliTGfk9Q563TiYi5lsQBLSTTsBj
         PH7na5gJv/1sV06ElMpGSPO4wcWRqGGDNcTHBupTBaPZz89360KhbwGsdu33E8j1mT
         xhC9kxYhMGpr92gotLcqC6wf/a1fRTVI/w9LLUK/u3vazeSNi29xIrR2/4VxrB9DwD
         NOVwMixNJWjRQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Viresh,

On 13.12.23 07:33, Viresh Kumar wrote:
> On 12-12-23, 19:58, Harald Mommer wrote:
>> On 12.12.23 11:34, Viresh Kumar wrote:
>> I'm working on V8. It's coming to an end, will still have to check some
>> details but it's close. Internal review pending. Now there is a V9 and I
>> will also have to look at this. Maybe I will send V8 and subsequently update
>> to V9,
> I hope you are talking about V8/V9 of the spec here, as I only see one
> version of the Linux driver on the list. Please keep me in cc if
> possible.

What you see is RFC PATCH v1 which meets the V4 draft specification. The 
only one which has been sent so far. For you this is latest. And now I 
got so much comments from you and also a spec update from V8 to V9 so 
that this will remain that way for some days. Need to do changes.

The next one will be RFC patch v2 and is planned to be made according to 
the V9 spec.

And most probably the next one will also attempt to be V9 spec compliant 
if there comes in the mean time a specification update. Moving target 
not good if you work agile, extension of scope all the time.

>>> On 27-10-23, 18:10, Harald Mommer wrote:
>>>> +++ b/include/uapi/linux/virtio_spi.h
>>>> @@ -0,0 +1,130 @@
>>>> +/* SPDX-License-Identifier: BSD-3-Clause */
>>> Maybe this should be:
>>>
>>> SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>>>
>>> ?
>> Looking into what others do here. virtio_blk.h, virtio_input.h and
>> virtio_iommu.h for example: None is using GPL-2.0 here. virtio_iommu.h is
>> using exactly the same header as we do.
> Looked at all headers for SPDX License in include/uapi/ and this is
> what I see (Yes there are many non SPDX licenses there):
>
>      522 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>      106 /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
>       18 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
>       16 /* SPDX-License-Identifier: LGPL-2.1+ WITH Linux-syscall-note */
>       16 /* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>       11 /* SPDX-License-Identifier: GPL-1.0+ WITH Linux-syscall-note */
>        6 /* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR BSD-3-Clause) */
>        5 /* SPDX-License-Identifier: BSD-3-Clause */
>        4 /* SPDX-License-Identifier: LGPL-2.1 WITH Linux-syscall-note */
>        4 /* SPDX-License-Identifier: LGPL-2.0+ WITH Linux-syscall-note */
>        4 /* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
>        3 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
>        2 /* SPDX-License-Identifier: MIT */
>        2 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
>        2 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR CDDL-1.0) */
>        2 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
>        2 /* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
>        1 /* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR MIT) */
>        1 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause */
>        1 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
>        1 /* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note*/
>
> Also Documentation/process/license-rules.rst says:
>
> "The license described in the COPYING file applies to the kernel source
> as a whole, though individual source files can have a different license
> which is required to be compatible with the GPL-2.0::
>
> ...
>
> Aside from that, individual files can be provided under a dual license,
> e.g. one of the compatible GPL variants and alternatively under a
> permissive license like BSD, MIT etc."
>
> And so I thought we may want this to be a dual license.

Please focus on include/uapi/linux/virtio_*.h files only.

You will see a lot BSD without mentioning GPL at all. So we are just 
doing what others did and what was accepted in the past. Changing the 
license is not a change I can do with a finger tip.

>>>> +/* All config fields are read-only for the Virtio SPI driver */
>>>> +struct virtio_spi_config {
>>> Can you please add proper doc style comments for the structures ?
>> Checking my current code. This is updated in the V8 version.
> V8 of this patch ?

V8 of the spec. Don't worry, you missed no code change, you are on 
public latest.


