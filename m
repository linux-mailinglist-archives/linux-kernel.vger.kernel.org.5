Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CEB78496A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjHVSa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjHVSay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:30:54 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49258CCB;
        Tue, 22 Aug 2023 11:30:53 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-56c2e882416so1474584a12.3;
        Tue, 22 Aug 2023 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692729053; x=1693333853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJwN0ydvfICl3fI2kvxn1N5nH6/CDUK6G2PaZVpxA4I=;
        b=hSDt/TD0ikAtNwtZ/R+RmB9AnmPP/Zt3LFAdNhjxdksgR3jt+3TV5tmZ49lX6A5gw1
         iaor2/05gYCEgOVxPfkXc+Dk97g7uTswGkptiGZRZCmZWtrgdx1eAzPlr4LycxpAIMa9
         KoWrblxUCtqmR8JVrCDnEsYMNVS30Ww6o4JCpNTEI0yx2Y2cPJ50PQjpHQ2pF7nCSvsc
         jea+nJrrcTrq1RIaeXJ7u4X9WnnEaWdswsIlM9zaUukvCU4Gxpyyle/AGf3EhugLJn77
         sjYhbDb4JIHM1zoERBoeEoK7WvY11sknovnpkS81AXk7e1cI3y9ARqzdXO7lmuw9yb/M
         LnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692729053; x=1693333853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJwN0ydvfICl3fI2kvxn1N5nH6/CDUK6G2PaZVpxA4I=;
        b=GPOxQ2xeKny09N8c4u6j6tUsDXQqDInfMLJ+Dwl+qZtfAkWfEERLm+Kcds0qr+A+VS
         2QZNkHRe8L+0OI4mf5rajz0+EtNHDDbSq7zLW1B+nU3JCcGdGGc3UHUIii6HsKdrbK5D
         1Aa1OlipGkZAZzWc2d5/7RPwqB8iKT2mqQc709ta+TjEZ/JuHGtTR3Na+j81OFVy6sY4
         FPwvRmPUTUvyGvH/4iwV9uw/euHAlCaGb9ZkWDeZG3x/PPcy370ehe+BlZK6J/OuyJVw
         ec7VvfQLi1ISpQ3eyTozPqadx4GYkoc0l+9L2WBIH/RZ1XfTwjTklqJ/mfhkhp+ct4ul
         Ro4Q==
X-Gm-Message-State: AOJu0Yx7a4GcDBL4Ty4iYbO/0DTYE4dgSAfXWD6cfBYXAEi3Jp3Kl2D1
        UdpRoe6OrHjUuAF+tKvo/OhKwV39vw1pg3klo6s=
X-Google-Smtp-Source: AGHT+IG70G5bzkRI9NiQyhps9POkN+ANs3KDZSZWmvxZeIyJrZIwsEnxBL/fPY4TunWbkrhDFMUxo4naz3HCEWkNr8k=
X-Received: by 2002:a17:90b:4c81:b0:26b:219f:3399 with SMTP id
 my1-20020a17090b4c8100b0026b219f3399mr6351074pjb.35.1692729052643; Tue, 22
 Aug 2023 11:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230816100113.41034-1-linyunsheng@huawei.com>
 <20230816100113.41034-2-linyunsheng@huawei.com> <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
 <20230817091554.31bb3600@kernel.org> <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
 <20230817165744.73d61fb6@kernel.org> <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
 <20230818145145.4b357c89@kernel.org> <1b8e2681-ccd6-81e0-b696-8b6c26e31f26@huawei.com>
 <20230821113543.536b7375@kernel.org> <5bd4ba5d-c364-f3f6-bbeb-903d71102ea2@huawei.com>
 <20230822083821.58d5d26c@kernel.org>
In-Reply-To: <20230822083821.58d5d26c@kernel.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 22 Aug 2023 11:30:15 -0700
Message-ID: <CAKgT0UeyRSa6LC8rmA0ottkTdYo3bv36THnCe2Yaba0xca5BHg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Mina Almasry <almasrymina@google.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 8:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 22 Aug 2023 17:21:35 +0800 Yunsheng Lin wrote:
> > > .. we should also add a:
> > >
> > >     WARN_ONCE(1, "misaligned DMA address, please report to netdev@");
> >
> > As the CONFIG_PHYS_ADDR_T_64BIT seems to used widely in x86/arm/mips/po=
werpc,
> > I am not sure if we can really make the above assumption.
> >
> > https://elixir.free-electrons.com/linux/v6.4-rc6/K/ident/CONFIG_PHYS_AD=
DR_T_64BIT
>
> Huh, it's actually used a lot less than I anticipated!
>
> None of the x86/arm/mips/powerpc systems matter IMHO - the only _real_
> risk is something we don't know about returning non-aligned addresses.
>
> Unless we know about specific problems I'd suggest we took the simpler
> path rather than complicating the design for systems which may not
> exist.
>
> Alex, do you know of any such cases? Some crazy swiotlb setting?
> WDYT about this in general?

There may be scenarios where if bounce buffers are used the page may
not be aligned. It all comes down to how
swiotlb_tbl_map_single(https://elixir.free-electrons.com/linux/v6.5-rc7/C/i=
dent/swiotlb_tbl_map_single)
is called. In the IOMMU case it looks like they take the extra step of
passing an alignment value, but it looks like for the other two cases
they don't.

Changing that behavior wouldn't take much though. Basically we would
just need to do something like look at the size and address and if
they are both page aligned then we could specify a page alignment for
the DMA mapping.
