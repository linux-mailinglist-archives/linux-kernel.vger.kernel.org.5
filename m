Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28287DBE33
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjJ3Qng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJ3Qne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:43:34 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5020298;
        Mon, 30 Oct 2023 09:43:32 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b2e308a751so2349402b6e.0;
        Mon, 30 Oct 2023 09:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698684211; x=1699289011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eb/YORMOjlpnh4rbVTUZhBfc4hKj/SVVxZvyoJL1lz8=;
        b=b3BsbMe4HB8nYOYywurvT1bpIy8ZF11kTXpq5UNkC+Hq2GYhrmp6efw+jVQ73L5GkA
         AlEIQ+AwajxXnMv607TSbM1KvCEwXu5AawUYPi2dEk3+Kz/HyBFABj1N89vKf9hmcp9k
         0prg+2Da3b0GGZfJWd7rdWuCRlSuF6GfRMk4Cfkgi8m52Rg4L2+OLBwUh/jW/ctnMeJW
         ZPf5PFCqihPUeAtUrl5rKzyl7C7otoIOjmqUFDaQG75W/6fibPk5YV3Yt3lHIjYSl1BI
         cEb67GgHzuFNx7RG+aWKBHnPyvqW6x+h1FbQ6EFP4lPyllw5CgSKRyMdGilXdwgco6RF
         ejMw==
X-Gm-Message-State: AOJu0Yy0fsRyvMVit6g8Hkg/XIBReygsqN2HfSR9ewrSCNeW5+joHl05
        DAA+FQetgiz9G6+6aN5O9g==
X-Google-Smtp-Source: AGHT+IHMyFzMgm+c8dVGQtXeMkZmLGewJPYTiE1ve03hzwu64Cz53i0nHeF5ZdHN1wDStXGrXA8DlA==
X-Received: by 2002:a05:6808:1383:b0:3ad:fa4b:4875 with SMTP id c3-20020a056808138300b003adfa4b4875mr84115oiw.11.1698684211419;
        Mon, 30 Oct 2023 09:43:31 -0700 (PDT)
Received: from herring.priv ([2607:fb91:e6c7:c3eb:a6fd:69b4:aba3:6929])
        by smtp.gmail.com with ESMTPSA id bg20-20020a056808179400b003b2e3e0284fsm1441279oib.53.2023.10.30.09.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 09:43:30 -0700 (PDT)
Received: (nullmailer pid 1482542 invoked by uid 1000);
        Mon, 30 Oct 2023 16:43:27 -0000
Date:   Mon, 30 Oct 2023 11:43:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: Re: [PATCH 5/7] dt-bindings: trivial-devices: Add IOT2050 Arduino
 SPI connector
Message-ID: <20231030164327.GA1242659-robh@kernel.org>
References: <cover.1698413678.git.jan.kiszka@siemens.com>
 <7838d99a1795337c73f480fafcbf698fc17d16dd.1698413678.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7838d99a1795337c73f480fafcbf698fc17d16dd.1698413678.git.jan.kiszka@siemens.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 03:34:36PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> On the Siemens IOT2050 devices, the SPI controller wired to the Arduino
> connector is normally driven by userspace. Introduce a binding for use
> by spidev.

What's spidev? Not a h/w device...


> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 430a814f64a5..01b9f36afcd5 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -349,6 +349,8 @@ properties:
>            - silabs,si3210
>              # Relative Humidity and Temperature Sensors
>            - silabs,si7020
> +            # Siemens IOT2050: SPI interface on Arduino connector
> +          - siemens,iot2050-arduino-spi

How is this specific to your board? Presumably, an 'Arduino connector' 
is a somewhat standard interface, right? If every board with an Arduino 
connector adds a compatible, this doesn't scale.

A connector is what you should be describing, but I imagine it is not 
just SPI. Here's some past discussions[1][2] on the need for connector 
bindings.

Rob


[1] https://lore.kernel.org/all/20220421094421.288672-1-michael@walle.cc/
[2] https://lore.kernel.org/all/CAL_JsqK2DKPbaFvUPSU2E7oh1_pryrRXPMg8OASmK722jmznwA@mail.gmail.com/
