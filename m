Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4CC791019
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 04:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350806AbjIDCZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 22:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjIDCZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 22:25:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFF1CA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 19:25:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c1e128135aso4575085ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 19:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693794308; x=1694399108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gWr2NdMRB7w9t/LSaCpp2WEPnGXvp2qwpPt42E19uI=;
        b=FjDhKBsIbtpTUnwtFSAZx0vft3BY1fZi6a2ZfQxQVv2rh6FSVxC+mes3/YbUlryXuc
         eTOOJFYvDfhTIAnBhoPGAqrcSDhYsSzUdsZ4VBWcTI5qtHAIjGEHxsJGyT4ROg8keCRL
         i3zSYkgqKA33DMHuVZD996MfdVvucqyuUnWAOd3M/L21S3+ufb4XHYdx2PISIJDKmEhK
         Y6JE9nNoHcdnAuvlgBWTk790fLUFKpC/rFGr5fQFz34lE8BRxLReMMM53h+reX0eLZFV
         mtElJaGa1Qj0gz1FSqQwsEGQKmrTPyhkpEKF2DsjBeJ5qMHw/fM6lbQRSe8JE1cHQN+y
         hlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693794308; x=1694399108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gWr2NdMRB7w9t/LSaCpp2WEPnGXvp2qwpPt42E19uI=;
        b=CKqcF6JAbbrHf3wmBs7WxESwipKLTc20CaKQPH/GiTMWgNbYBxiNiYd7qOPIduT4+o
         iJvb9IG9hD5l/RMEQx/TBehST770NTV9haeQOK+ZKAh9HaUeptSf4JNvGhOTIa3lfktp
         P+w5gO84kN+MZSlrP9eVCCiTs49B4/G9doijRdjT+jr4ClK8LfVn1sUYjxziChhPCSkG
         akYuqohkpnzjwPn5OgCPC8CCSSg3VSxxVSdmF9GcveObvQ0xr7vAiCvM9PO6ZpqmX0nX
         VJvg1yh15mSi8UU5J01yXjiT+6Pq4T6UAD7SH7Q+Hth3/47qmzYSzX9uFEi2paJDE45A
         141A==
X-Gm-Message-State: AOJu0YwGCgyYwpozg8tJ/MMzwSQcBoKsZ5LM1v5Ifdj8Ezo7UoXIM3Yq
        22f8vjQIgvXt8hWfZOTceMbZQg==
X-Google-Smtp-Source: AGHT+IHTX/NRbGpOQgZI7zKwBvAFLb1aMEEYtQAtzJFeT5lbWnZ7RlEXRfIZNRvsM7fVd17QZ8uBIw==
X-Received: by 2002:a17:902:e548:b0:1c2:9d0:e176 with SMTP id n8-20020a170902e54800b001c209d0e176mr8257613plf.27.1693794308518;
        Sun, 03 Sep 2023 19:25:08 -0700 (PDT)
Received: from [10.5.68.94] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001b89891bfc4sm6450126plb.199.2023.09.03.19.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 19:25:08 -0700 (PDT)
Message-ID: <94b76d95-0ebe-396a-d00f-1aaa4ed00409@bytedance.com>
Date:   Mon, 4 Sep 2023 10:25:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 0/6] blk-mq-tag: remove bt_for_each()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, chengming.zhou@linux.dev,
        axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230823151803.926382-1-chengming.zhou@linux.dev>
 <a84b5ccb-151a-2de1-c213-de68a6f81f29@bytedance.com>
 <13c27994-e372-674f-d265-dc623fae26ce@acm.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <13c27994-e372-674f-d265-dc623fae26ce@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/4 07:51, Bart Van Assche wrote:
> On 9/2/23 07:58, Chengming Zhou wrote:
>> Hello, gentle ping.
> According to https://lore.kernel.org/linux-kernel/CAHk-=wgmKhCrdrOCjp=5v9NO6C=PJ8ZTZcCXj09piHzsZ7qqmw@mail.gmail.com/,
> the merge window opened on August 27 (one week ago). Since we are now
> in the middle of the merge window and since maintainers typically do
> not merge patch series during the merge window, it's probably the wrong
> time to send a ping.
> 

Oh, I get it. Sorry for the noise.

Thanks.
