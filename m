Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194AB7B9EE8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbjJEOOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjJEOMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:12:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19417DBD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 00:46:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2774f6943b1so497865a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1696492002; x=1697096802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gONi3mU2Nao2iYlTM3Z0y9mEcA9yDtJpsS/Q6xea9gg=;
        b=a33qz0n8Gia6g8tiygzVqJO3XOIqyD1H+EoEFkVNzK73V/FkjKv7fhdGXfWYSgZ0Bs
         9I3BiYgT1GalnqhUz4EwcrsWJhmIfhcAxexyiMQNzpfZHo8wDIw+eDCvvMyPE9p8nljF
         SPzZmkjxb9AMuwQ7o8ukNEmU50oexX0RoOneRUF15he9iN3WaR4OtSXLk6sk+1EI/7m3
         D1aGm0VnY9i75uL72/PqBHcRKH0wg2aRBO2qaWa1lA5hvwCt8sTnV3I6nI2Yt8vWDhl8
         K8ZX2oZYLXT9/aNkTiA7S/mrFLJn9Fc99jhIv8wPGC+jRrMgVsej2tJlX2XPou3I+yp6
         4axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696492002; x=1697096802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gONi3mU2Nao2iYlTM3Z0y9mEcA9yDtJpsS/Q6xea9gg=;
        b=l88qozDYX64ReDNRJesR+jTjdzl5MqlES37Sztd+9eYYh1N1TvlMZQyZ/beqzZzRnJ
         3Aa2dXo5D5nn+GJGqR9tbRQK4AWOHdtIx7w62vjbTc7J25MHbsKtaH2Wd5kJQohtb9j4
         nbeb0lwQSFREw7rcM0MrpYhMx/tlk3HXsyRh91ZvDYtiaZelv48E0sqBTGASYeCBQauv
         L30U1NUlcL1h+AIvIEMERX0va3uDIbh9J0092ZRTRyMX+4yVFYbhXVQxYrNaMUrm7d14
         u4Y13n/KSggbFV9EXFtVZir3WLdi+Kcd4rMXaezcPvPSBv9GPaYyv9rh7ZmkPrx/zK0P
         9z7A==
X-Gm-Message-State: AOJu0Yw7kC0MdfbEINtVZmyaH97qg5JSazEXuAEtdVQR1VfGQH3fGKON
        t1S2qfvoUbX05Gz5mvLuQKeqq9dIy4lWcF9FRcKtjA==
X-Google-Smtp-Source: AGHT+IGnCQ/MzCTXbm/9BKeoqCiGoah+7aIF31lg8x7PD0677LUDZURnqxgVEDXEnB9+lJS4GNvl8XuU4H7vxTiphyA=
X-Received: by 2002:a17:90b:374b:b0:26b:4a9e:3c7e with SMTP id
 ne11-20020a17090b374b00b0026b4a9e3c7emr4348319pjb.4.1696492002069; Thu, 05
 Oct 2023 00:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231004120529.1155700-1-naresh.solanki@9elements.com> <20231004151433.GA3145438-robh@kernel.org>
In-Reply-To: <20231004151433.GA3145438-robh@kernel.org>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 5 Oct 2023 13:16:31 +0530
Message-ID: <CABqG17in=LKwsDoPRmN5NMNiZ3wU=bbWiyPdunpwph7hgPSxEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: regulator: regulator-output: Multiple supplies
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, zev@bewilderbeest.net,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On Wed, 4 Oct 2023 at 20:44, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Oct 04, 2023 at 02:05:26PM +0200, Naresh Solanki wrote:
> > Add support for multiple supplies.
>
> Why?
1. Driver is already capable of that using platform data. Hence added
support to read DT property & initialize the same for multiple
supplies instead of being limited to one.
2. This is particularly useful in cases wherein 2 or more regulators
are coupled together, for example in a PCIe connector having 3.3V &
12V.

Regards,
Naresh
>
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >  .../devicetree/bindings/regulator/regulator-output.yaml  | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/regulator-output.yaml b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> > index 078b37a1a71a..6d077f123729 100644
> > --- a/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> > +++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> > @@ -21,13 +21,13 @@ properties:
> >    compatible:
> >      const: regulator-output
> >
> > -  vout-supply:
> > +patternProperties:
> > +  ".*-supply":
> >      description:
> >        Phandle of the regulator supplying the output.
> >
> >  required:
> >    - compatible
> > -  - vout-supply
> >
> >  additionalProperties: false
> >
> > @@ -37,3 +37,8 @@ examples:
> >            compatible = "regulator-output";
> >            vout-supply = <&output_reg>;
> >        };
> > +      output1 {
> > +          compatible = "regulator-output";
> > +          sw0-supply = <&output_reg0>;
> > +          sw1-supply = <&output_reg2>;
> > +      };
> >
> > base-commit: f9a1d31874c383f58bb4f89bfe79b764682cd026
> > --
> > 2.41.0
> >
