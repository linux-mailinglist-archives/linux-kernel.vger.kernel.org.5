Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5707F0768
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 17:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjKSQS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 11:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSQS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 11:18:28 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C670011D;
        Sun, 19 Nov 2023 08:18:24 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1f03db0a410so2138705fac.1;
        Sun, 19 Nov 2023 08:18:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700410704; x=1701015504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGb1AwQyobcZMxIGXn3W57cOw12ftpO8AsnO8KGAKPg=;
        b=JiH4+z3MTfCQieM0/2wXgmWm3boDHfUhrcNTdg7EzUdASyPUAMAMpNsImYZ4nhY3Yu
         OXlT/RXqJTyZHDiNJikyisxTBt+skd3JsquqCxUD4WweGppm5OvDRa6CwsLv8erWSjv2
         /qBzmpxw794Xe+mtnKKYJuxGzr38XgFHzLPUYBFseyuuYKoUvEgREsEpRQRtF21CF8D+
         3GmmMtfF7Sp7t8VJpcgjJuLlFXtzA8GC6xzD54DDT8sEYbS1DWf1N4khlP/eBs/tdayQ
         MHEnQHyzB0BIovLKr2AV9UfrqrJRC+l/V6Aitvhf8qGfqkZYWI32z2/sP72npGj1L8c9
         /asw==
X-Gm-Message-State: AOJu0YxQ9kMWUsF0+eIyRHRAUtB4oage+Y8S/jllN3P/eOHa5zlrZNyL
        R8azr4gkP/l1P4HY5Igh7A==
X-Google-Smtp-Source: AGHT+IFghP1EK9O8jy+fqpG+hVnAkzGSwK9PHhcG345gLXC/3kk+JW41Fx0547RSwUbL1ITfpSLRJQ==
X-Received: by 2002:a05:6870:bf0b:b0:1f0:b31:9b7 with SMTP id qh11-20020a056870bf0b00b001f00b3109b7mr6100989oab.43.1700410703980;
        Sun, 19 Nov 2023 08:18:23 -0800 (PST)
Received: from herring.priv ([2607:fb90:45e3:889f:15b4:1348:6d64:224b])
        by smtp.gmail.com with ESMTPSA id y7-20020a9d6347000000b006d64e44566esm917003otk.72.2023.11.19.08.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 08:18:22 -0800 (PST)
Received: (nullmailer pid 283064 invoked by uid 1000);
        Sun, 19 Nov 2023 16:18:19 -0000
Date:   Sun, 19 Nov 2023 10:18:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH 01/14] dt-bindings: spi: axi-spi-engine: convert to yaml
Message-ID: <170041069911.283011.11782522637402410962.robh@kernel.org>
References: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com>
 <20231117-axi-spi-engine-series-1-v1-1-cc59db999b87@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117-axi-spi-engine-series-1-v1-1-cc59db999b87@baylibre.com>
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


On Fri, 17 Nov 2023 14:12:52 -0600, David Lechner wrote:
> This converts the axi-spi-engine binding to yaml.
> 
> There are a few minor fixes in the conversion:
> * Added maintainers.
> * Added descriptions for the clocks.
> * Fixed the double "@" in the example.
> * Added a comma between the clocks in the example.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> Note: This work is being done by BayLibre on behalf of Analog Devices Inc.
> This is why the maintainers are @analog.com rather than @baylibre.com.
> 
>  .../devicetree/bindings/spi/adi,axi-spi-engine.txt | 31 ----------
>  .../bindings/spi/adi,axi-spi-engine.yaml           | 66 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 31 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

