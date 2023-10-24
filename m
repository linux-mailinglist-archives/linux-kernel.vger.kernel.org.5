Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2347D5B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbjJXTf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjJXTfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:35:24 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD5BC4;
        Tue, 24 Oct 2023 12:35:22 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-57f0f81b2aeso2749345eaf.3;
        Tue, 24 Oct 2023 12:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176122; x=1698780922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9ar8bhIueC5EydnDePnLjCuAwDCm56UQXxamDo5GgY=;
        b=TCFcU03PPtIQhHvGwvJsJIOqUayxohPvcbw0QhAH+keQqIdG52rs7E/k4Ol6hUvlYA
         H1ZaCqu6PjgH495/PyXSWs7HKMgtNSwDThz9oRjlsAOn8TznnJw1voKqBeUi495cr+kN
         +lS3jhOy0YHLTK2Nt2CfaxGirWCiGpV6G49eVppAF4uvWdvg0bB48m7MAkork1LJZN5q
         fOEW94sWA1VEl+qWXZGysEWx9xob2Gdzr1EOx57q9FuVY7FiZkoh/zPjyrm0Wls5r85z
         rwAR5M5BsR2qd/XijJiH8197sjBxJ9bLc5KZUV2RPAhzo4IjkkhzQpZF2Xst0x3ibHBa
         OENA==
X-Gm-Message-State: AOJu0Yxt0jgM8gr2+lnHxVDqz4kvJn/lZHGYfd/V0bdTI/6ZQDhUCDA1
        sdylBiPMZFuxGoQjfwgGVg==
X-Google-Smtp-Source: AGHT+IErGorSYkZZFwTnmlJa0hWA/l7r/75pzydg4QiS1LHnTWY+BN+UvK5QJKPJ7zg/ixNZFuWCgA==
X-Received: by 2002:a4a:b789:0:b0:581:df34:15c with SMTP id a9-20020a4ab789000000b00581df34015cmr12117696oop.5.1698176122031;
        Tue, 24 Oct 2023 12:35:22 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r24-20020a05683001d800b006ce1f9c62a1sm1927297ota.39.2023.10.24.12.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:35:21 -0700 (PDT)
Received: (nullmailer pid 433054 invoked by uid 1000);
        Tue, 24 Oct 2023 19:35:20 -0000
Date:   Tue, 24 Oct 2023 14:35:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     linux-clk@vger.kernel.org, Sergej Sawazki <sergej@taudac.com>,
        Jacob Siverskog <jacob@teenage.engineering>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: clock: si5351: convert to yaml
Message-ID: <169817611957.433015.13808354686090868209.robh@kernel.org>
References: <20231020-alvin-clk-si5351-no-pll-reset-v5-0-f0c1ba537f88@bang-olufsen.dk>
 <20231020-alvin-clk-si5351-no-pll-reset-v5-1-f0c1ba537f88@bang-olufsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020-alvin-clk-si5351-no-pll-reset-v5-1-f0c1ba537f88@bang-olufsen.dk>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Oct 2023 13:34:14 +0200, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The following additional properties are described:
> 
>   - clock-names
>   - clock-frequency of the clkout child nodes
> 
> In order to suppress warnings from the DT schema validator, the clkout
> child nodes are prescribed names clkout@[0-7] rather than clkout[0-7].
> 
> The example is refined as follows:
> 
>   - correct the usage of property pll-master -> silabs,pll-master
>   - give an example of how the silabs,pll-reset property can be used
> 
> I made myself maintainer of the file as I cannot presume that anybody
> else wants the responsibility.
> 
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Rabeeh Khoury <rabeeh@solid-run.com>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
>  .../devicetree/bindings/clock/silabs,si5351.txt    | 126 -----------
>  .../devicetree/bindings/clock/silabs,si5351.yaml   | 241 +++++++++++++++++++++
>  2 files changed, 241 insertions(+), 126 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

