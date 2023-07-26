Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1989B764212
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGZWWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGZWWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:22:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BDF1BFF;
        Wed, 26 Jul 2023 15:22:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbd03cb7c1so2017515ad.3;
        Wed, 26 Jul 2023 15:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690410142; x=1691014942;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8AGk4Id4IfNgApVT6Qf0u2+a1oLhULyxKd2nOf0u9uw=;
        b=WxPJ9sxVnEPf3h4CN5hbcoU1Xry7Xzi3BxgGYELB0hpLshn9Vil3xsaKIzk8FzxQlz
         jqi+06yvZEKydnpUysL+XOypOtl9hY8wHKQ0YJPIpUYVJwisfBqyYTIdU9VrkjBBN6p5
         S7Gj0E6+jFuXEcXxdxgMa/ldwCRfzJva/Ti8reDc6qvm8aE5yVeDPvzy2thNXkssGBRY
         S297ktpwv/xVM4NuYWm3ewsUWsmZzKilmflUI6jqZJYc2l4vgqgr8MFMJKOKsaI6XjOo
         vSPZi/TjEFeiwt1Z4A2p8uLltX8o2oQkjXQYALs/OU2GeTtcJmt74oRsqaPTowRWaxoz
         Jg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690410142; x=1691014942;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8AGk4Id4IfNgApVT6Qf0u2+a1oLhULyxKd2nOf0u9uw=;
        b=l79Ul/ObdVET+EA/MkQrHLBvXtaSRou62VZ1nM3dz3sID5rcD7Vd7qnAEMJRIp5G5d
         zYlFjROzacX9T0eQQE6AJf9tQMR/LqA9bK8YcDNsBCCzkVpQjLxpBXwe+NKFrc6UQwRe
         l+UosilQOQT1GFEhn37ttLh5Y36rXrmD5K9cqjn/NjKYhm0UGLwcv7rm/O7BJMklsHQZ
         pjFbj1POSYKpt2/u/PQCnLk2cQWikG4DsoXzirTGAY60KfCxagL3JSct0B/8FcdjE4PT
         EQINf4mPkZdrIYMorh+Tomfq8KNXVJwMBj0iYBR2QBY/P/c//bo/Kzhf9tJDe4Y5KmfL
         5OEw==
X-Gm-Message-State: ABy/qLZWG+eiGX7xy1g1aj88ozcHqvmvPSx1u2k4IDsQ0yeLYCn+pnlJ
        khGgokcQzXkggmrk3R8jTsA=
X-Google-Smtp-Source: APBJJlEnir9n4wiRFr0tu0Le+NXw1whoHI2qgxVO5HrC3k27Jti5Ec9vzwf2mAFsyt3Gu4+v76UfNQ==
X-Received: by 2002:a17:902:ea01:b0:1b7:fef7:d578 with SMTP id s1-20020a170902ea0100b001b7fef7d578mr3365754plg.41.1690410142398;
        Wed, 26 Jul 2023 15:22:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h14-20020a170902f7ce00b001ae0152d280sm42139plw.193.2023.07.26.15.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 15:22:21 -0700 (PDT)
Message-ID: <48dad8c9-c61c-8d08-de57-a1255dfa8228@gmail.com>
Date:   Wed, 26 Jul 2023 15:22:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [net-next PATCH 2/3] net: dsa: qca8k: make learning configurable
 and keep off if standalone
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-2-ansuelsmth@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230724033058.16795-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/23 20:30, Christian Marangi wrote:
> Address learning should initially be turned off by the driver for port
> operation in standalone mode, then the DSA core handles changes to it
> via ds->ops->port_bridge_flags().
> 
> Currently this is not the case for qca8k where learning is enabled
> unconditionally in qca8k_setup for every user port.
> 
> Handle ports configured in standalone mode by making the learning
> configurable and not enabling it by default.
> 
> Implement .port_pre_bridge_flags and .port_bridge_flags dsa ops to
> enable learning for bridge that request it and tweak
> .port_stp_state_set to correctly disable learning when port is
> configured in standalone mode.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

With the feedback from Vladimir being addressed:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

