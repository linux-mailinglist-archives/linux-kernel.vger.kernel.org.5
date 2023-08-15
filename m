Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9DC77D4D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbjHOVHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239968AbjHOVGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:06:43 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099871B2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:06:42 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-790af3bfa5cso71675839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 14:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692133601; x=1692738401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ztLnjM2bT7vmtp/V6hmceBoe8bOCHnQ/mTwytlgMJ0k=;
        b=P1/t/kHsKTxx7aLVHwTvVN6FXN2EqSV0VXYYogCZouU+XE8hV3iXyqyJlRRR120XxY
         CTyORPHhGsqstcShVUHuVYcbs8C+Rj0RF/XEWUxqblHoMakuDm5pTFM8rYmNO/bprU62
         8POVTIbxNYDyQeA2JZrpX30bdCEb3+CqB+fSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692133601; x=1692738401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ztLnjM2bT7vmtp/V6hmceBoe8bOCHnQ/mTwytlgMJ0k=;
        b=HHuShkXAQ00oCkzzgVk3fjbEhiMRBhS5D1xwo3OhptMH5GrAQEC3ajL7nL7V6kEo7V
         em7Vqjtta1P915JCOKxgpBTkdBc0UOtcjEeMC0mOTi9FjOrglFotcJs0BLxS/QfbjK4I
         PTzOTdfQ/F39xKjUXc9cj25EBN02EKC739rsojLm25RCNTSNbPSlC6y59769gXZbmfUm
         uRMPW/+ndVKibYGgKucRu4wtJoAevq1cEjuEQmirwGuY0EZcxjxGm41GbIa3ykOiYS7h
         WSI65sstq8LS4ToMHBPW7pc7kZjvoqeC8B5odJXoi+mmDlCEOYVcAcJZuG4YC4dodyDg
         5RDA==
X-Gm-Message-State: AOJu0Ywdofs7P7rniUp6RW/zcTO74qAkeOdhoGTaT/4H5Spqs51dZbAP
        tQC8XJNevzWFlO4ivAGD23tRrQ==
X-Google-Smtp-Source: AGHT+IFUXyZf8I8S5b3XfgFxHspACqwcGfGxF/4GQIdz13SeeG7e3I4G1dL3njsF8dW7XfS0jKSGDA==
X-Received: by 2002:a05:6e02:549:b0:349:385e:287e with SMTP id i9-20020a056e02054900b00349385e287emr113728ils.1.1692133601393;
        Tue, 15 Aug 2023 14:06:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c18-20020a92cf52000000b00348d2e9701csm4140269ilr.63.2023.08.15.14.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 14:06:40 -0700 (PDT)
Message-ID: <85a03aa3-3d6e-3b16-d113-7d7f5a84bfb4@linuxfoundation.org>
Date:   Tue, 15 Aug 2023 15:06:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [GIT PULL] nolibc changes for 6.6-rc1
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20230806172245.GA26239@1wt.eu>
 <3efa3710-4e8b-d187-a24d-ff85858e37fe@linuxfoundation.org>
 <20230815143540.GA15075@1wt.eu>
 <29590d7b-40fd-0426-75c6-36667e344f6c@linuxfoundation.org>
 <9950607c-cafe-c011-7d5f-76a8a971beb0@linuxfoundation.org>
 <ZNvIkD1oxZENVkoe@1wt.eu>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZNvIkD1oxZENVkoe@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/23 12:48, Willy Tarreau wrote:
> Hello Shuah,
> 
> On Tue, Aug 15, 2023 at 12:13:24PM -0600, Shuah Khan wrote:
>> On 8/15/23 08:39, Shuah Khan wrote:
>>> On 8/15/23 08:35, Willy Tarreau wrote:
>>>> On Tue, Aug 15, 2023 at 08:25:51AM -0600, Shuah Khan wrote:
>>>>>> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
>>>>>>
>>>>>>      Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
>>>>>>
>>>>>> are available in the Git repository at:
>>>>>>
>>>>>>      https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ 20230806-for-6.6-1
>>>>>>
>>>>>> for you to fetch changes up to d98c1e27e46e47a3ae67e1d048f153598ba82611:
>>>>>>
>>>>>>      tools/nolibc: stackprotector.h: make __stack_chk_init static (2023-08-06 18:44:47 +0200)
>>>>>>
>>>>>
>>>>> Hi Willy,
>>>>>
>>>>> I am sorry for the delay on this. I was traveling last week
>>>>> and getting back to digging myself out of emails.
>>>>
>>>> No problem, thanks for getting back :-)
>>>>
>>>>> I am having trouble pulling this request though:
>>>>>
>>>>> git request-pull https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ 20230806-for-6.6-1
>>>>>
>>>>> gives me the following error
>>>>>
>>>>> fatal: Not a valid revision: git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/
>>>>>
>>>>> I don't see a tag at https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
>>>>
>>>> Ah sorry for the misunderstanding, that's the branch name, I'll set a
>>>> tag then.
>>>>
>>>
>>> No worries. Could you also share the test you run? I will pull
>>> you request and run tests.
>>>
>>
>> Please send either another pull request or send the tag details.
> 
> I've pushed a tag named 20230815-for-6.6-2 in the repo below:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
> 
> Please let me know if you want me to resend a PR.
> 

Pull worked fine and my verify_fixes script failed on the following patches.

Commit: 6c931bf0c732 ("selftests/nolibc: avoid buffer underrun in space printing")
	Fixes tag: Fixes: 8a27526f49f9 ("selftests/nolibc: add EXPECT_PTREQ, EXPECT_PTRNE and EXPECT_PTRER")
	Has these problem(s):
		- Target SHA1 does not exist
Commit: 40f12898b479 ("tools/nolibc/stdio: add setvbuf() to set buffering mode")
	Fixes tag: Fixes: ecb7fe2cd610 ("selftests: line buffer test program's stdout")
	Has these problem(s):
		- Target SHA1 does not exist


Will you be able to add the right commit IDs and resend the pull, so there
are no mistakes if I guess it wrong.

thanks,
-- Shuah



