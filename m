Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C1778EFC0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345657AbjHaOq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjHaOq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63F7CD6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693493136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTd3wy/OVxecIaD6rgBVuZb82dl7b8CuRSfdLyU+dL4=;
        b=hlZ60v8rW7BnrCDbIJw6DsySjMR5m91OI3MOB+Q8zDoo31WPBecszK+uyI5HGbcnFAZntV
        yav9HjYLCNcJMAix9WOPh0/w2QUMMLnFlMgM76+/tWu5MghNIaCihlDfk9V0va7S3blHQN
        XIMCkX0LJp4Z+cLxn0Llv6Ae0Si33xo=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-6lTesbxrOLG7LziuF31O1Q-1; Thu, 31 Aug 2023 10:45:35 -0400
X-MC-Unique: 6lTesbxrOLG7LziuF31O1Q-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6bd899e2d3aso1129210a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693493134; x=1694097934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTd3wy/OVxecIaD6rgBVuZb82dl7b8CuRSfdLyU+dL4=;
        b=BvaED7Kv+2os/XtgPfJZmgGDWtgDjPC+aur+qVilrjru1S0KGG4dem7A62JVQ0TJ4f
         wB2imfwN6CzxgIoNUBUdtzvCB8NGK2z5q4n1gW0/s6BsuO1v1gtaihQgFr2ipqslBvNh
         Es+p1Qpq0h+8JhwJoDiqbIzLgSXbHrez4FJcZ+94Wwy0m0EGladjZHsSjb4bV5A5WVea
         Wg/4G3XQlOImMh3uoY0pRGbi6t5w26atQosvHB9g623uW2/Q3xJOXkYpYcZ3+DsH/tvr
         lYEsGDvGjhVQG5s/cbIg5/U3eRAhhcgop8wn6W/YuYXfPpfkUK/xsjzgLKt490hs7e9a
         /SgQ==
X-Gm-Message-State: AOJu0YxLxZZRiaYRPSaTNoNHhj21AixNPSz6FtmmqHuAeSByY8ZenY7M
        EFO28KbLnbrcOqoM2kvPhVjTj5S+7jR4zBKj8FGFkzqtj99XRU1IiFl3QoREkuIUFOXotaUVqA/
        fbiCJy8/SPV8dUCoxLriNVK9bIirAVxfKmdXv/Zea
X-Received: by 2002:a05:6830:1692:b0:6b2:91c9:8e1e with SMTP id k18-20020a056830169200b006b291c98e1emr6023706otr.2.1693493134751;
        Thu, 31 Aug 2023 07:45:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0pI9uK2ToEtl8xqf16/qumOaryQOQqIewGouu2F54UiswiP68mqZsTvi5SjT3LsoV6gI2LE+dETgXBTmSrRc=
X-Received: by 2002:a05:6830:1692:b0:6b2:91c9:8e1e with SMTP id
 k18-20020a056830169200b006b291c98e1emr6023690otr.2.1693493134533; Thu, 31 Aug
 2023 07:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230831123931.60606-1-wander@redhat.com> <20230831133750.GB15759@breakpoint.cc>
In-Reply-To: <20230831133750.GB15759@breakpoint.cc>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Thu, 31 Aug 2023 11:45:23 -0300
Message-ID: <CAAq0SU=nesniZCLBa7xoqJ853sk2_+LaBhenVSZeYoe=82Syow@mail.gmail.com>
Subject: Re: [PATCH nf v2] netfilter/osf: avoid OOB read
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        "open list:NETFILTER" <netfilter-devel@vger.kernel.org>,
        "open list:NETFILTER" <coreteam@netfilter.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 10:37=E2=80=AFAM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Wander Lairson Costa <wander@redhat.com> wrote:
> >
> > diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_os=
f.c
> > index 8f1bfa6ccc2d..13fedf2aaa0f 100644
> > --- a/net/netfilter/nfnetlink_osf.c
> > +++ b/net/netfilter/nfnetlink_osf.c
> > @@ -315,6 +315,9 @@ static int nfnl_osf_add_callback(struct sk_buff *sk=
b,
> >
> >       f =3D nla_data(osf_attrs[OSF_ATTR_FINGER]);
> >
> > +     if (f->opt_num > ARRAY_SIZE(f->opt))
> > +             return -EINVAL;
> > +
>
> Hmm, this isn't enough; as far as I can see there is no validation
> whatsoever.
>

I didn't get it. It guarantees there is no OOB read of the opt array.

> This should also check that all of:
>
>  char    genre[MAXGENRELEN];
>  char    version[MAXGENRELEN];
>  char    subtype[MAXGENRELEN];
>
> ... have a NUL byte. You could use strnlen() =3D=3D ARRAY_SIZE() -> EINVA=
L
> for those.
>

I think the correct way would be memchr(genre/version/subtype, 0, MAXGENREL=
EN).

> Maybe there is more to be validated. I did not followup with all the
> nested structures buried in user_finger struct.
>

I focused on the reported issue mainly because I am unfamiliar with
the Netfilter layer. Let me take a deeper look.

