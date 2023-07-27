Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDE37648FE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjG0Hkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjG0HkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:40:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F0544AE;
        Thu, 27 Jul 2023 00:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCl8d4oRFhqvv3VGUogLIKhqgToRK8Y278iI5sGZe73Mk3O/HNXfEU19oVDJwADW5FHdpAjuSi5JaYCTHGNKB0fdLlWPoTAbVbpfGNMyQ8JPd2mE08i21qrx+C9hMBfFpeKiOahK2HC0fbJtVcLptrc3B/WYgG55zlXgsoH9fVZiJEnRC69ZvWo8xliEjtnkLZ2TSg4ja1s6Xcy2B7DOQmW3pHeTBzhSdQo2Qr+0BpX1iImpdmf5vkQznG70CfvS+zIq7e4fVb2QaXJ8upkTwpq+nsGHWxOzvVMSjPiU0iSZYKp/fqjWbyoSCEZPrIQNuXhPQ8fSQg9J6O8whQz8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prbJ8OYqp9gBk4BaXceUm5S/xMZvYwDoGLLnaJ/wgXg=;
 b=MJWFscI2/mSrIrNxtcXTs1GuNM/ZxGzDEyM4lx/qYlYQxIw/WRseWO/cm5FFbhmEAGZ5YW2qDrCOSoFbsOhtflxytaFjAnKN6+YoES5oYOC7LCLp8eiiAEm1Ug0RFdp3f7WWWCasZ240GS7I4Klm9HQdHOUysgxG09n84pAQH2caPIhQ2LLYU+P2kbIzma6beAvQF17DzdUmVrp2rlxCosD1cPcP10WFPFRqLqYgdnkoVw8cV/pB3sEYXdnUCnRPTd+ktMFZfjsss+dQnL6dTNO0aCy6PHznzm2EX+TGAAIer1Q88en+eqqkkUKkNR3Q9cAI6nxptUY20hO7LyQffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prbJ8OYqp9gBk4BaXceUm5S/xMZvYwDoGLLnaJ/wgXg=;
 b=SiZpn0pg74QV8z7kS7h8oKFMKcDnkYM4nii3X4wEVfztbqngnWgQS+S7zXQnA8UDXoztN9zzDHDP+ZvAFgmq2P2DWhasHuNKCzbM5lkz0aygM+Qp+AfAQ4KuYSOKHZn/OUZH0NNeQOfpUyUvL7oMywMlS89HmKGOASeEo+Yk2ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by MN2PR03MB5072.namprd03.prod.outlook.com (2603:10b6:208:1a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 27 Jul
 2023 07:33:14 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 07:33:14 +0000
Message-ID: <ca16e2d6-a1c7-bff6-496f-07174f379fd9@synaptics.com>
Date:   Thu, 27 Jul 2023 15:33:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
Content-Language: en-GB
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     linux-media@vger.kernel.org, ayaka@soulik.info,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        nicolas@ndufresne.ca
References: <20230704040044.681850-1-randy.li@synaptics.com>
 <20230704040044.681850-3-randy.li@synaptics.com>
 <20230712093301.nkj2vok2x7esdhb3@chromium.org>
 <4e70c8b8-d459-2b79-2b3d-40875f701d97@synaptics.com>
 <CAAFQd5CGO4iiC7HX9wTetuzjZyaAsKStFOpxqcFkZ_o-eJOPtg@mail.gmail.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <CAAFQd5CGO4iiC7HX9wTetuzjZyaAsKStFOpxqcFkZ_o-eJOPtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|MN2PR03MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f9cf5c-ccf8-4a7b-aa50-08db8e73bc37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyMtIRsrQMN5Ae5+XuEHSn8ZL+K5ljqkcYP3ARQENK6Ez6Z2tckY4XD7INrPwp5UOGzHgbzxp5T/sD6a6s8T8C7KpQIj+Vpib7UDKoaiw8q8RkGwvcfuzIQIPbv/EG4pgbKWc7xkGsbNU9E+SlsGM4HrurVlT8wpGZOeI7/joceCEcoSHV50CzrVIv/r50jsR0ZNDapT9VopqZPqUKha1x9aBcwNOhKl65wMgJ1QmS7bZmv/Hdi3pvAU8hPZipB4Qs2uYaFhAha3nGbgh5OAPpMe8o6noL17R24Jf718XamsC5LDiXd3IcizwcrqMUwnEVgjfad43IygSaO04h11TgP9iqmFo6lEL667RAbDK6QLLfNM5pzTHSYv7koF+QePcg5WgjkTtgkS07oWyVs78+HjYZ/RyMl96z1WaYvBx67cK2HywHjHzCEDp91/CcUBtWBtzamgQAQci+9Jxu9np6ifu0gLR/Qa4YUsNo6eHsbUZ/TqxBIJK5Le3ZV0X1zStvilAwbwd3whGxSJdFsp4DN27qh+ZvUYBA1GKhlw0ISxh5EMpUHlZJUvgNBeB2ALyvr9T5TROTmADrD4Yz4jySHP7hQNJzgHdVgf+RhcTkMkvMyJUXDZNf5VvaBZqB1SVndDl/QEoRlzD8uhWMYatGGcK7v2tNWqcTLfPg3MRmgtUZdQQ/2M6/NFWbqyWmGf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(53546011)(38100700002)(186003)(6512007)(6916009)(26005)(6506007)(7416002)(316002)(83380400001)(2616005)(8676002)(66946007)(6666004)(4326008)(5660300002)(6486002)(66556008)(41300700001)(66476007)(478600001)(52116002)(38350700002)(2906002)(8936002)(86362001)(36756003)(31696002)(66899021)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVpJdnVmYzUzZEpRdE5vS09FMU5LZXlGZVBRdlV6aEYwOTJjbXdIWU8wYkxK?=
 =?utf-8?B?VFdnSEVCQS95SDBtMGUwaGdQTitoQXZDM3VFZVFaRXdvYndLSlVqVDdIT0gw?=
 =?utf-8?B?U0xtZ3Vzb3pOOFF6SUtwNk9JUWszUXNna2hmVjR6aHhheG9tUDJFRnJlck5D?=
 =?utf-8?B?V3ZHcnB6bGdRT1VGclNYUVVWUG5iVlFqN1FGUXcvNVlQY1lvK2xXb2hKOFpx?=
 =?utf-8?B?emU1MnhLLy8rS2t2NUdwS3dvUmpra3V1UExhenZXOHoxTEVqV3ZMdHk4MzN4?=
 =?utf-8?B?VG55NVJPenU1M0JsVmJjL2p1R2ppaXFEV3Zwd05TZmMyeWpLVlZVeHh5aDcw?=
 =?utf-8?B?amVaTEo5RjAyZG5kMTIzUCtkaDBiYkE1RXN0dDFFWXRKalBIVEcrQkNoVkkz?=
 =?utf-8?B?L3ExaDdSRTdJeXZpU0dCQnJIZmo2R2ozV0FVYmR0dkQwMXRNN0xZZmNqdG51?=
 =?utf-8?B?S1FtS1dDQjI1WFhNMkprRFBUOFBzS28wWDl5aEpmcnFONUtBRVlZdnUvOHJE?=
 =?utf-8?B?VW5WZXM0b3UwMW5GUzd1WXdxMjNSVzdRc3g5akJlRjZpOVRHc0xpUUpXdFlK?=
 =?utf-8?B?RzA3WW1HOGpvT05WSSttRzRSbnBXZEovSzdXcUZDSkE2T1gyRnpxVitybTdV?=
 =?utf-8?B?QU5aOG13WU9XOXM4UDVoSE5sOFB4U1VvQ0VpamVYQWxVaVk0L05IQ0duSkNJ?=
 =?utf-8?B?Vks4bjZ6bS9UNHI5WjRPdWtrWTdkN1BpbXFDb3prdnBXVS8vbmRld3JoR2dw?=
 =?utf-8?B?RUpVcVYvSUI5UmhEa2FjQ1hvK0x6VzJ4a0JsVnpYRlFMRmNkakJ1dlpCd0VD?=
 =?utf-8?B?a0hzejMxYzBUbEVpV2JIdnlsVzdwcm1ZVlJuWldIM1JNcjRiTk0zNWpBUU9y?=
 =?utf-8?B?WExOUFlJOVJ6UXRETEJNODIyNG5DMldRWEV0dTdJcmpyaVZYaFRVV01JdTRF?=
 =?utf-8?B?T0c5QVZDaXc2ckNNR0UxQmgxeVh2K01kYW1jSHRsUGFHSExoRHhtaFVrZjVJ?=
 =?utf-8?B?cWxweDB6Tkl6Tys3Vk9qWi85bkQ1VWRNYzZWRDNaWnFJRzNScHIrYVN2Zys1?=
 =?utf-8?B?eHYyNGFReWdhRlhPYW93SUxJV2dCdGxSR2NrUkR0blV3OGR4ZnlDTmVUZXZ3?=
 =?utf-8?B?Mlk5d01keEJpVis2RXNHRUk4NndDU2EycnpseEUyR3VXVkNmcmNsU1dnSlZs?=
 =?utf-8?B?NWFISkhlUDBneVRRUFIvWEhGSThPcXE5SzMybTR6b0lwSmRiUTBMU3kraWZN?=
 =?utf-8?B?Nmkybmg0anpXdTZNMnZSc2p6dlN3eVpTRXZEVm5TbnpYTDk4WlJqNDFVWFAr?=
 =?utf-8?B?cFBmSzR1N2JCN3NGd2dQUFh2YXFlYWtEZmNydklmTExOTk9rR1IycDVHUnRR?=
 =?utf-8?B?d2xvQ3d4K1MvOWRUMnVUd3JRWmdYWWk2dmx2VDFqTWs3Q29tdHE4M2sxcWNQ?=
 =?utf-8?B?U2F1SlMwUkswa21aNFN1RVNtbG5hc1gzR2EwTERLTVpiM2c1TSt2cEwyS0tX?=
 =?utf-8?B?ejJabUNSRjhqVEVNYlJpQWhwbDU4eTJoZng5N2pFRzY5bFlNUnh1NUx0cktF?=
 =?utf-8?B?MUh3WlBZdm5YWmxUQzlJMXNGckpzSVhLUTN6RUVDcDgyY0JOeVEveVZNS1lw?=
 =?utf-8?B?UmU1MkZWRTQ3ZDMzWjNjcXhpTlhET1o3NGl3WG1sZTFkN2o1NXFjVk1iT3Ay?=
 =?utf-8?B?czB0Yk0reCtScWIzOXhGTEFkRnlnSTk2WFBkZGdCM0w5RmZSMER5QW0yQW5a?=
 =?utf-8?B?bXhpSjNkQjdGQzBVL0RTa3F5K05DWUFLLzlXa25QeVlXYVBvbStJS25NeHU3?=
 =?utf-8?B?RFFUSUpNMzcxTjgxeTBZV0pKNG5ncXQveklYa0MxM2Zzd3ppak9rSFo5K3kz?=
 =?utf-8?B?L2F3MEx5V3Zna0h1bmMzOXB4VWQ3YzhYWnRoWitaWlYzT0JCc2diRDZGL2pB?=
 =?utf-8?B?SEJhb3R0Y0hMckRiQU84YlZlSEdib3J0Q0J0TkVmU0VGY0JpS0VwRkoyZVdp?=
 =?utf-8?B?WjBWdzZxK2hDeXN6ZEc4TEhYMW9COUp0TFRlY29KMGNTSzlDTVRXUlNpb0lZ?=
 =?utf-8?B?WXhZRW94UTlORmdHUGZIZEJWRld4NTNQVmkvRlE1WUJHdkt0a0txbTQ4NFJM?=
 =?utf-8?Q?YsV5+VE9Wp2/qkQwbRe3np2nP?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f9cf5c-ccf8-4a7b-aa50-08db8e73bc37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:33:13.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCN3FVC2zaut4V4RF64igqt4eEXrQfDXOJK/1wXnMVNMMhcfkZMDulMYMbOwOXyYfEcyW6IuG0AMFs7Q/YtBbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5072
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/23 15:25, Tomasz Figa wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Mon, Jul 17, 2023 at 4:15 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>>
>>
>> On 7/12/23 17:33, Tomasz Figa wrote:
>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> On Tue, Jul 04, 2023 at 12:00:38PM +0800, Hsia-Jun Li wrote:
>>>> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>>>>
>>>> Many drivers have to create its own buf_struct for a
>>>> vb2_queue to track such a state. Also driver has to
>>>> iterate over rdy_queue every times to find out a buffer
>>>> which is not sent to hardware(or firmware), this new
>>>> list just offers the driver a place to store the buffer
>>>> that hardware(firmware) has acknowledged.
>>>>
>>>> One important advance about this list, it doesn't like
>>>> rdy_queue which both bottom half of the user calling
>>>> could operate it, while the v4l2 worker would as well.
>>>> The v4l2 core could only operate this queue when its
>>>> v4l2_context is not running, the driver would only
>>>> access this new hw_queue in its own worker.
>>> Could you describe in what case such a list would be useful for a
>>> mem2mem driver?
>>
>> This list, as its description, just for saving us from creating a
>> private buffer struct to track buffer state.
>>
>> The queue in the kernel is not the queue that hardware(codec firmware)
>> are using.
>>
> 
> Sorry, I find the description difficult to understand. It might make
> sense to have the text proofread by someone experienced in writing
> technical documentation in English before posting in the future.
> Thanks.
> 
Sorry, I may not be able to get more resource here. I would try to ask a 
chatbot to fix my description next time.
> I think I got the point from Nicolas' explanation, though.
> 
>>
>>>> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
>>>> ---
>>>>    drivers/media/v4l2-core/v4l2-mem2mem.c | 25 +++++++++++++++++--------
>>>>    include/media/v4l2-mem2mem.h           | 10 +++++++++-
>>>>    2 files changed, 26 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>> index c771aba42015..b4151147d5bd 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>> @@ -321,15 +321,21 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
>>>>                 goto job_unlock;
>>>>         }
>>>>
>>>> -     src = v4l2_m2m_next_src_buf(m2m_ctx);
>>>> -     dst = v4l2_m2m_next_dst_buf(m2m_ctx);
>>>> -     if (!src && !m2m_ctx->out_q_ctx.buffered) {
>>>> -             dprintk("No input buffers available\n");
>>>> -             goto job_unlock;
>>>> +     if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
>>>> +             src = v4l2_m2m_next_src_buf(m2m_ctx);
>>>> +
>>>> +             if (!src && !m2m_ctx->out_q_ctx.buffered) {
>>>> +                     dprintk("No input buffers available\n");
>>>> +                     goto job_unlock;
>>>> +             }
>>>>         }
>>>> -     if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
>>>> -             dprintk("No output buffers available\n");
>>>> -             goto job_unlock;
>>>> +
>>>> +     if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
>>>> +             dst = v4l2_m2m_next_dst_buf(m2m_ctx);
>>>> +             if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
>>>> +                     dprintk("No output buffers available\n");
>>>> +                     goto job_unlock;
>>>> +             }
>>>>         }
>>> src and dst would be referenced unitialized below if neither of the
>>> above ifs hits...
>> I think they have been initialized at v4l2_m2m_ctx_init()
> 
> What do you mean? They are local variables in this function.
> 
Sorry, I didn't notice the sentence after that.
>>>
>>> Best regards,
>>> Tomasz
>>>
>>>>         m2m_ctx->new_frame = true;
>>>> @@ -896,6 +902,7 @@ int v4l2_m2m_streamoff(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>>>>         INIT_LIST_HEAD(&q_ctx->rdy_queue);
>>>>         q_ctx->num_rdy = 0;
>>>>         spin_unlock_irqrestore(&q_ctx->rdy_spinlock, flags);
>>>> +     INIT_LIST_HEAD(&q_ctx->hw_queue);
>>>>
>>>>         if (m2m_dev->curr_ctx == m2m_ctx) {
>>>>                 m2m_dev->curr_ctx = NULL;
>>>> @@ -1234,6 +1241,8 @@ struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_m2m_dev *m2m_dev,
>>>>
>>>>         INIT_LIST_HEAD(&out_q_ctx->rdy_queue);
>>>>         INIT_LIST_HEAD(&cap_q_ctx->rdy_queue);
>>>> +     INIT_LIST_HEAD(&out_q_ctx->hw_queue);
>>>> +     INIT_LIST_HEAD(&cap_q_ctx->hw_queue);
>>>>         spin_lock_init(&out_q_ctx->rdy_spinlock);
>>>>         spin_lock_init(&cap_q_ctx->rdy_spinlock);
>>>>
>>>> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
>>>> index d6c8eb2b5201..2342656e582d 100644
>>>> --- a/include/media/v4l2-mem2mem.h
>>>> +++ b/include/media/v4l2-mem2mem.h
>>>> @@ -53,9 +53,16 @@ struct v4l2_m2m_dev;
>>>>     *   processed
>>>>     *
>>>>     * @q:               pointer to struct &vb2_queue
>>>> - * @rdy_queue:       List of V4L2 mem-to-mem queues
>>>> + * @rdy_queue:       List of V4L2 mem-to-mem queues. If v4l2_m2m_buf_queue() is
>>>> + *           called in struct vb2_ops->buf_queue(), the buffer enqueued
>>>> + *           by user would be added to this list.
>>>>     * @rdy_spinlock: spin lock to protect the struct usage
>>>>     * @num_rdy: number of buffers ready to be processed
>>>> + * @hw_queue:        A list for tracking the buffer is occupied by the hardware
>>>> + *           (or device's firmware). A buffer could only be in either
>>>> + *           this list or @rdy_queue.
>>>> + *           Driver may choose not to use this list while uses its own
>>>> + *           private data to do this work.
>>>>     * @buffered:        is the queue buffered?
>>>>     *
>>>>     * Queue for buffers ready to be processed as soon as this
>>>> @@ -68,6 +75,7 @@ struct v4l2_m2m_queue_ctx {
>>>>         struct list_head        rdy_queue;
>>>>         spinlock_t              rdy_spinlock;
>>>>         u8                      num_rdy;
>>>> +     struct list_head        hw_queue;
>>>>         bool                    buffered;
>>>>    };
>>>>
>>>> --
>>>> 2.17.1
>>>>
>> --
>> Hsia-Jun(Randy) Li
>>

-- 
Hsia-Jun(Randy) Li
