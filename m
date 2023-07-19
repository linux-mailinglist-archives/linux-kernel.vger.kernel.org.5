Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42BC75988C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGSOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjGSOhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:37:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A337710F5;
        Wed, 19 Jul 2023 07:37:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9939fbb7191so193718266b.0;
        Wed, 19 Jul 2023 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689777458; x=1690382258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLiCt95ygV41kuZf9pX1cXwrEnN2OwQXL7Y8MwA/vjc=;
        b=OyLcAVb026kFo928Hy3s1W+mPe+iulgMNXBvR9EpvChGg9Gydpc9dQDdcU7AEPRriL
         ighvJf16NYasg4aV/9TjA4clHitRmHAisnla+yi5FyN6dw0wPq4bAINmZqyjhSwz5kpe
         gZ801AHmgwGJ/iSbUpwUyBgiyhJFuR5m1DyHqkiyqFkOvrqhHaWqC6BejFbZ+pSw2ffo
         C79R5Osz6/qKjz8y7faz8knUyBl51h9WHcLga9OEKb+y7Kt5lLYp+fCmW4trCWdYogbR
         gqFYnb3IHsDOiU0+bCLYOKPdHLnmOQsOIWD/EVq7s1mtfap97NdLpUjH3VxLFpRT5jlk
         lW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689777458; x=1690382258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLiCt95ygV41kuZf9pX1cXwrEnN2OwQXL7Y8MwA/vjc=;
        b=JO93dIDH/2bfF6AS+nj+BAs3lmcNsSJNQ65FnaOjfgiLs57IyncnO0/16g1HC+4UKR
         HVIUhq5ycXYrXMVi38qOftmM1SGHDoF2tKgv05icVm3aM9xzZ9XN3lpGwiXhwo4Ya9Sv
         1jvm9e0qAwVWHLD+oVwNMuTnO7ngKKYEnCN0Xcp7h5rMmlNL+EFNGKCKm1HLdpyYK324
         hmV/ap9e2+DMS7nEJ3oEfCFJtCT896y+ug2sjhzkQdlid8r9tLSdTntszfdWEtY2Z2Jr
         sIrjB3SVDgeofUCsPsTMQDijXI5CLO2/G59pzIXIA3WkUunHcpTIX1oZpMA8PfszKQpe
         8I+Q==
X-Gm-Message-State: ABy/qLbYn4IMYUKLVtThn1duDRrcMEH14S2QlInww6QBIfXt+M+UPouw
        o4YVeR3SztN+WHx62M7YtAFKzvIrCXTVjgV0Mbk=
X-Google-Smtp-Source: APBJJlHvLAd11eHo8p4btHRTHFKMuq/1+lumsya3iavDjF5xiaMW7akyP7F5aQv7cVawl2wAzQxcsVt2Jm3RMy8ClbI=
X-Received: by 2002:a17:906:64d7:b0:993:f127:2391 with SMTP id
 p23-20020a17090664d700b00993f1272391mr2767082ejn.32.1689777457867; Wed, 19
 Jul 2023 07:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230717205357.2779473-1-samuel.holland@sifive.com>
 <20230717205357.2779473-3-samuel.holland@sifive.com> <CAJM55Z8Q-kGFKhFc57_Ew+0VsmBqwLrBAaiaiJ5zYdu_OG-wMg@mail.gmail.com>
In-Reply-To: <CAJM55Z8Q-kGFKhFc57_Ew+0VsmBqwLrBAaiaiJ5zYdu_OG-wMg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Jul 2023 17:37:01 +0300
Message-ID: <CAHp75VfxGP+N3KmAb2wcCZiDypsXBKxKwC9H_4WZ5ByM-Qo=5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sifive: Allow building the driver as a module
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
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

On Wed, Jul 19, 2023 at 5:12=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
> On Wed, 19 Jul 2023 at 08:26, Samuel Holland <samuel.holland@sifive.com> =
wrote:

...

> While you're at it maybe also add the MODULE_AUTHOR() and
> MODULE_DESCRIPTION() macros.

+1, as now we have a new warning that MODULE_DESCRIPTION() is not set.

--=20
With Best Regards,
Andy Shevchenko
