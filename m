Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E3C7A9EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjIUUL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjIUULg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:11:36 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641B172424
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:56:46 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bff776fe0bso22676791fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695322604; x=1695927404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qMZGPaiZgAdeetgQNbPZflVmvG6j0/UMJZSOWqoH/Y=;
        b=AIwSM9egBE5hBk760f3vx4dtodqmsV2Bwqi9OVNgrW92prYC8hN7wDHD8Diauu7hNy
         YcpzlKhDmTsW0oQLdugXBfhQLFTa56aeQhm0oZ+Oy6vYr8QCmK3OyPgO3tkWVxXMMNfu
         bQRpqZHNmmeMt94YtfueY+4sONzpA96y8c7dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322604; x=1695927404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qMZGPaiZgAdeetgQNbPZflVmvG6j0/UMJZSOWqoH/Y=;
        b=DqJ0QT1om+a3McgTQIYNN7qTzJQ5Y19Ji5yEvyYvxvKaeO5lUWd57KCF9kaMicWea4
         nrDdf2EBNrbYTyFcj0D8R03hT3qc6cmYjhxqvaie1Gnoj6NdZvNTq5IvtSCaefaPc7c3
         kJ1O3KHEz30V09BPs7z5qqBhHbXCJisEKcCShZK+/UFb0ONOHgu3H6PN6D17utqBDLw8
         fzwLbRjmXS6B4OqWKXTvfvJBFmEkyYUgu9K7IHD2VAXfI0r91HKPzCG/s6XC2p4PXn1N
         0R9TtB8Iwf3PwKikOhhEUt7MLCfW9vP72Oj43e9NOEZStyPKu/CAPs9zT6MRLsyMyN4W
         aHuw==
X-Gm-Message-State: AOJu0YyxC6e+zw7rVh3WyOKmKsiK829UbF5TOLiqPCwx5U0sW/7v41Tm
        2NeeRHHqSI82XXDhcofJbQKjfpkZLqTVV0Xe+Bi0I6Jb
X-Google-Smtp-Source: AGHT+IExT7FC5dwJtS7VwH0Oze2X4rNi91/okaJBwzABBHflh+GyLqv1lMPWLhGakhQ7XhuXZHqDGw==
X-Received: by 2002:a2e:850a:0:b0:2bd:1cd0:603f with SMTP id j10-20020a2e850a000000b002bd1cd0603fmr5581295lji.45.1695322603856;
        Thu, 21 Sep 2023 11:56:43 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id r21-20020a2e9955000000b002b9b90474c7sm479342ljj.129.2023.09.21.11.56.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 11:56:43 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50348c54439so832e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:56:43 -0700 (PDT)
X-Received: by 2002:a05:600c:1da1:b0:404:7462:1f87 with SMTP id
 p33-20020a05600c1da100b0040474621f87mr125460wms.6.1695322143955; Thu, 21 Sep
 2023 11:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234015.566018-1-dianders@chromium.org> <20230901163944.RFT.6.I21e0916bbd276033f7d31979c0da171458dedd4d@changeid>
In-Reply-To: <20230901163944.RFT.6.I21e0916bbd276033f7d31979c0da171458dedd4d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Sep 2023 11:48:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X87dWnp+sOQBUG=Mx6_YrD5BbDxHWJjE08_k378T+aAw@mail.gmail.com>
Message-ID: <CAD=FV=X87dWnp+sOQBUG=Mx6_YrD5BbDxHWJjE08_k378T+aAw@mail.gmail.com>
Subject: Re: [RFT PATCH 6/6] drm/hisilicon/kirin: Call drm_atomic_helper_shutdown()
 at shutdown/unbind time
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        jstultz@google.com, kong.kongxinwei@hisilicon.com,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        steven.price@arm.com, sumit.semwal@linaro.org,
        tiantao6@hisilicon.com, tzimmermann@suse.de,
        u.kleine-koenig@pengutronix.de, xinliang.liu@linaro.org,
        yongqin.liu@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 1, 2023 at 4:41=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown time
> and at driver unbind time. Among other things, this means that if a
> panel is in use that it won't be cleanly powered off at system
> shutdown time.
>
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS shutdown/restart and at driver remove (or unbind) time comes
> straight out of the kernel doc "driver instance overview" in
> drm_drv.c.
>
> I have attempted to put this in the right place at unbind time. In
> most other DRM drivers the call is made right after the call to
> drm_kms_helper_poll_fini(), so I've put it there. That means that this
> call will also be made in the case that we hit errors in bind, since
> kirin_drm_kms_cleanup() is called both in the bind error path and in
> unbind. I believe this is harmless even though it's not needed in the
> bind error path.
>
> For handling shutdown, we rely on the common technique of seeing if
> the drvdata is NULL to know whether we need to call
> drm_atomic_helper_shutdown(). This makes it important to make sure
> that the drvdata is NULL if bind failed or if unbind was called. We
> don't need the actual check for NULL and we'll rely on the patch
> ("drm/atomic-helper: drm_atomic_helper_shutdown(NULL) should be a
> noop").
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This commit is only compile-time tested.
>
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Landed in drm-misc-next:

918ce0906dcd drm/hisilicon/kirin: Call drm_atomic_helper_shutdown() at
shutdown/unbind time
