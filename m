Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B80679BFC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjIKUvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjIKIau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:30:50 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F21A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:30:44 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58cd9d9dbf5so57819217b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694421044; x=1695025844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zg32rEjDoEu1PGtZXp8/wlZ/iracuYWkm4l5HOAONA=;
        b=lyLDxFL1wVOZ7k/WPri6lhg/tsmjUDsAAfEEyaVfsOtt7U1Dgpn4awR0J1qgAiF7DR
         /o0kBZbohR/r6uf+EueBWiJmmsioRVrwBDJnEUo0Hi7VgQWdWeo+4M42xGMMGL1n+usR
         vxA72pL8pNbZdewu2CTj2nP7/A948nJBZj8h95nlNrW64bXDOYvPipSk5Dv9zcKWvvUG
         9kMmtNHzPnl+XLkJL8SAKhkAjLOa0DM58W5mGSk0J7kj0jyDQLIi0QSvWotURtrxUXLs
         tTbNouqxUuLW1uYeWWt5xsi2J8h4solAzigYCRyFeonpmmDnv8rQMnn87+RBYd7IChU0
         a0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694421044; x=1695025844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zg32rEjDoEu1PGtZXp8/wlZ/iracuYWkm4l5HOAONA=;
        b=nJvnqZpuHflzsGaVLzqGJ/B5uzjsSKDJNFRArL9+FTQxLMZWALrz2fFyssKpQAoAVw
         91Ng2Am6jsqDmFLDM5PSFw+8yZRA0MV1iYj1rU3tzui6KJNmu73EORMjBT6Av6Ce+zjp
         6ggjht+bXhgwhCz1nM9ELjxwtaPL1AlY/H0q7+qDHzXhpKzH1Eygd2Gc6Sx0gNlMapCQ
         yBzZBRbucAw8N1XO6/lxnPfFveYYp9Au/ifHEbjHHUbhGBf1R5pq4dNADk8VrmCLAYkW
         uVfWk9/3pGSRsD2dcugtPSYUyyMxr17yFmAhTHZ6iJhfFq+42ZoklVYmu2sabeFyfYxk
         /exA==
X-Gm-Message-State: AOJu0Yzl7RlmeWe0B/b7Rk3ktdjEUYq7ep11gUXPUE3yBBIOoMNBIgDx
        HTGAnX2u35Ot2fHjmZ0sC8rKG8u4HQg/vpW4Yh7/ZHLxZmyHIXUw
X-Google-Smtp-Source: AGHT+IEsImXmgKAD+TfIJklngPhS36fxrDS3Xx+JJKqoNkLnTxt1qEzhUft5sCOswiucbrguccWzTWb5PXFTld19dXA=
X-Received: by 2002:a81:4ed1:0:b0:58c:5598:be97 with SMTP id
 c200-20020a814ed1000000b0058c5598be97mr10510731ywb.15.1694421044046; Mon, 11
 Sep 2023 01:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230907145230.44085-1-brgl@bgdev.pl>
In-Reply-To: <20230907145230.44085-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 10:30:33 +0200
Message-ID: <CACRpkdYU5=jJ+hi3gKMT4GJe6_kAH8gw02Qt+kf-Lz7eu93Bmw@mail.gmail.com>
Subject: Re: [PATCH 1/5] gpio: mockup: fix kerneldoc
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 7, 2023 at 4:52=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The pull field of the line state struct is undocumented. Fix it.
>
> Fixes: 2a9e27408e12 ("gpio: mockup: rework debugfs interface")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

For the whole series.

Yours,
Linus Walleij
