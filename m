Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29047E5BA9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjKHQqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:45:59 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AE61FEB;
        Wed,  8 Nov 2023 08:45:57 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b3f55e1bbbso4396551b6e.2;
        Wed, 08 Nov 2023 08:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699461957; x=1700066757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2/em8px25lvvpBU9rvHFbF1HeCeuyI1nkJj1hjrCcE=;
        b=cdf6MVQCwN+UF1Ks6dRTdla+uJa6hPZ5/sN0UW/3Y04JkCtQSblGmqQgR+aCTW85ql
         HSqKd21g0/vcMpFj3nUa9has388xWL0XlqjI/YkmlPd/Bxcl7RfkMEYo6gF5aPnOrhZ7
         gH66hnnKP1OFln7f28NOvobGwH5h3mdZhbr5nvQdrIbWuu9wkD7iKH/daOY9u6+Z9yMS
         X2gbY+uwmj/89X7oci5rJbCPpmHh9cSaSQzC/oORgvh+S4pa/m0yHyMSc3UWueCtx+aE
         eM2AYtfsOJaaIVMflGjyGASKU0/Z28VBXiv4F12qKVv3QrZFuPcH/1jsfwVbw55MK7C8
         EbIw==
X-Gm-Message-State: AOJu0Yw8kAVDFG9xcUDuk8a0njsz8sjjy0RO3wod3H/OoKvD1r3ctsbk
        /atnIW7m/0KSJ/ZmOppEWg==
X-Google-Smtp-Source: AGHT+IFvlYjPpMwWNKajh1aieaxBmAkZnibFukFibLaHOGujo2dJzvubHc1EDt/gC2K4PeXz+9SVqw==
X-Received: by 2002:a05:6808:f15:b0:3ac:aae1:6d63 with SMTP id m21-20020a0568080f1500b003acaae16d63mr2822787oiw.44.1699461957004;
        Wed, 08 Nov 2023 08:45:57 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u6-20020a056808150600b003af6eeed9b6sm1951981oiw.27.2023.11.08.08.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 08:45:56 -0800 (PST)
Received: (nullmailer pid 2370821 invoked by uid 1000);
        Wed, 08 Nov 2023 16:45:55 -0000
Date:   Wed, 8 Nov 2023 10:45:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4] dt-bindings: leds: add 'internet' and 'signal'
 function definitions
Message-ID: <169946195473.2370763.12041367537748658964.robh@kernel.org>
References: <TYAP286MB0315F4D71698370875F58F6EBCAAA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAP286MB0315F4D71698370875F58F6EBCAAA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Nov 2023 14:26:51 +0800, Shiji Yang wrote:
> These two types of LEDs are widely used in routers and NICs.
> 
> The 'signal' LED is used to display the wireless signal strength.
> Usually, there are 3~4 LEDs in one group to indicate the signal
> strength, similar to the signal icon on a mobile phone.
> 
> The 'internet' LED can indicate whether the device can access a
> specific server. It's different from 'wan'. 'wan' usually indicates
> whether the WAN port is connected to the modem (internet services
> may still be unavailable). But the 'internet' shows if the device
> can successfully ping servers such as 8.8.8.8 to detect the internet
> connection status. When the router is running in AP only mode, we
> can even connect LAN port to the AC/modem to connect to the internet.
> In this case, the 'internet' LED should be on. On some routers, both
> 'internet' and 'wan' are available and can be controlled separately.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
> 
> Changes in v2:
> * Remove the LED name sorting patch as it changes the ABI.
> * Add "devicetree@vger.kernel.org" to '--to' list.
>   Thanks to Rob Herring and Krzysztof Kozlowski for letting me know I
>   can send patch to multiple mailing list at once.
> 
> Changes in v3:
> * Add more information about the new added LEDs.
> * Remove the missing LED fix as Jisheng Zhang has already sent a
>   similar one. I should search the mailing list first...
> 
> Changes in v4:
> * Rename 'rssi' LED to more generic name 'signal'. I forgot to update
>   the source file in v3.
> 
> v1:
> https://lore.kernel.org/all/TYAP286MB0315FE921FF113BF76F7B700BCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/
> 
> v2:
> https://lore.kernel.org/all/TYAP286MB03159A83A77E6FD59F271D9BBCA0A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/
> 
> v3:
> https://lore.kernel.org/all/TYAP286MB0315AE8F62E6AB48E3F9A0DDBCA5A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/
> 
>  include/dt-bindings/leds/common.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

