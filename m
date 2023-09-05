Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA4F792A5C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbjIEQfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354381AbjIELLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:11:00 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B611AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:10:56 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5731fe1d2bfso1241527eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 04:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693912255; x=1694517055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lFHibJcCTrHc7UsLYmrMGzSLKGIb6u3hELCj6ZH9vKM=;
        b=OM1vIucC15OkU1q9zHgy2hbBgUczskCy0YhURNBMLs7K6089N93HULK4gSpN1Hopn+
         K7iK0GPgS0zks2MUevv19dB4mBk8wcUuSgUPmjYGPZZa3VWUcS9Fz/o0r0M35yIzIAwA
         N4uSw45pJTMqyXUF+zxT1S5EqkkmfVcC2x6u1i21I4kwigBCCeVtTx4MCOupbqcffaRE
         g6xYybIBNeK3gcJ7HrUePgg0VyOpB5wFAeFnckyFwXAuxwavilOIjWKPWblvUt6kNm+5
         iJnsnXjNRHWLS9pYHy5BFD9185CaB/lIYMoZOkfAOKIsN0PkEVP1Ozuqwcz1unGFHTtq
         sJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693912255; x=1694517055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFHibJcCTrHc7UsLYmrMGzSLKGIb6u3hELCj6ZH9vKM=;
        b=SG/6SCoc1Nv2y7njLmnUVA1NFu10AOAyVgDbdyT+8MvdRB/xKEW8a9N0TcIzNEdjif
         eQPsUsE6dTQKb5eDM0yDczd6GFwyeVws7v34DK7TUeWM/lA29t4tUslNSSzCUt0p+jid
         d2PQg81FEX3jcdD9GEdqhNNetQLqlDi1dsYdFCYh3yfJR6KTLgFNg2wOLYIs3P6UKOTG
         1ELDNvAMpkh9XJidy4NJneYkhkTEU/SU+dik8vjvtECYQZ35+J51FpBD5c556XOT384w
         PoSlTGJjNGXp3pZzpO364R/RMbYXlUYb2JgdkQBYm8LiOZWPijb+IYBI6l8gjuABHjaM
         dETA==
X-Gm-Message-State: AOJu0YxCdeOfNMLu4D4z7JkWOhkk+BM75fwm6J/c01ps67Ax83z7f+6h
        wmCXUW5yeElwSYfgu1tAab+Fr70Vy7Trz4egcm+SQQ==
X-Google-Smtp-Source: AGHT+IFo9xBi2/mp2LlaAKkJ92fJy9V9XtRAZ9XtjSlMoeM6e+JjrV7rskbJMCadKMIvoAvsNXEXvZjxBF6IQTrAKW0=
X-Received: by 2002:a05:6358:63a4:b0:135:24ed:5106 with SMTP id
 k36-20020a05635863a400b0013524ed5106mr8346763rwh.9.1693912255339; Tue, 05 Sep
 2023 04:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230904161516.66751-1-vignesh.raman@collabora.com>
 <20230904161516.66751-3-vignesh.raman@collabora.com> <CAA8EJpq_cmFQ6TGy1xELh3ButWKLfSkQcp5ix049s_iqKw6DvQ@mail.gmail.com>
 <ueznsu2dlvq5zp3ls262fww54bnlqa3e2ssr6f65vrrionloms@ir2ywgeajj4w>
 <2c812fe4-04ba-0243-5330-c7b7e695cff9@collabora.com> <2jz6wurh6ejbaejwtb5r5gukjuw4zs7ujk5hbwfpsn26o6esqe@g2nnb2gjpnjp>
In-Reply-To: <2jz6wurh6ejbaejwtb5r5gukjuw4zs7ujk5hbwfpsn26o6esqe@g2nnb2gjpnjp>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 5 Sep 2023 14:10:44 +0300
Message-ID: <CAA8EJpoGoopP64T1nm1ye1ukTwT=u+LYY1ubQG-9dQ-j41iHiA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm: ci: Force db410c to host mode
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Vignesh Raman <vignesh.raman@collabora.com>,
        dri-devel@lists.freedesktop.org, helen.koike@collabora.com,
        guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
        david.heidelberg@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robclark@freedesktop.org, robdclark@google.com, anholt@google.com,
        robdclark@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sept 2023 at 14:00, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Tue, Sep 05, 2023 at 03:39:33PM +0530, Vignesh Raman wrote:
