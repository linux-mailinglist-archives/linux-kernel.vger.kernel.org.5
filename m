Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78927A4FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjIRQsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjIRQsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:48:04 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399861B8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:47:14 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d8207f87163so475999276.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695055633; x=1695660433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bC2phskuIFvD/AaiWBQwD/RidKu+taALyCRQa/nknSE=;
        b=UDKaXZv3Zf9Np39Rkb8CoPpxkkxYwUYEdauolRfPP5PGD3ae6tQJEqtZoPCFdbDgpc
         1dUEwTmzeypPkg4C0D4YqB6RpRZXQ3GpmahYjsCBo7tlGCjeLk7L3prSpWdZ1IDmeK3N
         FQhBMfCMEBihxEoM4APQF/IoszSdaDyxLlL7E3nyLxtaiqZPt4JeKB1NGGlqjBTipILz
         +3U7jsOpMdip7lYm0q26cBKYa+IF+vk9/DE76iBb7JKzLWq6b9mvAMwGkpyPJ2RYVRT7
         hwTq98q0kG8Q/R9Fvg80yEibQ0sui6Q/aOL2vmlC1Anuug0Q527OBacCncMvJrqwM/f4
         fd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695055633; x=1695660433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bC2phskuIFvD/AaiWBQwD/RidKu+taALyCRQa/nknSE=;
        b=g2yYsbympuiY/DnjeRcV4GAu7a8e6BcotJNBlIOx8JwTw8Fmu5twdKjpPy9cp9oxr2
         MW0uk7LPTTB1Jjv9ovf4+IAc5F35naEZZ0uoiAqQjrBNFjFz5YT3ANlTiFeKMBa3dmbz
         KljvpG/0qy0B7BoUDPtNs2CqeNMJ09GEMoCd1MAzLdKsasBStte/C2ZAYCrlNHgA3JZJ
         0ZKCbmW6kmBbPhNxhdIbvb6XFiRr+uTo84koHKtX8YP+MXe9h6et4EHS7L07EvFwaKYx
         hpPzITdbcrCjxIl3xFe/5Ye+3QOSnKron81LrTQuxEi1InT0ZRaeIa8r5UCDZHblwtIx
         Z3Aw==
X-Gm-Message-State: AOJu0YxDjgxloHxkgWg+2LtMwqi8JPomdjH/fGXpJwJcIkRj/Ygsl76+
        vc1JMhoS/dsfuIc9XEKQqwrRcpnU5otCgUnNL+z1Uw==
X-Google-Smtp-Source: AGHT+IE4huNJ9ieYLbRr1wXk9YJVyZSV0RaDTxWDJMPdpQYjKG794yWqTTw/d7v2WKKlkf7zMRwoMQ==
X-Received: by 2002:a6b:c94d:0:b0:795:172f:977a with SMTP id z74-20020a6bc94d000000b00795172f977amr9665856iof.1.1695045646340;
        Mon, 18 Sep 2023 07:00:46 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id em8-20020a0566384da800b0042b068d921esm2836235jab.16.2023.09.18.07.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 07:00:45 -0700 (PDT)
Message-ID: <e6433ada-16db-4d16-801b-9a3fd5460467@kernel.dk>
Date:   Mon, 18 Sep 2023 08:00:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aoe: refactor deprecated strncpy
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Justin Sanders <justin@coraid.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com>
References: <20230911-strncpy-drivers-block-aoe-aoenet-c-v1-1-9643d6137ff9@google.com>
 <202309142019.23A7D80A@keescook>
 <6338fbac-0177-43eb-be4f-7c586956953f@kernel.dk>
 <CAFhGd8pwtUSJBzepe=GBeyKuhD6ND6aWjeeT477Sdb4YTYDL_Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFhGd8pwtUSJBzepe=GBeyKuhD6ND6aWjeeT477Sdb4YTYDL_Q@mail.gmail.com>
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

On 9/18/23 1:03 AM, Justin Stitt wrote:
>> Change looks fine to me too, but for the love of $deity, please use
>> a proper subject line for these kinds of patches. It's not refactoring
>> anything.
>>
> 
> Fair.
> 
> Perhaps "xyz: replace strncpy with strscpy"?

That's a lot more descriptive, as a) it's actually accurate, and b) this
is what the patch does. You just sent another one with this refactor
wording which makes zero sense, please resend this and others targeted
at block with a proper description.

-- 
Jens Axboe

