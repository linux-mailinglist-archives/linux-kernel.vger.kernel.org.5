Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB1757293
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjGRDzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjGRDys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:54:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF3A137;
        Mon, 17 Jul 2023 20:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZcebAYNkR3hFLiCIo+vbn/098RGslg0TJG/cKtNrU50blUD9cWmBra+t+6dlPHux1ljzgCSd2jx5rtcUQZI9j1WncTmEkAOPNPFYHtQLL9KTaHGJSgpUhJ3Gy5nR+CXhw4sfcj6T+VgWKwcGwL5732Tj+x7Jt8Fe/rDY4g+xwaoFqE+SvCww8VfomJ8JKdaGCaqXOLCANxizgM4r7GsGpaZDQjhOpbPz6wLISqpa/CWe8b3l8OEIi68F0Yzlc2Qx25yxJdxAAGn/TFN3TwO/5MkxnsIfYuuD6jypzF9DPd33yHFK0cRNokfWpYCsXcwWFwq0cMPWrT3FnfSLFGvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFnSBUl6vj+O52WxjLAZGlwprE3WebCqsDrmYeixGKU=;
 b=IUvN2pi4RbQXcJ0EBiyZDw7wbapSLJ2nMLnduDX+omO4aKOzFt2LavAA7ZnHNvJ/axUOxu80CpJmLj6TJCOmk2+NUUiK11OVWxBRJFfkqbO6lnwzYcGf94Vz9GSR+sm5bLrit5VavpNVrFQz4nRwbk7y9Weu5+fQHnSjxtBHodTGt46Ha0Tgi4wP6N09VtPh0iBI3OTvM7IRF6xU8vMhgKkdWz1NLGQoFE0Luu5Cxbg5AcTzOoPjpZtcQnCuK7/PjJdUnf59FbuImtUwrKrrU2pVa3FE80p6yfFapIbNG+2Tv1dRnqHaCuGtugnKfcTsbrGev9g8t/ZkVDoGnUGlZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFnSBUl6vj+O52WxjLAZGlwprE3WebCqsDrmYeixGKU=;
 b=GqhUc9drPtX7z+l8vCD9rF35KpXOZscR1jMb60riq5ZdTXnbeVtyz7RpdlW/adIDnEUi68kwrWaGpB2BoNWKZ4UEWoGo34IQ4OtrIXD/WK8Rq9MLWa2Srr0z5G7vM1WmO4UYFc6oDR75ThWVxgRLGZvKLb60+q1vOHGEFruCjX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from MN2PR03MB5199.namprd03.prod.outlook.com (2603:10b6:208:1e9::11)
 by SA3PR03MB7491.namprd03.prod.outlook.com (2603:10b6:806:3a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 03:54:44 +0000
Received: from MN2PR03MB5199.namprd03.prod.outlook.com
 ([fe80::4abf:734:8ae6:a75c]) by MN2PR03MB5199.namprd03.prod.outlook.com
 ([fe80::4abf:734:8ae6:a75c%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 03:54:43 +0000
Message-ID: <96b044b3-a2bb-2044-7f22-f6eefaab2d26@synaptics.com>
Date:   Tue, 18 Jul 2023 11:53:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
Content-Language: en-GB
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        ayaka@soulik.info, hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org
References: <20230704040044.681850-1-randy.li@synaptics.com>
 <20230704040044.681850-3-randy.li@synaptics.com>
 <20230712093301.nkj2vok2x7esdhb3@chromium.org>
 <f8f766c0166c502e29b06cda71f6531e44a91a17.camel@ndufresne.ca>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <f8f766c0166c502e29b06cda71f6531e44a91a17.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::26) To MN2PR03MB5199.namprd03.prod.outlook.com
 (2603:10b6:208:1e9::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB5199:EE_|SA3PR03MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: ee41be7d-9379-4e59-5538-08db8742b7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqnqaXrUuk7I0GEuhIIv18M/pT/n5jkx5HUCvg9hiAGhLKJmmhquUcdIflB33SKe0GIbPikwVov4PKFiiPHJemJzhSOsFoJrexVzD2w9Mqt+GPGe7sgH+MkyVN2gkEYy7Sbbr80v877GfBmL9tIuUtx/+45miFvPDhIB6PBOUw5SzLp8cIK+RAcQ37mJclgyUqncEwpzhx7adhVIZcDjVCHf2KyTEuW/6Nq3tgQpGfm0TAMaKREo424tF1hyghwctGYI2oqL7WLHjlt0dz+hfgNtepAhCtS4MfZkjKQDJlTIV/MnjqbsnDPkCcJ+H7mUyeuWYw73F8eyTG8UO85luuW291hrf8JRMLU4rne3z55NX1D0EwORJVxeaqQZn8z0dyjU2rkRFDuXZ4nP9q+u0+38g7djz2AYNIixvhg9HBEtOWWLa/bw51FiTfFIiw0rMo4eYSIbfFj5r7Bo/s+wHPO4BjDg8MH8tx/pZrFx4YL8MalHJkKwwVMeoP6ngu9aGWfhJ/PZPttZhU09ickXx94Fr0WBgyfnWCtag1SwUeUS7vukHZXbbP0i7NEk8qSVtrxWE+HGh6VrbGDSKBd4oIyaKLkx8UWZ6iGLdklen+29Emtkg4vWpSI/oSWlhs1uo2yjdtt0ApHtzlsDYFvS3axBjspDm8n7g62+kiwFGOnCUSYTrX2wnFFNVt7U5Lwl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5199.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(31686004)(66899021)(6486002)(52116002)(6666004)(478600001)(83380400001)(2616005)(31696002)(86362001)(66574015)(2906002)(186003)(6506007)(53546011)(6512007)(26005)(38100700002)(38350700002)(6916009)(66476007)(41300700001)(66946007)(66556008)(4326008)(316002)(7416002)(36756003)(8676002)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkI2OHlWOVJYaVhubXhhRkI0bWlmZHdweGljSWowL3VWQnpzU3VndUNwZHBQ?=
 =?utf-8?B?SHNrZEg2cjNFbkE4Y21VVVRWM0R5VDh1V2FSL1l3Uko0SGdkbk5LK2srY1Bh?=
 =?utf-8?B?SWw0UE16RXNycVRidTgydU8rczZ4c09NTUtTVzEwUERjVGdBRGJOb2t3MWM5?=
 =?utf-8?B?SW9PWjdaV2luMVplMzA4TW1mMEJXdXZ5RklqR0tGcFBoR28wNFU4NGFSa2tU?=
 =?utf-8?B?MVd0UEsvTGFoQ0tLd0VtRHBVems0a3hPZHViTmFSYkVqVzFmbWozMEN3RXZk?=
 =?utf-8?B?R241MFpkc1h1TEhXM0FVUERqMGFBVWZRQURLVjFNZkJrZURsRnQrYXlCOXdU?=
 =?utf-8?B?aFUzVXZsUEE0N1JqdHVrZnlEUDRmVGhmRmpLUXRjeWF2aW5CZFFkWTBGTlgx?=
 =?utf-8?B?WmFJSjdxM1dPYmoyMHUvRUErd0crNlRKQWpiNC9adCtRd0FDMk9kYnhFMS8x?=
 =?utf-8?B?VUdOTU5EYmZvb3FPOTR5RUVhSUlRb25nZ0o3bHR6VEFHOHBYWERtRkxOTFBM?=
 =?utf-8?B?WE9PZFR4a1hONGVWdU1kb3BSQ083cHhrMGNTc2VYYUxiR1pEVy9NUUh2YVgz?=
 =?utf-8?B?dmVUbDhhZVNKbDk2ZW05RTJUaWljV1NQUUVmRzhtRERHZkREdTdBWEJqVmdH?=
 =?utf-8?B?UlpXQjIvZUhab2Z2R1oyUjIrU21ycWlaZGFoYzlERGlIeld1b01TVUxQRktZ?=
 =?utf-8?B?bDdGS2o3VXhuSDhNbjI5UzBsbnFVTkRraEl6WFFNL0VrTGpJWGpGbXVuekZI?=
 =?utf-8?B?dFZ4OFVyeEREeFNJK3FvUmoyQndjdDBWQjg5aU90MU9kd2F5eE1zemtDUDd2?=
 =?utf-8?B?bDNxVWJib1BNT1NDaGRhQUFENTFUUXNQcDNQSHJIeW42UENFVVRSNHdsOXEv?=
 =?utf-8?B?UTZ0ejc2ejFUUW5GcTNwSEdtYW13a3FlU3Y1ZERkdEpxNVZGOTVJVnJ6WThW?=
 =?utf-8?B?eEZuOXRmY2hqb3NtVTlrL2NGUTU0K05CY3BGWVpVeE1VUEtsRVVUL2o2L3NP?=
 =?utf-8?B?ZHhQZ3ZtYkJYZnY4dkIxcitYODRpWnNQRWxNcy81Mi9ySnJqSEtqUUZveGtx?=
 =?utf-8?B?VzB3cVM0WEw3WWpwSCtVY2Y2dzgvdTFyK3piUXdsU3BRN0dxUkxCdGczM1g5?=
 =?utf-8?B?b3N6V1R2cmhiN0ZRVUdTa2I0MkJSZy9RaFFjTFVkMFhJQm01SjJQQlZWeVhY?=
 =?utf-8?B?V1dYTlhNdS9CbUZZVkM1ZVVoSG5yVnRKc0ZzeTJRZWk0MVZiWHpFSlRLdzFE?=
 =?utf-8?B?TjVadU9XbE9SUE1FS2FYMEVhSDFYODZ4SHlqeWZlRmkxN1UzWUF4ZERESlZP?=
 =?utf-8?B?T3k4cjdHTCtpZ2ZZZEZzOG5wWlJaZFprOG5Fam9WNVloYkUwTFEvSmsrZG5X?=
 =?utf-8?B?TWVEaHE4N0NEaFNYMWtRS2wrWFFFZGNOQ0FSb0JoUGF4NEVESlhEUmk1NG83?=
 =?utf-8?B?eGo2cmhLK1ZLbGI1UWcxUUN1d0FBRlNLUGdUTXIvMDNwSmtwOUxQNWJOY1l4?=
 =?utf-8?B?aDFsVU5ITlNZUjJBM1dteUx6b01PQzZ1UU5ITE03T01ZM3Q1MDNSVGUreGJT?=
 =?utf-8?B?MWFHUEJnK2RSQTVodjZhVVhBS3l6Y3ZEZWoyNGk0b1JwczQxWElKNTJZRW4z?=
 =?utf-8?B?bmtEY291OHdDRXJKQXQzblZ3TzVaejNFNTBhbmora1lkZllLclBha25ETXVH?=
 =?utf-8?B?UkJkZFI5aWlDYkE5MHJsMWRCTG54bzJBalpRUzdwYjg4eDFSamVoa214MENm?=
 =?utf-8?B?U3NlQlhKa0pDeDRVZlhQMVU5VWw5R3VQdnovZWpzVEw2dGRVV3pJbEk5NVVw?=
 =?utf-8?B?Qmc1KzNlNjBmbE1qZW1jU2ZPbDYyNlU3K2FnM1hNbWJGK0s0VUlBcVRkbGwv?=
 =?utf-8?B?MFBmNkNrdmh4c0c5V3pqMDJRdlR1bUM5RlBGbXBaMXUvWFlNZW1jV3B1RWhX?=
 =?utf-8?B?SExKWmNVSG5XQnRrWDN6R1U5M3hvaW5EOU84MVFLZHZjNWhESnRPcHA0eHBy?=
 =?utf-8?B?K3BoQTlDcnRnbVY5MitSZzM0VmhNQTd3T1VSc3Uxb3haT3NSMy9MSHY3NkhM?=
 =?utf-8?B?ZFJqMUZYT3IxdmU4bkR6UlV6Q2p5SmNtUlJiV290VnhuVDgvcDNjSURKU0ZL?=
 =?utf-8?Q?v6zJgdym0pcj7PB1Itcg5m6Wb?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee41be7d-9379-4e59-5538-08db8742b7da
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5199.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:54:42.7138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uj0HTuUTWGAIReEAT8RW5arohk7b7df3KSBLcn2IcomUx83p6UCjmYjKcRe5myz+9+03I76gPq6SpM/vbPsIaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7491
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/17/23 22:07, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> Le mercredi 12 juillet 2023 à 09:33 +0000, Tomasz Figa a écrit :
>> On Tue, Jul 04, 2023 at 12:00:38PM +0800, Hsia-Jun Li wrote:
>>> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>>>
>>> Many drivers have to create its own buf_struct for a
>>> vb2_queue to track such a state. Also driver has to
>>> iterate over rdy_queue every times to find out a buffer
>>> which is not sent to hardware(or firmware), this new
>>> list just offers the driver a place to store the buffer
>>> that hardware(firmware) has acknowledged.
>>>
>>> One important advance about this list, it doesn't like
>>> rdy_queue which both bottom half of the user calling
>>> could operate it, while the v4l2 worker would as well.
>>> The v4l2 core could only operate this queue when its
>>> v4l2_context is not running, the driver would only
>>> access this new hw_queue in its own worker.
>> Could you describe in what case such a list would be useful for a
>> mem2mem driver?
> Today all driver must track buffers that are "owned by the hardware". This is a
> concept dictated by the m2m framework and enforced through the ACTIVE flag.

I think that flag is confusing, the m2m framework would only set this 
flag when a buffer is enqueue into v4l2 (__enqueue_in_driver()).

The application can't know whether the driver(or hardware) would still 
use it when that buffer is dequeued(__vb2_dqbuf() would override the 
state here).

I was trying to suggest a flag for the new DELETE_BUF ioctl() or it 
could delete a buffer which the hardware could still use in the future, 
if we are not in the case for non-secure stateless codec.

> All
> buffers from this list must be mark as done/error/queued after streamoff of the
> respective queue in order to acknowledge that they are no longer in use by the
> HW. Not doing so will warn:
>
>    videobuf2_common: driver bug: stop_streaming operation is leaving buf ...
>
> Though, there is no queue to easily iterate them. All driver endup having their
> own queue, or just leaving the buffers in the rdy_queue (which isn't better).
>
> Nicolas
>>> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
>>> ---
>>>   drivers/media/v4l2-core/v4l2-mem2mem.c | 25 +++++++++++++++++--------
>>>   include/media/v4l2-mem2mem.h           | 10 +++++++++-
>>>   2 files changed, 26 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>> index c771aba42015..b4151147d5bd 100644
>>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>> @@ -321,15 +321,21 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
>>>              goto job_unlock;
>>>      }
>>>
>>> -   src = v4l2_m2m_next_src_buf(m2m_ctx);
>>> -   dst = v4l2_m2m_next_dst_buf(m2m_ctx);
>>> -   if (!src && !m2m_ctx->out_q_ctx.buffered) {
>>> -           dprintk("No input buffers available\n");
>>> -           goto job_unlock;
>>> +   if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
>>> +           src = v4l2_m2m_next_src_buf(m2m_ctx);
>>> +
>>> +           if (!src && !m2m_ctx->out_q_ctx.buffered) {
>>> +                   dprintk("No input buffers available\n");
>>> +                   goto job_unlock;
>>> +           }
>>>      }
>>> -   if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
>>> -           dprintk("No output buffers available\n");
>>> -           goto job_unlock;
>>> +
>>> +   if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
>>> +           dst = v4l2_m2m_next_dst_buf(m2m_ctx);
>>> +           if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
>>> +                   dprintk("No output buffers available\n");
>>> +                   goto job_unlock;
>>> +           }
>>>      }
>> src and dst would be referenced unitialized below if neither of the
>> above ifs hits...
>>
>> Best regards,
>> Tomasz
>>
>>>      m2m_ctx->new_frame = true;
>>> @@ -896,6 +902,7 @@ int v4l2_m2m_streamoff(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>>>      INIT_LIST_HEAD(&q_ctx->rdy_queue);
>>>      q_ctx->num_rdy = 0;
>>>      spin_unlock_irqrestore(&q_ctx->rdy_spinlock, flags);
>>> +   INIT_LIST_HEAD(&q_ctx->hw_queue);
>>>
>>>      if (m2m_dev->curr_ctx == m2m_ctx) {
>>>              m2m_dev->curr_ctx = NULL;
>>> @@ -1234,6 +1241,8 @@ struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_m2m_dev *m2m_dev,
>>>
>>>      INIT_LIST_HEAD(&out_q_ctx->rdy_queue);
>>>      INIT_LIST_HEAD(&cap_q_ctx->rdy_queue);
>>> +   INIT_LIST_HEAD(&out_q_ctx->hw_queue);
>>> +   INIT_LIST_HEAD(&cap_q_ctx->hw_queue);
>>>      spin_lock_init(&out_q_ctx->rdy_spinlock);
>>>      spin_lock_init(&cap_q_ctx->rdy_spinlock);
>>>
>>> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
>>> index d6c8eb2b5201..2342656e582d 100644
>>> --- a/include/media/v4l2-mem2mem.h
>>> +++ b/include/media/v4l2-mem2mem.h
>>> @@ -53,9 +53,16 @@ struct v4l2_m2m_dev;
>>>    * processed
>>>    *
>>>    * @q:             pointer to struct &vb2_queue
>>> - * @rdy_queue:     List of V4L2 mem-to-mem queues
>>> + * @rdy_queue:     List of V4L2 mem-to-mem queues. If v4l2_m2m_buf_queue() is
>>> + *         called in struct vb2_ops->buf_queue(), the buffer enqueued
>>> + *         by user would be added to this list.
>>>    * @rdy_spinlock: spin lock to protect the struct usage
>>>    * @num_rdy:       number of buffers ready to be processed
>>> + * @hw_queue:      A list for tracking the buffer is occupied by the hardware
>>> + *                 (or device's firmware). A buffer could only be in either
>>> + *                 this list or @rdy_queue.
>>> + *                 Driver may choose not to use this list while uses its own
>>> + *                 private data to do this work.
>>>    * @buffered:      is the queue buffered?
>>>    *
>>>    * Queue for buffers ready to be processed as soon as this
>>> @@ -68,6 +75,7 @@ struct v4l2_m2m_queue_ctx {
>>>      struct list_head        rdy_queue;
>>>      spinlock_t              rdy_spinlock;
>>>      u8                      num_rdy;
>>> +   struct list_head        hw_queue;
>>>      bool                    buffered;
>>>   };
>>>
>>> --
>>> 2.17.1
>>>
-- 
Hsia-Jun(Randy) Li

