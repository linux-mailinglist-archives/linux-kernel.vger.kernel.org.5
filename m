Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF52F7BEC58
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378212AbjJIVIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377975AbjJIVIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:08:38 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E4592;
        Mon,  9 Oct 2023 14:08:36 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-49a99c43624so1748859e0c.2;
        Mon, 09 Oct 2023 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696885715; x=1697490515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUMJhM4RNaXfPkvZq6yA9TmBEqaoOVreSkZ7enRNpTE=;
        b=I2CBSfQDUTF+ERw0z7ag3a9LnqSjQOqnGy4feUhG+3AJI2TIWFFLDPKJyWY+KNVAQN
         sMZAvRMSS3jtYWUC5F11jDyj8DFyeBR6NB4b1aw8SfedRpE0G4UxoKQH1H6IfWNmEWH2
         Cv6k/LN8jDSPNUiHspxeR+Uzy8Yl5OTJQvnjGHnSxdhjW+YzDcGExqSrfnIRoc5hO8Of
         RGLZEZSDKrqqUmpPTatRiR3PQ0OgLZBXWDCrZNtZTo2mva+OxENg+UKEmngjBknYoOKA
         CG/idjA5OU/oFAzgwSHXW9IlGs44HP6xS4ftWW/wZ4G/15BNyfU26+goeSxBrrec7rJk
         mTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885715; x=1697490515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUMJhM4RNaXfPkvZq6yA9TmBEqaoOVreSkZ7enRNpTE=;
        b=CKpxeijz7KIq0735sQnFRgcWLJyn2eeWagmcTZhoK2ksbp5h4Oa4Koq3doSaf54kEM
         0j9Gd5dxzpBzjx2V7EwPalj/LAEqEZyfZUwBjyUVEbHN275aaccPI3QX6cK0VknzNc9O
         RjXirLqyjr2REDUbj3Dp/D5jV91eF8CIKc7C8CLOk53S0PdQ8UCuAu4hX4vcug3BKqYE
         2iNIwUGuiuhq298mZA797ZJ60+6TkW/RjFQNW3czgBIkdTcZHAixaA7lwaKdCQR6G7K2
         RxTSJp+MZMqBJ4xA7heqplAAM6kaCclS+RUjxxvgYMCc3VnLM8gfFc/cQ03/OYaytWIJ
         1CnQ==
X-Gm-Message-State: AOJu0YzywAmjMMvXOYEHVa0rWDbCgvYD9z7AACwx3f52S3kTlytqIcyZ
        7kToOOrK987yxCtF83TF830=
X-Google-Smtp-Source: AGHT+IH9NzacCFlYc2vSCsNGPWVwZUUarTYUyTpeXhV6VdGDCR5lAXn4XVW3hc4UFxvGLpGpgnDC9g==
X-Received: by 2002:a1f:a9c9:0:b0:49e:1eca:f847 with SMTP id s192-20020a1fa9c9000000b0049e1ecaf847mr4917635vke.15.1696885715423;
        Mon, 09 Oct 2023 14:08:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k24-20020ac84758000000b004199f47ccdbsm3956048qtp.51.2023.10.09.14.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:08:34 -0700 (PDT)
Message-ID: <3bc41449-1e95-446b-b590-c39429b9671b@gmail.com>
Date:   Mon, 9 Oct 2023 14:08:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 04/16] net: macb: Convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
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
 <20231009155138.86458-5-kory.maincent@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009155138.86458-5-kory.maincent@bootlin.com>
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
> The hardware timestamping through ndo_eth_ioctl() is going away.
> Convert the macb driver to the new API before that can be removed.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

