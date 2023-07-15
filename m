Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61E7754A67
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 19:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjGORMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 13:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGORMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 13:12:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13EAB5;
        Sat, 15 Jul 2023 10:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F52260BE9;
        Sat, 15 Jul 2023 17:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E19AC433C8;
        Sat, 15 Jul 2023 17:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689441135;
        bh=MAfYMKdp2yVbaYM8S1FWVm96avNCYt2e3gdVoTFht24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EUzn9nxqY92NW58UFzeEhxgQ3zJFBiNQFfjYwIigmkkr+Nri78fuPy1s7xvva480B
         3+yx1fupTy4dPxqlv91ouDZvaxZHJH3bwSd+hw3LN4mUIXCRA5dRhRh3t5jQQEB2uY
         omCJ5Gmw7oIBx9Nmrp92gevcn1mM84F+0P8eR/MRhu61l9wd/1hiElnKTcus1lwSsL
         tvX/qbdtMT+5X9MokXcaV7JHXxwivjbivO9/Zz5IzDa2yePJiP7DHkXm6HyS2xRPWj
         N/3ur+SCPFRePg/GvEdlDFslcLV29tVrXhqwCp9wqkgjMy4/wkUXAmC0Tf+oPlriim
         Kq/ASHnTZON0w==
Date:   Sat, 15 Jul 2023 18:12:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org, Cosmin Tanislav <demonsingur@gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adi,ad74115: remove ref from -nanoamp
Message-ID: <20230715181206.4f4c7db5@jic23-huawei>
In-Reply-To: <CAL_Jsq+MNsxnNBdDQJEy5qEraQMTyu_nHHEJNAvWM0bQ8p7Kig@mail.gmail.com>
References: <20230712080512.94964-1-krzysztof.kozlowski@linaro.org>
        <168917384908.183505.328888758911691646.robh@kernel.org>
        <CAL_Jsq+MNsxnNBdDQJEy5qEraQMTyu_nHHEJNAvWM0bQ8p7Kig@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 12 Jul 2023 08:59:15 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Wed, Jul 12, 2023 at 8:57=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> >
> >
> > On Wed, 12 Jul 2023 10:05:12 +0200, Krzysztof Kozlowski wrote: =20
> > > dtschema v2023.06 comes with support for properties with -nanoamp
> > > suffix, thus bindings should not have a ref for it:
> > >
> > >   adi,ad74115.yaml: properties:adi,ext1-burnout-current-nanoamp: '$re=
f' should not be valid under {'const': '$ref'}
> > >
> > > Cc: Cosmin Tanislav <demonsingur@gmail.com>
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml | 3 ---
> > >  1 file changed, 3 deletions(-)
> > > =20
> >
> > Acked-by: Rob Herring <robh@kernel.org> =20
>=20
> Jonathan, Please pick this up for 6.5. Or I can if you prefer.
>=20
> Rob

Ok. Applied to the fixes-togreg branch of iio.git given desire to get
it in 6.5

Thanks,

Jonathan
