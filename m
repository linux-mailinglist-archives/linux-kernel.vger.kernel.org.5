Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B907AA14F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjIUVAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjIUU75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:59:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830F086807;
        Thu, 21 Sep 2023 10:38:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384D9C4E753;
        Thu, 21 Sep 2023 15:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695310162;
        bh=YRubwqeTifeA4hxGDHOuj3A8llGfWe15Yg+vIKGo/KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghtZJW51nFyAJbX8IGGmWPHaVMTGDhpshg6uJhfm7ecaKMeYV7ZmNy3VqvcLpSBb0
         GlAoeOI+Xx17lJtCZt+tfA1ZzftsqVr8begb0yUvT19DqS2WOg04Uy4i+zYBjhbQjG
         oVni6z/QpNlEIwEcSWtbdc/ninRqMKbgaePXgOqjMITBM8uekywf/IDe2QVxY98LmZ
         pKkF4CTrIntIUYEvNgdeHO+1yhwGM/Mi4spQIHyQYhipOCmNmnOgeEKrQxaKHd1oVg
         BPDMkeqVNMaNgvjbjZBPxHYC1f8tUMy0ZPesZrNH1ifVfWJceeVcgathtCddib6kxv
         8OMM2htV20Pog==
Received: (nullmailer pid 378728 invoked by uid 1000);
        Thu, 21 Sep 2023 15:29:21 -0000
Date:   Thu, 21 Sep 2023 10:29:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: gpio-keys: Allow optional
 dedicated wakeirq
Message-ID: <20230921152921.GA160147-robh@kernel.org>
References: <20230920115044.53098-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920115044.53098-1-tony@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:50:43PM +0300, Tony Lindgren wrote:
> Allow configuring an optional dedicated wakeirq for gpio-keys that
> some SoCs have.
> 
> Let's use the common interrupt naming "irq" and "wakeup" that we already
> have in use for some drivers and subsystems like i2c framework.
> 
> Note that the gpio-keys interrupt property is optional. If only a gpio
> property is specified, the driver tries to translate the gpio into an
> interrupt.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> 
> - Run make dt_binding_check on the binding
> 
> - Add better checks for interrupt-names as suggested by Rob, it is
>   now required if two interrupts are configured
> 
> - Add more decription entries
> 
> - Add a new example for key-wakeup
> 
> ---
>  .../devicetree/bindings/input/gpio-keys.yaml  | 41 ++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)

With the indentation fixed,

Reviewed-by: Rob Herring <robh@kernel.org>
