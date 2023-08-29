Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABF078CF83
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjH2WYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbjH2WYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:24:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A62C2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:24:21 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68bed286169so4229827b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1693347860; x=1693952660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+YYrVRvFGP8cHlPGoJT9wVJUhY8GN/rwR0tzqEGpip4=;
        b=HGN6wzE0Z+22ftS0x+nuWnCprmDpb/v0SZ86HyOgWputm+heKUXR2mnqzErStq72tE
         c4zpJAZLjtl3kqpneEua/+I1WrnSnldvcrdEQdT7A5hy/DT7Q29PJg5ZsJoNRAT7q9t5
         0pNXHfsoylRRBs84O2jg2jQ44b0YU6QiALeVPzBfC77m+1icx0TiWZM2135zoO1fYz30
         Gm9oV5xtAaqTC6GGk81p9SW1a+4NDotdsld40wB+14KpNtaDa2zplFhdZqkhACTXNKdX
         846zMFSDYPBeCRHYzXhz0Q3MFtvLKbd7Qz/i6wN3kFU3FU+6W9fVtld63qMKc3qTQ68j
         7KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693347860; x=1693952660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YYrVRvFGP8cHlPGoJT9wVJUhY8GN/rwR0tzqEGpip4=;
        b=R0DalTRUB8tY9UiISHYe2E0+FEiAnGsasvUubUaHI40T33C6knw9XOBRYqxC+6yTON
         xSdwhPC1WkOnxKwgeTaJ/QQ1tjftngivGcIoUKQozK480ebb5As7UcBtoCGhin5RvhEX
         i3sna8rL54gERabVGbCT7M5rWv8ogGnQncy12lwP9CQdraYdobuOxCOUx5JxZjDdBd/t
         e9KGP88TQT5ntmhj4Oc5DaHvQhSqLoqDSZQJRKJ6dPPisykgKNFox4Gby23wCd+U+Osl
         2oDF8ZppuHcaANQIaXxPVnkZrbd3p+fjJKKhWb4+DoQtcRr2RyG4ztt4WUQ/tTPyV2mh
         t8/w==
X-Gm-Message-State: AOJu0Yy9TzjPjB0DGVK3wpn3WT77ZQEG9gf+akPvtQuQQhMohJysYW7Y
        x690VRf+2VWH5PdLOtmgVBGE5A==
X-Google-Smtp-Source: AGHT+IFPNsEXPkaJPGMeeiEFHipjnGseCng4DOTgYsmDDTAwZXJBdp93d1gYNXCJe3ucMHjD39GcnA==
X-Received: by 2002:a05:6a20:9746:b0:148:656b:9a1f with SMTP id hs6-20020a056a20974600b00148656b9a1fmr654936pzc.20.1693347860454;
        Tue, 29 Aug 2023 15:24:20 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id v12-20020a170902b7cc00b001993a1fce7bsm9798784plz.196.2023.08.29.15.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 15:24:20 -0700 (PDT)
Date:   Tue, 29 Aug 2023 15:24:18 -0700
From:   Mohamed Khalfella <mkhalfella@purestorage.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     willemjdebruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        David Howells <dhowells@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BPF [MISC]" <bpf@vger.kernel.org>
Subject: Re: [PATCH] skbuff: skb_segment, Update nfrags after calling zero
 copy functions
Message-ID: <20230829222418.GB1473980@medusa>
References: <20230828233210.36532-1-mkhalfella@purestorage.com>
 <64ed7188a2745_9cf208e1@penguin.notmuch>
 <20230829065010.GO4091703@medusa>
 <CANn89iLbNF_kGG9S3R9Y8gpoEM71Wesoi1mTA3-at4Furc+0Fg@mail.gmail.com>
 <20230829093105.GA611013@medusa>
 <CANn89iLzOFikw2A8HJJ0zvg1Znw+EnOH2Tm2ghrURkE7NXvQSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLzOFikw2A8HJJ0zvg1Znw+EnOH2Tm2ghrURkE7NXvQSg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-29 12:09:15 +0200, Eric Dumazet wrote:
> Another way to test this path for certain (without tcpdump having to race)
> is to add a temporary/debug patch like this one:
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a298992060e6efdecb87c7ffc8290eafe330583f..20cc42be5e81cdca567515f2a886af4ada0fbe0a
> 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1749,7 +1749,8 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
>         int i, order, psize, new_frags;
>         u32 d_off;
> 
> -       if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
> +       if (skb_shared(skb) ||
> +           pskb_expand_head(skb, 0, 0, gfp_mask))
>                 return -EINVAL;
> 
>         if (!num_frags)
> 
> Note that this might catch other bugs :/

I was not able to make it allocate a new frags by running tcpdump while
reproing the problem. However, I was able to do it with your patch.
