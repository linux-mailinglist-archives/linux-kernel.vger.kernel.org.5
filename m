Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2CC7C92DF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 08:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjJNF7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 01:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNF7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 01:59:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE9BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 22:59:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9ae65c0e46fso99211466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 22:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697263179; x=1697867979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8DPDev0kS332XCiOzJt+NGx19fYKPQfBshqPGKN8DE=;
        b=ih+KEGKUVuhqGaW/2poZbEBqx2y2SJ5LX6B42z7kbXWeLvimNvLM/nZP/nBkoMq3HZ
         yCmI01uUWT1R2I/3P29oSHqa/9VYaSTA6Xov9LaB8bpDbI7MgQUG8Lnr1oBVPk1wGUvY
         YZyi97EhIMMh2B9FOgxR4rCWwSy644S+clHf9hOHinAuhbj+cQgVy19bHLrI4STGkeMx
         yLkDAx6TCv/TLp0rB/aLBfquIqrPwVeE7SXLiBH4Oad4darKK6/zAj2eUIklD39W85yn
         szdvVNHaNqCd5TL2DmIqD+/eSlC/eILfgEgI4Oc0IQAn/RM/cZOyuwDCqNsNyhWbH01B
         377w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697263179; x=1697867979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8DPDev0kS332XCiOzJt+NGx19fYKPQfBshqPGKN8DE=;
        b=XM/ZUQt6iTNFC4TECkwgP3XQTiIU47sXJrK8SquDp4th815fYKHiJyNjeO4C3DPS80
         LDxg4RhUYRR1zPbXZ8QwXq6pBQQW1A4LGhov+2ONPV+kbG7r4gnG1ACssPgJUDDxBECb
         I9x9edv+GWAz6uyCpVPTxHFzZGGEXpwGeq4uDb2I0rjydEToTMufYkESz4thwIhKxn+d
         io2pRpw4FsshJI5PUyX9+BpQ2WWl9N+WKvDViWMenHSlMwZPArL53tfah2teTJziFGsK
         P/lr1WyBcZLgaBJlDS5Z8jqSa5l71fbb9/dw57CFNV0zFAN8RalSBatyrre8J3MbfTDz
         eBNQ==
X-Gm-Message-State: AOJu0Yy47VZhuU97bp5/W/KynPSak5zDGQIfXwwDlOMrAzzh1J1nL5mV
        Sjx7eteHSd5iKRMUPoBVM6c=
X-Google-Smtp-Source: AGHT+IEd+pm1Q04YhNA9EuiWqa4E3l5p0ML/HSnn1zHwrRUcm0TlwqY573qk/Ule+PxdXZh2sVsG7A==
X-Received: by 2002:a17:906:7389:b0:9b2:71f2:bd11 with SMTP id f9-20020a170906738900b009b271f2bd11mr22974303ejl.4.1697263178482;
        Fri, 13 Oct 2023 22:59:38 -0700 (PDT)
Received: from [192.168.0.100] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id ac7-20020a170907344700b00997d76981e0sm484346ejc.208.2023.10.13.22.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 22:59:38 -0700 (PDT)
Message-ID: <643971eb-c0e5-481c-94e0-b5bb168c8d5b@gmail.com>
Date:   Sat, 14 Oct 2023 07:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Staging: rtl8192e: Variable renames to fix checkpatch
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231014044435.11947-1-tdavies@darkphysics.net>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231014044435.11947-1-tdavies@darkphysics.net>
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

On 10/14/23 06:44, Tree Davies wrote:
> This patch series renames 4 varialbes to fix checkpatch warning Avoid
> CamelCase.
> 
> Thank you in advance to all reviewers
> ~Tree
> 
> Tree Davies (4):
>    Staging: rtl8192e: Rename variable pBa
>    Staging: rtl8192e: Rename variable TSInfo
>    Staging: rtl8192e: Rename variable ReasonCode
>    Staging: rtl8192e: Rename variable pTS
> 
>   drivers/staging/rtl8192e/rtl819x_BAProc.c |  58 ++++++-------
>   drivers/staging/rtl8192e/rtl819x_Qos.h    |   2 +-
>   drivers/staging/rtl8192e/rtl819x_TSProc.c | 100 +++++++++++-----------
>   drivers/staging/rtl8192e/rtllib.h         |   2 +-
>   drivers/staging/rtl8192e/rtllib_tx.c      |   8 +-
>   5 files changed, 85 insertions(+), 85 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
