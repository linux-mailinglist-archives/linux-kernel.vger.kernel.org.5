Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A7779C7AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjILHGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjILHGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:06:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738B4E78;
        Tue, 12 Sep 2023 00:06:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52e5900cf77so6718441a12.2;
        Tue, 12 Sep 2023 00:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694502376; x=1695107176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMy6jSxlLVQzjvcfRtLq3NXvZdu60RtRCF9sxWo1nvI=;
        b=qu8X3W77nsScShedTZusX8trRA3CnpfiKuCZuHnxxWufwiVeNClOfzqICjNzo0fPWB
         lotDfW3w8GruAjlxTLIP04sCBlhPY4RrQ9bU84n5UMrlbMuPcz9vyDmEQtaXx2sVOCYF
         cMuvWcC5Sfl24sUiGAC+aCEsHvaR6k4BFhvlaEwMnxobkxcKTK/4srD3KKGL0rjKoN1Q
         521lWiLBytGGaAi7X21Cy/WKX01d7tBnBZyvVRA+8Sy4+F0CNksU5g5S7vaCrFBUiQSc
         5rnzy+/nt+SOyqtxtUg8VHOBrrAqljKT46wvxo9+yJYU40XUV9tSataXNO8BdHTp4f5Q
         TXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502376; x=1695107176;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMy6jSxlLVQzjvcfRtLq3NXvZdu60RtRCF9sxWo1nvI=;
        b=fO7AYh2AZgGhuVstmzAABNkYGOkFYhZ72vWw/pRYvVCuteT+jV5HjIjze3WGfwj2FR
         fRn+4/Tc1MWJoRoaQXFd6lOVCwEWxql3bBibZz0UHTkZuOTt5ESKCYtEMkqxBMeYf6L8
         jtlkG4LqrYHmlDV36uAWXNuKg3DJ8sXdW/WxNrMDLCwGJMbnf8jLdzqT/jb/lg8tQ0NL
         Pgp64dc3pdh4NNMrk8eQzDbrYbZ9BdlAhmDXZIDGjyFd+OqnGtQXYHnzs5PjT67ixVhD
         8Pa4glCEGgG+wCbJTDLiHB5QDnhZy92IF6kJKlj3JIJsheY5sLEWevNU3wvfRNJ4IelO
         YG5Q==
X-Gm-Message-State: AOJu0YwSV76pLyGmhkWJU57N8ESkA0GGiXxlwYF15yJuawDiWzKnS+Bn
        2Ay1vx4RKjtgfSGvoGlwF1M=
X-Google-Smtp-Source: AGHT+IEOrMxMs1WFBCbVhLR01bYFYeYSawxe090qODnBi4upxpLOi7jNd1Rrxbto/3+X6VvKL39rYA==
X-Received: by 2002:a17:906:8b:b0:9a1:d7cd:6040 with SMTP id 11-20020a170906008b00b009a1d7cd6040mr9828714ejc.37.1694502375674;
        Tue, 12 Sep 2023 00:06:15 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.42])
        by smtp.gmail.com with ESMTPSA id p21-20020a170906b21500b0099b6becb107sm6415474ejz.95.2023.09.12.00.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:06:15 -0700 (PDT)
Message-ID: <23e71d1f-08c1-3834-5b1f-2b5714c7bfaa@gmail.com>
Date:   Tue, 12 Sep 2023 09:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/9] dma-heap: Provide accessors so that in-kernel drivers
 can allocate dmabufs from specific heaps
Content-Language: en-US
To:     John Stultz <jstultz@google.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>, tjmercier@google.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jianjiao.zeng@mediatek.com,
        kuohong.wang@mediatek.com
References: <20230911023038.30649-1-yong.wu@mediatek.com>
 <20230911023038.30649-4-yong.wu@mediatek.com>
 <803846bc-fd1d-d2ec-2855-456af22c82f8@amd.com>
 <CANDhNCrQyiFZ+8DnG0iyKBXC0H1698K1a9d2AxOq4whDsZBn+Q@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CANDhNCrQyiFZ+8DnG0iyKBXC0H1698K1a9d2AxOq4whDsZBn+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.09.23 um 20:29 schrieb John Stultz:
> On Mon, Sep 11, 2023 at 3:14 AM Christian König
> <christian.koenig@amd.com> wrote:
>> Am 11.09.23 um 04:30 schrieb Yong Wu:
>>> From: John Stultz <jstultz@google.com>
>>>
>>> This allows drivers who don't want to create their own
>>> DMA-BUF exporter to be able to allocate DMA-BUFs directly
>>> from existing DMA-BUF Heaps.
>>>
>>> There is some concern that the premise of DMA-BUF heaps is
>>> that userland knows better about what type of heap memory
>>> is needed for a pipeline, so it would likely be best for
>>> drivers to import and fill DMA-BUFs allocated by userland
>>> instead of allocating one themselves, but this is still
>>> up for debate.
>> The main design goal of having DMA-heaps in the first place is to avoid
>> per driver allocation and this is not necessary because userland know
>> better what type of memory it wants.
>>
>> The background is rather that we generally want to decouple allocation
>> from having a device driver connection so that we have better chance
>> that multiple devices can work with the same memory.
> Yep, very much agreed, and this is what the comment above is trying to describe.
>
> Ideally user-allocated buffers would be used to ensure driver's don't
> create buffers with constraints that limit which devices the buffers
> might later be shared with.
>
> However, this patch was created as a hold-over from the old ION logic
> to help vendors transition to dmabuf heaps, as vendors had situations
> where they still wanted to export dmabufs that were not to be
> generally shared and folks wanted to avoid duplication of logic
> already in existing heaps.  At the time, I never pushed it upstream as
> there were no upstream users.  But I think if there is now a potential
> upstream user, it's worth having the discussion to better understand
> the need.

Yeah, that indeed makes much more sense.

When existing drivers want to avoid their own handling and move their 
memory management over to using DMA-heaps even for internal allocations 
then no objections from my side. That is certainly something we should 
aim for if possible.

But what we should try to avoid is that newly merged drivers provide 
both a driver specific UAPI and DMA-heaps. The justification that this 
makes it easier to transit userspace to the new UAPI doesn't really count.

That would be adding UAPI already with a plan to deprecate it and that 
is most likely not helpful considering that UAPI must be supported 
forever as soon as it is upstream.

> So I think this patch is a little confusing in this series, as I don't
> see much of it actually being used here (though forgive me if I'm
> missing it).
>
> Instead, It seems it get used in a separate patch series here:
>    https://lore.kernel.org/all/20230911125936.10648-1-yunfei.dong@mediatek.com/

Please try to avoid stuff like that it is really confusing and eats 
reviewers time.

Regards,
Christian.

>
> Yong, I appreciate you sending this out! But maybe if the secure heap
> submission doesn't depend on this functionality, I might suggest
> moving this patch (or at least the majority of it) to be part of the
> vcodec series instead?  That way reviewers will have more context for
> how the code being added is used?
>
> thanks
> -john

