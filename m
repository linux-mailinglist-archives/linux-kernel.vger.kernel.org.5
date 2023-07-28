Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9360576639F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 07:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjG1F07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 01:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG1F0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 01:26:52 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C1D30FC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:26:50 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-63d0f62705dso11473856d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 22:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20221208.gappssmtp.com; s=20221208; t=1690522010; x=1691126810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cE7yzj/ShJctTo/cH8TMuQ/2VH0iD1G1+5KA9qirh/Y=;
        b=trpErXEJEPDZtUwJrLhT56jOvw/TASEnxJqiim24u87Ey219zXjICSpgcrZjP+hIvC
         YOisNcRp1EFcZBuqaw0v47KkdLVd0rFI+qxA+sXUlebSorcP7hGjMv3NkVKwxd1A+1fM
         +cPBg+wk6aUxXSizYt9OOW8K2HwaRZylnOeA2baYNkYAkyTSt3uSNK4bqSBTUKRlrYKH
         veSyepWn/C4JI0VyBkgwNf9ieJKzWg0hb3tCI/tmQqhFz8s1wdV5XOJi6PQyomubgQDL
         AUwaUxnOfbqg6WW2SXOJHHuKT2fULl3OjCF9EdNHMtPrrV+gZMyo2wDTP0lf87ec5+Bk
         zCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690522010; x=1691126810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cE7yzj/ShJctTo/cH8TMuQ/2VH0iD1G1+5KA9qirh/Y=;
        b=CzmVJzN8l3+ltnQzBbhIN8Kk/dY1WgyV4j4YAL57Zp998N2b6dgaZR+fphygzXsUFq
         seG7yGOu3mg7VSL/henfaOtqu65D6kunHTifAJpD4jTieYIOR62FgvgYj6VDVzRG8EmY
         uHMtvcwIeqoLxxC9NSCfJS0XRxXZuWobY0/ienFCafk/Fg09nSPggv00LdLRzL2Xrxhh
         phL+Z0wxSkuAfzZHJke1MjM/UmE8I8X49pFxKEKdOS+0P4BCJbRlSXkGz63FRNgLhN7W
         m2IHSbhDpVOFwez2Oir28YDLP+LSSQeeP4KavNgthms7OTjNKyhwq5HZV2xBlgElQI3V
         wIMQ==
X-Gm-Message-State: ABy/qLZG+kHaErfC7oAO29oIMiOKH/YSkrxY7K5Wffzuthu6FA6KtJTD
        lrDri8fNDhomQWkEqRIuuMmMQnxywAaqlVlqEYpNig==
X-Google-Smtp-Source: APBJJlGaHKu68l916QbJnESfurRQ8GLdxdUM6h1VlhU7qK1FfkFxQTpsfGqhPqGZxqp+5PbL922CfRISxETZ4hSkBS0=
X-Received: by 2002:ad4:45a9:0:b0:63c:fc39:3c0d with SMTP id
 y9-20020ad445a9000000b0063cfc393c0dmr1353378qvu.62.1690522009771; Thu, 27 Jul
 2023 22:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230720152737.102382-1-helen.koike@collabora.com>
 <CAF6AEGtXL5vjp3Uup6Mk19MiY8E26-tpyXVmxXYhMd3fiadykQ@mail.gmail.com> <CAF6AEGsxLg4og1EkCdno6P8x31KK=rJfmerJa8uMeNR-n7RVRg@mail.gmail.com>
In-Reply-To: <CAF6AEGsxLg4og1EkCdno6P8x31KK=rJfmerJa8uMeNR-n7RVRg@mail.gmail.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Fri, 28 Jul 2023 06:26:39 +0100
Message-ID: <CAPj87rPNyJ=mX1Um6yaN_jTV2gH5MhMxr3mnSb7=nB7NEOf2Ag@mail.gmail.com>
Subject: Re: [PATCH v10] drm: Add initial ci/ subdirectory
To:     Rob Clark <robdclark@gmail.com>
Cc:     Helen Koike <helen.koike@collabora.com>, emma@anholt.net,
        linux-doc@vger.kernel.org, david.heidelberg@collabora.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        jbrunet@baylibre.com, robdclark@google.com, corbet@lwn.net,
        khilman@baylibre.com, sergi.blanch.torne@collabora.com,
        gustavo.padovan@collabora.com, linux-rockchip@lists.infradead.org,
        daniels@collabora.com, martin.blumenstingl@googlemail.com,
        mripard@kernel.org, anholt@google.com,
        linux-mediatek@lists.infradead.org, robclark@freedesktop.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, neil.armstrong@linaro.org,
        guilherme.gallo@collabora.com, linux-kernel@vger.kernel.org,
        tzimmermann@suse.de, Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 at 22:47, Rob Clark <robdclark@gmail.com> wrote:
> > I did run into a bit of a chicken vs. egg problem with testing the "in
> > tree" version (compared to earlier versions which kept most of the yml
> > and scripts in a separate tree), is that it actually requires this
> > commit to exist in the branch you want to run CI on.  My earlier
> > workaround of pulling the drm/ci commit in via
> > ${branchname}-external-fixes no longer works.
>
> After unwinding some more gitlab repo settings that were for the
> previous out-of-tree yml setup, I have this working.
>
> Tested-by: Rob Clark <robdclark@gmail.com>
> Acked-by: Rob Clark <robdclark@gmail.com>

And it's also:
Acked-by: Daniel Stone <daniels@collabora.com>

It's been back and forth a few times by now and reviewed pretty
heavily by all the people who are across the CI details. I think the
next step is to answer all the workflow questions by actually getting
it into trees and using it in anger. There was some discussion about
whether this should come in from drm-misc, or the core DRM tree, or a
completely separate pull, but I'm not sure what the conclusion was ...
maintainers, thoughts?

Cheers,
Daniel
