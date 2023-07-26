Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCC976420F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjGZWVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjGZWVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:21:10 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB04271B;
        Wed, 26 Jul 2023 15:21:08 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-63cffc0f95eso1948146d6.3;
        Wed, 26 Jul 2023 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690410067; x=1691014867;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLphgLPxx18Z+da2pq6fNC6aZUO3yfqx0BJTZMqI46U=;
        b=VTMH5nVeRu+Q6yngBno6DebQJbhO2Br4VZJu2HddfHiXx4xrFSdcXzagw0WLlyakDy
         DKJavGOtannOhzv5U+YMRAVidt/2DNXSZRBliXN0TOw/G0o/vSPhZXqD5/VhXtfzLx8l
         pjz3RzWVar5MECuLZ+DniAcllojDo6wpEBzh2HVhP2CGOn4sdoOFmD9h72gI8bpTsNpP
         zdulllnTkBDkGmlTZHPxWFJwnpD9DIQkv9wtjuDNeCU7HGCBFopGKrJyNI2pbeWe8moB
         B0ixVhmLByFmO2e/yukxceoqXe2DkOJXwylSASsSIf5TTN9vfd/UI+2xxYhU6SKLROsx
         L25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690410067; x=1691014867;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLphgLPxx18Z+da2pq6fNC6aZUO3yfqx0BJTZMqI46U=;
        b=Gj7s6YK38ytT+FdHmKv/JtoL57DuFAfJiuFCu7UCbSScqI9Dx6jUKS4aeriNOVYyX9
         aZ61qi4WLv30WOs7u4UHkcOkp93MgJZARAVkHW/LIx8In6CUE7/MwOKvcHXLEVyEtZHO
         Xh386jEuYURsPM1T9dV2As+IZYSNIrtiGweYbSNWVJU3t0KoSL3gDkw4GYmGcdFvem7Z
         rXlDeJ14dpxGgoyNdmTJf3vIJmKKPMKuxMBgbuIszWLGutZt/GGzbrFnne5V3N56D0cj
         85snlVgiZ4tUh3rDTf4Q3XKD6l62RXFICeQtZK/pDinL+PrDXEBHHAZUmNEw+TX0XDfj
         4RkQ==
X-Gm-Message-State: ABy/qLYgWMMpKwSQZRJS074dj6k3kXbjpRYf6OyVwvzva+niZrKpI030
        SzUj6DqS339Z0bUQjjgWpdM=
X-Google-Smtp-Source: APBJJlGPdtDJZAGX+A+wp1Yy6KmWwx2hICG6iatQT2RIsWPD37mAoQLc33kfyEysVpaLo+JhGuiSpA==
X-Received: by 2002:a0c:9792:0:b0:62d:f8e7:3043 with SMTP id l18-20020a0c9792000000b0062df8e73043mr3291981qvd.18.1690410067614;
        Wed, 26 Jul 2023 15:21:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id dc8-20020a05620a520800b00767c76b2c38sm4639604qkb.83.2023.07.26.15.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 15:21:06 -0700 (PDT)
Message-ID: <2e147dcd-03ac-44d3-2781-c95c528994be@gmail.com>
Date:   Wed, 26 Jul 2023 15:21:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [net-next PATCH 3/3] net: dsa: qca8k: limit user ports access to
 the first CPU port on setup
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
 <20230724033058.16795-3-ansuelsmth@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230724033058.16795-3-ansuelsmth@gmail.com>
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
> In preparation for multi-CPU support, set CPU port LOOKUP MEMBER outside
> the port loop and setup the LOOKUP MEMBER mask for user ports only to
> the first CPU port.
> 
> This is to handle flooding condition where every CPU port is set as
> target and prevent packet duplication for unknown frames from user ports.
> 
> Secondary CPU port LOOKUP MEMBER mask will be setup later when
> port_change_master will be implemented.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

