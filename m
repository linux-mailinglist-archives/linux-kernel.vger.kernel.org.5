Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79E4788D65
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344071AbjHYQqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344049AbjHYQq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:46:27 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FD79E;
        Fri, 25 Aug 2023 09:46:26 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-68becf931d0so942610b3a.3;
        Fri, 25 Aug 2023 09:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692981986; x=1693586786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHst9wbGGDzmwYR4dacoLOvw9Cpq6xs5Zent4DwnkY0=;
        b=SDxkL5tq4CisvSJaB0Q32/lxIzvJoyrWPXZq6yN4962OIU8QbmzulTigcuPWvl9GXv
         MR35hAa5k4bPe1hHmgKqRARVN/Gs/de/mevLhMiG5TtiGxgmoZl4asMO1jVEC4BtLT+/
         HXfyOmpNMtVG2qZB0b5Z7b4uN9fz1RSHwksIlgiuHIhDB6kd56v8QCiVcl8dm8suZ4Ti
         ALTWHHSMyogsfCjFIlLn5rffv00i+RODp3Ozos0GZjetHql14a1/YSqT5FUq2qOXxhIk
         rlqrFQPR/2Sy+GbhdXa+d8yAUaO0sqBu35OsFovlrmtQMkCsnP/DZxl0oFd19X9SKVZW
         UuaQ==
X-Gm-Message-State: AOJu0Yx2JqfwpmkAbLk2H34QR2ZlK3C8/pOgg+kUAdha//12MYCbua5Z
        Jwqm7iLeZpfR3xIBRbWMZo12ZtIxn9s=
X-Google-Smtp-Source: AGHT+IF9CTZFuL1sZYQ1i3g6DcqcFpfaEsUGiGnEp/VyHT/Pw4GdDjdXgA2fmEjv4iNlkpotHMciMw==
X-Received: by 2002:a05:6a20:be30:b0:134:a8a1:3bf with SMTP id ge48-20020a056a20be3000b00134a8a103bfmr14583151pzb.30.1692981985492;
        Fri, 25 Aug 2023 09:46:25 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f521:8fc8:bb3a:811c? ([2620:15c:211:201:f521:8fc8:bb3a:811c])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b00682a61fa525sm1821522pfb.91.2023.08.25.09.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 09:46:24 -0700 (PDT)
Message-ID: <d6ec4e54-1ec9-648a-ce8c-1e08a439c3c6@acm.org>
Date:   Fri, 25 Aug 2023 09:46:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
 <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
 <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/23 07:26, Daniel Wagner wrote:
> On Fri, Aug 25, 2023 at 06:45:25AM -0700, Bart Van Assche wrote:
>> I don't like the "new style". What is so hard about typing "$@" to pass all function
>> arguments to _nvmet_target_setup()? Leaving out "$@" makes it much harder than
>> necessary to figure out the intent of the code author - not passing any arguments
>> or passing all caller arguments implicitly.
> 
> Because "$@" is just not correct.

Why not?

Thanks,

Bart.
