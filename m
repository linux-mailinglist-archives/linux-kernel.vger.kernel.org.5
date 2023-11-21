Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013307F3532
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjKURrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjKURrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:47:40 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87FE18C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:47:35 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cb55001124so8015b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700588855; x=1701193655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTbpm+rp6tMftUStFdiQEsAqCqUtgJmVMIVDldceZqw=;
        b=PV+GKU4aUhTQV3tEWdClWY1Hq/D5LCUwl5f6TBkRuXjZMyjgH/y2Ou1ehdfJGBzPli
         X+XF+BOlzTQOoB7MCN0yss4Uo1/8yiGoUSZLeExsFh9KerXniYZptvTbwbRf0ECM+A+l
         1+mfCtRY5Qgjj1v0+NCWEXqtor8tlrVoA9f65WaC2EtnLsK7YQsu5ZLdVNv5ikvnHmwg
         T5hyQQlrydf7N3dwWA24DdHYavSUsftpkF+Q2TL0BRX0SOXyBmUGT+5KiJ65+I546JX2
         e4lHfDa9I9cojtD3XZZPgh0VMIdGXk32z9snTGasI6/EQmjJ4fxQsvfdkALbWXfEnTYo
         8nKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700588855; x=1701193655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTbpm+rp6tMftUStFdiQEsAqCqUtgJmVMIVDldceZqw=;
        b=iAN5OBt+2f8z+1pz+gmV5PVAGlAdigI5fGir0v7M1XsHuzy+dPkJ3ITkhJg0UYvv3U
         G/VNQ/tlQ0EkpZgxIQSImlOIyovMLhHT7cOgVrr+y6qI/SXYNkkUj+d0ugy1dj1gamvr
         urg7KUo1RQRM7BzcUp7svrJVrHK7jh2y7ADmQLMDBnp+vHRH3yVonOYA0ybge3+p1Cx6
         ifxp6xH1Z84Wd+kZxgNEgJsLnmCUaLLS4tVwctd1DMDtte+ooFIM0Hh80x/rAjpEI++z
         Qg0k2LjsfWBbofm9hgpkwL1Qoupx8ZI6dmoOrw3wrR1K0F7wQLgTj2Erp92O6wdvqGwa
         /cAA==
X-Gm-Message-State: AOJu0YwIFlvlwBviMDbtGTNEVELD5TGE7EZiNI5DDuxHYEhCYR0Zd7Wj
        3w68h+YG88D1iNiDkGBW5r9/N7XvUTMmZTFKx22+Y7mo
X-Google-Smtp-Source: AGHT+IGpLWmqDSdVFd6CaLryGWVI12VpIaF4JYNkxPzXXmBwqK7ws85MhXqCeNh2+C9HWx6XT+XJQA==
X-Received: by 2002:a05:6a21:6da0:b0:187:4e8c:ac5c with SMTP id wl32-20020a056a216da000b001874e8cac5cmr89463pzb.1.1700588855173;
        Tue, 21 Nov 2023 09:47:35 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
        by smtp.gmail.com with ESMTPSA id b11-20020a056a000ccb00b006cb69ff0444sm5547127pfv.151.2023.11.21.09.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:47:34 -0800 (PST)
Message-ID: <f51d5dd1-5fc9-4b4b-b012-a396b68fe184@linaro.org>
Date:   Tue, 21 Nov 2023 11:47:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] tty: srmcons: use 'buf' directly in
 srmcons_do_write()
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
References: <20231121092258.9334-1-jirislaby@kernel.org>
 <20231121092258.9334-14-jirislaby@kernel.org>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231121092258.9334-14-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/23 03:22, Jiri Slaby (SUSE) wrote:
> There is no need to have a separate iterator ('cur') through 'buf' in
> srmcons_do_write(). 'buf' can be used directly which simplifies the code
> a bit.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> ---
>   arch/alpha/kernel/srmcons.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
