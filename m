Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA707849CC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjHVS64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjHVS6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:58:55 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1135E10B;
        Tue, 22 Aug 2023 11:58:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-565dc391be3so4005809a12.0;
        Tue, 22 Aug 2023 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692730732; x=1693335532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMyfxQQilaBubbW3wGRgmW0tc+84+eoy31aD07H9r/8=;
        b=mf8WIHUy5I40f/poa4qIGPBl9adfXpEUk6KuWSpmJ8xQmqRCdcdIJ6zyEXiSZXIc5w
         pwjHmWSz/MxGYvLPndfzkYpUpf13Q1cOySv5Ui+TQYEySS1rVc2XrjfRVaGQHvV/wFh3
         D+ZuE3Oa2GuaRn10Og0Zb6tEiC8iE00FHMt8bEeNmUPbtgrmF8jN/byVPFVHRNaNrXaD
         JM22Zv8KgCKlLT0X7E5kh8yNaEz3wPKKmKx/JfrkoFqkYJUxWrUK2ojHUriCuBpwTubt
         +nG9jdcZ+1aereFSTxJvLJW9PDs4/ZHCchk1Yuu1KP1aum2nKnUnycAsnWAV/IDs59qP
         5/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692730732; x=1693335532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMyfxQQilaBubbW3wGRgmW0tc+84+eoy31aD07H9r/8=;
        b=T15enWh2/5e9/fBzPEjhw+Ugp2OrT4N7fKSEixVBJRCMKI99jxCakcFkXIsvsuHSFM
         1Zfkm8fIis1HJkyreMsy2f6cq0AjL4OMsfxx8X26geNFaUj8pIfuSQAn3iGD061aDuPZ
         g/zSfdMEhsVeT2F/RwloTIHwfCfDpRN5yabxCK+hOey//L0k5l7PFltYTfLvuqoXG3vF
         5AXgJJr4afkoyMgBPLcrQqlc8umHgS0sXH/nQUOw6zz1fhqSi7ZVY08CwDlZlVM5b4Bd
         0snCL1cgjnUKFJJCfUTF0Xr4kjCUMqo6vf86VbTiYCJ5xFTqgx0m/JwmEEIU7qJz+WzG
         jtig==
X-Gm-Message-State: AOJu0YzIqFi7QZXwLPMdsDJ59X3UpcxcMyVSb50JG0cfz2iiEZDGwY4H
        k3uCywgKjKp3IZguBcz3I3bGTQVQcG7OEaHj1YM=
X-Google-Smtp-Source: AGHT+IG9PzxN2qjUzvLCPXojUKSBaNVsLHsu/rAxr6f0t5D78639H/6I/7eYCGZ6K1tHAw8jGDLNNHHVTusTz3UB0zw=
X-Received: by 2002:a05:6a20:4414:b0:12e:44:a1a6 with SMTP id
 ce20-20020a056a20441400b0012e0044a1a6mr16469440pzb.11.1692730732425; Tue, 22
 Aug 2023 11:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230816100113.41034-1-linyunsheng@huawei.com>
 <20230816100113.41034-2-linyunsheng@huawei.com> <CAC_iWjJd8Td_uAonvq_89WquX9wpAx0EYYxYMbm3TTxb2+trYg@mail.gmail.com>
 <20230817091554.31bb3600@kernel.org> <CAC_iWjJQepZWVrY8BHgGgRVS1V_fTtGe-i=r8X5z465td3TvbA@mail.gmail.com>
 <20230817165744.73d61fb6@kernel.org> <CAC_iWjL4YfCOffAZPUun5wggxrqAanjd+8SgmJQN0yyWsvb3sg@mail.gmail.com>
 <20230818145145.4b357c89@kernel.org> <1b8e2681-ccd6-81e0-b696-8b6c26e31f26@huawei.com>
 <20230821113543.536b7375@kernel.org> <5bd4ba5d-c364-f3f6-bbeb-903d71102ea2@huawei.com>
 <20230822083821.58d5d26c@kernel.org> <CAKgT0UeyRSa6LC8rmA0ottkTdYo3bv36THnCe2Yaba0xca5BHg@mail.gmail.com>
In-Reply-To: <CAKgT0UeyRSa6LC8rmA0ottkTdYo3bv36THnCe2Yaba0xca5BHg@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 22 Aug 2023 11:58:15 -0700
Message-ID: <CAKgT0UfeUAUQpEffxnkc+gzXsjOrHkuMgxU_Aw0VXSJYKzaovQ@mail.gmail.com>
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

On Tue, Aug 22, 2023 at 11:30=E2=80=AFAM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> On Tue, Aug 22, 2023 at 8:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Tue, 22 Aug 2023 17:21:35 +0800 Yunsheng Lin wrote:
> > > > .. we should also add a:
> > > >
> > > >     WARN_ONCE(1, "misaligned DMA address, please report to netdev@"=
);
> > >
> > > As the CONFIG_PHYS_ADDR_T_64BIT seems to used widely in x86/arm/mips/=
powerpc,
> > > I am not sure if we can really make the above assumption.
> > >
> > > https://elixir.free-electrons.com/linux/v6.4-rc6/K/ident/CONFIG_PHYS_=
ADDR_T_64BIT
> >
> > Huh, it's actually used a lot less than I anticipated!
> >
> > None of the x86/arm/mips/powerpc systems matter IMHO - the only _real_
> > risk is something we don't know about returning non-aligned addresses.
> >
> > Unless we know about specific problems I'd suggest we took the simpler
> > path rather than complicating the design for systems which may not
> > exist.
> >
> > Alex, do you know of any such cases? Some crazy swiotlb setting?
> > WDYT about this in general?
>
> There may be scenarios where if bounce buffers are used the page may
> not be aligned. It all comes down to how
> swiotlb_tbl_map_single(https://elixir.free-electrons.com/linux/v6.5-rc7/C=
/ident/swiotlb_tbl_map_single)
> is called. In the IOMMU case it looks like they take the extra step of
> passing an alignment value, but it looks like for the other two cases
> they don't.
>
> Changing that behavior wouldn't take much though. Basically we would
> just need to do something like look at the size and address and if
> they are both page aligned then we could specify a page alignment for
> the DMA mapping.

Actually I take that back. It looks like in the bounce case there is
already code that will look for PAGE_SIZE aligned blocks if the
request is for PAGE_SIZE or larger. So there shouldn't be any cases
where a PAGE_SIZE request is not PAGE_SIZE aligned in DMA that I am
aware of.
