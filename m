Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BECB76F5E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjHCXAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjHCXAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:00:37 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540A11FF0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:00:36 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a707bc2397so166633b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 16:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691103635; x=1691708435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pvpcCewD9AQ8Eo7cRRrjJpPvWQK+UsN2rBuNcYiJBs=;
        b=Si4mz4moMd7YmB5O1IUzv/QznafgYawJ328Gr8hYaP5+TyS8DTjsZdNkVBaIYcrBXB
         StBKRHxuHIxCb0bcRFJf/EYTBnrffdcpiOd0x3I/3ftnMd0aK9gxc0LiaRLeloBCJPAz
         VC0xLrk0hXeboshpUATBrSTJZY3w8bqFTXhX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691103635; x=1691708435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pvpcCewD9AQ8Eo7cRRrjJpPvWQK+UsN2rBuNcYiJBs=;
        b=Op31NBzPf+ZOemYcMBAV+tm2dy3VQUV4q6UkOPKNtUXvpPOAgUpqdUoBovLdPB9Ymh
         cnd+0pRx1X7+vAoMUWIrcbwywgIoFeyol74zTyhvCXe6LTwNTFZDg1rmCsTNtdsX0vgc
         uBrjvW7gJHjdigJ1pdXleqjZTjZKtENYoNJgy5HvSoijjHEMK0sCO9iMd+vhEFUSyTgb
         hq9xCpEXf6N7r/az3nFQsrhVVLmX7KFUigIq86zX8d8RoHyfB/oPtJ9whtAqTOfFlumO
         cuBf1rG02xjUEz39EDlpKWzTqiJEte+WwiluHpGIW+65xnM9Y4tBgivbwAN1wRur/VHH
         WMHg==
X-Gm-Message-State: AOJu0YxMTuKg9KC/Cb/Q3KkYxDvDl2o+PRBViUJZpo3hX7g2ezFBSqmS
        f8qvbhs3fXBkmCIi1gaJABZPIg==
X-Google-Smtp-Source: AGHT+IFcBoMvQRfeSsOHjbPf6cLNfvYf1F01nwjhQmMTDYXA67ri7QBH/E2zGXtl7XvPtlZqqgY1xw==
X-Received: by 2002:a05:6808:158f:b0:3a7:72e2:3262 with SMTP id t15-20020a056808158f00b003a772e23262mr2211924oiw.5.1691103635620;
        Thu, 03 Aug 2023 16:00:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v7-20020a92d247000000b00348cb9adb38sm279205ilg.7.2023.08.03.16.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 16:00:35 -0700 (PDT)
Message-ID: <8c206fc8-5dad-5df3-7c65-13d8036abcd8@linuxfoundation.org>
Date:   Thu, 3 Aug 2023 17:00:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: duplicate patch in the risc-v-fixes tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230804080137.49f03cf1@canb.auug.org.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230804080137.49f03cf1@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 16:01, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
> 
>    8c82d2bf5944 ("selftests/riscv: fix potential build failure during the "emit_tests" step")
> 

This was applied today risc-v-fixes tree - can be dropped.
> This is commit
> 
>    c77896b143d3 ("selftests/riscv: fix potential build failure during the "emit_tests" step")
> 
> in Linus' tree.
> 

Yes. I sent this in for Linux 6.5-rc3.

thanks,
-- Shuah
