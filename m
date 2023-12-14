Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D47081362C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjLNQ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjLNQ2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:28:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF1911A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:28:11 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso11502881a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702571290; x=1703176090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1g7iy2inMi8yBenBLvW1xet6ZL1hPMy4mWA7dcVL40=;
        b=s/HrImuZdghP+VVCQlo9EQiMIkwBNW/JHoA5twbpRN2/39KE91c5BJcEa/rsHChwpJ
         xr67gIFUWfwNYzwAaaVfRUHxnj6Jh0KKN0cRKvJCq2DAo+UfMIpVLj5wyGPbvnup6yNs
         fxt3SpE+vgi0ME1ahe9l5u/KupZhopHaAd5Swno9K5+/xjnA0Bmn9kNG81ATG1Gv8DQp
         Ia/YV7Un34iiSqOLgSXyUXGA4YO5PEBgFHtWRHrFwwFQxJpX1yl1ZefmzJwrKB2mCqGf
         chYJcpV7Wn/BXnIg2AiT7jGEkMmwYf18sb62fOk/iT5jtZvF7f7c3sthb8tCZl4irFGq
         1xVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571290; x=1703176090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1g7iy2inMi8yBenBLvW1xet6ZL1hPMy4mWA7dcVL40=;
        b=MY2DHJy3TGpyEzcUNIPZ3q424mHC/99y+IZqUjuAuIVYZqXfgrWLpx3S9GsTbAFQln
         oyZmvesRZO9A4k/oC+HJBLy80XSm7BooYuSS3bYy33475Xfd9WiXWgQYQLeKCGeM+rUu
         98Tam4OrRBoAg+YcP0frTjtttc8vLKswROweW4nyYNw7dPySiIbChyM7Lclnzd/NdRon
         GYR5+xXa/xKQMAsbuaEdKvyz2nUxkHCRS1USzFRlpltlQQzKqfyAUs/7jFSDq9AFQajm
         kH491jneCbSjarjkePYuCdCx9xFIycfht9KIouVfwIqk9ssczh7zmS50PV+TGYMdWuEq
         AvlQ==
X-Gm-Message-State: AOJu0YxjuLrj1V9Ma3kcSjBVw4hGellD/R8Gif4Xh3TrRuhFmvsyeN19
        +6L+eZhGGj9wF7S/6rKOd8hsSXDo9pdaj9HX6juRyg==
X-Google-Smtp-Source: AGHT+IFFf8MFkbRe3B+IYHotX448OnACGMEp2CPdU4gcm1U39YwidgDy0Lc5CECa1R6COImQLz4rVHZF5hkbHu4G5Zw=
X-Received: by 2002:a17:906:11d3:b0:a19:a1ba:8cf1 with SMTP id
 o19-20020a17090611d300b00a19a1ba8cf1mr4643725eja.143.1702571289527; Thu, 14
 Dec 2023 08:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20231214020530.2267499-1-almasrymina@google.com>
 <20231214020530.2267499-5-almasrymina@google.com> <ddffff98-f3de-6a5d-eb26-636dacefe9aa@huawei.com>
In-Reply-To: <ddffff98-f3de-6a5d-eb26-636dacefe9aa@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 14 Dec 2023 08:27:55 -0800
Message-ID: <CAHS8izO2nDHuxKau8iLcAmnho-1TYkzW09MBZ80+JzOo9YyVFA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v1 4/4] net: page_pool: use netmem_t instead
 of struct page in API
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Jiawen Wu <jiawenwu@trustnetic.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Ronak Doshi <doshir@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Shakeel Butt <shakeelb@google.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 4:05=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/12/14 10:05, Mina Almasry wrote:
>
> ...
>
> > diff --git a/include/net/page_pool/types.h b/include/net/page_pool/type=
s.h
> > index ac286ea8ce2d..0faa5207a394 100644
> > --- a/include/net/page_pool/types.h
> > +++ b/include/net/page_pool/types.h
> > @@ -6,6 +6,7 @@
> >  #include <linux/dma-direction.h>
> >  #include <linux/ptr_ring.h>
> >  #include <linux/types.h>
> > +#include <net/netmem.h>
> >
> >  #define PP_FLAG_DMA_MAP              BIT(0) /* Should page_pool do the=
 DMA
> >                                       * map/unmap
> > @@ -199,9 +200,9 @@ struct page_pool {
> >       } user;
> >  };
> >
> > -struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
> > -struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int=
 *offset,
> > -                               unsigned int size, gfp_t gfp);
> > +struct netmem *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp=
);
> > +struct netmem *page_pool_alloc_frag(struct page_pool *pool, unsigned i=
nt *offset,
> > +                            unsigned int size, gfp_t gfp);
>
> Is it possible that we add a thin layer caller on top of the page_pool AP=
I?
> So that the existing users can still use the old API, the new user suppor=
ting
> the devmem can use the new API, something like below:
>
> struct netmem *netmem_pool_alloc(struct netmem_pool *pool, gfp_t gfp)
> or
> struct devmem *devmem_pool_alloc(struct devmem_pool *pool, gfp_t gfp)
>

Yes, it can be a thin layer on top of the page_pool API, retaining the
support for the old API, so that I don't have to modify existing
users. But I have to tweak it slightly, it would be something like:

struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
/* old api unchanged */
+struct netmem *page_pool_alloc_netmem(struct page_pool *pool, gfp_t
gfp); /* new api added */

The new API can be implemented like this, but I don't need to add it
right now, it can be added in the separate devmem series:

struct netmem *page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
{
    return page_to_netmem(page_pool_alloc_pages(pool, gfp);
}

Willem I think suggested something similar to this. Drivers can then
use the old API while we implement the new API that supports different
memory types.

To support drivers using the old API I need to add a new skb frag
helper rather than modify the existing one:

+ void skb_add_rx_frag_netmem(struct sk_buff *skb, int i, struct
netmem *netmem, int off,
+                                                     int size,
unsigned int truesize)

> I perfer the second one personally, as devmem means that it is not
> readable from cpu.

From my POV it has to be the first one. We want to abstract the memory
type from the drivers as much as possible, not introduce N new memory
types and ask the driver to implement new code for each of them
separately.

> Perhaps netmem can be used in the networking core in the future to
> indicate the generic type for all types of memory supported by networking
> core.
>
> As the main concern from Jason seems to be about safe type protection for
> large driver facing API surface. And touching a lot of existing users doe=
s
> not seem to bring a lot of benefit when we have not a clear idea how to
> proceed yet.



--=20
Thanks,
Mina
