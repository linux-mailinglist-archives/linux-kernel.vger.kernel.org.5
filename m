Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67796777615
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbjHJKlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjHJKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:41:01 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851481702;
        Thu, 10 Aug 2023 03:41:00 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56d263da4f2so631308eaf.0;
        Thu, 10 Aug 2023 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691664060; x=1692268860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzGgdaSbIbO5607Bipi/BVOCslTkWPmDB2/kSSg0w98=;
        b=GPvrgMmq+chXVdFnEk9PGz2ydLogpF32PvUNg+4t9DmG3TwOcFvqJWeNdqylVbUIhQ
         RSOAX76SyLgThVlrNP/+88CJvg3E4dEH7qJ4Vyy8Bt2nZntX3FvEvRtfmLs3/tuk5dzP
         GUmD/GXjr7uC7TKx0t1UnP1ixWKazUF1DMqsQuMeulNN+XheZgG+AhrV/tJ57oWPrDuU
         1SEldI0rfzBWNPOtcoHN324a/dA8j5zuIm7YJcf5gKgJznWRYWkw4dkKdwmsICGMAdFg
         yj+KFap3WeMmn2rGW8b391L6YE91Ka+XeW9AW6thBHYR8KVqhrvjep8hZHMjbtcElkTu
         YTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664060; x=1692268860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzGgdaSbIbO5607Bipi/BVOCslTkWPmDB2/kSSg0w98=;
        b=U5o0dOBrAEgWeHU0aAfM/c3eqJ0qSCj9EC+N77gtnb+ZjR6sO+4W87qn5d8Rr2pBCW
         NKpNHZkM+MufIRNyJCwoyxz9YIRKe47VCqJoCX+hyI01TlVypX3b7SIhp2pcVzeKwepD
         JxvvEi6MMCE8fqfczwvL27MaEeLmJffH7wiVbBhpSTh28wSkJJsdbsZNSM4ybMHfGcMe
         7tOXvNfEhDt6SAb6VMDZ/K9LEIx2ZPa2q4v+j/zcLlO4257JUPG+GGqSrif22AoIWYiS
         TXY29Ff97W3Gpuqm4OXsONWkvEz6ngWiWLTyiG2fsi6K9g24MUVC8fBj+4xfx0N/J7SM
         tlug==
X-Gm-Message-State: AOJu0Yz2TkA9GVCIiXb2Nn72FGoe8nhBdtfcgOGYETbcViTFRozu0Nyy
        Ctv0raJu3hIWllL5TFZPCn7yJ5ZObYiVwJPW86EilNrbzrk=
X-Google-Smtp-Source: AGHT+IE472b1bBC1wnLWrRDe+WBNUm860iODbGwa4NJ/eoWfeoqPR7DWvpHGMbjOH3OcpROQ7IS0Vh10NJjlFUVmpzY=
X-Received: by 2002:a05:6820:47:b0:56c:cd0c:1d67 with SMTP id
 v7-20020a056820004700b0056ccd0c1d67mr1616704oob.7.1691664059810; Thu, 10 Aug
 2023 03:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230810074633.13111-1-coolrrsh@gmail.com>
In-Reply-To: <20230810074633.13111-1-coolrrsh@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Aug 2023 13:40:23 +0300
Message-ID: <CAHp75VfmnY1u2d4UX1qoKALqE--3+CUSGn9oDudCPZDa_-0GTA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: gpio-imx-scu: Use ARRAY_SIZE for array length
To:     coolrrsh@gmail.com
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
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

On Thu, Aug 10, 2023 at 10:46=E2=80=AFAM <coolrrsh@gmail.com> wrote:
>
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
>
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
> This fixes warnings reported by Coccinelle:
> drivers/gpio/gpio-imx-scu.c:106:32-33: WARNING: Use ARRAY_SIZE

...

> -       gc->ngpio =3D sizeof(scu_rsrc_arr)/sizeof(unsigned int);
> +       gc->ngpio =3D ARRAY_SIZE(scu_rsrc_arr);

And you need to include kernel.h for this.

--=20
With Best Regards,
Andy Shevchenko
