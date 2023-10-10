Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCC87BFB95
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjJJMfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjJJMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:34:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8457ED6B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:34:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so9141552a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696941278; x=1697546078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ctxSL5NHuvqBM6PtJ7e7K+XdAt+ChzjxPiXwTE9IU1w=;
        b=kX4xqlh3ySEt0nYkuJTc68vlvqCOA+244hPIC4X1Af2bRY2hOctq37psI0ERUH+b1W
         w3Pb2jw/Ws2S5cJBG2OWYhCHSO5mnqsJVsuOfvtRGGT/UZOOPGX0tPURef2yn4mI573s
         L/vc5WopsXgUtVVeV1ScLOqRv2oRd8LWRzM/9CMIQDwFUMGqQcTMtcd3ImaAWFUDFVLn
         wyuHdFq3eVxGcwZ5d7E2qUZ3ggD6jdh8Afz+buYz83IAv7NNyN8rJ+aONaV8g+7JfvHp
         Uf1V2vOHLCDp+7lqGiIDtZ3XMno38RWmEKPsK5ioSgbNnvmLVsvtKxaDE6rFSSeq0Hop
         GzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696941278; x=1697546078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctxSL5NHuvqBM6PtJ7e7K+XdAt+ChzjxPiXwTE9IU1w=;
        b=fLxCIBTEe7JxB/xr7yCXcUbo32A1twVyQUvs09V8gBYMTE0g4gTuT7wuRDSqPX3QXc
         5y3hTRqsV+h5olCJL14CGLWoFiz91eVyxzs6ioDw4mrx/QjsMyF44xoM30jwgC7a5z2k
         WmJFSR4YeN9RnxindaAQqiZYuRz/ag02l7x2JLoy+P57oUvdpxNUVwTy1hI+gbx5DwqU
         8yYW6UwuFAWWaLowBo7FT5jx2u9AKw0hlxk8f776Pi8ne4yNHDmM9r80C/c1igzAjBG6
         PXf8Uh+m0FlkTNfrBfuYRnmxP4MMsnWvBWX+0D1XF+UypVHqc6hsIjYpl1q7O1YotLht
         G6Pw==
X-Gm-Message-State: AOJu0Yy5JEaAVE87DyL6jxRn5cFLPWeXmQnAUaCVGxGzMgdQ3JJ0bHI8
        t99IqSgc5W+TW21c0wxZi5IasK1KTxfznMJHwvc=
X-Google-Smtp-Source: AGHT+IFNzIdVmK0dxW9clCRZ8qa+lFvSfLd3+EmkUWyp763Qj8lwGzsRCnf2oKn9izNfzMeApEkpFg==
X-Received: by 2002:a17:906:3094:b0:9b7:2a13:160c with SMTP id 20-20020a170906309400b009b72a13160cmr16436421ejv.69.1696941277834;
        Tue, 10 Oct 2023 05:34:37 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id e10-20020a1709062c0a00b009b64987e1absm8294690ejh.139.2023.10.10.05.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 05:34:37 -0700 (PDT)
Message-ID: <dc50d8ec-b43a-4beb-9fdf-773b0ee30d0c@baylibre.com>
Date:   Tue, 10 Oct 2023 14:34:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: mt6577_auxadc: Fix kernel panic on suspend
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, jic23@kernel.org
Cc:     lars@metafoo.de, matthias.bgg@gmail.com, ruanjinjie@huawei.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
References: <20231010121940.159696-1-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20231010121940.159696-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 10/10/2023 14:19, AngeloGioacchino Del Regno wrote:
> Commit a2d518fbe376 ("iio: adc: mt6577_auxadc: Simplify with device 
> managed function") simplified the driver with devm hooks, but wrongly 
> states that the platform_set_drvdata(), platform_get_drvdata() are 
> unused after the simplification: the driver data is infact used in 
> .suspend() and .resume() PM callbacks, currently producing a kernel 
> panic. Reintroduce the call to platform_set_drvdata() in the probe function

-- 
Regards,
Alexandre
