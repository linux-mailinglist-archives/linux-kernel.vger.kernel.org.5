Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3387D219A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 09:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjJVHJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 03:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 03:09:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46380E9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 00:09:38 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c40c3814a8so68926266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 00:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697958577; x=1698563377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VuUrAT1/Th4+3DgWgdpcxcj5Og5do5ih7a6V+PS/SU=;
        b=asV3DO0MQA3S+Bu5f8lIb1I6kAxWbBYNJK1xZhxv7qZMfs4FNk98axbn5wdKa5iLy0
         2d9upvWRc+Tuu5Q1x55bF3luVcwFTtjM5882y/HkDqlDwVAimP9RBj/i5MNGW15xH0x9
         hpegWZ8ndlrFb9tkSjx/BuneTqnuPDDCXA+s1scuObg8fm9kpBWg1V7eFpqZIHF66pNj
         Q58kZF3kZbv9xCpblvo3tRiWsUT2eGSIlAxrZl1cbLZ0mB52NJsc3aEVICjjCFqJQxk9
         VXsVJjqaIV3T0vQfgSZVWTuxoJyYTNhWzlLQjGcuCeRoXzlnkL0sO2EXKDnsSnZasFjv
         96sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697958577; x=1698563377;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VuUrAT1/Th4+3DgWgdpcxcj5Og5do5ih7a6V+PS/SU=;
        b=pEyGaf151hj2YDbEJYNapn2h4LiF8N//IDECbDot9EhxUsugsInMQvZRKFFmNagbgi
         5EXtZtl85iSfRz4fccmqoqCTct2C6d5e7i8iA7Mun7h5yLaOywmdSy14TqdAQU0W6Bfp
         LJxTir2cIBgxACLfRWUcrZcFCKaK0vRMIVVa8BvJ7KFPzFTUcTu6RH7+irtr98cmr9/M
         BdVzWBbP1b9GITQZUQJkDPGRjsEEMaHp9TqFc3+l5621UYtQx6A7N5woVd6n5vtM3HxP
         IksNFIHFXh7l3az9rKjBURY7Ku+6q6O4laUtX/L8VY4UQTDfyoQkaCtRYz0AKbYtZ5nK
         7/eQ==
X-Gm-Message-State: AOJu0Yye39ZG6v6lBOIEARj5kMSC1Vz5ia3pFjgEZVgOrQPMti3vvP/N
        pozpQtplrf49o43XjyNldWo=
X-Google-Smtp-Source: AGHT+IHpWFSh0xuBo4Si/FGcG50HBVDR+UsxBieOFg/xsNfweEU4hj1dct+CudLFa0Mr8Hp+MLQ2Yw==
X-Received: by 2002:a50:d4d4:0:b0:53f:9242:d24f with SMTP id e20-20020a50d4d4000000b0053f9242d24fmr3897922edj.0.1697958576575;
        Sun, 22 Oct 2023 00:09:36 -0700 (PDT)
Received: from [192.168.0.103] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id w21-20020a50d795000000b0053e4d1cbc6esm4540607edi.55.2023.10.22.00.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 00:09:36 -0700 (PDT)
Message-ID: <58cb8d84-b4ee-4d61-baa3-04d2bcdc9c43@gmail.com>
Date:   Sun, 22 Oct 2023 09:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] staging: vt6655: Rename variables byCWMaxMin, bySlot,
 bySIFS, byDIFS and byEIFS
Content-Language: en-US
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>,
        gregkh@linuxfoundation.org, outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1697927812.git.gilbertadikankwu@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1697927812.git.gilbertadikankwu@gmail.com>
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

On 10/22/23 01:12, Gilbert Adikankwu wrote:
> Make the variable names adhere to Linux kernel coding style and fix
> checkpatch.pl errors.
> 
> Gilbert Adikankwu (5):
>    staging: vt6655: Rename variable byCWMaxMin
>    staging: vt6655: Rename variable bySlot
>    staging: vt6655: Rename variable bySIFS
>    staging: vt6655: Rename variable byDIFS
>    staging: vt6655: Rename variable byEIFS
> 
>   drivers/staging/vt6655/card.c   | 72 ++++++++++++++++-----------------
>   drivers/staging/vt6655/device.h | 10 ++---
>   2 files changed, 41 insertions(+), 41 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
