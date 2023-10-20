Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31E27D089A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376298AbjJTGjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjJTGjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:39:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9E8B8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:39:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso591115a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697783983; x=1698388783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2yp/+uoXDPdDZvc0A60oXmXPqC6NUCSNebw398N6I0=;
        b=XxLFdweuaY6glNwcHvo3S7tU0HFKADCe+pwHRndN3UueSXOtJnXSCiyLSUmRh+Y85R
         lgS3j5cBmQ5gHiu9Z4d/esviIgP+DPeGQ8th8Y+v9AB2D9KrzOpFI0QTycgibbxnVikY
         t2UH4odyUE77znhmX/QwYPGF7zk3gTWU0r67wXenzMgsXpc/PvEBhl2WMkMKdiE/ZPwZ
         qnMmiCL2spjKFRMuMm/tvCX7bxd5rbS/UZKZ0V+tkshfUw/9rtG1+hR2kow3Xs9sg7/P
         fWxMMLFCT9q6DHfZIJpnJB9UgHtrZgJPLsPZB+MYe82Rrz+PK5kSN36ykgzFpURkZjcT
         36ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697783983; x=1698388783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2yp/+uoXDPdDZvc0A60oXmXPqC6NUCSNebw398N6I0=;
        b=dDD3qDyA4OeGkZWdMq6hdrNEz+22VDM1kCweuyDVEIHKtPQnzEroE+mngoZ2dnel1C
         HqXfxUyAZTT2wyth0Ra3RqynWJ00NkBG94uA8nqNp5h3r6ThRj52DChI/bfYdYlI+Ag0
         AjPX8VDPXsxkLNDkJ3BoNkI5s1r2/e/RaeGppCFnxIteXtkaWBdafeUaYJQSi6GQcW/K
         7oEMzGsBcMxgxY9Ej/Wpyo5kqCRP0vCR/FaCnlts96doO7xLCbQLm90psVy2Hd+MWszK
         lo+ZPCoRIkOOFa5cw6ZYiBSL7u2XncB9NvUk6mTnZJlWd4wjk2nVeEg9Y04UjP2jm65d
         dc/g==
X-Gm-Message-State: AOJu0YxcWC8YYqH67fANIh4oxb3M/6omZ+6H3bWmZQGVqWF4b/5Ed0JJ
        fhfDc13hdYy58OCmZrgaP+MfZ7YDep/w7AoAyLztQA==
X-Google-Smtp-Source: AGHT+IHB35/EOIOr35HN++ZRTCy6gPZn5GdWe6FQtupPL660MqWX2OkTGpZVDEc2RaXXWPPDHowi48EH0tOyEkBNITA=
X-Received: by 2002:a50:d742:0:b0:53f:6ed5:4dab with SMTP id
 i2-20020a50d742000000b0053f6ed54dabmr805859edj.24.1697783983308; Thu, 19 Oct
 2023 23:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697779681.git.yan@cloudflare.com> <e721c615e22fc4d3d53bfa230d5d71462ae9c9a8.1697779681.git.yan@cloudflare.com>
 <CANn89iKU6-htPJh3YwvDEDhnVtkXgPOE+2rvzWCbKCpU25kbDw@mail.gmail.com>
In-Reply-To: <CANn89iKU6-htPJh3YwvDEDhnVtkXgPOE+2rvzWCbKCpU25kbDw@mail.gmail.com>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Fri, 20 Oct 2023 01:39:31 -0500
Message-ID: <CAO3-PbqtEPQro4wsQbaD-UbF-2RpxsVKVvs3M0X10-oE7K1LXA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/3] ipv6: remove dst_allfrag test on ipv6 output
To:     Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexander H Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 1:06=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Oct 20, 2023 at 7:32=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wro=
te:
> >
> > dst_allfrag was added before the first git commit:
> >
> > https://www.mail-archive.com/bk-commits-head@vger.kernel.org/msg03399.h=
tml
> >
> > The feature would send packets to the fragmentation path if a box
> > receives a PMTU value with less than 1280 byte. However, since commit
> > 9d289715eb5c ("ipv6: stop sending PTB packets for MTU < 1280"), such
> > message would be simply discarded. The feature flag is neither supporte=
d
> > in iproute2 utility. In theory one can still manipulate it with direct
> > netlink message, but it is not ideal because it was based on obsoleted
> > guidance of RFC-2460 (replaced by RFC-8200).
> >
> > The feature test would always return false at the moment, so remove it
> > from the output path.
>
> What about other callers of dst_allfrag() ?
>
> This feature seems broken atm.

It is broken as far as I can tell. The reason I removed just one
caller here is to keep the code simpler and consistent. If I don't do
so, I ought to test it for both GSO fast path and slow path to be
logically consistent. Seems an overkill to me. For the removal of the
rest, I'd hope it could come in as a standalone patch(set) because it
is not just callers but also those unnecessary flags and tests on IP
corks and sockets, not quite aligned with this patch's intention. I
noted you have drafted something like this in the past:

https://lkml.kernel.org/netdev/1335348157.3274.30.camel@edumazet-glaptop/

I guess it might be a good base point to work on as a new patch(set)?
What's your call on this?

Yan
