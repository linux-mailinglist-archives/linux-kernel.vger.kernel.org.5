Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05648774C89
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjHHVLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbjHHVKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:10:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E264D1856C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:32:03 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686f74a8992so863411b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691526723; x=1692131523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+ZhtxeS2K6wY4/v6oo74/4iwOVLExtMX8Wj3f+oDck=;
        b=oZCMVoKtaxGXXbK0HY94/QPg5Dv5Eo5JV0M9mPOSkkB1h/L++cw7dWV2Sfea+qFG69
         liqMwo9D83nL5QdN/f6AjQt4sBb88fNmQzJfBFt36pvg9bbb0vWUYEYb0NAioDtDuyJr
         /We3F/nffs7+Wj5j2Q8ClI7mkeE4ozYt0l7wJ7Kf6yPJqmG5TCAeIBsH9o8IEYbH0vo2
         8rLZzoKIZXUBFRX6yS3G+lvzULHjFCa+Ic6HA2RAx/7bj938plbOSUMOG8Ofg39HNVGc
         TIGcIgK+eGWtRH/tLPFq2ssiFKJNoOZw8ZAxRXqIFqYhhJp69llOE8/mILt0S+vH/4cn
         2pGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691526723; x=1692131523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+ZhtxeS2K6wY4/v6oo74/4iwOVLExtMX8Wj3f+oDck=;
        b=ircy7Hm/paSLHdN5Xag9H6x7Yx/07KwFXXuHlRMomsucP4/fyAc/N9Hv+OC60nkeg6
         PKUO6r0vhABwtr8V5A6rtMlvuCZ6iC3nc1fAHFmXdIghkE9c0IgRE/ppUEPcA171NoP/
         6LmOXDtcUvPhENIqiVz3VvEDiN5uHLNm+eY4548YQjIgw19xzIilGkWy+oyUQ0idaRei
         TVIdMm403g9ZLOBrWksJBxN+U3iBhSF2L5BZHxT/1u5kJnustWL8ER0Ay/vjYhGLKz/s
         HfYigL1JRdiFqY4x/JL0KwmiVGPxIWeXAKTd8HUliXZna7ZBGlIzx5RwHsi3XVRSa8yk
         t+Mw==
X-Gm-Message-State: AOJu0YySKMxf1NXU5dqLvLAXy2To1ydS6af+n7xKh82exMFXC0m0fOfC
        1XH4NKrUSlPCt1YYogY487V28udZosbaKJFOZLA=
X-Google-Smtp-Source: AGHT+IEx3gKPK1UCRHC5/OF0O7NGaWz+NmKoOFS6yQMUxwxHjdFNxZmr4KBr7rsw4DGHnzbw4097ew==
X-Received: by 2002:a05:6a00:2295:b0:675:8627:a291 with SMTP id f21-20020a056a00229500b006758627a291mr622535pfe.3.1691526723240;
        Tue, 08 Aug 2023 13:32:03 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y19-20020aa78053000000b0063b8ddf77f7sm8483777pfm.211.2023.08.08.13.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 13:32:02 -0700 (PDT)
Message-ID: <da6c76b0-9d8e-7b0e-99e5-8f5271413d22@kernel.dk>
Date:   Tue, 8 Aug 2023 14:32:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 00/14] futex: More futex2 bits
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
        Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
        hch@infradead.org, lstoakes@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        malteskarupke@web.de
References: <20230807121843.710612856@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230807121843.710612856@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/23 6:18?AM, Peter Zijlstra wrote:
> Hi!
> 
> New version of the futex2 patches. Futex2 is a new interface to the same 'old'
> futex core. An attempt to get away from the multiplex syscall and add a little
> room for extentions.
> 
> Changes since v1:
>  - Moved the FUTEX2_{8,16,32,64} into FUTEX2_SIZE_Un namespace (tglx)
>  - Added FUTEX2_SIZE_MASK by popular demand (arnd,tglx)
>  - Added more comments (tglx)
>  - Updated __NR_compat_syscalls for arm64 (arnd)
>  - Folded some tags

Thanks Peter - for the series:

Reviewed-and-tested-by: Jens Axboe <axboe@kernel.dk>

on arm64 and x86-64. Caveat - only tested the existing futex api, not
the new syscall, and the io_uring futex implementation on top as well.

-- 
Jens Axboe

