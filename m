Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7D27ADCCB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjIYQKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjIYQKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:10:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2654410A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:10:13 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a648f9d8e3so900198166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695658209; x=1696263009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cwEuixmjVjieATmQA+XE8BdmzJIt5P+ghGd9MnmN4o=;
        b=DwSaGvG3lAkuEu7faXgfXIajdRZ9XWr7g1Hd+c7xYXx1BZW5sR8gXEoYzOiXaS3QKF
         Ay3KV1y2KJrdo+/JLYkjWr6fmwEV8qAzb8VY5pxZUaVpxUpivXCBWPFEBWF3KALUHGBs
         uUD5+RLIhEGoYpGFv08Q/TGNx89xH+q87lEv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695658209; x=1696263009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cwEuixmjVjieATmQA+XE8BdmzJIt5P+ghGd9MnmN4o=;
        b=an+KJ5lexyiu79kL1flmx2M3OhATxsVbkHd9SRJC1s4iycAzx7DSrJZmuG6Y2vnVC7
         BlCungTPg+ZWkMEitILP5Ybe+J6lVGSQcM0QTnMHu/RkgeP68SzKuDHehVwVRaygsBia
         a1tRP5mjrVqsz3YVsCrMEBmqIvidqZez98gHnEb4gS74HpQ3Gu2WpSRELByAwT9A01l7
         kHkB5ykEggIw9BMq1wDPpwYcH7gPw/oiNfLrrqx28I8uwA54+DlXb7lylyV3NeuC4Ue7
         1l/8mUP9aC2y0O71Zn30kbfWGYnNSwen15Gx1MbIVfY2ZhZjweKIpRH1yM8im84mDN9Z
         D/fQ==
X-Gm-Message-State: AOJu0YwR4BkPYm234dqYUAgKynsAetmUCmcyO6PXakJLWorl4ljBwFsA
        VvgYSS1zVP9W2DSyatBurABIHeztGCeDuBlvB43dlA==
X-Google-Smtp-Source: AGHT+IH1UqY9GIQn88RSuSSYVXUzd32kNJysXCAj9AVWZIZVdPqm1cA1aFDLbhg+DYLsqKPbx+hE4g==
X-Received: by 2002:a17:906:18:b0:9ae:4054:5d2a with SMTP id 24-20020a170906001800b009ae40545d2amr7996847eja.16.1695658209099;
        Mon, 25 Sep 2023 09:10:09 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id k5-20020a1709062a4500b009934b1eb577sm6587544eje.77.2023.09.25.09.10.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 09:10:08 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4053f24c900so144865e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:10:07 -0700 (PDT)
X-Received: by 2002:a05:600c:502b:b0:404:74f8:f47c with SMTP id
 n43-20020a05600c502b00b0040474f8f47cmr117221wmr.5.1695658207419; Mon, 25 Sep
 2023 09:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230921192749.1542462-1-dianders@chromium.org>
 <20230921122641.RFT.v2.11.I022cfc2dcd30e77d4f7005a2d912dd7ab76c0338@changeid> <BL1PR12MB51446279B27EC69BE91D865EF7FCA@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51446279B27EC69BE91D865EF7FCA@BL1PR12MB5144.namprd12.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 25 Sep 2023 09:09:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XzhCmnLC8eqS=0Ug_n4rG2b+GjcFQcDQWXwCOPiHP1LA@mail.gmail.com>
Message-ID: <CAD=FV=XzhCmnLC8eqS=0Ug_n4rG2b+GjcFQcDQWXwCOPiHP1LA@mail.gmail.com>
Subject: Re: [RFT PATCH v2 11/12] drm/radeon: Call drm_helper_force_disable_all()
 at shutdown/remove time
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <mripard@kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 25, 2023 at 8:49=E2=80=AFAM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: Douglas Anderson <dianders@chromium.org>
> > Sent: Thursday, September 21, 2023 3:27 PM
> > To: dri-devel@lists.freedesktop.org; Maxime Ripard <mripard@kernel.org>
> > Cc: Douglas Anderson <dianders@chromium.org>; Pan, Xinhui
> > <Xinhui.Pan@amd.com>; airlied@gmail.com; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org; Koenig,
> > Christian <Christian.Koenig@amd.com>; daniel@ffwll.ch; linux-
> > kernel@vger.kernel.org
> > Subject: [RFT PATCH v2 11/12] drm/radeon: Call
> > drm_helper_force_disable_all() at shutdown/remove time
> >
> > Based on grepping through the source code, this driver appears to be mi=
ssing
> > a call to drm_atomic_helper_shutdown(), or in this case the non-atomic
> > equivalent drm_helper_force_disable_all(), at system shutdown time and =
at
> > driver remove time. This is important because
> > drm_helper_force_disable_all() will cause panels to get disabled cleanl=
y which
> > may be important for their power sequencing. Future changes will remove=
 any
> > custom powering off in individual panel drivers so the DRM drivers need=
 to
> > start getting this right.
> >
> > The fact that we should call drm_atomic_helper_shutdown(), or in this c=
ase
> > the non-atomic equivalent drm_helper_force_disable_all(), in the case o=
f OS
> > shutdown/restart comes straight out of the kernel doc "driver instance
> > overview" in drm_drv.c.
> >
> > NOTE: in order to get things inserted in the right place, I had to repl=
ace the
> > old/deprecated drm_put_dev() function with the equivalent new calls.
> >
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I honestly have no idea if I got this patch right. The shutdown() funct=
ion
> > already had some special case logic for PPC, Loongson, and VMs and I do=
n't
> > 100% for sure know how this interacts with those. Everything here is ju=
st
> > compile tested.
>
> I think the reason for most of this funniness is to reduce shutdown time.=
  Lots of users complain if driver takes a while to shutdown and there is a=
 point to be made that if the system is going into power down, there is not=
 much reason to spend a lot of time messing with the hardware.

Sure, you don't want to do too much at shutdown time. That's the whole
reason that "shutdown" doesn't do a full remove / uninitialization of
all drivers. ...but drm_atomic_helper_shutdown() is documented to do
the things that are important for shutdown. Specifically, it cleanly
disables all of the displays. Depending on the display, this could
avoid temporary garbage on the display at reboot time or it could even
be important for the long term health of the panel.

-Doug
