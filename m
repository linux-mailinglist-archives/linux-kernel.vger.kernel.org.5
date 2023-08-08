Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C6C774B0B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjHHUjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjHHUjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:39:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D8430C5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:17:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso9786104e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691515041; x=1692119841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TwbRUbE9Iyh7dJoGsESA40RZGfSeEYtZu2QXfcxjFFs=;
        b=niEcvZOldZfy+xam2Ww/M+Ww2XUjN5PKDEv/6wH7IJLanqXGWwwycdxe3xy6LpTcjB
         mnC3AcSiOM3qzd1XAY7D8JKt1bf9rNjRnEs9XOmHApXmp7Xbh21dre88tV9NJC4i3YbK
         73Nl2bkH+MBdF+n023VIP7A8mzln45JvVV1fsSNMTIhLow1NWjFT075QJdRa7mKnkoIx
         vWVJhdSCBkcf/L0jS7ENrLpAEL7pvTuiM7aX6NkgFrJsPfdxFajBHr64tIjY6Ji4dY96
         yZVfKsNOwtcZfGVwYOYXPWZ+fYrvmOlTBFIh7HVbDpz9EQ/UYFSXIwMMLdFoKypiH9+L
         dBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515041; x=1692119841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TwbRUbE9Iyh7dJoGsESA40RZGfSeEYtZu2QXfcxjFFs=;
        b=L5Uhb4dmJcjR1NUyv1iQIJAwD187pVzpp21kJ+TggtaEpWaBEUIEmZo4HykPYyWEsG
         bHrV0AKKjE6LHE0amolpRKhEcuxzu7cl9B2oavcenaNaYgE8tKctR+xJ/HRP8juuaKPs
         Zs9CCepS1dyOMpLW4ok4W6ToNYun44w6dMoLTG/sQko8eJYzqX1M+GfuPbhF7rkYl+Cl
         70RVW9uFqo/qgjlCTvXCElgLg41VS8qVn62/mKo1rGIT2YwlFNS9v3Iy/xRP/do3Cdzo
         tboEsoQjjhXB+OEF+2ldMebj5C5ku1q9mwboJpUx9vp7JNSQm4TUFTFbGEzck+/amqPa
         1lKQ==
X-Gm-Message-State: AOJu0YwilEDVcmSWwUG3ZQYNKsCxdP0L5tDL4ERYutrn/zwhHbp+HTP4
        Sr0NeH09GdKvlTW8m7kL6lCgP8NU2mCcrj/kOLY=
X-Google-Smtp-Source: AGHT+IHXnKXnrJhPhidC8ZD5IsYzCSsqG98XaFeuFR/hu6KkMI3HUVVMoQJuiF68w2EPBmHNQLE76g==
X-Received: by 2002:a17:906:5dd8:b0:99b:c038:fdac with SMTP id p24-20020a1709065dd800b0099bc038fdacmr9328918ejv.20.1691486467929;
        Tue, 08 Aug 2023 02:21:07 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.23])
        by smtp.gmail.com with ESMTPSA id o6-20020a170906774600b0099290e2c163sm6345876ejn.204.2023.08.08.02.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 02:21:07 -0700 (PDT)
Message-ID: <2d86bba8-6cad-d67f-59bf-157e245edc97@linaro.org>
Date:   Tue, 8 Aug 2023 10:21:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 00/41] mtd: spi-nor: clean the flash_info database up
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michael,

I skimmed over the patches, the idea is good as I already said.
When do you aim to have these integrated, now or after -rc1 is out?
After -rc1 is more conservative, as if there are problems, we'll have
more time to fix them. Either way is good for me as long as you're around
to fix possible problems, but I'd like some timeframe to know when to
invest time in reviewing all. We're at -rc5.

Cheers,
ta
