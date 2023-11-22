Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440BE7F3D63
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjKVFgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjKVFgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:36:44 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF14D12A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 21:36:39 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4885352a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 21:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700631399; x=1701236199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPmH0R/ZGatN6+UwwJY3MEok1l+rZDRi+gW+Psbpgp4=;
        b=em2DzhAjzA6+M6CAZujzfRwbEZCqdGSRYk74aXSfvrwfC9i0A5Oyz+J+5tXb6LB8dK
         pb1g2PGElnuo2VdvsfPqhH/zL4esxIz8rbH83DzmAT67TQcpdWYKKVZUIut7hb1C1Dbk
         SSU7+oZWwp6PD3mXy/vhPNk2gTDZAD15xboH/Ew9BYswQvTRf1/GEiDSNQyn9VaGj5b4
         uApyRPYUw0IJVUcMc8WuX08ZPTfmQ8+6n3cXr8qZCA5fJ6k/UaM5+Ibswq/4Y3EzKHvu
         R9g/W7fzIJjmilMuHgWda6NsgQYaM4/F5jzzQu3bTAx4UkOXhFHVQUVBoyK2tkqx17Ww
         LxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700631399; x=1701236199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPmH0R/ZGatN6+UwwJY3MEok1l+rZDRi+gW+Psbpgp4=;
        b=ChS7SK93vUZE03VaEx/Ao6iYWWpSH8SQQHFtqmedhgPMpXQTcOg84+q/M34f2Fc0C0
         0DN3LeKm2O+E7CnSNf3KoCdaweSeQ+ZS73w0zliHwCdCfYXS7BGvSiuOP2DirU22HnDQ
         eOEgeyy4Y30bcVQmkTjdqwRUNPGVMo3xRjY9akNbiU42WSGkX4wibomHlk1+LL6IGNVP
         cm900Ft4Qu/XtaqMiiUFA2tJ5H0USNXdF6h9VlIgCybPiOUqotUlyKlQz1L0cThui+Wh
         8SfAKcsDtimeJLRMCnLgYH7g/9yvQ3MLKm/w4hb8qkAXAPpglaCRbZ7WggynCYgZMyTh
         wt+Q==
X-Gm-Message-State: AOJu0Yw0fRqk3NgXbSWdINomEOsQGvUh9lDuPOltVXmDkxsXDNfzImM2
        BE6igz+OzVBb8ePAnDhNKQB3nw==
X-Google-Smtp-Source: AGHT+IE67Eq9oO1uEot/zjxOXNvgyCk21nCZbXVKotApAyu3bet6Avb8lU17DWWWT9joNIuvOnZhJw==
X-Received: by 2002:a05:6a20:8f1d:b0:17a:e941:b0a3 with SMTP id b29-20020a056a208f1d00b0017ae941b0a3mr1395905pzk.39.1700631399364;
        Tue, 21 Nov 2023 21:36:39 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
        by smtp.gmail.com with ESMTPSA id gj13-20020a17090b108d00b002839a4f65c5sm454781pjb.30.2023.11.21.21.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 21:36:39 -0800 (PST)
Message-ID: <664003d3-aadb-4938-80f6-67fab1c9dcdd@daynix.com>
Date:   Wed, 22 Nov 2023 14:36:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] bpf: Introduce BPF_PROG_TYPE_VNET_HASH
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Yuri Benditovich <yuri.benditovich@daynix.com>,
        Andrew Melnychenko <andrew@daynix.com>
References: <20231015141644.260646-1-akihiko.odaki@daynix.com>
 <20231015141644.260646-2-akihiko.odaki@daynix.com>
 <CAADnVQLfUDmgYng8Cw1hiZOMfWNWLjbn7ZGc4yOEz-XmeFEz5Q@mail.gmail.com>
 <2594bb24-74dc-4785-b46d-e1bffcc3e7ed@daynix.com>
 <CAADnVQ+J+bOtvEfdvgUse_Rr07rM5KOZ5DtAmHDgRmi70W68+g@mail.gmail.com>
 <CACGkMEs22078F7rSLEz6eQabkZZ=kujSONUNMThZz5Gp=YiidQ@mail.gmail.com>
 <CAADnVQLt8NWvP8qGWMPx=12PwWWE69P7aS2dbm=khAJkCnJEoQ@mail.gmail.com>
 <9a4853ad-5ef4-4b15-a49e-9edb5ae4468e@daynix.com>
 <6253fb6b-9a53-484a-9be5-8facd46c051e@daynix.com>
 <CAPhsuW5JYoM-Mkehdy=FQsG1nvjbYGzwRZx8BkpG1P7cHdD=eQ@mail.gmail.com>
 <dba89d4b-84aa-4c9f-b016-56fd3ade04b2@daynix.com>
 <CAPhsuW5KLgt_gsih7zi+T99iYVbt7hk7=OCwYzin-H3=OhF54Q@mail.gmail.com>
 <a1f09866-a443-4f74-8025-6cdb32eb1d2c@daynix.com>
 <CAPhsuW4o5o41a+jVjgGP+Ck3eUD8w6coLXMTYewXKJYmciLLnQ@mail.gmail.com>
Content-Language: en-US
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAPhsuW4o5o41a+jVjgGP+Ck3eUD8w6coLXMTYewXKJYmciLLnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/22 14:25, Song Liu wrote:
> On Mon, Nov 20, 2023 at 12:05 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/11/20 6:02, Song Liu wrote:
> [...]
>>>> In contrast, our intended use case is more like a normal application.
>>>> So, for example, a user may download a container and run QEMU (including
>>>> the BPF program) installed in the container. As such, it is nice if the
>>>> ABI is stable across kernel releases, but it is not guaranteed for
>>>> kfuncs. Such a use case is already covered with the eBPF steering
>>>> program so I want to maintain it if possible.
>>>
>>> TBH, I don't think stability should be a concern for kfuncs used by QEMU.
>>> Many core BPF APIs are now implemented as kfuncs: bpf_dynptr_*,
>>> bpf_rcu_*, etc. As long as there are valid use cases,these kfuncs will
>>> be supported.
>>
>> Documentation/bpf/kfuncs.rst still says:
>>   > kfuncs provide a kernel <-> kernel API, and thus are not bound by any
>>   > of the strict stability restrictions associated with kernel <-> user
>>   > UAPIs.
>>
>> Is it possible to change the statement like as follows:
>> "Most kfuncs provide a kernel <-> kernel API, and thus are not bound by
>> any of the strict stability restrictions associated with kernel <-> user
>> UAPIs. kfuncs that have same stability restrictions associated with
>> UAPIs are exceptional, and must be carefully reviewed by subsystem (and
>> BPF?) maintainers as any other UAPIs are."
> 
> I am afraid this is against the intention to not guarantee UAPI-level stability
> for kfuncs.

Is it possible to ensure that a QEMU binary with the eBPF program 
included works on different kernel versions without UAPI-level stability 
then? Otherwise, I think we need to think of the minimal UAPI addition 
that exposes the feature I propose, and the two options I presented 
first are the candidates of such: the stable BPF change or tuntap 
interface change.

Regards,
Akihiko Odaki
