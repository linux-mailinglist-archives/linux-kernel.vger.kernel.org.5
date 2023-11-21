Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0622C7F258E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjKUF6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjKUF6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:58:02 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491DAE7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:57:58 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50aab0ca90aso2900689e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700546276; x=1701151076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7qlehtsZYfebpFdFAY73VV/paYzz6daNRXMckCDPI1Q=;
        b=LrYQybniTuoVmqlTcvQlF8ANVs8Z93Othbttao1VuFiDH9g9QIJKbgWhIocFpSJPKQ
         KwpCArSFOhUgMcH183gaGFvMJyuvWE4d7bdsSRzYLAE3xr9iwqlnZQgcC8gLcVBG93Ep
         4theNBc1PrNIlEwT6S9DVK2GDt+oLAZ46a6a8w6dMPXW+oht8VANVQQnDe0HmA4lkYWz
         wOl2GwBDFErY7ODKFQyum6D91KT9Y6gtyum7UUEo/l5/lehm+M3sKl/kmEFTslX/xYko
         aG6CRsj7WlcFvK+So6p/wwie79JmpS6TPN9UcPPv17T9NEYhhWfHolRgtkGVDIVtGjjY
         qkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700546276; x=1701151076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qlehtsZYfebpFdFAY73VV/paYzz6daNRXMckCDPI1Q=;
        b=SZ9EHV9DgBDaRU3WcG6+m8rKxRCLBinZe2Wj50zRI4tujMcFO0pPDMXJpPs6uOxQir
         EusLnVg6P5FO8OCLF69aBv1Lal4PHrPCbG3rKseXyxtGEsa2AJxXpJR9VliclTAl3Vdo
         hkW58pzvYyfj7pZmbcc5uwyK0Z5ThEsdiBy7ZEye3PAmhOn+8MAw1XDTCmmlLrnRKPc/
         DjM7zFxihmC0uPNAJ8SnowDtEJllhAuJ/wYFWWztKes1v1JGVwZiAYri/a3VbVE6Jm8W
         TkJ0eAUC/bU80G60ZODqsSfSRVcTudfJf2YfgxIxlfeD9QxgVWEmc9fn7QrPey7P74A9
         1oyg==
X-Gm-Message-State: AOJu0YxIrriU0qYjkjVv9pkQHuLZLKMG+xYow+J8wf0o2AgbSaf2XlRv
        nbUw/FBkcHCqwOT9u58tzRM8sQ==
X-Google-Smtp-Source: AGHT+IEYL7tOmd1RZpAcsqf+lMzTOJfDHXI7QPhJmLWCzGt6NCj2voH5dnbxu1YvRCITJXwXNJuZCQ==
X-Received: by 2002:ac2:5191:0:b0:50a:7868:d3c0 with SMTP id u17-20020ac25191000000b0050a7868d3c0mr5423864lfi.23.1700546276378;
        Mon, 20 Nov 2023 21:57:56 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.3])
        by smtp.gmail.com with ESMTPSA id s21-20020aa7d795000000b00548679e4884sm3504193edq.46.2023.11.20.21.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 21:57:56 -0800 (PST)
Message-ID: <33a44057-eefa-44ba-8e06-b6eb8bd79e59@tuxon.dev>
Date:   Tue, 21 Nov 2023 07:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] net: ravb: Use pm_runtime_resume_and_get()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        geert+renesas@glider.be, wsa+renesas@sang-engineering.com,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120084606.4083194-3-claudiu.beznea.uj@bp.renesas.com>
 <a465e1fb-6ef8-0e10-1dc9-c6a17b955d11@omp.ru>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <a465e1fb-6ef8-0e10-1dc9-c6a17b955d11@omp.ru>
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



On 20.11.2023 21:23, Sergey Shtylyov wrote:
> On 11/20/23 11:45 AM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> pm_runtime_get_sync() may return with error. In case it returns with error
>> dev->power.usage_count needs to be decremented. pm_runtime_resume_and_get()
>> takes care of this. Thus use it.
>>
>> Along with this pm_runtime_resume_and_get() and reset_control_deassert()
>> were moved before alloc_etherdev_mqs() to simplify the error path.
> 
>    I don't see how it simplifies the error path...

By not changing it... Actually, I took the other approach: you suggested in
patch 1 to re-arrange the error path, I did it the other way around:
changed the initialization path...

>    Re-ordering the statements at the end of the error path seems cheaper than
> what you do.
> 
>> Also, in case pm_runtime_resume_and_get() returns error the reset signal
>> is deasserted and runtime PM is disabled (by jumping to the proper
>> error handling label).
>>
>> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> [...]
> 
> MBR, Sergey
