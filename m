Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5117C5F99
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjJKVyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjJKVyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:54:16 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0C6C4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:54:12 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7a24c86aae3so5701639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697061252; x=1697666052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+WmDnmtn43/fhK77i3ikEqdFMWWB4Npron6CccFQK8=;
        b=Fn5JL8VUgbigQjRLNEoBUKdCj/Si74J9WkW+2FDfb4gCVupynvnQgcX5B9B+vaoI8P
         tLUn2urWu1Hz2ZHssxtt40bS44ByKOBWei/qqjjqG/cnH0wO8ls8DggQ+iXsljTR3Bk4
         iYTGJtzY+EmFOP2qs2xQYCKmB+5HbD7C8We780UGaldipJjDWFN7kDCpQIBe6Srz1rRS
         goNZHDjrhz1ShQv+LJpQm9oHIflpurrH4x/Y/Lr3BlwVIjCEOqR6YXVE22QzwIQBOxjK
         +faZqXpy5hSMSzAAa9pUDziUXhqGdTbse6+Ayfra1VQnRz/k8iLQvG03apQ7LxRH8Gln
         MAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697061252; x=1697666052;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+WmDnmtn43/fhK77i3ikEqdFMWWB4Npron6CccFQK8=;
        b=Hlb5azlDHsA3xzS4aBtDVxMewVk7SiUqYT0HORIfbcx5Fivx9YhPgdrXKrBgESeUQv
         vcy2pPLXLMXPS1MMZamySmGEntIhUpNp9f/RXCRtMf0FK4cAMbX68hY/04h//yqtJfQg
         QTpL4jxIbS+UY+C145M7/9kcnNRIa8K4WtLjZmJrPVWK2Nex9wjVsdEgnvQeA8KEKAFr
         /qkmM/oFBYBaRBDoV2i6aHovi+1ONVx0jwrKpanWpqnGEAHzlFvUKxwL3SRjoPwEWIsg
         Tus63IrrKWe5rKIRwfTUALOb7sFGdyNXOuEOFHPp7xvNueLtEqVJqhNBFE+0szB4Ob6f
         V8eg==
X-Gm-Message-State: AOJu0Yy8k76UMqj/9y0EUWYhyWzbgkwOa4LR7RAU3dprkZkXR2mJXey0
        wrzL+u+mU92rpb79YSmGYXByjg==
X-Google-Smtp-Source: AGHT+IFOnwcS9Io13fTYmd4tFOslv8p8Ucz3NNFkLx5qrd1CxmroPKPHhrf2oeN9KXrFqSAY64/KPA==
X-Received: by 2002:a05:6602:3a11:b0:79f:922b:3809 with SMTP id by17-20020a0566023a1100b0079f922b3809mr23849277iob.1.1697061252038;
        Wed, 11 Oct 2023 14:54:12 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m11-20020a02c88b000000b0042b35e163besm3635311jao.88.2023.10.11.14.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 14:54:11 -0700 (PDT)
Message-ID: <8edda030-9394-4252-bf43-3cb1207cf640@kernel.dk>
Date:   Wed, 11 Oct 2023 15:54:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Don't invalidate pagecache for invalid falloc
 modes
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>
References: <20231011201230.750105-1-sarthakkukreti@chromium.org>
 <b068c2ef-5de3-44fb-a55d-2cbe5a7f1158@kernel.dk>
In-Reply-To: <b068c2ef-5de3-44fb-a55d-2cbe5a7f1158@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 2:20 PM, Jens Axboe wrote:
> On 10/11/23 2:12 PM, Sarthak Kukreti wrote:
>> Only call truncate_bdev_range() if the fallocate mode is
>> supported. This fixes a bug where data in the pagecache
>> could be invalidated if the fallocate() was called on the
>> block device with an invalid mode.
> 
> Fix looks fine, but would be nicer if we didn't have to duplicate the
> truncate_bdev_range() in each switch clause. Can we check this upfront
> instead?

Don't see a good way to do it on my end, so let's just go with what is
there now. I applied it with the commit message reformatted.

-- 
Jens Axboe

