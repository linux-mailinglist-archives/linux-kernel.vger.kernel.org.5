Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF8E7EE6F1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbjKPSmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345452AbjKPSmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:42:05 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E75D51;
        Thu, 16 Nov 2023 10:42:02 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6d30d9f4549so625473a34.0;
        Thu, 16 Nov 2023 10:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700160121; x=1700764921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkWTQOIyVpOfLdSmjxQe+ZEyWYh6CEVKH0sUokEYmis=;
        b=kk52Ys/WPMMQyh1GEE4BZH35jJCpOsD49gp8nHKqVyC45kShSqecbDuILfPo4uLeDu
         yvWg5NQjGfuGFPo0DtubSx3yPmMkG2mQk2ZNOpfXW0oWqnjXKjwLQ7BtJoPimUx6kx3/
         EyNw9iadcSAXQWvUxeKJvG8jGrDsRGrDfc5CeP2v5D9Dz7wDVRIJpeuDGl+4tFfvbqTF
         MnxD83j2qOYBN3CNi48RQYdWX46WcYT3unt5uASJzUDAlWDx2QPa+bv9m9UNZN5wiUL9
         YCQ9MUSNHgVnBGKQnBGySmpgmD3x8fFy62k2K8IEcPo+vF8TLYAKLu6DaLG9r0ruZuh1
         m5XA==
X-Gm-Message-State: AOJu0Yw/JaKu0RjzZGIHc08cPBgG4Zm7CAr99h+mwGdNbEk+wSHjbEse
        S/Ty5qeaQ2vg0tdklOoHVA==
X-Google-Smtp-Source: AGHT+IHpLDFf/BevPQYjKNzthluo2+W8QR5uIN8SPGvSIJTeV7vcKNQsUuWQcBz9PkynNh2NxdIIEw==
X-Received: by 2002:a05:6830:cc:b0:6ce:267b:d409 with SMTP id x12-20020a05683000cc00b006ce267bd409mr9992998oto.13.1700160121336;
        Thu, 16 Nov 2023 10:42:01 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r42-20020a05683044aa00b006c4d822bea7sm998466otv.31.2023.11.16.10.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:42:00 -0800 (PST)
Received: (nullmailer pid 2821189 invoked by uid 1000);
        Thu, 16 Nov 2023 18:41:59 -0000
Date:   Thu, 16 Nov 2023 12:41:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v8 6/9] dt-bindings: net: ethernet-switch:
 Accept special variants
Message-ID: <170016011897.2821150.13183612616201132930.robh@kernel.org>
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
 <20231114-marvell-88e6152-wan-led-v8-6-50688741691b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114-marvell-88e6152-wan-led-v8-6-50688741691b@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Nov 2023 00:36:01 +0100, Linus Walleij wrote:
> Accept special node naming variants for Marvell switches with
> special node names as ABI.
> 
> This is maybe not the prettiest but it avoids special-casing
> the Marvell MV88E6xxx bindings by copying a lot of generic
> binding code down into that one binding just to special-case
> these unfixable nodes.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/net/ethernet-switch.yaml   | 23 +++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

