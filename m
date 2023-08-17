Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF73780150
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355891AbjHQWyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355885AbjHQWxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:53:38 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6EF2D65
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:53:36 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3492e8fb906so1177215ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692312816; x=1692917616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KniUMBT92oZj7fT7qN2uycdi3niZNLdHXUNCqhPvRlk=;
        b=clwfW/du9OluIW24MURiaUOQc8OWtsz/7I7JXg8dfwjUiRa7wjtf26mCM3BGuWzf78
         9S3n2dwc8hmMyCN1s8AFH27cTDc7y2Q3U8H3ZOaWx6ZvEk7xbHYWIfOLGCkIX9uEwiEh
         lRqTfjo9BbauIFNfioRIyYfFOzkV8JxUmy0QSH7U8QTSpl/N1SiaG+2G4JpYFjtaLWCG
         XpxSoqcSag8F0X1trivqneDWMxS5vC6JBMV+Dbk+tK2S4UiKolznpii2N68zJ4A9bKqS
         GkEkSM3nbkdwcu47CffiPtQzt1ePvzR8rKXtFrL3iTqQX4RikSRznwf85z46ARK09ryt
         zTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312816; x=1692917616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KniUMBT92oZj7fT7qN2uycdi3niZNLdHXUNCqhPvRlk=;
        b=dTlfqidDIX3L3aOJq/h6OETMT97MYzlwxcFZuMwsF3M3HZRu/YCOFKe4eMHy93xVLm
         xfB5J/WiMF5THuUlHsVV1xzvAXGDVrG4Mpad+JXlB+omegIMBLOhcd6DIcjCR0Y4v0uI
         S5CTe8yacZ+hFrAxXeCuAIqPk8TILYjuJRwAEEL9SFAzsntoqbdHADULA+F6HAnZ8NAJ
         dTo37PEdAD6/gEY6LIbcuTcQw7OGyL6c6XD2xHj+2IGGOgXvjoe4NlvtOUH9QwNP2hEB
         0LBONKMms4ava3UqTfxdwle++jndrDFIcgpFP7X3ZmNKUdvq5xSBp/liT+bufOt0idvB
         ydqg==
X-Gm-Message-State: AOJu0YyrpBM8B58dg0w1/PTza3GD/OLvc7FGe857SvPcnZtpbFa0h9wn
        qrl+ep/+LqYGuqFukDoAGeSwpn/EtPoC2neVyGU=
X-Google-Smtp-Source: AGHT+IFrBUPMu/bPjCTy+xRSKHysaPfQKY0KCqe9PXdSdMkcjklXThV1Jf/d7XkKBXEg3JtIvR12bKnmufWSexGYTTY=
X-Received: by 2002:a92:c0d1:0:b0:349:8dfa:ad64 with SMTP id
 t17-20020a92c0d1000000b003498dfaad64mr1082542ilf.15.1692312815736; Thu, 17
 Aug 2023 15:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230620194644.3142384-1-yosryahmed@google.com>
 <CAKEwX=OLR02MazB31wR-nphjZJvBHrm5Zy7hLPByZ3ubgO8mjw@mail.gmail.com>
 <CAJD7tkZ7dLwny7-CX7qCywZPtki+fDuESGfv+B9QG87cSsrHVQ@mail.gmail.com>
 <20230811141920.2f9bab6f21ab635ff1bd63ac@linux-foundation.org> <CAJD7tkbfKxCOoxNCgtbaAg4LXFbf=afaxei0SbKU2B=HFpPf6Q@mail.gmail.com>
In-Reply-To: <CAJD7tkbfKxCOoxNCgtbaAg4LXFbf=afaxei0SbKU2B=HFpPf6Q@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 17 Aug 2023 15:53:24 -0700
Message-ID: <CAKEwX=PDsYdyAq8s+A0-YQ7nQWVvJA9Tw5dNP6S1w6Rh==dQCw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: zswap: multiple zpools support
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 4:21=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Fri, Aug 11, 2023 at 2:19=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Thu, 13 Jul 2023 03:35:25 -0700 Yosry Ahmed <yosryahmed@google.com> =
wrote:
> >
> > > >
> > > > I'm experimenting with some other zswap changes - if I have
> > > > extra cycles and resources I'll try to apply this patch and see how=
 the
> > > > numbers play out.
> > >
> > > That would be amazing. Looking forward to any numbers you can dig :)
> >
> > So this patch seems stuck.  I can keep it in mm.git until the fog
> > clears, but would prefer not to.  Can we please revisit and decide on a
> > way forward?
>
> Johannes did not like a config option so I proposed it here as a
> constant (like SWAP_CLUSTER_MAX and others we have). This is a value
> that we have been using in our data centers for almost a decade, so it
> has seen a ton of testing. I was hoping Johannes would get time to
> take a look, or Nhat would get time to test it out, but neither of
> these things happen.
Apologies - finally have some time + freed experiment machine cycles
to put in your patch :P And gotta wait a couple of days to obtain sufficien=
t
data.

Result is quite unexciting - no tremendous gains or significant regression
in a bunch of internal metrics I was observing.

Of course, it's just one particular workload that I tested on - there could
be regression/gains in other workloads (or other metrics). But we can
always revisit this when it happens :)

With all that said, the code itself looks solid. And while I'm still not in
love with the change, I don't have any further objections, as of now.
I'll let you (and Johannes) continue from here.

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Tested-by: Nhat Pham <nphamcs@gmail.com>

>
> I obviously want it to be merged, but hopefully someone will chime in her=
e :)
