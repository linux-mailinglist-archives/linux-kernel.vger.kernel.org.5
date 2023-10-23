Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E267D34AE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbjJWLmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjJWLmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:42:09 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C630D10E9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:41:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so48260381fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dberlin.org; s=google; t=1698061294; x=1698666094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWng4wsdvhQ3yYhP90X+fEaax78WLUNDXvIyDdQRoDY=;
        b=EcaeOmUhQvXhvQ2qETBotdErcvU9+TVjCan2V/BKQUUEuInXUmyoVnwHjgbWh8o/1v
         o36NWe0m74sDerBTPxNfXGg1gnABiKtAkaETn/v5DeOtnZuQvdRlVFh/0cZfQDDd/H8o
         1PinCUJz9LLzhNi9R/aqbM3CFKuG+MPLQAG6gTdAk39XS0Qa5CGGS3ISSD5LR/mwcyPj
         y4NegjKH9wgz8uUmSEmSPVizzzJb5C6yUdIMLCCQYlyQMIpKcgZm79IV9ofcfNrhD2vG
         OVAIOFu5zksLfAQsVH8akRpqrHo6jNduS4mWhQuF1/0+p/JDnFUgBFr/0HfZTwyrtatV
         QCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698061294; x=1698666094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWng4wsdvhQ3yYhP90X+fEaax78WLUNDXvIyDdQRoDY=;
        b=VcnAXH7z23X8XnjYdiIdjNkTjlz/3F9mNVvxOtVnzmuCSQsJvevdxD/kDkxCI0jujm
         yF1Ey5fadhbVlaRNrdL/UNysDcGU90VUrVujJoohuWDe8dn15mdP7IQxek5UJU3jIkTU
         78EVjy3uUVXssGFOP7PsEXSBovz3TkAktBwDj4gDh36pLOsfS29j+dldY9lbRNN5xgOc
         FShzHI8V1RBYBskxq+4x4pY46xNz74NwKxneZ9rXt5UgeBLrvR2o9J3NPTD8mqCmdXtQ
         ilI9k4B7B1MXJjL1WQUpAyFvknJL5jshyqrpsE2w5GMWw9VCyzFrEOlxO1cf8JH4Vdfe
         OCrw==
X-Gm-Message-State: AOJu0Ywhx0z+/UxywLgpTINZ4gf21jaF0P1OP2a3fcEmNybpRKfa9pYy
        woHUCqyYMF3uJSFM/f7Md/ckV4iRuAR+uERCtsNugw==
X-Google-Smtp-Source: AGHT+IHKyAxZ9BWFT88KkDwFTqwRm+kj+yDtGkA7wrn9qxMdb7UW+TdPB5lXGlcJ56NfQxyWhYkXIWbfCbq5XCJuPsc=
X-Received: by 2002:a2e:86c4:0:b0:2c5:25f3:8e1c with SMTP id
 n4-20020a2e86c4000000b002c525f38e1cmr5732134ljj.21.1698061293768; Mon, 23 Oct
 2023 04:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697650207.git.dberlin@dberlin.org> <52c993fd93e13ac015be935a5284294c9a74ea8e.1697650207.git.dberlin@dberlin.org>
 <cc58057b-bc08-f717-1676-13046fc26c5c@broadcom.com> <CAF4BwTUTmUd0c-y_NfSi9WkCnDO9bhtpx03Aai1ByH5auq9YXw@mail.gmail.com>
In-Reply-To: <CAF4BwTUTmUd0c-y_NfSi9WkCnDO9bhtpx03Aai1ByH5auq9YXw@mail.gmail.com>
From:   Daniel Berlin <dberlin@dberlin.org>
Date:   Mon, 23 Oct 2023 07:41:22 -0400
Message-ID: <CAF4BwTUJ7NxWomeDEa7TOtjfCjEP+dD68HeT3QyDcNoA1QbXVQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] [brcmfmac] Add support for 6G bands
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 12:35=E2=80=AFPM Daniel Berlin <dberlin@dberlin.org=
> wrote:
>
> >
> > > -     brcmf_dbg(INFO, "nmode=3D%d, vhtmode=3D%d, bw_cap=3D(%d, %d)\n"=
,
> > > +     brcmf_dbg(INFO,
> > > +               "nmode=3D%d, vhtmode=3D%d, bw_cap=3D(%d, %d, %d), he_=
cap=3D(%d, %d)\n",
> > >                 nmode, vhtmode, bw_cap[NL80211_BAND_2GHZ],
> > > -               bw_cap[NL80211_BAND_5GHZ]);
> > > +               bw_cap[NL80211_BAND_5GHZ], bw_cap[NL80211_BAND_6GHZ],
> > > +               he_cap[0], he_cap[1]);
> >
> > So are these he mac and phy capabilities? ...
>
> No, unfortunately, it's either 1 or 0 on these chips, and all chips i tes=
ted.
> This is the hardware capability iovar.
>
> In the debug firmware i have access to (not apple's), i do see a
> command that looks like it may give the he cap, but i can't find how
> it would ever be triggered.
> (The iovar code for the iovar above is either always just return 0 or ret=
urn 1)
> There are no obvious iovars that relate, and  the absolute latest
> bcmdhd hardcodes the he caps, as do infineon's latest ifx code.
> :(
> I'l hack around see if i can get the caps out of it.
>
> I'll double check other ones.


So, I reached a  conclusion on this piece.

This is really an xtlv with subcommands that everyone (including me)
is wrongly treating as a non-xtlv.
The above is really showing you the enable value.
There is also hardware cap value (which is 0/1 as well).

In the 4398/4390 firmware, a "defcap" subcommand was added to the
firmware which can retrieve the default HE capabilities bytes for the
mac and phy and be used to fill them in.
However, it is unsupported in the firmware for earlier chips,
including these chips (or at least, any firmware i've found for it,
apple's or not)

As such, at least for these, STA/AP caps will have to be hardcoded.

I have updated the code to include the subcommands that exist here,
and properly use an xtlv command to retrieve this (it's really a uint8
value).
