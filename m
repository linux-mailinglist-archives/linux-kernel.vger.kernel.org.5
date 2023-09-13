Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6978079DE23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbjIMCN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjIMCNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:13:55 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B66170A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 19:13:51 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3ab8e324725so637930b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 19:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694571231; x=1695176031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=23rqbeU88G+H/X4YiesJiBFthRxmZeNP6+NeVuIKyqQ=;
        b=tcnC9UfRLA6uxGKWTNg4gxSepsyOiHvGK3MbsaJ2exWu5eFAFPrL36YfFZ9qdIP2/F
         /+UXhxdCZwqooroyaRF/yrxqOSSEZAOCewZee80/ihCK5ASZjkddicej9BpTJkgfj/3H
         ekOlqm92NsO7Kuen7L+QyLOpIsTB6e69unxuaiK/NVTkrv4Ig7GvEFAuWyDig9Ds65Mu
         7qGRZd3cJtgvvUS4xwkxXcn0V3XGehI+A0RbhneKwPWCfnb/2BoJ++7sXv/+cLIDHB7h
         mVQUCv55ggT1IjGnjFQyLLtowK2kLztAlDsCWi1wKGJvPRsL9+qSA9m+6RJw+vC/vykQ
         tf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694571231; x=1695176031;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23rqbeU88G+H/X4YiesJiBFthRxmZeNP6+NeVuIKyqQ=;
        b=Ya1JykQ1+zBJX3TEzhKzJChLY0yc8L+1wd7OMRQHtH0RjLaz6rgdDMrz6jBUjP5LmH
         WbyxObuibkPBTNu8RenXlrZBfimtlddcDoMcdXhKVlxk8srksmjaf5EcyS4Zr5CFY8tU
         6lwl0B557cxNTm/sOjJJZSjPmtyH23boD6xS7kykBshq3Yb+yiSa7IkugHP2agW04wpS
         6AX5trud9vKiLHXKgZ/CUqgboDjpT4Xg/V+ZGwlrpYs708PMkdIyoI/eMpQ5ZqHonapj
         Z6TaPfm9G6R7eyG2rwdtDxDRV7MFP1LHCfLb1WKKjFnRHDQVtZFSsgue8f4bazAGdAe3
         yU1A==
X-Gm-Message-State: AOJu0Yxr22bNc4Jn8ZrP6xAefssWg/6MG6IEmF5/7KIMDi64OScW2LYS
        nkN53Ouw3aeSHKcm//bSEfyVfg==
X-Google-Smtp-Source: AGHT+IHVjIFaCshNBaiPY+rZ4MupNKLAmafkcW6cF13HfuoZWHkT0jVAj0nhyAIPv6stui/Hf1oS3g==
X-Received: by 2002:a05:6808:bd3:b0:3a8:8b74:fd59 with SMTP id o19-20020a0568080bd300b003a88b74fd59mr1750655oik.0.1694571231249;
        Tue, 12 Sep 2023 19:13:51 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w20-20020a63af14000000b00577ae8ad823sm1630196pge.80.2023.09.12.19.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 19:13:50 -0700 (PDT)
Message-ID: <8d633491-b767-4e63-9964-fabe830191c4@kernel.dk>
Date:   Tue, 12 Sep 2023 20:13:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: general protection fault in reset_interrupt
To:     Sanan Hasanov <Sanan.Hasanov@ucf.edu>
Cc:     "efremov@linux.com" <efremov@linux.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
References: <BL0PR11MB31064006356930AAD778ACCAE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <BL0PR11MB31064006356930AAD778ACCAE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://lore.kernel.org/all/7df3e30a-aa31-495c-9d59-cb6080364f61@kernel.dk/

-- 
Jens Axboe

