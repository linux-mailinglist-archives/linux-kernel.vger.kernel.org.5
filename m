Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062F4785DED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbjHWQyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjHWQyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:54:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1A6E60
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:54:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8663061179
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCC8C433CA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692809639;
        bh=/m05BVbbhQZnGWMzyHejK0jy+8hkwws6SLURxTv+C+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GbBF13jpMAeUmmoDQzy+MrwetggJPOT1eNSZ5hSqKN09aeN7Zj/IeRSav5ecCBSNF
         L79TwTNdMS6GjnoFL2GRFp/tWpq6Oqi1uH7wr7RxvlQQ3Jh44y34t952yjzZNuR4/g
         l1KPFL5LG/t54V14X6Nuyxdr6G8cawSXhNyqvkfG7w5Bt4v8RNwOKYJfaeiEESf24Y
         CaG2vAaoA0m7fP3WmFqDmFU+vsj/XoNd0q8yMSBiykUQT6Nt1/VJi9i2Sb8vjDwimJ
         tfn6hp/VQfBE8xMMJfeJzdWiWgt8ooWECZaWDWEEzA0uxL6wHA+ZvvKVlGmWzOrl9x
         d49O10AqXEjyQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso45390791fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:53:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YxqGxc1cKE96/EPLbQL+uTRt7asFlPyMpBxxhjl+8CClMx+t5ye
        q9VqofovmoKBfe9PuOONTWrK23k8/1YceFqrYA==
X-Google-Smtp-Source: AGHT+IGbifS+z9ypvOM3QS2TueX9lmSydCFDxyBTCG6BEav5VPtVfvFlAFwUY9R7Id2EAEzfBRCBV+XMI/5ZMeM/zKc=
X-Received: by 2002:a2e:8914:0:b0:2b9:3db7:322f with SMTP id
 d20-20020a2e8914000000b002b93db7322fmr10770700lji.18.1692809637712; Wed, 23
 Aug 2023 09:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230717225610.3214029-1-robh@kernel.org> <169028492642.1718138.9430735746671016845.b4-ty@ti.com>
 <CAL_JsqKAuLJwBiKjLFd03C89ZRr0P+URyOh3t-7oqKv3vQzBdw@mail.gmail.com> <20230822230307.hps2zhd3acdjy7r3@emptiness>
In-Reply-To: <20230822230307.hps2zhd3acdjy7r3@emptiness>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Aug 2023 11:53:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJaYubxFHN6TEqTNicW-pdbBP=GQx70Sx-_0Po=p2d0ng@mail.gmail.com>
Message-ID: <CAL_JsqJaYubxFHN6TEqTNicW-pdbBP=GQx70Sx-_0Po=p2d0ng@mail.gmail.com>
Subject: Re: [PATCH] ARM: keystone: Drop unused includes
To:     Nishanth Menon <nm@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 6:03=E2=80=AFPM Nishanth Menon <nm@ti.com> wrote:
>
> On 17:28-20230822, Rob Herring wrote:
> > On Tue, Jul 25, 2023 at 6:35=E2=80=AFAM Nishanth Menon <nm@ti.com> wrot=
e:
> > >
> > > Hi Rob Herring,
> > >
> > > On Mon, 17 Jul 2023 16:56:09 -0600, Rob Herring wrote:
> > > > Several includes are not needed, so drop them.
> > > >
> > > > of_platform.h is not needed, but it implicitly includes platform_de=
vice.h
> > > > (for now) which is needed.
> > > >
> > > >
> > >
> > > I have applied the following to branch ti-keystone-next on [1].
> > > Thank you!
> > >
> > > [1/1] ARM: keystone: Drop unused includes
> > >       commit: 630c191b3396c6aaccab1234f8834848a2c42e8a
> >
> > Did you really? Doesn't look like this is in linux-next.
>
> Seems to have been there for a while?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git/log/?h=3Dti-=
keystone-next
>
> https://patchwork.kernel.org/project/linux-soc/patch/20230814160702.6l2fc=
ujbx33eogap@junction/
>
> $ git tag --contains 630c191b3396c6aaccab1234f8834848a2c42e8a
> next-20230801
> next-20230802
> next-20230804
> next-20230807
> next-20230808
> next-20230809
> next-20230816
> next-20230817
> next-20230818
> next-20230821
> next-20230822
> ti-keystone-soc-for-v6.6
>
>
> Did I miss something?

Sorry, I sent the davinci changes also with 'keystone' in the subject
by mistake and confused myself...

Rob
