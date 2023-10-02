Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861EE7B5B18
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbjJBTQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJBTQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:16:20 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4DDB3;
        Mon,  2 Oct 2023 12:16:17 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-4527d65354bso88163137.0;
        Mon, 02 Oct 2023 12:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696274176; x=1696878976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Tr1XYfZFQPwOIGZkao0xDKBVDpd/yFY9b0CTr+HCmI=;
        b=fG8Lk0qhIQ9sgBk798MAYtZLMMNfcPDOVCC0CpCe7i3XpsRF7tEScj/ldnV79b91Rj
         Ip41w2YhjKbY9PykpLqYXhDQzE1vOBiWpqyMQTOzhYL3apgFZW1zRoYokZKpG3oWC+E6
         v24X0nLYLJkK6CsDBH/C/VBI/epdehsas0OrFS7uoSXpoRyiUPJt9rqt1iXOz/byznKm
         6Kgj9PjFKAOguAINhI/d/6kkMEQg3jV/j3YrKVgSAFM6srkuPxUI8IRAvmk2bEdthyJo
         qOTLFJE/6/jUAwyisNI9UCnwcbdFuRc9ru1qk4wz6TTNdBcVggNz26eKJiA+vhpvrucg
         1/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696274176; x=1696878976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Tr1XYfZFQPwOIGZkao0xDKBVDpd/yFY9b0CTr+HCmI=;
        b=tpzlZQbbKX5mC9ZKRMyJViyEGcxsLl2iEu+QmxOWtJjtyUktDjcukGskb4KDa/NLsp
         sIDymMG0dox1SeNVoU43FQlBeVJpi9L/xnyFp4onRrd49a7FTyleSuVtZqMNdOmeP/6b
         0Jk/9ukyfZ9veAzdPnZW8OiEm64avcO10e7Buu35DSsvS8AYLw4FH4ubE70+uFbOR7H5
         Pxdxsv0+gBscC9azb6dQgMOd5bjP6a0/anVrU6lnznrm6zhuCsUSMES+hg0FvPipQN+f
         vVBHnArTuH39F8AeoRDPa2MjNjtpXghoVi0m7zaoYzBOpq0+J1FZxuWDp3X9gmfmSwUM
         kk/w==
X-Gm-Message-State: AOJu0YyDpN1+/TDOtTAwAJbuzL8xonWvdm2JTpe0G8cA2gqHZnFAzNrg
        +CF5LuuP7EvpbV1IfwzsgKU=
X-Google-Smtp-Source: AGHT+IFv1LL4hAxRrpJUw0BnAkrSJG1KrOzUpd35rSgjuWaSyLrINoESA3s18Z8/hb4VtPYwVgEJ0g==
X-Received: by 2002:a05:6102:1cb:b0:454:6ccc:ab79 with SMTP id s11-20020a05610201cb00b004546cccab79mr10882242vsq.11.1696274176341;
        Mon, 02 Oct 2023 12:16:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o20-20020a0cf4d4000000b00656329bb3b1sm7686722qvm.10.2023.10.02.12.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 12:16:15 -0700 (PDT)
Message-ID: <4351a85a-ab53-acf8-9e80-e65b2ebfab66@gmail.com>
Date:   Mon, 2 Oct 2023 12:16:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 net-next 01/15] phy: introduce phy_get_status() and
 use it to report CDR lock
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
 <20230923134904.3627402-2-vladimir.oltean@nxp.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230923134904.3627402-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/23 06:48, Vladimir Oltean wrote:
> Some modules, like the MTIP AN/LT block used as a copper backplane PHY
> driver, need this extra information from the SerDes PHY as another
> source of "link up" information.
> 
> Namely, the 25GBase-R PCS does not have a MDIO_CTRL1_LPOWER bit
> implemented in its MDIO_MMD_PCS:MDIO_CTRL1 register. That bit is
> typically set from phy_suspend() or phylink_pcs_disable() implementations,
> and that is supposed to cause a link drop event on the link partner.
> But here it does not happen.
> 
> By implementing the networking phylink_pcs_disable() as phy_power_off(),
> we are able to actually power down the lane in a way that is visible to
> the remote end. Where it is visible is the CDR lock, so we introduce
> PHY_STATUS_TYPE_CDR_LOCK as an extra link indication, we are able to
> detect that condition and signal it to upper layers of the network
> stack.
> 
> A more high-level and generic phy_get_status() operation was chosen
> instead of the more specific phy_get_cdr_lock() alternative, because I
> saw this as being more in the spirit of the generic PHY API.
> Also, phy_get_status() is more extensible and reusable for other
> purposes as well.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

