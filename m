Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8133B79D731
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbjILRH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbjILRHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:07:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A72D1710;
        Tue, 12 Sep 2023 10:07:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-502934c88b7so9483310e87.2;
        Tue, 12 Sep 2023 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694538466; x=1695143266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL7MyqLp5Ltk2dlKSxArA64ehXB/n2DZ7FckeLMxSeU=;
        b=Cahj0BLBNXk2POxVzaS2r7Hz3bTvEbEr8O0/eMIM7JdUuaeBTyvfjMgRhkoZJxnzxE
         MfxdLsXnVUvN6YyfWkRAj6BBbzXO58fcDtaJeX47IWtfor5xeVOL1ixbCs/BgFEqAg00
         zDw5bGctJh2cDJFXWCJAGPMVgh9IuYKzQguGsCQ5dVTHmPMwPz69NH2ZXbnm2vm/NkZL
         KU+ued56aQJcaHZRmgfChmjB0hQPR2mKRQqGNlnJhFYbBBwQcu7wO3haGT0U4yQk+tqM
         MVh0FCuAMKz1UmCHZgeDMVwqOeCh71tQ+A8g0BKC1WfQafh9tAdn1UcTmjcTUESnso6z
         YMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694538466; x=1695143266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL7MyqLp5Ltk2dlKSxArA64ehXB/n2DZ7FckeLMxSeU=;
        b=IFmz6eTudzLIuiLCJSlziKL3uxLpC0v3hxhr9k67t5tvHaQRncIw9iYLTiJLpdMBL/
         iolV6rmwHEhCyQz+/CYABfV54lLo3VK2z+mxbXjoshdxnIWRA8IggJIq75w2hsTUJgba
         F+k0vn5zLuG8QxQXZRV7YOs+CEYTy4z627za2EcHObvjrejhPg8svV6D2AWS6a0iyM2W
         yG1kvRnCG/xT/4aesYELMFhbxfxRNE8ZiR7EyZiObTwIpSsaI9LyHE3NFGwzVC5ejt9Z
         LcH8BnnuVs+wEzMg04ZHMd11uG3wJCAkSfVqn26HvfR9GJrWUEIylUl734i6MRKh91Xc
         2Vhg==
X-Gm-Message-State: AOJu0YxsLixCPPrTzcryjzXDbkAPpBWkw90DxavrrdMBdWMxT1ZcLvzp
        BF3BtN9jtchRDXa0iM+pkY6cp82rE0FbQlDCpKQ=
X-Google-Smtp-Source: AGHT+IHqIVPppW66u0UK7ipERkpm3zGAIUc4T/5xRvEo1k9V9BXZ+5tMa6CrWbpOFNqLtgZ4SXIBTkNpyAojGAP5Hyc=
X-Received: by 2002:ac2:58c8:0:b0:4fe:3724:fdae with SMTP id
 u8-20020ac258c8000000b004fe3724fdaemr82576lfo.66.1694538466120; Tue, 12 Sep
 2023 10:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
 <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
 <20230912152031.GI401982@kernel.org> <ZQCTXkZcJLvzNL4F@smile.fi.intel.com>
 <20f57b1309b6df60b08ce71f2d7711fa3d6b6b44.camel@redhat.com> <ZQCaMHBHp/Ha29ao@smile.fi.intel.com>
In-Reply-To: <ZQCaMHBHp/Ha29ao@smile.fi.intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 12 Sep 2023 10:07:35 -0700
Message-ID: <CAADnVQLk4JRKXoNA6h=hd25bmCuVP=DM0yRswM0a=wgKuYbdhA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 2/2] net: core: Sort headers alphabetically
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:05=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 12, 2023 at 06:53:23PM +0200, Paolo Abeni wrote:
> > On Tue, 2023-09-12 at 19:35 +0300, Andy Shevchenko wrote:
> > > On Tue, Sep 12, 2023 at 05:20:31PM +0200, Simon Horman wrote:
> > > > On Mon, Sep 11, 2023 at 06:45:34PM +0300, Andy Shevchenko wrote:
> > > > > It's rather a gigantic list of heards that is very hard to follow=
.
> > > > > Sorting helps to see what's already included and what's not.
> > > > > It improves a maintainability in a long term.
> > > > >
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com=
>
> > > >
> > > > Hi Andy,
> > > >
> > > > At the risk of bike shedding, the sort function of Vim, when operat=
ing
> > > > with the C locale, gives a slightly different order, as experssed b=
y
> > > > this incremental diff.
> > > >
> > > > I have no objections to your oder, but I'm slightly curious as
> > > > to how it came about.
> > >
> > > !sort which is external command.
> > >
> > > $ locale -k LC_COLLATE
> > > collate-nrules=3D4
> > > collate-rulesets=3D""
> > > collate-symb-hash-sizemb=3D1303
> > > collate-codeset=3D"UTF-8"
> >
> > I'm unsure this change is worthy. It will make any later fix touching
> > the header list more difficult to backport, and I don't see a great
> > direct advantage.
>
> As Rasmus put it here
> https://lore.kernel.org/lkml/5eca0ab5-84be-2d8f-e0b3-c9fdfa961826@rasmusv=
illemoes.dk/
> In short term you can argue that it's not beneficial, but in long term it=
's given
> less conflicts.

I agree with Paolo.

This is just code churn.
The includes will become unsorted eventually.
Headers might get renamed, split, etc.
Keeping things sorted is a headache.
