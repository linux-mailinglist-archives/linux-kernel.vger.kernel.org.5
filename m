Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FE07D00C4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbjJSRiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjJSRiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:38:01 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B966C121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:37:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53ebf429b4fso8296636a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697737077; x=1698341877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVLsdu4894wzLjbCSVYdckk2YNXtNkRVnHj3GUzmzxE=;
        b=BMzbXv7TA5pLGFuZoo4Nag6x50lPfNo5yJvW8CYSRGjYnCqGj2B+SZVSw2gpXMxS5C
         3Gunmp8zD2pZb8RYNpZcaOfes0FtMtxj8B9NrLd8kPUKbWVzclbonq+kbO1jL/v8lxij
         RX2FHAbzRnJWzJd8r8aluLSjFZSyoYLwJodmw5JkEN0nPocTa1yG+1NEVOb3UmEovUrJ
         iR9+7n5HWcsV8J32xGWQZKVtxTpEyMx+lD83e0sV/Cx4bPEGzIY06Kr2iJK1Yo3nyk0H
         Aw23yhhZ9CpAYTTmSMTejQ6u0JxfykdgivukiYkhcc4tT8ozRxDuwjkoLdW8RCXn2ezN
         7otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737077; x=1698341877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVLsdu4894wzLjbCSVYdckk2YNXtNkRVnHj3GUzmzxE=;
        b=f8xMzhYZBfH6LMBKYt9UyOjO8OfWC+disSTrO4DmS7VyCyM8Sbe5XrMe6WAJ6WYAJf
         o3Xvb2EvOWsWhnzxBMnbtOWbuJ3XAXwr0ikZsmkffPm65ELtI3OmnbcOLdWpcXKFlWlh
         0FKzk7wmuAIy8ISaiG5UKSzeAb2tM9bA96hm5AAO6yk58cpdfB6WbQZ66kyElqHS35zz
         lQRYSzLUl3KQVKNVDaXW+sFnKBE+ytnvIMbCIrDHqlWdA52qGZWWNnoaK8QR7Zr8Ks9T
         p1GLJm3u+ihza8qseo+QPXxbi4NGhJTazUCWu7vG7KeEGhH59QiB8YXMD0w79/8TKfIu
         JlWA==
X-Gm-Message-State: AOJu0YzOeyDWdYvfSARbqv59Or+cfhbUjC6gwWLUGwvddJ3xWGgcDv6N
        Epqs5kOc62+nnQhMm/6cgi+9ZZKFSTYR6bbD9cwWUQ==
X-Google-Smtp-Source: AGHT+IGgNlHXWJ4jAnKdze+bNbnKLPu1+tzb6oWrarJ3fNEgLoQAaoZLCjwvwJxcBXJ/th47uvdz3RgYjYvcHib0AQw=
X-Received: by 2002:a05:6402:5106:b0:53d:a4e5:67d0 with SMTP id
 m6-20020a056402510600b0053da4e567d0mr2179966edd.13.1697737077110; Thu, 19 Oct
 2023 10:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-0-af780d74ae38@google.com>
 <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-2-af780d74ae38@google.com>
 <202310181654.E47A7709@keescook>
In-Reply-To: <202310181654.E47A7709@keescook>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 19 Oct 2023 10:37:45 -0700
Message-ID: <CAFhGd8oAaVUP3KcXPkpF061T55PfGCKbxMRKay-==RWguMqJWQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] wifi: brcmsmac: replace deprecated strncpy with memcpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 5:03=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Oct 17, 2023 at 08:11:29PM +0000, Justin Stitt wrote:
> > Let's move away from using strncpy and instead use the more obvious
> > interface for this context.
> >
> > For wlc->pub->srom_ccode, we're just copying two bytes from ccode into
> > wlc->pub->srom_ccode with no expectation that srom_ccode be
> > NUL-terminated:
> > wlc->pub->srom_ccode is only used in regulatory_hint():
> > 1193 |       if (wl->pub->srom_ccode[0] &&
> > 1194 |           regulatory_hint(wl->wiphy, wl->pub->srom_ccode))
> > 1195 |               wiphy_err(wl->wiphy, "%s: regulatory hint failed\n=
", __func__);
> >
> > We can see that only index 0 and index 1 are accessed.
> > 3307 |       int regulatory_hint(struct wiphy *wiphy, const char *alpha=
2)
> > 3308 |       {
> > ...  |          ...
> > 3322 |          request->alpha2[0] =3D alpha2[0];
> > 3323 |          request->alpha2[1] =3D alpha2[1];
> > ...  |          ...
> > 3332 |       }
> >
> > Since this is just a simple byte copy with correct lengths, let's use
> > memcpy(). There should be no functional change.
> >
> > In a similar boat, both wlc->country_default and
> > wlc->autocountry_default are just simple byte copies so let's use
> > memcpy. However, FWICT they aren't used anywhere. (they should be
> > used or removed -- not in scope of my patch, though).
> >
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c=
 b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
> > index 5a6d9c86552a..f6962e558d7c 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
> > @@ -341,7 +341,7 @@ struct brcms_cm_info *brcms_c_channel_mgr_attach(st=
ruct brcms_c_info *wlc)
> >       /* store the country code for passing up as a regulatory hint */
> >       wlc_cm->world_regd =3D brcms_world_regd(ccode, ccode_len);
> >       if (brcms_c_country_valid(ccode))
> > -             strncpy(wlc->pub->srom_ccode, ccode, ccode_len);
> > +             memcpy(wlc->pub->srom_ccode, ccode, ccode_len);
>
>         const char *ccode =3D sprom->alpha2;
>         int ccode_len =3D sizeof(sprom->alpha2);
>
> struct ssb_sprom {
>         ...
>         char alpha2[2];         /* Country Code as two chars like EU or U=
S */
>
> This should be marked __nonstring, IMO.
>
> struct brcms_pub {
>         ...
>         char srom_ccode[BRCM_CNTRY_BUF_SZ];     /* Country Code in SROM *=
/
>
> #define BRCM_CNTRY_BUF_SZ        4       /* Country string is 3 bytes + N=
UL */
>
> This, however, is shown as explicitly %NUL terminated.
>
> The old strncpy wasn't %NUL terminating wlc->pub->srom_ccode, though, so
> the memcpy is the same result, but is that actually _correct_ here?

Judging from the usage, we can see that only bytes at offset 0 and 1 are
used. I think the comment "/* Country string is 3 bytes + NUL */" might
be misleading or perhaps there are other uses that I can't find (which
require NUL-termination)?

>
> >
> >       /*
> >        * If no custom world domain is found in the SROM, use the
> > @@ -354,10 +354,10 @@ struct brcms_cm_info *brcms_c_channel_mgr_attach(=
struct brcms_c_info *wlc)
> >       }
> >
> >       /* save default country for exiting 11d regulatory mode */
> > -     strncpy(wlc->country_default, ccode, ccode_len);
> > +     memcpy(wlc->country_default, ccode, ccode_len);
> >
> >       /* initialize autocountry_default to driver default */
> > -     strncpy(wlc->autocountry_default, ccode, ccode_len);
> > +     memcpy(wlc->autocountry_default, ccode, ccode_len);
>
> struct brcms_c_info {
>         ...
>         char country_default[BRCM_CNTRY_BUF_SZ];
>         char autocountry_default[BRCM_CNTRY_BUF_SZ];
>
> These are similar...

I can't find any uses for these either.

>
> So, this change results in the same behavior, but is it right?
>
> -Kees
>
> --
> Kees Cook

Thanks
Justin
