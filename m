Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC4B755C88
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjGQHP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQHPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:15:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4431AE;
        Mon, 17 Jul 2023 00:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhkIJPqEKUEiLBHvGMYxsdjcoCCeYVPXiizPjseCYc+3kWbRNdUtbcRSxNXjJBga8okZioJlKZpy1LfVkLiHs20jqd/KJ7SzA2zQgexJ8fktI2XTQ/bTsbM0J1KBmvQyA8MtDNCKDy/ccJpRfoHE9vwOPxtxroPniUExcy0C0U9I4Qo9DtDssem0L8OwzKZSPmJITrdm9xTFyixLMH+r2MZqLLe4zkKgBk64eL9V/1YdJuaqZU2XrwwRD/x1Ht+TwHupy9RvyyiH6s7FR6S/TuvGXogaXwOGLj7n4uIugFmrHdrul/nrT+/85pmTeufrlMIB5Wyf47s39U8wuxUx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUqctDffiXI9RMkxvvPhznU0cPCX60ysOS2+G0Ghrd4=;
 b=XbeZnBOA0JtFyGHiN+0vEYwdZPm8DsWnEDsMNBd5Q6r9UU/dYbkxVuSNYrNeROL9cNfmYGxPZejhp8z2eDSv2hxvsmn+ifzJ9MWwu8OGtC8nkI45iChHZkIHp7nA4mQaZ3O3fWAhDpfQgoQPw9N4duFIFizu7RG4guCZ00vnAIDNi2d7JNlwlFl53SPkAtCQxCOK3Hn2rE0nltqu68tjvDlGDFBgeL+OJYg1bN8EAdUWx9S7Aqtk2g3kDRGv2Iwvig3VBPJLP1at45yKMnykihThaHWM1WolicHHddG4t8AlcQaFhi7F7G9wtXnJ0ZQv0tw6ih6kbinBnr6OGkWwEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUqctDffiXI9RMkxvvPhznU0cPCX60ysOS2+G0Ghrd4=;
 b=CwlApxZZy0d1mtBPEE24BfSNx3rIF/SUzKyYPvof+d4nTCEDworMgXMWYqT8DysNyYW2gcqraWrhNeq0HLK3nEDwgd0aD8h76D18WpynsOfjNz0iMZgnBLrF0HhLxSl3DJu7AFmTIEWCdk/K5eWIC4TsGhyKirN98dF7Nf1Y2m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by MW4PR03MB6572.namprd03.prod.outlook.com (2603:10b6:303:12b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 07:15:16 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 07:15:15 +0000
Message-ID: <4e70c8b8-d459-2b79-2b3d-40875f701d97@synaptics.com>
Date:   Mon, 17 Jul 2023 15:14:56 +0800
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
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <20230712093301.nkj2vok2x7esdhb3@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::19) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|MW4PR03MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: f093331b-ba47-43d9-9c87-08db869591a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2jMkD18iK6DUjiNzaTVAq6kRSbKkUP1fZ5uYJD3VlGvHSH38ds23wy1q0Gx+0anxpREpgrWANJEL6JGxgNQEib3rj9UPvraY33qZ/0WcgdQx0o9SuF97DPVBNa4O2cdU8w2ZXjj8/A0pgR6OMYY5QYg0hkkC0DeO5nU1nIpeOLSLcqucqb/aFZFFi1vY+g5lBEAF/gHIq4RrRIpA+IhIZ8PHkoKzpxphYsTnrvrrBznmYVVe7kUxvz722vvWKcGm9BfmgZ2pp5wzmD8WHRusaX1vgF/QMFijiUrF/PB7CIE3nWOIwEB/tFcXSH4H7ua47LM1eRFxwohsCTxQY4mG5mTCqWlceR/tjLoL8MHhDi3F/4aXZ9NKcNwsmlDqIzHsr7+CKo7TxfT6I6Xt85+F5LQuvJPxZzYncesyXgHCMnlnhohjSkW1nTgvRpc0CBKUzWxT81WBDndywZ0xhVgZUMWK1XU3f33OhEAAYv689D8brftYgm8tOH9dvEL5bKBECP/dpa5xv/0l+0aNACPVLBnkFDOWX374Bx9boMCtcBc2B4iYUGlbrhH3MaxJ635jHydZ42N9gyuc9nkbBQJAz97hw53fvJOJDOljWVS8a+Md29ZkUmBRbvec5HvNqnueQsoHEZosADoTMeXDufuGKoD/PAQRvA+zPBkTY/p+ojUAIB99zL7mGhBC9LrQ/NN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(31686004)(86362001)(83380400001)(6486002)(6666004)(36756003)(52116002)(38350700002)(38100700002)(2906002)(31696002)(2616005)(7416002)(186003)(5660300002)(66899021)(6506007)(53546011)(26005)(41300700001)(8676002)(8936002)(478600001)(6512007)(66946007)(66476007)(66556008)(316002)(4326008)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTdRc05jcnNwcUpNV3NtWVRxdUh0bVBHc3ZZaVhEcE5YQkg1VHlrRW1XUGZ0?=
 =?utf-8?B?NVhEOEN5NWQ1dnVPaEhDZG9CUXpTQVc4WnRZbFNIQ2lQeitWVHF6Y2NWSkYz?=
 =?utf-8?B?Z0hJc1FtN0pLS3JGYlMwajNRWU9NaDgrUGFCOFVaQi9oWG1DWW9CTDc1QTR6?=
 =?utf-8?B?cnJubzZFR2ZmQ2hMQitaNnZFMVh0cEF1VDVvU2MyWTlGQjZhSnlCUFpaZTdI?=
 =?utf-8?B?eGwvUFNkL3paTGtpMmNRNUZHa3YxWUxNSjMyODV3dzdWdkY2dWs5TVk5SEVi?=
 =?utf-8?B?T0Z6UStFQUZiZ1M3a1RlTU9wVlJ1ZUZEY2toMnFkcG9raFZEMmI5aHFXSGhz?=
 =?utf-8?B?cllxcCt2NVNKaVRiWGN3dXJyV1h1QXhWWTl5c0JXV2xVakMva3h5dnVUeUxm?=
 =?utf-8?B?Rm5Rb2hHMWhaTnlGOWYvaUY2S1JhU3A3d2g3NUFOTjIwQnNkWVorN1NPNjA2?=
 =?utf-8?B?YzFYN3NzdXN2OG9RcXdxNS9sa2syeUF1YU9ZR0J1bnVoamkvZ0ZaSm5iaUJw?=
 =?utf-8?B?QWtpdytibjJZOHFnSmJxSWQ2REJXZnF6S3Aydm9QS3l2WTJSTlp3SkdTVWRq?=
 =?utf-8?B?UytPNVFXREFIRnkvdU0vVjFDWWMyZEZTdUtxV2NIZnZpWG42MEM4UGYrK012?=
 =?utf-8?B?V0ltT0pJNFNXL1B2QS9jNFJUcVg2eExZc3FzMGw2Und1b2VmU2RkRmhvK3N5?=
 =?utf-8?B?M1pWN1dSQWF3azlrcEkyZFBlaDhha2QrcHFDckx5OWQyVlR0RG5oK056RThz?=
 =?utf-8?B?TlFEc2l2a056MDhNZ0N4OWp5TStMcTVpOFgyTDFUTmhRRGl5UUpLYUdIYzBL?=
 =?utf-8?B?L2wxTjU5UWtsV3FZSTVHYXNsRjg1RmtTdzczRVg2VitxLzlEVkRoVXh5R1FQ?=
 =?utf-8?B?Q0Z0RHFUc091Qnl1dDhjenFmRzNuWGc1YTJldlg2eURIUWxVQ0ZLVC9udnRv?=
 =?utf-8?B?azNraTdldGlzSHhaUm5aWmdwN2k1Q0svL0d0WXVHbnhWRkRvWnZvQ0E5cUow?=
 =?utf-8?B?WE1zZHNUajFPNGM5Uy9MeE9JS3JJTUQrNkp5bFNvTnVrU0lFelo4dDFwRlph?=
 =?utf-8?B?K1Q5TEJuM0M1U3NsWDJtRVJwWE5hZjU0VjcvUWpsRGdZY2xZZW9GTEhCaXpl?=
 =?utf-8?B?WnNpNm5DMXd5YUU5elgzTWU1cGg2YnhvMS9aejVqbVhuWmxkdmI3TmRybU9o?=
 =?utf-8?B?U2NXRTVmblBSZ2c3czVEcHJqRXdHc3NKSVA5d3hDMHJZYjhMTkg5L3JCNFFB?=
 =?utf-8?B?TjVVMUkwblZVSmlERHdQOXpqaW9TT1k5c25KeTczakRlL25laXF0R1U3OURm?=
 =?utf-8?B?ZUxlODE1SUNQUjVlZmp4T2dIbURjSG1jUGdsRzRVL2dXaEJKK3psV0N4UDMz?=
 =?utf-8?B?Z25VS2tsZ0VwUWRrR2N1QnBOUFgzR0MzYVhYcm4veCtodGEvRmsvdWhVWmJi?=
 =?utf-8?B?TWJVa21xZ201Q1ptSG5JWlVkUFhWMkNCd21Ba2lkcW80aW5PSTh5TktOUXh4?=
 =?utf-8?B?MlBVc0hXYmFiM3VYanMzdHlIL3VpNHYvTVlZSCtvaFZ1SHBKMDZPZUNFSkRB?=
 =?utf-8?B?eDd4RjMrVjBoWHZXSjR6T3lGTkhEVXI0QWxnK0lOaVBRV3FTMzhWWVM3U2NZ?=
 =?utf-8?B?UHpsNVNoUzM3bkF3OCtLY3RhbkFkSTNPNzJ1VEl5SlBMT3J0bXZxeU1qai9X?=
 =?utf-8?B?eFpDWkhMYW9vd0txR1p2MXg2MGtZeW1DdzdQUVlEK1ZMSWhuc1U3eHV2Ykpr?=
 =?utf-8?B?OXVWV3c0TUQ2ODRNcTJrU1NtZW9EZlpFREFvb1ZuODZmcDBBekNjZHQvMFZW?=
 =?utf-8?B?eEM4aE44czNvcVJoWHpwMi9uRDh2c1QwT3liQkJKai9ieWRTNnlFeTJ6bzJo?=
 =?utf-8?B?d2xMTTlFNGg2RS9wa2lna1ZQd2pidDBJWjl5NDhmVVQ0S2hjM2VUaFZWVEZI?=
 =?utf-8?B?VnZrMllaTkhCQlZFL2hsYm0rZ0VYSnNUMEZFblJaRnFCTE1aWC90RkthZnF3?=
 =?utf-8?B?aHh1bUo4U08zQ0FJRUd1SHNucW5YQkxGQ1FIemlOK0dIZHZkRGxrSXEyVzlx?=
 =?utf-8?B?dWRjSlJ3bTlUQjRKc1RMd1l6ODduUzBaNmQyYThLZStidzRsTUNZWlllVTY0?=
 =?utf-8?Q?WZ4pCEc0G+yVAl0mMEQp/9BEB?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f093331b-ba47-43d9-9c87-08db869591a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 07:15:15.7305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrtwoeHj7dWZpgAKkZqCnE4GCpITZwG3xjNNwaWqA0pDZA0goNN5SrtFmAxrf8157/SJpYCI9jewDbTHLHIcyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6572
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/12/23 17:33, Tomasz Figa wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Tue, Jul 04, 2023 at 12:00:38PM +0800, Hsia-Jun Li wrote:
>> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>>
>> Many drivers have to create its own buf_struct for a
>> vb2_queue to track such a state. Also driver has to
>> iterate over rdy_queue every times to find out a buffer
>> which is not sent to hardware(or firmware), this new
>> list just offers the driver a place to store the buffer
>> that hardware(firmware) has acknowledged.
>>
>> One important advance about this list, it doesn't like
>> rdy_queue which both bottom half of the user calling
>> could operate it, while the v4l2 worker would as well.
>> The v4l2 core could only operate this queue when its
>> v4l2_context is not running, the driver would only
>> access this new hw_queue in its own worker.
> Could you describe in what case such a list would be useful for a
> mem2mem driver?

