Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC365755974
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGQCRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQCRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:17:11 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA51EC;
        Sun, 16 Jul 2023 19:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTz3dhK3WvzXjIYYd8CRCCsb5gsHLblK2pm05jHnbduSmLL+QGiQax92TXzaJh7ZdtReB7rHiFw8qdwbY1StSC/cVVyxIj+9in4Jm2bpHMCkU/GZwWUI9hwjpiathoD+seiBaIvGa8mNr462DaNgkJy+H2MM3oybf/3usntNDT/LcGRbIO6E4CfNUEnU4j5QiLE98+JofCpWQSldESU9qHMe2sJ/Qm6PItB6PxEZG1TSSwOqs5r31yxTaAqNcQMs6x+76gHerMY0de26uNs6/pfmbKgxKrtH0slO9a57lGXpyYRra4UWweJ+gZIl8I/qGT1++hvL5I9GdJt0clu/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1paPwi4TC6Dn88ujZdF0Xd6cyYBodNbAgv04iY3VBk=;
 b=nd2i6pszWTzmu70/K2bHvKKcjlzUOXWChlUlobPt9b/s9ppPoVgDtU+B5vH/5+73eeU3lKox67fY6FWpw3PWZPCDxGzKSONmjrhuCtwkLcGBrK772ZgkaAba+GS+LKlAASUcyFABBZyJAl1T3SUryqO45Eu/U9B8J847NzsRlfTb7GpSCGrquOft/khLNXn2jcT66dY64ns0fCBu4Iow8tG2o2c0VlQpceu4bPkp6xzBYyKMrOSftznU0UFNaNFi/mOAawI/MnIGClT2cCrBZjS95KHV8r3jX+86Q75K7dT6ceYhHYPd+/awxIkbGduRGzAeVV1g33t+qLd6O6PS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1paPwi4TC6Dn88ujZdF0Xd6cyYBodNbAgv04iY3VBk=;
 b=LlkQ1nB3jsQGSeZYrDCwTPL1GmH4O/ji5Xl76YJGq1/0R1pPO7ulatxQWyD8mWen23icrR0O3sy8uW094UgXN+QhtuLbtHR7+Rtwri/fqXALVEYA0s4NygxMnkkNYqnmUS9gXt/d3rRmrtt5CxdWoWlZGmgovan6Bu5qmytxGBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by MW4PR03MB6458.namprd03.prod.outlook.com (2603:10b6:303:121::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 17 Jul
 2023 02:17:06 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 02:17:05 +0000
Message-ID: <e4bb9520-489f-2bb3-4a17-668c3f448668@synaptics.com>
Date:   Mon, 17 Jul 2023 10:16:52 +0800
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
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <20230713090944.3gxrxt7lqnozhu7r@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::14) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|MW4PR03MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: c364cda3-933b-407f-300b-08db866bea1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEtL7a18b8hnjIkqOZ61DZtA49AREtxIlCRhoVVtiHgdFJSFBJislIHLZkhxmC6Kw2xCpQVgqn7upHWDtsm0EimUhTOF8UI4HrInaRG89WVDI/mdiWdccoCbgvd7yXSWDY9ucL+k8oWsEt4Jqvop8bPW6+uqqaSnu/+CQwAN8FyLQh5BO+HDv5h038bhZGINfA3b1HdT5wgIebcKRy+6jBG41iw8kOrsqc7R0axu+W1m/HuzcIQTnOcxMCyZ+IRBbZoSeRtxIM4qQuN/NJopasw26NR5oBSUWH74oR8xXVqzUIZKACAf4tM8/VpgSUZlw1f5i6Eti/G/MEBlQdjTxAjLmWe6bF5z+mb3a71CwT+zomry9iv+P0wqxO6i9SYMAzolybbJuuGXbOaBfUyf/YF9POAw2UHy9iNLsr8vFsye4bazXqSzUsjNej84yrffS/1nGTzlLyKELkCgqdwpDM4rT24spTTjjv5Bx8v2n+htje8OPHPhkpCMXU0z2mkCJf7Tgr1/M4Ns8FBm5AfcULE+iDtR79zE/mtCAM2tSMmp/G5ykN9FG32cmx3o5LMNQPxMOQVL5NXeyxz/JZGPS6pXJLJjjlBU+jK28+or33c8dw3q64/a8U3mqMZ1+4fD54bfHEEwgDp8rpHB6mE9C2wBEOyafkZC1IBUWzM7IKNCMFVZyP5Pz4DCG6+FQgwR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(31686004)(8676002)(7416002)(41300700001)(8936002)(5660300002)(26005)(66574015)(316002)(6916009)(6666004)(4326008)(186003)(6506007)(66476007)(83380400001)(2616005)(66946007)(66556008)(52116002)(478600001)(31696002)(86362001)(54906003)(2906002)(30864003)(53546011)(36756003)(6486002)(38350700002)(6512007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UC9rWUMzTFhNZ3RTanRZaWRWQXRWc1NneXB0eGNtUzN3MmorYk8rbGwvWHJ2?=
 =?utf-8?B?d3ZWd2QrRHpLZUpLOU56OFlIVHRqWVFTUDdrL2VNM2xFcWp2Nkp5TTYxYnVr?=
 =?utf-8?B?eTFLNFZzckR0ZWx1SWJGWU5LcytaYi9aV0JLTmlac0J2MDI3cU9Ld1NUWm42?=
 =?utf-8?B?TlQ0RHpwRzFoc1AxNitSK0ZHYlBQOVc2aTc0Q2t1QVYwc3FNV1Q1MXp4cVo1?=
 =?utf-8?B?UTZlOVViRHdxYXJQZTAyaGxPRGFGSC81c2JsRkZBWDltNVBUVHJEUmxaS1pB?=
 =?utf-8?B?MlRYUEh5cmNIcVJ5NUFTRVVkcUZVWGxuVVVlNEUvOXNlYy9HQ0xyOXVpYkRM?=
 =?utf-8?B?UVdVQXYwbGZKSVlqZEFEYUhaS3ZtSFJieFJWcDMrWXF1MTBBdkNlVW1JbXQ4?=
 =?utf-8?B?bHk2dytMbGY4V2JVOUZkV1Zwa2FTZUZCallRaTBHTi84Wk1NWXZpcDkrZEdq?=
 =?utf-8?B?MHE2RlcvRVJHSHl5TU40YTk5a2ZuNGMvb1o1WWtSMTZFQkNGM3ZvbUVrMkVn?=
 =?utf-8?B?MGZkY3drVkpna0NRM0VQbG9SclkxS3hySUNNTkloZjMvRDJGUTlLaVFUVXJk?=
 =?utf-8?B?dE9tQm5HRmdoOXY2SGVsZ3RLQUFaK0VhOC9IUXViYUliV0treVZyMW5ML2dY?=
 =?utf-8?B?bllYNHE3N0MxcmRnWFd4Ykp1aXFmUkJOV2VOYnNVTFFWWVRzZkovZDQ0NWox?=
 =?utf-8?B?T1FiYjhjcHo4QnpLL0FYcDFmU0pWNEZmS1NDVWdBOFp6N0QzNExjQlA2ZmNK?=
 =?utf-8?B?QkMxTTZSNWlKemlxUGJxUElGUXh2a0tDeUNqQVhJVWt3NFVmTkhJcG5jOVdp?=
 =?utf-8?B?N01rdExnT2dZQitYTGlSWkIyMGhmU0hzZGdvWFpET2FTWm8ySE1MVDZPWFpS?=
 =?utf-8?B?T2QvcmgvTDFXalF3V1J6eCt2aUpTWWEvRnpROTZtVmxxQlZvWTdIeUNPS0hx?=
 =?utf-8?B?L0NLeDh1ZG5WWmdpV2pOeEpzcGJWV2VENGV6cmh3ZGI0SFlPZlAvZlMvd05H?=
 =?utf-8?B?Ly9aQVZNOUlkN3dteHc4YzUwOWRFMStUWk5tYnV3RDladmlOcWNOQlZTcmNw?=
 =?utf-8?B?RnVYaHZqczhXWXN1K2ZqejhEV0FwNnJCR0ZTVWFiZitDSnprY3MzZ01CQU9n?=
 =?utf-8?B?TEZaSWJnOHZlNHo5ekJvRkxnSTFiLytPRGx0R3dIUmFSdkhVVEdLMk5tTVJs?=
 =?utf-8?B?UC9wZkdtN01HWXNidFdLQlVLMlZrTGRERzgwMG5oazUzMXQ4allFZk1tTDJV?=
 =?utf-8?B?K09wRStGR1lvTFAxenQwd3dPQTgwOWMrWU1ycC9YWERjcnFxdGhoVWY2VTVD?=
 =?utf-8?B?N0huMkJYSlVnNHI4UGJxVjh6ZStiYWlha3NzRTN5OFhZQVhYdUtLTU9CMjdO?=
 =?utf-8?B?STZtMU92YzUrSUsrSk00dHpScFZNQ0prL1NaaVMrcFRCRk9wMm1qRllZZTBD?=
 =?utf-8?B?UG9GWXB5eGs4YmlEcFJBZTV3aHZmMVYzWjk2WkF3bVpJdHdBMW9SSGtxU0FC?=
 =?utf-8?B?Nm8zcFRlK0lhME5ZelN5NkFkUktKSE1uYjRaaU5VYVFIRmRoR1pjVnRKVFpH?=
 =?utf-8?B?b1lJci9RSnNMdlNxTXZiUmZkWWtzU1M2c2V3NitLRnJ5WDIvNDVnOVZ1MUJJ?=
 =?utf-8?B?blFLem1jdXU4dmZxVlNRbCtSbm1PQTdvUUVBckRpaGV6NUFndm9OeWRZVjlM?=
 =?utf-8?B?UmticnJlSjlrbDBtWVZjQlBZNzRvQTJRZXdpcWRvNGpZZExqWWErM2FnUVdM?=
 =?utf-8?B?WlZvQitWdmZHcmpkQnFXazZlQkxYYm1CR0NzQkNwQ1c5UkZucDI0RStzQWpI?=
 =?utf-8?B?UVlEY2h3a2NvSG9pN1U1SFZZYWFOb1NxTGdXRUdpVlRTTms1N051QWwxajd4?=
 =?utf-8?B?cWdmNUFNM2FJaHZobWJ5NysxeE5BMFI2dHp1ZG11eXpkNGNPVjhMM25aNHNJ?=
 =?utf-8?B?UGdvbXBRUm56dlBIdEhqTk50clU0VUluRXN0MThRYXlyYnJxaXk3TVdhRXg3?=
 =?utf-8?B?NEtvb3BMVEIyQXg1MHQ1eHNwOEcySjh3c25uTWlUQ2tzNWlKLzZBV1I4amEw?=
 =?utf-8?B?cFk3NEM3TnhjT29DcUVMMGhldExpNkpSdVpvUUR2N3ZHYVpBZEl2M3M4dVQv?=
 =?utf-8?Q?vnpl+ws8VDXV+bJhsxUa8bksp?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c364cda3-933b-407f-300b-08db866bea1d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 02:17:05.2166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XS2SrQs4a0ycFTAQJoXcO5hr3FXp2v/mqlUkmxxYJaXF/oLmliu/GwOEoyn314AVMuJPGeDNabqPHvnP8G2ESw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6458
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/13/23 17:09, Tomasz Figa wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Fri, Jun 30, 2023 at 05:43:51PM +0800, Hsia-Jun Li wrote:
>> On 6/27/23 16:47, Hsia-Jun Li wrote:
>>> CAUTION: Email originated externally, do not click links or open
>>> attachments unless you recognize the sender and know the content is
>>> safe.
>>>
>>>
>>> On 6/27/23 16:43, Benjamin Gaignard wrote:
>>>> CAUTION: Email originated externally, do not click links or open
>>>> attachments unless you recognize the sender and know the content is
>>>> safe.
>>>>
>>>>
>>>> Le 27/06/2023 à 09:30, Hsia-Jun Li a écrit :
>>>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
>>>>>> CAUTION: Email originated externally, do not click links or open
>>>>>> attachments unless you recognize the sender and know the content is
>>>>>> safe.
>>>>>>
>>>>>>
>>>>>> VIDIOC_DELETE_BUF ioctl allows to delete a buffer from a queue.
>>>>>>
>>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>>> ---
>>>>>>    .../userspace-api/media/v4l/user-func.rst     |  1 +
>>>>>>    .../media/v4l/vidioc-delete-buf.rst           | 51
>>>>>> +++++++++++++++++++
>>>>>>    .../media/common/videobuf2/videobuf2-core.c   | 33 ++++++++++++
>>>>>>    .../media/common/videobuf2/videobuf2-v4l2.c   |  6 +++
>>>>>>    drivers/media/v4l2-core/v4l2-dev.c            |  1 +
>>>>>>    drivers/media/v4l2-core/v4l2-ioctl.c          | 10 ++++
>>>>>>    include/media/v4l2-ioctl.h                    |  4 ++
>>>>>>    include/media/videobuf2-core.h                |  9 ++++
>>>>>>    include/media/videobuf2-v4l2.h                | 11 ++++
>>>>>>    include/uapi/linux/videodev2.h                |  2 +
>>>>>>    10 files changed, 128 insertions(+)
>>>>>>    create mode 100644
>>>>>> Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>>
>>>>>> diff --git a/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>> b/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>> index 15ff0bf7bbe6..8c74016e12fd 100644
>>>>>> --- a/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>> +++ b/Documentation/userspace-api/media/v4l/user-func.rst
>>>>>> @@ -17,6 +17,7 @@ Function Reference
>>>>>>        vidioc-dbg-g-chip-info
>>>>>>        vidioc-dbg-g-register
>>>>>>        vidioc-decoder-cmd
>>>>>> +    vidioc-delete-buf
>>>>>>        vidioc-dqevent
>>>>>>        vidioc-dv-timings-cap
>>>>>>        vidioc-encoder-cmd
>>>>>> diff --git
>>>>>> a/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>> b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>> new file mode 100644
>>>>>> index 000000000000..0e7ce58f91bc
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/userspace-api/media/v4l/vidioc-delete-buf.rst
>>>>>> @@ -0,0 +1,51 @@
>>>>>> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
>>>>>> +.. c:namespace:: V4L
>>>>>> +
>>>>>> +.. _VIDIOC_DELETE_BUF:
>>>>>> +
>>>>>> +************************
>>>>>> +ioctl VIDIOC_DELETE_BUF
>>>>>> +************************
>>>>>> +
>>>>>> +Name
>>>>>> +====
>>>>>> +
>>>>>> +VIDIOC_DELETE_BUF - Delete a buffer from a queue
>>>>>> +
>>>>>> +Synopsis
>>>>>> +========
>>>>>> +
>>>>>> +.. c:macro:: VIDIOC_DELETE_BUF
>>>>>> +
>>>>>> +``int ioctl(int fd, VIDIOC_DELETE_BUF, struct v4l2_buffer *argp)``
>>>>>> +
>>>>>> +Arguments
>>>>>> +=========
>>>>>> +
>>>>>> +``fd``
>>>>>> +    File descriptor returned by :c:func:`open()`.
>>>>>> +
>>>>>> +``argp``
>>>>>> +    Pointer to struct :c:type:`v4l2_buffer`.
>>>>>> +
>>>>>> +Description
>>>>>> +===========
>>>>>> +
>>>>>> +Applications can optionally call the
>>>>>> :ref:`VIDIOC_DELETE_BUF` ioctl to
>>>>>> +delete a buffer from a queue.
>>>>>> +
>>>>>> +The struct :c:type:`v4l2_buffer` structure is specified in
>>>>>> +:ref:`buffer`.
>>>>>> +
>>>>>> +Return Value
>>>>>> +============
>>>>>> +
>>>>>> +On success 0 is returned, on error -1 and the ``errno`` variable is
>>>>>> set
>>>>>> +appropriately. The generic error codes are described at the
>>>>>> +:ref:`Generic Error Codes <gen-errors>` chapter.
>>>>>> +
>>>>>> +EBUSY
>>>>>> +    File I/O is in progress.
>>>>>> +
>>>>>> +EINVAL
>>>>>> +    The buffer ``index`` doesn't exist in the queue.
>>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>> index 899783f67580..aa546c972c3d 100644
>>>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>> @@ -1637,6 +1637,39 @@ int vb2_core_prepare_buf(struct vb2_queue *q,
>>>>>> unsigned int index, void *pb)
>>>>>>    }
>>>>>>    EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
>>>>>>
>>>>>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index)
>>>>>> +{
>>>>>> +       struct vb2_buffer *vb;
>>>>>> +
>>>>>> +       vb = vb2_get_buffer(q, index);
>>>>>> +       if (!vb) {
>>>>>> +               dprintk(q, 1, "invalid buffer index %d\n", index);
>>>>>> +               return -EINVAL;
>>>>>> +       }
>>>>>> +
>>>>>> +       if (vb->state != VB2_BUF_STATE_DEQUEUED) {
>>>>>> +               dprintk(q, 1, "can't delete non dequeued buffer index
>>>>>> %d\n", index);
>>>>>> +               return -EINVAL;
>>>>>> +       }
>>>>>> +
>>>>> I know the driver could implement its own
>>>>> v4l2_ioctl_ops->vidioc_delete_buf() that check whether a buffer is
>>>>> used by the hardware as a future reference frame.
>>>>> But I think we need a flag to let the user know which buffer is still
>>>>> used by the hardware.
>>>>> Alternative ref case is safe, we only know it's existing when it is
>>>>> dequeued in current V4L2 buffer mechanism.
>>>>> While the Golden reference frame, such long term reference frame could
>>>>> last much longer.
>>>> It is up to userland stack to know frames life time, it got the
>>>> information for that.
>>> That is true for the stateless codec driver.
>>>
>>> While application for stateful decoder could never do that. It also
>>> breaks what the document said:
>>>
>>> "The backing memory of |CAPTURE| buffers that are used as reference
>>> frames by the stream may be read by the hardware even after they are
>>> dequeued. Consequently, the client should avoid writing into this memory
>>> while the |CAPTURE| queue is streaming. Failure to observe this may
>>> result in corruption of decoded frames."
>>>
>>>>>> +       if (vb->planes[0].mem_priv)
>>>>>> +               call_void_vb_qop(vb, buf_cleanup, vb);
>>>>>> +
>>>>>> +       /* Free MMAP buffers or release USERPTR buffers */
>>>>>> +       if (q->memory == VB2_MEMORY_MMAP)
>>>>>> +               __vb2_buf_mem_free(vb);
>> Here is another problem for the existing application, the mmap() from the
>> mmap offset or exportbuffer fd would not create a reference to buffer in
>> this step(while the exportbuffer would create one itself).
>>
>> When you delete a buffer, you may not release it from its virtual memory
>> space, leaving a corrupted virtual memory space.
> What do you mean? __vb2_buf_mem_free() doesn't unconditionally free the
> memory, it just decrements a reference counter.

struct dma_buf_ops->mmap() may not increase a reference to its buffer.

While struct vb2_mem_ops->get_dmabuf() would.

> The VMA holds its own,
> so the buffer is only fully released when the application calls
> munmap().

DELETE_BUF ioctl() didn't answer to this problem. Should the DELETE_BUF 
ioctl() make the no other user could access to this.

>
> Best regards,
> Tomasz
>
>> Also this behavior is
>> right, because mmap(2) says:
>>
>> "After  the  mmap()  call has returned, the file descriptor, fd, can be
>> closed immediately without invalidating the map‐ping."
>>
>>>>>> +       else if (q->memory == VB2_MEMORY_DMABUF)
>>>>>> +               __vb2_buf_dmabuf_put(vb);
>>>>>> +       else
>>>>>> +               __vb2_buf_userptr_put(vb);
>>>>>> +
>>>>>> +       vb2_queue_remove_buffer(q, vb);
>>>>>> +       kfree(vb);
>>>>>> +
>>>>>> +       dprintk(q, 2, "buffer %d deleted\n", index);
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>>    /*
>>>>>>     * vb2_start_streaming() - Attempt to start streaming.
>>>>>>     * @q:         videobuf2 queue
>>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>> b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>> index 724135d41f7f..cea666c17b41 100644
>>>>>> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
>>>>>> @@ -751,6 +751,12 @@ int vb2_prepare_buf(struct vb2_queue *q, struct
>>>>>> media_device *mdev,
>>>>>>    }
>>>>>>    EXPORT_SYMBOL_GPL(vb2_prepare_buf);
>>>>>>
>>>>>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b)
>>>>>> +{
>>>>>> +       return vb2_core_delete_buf(q, b->index);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(vb2_delete_buf);
>>>>>> +
>>>>>>    int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers
>>>>>> *create)
>>>>>>    {
>>>>>>           unsigned requested_planes = 1;
>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-dev.c
>>>>>> b/drivers/media/v4l2-core/v4l2-dev.c
>>>>>> index f81279492682..80ace2e1e932 100644
>>>>>> --- a/drivers/media/v4l2-core/v4l2-dev.c
>>>>>> +++ b/drivers/media/v4l2-core/v4l2-dev.c
>>>>>> @@ -720,6 +720,7 @@ static void determine_valid_ioctls(struct
>>>>>> video_device *vdev)
>>>>>>                   SET_VALID_IOCTL(ops, VIDIOC_PREPARE_BUF,
>>>>>> vidioc_prepare_buf);
>>>>>>                   SET_VALID_IOCTL(ops, VIDIOC_STREAMON,
>>>>>> vidioc_streamon);
>>>>>>                   SET_VALID_IOCTL(ops, VIDIOC_STREAMOFF,
>>>>>> vidioc_streamoff);
>>>>>> +               SET_VALID_IOCTL(ops, VIDIOC_DELETE_BUF,
>>>>>> vidioc_delete_buf);
>>>>>>           }
>>>>>>
>>>>>>           if (is_vid || is_vbi || is_meta) {
>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>> b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>> index a858acea6547..1c737279d3ef 100644
>>>>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>> @@ -2156,6 +2156,15 @@ static int v4l_prepare_buf(const struct
>>>>>> v4l2_ioctl_ops *ops,
>>>>>>           return ret ? ret : ops->vidioc_prepare_buf(file, fh, b);
>>>>>>    }
>>>>>>
>>>>>> +static int v4l_delete_buf(const struct v4l2_ioctl_ops *ops,
>>>>>> +                         struct file *file, void *fh, void *arg)
>>>>>> +{
>>>>>> +       struct v4l2_buffer *b = arg;
>>>>>> +       int ret = check_fmt(file, b->type);
>>>>>> +
>>>>>> +       return ret ? ret : ops->vidioc_delete_buf(file, fh, b);
>>>>>> +}
>>>>>> +
>>>>>>    static int v4l_g_parm(const struct v4l2_ioctl_ops *ops,
>>>>>>                                   struct file *file, void *fh, void
>>>>>> *arg)
>>>>>>    {
>>>>>> @@ -2905,6 +2914,7 @@ static const struct v4l2_ioctl_info
>>>>>> v4l2_ioctls[] = {
>>>>>>           IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands,
>>>>>> v4l_print_freq_band, 0),
>>>>>>           IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info,
>>>>>> v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match)),
>>>>>>           IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl,
>>>>>> v4l_print_query_ext_ctrl, INFO_FL_CTRL |
>>>>>> INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
>>>>>> +       IOCTL_INFO(VIDIOC_DELETE_BUF, v4l_delete_buf,
>>>>>> v4l_print_buffer, INFO_FL_QUEUE),
>>>>>>    };
>>>>>>    #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
>>>>>>
>>>>>> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
>>>>>> index edb733f21604..2f232ed884c7 100644
>>>>>> --- a/include/media/v4l2-ioctl.h
>>>>>> +++ b/include/media/v4l2-ioctl.h
>>>>>> @@ -163,6 +163,8 @@ struct v4l2_fh;
>>>>>>     *     :ref:`VIDIOC_CREATE_BUFS <vidioc_create_bufs>` ioctl
>>>>>>     * @vidioc_prepare_buf: pointer to the function that implements
>>>>>>     *     :ref:`VIDIOC_PREPARE_BUF <vidioc_prepare_buf>` ioctl
>>>>>> + * @vidioc_delete_buf: pointer to the function that implements
>>>>>> + *     :ref:`VIDIOC_DELETE_BUF <vidioc_delete_buf>` ioctl
>>>>>>     * @vidioc_overlay: pointer to the function that implements
>>>>>>     *     :ref:`VIDIOC_OVERLAY <vidioc_overlay>` ioctl
>>>>>>     * @vidioc_g_fbuf: pointer to the function that implements
>>>>>> @@ -422,6 +424,8 @@ struct v4l2_ioctl_ops {
>>>>>>                                     struct v4l2_create_buffers *b);
>>>>>>           int (*vidioc_prepare_buf)(struct file *file, void *fh,
>>>>>>                                     struct v4l2_buffer *b);
>>>>>> +       int (*vidioc_delete_buf)(struct file *file, void *fh,
>>>>>> +                                struct v4l2_buffer *b);
>>>>>>
>>>>>>           int (*vidioc_overlay)(struct file *file, void *fh, unsigned
>>>>>> int i);
>>>>>>           int (*vidioc_g_fbuf)(struct file *file, void *fh,
>>>>>> diff --git a/include/media/videobuf2-core.h
>>>>>> b/include/media/videobuf2-core.h
>>>>>> index 080b783d608d..0f9e68f76b77 100644
>>>>>> --- a/include/media/videobuf2-core.h
>>>>>> +++ b/include/media/videobuf2-core.h
>>>>>> @@ -840,6 +840,15 @@ int vb2_core_create_bufs(struct vb2_queue *q,
>>>>>> enum vb2_memory memory,
>>>>>>     */
>>>>>>    int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index,
>>>>>> void *pb);
>>>>>>
>>>>>> +/**
>>>>>> + * vb2_core_delete_buf() -
>>>>>> + * @q: pointer to &struct vb2_queue with videobuf2 queue.
>>>>>> + * @index:     id number of the buffer.
>>>>>> + *
>>>>>> + *  Return: returns zero on success; an error code otherwise.
>>>>>> + */
>>>>>> +int vb2_core_delete_buf(struct vb2_queue *q, unsigned int index);
>>>>>> +
>>>>>>    /**
>>>>>>     * vb2_core_qbuf() - Queue a buffer from userspace
>>>>>>     *
>>>>>> diff --git a/include/media/videobuf2-v4l2.h
>>>>>> b/include/media/videobuf2-v4l2.h
>>>>>> index 88a7a565170e..3beeb4c735f0 100644
>>>>>> --- a/include/media/videobuf2-v4l2.h
>>>>>> +++ b/include/media/videobuf2-v4l2.h
>>>>>> @@ -114,6 +114,17 @@ int vb2_create_bufs(struct vb2_queue *q, struct
>>>>>> v4l2_create_buffers *create);
>>>>>>     */
>>>>>>    int vb2_prepare_buf(struct vb2_queue *q, struct media_device *mdev,
>>>>>>                       struct v4l2_buffer *b);
>>>>>> +/**
>>>>>> + * vb2_delete_buf() - Delete the buffer from the queue
>>>>>> + *
>>>>>> + * @q:         pointer to &struct vb2_queue with videobuf2 queue.
>>>>>> + * @b:         buffer structure passed from userspace to
>>>>>> + *             &v4l2_ioctl_ops->vidioc_delete_buf handler in driver
>>>>>> + *
>>>>>> + * The return values from this function are intended to be directly
>>>>>> returned
>>>>>> + * from &v4l2_ioctl_ops->vidioc_delete_buf handler in driver.
>>>>>> + */
>>>>>> +int vb2_delete_buf(struct vb2_queue *q, struct v4l2_buffer *b);
>>>>>>
>>>>>>    /**
>>>>>>     * vb2_qbuf() - Queue a buffer from userspace
>>>>>> diff --git a/include/uapi/linux/videodev2.h
>>>>>> b/include/uapi/linux/videodev2.h
>>>>>> index aee75eb9e686..31bba1915642 100644
>>>>>> --- a/include/uapi/linux/videodev2.h
>>>>>> +++ b/include/uapi/linux/videodev2.h
>>>>>> @@ -2702,6 +2702,8 @@ struct v4l2_create_buffers {
>>>>>>    #define VIDIOC_DBG_G_CHIP_INFO  _IOWR('V', 102, struct
>>>>>> v4l2_dbg_chip_info)
>>>>>>
>>>>>>    #define VIDIOC_QUERY_EXT_CTRL  _IOWR('V', 103, struct
>>>>>> v4l2_query_ext_ctrl)
>>>>>> +#define VIDIOC_DELETE_BUF      _IOWR('V', 104, struct v4l2_buffer)
>>>>>> +
>>>>>>
>>>>>>    /* Reminder: when adding new ioctls please add support for them to
>>>>>>       drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
>>>>>> --
>>>>>> 2.39.2
>>>>>>
>>> --
>>> Hsia-Jun(Randy) Li
>>>
>> --
>> Hsia-Jun(Randy) Li
>>
-- 
Hsia-Jun(Randy) Li

