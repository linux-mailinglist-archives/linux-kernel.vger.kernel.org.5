Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3D17AA14B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjIUVAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjIUU7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:59:51 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85714A7B75
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:14:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52f3ba561d9so2728924a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695320038; x=1695924838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdRKt7DZk+jjVJa9+TmUISsmxBaFaLipfQVb6i5Sv3Q=;
        b=XbwT5QKgT1we4HrmUiVOWKvW9ZL2hTUY6XazTxCRlpYQmcTYFl5zpwHhXvhNKlKhPk
         1sTrTBx8YUAfcpDLTbDtjIIHs6mGfA3N3mySkDkuFVH+PMbpz8LiBKrJegbfD2tVTBx7
         s+X52NF3LgTMEavnhab1PmheGAL0uNywOWH4U6cPqOjxDwfToI6TWGOdbDKTYECxkl3l
         HvuTLoscEOsa1AeBKjq5Jczf0jDx2B1EBdIUEE82YpoI/e3AgdAZOwc0QJVfEXtPt+Z0
         w5c+arsHTmH+IGWFt7cyMG72oJkKQJkbSaUh7sQnrghxhouud1+gXRwbglOEZWVMo4CT
         v8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320038; x=1695924838;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdRKt7DZk+jjVJa9+TmUISsmxBaFaLipfQVb6i5Sv3Q=;
        b=VDXFPoutk0re4jg2zXS3gI2mOMkvjd+4W+oxOG8WoLDQb+MO1yexVIqL7FqgqK7V3K
         oQ87f1OYfKspOS7TMmJv5+5BPid8PD0b31+GApaPrYU0BIbOi+BM13vK3KQQ3d/9Sd5E
         wUqLcgA4ZS30WlHna/zieahkth32ysbhylkXfSa6XIM4dHkOzr/rTXLsUsTovfqDE8HQ
         YxlsF3GrOa3jysraXaUzzHrhyTv40O1FJ6KD3azPZG81Dqe801C1vruJXvEfp0Fa0C+X
         WqVtjVsxcdLMgwjY9mcaGFMhv3FMUX4D5lYIw/3V7JGmWAZi8N5JPWlqvIJJLCPId1wz
         XOjA==
X-Gm-Message-State: AOJu0Yxr8bVJJKdTRvP0DCHAn5eg8qCvNfSguOlL4DxECBqVqn1JLFum
        /HmI5MmElzihZ58FaXCnKzkdSx0UetmOloQUZoU=
X-Google-Smtp-Source: AGHT+IEpwsRPhWLHd8PAT2dNP1MXglwufqkS9mIHN4cKFywtNIagh0BRbKUXzIfYEo4aQy+U7dfSAQ==
X-Received: by 2002:a17:907:d690:b0:9ad:8a96:ad55 with SMTP id wf16-20020a170907d69000b009ad8a96ad55mr10998951ejc.14.1695299572903;
        Thu, 21 Sep 2023 05:32:52 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id x18-20020a1709065ad200b0097073f1ed84sm991732ejs.4.2023.09.21.05.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 05:32:52 -0700 (PDT)
Message-ID: <5a2ee8c1-6058-ee65-7959-d191c075748e@linaro.org>
Date:   Thu, 21 Sep 2023 14:32:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/6] vlynq: remove bus driver
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-4-wsa+renesas@sang-engineering.com>
 <30279c62-c80b-330f-260f-0c64a7893555@linaro.org> <ZQwxwUm3HbqqwEzb@shikoro>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZQwxwUm3HbqqwEzb@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/9/23 14:06, Wolfram Sang wrote:
> On Thu, Sep 21, 2023 at 12:37:54PM +0200, Philippe Mathieu-Daudé wrote:
>> On 20/9/23 22:10, Wolfram Sang wrote:
>>> There are no users with a vlynq_driver in the Kernel tree. Also, only
>>> the AR7 platform ever initialized a VLYNQ bus, but AR7 is going to be
>>> removed from the Kernel. OpenWRT had some out-of-tree drivers which they
>>> probably intended to upport, but AR7 devices are even there not
>>
>> Typo "support".
> 
> "support" would also fit, but we use the term "upporting" frequently to
> express that we want to bring some code from downstream to upstream.

Oh I see, thanks, TIL :)

