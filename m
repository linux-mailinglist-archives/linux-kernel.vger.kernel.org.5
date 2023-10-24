Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459B97D587D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbjJXQew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343853AbjJXQeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:34:50 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C48AF;
        Tue, 24 Oct 2023 09:34:48 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41cc776ccb4so30547241cf.1;
        Tue, 24 Oct 2023 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698165287; x=1698770087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxClnLtytb8/MqBwGt1ecf9l9O9+RMotMvVBbqDYLVk=;
        b=Z4HXpvlt/vqEk4qrzr5qUiaUJQXX6vr6vA4bj61WC57uq2m691YeIoUzzc077RwNqn
         vTu5Gd0uCSHN+SeC91PIDeVlFO43ZXIV5m68hNZ+rEc81OsOzSxOn3AJKoYpIIZJorqL
         TFR5vT9F67+txAoBYgua/De8XLhRjmi5hM4p3iBRIpl1LdoxFBabM4SXYpOhYzFp1QQ4
         G/5QndlZW87WEYZZfqzOHFFih53nbvd0OAUJEIHCtpPVmje+CBuLBVRLwnJ7SulBJ3y0
         ppPUauXBOl+MLZXNGNMeh6whTCjcc0Vqh7IDH9ScQ7FullqXuM8Htp9/TwCRy2hlO9QU
         WCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698165287; x=1698770087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxClnLtytb8/MqBwGt1ecf9l9O9+RMotMvVBbqDYLVk=;
        b=L0auW9WlUDn42bUvvU3S1/n29r1eCZ9i1zWUc1KHIBdOshgxodRRcGZSbkZoDRx+P4
         JfmyaKSnWmpnSU/KtNmRU5Bb2W7/42q9WU1Q8lvlZnJQ+A9neC6HvjtGQIGwJ4PftH0j
         g/tmuZYn4fwwjWky8MVs9JZFNlFEKgV/EKXH+S5HUWQVlYs5s4Eh54V58mhFfXR0FezY
         IZA6AxVDWhSPPfg9+YoRKnB2W3O/DuvUem2clgUNnGEynM+iI0VRk8dpEURLQFHLcpRn
         flGXvQYNCzqO0RJSRyqkxwRVgtRtvS7EqWYOElTEkys9yezcn0oN5G8spiKOJniLlAbj
         013w==
X-Gm-Message-State: AOJu0YwpA3k/AzGo0HRm2WyPYVymhotxHu2dUi5YzNV3DyVJf6ZiU8TN
        aTYKDT8Hfjo7LFX7ksRPkSI=
X-Google-Smtp-Source: AGHT+IHKYZqbBrPYHli1D1qsB6UUfOarb2uGevVzcLCfBkSiM5ZUkDbFq/5Fa6SNfrB98F7eoZlFjA==
X-Received: by 2002:ac8:5e50:0:b0:418:1817:43a9 with SMTP id i16-20020ac85e50000000b00418181743a9mr14200224qtx.17.1698165287424;
        Tue, 24 Oct 2023 09:34:47 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h21-20020ac87455000000b00419b094537esm3590812qtr.59.2023.10.24.09.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 09:34:46 -0700 (PDT)
Message-ID: <4df5ef7e-d3dd-45a7-8edb-182784167243@gmail.com>
Date:   Tue, 24 Oct 2023 09:34:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/7] dt-bindings: net: mvusb: Fix up DSA
 example
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Rob Herring <robh@kernel.org>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-2-2869347697d1@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v7-2-2869347697d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 06:20, Linus Walleij wrote:
> When adding a proper schema for the Marvell mx88e6xxx switch,
> the scripts start complaining about this embedded example:
> 
>    dtschema/dtc warnings/errors:
>    net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells'
>    is a required property
>    from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
>    net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells'
>    is a required property
>    from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
> 
> Fix this up by extending the example with those properties in
> the ports node.
> 
> While we are at it, rename "ports" to "ethernet-ports" and rename
> "switch" to "ethernet-switch" as this is recommended practice.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

