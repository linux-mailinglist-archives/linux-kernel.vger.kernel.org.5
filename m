Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA967AB5CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjIVQXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjIVQXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:23:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA1919C;
        Fri, 22 Sep 2023 09:23:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB637C433C7;
        Fri, 22 Sep 2023 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695399823;
        bh=N6AxtFtkqnMy8GL9TKaW0bmzOTpf5iWTpKPHQH1zQ6Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h2RmYlC+naq65dXlHhsTYzhR5UN0B+QFn6gxO2k+CHaMM1GcFRM1f3q+MM0Rq5bGm
         Yxdw5/wRavg6Z54McAm/TCUaKbsfSrSWdZb8PNjlS4r5uOxa75Cgh4Y8sVh7T3Ccsk
         yuS648MAnIkds3HTlVXjNbFIZgqm9whuKTwar0uHtEwXzhv0X4ULvNJWiE/9y61pRs
         eOMynB8HeXUPJOjeof5HEuLIjvz+ihXKhv8EC/0iTNq6JfMJ6eQlRCtmqnUIcLXwJg
         J2nA9Q+PBAYH68EsUnzs4g/MxyAq0LTbHqIFEOSOCMmuYxEnY1IcpyD9op+DoG+Pun
         yF/Wpof4yBzyQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50337b43ee6so3805451e87.3;
        Fri, 22 Sep 2023 09:23:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YxqbvpknAFysGGPR6xU4EdiIuSKytYblFdhSka2MhvheYFeCBgB
        X6ZLtGAYRQ2DJ4CKCryI2EPwuoH8ME2RMTt82Q==
X-Google-Smtp-Source: AGHT+IFL2X4bMn8orgzNZf0JDqyiiAU4MnhfWwec0CEOtHYtLl1AOA2Ss5IqRERK3lPns8mo81cdhfnvadgZ8kCn8LE=
X-Received: by 2002:a05:6512:312d:b0:502:9c4e:d46a with SMTP id
 p13-20020a056512312d00b005029c4ed46amr28657lfd.32.1695399822017; Fri, 22 Sep
 2023 09:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230911214609.2201040-1-robh@kernel.org> <20230912065946.GC5285@atomide.com>
 <28c862d9-ca39-2dda-86dd-9ccc206c3a1d@ti.com>
In-Reply-To: <28c862d9-ca39-2dda-86dd-9ccc206c3a1d@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Sep 2023 11:23:29 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+8jisrwEqzz7tZnsV9g2+LmThwpO7sHRFA-zh+6q8XuA@mail.gmail.com>
Message-ID: <CAL_Jsq+8jisrwEqzz7tZnsV9g2+LmThwpO7sHRFA-zh+6q8XuA@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: omap: Apply am57xx-idk overlays to base dtbs
To:     Andrew Davis <afd@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 9:38=E2=80=AFAM Andrew Davis <afd@ti.com> wrote:
>
> On 9/12/23 1:59 AM, Tony Lindgren wrote:
> > * Rob Herring <robh@kernel.org> [230911 21:46]:
> >> DT overlays in tree need to be applied to a base DTB to validate they
> >> apply, to run schema checks on them, and to catch any errors at compil=
e
> >> time.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> ---
> >> Note that I have no idea if this combination of overlays makes sense.
> >
>
> It does make sense, but it is only one of many valid combinations. I'm
> guessing the goal here is just to make sure they all get applied in
> at least one way so the scheme check runs. In that case this is fine
> other than it might give the impression this is the only valid combinatio=
ns.

I only care that an overlay is applied to one base. You should care
about any combination a user might do in a bootloader because who
wants to debug a failure a) on a board and b) in the bootloader.

> Also now we end up with these odd `am57{1,2}x-idk-overlays.dtb` files
> which also might confuse folks, I wonder if there is some way to
> apply and check, but not ship/install these..

There's already a config option, CONFIG_OF_ALL_DTBS, which adds
$(dtb-) entries to the build. So if you have "dtb- +=3D
foo-overlays.dtb" it will only be built in that case. Note that they'd
probably get installed too, but who installs allyesconfig builds.

Rob
