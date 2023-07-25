Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A11C762140
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGYSXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGYSXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:23:07 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525221BFA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:23:06 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-cc4f4351ac7so6506976276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690309385; x=1690914185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5yJxpU6xDG6OF8KLnCz3+16QubBrgDtPLOu99x0f+k=;
        b=odUBHZayifA8Q3Ee2DnhxQ9lBrv2pxZfnhsPxnsajjwuGiP3S10r/7gIdGifpD7FHV
         MvIOF8elF9HBBIsmg1pyGuISA+7Gmm4BuEKP/LU2AoDX3iZFXjE89i85m9KdcKRIc5B0
         gwh5Qaun4O7kOSGCGKEMDU7OMtWyf6Wf9HkEjyih1fmcQTyKYvnB4I/2Oj/i84nWcLZU
         lygrDhJ2JKqlmtiSVq9yQwjHO+ZZhchNRbrzTWUTUmD1XCwfU6I0lZAhels+NI1/n22/
         l0uzLftt8jSOFoJjSutvaqltNYjh4gJjuVaj4nIAvahV5GxnK9xgZDMalPBgLk6giZ/+
         KLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690309385; x=1690914185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5yJxpU6xDG6OF8KLnCz3+16QubBrgDtPLOu99x0f+k=;
        b=g9BLe+l7HGj2N0ZZcGJLdWz5AAUGwcmZIZ7+zAkHoeU47kufFPs3poRx3EE2sQN5dr
         /b+gaMbgRksFAEF78YgFopRoYLXJII7aYcoFweYrzfXKnNY3UFWllBbadjFPWNLVsFt6
         /9CLnsj8UsoSIVvvQ1ykMYyXTXM5dU4LQ6GF+rDitzWrBQs3K5HiGtzZecmQ5DY1n6ss
         Rkk56DKY3EhrsdUKE+vDE3YeSJieUqeDLjgniBluh7T14HlbMDkuNKPFJn6oBpyS5mup
         tuWaMFNdfB10JplUl8od07yvPUPKwtLqkil0dMVVD/0gDiEIJXOyQUDBndSG6ADlVBiU
         KVXA==
X-Gm-Message-State: ABy/qLaWrq5bBcnBginarIEwjTu8+2xd1lFDT8QU9Uk9+Zg9NM3CKKVK
        +yQCC0Cd4ko7f3tYvA09rOA0upe70nD4T3kPbggcmw==
X-Google-Smtp-Source: APBJJlEYujHAzIBUdxeqCcqRIaJLIz/gGWkCCmtMC4KMe82w8HOo1f30KheaXVSB1T+tfJLhBiwxEWpd91aypJAi9zo=
X-Received: by 2002:a25:6dc2:0:b0:cac:e20:90e3 with SMTP id
 i185-20020a256dc2000000b00cac0e2090e3mr9515996ybc.63.1690309385295; Tue, 25
 Jul 2023 11:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230719152007.197710-1-arnaud.ferraris@collabora.com>
 <20230719152007.197710-3-arnaud.ferraris@collabora.com> <CACRpkdZ2Fu8jyyyDd4e1yq8g4bDoj2gCd4KnntST8uYvDNKUZw@mail.gmail.com>
 <0623ebc5-eef8-2c93-040f-eeeabc79ce17@collabora.com>
In-Reply-To: <0623ebc5-eef8-2c93-040f-eeeabc79ce17@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jul 2023 20:22:54 +0200
Message-ID: <CACRpkdY75A4NU3jyZfShNjd+mKhHmnNZY4+1YpAc=RanFBsX6g@mail.gmail.com>
Subject: Re: [PATCH v5 2/2 RESEND] drm: panel: Add novatek nt35596s panel driver
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Molly Sophia <mollysophia379@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 4:16=E2=80=AFPM Arnaud Ferraris
<arnaud.ferraris@collabora.com> wrote:

> Their magic number sequences are quite different, however all the other
> bits (power/reset sequences and timings) fit in, which isn't the case of
> the other novatek panel drivers. Moreover, they have similar (although
> not identical) resolutions.

Hm OK I guess.

> I found an old (2012) datasheet for the NT35596 (without the final "S")
> which is marked "Draft", so I'm really unsure this will be enough to
> make sense of those numbers.

I would try to add the most obvious cases. (Such as "command FF", I
am pretty sure it is clear what that does.)

As I pointed out in some other review, long term we want to support
things such as gamma correction for panels, and then this kind of
information will help greatly, even small pieces.

Yours,
Linus Walleij
