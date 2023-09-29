Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9257B3784
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjI2QKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjI2QK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:10:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6491ABE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:10:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3231dff4343so559956f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696003826; x=1696608626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsosfGEshqIoKCDorpEdcceOnoGA7Z3Gi/jf7+l6H3o=;
        b=T0+gcHKB+pVkYprBwVyFx8syY0qimTMhAUbYBsGdenN/tOAUS6K6V74Af28p0LiDy1
         RJs7V3hAORCTcBdANkJHpntEP7y6QgxnMOmo/eC4HJSptiAfzkarlxPir5aqXmhzxHwo
         kFDA45tT81w2cny+mS6LC3RGuni4iRqZU4zojIaxrGs8V7jm7eapAy9nRcxHPDCNhkjv
         lx5hT8bm9LsipNRyV/xD9ij74JAyrTzKKeeEOkBSuTRxEw3b5p9CtqduvdubEEtYTe/s
         BoA09oYqHSmpzwmYYyhwo1X6NuN6OAJu2+vbZ9dvgtctX6biNdFLfqbr8Vk1eKQ7s1/X
         IvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696003826; x=1696608626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsosfGEshqIoKCDorpEdcceOnoGA7Z3Gi/jf7+l6H3o=;
        b=X33EkNS719pyw4T/m8gVF5GUl1/k72LUzcZFYLQl+8iBnCY/r1UTJE7MRD2Pxc2fA+
         q1WsL57ntha0P+RuqYf79adT1P/XiGBD7nJ5DWLYEj27874YJVNH0vI6ZEMHhKUFk066
         hjHZAHO5vZzKMfarKozo/HnMeUFf8hEdclmTt24GW7AMmnoSBSqMUYUT7KSr489c/3j8
         m3XdTTNu8v7movXCidKCQmwySaLZPCWoWUEVSxmI0uyfXGajSTDFag3/kOCvuy77tCIp
         uXt7gnKt3GqslpVZ6/IINyLHsWt2UQLvG9h1TDiPO1ANeJG2pfNI4ljI334rF5cPkvkW
         J/6A==
X-Gm-Message-State: AOJu0YyPxDqA3lzViws68LKmoAGK0QOBXbopgGlh/9IKId8rn95AYyZL
        US2EVyMTVqgN4qk0b10BArgs6NA3ZDln6fbfiN667w==
X-Google-Smtp-Source: AGHT+IGJVy4cn6wsfYJyybJLTpVzhBoLAsGq/mtGnVfwMtDc27EoHCRTJrLpDNvmF4nasPQGeqo5XBwkuq750bEZ3zY=
X-Received: by 2002:a05:6000:1090:b0:31f:f8a7:a26c with SMTP id
 y16-20020a056000109000b0031ff8a7a26cmr4058353wrw.25.1696003825641; Fri, 29
 Sep 2023 09:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230920153819.2069869-1-andriy.shevchenko@linux.intel.com> <CAKwvOd=7vk2HKOpgVrRd2RtKSF9tXPqbVmN+5teLTNoBy4BWVg@mail.gmail.com>
In-Reply-To: <CAKwvOd=7vk2HKOpgVrRd2RtKSF9tXPqbVmN+5teLTNoBy4BWVg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 29 Sep 2023 09:10:11 -0700
Message-ID: <CAKwvOdkbcUh+tmsNcT4nCzFY37WbAUdjHJ62qNe=p8SetaQNTQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Replace custom implementation of COUNT_ARGS()
To:     "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        llvm@lists.linux.dev, alsa-devel@alsa-project.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 9:50=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Sep 20, 2023 at 8:38=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Replace custom and non-portable implementation of COUNT_ARGS().
> >
> > Fixes: e64b674bc9d7 ("software node: implement reference properties")
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Closes: https://lore.kernel.org/r/ZQoILN6QCjzosCOs@google.com
>
> Thanks for the patch!
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1935
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Of course Linux would have a macro for this!  I should have known.
> Trying to wrap my head around it. Awesome

(resending as text/plain)

Can someone pick this up for linux-next?

CI for linux-next has been red for days over this.

>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  include/linux/property.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index 1684fca930f7..55c2692ffa8c 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -10,6 +10,7 @@
> >  #ifndef _LINUX_PROPERTY_H_
> >  #define _LINUX_PROPERTY_H_
> >
> > +#include <linux/args.h>
> >  #include <linux/bits.h>
> >  #include <linux/fwnode.h>
> >  #include <linux/stddef.h>
> > @@ -314,7 +315,7 @@ struct software_node_ref_args {
> >  #define SOFTWARE_NODE_REFERENCE(_ref_, ...)                    \
> >  (const struct software_node_ref_args) {                               =
 \
> >         .node =3D _ref_,                                          \
> > -       .nargs =3D ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1, \
> > +       .nargs =3D COUNT_ARGS(__VA_ARGS__),                       \
> >         .args =3D { __VA_ARGS__ },                                \
> >  }
> >
> > --
> > 2.40.0.1.gaa8946217a0b
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
