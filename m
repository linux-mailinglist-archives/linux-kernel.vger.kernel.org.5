Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D0C768BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjGaG0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjGaG0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BF01A3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690784727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AMHoeLetncmOF6knuHXAEkwDxdPPKbLQBWKiqJmYdTc=;
        b=IgqfqKVYTctAySzgkOwoMnbvx4Pr2r8W7JBhwzBXTvO6aESS6FkswMKxCvzGpAr6FYoUw3
        V+FrnQcwHcCQCoeJ6903viqMYTq56OkBVr2VFKQXtMw2Jwy8Xg4K0jb4jZBUjxzSE8cpEs
        Tu77uKEikpkkcGCUmkkOeYAAsML0g6s=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-nvuqLuQFPNm2Q35iCB0Lqg-1; Mon, 31 Jul 2023 02:25:26 -0400
X-MC-Unique: nvuqLuQFPNm2Q35iCB0Lqg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-686db2bb3eeso3235456b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690784725; x=1691389525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMHoeLetncmOF6knuHXAEkwDxdPPKbLQBWKiqJmYdTc=;
        b=Rdcj7yuwP1L0H/Cd/ZRNYOqj0Dj0irVIqMfYeEsRVjrNpBcTqErrpam4Yf27gC9iZu
         d07m3ihwTHodJe+w7Sthj7MGaoNKZLY6kcjBc6ootmQz+iYCjelIhkyF6KcKoHjKi3D9
         q1R6FH2aaMcSnetJe1aU8xVFFGczUDq3TOyfGcNxjn9qVAphYQIvy2sopiFfzuVtwDLj
         kPo7Psd4T3F4JMRVYmvCi4Thu2TTlGOMmhA4xvSYEqEeGwmgmbD2SuxBoezmnBe715gt
         OaW+kAvNLWZ5QL+hJlk3mt7Uzw4ulP7XLG3O8t4WpNEyE8UIMdZr+TUMhurPMjirXicX
         36Fg==
X-Gm-Message-State: ABy/qLaebjvfNEhQdCKkitppKcIUPabt7d+epMehk7yHMFev1jfDJhbn
        CD0agKK9FCIB+WpOOAfN61+BjS07+iQ2ilNnuZnI2NEy9GqyE3uF0nUgoEqUkSFQFmwTBxvSllv
        Klcw9Id41YZxOKappa2NkTbJw
X-Received: by 2002:a05:6a20:1614:b0:13a:12c2:359e with SMTP id l20-20020a056a20161400b0013a12c2359emr9170166pzj.2.1690784725061;
        Sun, 30 Jul 2023 23:25:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFhdNonBuhx20H74nszcdmRPVMO19vB0iyTVH6P4jjKCSyrny8LhZooWAfIJTGU+TRmQj5JDQ==
X-Received: by 2002:a05:6a20:1614:b0:13a:12c2:359e with SMTP id l20-20020a056a20161400b0013a12c2359emr9170152pzj.2.1690784724776;
        Sun, 30 Jul 2023 23:25:24 -0700 (PDT)
Received: from [10.72.112.185] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x25-20020a056a00271900b00653fe2d527esm6799503pfv.32.2023.07.30.23.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 23:25:24 -0700 (PDT)
Message-ID: <fd3457bc-b16a-680a-0bed-80cc8505a4cc@redhat.com>
Date:   Mon, 31 Jul 2023 14:25:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Gavin Li <gavinl@nvidia.com>, xuanzhuo@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com,
        gavi@nvidia.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Heng Qi <hengqi@linux.alibaba.com>
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-3-gavinl@nvidia.com>
 <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
 <20230728014601-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230728014601-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/7/28 13:46, Michael S. Tsirkin 写道:
> On Thu, Jul 27, 2023 at 03:28:32PM +0200, Paolo Abeni wrote:
>> On Tue, 2023-07-25 at 16:07 +0300, Gavin Li wrote:
>>> Add interrupt_coalesce config in send_queue and receive_queue to cache user
>>> config.
>>>
>>> Send per virtqueue interrupt moderation config to underlying device in
>>> order to have more efficient interrupt moderation and cpu utilization of
>>> guest VM.
>>>
>>> Additionally, address all the VQs when updating the global configuration,
>>> as now the individual VQs configuration can diverge from the global
>>> configuration.
>>>
>>> Signed-off-by: Gavin Li <gavinl@nvidia.com>
>>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> FTR, this patch is significantly different from the version previously
>> acked/reviewed, I'm unsure if all the reviewers are ok with the new
>> one.
>>
>> [...]
> still ok by me
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> let's wait for Jason too.


I'm fine with this series (I've acked each patch).

Thanks


>
>>>   static int virtnet_set_coalesce(struct net_device *dev,
>>>   				struct ethtool_coalesce *ec,
>>>   				struct kernel_ethtool_coalesce *kernel_coal,
>>>   				struct netlink_ext_ack *extack)
>>>   {
>>>   	struct virtnet_info *vi = netdev_priv(dev);
>>> -	int ret, i, napi_weight;
>>> +	int ret, queue_number, napi_weight;
>>>   	bool update_napi = false;
>>>   
>>>   	/* Can't change NAPI weight if the link is up */
>>>   	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
>>> -	if (napi_weight ^ vi->sq[0].napi.weight) {
>>> -		if (dev->flags & IFF_UP)
>>> -			return -EBUSY;
>>> -		else
>>> -			update_napi = true;
>>> +	for (queue_number = 0; queue_number < vi->max_queue_pairs; queue_number++) {
>>> +		ret = virtnet_should_update_vq_weight(dev->flags, napi_weight,
>>> +						      vi->sq[queue_number].napi.weight,
>>> +						      &update_napi);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		if (update_napi) {
>>> +			/* All queues that belong to [queue_number, queue_count] will be
>>> +			 * updated for the sake of simplicity, which might not be necessary
>> It looks like the comment above still refers to the old code. Should
>> be:
>> 	[queue_number, vi->max_queue_pairs]
>> 			
>> Otherwise LGTM, thanks!
>>
>> Paolo

