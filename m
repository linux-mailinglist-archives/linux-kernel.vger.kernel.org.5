Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8651C77C151
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjHNUJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjHNUJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:09:18 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819D413E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:09:17 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-790b9d7d643so38997639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692043757; x=1692648557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nt8NvhUj7LKsuWhX8m0JFQKuVQwNc3xYghyI5ahujTg=;
        b=F4pkr89Wd6hHcMWTQPchd8CfEDE/g8JERZp9kc3KydWNRglQYJOcnqVSPrvm8oRir3
         tvr8+a2c2SWuyb6su27tvsQObBaZ1ljXQaZSSw4O4vhayScU/K6FXe5sm0kq59VcM3rZ
         3O+sK+XpxSZOAKIfdYNW+3EZVUk29nhmWQkCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692043757; x=1692648557;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nt8NvhUj7LKsuWhX8m0JFQKuVQwNc3xYghyI5ahujTg=;
        b=lezaWoDWCssHYRWxQT55PzC0wtUvZDX5eUieO0RwjuWkPOSF+MOUEoSQXYwguE9xF8
         1Z1QLClOC0u6Yw2RCO3Qwx8ygi1NxXEFOEWTY6paAxGfRvwd/5whqSTk7pp3oD4UZmx3
         Gg5yZ/RiVCBqcD6tMthaLn76LJlyerdJB/aE9ZuEyCX8Mlaf6x65Sd6CO9mu/AdCxiZt
         zkaR0P8z3hUTyRw2/9HHvSapTMZIhHwZ+ZTabfwdn6IfTN9VQ5WhRvEbPbpI8Fkj8FFI
         TZdZUH9tabJUj2DsTJZ5Qm2TqqcC+CCaaSaNngJJdV1ruPnBjjPkZzL/ZnUE9BC9s/+n
         /rxA==
X-Gm-Message-State: AOJu0YxegHZcMnZeCaM5F82hGtwm5HN5dFaDIdKJUyK5RkpJqO20yqJQ
        vYwnr88KosgMtw/sgMHwUmhh6795VHFHcTNfDoA=
X-Google-Smtp-Source: AGHT+IGTgPBpODx4qk2Anc+l3jSCJ2IEDatahTsi8+z4UZZFhoUDKKki3Bcw7oIodOMyeAALgUNC3w==
X-Received: by 2002:a5e:c90f:0:b0:780:d65c:d78f with SMTP id z15-20020a5ec90f000000b00780d65cd78fmr13736926iol.2.1692043756908;
        Mon, 14 Aug 2023 13:09:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p10-20020a056638190a00b0042b46224650sm3145372jal.91.2023.08.14.13.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 13:09:16 -0700 (PDT)
Message-ID: <b43706b7-4ced-9e00-823a-230a5a5e6345@linuxfoundation.org>
Date:   Mon, 14 Aug 2023 14:09:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests: prctl: Add prctl test for PR_GET_NAME
Content-Language: en-US
To:     Osama Muhammad <osmtendev@gmail.com>, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230806151810.9958-1-osmtendev@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230806151810.9958-1-osmtendev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/23 09:18, Osama Muhammad wrote:
> This patch covers the testing of PR_GET_NAME by
> reading it's value from proc/self/task/pid/comm
> and matching it by the value returned by  PR_GET_NAME.
> 

So the values should match? Can you elaborate that in the
change log.

> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> ---
>   .../selftests/prctl/set-process-name.c        | 25 +++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/testing/selftests/prctl/set-process-name.c
> index 3bc5e0e09..41f4b105d 100644
> --- a/tools/testing/selftests/prctl/set-process-name.c
> +++ b/tools/testing/selftests/prctl/set-process-name.c
> @@ -47,6 +47,28 @@ int check_null_pointer(char *check_name)
>   	return res;
>   }
>   
> +int check_name(void)
> +{
> +
> +	int pid;
> +
> +	pid = getpid();
> +	FILE *fptr;
> +	char path[50] = {};

Define this and use it. Don't hard-code the size.
MAX_PATH_LEN - look for other such defines.

> +	int j;
> +
> +	j = snprintf(path, 50, "/proc/self/task/%d/comm", pid);

Here - it makes it easier to maintain.

> +	fptr = fopen(path, "r");
> +	char name[TASK_COMM_LEN] = {};
> +	int res = prctl(PR_GET_NAME, name, NULL, NULL, NULL);
> +	char output[TASK_COMM_LEN] = {};

Code after declarations please. It is easier to read and follow.

> +
> +	fscanf(fptr, "%s", output);

Don't you want to check error return here?

> +
> +	return !strcmp(output, name);
> +
> +}
> +
>   TEST(rename_process) {
>   
>   	EXPECT_GE(set_name(CHANGE_NAME), 0);
> @@ -57,6 +79,9 @@ TEST(rename_process) {
>   
>   	EXPECT_GE(set_name(CHANGE_NAME), 0);
>   	EXPECT_LT(check_null_pointer(CHANGE_NAME), 0);
> +

No need to for this extra line

> +	EXPECT_TRUE(check_name());
> +
>   }
>   
>   TEST_HARNESS_MAIN

thanks,
-- Shuah
