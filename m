Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF7180115E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378702AbjLARDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378624AbjLARDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:03:14 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F69F3;
        Fri,  1 Dec 2023 09:03:21 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cdcef787ffso2353840b3a.0;
        Fri, 01 Dec 2023 09:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701450201; x=1702055001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNWn1kdO8blUyQYsaUuU441May+eNH4MGJiwzkp6ycg=;
        b=XyF4sQnf27IlxfPHxB7EfEGGAhlGQBachWONmEClvqy2PRde1vZrM07J5OmNXVNpcx
         8aDXs5l6+iwNm3cmGAumNrKPCCUR5MMlpxj9mfpvzgZn0AuBW+Qn+i0KB8iLHg4ppOup
         +4xgsRQPYLYt8zdErxY6iDGdAPkZhev7Sts3dcRKhDaCgTeToVIOlZ9/Z3JFNZj04FFi
         tNtO3frJh0z054nc1LpLoZjn+UeNtN1tL7VfRiYMO3QzwK8XYQV4SuyHbp5Fy8let2lU
         eWCDjMTSfttEVW8uJZw8ZCjIAgGPQUO6DHlMWeK5W+J2jHp/dZnzs9yc6Ri4S1L0uDCW
         hf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701450201; x=1702055001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNWn1kdO8blUyQYsaUuU441May+eNH4MGJiwzkp6ycg=;
        b=RCJgaNIhNYx/I13ksGwwW8xHbSNx7NfaAyDCLgVPxLuXEvf0CsvH3wZulKR0RYPN5f
         PHHJoIovZ7hoJm7YF3ah6YC6hnTBkQchJM+DS2Tws2ghkCViWC+WTCrufeJu3KXjP9/Y
         QYMf7LpTbWliG3nBmdLfHRYP2Vk+IYI/Nkp8wYtTfF7mlYu1A/rI4VSI0ZQ8Y7KQdHtE
         qns6nLDkMPBXnXYiaMliMi5+v00pIF2he7+JFbYNtB3s5iUH7MnP4cBX0BWck6HN4q+G
         7mB8u4HKwo73Kw/WbnLL5cdMgogZ+vHpXRmOcyalPyNcPeXrnnkOGy7y3yqnboIk9LXI
         XG0A==
X-Gm-Message-State: AOJu0YyKGhiUGbZsFJrtUHpysFwzgbYdZ69xUIAQyIOIeq3ivo8Y3Ay0
        puc/1ewrhtK3IFLO7hrODLw=
X-Google-Smtp-Source: AGHT+IGOFtaHoKo25pNZCUcukn0B+nCZPW8yNEXEsoJiDnOrjXmO7oZXnTTp8W69Zu32Vsx754Q6aQ==
X-Received: by 2002:a05:6a00:2e1c:b0:6c6:b5ae:15a4 with SMTP id fc28-20020a056a002e1c00b006c6b5ae15a4mr34841765pfb.20.1701450200769;
        Fri, 01 Dec 2023 09:03:20 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r14-20020aa79ece000000b006c9c0705b5csm3232908pfq.48.2023.12.01.09.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 09:03:20 -0800 (PST)
Message-ID: <36c32191-8cde-4a95-baf4-311b663fe275@gmail.com>
Date:   Fri, 1 Dec 2023 09:03:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: phy: micrel: use devm_clk_get_optional_enabled
 for the rmii-ref clock
Content-Language: en-US
To:     Heiko Stuebner <heiko@sntech.de>, andrew@lunn.ch,
        hkallweit1@gmail.com
Cc:     linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, quentin.schulz@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20231201150131.326766-1-heiko@sntech.de>
 <20231201150131.326766-2-heiko@sntech.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231201150131.326766-2-heiko@sntech.de>
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

On 12/1/23 07:01, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> While the external clock input will most likely be enabled, it's not
> guaranteed and clk_get_rate in some suppliers will even just return
> valid results when the clock is running.
> 
> So use devm_clk_get_optional_enabled to retrieve and enable the clock
> in one go.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

