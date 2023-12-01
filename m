Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D331800C55
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379016AbjLANjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378935AbjLANjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:39:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D45170E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:39:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9178FC433C9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701437958;
        bh=9nEJmdjtfoIvxDva2ZjlQga8piJtF+d6EPOi5490aAA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f8xjNWkEz6TrGFmfgKwWiHj2vBdLf26JePlhpo5KouqoN8GMmtEw8E3MhGEmabE2r
         HSOT/6+rrPwZMWzCOvGbDVdTifN9xpqlnMBTZKjH1r3YcAD16teOAhugWcjDUSKJHt
         e68BSldslVSDK7XHiOiZ2HBVeG8FRgy/mmqDulP4pHHqB6GG26bT+1M+wMYKz+1QG2
         vCLY5D+0cE025BAFX9HJNqJekQVOXXNM0u6IQ+SL0O/PNwSBIds4mxwn0DYMqnKlsc
         idDjMel957e9Tf+1gZ7nP9uuWtXJNQG9hVVpSpszQxR4ZrAFAwqtYHxEu2pTNHvzg3
         YClhdgkBhzdbw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50bcab463aaso2127118e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:39:18 -0800 (PST)
X-Gm-Message-State: AOJu0YxJ3kJQlQtacn0Z1LFLqL6WHyCBrMEGvd4ZuS7jDfyfwfLOybex
        9pgAgnio02d0DZKRG2UNljfy3k7ny+SOILxJCA==
X-Google-Smtp-Source: AGHT+IFi0UKZvH8854kJX17USMoNT6PUmh9PnYCHEjvih1RDalN3zf9beX7T8rCkvMhfH0vJjljDAjUo8hsP+sC+TYU=
X-Received: by 2002:a05:6512:33d0:b0:50b:c506:7356 with SMTP id
 d16-20020a05651233d000b0050bc5067356mr861970lfg.32.1701437956817; Fri, 01 Dec
 2023 05:39:16 -0800 (PST)
MIME-Version: 1.0
References: <20231115210245.3744589-1-robh@kernel.org> <CANiq72=VGJDcK=tVkOFCnTumxDNE9YfiyAVocmD534mnAd_1CA@mail.gmail.com>
In-Reply-To: <CANiq72=VGJDcK=tVkOFCnTumxDNE9YfiyAVocmD534mnAd_1CA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 1 Dec 2023 07:39:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLcqpGa=sc9niVK=-4LtVyr3jtUBcQJ2pNsafc3PQpj_g@mail.gmail.com>
Message-ID: <CAL_JsqLcqpGa=sc9niVK=-4LtVyr3jtUBcQJ2pNsafc3PQpj_g@mail.gmail.com>
Subject: Re: [RESEND PATCH] auxdisplay: img-ascii-lcd: Use device_get_match_data()
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Paul Burton <paulburton@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 12:55=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Nov 15, 2023 at 10:02=E2=80=AFPM Rob Herring <robh@kernel.org> wr=
ote:
> >
> > +       cfg =3D device_get_match_data(&pdev->dev);
>
> This sounds good to me, but a couple notes:
>
>   - This could be `dev` since we have it, no?
>
>   - Orthogonally, should we just directly initialize `cfg` since now we c=
an?
>
> Cc'ing Geert as well since he was the last one touching the file (in
> fact, he added the `dev` variable).

Can you fix that up while applying? This patch has only been ignored
for 2 months.

I really only care about getting the includes right so I can apply this[1].

Rob

[1] https://lore.kernel.org/all/20231129164316.2663565-1-robh@kernel.org/
