Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC097F79FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345549AbjKXRC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbjKXRCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:02:38 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63BF1FFB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:02:01 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a00cbb83c82so314416466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700845320; x=1701450120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43E23uAnd+k2rGiCz48QeTcuuPvbRuPzS8smKDyaGvc=;
        b=VwCbSmupocpzDeosNfLh7kHXy1eo2BxVw1J3vsuaJ26PXrVqNdlMi1kC5eVLU4JLCt
         wCeo2EckUXIS5c9wAgWqxc3DR9V8lVy/F5H8KvRB8kNYAe6NshBBle5myL+hjV/VosrT
         uev/A6BFSA1b43q7tiw9JUnkkqkhAozOt5KSsYDLZ0R8KDwSHRbOI7gobSW/QnwRhaGB
         6VsiiHmQ2lLcOjPZxPpiynVZBJYWcQjJewLWnACObPylH3grAZaa2XODHcjjziEUYjIn
         0It8/Xp03zb0z4+0GEVYd2WddFREczCxlYkEi/MfYZGMz8bc+oTZ+1xHRUdkrCL0qYIx
         QGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700845320; x=1701450120;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43E23uAnd+k2rGiCz48QeTcuuPvbRuPzS8smKDyaGvc=;
        b=df7BEb9AWw+hz9C6vcLGgWjVlkX6Oups8rJbQxnINOSnN0NHiXxNnpgaIHOaulhv/A
         bbWlefBaCBC6KOZ7EnKPzCEJ47D2wcDkt8WHryWcdNR5X2gkSCOJXnzGySeZ76teCSIy
         a/xBB+YbrEBc0fSwHr/9eTbBUJcwjOUro3/3n9vZCeL2AYklneTilWyGTj4sEEHp5CfM
         iVMmNMYsqlFbaMxjE1Esk6ClrJ7dErkv4EOv1ht89uvanZRKAxnKG2E+1FG3Rx3pc7vB
         QV8c1WV3Br9Shs5Ikp47q56D3kd3/4OHAeaEZWsvFK+yMsZ+OIHG5wdaO633eQ6rQchj
         5FoQ==
X-Gm-Message-State: AOJu0YxOKqKpOf1Gc23ZEBJddoP8tS967Fvy67MTAmJMoN4kGpCsQuzm
        MQZxtuq0l0lTm61TRtu6YNf+Tw==
X-Google-Smtp-Source: AGHT+IElUO+l51/8AnXdUmo/6bFieTHSrdY6icuz5IXr0X61Q6SkPXMM+wDGNFKRt6RKrJ9IHvi+Ig==
X-Received: by 2002:a17:906:856:b0:a00:2de3:73cc with SMTP id f22-20020a170906085600b00a002de373ccmr2137734ejd.69.1700845319366;
        Fri, 24 Nov 2023 09:01:59 -0800 (PST)
Received: from [192.168.0.174] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id r17-20020a170906a21100b009ae57888718sm2260761ejy.207.2023.11.24.09.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 09:01:58 -0800 (PST)
Message-ID: <9b0cf286-b938-4a89-bd5e-c2c00cea020a@linaro.org>
Date:   Fri, 24 Nov 2023 19:01:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs: mtd: spi-nor: add sections about flash
 additions and testing
To:     Bagas Sanjaya <bagasdotme@gmail.com>, pratyush@kernel.org,
        michael@walle.cc
Cc:     Linux MTD <linux-mtd@lists.infradead.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231123160721.64561-1-tudor.ambarus@linaro.org>
 <20231123160721.64561-2-tudor.ambarus@linaro.org>
 <ZWBMyPIPwq9L-5pG@archie.me>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <ZWBMyPIPwq9L-5pG@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.11.2023 09:12, Bagas Sanjaya wrote:
> The numbered lists don't properly rendered, so I have to fix it up:

Thanks, Bagas! It looks better, indeed. I'll include the diff in the
next version.

Cheers,
ta
