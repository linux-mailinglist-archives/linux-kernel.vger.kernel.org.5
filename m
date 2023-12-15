Return-Path: <linux-kernel+bounces-1794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D32A58153FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604B11F24961
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5582918EC1;
	Fri, 15 Dec 2023 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2x7HTmy/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AA81DDC5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c32bea30dso20145e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702680511; x=1703285311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbI008FwkAGh6OQKmN5oST6SiRX3AZBUL7LLv+QG9V0=;
        b=2x7HTmy/Y0wkJsdO8FH2y/FOE6L/xsfTjUTDHTYgcuzoM/fSetZVC4X/FNCHQ/NLaJ
         sdf3aPoD/jH+nO8zmiuf8dkrsdd8eX7aSO+Cm7iN9eusGEKYW/BCisKFY+OC5tFO+BzN
         B56nT91cWFgPKDHBnixf1z4bKzoWLhfZHd3EXkOaHIEJA6eQ+6vT8PkCDkg75xVnEoxN
         rQ/sd0JW4Z6/94Fw1ksF/Nm5NX9QpXO9mQdLzYqymZ6rL1zEiG/SfeHUJ6XhaAd6SuJa
         kx/2HmN5Krrff9bDE6CRUDkGhFRqoqR9Z7n2Svh+FOJl3qxxPKwDb9JT3R3x5U+7eNsC
         Tpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702680511; x=1703285311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nbI008FwkAGh6OQKmN5oST6SiRX3AZBUL7LLv+QG9V0=;
        b=pw8MRsipxchmxlgx2/q5E8OpCGCd+gNeV1V9nPRh/LuJoCh2/Qw1VTjxBYKTOzpK/b
         1Ev4K9xQoOMdSYtH9fLQMXhDY3WUwHgrMW3HLUw7Xs+Q5dawzJzK2M/1KLf9AdcqR5m+
         TME36YR0fCXMLhs1AwUgTkHASU+liNhfypRuOANgKCzPuau/5zpzkpzwfV+/r6jV2I1Y
         j0hjJdZXlFUIukXtWd2ECFjAKBwEXDO4ADTsnL1Ix/CZNFzg+VkmdBJB25rA+hdjXPT6
         8hHfA6ZWoAt7Xlc8eKs6I0TPBy2PjJ574ogFTAkGfkompp+47qpJNoGZlIZ/aILJGbPj
         O6Yg==
X-Gm-Message-State: AOJu0YwL/6bq+1xmFSHRfWjSFnP+h2ghUQq9ZhNvEAxLKqSscpSUuzFq
	bJgFeI/Llzu8WTW36QTGsZJ9JClsK3bEEk3RMnnML4j1iUXb
X-Google-Smtp-Source: AGHT+IEH+Qv9RSKhq/9jfnZdW9wTtoZNpMp0oTYJLHBu5gyf33Rz+fOC//89NFuG+KLCZxxYdvGGUhPx3em0gRZM++U=
X-Received: by 2002:a05:600c:1c28:b0:40a:483f:f828 with SMTP id
 j40-20020a05600c1c2800b0040a483ff828mr46852wms.4.1702680510823; Fri, 15 Dec
 2023 14:48:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215-kunit_bus-v4-0-4f5160e2f95e@google.com> <20231215-kunit_bus-v4-5-4f5160e2f95e@google.com>
In-Reply-To: <20231215-kunit_bus-v4-5-4f5160e2f95e@google.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 15 Dec 2023 17:48:18 -0500
Message-ID: <CA+GJov5k35_SLnDXdTOAyrRUStc-fk__u0b6HXshfzLQovOhtQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] drm/tests: Switch to kunit devices
To: davidgow@google.com
Cc: Brendan Higgins <brendan.higgins@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 2:39=E2=80=AFAM <davidgow@google.com> wrote:
>
> From: Maxime Ripard <mripard@kernel.org>
>
> Kunit recently gained helpers to create test managed devices. This means
> that we no longer have to roll our own helpers in KMS and we can reuse
> them.

Hello!

