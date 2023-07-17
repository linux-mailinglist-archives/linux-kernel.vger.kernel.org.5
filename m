Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEB97567BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjGQPXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjGQPXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8DB173F;
        Mon, 17 Jul 2023 08:23:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8FA461134;
        Mon, 17 Jul 2023 15:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E725C433CC;
        Mon, 17 Jul 2023 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689607345;
        bh=s72Q/8XYhHQvzmI1VDsEoAqOtnrO5eU9UNP8CV8UKys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C0emZjBNCquR9Voe1+urrx1DBzBKr/jIAPVcl7u3QyWptIgTEaYmI2gncVVzCgAS5
         UsJ3cmZgP5/bjdGONrJUV/8N+Qg3CZcPU9NQ8I231bshDjHFaaq8IRPUKlOty/uLJq
         asTt8cRYh9EedkxLKjIOeHO6MkHuxL+gwcBMRVq66EArGgNGRm67cPUWwJJvCakvko
         VkdbEJ8bQWgSTaXdf7jKSuxVfcwLBmk+N8o3hvYCcSK44mUiRfpl0VyIosk4kYBuYA
         cVoo29w8Fc9X9JkzfvMXlZBP6bz6III07Lk8epOGDkmTQpyYYFGYa5VS408LD0Ocz6
         miuGXx/6g/rHg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b70bfc8db5so68917131fa.2;
        Mon, 17 Jul 2023 08:22:25 -0700 (PDT)
X-Gm-Message-State: ABy/qLb6r7vEQcoB/oVi8BsUDQUTIyc1oM0mclHmSRC2imggsEIpWmC3
        l6BqYIJiyj62F4aljrvlOBfqsxrJH3Yw34rL0A==
X-Google-Smtp-Source: APBJJlFjUVuF8cT9Mjizg85yzlG3XoHjjgUIN2M6YkcqSURtLtAQSGtjkKNJqo2G7fj6obony0hWhkxkfR/W6HeRCjA=
X-Received: by 2002:a2e:9d84:0:b0:2b6:e76b:1e50 with SMTP id
 c4-20020a2e9d84000000b002b6e76b1e50mr9175045ljj.41.1689607343110; Mon, 17 Jul
 2023 08:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230714175035.4065508-1-robh@kernel.org> <317a9fd8-0ae9-daa0-012b-3908ca248b74@suse.de>
In-Reply-To: <317a9fd8-0ae9-daa0-012b-3908ca248b74@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 17 Jul 2023 09:22:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ2bkBU0WQG2jt755c_V4x4uR36Dvt2qEeXv52zCWeUmw@mail.gmail.com>
Message-ID: <CAL_JsqJ2bkBU0WQG2jt755c_V4x4uR36Dvt2qEeXv52zCWeUmw@mail.gmail.com>
Subject: Re: [PATCH] fb: Explicitly include correct DT includes
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Helge Deller <deller@gmx.de>, Michal Simek <michal.simek@amd.com>,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 12:34=E2=80=AFPM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> Hi
>
> Am 14.07.23 um 19:50 schrieb Rob Herring:
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it as merged into the regular platform bus.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those includ=
e
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> [...]
> >
> > @@ -48,7 +48,7 @@ int sbusfb_mmap_helper(struct sbus_mmap_map *map,
> >       unsigned long map_offset =3D 0;
> >       unsigned long off;
> >       int i;
> > -
> > +
>
> The various whitespace fixes should rather go into a separate patch. You
> can add
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> to the whitespace fix and the include cleanup.

Indeed. I missed dropping the whitespace change.

Rob
