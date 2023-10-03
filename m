Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246ED7B6B50
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbjJCOWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjJCOW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:22:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8640BAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:22:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533c71c5f37so288559a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696342941; x=1696947741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZTPVZjw5Q7ID9PafpDtUtk+upIY6bWyOZZUesf6B3U=;
        b=OhrRXrNJv8g2/DFy3BwXBtzISCfIomG6W9cQ6rhrsaKLMr7lvlfupsamQXZo9tnwTU
         caL56QwTDUDEVWJSlmgbjq0gmkveVYG6bu7BXnhmdcUFoxv5D9guy7xgseKXboWYwq9t
         WUk00c/CFPXsocCxXFlARbVvP7ZR1I6d3RTcymg6bviiXAHgjOJwkWxqdLw+1GdK7CdZ
         Y4eL1KP6vY93mh2PkT2cQQ/xNjetP7nPlkwri8oe2OThP8itdu/bssoXw73/oqsqdDCG
         3t3KnfDkWdCdUzeYculgm290RAALMCoCfC8rlfsJjcizNcyYt2j7tQ8guigeP7+tgAgp
         Rq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696342941; x=1696947741;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZTPVZjw5Q7ID9PafpDtUtk+upIY6bWyOZZUesf6B3U=;
        b=Wj2t4MSRvFjOgmABE3VlbAvg/GmCs9gM4/NYaLk8PqNDlkEzGrA615zvWOYZAIeGWP
         FN2n++LluEdwEU4RLoL2clpEvFpg6oPEmjE69c92AJgLaFGF3LWMtUJyOBusMLYf3L4y
         ZyUefU7kR/sY4crIm+MJDKoz4yJgM5PktKGFSDIffTJVR4KITrqzYs5oxQu71aH39iUC
         jKFgc4k93reiRGukAiFCsOhRkLACnJ9H3rRmidKzZzk/Qz9Ajqxe45WyQEGVZcSDubNA
         5t2uXlO3Me3sPWLDkJYy7+HCHG67mytSodRgU9ag0IoMC4w6fb7lfjvw3ZaG1cXN/8/M
         lonQ==
X-Gm-Message-State: AOJu0YxOpzJKKreLpW5uTT6usUGpktiDeGW8uEywl5QSEifUCWm5ACkq
        W5GNLm3ILCYLBgJ23mZLbUw=
X-Google-Smtp-Source: AGHT+IEKi6grJ6nrHdtMgB67yD68xZ3JEqIPy/wfgBeOm8Ihw8L+7hmvQPEaDZoWlKlGtpF189MLNA==
X-Received: by 2002:a05:6402:5243:b0:51d:cfeb:fc3b with SMTP id t3-20020a056402524300b0051dcfebfc3bmr11140823edd.1.1696342940653;
        Tue, 03 Oct 2023 07:22:20 -0700 (PDT)
Received: from [192.168.0.106] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id s3-20020aa7d783000000b0053404772535sm935532edq.81.2023.10.03.07.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 07:22:20 -0700 (PDT)
Message-ID: <7a8e0c9e-4662-ffab-50e8-f0f9e73dbb10@gmail.com>
Date:   Tue, 3 Oct 2023 16:22:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/3] Type encoding info dropped from arrary name
 "abyBBVGA" and variable names "byBBVGACurrent", "byBBVGANew"
Content-Language: en-US
To:     Pavan Bobba <opensource206@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1696141471.git.opensource206@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1696141471.git.opensource206@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 16:15, Pavan Bobba wrote:
> This patchset series consist of fixes to issues found by checkpatch
> 
> Pavan Bobba (3):
>    staging: vt6655: Type encoding info dropped from array name "abyBBVGA"
>    staging: vt6655: Type encoding info dropped from variable name
>      "byBBVGACurrent"
>    staging: vt6655: Type encoding info dropped from variable name
>      "byBBVGANew"
> 
>   drivers/staging/vt6655/baseband.c    | 40 ++++++++++++++--------------
>   drivers/staging/vt6655/channel.c     |  6 ++---
>   drivers/staging/vt6655/device.h      |  6 ++---
>   drivers/staging/vt6655/device_main.c | 24 ++++++++---------
>   4 files changed, 38 insertions(+), 38 deletions(-)
> 

Hi Pavan,

please do not send your patches in one email.

You need to send it in 4 separate emails.
Have a look at this example:
https://lore.kernel.org/linux-staging/
It was just send by Tree Davies.

Thanks for your support.

Bye Philipp
