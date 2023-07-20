Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792B875B3E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjGTQJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjGTQJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:09:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED7E1989;
        Thu, 20 Jul 2023 09:08:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so1320331a12.3;
        Thu, 20 Jul 2023 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689869326; x=1690474126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bNQ145SD9gJUUYcs3x/fi3m9w9C++tLcggQJSP0LH0=;
        b=reVTfqiyBw1foqbPbG2M1wDLQrA81Y2FGLbQOY87e1OWk0fXJhQRU7fpnzF54wSryW
         Cw8GnbXcLYt8wpsNGhvI8nb1EtICGOYLVhqmthAZWVgt+rcdS941QN7Kc7C6/o/Yhe6q
         avSKhv1REA5yDFLq361iggSXgu6fbnKgZuVqNJVqZebRq8UnnfMmd5e81faV3YJrnU5b
         JUPBCENfkBYNdVO8I9ohbCrQMPMG/WNgTxNiGKVUQicgUFJN/6MMO1WzkGaeZSHy3r4x
         wscURuoIGcayJIEsJ3VLEGrKAfVDpVuJ9tgHlRn0VrFKZ509O+nMRquVR4oG7My6KoWb
         4wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689869326; x=1690474126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bNQ145SD9gJUUYcs3x/fi3m9w9C++tLcggQJSP0LH0=;
        b=LHrFx/8LfUABgrkb+/rZH4ByhI5s1bEgu7PByowylqnEdhQUGSmFJuj6KW1R8UaCP+
         DfY5TdMGVaon8iXj2u+5xcIelWrxJEBQmaMSVuM8qR9mCLvvHo0lEu+RbxA3tdXpCTkt
         siSz8BY6pjOKqkF5/S6S/TTkrMXWK7Cude+NeyLvcthearGo5KWwE2klArUXRR630joi
         cXs0XRrLpuF0/5Vugqw/HnNepvixWGhUAmA//ATrFb/OwwO9mnzXdjfluON/V+WMTWJZ
         dBsge8xTn2OOwLzvjeh0QZoHk1EhnT3yT/bE3AmhdI2AQmeLW1+TID3ZCrM0mhWuqNzj
         tyJg==
X-Gm-Message-State: ABy/qLYAyyXDV0M/yW7sVkOAwiNh+CUXC5Ya9ghpbZs7Vv8JCLi8q1in
        UrirLdp/bIbd7IoL8zJxpWRy2taeNgauNLSTRLA=
X-Google-Smtp-Source: APBJJlH//xGSHp763z8Odv8skPDp2+tx8xVpkRAd0hnNWzbsEQe0URsks1sfPx/Bl8/cClJr88jBa+C6dKPM8qehhq8=
X-Received: by 2002:a17:907:7e8e:b0:98d:4000:1bf9 with SMTP id
 qb14-20020a1709077e8e00b0098d40001bf9mr6765289ejc.65.1689869326523; Thu, 20
 Jul 2023 09:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230720134845.23727-1-aboutphysycs@gmail.com>
In-Reply-To: <20230720134845.23727-1-aboutphysycs@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Jul 2023 19:08:10 +0300
Message-ID: <CAHp75VebtVNAzJBqbrf7sVmdZ2=+Oc1T+3r8vmkg3AOD_L_jPQ@mail.gmail.com>
Subject: Re: [PATCH] gpio :mlxbf2: remove unneeded platform_set_drvdata() call
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy@kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
        Alexandru Ardelean <alex@shruggie.ro>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 4:49=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver.
> Also, the private data is defined in this driver, so there is no risk of
> it being accessed outside of this driver file.

The Subject is broken.

--=20
With Best Regards,
Andy Shevchenko
