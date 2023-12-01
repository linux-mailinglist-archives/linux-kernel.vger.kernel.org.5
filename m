Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE2C8013B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379542AbjLATvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379522AbjLATvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:51:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8421FD67
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:51:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E313C433C7;
        Fri,  1 Dec 2023 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701460282;
        bh=EJH7pcH1qCI/9Ve49j/evlBf7hZBafJ34Kx2dvf1CwE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N/D5xbPMScGWqU7OkCWVs9XjFjv25Aed2kcWHTEMBMKNE2B1NmJyoyZvm8dHnQsGU
         FoksU6IMv0AC/uDwyWvh5SVGskGdoPaVXg17zr3jLsUy848EnZiNVeVM8LTvqUbApR
         Tpd3KHLZfVU6wr+FxneehIT6owf4h9nmYyYkqrSxSU+6oBeWSWB4HJ1S1WkyTRbrJz
         YO1MoQMMRoyxFZ0eFzGA/dzROW3DdmfJCImwvmsLHa4Gk+t2lR1LIkJb9rSmRg46tF
         9j2bYmZ3iQr5REjUNnJsTfuk0r7mXfj+F4dKrdZLM5C5zp9mr+En7tZUlKm+AkXeQY
         sR6grXNTQy+Aw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50bbb79f97cso2594668e87.0;
        Fri, 01 Dec 2023 11:51:22 -0800 (PST)
X-Gm-Message-State: AOJu0Yysvo/v6jkzhYgX4czzUXWiN5uPmMOAHq2R+n5eyQvqnNMalEPj
        8jy8fBnZIAUQ1FbEGCgB61ytME5/p7HdBngsJg==
X-Google-Smtp-Source: AGHT+IEMD8rQO1KH9KmGglrp52KHDXnUwLoWuFX1qmdNaWfItn9cnh29V/dJWQgSHPWDEjtq4wpND/HoficI4Tv4oLk=
X-Received: by 2002:ac2:57c9:0:b0:50b:e03b:95f2 with SMTP id
 k9-20020ac257c9000000b0050be03b95f2mr331377lfo.1.1701460280311; Fri, 01 Dec
 2023 11:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20231130172834.12653-1-johan+linaro@kernel.org>
 <20231201144320.GA977713-robh@kernel.org> <ZWoQXHnQbJuoxmw0@hovoldconsulting.com>
In-Reply-To: <ZWoQXHnQbJuoxmw0@hovoldconsulting.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 1 Dec 2023 13:51:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKh=MG_8TtKap5LvUY-u=KTdGrpb-Sf7MAd1JNqQGue8Q@mail.gmail.com>
Message-ID: <CAL_JsqKh=MG_8TtKap5LvUY-u=KTdGrpb-Sf7MAd1JNqQGue8Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-mpp: clean up example
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Dec 1, 2023 at 10:56=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Fri, Dec 01, 2023 at 08:43:20AM -0600, Rob Herring wrote:
> > On Thu, Nov 30, 2023 at 06:28:34PM +0100, Johan Hovold wrote:
> > > The Multi-Purpose Pin controller block is part of an SPMI PMIC (which=
 in
> > > turns sits on an SPMI bus) and uses a single value for the register
> > > property that corresponds to its base address.
> > >
> > > Clean up the example by adding a parent PMIC node with proper
> > > '#address-cells' and '#size-cells' properties, dropping the incorrect
> > > second register value, adding some newline separators and increasing =
the
> > > indentation to four spaces.
> >
> > This is fine, but I prefer these MFDs have 1 complete example rather
> > than piecemeal examples for each child device.
>
> Yeah, this is not ideal. The closest thing we've got are the examples
> in:
>
>         Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>
> Are you suggesting eventually dropping the examples from the child node
> bindings and adding (several) complete examples in the parent one?

Yes, but if the child nodes are truly reused across multiple PMICs
then, it is probably a worthwhile exception. There's not a great deal
of reuse on most MFDs.

> I guess there would need to be more than one if you want to cover all
> the various child nodes with real examples.

We don't want examples to be exhaustive permutations of every
possibility either.

Rob
