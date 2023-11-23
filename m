Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792F17F680F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 21:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjKWUFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 15:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjKWUFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 15:05:00 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523BD10D2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 12:04:58 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51f64817809so225778a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 12:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700769898; x=1701374698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RSloKbp86UiyOswV753VKR+ULy2TcPDIFU6JTx1BHg8=;
        b=Y/GYq1bjZBdjVgnR8UnEtq1heRxvHfI230VlpgMlZothiuWI/pihUUw9hIvlyrSINk
         JhOFYUCiEWUJaltZ9wXK1noXwZ/xhfQmgcrNz2xraL0+uQCnnhMs/VEJd1KfEaxhROjp
         vno9sES4buCXMLkpp7v8nlGVsuOY4o1BkmkeTTN+BPD1Fqhgkz4gmMvr0CODC8+ULzUN
         TKG95r01blvAEB5JGjNEQS+bfW4+LRozpxoENOxCrsW3rMl0sxrrag7MtIUoPYjquSCo
         9L6O22OOWoqRC/u68dcqo/A7CdoMC6oHHMvR1EEly8Fp1iCLKGFq/SRLy24kgRS39JEN
         N9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700769898; x=1701374698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSloKbp86UiyOswV753VKR+ULy2TcPDIFU6JTx1BHg8=;
        b=YMUoMhxsLVwMAi/Ok+3JgBpa/r68j+iYgYIfJw7UOb/X+ex10+Kzhi6OtJchptHDCV
         NfqrtQDF3yK4wXL0OYNAjNUprqw9BCjwpO3LCEiQUHPU5/J9TPDzuTdAzK7efGmMnYoZ
         8pxNMxrBcKpd1wtVZ/sM0tGBg28RqBeGm1KUeOWjI02L/hsy14/Wa/uYDT0AAKUQcLPk
         1CFcJn6xu9l5x9ZNabkOKJhf9vokA/SWrYmOS6jg40tia+5k29Rfz1Lv9TWzXWhdyhCB
         VX2Dj3fPlzatlt5nQlyPFZOI+je64bnEaXOuGlw4sg1jdmELiTWLvKiuQgF54MwNW5/1
         z+ag==
X-Gm-Message-State: AOJu0YxOJsXvavqHLO8c5OgDao1iqCSXATWWFETA/E55iNDclKgSfs/2
        JTVKFESEVByb1EjTMHxJZoAQ2Q==
X-Google-Smtp-Source: AGHT+IFkd3TNIFngcpqmaOP6yzGlh39X9sE8ua0oX03sz71V9GSS4EYsfgihju9WseoKWmkyNlYZlA==
X-Received: by 2002:a05:6a20:e11a:b0:185:a0eb:8574 with SMTP id kr26-20020a056a20e11a00b00185a0eb8574mr901433pzb.5.1700769897643;
        Thu, 23 Nov 2023 12:04:57 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id z12-20020aa791cc000000b006c0316485f9sm1604516pfa.64.2023.11.23.12.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 12:04:57 -0800 (PST)
Message-ID: <dd7290ed-800f-4523-864d-45b5c2dc93cf@kernel.dk>
Date:   Thu, 23 Nov 2023 13:04:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] nvme link failure fixes
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-kernel@vger.kernel.org
References: <20231122224719.4042108-1-arnd@kernel.org>
 <ca200ed6-a70e-401e-b862-f690368e0266@kernel.dk>
 <a9ef56fa-725f-4d18-b408-ce0ba13c2d6e@app.fastmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a9ef56fa-725f-4d18-b408-ce0ba13c2d6e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 11:25 PM, Arnd Bergmann wrote:
> On Thu, Nov 23, 2023, at 02:42, Jens Axboe wrote:
>> On 11/22/23 3:47 PM, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> There are still a couple of link failures that I tried to address
>>> with a previous patch. I've split up the missing bits into smaller
>>> patches and tried to explain the bugs in more detail.
>>>
>>> With these applied, randconfig builds work again. Please either
>>> merge them or treat them as bug reports and find a different fix,
>>> I won't do another version.
>>
>> Applied, but had to hand-apply hunk 9 of patch 3 due to a previous
>> attempt at this:
>>
>> commit 23441536b63677cb2ed9b1637d8ca70315e44bd0
>> Author: Hannes Reinecke <hare@suse.de>
>> Date:   Tue Nov 14 14:18:21 2023 +0100
>>
>>     nvme-tcp: only evaluate 'tls' option if TLS is selected
> 
> Ok, thanks for merging my changes! The commit from Hannes
> is what I had in my v1 for this, and it was a correct fix
> as well, my patch 3/3 was just a more elaborate way to do
> the same thing that I did since Hannes did not like my
> version at first.
> 
> The 23441536b6 commit was not in linux-next yesterday, so
> it looks like our patches crossed paths on the same day.

yeah, it was just recently merged, which is probably why it wasn't there
yet and you didn't see it. Not a big deal, easy enough to resolve - just
wanted to make sure you knew about it. It should all be heading upstream
shortly, just sent out the pull.

-- 
Jens Axboe

