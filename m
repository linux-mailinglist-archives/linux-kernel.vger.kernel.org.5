Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E2D7F0D25
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjKTIFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjKTIFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:05:53 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0806E8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:05:47 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so4252363b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700467547; x=1701072347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4NoqTxZnppS8i0nP/xGCXWB/hxXsx67zIl1hkFjXDo=;
        b=OGRyE6wZHDiPSa6gF4QXDy5G++VYIEFZkEWmeZEiaskWAB2wUBXtzA5uds46mPpmIB
         tOe9lhtEvqHdhC3ulemjpZKATvLGbU8hgBrIG5BVVwHGG2ZUNIuZQYotukauA/hBuIRG
         YptTDtk2RaTYWz51aEQzGQB18IalXh2sqC4SErvC7mZ+3fQwRJA42NBV3fQTU85VvVmv
         F7RoQe10E6yMVAKEEJcC5js3pXvwarz8J+wa5FW5c4E2S4VaqaBKERXUG+DhVfT2Urnp
         kRLqGRCEzdGsy85oOI2lKINxkTEKWq3ChqOIkRxk6eeU4aDNjhfThaO37pT2P9HxPaAA
         b44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700467547; x=1701072347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4NoqTxZnppS8i0nP/xGCXWB/hxXsx67zIl1hkFjXDo=;
        b=ks+v0PCdMiEMQ2uiCl30tXx1vcuU3VzALCZ4B3teJ0J9Xr5HqSoQCVGPPWxBeh3AFv
         /C6t01WOQr/pkz2EH8ih/BEb8cbgRXJ2Z0hBP2mz4VGBeLNC28La/qeOy6rrQo8pX8Ep
         1QfXHthGMKVHBPYMdAEvUujaLaFLUIQ2GsVwMmfUzHOlTjVV/fVWD/lL7QIgcdBUmfMR
         6xawiFXWU7A5Blk3JK4VWlvCE6HLyM/S/rh3w6GupmEhm8Wx6J0mx5IWLN8HoCKGz/V7
         te/no773U+JZusshLUOWWdYUbARdffamFConpcLh3ktAPQwkW0p4pPjGACayjtsXrhWR
         SAJA==
X-Gm-Message-State: AOJu0YxvOvQGZeo0KSDEfM1r3FN145m/+nB/sCGg0nJ5RNj0xdHgISOA
        9GGt43z7Iw2OVS9RUm+A1xRRaA==
X-Google-Smtp-Source: AGHT+IGssdhQXa2d+roUN7IT+TTU6LwlrMuPiMYOCQM48dnmpaA4XEU9k505dahywkNiyYYGiT6THg==
X-Received: by 2002:a05:6a00:80a:b0:6cb:910a:c6fe with SMTP id m10-20020a056a00080a00b006cb910ac6femr3670261pfk.7.1700467547194;
        Mon, 20 Nov 2023 00:05:47 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
        by smtp.gmail.com with ESMTPSA id f32-20020a056a000b2000b006c5da63556dsm5673415pfu.178.2023.11.20.00.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 00:05:46 -0800 (PST)
Message-ID: <a1f09866-a443-4f74-8025-6cdb32eb1d2c@daynix.com>
Date:   Mon, 20 Nov 2023 17:05:40 +0900
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
Content-Language: en-US
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAPhsuW5KLgt_gsih7zi+T99iYVbt7hk7=OCwYzin-H3=OhF54Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/20 6:02, Song Liu wrote:
> On Sun, Nov 19, 2023 at 12:03 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
> [...]
>>
>> Unfortunately no. The communication with the userspace can be done with
>> two different means:
>> - usual socket read/write
>> - vhost for direct interaction with a KVM guest
>>
>> The BPF map may be a valid option for socket read/write, but it is not
>> for vhost. In-kernel vhost may fetch hash from the BPF map, but I guess
>> it's not a standard way to have an interaction between the kernel code
>> and a BPF program.
> 
> I am very new to areas like vhost and KVM. So I don't really follow.
> Does this mean we have the guest kernel reading data from host eBPF
> programs (loaded by Qemu)?

Yes, the guest will read hashes calculated by the host, and the 
interface is strictly defined with the virtio-net specification.

> 
>>>
>>>>
>>>> Unfortunately, however, it is not acceptable for the BPF subsystem
>>>> because the "stable" BPF is completely fixed these days. The
>>>> "unstable/kfunc" BPF is an alternative, but the eBPF program will be
>>>> shipped with a portable userspace program (QEMU)[1] so the lack of
>>>> interface stability is not tolerable.
>>>
>>> bpf kfuncs are as stable as exported symbols. Is exported symbols
>>> like stability enough for the use case? (I would assume yes.)
>>>
>>>>
>>>> Another option is to hardcode the algorithm that was conventionally
>>>> implemented with eBPF steering program in the kernel[2]. It is possible
>>>> because the algorithm strictly follows the virtio-net specification[3].
>>>> However, there are proposals to add different algorithms to the
>>>> specification[4], and hardcoding the algorithm to the kernel will
>>>> require to add more UAPIs and code each time such a specification change
>>>> happens, which is not good for tuntap.
>>>
>>> The requirement looks similar to hid-bpf. Could you explain why that
>>> model is not enough? HID also requires some stability AFAICT.
>>
>> I have little knowledge with hid-bpf, but I assume it is more like a
>> "safe" kernel module; in my understanding, it affects the system state
>> and is intended to be loaded with some kind of a system daemon. It is
>> fine to have the same lifecycle with the kernel for such a BPF program;
>> whenever the kernel is updated, the distributor can recompile the BPF
>> program with the new kernel headers and ship it along with the kernel
>> just as like a kernel module.
>>
>> In contrast, our intended use case is more like a normal application.
>> So, for example, a user may download a container and run QEMU (including
>> the BPF program) installed in the container. As such, it is nice if the
>> ABI is stable across kernel releases, but it is not guaranteed for
>> kfuncs. Such a use case is already covered with the eBPF steering
>> program so I want to maintain it if possible.
> 
> TBH, I don't think stability should be a concern for kfuncs used by QEMU.
> Many core BPF APIs are now implemented as kfuncs: bpf_dynptr_*,
> bpf_rcu_*, etc. As long as there are valid use cases,these kfuncs will
> be supported.

Documentation/bpf/kfuncs.rst still says:
 > kfuncs provide a kernel <-> kernel API, and thus are not bound by any
 > of the strict stability restrictions associated with kernel <-> user
 > UAPIs.

Is it possible to change the statement like as follows:
"Most kfuncs provide a kernel <-> kernel API, and thus are not bound by 
any of the strict stability restrictions associated with kernel <-> user
UAPIs. kfuncs that have same stability restrictions associated with 
UAPIs are exceptional, and must be carefully reviewed by subsystem (and 
BPF?) maintainers as any other UAPIs are."

Regards,
Akihiko Odaki
