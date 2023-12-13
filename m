Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096438112B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379210AbjLMNWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379208AbjLMNWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:22:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DC2F7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:22:34 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso9681701a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702473753; x=1703078553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cj1ZMs1V56ZZNUEaZewI9vOkZv5jPO392Bp8WoFBh7w=;
        b=QE0f0ib379EAddySX8B2XxGtd5yPt0f7o2RTb1vh5d1D37j4+hXzzPyrQY3/0rltXl
         FpB+Hcjie0+e1urDiEXsmvHFCoFeCRbi5ke3i180BXB7wJKgWrIaIWR9HAKvu3hpR9T5
         v77abuKh4sBKzhN0JG3dxYllq8eZv49Fo0cVfEAyEsXNx28QpxBJmrltDjGBtIEoGreY
         IlmgUuIALhKRVNanBzVjhZWmZU15Ia9hPcrQ6qfnDjc2ujcgMHz44EJ3j2U21v1quruC
         wpcwOxS7xUnK1lfM920/Dw+pbc+VdUU5idV3tsBAIwBF6IpbD6GF4YzUXMSig+7p67Az
         yxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702473753; x=1703078553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj1ZMs1V56ZZNUEaZewI9vOkZv5jPO392Bp8WoFBh7w=;
        b=NnTh4nz+WjoQjFxxCbFcGPnKjpc78/exOXswFQcu3muRUVGDp53zoCPtWFvFeVswrT
         AOghFL/onlaqot7J4kPNcm1bHJ+qcioap0LsV48b33PNHwtOJH12iNfRvUsrivTC00eO
         jac/bztz7RviFGZ3Rjr8n0tWZbGrs0PctjGlv+z/m/oGAF4dAQcpXs9qPTMtVgreRol/
         GCsGTv3Cou4rgxXMgske6Kv1FC85mVaD2FCD13Rc/sPIR1SzhiEW+hH3ZGXcjvPQzV7G
         BEhRCAwq9aCVLUdg9TGEzOtGSYRWqYTBHz0R49Xgpwta9YD778EsNqJrwsqofPxxl+pJ
         tMLg==
X-Gm-Message-State: AOJu0YwqjwEWlapudyL3oiP9w/DXjKJTx0P7iPy1pt03E0E6vszs7DR7
        P9lUWvXbe7c9D8IFAOuT5OgHug==
X-Google-Smtp-Source: AGHT+IELaCU/APPH5lEyFAZu+OpT0rs0/r3NQO6C377YTW5LsGnDiFcS2/Qewp1/YjG0GmihdG0ytg==
X-Received: by 2002:a50:955d:0:b0:54f:4f7f:1a5c with SMTP id v29-20020a50955d000000b0054f4f7f1a5cmr828258eda.81.1702473752835;
        Wed, 13 Dec 2023 05:22:32 -0800 (PST)
Received: from pop-os.localdomain (81-231-61-187-no276.tbcn.telia.com. [81.231.61.187])
        by smtp.gmail.com with ESMTPSA id s28-20020a50ab1c000000b0054c6b50df3asm5921343edc.92.2023.12.13.05.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:22:31 -0800 (PST)
Date:   Wed, 13 Dec 2023 14:22:29 +0100
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
Message-ID: <20231213132229.q3uxdhtdsxuzw3w6@pop-os.localdomain>
References: <20231212024607.3681-1-yong.wu@mediatek.com>
 <DPBmATfmfvSP8Cwjz99kj_JvCEiAqRfuMFJZEBF2aIgl8NZqWFR66eyPTX1E8bHyOlimBihEE3E80p9bfOJ-0SNu8pwoIzL9gD2Xae6r97g=@emersion.fr>
 <20231213110517.6ce36aca@eldfell>
 <20231213101549.lioqfzjxcvmqxqu3@pop-os.localdomain>
 <20231213133825.0a329864@eldfell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231213133825.0a329864@eldfell>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:38:25PM +0200, Pekka Paalanen wrote:
