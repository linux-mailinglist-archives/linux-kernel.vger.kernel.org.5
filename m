Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC0E75110F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjGLTRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjGLTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:17:04 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062EE1994;
        Wed, 12 Jul 2023 12:17:03 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6f9edac8dso114592161fa.3;
        Wed, 12 Jul 2023 12:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689189421; x=1691781421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKUU6pO05tC6nslWQtTK7aayznxqpJZOlTSHV8yJb9A=;
        b=O/uUoRFYLM7U2NaSQXgscGqN74q0Yg2vt7V9h/3r7QIr97BinTaq7rwWN02QRsAdQL
         XAHhIr6NlO8mIugdArNXlEGF4v4Eled9AlUq9ZwzizdhHDF9icc76Rukho5sQcyy/TuZ
         awFn6wh87++yeUIg73kky9mAyS+AAkJzuMtfX0Z+iuPkKUh+0xOy+X+suIinN27RcQ1w
         ByeW+pft8rq3yPk32YhcO6QKFbox2mwhy8mPCcWQG+XuPiILbpozwWc3GFSaoInnMHbw
         1m/uov2UsL6ErM33f6++xonSk1O9x43XZgHwual2C4wUxJERw+ntGlT5My+UcznueaFF
         C5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689189421; x=1691781421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKUU6pO05tC6nslWQtTK7aayznxqpJZOlTSHV8yJb9A=;
        b=T2X/b3HvLCtBZskx2m8CMFqJg6POQcz3xL0LLmqukpD9d8H4JxRMp5dLoqGHp49ZGz
         50fArM/zYtzMKzsXeXzAj+OCdn1riqmHb+FH9Hoe62J7lwr+rMh4hYLv9ow2nTwmS/iq
         lIa9b72k0P0n+s2Ovy73akWaqBrPFIDg8snS/PswiEkrQiBeufsGf2MkvLVwXJ4nSphU
         asgTAYO+pJBT7vUyeBsCVi944Rk2aHQ2E/SQPEztp0JtRZkYHSB8/UV4MTJB7z7p4rO7
         ncv94B8GKx/puI5IWF+hKRw1rulQd16mePWuP1Ce91qzLqL38LHK+UhpdPMOLsXmX4cu
         C6aA==
X-Gm-Message-State: ABy/qLZxWv5GVO9rxH4Bfy6AimATTIoSS3AKAa+cG5ocekq/WexFJ3T1
        w+yDteDIRDtYqkkKeeOLvempHvBJGi+Fc9V0Mtk=
X-Google-Smtp-Source: APBJJlHlwAYxZ65C1c8Q9ugKnNqaqVhSE8j/kXJRI74ytBCcaZP3PKX256L5y5qffFlFMFUarMeHGX0208iENFWAJ54=
X-Received: by 2002:a2e:9b4f:0:b0:2b7:2ea:2e27 with SMTP id
 o15-20020a2e9b4f000000b002b702ea2e27mr16092031ljj.19.1689189420809; Wed, 12
 Jul 2023 12:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230712184011.2409691-1-sumang@marvell.com>
In-Reply-To: <20230712184011.2409691-1-sumang@marvell.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Thu, 13 Jul 2023 00:46:49 +0530
Message-ID: <CA+sq2CdCw1OT_ChVg_95ALzPX-1LWyiHUSsThor7O3J7Jm3Nmw@mail.gmail.com>
Subject: Re: [net-next PATCH] octeontx2-pf: Install TC filter rules in
 hardware based on priority
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Jul 13, 2023 at 12:10=E2=80=AFAM Suman Ghosh <sumang@marvell.com> w=
rote:
>
> As of today, hardware does not support installing tc filter
> rules based on priority. This patch adds support to install
> the hardware rules based on priority. The final hardware rules
> will not be dependent on rule installation order, it will be strictly
> priority based, same as software.
>
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   9 +-
>  .../marvell/octeontx2/af/rvu_npc_fs.c         |  10 +-
>  .../marvell/octeontx2/af/rvu_switch.c         |   6 +-
>  .../marvell/octeontx2/nic/otx2_common.h       |  11 +-
>  .../marvell/octeontx2/nic/otx2_devlink.c      |   1 -
>  .../marvell/octeontx2/nic/otx2_flows.c        |   2 +
>  .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 315 +++++++++++++-----
>  7 files changed, 251 insertions(+), 103 deletions(-)
>

>

Suman,

net-next is not yet open, please check the status here
http://vger.kernel.org/~davem/net-next.html

Thanks,
Sunil.
