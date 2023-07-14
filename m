Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533D6753456
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjGNHyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjGNHxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:53:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD54420A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:52:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991fe70f21bso221881466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689321147; x=1691913147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOVlS2YAuvrsf20+jrFcg/um5olVmnGgBe34iQHZIlQ=;
        b=e7zQskFd1+/J6qaQJ5w9NuZJXYRISLqdmLBz8C6tlCDh6ZJ5vUxguMbOYC0DDc4c2t
         rZifVjB7YG1xrGJoJJY0nDROdlpjM5kuYO9I2cTR1d4T5F7Crp0dFpVGY+MNDr5wyxLv
         HG40R6eeryGox0pzOYqyKA+JAB+asg66z1fPpliAnVGtbNEqQkSA0LWfnlbZrptfs7qp
         d/p6hl8IoyX1SjHF5lYfDLRgfXNcQIzSHFnDSnqU0XTzl6hiUxXqDrWzcahK00YItxTe
         PnJ6M/MQyLIiG93/2obyg8ku9yWCdUreFrP2z2OdjLE/xGxJauW/kwg1Y0aFnMrJbMCp
         dEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321147; x=1691913147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOVlS2YAuvrsf20+jrFcg/um5olVmnGgBe34iQHZIlQ=;
        b=NekaLCRPmolYX81Xffh4R/ReZAp41edatoCAUyHwebD/OXq2CYFu5kuF2lauOtu8bH
         8E1RI6DaB5wh2AoYMTpPxaOFXBQZplnGKyo8TzNbNCucZuNU32f80kKKoCAazZ+LkPbY
         MYMKxyk1AJET99FPH6fYVZgbHSRghmBLwQSbDERJFzM1cOaw1HT7dfp4n8u6VjqHN7uy
         mMfQbcW3rmAIN257c8d2eIJtFpDSZBmj3oPTwBCDmUxiGg0OhQicjA+wIQQDjyLDUGpJ
         1v2KIqNmUEDZRHSrTNxPdk9otvoPFmG48S6Xscxp0E8Pjf06GrbZU98rptTittOaXwA0
         ivrQ==
X-Gm-Message-State: ABy/qLYqn+yKR9Q/IWLQGxrIUeySI7d+MbpYnXqdq4nNg4mDwhwlPNaG
        PElO/2WeTmmlNQz7nuMHpGKUJN3Zy90=
X-Google-Smtp-Source: APBJJlFJqBvBNQDT0oi8m1LKbRiN/jcbi6Zg8upgZIA9EcHPBqmkQw/o1nmRpJunvMsqiX8DwkdHyQ==
X-Received: by 2002:a17:907:767b:b0:988:8be0:3077 with SMTP id kk27-20020a170907767b00b009888be03077mr3466572ejc.31.1689321146417;
        Fri, 14 Jul 2023 00:52:26 -0700 (PDT)
Received: from ?IPV6:2a00:e180:156e:8700:817e:6375:6a13:2da9? ([2a00:e180:156e:8700:817e:6375:6a13:2da9])
        by smtp.gmail.com with ESMTPSA id lf16-20020a170907175000b00993928e4d1bsm5046737ejc.24.2023.07.14.00.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 00:52:25 -0700 (PDT)
Message-ID: <72a40172-86a8-64c0-0c06-cbc670503370@gmail.com>
Date:   Fri, 14 Jul 2023 09:52:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/6] drm/amdgpu: Limit info in coredump for kernel
 threads
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
        michel.daenzer@mailbox.org,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        alexander.deucher@amd.com, christian.koenig@amd.com
References: <20230713213242.680944-1-andrealmeid@igalia.com>
 <20230713213242.680944-5-andrealmeid@igalia.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230713213242.680944-5-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 13.07.23 um 23:32 schrieb André Almeida:
> If a kernel thread caused the reset, the information available to be
> logged will be limited, so return early in the dump function.

Why? The register values and vram lost state should still be valid.

Christian.

>
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e80670420586..07546781b8b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4988,10 +4988,14 @@ static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
>   	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
>   	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
>   	drm_printf(&p, "time: %lld.%09ld\n", coredump->reset_time.tv_sec, coredump->reset_time.tv_nsec);
> -	if (coredump->reset_task_info.pid)
> +	if (coredump->reset_task_info.pid) {
>   		drm_printf(&p, "process_name: %s PID: %d\n",
>   			   coredump->reset_task_info.process_name,
>   			   coredump->reset_task_info.pid);
> +	} else {
> +		drm_printf(&p, "GPU reset caused by a kernel thread\n");
> +		return count - iter.remain;
> +	}
>   
>   	if (coredump->reset_vram_lost)
>   		drm_printf(&p, "VRAM is lost due to GPU reset!\n");

