Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA9D80DD7B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbjLKVjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345275AbjLKVjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:39:07 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79449CE;
        Mon, 11 Dec 2023 13:39:13 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b9de2332e3so3279731b6e.1;
        Mon, 11 Dec 2023 13:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702330753; x=1702935553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dy+fi2JHrQvrJFBsxHz6YX2HvM8v9kbAWQn+mZlILk4=;
        b=GQnSWMSov3IiuuWg9xGZ8Hq3ZlL844jt6KrZiaTavIrTDHVpYzM02EpoWtJiYhu8Lc
         qSFi7opAe06u8QTqwOer+lOuAhJRw3xlONk7wXpWiYsCH4i/6qurY6VpsXAgvi+S5/ra
         GGayOBjuPdD8SMIAlBksK25lO2jjB/J8JmLtdp3uyLxPxLOj/pFYUVv/OolnCB0uDyCY
         ALCy87Drs9bCNBeebu4MTgvmQ5zp2FC2BLW0XR4mAn70vhp45Elg8pQrKRQbbAZNZLSl
         jOZMDK8gCrva0ZQKnNZ1m5TvWj7CP9340c6EcXZnotm4T+/LTdnkYPabi5uELeg9QvA0
         /oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702330753; x=1702935553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dy+fi2JHrQvrJFBsxHz6YX2HvM8v9kbAWQn+mZlILk4=;
        b=psmiaHnOtuFZOXoIJ2OFnqtZkA57H+Jki1R07Z4grxqGcIZqDy+/uvfLTF0oe8bmwo
         DIqfxAQ92yb/SVfsFqcFC6bHWVPNARF3X+ZIsk9UCP3X2SJcoj32L2yCUvQoC86U+x8F
         hKP/DyJQ9Ys+I76ZOUkoHqPGpTiboEClQ65y8W3Uv8yI6u+eN9qsWVT+MmEo5an+yxUZ
         KnrIqNZ8SSVJfvMtfQ6WbCdRjckyxtmfXAKcdVZcgAtks9Mqoz6qXMBDPelBPEV5w1nA
         6k7RdMYgPoyMUXl6pfDaoZWo6UjJpyS8/aZ3uXrqjUR0NqH1HSFhymLJ3hGY3aW2nGb6
         4mKA==
X-Gm-Message-State: AOJu0Yz35W0szzQawacF7CD+pWPvkNsVXE6/Uf+stANp9BDwodModA5E
        XnrWDE8qOIaIniMVKcsHmRLXUJbdozvuHyR5PtE=
X-Google-Smtp-Source: AGHT+IFdbb0kLxHtL7c2/l5H7+g+aGadHAScdA6+d2uUFusczUwI8eyOXdG+pMWQM/hlTmXTnqyH5UEyEm+VF+RyIOk=
X-Received: by 2002:a05:6808:130a:b0:3b8:7a9d:af5b with SMTP id
 y10-20020a056808130a00b003b87a9daf5bmr5514650oiv.35.1702330752631; Mon, 11
 Dec 2023 13:39:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1702325874.git.dxu@dxuuu.xyz> <e8029421b1a0d045fadb214ba919cc25efab4952.1702325874.git.dxu@dxuuu.xyz>
In-Reply-To: <e8029421b1a0d045fadb214ba919cc25efab4952.1702325874.git.dxu@dxuuu.xyz>
From:   Eyal Birger <eyal.birger@gmail.com>
Date:   Mon, 11 Dec 2023 13:39:00 -0800
Message-ID: <CAHsH6Gt4k3myGhyznhvhknup+U+aWq3dsMuhaWD=p1RWd+ABKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/9] bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        Herbert Xu <herbert@gondor.apana.org.au>, ast@kernel.org,
        john.fastabend@gmail.com, kuba@kernel.org,
        steffen.klassert@secunet.com, pabeni@redhat.com, hawk@kernel.org,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com,
        yonghong.song@linux.dev, eddyz87@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Tiny nits below in case you respin this for other reasons:

