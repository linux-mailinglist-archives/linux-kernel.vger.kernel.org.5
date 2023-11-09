Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF497E6F39
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbjKIQim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344459AbjKIQiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:38:12 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7AD3846
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:37:57 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77784edc2edso65937585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 08:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1699547877; x=1700152677; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8xnl4OUBKidE3PaY/zTL5GcIkGRs6wcCpqKnmSejZ0=;
        b=oRSq5LC2OCaKgATcRAqNgotoCH15uzqFKVTcZMVYmzw2CviLLPLBcT70Aa7RZscD0F
         zN8gnJ2CV2o12eVqh4c7d0l1PHCFhYj9psqu+pP+XrmJZmxM+pzqpEj6DFLVaR+NzpSx
         hSj92FWTnWzNOQYWQ1TZPkUZQhjidSaVo/zvmA3z2cu8xe+YR5hmReNE68plv4tAKYrr
         NRe2mmkgMCQ+h+IJBQg1epS0SoahGNKe3c5IzojXhmJmp9K1xjPKUhrHfGcfiNB4VxKR
         yO54rgaPIvKPzYPk8qa9irABfaQVrN+pbioXdozkXFv3Jexnu4lmlRQfT75cdI64I8iY
         vU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699547877; x=1700152677;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x8xnl4OUBKidE3PaY/zTL5GcIkGRs6wcCpqKnmSejZ0=;
        b=sYVCF5u5RgnVu6NNxVlBkNJQm5tVTcAKPp6X9LoixBlCslsoMBLiB31VwUpYQ6oKkB
         udWxECoVkbTzvSwPKTROklJkdxIkuJk0sSwMlI1otw4aGsJE9rxD9x3XgoGU0luFoh6Z
         B4zaHplb7jSEqklVVMiTJaGwLKvmBscyMAo8odkSWVrzIBqg3QA5za8NecTjRDegcyhj
         715ws2tvv3ARAWVXU41F8x/8zdzYtYNb9TyGNJpMbGM8rF9BMZbYRR7vYIMrcW2Y9S0B
         YT2s43TRUQqA5fD/FpnlF+Gxrayq5zCoczu5OtJSwrxqK2c34Sl699zrzh98rMrLWjhY
         5w1Q==
X-Gm-Message-State: AOJu0YwUqSr497matE/pPYGZefCPAhJN0Swa/pWvTJfq5BPJh8K7gfkA
        Cm8b1TK/XDoQvMYggE/JUvbpug==
X-Google-Smtp-Source: AGHT+IFkwLPUuqOBHRSAfmZ0e9/QTmdNov+D3YO3WfPHofSTC2FI9IqreavYREGQVGgN4UsJQiwYLA==
X-Received: by 2002:a05:620a:3947:b0:779:f645:c203 with SMTP id qs7-20020a05620a394700b00779f645c203mr5687091qkn.29.1699547876265;
        Thu, 09 Nov 2023 08:37:56 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id j2-20020a05620a0a4200b00775afce4235sm5066qka.131.2023.11.09.08.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 08:37:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------uEXi03ynL0GsboBc8gzwZ8vX"
Message-ID: <8f027b47-e778-15fc-0306-a5ae094f1070@landley.net>
Date:   Thu, 9 Nov 2023 10:42:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/5] fix rootfstype=tmpfs
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
 <8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net>
 <f9d57ae7-6dd6-4854-b9cf-1eec4cfa2a92@linux.ibm.com>
 <b74ea810-5b6c-404d-8cee-7d3d3922205e@linux.ibm.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <b74ea810-5b6c-404d-8cee-7d3d3922205e@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------uEXi03ynL0GsboBc8gzwZ8vX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/23 16:05, Stefan Berger wrote:
> On 11/1/23 09:10, Stefan Berger wrote:
>> On 2/21/23 16:04, Rob Landley wrote:
>>> Wire up rootfstype=tmpfs to force rootfs to be tmpfs even when you 
>>> specify root=
>>>
>>> Initramfs automatically uses tmpfs (if available) when you DON'T 
>>> specify a
>>> root= fallback root to mount over initramfs, but some people can't NOT do
> 
> can't NOT -> cannot

The double negative was intentional for emphasis, hence the capitalization. They
are unable to refrain from doing. "Could you just... not do that?" "No, I cannot
not do that."

But if you want to phrase it differently, go ahead.

>>> that for some reason (old bootloaders), so let rootfstype=tmpfs 
>>> override it.
>>>
>>> My original code tried to do this 10 years ago but got the test wrong,
>>> and nobody's corrected it since, so here you go...
> 
> I think this sentence can be dropped.

If you like.

>>>
>>> Signed-off-by: Rob Landley <rob@landley.net>
>> 
>> I would like to be able to have this for some work with OpenBMC and 
>> ideally it would propagate to one of the recent kernels with a Fixes tag 
>> like this? 
> 
> Can you repost this patch or should I do it?

They're more likely to listen to you.

Rob
--------------uEXi03ynL0GsboBc8gzwZ8vX
Content-Type: application/x-compressed-tar; name="patches.tgz"
Content-Disposition: attachment; filename="patches.tgz"
Content-Transfer-Encoding: base64

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

--------------uEXi03ynL0GsboBc8gzwZ8vX--
