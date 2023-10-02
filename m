Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558FB7B5BCB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbjJBUH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJBUH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:07:56 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C818793;
        Mon,  2 Oct 2023 13:07:52 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c2907ff9fcso1559921fa.1;
        Mon, 02 Oct 2023 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696277271; x=1696882071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzzKZoEmdCGE7S1RXteRn52a8Z5fDrSNy3okgZBM+pc=;
        b=VDsZXbGMk82TElpM95ipyLgSyNqNJsZ//EAIfNVloi0WOowYJJIGyhCrPKGvZH/c1l
         R10sjdXjUzbH6+thwoK6zSQIM9KQ5dZpvcb/h75z1MkXN1RMlGtPQJbGcLTQSSpYdA2O
         PZjm1RrJpncLik4u+h5E+Siu0A7/27mB8PU8WLqJ6HCgO9gW8hQVagt9NFdsc2atonrx
         emasOfYTCr+VBxzpNQ/eatuULYHGGfb0E6qw9qy/TTMsYVkUn+EqxQvwXWcwHykcyS2f
         iCmiEWHfJ0bbYB/KjCPqkLsdCXg7DVaivYZJuuCBhUYCYtyyJJUwj6U7OGSgVxbGczPi
         XGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696277271; x=1696882071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzzKZoEmdCGE7S1RXteRn52a8Z5fDrSNy3okgZBM+pc=;
        b=Oox5r9W2VNMFeuZo6i7Y68mkf8X3qFLDmRGpdN/RXrAWJF8Drj4QVndMGmiyNZSKaM
         BPN1dfiX2SV7MLPzLy+6MPL9lQPyxTeNJw4WeEedT1dYznCCGQyu9aTWsAEj39TWfyQb
         hpq3yKwzkZhrVZZ/pp61GQ4r6BR5GdE8eYAjkOIl1d1cfjY7753aVjq065eIqa8dASHc
         LjLZ1hDxQY7S0V2BmNeHkDM2brO9u2I54utDUe3Dl1j2QgIJO7QIV3fV6jisKM18qaxI
         +iTWRsYZn4mQbLr50wIg7Qy52NWQuEiHDwYGFE4Y6Z9Li5CJdJuAQIOty8Sh6syGOp9H
         FvWw==
X-Gm-Message-State: AOJu0YzfOERQJU9KznhH8JqcTXTk4BeNRQtpm+L+qx4N3+Mzyfgzt0xx
        T9uHNdRViR/lZeC7SG8b46wg7c6JMP6gOT+CfeM=
X-Google-Smtp-Source: AGHT+IHfAwfrbZiXrWiDIVYFKatdO7nPRT0KeuksW27VNFvfFxPfriAmuquY7kqLS5l/DTLOc9tMmisPbwCaGXu9QRo=
X-Received: by 2002:a2e:868e:0:b0:2c0:cd8:2bdc with SMTP id
 l14-20020a2e868e000000b002c00cd82bdcmr10560836lji.24.1696277270845; Mon, 02
 Oct 2023 13:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231002194138.125349-1-tmaimon77@gmail.com> <20231002194138.125349-3-tmaimon77@gmail.com>
 <CAHp75VfDcqTAVhZmo-q8v8c8TKwZUjQMr2-0RBarYDDJD1+TZw@mail.gmail.com>
In-Reply-To: <CAHp75VfDcqTAVhZmo-q8v8c8TKwZUjQMr2-0RBarYDDJD1+TZw@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 2 Oct 2023 23:07:39 +0300
Message-ID: <CAP6Zq1gnjDUSWqe2aNMfMx-Ksdx_Mw6skCu4ecRC4na2A-UNkg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ulf.hansson@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, adrian.hunter@intel.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, openbmc@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

Thank a lot Address in V5

On Mon, 2 Oct 2023 at 22:46, Andy Shevchenko <andy.shevchenko@gmail.com> wr=
ote:
>
> On Mon, Oct 2, 2023 at 10:41=E2=80=AFPM Tomer Maimon <tmaimon77@gmail.com=
> wrote:
> >
> > Add Nuvoton NPCM BMC sdhci-pltfm controller driver.
>
> ...
>
> > +       pltfm_host->clk =3D devm_clk_get_optional_enabled(dev, NULL);
> > +       if (IS_ERR(pltfm_host->clk)) {
> > +               ret =3D PTR_ERR(pltfm_host->clk);
> > +               goto err_sdhci;
> > +       }
>
> ...
>
> > +err_sdhci_clk:
> > +       clk_disable_unprepare(pltfm_host->clk);
>
> Now this is leftover that leads to unbalanced reference counting.
>
> --
> With Best Regards,
> Andy Shevchenko
