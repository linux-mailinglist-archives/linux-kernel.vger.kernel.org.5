Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2477EDB0E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbjKPFLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPFLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:11:43 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BC8181
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:11:39 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so447627e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700111498; x=1700716298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8JhiyfChFnHfK8gH5OrmY086razpxrVoC9oM/007B8=;
        b=BOeguaTUifrBltCoy6ZYlE52qVyuyWTOCkZCXO79GdcQNFjz6PPTiWQ9pGyQLIGoYD
         ZTYo2vxQ2TYu3YhDCpW+IbvFSPWjEH+zyPpPKnUWwrIkLb1qRryjr/evlKUxr47Pq4mh
         d5eBqDjHXjoRcqIcYUIKtQXsbRU5zFzpH8nTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700111498; x=1700716298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8JhiyfChFnHfK8gH5OrmY086razpxrVoC9oM/007B8=;
        b=GW8a6Sn2PDdCw9Qn1Wno4CEtEE/mb4vD1WqrCsqnJtSj5XPspnbFWJAQo4UA3J4+XU
         kxLa91KxXD+RQb4UQrQYc5nTtabcSAfBdBEzmxyLV+AqDM7UYudnBD/QLRt13X1kW/BL
         mfhgd53oIj3sGmiX2xZaAtBltbcmoxIFhHqWfbyMQd1jmhgb1iY/lEDB7+JOC4CpbMqk
         wq7G20zLwNiLE7a1vaoAISdyhaDnB7jzQUWb0RoUJVBGIYaGbOz8CIOefcDKsN+SxokI
         pkyq1BtjJp6Kt/Askdo8xod+fLxv2YkccZ5WwRiwQwNt1n9FXOLhXvPxR4xOWMBpUOBB
         tKrg==
X-Gm-Message-State: AOJu0YyNZbzZICR1El/58G1k3O7F/kKOqFiVuupy5erJDvKUDjz88hkh
        okwKnoDpwDhKVZlAhh+NMriLatUBnsMao/WoteXCIQ==
X-Google-Smtp-Source: AGHT+IE919p5h6uSBLZUgL0Rce3waJORc1i8w1Vez3b7vQCDhk2f/YDhmtC3VtlqFgH6f/xyZikinMN2oFEIA+DaGMQ=
X-Received: by 2002:a19:ac03:0:b0:509:8da5:5d46 with SMTP id
 g3-20020a19ac03000000b005098da55d46mr174429lfc.17.1700111497544; Wed, 15 Nov
 2023 21:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20231109100606.1245545-1-wenst@chromium.org> <859ac058-c50a-4eb8-99b6-3011ef4e7529@collabora.com>
 <CAL_JsqK64w3+r_LJZoh50PzAUcsvH6ahSDCqgSiKrD3LBAXE9g@mail.gmail.com>
 <CAD=FV=VUZy9DaZgKafSpXXopD5k8ExGSR97BjAqC5tupPoxNfQ@mail.gmail.com>
 <CAL_Jsq+puq20EWkQg1RTs2zfmh4DGbqz1krp+19c=wPXnLT5dA@mail.gmail.com>
 <CAD=FV=X-17COQ2-tycV1bSuCrGy7MJ88Un8nA-a-ODexvgi9TQ@mail.gmail.com>
 <CAL_JsqKR_YD6hm4Lv+OuCKms8Ha61BZRKUuiLYPgSkz3_3NCFA@mail.gmail.com> <CAD=FV=XO5VNuaVKwBHLQC1ukdpHQO0-XTaKnRM=rigbcdOytgQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XO5VNuaVKwBHLQC1ukdpHQO0-XTaKnRM=rigbcdOytgQ@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Nov 2023 13:11:26 +0800
Message-ID: <CAGXv+5E6zYBoiVr4oNQ9LHEgMWBjz4kBNv+sWmRa5_0jEkdUDg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] of: Introduce hardware prober driver
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        rafael@kernel.org, tglx@linutronix.de,
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

On Thu, Nov 16, 2023 at 6:14=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, Nov 15, 2023 at 4:35=E2=80=AFPM Rob Herring <robh+dt@kernel.org> =
wrote:
> >
> > On Wed, Nov 15, 2023 at 2:45=E2=80=AFPM Doug Anderson <dianders@chromiu=
m.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Nov 15, 2023 at 2:28=E2=80=AFPM Rob Herring <robh+dt@kernel.o=
rg> wrote:
> > > >
> > > > > So if we're searching the whole device tree for "failed-needs-pro=
be"
> > > > > then we need to figure out which devices are related to each othe=
r. If
> > > > > a given board has second sources for MIPI panels, touchscreens, a=
nd
> > > > > trackpads then we need to know which of the "failed-needs-probe"
> > > > > devices are trackpads, which are touchscreens, and which are MIPI
> > > > > panels. Do you have any suggestions for how we should do that? Ma=
ybe
> > > > > it was in some other thread that I missed? I guess we could have =
a
> > > > > board-specific table mapping (compatible + node name + reg) to a
> > > > > class, but that feels awkward.
> > > >
> > > > Node name is supposed to correspond to device class, so why not use
> > > > that (no path or unit-address.) and nothing else (well, besides
> > > > "status")?
> > >
> > > One problem is that I could imagine having two second source trackpad=
s
> > > that both have the same i2c address. That would give them the same
> > > name, right? I guess you could maybe come up with some sort of suffix
> > > rule? Like
> > >
> > > trackpad-1@10 {
> > >   compatible =3D "elan,blah";
> > >   ret =3D <0x10>;
> > >   status =3D "failed-needs-probe";
> > >   ...
> > > }
> > > trackpad-2@10 {
> > >   compatible =3D "goodix,gt7375p";
> > >   ret =3D <0x10>;
> > >   status =3D "failed-needs-probe";
> > >   ...
> > > }
> > >
> > > Then I guess the class would be "trackpad"?
> >
> > That issue is somewhat orthogonal because it is not following the spec.
>
> I'm not sure why you say it's orthogonal. The whole reason why we get
> into the situation above is that we could have two devices, only one
> of which is present (hence the status of "failed-needs-probe"), that
> are the same type and have the same "reg" address.
>
> Essentially the whole "failed-needs-probe" is extending the spec,
> right? While extending the spec, we also need to talk about what to do
> if some of the devices that we need to probe have the same class and
> the same "reg".

If it's at the same address, then you would need some device specific
probing code, like reading a register back and checking if matches
some known value. This could be done by passing in some kind of table,
but it is by no means as generic as checking if an address responds.

This is what we have on MT8186 Tentacruel. We do have the ability to
differentiate using the SKU ID for the same address case, but I'm happy
to try other methods if it helps everyone else.

ChenYu

> > I'm not sure mixing the 2 styles of node names is a good idea. While
> > not used too much, matching by node name does ignore the unit-address,
> > but I'm not sure we could ignore a '-N'.
> >
> > I think our options are either add something to the unit-address or
> > use i2c-mux binding. Adding to the unit-address is not unprecedented.
> > I did that for some of the register bit level bindings where you have
> > a node for different bits at the same address. The downside is
> > unit-address is bus specific, so we'd have to add that for multiple
> > buses. For the i2c-mux, it's perhaps a bit complex and I'm not sure
> > what if anything you'd have to do to manage the mux that's not really
> > there.
>
> Somehow it feels weird to use an i2c-mux because there's no real mux
> present, right? ...so this would be a virtual (bogus) device that
> doesn't really exist in hardware.
>
> ...though I guess if the "mux" type binding is OK then maybe we just
> use that as the HW prober, at least for i2c devices...
>
> -Doug
