Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76019788732
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244777AbjHYM0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244881AbjHYM0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:26:31 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92DC26B9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:26:00 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5922380064bso9937647b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692966318; x=1693571118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=imTtF6oMDfUUdZZOXaDJRn5vC8nuYTa4GJ6U0uaioBA=;
        b=LjrX5q74j68I1VUl5oO9TUBIMmOBTPj1Vwy6sA95yTKrKny16GyqMuCQdgRCJS2sSf
         UyO1ObVQ3ldNV4uvynAiIi0Xw6LVJPGWO0XCW7F2EndaB9TnUNtxXTpceKVazPHulz0T
         lcmoPSbi+9SMB9UkWv7CQC4MHQm0sjDdLAHz69csq8RrwX5fDFGCMmzGRsm5j5mkno5W
         8EeFqLMHe3jsA1B7VuoUPgPOLFGtGeUv72Oa5cvHCDU/ONZ7bD3/4sK5SDY/SHs45AdE
         wbsQey/XRGdkEQyTeblklJJOxHVSpXRSVfKLd7Q0/MEL+96lUlvSNdKxStk5EzKxnlLP
         UT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966318; x=1693571118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imTtF6oMDfUUdZZOXaDJRn5vC8nuYTa4GJ6U0uaioBA=;
        b=QtignLLsRW64/DMCwGcFVDdeXKU8Q1jeL+kbEPa8I7gcz9vGhG9PC+oKnK/7mGNfjL
         rxIz6fHL4WI+NWxhzNNVF/MW7wb2ur82NEmSo2GlNbuUBMgYdEpEuJSwU+TTtv1Xv1Ld
         zk4+NAijhxRu+bUmKqg8+L7bxxRL/3xvdmLRcqSrJiPRagYonoFABtqZ6WkoDM/6J7iD
         h8Mxa7mury/euplPlxeTLPoIy8HL1WSHRFmdi4pLSORXfFRcqCqCvXhLbXm8llYVUVg2
         qtfX+rkSTZM5ZMW3CHwJAxgXVheKX4bpkP5RJm9wvVeDj0P3vIlxaAwbX9Sx7Nv+egvE
         UaNw==
X-Gm-Message-State: AOJu0YwOqAelck/JjfCvgqRBH+f1PffhfKBx36NzPYCYtMxBKAK+8x94
        pewgpYOc2aSxAhR7JzDTvbcI0NEBnSEsjUV71XJtuQ==
X-Google-Smtp-Source: AGHT+IGzX+k1WodF6SQPMN6CDVYnV4vxVt6RIf05NBatVhakz7fxdBWuUoY22uoRqj2+6v0uLXCfzghx5tVitq3nYq0=
X-Received: by 2002:a81:df0d:0:b0:586:9ce4:14e8 with SMTP id
 c13-20020a81df0d000000b005869ce414e8mr15051293ywn.52.1692966318735; Fri, 25
 Aug 2023 05:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com> <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Aug 2023 14:24:43 +0200
Message-ID: <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 at 18:35, Shenwei Wang <shenwei.wang@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Thursday, August 24, 2023 4:27 AM
> > To: Shenwei Wang <shenwei.wang@nxp.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> > Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> > imx@lists.linux.dev; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > dl-linux-imx <linux-imx@nxp.com>
> > Subject: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
> >
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report this
> > email' button
> >
> >
> > On Fri, 18 Aug 2023 at 17:35, Shenwei Wang <shenwei.wang@nxp.com> wrote:
> > >
> > > Documenting the regulator power domain properties and usage examples.
> >
> > As Rob and Krzysztof already pointed out, I agree that this binding looks a bit
> > questionable.
> >
> > Rather than adding a new DT binding, why can't we just use the existing way of
> > describing a platform specific power-domain provider?
>
> Can you please provide more details on how you thought we should implement this
> feature using the existing way? Very appreciate if you could provide a simple example.
>
> > This still looks platform specific to me.
>
> What does platform specific exactly mean here?  I want to make sure I understand
> what you were referring to.

There are plenty of examples of how a platform specific genpd provider
looks in DT. You may have a look a imx platforms for example.

git grep "#power-domain-cells" arch/arm/boot/dts/nxp/imx

The genpd provider then needs to be a consumer of the resources it
needs. In this case a couple of regulators it seems like.

[...]

Kind regards
Uffe
