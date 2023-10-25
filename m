Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0817D750F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjJYUCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYUB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:01:58 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94772129;
        Wed, 25 Oct 2023 13:01:56 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b2ec5ee2e4so53870b6e.3;
        Wed, 25 Oct 2023 13:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698264116; x=1698868916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDPAhR5fSfEoEkOOmbpL6SW/JEraR6zJHMkU4+VoReA=;
        b=uXzvs/pRahc9vPUUlK/OYJjKXYthBmIx1IncBOEGycpmN2KqFUTrLPqe+L8Fljq8P5
         ruzSt/EGu2AtfmPu1VAe5YdGEmzj7RixuTPpIgMiPTRr9mBuQ0KxN9e73fJbelDeEyUQ
         ewyQdJ/HkNtnKdBE+Zd3jDl76cOAPhjK3R6tWyIO/qt7XEKM9KuTWIgCPx0B1Hw5kaGx
         QOgg1BgGPU1ggwqOPj9eUvMUkbiQIspfPBj2L0XUCayPnyT1rzbIjnHWOe0Jw2vebf17
         Dv9CXL7CMhrnMq2grlfOQaH3eHmM7cTSfWgv7pW/M7Rtq31CCHplfBszGpShZXcOWdax
         fbaw==
X-Gm-Message-State: AOJu0YxSVE76q6IYmIANpgkt8UDHj499mho5VjDT7ux29mMT/K8MUlPt
        D7qfxeQ+iUNCStJWaLdVpQ==
X-Google-Smtp-Source: AGHT+IFqlo/cKt2k9hqKCjgSmwDty+KWjBDgiWpg93HVIlAUyxauJGmqDqOXj6I/m+R/FF7lBIuyzw==
X-Received: by 2002:a05:6808:90:b0:3b2:f54b:8b3a with SMTP id s16-20020a056808009000b003b2f54b8b3amr17589958oic.27.1698264115822;
        Wed, 25 Oct 2023 13:01:55 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z20-20020a544594000000b003a3860b375esm2473216oib.34.2023.10.25.13.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:01:55 -0700 (PDT)
Received: (nullmailer pid 1067568 invoked by uid 1000);
        Wed, 25 Oct 2023 20:01:53 -0000
Date:   Wed, 25 Oct 2023 15:01:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nik Bune <n2h9z4@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, conor+dt@kernel.org, baruch@tkos.co.il,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v2] dt-bindings: watchdog: cnxt,cx92755-wdt: convert txt
 to yaml
Message-ID: <169826378704.1058225.17608945704305055668.robh@kernel.org>
References: <20231023202622.18558-1-n2h9z4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023202622.18558-1-n2h9z4@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Oct 2023 22:26:22 +0200, Nik Bune wrote:
> Convert txt file to yaml.
> Add maintainers list.
> 
> Signed-off-by: Nik Bune <n2h9z4@gmail.com>
> ---
> 
> Changes in v2 (according to review comments):
> - Updated clocks property to have only maxItems without $ref and description.
> - Removed timeout-sec explicit definition, as it is defined in watchdog.yaml.
> 
> v1 patch: https://lore.kernel.org/all/20231022120328.137788-1-n2h9z4@gmail.com/
> 
>  .../bindings/watchdog/cnxt,cx92755-wdt.yaml   | 45 +++++++++++++++++++
>  .../bindings/watchdog/digicolor-wdt.txt       | 25 -----------
>  2 files changed, 45 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/cnxt,cx92755-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/digicolor-wdt.txt
> 

It seems watchdog bindings aren't getting applied, so I've applied it.
Wim, please take watchdog bindings in the future unless noted otherwise.

Rob
