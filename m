Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2105F7A200A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbjIONpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbjIONpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:45:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D806B1BEB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:45:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-501bef6e0d3so3469997e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694785500; x=1695390300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4UHa0/oq66alw95ljztJJEQxyAHYh4BXAB2kPfRssY=;
        b=deNEYaTEQ1hUfIPELdlPJVagpRyXes8SOnT3NewE+W8HKtQsATTgmmfB68eutYn7j3
         6xhEijKhs9ZI6PY1WYsbFwkE/TFVL0O31nnSqiU23u++j3YrssfGU8tSeYuOQ+t47tBA
         pdLQCm4cphD0tu34fCmrTgbDsatBdOjt3HOjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694785500; x=1695390300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4UHa0/oq66alw95ljztJJEQxyAHYh4BXAB2kPfRssY=;
        b=IwDqKvW8FUBGTtuuWADh2HxZ/w7Am7KIYj0Eb2xQVHioDdJ7kYLk5OvAvvjZw9A/lA
         5jBb/WyrRPzpyV9I6BCUdvBCQYXXeen1JAX09qvD7JteO6dO9tuLCuSfvo22Ay+FiDll
         TGFIna5CyQojrY0JWK4pIKHTQHGblaDv33864jrJpUtaNfuLxulPaRmfcEL7DPfPMJCM
         05Ji4yX094bh4EUK+OMUsI3jkap3fp7ZFciywF8VJPoDs62wy/lTnAscDaV47rZF0VPn
         UBQyarTmwjTqVImAq3+R0FsXF4CM/h0baJyFkRW+75SB+qOVcv5uwUWBeTpbVANm3jOf
         nklQ==
X-Gm-Message-State: AOJu0YzeEqc0wdEuSijiVq+AWzHKHHnzZfA25UN3gTuRUqws1W0BnMFC
        3zHOkJQJaK0B8Do95+GjbiUkvHx2E2oBgDV+1+EOVc8+
X-Google-Smtp-Source: AGHT+IGBwcbOrp1yz3E7C3hxYrGUJrvdlvNMvv7XYXfQlIhlsss6o7Mjh899N0NoMKRJbipS7oNzQw==
X-Received: by 2002:ac2:58c5:0:b0:4fe:d0f:1f1b with SMTP id u5-20020ac258c5000000b004fe0d0f1f1bmr1422569lfo.65.1694785500085;
        Fri, 15 Sep 2023 06:45:00 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id o8-20020a056512050800b004fb757bd429sm649939lfb.96.2023.09.15.06.44.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 06:44:59 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5009dd43130so2600e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:44:59 -0700 (PDT)
X-Received: by 2002:a50:d09e:0:b0:525:573c:6444 with SMTP id
 v30-20020a50d09e000000b00525573c6444mr118963edd.1.1694785478523; Fri, 15 Sep
 2023 06:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234015.566018-1-dianders@chromium.org>
 <20230901163944.RFT.2.I9115e5d094a43e687978b0699cc1fe9f2a3452ea@changeid> <e7d855b6-327e-8c0c-5913-75bba9b6cfcd@loongson.cn>
In-Reply-To: <e7d855b6-327e-8c0c-5913-75bba9b6cfcd@loongson.cn>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Sep 2023 06:44:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XF65otS2S+6sg6qga6Le3xb1f5GC6R6qpf27zx49DQ6w@mail.gmail.com>
Message-ID: <CAD=FV=XF65otS2S+6sg6qga6Le3xb1f5GC6R6qpf27zx49DQ6w@mail.gmail.com>
Subject: Re: [RFT PATCH 2/6] drm: Call drm_atomic_helper_shutdown() at
 shutdown time for misc drivers
