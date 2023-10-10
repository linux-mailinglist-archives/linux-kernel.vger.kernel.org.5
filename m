Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745E17BFEED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjJJORq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjJJORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:17:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C6699;
        Tue, 10 Oct 2023 07:17:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A73C433C8;
        Tue, 10 Oct 2023 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696947464;
        bh=0uqXFpVu4xMd/m4hEO1AB1o5xxHqn9bBpK0vECkb/vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rvrmVv6spV6Gc04pzXp+ZXDo39SMDSuAiyargrd3zHWfVezi6KUVnJ+7cTwHlVPv9
         RcT5QogpVfhySDASUvSXSc6FwVFUPWyi0x9RYzxx853U9xP5E5Ewf6emGZcN3GX5lj
         4RQimH6z8DI3ldy8ImQZvKCSreTzPW2stx4hMnqPtJZQ8/uE0OnLy0LVOfuZdkImAP
         nzox6ZGmBwWdn78zKtTInhY9QNUQoHQwLxf3bxsRoYd00q54rGm5HcWTt2EDmdHiMT
         ID3Yx8kWCUWP90DZ1ST1IRPVjt4of5LpnQK8xmjWRl3x6wuQI1ZkGZq/n0/ZR0uoSk
         mvoGsZpUJpoTA==
Received: (nullmailer pid 803567 invoked by uid 1000);
        Tue, 10 Oct 2023 14:17:41 -0000
Date:   Tue, 10 Oct 2023 09:17:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, pavel@ucw.cz, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andy.shevchenko@gmail.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org,
        George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v1 11/11] dt-bindings: leds: Add binding for AW20108 led
 driver
Message-ID: <20231010141741.GA779946-robh@kernel.org>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
 <20231006160437.15627-12-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006160437.15627-12-ddrokosov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 07:04:37PM +0300, Dmitry Rokosov wrote:
> From: George Stark <gnstark@salutedevices.com>
> 
> Add aw20108 compatible in devicetree binding for aw200xx led driver.

Binding is for the hardware, not a driver.

For the subject: dt-bindings: leds: awinic,aw200xx: Add AW20108 device

> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  .../devicetree/bindings/leds/awinic,aw200xx.yaml          | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> index 5cd167ab0f04..c3abb0f7ded3 100644
> --- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> @@ -10,15 +10,16 @@ maintainers:
>    - Martin Kurbanov <mmkurbanov@sberdevices.ru>
>  
>  description: |
> -  This controller is present on AW20036/AW20054/AW20072.
> -  It is a 3x12/6x9/6x12 matrix LED programmed via
> -  an I2C interface, up to 36/54/72 LEDs or 12/18/24 RGBs,
> +  This controller is present on AW20036/AW20054/AW20072/AW20108.
> +  It is a 3x12/6x9/6x12/9x12 matrix LED programmed via
> +  an I2C interface, up to 36/54/72/108 LEDs or 12/18/24/36 RGBs,
>    3 pattern controllers for auto breathing or group dimming control.
>  
>    For more product information please see the link below:
>    aw20036 - https://www.awinic.com/en/productDetail/AW20036QNR#tech-docs
>    aw20054 - https://www.awinic.com/en/productDetail/AW20054QNR#tech-docs
>    aw20072 - https://www.awinic.com/en/productDetail/AW20072QNR#tech-docs
> +  aw20108 - https://www.awinic.com/en/productDetail/AW20108QNR#tech-docs
>  
>  properties:
>    compatible:
> @@ -26,6 +27,7 @@ properties:
>        - awinic,aw20036
>        - awinic,aw20054
>        - awinic,aw20072
> +      - awinic,aw20108
>  
>    reg:
>      maxItems: 1
> -- 
> 2.36.0
> 
