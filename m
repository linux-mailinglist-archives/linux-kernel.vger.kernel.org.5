Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128577AD8B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjIYNO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjIYNO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:14:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C309710A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:14:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50435ad51bbso8274337e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695647688; x=1696252488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1dlFb9CClluN5asqyzNkIJTNCGduX6dkKi0ZTGTethQ=;
        b=iT7b5oAQ1C6Sxidm++2fQ0NZk4D8nRecsbUKgKHZFszcBVIeNty1sunSlm49HXQwGE
         cs4G3T5C3iI0Jrl+3sMshqLYFht0VxFJ646Z7kCbwd6QJIm2/C+tgBpcW1Asu+Ir9Nsc
         PLG71UDIUD7282o2ihmQ2ogGL9XoPgQ/7lLMu5xNHTN2tz1Uzl9TCyWcpljG5F1NB62w
         kBenM8q/hY19Lvg6LhwQ7ZBW/IVPzFySamgwiU8uDwfX7sEAYBEx8FvQW/nVrJ4EdOA2
         x/efuZaLiHaFsgWumb78VA2GER5Hzpw+t9aaME2lmU+xP22z5wSfZMLewBEmg8dpdsVH
         5lPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647688; x=1696252488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dlFb9CClluN5asqyzNkIJTNCGduX6dkKi0ZTGTethQ=;
        b=WzGh8pdqaWvT13t7y0xp9BrJT+Jych3y8OUvKeuCSGnQYncwdwc/GlxK/DWTirLaYE
         lRieiCy0jxhDFcQkwZidgInoE6lIqj6lBrFKhdlmkJfJZByjeuWsAaNL3H/NURUn0HCY
         DUR3aepnIdaSNzX6qi0LjSB5gFAIKuj5XyuOyLCHFM2edavL5Ikp3KC9RC6+xyccKmft
         kaq45slyI45NfwEZwSLaxAOF/epjB81yq6Aqzy+ir4gvSfHTOwLBMF3gQh85KcvDw6Ed
         nmR20mER8ldU9fV8MS4F/R3vY7wPpb/9iw8c/XJWHI+OVUZtRniBrs5gO/wjhnOXIjrK
         jwvw==
X-Gm-Message-State: AOJu0Yxvmw2sxRmBDjF2g10S8PDHLii5Npk5yh2PWYudlZLG49LT/4PV
        yPCpn1mdqQ/fXERZs+2YjNMq9A==
X-Google-Smtp-Source: AGHT+IHaOAbnnh4AOTSgeqS4SICLk5OHXkQxgAQQHlYcTHOeTwMRRuF2/91BgowsmYY9TTh/bCZsrQ==
X-Received: by 2002:a05:6512:ad0:b0:500:b5db:990b with SMTP id n16-20020a0565120ad000b00500b5db990bmr6180928lfu.47.1695647687561;
        Mon, 25 Sep 2023 06:14:47 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id w25-20020aa7d299000000b005329f1aa071sm5484747edq.10.2023.09.25.06.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 06:14:47 -0700 (PDT)
Message-ID: <058d5889-8d16-b753-4ebb-6a25d0e5ae22@tuxon.dev>
Date:   Mon, 25 Sep 2023 16:14:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 2/2] ARM: dts: at91: sama5d29_curiosity: Add device
 tree for sama5d29_curiosity board
Content-Language: en-US
To:     Mihai Sain <mihai.sain@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, cristian.birsan@microchip.com,
        alexandre.belloni@bootlin.com, andre.przywara@arm.com,
        jerry.ray@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     andrei.simion@microchip.com
References: <20230919124606.26898-1-mihai.sain@microchip.com>
 <20230919124606.26898-3-mihai.sain@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230919124606.26898-3-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.09.2023 15:46, Mihai Sain wrote:
> Add initial device tree file for sama5d29_curiosity board.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>

Applied to at91-dt, thanks!
