Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0990F7E27B8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjKFOxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjKFOxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:53:43 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F9F3;
        Mon,  6 Nov 2023 06:53:39 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1f03db0a410so2860527fac.1;
        Mon, 06 Nov 2023 06:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699282418; x=1699887218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2V1ZiN+zs3QIzCVMS+3WcPL2sPUpKN5a1KBpkJaxZw=;
        b=Pwa1+cP0XWaajldyILfg4UIjrmuuEJlSp/0rOxIk0bbG190u764q0q2WIKziPnFFpA
         zekO2wrFWydtz+mf5JOgziie1iFjNqTkqDW3w81IG2N030KDCMMbjazAs1+GNewQ7XQZ
         CYedwW/RDNG82nmegBkaB9SPc3npCHDh8Nvtv++j9zLFIePCmKwh/HFNb7vEJ72YshLV
         e7SQhQ295KzPYJgUUaYy6e+igrIO0fd0ev6UXtanU2wQTyHzkuAccCh6tITA8N+RQTB/
         18RU1QwLFp22SX3C1CASAeeasX054wvC5/VgBplT/SFbMEwbbqgCPi2PzyYh5B/baWH4
         NHEg==
X-Gm-Message-State: AOJu0YzF9E9iD34vGizYo+b8CyWN/8+PC5L9zQniMGkAomxwN3wL0OnK
        2OD/6jk33Qd0G0memXxDxTkrZP2Ceg==
X-Google-Smtp-Source: AGHT+IH/P6qGnMzXlfn4Jsuc4Ld6M5FeFXQOO2rlV9PprvtLYOMEsmWcaAqL5pqImcL42+rILxFNZA==
X-Received: by 2002:a05:6871:7515:b0:1ea:406:4dff with SMTP id ny21-20020a056871751500b001ea04064dffmr35930559oac.50.1699282418437;
        Mon, 06 Nov 2023 06:53:38 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id jq8-20020a05687c30c800b001ead209f185sm1400642oac.20.2023.11.06.06.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 06:53:37 -0800 (PST)
Received: (nullmailer pid 327400 invoked by uid 1000);
        Mon, 06 Nov 2023 14:53:36 -0000
Date:   Mon, 6 Nov 2023 08:53:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, rockosov@gmail.com, conor+dt@kernel.org,
        linux-leds@vger.kernel.org, andy.shevchenko@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org
Subject: Re: [PATCH v3 03/11] dt-bindings: leds: aw200xx: introduce optional
 enable-gpios property
Message-ID: <169928241636.327345.6928355613329474540.robh@kernel.org>
References: <20231101142445.8753-1-ddrokosov@salutedevices.com>
 <20231101142445.8753-4-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101142445.8753-4-ddrokosov@salutedevices.com>
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


On Wed, 01 Nov 2023 17:24:37 +0300, Dmitry Rokosov wrote:
> Property 'enable-gpios' is optional, it can be used by the board
> developer to connect AW200XX LED controller with appropriate 'enable'
> GPIO pad.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

