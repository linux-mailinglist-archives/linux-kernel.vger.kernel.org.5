Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5FA7FEBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjK3JYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3JY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:24:28 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341A0BD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:24:12 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c21e185df5so585761a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701336251; x=1701941051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODGxd7/u71d/rY/1QUl5tXlqtMzlubsqrETh3ZFBIzc=;
        b=UUks07+cN6WPU+Lhz+jl8Ma+nNwYywdE99+qa7HjaTsNJimsVx0/8GBu1sm0fshzUY
         hPF9tRyE3bvdvhBG3AtCnFf8w99n/hGyDLYNZ+usmZcDZzOx4N1gEdkzOAe+z/bq5cyo
         LHAdlRQWuGva8NqWHaHPGUAU/YjM3ylTY3z/yMioGqGk5zFahPwLwi5T2f27XxsuOMPd
         l9VtUIGlZhX8FgnhHH78RUBFKYvAkbKYGTJ+C+sY09IohPcvOBDUQxCpfjQPFAvsxJyk
         pBD0BpQRibAkzihXWD5Pgh9meVfyhasD6Zq50mToidNbTgm3Fbo/Xnp1rhCzcfkmApUZ
         2h7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336251; x=1701941051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ODGxd7/u71d/rY/1QUl5tXlqtMzlubsqrETh3ZFBIzc=;
        b=fcHQRv8Jv9n+6mEihH/6dimeI7R9gW7JhFBdgre8CykAqLyREBfdFW/kTSEPN+sZ0e
         NPywLXImh7cqh7ti6WI0Xx35UYsOUaV/a8oaHwptgkdVw3A5KFqjy78c7QJ45IkhZePb
         maTcWBMIO662f8JstJLTHoKK7Iex74RQR0VmakLpqruEmXR7tyoyXJtCb00Uv1+WatSV
         eVXlpiOZeQgfodHPeaMfRfC+PZDFHWQxjR+3VUHI1h4LF2xYRAP+DvmbQA8+fhg5iA7n
         nAge7p8pB/KZMEasRO0xvgqoiR5NxgXUjgUBo0cmTLGwSOY5c0WuOKug4xe1JFbmb3Pm
         PpfQ==
X-Gm-Message-State: AOJu0Yz64ZMgsLd+zGqxHjHAUpN1z1wjbHhqDAbaPmbUakxcU/J8UOzs
        IixYW6E3efcV8XnKvEPn8ryEnw==
X-Google-Smtp-Source: AGHT+IGvtcp1PgtnVJr+WQ8C2U2NNcXXrpY/qCKSZGSEOFUMfOPyOa8gDqmrc3Yr78UCV+DX5EsG/Q==
X-Received: by 2002:a05:6a21:a58d:b0:18b:d99a:99bd with SMTP id gd13-20020a056a21a58d00b0018bd99a99bdmr25455213pzc.32.1701336251730;
        Thu, 30 Nov 2023 01:24:11 -0800 (PST)
Received: from [10.84.152.108] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id u8-20020a17090282c800b001cfc1b93179sm18516plz.232.2023.11.30.01.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:24:11 -0800 (PST)
Message-ID: <16b4d42d-2d62-460e-912f-6e3b86f3004d@bytedance.com>
Date:   Thu, 30 Nov 2023 17:24:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH bpf-next] netkit: Add some ethtool ops to
 provide information to user
To:     Nikolay Aleksandrov <razor@blackwall.org>, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
        wangdongdong.6@bytedance.com, tangchen.1@bytedance.com
References: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
 <51dd35c9-ff5b-5b11-04d1-9a5ae9466780@blackwall.org>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <51dd35c9-ff5b-5b11-04d1-9a5ae9466780@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/11/30 17:06, Nikolay Aleksandrov 写道:
> On 11/30/23 09:58, Feng zhou wrote:
>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>
>> Add get_strings, get_sset_count, get_ethtool_stats to get peer
>> ifindex.
>> ethtool -S nk1
>> NIC statistics:
>>       peer_ifindex: 36
>>
>> Add get_link, get_link_ksettings to get link stat.
>> ethtool nk1
>> Settings for nk1:
>>     ...
>>     Link detected: yes
>>
>> Add get_ts_info.
>> ethtool -T nk1
>> Time stamping parameters for nk1:
>> ...
>>
>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>> ---
>>   drivers/net/netkit.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
> 
> Hi,
> I don't see any point in sending peer_ifindex through ethtool, even
> worse through ethtool stats. That is definitely the wrong place for it.
> You can already retrieve that through netlink. About the speed/duplex
> this one makes more sense, but this is the wrong way to do it.
> See how we did it for virtio_net (you are free to set speed/duplex
> to anything to please bonding for example). Although I doubt anyone will 
> use netkit with bonding, so even that is questionable. :)
> 
> Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> Cheers,
>   Nik
> 

We use netkit to replace veth to improve performance, veth can be used 
ethtool -S veth to get peer_ifindex, so this part is added, as long as 
it is to keep the netkit part and veth unified, to ensure the same usage 
habits, and to replace it without perception.


