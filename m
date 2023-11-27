Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6B77FA8D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjK0STn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjK0STm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:19:42 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DE019D;
        Mon, 27 Nov 2023 10:19:49 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67a295e40baso12196006d6.1;
        Mon, 27 Nov 2023 10:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701109188; x=1701713988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7WJp6iD74Env4N8QVbO7CqEc0RfCxzm8B7uJPfFeco=;
        b=PsewsnITFf9+OXk3fJUtLb+ql+gmCUFrWxBV6t6195F6eORipkmKC1TCgU3yCPaO5a
         m18H+vKH3qGc2L1qiFmfJBYXiV5rHnju1I0pQku3iAsRtoUvErjWWdbWCFAXl12Njx+y
         xWpxMxVE6Bc9vYGTSiXFe9zyYcjdaJbxPu57Kl5ylkxTnAb9LwyFyVUbYTQM7cEJyEqR
         FtL8E1RswiWOWTcNVmtuxndHGtWpMVBjqFBiY6I0z3lsXzc2GtKIyUkoToR7ZB7V1UWW
         BrpBths8qib4Qxs9KdCCwE/cDYCU2f8Ymkw2goHqzvEAp48+pxFcosUoXpVePk2TiBfY
         Jr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109188; x=1701713988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7WJp6iD74Env4N8QVbO7CqEc0RfCxzm8B7uJPfFeco=;
        b=Jg0y/+GTMIyLCKuN+qSF6nZTZSEXgfbxSvB1mQJYCP6U4OQvdZRe1EvwpbV3YVRiMt
         uwG8PDTmPD05YK9QaT7owA/HxVCM2v5rikCksZqK2oU/aoGjQgbrQJWYdb3WjeibFq0m
         yw6Blb5j+9+wKHg90JXGOEPUy6IP2ZDFXGpwa/5ONWdEgzJC/M8Chm2NDTE26Whpi81h
         GGEFb/+UmKU3zLKIGQiO8P0iAqawRhI2wKf8tvYGOCDlPyKJQ6ozijB2YHvP8rEdOaZd
         B5X8h4ilzxcdi9hDFsng10mBdY51ozi6EeIKrTSaFSK0jD7R1nbRxQ65ucGGvjkAaJOA
         CybA==
X-Gm-Message-State: AOJu0YxWBzYFJR/fxUeBnX8H1JI5COkjk4cLerkT7OaAeBFaJgekM/4m
        gEGk5HUTLkqxNKomhstH6YU=
X-Google-Smtp-Source: AGHT+IEV7YFZeWUA96Js+BprC85P1JqgklNFECUWqgPRwek9NoWnMBcxLyfBpQt7lfmnDxQCOxeolg==
X-Received: by 2002:a05:6214:aab:b0:67a:2261:4e3d with SMTP id ew11-20020a0562140aab00b0067a22614e3dmr9480521qvb.19.1701109188118;
        Mon, 27 Nov 2023 10:19:48 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ee5-20020a0562140a4500b0067a22a8564fsm2872202qvb.140.2023.11.27.10.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 10:19:47 -0800 (PST)
Message-ID: <62879af6-8555-48bc-944d-2f475139f94f@gmail.com>
Date:   Mon, 27 Nov 2023 10:19:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/3] net: dsa: microchip: make
 phylink_mac_link_up() not optional
Content-Language: en-US
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <20231127145101.3039399-1-o.rempel@pengutronix.de>
 <20231127145101.3039399-4-o.rempel@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231127145101.3039399-4-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 06:51, Oleksij Rempel wrote:
> Last part of the driver do now support phylink_mac_link_up(). So, make it
> not optional.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

