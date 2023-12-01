Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131D1800615
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377848AbjLAInI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLAInG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:43:06 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEAB1712
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:42:49 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5c637e83915so225410a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 00:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701420169; x=1702024969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BektOburQXG+cnVes1gG9CvIvVklrxBOP0251luLyc=;
        b=kHYsiKrj19n2T9Kt0FmcQ0QcDbtiHorBeZoHw5NhUJoKIz09o3vkNMQ2QNq9U/323u
         QdyJ8WGL9kY+CTx4572elOksuM/z5ekEeqeAVdRFdmWbxAnlumlBmJXsdmpoPUGOdJhR
         Yxef/EEZy8gKa1WBikMrAC3cvQbbgOlTjs9M5XkyQr0TflQW0vvoxhEDIsQVvBSIZ94G
         4gY/T7aW0bM1KnobZeNuckOYqc68QLS84MGmrEgPowJWd2kF3wyLolNyKh0123zp+Ov0
         IjZfY3jl9oTPTnLVxWHiTupaNUJSq3nYsc4vGfZiFxvGNUSsZPbhLC7rvtE7OdHekS/8
         4Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701420169; x=1702024969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+BektOburQXG+cnVes1gG9CvIvVklrxBOP0251luLyc=;
        b=R5oFYfDlilq6DmVks/AV/JHlGzybRHnQcKd2Xr9ZDY7S96wHz31rzUAAn48xeYVOnc
         eMHSayUuVzVu5PN0+pH2N9P5FNQ0sdp7qR+9VJ6kjErZPZS1oVqp0owqAqNQPerW5Tlq
         I/JAQsQ+tuej7IDZwvNS/9eSkdmf7pRkcB+i09TP0bI7rmbD/taUl/Olnv2vaSvjNqwK
         GxXPH98wzRKa+BlqZjEqrlQbyJip8Zdzg9oROJuT6tmRHw3QnZqXYeE1jeY2czUAT2ok
         ZBQ//P8W0IlvvO4hohTobEL39Qy8inBypmqyYwRqpPo9hZOVHQA9kcm5IpWBCuFdzPRU
         Fg9g==
X-Gm-Message-State: AOJu0YxkOkouR6kRQczRKFXTIQ436KYtmTgfHHt+UXWwRP/K5pc+pZwz
        Z7ZdGSTO1UISc1g7mon9NJjs8Q==
X-Google-Smtp-Source: AGHT+IHQlZQSaiA1mjh+Q6JoSIYJ8AxSKOD+/HgFMegaxFy19UtbZ/j6lBZcz5IClhqCixQds2+CYQ==
X-Received: by 2002:a17:90b:3a90:b0:285:8cb6:6153 with SMTP id om16-20020a17090b3a9000b002858cb66153mr33062567pjb.17.1701420168679;
        Fri, 01 Dec 2023 00:42:48 -0800 (PST)
Received: from [10.84.154.115] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfba9dac6esm2770341plg.115.2023.12.01.00.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 00:42:48 -0800 (PST)
Message-ID: <57587b74-f865-4b56-8d65-a5cbc6826079@bytedance.com>
Date:   Fri, 1 Dec 2023 16:42:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH bpf-next] netkit: Add some ethtool ops to provide
 information to user
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Nikolay Aleksandrov <razor@blackwall.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
        wangdongdong.6@bytedance.com, tangchen.1@bytedance.com
References: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
 <51dd35c9-ff5b-5b11-04d1-9a5ae9466780@blackwall.org>
 <16b4d42d-2d62-460e-912f-6e3b86f3004d@bytedance.com>
 <94e335d4-ec90-ba78-b2b4-8419b25bfa88@iogearbox.net>
From:   Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <94e335d4-ec90-ba78-b2b4-8419b25bfa88@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/11/30 18:56, Daniel Borkmann 写道:
> On 11/30/23 10:24 AM, Feng Zhou wrote:
>> 在 2023/11/30 17:06, Nikolay Aleksandrov 写道:
>>> On 11/30/23 09:58, Feng zhou wrote:
>>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>>
>>>> Add get_strings, get_sset_count, get_ethtool_stats to get peer
>>>> ifindex.
>>>> ethtool -S nk1
>>>> NIC statistics:
>>>>       peer_ifindex: 36
>>>>
>>>> Add get_link, get_link_ksettings to get link stat.
>>>> ethtool nk1
>>>> Settings for nk1:
>>>>     ...
>>>>     Link detected: yes
>>>>
>>>> Add get_ts_info.
>>>> ethtool -T nk1
>>>> Time stamping parameters for nk1:
>>>> ...
>>>>
>>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>> ---
>>>>   drivers/net/netkit.c | 53 
>>>> ++++++++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 53 insertions(+)
>>>>
>>>
>>> Hi,
>>> I don't see any point in sending peer_ifindex through ethtool, even
>>> worse through ethtool stats. That is definitely the wrong place for it.
>>> You can already retrieve that through netlink. About the speed/duplex
>>> this one makes more sense, but this is the wrong way to do it.
>>> See how we did it for virtio_net (you are free to set speed/duplex
>>> to anything to please bonding for example). Although I doubt anyone 
>>> will use netkit with bonding, so even that is questionable. :)
>>>
>>> Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
>>
>> We use netkit to replace veth to improve performance, veth can be used 
>> ethtool -S veth to get peer_ifindex, so this part is added, as long as 
>> it is to keep the netkit part and veth unified, to ensure the same 
>> usage habits, and to replace it without perception.
> 
> Could you elaborate some more on the use case why you need to retrieve it
> via ethtool, what alternatives were tried and don't work?
> 
> Please also elaborate on the case for netkit_get_link_ksettings() and which
> concrete problem you are trying to address with this extension?
> 
> The commit message only explains what is done but does not go into the 
> detail
> of _why_ you need it.
> 
> Thanks,
> Daniel

In general, this information can be obtained through ip commands or 
netlink, and netkit_get_link_ksettings really not necessary. The reason 
why ethtool supports this is that when we use veth, our business 
colleagues are used to using ethtool to obtain peer_ifindex, and then 
replace netkit, found that it could not be used, resulting in their 
script failure, so they asked us for a request.


