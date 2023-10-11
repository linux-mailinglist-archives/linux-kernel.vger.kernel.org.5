Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FCC7C5F02
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjJKVUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjJKVU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:20:28 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D61BA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:20:23 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7a24c86aae3so5332739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697059223; x=1697664023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ou8Z46f8D4HFatkbCIXSPvYGp0xJZP5BFrXKyDUAkb8=;
        b=UF0kV8pV6PLXJQZTfcAz8fMCCu95vvysIrVgLfw7KXN6b+rj1fvrGma2s95TnW+b4o
         dTo/1+BaNzpFZQQfebrQlIVn7wv8cTzUa0Lq2kGNOmHMinMMhpTThQG2TQW++IuRBDQr
         syji2/W3mWJgdaPef0BtqZhZuxyGfjDKlHAo+DbDFXRYhS+mMGswm64OTTnx7ZLk45gi
         HYC5Gm/vpdwTLHyhZvbLFQTjHmf5a/ckf9F1fcoRJH/0mM8C0UlyveM0BkAThZaZVdmM
         LU4H19B3lae3+MmmgCmTI4PeQsrxfkzqZenH43aFTuPii9wuPQ0GRmxjg5gVqnSlqezc
         ttuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697059223; x=1697664023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ou8Z46f8D4HFatkbCIXSPvYGp0xJZP5BFrXKyDUAkb8=;
        b=uR8q8xH9EhxBJy1Di11pUZYXyJxGPxX87VW99fZzhj0Th+A5EOTz1QeYOIa+ZIWnWR
         rWmzXnN1nh39RgJXGP7tc0CHyu8P10GFrtCrVT/GwNgKt3H647aavhWmnbHbuCgLpHy5
         n/4BsBy+x0y+JXh5RcKbmAQVIpvWxUFdmwYmNkSh2UQ1T8NhfoArU3CHexnm8eOptexm
         F5ukhXSe+goHup51Nd7jDe1W0TNd4Z5uQsIpwSBq9he70/LxbstfdypdZ+JK8Tx8iXR9
         ZzSlCegz8gFxgnJ4P7z2CBHRdGoNsWdZ+P2nSX9mN5CxEc2dpfNZIOWr1LL8EO9xdx13
         jBfA==
X-Gm-Message-State: AOJu0YxiOBFtFJj3qRSd6aSUELMwJMyO1qhN8i7BV3fgIUmcx8UzwR9Z
        Xmy+aTfwqg9bCtwh33XM8aobxg==
X-Google-Smtp-Source: AGHT+IFDYfOpCNUhep+7IgWh6NGfsroxNM+d8ImbLUEV1kcWszBBlrRw4fvIGqhVskXuEnZ7Ig6CRQ==
X-Received: by 2002:a05:6602:3a11:b0:79f:922b:3809 with SMTP id by17-20020a0566023a1100b0079f922b3809mr23781388iob.1.1697059223057;
        Wed, 11 Oct 2023 14:20:23 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c18-20020a02c9d2000000b0041fb2506011sm3547225jap.172.2023.10.11.14.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 14:20:22 -0700 (PDT)
Message-ID: <c337dd4f-e363-48d1-8ac0-a62da3e1a741@kernel.dk>
Date:   Wed, 11 Oct 2023 15:20:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block: Don't invalidate pagecache for invalid falloc modes
Content-Language: en-US
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20231011201230.750105-1-sarthakkukreti@chromium.org>
 <b068c2ef-5de3-44fb-a55d-2cbe5a7f1158@kernel.dk>
 <ZScKlejOlxIXYmWI@redhat.com>
 <d5e95ca1-aa20-43da-92f8-3860e744337e@kernel.dk>
 <ZScOxR5p0Bhzy2Uk@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZScOxR5p0Bhzy2Uk@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 3:08 PM, Mike Snitzer wrote:
>>>> Also, please wrap commit messages at 72-74 chars.
>>>
>>> Not seeing where the header should be wrapped.  You referring to the
>>> Fixes: line?  I've never seen those wrapped.
>>
>> I'm referring to the commit message itself.
> 
> Ah, you'd like lines extended because they are too short.

Exactly, it's way too short.

-- 
Jens Axboe

