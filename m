Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1497F4620
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344032AbjKVM3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKVM3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:29:08 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C185CB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:29:02 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1ef370c2e12so3818729fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1700656142; x=1701260942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1NMtf5TNC4hWWw549jqhQu4xI8dAUFYNGtWt0AUtBAo=;
        b=Va8Eg1CMUMgl9VcyHVf/u07WW3Wg5MlUSVd1r6f1Gwbli7OjTw5SW8eYJZAeD1BJNh
         gOG+aBBR1nOdjJ4ngu52CgyLsgtxBSSyMJF3dr4gGDfgRRaD5GxVy9f+pdwShT/rrYcz
         1lbgDigVEKu7N3RHA99kES49F7wa3NlkKoqk70OS8Tny8o816QntvI+jyYJE+p9WLV1b
         La0iALB2Hnfy8gEEJOV3Q/lR1yPvI0cw748UDB2LXevKNYuGt6ElMOfQIDpWGVKAFIMY
         p2+2v9Lo2so6j4c/T+tquQLEg2ZwiXfobhonVNeJveoXKZ/Z9jcZa/TN5SXYwOBynxys
         9j6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656142; x=1701260942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NMtf5TNC4hWWw549jqhQu4xI8dAUFYNGtWt0AUtBAo=;
        b=OxtMgCE0Arr983gVc9oFzDYMRBIb+UByXdK5xk5pBuFP+LfC4vGBs6FsCFR4Epulre
         5y36Ce4aXSGTNsUgxAhoBKr15SgxpuT/Ojm/6Pi5ck42opmDI09xMdECenwlwX38Gp32
         yVeyBvp+k20cEz0w7QfUXp9EwdHigHxonN9ipMqjivIVa1mBHnskMede+OG9nYmFfBkx
         cP803Pg63t1BSKWbH7RlmKiXbx2INw8ODbsVDeOOF1oRQcpXJiQl4cFbCfq5gCfFrf8I
         efCTb3UlxrJ4t6vRoIilMvhBBimWXecr+WYspUneqOkf7nh9K/4KTQsLwwoLexxNOY1M
         vjNg==
X-Gm-Message-State: AOJu0Yw99oDF5JxFgK2xQWun898ddcWQBCU4XTFhNSgOxCzw1Dtm4w2N
        RT225wBuRwoX12UuTOlZZl/fPbJ+VTMHzkV6hWxvVQ==
X-Google-Smtp-Source: AGHT+IE4RhkDbuclMq9ltVuFBkZXZA8BM882FOXeUnb6DCxbwIotur+3+O8VDD4iyzzyKVOmUB7dBUVGZkG6Y+BhQW4=
X-Received: by 2002:a05:6870:c98f:b0:1e1:e36a:fb74 with SMTP id
 hi15-20020a056870c98f00b001e1e36afb74mr2997080oab.26.1700656141830; Wed, 22
 Nov 2023 04:29:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1700648164.git.cmo@melexis.com> <2e8b4a7d3ef4bc1c53bd0a849e4c31eaf2477f6b.1700648165.git.cmo@melexis.com>
 <99d1808a-da04-4bc1-a1f7-cbd269adbbf0@kernel.org>
In-Reply-To: <99d1808a-da04-4bc1-a1f7-cbd269adbbf0@kernel.org>
From:   Crt Mori <cmo@melexis.com>
Date:   Wed, 22 Nov 2023 13:28:25 +0100
Message-ID: <CAKv63uv87srZ3gJxFASuGWV6cULXkN=gYi_L=BCcd3dgOFQEfw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: iio: temperature: add MLX90635 device bindings
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 at 12:52, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 22/11/2023 11:27, Crt Mori wrote:
> > Add device tree bindings for MLX90635 Infra Red contactless temperature
> > sensor.
>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
>

OK, will put everyone in that list in next spin.

> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
>

 Ok, will fix that in next version (probably main driver review will
get some comments).

> >
> > Signed-off-by: Crt Mori <cmo@melexis.com>
> > ---
> >  .../iio/temperature/melexis,mlx90635.yaml     | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/melexis,mlx90635.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90635.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90635.yaml
> > new file mode 100644
> > index 000000000000..96463121a806
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90635.yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90635.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Melexis MLX90635 contactless Infra Red temperature sensor
> > +
> > +maintainers:
> > +  - Crt Mori <cmo@melexis.com>
> > +
> > +description: |
> > +  https://www.melexis.com/en/documents/documentation/datasheets/datasheet-mlx90635
> > +
> > +  There are various applications for the Infra Red contactless temperature
> > +  sensor and MLX90635 is most suitable for consumer applications where
> > +  measured object temperature is in range between -20 to 100 degrees
> > +  Celsius with relative error of measurement 2 degree Celsius in
> > +  object temperature range for industrial applications, while just 0.2
> > +  degree Celsius for human body measurement applications. Since it can
> > +  operate and measure ambient temperature in range of -20 to 85 degrees
> > +  Celsius it is suitable also for outdoor use.
> > +
> > +  Be aware that electronics surrounding the sensor can increase ambient
> > +  temperature. MLX90635 can be calibrated to reduce the housing effect via
> > +  already existing EEPROM parameters.
> > +
> > +  Since measured object emissivity effects Infra Red energy emitted,
> > +  emissivity should be set before requesting the object temperature.
> > +
> > +properties:
> > +  compatible:
> > +    const: melexis,mlx90635
>
> It's the same as mlx90632. Add it there (as enum).
>

Properties are the same, but then you can't have much differences for
a temperature sensor. It has a bit worse relative measurement error
outside of the human body range and overall different DSP, register
map, even physical size - it's 1.8x1.8 mm compared to 90632 3x3 mm. I
was not sure how it qualifies for adding it as another enum, but I
went with the feeling that if it can reuse the driver, then it is an
enum, otherwise it is a new file. And I could not reuse anything from
90632.

Thanks for quick feedback and best regards,
Crt
> Best regards,
> Krzysztof
>
