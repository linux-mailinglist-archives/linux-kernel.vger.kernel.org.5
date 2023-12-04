Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BE1803470
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344243AbjLDNXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbjLDNXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:23:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD4ED5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:23:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1285BC433C7;
        Mon,  4 Dec 2023 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701696216;
        bh=ek3ANT87AWqPR1Eca9OZQtmPMVo5VRMPorN42gdYvgY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AJs1P8QdLhwxhurk24vb8kK4mxKFCklvfs+/zuUF4DXHatRF3YJgx0ZchAXpYEjNz
         EuYCkY2kQPoYoDmbMOCXxzsB3h2MRgnkvN9skNHMwLDqYL4bzfwsuVCzHjoZMQ4zta
         Gpnmrng3JciT7HY/s8+FAbyCWCkdHjntdre9726t7QtijJAhMpJT0CFDm7cpUZdK1k
         TSm+5+bdNA16U6UZg1cOFK1Hyx/AJ8hBjjVOEcHKwm2LpUrMaq+WyX1RSPvxMXfbmR
         fAsAiZsnMZTh6OApYM0BtuNZvEhBjELSLRH/ow6Ia9x3ITVFvkjCDe2nBP6JugC9JY
         GAlBSp6/x+qig==
Date:   Mon, 4 Dec 2023 13:23:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio/adc: ti,palmas-gpadc: Drop incomplete
 example
Message-ID: <20231204132327.227588d8@jic23-huawei>
In-Reply-To: <87771c1f-17fd-4895-aafc-4fe0c38a59ee@linaro.org>
References: <20231128214803.3975542-1-robh@kernel.org>
        <87771c1f-17fd-4895-aafc-4fe0c38a59ee@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 09:30:23 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 28/11/2023 22:48, Rob Herring wrote:
> > The example for the TI Palmas ADC is incomplete as the binding is the
> > full PMIC, not just the sub-functions. It is preferred for MFD examples
> > to be complete in the top-level MFD device binding rather than piecemeal
> > in each sub-function binding.
> > 
> > This also fixes an undocumented (by schema) compatible warning for
> > '"ti,twl6035-pmic", "ti,palmas-pmic"'.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---  
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan
