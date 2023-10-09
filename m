Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF467BEC89
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378697AbjJIVOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378666AbjJIVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB98C118;
        Mon,  9 Oct 2023 14:14:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-692eed30152so3650575b3a.1;
        Mon, 09 Oct 2023 14:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696886064; x=1697490864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TcXX7RVBze6PtaEVGPwxBuREbw4pOeYlpdgmI3+Ezos=;
        b=C+jT9QNgXaA3vr3Kt9HKSzgl/vt/Zq46roaYXA7rr2dAdhb5ls9TQlNHWlDAmdkr+Z
         QGCnyMFfgVUhmjTIlaFGblmugXmIe/MoWICxh7OqYSyKEen8WTjoA6jHMha1CDODpppR
         j+Mw/5oZojgR2rcsfyQEORxlnWtDcjBBTLXNpExGbGlkyPFWR1/Av3cAq2NiLB2xcCZO
         0F1ERwVVvCFoUJHFgfXISqnIPckUiJTGExstjNPdvbVcYfdNZVgidPfdqKGGFGrLna3T
         IFj3X0efowAwcw2LR5VvWamkutKANhFtDrE3VRh0/8ZNzoagXhem8zwGSvzyzxZ1eyoz
         4C1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696886064; x=1697490864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcXX7RVBze6PtaEVGPwxBuREbw4pOeYlpdgmI3+Ezos=;
        b=Q78R10VETzgf4PwuCpiCYrsk7LjZtXUyYvsQGp/zkrAyysRcUrOC8HUfsePEguVMQ6
         x9cqmoQkADlCWIlFozL4b+MkGLaE2z7Uj7YYlQ+xWQQgV0yGJZ6v3DlDV4nIXKlhQULH
         WWcEo9aSIPKAnbYtyzB3konKtmaC4beCUM/OErtAEZOgiRBF4EF5xSYMnX+3ut/XzK+Y
         lRmeqKtLouw1erJOkMaQUOa0yGEUUregkHVjHfCDA5q7RtMhhdMpwzGDWRlNVs3Hujap
         An6V2SLJpRml3vwGiQBM0M9tSZyXix+JBxmBeaZI6rKi8nv1Ra2KhU34fMuN0N/7R/zf
         0AnA==
X-Gm-Message-State: AOJu0YypeJ5myUE95H8h9XN+V+uF01iGXaAGpWp/3Fjf3r3yxVcWS7lX
        ZoGWABfsdzsObswQY7yU0T4=
X-Google-Smtp-Source: AGHT+IE7FLCoSoMsHQNQ/0WOOgZ6ZheIOjBVYKDJAopjQ13e0Y75eg4ZPgE3eYlX9lADV80hdM3jRQ==
X-Received: by 2002:a05:6a00:2e89:b0:693:3851:bd98 with SMTP id fd9-20020a056a002e8900b006933851bd98mr16553359pfb.2.1696886064624;
        Mon, 09 Oct 2023 14:14:24 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x2-20020a62fb02000000b006889348ba6esm6826794pfm.127.2023.10.09.14.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:14:23 -0700 (PDT)
Message-ID: <1aac2644-af91-4408-b84a-0c92f1202f7c@gmail.com>
Date:   Mon, 9 Oct 2023 14:14:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 07/16] net: phy: micrel: fix ts_info value in
 case of no phc
Content-Language: en-US
To:     =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-8-kory.maincent@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009155138.86458-8-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 08:51, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> In case of no phc we should not return SOFTWARE TIMESTAMPING flags as we do
> not know the netdev supports of timestamping.

There seems to be a word missing, maybe:

as we do not know whether the netdev supports timestamping.

> Remove it from the lan8841_ts_info and simply return 0.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> This patch is not tested but it seems consistent to me.

This does look correct to me as well.
-- 
Florian