This looks good to me. Thanks!

Reviewed-by: Rae Moar <rmoar@google.com>

-Rae

>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Tested-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  drivers/gpu/drm/tests/drm_kunit_helpers.c | 66 ++-----------------------=
------
>  1 file changed, 3 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/=
tests/drm_kunit_helpers.c
> index c251e6b34de0..ca4f8e4c5d5d 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -5,6 +5,7 @@
>  #include <drm/drm_kunit_helpers.h>
>  #include <drm/drm_managed.h>
>
> +#include <kunit/device.h>
>  #include <kunit/resource.h>
>
>  #include <linux/device.h>
> @@ -15,28 +16,6 @@
>  static const struct drm_mode_config_funcs drm_mode_config_funcs =3D {
>  };
>
> -static int fake_probe(struct platform_device *pdev)
> -{
> -       return 0;
> -}
> -
> -static struct platform_driver fake_platform_driver =3D {
> -       .probe  =3D fake_probe,
> -       .driver =3D {
> -               .name   =3D KUNIT_DEVICE_NAME,
> -       },
> -};
> -
> -KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_platform_driver_unregister,
> -                           platform_driver_unregister,
> -                           struct platform_driver *);
> -KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_platform_device_put,
> -                           platform_device_put,
> -                           struct platform_device *);
> -KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_platform_device_del,
> -                           platform_device_del,
> -                           struct platform_device *);
> -
>  /**
>   * drm_kunit_helper_alloc_device - Allocate a mock device for a KUnit te=
st
>   * @test: The test context object
> @@ -54,34 +33,7 @@ KUNIT_DEFINE_ACTION_WRAPPER(kunit_action_platform_devi=
ce_del,
>   */
>  struct device *drm_kunit_helper_alloc_device(struct kunit *test)
>  {
> -       struct platform_device *pdev;
> -       int ret;
> -
> -       ret =3D platform_driver_register(&fake_platform_driver);
> -       KUNIT_ASSERT_EQ(test, ret, 0);
> -
> -       ret =3D kunit_add_action_or_reset(test,
> -                                       kunit_action_platform_driver_unre=
gister,
> -                                       &fake_platform_driver);
> -       KUNIT_ASSERT_EQ(test, ret, 0);
> -
> -       pdev =3D platform_device_alloc(KUNIT_DEVICE_NAME, PLATFORM_DEVID_=
NONE);
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> -
> -       ret =3D kunit_add_action_or_reset(test,
> -                                       kunit_action_platform_device_put,
> -                                       pdev);
> -       KUNIT_ASSERT_EQ(test, ret, 0);
> -
> -       ret =3D platform_device_add(pdev);
> -       KUNIT_ASSERT_EQ(test, ret, 0);
> -
> -       ret =3D kunit_add_action_or_reset(test,
> -                                       kunit_action_platform_device_del,
> -                                       pdev);
> -       KUNIT_ASSERT_EQ(test, ret, 0);
> -
> -       return &pdev->dev;
> +       return kunit_device_register(test, KUNIT_DEVICE_NAME);
>  }
>  EXPORT_SYMBOL_GPL(drm_kunit_helper_alloc_device);
>
> @@ -94,19 +46,7 @@ EXPORT_SYMBOL_GPL(drm_kunit_helper_alloc_device);
>   */
>  void drm_kunit_helper_free_device(struct kunit *test, struct device *dev=
)
>  {
> -       struct platform_device *pdev =3D to_platform_device(dev);
> -
> -       kunit_release_action(test,
> -                            kunit_action_platform_device_del,
> -                            pdev);
> -
> -       kunit_release_action(test,
> -                            kunit_action_platform_device_put,
> -                            pdev);
> -
> -       kunit_release_action(test,
> -                            kunit_action_platform_driver_unregister,
> -                            &fake_platform_driver);
> +       kunit_device_unregister(test, dev);
>  }
>  EXPORT_SYMBOL_GPL(drm_kunit_helper_free_device);
>
>
> --
> 2.43.0.472.g3155946c3a-goog
>

