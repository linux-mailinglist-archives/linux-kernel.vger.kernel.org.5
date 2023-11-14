Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3647EB77F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjKNUKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjKNUKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:10:09 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DAD11C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:09:46 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9dd9808c308so139813266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699992585; x=1700597385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjVE7g4gLV36CCD94RH1v3GPVVRu0rmQH9p/wSPfCGI=;
        b=L62Wc6ndv85HUT5yXWCi3swVU5nQ7yesZ0T5naVF4BcniVSGqoACtsJJJmKgWm6k5D
         CR+NLHVnRmKhKQzq61rPBZejQxNcMqelAV8xhNAXABez9JtewZf0GsCnPuBSoF0PExgK
         wAXFyBls8/OBXlD5I5GO7a5JxC95M2ho/V5UaCFoHLoxflMf5Y0MCmqTQG1oRtvS4w8h
         5LLgeWRu7BDNvuDoEma+oxvwjmflx+bH3xk6bMTbPj53BymXDacsrYEK6OeZPKBRpXpv
         fjU1HfH69uQaC7SH512LiJiLO3SKgGXV6T5B88fSF+temwFUQ27yypPIauZjWuqqlOZY
         Ctww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699992585; x=1700597385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjVE7g4gLV36CCD94RH1v3GPVVRu0rmQH9p/wSPfCGI=;
        b=Dtz2TZpkRmTtmwJOk2COWSwt7cyEinLnTNk3DMI2ZFRlWkigCD8WXSWyF3W0UDvgEd
         7j6NSIDS4cGLqYRBRTwxiOQOW8RfDqjrNiXUMG4Qmk4FUQtHKdIpbXyYM0ttVMDM1j5l
         aV6gYVwzZ890sKI7T4MhmBZsUBXZfV6+TezHx9BpwcHqyx1hHXTFD9XUNmdIEW6x/tBv
         +u5InfU0v4iuh2w2s5e/lZOACcqIPVyaWAmMfPNKdJarZbZC0Qwqll7ejHUdGa2FreLW
         6zQgP+mJ3PfF+xvp7h+2G/sUzofsw++h2zYnf15m+ikwf6GGvXaYJqUCeCxWzJjHQYzx
         FYag==
X-Gm-Message-State: AOJu0Ywiw6BmnCH5t1HmQOZKnwRGp8mEA/6cgfGZTcd4krqbj0xJnMBT
        Ep+g0v5dDwygbTBZ+Ue8A1A=
X-Google-Smtp-Source: AGHT+IEssApvIbQKpflYjf6NlHMo7r/dIDUj6kFmDMDIp8yG6Cl4/TVje9dZ8ZzLBwbPRsNpHuD0Yg==
X-Received: by 2002:a17:906:1da:b0:9e6:dfee:8154 with SMTP id 26-20020a17090601da00b009e6dfee8154mr2249304ejj.3.1699992584387;
        Tue, 14 Nov 2023 12:09:44 -0800 (PST)
Received: from [192.168.0.102] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id fy15-20020a170906b7cf00b009e5e1710ae7sm6077032ejb.191.2023.11.14.12.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 12:09:44 -0800 (PST)
Message-ID: <c464f4a8-753b-417c-97bb-7aa29ab5bf59@gmail.com>
Date:   Tue, 14 Nov 2023 21:09:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Staging: rtl8192e: Rename bool variables
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231113195910.8423-1-tdavies@darkphysics.net>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231113195910.8423-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/23 20:59, Tree Davies wrote:
> This series renames bool variables to fix checkpatch warnings
> Thank you in advance to reviewers
> regards,
> ~Tree
> 
> Tree Davies (7):
>    Staging: rtl8192e: Rename variable bSendDELBA
>    Staging: rtl8192e: Rename variable bCurrentAMPDUEnable
>    Staging: rtl8192e: Rename variable bAddBaReqInProgress
>    Staging: rtl8192e: Rename variable bAddBaReqDelayed
>    Staging: rtl8192e: Rename variable bUsingBa
>    Staging: rtl8192e: Rename variable bOverwritePending
>    Staging: rtl8192e: Rename variable bDisable_AddBa
> 
>   drivers/staging/rtl8192e/rtl819x_BAProc.c | 40 +++++++++++------------
>   drivers/staging/rtl8192e/rtl819x_HT.h     |  2 +-
>   drivers/staging/rtl8192e/rtl819x_HTProc.c |  6 ++--
>   drivers/staging/rtl8192e/rtl819x_TS.h     |  8 ++---
>   drivers/staging/rtl8192e/rtl819x_TSProc.c | 14 ++++----
>   drivers/staging/rtl8192e/rtllib.h         |  2 +-
>   drivers/staging/rtl8192e/rtllib_tx.c      |  8 ++---
>   7 files changed, 40 insertions(+), 40 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
