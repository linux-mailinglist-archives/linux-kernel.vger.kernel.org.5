Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1667B782B28
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbjHUOG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjHUOG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F4BCE;
        Mon, 21 Aug 2023 07:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9220563520;
        Mon, 21 Aug 2023 14:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BCCC433C7;
        Mon, 21 Aug 2023 14:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692626785;
        bh=jskCnmfcQS5EFi06b4333cYtIRY89QRwP0GiuGw2lz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OPZBm3I8NJHoZf7lNV4qSpa5xDGS9Hj6d9J+HQ41DwnpKpgECp2/T0IvOCJNncVya
         KUOCkzttOoxWUVf7H+69kgVBsKZOKqz22xOIyUo7v+iP0131btrysBz0SMywPcyYhE
         r1LIquZBVqSczHC4FriOFXStKLlwWUx/900G6VzQA/QFZ5AJ+cAqk8rJs5nNpuXjH/
         tj3V7Cvm/SvDWo97FwWn3Xcjh5X78b0j+JKRlXkGx1lUIhLdZYMK68JF7e8T4ZvBiR
         5QCv5J7Z3bgb6+r7F0T8wA32Q/jw4GdjpCsRAZe18V0ZmeVy9c/BFOAhNVhnSzL53g
         +nsYCO0dsNUdA==
Received: (nullmailer pid 1479558 invoked by uid 1000);
        Mon, 21 Aug 2023 14:06:22 -0000
Date:   Mon, 21 Aug 2023 09:06:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: fsl_easrc: Add support for
 imx8mp-easrc
Message-ID: <20230821140622.GA1473812-robh@kernel.org>
References: <20230820175655.206723-1-aford173@gmail.com>
 <f5b16676-04b9-7864-ffa7-1c48f3c2ca9c@linaro.org>
 <6089b46d-a580-af52-0cac-84b46fe11e6c@linaro.org>
 <CAHCN7xJyOjKSXbm17roAJDbk-gDKQHprE9t1d4VH2uYSMZcEDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xJyOjKSXbm17roAJDbk-gDKQHprE9t1d4VH2uYSMZcEDg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 04:05:16PM -0500, Adam Ford wrote:
> On Sun, Aug 20, 2023 at 3:33 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 20/08/2023 22:32, Krzysztof Kozlowski wrote:
> > > On 20/08/2023 19:56, Adam Ford wrote:
> > >> The i.MX8MP appears to have the same easrc support as the Nano, so
> > >> add imx8mp as an option with a fallback to imx8mn.
> > >>
> > >> Signed-off-by: Adam Ford <aford173@gmail.com>
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> > >> index bdde68a1059c..2d53b3b10f2c 100644
> > >> --- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> > >> +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> > >> @@ -14,7 +14,11 @@ properties:
> > >>      pattern: "^easrc@.*"
> > >>
> > >>    compatible:
> > >> -    const: fsl,imx8mn-easrc
> > >> +    oneOf:
> > >> +      - items:
> > >> +          - enum:
> > >> +              - fsl,imx8mp-easrc
> > >> +          - const: fsl,imx8mn-easrc
> > >
> > > You need here also const for fsl,imx8mn-easrc, otherwise you do not
> > > allow it alone. Test it for fsl,imx8mn-easrc DTS - you will notice warnings.
> >
> > Actually, I see now Rob's report... you did not have to test DTS even.
> > It was enough to test your change and this test was missing :(. Please
> > test your changes before sending.
> 
> For what it's worth, I did run 'make dt_binding_check', but I didn't
> run it with the extra flags from Rob's e-mail.  The tool didn't return
> any errors.

The error is not related to the '-m' (undocumented compatible) warning. 
It is as Krzysztof said.

Rob
