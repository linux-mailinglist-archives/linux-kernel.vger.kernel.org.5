Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840037D2197
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 08:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjJVGsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 02:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVGsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 02:48:53 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E58F7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 23:48:52 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c51774da07so7932551fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 23:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697957330; x=1698562130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KHzG31BGHkohJvfifKCRd1NP9UcJjGMJrOEZtVJg0R8=;
        b=PIV1kNNDuB9m+HTw5RNm5mliTP2bio0bgLIfMcOOiBxEnrhLxx4WiqEMwaSVlgVcAK
         LdkBHkdgKerRcuJ+/YexWxXxNBIwePjyzyh7IOMmnNAvI05V4FlO7c9YPD7LHrDzUoVu
         DfM+gFG9inmtyRvrNj5uEUoCiyGGP/PKkcX6/GJzicP1IHyZubHxbwqXsoz3ZEwVtlfu
         +I3V/8/KDcBVu8T9IDKo5JEy+hmZ9bKnH6BlkB7A4q4BXUqdLit3DNz1WokSkxclQa6m
         xPQzUal6Jzat/T0SwYMKT+TSW22UkWEA1DY+l6RLZJQytW0/t6GDzi3cu1ISCLd+lT+N
         iE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697957330; x=1698562130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KHzG31BGHkohJvfifKCRd1NP9UcJjGMJrOEZtVJg0R8=;
        b=A3t9Z/yFPLw3tgIENyxACZLsElRTQQkBVxXd3OIGSWIsOrJLYPW1h/Uyk4HwZdPLaL
         HT2zNFEfpA04n9aU2bhIkYigz0Y9zrQlxNWdUtvOu+NufjOziUQ8j4qEEe/mWyZlttTZ
         Dt8WoJuex49u8/1A1V759W7UfS0q8WhVrSsPDynxrQyfCieUcVCCONdjqI0OYsW8HxWd
         XC1LT4Lfqxkz3PdKXqSi6vOEvgDKI6Ktvls2hQ60hM5KB1/wwgBDIEfZy49GadqSgNsS
         sQWKB2eNB5HhGYFKhz9BDojF1XM/9gRz19IJHajBbfIWtg0oOh7v9MT5rnoVWCGMCYHC
         grsg==
X-Gm-Message-State: AOJu0Yxfe9+gzw7CpnCMWv/dHlXaCuE6SVs1uGUFQ/2e7Ahagg/ivpIB
        5UdJF+OUogruX3TNbeENJu8=
X-Google-Smtp-Source: AGHT+IH2B0ncrv4pleagLGpYWsQLTr6JJKfe+Ayd8g59dK0vvOFoJQA2dBoeDBYbN3XOfcng3CfsQQ==
X-Received: by 2002:a05:6512:ad3:b0:502:af44:21c2 with SMTP id n19-20020a0565120ad300b00502af4421c2mr3680310lfu.5.1697957329999;
        Sat, 21 Oct 2023 23:48:49 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id n13-20020a17090673cd00b009b65a834dd6sm4649903ejl.215.2023.10.21.23.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 23:48:49 -0700 (PDT)
Message-ID: <1f47714b-4362-47cc-a83c-190b666f748f@gmail.com>
Date:   Sun, 22 Oct 2023 08:48:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: renamed variable IsHTHalfNmodeAPs
Content-Language: en-US
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231021224051.7443-1-garyrookard@fastmail.org>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231021224051.7443-1-garyrookard@fastmail.org>
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

On 10/22/23 00:40, Gary Rookard wrote:
> Renamed from Pascal/CamelCase to Snake case the variable 
> IsHTHalfNmodeAPs, IsHTHalfNmodeAPs -> is_ht_half_nmode_aps. Linux kernel 
> coding style (cleanup) checkpatch Avoid CamelCase. Driver rtl8192e 
> compiles. Signed-off-by: Gary Rookard <garyrookard@fastmail.org> --- 
> drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +- 
> drivers/staging/rtl8192e/rtllib.h | 2 +- 
> drivers/staging/rtl8192e/rtllib_softmac.c | 2 +- 3 files changed, 3 
> insertions(+), 3 deletions(-)

Hi,

I assume that now I cannot apply this patch anymore because the previous 
one is missing.

I propose to make a patch series out of the send in patches.
Please do a compile test and and use checkpatch.

Please include in the version change at which version what changed.

Thanks for your support.

Bye Philipp
