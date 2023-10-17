Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1D7CC745
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjJQPS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343858AbjJQPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:18:53 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674CBBA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:18:52 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fab2caf70so43118139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697555932; x=1698160732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bz97LhBkacNLFF9w36L/GNfl1rta6H61fr6CWjLcmb8=;
        b=VB1Kjl//9dIeIaWjQNJnaV47eQkeXKMb/Q3wFtvqM11QH+LzSxN7idiTSGeRpMTyIj
         +7dSIm+Eqj2jc6H7S0s7vpGQbPpcrmKVyCe8NR066V6pblIgAEAfuyAzwWn55B08jwN5
         LCoLD4WLh+hkq1mooc+0nyBz0y9h7RyK01qK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697555932; x=1698160732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bz97LhBkacNLFF9w36L/GNfl1rta6H61fr6CWjLcmb8=;
        b=UMd6ANO3y0Pfx0m4P62dWKC2vyF4dhe06ClEKT4HLwMQxXW0z90jA3rkJc/zz+6ECb
         TWN/Apb5lvbIGKkTIf2Shq779QoNCt0WOiDYG0IWTinlAkVLwO7sIilGPjeRz/V2WAMp
         jKq0t0SFOj6VRVy3ou2FcVjC+mUoGlwILubc6j+ago12Lgfqw3P9I2WO+sM+gYBU7yKJ
         ULMe40ygU7kD0WDU5Fi5NbkhZKMZRm8Y/NsGmZAWZSoXrQYt26WhhiEXeFE8ti788CX2
         mUZ6bLOLw6+5xY3jtNdV0bOg1lcUzCNOs0kaFfE09m0t2DfcZPpJNzLPIJ9XHq+Zrr6Z
         WpzQ==
X-Gm-Message-State: AOJu0YxhCUWVGwOpt29N12QWViT+RpN52S72+CC7fcjg2Pzer7cRa2sC
        VC/WTOHDCm8zmdJYGIet0OqIXQ==
X-Google-Smtp-Source: AGHT+IF8X1gs2mpDitmtnzm5Hc0+Ux1uFZKtDVwiZlAFVRNviuKOTbPqoVbUCuMiHqToRJK7PZtZyA==
X-Received: by 2002:a05:6e02:3d03:b0:34f:a4f0:4fc4 with SMTP id db3-20020a056e023d0300b0034fa4f04fc4mr2648117ilb.2.1697555931770;
        Tue, 17 Oct 2023 08:18:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c4-20020a02c9c4000000b0042b068d921esm565896jap.16.2023.10.17.08.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:18:51 -0700 (PDT)
Message-ID: <8f07e202-fe60-4e7e-adde-e39a95f7fb22@linuxfoundation.org>
Date:   Tue, 17 Oct 2023 09:18:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patch in the kselftest tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Binbin Wu <binbin.wu@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231017150325.4a89ab71@canb.auug.org.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231017150325.4a89ab71@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 22:03, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the tip tree as a different commit
> (but the same patch):
> 
>    197964fc3274 ("selftests/x86/lam: Zero out buffer for readlink()")
> 
> This is commit
> 
>    29060633411a ("selftests/x86/lam: Zero out buffer for readlink()")
> 
> in the tip tree.
>
Thank you. I will go drop it from ksefltest next now.

thanks,
-- Shuah
