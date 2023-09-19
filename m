Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4777A6C91
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjISU5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjISU5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:57:52 -0400
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 13:57:46 PDT
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DD9BF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
        c=relaxed/relaxed; q=dns/txt; t=1695157067; x=1697749067;
        h=content-transfer-encoding:content-type:in-reply-to:from:content-language:references:cc:to:subject:mime-version:date:message-id:x-thread-info:subject:to:from:cc:reply-to;
        bh=AskR4byY02A0+0bNCEbBq1u+3fbXAqKncGpUjIuFVcM=;
        b=VP5mjrgwnnLw7XEwEfN7y/K0nBCpdZGNDwMM+WflR9uuFqZryhFmX06ntCsAjp2z6Oj2VNH8dRx5WFXleHDMcwyAFanV+j9IfD4uqxbyBMJQD3krQ3VQbgTaXvRM+tuChfMyRNhYYrPbJ/bv8YB5iqOwmybsfa8doQSFUVnRJHw=
X-Thread-Info: NDUwNC4xMi4xNWZkOTAwMDdhNzdkMjIubGludXgta2VybmVsPXZnZXIua2VybmVsLm9yZw==
Received: from r3.us-east-1.aws.in.socketlabs.com (r3.us-east-1.aws.in.socketlabs.com [142.0.191.3]) by mxrs4.email-od.com
        with ESMTP(version=Tls12 cipher=Aes256 bits=256); Tue, 19 Sep 2023 16:42:29 -0400
Received: from nalramli.com (d14-69-55-117.try.wideopenwest.com [69.14.117.55]) by r3.us-east-1.aws.in.socketlabs.com
        with ESMTP; Tue, 19 Sep 2023 16:42:28 -0400
Received: from [10.0.2.15] (d14-69-55-117.try.wideopenwest.com [69.14.117.55])
        by nalramli.com (Postfix) with ESMTPS id 09F092CE000F;
        Tue, 19 Sep 2023 16:42:27 -0400 (EDT)
Message-ID: <150cef65-1de0-4145-a917-18a3665808c2@nalramli.com>
Date:   Tue, 19 Sep 2023 16:42:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next RFC v2 0/4] mlx5: support per queue coalesce settings
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc:     netdev@vger.kernel.org, saeedm@nvidia.com, saeed@kernel.org,
        kuba@kernel.org, davem@davemloft.net, tariqt@nvidia.com,
        linux-kernel@vger.kernel.org, leon@kernel.org, jdamato@fastly.com,
        sbhogavilli@fastly.com, nalramli@fastly.com
References: <ZOemz1HLp95aGXXQ@x130> <20230918222955.2066-1-dev@nalramli.com>
 <87ttrq802f.fsf@nvidia.com>
Content-Language: en-US
From:   "Nabil S. Alramli" <dev@nalramli.com>
In-Reply-To: <87ttrq802f.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_IADB_DK,RCVD_IN_IADB_LISTED,
        RCVD_IN_IADB_OPTIN,RCVD_IN_IADB_RDNS,RCVD_IN_IADB_SENDERID,
        RCVD_IN_IADB_SPF,RCVD_IN_IADB_VOUCHED,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

Thank you for your response.

On 9/19/23 14:55, Rahul Rameshbabu wrote:
> Hi Nabil,
> 
> On Mon, 18 Sep, 2023 18:29:51 -0400 "Nabil S. Alramli" <dev@nalramli.com> wrote:
>> Hello,
>>
>> This is v2 of my previous patch:
>> https://lore.kernel.org/lkml/20230823223121.58676-1-dev@nalramli.com/.
>>
>> Saeed: Thanks for reviewing v1. I made significant changes to support
>> per-channel DIM settings. Is this ready for an official v1 submission or
>> are there other major changes you'd like to see before I do that?
>>
>> ***************************************************************************
>> Version History
>> ---------------
>> * v1: Initial draft, individual channel DIM changes not supported.
>> * v2: Support individual channel DIM changes.
>> ***************************************************************************
> 
> We actually began working on a patch set for the feature internally
> inspired by your initial RFC. If it is alright with you, would it be ok
> to have you as a co-author of that series that we should have prepared
> in the coming days? We have some minor enhancements that we think will
> improve the general architecture for how we handle both the global and
> per-queue settings.
> 

Yes. Please feel free to add me as a co-author. Actually, I'm new to
submitting mlx-5 patches and a lot of credit goes to Joe Damato
<jdamato@fastly.com> who had this initial idea and helped me develop it
into this patch, so would you mind adding him as well? If you would like
you could start with my patch-set and then revert it and add your own,
or if you think that's too much trouble then I'm fine with however you'd
like to proceed. I'd be happy to test your patch whenever it's ready.

