Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57662752AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjGMTQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjGMTP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:15:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847721993;
        Thu, 13 Jul 2023 12:15:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 157A161B32;
        Thu, 13 Jul 2023 19:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E84C433C7;
        Thu, 13 Jul 2023 19:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689275757;
        bh=wMAAhumlVTX0yM9sGr71/Qtd2eWIFF4a6a+b8XS0BR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+d39gaEwtn59FjRTtalKbrFQ4ZI6g86ihfs4Eeh28rmvYFu0E0lwH/me6ta4x3Ke
         bQzsZYF4TSR9LtyVoL7cjmmglE6i8Dq1X7deLDrpatuJenfaxjKFjwxkO78XZ0XdVT
         J9bT+m+7PVHksM8LToszm99NvXYN/47smkhLN3M4TBauUHYuJRYKmSs9JeR1aPTmbw
         GaaLxrrVM0W2wNFrpFxrvKYplh0ySK08eKzYpM7n3n+YO/0pN/52zmn0LQTS4weaFs
         Ci38WDKqlEwFhcMuR9mBOGiKNlYtPX+g1l0j1YMxPALkzeH9DLCaQZIQkgt9nUjtCz
         +J3hvBAWjsG1g==
Date:   Thu, 13 Jul 2023 20:15:50 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] dt-bindings: mfd: brcm: drop unneeded quotes and
 use absolute /schemas path
Message-ID: <20230713191550.GA1016730@google.com>
References: <20230713065040.7968-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713065040.7968-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023, Krzysztof Kozlowski wrote:

> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.  Also absolute path
> starting with /schemas is preferred.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Rebase and resend. Dependencies were merged in v6.5-rc1.
> 
>  .../devicetree/bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml     | 4 ++--
>  .../devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml    | 4 ++--
>  .../devicetree/bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml     | 4 ++--
>  .../devicetree/bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml     | 4 ++--
>  .../devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml     | 4 ++--
>  .../devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml     | 4 ++--
>  6 files changed, 12 insertions(+), 12 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