On Mon, Dec 11, 2023 at 12:20=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This commit adds an unstable kfunc helper to access internal xfrm_state
> associated with an SA. This is intended to be used for the upcoming
> IPsec pcpu work to assign special pcpu SAs to a particular CPU. In other
> words: for custom software RSS.
>
> That being said, the function that this kfunc wraps is fairly generic
> and used for a lot of xfrm tasks. I'm sure people will find uses
> elsewhere over time.
>
> Co-developed-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/net/xfrm.h        |   9 +++
>  net/xfrm/Makefile         |   1 +
>  net/xfrm/xfrm_policy.c    |   2 +
>  net/xfrm/xfrm_state_bpf.c | 114 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 126 insertions(+)
>  create mode 100644 net/xfrm/xfrm_state_bpf.c
>
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index c9bb0f892f55..1d107241b901 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -2190,4 +2190,13 @@ static inline int register_xfrm_interface_bpf(void=
)
>
>  #endif
>
> +#if IS_ENABLED(CONFIG_DEBUG_INFO_BTF)
> +int register_xfrm_state_bpf(void);
> +#else
> +static inline int register_xfrm_state_bpf(void)
> +{
> +       return 0;
> +}
> +#endif
> +
>  #endif /* _NET_XFRM_H */
> diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> index cd47f88921f5..547cec77ba03 100644
> --- a/net/xfrm/Makefile
> +++ b/net/xfrm/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_XFRM_USER_COMPAT) +=3D xfrm_compat.o
>  obj-$(CONFIG_XFRM_IPCOMP) +=3D xfrm_ipcomp.o
>  obj-$(CONFIG_XFRM_INTERFACE) +=3D xfrm_interface.o
>  obj-$(CONFIG_XFRM_ESPINTCP) +=3D espintcp.o
> +obj-$(CONFIG_DEBUG_INFO_BTF) +=3D xfrm_state_bpf.o
> diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> index c13dc3ef7910..1b7e75159727 100644
> --- a/net/xfrm/xfrm_policy.c
> +++ b/net/xfrm/xfrm_policy.c
> @@ -4218,6 +4218,8 @@ void __init xfrm_init(void)
>  #ifdef CONFIG_XFRM_ESPINTCP
>         espintcp_init();
>  #endif
> +
> +       register_xfrm_state_bpf();
>  }
>
>  #ifdef CONFIG_AUDITSYSCALL
> diff --git a/net/xfrm/xfrm_state_bpf.c b/net/xfrm/xfrm_state_bpf.c
> new file mode 100644
> index 000000000000..21630974c27d
> --- /dev/null
> +++ b/net/xfrm/xfrm_state_bpf.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Unstable XFRM state BPF helpers.
> + *
> + * Note that it is allowed to break compatibility for these functions si=
nce the
> + * interface they are exposed through to BPF programs is explicitly unst=
able.
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +#include <net/xdp.h>
> +#include <net/xfrm.h>
> +
> +/* bpf_xfrm_state_opts - Options for XFRM state lookup helpers

Maybe document that the returned pointer must be released?

BTW, it seems to me that there's not much value in having the release
function added in a separate patch as they are bound together. Maybe
consider squashing these two patches together.

> + *
> + * Members:
> + * @error      - Out parameter, set for any errors encountered
> + *              Values:
> + *                -EINVAL - netns_id is less than -1
> + *                -EINVAL - opts__sz isn't BPF_XFRM_STATE_OPTS_SZ
> + *                -ENONET - No network namespace found for netns_id

I guess ENOENT should be documented here too

> + * @netns_id   - Specify the network namespace for lookup
> + *              Values:
> + *                BPF_F_CURRENT_NETNS (-1)
> + *                  Use namespace associated with ctx
> + *                [0, S32_MAX]
> + *                  Network Namespace ID
> + * @mark       - XFRM mark to match on
> + * @daddr      - Destination address to match on
> + * @spi                - Security parameter index to match on
> + * @proto      - L3 protocol to match on

Maybe "ip protocol to match on (e.g. IPPROTO_ESP)".

> + * @family     - L3 protocol family to match on

Maybe "protocol family to match on (AF_INET/AF_INET6)

Eyal.




> + */
> +struct bpf_xfrm_state_opts {
> +       s32 error;
> +       s32 netns_id;
> +       u32 mark;
> +       xfrm_address_t daddr;
> +       __be32 spi;
> +       u8 proto;
> +       u16 family;
> +};
> +
> +enum {
> +       BPF_XFRM_STATE_OPTS_SZ =3D sizeof(struct bpf_xfrm_state_opts),
> +};
> +
> +__bpf_kfunc_start_defs();
> +
> +/* bpf_xdp_get_xfrm_state - Get XFRM state
> + *
> + * Parameters:
> + * @ctx        - Pointer to ctx (xdp_md) in XDP program
> + *                 Cannot be NULL
> + * @opts       - Options for lookup (documented above)
> + *                 Cannot be NULL
> + * @opts__sz   - Length of the bpf_xfrm_state_opts structure
> + *                 Must be BPF_XFRM_STATE_OPTS_SZ
> + */
> +__bpf_kfunc struct xfrm_state *
> +bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *o=
pts, u32 opts__sz)
> +{
> +       struct xdp_buff *xdp =3D (struct xdp_buff *)ctx;
> +       struct net *net =3D dev_net(xdp->rxq->dev);
> +       struct xfrm_state *x;
> +
> +       if (!opts || opts__sz < sizeof(opts->error))
> +               return NULL;
> +
> +       if (opts__sz !=3D BPF_XFRM_STATE_OPTS_SZ) {
> +               opts->error =3D -EINVAL;
> +               return NULL;
> +       }
> +
> +       if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS)) {
> +               opts->error =3D -EINVAL;
> +               return NULL;
> +       }
> +
> +       if (opts->netns_id >=3D 0) {
> +               net =3D get_net_ns_by_id(net, opts->netns_id);
> +               if (unlikely(!net)) {
> +                       opts->error =3D -ENONET;
> +                       return NULL;
> +               }
> +       }
> +
> +       x =3D xfrm_state_lookup(net, opts->mark, &opts->daddr, opts->spi,
> +                             opts->proto, opts->family);
> +
> +       if (opts->netns_id >=3D 0)
> +               put_net(net);
> +       if (!x)
> +               opts->error =3D -ENOENT;
> +
> +       return x;
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_SET8_START(xfrm_state_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_xdp_get_xfrm_state, KF_RET_NULL | KF_ACQUIRE)
> +BTF_SET8_END(xfrm_state_kfunc_set)
> +
> +static const struct btf_kfunc_id_set xfrm_state_xdp_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set   =3D &xfrm_state_kfunc_set,
> +};
> +
> +int __init register_xfrm_state_bpf(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
> +                                        &xfrm_state_xdp_kfunc_set);
> +}
> --
> 2.42.1
>
