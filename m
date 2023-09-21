Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100337A9AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjIUSse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjIUSsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:48:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9C0EE861
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:48:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3216ba1b01eso1295343f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695322096; x=1695926896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brAzGA2XEfmHNJOmgEz0xYZn4CECqGMWBMjfuyGkpN0=;
        b=Vv5DnQvTkeakm/54mnejGWYjjWp1aPw9QwS6eM5Hn+Psr+wpG0dO4eG5pLv4pESi0j
         t1p0cROOoJ9YHTcocCLEne/98LvSVinLVAQdzlWpJOjWzNVS+UiaC4M+9ou2aC5EjgIe
         QowvSBcYx98qow7ouH4nmC7iPJ76PG7ZOtOK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322096; x=1695926896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brAzGA2XEfmHNJOmgEz0xYZn4CECqGMWBMjfuyGkpN0=;
        b=b0j5moMp0vRny7aSQSBn+V2vwd3jRABionRSR/lW2oCDo6DcUIXYs/c63VpX88CWQk
         cf+eXqP8ifbC940KQQcp4pgjL38vmy+GeGdLhbiu2omZQmtlLY+4u6IR6wHGGKvVWCde
         LUmyZYI2g5JkeUmLnq4GvE76EL1aBQVCD3Fz96vrNLNDZWg2I8HsHjJXrRiVnD2uyRMG
         dD3Ct1GdLsIqCbzARLACFEw7FTHk1RSZPFi2FrDuca0+dBJAZF4TBumfPBXft60KaSnj
         qijl98yfCxGwNGjeaFb0tvaBmIxE4lV6GdCuvGTXzELsKrnYPjxHSdhpkAcTzOdAollJ
         D8gw==
X-Gm-Message-State: AOJu0YysuZD8Txl96H2BQJSVxGlGh4OTEqBN5YKKnogOxw9ANZK9zajS
        6pkLfH1nXEBQzUfRIbRsViRaTVuQdxV5a7ENL5bwvM1b
X-Google-Smtp-Source: AGHT+IH8bYZi182tC/X0lE81k6HA5OCMqtLJh6nGTGSP24etSulHD2WxzB9fS4SWPSJ4Df49XQyoVg==
X-Received: by 2002:adf:f08a:0:b0:31f:f43e:4f3c with SMTP id n10-20020adff08a000000b0031ff43e4f3cmr6356435wro.8.1695322095997;
        Thu, 21 Sep 2023 11:48:15 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id d26-20020a1709064c5a00b009ad875d12d7sm1436985ejw.210.2023.09.21.11.48.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 11:48:14 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-404f881aa48so19185e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:48:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4c19:b0:3fe:d691:7d63 with SMTP id
 d25-20020a05600c4c1900b003fed6917d63mr120103wmp.6.1695322093885; Thu, 21 Sep
 2023 11:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234015.566018-1-dianders@chromium.org> <20230901163944.RFT.5.I771eb4bd03d8772b19e7dcfaef3e2c167bce5846@changeid>
In-Reply-To: <20230901163944.RFT.5.I771eb4bd03d8772b19e7dcfaef3e2c167bce5846@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Sep 2023 11:48:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vvqd76m-i2vbpVoiTir18S4ceFTd17nGdH1yU+9jhfDw@mail.gmail.com>
Message-ID: <CAD=FV=Vvqd76m-i2vbpVoiTir18S4ceFTd17nGdH1yU+9jhfDw@mail.gmail.com>
Subject: Re: [RFT PATCH 5/6] drm: Call drm_atomic_helper_shutdown() at
 shutdown/remove time for misc drivers
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     airlied@gmail.com, airlied@redhat.com,
        alexandre.torgue@foss.st.com, andrew@aj.id.au, daniel@ffwll.ch,
        emma@anholt.net, hdegoede@redhat.com, jfalempe@redhat.com,
        joel@jms.id.au, jyri.sarha@iki.fi, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, philippe.cornu@foss.st.com,
        raphael.gallais-pou@foss.st.com, tomi.valkeinen@ideasonboard.com,
        tzimmermann@suse.de, yannick.fertre@foss.st.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 1, 2023 at 4:41=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> Based on grepping through the source code these drivers appear to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown time
> and at driver remove (or unbind) time. Among other things, this means
> that if a panel is in use that it won't be cleanly powered off at
> system shutdown time.
>
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS shutdown/restart and at driver remove (or unbind) time comes
> straight out of the kernel doc "driver instance overview" in
> drm_drv.c.
>
> A few notes about these fixes:
> - I confirmed that these drivers were all DRIVER_MODESET type drivers,
>   which I believe makes this relevant.
> - I confirmed that these drivers were all DRIVER_ATOMIC.
> - When adding drm_atomic_helper_shutdown() to the remove/unbind path,
>   I added it after drm_kms_helper_poll_fini() when the driver had
>   it. This seemed to be what other drivers did. If
>   drm_kms_helper_poll_fini() wasn't there I added it straight after
>   drm_dev_unregister().
> - This patch deals with drivers using the component model in similar
>   ways as the patch ("drm: Call drm_atomic_helper_shutdown() at
>   shutdown time for misc drivers")
> - These fixes rely on the patch ("drm/atomic-helper:
>   drm_atomic_helper_shutdown(NULL) should be a noop") to simplify
>   shutdown.
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c |  7 +++++++
>  drivers/gpu/drm/mgag200/mgag200_drv.c   |  8 ++++++++
>  drivers/gpu/drm/pl111/pl111_drv.c       |  7 +++++++
>  drivers/gpu/drm/stm/drv.c               |  7 +++++++
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c     | 11 ++++++++++-
>  drivers/gpu/drm/tve200/tve200_drv.c     |  7 +++++++
>  drivers/gpu/drm/vboxvideo/vbox_drv.c    | 10 ++++++++++
>  7 files changed, 56 insertions(+), 1 deletion(-)

Landed on drm-misc-next:

3c4babae3c4a drm: Call drm_atomic_helper_shutdown() at shutdown/remove
time for misc drivers
