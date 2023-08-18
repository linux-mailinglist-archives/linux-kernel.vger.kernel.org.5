Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F1B780715
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358567AbjHRIYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358571AbjHRIYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:24:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1398726BC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:24:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26d12558d63so431890a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692347052; x=1692951852;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMABurkuzxcCubHL/AM70WvfxJrrtNaP5ENFaFyth9U=;
        b=ITiP4gQsAEWOkAqOU/2TBCZdsneLAAsLvkDYb2/LeUtjotEqtvXrgOO7ZmN4uFeDPa
         eQGPC21Hk5RVxImw/llxv5kfBbRzizyy97mVwax8opipAl1nq1EqoUjKp2viAJrJruQD
         aTUHx2xA3paksduun5MU2NANRX18Hqfq8pBmq5xa2KKRN77aPqrBJUzkECa8GCWIoPrW
         3/BQdwV05E1yztutgQQEz/Ozg1mKPT1ZwigUUwcxLptNa5UblkS2NiIkSwvHNFeKyloL
         Tyd9EyvN7vX2jyXyj5kyZmTbz/svS2xikm1GOa4BcnERpBxY4QFnxGiT+GJyfxDcdUbt
         SL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692347052; x=1692951852;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMABurkuzxcCubHL/AM70WvfxJrrtNaP5ENFaFyth9U=;
        b=kSgjOrNEjwc+mHTkqDGoqXaXN6w+xBVNGfz1QUHX9maQgrV04oPNBuiFmNI1Xful53
         AUzSB7y6ZCE6RRwkJfjBuLKmj6wYqHWwtgleAi12yv9A6tHulO4OtglfVxopUF+3ZxFt
         bYPtCzok/2CeSiooN/vjUcbRIsgxFt33l7kEks/K1mXpyBQN5ngd+EpzP8OAccj82CDg
         FmNRtj6DR3jZbej23CBj3bdBjqW9I/j3N5bZYm/hwzYmtNniWXhF5qYfZbh3N4qIVDb0
         mQ2l+XLzDylZdNVZVecPnP0YYY27vfP13imBbZZ0fEv5jn1ilidHkdXgPziwxaubni6k
         KH8Q==
X-Gm-Message-State: AOJu0YzN5xrDQJAd2fF4GnZ2RKiS5Rvw45/TjV2eMI7IQwy/5bkrAXTX
        +wxmLimWa1V2LvgSmZj3KaCJXyDQZvtjUo/VPMNTKrBtj24=
X-Google-Smtp-Source: AGHT+IHluHVI8uqhig9TEbDsQ+IxbXGWS59dC0lSLiEVoYgBXxLFbi0DHhBEsL9GBH8YXn0yx/2Y3vbisNBE81B+mRs=
X-Received: by 2002:a17:90a:b017:b0:268:fb85:3b2 with SMTP id
 x23-20020a17090ab01700b00268fb8503b2mr1690034pjq.7.1692347052438; Fri, 18 Aug
 2023 01:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <ZN8oV98hs1Kt0KzS@nam-dell>
In-Reply-To: <ZN8oV98hs1Kt0KzS@nam-dell>
From:   Nam Cao <namcaov@gmail.com>
Date:   Fri, 18 Aug 2023 10:24:01 +0200
Message-ID: <CA+sZ8B_hQHw9vH0=epF9q2Uo72ynUjtExiJ9vx0Nws2sCjdZAw@mail.gmail.com>
Subject: Re: where is TASK_TI_KERNEL_SP defined?
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Aug 18, 2023 at 10:14=E2=80=AFAM Nam Cao <namcaov@gmail.com> wrote:
>
> Hello,
>
> I'm not sure why but I cannot find the definition of TASK_TI_KERNEL_SP. C=
an
> someone tell me?

Nevermind, I figured it out.
