Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4F67664A6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjG1HAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjG1HAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:00:20 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25D935A5;
        Fri, 28 Jul 2023 00:00:13 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-563f8e8a53dso1053905a12.3;
        Fri, 28 Jul 2023 00:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690527613; x=1691132413;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=csffeR+oPJ4r1BFCRv18Ji1lYkr66TeUyNN6VXBOA5k=;
        b=bRLx7EBYf2U/nH8+u7oRWuawRuAyUzkXbwowllN+/5tlGx22+wcqAfwqnLf6zyOJFT
         aEB0LmSqIHbOI5lh5OaOyP58iVFGwoGiC6u9jCaxhKwNA7EkkrdrSPHJzOBeYRKgGvQQ
         rR99TNGh+oqu74wFG70rdejgZdL98JInkuARS3eKs5FvfZVY+PcS3W8q/HR+6C2j35Yh
         6Xi59KPlnLgmlc1xc8yfkn7TgINdqoqTShBzyKWD5evH6gLgsM9qDw8JYoxyq5SAeYqP
         ZxNLgPQqQq7mGC0dmx10/LJnQT8/7Cv7WEBpSsZN9hv8o8pI8q4zXG5PHI9A/esxIIfx
         et+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690527613; x=1691132413;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csffeR+oPJ4r1BFCRv18Ji1lYkr66TeUyNN6VXBOA5k=;
        b=ikIboOfaDS42FCJ/JZ1pyyhyazNF+nWv6CaLA6f5Si8apSDNh2XN5I0wNVtEYbzsZ1
         iwgfvwUZvES6mIoo63jw7yOCsoYzB9CaOakyvRIkfcAd6/7t6u1H9U9D3TxuFFy6KhAp
         vw72o946Gt2gukWn27v2V8WBSe4sEB6yOI7rRMQJSziXgoYNf6L1w0yqIgl+hyKwtWfh
         EajF8Dl22eK96rFk1WWyZfxPO3oxtl2jB8cGVMIGP8z4FVv3nVgjqPBFZ1V2weswQCcS
         hBLwORlq9k5SDmg1M7skhYw9eAO2m2LOGGtkf36Kv6E4csnEL6mrd8Ky/4bqBnucuSQJ
         VXKw==
X-Gm-Message-State: ABy/qLYIx2RzwlvLGfHQICn2XYDn8YiRCVGC06BsMXBLlsf1gwxckODO
        GU2E2UA/ry0UeKKnRdASfIE=
X-Google-Smtp-Source: APBJJlHQFId3j9XY4axmj92fg1mRTYT3ZW0i6+fQ9XtygsZgZwiS7I1U8crPutn4LhBlrp3d2H13DA==
X-Received: by 2002:a17:90a:bf0a:b0:268:5558:de4c with SMTP id c10-20020a17090abf0a00b002685558de4cmr803408pjs.38.1690527613159;
        Fri, 28 Jul 2023 00:00:13 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fw3-20020a17090b128300b00262ca945cecsm3642658pjb.54.2023.07.28.00.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 00:00:12 -0700 (PDT)
Message-ID: <849bdcfb-b70f-5212-58f7-71e2da25c5ed@gmail.com>
Date:   Fri, 28 Jul 2023 14:00:05 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: XPS 17 9730 runs significantly warmer on Kernel 6.5-rc3
 compared to Kernel 6.4.3
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Goran <goran.brkuljan@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>
References: <4aaf1d3d-2ab7-2d3a-f597-a1741bf699d6@gmail.com>
 <ZMMaYLcc5G4KSVyf@debian.me>
In-Reply-To: <ZMMaYLcc5G4KSVyf@debian.me>
Content-Type: text/plain; charset=UTF-8
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

On 7/28/23 08:31, Bagas Sanjaya wrote:
> Oops, I accidentally duped this. My email client was stuck sending it
> (but got delivered anyway), thus:
> 
> #regzbot dup-of: https://lore.kernel.org/regressions/107f05b8-0104-501c-130c-4f89f3f8a628@gmail.com/
> 

And to clean regzbot up:

#regzbot invalid: accidental duplicate

Please ignore this thread, and instead follow up the original
forwarded report at [1].

Sorry for inconvenience.

[1]: https://lore.kernel.org/lkml/107f05b8-0104-501c-130c-4f89f3f8a628@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara

