Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667EB7EB128
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjKNNqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjKNNq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:46:29 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C82D6B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:46:22 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a8628e54d4so46774807b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699969582; x=1700574382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nliPXMHTnBYGTGReWura9iw7kNKuYsUsSdl3m7Yb7x4=;
        b=iIsAT5CNFPuwdLLx17Byh3PFtj4b7/Sjzv5SHr1RhDOIjyWatTuRNu9C+iXkcDsqxm
         t53w9upp7Acy8n7VaHcrl1DPZ3HYrr6mOtuJwPaBEfOWryF9hLI5JJiQ17RKksOy3KXs
         ls21ouFECwwiXJqbjU3tX3vcr8xCuZmhNjh/TueNBUrMj4nZAyIMrU50BhYNJX4ZDN9K
         Q2ud3Ux25mx4Xg2ZMBjLh1x1KV1qdxNrcWK+H/xIxbqSyrZlshGhLSWUY3drBOiMjSg7
         1VmlmIDzbJVD4nVC4WzHCTLHIqeWJRzIeicPyfjzAUNvzVs20Ntqj1qiI9xNrhBJAMs6
         3EOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699969582; x=1700574382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nliPXMHTnBYGTGReWura9iw7kNKuYsUsSdl3m7Yb7x4=;
        b=MldEjM5i44qm4sFrh9MsYsBbCBbsXM5MMnDfP0hWaqX2HKOpw5nKKjBI4G72ti34B+
         7o89joI4v/cegTNNlp31/XDl/b07cU2p4wjrgMhnSh2q9mWQBq25f6TlvmM9xPySjcoU
         p8rR0mQNdXpthdfsDBqdeKYDPgmy2S+eUKTJUnbNK0/fOPuhgPuobRUcfKJCVFwYjhwU
         QBBNLu+BpS5xT3Krvd6tIng6ABcYDUFH4bj43tWF3pKgDnahQGWwkW3WZs0bPWW2fhSg
         9oCgF6sQmeXqV0z+k34u8mXMfNv3CXvZeWn44BaYxPwfqBR7mk+jPNlPqU5Auokopxmf
         5H5Q==
X-Gm-Message-State: AOJu0YxyR/7qPpOFjzdxmjdwAfyC5hMcVtTyFNWHdxQ4WNSAS4ZpH8Lf
        e/HTgXz1ECeyq4KBIJb+GCzfEzksckpK7wXdoVSKUA==
X-Google-Smtp-Source: AGHT+IHljeec9sFxlNUsrr+jfk+JbFvnr/ZZvguGt3cDWAtXFcsxBJ/HQEG8up18lILbAZk3cTqoqDwr9zZLzkya8eE=
X-Received: by 2002:a05:690c:3382:b0:5a7:f263:6873 with SMTP id
 fl2-20020a05690c338200b005a7f2636873mr1819095ywb.20.1699969582191; Tue, 14
 Nov 2023 05:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20231108104124.2818275-1-eblanc@baylibre.com>
In-Reply-To: <20231108104124.2818275-1-eblanc@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 14:46:10 +0100
Message-ID: <CACRpkdZqOiPFCkM2JAPnVam0Q5ciWs0p0_kHd4K=ML1qwKm1Bw@mail.gmail.com>
Subject: Re: [PATCH v10] pinctrl: tps6594: Add driver for TPS6594 pinctrl and GPIOs
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, u-kumar1@ti.com
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

On Wed, Nov 8, 2023 at 11:41=E2=80=AFAM Esteban Blanc <eblanc@baylibre.com>=
 wrote:

> TI TPS6594 PMIC has 11 GPIOs which can be used
> for different functions.
>
> This patch adds a pinctrl and GPIO drivers in
> order to use those functions.
>
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Patch applied!

Yours,
Linus Walleij
