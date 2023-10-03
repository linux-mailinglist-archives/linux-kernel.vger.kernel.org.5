Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6094B7B6B33
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbjJCORp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjJCORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:17:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B830895
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:17:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b2d64c9307so38343366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696342659; x=1696947459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HI34v6enrzXzY5NrqWLUUaWvQE0QecGPMbWgelnAX9Q=;
        b=hn4ROQlPTKKXDRog8j678qk4Sj9FruhUcD4Rpja2vJoJU0aot+HdeUl1M7IgM1aM8Y
         bedY9Xx0U2Okn5qndSrhObb1897HaO/Ty0zVwnWZnE9j6H895d8mkZSJm2MVZTkc9x9y
         xYD+dxbsp0wFeuj0KxL4Rxd0XuRBLWtyV7+ragx0/7k09uRdW6SdmACJSS4S4tcEiiM8
         N9ZSkTbDVkGT9kqkQJfbOiJRPiDweDD4VoghGXOiYR3s/AoZyxzG2IbowszYAjgymzJl
         YNbNcVYnXsNyokALu3b62TSTGHWgORNI70vQoWfYXra7Qdn/scjRAmMVqwI3zbZMVmsw
         1ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696342659; x=1696947459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HI34v6enrzXzY5NrqWLUUaWvQE0QecGPMbWgelnAX9Q=;
        b=agdc32gO9skD24P133n9wJHoPcIBQWnqdcSKsOf1M6Y6OBLxsBAuKk73MUfvFWgHUX
         fiEz59XuhBbo0iLxfTrhQ+s0otYymba9c2elH3jIaQVf2rPaFmyYmaRVOwhMtcxsZ20Y
         lCbP38hOvE/aqzixXhLKew4BNk17afWmCopS0da27uoXNdDlZ0Quxv/u///wj9z12GGU
         VDtwpOnvuU8oJMGwWAeNRtsr37luT1PfD2QYMUTNUA0aK/hHR4NwztApHfs67Cy5NGix
         aBtRnUhKqr1c+EGbtcULmrhBNNPfxVJDGZACyi46uJLLzjGU2o+5l4zey+Xr0hbhGqKd
         ggng==
X-Gm-Message-State: AOJu0Yyt4sAGJZ+jhCXemaZzZO6G64QqfnPxrZShKe/sfsWpFVAil4WH
        91GA+3oFTD7FLegVT/fZRMU=
X-Google-Smtp-Source: AGHT+IEbKVCzw3Lfku0fwJ0ozzk3Sfk1w53bdcdkhYVx3IWl7AZ1y4xaY3AZZt0azRiyV+SzwLsjRA==
X-Received: by 2002:a17:906:28e:b0:9a1:be9b:c935 with SMTP id 14-20020a170906028e00b009a1be9bc935mr11939852ejf.0.1696342658605;
        Tue, 03 Oct 2023 07:17:38 -0700 (PDT)
Received: from [192.168.0.106] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id kj6-20020a170907764600b009ad88839665sm1147153ejc.70.2023.10.03.07.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 07:17:38 -0700 (PDT)
Message-ID: <f4a30e07-e967-a734-8892-068514c0ea0a@gmail.com>
Date:   Tue, 3 Oct 2023 16:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] Staging: rtl8192e: Rename variables pBA,
 bCurrentHTSupport, and pTSInfo
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231003031849.176743-1-tdavies@darkphysics.net>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231003031849.176743-1-tdavies@darkphysics.net>
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

On 10/3/23 05:18, Tree Davies wrote:
> This series renames 3 variables to fix checkpatch warning Avoid CamelCase
> Thank you in advance to the reviewers
> Tree
> 
> 
> Tree Davies (3):
>    Staging: rtl8192e: Rename variable pTSInfo
>    Staging: rtl8192e: Rename variable bCurrentHTSupport
>    Staging: rtl8192e: Rename variable pBA
> 
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c |   2 +-
>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   |   2 +-
>   drivers/staging/rtl8192e/rtl819x_BAProc.c    | 112 +++++++++----------
>   drivers/staging/rtl8192e/rtl819x_HT.h        |   2 +-
>   drivers/staging/rtl8192e/rtl819x_HTProc.c    |  12 +-
>   drivers/staging/rtl8192e/rtl819x_TSProc.c    |  20 ++--
>   drivers/staging/rtl8192e/rtllib.h            |   2 +-
>   drivers/staging/rtl8192e/rtllib_softmac.c    |  15 ++-
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c |   2 +-
>   drivers/staging/rtl8192e/rtllib_tx.c         |   8 +-
>   10 files changed, 88 insertions(+), 89 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
