Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCB776B841
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjHAPLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjHAPLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:11:05 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB0A1B1;
        Tue,  1 Aug 2023 08:11:04 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9a828c920so89177411fa.1;
        Tue, 01 Aug 2023 08:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690902663; x=1691507463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ply/M1oL6Fq7JzUxYf0RMHVAjtQKWKZdsAYugDGBkbQ=;
        b=iUqKDoSKqVP5ULIA0O7A2XpGZ8pGgRra6ehXytZRvgnM4OOVEJd29s/vL5s0fteAsQ
         /GNSZUyyTqawpKG4kEd8s9E2np7wiLP5069H4AMJkghoG3fpLWTyvlijLFN9bUaEhGYX
         mxhcnFvOvsOtSvvTaMbk3TVC/NtjYT3NGuM6O0At37+rUnHUCA2movZttsalu0Dscj6g
         Vz7eopg5GUcBZDQFiw3Km7IpmHvsg00LGFdEYgTYq+tUZkLNBYWwGdWzgAXpE9U4tcWo
         AHmXGm6TFgEsYsfy7qAmS/r88kqHDeN8s+hVnx4ah1Ix4d45RBLw9UEfmlftoPk4rXIN
         n2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690902663; x=1691507463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ply/M1oL6Fq7JzUxYf0RMHVAjtQKWKZdsAYugDGBkbQ=;
        b=Lyg7FIYBDmYfbWY5uf9DxXwRrK2pVNA/6UkFSxXe+eVn3RKa3LU8O+Tznfdz/oGNRB
         qiJfERcwq494LpFgLAMQDZ5zmfJeqhkEZ7FZPltu/Dr7gE3j/5x7O0daAOlJaYSWxhAd
         HUhfSaJACkMWsUSmkFSEBxG4JIZi5xytY+H3fVBYFv31eKX2RIMq5PYRxHDzRzXMQJXa
         Oc44agk4DGeYrxTzAt6SoP6/7/BNj4RINkAQRJOQYAI/NxRV5PMAlTdl5orVt1wZaUnl
         +/vW6UrhgwWUtJkd2JO8HP69Wp2Fbeyijh3pAasBXeCrFOq/occaKvKviF+8bUT+prJm
         Ba5g==
X-Gm-Message-State: ABy/qLZoa+vPwFjZdKEtVczqVQOyeQ9X64JqBd3JsButz/27kRdlEXpm
        KmwQ03U7NIOke+n2xSi2J30guN7+YvLl1RKe6CcN50vZ
X-Google-Smtp-Source: APBJJlFCYr6FiTshFjokSiMYetnA4bQNdJ20kE7XejmNaEXmiYAfKp6hJM50X5elsUL1+jJVvcRGnk6WPYM+qQrwTXA=
X-Received: by 2002:a2e:968e:0:b0:2b9:ee3e:240b with SMTP id
 q14-20020a2e968e000000b002b9ee3e240bmr2715597lji.41.1690902662863; Tue, 01
 Aug 2023 08:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230731203141.30044-1-jorge.lopez2@hp.com> <c891e1cb-3fb6-448a-850c-e94c48d32c66@kadam.mountain>
 <CAOOmCE8xLxE9fSZNhPeYumRyzg9S-C9++8LH5jDq5vVwgFMdCQ@mail.gmail.com> <6c6143bd-5352-4edc-a44c-143c27fbf1cf@kadam.mountain>
In-Reply-To: <6c6143bd-5352-4edc-a44c-143c27fbf1cf@kadam.mountain>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 1 Aug 2023 10:10:05 -0500
Message-ID: <CAOOmCE85enO=C+i8SUAroJpMCi7cGYvJ5TOCgsVbL2b-6pPpNw@mail.gmail.com>
Subject: Re: [PATCH 0/8] hp-bioscfg: Overall fixes and code cleanup
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
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

Ok. Thanks for the clarification.  I will remove 'value_len' and
replace all its references with 'size'.

On Tue, Aug 1, 2023 at 10:04=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Tue, Aug 01, 2023 at 09:52:05AM -0500, Jorge Lopez wrote:
> > I will submit a new patch replacing 'value_len' for 'size' in line 267
> > as indicated.
> > 'value_len' is utilized earlier in the code so we cannot remove it
> > completely from the function.
> >
>
> After replacing size then it looks like this.
>
> $ grep value_len drivers/platform/x86/hp/hp-bioscfg/order-list-attributes=
.c
>         int value_len =3D 0;
>                                                                &str_value=
, &value_len);
>                                                                &str_value=
, &value_len);
>
> It's a write only variable.
>
> regards,
> dan carpenter
>
