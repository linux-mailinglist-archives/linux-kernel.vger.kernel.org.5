Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ADB7D5B96
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbjJXTgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344046AbjJXTgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:36:36 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCAAB3;
        Tue, 24 Oct 2023 12:36:34 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ce322b62aeso3153151a34.3;
        Tue, 24 Oct 2023 12:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176194; x=1698780994;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xw/76vCr0PLDGu+ObHw0El452oG4pXRjVAV5SmwwM50=;
        b=ZWDBnnedHDFNZSKmDYFEx9c6kJyJLMlJIUvCqqQJENtTeM5dXhpWEWRer+zKFmOl0j
         5IlSVahJDQUkzJA7Xq2WjFgCixrv/ZHAxiJOwvx0wuQdo3BhQ6FX1qYF1NrELcNh/X9Y
         PnjoJR6l3jtciN1Yv5uCnTKjc+lkc/057+IPcNRj4YlyZy2snSLLzlyPFMJtXtFIfztc
         8MTIIuO1n4KtFIIoEMowS1RClhumkQrjbw1zexnxstzSibnyJRvFtrOSuVx7dfOdWsj8
         NTbuPK4etT3obkHF7LJ2jQa2EVVQ5GRvanqf4K7pcOykhjJCWfIE/WPABBTe2GR5ZoCt
         8fMg==
X-Gm-Message-State: AOJu0YzbtGgnbJ820ChbOMPMJk0nrJ2QkKHFv87ICfjnEGO/6UySmEAR
        /LmtgW5d9jWJEGj2IGHRew==
X-Google-Smtp-Source: AGHT+IGAF+x9ZUitcV7dAlZnDe47vxmPt4py4fpRetqxMJ7bZjP220rsXPpzI50pM4oM+BNkX6P1HQ==
X-Received: by 2002:a9d:73c3:0:b0:6b9:b226:d08e with SMTP id m3-20020a9d73c3000000b006b9b226d08emr14910421otk.34.1698176193747;
        Tue, 24 Oct 2023 12:36:33 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z10-20020a4ad1aa000000b00581daa5c5fdsm2049818oor.29.2023.10.24.12.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:36:33 -0700 (PDT)
Received: (nullmailer pid 434690 invoked by uid 1000);
        Tue, 24 Oct 2023 19:36:31 -0000
Date:   Tue, 24 Oct 2023 14:36:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     linux-clk@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Jacob Siverskog <jacob@teenage.engineering>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sergej Sawazki <sergej@taudac.com>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: clock: si5351: add PLL reset mode
 property
Message-ID: <169817619092.434632.12338153362080945824.robh@kernel.org>
References: <20231020-alvin-clk-si5351-no-pll-reset-v5-0-f0c1ba537f88@bang-olufsen.dk>
 <20231020-alvin-clk-si5351-no-pll-reset-v5-2-f0c1ba537f88@bang-olufsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020-alvin-clk-si5351-no-pll-reset-v5-2-f0c1ba537f88@bang-olufsen.dk>
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


On Fri, 20 Oct 2023 13:34:15 +0200, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> For applications where the PLL must be adjusted without glitches in the
> clock output(s), a new silabs,pll-reset-mode property is added. It
> can be used to specify whether or not the PLL should be reset after
> adjustment. Resetting is known to cause glitches.
> 
> For compatibility with older device trees, it must be assumed that the
> default PLL reset mode is to unconditionally reset after adjustment.
> 
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Rabeeh Khoury <rabeeh@solid-run.com>
> Cc: Jacob Siverskog <jacob@teenage.engineering>
> Cc: Sergej Sawazki <sergej@taudac.com>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
>  .../devicetree/bindings/clock/silabs,si5351.yaml   | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

