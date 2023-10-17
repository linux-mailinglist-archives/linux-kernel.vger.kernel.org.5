Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE14D7CC09E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343576AbjJQKZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbjJQKZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:25:19 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01olkn2083.outbound.protection.outlook.com [40.92.66.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8C58E;
        Tue, 17 Oct 2023 03:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YitFB4t02R7NNJUhY6k72R6k2gs5ZJYHu6T8GHv5ouKTyU5aY8VZ1JFRZr2d73NZZFCvRWd7R5vHpjTUpHDVUXy1s2u8+DC+FVo7hDpaHGJOQ/M+8nPETXQWV7wgqsGZWWdAJJ/5P3At69l+9Xo6EuA0no0X891LXErPswYGmQpRIuntkqlVKZDCf+eFbiFyapYsFrLjZGYaoJpApduopnv2dyvi4UmghEAB83DFM4sl+0GIxT98CfI0++6R/IiGb0+P8nGkWPhvvxLwJ3j1vQH84bwh7f0KtoPinBoiy0MIAnd7R5M4VlR6Cz7hXzhH4Urp8WsT97O/LpCaKNdUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NLbVtIBgZKSwD0lqdxD9uFkjaf/d+qY8eqhJrvrPW0=;
 b=oKOp/obo6cbxXCapmxPcF8BLrxUwsfbd5gbMUbtPkjY8dQOyGFRc1V3ykzD9sjnMPURm7HmdSp925nXy16Ad3kXnEdZR44lFXkDE2jtXrW3wPK/62+3Sg4Bg2D/hsBD8AVSi5bNkdDFrqieh2F8MspCn29/9oa/PAQ3vhYwrHkzScIIvhP6lwQV+vFG58yuYbN6B07H+Jfh/mqsEijQmL/maeLbzwgTqsWNTN1J26q4TkbyOm0cUJjETKqwZXevp4dq+BZX4RwlBUwWSLvmQur1S9kpGn2Cj7y15KPgSURwo9E7yS0ellIrgaHgyqx4OuPM8JHgqe//jCPLALG66cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NLbVtIBgZKSwD0lqdxD9uFkjaf/d+qY8eqhJrvrPW0=;
 b=ZZMGV/lgehae3VsL2G+R6pPF4so3NszUYKOkUUFsoi4y23KnIJJyK10uE5NlPpHZp/Sv1zYY60bmwy1FuUe9lpmJaXLr6DTjWhfsytnxpM3jEa7u3km1fhw/OfiDpOPel/vzmZF6RSXRFA5u1ip8jnuIv3zL2M2NXiH/iIoNlFn90A3qn3eyRmzNND3EBE/wToagBvkaOIwR0xk0RYQBiFu9tzrVm2FmYfikyDAkrFkQ4NLZtree0XSvhrdPAIxC8YiYRKSCabiW+1GdJ5YzNk1E2CjpiSFegOZ98glveVt6zXPHIYz0bfNjl8Hc3IUqmUDsV3mzhny8nsogmmsNKQ==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by DB8P193MB0502.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:152::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 10:25:15 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::af68:c2a:73ce:8e99]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::af68:c2a:73ce:8e99%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 10:25:15 +0000
Message-ID: <VI1P193MB0752C1A213A65CD7D49347B399D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Date:   Tue, 17 Oct 2023 18:25:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tls: Fix slab-use-after-free in tls_encrypt_done
To:     Simon Horman <horms@kernel.org>
Cc:     borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com
References: <VI1P193MB0752428D259D066379242BD099D3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
 <20231016095015.GJ1501712@kernel.org>
