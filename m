Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD7D78793D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243473AbjHXUX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243515AbjHXUXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:23:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F711BF0;
        Thu, 24 Aug 2023 13:23:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B7CF63591;
        Thu, 24 Aug 2023 20:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0215C433C7;
        Thu, 24 Aug 2023 20:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692908589;
        bh=3PBtJkg2WZ3R/qS+hkh2lrKdXxwwnQiMiY+RDme0Jsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFYwBMIb2Au7arswiPDu9WGX9Z9aCR4Jg6WU4i6c9JuA13KlGwG+vk2mS+yLKande
         I9A8HNOmOwY4+f6s60c9d2IoYm9P9qDUJjkjF5FVPbyvZsKcWNtS6ir7VeUz+IOdug
         IjHoingdNMjUrMinR5zkGbZiOohE/B6XcjHrPN8kzQCWXnAeSRK83YYUHVTjfJ8ZL2
         LwREZTF2Rqe+9uuPGFC9ho+uJ+5koTacW/ugCtLscV7QAvl2g0PqorSz3RDPe9zSkj
         x/+CK3VJuwr8vVkSkc/bsPwZdo8feq/Qnil9THLYMEjWJbhQNVnrV/A8svmywMA9O6
         K0C47KledO7ug==
Received: (nullmailer pid 1388034 invoked by uid 1000);
        Thu, 24 Aug 2023 20:23:07 -0000
Date:   Thu, 24 Aug 2023 15:23:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: usb: dwc3: Add Realtek DHC RTD SoC
 DWC3 USB
Message-ID: <169290858708.1387981.16009079026714581138.robh@kernel.org>
References: <20230824082824.18859-1-stanley_chang@realtek.com>
 <20230824082824.18859-2-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824082824.18859-2-stanley_chang@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Aug 2023 16:28:09 +0800, Stanley Chang wrote:
> Document the DWC3 USB bindings for Realtek SoCs.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v4 to v5 change:
>     No change.
> v3 to v4 change:
>     Add reg for register set for pm control.
>     Remove maximum-speed in example.
> v2 to v3 change:
>     Add description for reg
>     Remove property for realtek,unlink-usb3-port.
>     Remove property for realtek,disable-usb3-phy.
>     Use the maximum-speed instead of the above two properties.
> v1 to v2 change:
>     Revise the subject.
>     Rename the file.
>     Fix dtschema warnings.
>     Remove the property realtek,enable-l4icg.
>     Drop status.
> ---
>  .../bindings/usb/realtek,rtd-dwc3.yaml        | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/realtek,rtd-dwc3.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

