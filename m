Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491447E276A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjKFOpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjKFOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:45:03 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50702D47;
        Mon,  6 Nov 2023 06:44:59 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ce29d1db6eso2637789a34.1;
        Mon, 06 Nov 2023 06:44:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281898; x=1699886698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzTeypYavg43CGGqc/gvMHs0xlS4mmNzFQv4Nkw8p9U=;
        b=xGJAYEr4+93MJzvoyXLOxKjlKW60Rpw0qeyOewGTTRUFbmTGPO+OkTce/92jLLMVub
         v07E+c5Cb7JfjokUxOeDNL2BwmjCNaozjvvzDa1UiKojsDAaU6kCnbj6t7iaIxhhKEnx
         a7qE3tIM9m8ub8a84YdvOmSkEP6Ogrgg38Gm4tzKzLBDC1qxior2V0qgQSkaj4OiXLT4
         vyABCUih9YEeuYLqqh+T1feRd/sGYnsyjM4LO54OX3nKy7/Yt4UOcg4yLqJpHTyasXch
         ZSgmgRxG3/C98zT+3VKyST1XS4O9RXlCGzsb1aTEt7i6Od2doqDsHzVIFle6ydm6okh2
         vuEQ==
X-Gm-Message-State: AOJu0Yyo1I9NxTr3C6jRYdsj3zMla2sQDfb32bgiz/rEYP9hpWLCJXLZ
        qM2guu9QD7fd1C521PdLDA==
X-Google-Smtp-Source: AGHT+IE7RvtxWIISIJToFQ9Z9MXswEDAfriM8yXPO4Qhgdi8XwAPJJQ49Eh7JOWDsy32b9kuz6ye3A==
X-Received: by 2002:a9d:6e81:0:b0:6cd:a4a:181f with SMTP id a1-20020a9d6e81000000b006cd0a4a181fmr5663889otr.17.1699281898505;
        Mon, 06 Nov 2023 06:44:58 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bo7-20020a0568300c0700b006ce28044207sm1295906otb.58.2023.11.06.06.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 06:44:57 -0800 (PST)
Received: (nullmailer pid 317716 invoked by uid 1000);
        Mon, 06 Nov 2023 14:44:56 -0000
Date:   Mon, 6 Nov 2023 08:44:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Naveen Kumar <mnkumar@google.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, royluo@google.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] dt-bindings: usb: add no-64-bit-support
 property
Message-ID: <20231106144456.GA315331-robh@kernel.org>
References: <20231101101625.4151442-1-mnkumar@google.com>
 <20231101101625.4151442-3-mnkumar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101101625.4151442-3-mnkumar@google.com>
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

On Wed, Nov 01, 2023 at 10:16:25AM +0000, Naveen Kumar wrote:
> From: Naveen Kumar M <mnkumar@google.com>
> 
> Add a new DT option to specify whether a host controller is able to
> support 64-bit DMA memory pointers
> 
> Signed-off-by: Naveen Kumar M <mnkumar@google.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.yaml b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
> index 180a261c3e8f..20dc134004f3 100644
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
> @@ -25,6 +25,10 @@ properties:
>      description: Set if the controller has broken port disable mechanism
>      type: boolean
>  
> +  quirk-no-64-bit-support:
> +    description: Set if the xHC doesn't support 64-bit DMA memory pointers
> +    type: boolean

To add on to this, you can handle this with dma-ranges if you need to 
limit DMA addresses to less than 32-bits.

Rob

