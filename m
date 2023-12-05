Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179E38049F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344324AbjLEGU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjLEGUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:20:54 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116FFB6;
        Mon,  4 Dec 2023 22:21:01 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9fdf53abcso19184031fa.1;
        Mon, 04 Dec 2023 22:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701757259; x=1702362059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOqprCd4bG5T3dRTwPYRAAXTaR7ceVabdmLSc2XpaJ0=;
        b=OOdcoubrHsN3H9Reb/J62QaitBXRxm2NCntJ3qnYY4iEiMo5k3U5IKMMQZVX+1oaWs
         fK6G2FUyJP+G6DkFjVJ8a9XRgHupteIhKJtvhP6xKWY1DELB2TRY5mAiaU1ltgBsZpHU
         KBEZzYW93mmvUBRhRjn6HWhL1ANE5uZWNJtbKXcKQ0XlJPMK0hBq2drSTq+iZJHReipR
         /yNMladsiw1HzpPFp2Vt5qoXYKasCLUpR0mzBXsOJZs7ntZ+shlE5Dr5/zl81NDpizWK
         JNx7g0+xzsk/EQrCA/9mfqN2iGVZvf0rp9pDUrMUkHCXZm2b7+uxPnF6Sy+bDEI51OrK
         gxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701757259; x=1702362059;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOqprCd4bG5T3dRTwPYRAAXTaR7ceVabdmLSc2XpaJ0=;
        b=T1UQcaqNrWHcmMnVRZheeKEu71HehU7RWBVCV4iiJ41+x+fkQwLBXkofWBdKNgTZEC
         7Q8NZT0qjUp2E1dRHIvw7UUf2cZpdxcYEiGX7JrkolgZEVtVTTHvsX1ZtRmEyoPnWUZU
         mkn6wdRnvz1a5FDZhCSFExJwTzsLN4gSDK5pEhHPcWGHqzIaCNdoYKSIWhZT5MMsK8bH
         QstHOLRfn4kpbnRR0Nv2q0KksJeI7dySZGN5EjJZMs9SZ5MnpNZqFsnkkCybawb8c+nO
         C4qdETv3JvAWEYYgyXKHZpey6FzttjwiRJApZgURuB3nyxDtLiXSyOsiivZrYRyv0kKr
         EDAQ==
X-Gm-Message-State: AOJu0Yw5R4mWQTg6fdDoOm2Xz+nuwMYzTfEmuWJzcXEb+9crVPLPrQ/t
        ETYpnH2QdqutLr0QsmS0lPmApM0vMRjmUw==
X-Google-Smtp-Source: AGHT+IFEpn9/cYjwhdGUMp5Q8e82xnJ9Pnz3h+NI7jLulEvGm4X2k+vBHEEVziBdAvT0dyhQQPx1Rw==
X-Received: by 2002:a2e:8908:0:b0:2c9:ea39:5fe1 with SMTP id d8-20020a2e8908000000b002c9ea395fe1mr629301lji.9.1701757258904;
        Mon, 04 Dec 2023 22:20:58 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id e20-20020a2e8ed4000000b002ca0d8768a7sm296664ljl.93.2023.12.04.22.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 22:20:57 -0800 (PST)
Message-ID: <68533caa-d98f-4824-a761-82a09f419f41@gmail.com>
Date:   Tue, 5 Dec 2023 08:20:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] devm-helpers: introduce devm_mutex_init
Content-Language: en-US, en-GB
To:     George Stark <gnstark@salutedevices.com>, pavel@ucw.cz,
        lee@kernel.org, vadimp@nvidia.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hdegoede@redhat.com, andy.shevchenko@gmail.com, jic23@kernel.org
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
References: <20231204180603.470421-1-gnstark@salutedevices.com>
 <20231204180603.470421-2-gnstark@salutedevices.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231204180603.470421-2-gnstark@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 20:05, George Stark wrote:
> Using of devm API leads to certain order of releasing resources.
> So all dependent resources which are not devm-wrapped should be deleted
> with respect to devm-release order. Mutex is one of such objects that
> often is bound to other resources and has no own devm wrapping.
> Since mutex_destroy() actually does nothing in non-debug builds
> frequently calling mutex_destroy() is just ignored which is safe for now
> but wrong formally and can lead to a problem if mutex_destroy() is
> extended so introduce devm_mutex_init().
> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
>   include/linux/devm-helpers.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
> index 74891802200d..2f56e476776f 100644
> --- a/include/linux/devm-helpers.h
> +++ b/include/linux/devm-helpers.h
> @@ -76,4 +76,22 @@ static inline int devm_work_autocancel(struct device *dev,
>   	return devm_add_action(dev, devm_work_drop, w);
>   }
>   
> +static inline void devm_mutex_release(void *res)
> +{
> +	mutex_destroy(res);
> +}
> +
> +/**
> + * devm_mutex_init - Resource-managed mutex initialization
> + * @dev:	Device which lifetime work is bound to

Work? Copy-paste error?

> + * @lock:	Pointer to a mutex
> + *
> + * Initialize mutex which is automatically destroyed when driver is detached.
> + */
> +static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
> +{
> +	mutex_init(lock);
> +	return devm_add_action_or_reset(dev, devm_mutex_release, lock);
> +}
> +
>   #endif

Doesn't the mutex stuff need a header inclusion?

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

