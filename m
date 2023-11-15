Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7D27ED620
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbjKOVfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjKOVfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:35:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520B811D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:35:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD9AC433B6;
        Wed, 15 Nov 2023 21:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700084108;
        bh=RWdpyuo51tuvIqwMGTL3/I2DqmEZBZKqCR84EaR63Ic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ax7GU+e8NoT5NkhfbCkd6P6Edug5yH+pW3/V5VyW1TLH2HPz/nr8R2GsxsPPVVGO/
         lkVfE0amR6D0oREGacbWEFDSThlzJ3Pm0CER2NugqFfsP0Qye78NcoEx79ePWeiK/N
         4GtOmqctClRVu77IayArzEX3uErPWajp+mdTfHt+FPR4QEM7HqzyFPPRgwQLnG59yu
         yM1iH72Ttd3X+Ga/HmssO1USouNL74sFTlcfI0TMsslOwjnn0uMTkt/djrjl4wGANN
         xaaIuNoJGhaqoIcWxPaLgWUy/WQzFirCRX3c5F+wRRn+5cKfxKkY9WyIEZvt/p5TbR
         odUwMB52SGjpQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-507bd19eac8so153263e87.0;
        Wed, 15 Nov 2023 13:35:07 -0800 (PST)
X-Gm-Message-State: AOJu0Ywm9nsiRfMF8uBmCx8wMk4+F/+/c4LHGoTjuQAdMV16mDN/zNvi
        EGOfhoKX6RKpZkZWv3aqmB/dv4YJZS+mBadghw==
X-Google-Smtp-Source: AGHT+IFl6KjrcRk1mQBCW5HE5cpfkWvGnPq2lzZKYvuAbqxy2DSLTn7CJKpIC3Dea3cgv04VsyssEPWyJ1Gce9eCWAA=
X-Received: by 2002:a05:6512:3f12:b0:507:a6a5:a87b with SMTP id
 y18-20020a0565123f1200b00507a6a5a87bmr12750059lfa.51.1700084106033; Wed, 15
 Nov 2023 13:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20231109100606.1245545-1-wenst@chromium.org> <859ac058-c50a-4eb8-99b6-3011ef4e7529@collabora.com>
 <CAL_JsqK64w3+r_LJZoh50PzAUcsvH6ahSDCqgSiKrD3LBAXE9g@mail.gmail.com>
 <CAD=FV=VUZy9DaZgKafSpXXopD5k8ExGSR97BjAqC5tupPoxNfQ@mail.gmail.com>
 <CAL_Jsq+puq20EWkQg1RTs2zfmh4DGbqz1krp+19c=wPXnLT5dA@mail.gmail.com> <CAD=FV=X-17COQ2-tycV1bSuCrGy7MJ88Un8nA-a-ODexvgi9TQ@mail.gmail.com>
In-Reply-To: <CAD=FV=X-17COQ2-tycV1bSuCrGy7MJ88Un8nA-a-ODexvgi9TQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 15 Nov 2023 15:34:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKR_YD6hm4Lv+OuCKms8Ha61BZRKUuiLYPgSkz3_3NCFA@mail.gmail.com>
Message-ID: <CAL_JsqKR_YD6hm4Lv+OuCKms8Ha61BZRKUuiLYPgSkz3_3NCFA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] of: Introduce hardware prober driver
To:     Doug Anderson <dianders@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        petr.tesarik.ext@huawei.com, rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 2:45=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, Nov 15, 2023 at 2:28=E2=80=AFPM Rob Herring <robh+dt@kernel.org> =
wrote:
> >
> > > So if we're searching the whole device tree for "failed-needs-probe"
> > > then we need to figure out which devices are related to each other. I=
f
> > > a given board has second sources for MIPI panels, touchscreens, and
> > > trackpads then we need to know which of the "failed-needs-probe"
> > > devices are trackpads, which are touchscreens, and which are MIPI
> > > panels. Do you have any suggestions for how we should do that? Maybe
> > > it was in some other thread that I missed? I guess we could have a
> > > board-specific table mapping (compatible + node name + reg) to a
> > > class, but that feels awkward.
> >
> > Node name is supposed to correspond to device class, so why not use
> > that (no path or unit-address.) and nothing else (well, besides
> > "status")?
>
> One problem is that I could imagine having two second source trackpads
> that both have the same i2c address. That would give them the same
> name, right? I guess you could maybe come up with some sort of suffix
> rule? Like
>
> trackpad-1@10 {
>   compatible =3D "elan,blah";
>   ret =3D <0x10>;
>   status =3D "failed-needs-probe";
>   ...
> }
> trackpad-2@10 {
>   compatible =3D "goodix,gt7375p";
>   ret =3D <0x10>;
>   status =3D "failed-needs-probe";
>   ...
> }
>
> Then I guess the class would be "trackpad"?

That issue is somewhat orthogonal because it is not following the spec.

I'm not sure mixing the 2 styles of node names is a good idea. While
not used too much, matching by node name does ignore the unit-address,
but I'm not sure we could ignore a '-N'.

I think our options are either add something to the unit-address or
use i2c-mux binding. Adding to the unit-address is not unprecedented.
I did that for some of the register bit level bindings where you have
a node for different bits at the same address. The downside is
unit-address is bus specific, so we'd have to add that for multiple
buses. For the i2c-mux, it's perhaps a bit complex and I'm not sure
what if anything you'd have to do to manage the mux that's not really
there.

Rob
