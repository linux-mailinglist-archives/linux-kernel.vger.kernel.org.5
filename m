Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD786753A5B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbjGNMIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjGNMIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:08:23 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF51730ED
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:08:22 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-783698a37beso73060939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689336502; x=1691928502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16R55gbmSXiUXNQxWIymx0I+9penedcTPq9wO+7lCos=;
        b=y7REO+92dtiIq5DKsoK3i79K/GnZSa/0jsg3cYmJ61hmgl+xGQi99YOyPD8I6hC90M
         uEVjY0HxmwMjSqIBEW2L2jSWB7fPRl+viANMkl6lB12vQamLIfw6RX96y17x8aZrOnZE
         FJKVhrTYfT7jR4HCSsvJhujjait9JKKT2rxxcljLx1DYdJT+MfehkAGS2szwGq/+YV7e
         oiMcVoajwbImsrbWDE8CQI72B0O8XgrU2KlzdweygcP7IPBPblgFPLkZec/FvOk4rbTu
         w9Qsg++U0F2Z7Fv3DpwvEhzezoSeZKdg/1R24iTz/Vs//zsr4EFutglEzCa7uwQTbgcH
         2Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689336502; x=1691928502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16R55gbmSXiUXNQxWIymx0I+9penedcTPq9wO+7lCos=;
        b=NGXgGyStUjohafNPUs4Rvmko2bSrRVTTARmmCOl1KpbAMmFA7fv6OXQlvjsDRUcJbC
         PntlK93daz+RFa7Y7yU4elDaxAHnu6iq/GOO/P4TEmF3EsRVt6iPAnkpJ2KFsm4LHnC/
         oDMlkmC3XY0Po+abA5g2AMpAfwuCylhemGGXVlzQ6r5Gqr3UjC/Pyye1VksOHbZZ+d22
         ryjsQmYyM91m7BR87PHJuHFpohoghVfbRXxWlx/17eNGAZ/jUw/XD5hWWxraCNEJ+QCW
         dnvGCwCoRxzo94NKJCPOXpON/DlTTjNrdMCW7BJrAwDnU6ppuC0ydxS7ePR0jP6ft1mX
         SYrg==
X-Gm-Message-State: ABy/qLYPtwjUE+O1gJasSb3FqBsmZfZV/hQNstKgDhBJWt3z2kpN13j1
        tHnB1gPdSLCWk0sVHJyk6mYB1f2zprLpZ4YKIDcvzA==
X-Google-Smtp-Source: APBJJlEwFYgIUXPPJElRO68HwWFqWYYSyd6C+l4du1rFD3cDPeB7/6KVej7KINqm9RfTK1Q8xzx//FIEVChIy9gkIZ8=
X-Received: by 2002:a6b:3c0c:0:b0:785:ff35:f340 with SMTP id
 k12-20020a6b3c0c000000b00785ff35f340mr4602898iob.14.1689336502095; Fri, 14
 Jul 2023 05:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230713125706.2884502-1-glider@google.com> <20230713125706.2884502-2-glider@google.com>
 <ZLA0TwHZOgAGCgKX@smile.fi.intel.com> <CAG_fn=WsPC_qMZfbVQHbXq_cGXP4ZfYkyGyJPzaAKSqurxoibw@mail.gmail.com>
 <ZLEBgGSsmOPs4Zu5@smile.fi.intel.com> <ZLEvM1s65L1k0PTx@fedora> <ZLExRvCytbxBcUef@smile.fi.intel.com>
In-Reply-To: <ZLExRvCytbxBcUef@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 14 Jul 2023 14:07:45 +0200
Message-ID: <CAG_fn=XFBFByn7i1aw69rttJK9GZWSge81aa8yTK=qFZYAE7AQ@mail.gmail.com>
Subject: Re: [v2 1/5] lib/bitmap: add bitmap_{set,get}_value_unaligned()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 1:28=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 14, 2023 at 07:19:15AM -0400, William Breathitt Gray wrote:
> > On Fri, Jul 14, 2023 at 11:04:16AM +0300, Andy Shevchenko wrote:
> > > On Thu, Jul 13, 2023 at 08:05:34PM +0200, Alexander Potapenko wrote:
> > > > On Thu, Jul 13, 2023 at 7:29=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Jul 13, 2023 at 02:57:01PM +0200, Alexander Potapenko wro=
te:
> > > > > > The two new functions allow setting/getting values of length up=
 to
> > > > > > BITS_PER_LONG bits at arbitrary position in the bitmap.
> > > > >
> > > > > A couple of years (?) ago it was a series to achieve something li=
ke this with
> > > > > better (?) code. Why not resurrect that one?
> > > > >
> > > > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2195=
426.html
> > > >
> > > > It looks more compact thanks to GENMASK, I can cook something based=
 on
> > > > the proposed bitmap_{set,get}_value (and change the names if you
> > > > prefer the shorter ones).
> > > > But I'd better avoid pulling in the rest of that series without a s=
trong need.
> > >
> > > William, what do you think on this?
> > >
> > > I'm personally prefer William's version as not only it was published =
first
> > > it was carefully designed and got a lot of review already. We just ha=
dn't had
> > > the user for it that time.
> >
> > Yes, that version went through several revisions so it's been well
> > tested and known to work -- as you pointed out it just lacked the users
> > to warrant merging it into the tree. If it statisfies the use-case
> > required here now, then I think we should it pick it up rather than
> > reinvent the solution again.
> >
> > Also, we probably don't need the "clump" code in there, so perhaps
> > splitting it out to just the bitmap_{set,get}_value relevant code is
> > fine.
>
> Agree, thank you for your comments!
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
So would it be fine if I split off bitmap_set_value() and
bitmap_get_value() from that series and send it (with the appropriate
attribution) instead of my patch 1/5?
We'll probably still need to retain patch 2/5 (with the function names chan=
ged).
