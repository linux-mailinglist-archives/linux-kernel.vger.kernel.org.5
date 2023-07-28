Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80A57673BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjG1RqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjG1RqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:46:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7B64227;
        Fri, 28 Jul 2023 10:45:54 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso3964167e87.1;
        Fri, 28 Jul 2023 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690566353; x=1691171153;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nGAKrZWJMbIMB5ZiG1OyunTWaTeBfGr8940TFqx3V5w=;
        b=Tc/kauorT1NGAkKqKKQCiTRNQMlA7Z1TGVYChj6B2VSF1iDveTmEE/EA/ukWrgey6h
         IobJN6UnRZ4eS5OVpt5hXzZixOI7TSgrcgaRy2sTOnRknlGLXPXDZtRVjjDj5lU1JSJ6
         GDQjMd9nsUQGCV5V76klC/xxKZ010wUFy9gHt7ElGM1r0x7Nd2c4AUgc7Pvr5JCGW/vk
         NeIDH2Zyezq2nh/v/PkHD31xoDMoZMGMx7149O5aVP8IEd4i8vaXgnldWGyQ4Q8bARF5
         wsCRglxCkX5rKKn7wv61DS5Dfwf/j7F9vMs8rWy+StB7p/TRGONx9Mz4P5klkN8FWNFE
         hQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566353; x=1691171153;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nGAKrZWJMbIMB5ZiG1OyunTWaTeBfGr8940TFqx3V5w=;
        b=TD0XUgs9TNndw/ZX6tUci6eyCpUAt9/ZC6uK6nEAQQuauBfWjjphLMEgX9J7IDER1O
         7vj+KgFx/3R4Voqo7bJ5OYOebmu1WOevAGMtI/1psKUVHotuEIf7lt6s+K2hMTpqZjEJ
         hSJ483jAWN6lGXpx4KdE1d7+wWiDH5yHlEw8fo06OIyhvkrmCOdHrdeRoVtD8ncRuLY1
         T5kIK8QrIbODg9AR9hzcRhomySF8VRUMQl1eDOXYF1rB3Bgb0tnhIHCa3kGHi8IobTNN
         UR/E0VmvNtT0sQtoxKpL6WVMi9nRlKNCr85HPoG4v2TwjAU0pMCBEJWsf9kwC0IEkMZ3
         oegA==
X-Gm-Message-State: ABy/qLZCuu2ZAKyuMzxejAx0oqOn6hZBtyJ3iokqyjiygeJKpOty6uv0
        ccc2YfvAe7PM5uHkrQltWKI=
X-Google-Smtp-Source: APBJJlFm8abjYm/4TWYtQIEydN7BWfBNVQ6mYEuZMyi0sxzGgDUZtGMrFZB/r3PFF68fzZLOJGnF3g==
X-Received: by 2002:a19:9111:0:b0:4fe:1b7a:dfc9 with SMTP id t17-20020a199111000000b004fe1b7adfc9mr2038566lfd.64.1690566352601;
        Fri, 28 Jul 2023 10:45:52 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id f28-20020ac2533c000000b004fb96436ac7sm906991lfh.250.2023.07.28.10.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:45:52 -0700 (PDT)
Message-ID: <2fce9526-34c4-99ba-3dbe-9fa0ee2c0ed7@gmail.com>
Date:   Fri, 28 Jul 2023 19:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] wifi: mt76: add support for providing eeprom in nvmem
 cells
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230708182936.24469-1-ansuelsmth@gmail.com>
 <20230708182936.24469-2-ansuelsmth@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20230708182936.24469-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.07.2023 20:29, Christian Marangi wrote:
> Add support for providing eeprom in nvmem cells by adding nvmem cell as
> an alternative source for mt76_get_of_eeprom().
> 
> Nvmem cells will follow standard nvmem cell definition and needs to be
> called 'eeprom' to be correctly identified.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Rafał Miłecki <rafal@milecki.pl>
