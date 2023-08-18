Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E3D780812
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358973AbjHRJNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359015AbjHRJNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:13:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398273ABE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:13:30 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so9539791fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1692350008; x=1692954808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ip54WHMlGq0LYtswPaYe70qDkryOWOGUPqAl6wNrG5Y=;
        b=HCAXeuFuBiNou9VLItqgrjEn47VUlkTyfrN8A+vq8KiIaaLwFUEwThX1ifum1zOENh
         2CNTwEh2Bh+zC9OlqEY2QTNQLe/XxS3tP05tSFR8mLRuyjyKTbUYpoOxkeSSsq9oUS9L
         6hbaP1x5jmjnp6UYQ1MsUbqpiGyhBwhyKy6xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692350008; x=1692954808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ip54WHMlGq0LYtswPaYe70qDkryOWOGUPqAl6wNrG5Y=;
        b=Nib3ZVOVOOOsGPKpOrri8nQFzZo71BfdR/F+aHbyC3HToruStq+FfSocVf9BjCOYzM
         hh+dddR/d59GN4Gz77C9UpL7YtCff56Lw+LQLo4moSWArc0IkMHw7XkUmA3r+dJ+x1+i
         zHq8/AYATJFh/dULGgadWRfmz4zDZWn0AtmkP+X2TLkU+1dCRT5GsHPC+TMG0UlCYiOp
         jmmDjL52heBTik4yb0d9J4zzuI24dWGaXEhyLFBjfvJK6KWO8/JZIEyJt7QheHPEXv4X
         TjIMft+oVlQAA4rFjobzqs4PoCxFtiNuRTheZA/3CE1CVddVI8ZB6ZsTQ7SL83Q13RUP
         9FNg==
X-Gm-Message-State: AOJu0YyU9ivP90ErrOQHpIXNvUcPt/XPG6E3hcpZI+DUJ3z42BvnqoU9
        ePrB8FaG/DQiDAl9jG0fWW6h4A==
X-Google-Smtp-Source: AGHT+IEY76IIhHHDE9Jac52CMY3YSmVGdpQluWr9Xgm+PQ1NjllYhjWNo7yOf4O0LjNuwHXDzajuKA==
X-Received: by 2002:a2e:a414:0:b0:2b9:53bd:47a7 with SMTP id p20-20020a2ea414000000b002b953bd47a7mr1346453ljn.30.1692350008532;
        Fri, 18 Aug 2023 02:13:28 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q14-20020a2e874e000000b002b94327308asm318016ljj.133.2023.08.18.02.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 02:13:28 -0700 (PDT)
Message-ID: <c578a9a6-9a9a-fb47-1b6b-d4c534f200f2@rasmusvillemoes.dk>
Date:   Fri, 18 Aug 2023 11:13:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/2] bitmap: Use constants and macros from bits.h
Content-Language: en-US, da
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
References: <20230817165453.713353-1-andriy.shevchenko@linux.intel.com>
 <20230817165453.713353-2-andriy.shevchenko@linux.intel.com>
 <26fc3fb7-eb68-e5ff-ec86-67982734491e@rasmusvillemoes.dk>
 <ZN8w5CbGn2CkYCDy@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <ZN8w5CbGn2CkYCDy@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 10.50, Andy Shevchenko wrote:
> On Fri, Aug 18, 2023 at 08:28:21AM +0200, Rasmus Villemoes wrote:
>> On 17/08/2023 18.54, Andy Shevchenko wrote:
> 
>>>  #ifdef __LITTLE_ENDIAN
>>> -#define BITMAP_MEM_ALIGNMENT 8
>>> +#define BITMAP_MEM_ALIGNMENT	BITS_PER_BYTE
>>>  #else
>>> -#define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
>>> +#define BITMAP_MEM_ALIGNMENT	BITS_PER_LONG
>>>  #endif
>>>  #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
> 
> What about this chunk? Does it worth to be updated?

IMHO, no, not in this way anyway. But the macros could perhaps use a
comment saying that they decide whether certain bitmap operations can be
turned into plain memxxx calls, which is why LE vs BE matters, and LE
just needs the bitmap to consist of a whole number of bytes while for BE
it must be a whole number of longs.

Rasmus

