Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A8C77A787
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjHMPfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjHMPe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:34:59 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF041E5C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 08:35:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6873f64a290so989768b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 08:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691940901; x=1692545701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RNqe/nmjkgw3d8zLXWfLEuR3zEJElR6Cvxa4EUhIgTM=;
        b=nNM0ekLabYjOL/L6X7z8Eiw3UfTV8EdzaD6mXLaD9DnCTQnYj6bOUIWKO9WoaXjsez
         +3CJSvvOCLr7khKerM3Dk2aVUIgA2ukGpmzJiIwW/0HzxnBpSSorieCC1IEGm0+wyiuB
         DW/G6hImrEbJLRKR8rMUOtZMTt0XfUImsh1SLriEHcWHaw3Mb7dx1+okBM3TUu3vqtkX
         GxSpA8hC/ZzdphwQUZWGqVG82i07r/Tr1jbydeb4HzOifGlQrphfuTiuj63NdMAVwakm
         rg9dWUhSVldDNS2zmrcYUAuALB8IMJFjYA2DaXgVbYoNdtp8r3RpFyP/t+t9PTK6Mey8
         iLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691940901; x=1692545701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNqe/nmjkgw3d8zLXWfLEuR3zEJElR6Cvxa4EUhIgTM=;
        b=hXQvn5bgdzS6MVDiqx2k9+AKo6v2kHrXrfXsvZURIHnXCuu1DEKbJxN88U9iFUmGT1
         QVDGWooTaO1O1CP3eu9zWoCW463IBThxdKdPnxnBEAlCPGTQklK/dG4LZJtFJvKvebGJ
         tGct821HjjSRKL2KkPq2MkZb0iLr6D7F+AlHxkxBs2nil1ojN/CTlBE4Lo2HPZa7nKob
         rJq9g2P97d6iX0f0ndVFWXASNYTni9/HAaxMqNf2y7E3QjVOB8uIlXloAaTSSp+tpM59
         9XQBZrlDLQ7ZnUcikjp3TMlAoO6RxmBUGjWH7tmWZGBIMg759g9Kv/2T7H3yTBozWR4z
         qNtw==
X-Gm-Message-State: AOJu0Yxc3KNjgj2Vqoe6grh6B5ag32Fb7yF0NA31USLM0UO82KAvQcTl
        +7w+tvXFkBH2pDdYBTAaJfD7rA==
X-Google-Smtp-Source: AGHT+IHQw3V12cavdbXwv/KBh/WEXfZGutgwq36KqFYBQvM/crx2fJQ86XNpB5Wuc5avQCENertDFw==
X-Received: by 2002:a05:6a00:2ea0:b0:677:3439:874a with SMTP id fd32-20020a056a002ea000b006773439874amr9008826pfb.3.1691940901140;
        Sun, 13 Aug 2023 08:35:01 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id i15-20020a63a84f000000b005634343cd9esm6780093pgp.44.2023.08.13.08.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 08:35:00 -0700 (PDT)
Message-ID: <61b9abff-091e-4aae-a9bd-3f1be1593661@kernel.dk>
Date:   Sun, 13 Aug 2023 09:34:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-mq: release scheduler resource when request
 complete
Content-Language: en-US
To:     chengming.zhou@linux.dev, hch@lst.de, chuck.lever@oracle.com
Cc:     bvanassche@acm.org, cel@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230813152325.3017343-1-chengming.zhou@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230813152325.3017343-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/23 9:23 AM, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Chuck reported [1] a IO hang problem on NFS exports that reside on SATA
> devices and bisected to commit 615939a2ae73 ("blk-mq: defer to the normal
> submission path for post-flush requests").
> 
> We analysed the IO hang problem, found there are two postflush requests
> are waiting for each other.
> 
> The first postflush request completed the REQ_FSEQ_DATA sequence, so go to
> the REQ_FSEQ_POSTFLUSH sequence and added in the flush pending list, but
> failed to blk_kick_flush() because of the second postflush request which
> is inflight waiting in scheduler queue.
> 
> The second postflush waiting in scheduler queue can't be dispatched because
> the first postflush hasn't released scheduler resource even though it has
> completed by itself.
> 
> Fix it by releasing scheduler resource when the first postflush request
> completed, so the second postflush can be dispatched and completed, then
> make blk_kick_flush() succeed.

Thanks, applied with a bit of commit message massaging and adding a
comment for the newly added WARN_ON_ONCE().

-- 
Jens Axboe

