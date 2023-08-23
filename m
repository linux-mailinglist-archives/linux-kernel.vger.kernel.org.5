Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A2E785F19
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbjHWSBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbjHWSBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:01:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B4110CA;
        Wed, 23 Aug 2023 11:01:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26f3e26e59cso82006a91.0;
        Wed, 23 Aug 2023 11:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692813692; x=1693418492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za0ufvKdvjn0lcKvQwI011LlLbPEuvnSecKdpqBM6Gw=;
        b=riMSJJFzc+QAcTd7+4ERamp4y3m0XbSpesh5wpsXi5qlEH4JKhdwK3MuFmaQHpcI+s
         GH74D7RfD8LR59GpGiNWBPmzj+AXBvKKFLv2vzaM6fASc2S2Ueqeu3N6E+NMPZAQnAGs
         j5k1ZMwEDAHoa2W7tNIgylKQxOY6chYiyF8dlJDT+mx9TYR/Z8wgJYWDsf2A8rEj4Phe
         3a06kIxsVLa5DPsecweWCB6TBH2l2bTVCXwQT71/nr8rYfvNewC8HXwT++Lk9JMQdv3S
         w19hVJN7Fad3JJxnRhuQ83qVo+jlPgCoD1QezWW8ImU18NTyXonR53tCgZOPdsRY4PJ5
         U3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692813692; x=1693418492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=za0ufvKdvjn0lcKvQwI011LlLbPEuvnSecKdpqBM6Gw=;
        b=SFZx3TAFR6+T093SgqLdGrKeRVfKJJS7Y8y+EYBjJ0TUa3GV0OTWAho8XQQbmcgl45
         JPYHC+TW0SpLi1BObz7Fw/z+sDWC664Px8zq/9gvWbTF4onM77oYA1sHkSBc07nQl5RZ
         cyVQlpkI8WUAEMOwGG502OBPwIEQgjzxt5gh9d9Kz0lQ5oJEAd9Qhp+eqy5C57FESh/Z
         lmhDrvHaQg7FUE+qu1GE0MzvulnNecX4CtHVfeUkxSHPGhol7CGx/7BhJJM96x0Hl5ry
         /dHP4KekczpGso01KWiLlaBQPfsFKxwYO36NVo2efXX1WdpiSeXPg5WFWn8ZxOzYJ3ve
         aaPw==
X-Gm-Message-State: AOJu0YzoxEGrLFqZGF9oto5HD23rMZ9DHSpzVTsot724pJq0bQ91Ajly
        RAvXcML0E3FQyg4QVXNkOpgZQAV71uwu5pHrKsI=
X-Google-Smtp-Source: AGHT+IGaFgLRmmYBXz7oKvMz+oQ+IVPL7kmlvpgZvMOuRSHCaR04XVL8ROZ4x8Wn+6Mew3e/zNjJh6XgMlu29ftLvVU=
X-Received: by 2002:a17:90a:eb14:b0:268:2af6:e48c with SMTP id
 j20-20020a17090aeb1400b002682af6e48cmr20283189pjz.4.1692813691908; Wed, 23
 Aug 2023 11:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230816100113.41034-1-linyunsheng@huawei.com>
 <20230816100113.41034-2-linyunsheng@huawei.com> <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
 <20230817091554.31bb3600@kernel.org> <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
 <20230817165744.73d61fb6@kernel.org> <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
 <20230818145145.4b357c89@kernel.org> <1b8e2681-ccd6-81e0-b696-8b6c26e31f26@huawei.com>
 <20230821113543.536b7375@kernel.org> <5bd4ba5d-c364-f3f6-bbeb-903d71102ea2@huawei.com>
 <20230822083821.58d5d26c@kernel.org> <79a49ccd-b0c0-0b99-4b4d-c4a416d7e327@huawei.com>
 <20230823072552.044d13b3@kernel.org>
In-Reply-To: <20230823072552.044d13b3@kernel.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 23 Aug 2023 11:00:55 -0700
Message-ID: <CAKgT0UeSOBbXohq1rZ3YsB4abB_-5ktkLtYbDKTah8dvaojruA@mail.gmail.com>
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

On Wed, Aug 23, 2023 at 7:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 23 Aug 2023 11:03:31 +0800 Yunsheng Lin wrote:
> > On 2023/8/22 23:38, Jakub Kicinski wrote:
> > > On Tue, 22 Aug 2023 17:21:35 +0800 Yunsheng Lin wrote:
> > >> As the CONFIG_PHYS_ADDR_T_64BIT seems to used widely in x86/arm/mips=
/powerpc,
> > >> I am not sure if we can really make the above assumption.
> > >>
> > >> https://elixir.free-electrons.com/linux/v6.4-rc6/K/ident/CONFIG_PHYS=
_ADDR_T_64BIT
> > >
> > > Huh, it's actually used a lot less than I anticipated!
> > >
> > > None of the x86/arm/mips/powerpc systems matter IMHO - the only _real=
_
> >
> > Is there any particular reason that you think that the above systems do=
es
> > not really matter?
>
> Not the systems themselves but the combination of a 32b arch with
> an address space >16TB. All those arches have 64b equivalent, seems
> logical to use the 64b version for a system with a large address space.
> If we're talking about a system which ends up running Linux.
>
> > As we have made a similar wrong assumption about those arches before, I=
 am
> > really trying to be more cautious about it.
> >
> > I searched through the web, some seems to be claiming that "32-bits is =
DEAD",
> > I am not sure if there is some common agreement among the kernel commun=
ity,
> > is there any previous discussion about that?
>
> My suspicion/claim is that 32 + PAGE_SHIFT should be enough bits for
> any 32b platform.

One additional thing we could consider would be to simply look at
having page_pool enforce a DMA mask for the device to address any
cases where we might not be able to fit the address. Then in the
unlikely event that somebody is running a 32b system with over 16
terabytes of RAM. With that the DMA subsystem would handle it for us
and we wouldn't have to worry so much about it.
