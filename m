Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAC17FFC6A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376636AbjK3UZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjK3UZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:25:32 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A55E10FF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:25:39 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35c9cba4fa6so266055ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701375938; x=1701980738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tJRwlgJXY8zfS6Dn3Qyvps6vNutTsbWo0ctzy0xsDTE=;
        b=RiYYfKHsRtWy65F7tPQdF1zFA3tglx05sTafIx0J5SsOn7lB4uR1ysV9LfDIz/AHAx
         Jib6zMm4JWYwJvFOud9V85hNE0So7EoIBpU8eCq9KelK2qyjxalLrJoMaUCcuD1NT5jS
         pYVdpz0gDXBhKyHd2rP5b3m729w5yNXUupBXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375938; x=1701980738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJRwlgJXY8zfS6Dn3Qyvps6vNutTsbWo0ctzy0xsDTE=;
        b=ANS8b+p+m1JWBe7cmkbewB6wdWVot0rAyg4E0pInkTYi63WkoFjaPIbCz9Ou7sy5m8
         YM8bLEEaGOUx2JUZyOOgLzfdWlly7XFp4I3jsfhN6Cjd7DrgswSGT639VIHTSUsI373G
         UN7vfVfdM4CS9X2PMql0Uvn+e0SXWRGmgQDEgdhSizOI3GdHemocaxldOEH2jPC2HOti
         A/a0qBNfGqppNRrYWnwAoEjOlazQumFozXJpPV+T5AkGpfYCRm6A7L6nDfq9YIf1KIkG
         Rk5DFGe3+SwOCaXxpR98P4AItl8v8mYFEiocRRNNLDOYhY8WDG3RJZhavH9wMa1c9tBJ
         bhWg==
X-Gm-Message-State: AOJu0YyRuVYHWMK3RUHTvj6ycjEE3WTw0OP+M2B5PCImcfUgCZoBcRxE
        xHpM6UmkYmH1ovj4f7jeydQgXdfPSYSx+SoVxPI=
X-Google-Smtp-Source: AGHT+IEGUJuAhqQgLn7oVdVGifPgt9lHfhIlE4GIM70wiojIb1pXjfhGAMJ+UM2YbwQBa8GA9orUtQ==
X-Received: by 2002:a6b:c403:0:b0:7b3:f2a2:45e with SMTP id y3-20020a6bc403000000b007b3f2a2045emr6228689ioa.2.1701375938620;
        Thu, 30 Nov 2023 12:25:38 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id gu4-20020a0566382e0400b00466c82bce72sm484293jab.56.2023.11.30.12.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 12:25:38 -0800 (PST)
Message-ID: <2845b899-efd8-49db-8ea6-18834e97071e@linuxfoundation.org>
Date:   Thu, 30 Nov 2023 13:25:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:proc: Resolve 'Unused Result' Warning from
 proc-empty-vm.c
Content-Language: en-US
To:     angquan yu <angquan21@gmail.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231129034556.5719-1-angquan21@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231129034556.5719-1-angquan21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 20:45, angquan yu wrote:
> From: angquan yu <angquan21@gmail.com>
> 
> In tools/testing/selftests/proc/proc-empty->because the return value
> of a write call was being ignored. This call was partof a conditional
> debugging block (if (0) { ... }), which meant it would neveractually
> execute.
> 
> This patch removes the unused debug write call. This cleanup resolves
> the compi>warning about ignoring the result of write declared with
> the warn_unused_resultattribute.
> 
> Removing this code also improves the clarity and maintainability of
> the function, as it eliminates a non-functional block of code.
> 
> This is original warning: proc-empty-vm.c: In function
> ‘test_proc_pid_statm’ :proc-empty-vm.c:385:17:
> warning: ignoring return value of ‘write’
> declared with>385 |                 write(1, buf, rv);|
> 
> Signed-off-by: angquan yu <angquan21@gmail.com>
> ---
>   tools/testing/selftests/proc/proc-empty-vm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
> index 5e7020630..d231e61e4 100644
> --- a/tools/testing/selftests/proc/proc-empty-vm.c
> +++ b/tools/testing/selftests/proc/proc-empty-vm.c
> @@ -383,8 +383,10 @@ static int test_proc_pid_statm(pid_t pid)
>   	assert(rv <= sizeof(buf));
>   	if (0) {
>   		ssize_t written = write(1, buf, rv);
> +
>   		if (written == -1) {
>   			perror("write failed to /proc/${pid}");
> +			return EXIT_FAILURE;
>   		}
>   	}
>   

Hmm. Is this patch based on Linux 6.7-rc3? The code doesn't
match?

thanks,
-- Shuah
