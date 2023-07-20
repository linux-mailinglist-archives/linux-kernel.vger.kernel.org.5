Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8277D75B7FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjGTTad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGTTac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:30:32 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFE6171D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:30:31 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a46da5cd6dso804707b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689881430; x=1690486230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ovbilqR1AJyAKu17jhe2zKoPE+uzJ6FwMN43SkdWAo=;
        b=ztA7KwqHjak2wfiKBerFpLdypaCN1ssviXihAe4JX+UN7frh0H4Dhxn7p/DKMZDTjq
         6zqHhTtcgUyPzpozJ/gPmL3QTgcyIobmM8B/z6BYx546fQVflYcTUsWTeQj799KVarjB
         FQgwrAcjc3xVODcctFcklFN9HtbH3RYyiDX/WQm7DY5/qJO5yquud7dX7Vw8kIsaMLDL
         yRJ34RyRvUNMzGww0uRwvzSGizNiy0enbpxbeCaXY+CwgPnN9W8eyGAdOBMS3KXVF8wZ
         qtKc00Okhtjk0epbuWgtcT8LMOuzvp0btQhCVPsdR/hMy9pjBS5T5JgxhiCc/7Mwpmtp
         XGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689881430; x=1690486230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ovbilqR1AJyAKu17jhe2zKoPE+uzJ6FwMN43SkdWAo=;
        b=PbKoPy8Mnee1BnluAB3jIhk62EOvyrLvkIpT9DFO828W4L2q8qopw2GWGvVrYYAYe6
         k23r7SNSPEnO30Yvm6O+ho3B0bCV1UpTH5Y5687jsMocmYNAS+pAefPwEy7QSjHeKne2
         chDr13pzyL1EVGXHRCzUjm6U4Z3V7xezRvXTGK6yCGlbGcJw1wMC4vzEOYMbQOe/fCyJ
         u2QC1zY8DpackvDz7av/sjONrVhxlYdfqgBwS0EmJgxdM4FsPSaG4bEWJJmUbtfgmIgD
         3JTMw5Wdph+n18VGJgyw+6AcWmZrNhzUnIT/M2OdV7yULzxxu7sc8FDWZ/wsi0EUl36U
         Be3g==
X-Gm-Message-State: ABy/qLYT0RWC8TnnkET/p1xzmcl43PS0kcokVrDhpl3HSaIPIyYyQk7c
        KJJ7z7FXWJ/iYxz5kNfeSip60b0S6UzQeMywsUAizw==
X-Google-Smtp-Source: APBJJlGB78Ba1YxlYKSiQYQpSgP4Qc+ZwLdhrhwvZSFXNfmHxCqWZmfu4tcCCQoTcgzKVBh1qY2pfnz1Lmr5Gh5FzrA=
X-Received: by 2002:a05:6358:990c:b0:134:d45b:7dd1 with SMTP id
 w12-20020a056358990c00b00134d45b7dd1mr20518414rwa.21.1689881430570; Thu, 20
 Jul 2023 12:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230712094857.218105-1-alex@shruggie.ro>
In-Reply-To: <20230712094857.218105-1-alex@shruggie.ro>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Jul 2023 21:30:19 +0200
Message-ID: <CACRpkdbEuXtv3OCbG3_WQguSFP=gprHP+6_80j7CU+o-JAFYkQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: 74xx-mmio: remove unneeded platform_set_drvdata() call
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        brgl@bgdev.pl, andy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 11:49=E2=80=AFAM Alexandru Ardelean <alex@shruggie.=
ro> wrote:

> The platform_set_drvdata() was needed when the driver had an explicit
> remove function.
> That function got removed a while back, so we don't need to keep a pointe=
r
> (on 'dev->driver_data') for the private data of the driver anymore.
>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
