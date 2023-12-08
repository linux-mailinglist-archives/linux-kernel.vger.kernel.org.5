Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9707B809D3D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573284AbjLHHjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573249AbjLHHjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:39:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3571721
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:39:11 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c32bea30dso30065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 23:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702021149; x=1702625949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FCkP1UOSFN/6Yv9hZtznqIMqYxp7IUc2r86Qofpf4h4=;
        b=AxHsxAZ/xykqhTKH/4qrAOMgBFMUS6FtjwtZwCt2FJ107pcqxjfJe2TEmC7LTkxXb+
         rRmw6jAe31h2VQyMtb2IUDm9t9P8hrzRDhIMDR+J+geyyFoOI9QMhR/rJto3YQ3JvgDy
         Ufli6jeAosTAEhRXe0fviP6h189aLa9SqcyguZfuhLnGIlIoiqGGcPi1xcUedPItOGir
         Lv1pgYf/N7vI5EcUchnsnJ0JFQtQNtPk1pbSFVOCLY+Cf+v6TCQbmkcNgADIPKzUFL7S
         zUIvUz1xuWyZakmWucGiOHHSlqoCwv8gIdK2OhGdIefeoGq5TX3WHo8YX/wPtYQPZRk6
         OK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702021149; x=1702625949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCkP1UOSFN/6Yv9hZtznqIMqYxp7IUc2r86Qofpf4h4=;
        b=O+DhmQXv0Q8Zv5BWMxKkPAIgMUQjSJr8E/e0oCqjaEYpTghw/EuvMYgv1v7k6eQGV8
         UAJhBsk7nF/h48sUdi3Ykdelt8ztDGYIg6OYJ45JEmCNv0rVmo2CcZwaGNi1L1gPJGv4
         8ap17gw+3lSP7V+uKInymJno0DKDk2yTAj3NLy2svDPICLWHs65fUGLCpxRPDvjzPhNt
         9Et3JE98wdGD7DlWd404fZrG/sneS2QwhBUrWCq+WqF+fBz6Zxjnx3WToZjyLvYp8oqb
         TfFk+EaHDgZDLuu6NqGbZx+zxuoTte2UhOrUb0KfteeKahU6lm9RKjhjp+HCeE9uMfEA
         V0Gg==
X-Gm-Message-State: AOJu0Yw6tO/Zx/3mPZQITOqbV/UaEyGClD5kaKptOtgkvIi/2+VEmJTI
        n2kseIbwFO7oVSUPZAPvYpJ6hDFnFOsrjuFD2Bbwlg==
X-Google-Smtp-Source: AGHT+IHtwp5+Xh1T0DDbMixGMxkesvV/WAZ7PB8oqKgeYis6tuJvGlc9TtYOL/dGIFuzzX0bR0zNC49Q9Vw6vStVMM0=
X-Received: by 2002:a05:600c:2941:b0:405:320a:44f9 with SMTP id
 n1-20020a05600c294100b00405320a44f9mr25035wmd.5.1702021149395; Thu, 07 Dec
 2023 23:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
 <20231205-kunit_bus-v1-2-635036d3bc13@google.com> <202312061306.98DA6D275D@keescook>
In-Reply-To: <202312061306.98DA6D275D@keescook>
From:   David Gow <davidgow@google.com>
Date:   Fri, 8 Dec 2023 15:38:56 +0800
Message-ID: <CABVgOSnTJFeso-=if=2Vs31xoCKNGvN2vM9nCJ37eJNEd=dRYw@mail.gmail.com>
Subject: Re: [PATCH 2/4] fortify: test: Use kunit_device
To:     Kees Cook <keescook@chromium.org>
Cc:     Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 at 05:07, Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Dec 05, 2023 at 03:31:34PM +0800, davidgow@google.com wrote:
> > Using struct root_device to create fake devices for tests is something
> > of a hack. The new struct kunit_device is meant for this purpose, so use
> > it instead.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >  lib/fortify_kunit.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
> > index c8c33cbaae9e..f7a1fce8849b 100644
> > --- a/lib/fortify_kunit.c
> > +++ b/lib/fortify_kunit.c
> > @@ -16,6 +16,7 @@
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> >  #include <kunit/test.h>
> > +#include <kunit/device.h>
> >  #include <linux/device.h>
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> > @@ -269,7 +270,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
> >       size_t len;                                                     \
> >                                                                       \
> >       /* Create dummy device for devm_kmalloc()-family tests. */      \
> > -     dev = root_device_register(dev_name);                           \
> > +     dev = kunit_device_register(test, dev_name);                    \
> >       KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),                       \
> >                              "Cannot register test device\n");        \
> >                                                                       \
> > @@ -303,7 +304,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
> >       checker(len, devm_kmemdup(dev, "Ohai", len, gfp),               \
> >               devm_kfree(dev, p));                                    \
> >                                                                       \
> > -     device_unregister(dev);                                         \
> > +     kunit_device_unregister(test, dev);                             \
> >  } while (0)
> >  DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> (As an aside; shouldn't this get automatically cleaned up like other
> kunit resources, though?)
>

We can't just get rid of the {kunit_,}device_unregister() here,
because otherwise we'd have several devices with the same name during
the test.

So, yes, these get automatically cleaned up, but the test would have
to be restructured to either give each device a different name, or
split the tests up further.

-- David
