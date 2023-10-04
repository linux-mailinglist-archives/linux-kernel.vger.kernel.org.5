Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC827B86B4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjJDRhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjJDRhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:37:02 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8317A7;
        Wed,  4 Oct 2023 10:36:58 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so17504b3a.3;
        Wed, 04 Oct 2023 10:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696441018; x=1697045818;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g29tpi2UnIBTW31PgclWidtbuPMj8CfZn07mYSfvtsM=;
        b=qQP4sdMIAAtgVfLmnYyVPRvyzkMAPFL61LG/c5KoWZHO8jacy0fIZqFss4YoRsaofY
         3JzSkfekjL3WQISXO1VT1ZSlYRbS2F+uCEjDIieoLLE4PA7lV16NDDLza4JOgEEf47AJ
         VUWO66nUXw0Mnn7ojwn+jGljiXSpIdVw1FDtxBX/V2bhj+AfMl4R6ZIh6wYzW3TouVaV
         r4UyuIOfF8GZI5kcUa1RX3FljLzbBwZ1g48uL1JYj/IVAT9npSUKshhS6o8uR34+PEDw
         vLAoaD9ozQF9+dYTjIqyIqkJp09X2hklcn+6s3ZJ/fNvlQNcfSO23fwn4RVNbktesuxd
         8dJQ==
X-Gm-Message-State: AOJu0YwGZJIjSipWcQFgODGPG5F+VTuZO+L1cYGXL4RQ7tcSRqseOgLw
        4sdE7b2rfFhLrbG7ZkhFnRxSdiqlgaU=
X-Google-Smtp-Source: AGHT+IHCZWk9ZETBxOJ3ukGft40tk77E0oF5ppNLkTAP7tZ8Pr+6WS3Df7g6DQ/xXKvdRG4aD6Q+bA==
X-Received: by 2002:a05:6a20:7fa8:b0:159:c2d0:9fc6 with SMTP id d40-20020a056a207fa800b00159c2d09fc6mr3529835pzj.8.1696441018078;
        Wed, 04 Oct 2023 10:36:58 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:969d:167a:787c:a6c7? ([2620:15c:211:201:969d:167a:787c:a6c7])
        by smtp.gmail.com with ESMTPSA id n18-20020a62e512000000b0068ffd56f705sm3510725pff.118.2023.10.04.10.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 10:36:57 -0700 (PDT)
Message-ID: <bef7887b-6bf8-4863-b3b8-800df12f91e4@acm.org>
Date:   Wed, 4 Oct 2023 10:36:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] readv.2: Document RWF_ATOMIC flag
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, djwong@kernel.org, david@fromorbit.com,
        himanshu.madhani@oracle.com
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
 <20230929093717.2972367-3-john.g.garry@oracle.com>
 <9ba10b14-931b-42db-b7c2-e6f9aa95e477@acm.org>
 <dee45e9a-6a45-e949-2b46-1373fea8dcda@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <dee45e9a-6a45-e949-2b46-1373fea8dcda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 01:47, John Garry wrote:
> On 03/10/2023 20:25, Bart Van Assche wrote:
>> Additionally, shouldn't it be documented what value will be stored in
>> errno if the atomic write has been rejected?
> 
> So I was treating all atomic writes errors which don't follow the 
> "rules" as low-level I/O errors, which is -EIO. However, yes, I can 
> document this. Further to that, based on description of an error for 
> O_DIRECT, which is to return -EINVAL for misaligned, I think that 
> -EINVAL may be better for any atomic write rule violations. OK?

That sounds good to me.

Thanks,

Bart.

