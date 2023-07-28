Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C14176608E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjG1AMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjG1AMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:12:10 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6FEA3;
        Thu, 27 Jul 2023 17:12:09 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3476c902f2aso6554385ab.3;
        Thu, 27 Jul 2023 17:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690503128; x=1691107928;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwOH31B9YC5Qq5eOuM4YDVXxICyCI8qLiMY5d30rtYA=;
        b=n2svxsWY7nhs+X7iL+CNV93rlxWXNy8DKhBsequbKHAsWICSwP9FHUrAUJqaCYGqdZ
         wMG5TLcsHWxov44VFlACkqXYZf0Im5U6wzer0OkeVQL5jTmxjbLc8QOmMtTHnlglJWjK
         BlAe6JF6UpTB1DkdymKkPrMqx5kfyiuAgNQcK2EBLY+Ol/SqolHAWDU0qLdhLuVz+vOZ
         rFQfLnfPnEDmJNFHrCM7SIh7qMYecY4LKDB7dqIfDPMd9d2VGj5PLlmhDyDNCQgQiav/
         dNoA2nTMiBSaIoU2wxqZQnzSH8tAH95bstJsrsnwdL2WSVT++r/jA28D2S7e3pZllAmF
         dKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690503128; x=1691107928;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwOH31B9YC5Qq5eOuM4YDVXxICyCI8qLiMY5d30rtYA=;
        b=MkPndtYYcbtGagbGTmW+HbKoeMFcey74q9OaIiUruGh4UviRxFu1MkOorMe6v+coER
         AsdL2lsmoT+D/HvtJLgk5UgpJnR+rtZ1AkRCo2CYeA7uZXluCbvuDsIRA/svBYLvgjWN
         10om7ApToGEGCF7hC7nOVBPomk5DAuZ3N4rumiJsFbHHjJF0Ychv/AJNMs2qa3GFw4EJ
         hneVW05htnkMeXUQ8MZred3Nl/Zep3tU6OBqq2VJGmptz0VfJaYcKmQS3PnnbdxFuk5g
         TAcloNlTb6zsMbdyIG7Ejd/JJMETg/F/IGNJB3Wy5nGAjpUYsYSnxN6NxEnyV+tmU4n3
         y4Xw==
X-Gm-Message-State: ABy/qLZ0D8+fuAM9Q5nlTEJDCX4nJ36akst7cEK5R2vuMPOGQtStlpl/
        IhKUa2DXv8a8WgkJAj6opoE=
X-Google-Smtp-Source: APBJJlFBi8MzPqGS4a5G0CvRMP10AO7jeswih1bVJor5eo3HO+kmYkNCU1XCNo4FpUvOF4Sa3MGFQw==
X-Received: by 2002:a05:6e02:1ba5:b0:348:f6cb:e585 with SMTP id n5-20020a056e021ba500b00348f6cbe585mr1175069ili.30.1690503128696;
        Thu, 27 Jul 2023 17:12:08 -0700 (PDT)
Received: from ?IPV6:2601:282:800:7ed0:211e:b7c4:92fe:76f4? ([2601:282:800:7ed0:211e:b7c4:92fe:76f4])
        by smtp.googlemail.com with ESMTPSA id v18-20020a92c6d2000000b00348cc29117esm829376ilm.34.2023.07.27.17.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 17:12:01 -0700 (PDT)
Message-ID: <cf1ef905-fa48-df3a-2d3c-37d7a1e79b8e@gmail.com>
Date:   Thu, 27 Jul 2023 18:11:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3] drivers: net: prevent tun_get_user() to exceed xdp
 size limits
Content-Language: en-US
To:     Andrew Kanner <andrew.kanner@gmail.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
        brouer@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
        John Fastabend <john.fastabend@gmail.com>
References: <20230725155403.796-1-andrew.kanner@gmail.com>
 <CACGkMEt=Cd8J995+0k=6MT1Pj=Fk9E_r2eZREptLt2osj_H-hA@mail.gmail.com>
 <ab722ec1-ae45-af1f-b869-e7339402c852@redhat.com>
 <179979e6-eb8a-0300-5445-999b9366250a@gmail.com>
 <0c06b067-349c-9fe2-2cc3-36c149fd5277@gmail.com>
 <CACGkMEsYzd1FphP-Ym9T9YjA9ZNBw7Mnw5xQ75dytQMJxDK3cg@mail.gmail.com>
 <220fc36ba1086c1390ba087d08561b61762c965a.camel@redhat.com>
 <3659ea35-8d03-aae7-53c0-09181bb1b69d@redhat.com>
 <64c30249.2e0a0220.f779a.1c31@mx.google.com>
From:   David Ahern <dsahern@gmail.com>
In-Reply-To: <64c30249.2e0a0220.f779a.1c31@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 5:48 PM, Andrew Kanner wrote:
> 
> Thanks, everyone.
> 
> If we summarize the discussion - there are 3 issues here:
> 1. tun_can_build_skb() doesn't count XDP_PACKET_HEADROOM (minor and
>    most trivial)
> 2. WARN_ON_ONCE from net/core/filter.c, which may be too strict / not
>    needed at all.
> 3. strange behaviour with reallocationg SKB (65007 -> 131072)

I believe that happens because of the current skb size and the need to
expand it to account for the XDP headroom makes the allocation go over
64kB. Since tun is given the packet via a write call there are no header
markers to allocate separate space for headers and data (e.g. like TCP
does with 32kB data segments).

> 
> I can check these issues. I have to dive a little deeper with 2-3,
> most likely with kgdb and syzkaller repro. But seems this is not
> somewhat urgent and lives quite a long time without being noticed.
> 
> BTW: Attached the ftrace logs using the original syzkaller repro
> (starting with tun_get_user()). They answer Jesper's question about
> contiguous physical memory allocation (kmem_cache_alloc_node() /
> kmalloc_reserve()). But I'll check it one more time before submitting
> a new PATCH V4 or another patch / patch series.
> 