> On Wed, 13 Dec 2023 11:15:49 +0100
> Joakim Bech <joakim.bech@linaro.org> wrote:
> 
> > On Wed, Dec 13, 2023 at 11:05:17AM +0200, Pekka Paalanen wrote:
> > > On Tue, 12 Dec 2023 16:36:35 +0000
> > > Simon Ser <contact@emersion.fr> wrote:
> > >   
> > > > Is there a chance to pick a better name than "secure" here?
> > > > 
> > > > "Secure" is super overloaded, it's not clear at all what it means from
> > > > just the name. Something like "restricted" would be an improvement.
> > > >   
> > > 
> > > My thoughts exactly. Every time I see "secure" used for something that
> > > either gives you garbage, refuses to work, or crashes your whole machine
> > > *intentionally* when you try to do normal usual things to it in
> > > userspace (like use it for GL texturing, or try to use KMS writeback), I
> > > get an unscratchable itch.
> > > 
> > > There is nothing "secure" from security perspective there for end users
> > > and developers. It's just inaccessible buffers.
> > > 
> > > I've been biting my lip until now, thinking it's too late.
> > >   
> > The characteristics we're looking for here is a buffer where the content
> > is inaccessible to the normal OS and user space, i.e., Non-secure EL0 to
> > EL2. I.e, the content of the buffer is meant to be used and accessible
> > primarily by the secure side and other devices that has been granted
> 
> s/secure side/proprietary side/
> 
I'm using the nomenclature as written by Arm (other architectures have
other names for their secure execution states).

> I presume nothing of the other side can ever be in any way open?
> 
I'm sure there are lots of examples of things running on the secure side
that are open. The OP-TEE project where I'm a maintainer has been fully
open source since 2014, to give one example that I'm familiar with
myself.

> Maybe the other side is even less secure than the FOSS side...
> 
> > access to it (for example decoders, display controllers if we're talking
> > about video use cases). However, since the use cases for this exercises
> > the whole stack, from non-secure user space (EL0) all the way to secure
> > user space (S-EL0), with various devices needing access to the buffer at
> > various times, it makes sense to let Linux manage the buffers, although
> > it still cannot access the content. That's the overall context.
> 
> Yes, we know all this (except for the exact meaning of EL0 etc.).
> 
Great!

> > As for the name, it's always difficult to find a name suitable precisely
> > describing what it is. "Secure" is perhaps vague, but it might still a
> > good choice, if you carefully describe what secure means for this
> > particular heap (in the source code and the documentation for it). For
> 
> Carefully describe, as in, re-define.
> 
> > example, the definition of "secure" for a secure heap as here could mean
> > that buffer content is inaccessible to the host OS and user space
> > running in normal world (using Arm nomenclature). I wouldn't have any
> > problems with calling it secure if, as said it's defined what we mean by
> > saying so. But I'm all ears for other suggestions as well.
> > 
> > Safe, protected, shielded, unreachable, isolated, inaccessible,
> > unaccessible, fortified, ... would any of these make more sense?
> 
> "Restricted" sounds like a good compromise to me. The buffers' usage is
> severely restricted.
> 
Yes, restricted isn't a bad choice. We would still need to describe what
we mean by saying it's restricted, i.e., what is it restricted from,
since I'd guess that "restricted" by itself also could be a bit open
ended for a lot of people.

> It is the opposite of "safe", because accessing the contents the wrong
> way can return garbage or intentionally crash the whole system,
> depending on the hardware implementation. One example is attempting to
> put such a buffer on a KMS plane while the connector HDCP state is not
> high enough, or a writeback connector is connected to the CRTC. It is
> really fragile. (Do KMS drivers fail an atomic commit that would
> violate the heap rules? Somehow I doubt that, who'd even know what the
> rules are.)
> 
I believe one of the goals with reviewing the patches is to highlight
issues like this and try to figure out how to avoid ending up in
situations like what you described by suggesting alternative solutions
and ideas.

> It is protected/shielded/fortified from all the kernel and userspace,
> but a more familiar word to describe that is inaccessible.
> "Inaccessible buffer" per se OTOH sounds like a useless concept.
> 
> It is not secure, because it does not involve security in any way. In
> fact, given it's so fragile, I'd classify it as mildly opposite of
> secure, as e.g. clients of a Wayland compositor can potentially DoS the
> compositor with it by simply sending such a dmabuf. Or DoS the whole
> system.
> 
I hear what you are saying and DoS is a known problem and attack vector,
but regardless, we have use cases where we don't want to expose
information in the clear and where we also would like to have some
guarantees about correctness. That is where various secure elements and
more generally security is needed.

So, it sounds like we have two things here, the first is the naming and
the meaning behind it. I'm pretty sure the people following and
contributing to this thread can agree on a name that makes sense. Would
you personally be OK with "restricted" as the name? It sounds like that.

The other thing is the feature and functionality itself offered by this
patch series. My impression from reading your replies is that you think
this is the wrong approach. If my impression is correct, what would you
suggest as an alternative approach?

> "Poisonous heap" would be fitting but politically inappropriate I
> guess. After all, "poison" is data that is not meant to be read by
> anything normal.
> 
> 
> Thanks,
> pq

-- 
// Regards
Joakim
