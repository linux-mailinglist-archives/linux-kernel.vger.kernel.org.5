Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC967642F0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjG0A1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjG0A1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:27:15 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA509100;
        Wed, 26 Jul 2023 17:27:14 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7835ae70e46so13933339f.3;
        Wed, 26 Jul 2023 17:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690417634; x=1691022434;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7g88EX3ElPzMHH1cxDZbT04edVSiNRVHvA7iXAYrAo=;
        b=f3H4vfeLylp2wg0nVMIywz+9PHn/KiSpcbldySF26DRn9AiUtEeBB5CkQJitGwEGKj
         5+mGkVG8SN4a05BWWSw67S9uT+IRrj9Rl+y/6sl3GTzp4tSHEzRFK66+RDz5xqhulEuz
         Hf4chdxIPAiC7+ba9o2axjXiPOoA8e8lb0YkWRMoQVMkWEPKfa6Jhgsb4b9ZF+wqTSgW
         HhN5FYEkXL2tkRrmctmcxQHBxrNJwZhneObt8vu7IqQhMzGa2Fix58MpS/CouPOcLmyo
         +LQV10zDWU4U49DYhoXS50330wNYor0r2MwB58UCJPg08YePkj/s/rdaRAZ0koKzL7zp
         5bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690417634; x=1691022434;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7g88EX3ElPzMHH1cxDZbT04edVSiNRVHvA7iXAYrAo=;
        b=SCuBItLu68uBRZRk51bRn48z5aNLLKJGBp8SnPlfrqbIp/UVYlNHpj2ZOkJXzkZqBf
         LXs3uEwzMCQ9WhUAn+a2+/J/LwEBRX/mibsLB4SrOp9jv3s5Mt2sT4xhtnQPWMZW2jZM
         GN49nPlvou3lvsPz8PSYyrxgJ8gRYTnF4vLK5c8qR7HhjLYv7XSXrJU/IVKB64VkGi74
         PPU5IY3x989z4kURqOZCtHFPdpJtAO2v7PMhiQrSvxfRQ7yap8S/aEMUdRU19RgS9HAq
         aC7BRpQ4wvxFuHp3z4mKRIP8War9N+DpUAEZiCKEoGluCjtF7kiEEX+wYqoTembccwVF
         SuSQ==
X-Gm-Message-State: ABy/qLbdBmuSl3Uycm9JpxfcakIScOqIJPjN9WG5j78YpMz32D8cGsoH
        96KulSwKhmeORN6pWHC0xLc=
X-Google-Smtp-Source: APBJJlFpcp26uwvnPQ3z9ha61DL/89HUSRq9ynlxFUpBBUyir6DJ+iZRgQvQTbgbjaz1GmQ4xAxT8w==
X-Received: by 2002:a05:6e02:1a85:b0:346:63f1:a979 with SMTP id k5-20020a056e021a8500b0034663f1a979mr3892802ilv.30.1690417634018;
        Wed, 26 Jul 2023 17:27:14 -0700 (PDT)
Received: from ?IPV6:2601:282:800:7ed0:bd1d:fe8d:d220:8378? ([2601:282:800:7ed0:bd1d:fe8d:d220:8378])
        by smtp.googlemail.com with ESMTPSA id y5-20020a92d805000000b0033b2a123254sm147546ilm.61.2023.07.26.17.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 17:27:13 -0700 (PDT)
Message-ID: <0c06b067-349c-9fe2-2cc3-36c149fd5277@gmail.com>
Date:   Wed, 26 Jul 2023 18:27:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3] drivers: net: prevent tun_get_user() to exceed xdp
 size limits
Content-Language: en-US
From:   David Ahern <dsahern@gmail.com>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Kanner <andrew.kanner@gmail.com>
Cc:     brouer@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
        John Fastabend <john.fastabend@gmail.com>
References: <20230725155403.796-1-andrew.kanner@gmail.com>
 <CACGkMEt=Cd8J995+0k=6MT1Pj=Fk9E_r2eZREptLt2osj_H-hA@mail.gmail.com>
 <ab722ec1-ae45-af1f-b869-e7339402c852@redhat.com>
 <179979e6-eb8a-0300-5445-999b9366250a@gmail.com>
In-Reply-To: <179979e6-eb8a-0300-5445-999b9366250a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 1:37 PM, David Ahern wrote:
> On 7/26/23 3:02 AM, Jesper Dangaard Brouer wrote:
>> Cc. John and Ahern
>>
>> On 26/07/2023 04.09, Jason Wang wrote:
>>> On Tue, Jul 25, 2023 at 11:54 PM Andrew Kanner
>>> <andrew.kanner@gmail.com> wrote:
>>>>
>>>> Syzkaller reported the following issue:
>>>> =======================================
>>>> Too BIG xdp->frame_sz = 131072
>>
>> Is this a contiguous physical memory allocation?
>>
>> 131072 bytes equal order 5 page.
>>
>> Looking at tun.c code I cannot find a code path that could create
>> order-5 skb->data, but only SKB with order-0 fragments.  But I guess it
>> is the netif_receive_generic_xdp() what will realloc to make this linear
>> (via skb_linearize())
> 
> 
> get_tun_user is passed an iov_iter with a single segment of 65007
> total_len. The alloc_skb path is hit with an align size of only 64. That
> is insufficient for XDP so the netif_receive_generic_xdp hits the
> pskb_expand_head path. Something is off in the math in
> netif_receive_generic_xdp resulting in the skb markers being off. That
> causes bpf_prog_run_generic_xdp to compute the wrong frame_sz.


BTW, it is pskb_expand_head that turns it from a 64kB to a 128 kB
allocation. But the 128kB part is not relevant to the "bug" here really.

The warn on getting tripped in bpf_xdp_adjust_tail is because xdp
generic path is skb based and can have a frame_sz > 4kB. That's what the
splat is about.

Perhaps the solution is to remove the WARN_ON.


