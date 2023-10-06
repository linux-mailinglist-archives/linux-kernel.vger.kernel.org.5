Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EB07BC30B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbjJFXp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjJFXp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:45:56 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E5BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:45:55 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79fb8f60374so24105339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 16:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696635954; x=1697240754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwALpqDQCcQrYqpE5W+6VpYG6KweS9qs1qffrleQgRE=;
        b=Sk6wduMOPc4rUCfR9JV68tjr+9g9zE97VrGGvcQ20hpouKphJCceLXzyXd4hyR1WiV
         DP/x/lqBIYsiz9/Qp8eVz7/eihgRTxsjvlMxkpFBM7IdHbSGqDnnC3f6UsyF+iMer9xJ
         AqrCDxmOyMH8dGKS95XjmmKLtZF29G8U6mCA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696635954; x=1697240754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwALpqDQCcQrYqpE5W+6VpYG6KweS9qs1qffrleQgRE=;
        b=gL3zpqEAMNL8cRfm8dMBNJzDANglTMGRpysMeHO5fFzmsuwtOd1/n2g4rkxwUVLE/l
         NPfqQQuxxqQA6m4ewU/SRXNOuHyrf7IxiQ2CP87UWHN7VNhrefoT5OqYHDfNU8qFm+Sw
         1MJipo9Cw8eJiFtg/xtNhrG194b4ilSOCZt/v+9HI+kptBWDiNcIDXZnUy6MgfHBfVXR
         4/smtCJGS+xIVCPsddvtcWtxRYuskf3Iq/QEU/QsqiFp3kxUB6wES59BI/ev4VjVkH+Z
         cbl9sGPCYXidgN5GvhF4RxjnN+p9w+6Cl6paDPARpJ8lPzdqV9x1detdZmDglvbRSKbU
         /kWw==
X-Gm-Message-State: AOJu0YzzwUV/JG1NZ0dwomV0+M7m7IKtWLAk2jpG93mgvwBHLy05uEMy
        2H2O/xkNxFAQih6cggellxDlLQ==
X-Google-Smtp-Source: AGHT+IFWjgCfteMJKA7Ko5UEmiUhVCiC4lvGalS8vluElZp3adwfyiwGFZhGgdVb2pxwbng2ZkTthQ==
X-Received: by 2002:a05:6602:3a05:b0:792:6be4:3dcb with SMTP id by5-20020a0566023a0500b007926be43dcbmr9810780iob.2.1696635954574;
        Fri, 06 Oct 2023 16:45:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q10-20020a056638040a00b0042b03d40279sm697231jap.80.2023.10.06.16.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 16:45:54 -0700 (PDT)
Message-ID: <d663a8f5-c91c-404e-b866-dc6a6188bc8a@linuxfoundation.org>
Date:   Fri, 6 Oct 2023 17:45:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] selftests: capabilities: remove duplicate unneeded
 defines
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230805073809.1753462-1-usama.anjum@collabora.com>
 <95fc0e92-79ed-4748-a565-a82469d087f6@collabora.com>
 <9c0dae5b-a7ee-4399-abf3-883a5946f2f6@collabora.com>
 <1c0ce608-20a4-4b72-8d5e-5308e119959b@collabora.com>
 <369f876c-be07-41d9-b2fb-ec7d629f2d9b@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <369f876c-be07-41d9-b2fb-ec7d629f2d9b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/23 04:09, Muhammad Usama Anjum wrote:
> On 10/6/23 1:33 PM, Muhammad Usama Anjum wrote:
>> On 9/4/23 3:48 PM, Muhammad Usama Anjum wrote:
>>> On 8/22/23 1:57 PM, Muhammad Usama Anjum wrote:
>>>> Hi Shuah,
>>>>
>>>> Christian Brauner had picked [PATCH 4/6]. Others are still not picked.
>>>> Please have a look.
>> Shuah, I thought you had picked up these patches. But I'm unable to find
>> them in the linux-next. I'll be re-sending 6th patch separately. Can you
>> please pick up patch number 1, 2, 3 and 5 to your tree?

I though I picked these up. Looks like I didn't.

> Sent v2 for your ease. It has same patches.
> https://lore.kernel.org/all/20231006100743.1631334-1-usama.anjum@collabora.com
> 

Thank you. They are now in linux-kselftest next.

-- Shuah

