Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C607CA70A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjJPLxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjJPLw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:52:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A85A109;
        Mon, 16 Oct 2023 04:52:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9be7e3fa1daso317801566b.3;
        Mon, 16 Oct 2023 04:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697457170; x=1698061970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ylGPgerA7JSBXW4o/i4XQZounlAgX7/yFcNqik5k9g4=;
        b=Esqsr6YqSFba8nEZLfkO1aT6pKmzrJWzDZoUGVJOvkVGkAN3nmkuRSBirpcg73nx9s
         dT1fxFMrzXci3A28gVarRR79a04K4+snxj5pNh7MpzMKXOAKScUY39PQHkd/XHllYYDv
         okc7BKhvMna2jHe3yOKqtOyiNbDnSmC/KZmL/1AUO7MreImdwmxYl7v332cnuwbJ0J5b
         ulTcYLcut1cigUc3mCbHxATkxMWBXzkgOaXv9N93BatHvqbARKpF8G9pUMTDKB1mKEmT
         i3Wh4HaCqBqA5VmxfpV7MEhFqf48o/wJW4wOyALbSuI3PF7mN+CHhwMslbSCO/FxSbpk
         1uIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697457170; x=1698061970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylGPgerA7JSBXW4o/i4XQZounlAgX7/yFcNqik5k9g4=;
        b=wTyfl+VDIYUZucNlIYV+e3zgypCZ2YEAI35O3m5wwnhYyujsIhqDmLCxoPVz9h79Hr
         NKm+H3oNEVRnaRAF+FczuNdyJ/rYhe9IswUOAWZhnOzRgH9VZuI+D26OP8D5U7Fd+46u
         10p6jRByBGETGOCjPoEmMoZWfV67oO0ZdPt+SgiJmwjwYzZ82ZOsDNtIC8e7UTo2c58a
         Scs1P5580QsmbwZulihFtG4q9boc+mNcD45K6wvvgOTv7IkuNcuWEINouzx4+D0VYtHE
         3uOrRaA21okMNTdWAy5y0eaxuz2KQ696l9fFq8OE4Bym6oYuuVRYp+fqtEmrqZJVHjKJ
         XaNA==
X-Gm-Message-State: AOJu0YywxHR4Auxx2YS3V7L6nIvRvDvK3AzEMCi7SG27UbYpzTy2aaRY
        1O0gi4/9UT1lZr3oYw+6fIo=
X-Google-Smtp-Source: AGHT+IGwUZmGUJ7eZXwonOqTO+7N6o6Q7P3ALprk6hBr0aDB1PQwIovP+gi/1e90a/uQqx6HTZl51w==
X-Received: by 2002:a17:907:2d09:b0:9be:d55a:81c5 with SMTP id gs9-20020a1709072d0900b009bed55a81c5mr5620750ejc.60.1697457169543;
        Mon, 16 Oct 2023 04:52:49 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709061b5600b009737b8d47b6sm3815855ejg.203.2023.10.16.04.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:52:49 -0700 (PDT)
Date:   Mon, 16 Oct 2023 14:52:46 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/6] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
Message-ID: <20231016115246.rjcoggwtpkmw7f4v@skbuf>
References: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
 <20231016-marvell-88e6152-wan-led-v3-1-38cd449dfb15@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-marvell-88e6152-wan-led-v3-1-38cd449dfb15@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:12:54AM +0200, Linus Walleij wrote:
> This is an attempt to rewrite the Marvell MV88E6xxx switch bindings
> in YAML schema.
> 
> The current text binding says:
>   WARNING: This binding is currently unstable. Do not program it into a
>   FLASH never to be changed again. Once this binding is stable, this
>   warning will be removed.
> 
> Well that never happened before we switched to YAML markup,
> we can't have it like this, what about fixing the mess?
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

It would make more sense for this patch to be last, after you've fixed
the warnings that this patch introduces.
