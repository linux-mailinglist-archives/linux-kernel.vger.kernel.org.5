Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C17B7C5835
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjJKPie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjJKPi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:38:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF39EA4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:38:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31f71b25a99so6874285f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1697038703; x=1697643503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RCvxB/+dBXFv2rNSKeHbra6jgSQPb7w0QpnaCjhqlhw=;
        b=SR2V185aaJaMUCcJ3dmpm0p8m+apUfcn4Z0k/elor0IvVoX6/d+e5NbulscrbJLlLF
         pNGgq5XIb/2Ukpnv2kUGdLRBzrHGEA3OdWwxKSRwAc+P2lCDHkoQrCaRwHshzIkO1XjU
         45s/W+xrjw0WAF883BPAnXUFtQyyCDWvUY2Dnafp6Jf3hjfkXaIewUfXp0DU85tQQUgC
         xnuHrMEnmbdlVOXFZdSbKe8wPqQy7n+Gzd0l1cCiqXcTNtuI0rMynt0fyOFqHxMjLEwI
         xWGVBFC/g9n3BIbORoeS7KU6QzHx2T+J7m8B3JmEo4M09+bBYHm2ccJw7+XPJU7pdyWq
         Q/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697038703; x=1697643503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCvxB/+dBXFv2rNSKeHbra6jgSQPb7w0QpnaCjhqlhw=;
        b=ibbMkrd67034/gco1O/ze5h5kwIfim/Z8vsZ1Mzw5qub0jYLQo/ICuuZassrDPBnCa
         s6yRVoHbcwNQRNM8TE6k2vmKQOM9kSETAEkXE1ohCLYqaYVx70T9ag1uuI4uALxZ3XJb
         ZdfqAuoe7MTHjK43TDo9q0std0EaSYvkfavfdEiSHDMws+0a+PhNLw1RRQ1o6pmoDkHi
         QN1rjPUA+CtkJOeNE9LuQYwhdgC/0uDeuQcqD2ns5fXYJYnR2L2elKMuTWo8mAX4NA1r
         AAvEi+KrD/+eYFUa1LevhJVMr26u3vH/0KcQw8yX39O2S8FhU4Sw9eBV84/x+AcS0XVi
         x7Pw==
X-Gm-Message-State: AOJu0Yw4OP74M62hr4DW4fneM9A7WtDW3xCAODg339ZcgiDFkvCT1AYU
        uCXI4RGlkuQiK2809Do/8CpvXQ==
X-Google-Smtp-Source: AGHT+IFJ8WJKE7vEKFkfOXPL6F+ZSOLBJaxUlC5THEtjVgUXbUPSwzbmht5i3Ga90Fbbmkh/IFB1BA==
X-Received: by 2002:a5d:500b:0:b0:319:8a66:f695 with SMTP id e11-20020a5d500b000000b003198a66f695mr16591567wrt.55.1697038703102;
        Wed, 11 Oct 2023 08:38:23 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c248400b004060f0a0fd5sm17104653wms.13.2023.10.11.08.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 08:38:15 -0700 (PDT)
Message-ID: <899c7275-ccca-43bb-b1ae-a3403dd18622@baylibre.com>
Date:   Wed, 11 Oct 2023 17:38:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: mediatek-gen3: Fix translation window
Content-Language: en-US
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>, jieyy.yang@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        jian.yang@mediatek.com
References: <20231011122633.31559-1-jianjun.wang@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20231011122633.31559-1-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2023 14:26, Jianjun Wang wrote:
> The size of translation table should be a power of 2, using fls() cannot 
> get the proper value when the size is not a power of 2. For example, 
> fls(0x3e00000) - 1 = 25, hence the PCIe translation window size will be 
> set to 0x2000000 instead of the expected size 0x3e00000. Fix translation 
> window by splitting the MMIO space to multiple tables if its size is not 
> a power of 2.

Hi Jianjun,

I've no knowledge in PCIE, so maybe what my suggestion is stupid:

Is it mandatory to fit the translation table size with 0x3e00000 (in 
this example) ?
I'm asking because you can have an issue by reaching the maximum 
translation table number.

Is it possible to just use only one table with the power of 2 size above 
0x3e00000 => 0x4000000 ( fls(0x3e00000) = 26 = 0x4000000). The downside 
of this method is wasting allocation space. AFAIK I already see this 
kind of method for memory protection/allocation in embedded systems, so 
I'm wondering if this method is safer than using multiple table for only 
one size which isn't a power of 2.


-- 
Regards,
Alexandre
