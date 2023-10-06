Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD27BBDAC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjJFRZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjJFRY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:24:58 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51069BF;
        Fri,  6 Oct 2023 10:24:57 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4181f8d82b9so14604051cf.0;
        Fri, 06 Oct 2023 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696613096; x=1697217896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rx67H5KTarmXEYEDYl/whfWf5psnvMF6kQlD25eZvhI=;
        b=gw6J0qq4D+G1D6PNZVVcQlbce3xcoeOlzDO7oYzwuo+R5LNlF01fPOPWAUENZgaHtP
         6Cxp0KLSBaPApyAXUbgKqW/167TybyIZrjnLIFiCKcSGtmYOLmqfI43EV22tUPA2p/rH
         KalymaM4fOg7YNyOw+ILfXe2FLV/3aWRXg78l8ppxPV81tq3jJSI7x8tw+K/oZaMdGJv
         KJ+VXkAA79NeIOERWV7s7c8J7fmmoS6a5VuFgMTqmePkB1kT3GY3FgVsaT0TQhbVTBdV
         pl7Bpcynf3a49SFk4Dx1EYJB1iv+GbGWnvzQmBgSZy7XQFLLdyVexfVhoCmPJeaQq06u
         qBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696613096; x=1697217896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx67H5KTarmXEYEDYl/whfWf5psnvMF6kQlD25eZvhI=;
        b=vqTpVedAvsONhVMTf5mX+DKMl3H4MbcIYtHfUSvyw6rTFoJ+O/35E1bkU6bdnR2qQp
         2+ClYuTjOOR9+5YoH537WV0JVAt+P+w9zeYmUyPzUAQFpolwl8YufIZPTNs+eNa2BX8g
         +YG6Emz3kkIMpgwRqRjjTvXnnwWZ69iKm7+IaseW1Yy5R/30gaqT4e0jv+bTHDzbJZw/
         dA4e/JPNSvjJdEAadDMCCcE6IM7/vtZT4dYTjura08UxqzrSOOODhLPesB2a8Yv4mbRf
         bw7aLG95veYm15sXzjHAOgLZy3R/fujYW0OwDXtvV8xHw95Z2Aqp1oQZi2TcP6ny6J5Z
         arMw==
X-Gm-Message-State: AOJu0YymZeC0WkGKRv7vDL7i7cJNDOEDeD50LhdHjkNJzkqjA6l4pRBA
        iVYeKitSZ/F28z5jY2o/2AM=
X-Google-Smtp-Source: AGHT+IHwLs/v/pRUwENWm8kO3YiMtI8D7kqXA1W9FqIZdOyxIwFxNccblqEM07hLTqCH+jojBnOs9Q==
X-Received: by 2002:a05:622a:a:b0:417:a2f9:bba6 with SMTP id x10-20020a05622a000a00b00417a2f9bba6mr9349030qtw.60.1696613096350;
        Fri, 06 Oct 2023 10:24:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fj19-20020a05622a551300b0041abcc69050sm1145292qtb.95.2023.10.06.10.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 10:24:55 -0700 (PDT)
Message-ID: <2818465e-e60e-4d6c-a7e3-828c28d8ab59@gmail.com>
Date:   Fri, 6 Oct 2023 10:24:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] net: dsa: microchip: Fix uninitialized
 var in ksz9477_acl_move_entries()
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
Cc:     Dan Carpenter <dan.carpenter@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Petr Machata <petrm@nvidia.com>,
        Lukasz Majewski <lukma@denx.de>
References: <20231006115822.144152-1-o.rempel@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231006115822.144152-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/23 04:58, Oleksij Rempel wrote:
> Address an issue in ksz9477_acl_move_entries() where, in the scenario
> (src_idx == dst_idx), ksz9477_validate_and_get_src_count() returns 0,
> leading to usage of uninitialized src_count and dst_count variables,
> which causes undesired behavior as it attempts to move ACL entries
> around.
> 
> Fixes: 002841be134e ("net: dsa: microchip: Add partial ACL support for ksz9477 switches")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