From:   Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <20231016095015.GJ1501712@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [n/rox1dDbiBHhRGH2yfIn/7RqCFJhqNC]
X-ClientProxiedBy: LO2P265CA0387.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::15) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <c560c802-f514-47ba-936d-c9c76105cbeb@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|DB8P193MB0502:EE_
X-MS-Office365-Filtering-Correlation-Id: aad3ffb2-18a3-400f-8910-08dbcefb59f6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNd9051h22e7U5rP0SIcXMWxut4scFelPm6zvtTw/rCqnv7SRgoVhYrWRnByXrbcEUvERHT6BdMbOd2Ua77Gjrjrx+wgnUasKgmfDjQVkFVtWUCqvWJwKgGZg/lPSHHp18gmCC3BqAE9/16sRvwu2Q9Ztd+X8idqjDdNcYdOnm67jj/h+fcUOmxB8OPvt9Q6EOy7AC+WvJvscRb9cIrbpA8qXiCOf5u8fwGauhEsVE3bR+9FLHT8EKfrYiZfBsJkiv8PeO9zuYIVlKWcfdY2bMyEtgnbgeEJnIN4l4YcWt+b70xt0NIPKMojh9h4KkaQpCoumKmQVdhlasjR/wJQXXQoyJzp9Pio5XyewQxPSFa3nJ7CsW5uNNZ4QwhBZv/3aSydnkQiCT81hWR1L1ITBsstjn2Ad91gWFFMzfv4iXIsEkBaVLby/lqzpss4w0u46D0jrwOEz6Q1f7uqKBPwfDhRp/c4QChjJNaUc/svBjUM869bclxXT2h42CCTdLXG1D1bvQfMUwKXgyofkZTXgUQklODOJ2R78YB6q7jn70OPyiAR9kmylraHMDrWAtW1KOCfuFTTq6MpMFQcZ2VTk41BkHvkO02tlcNZnC5Ro8o=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2xWZ2VLTWdoRGMxclF1ZHZld1FkUVJJcHI0cDhMSjllUmhrUXNnb1gvT2RD?=
 =?utf-8?B?Ym5WYVB2R1IvbjlDQndiUHhnTDNTOEtpdzZCdGhyVlJuSjMrb3g5NWZlQmdo?=
 =?utf-8?B?TDg4ZUFMZlhaVjhIM244V2R1QVNRSUV2RW9yWTliYUpIZ0ZiQitIZmFsS3BB?=
 =?utf-8?B?ZHI3bnFuMlRyR1l1alVZZHdFV1RhcXQxSkNYZHhtQktLeE9QOUpFUnN6S25u?=
 =?utf-8?B?Z3hFeVVCQVhIU1phcmFNSDQ5TVByYWwwblpNMmlUdVZybHorSVU0QVZiSGZN?=
 =?utf-8?B?V2cxeXpvQkFaN0pvU3l6c3JsdVR0a2djZmZJcGlZWTc5L2sxVHJ2QytTWlpI?=
 =?utf-8?B?Qk1vQzlkUjh5RXd6ZjJGd0JxTm5mRnRDbTk1b204NGNLaUlzZUhxMTNockpn?=
 =?utf-8?B?UzVkbW1hTC9ZMTVKWk4yQnFlaG1TMnFQd3FzZHZtT3lLVnUvZWxCdEVUL0xv?=
 =?utf-8?B?NGtkaXlrazRnZFU3VjdVbTM3OEt3b0NPb2tIMVl4VFdRTXZvWTZRZDZlV2dt?=
 =?utf-8?B?SjdYdjBDZklzNHA4RXN1Y2FobXplY0N1OHI3bUtuL2M1RkxIRGxxWFR1Z0Vj?=
 =?utf-8?B?Ym1uOTVaT29Qd3ZKcktoemNaRjczODB4QVRkUHZIcFkxYzN5MU5LdHVUZ3hj?=
 =?utf-8?B?Lys2NzhONDVCUkZDVkRPN1lOM2pXQW5RRnc0TWlFSloyVWRDWTZUc0V5d0ph?=
 =?utf-8?B?NkRnMVhPTUhhVWFyYndqVit0U093SXRZOFBaUGR1YngyakFmdDhMZE1rcU5Q?=
 =?utf-8?B?T1FsRmJNcDhkU29nQXhiZXdTU2JBZytRaEZDM00xRlB5aUNBc3orZzJuaWVV?=
 =?utf-8?B?VHc1MnovUzlFSDdaRE9GMWtVNXRmTUlBUVg3VGZ2RHNwWHl3dVlIb09NTE5H?=
 =?utf-8?B?N2s1RFhPOTRYSFVrK3Z2NExSVzJEcFh0elgvbDduRW9mc25YM2ZiTHdscU9Q?=
 =?utf-8?B?d3hUYnJ2YWlTWlk4L1VZaUs4VlZCUWcrbDNNZnhWWjE1cUJkMnlOUFlhTXlZ?=
 =?utf-8?B?NStDaE5lOG1qNnFXcVF3S2RLT0h5clBuMFZ2R1oyTjJtaUlVUTBzMjZGRWFO?=
 =?utf-8?B?aHpNamFOSmQ1YzlFc045ZW5lUWRnRXZPY2VKREp1OWMxQVh3eXdYb0Z5UEpP?=
 =?utf-8?B?TEJ1aWRvcS9KVVUrNGdSZERpSkVWY0VCY3hXV1hLRkdFV2FlMG4rd21JWkRZ?=
 =?utf-8?B?TTdFWjYydlVhMllIUjVGYjhJZ2ppS3JkUDI4NlBIMU13ZGJTTkttcWtzd0VC?=
 =?utf-8?B?Z2pTQUFialkyUjMxbHZJeU9nMW1jcWM3MXhxbmxTRTd1ZzVmR2lRUHFxRkUx?=
 =?utf-8?B?TXVucDNkVHVoT0N2L2pPdWlJaHF4TDQ1bGNkQUNsbVlrYy8yaE44bDNpeVd4?=
 =?utf-8?B?T2JJU1huY2U1RDc5MTlEcE9YZStwSnVtQ2pQNjYxOVNvc0loQm1aUTltaXpL?=
 =?utf-8?B?SThvZUpZSE9jUGFTZW9UNkFaa3R3VlJ6M3pPUjdoRlZadUtXTk9uKytrWUpN?=
 =?utf-8?B?amt6NEczZWpZSzZlVnBpTlArOFNHNmhRQkMyQWk0Y3ZITXNOZUpsMHNFL0RX?=
 =?utf-8?B?RlZsc2NOQTBWeUNEZ3FVUHo2ZmhNckRjMk9xNE8wRW4vaU9DWmtSeUxoeE51?=
 =?utf-8?Q?tjQpft9GwrLzOvqTh4oj6MMExfk5k34b2QWO5J/t5Kmo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad3ffb2-18a3-400f-8910-08dbcefb59f6
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 10:25:14.9725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P193MB0502
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/16 17:50, Simon Horman wrote:
> On Thu, Oct 12, 2023 at 07:02:51PM +0800, Juntong Deng wrote:
>> In the current implementation, ctx->async_wait.completion is completed
>> after spin_lock_bh, which causes tls_sw_release_resources_tx to
>> continue executing and return to tls_sk_proto_cleanup, then return
> 
> Hi Juntong Deng,
> 
> I'm slightly confused by "causes tls_sw_release_resources_tx to  continue
> executing".
> 
> What I see in tls_sw_release_resources_tx() is:
> 
>          /* Wait for any pending async encryptions to complete */
>          spin_lock_bh(&ctx->encrypt_compl_lock);
>          ctx->async_notify = true;
>          pending = atomic_read(&ctx->encrypt_pending);
>          spin_unlock_bh(&ctx->encrypt_compl_lock);
> 
> Am I wrong in thinking the above will block because
> (the same) ctx->encrypt_compl_lock is held in tls_encrypt_done?
> 

