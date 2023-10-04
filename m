Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DD47B7EE6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbjJDMSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjJDMSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:18:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B30793
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:18:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so5640965e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 05:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696421881; x=1697026681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jx809ZZPmQX9bCss2qHfga4iHIHABGn3+dRnDoOEwBM=;
        b=2XlPwNz70UbgcPHNh9U92lNSn/Kd4wvmk+CoOCtCspI+gQyMTXiehZgXxM+bCR5LOg
         yCDiRABRk7itxak11OylJMpZrTO/hx4ZjB4qIJW55kndS5tDILDmzqhkG2ouS+iApxs3
         9/CBR8cLgwSRWxMsBx8dQ+2sefuOHRdhhniVxTzlwRNb8ar5VJprY6voOPyhHNifj7L1
         xQKiSq4Sz/I2CzgUVk0BSNoCaomooznkKOSzZzExPNrEGreCaGVBIVufTMHI7QpMIGbR
         WoK0GSuKeVZ+V0n/k+0OB9MZ6d8SivkbtjpBwZjMbwrXDuhZvDPYfyn4Rq7GYYqQBtGp
         dpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696421881; x=1697026681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jx809ZZPmQX9bCss2qHfga4iHIHABGn3+dRnDoOEwBM=;
        b=PQFoAlMWvnG/YU7jiC1xCZs4fpRpbFrzHA3SsSwlJMmqyXvgGECYce6NybJssyXNsy
         dzrYEvyA5DYKHxoZyNKzDY8B/D8ot3sbXbvy4ujMZwgaCKJqHZ8jW0gkw+lltNStCFBr
         afkdyLJH8dy56SIey3ox3xTXCo59p/lDgNFIjY6OHw4mcUJ7LBaEmI5zrkjcvP/7fHEe
         kGq/X3sX/igkgXVKQFCfQjYn4FcUVqclO7i6guqWudlRzeb381ZcVUlbutQchkwmDL4j
         gKaOvpoH70D90ltOppV6zzIOCyIOccrCf2MbyYhdNm6eznoFOliNYoZDhkE/BiS129b3
         +CHw==
X-Gm-Message-State: AOJu0YzthwYoFN/eGBn/bP0ydbCyUvvHIYbGMHabWUIyQsXv2HPsdye4
        YKruNPgfdMD4TQ5+FUVAt1dSug==
X-Google-Smtp-Source: AGHT+IE3PlonxvNG9K0O/ooQBE2t08mHBkDvaao/sVglxJTmwYrc4biZ9IOQj1rAv7vYdVx+kMu1lA==
X-Received: by 2002:a7b:ce98:0:b0:3fc:dd9:91fd with SMTP id q24-20020a7bce98000000b003fc0dd991fdmr2062644wmj.40.1696421881447;
        Wed, 04 Oct 2023 05:18:01 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id o4-20020a1c7504000000b00405588aa40asm1375832wmc.24.2023.10.04.05.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 05:18:01 -0700 (PDT)
Message-ID: <9420885b-784f-5f80-e273-7bade6285676@baylibre.com>
Date:   Wed, 4 Oct 2023 14:18:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     nfraprado@collabora.com, wenst@chromium.org, robh@kernel.org,
        arnd@arndb.de
References: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com>
 <d26ee3f8-d5d3-e46d-4d79-098992d13790@gmail.com>
 <77bfcbca-e7fe-49e1-952a-c99596160c0f@collabora.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <77bfcbca-e7fe-49e1-952a-c99596160c0f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Happy to see you back and fine Matthias !

Also, I'm happy to see the Angelo's step-up welcomed by everybody,
it's a great news !!!

Feel free to ask me if you need help.

Alex


