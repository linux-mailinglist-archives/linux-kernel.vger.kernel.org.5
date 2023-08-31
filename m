Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFEA78E6BD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbjHaGqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjHaGqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:46:53 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07297A4;
        Wed, 30 Aug 2023 23:46:51 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-26d0d376ec7so371958a91.2;
        Wed, 30 Aug 2023 23:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693464410; x=1694069210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hwsn/fhLrXXqL5sdshf2nxUI7vcdgz+hyuqbEx4WJpU=;
        b=XSwoOqw9iye92fg49LCWJoD7tbwBLcr0w/4Sb0L481G36aNuk4KV+RCkBlhQo9zTzP
         CRfdbL0DY+JIpi0egfl3RtgxTd5JJ5h7kQTv6bEWUdWD2wRFbbWqBEE7EwlJzMH9w747
         ezY7ZBDLQ/j03KYTPGxv3DRq7jfIDzcIKF3SqJXk52k1NEVJND2ZdxISjdd896+Nflqe
         7KPJ55s2YZiCKn4x/3mUwdETcBA83soCz16jsqSrdLp4fki5REvTUrY9slRCjQ/I4Hr6
         JfLB7xuJdEIWvImLjmte/UrQkeexjH4oBkQ2eWQY2gtCfBA0unk9wbcBVWAEw/p/gFFm
         FOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693464410; x=1694069210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hwsn/fhLrXXqL5sdshf2nxUI7vcdgz+hyuqbEx4WJpU=;
        b=h/GVZ4ct3u91HpBljzZ6JYWTFqYewU1UOWYdlf7SqNbFK0dz9Va22B31GHLiZhUpnR
         1lBvF5vpKwh8JDffUtwIs/V7VWONJWTxB+jFgx++vBUUAHnEldH9sUHkhUtEGULcjQ55
         NgKRzf9MKWHhiIjR36qk6/syRpFRqKbF3dyQBBV5/JmVijJJH7U8GA5X3gCnlUnt9tur
         CkplZ91YjM5H7IT9MYe/l1bv7rAxjGSDG5EuWcYST6y7S8XYQoF640zCjyMks3+gBXrN
         M3yXKH220KCuw8ZVFQux6D01Azm4UagVk6NdIE5bweQMXC8azxLZ5Rbyz6LCH2qbkZG8
         tG5w==
X-Gm-Message-State: AOJu0YyyZPRn65P/OL8MLggvpXIsHMXEJ0zIH3Q6D+DGmoGFezB3DHUv
        QafHM06Rw4F77KejIhVsXvy6PEgePIDcMmUX82U=
X-Google-Smtp-Source: AGHT+IFoRkwGonaGpiH4PQM+abnBEm7q/IGhhzLOeOQMfiF7bwrsvt1J75ta+aGQdSdMdA5GtegUPiVAwRqS5tw0MIA=
X-Received: by 2002:a17:90a:bb15:b0:26d:227c:9068 with SMTP id
 u21-20020a17090abb1500b0026d227c9068mr4164858pjr.16.1693464410160; Wed, 30
 Aug 2023 23:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230725030026.1664873-1-zyytlz.wz@163.com> <20230815100844.GA495519@google.com>
 <20230829134616.GA215597@google.com> <CAJedcCyFqJiXa9QHM6-Mg1ezF2tOKkyv2ukoOu+_T3YAdEhWdQ@mail.gmail.com>
In-Reply-To: <CAJedcCyFqJiXa9QHM6-Mg1ezF2tOKkyv2ukoOu+_T3YAdEhWdQ@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 31 Aug 2023 14:46:38 +0800
Message-ID: <CAJedcCxE3gbiF4_MTeTXNpcr4zPA0KtBw_qEq_pP8x=3PhVo5Q@mail.gmail.com>
Subject: Re: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
To:     Lee Jones <lee@kernel.org>,
        Simon Horman <simon.horman@corigine.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, s.shtylyov@omp.ru,
        linyunsheng@huawei.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, geert+renesas@glider.be,
        magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        biju.das.jz@bp.renesas.com, wsa+renesas@sang-engineering.com,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

After reviewing all comments about the patch. I agree with Jakub. But
adding reference on net_device is a big move. All related drivers must
modify the code.
For now, I couldn't think a better idea about the fix. Thanks for your
effort and sorry for my late reply.

Best regards,
Zheng Wang

Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=B8=89 12:30=E5=86=99=E9=81=93=EF=BC=9A
>
> Sorry for my late reply. I'll update another patch later today.
>
> Best regards,
> Zheng
>
> Lee Jones <lee@kernel.org> =E4=BA=8E2023=E5=B9=B48=E6=9C=8829=E6=97=A5=E5=
=91=A8=E4=BA=8C 21:46=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, 15 Aug 2023, Lee Jones wrote:
> >
> > > On Tue, 25 Jul 2023, Zheng Wang wrote:
> > >
> > > > In ravb_probe, priv->work was bound with ravb_tx_timeout_work.
> > > > If timeout occurs, it will start the work. And if we call
> > > > ravb_remove without finishing the work, there may be a
> > > > use-after-free bug on ndev.
> > > >
> > > > Fix it by finishing the job before cleanup in ravb_remove.
> > > >
> > > > Note that this bug is found by static analysis, it might be
> > > > false positive.
> > > >
> > > > Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> > > > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > > > Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > > > ---
> > > > v4:
> > > > - add information about the bug was found suggested by Yunsheng Lin
> > > > v3:
> > > > - fix typo in commit message
> > > > v2:
> > > > - stop dev_watchdog so that handle no more timeout work suggested b=
y Yunsheng Lin,
> > > > add an empty line to make code clear suggested by Sergey Shtylyov
> > > > ---
> > > >  drivers/net/ethernet/renesas/ravb_main.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > >
> > > Trying my best not to sound like a broken record, but ...
> > >
> > > What's the latest with this fix?  Is a v5 en route?
> >
> > Any update please Zheng Wang?
> >
> > --
> > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
