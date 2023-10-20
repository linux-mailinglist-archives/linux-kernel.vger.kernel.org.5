Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0677D1421
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377871AbjJTQgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjJTQgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:36:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A759D6C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:36:15 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so14943151fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dberlin.org; s=google; t=1697819773; x=1698424573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWikgjvSE35PTGSbSuie+aPwQzHN09c8HW1HYQB+sf0=;
        b=VkEV5wNcYCYbxoaE2thD1Lilw4JWGh2GPuUn5UafR17g7R2BzGsupWb7k4M9ERSYR8
         akb0j9Lu7fmqpdMfMCgp/h98avIHVDGAGtMExbJjRzDn65qDqZQK0YQh6GiTo+V4cXqJ
         ZaddcVdsuAHqbwanCdohP/vvS63dq5jmOb5Gwvu3U5ozVCv7cecARV0vPaR9853OflPZ
         j1gM0qT2zVPYBHZnKsERidIQ56zkDlYKdViAqk18LRgDKuV52JB7tzM9dtTSH1pU76T0
         NjFHGSbeDFyaHp/sdSOjYYCom6U6xhcpFNQ4vESFcH1J3sIFiXAu65QqzFlp+ZlDfRJ0
         QY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697819773; x=1698424573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWikgjvSE35PTGSbSuie+aPwQzHN09c8HW1HYQB+sf0=;
        b=MJNydxAC1Iep/ldzvvpmUrTLJY+4hdmKXpKi3fjpPECYeF584/VAbC9izlAr9WbtXW
         4pjsDfT4O8oW0oJXrP8uENFHGfcGf7/OP2Y/9rp8IXJ3GjK2aKdLqjXyVvdSk4TwgsQ5
         G96JHOvRKTcerxdMTRDYUXhy7YpxvoAOqGusRPCvGXa7/sC/B1jBCfT7fYTWrjqKo45n
         2zjxg/74ocdshmqAqrfCCtoMMGawZJJT+DvRBP/OlvmGR7kp4/PAVFz7U5FenU2ZTXvf
         D77kfrLLpYgzkuvN0kg7+nT5qdKVQoBVw4kAaIW2cygm0vea1MszUd9zl/Z5EJGpRQ3+
         G/Dw==
X-Gm-Message-State: AOJu0YyA81PAzt6TAj4vouHWgI1elONKm5f6hqjVhM4z+HbMV+8n5XeN
        WJeOb9gqUi/LcbO1KiQ9k3WtUflAOWiyx7q6j5y8dw==
X-Google-Smtp-Source: AGHT+IG9FrJ+4IDGeQ5HI4NuEOL5bT0XfITQxtC2xYwKhr5rMhoYqSAWfKWojrK/kLlHBC2M+Qi/As+8Q8sFRthQNLI=
X-Received: by 2002:a05:651c:1a28:b0:2c5:80d:53b1 with SMTP id
 by40-20020a05651c1a2800b002c5080d53b1mr2380888ljb.43.1697819773114; Fri, 20
 Oct 2023 09:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697650207.git.dberlin@dberlin.org> <0b95944fcf047b3ec83cecb0c65ca24de43810fd.1697650207.git.dberlin@dberlin.org>
 <d55c968a-d953-67d7-cdff-f856422607f5@broadcom.com>
In-Reply-To: <d55c968a-d953-67d7-cdff-f856422607f5@broadcom.com>
From:   Daniel Berlin <dberlin@dberlin.org>
Date:   Fri, 20 Oct 2023 12:36:01 -0400
Message-ID: <CAF4BwTWDAV0_iecq3Z7iOxe9UejYkYpDrfMqBXA=hq_ouEePKw@mail.gmail.com>
Subject: Re: [PATCH 1/5] [brcmfmac] Add support for encoding/decoding 6g chanspecs
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll remove the extra prints, and the 320MHZ.

