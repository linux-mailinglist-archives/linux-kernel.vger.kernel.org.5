Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653F17A59FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjISGdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjISGdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:33:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B42116
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:32:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae22bf33a0so176939866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1695105177; x=1695709977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GbXneqlvqIGCYRFq8SaQCy+9zDbbsrcbESBLAJ+M0h4=;
        b=Xqb4aqcH/mtSprIbTMmuPlGtNpLgLIFKrFe6vR9y1G8EOoniPOKh2czR4P/Er06XCT
         ToHfJOxlwfLl9cME//Mc2Fkaz31Qyhy48NQaqOXgdz+dqKn4iym2cpF+NJxpTePsbPFd
         qKEEvBr1yOQl2IMzs+KpeCq9zfo3/nZSKzueTDsnvhs/J1hSdrFHU+bpBHNZikZYqffP
         JeOTw9sajiHm3dS6uj+aSDRKrrJjyiUa3ke03Q68nfvlv9pNS0zrJCZQV8EN5T0S7EaA
         qs4KrrnsdW5sJ/M6gTv8LUDzfyJlokOBoT2eBGNAUbMUHWVngDDRjb09JqoDlCsasCCi
         BY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695105177; x=1695709977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbXneqlvqIGCYRFq8SaQCy+9zDbbsrcbESBLAJ+M0h4=;
        b=OJLhN8UU+hwkesvOqB2tFqs3/7WMc6P/FH7NaeYeG0l7LKKVuEz0wyXOd1/xmGk8ke
         7YHfMIBhFERcVa/IjAa811j5yCEFRswb+P43i6CoMLFXlyTL0OForpAK6WL6sEbzIb9o
         BTq/lmZWWevVdrAnoJo45SNJeDpm9l8qHaTUyrfURCKQ1otbxwngm26K1qOxABpd8TSc
         T/H88CIvzwhi1QRVUf6Kqu1Pq9i4ak39rNU8ZTtY/Za6Uu55bFaTvMBuJIytRqk97PKC
         ygGwbtARy/IetIR2AkzlIOHSlC2napRlVvgtCDtIGKrSGUoCRHsWE9megP4KNYbh4gAL
         c3Eg==
X-Gm-Message-State: AOJu0YwM+X49tqGDuBUb/AjiGX2BZF4zkeFU6kujYc3pqmGeWKgFy70a
        n9/RyBw1Vvt8/tf7ya7dvs1XNrHt2zKjw46rf0EOEQ==
X-Google-Smtp-Source: AGHT+IHpV5Vew41sZRDC2b41rJaSvmNBj24K6LKHAVA5Q188InmpQ7BMq5mvfnybMr2PJTT4+AhBMJwTFm7hYcrfhYw=
X-Received: by 2002:a17:907:97cb:b0:9aa:f7f:e276 with SMTP id
 js11-20020a17090797cb00b009aa0f7fe276mr2314608ejc.38.1695105176878; Mon, 18
 Sep 2023 23:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230919030345.8629-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20230919030345.8629-1-jason-jh.lin@mediatek.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Tue, 19 Sep 2023 07:32:44 +0100
Message-ID: <CAPj87rOHctwHJM-7HiQpt8Q0b09x0WWw_T4XsL0qT=dS+XzyZQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add mediate-drm secure flow for SVP
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Shawn Sung <shawn.sung@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason, CK,

On Tue, 19 Sept 2023 at 04:04, Jason-JH.Lin <jason-jh.lin@mediatek.com> wrote:
> The patch series provides drm driver support for enabling secure video
> path (SVP) playback on MediaiTek hardware in the Linux kernel.
>
> [...]
>
> Memory Usage in SVP:
> The overall flow of SVP starts with encrypted video coming in from an
> outside source into the REE. The REE will then allocate a 'secure
> buffer' and send the corresponding 'secure handle' along with the
> encrypted, compressed video data to the TEE. The TEE will then decrypt
> the video and store the result in the 'secure buffer'. The REE will
> then allocate a 'secure surface'. The REE will pass the 'secure
> handles' for both the 'secure buffer' and 'secure surface' into the
> TEE for video decoding. The video decoder HW will then decode the
> contents of the 'secure buffer' and place the result in the 'secure
> surface'. The REE will then attach the 'secure surface' to the overlay
> plane for rendering of the video.
>
> Everything relating to ensuring security of the actual contents of the
> 'secure buffer' and 'secure surface' is out of scope for the REE and
> is the responsibility of the TEE.
>
> DRM driver handles allocation of gem objects that are backed by a 'secure
> surface' and for displaying a 'secure surface' on the overlay plane.
> This introduces a new flag for object creation called
> DRM_MTK_GEM_CREATE_ENCRYPTED which indicates it should be a 'secure
> surface'. All changes here are in MediaTek specific code.

To be honest, it seems strange that DRM is being used as the allocator
for buffers which will mostly be used by codec hardware which is not
mentioned here. I can understand that minigbm and gbm_gralloc make
this easy to implement, but it's not really right to add this all to
mtk-drm just to support some codec features.

NXP posted a patchset a while ago to add secure-memory support to
dma-heaps[0]. This would be much cleaner (e.g. avoiding strcmp on
allocating name, avoiding mtk-drm being a render node when it can't
render) I think, and also allow common secure-path semantics between
different vendors.

Having common secure-path semantics between different vendors would be
very helpful, because the first question when we add new uAPI is
'where is the open-source userspace?'. If there is at least a common
interface through e.g. dma-heaps, then we could have some standard
cross-vendor userspace code which would work well with the standard
interface.

Cheers,
Daniel

[0]: https://lore.kernel.org/lkml/20220805135330.970-2-olivier.masse@nxp.com/
