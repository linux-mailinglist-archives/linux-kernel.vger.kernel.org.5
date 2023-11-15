Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFAB7ED696
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343756AbjKOWCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343724AbjKOWCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:02:21 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9116818B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:02:17 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc411be7e5so7885ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700085737; x=1700690537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuZvFHzKeqbg6jXEYOC+etK401rPBU1DU0zLZUwkdow=;
        b=sxgBdC5HQ3kZkiv5KXeRWfdoecOm7BeBoruDDM69bAn8ZvCYN/gvJdmxWZjiBoNgXE
         2EXf/qBs6IX4OifiVA0V+Kr3WKDF+xbi26x+6B1PeFaMPKRDl0uGPLadCXJyGTsij1KQ
         /JhbqavPLYQs+kHrFiaueUry+YqwzWz6eEQZl81d9MICcFxRWtTaWlehLqXlHHgfdRC7
         NsmOpieFe0qH7Vu+w4cGxXfXWFxBw4SIpEEcNy6/b2AsEui4GsNl2xceFhT+OlCOQtx/
         neBwrmXLktMcPqhXaW67k/8nUQQ03xp0diUww/e5DtzybWO2MhGUFUm1SxFJGwwHgLNe
         C0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700085737; x=1700690537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuZvFHzKeqbg6jXEYOC+etK401rPBU1DU0zLZUwkdow=;
        b=AHfVI4N9rvXLgoj58pFIwa1n48CdRElXTY2fd2EP2DfZrWxrxawp+Htfi1ngnXWimX
         nWixC13UHVLlX1Qp0SL/N49/aCIbv1LUmTAz6uG4xUeBWm8d0fN/XT5EoMClZ2ujIz+t
         SvRoh+vp16Osm2Q6Qy8zINdVyYDjTqTX3HQdEdE4gQ5XNFi9+kRDV9qCRIh+PEeN5/q6
         2FbOSgckISwLGDjU+0+JypwjsFDBdNURVbwg1X/xdWb9L53LbX8sYA41nZjWmT5XyZbX
         bxk3BWOa2cBUUl9u7ClF7G/GbxEkqN8DGXRbsXGeYJjbY+bVHhUpGJPH8sh97s+E/4ob
         5WuA==
X-Gm-Message-State: AOJu0Ywn0LjE+O328y0SxhDgkQzJw6y5ctqfX0UAfojga1yjmtgi6g2/
        TGUE9u56pjySmjxi+RmQF4DBxgflLp96O3+AJnc6
X-Google-Smtp-Source: AGHT+IFRrz+wFMxIvQfSahyfIBqJGBGy54Oa9WJpbdDj3Indo4j6kQ+gLppqjmS9wzYszPzrga5jiO2H91ugbxFInwY=
X-Received: by 2002:a17:902:d506:b0:1c7:25e4:a9d5 with SMTP id
 b6-20020a170902d50600b001c725e4a9d5mr45085plg.17.1700085736744; Wed, 15 Nov
 2023 14:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20231111111559.8218-1-yong.wu@mediatek.com> <ZU/V2XX71GbaV6Q8@duo.ucw.cz>
In-Reply-To: <ZU/V2XX71GbaV6Q8@duo.ucw.cz>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Wed, 15 Nov 2023 14:02:05 -0800
Message-ID: <CA+ddPcNd20Bg_pYWqty90NafwC54dz0LGEmTMpia5_7e4=N-cg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] dma-buf: heaps: Add secure heap
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>, tjmercier@google.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jianjiao.zeng@mediatek.com,
        kuohong.wang@mediatek.com,
        Vijayanand Jitta <quic_vjitta@quicinc.com>,
        Joakim Bech <joakim.bech@linaro.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        ckoenig.leichtzumerken@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main goal is for secure video playback, and to also enable other
potential uses of this in the future. The 'secure dma-heap' will be
used to allocate dma_buf objects that reference memory in the secure
world that is inaccessible/unmappable by the non-secure (i.e.
kernel/userspace) world.  That memory will be used by the secure world
to store secure information (i.e. decrypted media content). The
dma_bufs allocated from the kernel will be passed to V4L2 for video
decoding (as input and output). They will also be used by the drm
system for rendering of the content.

Hope that helps.

Cheers,
Jeff

On Mon, Nov 13, 2023 at 3:38=E2=80=AFAM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > This patchset adds three secure heaps:
> > 1) secure_mtk_cm: secure chunk memory for MediaTek SVP (Secure Video Pa=
th).
> >    The buffer is reserved for the secure world after bootup and it is u=
sed
> >    for vcodec's ES/working buffer;
> > 2) secure_mtk_cma: secure CMA memory for MediaTek SVP. This buffer is
> >    dynamically reserved for the secure world and will be got when we st=
art
> >    playing secure videos, Once the security video playing is complete, =
the
> >    CMA will be released. This heap is used for the vcodec's frame buffe=
r.
> > 3) secure_cma: Use the kerne CMA ops as the allocation ops.
> >    currently it is a draft version for Vijay and Jaskaran.
>
> Is there high-level description of what the security goals here are,
> somewhere?
>
> BR,
>                                                                         P=
avel
> --
> People of Russia, stop Putin before his war on Ukraine escalates.
