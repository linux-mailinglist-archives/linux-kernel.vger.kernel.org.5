Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F747CCAF0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjJQSos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQSor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:44:47 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0728192;
        Tue, 17 Oct 2023 11:44:46 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3add37de892so3251342b6e.1;
        Tue, 17 Oct 2023 11:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697568285; x=1698173085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9AXL+kNMUTK5DLziPFLVPYslxiHAWx2Uz99cy32iBQ=;
        b=hPr01lCOaKOCo8LNdSVMSHz8zScxvffX71JRCd8fNt/tP9T83h9+XMxjaTWfAEF+/D
         a5DJaK59eZ4037M3s+z45FGqtQ7bm+TBlkRG2UO6InxBTE88mZKm9XDEGKIzRcTdiWhP
         hctBwjIwXjMlcLa88c/3yLHgq0+OzAFsT6NJe698h84bQdT8yvAGdj7Gbqpa+cBC+zuN
         c719F4danzbW1eAUZOWQ9ahV9YXkXix5ZNc8PA8z4/YBtHyDPiAicisyEXej9gUx0CWc
         cyKWVa7He+05oNwNTOuZEquCuAAOBmE12VtliVeMfDcTJc3TZxwDgMbu+bB53YyLrO7J
         /4Vw==
X-Gm-Message-State: AOJu0YxiR1fKCR9xzMlnyL0sWZUPfZzGqORkeZckux93yfxhXd4CqqzJ
        94kyvKi1YM2alOFOpKwwuw==
X-Google-Smtp-Source: AGHT+IFa5Fe5Sjl0kxSSWVeXZ8dmWI5hFb75CSBsBtIJrHTnP6bgppm7OeH4LnEkwMtixdRuyh4UyA==
X-Received: by 2002:a05:6808:97:b0:3af:795d:b74b with SMTP id s23-20020a056808009700b003af795db74bmr3192631oic.50.1697568285302;
        Tue, 17 Oct 2023 11:44:45 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z26-20020a54459a000000b003af60f06629sm347141oib.6.2023.10.17.11.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 11:44:44 -0700 (PDT)
Received: (nullmailer pid 2496099 invoked by uid 1000);
        Tue, 17 Oct 2023 18:44:43 -0000
Date:   Tue, 17 Oct 2023 13:44:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>,
        Daniel Mack <daniel@zonque.org>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: display: remove backlight node from panel
 examples
Message-ID: <169756828188.2496027.18329599357112403195.robh@kernel.org>
References: <20231011-dt-panel-example-no-backlight-v1-1-b81618d32752@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011-dt-panel-example-no-backlight-v1-1-b81618d32752@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Oct 2023 12:47:38 +0200, Luca Ceresoli wrote:
> The examples for these panel drivers have a backlight node in addition to
> the actual panel node. However the exact backlight is outside the scope of
> this binding and should be dropped from the example.
> 
> Link: https://lore.kernel.org/linux-devicetree/20230724143152.GA3430423-robh@kernel.org/
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  Documentation/devicetree/bindings/display/ilitek,ili9486.yaml       | 4 ----
>  Documentation/devicetree/bindings/display/panel/ilitek,ili9163.yaml | 4 ----
>  Documentation/devicetree/bindings/display/sitronix,st7735r.yaml     | 5 -----
>  3 files changed, 13 deletions(-)
> 

Applied, thanks!

