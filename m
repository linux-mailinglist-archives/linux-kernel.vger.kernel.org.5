Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384217C6055
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347010AbjJKWZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjJKWZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:25:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B462AF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:25:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53da72739c3so602178a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697063141; x=1697667941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zNZbeMMG66zQaffulwZBSRVTQq7xegGVzsE2aBNQYM=;
        b=Vk/CYjVRmA34OY+cWbPCRDyipcQMzmvE274FhS1JKNS7qXEDNQCfkR6gNwl/dE5tDp
         8MEkMZUYsKWt5LARKCwqd7jGWhaSVohomXmAWgjXc2TjBsvZHLy45m3IW1jAbPQNmXe9
         KrxqDKnv+5hedt45/0i1elPvPUD82nDWJwOn9mheHyXBowaOfT0McQqHUcBmRXoBqlD1
         Ih0evblLZSAJNkvwxxRqkm7CE89EeVc6euI21eVVQ/yuFO9+/NltplYmM1wsejtlMA2a
         gm1kuU0JDdUVxSSxPsU9L+M65R93YQTlqSeGeKf8dO5ByvmTyW4g2VcuTbx3j72Hs+5X
         QI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697063141; x=1697667941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zNZbeMMG66zQaffulwZBSRVTQq7xegGVzsE2aBNQYM=;
        b=bP1nxEhChd6gZsrWLUs8SFUiv+7QLwOqoOdlcTDUshoJPgpbPnYCNZEwf67jE6PiQo
         iOC2XBrUFo+bVt8ekbO2NNf6RnSkzbQnoEWCv1Wt04NnuHTS1B2zIPJi91tBv78vF+H5
         oM5YcYPX+EeYVpFxicqkgkz6GTRHxnipH1nj+WLaR1yuDqWS1L+eKrY8HlfNKMTgyNxa
         xzBvizicN1+zNBlld3ktRrRlU++7BVZfEc5sAg7jIjMhV2pEQYY8MKaLco7D/hhR8ENT
         ZMMyRxfTIvGo2t+J2YWtGdx0tSt+DGa6DxtoMdNx0yDQDV9/yxxREaunJ6oCEeIE8Xhi
         AsiQ==
X-Gm-Message-State: AOJu0YxCVs6tbeocMg/Jg1cn4oAm/1ZQHrgV499WC6QF/VLtMrApQ09k
        gJ42NloNXhC/UmYGCdkJsnQ7lCT7fG1wYezJZMi7Zw==
X-Google-Smtp-Source: AGHT+IH82POX7rEVI8+B5B5Y6q0ivHvbcCUnUMV5joor+RIQWbQw8OHBFlxjr3E9HWXtTSFfxwUwfy6oVuwv/HSjUd4=
X-Received: by 2002:aa7:d297:0:b0:533:1acb:7134 with SMTP id
 w23-20020aa7d297000000b005331acb7134mr21589053edq.23.1697063141000; Wed, 11
 Oct 2023 15:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-v1-1-23c62a16ff58@google.com>
 <cadf72fc-2c0b-428a-b445-0f6a34c18d9b@amd.com>
In-Reply-To: <cadf72fc-2c0b-428a-b445-0f6a34c18d9b@amd.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 11 Oct 2023 15:25:29 -0700
Message-ID: <CAFhGd8q-q+DfQz_a_NKLmP_CG_fgYz29jZdoqT3qDMBm46VWHw@mail.gmail.com>
Subject: Re: [PATCH] ionic: replace deprecated strncpy with strscpy
To:     "Nelson, Shannon" <shannon.nelson@amd.com>
Cc:     Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Wed, Oct 11, 2023 at 3:17=E2=80=AFPM Nelson, Shannon <shannon.nelson@amd=
.com> wrote:
>
> On 10/11/2023 2:53 PM, 'Justin Stitt' via Pensando Drivers wrote:
> >
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > NUL-padding is not needed due to `ident` being memset'd to 0 just befor=
e
> > the copy.
> >
> > Considering the above, a suitable replacement is `strscpy` [2] due to
> > the fact that it guarantees NUL-termination on the destination buffer
> > without unnecessarily NUL-padding.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Thanks, I suspected this was coming soon :-)
>
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

Thanks Shannon!

>
>
> > ---
> > Note: build-tested only.
> >
> > Found with: $ rg "strncpy\("
> > ---
> >   drivers/net/ethernet/pensando/ionic/ionic_main.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers=
/net/ethernet/pensando/ionic/ionic_main.c
> > index 1dc79cecc5cc..835577392178 100644
> > --- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
> > +++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> > @@ -554,8 +554,8 @@ int ionic_identify(struct ionic *ionic)
> >          memset(ident, 0, sizeof(*ident));
> >
> >          ident->drv.os_type =3D cpu_to_le32(IONIC_OS_TYPE_LINUX);
> > -       strncpy(ident->drv.driver_ver_str, UTS_RELEASE,
> > -               sizeof(ident->drv.driver_ver_str) - 1);
> > +       strscpy(ident->drv.driver_ver_str, UTS_RELEASE,
> > +               sizeof(ident->drv.driver_ver_str));
> >
> >          mutex_lock(&ionic->dev_cmd_lock);
> >
> >
> > ---
> > base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> > change-id: 20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_m=
ain-c-709f8f1ea312
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >
