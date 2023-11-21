Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C527F3914
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjKUWVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUWU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:20:59 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE507113
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:20:55 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35b2144232bso3333985ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700605255; x=1701210055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Z8WXu/fiJNNXFNteHhgEV4qN2i0FU5wTM5NTjIv1Ec=;
        b=Rze1fUY5Jzt23UzDcdDj8R8XbFikSyPBT4kbZT5jL87HXwOoACdc8it/vZPso5TMK4
         t9xZ8u9u/iQZuO2Sib/+5ecZ01OVOrjTpOjEB7Dpl6wvxib7HJEP5zjSjbiU5m653qzq
         haXXQ3TZmbVNKZm7kBx33uBCzVSb6suDP3awUa/FGma5lSZW7BnQNfQOhe5/sireXGZV
         xL1YO1GdHTkmHNv7d4uONJva0OturzW8aBfGCKy7T1PM7FN2YwvIHNsdI4vq14xhBanJ
         Cki3v4mL+GyysPWha4wnoHLKBKOjjDEXWgqJ84eQoU35yLcS0Vp94PG9Klksn8sLFwBt
         plHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700605255; x=1701210055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z8WXu/fiJNNXFNteHhgEV4qN2i0FU5wTM5NTjIv1Ec=;
        b=nqFOLqWt9TrdUzdLUl3O9YswUb9en+a4patbhTIisLAdy9FP0ue5G40Og1SedoMB1D
         Xkhw4OhT2C9grZA/370/50pD7G9dGgyheoMEWI3DA6QZ964f1zNNMSlqEMPbO41vYT6l
         JcGNYoACwRB1DCokYo6kGDVBlw19pO20g2Sw3jLQZQEtYPDxOeLp8IpKwvYKyu3wALY4
         pEgAmWZZ5rFRNFnkZZRapizoSsypUeZ8QxHjOzT/nsom26VCwAqKy/cQ+HPAlzTQBWLe
         L1oUz0vDnuokvUdmW8alMZCKoOQ+eU8jjhqq6VDnSSeIQBlf4kFsemwgUAYG5UMbefGm
         VsyQ==
X-Gm-Message-State: AOJu0YwWQXhS8q4TZlfVihnwWz50XF1eLpa/zlkWlWlzDayMujfjlG6X
        LsU69OU3MXL8XfY05PFGCzn+dI3JH6dwwHOl6AA=
X-Google-Smtp-Source: AGHT+IHnEzmXNMqVmbAle3y5pw8fBSNlcSrzJYfQGkwCwmsEPf93tuSlpeOlgv47mg2chlhnMyjDeQ==
X-Received: by 2002:a05:6e02:2146:b0:359:50f2:88b with SMTP id d6-20020a056e02214600b0035950f2088bmr407808ilv.11.1700605255051;
        Tue, 21 Nov 2023 14:20:55 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:9465:402f:4b0a:1116? ([2605:a601:adae:4500:9465:402f:4b0a:1116])
        by smtp.gmail.com with ESMTPSA id bc23-20020a056e02009700b0035742971dd3sm3505623ilb.16.2023.11.21.14.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 14:20:54 -0800 (PST)
Message-ID: <ddb9d0cb-5f78-4242-b431-878d0372884b@sifive.com>
Date:   Tue, 21 Nov 2023 16:20:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: select ARCH_HAS_FAST_MULTIPLIER
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231121144340.3492-1-jszhang@kernel.org>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231121144340.3492-1-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-21 8:43 AM, Jisheng Zhang wrote:
> Currently, riscv linux requires at least IMA, so all platforms have a
> multiplier. And I assume the 'mul' efficiency is comparable or better
> than a sequence of five or so register-dependent arithmetic
> instructions. Select ARCH_HAS_FAST_MULTIPLIER to get slightly nicer
> codegen. Refer to commit f9b4192923fa ("[PATCH] bitops: hweight()
> speedup") for more details.
> 
> In a simple benchmark test calling hweight64() in a loop, it got:
> about 14% preformance improvement on JH7110, tested on Milkv Mars.

typo: performance

> about 23% performance improvement on TH1520 and SG2042, tested on
> Sipeed LPI4A and SG2042 platform.
> 
> a slight performance drop on CV1800B, tested on milkv duo. Among all
> riscv platforms in my hands, this is the only one which sees a slight
> performance drop. It means the 'mul' isn't quick enough. However, the
> situation exists on x86 too, for example, P4 doesn't have fast
> integer multiplies as said in the above commit, x86 also selects
> ARCH_HAS_FAST_MULTIPLIER. So let's select ARCH_HAS_FAST_MULTIPLIER
> which can benefit almost riscv platforms.

On Unmatched: 20% speedup for __sw_hweight32 and 30% speedup for __sw_hweight64.
On D1: 8% speedup for __sw_hweight32 and 8% slowdown for __sw_hweight64.

So overall still an improvement.

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>