This list, as its description, just for saving us from creating a 
private buffer struct to track buffer state.

The queue in the kernel is not the queue that hardware(codec firmware) 
are using.


>> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
>> ---
>>   drivers/media/v4l2-core/v4l2-mem2mem.c | 25 +++++++++++++++++--------
>>   include/media/v4l2-mem2mem.h           | 10 +++++++++-
>>   2 files changed, 26 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>> index c771aba42015..b4151147d5bd 100644
>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>> @@ -321,15 +321,21 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
>>                goto job_unlock;
>>        }
>>
>> -     src = v4l2_m2m_next_src_buf(m2m_ctx);
>> -     dst = v4l2_m2m_next_dst_buf(m2m_ctx);
>> -     if (!src && !m2m_ctx->out_q_ctx.buffered) {
>> -             dprintk("No input buffers available\n");
>> -             goto job_unlock;
>> +     if (list_empty(&m2m_ctx->out_q_ctx.hw_queue)) {
>> +             src = v4l2_m2m_next_src_buf(m2m_ctx);
>> +
>> +             if (!src && !m2m_ctx->out_q_ctx.buffered) {
>> +                     dprintk("No input buffers available\n");
>> +                     goto job_unlock;
>> +             }
>>        }
>> -     if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
>> -             dprintk("No output buffers available\n");
>> -             goto job_unlock;
>> +
>> +     if (list_empty(&m2m_ctx->cap_q_ctx.hw_queue)) {
>> +             dst = v4l2_m2m_next_dst_buf(m2m_ctx);
>> +             if (!dst && !m2m_ctx->cap_q_ctx.buffered) {
>> +                     dprintk("No output buffers available\n");
>> +                     goto job_unlock;
>> +             }
>>        }
> src and dst would be referenced unitialized below if neither of the
> above ifs hits...
I think they have been initialized at v4l2_m2m_ctx_init()
>
> Best regards,
> Tomasz
>
>>        m2m_ctx->new_frame = true;
>> @@ -896,6 +902,7 @@ int v4l2_m2m_streamoff(struct file *file, struct v4l2_m2m_ctx *m2m_ctx,
>>        INIT_LIST_HEAD(&q_ctx->rdy_queue);
>>        q_ctx->num_rdy = 0;
>>        spin_unlock_irqrestore(&q_ctx->rdy_spinlock, flags);
>> +     INIT_LIST_HEAD(&q_ctx->hw_queue);
>>
>>        if (m2m_dev->curr_ctx == m2m_ctx) {
>>                m2m_dev->curr_ctx = NULL;
>> @@ -1234,6 +1241,8 @@ struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_m2m_dev *m2m_dev,
>>
>>        INIT_LIST_HEAD(&out_q_ctx->rdy_queue);
>>        INIT_LIST_HEAD(&cap_q_ctx->rdy_queue);
>> +     INIT_LIST_HEAD(&out_q_ctx->hw_queue);
>> +     INIT_LIST_HEAD(&cap_q_ctx->hw_queue);
>>        spin_lock_init(&out_q_ctx->rdy_spinlock);
>>        spin_lock_init(&cap_q_ctx->rdy_spinlock);
>>
>> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
>> index d6c8eb2b5201..2342656e582d 100644
>> --- a/include/media/v4l2-mem2mem.h
>> +++ b/include/media/v4l2-mem2mem.h
>> @@ -53,9 +53,16 @@ struct v4l2_m2m_dev;
>>    *   processed
>>    *
>>    * @q:               pointer to struct &vb2_queue
>> - * @rdy_queue:       List of V4L2 mem-to-mem queues
>> + * @rdy_queue:       List of V4L2 mem-to-mem queues. If v4l2_m2m_buf_queue() is
>> + *           called in struct vb2_ops->buf_queue(), the buffer enqueued
>> + *           by user would be added to this list.
>>    * @rdy_spinlock: spin lock to protect the struct usage
>>    * @num_rdy: number of buffers ready to be processed
>> + * @hw_queue:        A list for tracking the buffer is occupied by the hardware
>> + *           (or device's firmware). A buffer could only be in either
>> + *           this list or @rdy_queue.
>> + *           Driver may choose not to use this list while uses its own
>> + *           private data to do this work.
>>    * @buffered:        is the queue buffered?
>>    *
>>    * Queue for buffers ready to be processed as soon as this
>> @@ -68,6 +75,7 @@ struct v4l2_m2m_queue_ctx {
>>        struct list_head        rdy_queue;
>>        spinlock_t              rdy_spinlock;
>>        u8                      num_rdy;
>> +     struct list_head        hw_queue;
>>        bool                    buffered;
>>   };
>>
>> --
>> 2.17.1
>>
-- 
Hsia-Jun(Randy) Li