To:     suijingfeng <suijingfeng@loongson.cn>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, airlied@gmail.com,
        airlied@redhat.com, alain.volmat@foss.st.com,
        alexander.deucher@amd.com, alexandre.belloni@bootlin.com,
        alison.wang@nxp.com, bbrezillon@kernel.org,
        christian.koenig@amd.com, claudiu.beznea@microchip.com,
        daniel@ffwll.ch, drawat.floss@gmail.com, javierm@redhat.com,
        jernej.skrabec@gmail.com, jfalempe@redhat.com, jstultz@google.com,
        kong.kongxinwei@hisilicon.com, kraxel@redhat.com,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, liviu.dudau@arm.com,
        nicolas.ferre@microchip.com, paul.kocialkowski@bootlin.com,
        sam@ravnborg.org, samuel@sholland.org,
        spice-devel@lists.freedesktop.org, stefan@agner.ch,
        sumit.semwal@linaro.org, tiantao6@hisilicon.com,
        tomi.valkeinen@ideasonboard.com, tzimmermann@suse.de,
        virtualization@lists.linux-foundation.org, wens@csie.org,
        xinliang.liu@linaro.org, yongqin.liu@linaro.org, zackr@vmware.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 15, 2023 at 2:11=E2=80=AFAM suijingfeng <suijingfeng@loongson.c=
n> wrote:
>
> Hi,
>
>
> On 2023/9/2 07:39, Douglas Anderson wrote:
> > Based on grepping through the source code these drivers appear to be
> > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > time. Among other things, this means that if a panel is in use that it
> > won't be cleanly powered off at system shutdown time.
> >
> > The fact that we should call drm_atomic_helper_shutdown() in the case
> > of OS shutdown/restart comes straight out of the kernel doc "driver
> > instance overview" in drm_drv.c.
> >
> > All of the drivers in this patch were fairly straightforward to fix
> > since they already had a call to drm_atomic_helper_shutdown() at
> > remove/unbind time but were just lacking one at system shutdown. The
> > only hitch is that some of these drivers use the component model to
> > register/unregister their DRM devices. The shutdown callback is part
> > of the original device. The typical solution here, based on how other
> > DRM drivers do this, is to keep track of whether the device is bound
> > based on drvdata. In most cases the drvdata is the drm_device, so we
> > can just make sure it is NULL when the device is not bound. In some
> > drivers, this required minor code changes. To make things simpler,
> > drm_atomic_helper_shutdown() has been modified to consider a NULL
> > drm_device as a noop in the patch ("drm/atomic-helper:
> > drm_atomic_helper_shutdown(NULL) should be a noop").
> >
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
>
> I have just tested the whole series, thanks for the patch. For drm/loongs=
on only:
>
>
> Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
> Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>

Thanks!


> By the way, I add 'pr_info("lsdc_pci_shutdown\n");' into the lsdc_pci_shu=
tdown() function,
> And seeing that lsdc_pci_shutdown() will be called when reboot and shutdo=
wn the machine.
> I did not witness something weird happen at present. As you have said, th=
is is useful for
> drm panels drivers. But for the rest(drm/hibmc, drm/ast, drm/mgag200 and =
drm/loongson etc)
> drivers, you didn't mention what's the benefit for those drivers.

I didn't mention it because I have no idea! I presume that for
non-drm_panel use cases it's not a huge deal, otherwise it wouldn't
have been missing from so many drivers. Thus, my "one sentence" reason
for the non-drm_panel case is just "we should do this because the
documentation of the API says we should", which is already in the
commit message. ;-)

If you have a specific other benefit you'd like me to list then I'm happy t=
o.


> Probably, you can
> mention it with at least one sentence at the next version. I also prefer =
to alter the
> lsdc_pci_shutdown() function as the following pattern:
>
>
> static void lsdc_pci_shutdown(struct pci_dev *pdev)
> {
>
>      struct drm_device *ddev =3D pci_get_drvdata(pdev);
>
>      drm_atomic_helper_shutdown(ddev);
> }

I was hoping to land this patch without spinning it unless there's a
good reason. How strongly do you feel about needing to change the
above? I will note that I coded it the way I did specifically to try
to follow the style in the documentation in "drm_drv.c". In the
example "driver_shutdown()" function you can see that they combined it
into one line and so I followed that style. ;-) That being said, I
have no problem changing this if I spin the patch.

-Doug
