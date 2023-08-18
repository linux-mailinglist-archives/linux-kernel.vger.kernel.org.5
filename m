Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8EE780F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378210AbjHRPf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378207AbjHRPfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:35:54 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AE22D59;
        Fri, 18 Aug 2023 08:35:53 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76d7a05552aso65338185a.3;
        Fri, 18 Aug 2023 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692372952; x=1692977752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exNo+UsQcHTn5E4VhXDma0UbCxlKMm5pq8zEtdARRFs=;
        b=FqJon+Cbb9L56LIXhoezOrzlknoAMq9WgmGkXmfyRm+VEQxrHYEy4CjieG06vh8JSu
         zPr+QOIMfADDlKVqDmsluyFFCZV8yNxu5yt8UDLkTgPPMqUsFwiI09CvaGK3UkExJNVs
         2Gfnjcnh14Q9xoy35F9i23+lL4OgT3a2ZN2Kz0mLoCdh4f+m9+L3nHTUICy5IL9Eu5uX
         zMsnXoiwsY8LrE03s7LqQvIYCqdVyZLyJeovZgGrL7UpZ4EkR/27N8xo9nHR9gC0/8rV
         VNvfleohUKDRaQXW+FjH5vkIuL9/+PA80d7RdDLCn8FIRU+LcfW6YGV1G0CdGu++uBxD
         TkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372952; x=1692977752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exNo+UsQcHTn5E4VhXDma0UbCxlKMm5pq8zEtdARRFs=;
        b=efQGagTXILBkXYQMbYyC05vsT751qBJLpczVuUYiOlh0aHX0yLzxS/czla9v69ZUDU
         hQCP5a+fZkHn8rFVg0Q71/CiBzaIiiZK7fxLM2Klp8ixBoJIZkcMfibYL0fSNqKNW00n
         2x/u/mdjBEFM6VPjgS9CfHYdwNI4tAfmV5PONTNVeiJmQCmomsWu5iIAIRmd8bQpdzUK
         3cvYf9evWSsK07HmV/H1BBeFmPIGj3yEqXC842yvKftDp7PSUZcdH7d0SyeIBR0Bqj8K
         3SxthWCC6xYfgZtt2SA/ZRt8ZxWp96PmVF8v1YflTWAB+DMdSkWs3XHL9XlQTr/rCSVl
         WPyg==
X-Gm-Message-State: AOJu0YzkcQPbwpv+IKbHTfU3/cB5HWfGC9wQVB//u1eqW095mnlNKQ4C
        aow3r8/Zqakf/pIgagA8E1sSMav98MwiGg==
X-Google-Smtp-Source: AGHT+IFzXkHclsRgM7QuUp9nfoxlu2eCobpTUxGWWJgz46BjOqq5dRrsFENKGEUATdTLng1t6tN9Hw==
X-Received: by 2002:ad4:452e:0:b0:647:12a5:5f10 with SMTP id l14-20020ad4452e000000b0064712a55f10mr3217069qvu.21.1692372952045;
        Fri, 18 Aug 2023 08:35:52 -0700 (PDT)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id u26-20020a0cb69a000000b0064729a2f44csm750758qvd.142.2023.08.18.08.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:35:51 -0700 (PDT)
Date:   Fri, 18 Aug 2023 11:35:41 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: Re: [PATCH] dt-bindings: usb: Add binding for ti,tps25750
Message-ID: <ZN+PzWuiLRsSVcmU@abdel>
References: <20230817235212.441254-1-alkuor@gmail.com>
 <eba26f0e-40dd-3661-b089-bc34c9426000@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba26f0e-40dd-3661-b089-bc34c9426000@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:31:35AM +0200, Krzysztof Kozlowski wrote:
> Where is any user of it? DTS, driver or 3rd party upstream open-source
> project?
>
Yes, for Geotab. We are working on bringing up a new BSP and we have tps25750
which doesn't have a driver in Linux yet. We developed the driver but I thought
I needed to get the dt-bindings accepted first before sending the patch for
the driver.

Sorry, this is my first time contributing to Linux. Maybe this question
was asked before but for some reason I couldn't find it.

What is usually the process? Should I upload the driver too?

> 
> A nit, subject: drop second/last, redundant "binding for". The
> "dt-bindings" prefix is already stating that these are bindings.
>

> > +      - ti,tps25750
> 
> Blank line
> 
> > +  reg:

> > +  interrupts:
> > +    description: |
> 
> Drop description
>

> > +  interrupt-names:
> > +    items:
> > +      - const: irq
> 
> Drop interrupt-names, it is useless in this form.
> 

> > +  firmware-name:
> > +    description: |
> > +      Should contain the name of the default patch binary
> > +      file located on the firmware search path which is
> > +      used to switch the controller into APP mode
> 
> maxItems: 1
> 

> > +        tps25750: tps25750@21 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
> > +            compatible = "ti,tps25750";
> > +            reg = <0x21>;
> > +
> 
> 
> Best regards,
> Krzysztof
> 

Thanks for the review. I've addressed your comments in v2

Best Regards,
Abdel
