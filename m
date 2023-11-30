Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BEA7FFFB0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377319AbjK3Xqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377273AbjK3Xqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:46:31 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125FD10E2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:46:37 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35c683417f1so1382165ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701387996; x=1701992796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zh250x7hPWKm3cEtn7H0ENDaWoHwP+xH2vXQISgMTVI=;
        b=UtanHwiHwk/u9K+5iJi35mi1S9WgSFOIWaGjJQH9uFkppBKHdAIpfNJiNes6hJa28t
         Xhe7GAl6IPdW0WTIeaAJi+uOg6rh1nCndzazcB/tRtoofn4Kkxr8fGtNOxTRcbN56IUw
         bFkubbkM0y6cSzvw2R0KVRVsTcteXnkZSpa6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387996; x=1701992796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zh250x7hPWKm3cEtn7H0ENDaWoHwP+xH2vXQISgMTVI=;
        b=rNN0dPs3N1UYxtAB55Hzxo8DaNxoZ+WDdtrov3SVlIbPmtdVx79fkRPdlhGmx8ckBf
         CV5ndtiGA/dfJNKTOih3IXNpYUaKJW/1qR5VaKU4QF23xxNRlDvOcCewSunHrjAEUrll
         bUh2zTWrsSbMFoT4t8lRJ6v0MfnktoBzyvpN95GKkf6+JtGYAIYkBd4ezAshNFQctiQZ
         1/AR7KGjcoNGw0Zc4dE8uCkjMn3JvnGjBfgyDIYDJTITjLWCloXlbJPe9bn6xCcKZFGZ
         38KSeCHlPnX2E0zIqEbzFpKFrX5C+0phLqUYwQFSLSDgLq/m4ePz24L3bcNzVmDMCHVs
         Vnqw==
X-Gm-Message-State: AOJu0Ywj2YIgeYoZqpztG68Wlk/6lGyGXP+fq9rHufJ0rdSi/2vn7Wd6
        ZOlih8b0hT+IDTd5dBZplzeSww==
X-Google-Smtp-Source: AGHT+IHZwDGqqHcfAVap/vf6pHAy9YoCKCV0f7Ge3jlcZnLyFIzigfI+bN6GjaopeCQk+k0HXwJOJg==
X-Received: by 2002:a5d:8b98:0:b0:790:958e:a667 with SMTP id p24-20020a5d8b98000000b00790958ea667mr25499298iol.2.1701387996280;
        Thu, 30 Nov 2023 15:46:36 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id h5-20020a056638062500b004562646b66bsm579254jar.12.2023.11.30.15.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 15:46:36 -0800 (PST)
Message-ID: <e13a07f6-d251-4510-aa3a-3a90583bd404@linuxfoundation.org>
Date:   Thu, 30 Nov 2023 16:46:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests: cgroup: Fixes code style errors
Content-Language: en-US
To:     Atul Kumar Pant <atulpant.linux@gmail.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, shuah@kernel.org
Cc:     cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231106181144.117188-1-atulpant.linux@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231106181144.117188-1-atulpant.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 11:11, Atul Kumar Pant wrote:
> Fixes following checkpatch.pl issues:
> ERROR: do not use assignment in if condition
> ERROR: Macros starting with if should be enclosed by a do - while
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>   tools/testing/selftests/cgroup/cgroup_util.c | 14 ++++++++------
>   tools/testing/selftests/cgroup/test_core.c   |  3 ++-
>   2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 0340d4ca8f51..e165c4a703a6 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -411,12 +411,14 @@ int dirfd_open_opath(const char *dir)
>   	return open(dir, O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW | O_PATH);
>   }
>   
> -#define close_prot_errno(fd)                                                   \
> -	if (fd >= 0) {                                                         \
> -		int _e_ = errno;                                               \
> -		close(fd);                                                     \
> -		errno = _e_;                                                   \
> -	}
> +#define close_prot_errno(fd)				\
> +	do {						\
> +		if (fd >= 0) {                          \
> +			int _e_ = errno;                \
> +			close(fd);                      \
> +			errno = _e_;                    \
> +		}					\
> +	} while (0);

Did you run checkpatch on this patch? You are fixing
checkpatch errors - :)

thanks,
-- Shuah
