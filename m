Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115D87AD4B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjIYJmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjIYJmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:42:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A249ADA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:42:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405417465aaso47443485e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695634925; x=1696239725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2OvvcdbPDlc5RUM3ipWasxoHtTemWDcPqStni+63QcQ=;
        b=pXWZW3f0tfSh9GBeREKcpZnyr6JSbRduFpypxxL51Q3B1F02JN84P+WnRLNr2m2MMf
         m9fAv34Fd2LOC9MtVnrjkix3O1Bmyf1DhrP+vgLTKWGBzRQ/QGP+4+aamXhDTkQaKm+F
         HXswwBvjvhtD/wCC/Sl7O53MECBC6Im2GnrchURMbKmpjYjDnZ+hXrFhslZdGCRxoD35
         IMWNEKL+Udch1IiNGwexxdlaiKQ16k79yPoS+hRK7gsCEYbP/U0xbi8QBNv8DLUyeOuy
         ptq/TFpB2VYkBV5ljqNUvZnlo2AuL7+nqNSd4kN81mtBM+NYr1T0xiTwUjQc9s60BTkK
         JyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695634925; x=1696239725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OvvcdbPDlc5RUM3ipWasxoHtTemWDcPqStni+63QcQ=;
        b=W4u7xL7raPB3DmqHQ2zHhPBo9pHaxAi2LSZTASe96+ahgODDp0l0nH0/foWvlctKRv
         tkg4AWsfV7hMCmudmj+rs+5INYrPtpkSW7gA0352AenWlkYSxck59LjOTj1o4OoqR4w/
         9L6NYe1UF3eJX/OpmrxTZP0+w07m7BTPcoWU7snHLpdhvLn3fV0JAgZjyc04zs/64WhI
         6rUtAFNOV5X9glcFMaPkf1uby2vXXMM1FNZQyAmYcmA93u6n5RojKKZD7ymOPf41fyBT
         tmah8Be3k7IlRNbxLfLRcvnt4wM4zxFSvwnuZB79xFKZgluHwA4dVRbN1BNU2sJr33Y+
         pkLA==
X-Gm-Message-State: AOJu0YzG16DO2t3foVxTDhCt0jo01X1JlnmFkXAglYZXFYDxwoxEACac
        r9LiqmGrZgD0DzF52m9KbGLEFA==
X-Google-Smtp-Source: AGHT+IGejiln/BxWgBkcJQSbke6s9AYgvYZym3e5WqpOA23xCckmmTqlINrt5I3jWFBq/NkvAKVmQg==
X-Received: by 2002:a7b:c4cb:0:b0:404:f9c1:d5d7 with SMTP id g11-20020a7bc4cb000000b00404f9c1d5d7mr6099794wmk.25.1695634924989;
        Mon, 25 Sep 2023 02:42:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a927:1e5c:85b4:9da1? ([2a05:6e02:1041:c10:a927:1e5c:85b4:9da1])
        by smtp.googlemail.com with ESMTPSA id u21-20020adfa195000000b00323293bd023sm2209859wru.6.2023.09.25.02.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 02:42:04 -0700 (PDT)
Message-ID: <93c87b5c-ae8f-d27d-0342-faa884a3142e@linaro.org>
Date:   Mon, 25 Sep 2023 11:42:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tools/thermal: fix memory leak in realloc failure
 handling
Content-Language: en-US
To:     Kuan-Wei Chiu <visitorckw@gmail.com>, rafael@kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230924065013.1081471-1-visitorckw@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230924065013.1081471-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Kuan-Wei,

On 24/09/2023 08:50, Kuan-Wei Chiu wrote:
> In the previous code, there was a memory leak issue where the
> previously allocated memory was not freed upon a failed realloc
> operation. This patch addresses the problem by releasing the old memory
> before setting the pointer to NULL in case of a realloc failure. This
> ensures that memory is properly managed and avoids potential memory
> leaks.

Thanks for reporting the issue and proposing the fix.

The description is not accurate actually, neither the fix.

What is happening is we are losing the pointer information as the 'mds' 
variable is a global variable. So the assignation will overwrite the 
current pointer if it fails. That leads to a NULL pointer dereference in 
the mainloop_del.

Looking closer to the code, it seems 'mds' is not used as the stored 
information is not accessed.

For my understanding, we can just remove the:

static struct mainloop_data **mds

and

static unsigned short nrhandler;

along with the associated code


> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>   tools/thermal/lib/mainloop.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/thermal/lib/mainloop.c b/tools/thermal/lib/mainloop.c
> index 94cbbcbd1c14..6dcc4090d47e 100644
> --- a/tools/thermal/lib/mainloop.c
> +++ b/tools/thermal/lib/mainloop.c
> @@ -62,9 +62,13 @@ int mainloop_add(int fd, mainloop_callback_t cb, void *data)
>   	struct mainloop_data *md;
>   
>   	if (fd >= nrhandler) {
> -		mds = realloc(mds, sizeof(*mds) * (fd + 1));
> -		if (!mds)
> +		struct mainloop_data **mds_tmp =
> +			realloc(mds, sizeof(*mds) * (fd + 1));
> +		if (!mds_tmp) {
> +			free(mds);
>   			return -1;
> +		}
> +		mds = mds_tmp;
>   		nrhandler = fd + 1;
>   	}
>   

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

