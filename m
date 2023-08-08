Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4347737BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjHHD2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjHHD2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:28:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9C91BF2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:27:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so28545e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 20:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691465261; x=1692070061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiGQp3FsAI04kcNtST/Tl1pJkj2vxq4v0LWaXPyZsOc=;
        b=pTn2KPnbpACRR1QoEDcr3ERxsHMj/OGG5vXUuUYjUIU9vaSomJncuphTCfIQ+V2jnF
         tuxaRrPri4lngxFMKN+lzupIJKyPzJY6nWDPXUBV3uZJyHiN061bifLJJKL1mEdh4Zc/
         1ZZZfF3vN5E4yc269EtGzxSwcgvKeTBrxeUQoDw0m5pTsHk06h6+eeSczXGA3bnEew9v
         Nh5ds2u/V4BlrnZURcfuVZBtEJpP1qpOo/czVYss5a/IuZ1SGP4k1se4KCifowq+EIOT
         fEnIu8rxXpbrKg4BgZkCbUGUYIVm5vkOz5UeICXSIJN5mKqoA8F8hwA46l7UAQu6fidZ
         6c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691465261; x=1692070061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiGQp3FsAI04kcNtST/Tl1pJkj2vxq4v0LWaXPyZsOc=;
        b=JZtKS4L0TiWnQSLyYajJGdp5+lnQULTss/8jRtd6Fwp3mNDLyJ7jgpol85bFVjqOj8
         JNbyoKWDlHDahkmSZpMWmU0R1ym8geX/arIUUby0HfpJM4P22pK/1IP8g1PMYpUpYNYY
         9QxJaUjk0MAaKv3NbZt9g0qne1s84qElhEI+c3LVLjWiP3qsmKeFe5Ndikqj3DGoosFj
         Oucvxpweyxx/+pnUjsXSqk2cydQtUPHhy43gkOPWlfZijQf4iV2lA/HT5tV0dcTXSRq/
         /Ce3S7sfYk4MpVZ2mQ5TGq7jSe5lWteGlSNhKpJziS3BYSM4ARoRXdedAd6rvl5jp9cL
         YSYQ==
X-Gm-Message-State: AOJu0Yy8eqZHuwuGPNb5pt9xFfFjpnJjluZVzBvZh2QD/pUh8/1auXSy
        5AxWBz07+HhbmljS/+Ilpb7+1Q/OZ2NQEQI0ryIw
X-Google-Smtp-Source: AGHT+IHNklvPNz0M4NW5KZIZXX2bW3bL4rd8brH9A51j5QvubhasYCcxYJoodGdcImm/oRHisG2hKp4tUyZlyR0ad8Q=
X-Received: by 2002:a05:600c:1d88:b0:3f7:e463:a0d6 with SMTP id
 p8-20020a05600c1d8800b003f7e463a0d6mr296502wms.0.1691465261438; Mon, 07 Aug
 2023 20:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <12d34340-6c94-4bfd-aa16-3c39026070d8@paulmck-laptop> <20230728032232.816584-2-paulmck@kernel.org>
In-Reply-To: <20230728032232.816584-2-paulmck@kernel.org>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 7 Aug 2023 20:27:29 -0700
Message-ID: <CANDhNCpCrwbMp8oTwvTab+-Q1b52zJvMuZiV9LW-bP2Zgqqyhg@mail.gmail.com>
Subject: Re: [PATCH rcu 2/2] torture: Add lock_torture writer_fifo module parameter
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com, Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 8:22=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> This commit adds a module parameter that causes the locktorture writer
> to run at real-time priority.
>
> To use it:
> insmod /lib/modules/torture.ko random_shuffle=3D1
> insmod /lib/modules/locktorture.ko torture_type=3Dmutex_lock rt_boost=3D1=
 rt_boost_factor=3D50 nested_locks=3D3 writer_fifo=3D1
>                                                                          =
                               ^^^^^^^^^^^^^
>
> A predecessor to this patch has been helpful to uncover issues with the
> proxy-execution series.
>
> [ paulmck: Remove locktorture-specific code from kernel/torture.c. ]

Thanks again for improving this!  I've switched over to your version
here in my test tree.

Acked-by: John Stultz <jstultz@google.com>

thanks
-john
