Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65A27F3FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjKVIJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjKVIJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:09:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF2818E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:09:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2F1C433D9;
        Wed, 22 Nov 2023 08:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700640552;
        bh=PHQsh6F5XvgFUnaiWxcwLwUn3OBKs5yGFFQ41WrpYbs=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=nbJ2SK6lwZUEu6ZnwTSH+Oa/pBWa+sX/Htt/x2OReGd8JoH8z85C27DzRYTHJBlVi
         3wDe3x5yRyGX5qAMhcpfKXHDb9VRNeNThxVKhdlyx1h9TbC6wosV8PHWzu2uTL/7Am
         ZWlKfb6oi0Cn+Ic/KuwFQalQJhUOwrmMosWHgVwHC2Cz6C0mqCCOKTxXIRm3FodZqc
         a5DVliVMdZJxlKjgLRaCcUtozoEbeFe5NuT8tHE9n86xS+d7H2vfDsWjbaRg0Z56Vf
         5KU1r/sIqOWweRJ36Zhtl3j2xC4aB6yAvdaF7pTTjplwjMbpiRtNuVc7wneOEmh45p
         iqsEGA8VNAjSA==
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28098ebd5aeso5197621a91.0;
        Wed, 22 Nov 2023 00:09:12 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7odvUu4zERkyhQekrKqkBcCJ348m56meZ7iw4iXyhkBSdkk6f
        8cpOzvOaK4gnHrY+fkTLZ8IxsErmbn8YrXs/sto=
X-Google-Smtp-Source: AGHT+IEr9UvTFqYZYbRvMse6NIITfqbwjuUq1G6lDkVVXaxwMJVX1684jPAX+uFy+o0fSjl0iAD8WjSqBj6oqY9ODoU=
X-Received: by 2002:a17:90b:1d92:b0:27f:ecd9:6d0e with SMTP id
 pf18-20020a17090b1d9200b0027fecd96d0emr1639810pjb.34.1700640552241; Wed, 22
 Nov 2023 00:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20231120084044.23838-1-krzysztof.kozlowski@linaro.org>
 <6b288a2e-d147-4bd3-b1d4-daf56295d939@gmail.com> <01f9ce3b-e6e5-4b05-bf7f-0b3a5f74910a@linaro.org>
In-Reply-To: <01f9ce3b-e6e5-4b05-bf7f-0b3a5f74910a@linaro.org>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Wed, 22 Nov 2023 16:09:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v64Vf5dDwq=KTrxwc=+w+0KUD2KVPMjmHg68Y_yukES5dQ@mail.gmail.com>
Message-ID: <CAGb2v64Vf5dDwq=KTrxwc=+w+0KUD2KVPMjmHg68Y_yukES5dQ@mail.gmail.com>
Subject: Re: [PATCH v2] docs: dt-bindings: add DTS Coding Style document
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
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

On Wed, Nov 22, 2023 at 4:05=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/11/2023 14:50, Rafa=C5=82 Mi=C5=82ecki wrote:
> >> +Order of Nodes
> >> +--------------
> >> +
> >> +1. Nodes within any bus, thus using unit addresses for children, shal=
l be
> >> +   ordered incrementally by unit address.
> >> +   Alternatively for some sub-architectures, nodes of the same type c=
an be
> >> +   grouped together (e.g. all I2C controllers one after another even =
if this
> >> +   breaks unit address ordering).
> >> +
> >> +2. Nodes without unit addresses should be ordered alpha-numerically b=
y the node
> >> +   name.  For a few types of nodes, they can be ordered by the main p=
roperty
> >> +   (e.g. pin configuration states ordered by value of "pins" property=
).
> >> +
> >> +3. When extending nodes in the board DTS via &label, the entries shou=
ld be
> >> +   ordered alpha-numerically.
> >
> > Just an idea. Would that make (more) sense to make &label-like entries
> > match order of nodes in included .dts(i)?
> >
> > Adventages:
> > 1. We keep unit address incremental order that is unlikely to change
> >
> > Disadventages:
> > 1. More difficult to verify
>
> Rob also proposed this and I believe above disadvantage here is crucial.
> If you add new SoC with board DTS you are fine. But if you add only new
> board, the order of entries look random in the diff hunk. Reviewer must
> open SoC DTSI to be able to review the patch with board DTS.
>
> If review is tricky and we do not have tool to perform it automatically,
> I am sure submissions will have disordered board DTS.
>
> >
> >
> >> +Example::
> >> +
> >> +    // SoC DTSI
> >> +
> >> +    / {
> >> +            cpus {
> >> +                    // ...
> >> +            };
> >> +
> >> +            psci {
> >> +                    // ...
> >> +            };
> >> +
> >> +            soc@ {
> >> +                    dma: dma-controller@10000 {
> >> +                            // ...
> >> +                    };
> >> +
> >> +                    clk: clock-controller@80000 {
> >> +                            // ...
> >> +                    };
> >> +            };
> >> +    };
> >> +
> >> +    // Board DTS
> >> +
> >> +    &clk {
> >> +            // ...
> >> +    };
> >> +
> >> +    &dma {
> >> +            // ...
> >> +    };
> >> +
> >> +
> >> +Order of Properties in Device Node
> >> +----------------------------------
> >> +
> >> +Following order of properties in device nodes is preferred:
> >> +
> >> +1. compatible
> >> +2. reg
> >> +3. ranges
> >> +4. Standard/common properties (defined by common bindings, e.g. witho=
ut
> >> +   vendor-prefixes)
> >> +5. Vendor-specific properties
> >> +6. status (if applicable)
> >> +7. Child nodes, where each node is preceded with a blank line
> >> +
> >> +The "status" property is by default "okay", thus it can be omitted.
> >
> > I think it would really help to include position of #address-cells and
> > #size-cells here. In some files I saw them above "compatible" that seem=
s
> > unintuitive. Some prefer putting them at end which I think makes sense
> > as they affect children nodes.
> >
> > Whatever you choose it'd be just nice to have things consistent.
>
> This is a standard/common property, thus it goes to (4) above.

It's probably a mix, but AFAIK a lot of the device trees in tree have
#*-cells after "status". In some cases they are added in the board
.dts files, not the chip/module .dtsi files.

+1 that it makes sense at the end as they affect child nodes.

ChenYu
