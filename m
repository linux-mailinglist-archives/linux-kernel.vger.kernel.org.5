Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6AA7BFAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjJJMJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjJJMJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:09:19 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466BE94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:09:17 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7a7e9357eso15969157b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696939756; x=1697544556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEaEMkX8vOBOdzxYFvJA9DgnPvy6/WwAYugNg849Uvw=;
        b=CcR9sARPY+YNl/5TT4P/jcN/awaRsn37ZxpPJO9y2VJEcMnSCIDqv11N/oPEg3gM6W
         dNaiHAqjtNFruWYrGGX9ZTsZysKZzjOEWUtU1C7EFbC4apdBiUHl5GWdYHmr/QH0d2gi
         dcCogU32IUS7I6BtpEjMR1n5usmCwpm3BaGkYJV643Hwo+Mf7zw9O5pJJoso/p4SmdUO
         kvxRvK45QVzC8ZljpLLN4BDVyzZRMsMe+uITUZ/I7BEA2aGJLVSbaedxWMz5q+GF7XeV
         dvNNnH0MOiTTNPNmnQKD6ViCaavd6fX5vZulvTdcVcwpmQwx0JyrBTEhTb1+AddmKsWE
         V3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696939756; x=1697544556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEaEMkX8vOBOdzxYFvJA9DgnPvy6/WwAYugNg849Uvw=;
        b=tmxSKvYBpaJprds1v2H1FmZejdeodAkPH66q8bv8lSbjNG5XwHjx21DUkuwT4c0xQI
         n7+gDLFqMTa+SmTOUMRV71QC8hSQFRg/BEGDwYY/eG+aNQDklalfVA/jCDHnh9bQe1uo
         YC5AiTckBwpQSQjS9iFq0dbluvR/y/wwgtrlQjuDmHxrVjt+cxzwSmNmQ5ivNqO2vm/L
         /j5yQfaUg8R3zBuJwL+Jlh91d7+nLgmhIv7/IZablBgftDWtkS6EcO4NFssFI3AKkDmh
         qGSEUDwFQ0wBabdB96BpFpNCQ6MVnCwLIYEXYB35PH1zxMAqXGfhLyUTy1ih+/lKJI1M
         1ifA==
X-Gm-Message-State: AOJu0Yz3O9CXlow5T5MXykeeFHwJQp/DSBBOW6/CAYUHgSo41Hy4UOkm
        KGYf2+BVu4uFi/d+Toy4dTR8g1+5/TMRsu8l3xxfZA==
X-Google-Smtp-Source: AGHT+IHRGEq7DdXjBkp0ZcsqBXe3LfpagEhnnJNKWYx9uqyU6eZI1qB/e8NPka/ZmWvype1vTBLGlZHCNknfRy93KUQ=
X-Received: by 2002:a81:5b02:0:b0:583:a3ab:b950 with SMTP id
 p2-20020a815b02000000b00583a3abb950mr16029722ywb.50.1696939756492; Tue, 10
 Oct 2023 05:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3@eucas1p1.samsung.com>
 <20231006125557.212681-1-m.majewski2@samsung.com>
In-Reply-To: <20231006125557.212681-1-m.majewski2@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 14:09:05 +0200
Message-ID: <CACRpkdZULAeKE_DZX9RVhu0tSutdB_wMgoHhonB3H8DAdjKBEA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix Samsung pinctrl driver static allocation of GPIO
 base warning
To:     Mateusz Majewski <m.majewski2@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mateusz,

On Fri, Oct 6, 2023 at 3:00=E2=80=AFPM Mateusz Majewski <m.majewski2@samsun=
g.com> wrote:

> The object of this work is fixing the following warning, which appears
> on all targets using that driver:
>
> gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic=
 allocation.
>
> This needs a small refactor to how we interact with the pinctrl
> subsystem. Finally, we remove some bookkeeping that has only been
> necessary to allocate GPIO bases correctly.

I see that Krzysztof has already taken care of this series so I just
wait for a pull request (some days work is a bliss, thanks Krzysztof!)

Yours,
Linus Walleij