>>
>> Currently, only gobal coalescing configuration queries or changes are
>> supported in the `mlx5` driver. However, per-queue operations are not, and
>> result in `EOPNOTSUPP` errors when attempted with `ethtool`. This patch
>> adds support for per-queue coalesce operations.
>>
>> Here's an example use case:
>>
>> - A mlx5 NIC is configured with 8 queues, each queue has its IRQ pinned to
>>    a unique CPU.
>> - Two custom RSS contexts are created: context 1 and context 2. Each
>>    context has a different set of queues where flows are distributed. For
>>    example, context 1 may distribute flows to queues 0-3, and context 2 may
>>    distribute flows to queues 4-7.
>> - A series of ntuple filters are installed which direct matching flows to
>>    RSS contexts. For example, perhaps port 80 is directed to context 1 and
>>    port 443 to context 2.
>> - Applications which receive network data associated with either context
>>    are pinned to the CPUs where the queues in the matching context have
>>    their IRQs pinned to maximize locality.
>>
>> The apps themselves, however, may have different requirements on latency vs
>> CPU usage and so setting the per queue IRQ coalesce values would be very
>> helpful.
>>
>> This patch would support this. In v1 DIM mode changes could only be changed
>> NIC-wide. However, in this iteration, DIM mode changes are supported
>> globally as well as on a per-queue basis.
>>
>> Here's an example:
>>
>> ```
>> $ sudo ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
>> Queue: 2
>> Adaptive RX: on  TX: on
>> stats-block-usecs: 0
>> sample-interval: 0
>> pkt-rate-low: 0
>> pkt-rate-high: 0
>>
>> rx-usecs: 8
>> rx-frames: 128
>> rx-usecs-irq: 0
>> rx-frames-irq: 0
>>
>> tx-usecs: 8
>> tx-frames: 128
>> tx-usecs-irq: 0
>> tx-frames-irq: 0
>> ```
>>
>> Now, let's try to set adaptive-rx off rx-usecs 16 for queue 2:
>>
>> ```
>> $ sudo ethtool --per-queue eth0 queue_mask 0x4 --coalesce adaptive-rx off
>> $ sudo ethtool --per-queue eth0 queue_mask 0x4 --coalesce rx-usecs 16
>> ```
>>
>> Confirm that the operation succeeded:
>>
>> ```
>> $ sudo ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
>> Queue: 2
>> Adaptive RX: off  TX: on
>> stats-block-usecs: 0
>> sample-interval: 0
>> pkt-rate-low: 0
>> pkt-rate-high: 0
>>
>> rx-usecs: 16
>> rx-frames: 32
>> rx-usecs-irq: 0
>> rx-frames-irq: 0
>>
>> tx-usecs: 8
>> tx-frames: 128
>> tx-usecs-irq: 0
>> tx-frames-irq: 0
>> ```
>>
>> The individual channel settings do not overwrite the global ones. However
>> Setting the global parameters will also reset all of the individual channel
>> options. For example, after we set the options for queue 2, we'll see that
>> the global options remain unchanged:
>> ```
>> $ sudo ethtool --show-coalesce eth0
>> Coalesce parameters for eth0:
>> Adaptive RX: on  TX: on
>> stats-block-usecs: 0
>> sample-interval: 0
>> pkt-rate-low: 0
>> pkt-rate-high: 0
>>
>> rx-usecs: 8
>> rx-frames: 128
>> rx-usecs-irq: 0
>> rx-frames-irq: 0
>>
>> tx-usecs: 16
>> tx-frames: 32
>> tx-usecs-irq: 0
>> tx-frames-irq: 0
>> ```
>>
>> But then if we set them, we'll see that the options for queue 2 have been
>> reset as well:
>> ```
>> $ sudo ethtool --coalesce eth0 adaptive-tx off
>>
>> $ sudo ethtool --show-coalesce eth0
>> Coalesce parameters for eth0:
>> Adaptive RX: on  TX: off
>> stats-block-usecs: 0
>> sample-interval: 0
>> pkt-rate-low: 0
>> pkt-rate-high: 0
>>
>> rx-usecs: 8
>> rx-frames: 128
>> rx-usecs-irq: 0
>> rx-frames-irq: 0
>>
>> tx-usecs: 16
>> tx-frames: 32
>> tx-usecs-irq: 0
>> tx-frames-irq: 0
>>
>> $ sudo ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
>> Queue: 2
>> Adaptive RX: on  TX: off
>> stats-block-usecs: 0
>> sample-interval: 0
>> pkt-rate-low: 0
>> pkt-rate-high: 0
>>
>> rx-usecs: 8
>> rx-frames: 128
>> rx-usecs-irq: 0
>> rx-frames-irq: 0
>>
>> tx-usecs: 16
>> tx-frames: 32
>> tx-usecs-irq: 0
>> tx-frames-irq: 0
>> ```
>>
>> Previously a global `struct mlx5e_params` stored the options in
>> `struct mlx5e_priv.channels.params`. That was preserved, but a channel-
>> specific instance was added as well, in `struct mlx5e_channel.params`.
>>
>> Best Regards,
>>
>> ***************************************************************************
>>
>> Nabil S. Alramli (4):
>>    mlx5: Add mlx5e_param to individual mlx5e_channel and preserve them
>>      through mlx5e_open_channels()
>>    mlx5: Add queue number parameter to mlx5e_safe_switch_params()
> 
> We currently are working on a variation of this without needing to use
> mlx5e_safe_switch_params for updating individual channel states (our
> variation of the feature avoids needing to place an instance of
> mlx5e_params per channel).
> 

Oh I'm curious to see how this solution works. I look forward to your
upcoming patch, and would be happy to review it as well.

>>    mlx5: Implement mlx5e_ethtool_{get,set}_per_queue_coalesce() to
>>      support per-queue operations
>>    mlx5: Add {get,set}_per_queue_coalesce()
>>
>>   drivers/net/ethernet/mellanox/mlx5/core/en.h  |   6 +-
>>   .../ethernet/mellanox/mlx5/core/en_dcbnl.c    |   2 +-
>>   .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 214 +++++++++++++-----
>>   .../net/ethernet/mellanox/mlx5/core/en_main.c |  76 +++++--
>>   .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |   2 +-
>>   5 files changed, 222 insertions(+), 78 deletions(-)
> 
> --
> Thanks,
> 
> Rahul Rameshbabu

Best Regards,

-- Nabil S. Alramli

