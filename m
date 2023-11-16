Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42117EE52B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjKPQ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKPQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:29:03 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5F3AD;
        Thu, 16 Nov 2023 08:28:58 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1ea82246069so482665fac.3;
        Thu, 16 Nov 2023 08:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700152138; x=1700756938;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHpsolomr1O8IoNZNmWuKJghrcMhtNlGZuOKvxu4Hyg=;
        b=rAPReS48rdOynBf8fZhqE/qyTywjD1L+pbSHRe0OssTTniIOmVafVxA5uvW+6qUFqv
         aGnNH3afUMy3hfRnpcqgkCRZk8VMaHpmDmb1v1whtA3pp9adiv3HmRfSTYhUzRDn/NrB
         +No9dhTTbtXmr3moQWOUiVS54B+omnb+Dfy9vdrIkE3bbksL+UyCW3R4nS/LbAO2lZWr
         jhj/XpvMALMqgqbfQwr1y/wUtElRaLSYNxlA+HG2pcn31qZ3VvCpA8xqeZFu9INzDJU8
         Ii/HCBPN0rP+vwJ8rqTFo8VpWlMT7jZGbLHaA7aDyECvHmCbFdMIYwjP1ks+iVbSmdzV
         2yFQ==
X-Gm-Message-State: AOJu0Yx7QbGIFAIelyRvsLgwdpOE+2tAve+Ycpj3JABysEJSUBaAcpkR
        FeJ8v+Ierj3ulNv/8FALLw==
X-Google-Smtp-Source: AGHT+IEN7OCfu+AaT2L23F6tUrWC+9ztcQ5rH5Mxyh/0SpCy8jBoSr8cd13j15tMtuSmOolw2nIBzQ==
X-Received: by 2002:a05:6870:6c05:b0:1f0:6931:e301 with SMTP id na5-20020a0568706c0500b001f06931e301mr21055183oab.0.1700152137858;
        Thu, 16 Nov 2023 08:28:57 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bp9-20020a056871280900b001eb79fedbb1sm2156514oac.17.2023.11.16.08.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:28:57 -0800 (PST)
Received: (nullmailer pid 2438161 invoked by uid 1000);
        Thu, 16 Nov 2023 16:28:55 -0000
Date:   Thu, 16 Nov 2023 10:28:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: gpu: samsung: constrain clocks in
 top-level properties
Message-ID: <20231116162855.GA2435337-robh@kernel.org>
References: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
 <20231112184403.3449-3-krzysztof.kozlowski@linaro.org>
 <20231113-sultry-cold-d63dd9f015d9@squawk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231113-sultry-cold-d63dd9f015d9@squawk>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 01:51:30PM +0000, Conor Dooley wrote:
> On Sun, Nov 12, 2023 at 07:44:01PM +0100, Krzysztof Kozlowski wrote:
> > When number of clock varies between variants, the Devicetree bindings
> > coding convention expects to have widest constraints in top-level
> > definition of the properties and narrow them in allOf:if:then block.
> > 
> > This is more readable and sometimes allows to spot some errors in the
> > bindings.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> Åcked-by: Conor Dooley <conor.dooley@microchip.com>

  ^

Not an 'A'. I only caught this because I go thru everything 
Acked/Reviewed-by first and this one was missed.

Rob
