Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3757D219F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 09:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjJVHU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 03:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVHU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 03:20:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76E5C2;
        Sun, 22 Oct 2023 00:20:20 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9d922c039so18330515ad.3;
        Sun, 22 Oct 2023 00:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697959220; x=1698564020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTMy4jRMjdPSok66h5pvXOKtTYMVZRMrenI1NsIR3i8=;
        b=Y5undhitor7bZPDwO4DCLA/lgmQzw3VUrI5h7jENG2ht22tUsampundGD/KNPkARpq
         o00GVWCVXmcYq/LbgGwNyJ0UBOP5KmPXtPIXN4XhsGCcvl7rxhH+AlseZYa9pT0qH1ZV
         t10Yde9eteVZcRBqM8a7LtqSt+TlQWA3ercIOM3zGJWzpUXq1dF6SdI2yHDlSib1IeJz
         dvRxNOzyimeFcBSn8Thx63Wmjl4+ZMQ+FCVtR6i/bU1uHKi/zG5kmJuli2Nwyai2npvU
         tFvlCtJvcgaolz4czxkEtZNVjTc7HSBzOP2OP9XK9WZZQ24qzPavQwvpWZZwIgk1bHgU
         szOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697959220; x=1698564020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTMy4jRMjdPSok66h5pvXOKtTYMVZRMrenI1NsIR3i8=;
        b=TzlPxyQtazuLFv0upSsHHYFd9qEv4zf0r/tu6SmhDfFa0Qmucv6q1j5ZsZEaDLTHXv
         hzA6h9OKa5H3qTyWebJuOxPfparvmZm2ljjPQ9Z4ZpKK7PB4nK5gvzlXGUcQL+/MSk+0
         gTqzm4g8dHOOwQtkFSSlJd2L24t7wxrioVQKk4w2nHLXZFvPOIGMo+A2F1ASqbfp4ztd
         vdKOgxSgcvcLp1SbyR1+ba81mMNmHXLRyAGKbg6Tfcr/24ixriPKY0sjyoxLciOCyXMJ
         28BGpOaWPVs7jYYZXRONwgyXxiglGtM6gFK380Xrxfpi9wHf/3sRXd9XiAPYTCgXYyYK
         54NQ==
X-Gm-Message-State: AOJu0YzKS4Oy6TMsO6aaqGvDlDmRuIMrj2uIanBx+3bvkiWX6Flo6eyk
        9ZLY31Ux+lg9Ylnl3NV+kYXpIxY00vbS135cFag=
X-Google-Smtp-Source: AGHT+IGrq1BbWBxZjWr9/xngYvuWV2Dt0B1uacT4bxHZZ4QuMYLFehe5KZuXx9ful0NTGvqgqtzMOrAbcq02kmppJII=
X-Received: by 2002:a17:902:ec88:b0:1c7:733b:27c7 with SMTP id
 x8-20020a170902ec8800b001c7733b27c7mr6767226plg.56.1697959220188; Sun, 22 Oct
 2023 00:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231020061158.6716-1-hkelam@marvell.com> <CAM0EoMkawLKubMdrTOAcOhYq8Jicc5XuXuytBVi-yy-_QgiTuA@mail.gmail.com>
 <PH0PR18MB4474C304575E55092A2C7377DEDBA@PH0PR18MB4474.namprd18.prod.outlook.com>
 <0329924b-a868-49b9-ab98-0b3f8bd545cb@intel.com> <CA+sq2Cd51mYHbSsjUKL23MbLkHr=oKYWvuubspg37AEo2fE8vg@mail.gmail.com>
In-Reply-To: <CA+sq2Cd51mYHbSsjUKL23MbLkHr=oKYWvuubspg37AEo2fE8vg@mail.gmail.com>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Sun, 22 Oct 2023 00:20:06 -0700
Message-ID: <CAA93jw4ZmG3A=20SpeXZeFP=4Xf=oAuK+tjwZrPR6zwtHdi9vg@mail.gmail.com>
Subject: Re: [net-next] net: sched: extend flow action with RSS
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     "Nambiar, Amritha" <amritha.nambiar@intel.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 10:53=E2=80=AFPM Sunil Kovvuri <sunil.kovvuri@gmail=
.com> wrote:
>
> On Sat, Oct 21, 2023 at 1:43=E2=80=AFAM Nambiar, Amritha
> <amritha.nambiar@intel.com> wrote:
> >
> > >> On Fri, Oct 20, 2023 at 2:12=E2=80=AFAM Hariprasad Kelam <hkelam@mar=
vell.com>
> > >> wrote:
> > >>>
> > >>> This patch extends current flow action with RSS, such that the user
> > >>> can install flower offloads with action RSS followed by a group id.
> > >>> Since this is done in hardware skip_sw flag is enforced.
> > >>
> > >> Our typical rule for TC is we need s/w equivalence for offloads. How=
 would
> > >> this work in absence of offload?
> > >>
> > > [Hari]
> > > Our typical rule for TC is we need s/w equivalence for offloads. How =
would this work in absence of offload?
> > >
> > > This patch we added as an extension to receive queue selection in har=
dware.
> > > This patch "act_skbedit: skbedit queue mapping for receive queue" ena=
bled receive queue selection in hardware
> > > and skip_sw is enforced.
> > >
> > > Adding stakeholders of this patch, to get their opinion.
> > > sridhar.samudrala@intel.com  amritha.nambiar@intel.com
> > >
> > > incase of RSS, hardware makes decisions about incoming packets before=
 they are even received in the queue.

Is there any way to do a LPM to queue match on inbound?

> > >
> >
> > The skip_sw for skbedit receive queue action was enforced as the only
> > other alternative was a new hw-only action, or changing the action
> > mirred. See discussion at
> > https://lore.kernel.org/netdev/20220921132929.3f4ca04d@kernel.org/
> >
> > Few questions WRT this patch:
> > How are the rss groups created? ethtool rss contexts? Any reason to use
> > TC to direct to rss contexts over using ethtool context ids?
> >
>
> Yes, RSS groups are created using ethtool.
> Ethtool ntuple is very limited in expressing flow rules and since the
> general direction
> is to use 'TC', we are attempting to add RSS action to 'TC'.
>
>
> > IIUC, skbedit is meant to only edit skb metadata such as mark, packet
> > type, queue mapping, priority etc. Even if this is a HW only action and
> > has no use in the stack, would skbedit be the right fit here?
> >
>
> The thought was to keep related actions like RQ, RSS group etc under
> one action ie skbedit.
> If that's not the right place we can add a separate action.
>
> Thanks,
> Sunil.
>


--=20
Oct 30: https://netdevconf.info/0x17/news/the-maestro-and-the-music-bof.htm=
l
Dave T=C3=A4ht CSO, LibreQos
