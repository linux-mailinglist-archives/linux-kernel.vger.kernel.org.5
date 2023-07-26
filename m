Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C59376284A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjGZBr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGZBr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:47:26 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DA026A2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 18:47:25 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-583b4522927so47270967b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 18:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690336045; x=1690940845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GWTIil/tm7mqD4sdysaM/Da0PfAMCmi2KUFDiSQGwA=;
        b=I1wqWaF7xVjCzMs+jeu7Mf+11Tx5KCsdv9Rcv8lBYR569EaeTkQdk73AgXA4ErQA64
         DPGXqVv9KUqyjwD3DzDKPxPkonBtIFfFSX3TgmXhhbTTCUhZ3NtNlBPp1MuGDWxEHX8D
         MYlpqLfRIDc5AzwBTMCOH/e+aeyoWWZlJ2I7BZHXDhjbctB+EQkirNbOpQhBdpqKafxE
         Rg6X3ztrKELT3NWEgghlPLWFZr4/2Bx+dV9IMww3z0bKxISmI6QbYC6sa+xJp2O9UWDr
         Dsa+PY7a2rbCE/i+18XdesZACx9KaxCONOsHPA84XQwnN7mjce6ymDN3CWOm7GPYBsdU
         wvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690336045; x=1690940845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GWTIil/tm7mqD4sdysaM/Da0PfAMCmi2KUFDiSQGwA=;
        b=EOSocA2FhfjFeCgLxVB06uOG3Ck1jBdSekZ4jO/DvRoum1u35A3TiS+F1jQQ2RVnEP
         y8LMTC1p9EH6c6hUWxPNDHlWCa0dPA7h3meSdkYfcH9ESMxyQQx+hjFUoeqntB+p58BQ
         KOpvW/29EfTBoE+Wts5I18BmjxM8JugmYH3myfQoFt+LTqkiJB6doQ7TO5C553jJi8FW
         4KJSZVzfCevmkp3V+rFhj5Ms0asWrczOyaCRErSE0d0QWOI8oe1OO7RGB3Ex+Gps27NM
         2TWkpbJG9znGF+DQUjlz3xOegfPFQUjdCIB76TnWJe4Omy5iz3sbLXdLoy8Jg7e9pQn9
         FEZg==
X-Gm-Message-State: ABy/qLb9k+yUkY79K6R2MvcCcKbzNW0qxPZ6LqFm2JkOTeo52oTxMp+A
        rdPyiNajnMcYTEJS1Rbls4JNotwbLziiX5/o1HPs
X-Google-Smtp-Source: APBJJlGKCmF6Eq7yIsgErcnDcg/CYg926aKaUaYzEfOzvWSEGEZNw51kJosjI5zxYDSJvamqMRJphUgL4Cq5GX9fLzQ=
X-Received: by 2002:a81:7bd5:0:b0:579:f5e3:ad07 with SMTP id
 w204-20020a817bd5000000b00579f5e3ad07mr844539ywc.14.1690336044906; Tue, 25
 Jul 2023 18:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230725093005.3499455-1-lerobert@google.com> <87sf9ctifg.wl-tiwai@suse.de>
 <CAOM6g_Db8qwbDmbWSSLKqUHsSMLUYxFtpqKi1cWsXsXTE9B+vA@mail.gmail.com> <87lef4thir.wl-tiwai@suse.de>
In-Reply-To: <87lef4thir.wl-tiwai@suse.de>
From:   Robert Lee <lerobert@google.com>
Date:   Wed, 26 Jul 2023 09:47:13 +0800
Message-ID: <CAOM6g_DVKpEhnVStpNWmPoXyHNUuNTA+CNbdPxasObGcXtGEpQ@mail.gmail.com>
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

Yes, but we still need this change to let the sound system can use the
codec. or do you have any suggestions?

Thanks,
Robert.

Takashi Iwai <tiwai@suse.de> =E6=96=BC 2023=E5=B9=B47=E6=9C=8825=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:25=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 25 Jul 2023 12:14:56 +0200,
> Robert Lee wrote:
> >
> > Thanks for reply so quickly.
> > And yes, there are other changes but it is inside our offload pcm
> > driver to handle it.
> > Currently we only use it to decode, and we don't need additional option=
 for it.
>
> It means still a downstream-only change :)
>
> It's nice to upstream changes in general, but from the upstream POV,
> only changing this gives no benefit.  Let's tie with the actual use
> case *in the upstream*.
>
>
> thanks,
>
> Takashi
>
> >
> > Thanks,
> > Robert.
> >
> > Takashi Iwai <tiwai@suse.de> =E6=96=BC 2023=E5=B9=B47=E6=9C=8825=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:05=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Tue, 25 Jul 2023 11:30:05 +0200,
> > > Robert Lee wrote:
> > > >
> > > > Add to support decode Opus codec in Ogg container.
> > > >
> > > > Signed-off-by: Robert Lee <lerobert@google.com>
> > >
> > > The change makes sense only when it's really used.  So usually it's
> > > better to put into a series that actually implements its usage.
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> > >
> > > > ---
> > > >  include/uapi/sound/compress_params.h | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/uapi/sound/compress_params.h b/include/uapi/so=
und/compress_params.h
> > > > index ddc77322d571..bac5797bcb02 100644
> > > > --- a/include/uapi/sound/compress_params.h
> > > > +++ b/include/uapi/sound/compress_params.h
> > > > @@ -43,7 +43,8 @@
> > > >  #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
> > > >  #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
> > > >  #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
> > > > -#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
> > > > +#define SND_AUDIOCODEC_OPUS                  ((__u32) 0x00000011)
> > > > +#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_OPUS
> > > >
> > > >  /*
> > > >   * Profile and modes are listed with bit masks. This allows for a
> > > > --
> > > > 2.41.0.487.g6d72f3e995-goog
> > > >
> >
