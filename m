Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635517F490D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjKVOfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjKVOfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:35:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BA2195
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:35:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B75C433C8;
        Wed, 22 Nov 2023 14:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700663713;
        bh=RtXHVojQdii9cypheSJBX00LBuWCbe8gFyZ642oQe6A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dBFU2Dem3EzGCXV3Q3tedWG2zrS20A/bGvbdoBmedPEANbbwkpNzyl/M4HioweVGb
         BZ3fnadm47uAvJY3apn3f989uSWYz5ONRfJ1zS+0gls0LHlGnFiJSqXSkPoPBYtg+F
         lWoW4L18wsGteiHC0Wr/scISvN7KVWVMMxPT/v1vjBH7G3Knl2QSRkRYbyiN3zVi+p
         fApO8YOj9xhU5chPpIASR5ijXN/I55LBw+v6S0lJ3o2wcnXinboeFMs+SkErTCpNri
         NglxMF0ZEATv4ho4vVWQTGGOToZKxW2gEZn+y/bvi6tY+VPWnPcKdl0sAZVpxKjRyP
         Lyz/wtrvTtYYQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-507a62d4788so9689216e87.0;
        Wed, 22 Nov 2023 06:35:13 -0800 (PST)
X-Gm-Message-State: AOJu0YyFSrBT4Jg2PKqPlGk+YANH9sMuiP1rL2066+rtI8Djy+akMQpl
        AGKkQSN5J/wpAM0/WQGAnEnttdKMIKteMmHWCA==
X-Google-Smtp-Source: AGHT+IEQBg+DK/D3DTxQm+IxmEnOEyd8FYRneZs7dFyJFZUQ30Vu7QNpAPavUGMN4n7otiuBSo5YrTBJtBD/XnkZObs=
X-Received: by 2002:a05:6512:3c8f:b0:509:2b81:fc40 with SMTP id
 h15-20020a0565123c8f00b005092b81fc40mr2616195lfv.9.1700663711762; Wed, 22 Nov
 2023 06:35:11 -0800 (PST)
MIME-Version: 1.0
References: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
 <6b288a2e-d147-4bd3-b1d4-daf56295d939@gmail.com> <01f9ce3b-e6e5-4b05-bf7f-0b3a5f74910a@linaro.org>
 <CAGb2v64Vf5dDwq=KTrxwc=+w+0KUD2KVPMjmHg68Y_yukES5dQ@mail.gmail.com>
 <7232a48b-b9ad-44b5-ae6a-d12dad70b3c4@linaro.org> <58a9caacc1226c7c3a2bdfe73ef1791f@manjaro.org>
 <cc4c789c-b595-41eb-b543-9e03549c6e61@amd.com> <CAMuHMdWm-gRPHeHyuX3_eR+9chJEw3iiZwCNBnoiRPHzoMAs6w@mail.gmail.com>
 <808270d3-2274-4fb7-a397-38538503b67c@amd.com>