Hi Simon Horman,

What I mean is that tls_sw_release_resources_tx will pause at
crypto_wait_req(-EINPROGRESS, &ctx->async_wait) because crypto_wait_req
call wait_for_completion.

Then after tls_encrypt_done call complete(&ctx->async_wait.completion),
it will cause tls_sw_release_resources_tx to continue executing.

>> to tls_sk_proto_close, and after that enter tls_sw_free_ctx_tx to kfree
>> the entire struct tls_context (including ctx->encrypt_compl_lock).
>>
>> Since ctx->encrypt_compl_lock has been freed, subsequent spin_unlock_bh
>> will result in slab-use-after-free error. Due to SMP, even using
>> spin_lock_bh does not prevent tls_sw_release_resources_tx from continuing
>> on other CPUs. After tls_sw_release_resources_tx is woken up, there is no
>> attempt to hold ctx->encrypt_compl_lock again, therefore everything
>> described above is possible.
>>
>> The fix is to put complete(&ctx->async_wait.completion) after
>> spin_unlock_bh, making the release after the unlock. Since complete is
>> only executed if pending is 0, which means this is the last record, there
>> is no need to worry about race condition causing duplicate completes.
>>
>> Reported-by: syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=29c22ea2d6b2c5fd2eae
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   net/tls/tls_sw.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index 270712b8d391..7abe5a6aa989 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -441,6 +441,7 @@ static void tls_encrypt_done(void *data, int err)
>>   	struct sk_msg *msg_en;
>>   	bool ready = false;
>>   	struct sock *sk;
>> +	int async_notify;
>>   	int pending;
>>   
>>   	msg_en = &rec->msg_encrypted;
>> @@ -482,10 +483,11 @@ static void tls_encrypt_done(void *data, int err)
>>   
>>   	spin_lock_bh(&ctx->encrypt_compl_lock);
>>   	pending = atomic_dec_return(&ctx->encrypt_pending);
>> +	async_notify = ctx->async_notify;
>> +	spin_unlock_bh(&ctx->encrypt_compl_lock);
>>   
>> -	if (!pending && ctx->async_notify)
>> +	if (!pending && async_notify)
>>   		complete(&ctx->async_wait.completion);
>> -	spin_unlock_bh(&ctx->encrypt_compl_lock);
>>   
>>   	if (!ready)
>>   		return;
>> -- 
>> 2.39.2
>>
>>

