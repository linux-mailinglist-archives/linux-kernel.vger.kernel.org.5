Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FFD76574A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjG0PTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbjG0PTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:19:01 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B302A35A8;
        Thu, 27 Jul 2023 08:18:44 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1bba48b0bd2so6616425ad.3;
        Thu, 27 Jul 2023 08:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690471124; x=1691075924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0vvwsh2rxMF2ShvbYgqpo5URMyKXI0NTlXbCxD/+r0=;
        b=OJMEagHZlltshrpNvB0cP9IZYZDEKxFCzK1m7MZt2AIVJv2h7HAO1KjYV9qZtKtRqc
         csATaTvBR4cASw0nWAISGQZiBJiAPGG1g3Bp3zDGoBiHcce5nKOp5opx6NjehHSma7y/
         G/N+LHcv0IYzPrOSytHTOAZ7wcDrpzQMawCKlrXPqW0s0FwvbW2PksTt2IvoC+iz7F9c
         hhsdxA+jLU9m6kc8q0iG/Vkl1ZLcPODNAOxLjYhsKRv3oBVv31An4fa4jeYkyAOMUCLE
         m7eJEb8RRzQlAbiAEcCxMrJuQgOdMilytZ/PNBCDYvyyt9B9xgtLcpLtHw6jXvYuTzEI
         Rtdg==
X-Gm-Message-State: ABy/qLakebZ2N7Shi1TxXBEFHj3qgqBTwl1c1jDWbi2V2+vdcixw87Td
        D9hwhce9v02pjFHz5FwfRdE=
X-Google-Smtp-Source: APBJJlG+bh/RGLvfVKFEqRfijkNNCjs6JeTHl2tGDJdRVSJtDHktXPCXP8zZXKWwmTtRjnw0V8qL1Q==
X-Received: by 2002:a17:902:e550:b0:1b5:5a5f:369b with SMTP id n16-20020a170902e55000b001b55a5f369bmr5439261plf.65.1690471124010;
        Thu, 27 Jul 2023 08:18:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:32d2:d535:b137:7ba3? ([2620:15c:211:201:32d2:d535:b137:7ba3])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902ceca00b001b872695c1csm1748294plg.256.2023.07.27.08.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 08:18:43 -0700 (PDT)
Message-ID: <c3bff0d9-957a-fbb7-a433-4cab457c62bf@acm.org>
Date:   Thu, 27 Jul 2023 08:18:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 01/11] nvme/{003,004,005,013,046,049}: Group
 all variables declarations
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-2-dwagner@suse.de>
 <7e4f6c51-43f4-c039-07bc-6724748a1d3e@acm.org>
 <kya2ayzcgz7iemknkx6xuef4m37f2ms7rt3uxamtxr2w7zbwfc@onladguxa7bk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <kya2ayzcgz7iemknkx6xuef4m37f2ms7rt3uxamtxr2w7zbwfc@onladguxa7bk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 00:11, Daniel Wagner wrote:
> On Wed, Jul 26, 2023 at 07:54:24AM -0700, Bart Van Assche wrote:
>> On 7/26/23 05:46, Daniel Wagner wrote:
>>> Group all variable declarations together at the beginning of the
>>> function.
>>
>> An explanation of why this change has been proposed is missing from the
>> patch description.
> 
> Sure, I'll add one. The coding style to declare all local variables at the
> beginning of the function.

Isn't declaring local variables just before their first use a better style?

Thanks,

Bart.

