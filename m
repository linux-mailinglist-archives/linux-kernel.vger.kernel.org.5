Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673AC7A23AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjIOQhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbjIOQhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:37:38 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4922DE69;
        Fri, 15 Sep 2023 09:37:29 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1c26bb27feeso1353113fac.0;
        Fri, 15 Sep 2023 09:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694795848; x=1695400648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZS93HQjg+3yZppe9BDFA0lNQehCr7DbnGsXiOwc2hY=;
        b=XzuUR6ic1iTpnVyIqBe5Oug9uCU+VKzlS0itXz01AuNbO8UycyWVePNcpOURbFnrTW
         LdVGnWppV7s8bVlDqDZcqeZ7aBdRN5YOiniI9mud/Az38wRvu2m+E+C/l0Ttlvx8HaDk
         s4qZr5Z12UuFERNE2kMwnP9aY1qT+++zU4xDcyUGxtXurfX2IHusR689OONNltdde4ev
         FaADrnEnt7M3Y3DXyM0yyt4gdGUD+h8nHEQm4D1uGxe7i7DRoirbmN9ah1Nmcw+qmHXf
         lB25ffdqEQCYPFFnK3y4r0F8/jJKK0QKSXoNARD7cFkEuWGkdwO3q6k8twyi8070cufy
         hgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694795848; x=1695400648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZS93HQjg+3yZppe9BDFA0lNQehCr7DbnGsXiOwc2hY=;
        b=Qk+sM/6LAVmbOvKOP4Bjt4oGFU9cWIUMdk8RkbEYQFEYyAn6laZqGdghZoOEPCgzC+
         rbAH7ZBtxC3VH0j++3NXXVGvtGTEEKNON7/DLzxSYRGseRbIk6u1uUqYPSjx/1lkWmF3
         jKHHkHZHPwins1Qey4cYqtQrSsLuQDrRoK4utYqqNjJcgSPNVjs86Cokl0ONhHY95R0Y
         GA+Xpcf/UA+Wa+X+NavPSlMYGg9Cc1rppxO0pZnbixxP5GbX8WZCeUX9Dj5hwfFT4GAo
         ZIQ1g1t3Zy0eWsCGOL4AnWN/FNIATtF6sQi7edpU7OAA1B1UKxqBi878U56UgOU+1BMT
         NfxA==
X-Gm-Message-State: AOJu0YwvIjAZsUMPI/ciGr1K+9NQzzRgegG2rj5YxwCgOnxRkleQEGNX
        Q57EBLuuuc1BDsW7qc538Qw=
X-Google-Smtp-Source: AGHT+IHuOJ0zfEFx131vF1PsD/D04RTwXG8CpNkLfPL4TefJN92KzNNhUgykV3w/pGwZqA2koPXf7A==
X-Received: by 2002:a05:6870:e9a4:b0:1bf:8c9a:9a2c with SMTP id r36-20020a056870e9a400b001bf8c9a9a2cmr2238684oao.15.1694795848361;
        Fri, 15 Sep 2023 09:37:28 -0700 (PDT)
Received: from [10.67.51.148] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m10-20020ac866ca000000b004055d45e420sm1265339qtp.56.2023.09.15.09.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 09:37:27 -0700 (PDT)
Message-ID: <86f42ef5-096c-7eaf-9273-feea82947eef@gmail.com>
Date:   Fri, 15 Sep 2023 09:37:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 1/2] net: dsa: microchip: Move *_port_setup code
 to dsa_switch_ops::port_setup()
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
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Petr Machata <petrm@nvidia.com>,
        Lukasz Majewski <lukma@denx.de>
References: <20230914131145.23336-1-o.rempel@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230914131145.23336-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 06:11, Oleksij Rempel wrote:
> Right now, the *_port_setup code is in dsa_switch_ops::port_enable(),
> which is not the best place for it. This patch moves it to a more
> suitable place, dsa_switch_ops::port_setup(), to match the function's
> purpose and name.
> 
> This patch is a preparation for coming ACL support patch.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

