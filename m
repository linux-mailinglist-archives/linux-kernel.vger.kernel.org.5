Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9187879E594
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbjIMLAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239798AbjIMLA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:00:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBD81726;
        Wed, 13 Sep 2023 04:00:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ad810be221so251996866b.2;
        Wed, 13 Sep 2023 04:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694602823; x=1695207623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=au/7PSHEheAOFV6kauhcShIfB51spSoacnx+jNp9SGs=;
        b=R5kkvVIhbFUE6mCMpOt0PtzC71M4K2heFLKLeFLM9gWgXJZwvtKlNfcJ/SFW5Tc1wf
         CN9h37jExPXTRxhyTzuW1I0YSuI6cSERb46paJbSOaV37z57nYu/AVjQqqgOyqJrHVGM
         zywUKxXNwaaftR6Yzwm6e17MknB5ud7ehmmT99zhF5BCPRe6N5jUKS2zZYp1aLTM7kbl
         tRl3MjFp5HOxtzCxEP/ULsHe3GBb7qeDLHu6HCPP3sp5saVg/yOFFNrro8velw1WKTuJ
         M8ytU0wjTjvyfIDyoVIfUz0nAYgSislVT/4eKFLECUeNgBY5jE5P76etPUCli+nHZ4vj
         wn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602823; x=1695207623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=au/7PSHEheAOFV6kauhcShIfB51spSoacnx+jNp9SGs=;
        b=gzDgoONjo2ErDJv8/94orXhHpDT7JbWFpalBeQ7NsmU2ptklRvKmqaUrxtxJYw6Txi
         W5mv+tnvm/kBo2qWZ+Ooyxq7MyocaPp3eVA5YBGWF0QBYUIDtmlnKRdXnz3zaAueHyZM
         GMYfnkb0MvULKNorR+sNMhkaR5iySmJ0Bh4BGIk8zULdWiZ3BnLJeBCEgvuGvrZSEuwd
         X/XzUJ5BlefuKr9WEgPZphaODHo07R9gxqLwcCcbOuREJFKi7PabbC5R2828ohAv2wE3
         FYRUQQWtiFVlbWHN8T1RWrlSrkhMsI4BYxUdWAvcuzbNI28rWt0XHicN5HjP1WLCcj2E
         eZ8A==
X-Gm-Message-State: AOJu0YyJWft5iaHntSZ9OIDw0FUzfiNGnLS9pZSiMaJAvt/EVeMDFWdQ
        DAmSQtVtVWYK859ez9mJyLw=
X-Google-Smtp-Source: AGHT+IF7yTclIVJKpeCodlCooHdBEfeammFCCEJq5RHV5EJTUSb/wU6bhojoQGcUcKOMJJpCsd+Jwg==
X-Received: by 2002:a17:906:51c8:b0:9a1:d915:637a with SMTP id v8-20020a17090651c800b009a1d915637amr1685038ejk.61.1694602822867;
        Wed, 13 Sep 2023 04:00:22 -0700 (PDT)
Received: from skbuf ([188.26.184.93])
        by smtp.gmail.com with ESMTPSA id pv26-20020a170907209a00b00992d122af63sm8199511ejb.89.2023.09.13.04.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 04:00:22 -0700 (PDT)
Date:   Wed, 13 Sep 2023 14:00:20 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: rtl8366rb: Implement setting up link
 on CPU port
Message-ID: <20230913110020.mly455oreyrsyld6@skbuf>
References: <20230912-rtl8366rb-link-v1-1-216eed63f357@linaro.org>
 <20230912-rtl8366rb-link-v1-1-216eed63f357@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-rtl8366rb-link-v1-1-216eed63f357@linaro.org>
 <20230912-rtl8366rb-link-v1-1-216eed63f357@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:24:18PM +0200, Linus Walleij wrote:
> We auto-negotiate most ports in the RTL8366RB driver, but
> the CPU port is hard-coded to 1Gbit, full duplex, tx and
> rx pause.
> 
> This isn't very nice. People may configure speed and
> duplex differently in the device tree.
> 
> Actually respect the arguments passed to the function for
> the CPU port, which get passed properly after Russell's
> patch "net: dsa: realtek: add phylink_get_caps implementation"
> 
> After this the link is still set up properly.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
