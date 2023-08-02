Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C057276C2BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjHBCL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHBCLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:11:54 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51209213D;
        Tue,  1 Aug 2023 19:11:53 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1bb5c259b44so4638454fac.1;
        Tue, 01 Aug 2023 19:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690942312; x=1691547112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKQJaSiMRxLz83enNF9c3/5M/8l9/9RYd+HpJvD4GPQ=;
        b=jlE8NqhoWvMAe9M9/OGhFBGmaAbSboe5VmeieaJHgsxaTZEWZt9ivJFAs60r4GA46m
         nbsRGtnb/Dl+C19Ar0dyZzYWqlWDv7E7u1mvmY+o86F3jpEEJOc9d/rLzjZ9jQILb6R/
         YgD3c378ek8e1rtL6AkZqUSDj1+uymljJyyJzagxmraG1JgT+3yuTKe4ci16juCf5V4l
         fsLupVA8RJVj3/AT5g8DMUE8rcHLKjIQrP1MWKpuAjiBn/Ep7uUKUF5JD04NDLi67o/z
         j1nQYLkUwe11JefZdDVrumnno1XYnfJl6tcNl653driaQl2qeDmwoY1U0+6Gcew69BUO
         nKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690942312; x=1691547112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKQJaSiMRxLz83enNF9c3/5M/8l9/9RYd+HpJvD4GPQ=;
        b=LMq1+Mau/VyrD6FWfF+obRyu6h8e0h8LIOqEDr7lvPMyOBsx6IA9Bwl6ydH8mfjHoj
         bXJ5/4r7rykQq2vWaqnwun+GUPiAvPrdMOXtY9yOtjPwqCTd1W/QCYwMrYTmZ5uWqh61
         euftMhFWM97Vu7ijQjPorNqkxhVoNdEl3N7MwnTQ9kdOI+QCzPQvLCgqipCWPYZ1OZfQ
         dNGgZkSsSSCvDzmq7GRbQZOCj0CTJyEPesIXG1Y4c4/Xl4BCtLuB4m0HMeXmsrSLyyWD
         Lyk7sIfc/4PY/CfQh7gM82tVt8pibhsOb84Z7Z6b9SMHMVJ9oQi5ubxgctS8f0qTR/15
         2nGw==
X-Gm-Message-State: ABy/qLa65mYVcqeMVN9DwY1spEZ0f92KRmqHA7lOiQR1PinpP8hdtEVl
        oHNdzQ1YPhS4nKkFR0L/nV4GJkvUK5PhjNl8gqc=
X-Google-Smtp-Source: APBJJlER4x//DJEJE7A7FmpbPubfUfXIzhyvWK6lBXXwSZCsTtlDoIIjmx6MRsXRdhfJaxim/hXE84CijoKmrWxF3PY=
X-Received: by 2002:a05:6870:f695:b0:1b7:60aa:43f1 with SMTP id
 el21-20020a056870f69500b001b760aa43f1mr17528847oab.11.1690942312120; Tue, 01
 Aug 2023 19:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230720091436.399691-1-yunlong.xing@unisoc.com> <CAJfpeguygW3JY5L5d+87+V538hAWu2tL9Yksg5p-QMP3ppv13w@mail.gmail.com>
In-Reply-To: <CAJfpeguygW3JY5L5d+87+V538hAWu2tL9Yksg5p-QMP3ppv13w@mail.gmail.com>
From:   yunlong xing <yunlongxing23@gmail.com>
Date:   Wed, 2 Aug 2023 10:11:41 +0800
Message-ID: <CA+3AYtSYQEPR2txskm5VyXpZR8VqCdkX23NWdtfmTjp6WLQWvw@mail.gmail.com>
Subject: Re: [PATCH V3] ovl: fix mount fail because the upper doesn't have space
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Yunlong Xing <yunlong.xing@unisoc.com>, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhiguo.niu@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 1:43=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Thu, 20 Jul 2023 at 11:15, Yunlong Xing <yunlong.xing@unisoc.com> wrot=
e:
> >
> > The current ovlfs mount flow:
> >
> > ovl_fill_super
> >  |_ovl_get_workdir
> >     |_ovl_make_workdir
> >        |_ovl_check_rename_whiteout
> >
> > In ovl_check_rename_whiteout(), a new file is attempted to create.But i=
f
> > the upper doesn't have space to do this, it will return error -ENOSPC,
> > causing the mount fail. It means that if the upper is full, the overlay=
fs
> > cannot be mounted. It is not reasonable, so this patch will omit this e=
rror
> > and continue mount flow.
>
> Wouldn't mounting without upper (two or more lower layers) work in this c=
ase?
Sorry miklos=EF=BC=8C I don't understand what you mean.

The case is in  "ovl_make_workdir" flow,  "ovl_check_rename_whiteout"
will attempt to
create a temp file. The "upper" partition=EF=BC=88e.g scratch partition=EF=
=BC=89is
completely full=EF=BC=8Cthe
create will fail. So, the overlay mounting will failed


>
> Thanks,
> Miklos
