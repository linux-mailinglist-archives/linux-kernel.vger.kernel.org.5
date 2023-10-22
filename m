Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEDE7D212D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 07:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjJVFxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 01:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVFxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 01:53:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB60E126;
        Sat, 21 Oct 2023 22:53:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507ac66a969so2851216e87.3;
        Sat, 21 Oct 2023 22:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697954014; x=1698558814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmTFA4Fe0lNk5XVCq7JFR5JNdHnS2vqAdz0xdH5/1WE=;
        b=jnY+vqL1GDxEdxG0KiXeInpoB298qJkNKrinzzRQDl5nk7szxuVMDiP2PoCfbClXr3
         tXXZEguDzGWMmih2q9+uoFdU6n29KSbQndMbKk9YurQNb2Ii8zx9BzdYkvoiyekv6Ibb
         Dxx9KfGiv2+SOhtf13OYPcZfbPAeh7K42ULfkopes03CmDhh3OWYdb2Gtxm9ND86UJQx
         bBU+5n8l6yUMyqaaO3EfyIy9BPWNzcHPpKRUCpqEt2qo9Jww2RAz0XVWSy4arUM37Z+T
         pZcWmiUIWF7KFw95CGyArhO2ejNEqSPjMt5DRrzIdhQeltDg470AI3Ofk89vyMsHY+aU
         Qn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697954014; x=1698558814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmTFA4Fe0lNk5XVCq7JFR5JNdHnS2vqAdz0xdH5/1WE=;
        b=KFa9sv2K23OugebO3RqLB4YSZ3vGXJlJRLoZXNi2b2oH++ULBzDThqP8bVcTP4p/fG
         HGZf8i+fYcPxqZeqpm+e34p0UilzkfWT7i+AU/eU5oWA6jbAHGgrgTlcQEkxa9bKoQjh
         6cs5BkxSqaCvXRMef3Sc594cbMscbaIEfraj7WU6PMapA48ClDIyHNgdBiv5732PZU29
         2GawH73lnPRdlYK1D2zPQmgl/AY/K1+WotdHAJuKHa3oyk54B+aWQB/0KqKpjAaKzwsD
         UfyZ5utnur2iQSo8A00DjZ5ef+ZyeFQ4OwVs8y0a5VA/ozEKhDwr4fH6yE3+prmHQasv
         F0mQ==
X-Gm-Message-State: AOJu0YxYGouBBfwM3TUzbQegwX3YfeWL70Pc/9hVeRFFmbbJbCTg+nkr
        APopM6hlCRB4eZhjkGTCeXkfNqEjN6QC5m/jW8g=
X-Google-Smtp-Source: AGHT+IEYP1qsIcdpEKXs4OnftIXhimf6rJ0k/K7YdWNDZK4kmP/EOPGQhJwAOX++uJrox3E/b8g5MjfImM/OVXlSdmY=
X-Received: by 2002:ac2:5046:0:b0:507:cd53:5847 with SMTP id
 a6-20020ac25046000000b00507cd535847mr3555991lfm.56.1697954013635; Sat, 21 Oct
 2023 22:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231020061158.6716-1-hkelam@marvell.com> <CAM0EoMkawLKubMdrTOAcOhYq8Jicc5XuXuytBVi-yy-_QgiTuA@mail.gmail.com>
 <PH0PR18MB4474C304575E55092A2C7377DEDBA@PH0PR18MB4474.namprd18.prod.outlook.com>
 <0329924b-a868-49b9-ab98-0b3f8bd545cb@intel.com>
In-Reply-To: <0329924b-a868-49b9-ab98-0b3f8bd545cb@intel.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Sun, 22 Oct 2023 11:23:22 +0530
Message-ID: <CA+sq2Cd51mYHbSsjUKL23MbLkHr=oKYWvuubspg37AEo2fE8vg@mail.gmail.com>
Subject: Re: [net-next] net: sched: extend flow action with RSS
To:     "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc:     Hariprasad Kelam <hkelam@marvell.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 1:43=E2=80=AFAM Nambiar, Amritha
<amritha.nambiar@intel.com> wrote:
>
> >> On Fri, Oct 20, 2023 at 2:12=E2=80=AFAM Hariprasad Kelam <hkelam@marve=
ll.com>
> >> wrote:
> >>>
> >>> This patch extends current flow action with RSS, such that the user
> >>> can install flower offloads with action RSS followed by a group id.
> >>> Since this is done in hardware skip_sw flag is enforced.
> >>
> >> Our typical rule for TC is we need s/w equivalence for offloads. How w=
ould
> >> this work in absence of offload?
> >>
> > [Hari]
> > Our typical rule for TC is we need s/w equivalence for offloads. How wo=
uld this work in absence of offload?
> >
> > This patch we added as an extension to receive queue selection in hardw=
are.
> > This patch "act_skbedit: skbedit queue mapping for receive queue" enabl=
ed receive queue selection in hardware
> > and skip_sw is enforced.
> >
> > Adding stakeholders of this patch, to get their opinion.
> > sridhar.samudrala@intel.com  amritha.nambiar@intel.com
> >
> > incase of RSS, hardware makes decisions about incoming packets before t=
hey are even received in the queue.
> >
>
> The skip_sw for skbedit receive queue action was enforced as the only
> other alternative was a new hw-only action, or changing the action
> mirred. See discussion at
> https://lore.kernel.org/netdev/20220921132929.3f4ca04d@kernel.org/
>
> Few questions WRT this patch:
> How are the rss groups created? ethtool rss contexts? Any reason to use
> TC to direct to rss contexts over using ethtool context ids?
>

Yes, RSS groups are created using ethtool.
Ethtool ntuple is very limited in expressing flow rules and since the
general direction
is to use 'TC', we are attempting to add RSS action to 'TC'.


> IIUC, skbedit is meant to only edit skb metadata such as mark, packet
> type, queue mapping, priority etc. Even if this is a HW only action and
> has no use in the stack, would skbedit be the right fit here?
>

The thought was to keep related actions like RQ, RSS group etc under
one action ie skbedit.
If that's not the right place we can add a separate action.

Thanks,
Sunil.
