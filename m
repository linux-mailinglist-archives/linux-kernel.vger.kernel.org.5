Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7907A9719
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjIURLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjIURJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:09:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9178876A1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:05:24 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bbbe81185dso4387181fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695315908; x=1695920708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYno1ZJZxkD4vk/Haa7DuZReObG5ynelS4rpVSOvG3w=;
        b=cE3lBHkIoTd/Qe6w/1BDT3n9LewhwyqvLqO0b+H4IPHOw5KP2XMCRYaqNhELLgYFYP
         FkxU9RfMrMW6q593uwOBo5zoe4nTisLBuWIjhel3zJbRh6tS5DHn7LlhU3LlG6hjJNqA
         rtuMQE2Kx6wwWoEjzzS7zsERRU3JwSkd0ZIW7vT2V8dR/O/di7PS2BMDlobpq8WPEvkc
         J8psNLsILWC3UUFHiDaPT9qYbCzqDXKXB0LaSMOaH7PJA6btyuP7CXwCNjBYfSxHJLwB
         VsfIOPPHOBQ6QWO+ZkuIbeqOMcheT/Ad1m0o/Ag45emw80qonQawgPyTqkEVq8iS3QsE
         uYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315908; x=1695920708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYno1ZJZxkD4vk/Haa7DuZReObG5ynelS4rpVSOvG3w=;
        b=KgIrku7X4iskMic+2cYdWOJ2EsHjs8u50sRlq5bOgk9sPke72G9IK2Hb/3pLosZPJk
         cL5cfiGqvcz5vA+it4Vi/wgoZiSKtMMZ5lZ4cPQ0mUZqywTtcwWapfCcQH5Zd/D59a2q
         tTzPH3IRCJ/Ava/dUMAKHAUKAN4fCz3HAB3NdExw6E7r0+N40vpxLxLb+mwK8RxCao63
         tGh0ENZmZfjwW3/OHzQDpTlFZrfe2dF5r7p/VcS9lA377w5S7Zf+yCVm6k1o5NJIxXRi
         dMJLGQFYvhEigphMScLkagbK38xHXwOVNlRYzoLIUVlIa6co7ovePP4OWl5HIRE35vKH
         6kvA==
X-Gm-Message-State: AOJu0YyCdXmov2B3eoMXJaRzH2p38V6jwYm5QbsWpUcTSkBRr7aFba+r
        tKrG+T2Vx4eiv/WL1e5v1peBo3DoAZxqoQ==
X-Google-Smtp-Source: AGHT+IG9d1svIapCRWcs3sULEe5wW0jguhBJFgzhPLiS72gscJIBp0Qmm+cDiXey5SMrS/Zkpe+Wtg==
X-Received: by 2002:a05:6402:2695:b0:521:f2a7:d57a with SMTP id w21-20020a056402269500b00521f2a7d57amr5463731edd.2.1695311763759;
        Thu, 21 Sep 2023 08:56:03 -0700 (PDT)
Received: from [192.168.0.102] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id n26-20020a056402061a00b005313c60165asm1028680edv.77.2023.09.21.08.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 08:56:03 -0700 (PDT)
Message-ID: <13773b73-147e-6e52-64c9-bedd1bf826f8@gmail.com>
Date:   Thu, 21 Sep 2023 17:56:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 00/11] Staging: rtl8192e: Function and Variable rename
 series
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230921032515.96152-1-tdavies@darkphysics.net>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230921032515.96152-1-tdavies@darkphysics.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 05:25, Tree Davies wrote:
> This series fixes 11 checkpatch Avoid Camelcase issues throughout the
> driver.
> 
> Thank you in advance to reviewers
> Tree
> 
> Tree Davies (11):
>    Staging: rtl8192e: Rename variable Time
>    Staging: rtl8192e: Rename variable pAdmittedBa
>    Staging: rtl8192e: Rename variable pPendingBa
>    Staging: rtl8192e: Rename variable Dst
>    Staging: rtl8192e: Rename variable pPendingBA
>    Staging: rtl8192e: Rename variable Addr
>    Staging: rtl8192e: Rename variable pStatusCode
>    Staging: rtl8192e: Rename variable Policy
>    Staging: rtl8192e: Rename function GetTs()
>    Staging: rtl8192e: Rename function TSInitialize
>    Staging: rtl8192e: Rename variable StatusCode
> 
>   drivers/staging/rtl8192e/rtl819x_BAProc.c | 74 +++++++++++------------
>   drivers/staging/rtl8192e/rtl819x_TS.h     |  2 +-
>   drivers/staging/rtl8192e/rtl819x_TSProc.c | 36 +++++------
>   drivers/staging/rtl8192e/rtllib.h         |  8 +--
>   drivers/staging/rtl8192e/rtllib_module.c  |  2 +-
>   drivers/staging/rtl8192e/rtllib_rx.c      |  4 +-
>   drivers/staging/rtl8192e/rtllib_tx.c      |  4 +-
>   7 files changed, 65 insertions(+), 65 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
