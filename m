Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36819753D91
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbjGNOe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbjGNOeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:34:36 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719193AA9;
        Fri, 14 Jul 2023 07:34:09 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3461053677eso4406275ab.0;
        Fri, 14 Jul 2023 07:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689345238; x=1691937238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgiht/lCckduqQild9xWBFcr10Bz7Z0qNdMiS2Y+g2s=;
        b=Yk8qBH59huSWzSFAUZHWkSmfcXa48bAwO08SVsP8GihivmnhD3/Oh5dmHeZbzWNNcG
         Gp66tSimm950RgodlZ+P/dJxmpHzhydsKsVIiE0krkm5HGQPkLSBlwwt6aE+OekQJ0PP
         uCnfCa/NeZZhqS/ZHswILiqex/TQtcuYxNNr1muHnYg0t30vgh028OFfWL5C5CBhkCwC
         m2gPJg/NwhpRrgQE4U8RkyZXK/AHKCGqtKhaB6r4nxeOkRxNHxi3v2QAP7BRlfkP1lWq
         KJsgSLXaIB9E5kVdEQgr4GpQE42o3rbFfJQPR+3cTlzSUR6D2J14bcg10fsoyiCvDzw7
         XMFw==
X-Gm-Message-State: ABy/qLaBccxP6fppoHfe/NIXzPeoCWBMzklck6qeo9dMMd6uY2GykZTw
        CjCdt7ygbGr58GLLlaBmBA==
X-Google-Smtp-Source: APBJJlHc87RGDE4ioh1yw30FaD7V2nkRtIdOKWEAEqqS4SeVwBEFRxF8hNU6UpuUILrr1/1c601qQw==
X-Received: by 2002:a92:d083:0:b0:345:b4e0:35d3 with SMTP id h3-20020a92d083000000b00345b4e035d3mr1939585ilh.9.1689345238217;
        Fri, 14 Jul 2023 07:33:58 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w17-20020a92c891000000b0034233fd80d3sm2788841ilo.22.2023.07.14.07.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 07:33:57 -0700 (PDT)
Received: (nullmailer pid 3490019 invoked by uid 1000);
        Fri, 14 Jul 2023 14:33:55 -0000
Date:   Fri, 14 Jul 2023 08:33:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Flavio Suligoi <f.suligoi@asem.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roy Luo <royluo@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Ray Chi <raychi@google.com>
Subject: Re: [PATCH v7 5/5] dt-bindings: phy: realtek: Add Realtek DHC RTD
 SoC USB 3.0 PHY
Message-ID: <168934521641.3489578.4865141978582966306.robh@kernel.org>
References: <20230707064725.25291-1-stanley_chang@realtek.com>
 <20230707064725.25291-5-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707064725.25291-5-stanley_chang@realtek.com>
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


On Fri, 07 Jul 2023 14:47:04 +0800, Stanley Chang wrote:
> Document the USB PHY bindings for Realtek SoCs.
> Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
> controller and using USB 3.0 PHY transceiver.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v6 to v7 change:
>     Revise the commit message.
> v5 to v6 change:
>     Drop the labels of example.
> v4 to v5 change:
>     1. Remove the compatible realtek,usb3phy.
>     2. Add the default of the property.
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
>  .../bindings/phy/realtek,usb3phy.yaml         | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

