Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80C07A1FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbjIONgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbjIONgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:36:49 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DF62130
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:36:43 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-77dcff76e35so32128839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694785002; x=1695389802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FyfUX0X2fmtB6PX68eelYyAoJB8jxcCYoU3jaj8MsYM=;
        b=ydn4D9Jfxv5BuKoSlCNrEbvb0wmF/UhEs+33XosPhhKT/yK+jMCISrZt2wgU4HM87v
         7KCXIviagDEc8M7npSAwopV0CkjU8APIaZPrZxk+TLvqRSEezoC3ZIpQCjSIBaQxANVK
         biaVcG0RgFfe94C6GxLy9OSgNAXZHmFD38xMHM4ee4yX7mvOaZG/ucotanKldb1ciNIA
         pwD8BOE0GACYkaxnmil2tFmNtlj1vwN+8aw9OqRqby4m/JpHwA6riYYpJZ7MnvSJCba8
         bHCFt6A5CDU3LboM1AyBTUxoRG36YW/tzua93QCiPMyEKHsndpENAp9VlejjaE2tqKn+
         rkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694785002; x=1695389802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyfUX0X2fmtB6PX68eelYyAoJB8jxcCYoU3jaj8MsYM=;
        b=YZlnofUqd7BZFAZC1PXh5reAJc183pIL2hBeOBRy1ggCtzgBFO8gvCXJ6rCVBFoqyN
         I9RtylNW9QYYaA7eXU51mBHH3upwMCX8s7kLcT0i6cI2kj5PjNNLk1XD8VRYOFfQ2Aei
         NjIC+wVk14Sf+uLVlle5CNSEedpvws+/+pN/OabIgfBM6SjP3EpAIgBid6i0CNOPuBHF
         LCqQDKu/btmEofpaKzU1JeQrdLrdDn2DRfJ2F0VW08oDndZuhPBweyEv6uBQWWSeEOUl
         rn5d1j4umr6ZpKY8kTW6larzfC9fi4n71Wi0nwaDzyjO8HWtDf8YdshKOKiuRLNfW46H
         UlAg==
X-Gm-Message-State: AOJu0YwkpVQdEe8VZ6cKJEnkqCN60ZnnLX4IdXWluILUHE/Hj4FhNapi
        //JL5bPP6J25qcN/DvFyH5RgWA==
X-Google-Smtp-Source: AGHT+IH9FFVy2H1yFJjidsyCoasweVzlcw3vqMkLY4wA397WlW2CuAHpeyoGIJF6lW3TWHiGyUOvwQ==
X-Received: by 2002:a05:6602:17c9:b0:792:6dd8:a65f with SMTP id z9-20020a05660217c900b007926dd8a65fmr1530583iox.0.1694785002301;
        Fri, 15 Sep 2023 06:36:42 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b12-20020a02c98c000000b0042b6940b793sm1024607jap.17.2023.09.15.06.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 06:36:41 -0700 (PDT)
Message-ID: <6338fbac-0177-43eb-be4f-7c586956953f@kernel.dk>
Date:   Fri, 15 Sep 2023 07:36:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aoe: refactor deprecated strncpy
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Xu Panda <xu.panda@zte.com.cn>, Yang Yang <yang.yang29@zte.com>
References: <20230911-strncpy-drivers-block-aoe-aoenet-c-v1-1-9643d6137ff9@google.com>
 <202309142019.23A7D80A@keescook>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <202309142019.23A7D80A@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 9:21 PM, Kees Cook wrote:
> On Mon, Sep 11, 2023 at 09:09:07PM +0000, Justin Stitt wrote:
>> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>>
>> `aoe_iflist` is expected to be NUL-terminated which is evident by its
>> use with string apis later on like `strspn`:
>> | 	p = aoe_iflist + strspn(aoe_iflist, WHITESPACE);
>>
>> It also seems `aoe_iflist` does not need to be NUL-padded which means
>> `strscpy` [2] is a suitable replacement due to the fact that it
>> guarantees NUL-termination on the destination buffer while not
>> unnecessarily NUL-padding.
>>
>> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
>> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Xu Panda <xu.panda@zte.com.cn>
>> Cc: Yang Yang <yang.yang29@zte.com>
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> Agreed, truncation is the current behavior, and padding isn't needed.
> (Or more precisely, it's already zeroed and this function is called
> once.)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Change looks fine to me too, but for the love of $deity, please use
a proper subject line for these kinds of patches. It's not refactoring
anything.

-- 
Jens Axboe

