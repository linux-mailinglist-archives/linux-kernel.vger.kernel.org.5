Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282B878BF44
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjH2Hdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjH2Hdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:33:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26D812F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:33:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a21b6d105cso516404766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1693294411; x=1693899211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRNXlte5u35BqwmNOEJYIpVVcE85OErkNgFAmfi6iHs=;
        b=a0Dqe5VTFzdf8sBljN1f3Kxv6VuyWIhXR1qfDryKuDvfd09vjDlV0BLW6OtVwbZ1tH
         0Vnvzd9f07ha27tTwc1WqhbphSpzGRNKJwKNElV53q8gp6AJLJCCewnZPcbpmkNY07t5
         Vf+n6VRPwZKNsdZFnGg89dQcJWjtUtpE5mTe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693294411; x=1693899211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRNXlte5u35BqwmNOEJYIpVVcE85OErkNgFAmfi6iHs=;
        b=NQyCLo6g3XHPwvR7gk+Lu5JvPvEvJGQOxOGmoyXINZQBrtIKkRi185WhwiMjh74MLA
         RPd/r2RuBEPU1DEvgAPyzaagHb3SOl7oTmd1BgqWfZaQ6UgpdRInTRGSb6NgMPdDGDgf
         IUr/PGZ81vWt63z86ENmFNbxAAKHuq2D1/ChM3o3Scphjh+QQXvH4vHDISfHSf9yw9dO
         3PyUtQlwsxjR9oCwAudEspO9D1Fy0yqCrT55LILLyjnlsOWjyp2EY1IVXyOOvh2xJmxj
         oBDJBCuxalICjz/+W+0oKPS2UgK4xjRBtABR1kNcRhVd0cKnpN3Xtx96dIs5e1382FbU
         9qCw==
X-Gm-Message-State: AOJu0YyJbIeN7y8WMAy3WA6Im4En5jXC9xg+E6uYGvxztEMqXpagbmK8
        wY1xFHnRWIFjSgVnq3JAwBAlfg==
X-Google-Smtp-Source: AGHT+IHCG6ZTBG1UGpX8XAcwOJu7aCTGdJn0htp76AbienIJAd/U9QB4iXDYxU9CQ7/o1kdAHiQUvg==
X-Received: by 2002:a17:907:2c6a:b0:9a2:739:3aa1 with SMTP id ib10-20020a1709072c6a00b009a207393aa1mr10924387ejc.61.1693294410951;
        Tue, 29 Aug 2023 00:33:30 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id ha19-20020a170906a89300b00992b7ff3993sm5606976ejb.126.2023.08.29.00.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 00:33:30 -0700 (PDT)
Message-ID: <5247e354-cb7f-4df7-37a5-95cebed43d4c@rasmusvillemoes.dk>
Date:   Tue, 29 Aug 2023 09:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/12] bitmap: rework bitmap_{bit,}remap()
Content-Language: en-US, da
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230828184353.5145-1-yury.norov@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230828184353.5145-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 20.43, Yury Norov wrote:
> This series adds a test, const-time optimizaton and fixes O(N^2)
> complexity problem for the functions. It's based on discussion in
> bitmap: optimize bitmap_remap() series [1], but there's much more work
> here, so I decided to give it a separete run, and don't name it as v2.
> 
> bitmap_remap() API has just one user in generic code, and few more in
> drivers, so this may look like an overkill. But the work gives ~10x
> better performance for a 1000-bit bitmaps, which is typical for nodemasks
> in major distros like Ubuntu.

Can you find just _one_ project on Debian Code Search or elsewhere that
actually uses mbind(2), that could possibly ever trigger the use of that
bitmap_remap stuff? Also, the bitmap may be order 10, but that's just
because the kitchen sink distros are silly, real machines have nowhere
near that number of nodes, so even if mbind is used, the bitmaps
involved will never actually have anything beyond index ~64.

I think this is all total overkill for non-existing problems, and when
it takes me 20 seconds to find the first bug, I really don't think it's
worth the churn. I'm not giving a thorough review on the rest of the
series, nor commenting on followups.

Rasmus

