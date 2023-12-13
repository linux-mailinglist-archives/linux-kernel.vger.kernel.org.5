Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C6810E26
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjLMKPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjLMKPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:15:49 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E2CAC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:15:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1f8f470903so464119066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702462554; x=1703067354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m71FV5vGmPVywWzxoFuxmmARDOatcoG5xbVNtimxsKM=;
        b=PqjWfS0J0LTq1aRD/+QxD77CcgJqq0x1kPEoUfQTOrYeSNEH9TyCrmOI35mB2kihcB
         LtZYQoj/x4jpLOhf0wmfAMdoa3gljesec2sZ4bpSSZsYv2B8BVW5fjEZbKAktmMRnedk
         bK4EWVell39DNEmYIIoyg/cmxP3XAmS8h4wRjFkD+lGxm2lE6RxBsJOSIigTVHOYGzSQ
         h0avvBLvvPWuPwU5NgfAzOVMcuarh4nO9lJ0fRmXzXI90FZEjXEQnT3QcdYDLqoW2ysA
         aFBge+wfUzXSoIatSBkEivrAEST2TQYsDD/YQ87mZImKw5fQsIvdmmCxBISg3uDLKjg5
         /VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702462554; x=1703067354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m71FV5vGmPVywWzxoFuxmmARDOatcoG5xbVNtimxsKM=;
        b=JwJaDj8t/lSMH7yZgHP/tFVoE5NxTwRLEx4k/La50B1zBT+xaoMrg3CwYZO4we9E/6
         UoGmZEShQv9+/prJcTTtHbQtDQxcZs97uQYoBhtALBxISK5sfCxHgwd2S0zhfGc5fD+3
         j7Yh9r6vL9VobdOu4v/BfW3Po9q1bo1aBazBGNgudILWsnrMYsAf4H96gh/5ZPeuagVe
         c5MfPHYz8vvvFPTDs5R43ddAYW8w5lFOjpeN8pSSkPFiwsJyGYzs95P6ZwycECS+qNId
         O1rgmtTjH8p4BH+TtGc2+fxWTM/hzo8TyoNSh2vua+J7D3wTVcOCAYqZFAsxde5xKumB
         xk3w==
X-Gm-Message-State: AOJu0YzE86jSHJSkxvtS3rMq7IV+xxAzqPzNJTbfRRoLxaKSs6//fXs1
        XJdzhRnRdTIKGa94XxmLV60f5w==
X-Google-Smtp-Source: AGHT+IFLhx9mrchCh5E2ylqHbgPhyi2ITVUtOX/P4qGORrsYs/M4rF8Vci+B58KQG68twiIyDl6XRw==
X-Received: by 2002:a17:907:9905:b0:a1c:f745:e0b3 with SMTP id ka5-20020a170907990500b00a1cf745e0b3mr3808358ejc.97.1702462553820;
        Wed, 13 Dec 2023 02:15:53 -0800 (PST)
Received: from pop-os.localdomain (81-231-61-187-no276.tbcn.telia.com. [81.231.61.187])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090676d200b00a1d9733f2d9sm7400403ejn.209.2023.12.13.02.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:15:52 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:15:49 +0100
From:   Joakim Bech <joakim.bech@linaro.org>
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Simon Ser <contact@emersion.fr>, Yong Wu <yong.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, John Stultz <jstultz@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Vijayanand Jitta <quic_vjitta@quicinc.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        jianjiao.zeng@mediatek.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        ckoenig.leichtzumerken@gmail.com, linaro-mm-sig@lists.linaro.org,
        linux-mediatek@lists.infradead.org, tjmercier@google.com,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kuohong.wang@mediatek.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] dma-buf: heaps: Add secure heap
Message-ID: <20231213101549.lioqfzjxcvmqxqu3@pop-os.localdomain>
References: <20231212024607.3681-1-yong.wu@mediatek.com>
 <DPBmATfmfvSP8Cwjz99kj_JvCEiAqRfuMFJZEBF2aIgl8NZqWFR66eyPTX1E8bHyOlimBihEE3E80p9bfOJ-0SNu8pwoIzL9gD2Xae6r97g=@emersion.fr>
 <20231213110517.6ce36aca@eldfell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231213110517.6ce36aca@eldfell>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:05:17AM +0200, Pekka Paalanen wrote:
> On Tue, 12 Dec 2023 16:36:35 +0000
> Simon Ser <contact@emersion.fr> wrote:
> 
> > Is there a chance to pick a better name than "secure" here?
> > 
> > "Secure" is super overloaded, it's not clear at all what it means from
> > just the name. Something like "restricted" would be an improvement.
> > 
> 
> My thoughts exactly. Every time I see "secure" used for something that
> either gives you garbage, refuses to work, or crashes your whole machine
> *intentionally* when you try to do normal usual things to it in
> userspace (like use it for GL texturing, or try to use KMS writeback), I
> get an unscratchable itch.
> 
> There is nothing "secure" from security perspective there for end users
> and developers. It's just inaccessible buffers.
> 
> I've been biting my lip until now, thinking it's too late.
> 
The characteristics we're looking for here is a buffer where the content
is inaccessible to the normal OS and user space, i.e., Non-secure EL0 to
EL2. I.e, the content of the buffer is meant to be used and accessible
primarily by the secure side and other devices that has been granted
access to it (for example decoders, display controllers if we're talking
about video use cases). However, since the use cases for this exercises
the whole stack, from non-secure user space (EL0) all the way to secure
user space (S-EL0), with various devices needing access to the buffer at
various times, it makes sense to let Linux manage the buffers, although
it still cannot access the content. That's the overall context.

As for the name, it's always difficult to find a name suitable precisely
describing what it is. "Secure" is perhaps vague, but it might still a
good choice, if you carefully describe what secure means for this
particular heap (in the source code and the documentation for it). For
example, the definition of "secure" for a secure heap as here could mean
that buffer content is inaccessible to the host OS and user space
running in normal world (using Arm nomenclature). I wouldn't have any
problems with calling it secure if, as said it's defined what we mean by
saying so. But I'm all ears for other suggestions as well.

Safe, protected, shielded, unreachable, isolated, inaccessible,
unaccessible, fortified, ... would any of these make more sense?

> 
> Thanks,
> pq

-- 
// Regards
Joakim