On Fri, Oct 20, 2023 at 5:57=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 10/19/2023 3:42 AM, Daniel Berlin wrote:
> > This patch adds support for 6G chanspecs, as part of adding 6G and
> > 802.11ax support.
> >
> > I added the correct values for the upcoming 320mhz as well so that the
> > info is complete.
>
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>>
> Signed-off-by: Daniel Berlin <dberlin@dberlin.org>
> > ---
> >   .../broadcom/brcm80211/brcmutil/d11.c         | 46 +++++++++++++++---=
-
> >   .../broadcom/brcm80211/include/brcmu_d11.h    | 46 +++++++++++++-----=
-
> >   .../broadcom/brcm80211/include/brcmu_wifi.h   | 27 ++++++++---
> >   3 files changed, 89 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c b/d=
rivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c
> > index 1e2b1e487eb7..faf7eeeeb2d5 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmutil/d11.c
>
> [...]
>
> > @@ -117,7 +127,9 @@ static void brcmu_d11n_decchspec(struct brcmu_chan =
*ch)
> >               }
> >               break;
> >       default:
> > -             WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
> > +             WARN_ONCE(1,
> > +                       "Invalid chanspec - unknown 11n bandwidth 0x%04=
x\n",
> > +                       ch->chspec);
>
> I don't think this provides more info. The WARN_ONCE() already prints
> code location and stack trace.
>
> >               break;
> >       }
> >
> > @@ -129,7 +141,8 @@ static void brcmu_d11n_decchspec(struct brcmu_chan =
*ch)
> >               ch->band =3D BRCMU_CHAN_BAND_2G;
> >               break;
> >       default:
> > -             WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
> > +             WARN_ONCE(1, "Invalid chanspec - unknown 11n band 0x%04x\=
n",
> > +                       ch->chspec);
>
> ditto
>
> >               break;
> >       }
> >   }
> > @@ -156,7 +169,9 @@ static void brcmu_d11ac_decchspec(struct brcmu_chan=
 *ch)
> >                       ch->sb =3D BRCMU_CHAN_SB_U;
> >                       ch->control_ch_num +=3D CH_10MHZ_APART;
> >               } else {
> > -                     WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chs=
pec);
> > +                     WARN_ONCE(1,
> > +                               "Invalid chanspec - unknown 11ac channe=
l distance 0x%04x\n",
> > +                               ch->chspec);
>
> ditto
>
> >               }
> >               break;
> >       case BRCMU_CHSPEC_D11AC_BW_80:
> > @@ -177,7 +192,9 @@ static void brcmu_d11ac_decchspec(struct brcmu_chan=
 *ch)
> >                       ch->control_ch_num +=3D CH_30MHZ_APART;
> >                       break;
> >               default:
> > -                     WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chs=
pec);
> > +                     WARN_ONCE(1,
> > +                               "Invalid chanspec - unknown 11ac channe=
l distance 0x%04x\n",
> > +                               ch->chspec);
>
> ditto
>
> >                       break;
> >               }
> >               break;
> > @@ -211,17 +228,24 @@ static void brcmu_d11ac_decchspec(struct brcmu_ch=
an *ch)
> >                       ch->control_ch_num +=3D CH_70MHZ_APART;
> >                       break;
> >               default:
> > -                     WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chs=
pec);
> > +                     WARN_ONCE(1,
> > +                               "Invalid chanspec - unknown 11ac channe=
l distance 0x%04x\n",
> > +                               ch->chspec);
>
> ditto
>
> >                       break;
> >               }
> >               break;
> >       case BRCMU_CHSPEC_D11AC_BW_8080:
> >       default:
> > -             WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
> > +             WARN_ONCE(1,
> > +                       "Invalid chanspec - unknown 11ac channel bandwi=
dth 0x%04x\n",
> > +                       ch->chspec);
> >               break;
> >       }
> >
> >       switch (ch->chspec & BRCMU_CHSPEC_D11AC_BND_MASK) {
> > +     case BRCMU_CHSPEC_D11AC_BND_6G:
> > +             ch->band =3D BRCMU_CHAN_BAND_6G;
> > +             break;
> >       case BRCMU_CHSPEC_D11AC_BND_5G:
> >               ch->band =3D BRCMU_CHAN_BAND_5G;
> >               break;
>
> [...]
>
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_d11.=
h b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_d11.h
> > index f6344023855c..bb48b7442062 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_d11.h
> > +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_d11.h
> > @@ -69,24 +69,44 @@
> >   #define  BRCMU_CHSPEC_D11AC_SB_UU   BRCMU_CHSPEC_D11AC_SB_LUU
> >   #define  BRCMU_CHSPEC_D11AC_SB_L    BRCMU_CHSPEC_D11AC_SB_LLL
> >   #define  BRCMU_CHSPEC_D11AC_SB_U    BRCMU_CHSPEC_D11AC_SB_LLU
> > +/* channel sideband indication for frequency >=3D 240MHz */
> > +#define BRCMU_CHSPEC_D11AC_320_SB_MASK       0x0780
> > +#define BRCMU_CHSPEC_D11AC_320_SB_SHIFT      7
> > +#define BRCMU_CHSPEC_D11AC_SB_LLLL   0x0000
> > +#define BRCMU_CHSPEC_D11AC_SB_LLLU   0x0080
> > +#define BRCMU_CHSPEC_D11AC_SB_LLUL   0x0100
> > +#define BRCMU_CHSPEC_D11AC_SB_LLUU   0x0180
> > +#define BRCMU_CHSPEC_D11AC_SB_LULL   0x0200
> > +#define BRCMU_CHSPEC_D11AC_SB_LULU   0x0280
> > +#define BRCMU_CHSPEC_D11AC_SB_LUUL   0x0300
> > +#define BRCMU_CHSPEC_D11AC_SB_LUUU   0x0380
> > +#define BRCMU_CHSPEC_D11AC_SB_ULLL   0x0400
> > +#define BRCMU_CHSPEC_D11AC_SB_ULLU   0x0480
> > +#define BRCMU_CHSPEC_D11AC_SB_ULUL   0x0500
> > +#define BRCMU_CHSPEC_D11AC_SB_ULUU   0x0580
> > +#define BRCMU_CHSPEC_D11AC_SB_UULL   0x0600
> > +#define BRCMU_CHSPEC_D11AC_SB_UULU   0x0680
> > +#define BRCMU_CHSPEC_D11AC_SB_UUUL   0x0700
> > +#define BRCMU_CHSPEC_D11AC_SB_UUUU   0x0780
>
> These are WCC specific, but I think it is okay to have these definitions
> here.
>
> >   #define BRCMU_CHSPEC_D11AC_BW_MASK  0x3800
> >   #define BRCMU_CHSPEC_D11AC_BW_SHIFT 11
> > -#define  BRCMU_CHSPEC_D11AC_BW_5     0x0000
> > -#define  BRCMU_CHSPEC_D11AC_BW_10    0x0800
> > -#define  BRCMU_CHSPEC_D11AC_BW_20    0x1000
> > -#define  BRCMU_CHSPEC_D11AC_BW_40    0x1800
> > -#define  BRCMU_CHSPEC_D11AC_BW_80    0x2000
> > -#define  BRCMU_CHSPEC_D11AC_BW_160   0x2800
> > -#define  BRCMU_CHSPEC_D11AC_BW_8080  0x3000
> > -#define BRCMU_CHSPEC_D11AC_BND_MASK  0xc000
> > -#define BRCMU_CHSPEC_D11AC_BND_SHIFT 14
> > -#define  BRCMU_CHSPEC_D11AC_BND_2G   0x0000
> > -#define  BRCMU_CHSPEC_D11AC_BND_3G   0x4000
> > -#define  BRCMU_CHSPEC_D11AC_BND_4G   0x8000
> > -#define  BRCMU_CHSPEC_D11AC_BND_5G   0xc000
> > +#define BRCMU_CHSPEC_D11AC_BW_10    0x0800
> > +#define BRCMU_CHSPEC_D11AC_BW_20    0x1000
> > +#define BRCMU_CHSPEC_D11AC_BW_40    0x1800
> > +#define BRCMU_CHSPEC_D11AC_BW_80    0x2000
> > +#define BRCMU_CHSPEC_D11AC_BW_160   0x2800
> > +#define BRCMU_CHSPEC_D11AC_BW_320   0x0000
>
> 320MHz is 802.11be. No need to add this already, but not a biggy.
>
> > +#define BRCMU_CHSPEC_D11AC_BW_8080  0x3000
> > +#define BRCMU_CHSPEC_D11AC_BND_MASK 0xc000
> > +#define BRCMU_CHSPEC_D11AC_BND_SHIFT 14
> > +#define BRCMU_CHSPEC_D11AC_BND_2G   0x0000
> > +#define BRCMU_CHSPEC_D11AC_BND_4G   0x8000
> > +#define BRCMU_CHSPEC_D11AC_BND_5G   0xc000
> > +#define BRCMU_CHSPEC_D11AC_BND_6G   0x4000
> >
> >   #define BRCMU_CHAN_BAND_2G          0
> >   #define BRCMU_CHAN_BAND_5G          1
> > +#define BRCMU_CHAN_BAND_6G           2
> >
> >   enum brcmu_chan_bw {
> >       BRCMU_CHAN_BW_20,
>
