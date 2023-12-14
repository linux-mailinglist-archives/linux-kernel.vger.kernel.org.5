Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F1D8125E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443097AbjLNDZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjLNDZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:25:08 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A763CD0;
        Wed, 13 Dec 2023 19:25:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-33646dbedc9so215636f8f.3;
        Wed, 13 Dec 2023 19:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702524313; x=1703129113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPsWVyL4NwwSi16TKv9mIAnFmxSF7NSVwjEEFxKBUi4=;
        b=l5RDKi8JqobHEEfHqeg6/Qs5k38K/go2BsS+4h45GSZLJjYDWWpHN4zDSL+Ztgctuo
         orZQTBu5i2Gz3ysblKf+bMiKqcMYqdgiC45wuaLv3EuCnAuCG1I9MvJCEPtlNxZxG11w
         hwjCq/L7u3GDzmbTUlnfhAz3cDLOIlDAJ1syzgD6SfR3cD3RNDMxE/IiG40tLDVG6T4w
         aiFfLF2F6sXoIoISfSXQi88i8mUb5pHW4QIr2pSjQQfLKFqim+Ty5n5Nss5e9HgYiY1y
         xwS6k4DEucO86GrB1NGhrIeYt/sDzeSgXVD76DNVnlrv8BTBUs4CUZ3TZ4TwZTDdEDYx
         NeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702524313; x=1703129113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPsWVyL4NwwSi16TKv9mIAnFmxSF7NSVwjEEFxKBUi4=;
        b=Pa6U7yuwVpYE6gX+12o8aSax0oukCYIJrIeGVi5p13m9SrLL5oRoIDXEU03KSrrcmQ
         MyxCOkw2jGbOmSCmXF/FspKdDjmQA735oBvaYTRrdQ8SKadqdhBOV3cT6uRAIyRZS6kr
         MXrZKw566AIfF7qHw3cwMFQPfGNhILU4qGROQAVK+wt6T2kkjDsb66g8Ey4DTTOxGRFj
         +mmT+UcCY0sddhpmZrMmIRD3k6TMWpgqBKQ8h/5UssA/jRVcZnj7TwUtYDQAcM19LTDG
         CDMaRF3WzWFfDLfMFjsMosLDvcSLdX2tnuMc2AO/OwF1aD+ZVuL7RXqPJJxuy3QAcjVR
         PLIg==
X-Gm-Message-State: AOJu0YwcjJZReWyP1zsps6OIvvRiROJj2cAx4cNavCJatUA4SrVxdURP
        6cam9XFMrSnimQ3elOwwwdk07V8uQcd+ge9B23g=
X-Google-Smtp-Source: AGHT+IFQl0zE2JUWjUI3TFcZcBYFvGDa1fMA5dcr01PromNt2Cebf/mYv198rJlDw+KoEp8QS7Hb41NwoZMEMXHkFrM=
X-Received: by 2002:a5d:49c1:0:b0:333:2fd2:5d1b with SMTP id
 t1-20020a5d49c1000000b003332fd25d1bmr5020063wrs.77.1702524313048; Wed, 13 Dec
 2023 19:25:13 -0800 (PST)
MIME-Version: 1.0
References: <1702467945-38866-1-git-send-email-alibuda@linux.alibaba.com>
 <1702467945-38866-2-git-send-email-alibuda@linux.alibaba.com> <20231213222415.GA13818@breakpoint.cc>
In-Reply-To: <20231213222415.GA13818@breakpoint.cc>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 13 Dec 2023 19:25:01 -0800
Message-ID: <CAADnVQKGnkXYZ4GMpmDHhp2W5c0kJ7p-ipr3JwKSZyKvaSfyiQ@mail.gmail.com>
Subject: Re: [RFC nf-next 1/2] netfilter: bpf: support prog update
To:     Florian Westphal <fw@strlen.de>
Cc:     "D. Wythe" <alibuda@linux.alibaba.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        coreteam@netfilter.org,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>
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

On Wed, Dec 13, 2023 at 2:24=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> D. Wythe <alibuda@linux.alibaba.com> wrote:
> > From: "D. Wythe" <alibuda@linux.alibaba.com>
> >
> > To support the prog update, we need to ensure that the prog seen
> > within the hook is always valid. Considering that hooks are always
> > protected by rcu_read_lock(), which provide us the ability to use a
> > new RCU-protected context to access the prog.
> >
> > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > ---
> >  net/netfilter/nf_bpf_link.c | 124 ++++++++++++++++++++++++++++++++++++=
+++-----
> >  1 file changed, 111 insertions(+), 13 deletions(-)
> >
> > diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
> > index e502ec0..918c470 100644
> > --- a/net/netfilter/nf_bpf_link.c
> > +++ b/net/netfilter/nf_bpf_link.c
> > @@ -8,17 +8,11 @@
> >  #include <net/netfilter/nf_bpf_link.h>
> >  #include <uapi/linux/netfilter_ipv4.h>
> >
> > -static unsigned int nf_hook_run_bpf(void *bpf_prog, struct sk_buff *sk=
b,
> > -                                 const struct nf_hook_state *s)
> > +struct bpf_nf_hook_ctx
> >  {
> > -     const struct bpf_prog *prog =3D bpf_prog;
> > -     struct bpf_nf_ctx ctx =3D {
> > -             .state =3D s,
> > -             .skb =3D skb,
> > -     };
> > -
> > -     return bpf_prog_run(prog, &ctx);
> > -}
> > +     struct bpf_prog *prog;
> > +     struct rcu_head rcu;
> > +};
>
> I don't understand the need for this structure.  AFAICS bpf_prog_put()
> will always release the program via call_rcu()?
>
> If it doesn't, we are probably already in trouble as-is without this
> patch, I don't think anything that prevents us from ending up calling alr=
eady
> released bpf prog, or releasing it while another cpu is still running it
> if bpf_prog_put releases the actual underlying prog instantly.
>
> A BPF expert could confirm bpf-prog-put-is-call-rcu.

+1
These patches look unnecessary.
It seems that they accidently fix something else.
