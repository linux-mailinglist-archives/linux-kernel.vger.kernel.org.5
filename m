Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B8A7D587B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbjJXQeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343998AbjJXQeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:34:12 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D4E10D5;
        Tue, 24 Oct 2023 09:34:09 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-779f2718accso29025585a.1;
        Tue, 24 Oct 2023 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698165248; x=1698770048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxlGF2huoBf3gQegLGUHLrMjlaXDURjhRNvYADg8LmE=;
        b=lZTRAspKjdwRxLc/oVqNLvu7WgUKp06fseGeuhQMTeegc1y1udsm9uOSSFyYg7lGEo
         jNQpdOz1YUgKdsteB8MoCvdepcqg/eC2BXv2mE+vNTgJia2oQF7Dl0L/pzxB+UiKBXYp
         R+rIet+eg81PYcJm+AAE6nGFxHEjCLslZd7PUwQZyqr52mWvwunMbH+nmphNNZSjbATE
         BC2P0OFoMYvaZAOvjfSeU13ObFl8Mh8AKe7WcAM+aW+CXQT1Ia+wi5tyYjxQvDFPVus2
         I7O8HKLEGk8L/ghBceD2ufiBPb9mCl0SCwp7C3wYat89RADLutoqbB5UeIy9CK/k6tBq
         ecqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698165248; x=1698770048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxlGF2huoBf3gQegLGUHLrMjlaXDURjhRNvYADg8LmE=;
        b=EuVylJMVAcUduTfkavJoc/rCsDy4vL0bzBXa/VNdz/9b24EJmS0CK/j4VYBLRzL5aN
         TSz9qPAwLs8ut4oEOzxlkaBk27tGHW04AN5uL8mwDxrK4LoRIDQGa14rVrkOGsQnfYwe
         fHucD3DlqHyNulAJBPe4XdIV9D0/09kNes4Ja3QV3j88K18OzBjQQAnrQYeN2SgELGvj
         HRnDwg4h3WkQBJLqqRFK//v+SvtI91v3oaMblMLxkREqYkDitWWsQly2W2GCwyti5GAZ
         L2NeVAgWGGflcmEiDzl8NLodECpGNjeMANP2P3/92vTXwlqdRacTlUG1DDG3TGSxH1Da
         JCiA==
X-Gm-Message-State: AOJu0Yxej7O3C5/369zKdHXFszTzNBBA8ZaqpWNv0KEYHy9yw2UQSEcl
        7Jo+vIfbB4yoJUmko/8CYhQ=
X-Google-Smtp-Source: AGHT+IHg2hQOyHtXeTUA7PVDYJ0xqDkt8W6ms2wylLaxLKy0rZaAjlYf2EDHPdQicvzSqZgO826bvw==
X-Received: by 2002:a05:620a:25c6:b0:774:193c:94bd with SMTP id y6-20020a05620a25c600b00774193c94bdmr14838663qko.4.1698165248609;
        Tue, 24 Oct 2023 09:34:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h21-20020ac87455000000b00419b094537esm3590812qtr.59.2023.10.24.09.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 09:34:06 -0700 (PDT)
Message-ID: <d5871a55-a699-470c-a41d-ff457699d9c0@gmail.com>
Date:   Tue, 24 Oct 2023 09:34:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
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
        Rob Herring <robh@kernel.org>
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-1-2869347697d1@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v7-1-2869347697d1@linaro.org>
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
> Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> a DSA switch node need to have a ports or ethernet-ports
> subnode, and that is actually required, so add requirements
> using oneOf.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