In-Reply-To: <808270d3-2274-4fb7-a397-38538503b67c@amd.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 22 Nov 2023 07:34:59 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKkOjBHrJ0WELq3JnJDqgtA=mdF+EtAxHSCGqZMQ9tuSQ@mail.gmail.com>
Message-ID: <CAL_JsqKkOjBHrJ0WELq3JnJDqgtA=mdF+EtAxHSCGqZMQ9tuSQ@mail.gmail.com>
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
To:     Michal Simek <michal.simek@amd.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dragan Simic <dsimic@manjaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        wens@kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Andrew Davis <afd@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 1:57=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
> Hi Geert,
>
> On 11/22/23 09:53, Geert Uytterhoeven wrote:
> > Hi Michal,
> >
> > On Wed, Nov 22, 2023 at 9:50=E2=80=AFAM Michal Simek <michal.simek@amd.=
com> wrote:
> >> On 11/22/23 09:29, Dragan Simic wrote:
> >>> On 2023-11-22 09:21, Krzysztof Kozlowski wrote:
> >>>> On 22/11/2023 09:09, Chen-Yu Tsai wrote:
> >>>>> On Wed, Nov 22, 2023 at 4:05=E2=80=AFPM Krzysztof Kozlowski
> >>>>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>>>
> >>>>>> On 21/11/2023 14:50, Rafa=C5=82 Mi=C5=82ecki wrote:
> >>>>>>>> +Order of Properties in Device Node
> >>>>>>>> +----------------------------------
> >>>>>>>> +
> >>>>>>>> +Following order of properties in device nodes is preferred:
> >>>>>>>> +
> >>>>>>>> +1. compatible
> >>>>>>>> +2. reg
> >>>>>>>> +3. ranges
> >>>>>>>> +4. Standard/common properties (defined by common bindings, e.g.=
 without
> >>>>>>>> +   vendor-prefixes)
> >>>>>>>> +5. Vendor-specific properties
> >>>>>>>> +6. status (if applicable)
> >>>>>>>> +7. Child nodes, where each node is preceded with a blank line
> >>>>>>>> +
> >>>>>>>> +The "status" property is by default "okay", thus it can be omit=
ted.
> >>>>>>>
> >>>>>>> I think it would really help to include position of #address-cell=
s and
> >>>>>>> #size-cells here. In some files I saw them above "compatible" tha=
t seems
> >>>>>>> unintuitive. Some prefer putting them at end which I think makes =
sense
> >>>>>>> as they affect children nodes.
> >>>>>>>
> >>>>>>> Whatever you choose it'd be just nice to have things consistent.
> >>>>>>
> >>>>>> This is a standard/common property, thus it goes to (4) above.
> >>>>>
> >>>>> It's probably a mix, but AFAIK a lot of the device trees in tree ha=
ve
> >>>>> #*-cells after "status". In some cases they are added in the board
> >>>>> .dts files, not the chip/module .dtsi files.
> >>>>
> >>>> Existing DTS is not a good example :)
> >>>>
> >>>>>
> >>>>> +1 that it makes sense at the end as they affect child nodes.
> >>>>
> >>>> I still insist that status must be the last, because:
> >>>> 1. Many SoC nodes have address/size cells but do not have any childr=
en
> >>>> (I2C, SPI), so we put useless information at the end.
> >>>> 2. Status should be the final information to say whether the node is
> >>>> ready or is not. I read the node, check properties and then look at =
the end:
> >>>> a. Lack of status means it is ready.
> >>>> b. status=3Ddisabled means device still needs board resources/custom=
ization
> >>>
> >>> I agree with the "status" belonging to the very end, because it's bot=
h logical
> >>> and much more readable.  Also, "status" is expected to be modified in=
 the
> >>> dependent DT files, which makes it kind of volatile and even more des=
erving to
> >>> be placed last.
> >>
> >> I am just curious if having status property at the end won't affect
> >> execution/boot up time. Not sure how it is done in Linux but in U-Boot=
 at least
> >> (we want to have DTs in sync between Linux and U-Boot) of_find_propert=
y is
> >> pretty much big loop over all properties. And status property defined =
at the end
> >> means going over all of them to find it out to if device is present.
> >> Not sure if Linux works in the same way but at least of_get_property i=
s done in
> >> the same way.
> >
> > As the default is "okay", you have to loop over all properties anyway.
>
> No doubt if you don't define status property that you need to loop over a=
ll of
> them. We normally describe the whole SOC with pretty much all IPs status =
=3D
> disabled and then in board file we are changing it to okay based on what =
it is
> actually wired out.
> It means on our systems all nodes have status properties. If you have it =
at
> first you don't need to go over all.

Order in the source and order in the OS are independent. If checking
status needs to be optimized, then we could just put it first in the
property list or make the state a field in struct device_node. But
provide some data that it matters first.

I've had this idea to randomize the order nodes are processed so
there's no reliance on the DT order. Maybe I need the same on
properties...

Rob
