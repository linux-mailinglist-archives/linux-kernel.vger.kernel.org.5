Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F53753D88
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbjGNOdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbjGNOdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:33:52 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEA33A96;
        Fri, 14 Jul 2023 07:33:13 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-345f3e28082so8384585ab.1;
        Fri, 14 Jul 2023 07:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689345184; x=1691937184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf90yCWC/Qqdnr0SRBoZ5jMgO+4zIAgRXZgbEEN5z0k=;
        b=AVt2GpDIyyWMXCHhEjYAdwxsWyD+VGJo7BJIoOFAoel7UuXvpGsMqRO4qVFOVrIR6p
         H8Q7YZ0R5/V8NVkoD0FTF+DT+S7KgoI0/Y3HzI8MD+JVxuG3WAAChOBFIfs3elh5s269
         6LfR2rjifSaG4c1zkwYh6EUdO7fRJWaMjpMG811m6LfsTdbWqu5oEh+ye1brsvo0PHIV
         rci/IglimmLalam1/bzBLhKEuFSJaQJKyBmq86j8dP2MxKcn67siXzJSMprC924ZFb8d
         1tJcx0auK1QYN7fj+/uKJZApCDWc8KTFXRdXHDcnetI92fi9wzsxUj6cE0R1yGcEZDtu
         FrXA==
X-Gm-Message-State: ABy/qLZWH6xKUzzN3kI34HdbaMzb9Bk22AUVlJ8Sq0XIcDx0NrywcLO4
        cm4vUL054ivGJE/nwyt96g==
X-Google-Smtp-Source: APBJJlG+Si+Ds9hRccCS0//Wm2Kl1639AFJzVjLprZtZCtSIorBGRW0ShYQ8I+sjmJMhcxfg1FSiJQ==
X-Received: by 2002:a92:1a52:0:b0:345:775f:1a2f with SMTP id z18-20020a921a52000000b00345775f1a2fmr4681914ill.14.1689345183884;
        Fri, 14 Jul 2023 07:33:03 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f17-20020a056e0204d100b00345de23f6b6sm2759553ils.6.2023.07.14.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 07:33:03 -0700 (PDT)
Received: (nullmailer pid 3488768 invoked by uid 1000);
        Fri, 14 Jul 2023 14:33:00 -0000
Date:   Fri, 14 Jul 2023 08:33:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Ray Chi <raychi@google.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roy Luo <royluo@google.com>, Vinod Koul <vkoul@kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-phy@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH v7 4/5] dt-bindings: phy: realtek: Add Realtek DHC RTD
 SoC USB 2.0 PHY
Message-ID: <168934517988.3488706.6095305078054455561.robh@kernel.org>
References: <20230707064725.25291-1-stanley_chang@realtek.com>
 <20230707064725.25291-4-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707064725.25291-4-stanley_chang@realtek.com>
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


On Fri, 07 Jul 2023 14:47:03 +0800, Stanley Chang wrote:
> Document the USB PHY bindings for Realtek SoCs.
> Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
> controller and using USB 2.0 PHY transceiver.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v6 to v7 change:
>     1. Revise the commit message
>     2. Change the property name for realtek,driving-level-compensate
>     3. Add if/then schema for specific properties
> v5 to v6 change:
>     Drop the redundant examples
>     Drop the label of example
> v4 to v5 change:
>     1. Add more examples.
>     2. Remove the compatible realtek,usb2phy.
>     3. Revise the descriptor of the property.
>     4. Add the default of the property.
> v3 to v4 change:
>     1. Remove the parameter and non hardware properties from dts.
>     2. Using the compatible data included the config and parameter
>        in driver.
> v2 to v3 change:
>     1. Broken down into two patches, one for each of USB 2 & 3.
>     2. Add more description about Realtek RTD SoCs architecture.
>     3. Removed parameter v1 support for simplification.
>     4. Revised the compatible name for fallback compatible.
>     5. Remove some properties that can be set in the driver.
> v1 to v2 change:
>     Add phy-cells for generic phy driver
> ---
>  .../bindings/phy/realtek,usb2phy.yaml         | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb2phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

