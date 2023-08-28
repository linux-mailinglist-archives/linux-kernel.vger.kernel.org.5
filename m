Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89CE78B7A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjH1Sze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjH1SzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:55:13 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB621A3;
        Mon, 28 Aug 2023 11:55:07 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bf092a16c9so27684255ad.0;
        Mon, 28 Aug 2023 11:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248907; x=1693853707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umflnyFqBYkm4MgelOGwx19oN9oBe5SP3i3J2ZxPkxQ=;
        b=el7WQAhC3uTso+CrYyYTyFpA2mWvmY9Nk0SnMf78ycenwiR0N+lfoor46ifpG3gBaR
         jXggXK1vp23FXKFJ7E8i/JPsg1ACsE/d2CvCK7SCLoCj0T8NaLF99emI6TgD73HlKSm6
         r5Xw8wDPzWl5xetUzlBlxboJg7pwdNANx/V8DPpGBUWh8oKShsOxUeDb8QR2IPk/NF5m
         SHwxO/DROG9XUUei8W1b+HbFU17cMbuAKwsWvPvB0+YOfXlM/xkue+Pvy78NLoCU8sNd
         374pTFAS8oEbHtKJeXKSrxKr+HEmSyEm995/lunjv98Ic1N+xIb7iLpSUWhv0UuV+cc4
         9JIg==
X-Gm-Message-State: AOJu0YwMVM0dxwnS3NbViGBBvns4RDpZGnk3aU8EqosOie5cJQ/L/IFI
        wWQ62vUY4Td3rmEnChqBY7Q=
X-Google-Smtp-Source: AGHT+IG5OnTzChA0NWY4c4vTbc4cYX/NBVucFHt1B0vYzAE05QFD8WTqXl+BXzYAGg4hw/79RtJ9YA==
X-Received: by 2002:a17:902:f94e:b0:1c0:e014:90c1 with SMTP id kx14-20020a170902f94e00b001c0e01490c1mr8249817plb.48.1693248906633;
        Mon, 28 Aug 2023 11:55:06 -0700 (PDT)
Received: from [192.168.165.167] ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c14d00b001b8a3e2c241sm7745382plj.14.2023.08.28.11.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 11:55:06 -0700 (PDT)
Message-ID: <ed518b56-a579-49bb-b2bb-220214ef6e2e@acm.org>
Date:   Mon, 28 Aug 2023 11:55:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
 <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
 <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
 <d6ec4e54-1ec9-648a-ce8c-1e08a439c3c6@acm.org>
 <ckuewnzuiejug6jbuxfw4viqwf4v43pq54mj4k4qbq7uz3zwpn@3iijcby24ujd>
 <8ffb6c2f-0836-4302-82b9-902e092e537c@acm.org>
 <txsyjpcxb3baog5fgqdnm5hh765nt5qcbcmllsto7uulyzr5kn@zirmqldhosbi>
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <txsyjpcxb3baog5fgqdnm5hh765nt5qcbcmllsto7uulyzr5kn@zirmqldhosbi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 10:02, Daniel Wagner wrote:
> I am against adding code just to make ShellCheck happy.
Hi Daniel,

That's not what my concern is about. My concern is about keeping
the blktests source code maintainable and easy to read. My opinion
is that the ability of bash to pass arguments from caller to callee
implicitly (a) hurts readability, (b) is error prone and (c) hurts
maintainability. This is why I think that this feature should not
be used and hence that disabling SC2119 would be really wrong.

Regarding (a), I think this long e-mail thread is more than enough
evidence that it is not clear what the intention is of the
_nvmet_target_setup calls without arguments - not pass any arguments
or pass the argument list of the caller. Regarding (c): if any
_nvmet_target_setup calls would be added in a function that accepts
arguments, how is _nvmet_target_setup() expected to process arguments
of which it doesn't know how to interpret these?

Hence my proposal to change the _nvmet_target_setup calls with no
arguments into "_nvmet_target_setup --" and also to ignore the double
hyphen argument inside _nvmet_target_setup().

Thanks,

Bart.
