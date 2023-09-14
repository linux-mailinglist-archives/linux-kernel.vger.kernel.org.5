Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA127A07EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbjINOwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjINOwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:52:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14476F9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 07:52:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4994C433C8;
        Thu, 14 Sep 2023 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694703156;
        bh=gE+iGruQvOG/SXJlNTNSS7Rv1fSDB/ionw3c3sNQrcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S5ESi6R5qMDsXGmiZDsnnind0aPSnL6noRDyLYFTZtx1d+j1daLn7AWfsepRmepyf
         viDS8j6XGiMLl50jlo7xDu3U+90/N5EZ19I0jOGIP5jLktjo279oem6Ri6jaLJhWNx
         VV03MjWJqy5rq4m/h+OLechKjMHRILcFnnHQ9CR9t+Ja3iKYb6iuy4OXj1+UUmUmk7
         sHJ2m7IALxLbuJa8hfxQcfpAv6UwjLAWlh1nEtZ0Xp7zanYEohytfLo8wbk5wet7o7
         Qhfvhf5MULFQUlPhgaCyJynvsuC9h1MAVmzPQUfvTVNgmJVlechH3RVnHN/SxZK7Vv
         CaEobsiHP5ApQ==
Received: (nullmailer pid 1276282 invoked by uid 1000);
        Thu, 14 Sep 2023 14:52:34 -0000
Date:   Thu, 14 Sep 2023 09:52:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     John Watts <contact@jookia.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ASoC: dt-bindings: wlf,wm8782: Add wlf,fsampen
 property
Message-ID: <20230914145234.GA1275176-robh@kernel.org>
References: <20230913171552.92252-1-contact@jookia.org>
 <20230913171552.92252-4-contact@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913171552.92252-4-contact@jookia.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 03:15:52AM +1000, John Watts wrote:
> The WM8782 can safely support rates higher than 48kHz by changing the
> value of the FSAMPEN pin.
> 
> Allow specifying the FSAMPEN pin value in the device tree.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---
>  Documentation/devicetree/bindings/sound/wm8782.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/wm8782.txt b/Documentation/devicetree/bindings/sound/wm8782.txt
> index 256cdec6ec4d..d217a616e103 100644
> --- a/Documentation/devicetree/bindings/sound/wm8782.txt
> +++ b/Documentation/devicetree/bindings/sound/wm8782.txt
> @@ -8,10 +8,15 @@ Required properties:
>   - Vdda-supply : phandle to a regulator for the analog power supply (2.7V - 5.5V)
>   - Vdd-supply  : phandle to a regulator for the digital power supply (2.7V - 3.6V)
>  
> +Optional properties:
> +
> + - wlf,fsampen : FSAMPEN pin value, 0 for low, 1 for high, 2 for disconnected

What's the default if the property is not present?

> +
>  Example:
>  
>  wm8782: stereo-adc {
>  	compatible = "wlf,wm8782";
>  	Vdda-supply = <&vdda_supply>;
>  	Vdd-supply = <&vdd_supply>;
> +	wlf,fsampen = <2>; /* 192KHz */
>  };
> -- 
> 2.42.0
> 
