Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543BB76105E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjGYKPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjGYKPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:15:10 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F11010D8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:15:09 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-583d702129cso28316657b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690280108; x=1690884908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erCjSkC9KKXf4HZ3WKTycAwEPfysE7GXkEGTjXCWoCc=;
        b=6MEp3pyBCXWUcasQ8uaKY9lSpp+OI376HqLg5SAKaSfoRbMYh2N2HowQDjRHk1i5Bq
         cQ1t9WKN2e1L3YhsyDITrxJzJIfN2ZyyJTXYFIe3veFLp/2+Lw5/EV4rMe4Egb93eGqj
         vwJllwew76LsO0ecWRpgOJD4ymg1tTIzMYqT5lwvqADsGfAFDJfFFh/tHBhqx7V9YGpp
         1WIum2xOZ+rjlKn0OWKawDGaoU7mi2hB6wwf62lBwd0/93RWasbPC1c8xi8JcBLHe7uL
         gol9mTfReNIGUxLypleX+407RTen22oBYqnndLywI21zarJ7U4sN0ObIDXTEnNkcnplE
         FPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690280108; x=1690884908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erCjSkC9KKXf4HZ3WKTycAwEPfysE7GXkEGTjXCWoCc=;
        b=gk+0K17B7z1Lxf1BmiAejrqKQCKnbJRfLxyzpJdn+nG/Pr8vWdpyTJ6+Fr4ybIIyQw
         qv2NdbkVnRdt1lEvWEMtvd69bfIC9myTwOoZ+HMsuVcfiTvu1+Aw2ALQ6XHcM+z+Adq+
         rmRHG1WMBoX2QHAjjeEaN6SOEx6sVeZYr7Ds2lU8OVkXxh8zpRXXwo8ANYuR9gNL/mdp
         36gfibjSSrKc74g9OC0xdzIpy1K2f7hurn8KQEYBxjLzSj4pX+hpnA18tIr1wrhOZkzG
         6nbFdUH8k7f6D7WQ1rSWH23axin6KU4DiQxV1Y2KW4P85T0hbIb6yejqSukXtQOs7ZGQ
         KIXw==
X-Gm-Message-State: ABy/qLYW02JQFSAsgheXc8gjiosPKkfvisny3ZfDixnJ7ACUWctJDU5L
        YY3x72jTkGqyc7t8f+m99b8XXwrqQJ13b0G4Zu1o
X-Google-Smtp-Source: APBJJlGIO67AaF30j+BiHBC7vNFOhVQy4zYdxjKEcTdPuwUJyitpRm4x1zlrpIeM8OGM0y6X5Dm43P3CjK6IM53ptVk=
X-Received: by 2002:a0d:ea56:0:b0:57c:9e81:723 with SMTP id
 t83-20020a0dea56000000b0057c9e810723mr9598105ywe.5.1690280108609; Tue, 25 Jul
 2023 03:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230725093005.3499455-1-lerobert@google.com> <87sf9ctifg.wl-tiwai@suse.de>
In-Reply-To: <87sf9ctifg.wl-tiwai@suse.de>
From:   Robert Lee <lerobert@google.com>
Date:   Tue, 25 Jul 2023 18:14:56 +0800
Message-ID: <CAOM6g_Db8qwbDmbWSSLKqUHsSMLUYxFtpqKi1cWsXsXTE9B+vA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: compress: add opus codec define
To:     Takashi Iwai <tiwai@suse.de>
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reply so quickly.
And yes, there are other changes but it is inside our offload pcm
driver to handle it.
Currently we only use it to decode, and we don't need additional option for=
 it.

Thanks,
Robert.

Takashi Iwai <tiwai@suse.de> =E6=96=BC 2023=E5=B9=B47=E6=9C=8825=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 25 Jul 2023 11:30:05 +0200,
> Robert Lee wrote:
> >
> > Add to support decode Opus codec in Ogg container.
> >
> > Signed-off-by: Robert Lee <lerobert@google.com>
>
> The change makes sense only when it's really used.  So usually it's
> better to put into a series that actually implements its usage.
>
>
> thanks,
>
> Takashi
>
> > ---
> >  include/uapi/sound/compress_params.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/=
compress_params.h
> > index ddc77322d571..bac5797bcb02 100644
> > --- a/include/uapi/sound/compress_params.h
> > +++ b/include/uapi/sound/compress_params.h
> > @@ -43,7 +43,8 @@
> >  #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
> >  #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
> >  #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
> > -#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
> > +#define SND_AUDIOCODEC_OPUS                  ((__u32) 0x00000011)
> > +#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_OPUS
> >
> >  /*
> >   * Profile and modes are listed with bit masks. This allows for a
> > --
> > 2.41.0.487.g6d72f3e995-goog
> >
