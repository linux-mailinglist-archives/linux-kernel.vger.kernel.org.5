Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E087A7D58A6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbjJXQhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbjJXQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:37:53 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F801111;
        Tue, 24 Oct 2023 09:37:51 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-41b7fd8f458so29049781cf.0;
        Tue, 24 Oct 2023 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698165471; x=1698770271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fhegx16jideZ+31yN9Lvg2G1yv7a1fe0/VacwfZTuhk=;
        b=N9Z9uIfBOjJgngmyGffmV8b2yU4lPeaTDssMcX7Z7+6GrStnkk9s2pqOqiAXp0+4DE
         0gGKa4bdsfwm40d+XsquVbpOai6Xdb0cNW7tNM795D2P59ut0g9o2SeLa8ES6l/kxhKV
         eUmO4Gdoo+hLbDXieDw6TjqkKIntDXS+CMw8+rqDwsA2CQun+grBqePTq2/LWNE0PlZY
         k2RcbHL2ydRYMNdMF6Rwtc/zvfRvh/0UfHeKs6zcgbaTr2YC5aXsN5ZTaUD1FfCuEOSo
         ClL9C201UyThpV4I5gc8OjJkxx4sH80GB4Eqz1CFXVtMYExm2inWVFUKBCAbo8F44eQY
         ScQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698165471; x=1698770271;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fhegx16jideZ+31yN9Lvg2G1yv7a1fe0/VacwfZTuhk=;
        b=g7XTiDXi7nnx0zx01HbR8duUft8LvRKoEUlI9eahhyETw1XHqU6Wpj/RhF1FECi9eJ
         yH1a9qsut9gal0PUhMws/zk2ZSe2tm+TV2vOp4CLqAJuZcr1pZovrH9WWEFJAZH+f+3X
         InJzyTN7aP0BREYCfF6qmXKrl/LzKcpk4/OEdqjuiW3AiHhpdqkOJBvwx5pIk8cPgN7J
         azvIeEi8mqpw2tOpUooN4ULgO/HMrOXMhXQtw77agXsxGy8dUowWNLywt3ibjkyKPzgr
         19s3rpEggnn+Ul9vgAH8nRzotcKmeeF9YAGp8Pyl1qASpu+WYxFB7c3pwY8t9nCb6mOO
         W8eg==
X-Gm-Message-State: AOJu0YzuBSKzyGxYYbaYgFZagVWGRSj5yDNHpjVUSegZRrzsq4hR34Ye
        sU0JqJQexyBAK74auHHibo8=
X-Google-Smtp-Source: AGHT+IFYT4KgxJWblIcl4cq/Rq1fUtA6/Imb5kvmLn9fnhb/PS0BNq6OUKDr7Z99kCDSfxHyzfFMUQ==
X-Received: by 2002:ac8:5a8f:0:b0:418:d18:56ae with SMTP id c15-20020ac85a8f000000b004180d1856aemr15039293qtc.25.1698165470688;
        Tue, 24 Oct 2023 09:37:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h21-20020ac87455000000b00419b094537esm3590812qtr.59.2023.10.24.09.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 09:37:50 -0700 (PDT)
Message-ID: <987342c5-e122-42cc-aa2a-b709746338d5@gmail.com>
Date:   Tue, 24 Oct 2023 09:37:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-5-2869347697d1@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231024-marvell-88e6152-wan-led-v7-5-2869347697d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 06:20, Linus Walleij wrote:
> Fix some errors in the Marvell MV88E6xxx switch descriptions:
> - The top node had no address size or cells.
> - switch0@0 is not OK, should be ethernet-switch@0.
> - ports should be ethernet-ports
> - port@0 should be ethernet-port@0
> - PHYs should be named ethernet-phy@
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