> > Hi Dmitry, Maxime,
> >
> > On 05/09/23 14:13, Maxime Ripard wrote:
> > > Hi,
> > >
> > > On Mon, Sep 04, 2023 at 07:59:26PM +0300, Dmitry Baryshkov wrote:
> > > > On Mon, 4 Sept 2023 at 19:16, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> > > > >
> > > > > Force db410c to host mode to fix network issue which results in failure
> > > > > to mount root fs via NFS.
> > > > > See https://gitlab.freedesktop.org/gfx-ci/linux/-/commit/cb72a629b8c15c80a54dda510743cefd1c4b65b8
> > > > >
> > > > > Use fdtoverlay command to merge base device tree with an overlay
> > > > > which contains the fix for USB controllers to work in host mode.
> > > > >
> > > > > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > > > > ---
> > > > >
> > > > > v2:
> > > > >    - Use fdtoverlay command to merge overlay dtbo with the base dtb instead of modifying the kernel sources
> > > > >
> > > > > ---
> > > > >   drivers/gpu/drm/ci/build.sh                         |  5 +++++
> > > > >   .../gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts  | 13 +++++++++++++
> > > > >   2 files changed, 18 insertions(+)
> > > > >   create mode 100644 drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> > > > >
> > > > > diff --git a/drivers/gpu/drm/ci/build.sh b/drivers/gpu/drm/ci/build.sh
> > > > > index 7b014287a041..92ffd98cd09e 100644
> > > > > --- a/drivers/gpu/drm/ci/build.sh
> > > > > +++ b/drivers/gpu/drm/ci/build.sh
> > > > > @@ -92,6 +92,11 @@ done
> > > > >
> > > > >   if [[ -n ${DEVICE_TREES} ]]; then
> > > > >       make dtbs
> > > > > +    if [[ -e arch/arm64/boot/dts/qcom/apq8016-sbc.dtb ]]; then
> > > > > +        dtc -@ -I dts -O dtb -o drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dtbo drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> > > > > +        fdtoverlay -i arch/arm64/boot/dts/qcom/apq8016-sbc.dtb -o arch/arm64/boot/dts/qcom/apq8016-sbc-overlay.dtb drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dtbo
> > > > > +        mv arch/arm64/boot/dts/qcom/apq8016-sbc-overlay.dtb arch/arm64/boot/dts/qcom/apq8016-sbc.dtb
> > > > > +    fi
> > > > >       cp ${DEVICE_TREES} /lava-files/.
> > > > >   fi
> > > > >
> > > > > diff --git a/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts b/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> > > > > new file mode 100644
> > > > > index 000000000000..57b7604f1c23
> > > > > --- /dev/null
> > > > > +++ b/drivers/gpu/drm/ci/dt-overlays/apq8016-sbc-overlay.dts
> > > > > @@ -0,0 +1,13 @@
> > > > > +/dts-v1/;
> > > > > +/plugin/;
> > > > > +
> > > > > +/ {
> > > > > +    fragment@0 {
> > > > > +        target-path = "/soc@0";
> > > > > +        __overlay__ {
> > > > > +            usb@78d9000 {
> > > > > +                dr_mode = "host";
> > > > > +            };
> > > > > +        };
> > > > > +    };
> > > > > +};
> > > > > --
> > > > > 2.40.1
> > > >
> > > > Can we use normal dtso syntax here instead of defining fragments manually?
> > >
> > > What Dmitry is hinting about is to use the "Sugar Syntax". There a good documentation here:
> > > https://source.android.com/docs/core/architecture/dto/syntax
> >
> >
> > With the below DTO syntax,
> > /dts-v1/;
> > /plugin/;
> >
> > &usb {
> >   usb@78d9000 {
> >     dr_mode = "host";
> >   };
> > };
> >
> > Decoded dtbo file is,
> > /dts-v1/;
> >
> > / {
> >
> >       fragment@0 {
> >               target = <0xffffffff>;
> >
> >               __overlay__ {
> >
> >                       usb@78d9000 {
> >                               dr_mode = "host";
> >                       };
> >               };
> >       };
> >
> >       __fixups__ {
> >               usb = "/fragment@0:target:0";
> >       };
> > };
> >
> > With the previous fix using fragment we get,
> > / {
> >
> >       fragment@0 {
> >               target-path      = "/soc@0";
> >
> >               __overlay__ {
> >
> >                       usb@78d9000 {
> >                               dr_mode = "host";
> >                       };
> >               };
> >       };
> > };
> >
> > Decoded apq8016-sbc.dtb file with the fix (setting dr_mode to host) is,
> > /dts-v1/;
> > / {
> >       soc@0 {
> >               usb@78d9000 {
> >                       dr_mode = "host";
> >               };
> >       };
> > };
> >
> > How can set the target to "soc@0" using the DTO syntax?
>
> To strictly answer your question, that would be something like
>
> &{/soc@0} {
>         usb@78d9000 {
>                 dr_mode = "host";
>         };
> };
>
> You can simplify this further however by doing:
>
>
> &{/soc@0/usb@78d9000} {
>         dr_mode = "host";
> };
>
> Also, that node actually has a label ("usb"), defined here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/msm8916.dtsi#n2322
>
> So you can end up with
>
> &usb {
>         dr_mode = "host";
> };

... which is the simplest and thus more robust one.

> All of them should be equivalent to the one you had in your patch.
>
> Maxime

-- 
With best wishes
Dmitry
