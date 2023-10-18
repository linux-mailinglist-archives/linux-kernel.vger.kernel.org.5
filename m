Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF607CDDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344781AbjJRNxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344726AbjJRNxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:53:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8654B109
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:53:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53f3609550bso2232470a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697637193; x=1698241993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Y1aisZeIriYyxFM1TSaA8ZfMVwNYTwFQkBPhrfCDrQ=;
        b=UrGRUZwZ/COkrTKm9QxMPQ7q4cvPd6/YcYE/Z5VydGyB98OPuzu89VJV5Epv6Dhp5m
         AxxWoUbpFKs6rh+kRCv03W0e18SB1hfluojKFe7VFZZUxtvCyt3DGbK6rOcxj3ba2t3+
         XJoHmvPfybOz/Tyr4XHAp0GsL4I1MFaIGf4uhis6q8SSV7KskytX0lSPR6CI2Wjh7Idj
         BJZXEUoEpJVGYO4odnThUUts7XKCxEixGBVPtKQJxkOW+dPDUsfkcx4RbPbFSwD3dzjl
         g+7AXaK8M7l8ghja3dOT9otJA4KUH9osmcmNt8VvSSkc9UiWFnJ7/qh2eJVWgNjA/hk8
         dIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697637193; x=1698241993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Y1aisZeIriYyxFM1TSaA8ZfMVwNYTwFQkBPhrfCDrQ=;
        b=BLi2s5AU2E6HBYo+PCzXr1KDHAVVImBcnwZ/OzLBn1b1bKwY2EkJoDjvCsbSqVNPK1
         LfeDilFKrat84iAfTrpO5iUogTluQhvrqH5NVWbDPPuou4yVekFfKsTIffblCEX6d4cF
         eevZSCcGVG1RfeJabXbwe8CajNL6VZHIKKMhVdEqVOnqVSDV9X/fQYeiZAp1STRfi5Zb
         UT9LQXk5+SA7erX4wkIqKkZ/Bm2PNnmaQXq4wY4q9at1TwCdswWpPNX3McRu5ysvmv74
         bQQlpB42W5ZPaOP2YQ0/X7kxftRzlcIgYTbmHc+aTyNxNu0xJnr8SmzB1dIoxv4d9WTr
         jcOw==
X-Gm-Message-State: AOJu0YzrM2DGK3DHzgsnOiSzpqXENjivTQIeSPzdob7FGRtCMnbdenxU
        xzrqU1CFkq4WXlHVmZ81kYegD/PlTUlcnEmhE/0vog==
X-Google-Smtp-Source: AGHT+IHwJ/xcQTSrRnlBfY8dlsY743seQ08VsnugmfLJtoKefKnXoer3Thpmqy5aePNBjup4q3pRVDyyWaP5xR8Tv2c=
X-Received: by 2002:a50:9f4b:0:b0:53e:8972:1d4f with SMTP id
 b69-20020a509f4b000000b0053e89721d4fmr4124734edf.5.1697637192880; Wed, 18 Oct
 2023 06:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <ZS1/qtr0dZJ35VII@debian.debian> <20231017200207.GA5770@breakpoint.cc>
 <CAO3-Pbod3qc7rdg0bN0z5TjeoxO-SAADEwPZm6jcT42Gya8s=g@mail.gmail.com> <CAF=yD-K7SbUkeVkTcZyR_x-+fgtpcBr0R6e75J=C_Af54J+zew@mail.gmail.com>
In-Reply-To: <CAF=yD-K7SbUkeVkTcZyR_x-+fgtpcBr0R6e75J=C_Af54J+zew@mail.gmail.com>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Wed, 18 Oct 2023 08:53:01 -0500
Message-ID: <CAO3-Pbpc+s95fDc6ejrmPSYEPYYu-8X-ZvYNPPoSzCuG=W=gwQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] ipv6: avoid atomic fragment on GSO packets
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 8:58=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> The second paragraph in the commit message really makes
> clear that this combines three changes in one patch. Of which
> the largest one in terms of code churn is supposed to be a
> NOOP.
>
> Separating into three patches will make all three more clear.
> They can be pushed as one series, conceivably.

Thanks for clarifying. In that case I am just gonna remove dst_allfrag
in ip6_finish_output rather than everywhere for the series. Remaining
cleanup can come later then. In fact there were some past
considerations already on this:

https://lkml.kernel.org/netdev/1335348157.3274.30.camel@edumazet-glaptop/

Could be a good base to work on later.

Yan
