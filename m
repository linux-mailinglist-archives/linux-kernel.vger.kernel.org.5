Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E4B7C750B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379640AbjJLRri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379549AbjJLRrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:47:36 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266FFB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:47:35 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57b67c84999so755967eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697132854; x=1697737654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZ5cBSWgR34rbCxupj7uHLFbP8vjmFBvwRGEvSBQmBE=;
        b=WFOkLyN0ES41s8IdmvELIh+qlzx8O+7h2KZ7RZscB0ouHJOfk0gbVjJx/K/KbBp2u2
         xIlLJh+gYMYlELuSgTtEJFw6zyIxfDRj8kt6mrlRneebPydXl4rec/2r86x2p0Bzj3f/
         FQ0hJAsXgTvbk/uV2cxpirL6m2ad7CAh2dag4ifGsPJnXn5uJJtuOKx1l+e7Qp5cNchW
         U2QtJD7ql69AAYuIPv+pV/091zeClnf4vhEtbj+khciu9BgjDgAhtCoeqCiU33seQhuZ
         dkFIektmsQuYBOn+mZTINl/+OSREmiNO9dnuwWRBm0ISSFhO9ids1LtlwMx9dO2JhoFT
         y1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697132854; x=1697737654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZ5cBSWgR34rbCxupj7uHLFbP8vjmFBvwRGEvSBQmBE=;
        b=e6b/BH/WdW/wzBybGJVC+w8q2DUxHOA4zUPIqWQbbaN6XHGpqalDsL6UQ1Fjbh87+V
         0R0TQkhZf3SLRTgCtPpE8XwhBqthGO8iM9EgpIQD864klB9QszFyieSqJEk2Qsfm+4D3
         y/g0s7uzMoTEq5YdpwWXdVjNeOHZzRkebsOu1CD6sDyitCXhH5zUN47SD4AAwjPvqSCC
         6X+xMgcaNKSMTyMtMr3ZWf7Hej9g5H3YsLrQT0sxSTHB2t6JPK5bulJ0c1yDy8x1HQcM
         Ehl7MbTT6KOCh43fTQkwKxUxKFeXlH7/Ho0GkJzQI3qSNkpGeva6RKjvJx7ennjI+Z4C
         +cdQ==
X-Gm-Message-State: AOJu0Yxt/2A2IglYLbmCOtkTLtj5dJ6vnD3YLV1Unkykq1sZ8fRkeEOk
        /I8qPpil5dILFG449U0y8jPpl2obfdrFxq0Fk78=
X-Google-Smtp-Source: AGHT+IGebWKoIkiyVL4Zv+2u6gnjQtw4yarEaWmsPUToyBHoZzdphDOgqkw3QNX07uCFBmo/240cPNDISGcBH74mrC4=
X-Received: by 2002:a4a:9b0b:0:b0:57b:6d88:4cb2 with SMTP id
 a11-20020a4a9b0b000000b0057b6d884cb2mr26109502ook.1.1697132854386; Thu, 12
 Oct 2023 10:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <ZSf8VcH8JQ+L+Z/r@lab-ubuntu> <2023101234-extenuate-regain-2e36@gregkh>
In-Reply-To: <2023101234-extenuate-regain-2e36@gregkh>
From:   Calvince Otieno <calvncce@gmail.com>
Date:   Thu, 12 Oct 2023 20:47:23 +0300
Message-ID: <CADFX3OQWXU0bxe17QmCVdASC2oRzMk3A3SBW=5SnO9SSBzR2FA@mail.gmail.com>
Subject: Re: [PATCH v2] staging/wlan-ng: remove strcpy() use in favor of strscpy()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Archana <craechal@gmail.com>, Dan Carpenter <error27@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 7:42=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 12, 2023 at 05:01:57PM +0300, Calvince Otieno wrote:
> > In response to the suggestion by Dan Carpenter on the initial patch,
> > this patch provides a correct usage of the strscpy() in place of the
> > current strcpy() implementation.
> >
> > strscpy() copies characters from the source buffer to the destination
> > buffer until one of the following conditions is met:
> >       - null-terminator ('\0') is encountered in the source string.
> >       - specified maximum length of the destination buffer is reached.
> >       - source buffer is exhausted.
> > Example:
> >       char dest[11];
> >       const char *PRISM2_USB_FWFILE =3D "prism2_ru.fw";
> >       strscpy(dest, PRISM2_USB_FWFILE, sizeof(dest));
> >
> >       In this case, strscpy copies the first 10 characters of src into =
dest
> >       and add a null-terminator. dest will then contain "prism2_ru.f" w=
ith
> >       proper null-termination.
> >
> > Since the specified length of the dest buffer is not derived from the
> > dest buffer itself and rather form plug length (s3plug[i].len),
> > replacing strcpy() with strscpy() is a better option because it will
> > ensures that the destination string is always properly terminated.
> >
> > Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> > ---
> >  drivers/staging/wlan-ng/prism2fw.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-=
ng/prism2fw.c
> > index 5d03b2b9aab4..3ccd11041646 100644
> > --- a/drivers/staging/wlan-ng/prism2fw.c
> > +++ b/drivers/staging/wlan-ng/prism2fw.c
> > @@ -725,7 +725,7 @@ static int plugimage(struct imgchunk *fchunk, unsig=
ned int nfchunks,
> >
> >               if (j =3D=3D -1) {  /* plug the filename */
> >                       memset(dest, 0, s3plug[i].len);
> > -                     strncpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - =
1);
> > +                     strscpy(dest, PRISM2_USB_FWFILE, s3plug[i].len);
> >               } else {        /* plug a PDR */
> >                       memcpy(dest, &pda->rec[j]->data, s3plug[i].len);
> >               }
> > --
> > 2.34.1
> >
> >
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot



Hello Greg,

I did amend my first commit

I used the command: git commit --amend -v
The result of this commit action is what I sent over.
--=20
Kind regards,
Calvince Otieno
