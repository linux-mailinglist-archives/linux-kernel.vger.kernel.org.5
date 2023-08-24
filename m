Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF1A786C35
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbjHXJm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbjHXJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:42:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A5410F9;
        Thu, 24 Aug 2023 02:42:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so8319084a12.1;
        Thu, 24 Aug 2023 02:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692870140; x=1693474940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wjGIWwx9sMqqDG4N0HeXS9byjWgyDyOJOPKv8Cpifs8=;
        b=sePIHjLQiTnleOV5GoSLYhUfJFrfCxpJXhIB9zbk67whQZHbpN8qokQ5usK23OMfQT
         araDscwvMtKVxYqkgH2unppqRTai0xCKgCKUmuRdRb29nYgeu2mkNFqxSTxGwVauoBxq
         zaScxgfi0YtXTYDWIiHmP+BcwSpDy5ME7rEJBAw+RO9LUhQHmhnM0uhQ7pPkax0g+Xmy
         LkmXjPlv6JOPXVCnp50OUkmELNyNfqX1Xcge1cl6BwODCsOOJV8NWq34FnMKbjf/j55O
         6uUtqUYwalEfw3vLB0/aWt5+nUZQeOHnGmJzJmH0TFDsMBdezCEPsNXDImldpCPm7YPe
         IQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692870140; x=1693474940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wjGIWwx9sMqqDG4N0HeXS9byjWgyDyOJOPKv8Cpifs8=;
        b=F8e5cs1f4sTQx1rt5txwWXEzb1BslWtijOf1ZF5EMdOQMZor7SoERkSBH5iiIcCrDp
         6TrBW+CBY6Q5DARNSzRwUFeXb7lGI2xt0JUm3Nmzna3eDS4WZycWULe4+/UnAUdX9O3/
         VDhbqRULf+KbD0CMfCTsYxTLBLuCDvtEvCSXtzA8htWLXshVrj/QUHdYihC5VRNsuJuY
         1wryzZnobDJIXFosT2KrHVpNNr7vIKV30XCWgNHJzV39/r3tx6aQ+qrAMfH7ujDK+Zxc
         FUjPJmCEedEumJ3DqxDU5VxQelkEZfqtz92wyHQQcxCE3JAgCC/PZHe1EWCTUvCHpLNs
         02Wg==
X-Gm-Message-State: AOJu0YxkwYMbA08MHgKhX76Uk8x9DjQX6Jvq5a1uEK4sDV3UkfNjwPrS
        F7mKmpnYodgbm6M/39mEF5o=
X-Google-Smtp-Source: AGHT+IHHj0Z4GE4VEpBXOqxHymqAxmvG7gD4sWN1EVfNANnc4VAKwXJAvMT1o/1+L1vUGkYCIDbXCg==
X-Received: by 2002:aa7:c54f:0:b0:523:47cf:5034 with SMTP id s15-20020aa7c54f000000b0052347cf5034mr10061173edr.34.1692870140139;
        Thu, 24 Aug 2023 02:42:20 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.100.78])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fc0f000000b0051e1660a34esm10229017edr.51.2023.08.24.02.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 02:42:19 -0700 (PDT)
Message-ID: <d085c6e4-36d2-cd69-bb43-3c8d46da5239@gmail.com>
Date:   Thu, 24 Aug 2023 11:42:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Linaro-mm-sig] [PATCH 10/20] drm/scheduler/sched_main: Provide
 short description of missing param 'result'
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Luben Tuikov <luben.tuikov@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20230824073710.2677348-1-lee@kernel.org>
 <20230824073710.2677348-11-lee@kernel.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230824073710.2677348-11-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.08.23 um 09:36 schrieb Lee Jones:
> Fixes the following W=1 kernel build warning(s):
>
>   drivers/gpu/drm/scheduler/sched_main.c:266: warning: Function parameter or member 'result' not described in 'drm_sched_job_done'
>
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 506371c427451..1ef558cda60ce 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -259,6 +259,7 @@ drm_sched_rq_select_entity_fifo(struct drm_sched_rq *rq)
>   /**
>    * drm_sched_job_done - complete a job
>    * @s_job: pointer to the job which is done
> + * @result: fence error to forward and set
>    *
>    * Finish the job's fence and wake up the worker thread.
>    */

