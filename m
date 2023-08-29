Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424ED78C63C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjH2Nid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbjH2Nh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:37:57 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFC11724;
        Tue, 29 Aug 2023 06:36:53 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-68c576d35feso1620438b3a.2;
        Tue, 29 Aug 2023 06:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693316154; x=1693920954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58tJu8HS3Uk+gerFXyZAfcbbsx2SaXKrB/OzNfMroZM=;
        b=VbLdHmRCfhdCyZtcnKq4nqIYarSiDFkPrni7iZrgGJpkMT9jFzhsJ4gP9Ik4tkyd5v
         CRvNLS43hZFn9BAm8B3x77xNudamE3dvyzmjZNAw6yC9f0yHlolE2M+2pNKQUlYNhN3i
         E6f84Rxf51D23V/+5WFb7ieyGH7xNguUfBoNPfn6O2W5YYB/rRCOFB7wQmQT9Dkhg4Mo
         q7ajMa1RJJr+/+mmjQ/5S4pLumbxh76XBLcboBI0vII17B98XsjZZVmdcRbFBtdpEC/H
         SZO2v9UYHHXNfYDTmISsrZpvRHSpM+tLagWDZqzODOzP71A5Hnj2bdExjF5uRoCxFebQ
         zthQ==
X-Gm-Message-State: AOJu0YzaEFltc9CG3xB9OKUqjsxRGCzBuYQB1Fzk9RMXrpadPy+ovNCa
        K7tOXFxOKiOtZKmKxMpuxl0=
X-Google-Smtp-Source: AGHT+IG9aL/VbyawH5cxLpKPv48bF/ifjtaCOBxvr16QlUWtHvl9BmANrS6abaZiiejyKlhA6FbCiw==
X-Received: by 2002:a05:6a20:6a05:b0:13f:9cee:ff42 with SMTP id p5-20020a056a206a0500b0013f9ceeff42mr35105172pzk.41.1693316153610;
        Tue, 29 Aug 2023 06:35:53 -0700 (PDT)
Received: from [172.20.4.71] ([208.98.210.70])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79156000000b00666b012baedsm8485174pfi.158.2023.08.29.06.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 06:35:52 -0700 (PDT)
Message-ID: <3b5b246f-386d-4afe-a20d-4b08770bd4cb@acm.org>
Date:   Tue, 29 Aug 2023 06:35:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
 <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
 <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
 <d6ec4e54-1ec9-648a-ce8c-1e08a439c3c6@acm.org>
 <ckuewnzuiejug6jbuxfw4viqwf4v43pq54mj4k4qbq7uz3zwpn@3iijcby24ujd>
 <8ffb6c2f-0836-4302-82b9-902e092e537c@acm.org>
 <txsyjpcxb3baog5fgqdnm5hh765nt5qcbcmllsto7uulyzr5kn@zirmqldhosbi>
 <ed518b56-a579-49bb-b2bb-220214ef6e2e@acm.org>
 <ptqdqjo7xt5qsijmuftmboutck5bpwm2wjrwks5lr4l44ssvjy@iurtgbaxnoji>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ptqdqjo7xt5qsijmuftmboutck5bpwm2wjrwks5lr4l44ssvjy@iurtgbaxnoji>
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

On 8/28/23 19:11, Shinichiro Kawasaki wrote:
> This is the unclear point for me. Does bash really pass the arguments list of
> the caller to the callee when functions are called without arguments?
> 
> Looking back the commit 852996fea4f1, you explained that bash does, and I
> agreed. But now in my environment bash doesn't. I tried the script below in my
> environment, and see nothing printed.
> 
>    funcA() { echo "$1" ; }
>    funcB() { funcA; }
>    funcB foo
> 
> Then the arguments of funcB is not passed to funcA. How does it run in your
> environment?

I see the same result that you see. It seems that I misinterpret the 
text produced by shellcheck if it reports warning SC2119. After having 
reread https://github.com/koalaman/shellcheck/wiki/SC2119, I'm OK with
suppressing warning SC2119 because that warning doesn't seem useful to
me.

Thanks,

Bart.
