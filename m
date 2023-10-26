Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D44D7D7D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344254AbjJZHHb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 03:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZHH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:07:29 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C62129;
        Thu, 26 Oct 2023 00:07:27 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-779fb118fe4so44000485a.2;
        Thu, 26 Oct 2023 00:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698304046; x=1698908846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moS5fR7OYOBC36D4IDUFcRhCbJ+jsem7+MoLbL129AU=;
        b=X3ZATYtxCsSPuUZWYDE32N4ArGiHFcsK4KgArUExjW7M9keByY76GdmmttHQ0/IjUL
         8b9Fdnh4WLa6ws4PVoxb/ynZMfNizxJ4f34KBmARgRYFEENKjK3/4sQJJZv8lnJY6MWv
         vOJkXD8reUKleW9zPejhGeDMgeWw9aPOWtW75lhqtqjlepmbpJl+7IpdVlH3o08mXF32
         oWN6O2JaWF5af/DrvvBIzqnW8J1kPqbvy+0BticyfWswMK0pgOG6MIPZ5q4iImOsQkaN
         BxEd5W+fSB+y3svO984EkGTcjmNU4jIJnSRbyVQU8Waggpc40TudNfpgExhLz2cmH6FQ
         IsyQ==
X-Gm-Message-State: AOJu0YxzMRqKQzKJy0Hes3lXdrodn6nzh4YD7tYjJLmN2NcufhNJgOH1
        D8U5Ot2wk4quXzjBH1c/bHfIdlQuj3mtdQ==
X-Google-Smtp-Source: AGHT+IHQTNr8OjzjllJV8A0NdRYg61BNHCrkkQ5cusbH08b4CeEhrZmHfWcjM0uBxokzltjjaX4yQA==
X-Received: by 2002:a05:620a:51d6:b0:775:9bc3:beb7 with SMTP id cx22-20020a05620a51d600b007759bc3beb7mr17597277qkb.0.1698304046606;
        Thu, 26 Oct 2023 00:07:26 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id y83-20020a0dd656000000b0056d51c39c1fsm5717956ywd.23.2023.10.26.00.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 00:07:26 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a90d6ab962so4125807b3.2;
        Thu, 26 Oct 2023 00:07:26 -0700 (PDT)
X-Received: by 2002:a0d:ca8d:0:b0:5a7:d9f9:2285 with SMTP id
 m135-20020a0dca8d000000b005a7d9f92285mr19127428ywd.26.1698304046047; Thu, 26
 Oct 2023 00:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <56a5ebee588696f9022fa29fa8e266c8bdee6fd7.1698228043.git.geert+renesas@glider.be>
 <4aaabd0-98f1-3c56-96d5-9b3b789dc36c@intel.com>
In-Reply-To: <4aaabd0-98f1-3c56-96d5-9b3b789dc36c@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Oct 2023 09:07:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXjqGfENeiDjNRBZgiE+99OpPFzCvFLuyKKTTg973YSyQ@mail.gmail.com>
Message-ID: <CAMuHMdXjqGfENeiDjNRBZgiE+99OpPFzCvFLuyKKTTg973YSyQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mfd: ams,as3711: Convert to json-schema
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guennadi,

On Thu, Oct 26, 2023 at 7:51 AM Guennadi Liakhovetski
<guennadi.liakhovetski@linux.intel.com> wrote:
> On Wed, 25 Oct 2023, Geert Uytterhoeven wrote:
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ams,as3711.yaml

> > +maintainers:
> > +  - Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
>
> Sorry for a late reply. I just noticed that you specified me as a
> maintainer of as3711 code in your new file. Even though I did author the
> original version of the driver more than 10 years ago, I haven't worked on
> it for a long time, so I think it would be better to pick up a more
> relevant person there.

Good to hear from you!
However, I am afraid you are still the most relevant person...

And let's try the new Mailing list etiquette guidelines ;-)
https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replying
https://subspace.kernel.org/etiquette.html#trim-your-quotes-when-replying

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
