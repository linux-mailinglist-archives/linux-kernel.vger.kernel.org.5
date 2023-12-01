Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954E98016B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjLAWlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAWlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:41:06 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8170AD;
        Fri,  1 Dec 2023 14:41:12 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b8929269a0so785402b6e.1;
        Fri, 01 Dec 2023 14:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701470472; x=1702075272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HppQFlrOhl3DpBuO1vH2x7JNHeOPGUaD7VcYDrznbHA=;
        b=NpzgGHqBLa4rhwf3pIJlYKpT/UzcFSF4zjZNTAySmMD8jHy83hw4NXcTcXfD2nRcbC
         Cl4XSG5nilG538gqgQJkiBQd9t7q7teyZrtBPGL88Llt0AGI+00hW+WZnjDIL2TeqwER
         o1RpCObGgcNAbbS0i7HMg+WFREEe1AU+uUh57mVVbMWPzMGsBFwfCSJWC4t4c31gO9gK
         PQdNtP7Y+2v0xv+L+LOu6u55OegMHN7Tlctb5pwRaCeFaotFY63HDxLqupJUxbuwk+VQ
         lIZ1I7krCL/kDRaBK5UXv1ldbIO+iArjNfGZaU67ncy2peahrK0eXKRdMD4dVZuAC/dV
         cf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470472; x=1702075272;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HppQFlrOhl3DpBuO1vH2x7JNHeOPGUaD7VcYDrznbHA=;
        b=YP/Qg9AAkj6i2+p4Ddu7AEbplTx04aN64GnWBOyJcLw+WlupUQKCsSU8W2gtzx8Vv7
         3NrERNQIyzlLytPT1vM0ONiVAFSx1NOujwAU6V/jBgHPRdVIj41hh2VvfjRH0tup2yjF
         qoKjiRQtAJzitKysqLZ0HjqPvpU2m690K+94FZXmBZ5n2v6r8lmqWg5cjRlZty0U1J+m
         wH4+9JurLq23wrFtiNnplBQiyOsWbMlrjrP7CFwgWGwcS6MW0PzfOeAMzbnZesw2oBSQ
         QhuiEZbAoHWI0rWWwlK4x1UlaZI53A6WnyZE3IZZgLfB5/JHnfBp9dvt2vSvrNN1aIbm
         z+/g==
X-Gm-Message-State: AOJu0Yw4yA7br1nXz9jbkf2Eb/bmbHBAa0B3Z3QQYq6n1msEloKTuXBc
        WD4Ooi989K7G6Wz/X5bR8OU=
X-Google-Smtp-Source: AGHT+IHUOL8efQZ4MRUvrrftFGV9/JlRPQPOPPiIMIUEfpYOV6SvhxXGWaxD6FdpVtbfxmrjKFPZww==
X-Received: by 2002:a05:6358:2606:b0:16b:c43f:3da4 with SMTP id l6-20020a056358260600b0016bc43f3da4mr279561rwc.3.1701470471955;
        Fri, 01 Dec 2023 14:41:11 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id js3-20020a17090b148300b002809822545dsm3626410pjb.32.2023.12.01.14.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:41:11 -0800 (PST)
Message-ID: <ecbdcfb7-32ab-45cc-991a-982c52bf4b14@gmail.com>
Date:   Fri, 1 Dec 2023 14:41:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mdio: enable optional clock when registering a phy
 from devicetree
Content-Language: en-US
To:     Heiko Stuebner <heiko@sntech.de>, andrew@lunn.ch,
        hkallweit1@gmail.com
Cc:     linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, quentin.schulz@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20231201142453.324697-1-heiko@sntech.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231201142453.324697-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/23 06:24, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The ethernet-phy binding (now) specifys that phys can declare a clock
> supply. Phy driver itself will handle this when probing the phy-driver.
> 
> But there is a gap when trying to detect phys, because the mdio-bus needs
> to talk to the phy to get its phy-id. Using actual phy-ids in the dt like
>         compatible = "ethernet-phy-id0022.1640",
>                      "ethernet-phy-ieee802.3-c22";
> of course circumvents this, but in turn hard-codes the phy.

But it is the established practice for situations like those where you 
need specific resources to be available in order to identify the device 
you are trying to probe/register.

You can get away here with the clock API because it can operate on 
device_node, and you might be able with a bunch of other "resources" 
subsystems, but for instance with regulators, that won't work, we need a 
"struct device" which won't be created because that is exactly what we 
are trying to do.

Also this only works for OF, not for ACPI or other yet to come firmware 
interface.

Sorry but NACK.

I am sympathetic to the idea that if you have multiple boards and you 
may have multiple PHY vendors this may not really scale, but in 2023 you 
have boot loaders aware of the Device Tree which can do all sorts of 
live DTB patching to provide the kernel with a "perfect" view of the world.
-- 
Florian

