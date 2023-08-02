Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D85E76D110
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjHBPIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjHBPHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:07:39 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CD13AA0;
        Wed,  2 Aug 2023 08:07:12 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb84194bf3so43578225ad.3;
        Wed, 02 Aug 2023 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690988832; x=1691593632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jkYV7c5PLMTn5+v3tPIkhhWx21IaP2g8CeWnmycn90=;
        b=BWOwB+kC+ca19GkjhgxcBsds/x3qJxBoyS2Mv6o6f4kKa+8h1r4XBIX7VU+MZTs+hz
         ah2LOojfErDO0l4Fb+x29RyibobZu0cEgTBtHU+5/cXXpQLLCFSMZ//fgm/EVAKtlHlH
         pxhgSrEfFi+3KXedd3BgzihMfkjASj5jhrkCUCwufWHZ0cPdmXOyroACbZL3xJmrlFuH
         ORVbUUjvi0CBW6IFz2AeaLKx/vTnRdWHdikh7FGKRemrYt1+Hbps1PVU9qfZL9swJN7b
         Lu0u/cG8tmSm5zY7yxbOfcv9tc6eftXRHg/xOLC3+igXISGRqvsu//oC5Ur9sCB0SE9u
         ZfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690988832; x=1691593632;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jkYV7c5PLMTn5+v3tPIkhhWx21IaP2g8CeWnmycn90=;
        b=FgB6EpEgz1VBrj7a2kYYBrooX8vkhGFUDc7ZsU1bNoqLYBThTU0h8cGMZ8hWcevnvA
         IDVyy/JeAXtS77pzQJaEJoExg0G5veVV62MKInbyX73Y+T23MeyC+0CXS4nf+sTsTNT7
         OUez5Yj60K0XF/YIPSpgAQnboTN7yG3fFtqrCBE7PzhWQkqwOlW7WuWks7h6AUG1ha1o
         NPP9i6rG4qTMvZaZxpcj+ofQ8ZUzDZ2of4zj8z/iV8bNr+Rp51CNiOjVkNM6Kor4SdRL
         VvwvkKaDf0zzg1zRoRQgeNylR9t+YOnNk8WSShbFNUuYyNHaKz+8/7v13T6DsrmVEWeT
         k5sg==
X-Gm-Message-State: ABy/qLZTbCpKLC+ptU47oB+X0A0GT+LjqHcON2WchXWmLuW0EY0lTssx
        WxRmF4B0cactTgqtVw7DM0c=
X-Google-Smtp-Source: APBJJlEygCUlYmzIURk4gjtEnKzK4hnw15QHHhv8QAxHHcCTm0Xbt+OEzBvPahfOd4zzzB7S9XJI+Q==
X-Received: by 2002:a17:902:8f8b:b0:1b8:9db5:2ec1 with SMTP id z11-20020a1709028f8b00b001b89db52ec1mr12807169plo.67.1690988831647;
        Wed, 02 Aug 2023 08:07:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 18-20020a170902c21200b001bc21222e34sm3995116pll.285.2023.08.02.08.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:07:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 2 Aug 2023 08:07:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Carsten =?iso-8859-1?Q?Spie=DF?= <mail@carsten-spiess.de>,
        Conor Dooley <conor@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: hwmon: add renesas,isl28022
Message-ID: <c46fe1bc-3170-4ab3-9de4-86d6877a004f@roeck-us.net>
References: <20230801163546.3170-1-mail@carsten-spiess.de>
 <20230801163546.3170-3-mail@carsten-spiess.de>
 <20230801-implicate-mullets-bd160bbda4b2@spud>
 <20230802093023.1a926c9f.mail@carsten-spiess.de>
 <20230802-sandbar-crudely-78a4b8a351b0@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230802-sandbar-crudely-78a4b8a351b0@wendy>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 08:43:59AM +0100, Conor Dooley wrote:
> On Wed, Aug 02, 2023 at 09:30:23AM +0200, Carsten Spieß wrote:
> > 
> > On 8/1/23 22:52, Conor Dooley wrote:
> > > On Tue, Aug 01, 2023 at 06:35:46PM +0200, Carsten Spieß wrote:
> > > > Add dt-bindings for Renesas ISL28022 power monitor.
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - renesas,isl28022  
> > > 
> > > You've only got one compatible, why the enum? Will there be more similar
> > > devices that have an incompatible programming model?
> > Yes, there are isl28023 and isl28025 with different register addresses,
> > might be supported in future releases.
> 
> Right. Unless that's a very strong "might", const: will do the trick
> here just fine.

It is a very strong "will never be" for isl28023 and isl28025.

Guenter

> 
> Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> > > > +  renesas,shunt-range-microvolt:
> > > > +    description: |  
> > > 
> > > You don't need these |s if you have no formatting to preserve in the
> > > text.
> > Will fix in v4.
> 
> There's no need to send a v4 for that alone.


