Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD6E7EDB08
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjKPFHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPFHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:07:47 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB18719E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:07:43 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507bd644a96so536694e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700111262; x=1700716062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n47o3OCFeDC4YRz6dczMMUhasbGb5AVuJwwpKHI7eFo=;
        b=kMy9X+ZvZZcOmSWLeFHvAHNtNge8oJD4OdCGchhk/D79Ye4EhoblebUNO5c+S3dXIQ
         di50xAIrda8ld6gu7NWvTpo1V4/u261eu9DsWH7w7TBDe0RD+7Ip3ezP31g0kDfJZ5uy
         rgUc95XjztBClPsRiO0/U+e0Ep7N+ozu5DH5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700111262; x=1700716062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n47o3OCFeDC4YRz6dczMMUhasbGb5AVuJwwpKHI7eFo=;
        b=l3GF9i4qtClOO4zsebT4tDysmvNNoijjbD7r3YZsiJhosgccwqPM82/CekI3qRwpQ0
         GourLIjynOaIaAQFo1MTnmEWhnTfyFKO7SotkWBeOlkMDZ0VFWexCG9iB0bElhMKAQ3p
         loy5uBHiC0Kg3+Cac4etW5BvZ7T2lHMXtzLZjhMTnEsM9AAgCAY5ppWuU0SguzkqqUTi
         7nprNHDlX1mgKNHBFz4T10Kh2xwyPACei9wRxnp1vqjwGKSiwDf2NMZdrTDXFItxJM0m
         DPAVwSMZCXghzyKOSsDRm0GJ8rKDAOBmIcFxZsAzo4geiDg5D4I8vbFE9DwVrlHDbkgm
         nAjA==
X-Gm-Message-State: AOJu0Ywuozt4HcMw+xhQurFXwAImN5guyKYMyJgGlgdj9NWzDdkcOfDK
        XbwqAszlJ1jxH/B3MaSwhaFe7SNahTS4RhPr+bXfFA==
X-Google-Smtp-Source: AGHT+IHE03gJszw8lf/xHkWqpl61E8rAlryiMxaNRq78cfueM1p5kFwPjBIZVK5w9yvg2jCkjEB/Vh2Q6LEYk1Pq+cI=
X-Received: by 2002:a19:7616:0:b0:509:4980:7bf0 with SMTP id
 c22-20020a197616000000b0050949807bf0mr9759057lff.38.1700111261841; Wed, 15
 Nov 2023 21:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20231109100606.1245545-1-wenst@chromium.org> <859ac058-c50a-4eb8-99b6-3011ef4e7529@collabora.com>
 <CAL_JsqK64w3+r_LJZoh50PzAUcsvH6ahSDCqgSiKrD3LBAXE9g@mail.gmail.com>
 <CAD=FV=VUZy9DaZgKafSpXXopD5k8ExGSR97BjAqC5tupPoxNfQ@mail.gmail.com>
 <CAL_Jsq+puq20EWkQg1RTs2zfmh4DGbqz1krp+19c=wPXnLT5dA@mail.gmail.com>
 <CAD=FV=X-17COQ2-tycV1bSuCrGy7MJ88Un8nA-a-ODexvgi9TQ@mail.gmail.com> <CAL_JsqKR_YD6hm4Lv+OuCKms8Ha61BZRKUuiLYPgSkz3_3NCFA@mail.gmail.com>
In-Reply-To: <CAL_JsqKR_YD6hm4Lv+OuCKms8Ha61BZRKUuiLYPgSkz3_3NCFA@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Nov 2023 13:07:30 +0800
Message-ID: <CAGXv+5Gu4fmfriCh5wfeyqGPAX+LyLEDkCCrp4+_3XvS9-mAmw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] of: Introduce hardware prober driver
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 5:35=E2=80=AFAM Rob Herring <robh+dt@kernel.org> wr=
ote:
>
> On Wed, Nov 15, 2023 at 2:45=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Wed, Nov 15, 2023 at 2:28=E2=80=AFPM Rob Herring <robh+dt@kernel.org=
> wrote:
> > >
> > > > So if we're searching the whole device tree for "failed-needs-probe=
"
> > > > then we need to figure out which devices are related to each other.=
 If
> > > > a given board has second sources for MIPI panels, touchscreens, and
> > > > trackpads then we need to know which of the "failed-needs-probe"
> > > > devices are trackpads, which are touchscreens, and which are MIPI
> > > > panels. Do you have any suggestions for how we should do that? Mayb=
e
> > > > it was in some other thread that I missed? I guess we could have a
> > > > board-specific table mapping (compatible + node name + reg) to a
> > > > class, but that feels awkward.
> > >
> > > Node name is supposed to correspond to device class, so why not use
> > > that (no path or unit-address.) and nothing else (well, besides
> > > "status")?
> >
> > One problem is that I could imagine having two second source trackpads
> > that both have the same i2c address. That would give them the same
> > name, right? I guess you could maybe come up with some sort of suffix
> > rule? Like
> >
> > trackpad-1@10 {
> >   compatible =3D "elan,blah";
> >   ret =3D <0x10>;
> >   status =3D "failed-needs-probe";
> >   ...
> > }
> > trackpad-2@10 {
> >   compatible =3D "goodix,gt7375p";
> >   ret =3D <0x10>;
> >   status =3D "failed-needs-probe";
> >   ...
> > }
> >
> > Then I guess the class would be "trackpad"?
>
> That issue is somewhat orthogonal because it is not following the spec.
>
> I'm not sure mixing the 2 styles of node names is a good idea. While
> not used too much, matching by node name does ignore the unit-address,
> but I'm not sure we could ignore a '-N'.

of_node_name_prefix() solves that. I assume that's the intended use case?

> I think our options are either add something to the unit-address or
> use i2c-mux binding. Adding to the unit-address is not unprecedented.
> I did that for some of the register bit level bindings where you have
> a node for different bits at the same address. The downside is
> unit-address is bus specific, so we'd have to add that for multiple
> buses. For the i2c-mux, it's perhaps a bit complex and I'm not sure
> what if anything you'd have to do to manage the mux that's not really
> there.
>
> Rob
