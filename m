Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0CB7AB50A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjIVPoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjIVPoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:44:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E24136
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:44:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso286584966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695397469; x=1696002269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x30RhvJx7Eh4gJJcrIw3/KmQaNQO6cXN4EDW/eJIqIA=;
        b=PC60PjWqK/mI2tx9dCu5BVECUTP+AmGzAKiixv8mM+roedHVJLr5nbAX6JEWbKFEGn
         KdEwg7OG/HDIpRrY4vY5mpgtKH+rIPYcywSghzw9EDfiM2AcBmWHBbTG/WMZInC0J//e
         OQxMQvMTinNEG4QFTYLsE08UCzEP4bzUOLYl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695397469; x=1696002269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x30RhvJx7Eh4gJJcrIw3/KmQaNQO6cXN4EDW/eJIqIA=;
        b=rcnQheCUy2mJFH16mdc+51APUVP8DZMEkI1tuXugr2nnVALmn1ZJGzyAx8ALtufCWX
         ktgnecmXggJG1XfJ6kKbBT0bcmIx1ol3KkjpdjCNOF3WesaBpJ0Q41A7nGMgE6S2HNI3
         B2V1d7Y7zi5AqZQ27eNA3Js+/J+025JdXV3Cdb2PgCfnqKUFsgTW0AOBP9+gsisApQRf
         fEHkit4BvX8C/1TWeN9K0E4cN6pOCwEYCAeSMpZcNPtkAcRHmFIF+Fj6V7+29iWSmkCf
         amL2GKDXgAqAwH5KAzw2bfBCnbhy0ijBXHSSUA2NSeJke1KbGL9eqdJsJMBQQq0tqMG6
         /6Ew==
X-Gm-Message-State: AOJu0YzWCsiYYMu4mau2aly3b3J1KnpgGqBgF+d4Bf7mwnTmmiwTlpoJ
        LH+sLNZm6E+bA+QaxWEO2mJFc0z1xBP+UhA0Q+i9U1SC
X-Google-Smtp-Source: AGHT+IH0M1x0u+d57s+3tQCtH0U54sV7wj8oG7XeODemCOc8PpnGATY+WFIx6ltvOh/kKkHPpM99Vw==
X-Received: by 2002:a17:906:3044:b0:9a5:c54f:da1c with SMTP id d4-20020a170906304400b009a5c54fda1cmr8167640ejd.47.1695397468671;
        Fri, 22 Sep 2023 08:44:28 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id n25-20020a170906119900b009887f4e0291sm2850723eja.27.2023.09.22.08.44.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 08:44:28 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-405459d9a96so28375e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:44:28 -0700 (PDT)
X-Received: by 2002:a05:600c:2e4c:b0:404:7462:1f87 with SMTP id
 q12-20020a05600c2e4c00b0040474621f87mr79571wmf.6.1695397467960; Fri, 22 Sep
 2023 08:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230921192749.1542462-1-dianders@chromium.org>
 <20230921122641.RFT.v2.1.I134336fce7eac5a63bdac46d57b0888858fc8081@changeid> <20230922075610.ekrzyz6hfcd3rjsm@fsr-ub1664-121.ea.freescale.net>
In-Reply-To: <20230922075610.ekrzyz6hfcd3rjsm@fsr-ub1664-121.ea.freescale.net>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Sep 2023 08:44:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ViV-n2T1Bup+XScsWD11yWpTmW3qEOLTTDj3kTtTY4Cg@mail.gmail.com>
Message-ID: <CAD=FV=ViV-n2T1Bup+XScsWD11yWpTmW3qEOLTTDj3kTtTY4Cg@mail.gmail.com>
Subject: Re: [RFT PATCH v2 01/12] drm/imx/dcss: Call drm_atomic_helper_shutdown()
 at shutdown time
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, airlied@gmail.com,
        daniel@ffwll.ch, festevam@gmail.com, kernel@pengutronix.de,
        l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
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

On Fri, Sep 22, 2023 at 12:56=E2=80=AFAM Laurentiu Palcu
<laurentiu.palcu@oss.nxp.com> wrote:
>
> Hi,
>
> On Thu, Sep 21, 2023 at 12:26:44PM -0700, Douglas Anderson wrote:
> > Based on grepping through the source code this driver appears to be
> > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > time. Among other things, this means that if a panel is in use that it
> > won't be cleanly powered off at system shutdown time.
> >
> > The fact that we should call drm_atomic_helper_shutdown() in the case
> > of OS shutdown/restart comes straight out of the kernel doc "driver
> > instance overview" in drm_drv.c.
> >
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> No issues found on i.MX8MQ.
>
> Tested-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Thanks! Would you expect this patch to land through drm-misc? If so,
I'm happy to commit it there with your tags. If patches to this driver
normally flow through drm-misc, I'm also happy to post a patch to
MAINTAINERS (or review a patch you post) adding this to the entry for
"NXP i.MX 8MQ DCSS DRIVER":

T:     git git://anongit.freedesktop.org/drm/drm-misc

...which would make it obvious in the future that things should land
through drm-misc. This is similar to what I did for commit
92e62478b62c ("MAINTAINERS: Update DRM DRIVERS FOR FREESCALE IMX
entry"). :-)

-Doug
