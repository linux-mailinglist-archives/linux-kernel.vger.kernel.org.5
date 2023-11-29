Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847E47FD926
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjK2OUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjK2OUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:20:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBB6D1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:20:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD0BC433C8;
        Wed, 29 Nov 2023 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701267645;
        bh=ilqRE+p2fOw9a0JlFxXvmLieJ549kSYDkFaGPRRW8oQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=usQAeTppBB5TlyqxaUvm+41VSl5IEzYDcwModnXtK+ilMiYYiZNMrGCbjgRdZXH/p
         7dbuv2jwzNtp5Du9YUsXip+eBl0GMPECNrAzKSBpNPdrJYpApOeTO4Yk6eYGfiCG5Z
         U5F4XF3VeQXjWf3HSVlVEs4AdNgM6M0FS1acS3in6ezgGKlmMHXPUcU+DJsbfJufr6
         TzeJkANcn3GU2M7GZiXB8s1i73Lx36tezfKVwFBWdIYfixNZTpARyWIZ4XoMoy8ixh
         3I84Uyv8YYD3+0pUHFFXCaKPdBuTF30Tu7TxB8uOBSzdACibLuOQpvE0nzEdwkoAHZ
         HLnyY+98+UN1w==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50bbfad8758so2243772e87.3;
        Wed, 29 Nov 2023 06:20:45 -0800 (PST)
X-Gm-Message-State: AOJu0YxMIn8A116RYvHh6I4XaAKjyUuECqakwDgeOn8TAJ8A8/2dV8sV
        MIDEqIAfYuuLBOmvXHsfROXWxVpAelh5QPMTDw==
X-Google-Smtp-Source: AGHT+IGQ6dT1phTdaBB2cnieLq1FHpCwg9+LMFYxy4gEJXci5LIhzhHGeiWIcYiUZnTGssn08SW/cPnCLwYi8FMKZP4=
X-Received: by 2002:a05:6512:114d:b0:509:4599:12d9 with SMTP id
 m13-20020a056512114d00b00509459912d9mr16626681lfg.6.1701267643713; Wed, 29
 Nov 2023 06:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20231129111041.26782-1-krzysztof.kozlowski@linaro.org>
 <170126087595.1991744.9053853140300681368.robh@kernel.org> <3df72c05-7b79-4804-a220-5e342d6e5dd2@linaro.org>
In-Reply-To: <3df72c05-7b79-4804-a220-5e342d6e5dd2@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 29 Nov 2023 08:20:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKhAX0vQ6LPN9ZfO4R44HZ3qrfb0oN9A9jo9+Jd2ePFLw@mail.gmail.com>
Message-ID: <CAL_JsqKhAX0vQ6LPN9ZfO4R44HZ3qrfb0oN9A9jo9+Jd2ePFLw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: honeywell,mprls0025pa: drop ref from
 pressure properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 6:29=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/11/2023 13:27, Rob Herring wrote:
> >
> > On Wed, 29 Nov 2023 12:10:41 +0100, Krzysztof Kozlowski wrote:
> >> The dtschema treats now properties with '-pascal' suffix as standard o=
ne
> >> and already defines $ref for them, thus the $ref should be dropped fro=
m
> >> the bindings.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> dtschema change was merged:
> >> https://github.com/devicetree-org/dt-schema/commit/2a1708dcf4ff0b25c4e=
c46304d6d6cc655c3e635
> >> but not yet released as new dtschema version.
> >>
> >> This change should be applied once new dtschema version is released or
> >> Rob says otherwise.
> >> ---
> >>  .../devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml | 2 -=
-
> >>  1 file changed, 2 deletions(-)
> >>
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/iio/pressure/honeywell,mprls0025pa.yaml: honeywell,pmin-pascal: missing ty=
pe definition
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/iio/pressure/honeywell,mprls0025pa.yaml: honeywell,pmax-pascal: missing ty=
pe definition
> >
>
> That's expected, depends on the dtschema change.

Well, it wasn't because dtschema version used is git tree. However,
the CI job was using master rather than main branch. master falls
behind when I use the web interface... Now fixed the CI job to use
main.

Rob
