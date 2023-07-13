Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9307525D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjGMO55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjGMO5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:57:54 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD962D6A;
        Thu, 13 Jul 2023 07:57:30 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-786bb09e595so45010439f.1;
        Thu, 13 Jul 2023 07:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260246; x=1691852246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXTEiJgqTQSHTgMd2XgbWoza5WarJFfM5iZCV23PHFo=;
        b=TqS/8nXmUg7DBqIp4YAPym5tZ23vnhJg7PSsH5g9SAPvE2D94+AGs9yLaIiPIMiyrR
         OnwjaHbhPq0slfA2wC6HN09/GirII3MipD3GmtqpKaP2+fZPn0AvG/KO6E+jPPJ0D4Mv
         wcLMxvJGiW8E8ZAXGOQGACmxkQQs83P7CMq3XpY+kw9ObbEVS1ACRwltvEMc5+NI9yHA
         aydZLDpWwxXqhZ4l+K9OtPm/ZY9o1Zs6twhlWPfd7hjnj8hWMMFwEGlp/bLp4SxBNHCW
         KpogEyNepiMzfyFhGFrJD4SUwOoqXtoA8QJQRcmeGdwJm8HDplEth6GmfvDXqgwiIPws
         x3Jg==
X-Gm-Message-State: ABy/qLZvwimLa7Tiy6lqzJoQUQGsnzUUr8D70l4FiEjfd05HbdC9l5yf
        ly98/cMupTQ5h+baBLnTO1lUb6tFFQ==
X-Google-Smtp-Source: APBJJlEbJtUGyiRAj/0oiEUGHUE6MDV5DC9yCYrFNINS6T3YHK29EQFfzahnTjX3plIUV34wtbPcAA==
X-Received: by 2002:a92:c905:0:b0:346:3fc5:93e0 with SMTP id t5-20020a92c905000000b003463fc593e0mr1501585ilp.2.1689260246652;
        Thu, 13 Jul 2023 07:57:26 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y9-20020a92d809000000b003460b8505easm2113677ilm.19.2023.07.13.07.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:57:25 -0700 (PDT)
Received: (nullmailer pid 4005390 invoked by uid 1000);
        Thu, 13 Jul 2023 14:57:24 -0000
Date:   Thu, 13 Jul 2023 08:57:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: spi: constrain minItems of clocks
 and clock-names
Message-ID: <20230713145724.GA3975811-robh@kernel.org>
References: <20230713090015.127541-1-william.qiu@starfivetech.com>
 <20230713090015.127541-3-william.qiu@starfivetech.com>
 <c5ad1e1c-58f4-4833-b9c7-8876c1a0dc27@sirena.org.uk>
 <e3fd0d3f-3fe4-2e23-2548-ecbd487e9c9f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3fd0d3f-3fe4-2e23-2548-ecbd487e9c9f@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 02:39:19PM +0200, Krzysztof Kozlowski wrote:
> On 13/07/2023 14:28, Mark Brown wrote:
> > On Thu, Jul 13, 2023 at 05:00:14PM +0800, William Qiu wrote:
> > 
> >> The SPI controller only need apb_pclk clock to work properly on JH7110 SoC,
> >> so there add minItems whose value is equal to 1. Other platforms do not
> >> have this constraint.
> > 
> > Presumably this means that this is some variant of the usual pl022 IP,
> 
> Hm, in such case this could mean we need dedicated compatible.

Except the vendor in the ID registers should be different if the IP is 
modified.

I suspect that PCLK and SSPCLK are tied to the same clock source. There 
must be an SSPCLK because that is the one used to clock the SPI bus and 
we need to know the frequency of it.

Rob
