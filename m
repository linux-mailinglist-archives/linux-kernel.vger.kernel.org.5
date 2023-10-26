Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5DF7D89B1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjJZUan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZUam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:30:42 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629E91AC;
        Thu, 26 Oct 2023 13:30:39 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ce2d4567caso829530a34.2;
        Thu, 26 Oct 2023 13:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352238; x=1698957038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkyeTzF/tPkHv6TpS8dsv+uB8svyflGUtJpGpeK6gjs=;
        b=AIX9qQO58fo6NGgI9fxBQXmFY1DC7Jn35RtByAhebk6c304pYfJLC6qTScweArBR9H
         gwhDLezldOH2G19FqmB2+FonF9M8W5N8mHMeCKOBRwzVbbmvWAxsMpx8Hl/8PbNvwW0i
         KfpqMtLcF56mNKp914PDfQE99c+XzDB8smhsxOxJb4vrkNG+f7Rmeg4f7Mqd91AcEA0v
         /8kDteVOC8YyDNJ2SSZ/G+O+SAh+TPacxe6RhdXeiNt9fvS2yiAf66sz97h42aO27900
         gyhKBy3Zyhxx5ZAfVY20aGNSJL3Fr34o1fYlqVo/0vwf0S13cUkftgMUL3lrpPgCvsTn
         Ty2Q==
X-Gm-Message-State: AOJu0YzMUHSu6OrySVGPRc2XD2YfWiCHTgSMbgPOYullOrMhvzm8ynEp
        iCq1yFaDQD1D5Jory9aH6g==
X-Google-Smtp-Source: AGHT+IH6kobtiBdqkODWoCJa7OcCFMsfzJD5tffITWfZyftDjIsVOFBR16HbOPZ6q+2+26m/pWGJ0Q==
X-Received: by 2002:a05:6808:17a2:b0:3af:6ce1:91fc with SMTP id bg34-20020a05680817a200b003af6ce191fcmr617368oib.21.1698352238569;
        Thu, 26 Oct 2023 13:30:38 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m9-20020a0568080f0900b003b2ee6a9358sm19785oiw.16.2023.10.26.13.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:30:37 -0700 (PDT)
Received: (nullmailer pid 347114 invoked by uid 1000);
        Thu, 26 Oct 2023 20:30:37 -0000
Date:   Thu, 26 Oct 2023 15:30:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Nik Bune <n2h9z4@gmail.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, skhan@linuxfoundation.org,
        m-karicheri2@ti.com, ivan.khoronzhuk@ti.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: watchdog: davinci-wdt: convert txt to
 yaml
Message-ID: <20231026203037.GA327324-robh@kernel.org>
References: <20231024195839.49607-1-n2h9z4@gmail.com>
 <41408db6-89f9-4e0b-b407-96c6c922e8a4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41408db6-89f9-4e0b-b407-96c6c922e8a4@ti.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 03:55:23PM -0500, Andrew Davis wrote:
> On 10/24/23 2:58 PM, Nik Bune wrote:
> > Convert txt file to yaml.
> > Add maintainers list, based on the git history.
> > Mark clock as required property, by reviewer's suggestion.
> > 
> > Signed-off-by: Nik Bune <n2h9z4@gmail.com>
> > ---
> > 
> > Changes in v2 (according to review comments):
> > - Added clocks to the list of required properties.
> > - Updated clocks property to have only maxItems without $ref and description.
> > - Removed timeout-sec explicit definition, as it is defined in watchdog.yaml.
> > - Updated maintainers list from the git history.
> > 
> > v1 patch: https://lore.kernel.org/all/20231021171323.113208-1-n2h9z4@gmail.com/
> > 
> >   .../bindings/watchdog/davinci-wdt.txt         | 24 ----------
> >   .../bindings/watchdog/ti,davinci-wdt.yaml     | 47 +++++++++++++++++++
> >   2 files changed, 47 insertions(+), 24 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
> >   create mode 100644 Documentation/devicetree/bindings/watchdog/ti,davinci-wdt.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
> > deleted file mode 100644
> > index aa10b8ec36e2..000000000000
> > --- a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
> > +++ /dev/null
> > @@ -1,24 +0,0 @@
> > -Texas Instruments DaVinci/Keystone Watchdog Timer (WDT) Controller
> > -
> > -Required properties:
> > -- compatible : Should be "ti,davinci-wdt", "ti,keystone-wdt"
> > -- reg : Should contain WDT registers location and length
> > -
> > -Optional properties:
> > -- timeout-sec : Contains the watchdog timeout in seconds
> > -- clocks : the clock feeding the watchdog timer.
> > -	   Needed if platform uses clocks.
> > -	   See clock-bindings.txt
> > -
> > -Documentation:
> > -Davinci DM646x - https://www.ti.com/lit/ug/spruer5b/spruer5b.pdf
> > -Keystone - https://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
> > -
> > -Examples:
> > -
> > -wdt: wdt@2320000 {
> > -	compatible = "ti,davinci-wdt";
> > -	reg = <0x02320000 0x80>;
> > -	timeout-sec = <30>;
> > -	clocks = <&clkwdtimer0>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/watchdog/ti,davinci-wdt.yaml b/Documentation/devicetree/bindings/watchdog/ti,davinci-wdt.yaml
> > new file mode 100644
> > index 000000000000..4747be98b7d9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/ti,davinci-wdt.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/watchdog/ti,davinci-wdt.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Texas Instruments DaVinci/Keystone Watchdog Timer (WDT) Controller
> > +
> > +description: |
> > +  Documentation:
> > +  Davinci DM646x - https://www.ti.com/lit/ug/spruer5b/spruer5b.pdf
> > +  Keystone - https://www.ti.com/lit/ug/sprugv5a/sprugv5a
> > +
> > +maintainers:
> > +  - Murali Karicheri <m-karicheri2@ti.com>
> > +  - Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> 
> Neither of these folks will be available for this, you can use me if
> you want an email that won't bounce for now.
> 
> > +
> > +allOf:
> > +  - $ref: watchdog.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,davinci-wdt
> > +      - ti,keystone-wdt
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> 
> We also have some instances with an optional power-domains prop.
> 
>   power-domains:
>     description: A phandle and PM domain specifier as defined by bindings of
>       the power controller specified by phandle. See
>       Documentation/devicetree/bindings/power/power-domain.yaml for details.

But not what the schema should look like here. Same as others. How many 
and what order if more than 1.

Rob
