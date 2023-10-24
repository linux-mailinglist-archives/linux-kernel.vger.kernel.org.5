Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D3C7D4DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjJXKaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjJXKau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:30:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0600410F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:30:48 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so10815a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698143446; x=1698748246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrsY5SMpX0KhMxGlL3VcqlkeSm0skgCjxoXpak2azgY=;
        b=nT+d7B4aVQNCGDPkOvARBEpL7iqabSuv2BLBnKqi6qB7gnHQWTK6jB4Il+w4dRqV0Z
         yFqnig+qv/0VzDNVKwx/Kx+GugLjE1kiBiuk29vP1DmpI1bTHZdV/m3i/tOZp4bfr9W+
         vLs3HNjSG8euU98bK+fyVk9/iplT04YUveHZAN7sCcoszETns0600BgXyoPh0JnjE5V4
         /GWFqqt7peFHVs7C19mUumJhMNlFwdmTrndVGuOUWL3fBrUpn4GWfUcS3nwtkE4+UqQM
         3hfIk9pjLKUZPW8gYOmFFHgCzJICs1DKGU41QIvGYrsAcwv0xF+5RZ4qi/lGMRoJimfz
         hWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698143446; x=1698748246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrsY5SMpX0KhMxGlL3VcqlkeSm0skgCjxoXpak2azgY=;
        b=F8UMKzuvN6rZRIHz0avURZxBT2tzVNZJaAn4Rrqf/YbMy5xmjwUYR2iAN71XAy1AFq
         IFbbuN7EbUywqJdTH9FAYwUNsHu0tlDk0AVZDG6nsYE3qkno4c29JpNe7tAgyiJ+oRZh
         SGU0V1QHriSCTW+0G7PnCYVxF5DYIDZDWyuuTFKXTH/gokfhUHc157ZAROVM1xnJ4z0z
         pcwaYSyhMDclNEFA3knGxrpXjpw/MNFM09nXV6MVycrS5BFennYlQiMQM17Frwyif4Fv
         HjShERsg1dx4mmVg0rQauwhyhZFPzgfSgEV0feLQa1b6P/wq4odpH2lh4K4ydHogMF76
         RXtw==
X-Gm-Message-State: AOJu0Yz+QEBIvlGfx9h3cDou0p5pUQz+ev7zX57hN7DHxkkVKJS7lXfM
        wlzx4hNkO9aixN1iQ98qQ3LuDGtTq/ItI5Qo1xf3JQ==
X-Google-Smtp-Source: AGHT+IEayzEbnMU7KkNUnMx0j45kuBJVJCbt6AsX3FsNeWab2ahnXcU+1K1FPi/X+kZKl568n2jcupQXxPtNyDHJkEg=
X-Received: by 2002:aa7:cd4c:0:b0:540:9db8:e357 with SMTP id
 v12-20020aa7cd4c000000b005409db8e357mr71204edw.0.1698143446154; Tue, 24 Oct
 2023 03:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698114636.git.yan@cloudflare.com> <a79fe77d7308f7e6de7a019f23a509b84cbacd79.1698114636.git.yan@cloudflare.com>
 <20231024102201.GB2255@breakpoint.cc>
In-Reply-To: <20231024102201.GB2255@breakpoint.cc>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 24 Oct 2023 12:30:32 +0200
Message-ID: <CANn89iL8LfGJF2xJP0JhW7sMUXiMdJGAe7jhL0XW3pVMG7cmkw@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 1/3] ipv6: drop feature RTAX_FEATURE_ALLFRAG
To:     Florian Westphal <fw@strlen.de>
Cc:     Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexander H Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 12:22=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Yan Zhai <yan@cloudflare.com> wrote:
> >  #define IPCORK_OPT   1       /* ip-options has been held in ipcork.opt=
 */
> > -#define IPCORK_ALLFRAG       2       /* always fragment (for ipv6 for =
now) */
> > +#define IPCORK_ALLFRAG       2       /* (unused) always fragment (for =
ipv6 for now) */
>
> Nit: Why not remove the ALLFRAG define as well?

I agree, this is not exposed to user space and should be deleted.

Reviewed-by: Eric Dumazet <edumazet@google.com>

>
> Otherwise the series looks good to me, thanks!
>
> Reviewed-by: Florian Westphal <fw@strlen.de>
>
