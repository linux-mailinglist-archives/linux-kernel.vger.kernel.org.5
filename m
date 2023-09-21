Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56227A9D98
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjIUTmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjIUTlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:41:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9386FEBB;
        Thu, 21 Sep 2023 10:51:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c465d59719so10307235ad.1;
        Thu, 21 Sep 2023 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695318670; x=1695923470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6FcigXJsdBYuopdJxzqdyc5vjBqucHksGMym4CYbwI=;
        b=a1GX0xFkvD7Ue+OmUisIE3vullsQjvAlFvpqDp2QLpt8OpnlNWoGqsMOAcCMgKI+Qv
         BMQeL5sa6BD8fmFnzozFd9wdoPjhjSvTxkEJeZjL8IZ22tEsBZSA6AL3NekeJF7h8ml8
         zouEUAro3eZRtlQr/RS1M6ySR4Ahf7dIW3vgldcSOc9MdKBPgUcMPB3gMJK05cuu8Jw1
         AhQj3HSGfGQa359IQNnfN4YxpsuFIrfRusIlgAhb3IhcddLM/8V5oGjlagWX1GPZD8eJ
         crHuUWJlKTt/cXk4sFa1LZ+saCEXtrGUC0XFnkiAMNU6sO9BDIL5F+hvTO0eCE/jebSN
         V/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318670; x=1695923470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6FcigXJsdBYuopdJxzqdyc5vjBqucHksGMym4CYbwI=;
        b=daizfSa2J2LPYM1SgV0YWFEg8+ee39pyZe/rF7NKZZ/KRBS66IYAc2IZ9VqzQbBTK4
         c99CRY0O0lQPkjeFFOwZbMuDgzzH5pfBHqWY4ZTFMDiyi8RZfLYoXBs9uAJ9AP4ScQiY
         cG+qZVihCLsdGhReotB+oAKH16uzcjMvkQB5jS9tRfUXzK4BzKb1qd2wR199L2ybFayh
         a0iI+44RHC2nb+WAQIZWKdcrOEkCLbXfotLG95HwbnmcJxyP4ViHryzDnPv8smorWcJ5
         qUsYLZls/fXZYPFlfmT82hlNdn32LoVm6EAa6abfWLO8AEpKnifMePf7idQ048UC3WAW
         NeRg==
X-Gm-Message-State: AOJu0Ywfv0i0TzFxsJTlbmFEyFR/69IwWfxIis5V7xWSonL2Ln8ycMDR
        Tahg2/FjjUwKl1zTfMXQG1c=
X-Google-Smtp-Source: AGHT+IHAeFfXilr6JALTRh4dYOz7zbBsxx9WGqW0flPjZs0lRr341+qzKjY5GVDUGWmoXHccQAd/Rg==
X-Received: by 2002:a17:902:8c93:b0:1c3:94a4:34bd with SMTP id t19-20020a1709028c9300b001c394a434bdmr5164091plo.40.1695318670555;
        Thu, 21 Sep 2023 10:51:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l19-20020a170902d35300b001bf5e24b2a8sm1787856plk.174.2023.09.21.10.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 10:51:10 -0700 (PDT)
Message-ID: <63152382-b614-c960-888e-723c955bb109@gmail.com>
Date:   Thu, 21 Sep 2023 10:50:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 net-next 4/5] net: dsa: microchip: move REG_SW_MAC_ADDR
 to dev->info->regs[]
Content-Language: en-US
To:     Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20230920114343.1979843-1-lukma@denx.de>
 <20230920114343.1979843-5-lukma@denx.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920114343.1979843-5-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 04:43, Lukasz Majewski wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Defining macros which have the same name but different values is bad
> practice, because it makes it hard to avoid code duplication. The same
> code does different things, depending on the file it's placed in.
> Case in point, we want to access REG_SW_MAC_ADDR from ksz_common.c, but
> currently we can't, because we don't know which kszXXXX_reg.h to include
> from the common code.
> 
> Remove the REG_SW_MAC_ADDR_{0..5} macros from ksz8795_reg.h and
> ksz9477_reg.h, and re-add this register offset to the dev->info->regs[]
> array.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

