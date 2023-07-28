Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AEB76654A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjG1H1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjG1H0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:26:42 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F41B3A8B;
        Fri, 28 Jul 2023 00:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EF+fGvR4OBiI6LMCZJvdVuJ+iNd13Qq2Ngg5vlgoi1dXxbb1S9h6INGivzhNgn+yXgrg3RZfyO3MaNBVzxd/o94UpFrbK4O8SK/GvCkupw1VHMfCgcVbnrf7AdCwdED4XYGfGztNTP91VZs9VzCFX5CvCX63H/glbQnCTcjxF4GbgoVocFCCFAU1/7Xs/Hiqtlwa5Mt7C//5esLxljhnPlpHOkKyhvLSt4VaLpV1mwyfOZ8Q8cC1TQWn+FGd+3U126mJ1jDzsOFjNrfSpn9njHPLMHJkpsUAClO/JWX9ChObmnWFpTJSxqZKBK4Q6bAg2IwbFAPUnIj3kfGvmV8hrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YnMa943IaLT1zPYOXIwbj9Uh3YFWLDIQg6XYWGD3Kw=;
 b=g4T4WOG5fF7rtAyhH0FEkVGR+vOX8Mx6u2dfBuRdJkQCdrDvZBQrvqt0EOM87WkuQVorgAFXbXFA5GcjXfG1HCojYXDKf1OorxsCWNTGYbR6rtzWhmVgnoGi4f8RlXuwk1LeZ9EDWO1Jd8nVNfVWZArxohRnh2LL9FLS9oHYzYlOzkD+6JHYlkdtpUvNPMTqnGhFhQGjo3YrfA31d7dOu3Eal/RwV6wwcilPMpRuYGGkpTXMNZ/MGq3+FXiaT2xeSYP5sBUfTBNiPmykjMNEq+QzvDeg0TtQj4RJ9GG88O7RGn3mqm2ef9ZGKPmCjK/6mdUtvQbjErBOzYmSsB+PnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YnMa943IaLT1zPYOXIwbj9Uh3YFWLDIQg6XYWGD3Kw=;
 b=jnoK+NsZ4sQ6gnFJ5Pim1iqQgizOuVisdwpdf+7iH0O9G1Uf6MiMGOA9YrwwSuUpFTw4rV6ZxcIy4d2tiYdFEY38G/1yIQccshTSTBUp4Ml7VWzH75a4JuBUGZOm4XDfg3VveCFdxCu/IKCwUTJX5V2xZWRn4gGYAqT0joqhU6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by CH2PR03MB5285.namprd03.prod.outlook.com (2603:10b6:610:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 07:26:37 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 07:26:37 +0000
Message-ID: <08588eb0-0e3f-828a-65be-50460560095d@synaptics.com>
Date:   Fri, 28 Jul 2023 15:26:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 10/11] media: v4l2: Add DELETE_BUF ioctl
Content-Language: en-GB
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, ming.qian@nxp.com,
        hverkuil-cisco@xs4all.nl, gregkh@linuxfoundation.org,
        ezequiel@vanguardiasur.com.ar,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, nicolas.dufresne@collabora.com,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        mchehab@kernel.org, m.szyprowski@samsung.com,
        ayaka <ayaka@soulik.info>
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-11-benjamin.gaignard@collabora.com>
 <80a03c29-6f3d-43f1-755c-10f3ae2c2756@synaptics.com>
 <42a45bad-09c7-ffb6-49cb-29ec0826599d@collabora.com>
 <3b22fda9-4a0e-2c03-2f12-19e5e3239235@synaptics.com>
 <54833256-7d88-9316-4f0f-b8c57552cd7b@synaptics.com>
 <20230713090944.3gxrxt7lqnozhu7r@chromium.org>
 <e4bb9520-489f-2bb3-4a17-668c3f448668@synaptics.com>
 <CAAFQd5D8bTdqT4tS5R4P60+T+qLcqQ-JMeA3vSN6TRLQXCazWw@mail.gmail.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <CAAFQd5D8bTdqT4tS5R4P60+T+qLcqQ-JMeA3vSN6TRLQXCazWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::31) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|CH2PR03MB5285:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d06053-9ca0-43fa-a022-08db8f3bfa71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cX0GFrYIXEyUlnpjP5NAFHGx5vOv2QKdNYE2VouHFADOSMRyjATFeQjE82USjmYfBXGfMiqaOYSaVFJsMNeroTpOXWxx4Vl2fkNxKnGU5drZ8kcgO3uqmaShF5TiOcoTsJ9uDDuHPXVB4eFGT1PtPsk0Y+NZEJTK/85UDVMCdJzsnHqWjE1SKfIi2xWd1jqSs0qPZHKOOi+l0wSqeM6Eg7xeMHVsxtpgvdpuz0m83bIRqdSIXiCswa0sH4QUNwYIYsSbE3PgNyYmW22vxyD6cUjEQrZhANhO11BTotblEHRQlLSjD033rcd/Iir8isbax9jy12Hj8S6aIYqhgeciTQettM8GNxvq/+9tlxJmDSuTDc/9FBdowXqsDexwv+kMHS8jHn9BWhQ2zGHnpT5NdSjpviw5841l7pLlMT/Up6ydwun6SAd5beszEmXVzUZjl5wTO0ZDDHpB5BNCHJjxRsmuHxKWWhhvkt6pijnxSfUTwvtJMVby8RZkdpnpTNy1As1MSBAbVi7ajiu67jVMznDIkAfNcXu7+DFE0uQRB1fXgPnz71djUHmPO2gidIY9qlz2yDr49fJaohVQSzjGBefV6/m3G9Vm5lglVi7GYsdglnmTQN5TEI1ZO8Ux+3pE002fAEtWyEZZno/7xEf/Yl/wExDkbX1J+Y8J45dbqkQIfBXkxGn1R93lM/CKDMMt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39850400004)(376002)(136003)(366004)(451199021)(38100700002)(54906003)(6666004)(6486002)(478600001)(38350700002)(52116002)(316002)(8676002)(41300700001)(6916009)(2616005)(66476007)(66946007)(8936002)(66556008)(5660300002)(4326008)(186003)(66574015)(83380400001)(26005)(53546011)(6506007)(6512007)(31696002)(86362001)(30864003)(2906002)(7416002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxiM2NCK2s3NzRRdjhCMnBERCs4R1NDR3lmWDU4SUNzeFhuMXdpc0ZZcndC?=
 =?utf-8?B?amVCMzBDM3pORnBCT1FoVWN4U01NZStSTjJpY1M4Lzg2cWorSG1VNDkyVXpv?=
 =?utf-8?B?bm5KM09HVFBreHdrLzFKbW45U3pwWkVVOGI5eFV0U2l5c3dSS1Vpc0ZoUU5P?=
 =?utf-8?B?aitxZUFlYVBIaXpGaFBUWUIzV2VEWm5jOVhEUGh1cVFjenRIYnlHZG1vUG1G?=
 =?utf-8?B?aXhTZWh0T3BmN3VmenlpSFNmSUJyMk01TCtuTE01ZzVVcDRkMStVL2JRR2xn?=
 =?utf-8?B?d1J4SmVpNHhCaCtpZXV6L0JlTnlRSW1UYzIzSnE5S3N6d0hRS01hTGNCUTNB?=
 =?utf-8?B?SXBZbStHQ3gvaXQwRWVjZEFtZXRPd2Z2RXFodktuV2VyaE9xRXhSUTg4RnQw?=
 =?utf-8?B?d1grRVVWZ2JTZ1pPL0Jsdk1ITkJDNkNsbFc4aDMrTjB3RTc4SjVZUms5TGJk?=
 =?utf-8?B?M2tPTDBZT2dmVUdsV0xkN3hwcHd6UWVDejFQMjZHb29aYW5ldCt5bzBrSlNt?=
 =?utf-8?B?eWpycUgzTGVQREQ2TmMvSEUwSUdwTTdGR0RqWEtWNk1NbU5YRUxTVDhURGdE?=
 =?utf-8?B?Z1p3bDVaT0hxT2hjNDJrZHdkeVAybXg1Y3h5QWVMUCtUcGJzUktWMXBjcFF5?=
 =?utf-8?B?cHRxSUVJQjV2QjhQOGRGYW00MUZiWkdpUTI0UGcwR0RRVisyWlFDYkI2Nkhy?=
 =?utf-8?B?bmJrbnBwMTBzcElTYnVhVTdwSm4vTWdxNXRGaFNmK2FyZEpudndpZ1ZVcWpm?=
 =?utf-8?B?bjdqUlNJdTEvaW5taHNMQTU2S21qYnZCQjRpajZhSUNHQmwxM0FmZDNwWGg2?=
 =?utf-8?B?OU83dVZieFZkLzYycEJFQlpsaFMrd1hGOXpvTS9LVllaTytSWnRaV01RN2la?=
 =?utf-8?B?V3k3UXVzVzZYbGNhT2MycXJrN1E0T1FGejQ5Slh6eWdsRm8rUmptQ3pMNkF0?=
 =?utf-8?B?Qi9mUW9VRGxXLy9jSFFxVmlkRW05S3lHYUhJK0k0WURTa0ZyQkgyd2JUbjVh?=
 =?utf-8?B?NHBDd0hOdWtiNWduN2w5QmxGZWIyMzBIdCtYVW1ibXJaZzRqbm5PYk4reTQw?=
 =?utf-8?B?Q1VmMkd2NElPNHRVbElPTHMyaUErNXdLNTdnTjBlMWxRbDR0cUl4WHBLVFp2?=
 =?utf-8?B?Sk5wU2VYcTZ6bnZ3V1lrQ2FGeFhiM2JtZmhBZHhkNTlqQnRLTU9XWG4rU0kz?=
 =?utf-8?B?QmRtVDQxZEhwQVk3OWRDUlFZZU9seWNBLzg2MXhsbTFMdDYyeStHM0Z5YlI0?=
 =?utf-8?B?R295R3pBVGk0Z1N4SWp6WkZxZ0N5R2FPc0xUQ0JlanM3T2kxVzE2S2hyYjVT?=
 =?utf-8?B?Sm9jNkg1R2UzSHVNS0NLTTZ0Y1ViQzRKOG9NVFY5VGZCTDNneEhCYXZxNWNx?=
 =?utf-8?B?dG9nNk1Rd0RZQ1VsME55Yk5Nd1dvUFZPQzdVQmpZcUkzRjIvNjZGOXV0M1cw?=
 =?utf-8?B?U1hwUUZKRVZXU2oyS3ZDeHJRNFduZkZZV1JIT3NxM2x2REErTm8zS1d4MkNN?=
 =?utf-8?B?K1BpbzkwUERnbm5SNFBuVVoxYVlXNSswVzQxQmttRHk0ZUszQzBNQXkva0s1?=
 =?utf-8?B?THNQc1VZZ2JsZVlkeFU4RlhVZUR1N01DV2FaMVBFUGp2Ukp3ZzgzUGp6eXFV?=
 =?utf-8?B?TXJDYlNObUhkRnhoV3hkY1VjUHhwN3hHQ1N0ZWtRdkM3MjZZTGNlNktIdjll?=
 =?utf-8?B?SjJuWmVEZGUvUGRmSE80MkJvTHRlL05QN3AvcmxXWWtZbHlydEpPakVIQmVp?=
 =?utf-8?B?ZlovcHo2UERvcGxzejJ1VjIwZklQV1pQRmZwaFM3RHc4ZUdHbmNzS2VieURF?=
 =?utf-8?B?aDRKZDlCMGNDRndCeE5ScklVVXpZV05YV0hObTdtL0Vsck04SUMyNEdxeFNR?=
 =?utf-8?B?aHFVNHF4dHNZakN5NTNhU3ZocjJUTUI0WTdrZTJjQk1tNnhuRUJJWmJqM3Jq?=
 =?utf-8?B?ditYaW9NdUVMNkpmWTY4N3dwN0V4S1dyaEltZGd2VEFqZWY0ajVmTmQ4OTBs?=
 =?utf-8?B?bXhoU29xMXpXVjBoM0dEQWdkMlZ4RXVSUG5YazVoZXFBZStjNHB1QWE5TjdO?=
 =?utf-8?B?dEpEVWRoQjRHcmwvaUJOb0E4dHpNcms2R0kxcTJqTUJzYkNwNS8wQm1HeEZt?=
 =?utf-8?Q?GhZaippR+VM3KtrszN2Il4Os/?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d06053-9ca0-43fa-a022-08db8f3bfa71
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 07:26:37.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70xINtGZSwR9QjsuWKfdgxt8L+XNzrZlnWVSu2OOFpAy8A6aze7tkjKNq3YkY5tNxRtMXPwrsK0ME1clt9lmvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5285
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/23 14:57, Tomasz Figa wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Mon, Jul 17, 2023 at 11:17 AM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>>
>>
>> On 7/13/23 17:09, Tomasz Figa wrote:
>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> On Fri, Jun 30, 2023 at 05:43:51PM +0800, Hsia-Jun Li wrote:
>>>> On 6/27/23 16:47, Hsia-Jun Li wrote:
>>>>> CAUTION: Email originated externally, do not click links or open
>>>>> attachments unless you recognize the sender and know the content is
>>>>> safe.
>>>>>
>>>>>
>>>>> On 6/27/23 16:43, Benjamin Gaignard wrote:
>>>>>> CAUTION: Email originated externally, do not click links or open
>>>>>> attachments unless you recognize the sender and know the content is
>>>>>> safe.
>>>>>>
>>>>>>
>>>>>> Le 27/06/2023 à 09:30, Hsia-Jun Li a écrit :
>>>>>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
>>>>>>>> CAUTION: Email originated externally, do not click links or open
>>>>>>>> attachments unless you recognize the sender and know the content is
>>>>>>>> safe.
>>>>>>>>
>>>>>>>>
>>>>>>>> VIDIOC_DELETE_BUF ioctl allows to delete a buffer from a queue.
>>>>>>>>
>>>>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>>>>> ---
>>>>>>>>     .../userspace-api/media/v4l/user-func.rst     |  1 +
>>>>>>>>     .../media/v4l/vidioc-delete-buf.rst           | 51
>>>>>>>> +++++++++++++++++++
>>>>>>>>     .../media/common/videobuf2/videobuf2-core.c   | 33 ++++++++++++
>>>>>>>>     .../media/common/videobuf2/videobuf2-v4l2.c   |  6 +++
>>>>>>>>     drivers/media/v4l2-core/v4l2-dev.c            |  1 +
>>>>>>>>     drivers/media/v4l2-core/v4l2-ioctl.c          | 10 ++++
>>>>>>>>     include/media/v4l2-ioctl.h                    |  4 ++
>>>>>>>>     include/media/videobuf2-core.h                |  9 ++++
>>>>>>>>     include/media/videobuf2-v4l2.h                | 11 ++++
>>>>>>>>     include/uapi/linux/videodev2.h                |  2 +
>>>>>>>>     10 files changed, 128 insertions(+)
>>>>>>>>     create mode 100644
>>>>>>>> Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>>>>
>>>>>>>> diff --git a/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>>>> b/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>>>> index 15ff0bf7bbe6..8c74016e12fd 100644
>>>>>>>> --- a/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>>>> +++ b/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>>>> @@ -17,6 +17,7 @@ Function Reference
>>>>>>>>         vidioc-dbg-g-chip-info
>>>>>>>>         vidioc-dbg-g-register
>>>>>>>>         vidioc-decoder-cmd
>>>>>>>> +    vidioc-delete-buf
>>>>>>>>         vidioc-dqevent
>>>>>>>>         vidioc-dv-timings-cap
>>>>>>>>         vidioc-encoder-cmd
>>>>>>>> diff --git
>>>>>>>> a/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>>>> b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..0e7ce58f91bc
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>>>> @@ -0,0 +1,51 @@
>>>>>>>> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
>>>>>>>> +.. c:namespace:: V4L
>>>>>>>> +
>>>>>>>> +.. _VIDIOC_DELETE_BUF:
>>>>>>>> +
>>>>>>>> +************************
>>>>>>>> +ioctl VIDIOC_DELETE_BUF
>>>>>>>> +************************
>>>>>>>> +
>>>>>>>> +Name
>>>>>>>> +====
>>>>>>>> +
>>>>>>>> +VIDIOC_DELETE_BUF - Delete a buffer from a queue
>>>>>>>> +
>>>>>>>> +Synopsis
>>>>>>>> +========
>>>>>>>> +
>>>>>>>> +.. c:macro:: VIDIOC_DELETE_BUF
>>>>>>>> +
>>>>>>>> +``int ioctl(int fd, VIDIOC_DELETE_BUF, struct v4l2_buffer *argp)``
>>>>>>>> +
>>>>>>>> +Arguments
>>>>>>>> +=========
>>>>>>>> +
>>>>>>>> +``fd``
>>>>>>>> +    File descriptor returned by :c:func:`open()`.
>>>>>>>> +
>>>>>>>> +``argp``
>>>>>>>> +    Pointer to struct :c:type:`v4l2_buffer`.
>>>>>>>> +
>>>>>>>> +Description
>>>>>>>> +===========
>>>>>>>> +
>>>>>>>> +Applications can optionally call the
>>>>>>>> :ref:`VIDIOC_DELETE_BUF` ioctl to
>>>>>>>> +delete a buffer from a queue.
>>>>>>>> +
>>>>>>>> +The struct :c:type:`v4l2_buffer` structure is specified in
>>>>>>>> +:ref:`buffer`.
>>>>>>>> +
>>>>>>>> +Return Value
>>>>>>>> +============
>>>>>>>> +
>>>>>>>> +On success 0 is returned, on error -1 and the ``errno`` variable is
>>>>>>>> set
>>>>>>>> +appropriately. The generic error codes are described at the
>>>>>>>> +:ref:`Generic Error Codes <gen-errors>` chapter.
>>>>>>>> +
>>>>>>>> +EBUSY
>>>>>>>> +    File I/O is in progress.
>>>>>>>> +
>>>>>>>> +EINVAL
>>>>>>>> +    The buffer ``index`` doesn't exist in the queue.
>>>>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>> index 899783f67580..aa546c972c3d 100644
>>>>>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>> @@ -1637,6 +1637,39 @@ int vb2_core_prepare_buf(struct vb2_queue *q,
>>>>>>>> unsigned int index, void *pb)
>>>>>>>>     }
>>>>>>>>     EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
>>>>>>>>
>>>>>>>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index)
>>>>>>>> +{
>>>>>>>> +       struct vb2_buffer *vb;
>>>>>>>> +
>>>>>>>> +       vb = vb2_get_buffer(q, index);
>>>>>>>> +       if (!vb) {
>>>>>>>> +               dprintk(q, 1, "invalid buffer index %d\n", index);
>>>>>>>> +               return -EINVAL;
>>>>>>>> +       }
>>>>>>>> +
>>>>>>>> +       if (vb->state != VB2_BUF_STATE_DEQUEUED) {
>>>>>>>> +               dprintk(q, 1, "can't delete non dequeued buffer index
>>>>>>>> %d\n", index);
>>>>>>>> +               return -EINVAL;
>>>>>>>> +       }
>>>>>>>> +
>>>>>>> I know the driver could implement its own
>>>>>>> v4l2_ioctl_ops->vidioc_delete_buf() that check whether a buffer is
>>>>>>> used by the hardware as a future reference frame.
>>>>>>> But I think we need a flag to let the user know which buffer is still
>>>>>>> used by the hardware.
>>>>>>> Alternative ref case is safe, we only know it's existing when it is
>>>>>>> dequeued in current V4L2 buffer mechanism.
>>>>>>> While the Golden reference frame, such long term reference frame could
>>>>>>> last much longer.
>>>>>> It is up to userland stack to know frames life time, it got the
>>>>>> information for that.
>>>>> That is true for the stateless codec driver.
>>>>>
>>>>> While application for stateful decoder could never do that. It also
>>>>> breaks what the document said:
>>>>>
>>>>> "The backing memory of |CAPTURE| buffers that are used as reference
>>>>> frames by the stream may be read by the hardware even after they are
>>>>> dequeued. Consequently, the client should avoid writing into this memory
>>>>> while the |CAPTURE| queue is streaming. Failure to observe this may
>>>>> result in corruption of decoded frames."
>>>>>
>>>>>>>> +       if (vb->planes[0].mem_priv)
>>>>>>>> +               call_void_vb_qop(vb, buf_cleanup, vb);
>>>>>>>> +
>>>>>>>> +       /* Free MMAP buffers or release USERPTR buffers */
>>>>>>>> +       if (q->memory == VB2_MEMORY_MMAP)
>>>>>>>> +               __vb2_buf_mem_free(vb);
>>>> Here is another problem for the existing application, the mmap() from the
>>>> mmap offset or exportbuffer fd would not create a reference to buffer in
>>>> this step(while the exportbuffer would create one itself).
>>>>
>>>> When you delete a buffer, you may not release it from its virtual memory
>>>> space, leaving a corrupted virtual memory space.
>>> What do you mean? __vb2_buf_mem_free() doesn't unconditionally free the
>>> memory, it just decrements a reference counter.
>>
>> struct dma_buf_ops->mmap() may not increase a reference to its buffer.
I think we are talking the same refcount.
That is vb2_vmarea_handler->refcount.
While, I am thinking about refcount from vb2_dc_buf.
> 
> Both V4L2 mmap() and DMA-buf mmap() of buffers exported from V4L2
> would increase a reference to the buffer. They both lead to
> vb2_{dc,sg,vmalloc}_mmap() which open the VMA, which in turn calls
> vb2_common_vm_open() that increases the buffer refcount.
> 
> Best regards,
> Tomasz
> 
>>
>> While struct vb2_mem_ops->get_dmabuf() would.
>>
>>> The VMA holds its own,
>>> so the buffer is only fully released when the application calls
>>> munmap().
>>
>> DELETE_BUF ioctl() didn't answer to this problem. Should the DELETE_BUF
>> ioctl() make the no other user could access to this.
>>
>>>
>>> Best regards,
>>> Tomasz
>>>
>>>> Also this behavior is
>>>> right, because mmap(2) says:
>>>>
>>>> "After  the  mmap()  call has returned, the file descriptor, fd, can be
>>>> closed immediately without invalidating the map‐ping."
>>>>
>>>>>>>> +       else if (q->memory == VB2_MEMORY_DMABUF)
>>>>>>>> +               __vb2_buf_dmabuf_put(vb);
>>>>>>>> +       else
>>>>>>>> +               __vb2_buf_userptr_put(vb);
>>>>>>>> +
>>>>>>>> +       vb2_queue_remove_buffer(q, vb);
>>>>>>>> +       kfree(vb);
>>>>>>>> +
>>>>>>>> +       dprintk(q, 2, "buffer %d deleted\n", index);
>>>>>>>> +       return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>     /*
>>>>>>>>      * vb2_start_streaming() - Attempt to start streaming.
>>>>>>>>      * @q:         videobuf2 queue
>>>>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>>>> b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>>>> index 724135d41f7f..cea666c17b41 100644
>>>>>>>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>>>> @@ -751,6 +751,12 @@ int vb2_prepare_buf(struct vb2_queue *q, struct
>>>>>>>> media_device *mdev,
>>>>>>>>     }
>>>>>>>>     EXPORT_SYMBOL_GPL(vb2_prepare_buf);
>>>>>>>>
>>>>>>>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b)
>>>>>>>> +{
>>>>>>>> +       return vb2_core_delete_buf(q, b->index);
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL_GPL(vb2_delete_buf);
>>>>>>>> +
>>>>>>>>     int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers
>>>>>>>> *create)
>>>>>>>>     {
>>>>>>>>            unsigned requested_planes = 1;
>>>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-dev.c
>>>>>>>> b/drivers/media/v4l2-core/v4l2-dev.c
>>>>>>>> index f81279492682..80ace2e1e932 100644
>>>>>>>> --- a/drivers/media/v4l2-core/v4l2-dev.c
>>>>>>>> +++ b/drivers/media/v4l2-core/v4l2-dev.c
>>>>>>>> @@ -720,6 +720,7 @@ static void determine_valid_ioctls(struct
>>>>>>>> video_device *vdev)
>>>>>>>>                    SET_VALID_IOCTL(ops, VIDIOC_PREPARE_BUF,
>>>>>>>> vidioc_prepare_buf);
>>>>>>>>                    SET_VALID_IOCTL(ops, VIDIOC_STREAMON,
>>>>>>>> vidioc_streamon);
>>>>>>>>                    SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF,
>>>>>>>> vidioc_streamoff);
>>>>>>>> +               SET_VALID_IOCTL(ops, VIDIOC_DELETE_BUF,
>>>>>>>> vidioc_delete_buf);
>>>>>>>>            }
>>>>>>>>
>>>>>>>>            if (is_vid || is_vbi || is_meta) {
>>>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>>>> b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>>>> index a858acea6547..1c737279d3ef 100644
>>>>>>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>>>> @@ -2156,6 +2156,15 @@ static int v4l_prepare_buf(const struct
>>>>>>>> v4l2_ioctl_ops *ops,
>>>>>>>>            return ret ? ret : ops->vidioc_prepare_buf(file, fh, b);
>>>>>>>>     }
>>>>>>>>
>>>>>>>> +static int v4l_delete_buf(const struct v4l2_ioctl_ops *ops,
>>>>>>>> +                         struct file *file, void *fh, void *arg)
>>>>>>>> +{
>>>>>>>> +       struct v4l2_buffer *b = arg;
>>>>>>>> +       int ret = check_fmt(file, b->type);
>>>>>>>> +
>>>>>>>> +       return ret ? ret : ops->vidioc_delete_buf(file, fh, b);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>     static int v4l_g_parm(const struct v4l2_ioctl_ops *ops,
>>>>>>>>                                    struct file *file, void *fh, void
>>>>>>>> *arg)
>>>>>>>>     {
>>>>>>>> @@ -2905,6 +2914,7 @@ static const struct v4l2_ioctl_info
>>>>>>>> v4l2_ioctls[] = {
>>>>>>>>            IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands,
>>>>>>>> v4l_print_freq_band, 0),
>>>>>>>>            IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info,
>>>>>>>> v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match)),
>>>>>>>>            IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl,
>>>>>>>> v4l_print_query_ext_ctrl, INFO_FL_CTRL |
>>>>>>>> INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
>>>>>>>> +       IOCTL_INFO(VIDIOC_DELETE_BUF, v4l_delete_buf,
>>>>>>>> v4l_print_buffer, INFO_FL_QUEUE),
>>>>>>>>     };
>>>>>>>>     #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
>>>>>>>>
>>>>>>>> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
>>>>>>>> index edb733f21604..2f232ed884c7 100644
>>>>>>>> --- a/include/media/v4l2-ioctl.h
>>>>>>>> +++ b/include/media/v4l2-ioctl.h
>>>>>>>> @@ -163,6 +163,8 @@ struct v4l2_fh;
>>>>>>>>      *     :ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` ioctl
>>>>>>>>      * @vidioc_prepare_buf: pointer to the function that implements
>>>>>>>>      *     :ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>` ioctl
>>>>>>>> + * @vidioc_delete_buf: pointer to the function that implements
>>>>>>>> + *     :ref:`VIDIOC_DELETE_BUF <vidioc_delete_buf>` ioctl
>>>>>>>>      * @vidioc_overlay: pointer to the function that implements
>>>>>>>>      *     :ref:`VIDIOC_OVERLAY <vidioc_overlay>` ioctl
>>>>>>>>      * @vidioc_g_fbuf: pointer to the function that implements
>>>>>>>> @@ -422,6 +424,8 @@ struct v4l2_ioctl_ops {
>>>>>>>>                                      struct v4l2_create_buffers *b);
>>>>>>>>            int (*vidioc_prepare_buf)(struct file *file, void *fh,
>>>>>>>>                                      struct v4l2_buffer *b);
>>>>>>>> +       int (*vidioc_delete_buf)(struct file *file, void *fh,
>>>>>>>> +                                struct v4l2_buffer *b);
>>>>>>>>
>>>>>>>>            int (*vidioc_overlay)(struct file *file, void *fh, unsigned
>>>>>>>> int i);
>>>>>>>>            int (*vidioc_g_fbuf)(struct file *file, void *fh,
>>>>>>>> diff --git a/include/media/videobuf2-core.h
>>>>>>>> b/include/media/videobuf2-core.h
>>>>>>>> index 080b783d608d..0f9e68f76b77 100644
>>>>>>>> --- a/include/media/videobuf2-core.h
>>>>>>>> +++ b/include/media/videobuf2-core.h
>>>>>>>> @@ -840,6 +840,15 @@ int vb2_core_create_bufs(struct vb2_queue *q,
>>>>>>>> enum vb2_memory memory,
>>>>>>>>      */
>>>>>>>>     int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index,
>>>>>>>> void *pb);
>>>>>>>>
>>>>>>>> +/**
>>>>>>>> + * vb2_core_delete_buf() -
>>>>>>>> + * @q: pointer to &struct vb2_queue with videobuf2 queue.
>>>>>>>> + * @index:     id number of the buffer.
>>>>>>>> + *
>>>>>>>> + *  Return: returns zero on success; an error code otherwise.
>>>>>>>> + */
>>>>>>>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index);
>>>>>>>> +
>>>>>>>>     /**
>>>>>>>>      * vb2_core_qbuf() - Queue a buffer from userspace
>>>>>>>>      *
>>>>>>>> diff --git a/include/media/videobuf2-v4l2.h
>>>>>>>> b/include/media/videobuf2-v4l2.h
>>>>>>>> index 88a7a565170e..3beeb4c735f0 100644
>>>>>>>> --- a/include/media/videobuf2-v4l2.h
>>>>>>>> +++ b/include/media/videobuf2-v4l2.h
>>>>>>>> @@ -114,6 +114,17 @@ int vb2_create_bufs(struct vb2_queue *q, struct
>>>>>>>> v4l2_create_buffers *create);
>>>>>>>>      */
>>>>>>>>     int vb2_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
>>>>>>>>                        struct v4l2_buffer *b);
>>>>>>>> +/**
>>>>>>>> + * vb2_delete_buf() - Delete the buffer from the queue
>>>>>>>> + *
>>>>>>>> + * @q:         pointer to &struct vb2_queue with videobuf2 queue.
>>>>>>>> + * @b:         buffer structure passed from userspace to
>>>>>>>> + *             &v4l2_ioctl_ops->vidioc_delete_buf handler in driver
>>>>>>>> + *
>>>>>>>> + * The return values from this function are intended to be directly
>>>>>>>> returned
>>>>>>>> + * from &v4l2_ioctl_ops->vidioc_delete_buf handler in driver.
>>>>>>>> + */
>>>>>>>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b);
>>>>>>>>
>>>>>>>>     /**
>>>>>>>>      * vb2_qbuf() - Queue a buffer from userspace
>>>>>>>> diff --git a/include/uapi/linux/videodev2.h
>>>>>>>> b/include/uapi/linux/videodev2.h
>>>>>>>> index aee75eb9e686..31bba1915642 100644
>>>>>>>> --- a/include/uapi/linux/videodev2.h
>>>>>>>> +++ b/include/uapi/linux/videodev2.h
>>>>>>>> @@ -2702,6 +2702,8 @@ struct v4l2_create_buffers {
>>>>>>>>     #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct
>>>>>>>> v4l2_dbg_chip_info)
>>>>>>>>
>>>>>>>>     #define VIDIOC_QUERY_EXT_CTRL  _IOWR('V', 103, struct
>>>>>>>> v4l2_query_ext_ctrl)
>>>>>>>> +#define VIDIOC_DELETE_BUF      _IOWR('V', 104, struct v4l2_buffer)
>>>>>>>> +
>>>>>>>>
>>>>>>>>     /* Reminder: when adding new ioctls please add support for them to
>>>>>>>>        drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
>>>>>>>> --
>>>>>>>> 2.39.2
>>>>>>>>
>>>>> --
>>>>> Hsia-Jun(Randy) Li
>>>>>
>>>> --
>>>> Hsia-Jun(Randy) Li
>>>>
>> --
>> Hsia-Jun(Randy) Li
>>

-- 
Hsia-Jun(Randy) Li
