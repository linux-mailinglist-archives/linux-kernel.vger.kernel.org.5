Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6780791A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442840AbjLFUD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379448AbjLFUDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:03:55 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB8511F;
        Wed,  6 Dec 2023 12:04:01 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-33334c0c0aaso29143f8f.0;
        Wed, 06 Dec 2023 12:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893040; x=1702497840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1cGGHd2OvOThZgWozukycQcpRjzFNoDizoPFfKVS7w=;
        b=Q63f54PXKnCGyOsb1R2nHx0amUv3+IkePV8KGz7/Gd3v7/9RgWof6cnFhek1ykWtDs
         g92HtfHlfj1zgvIanOdamiuue4E2AdBSSyibe8nhnDW2Al6Cr0rQj9lVbA4Whr0yfvSd
         0wLEGFZKwCTOe5Jn0ZoySmgifri0gQPPH1RTVwxwsRhNi137DPm/8Lj0nARuYXU3dTzi
         6feRxvaf9r9RxzNxNvTnskL8BCChcEfJr3Gt+pHkFaJ1WeELBDU7lQQldZEwP2IVs3UP
         30OE8ZzPgJyH3ySwWjTFvFUPvAd1xHsnkkDBVfobl7LCu/ZOlCKD7mMirFu9fp4iL0da
         sESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893040; x=1702497840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1cGGHd2OvOThZgWozukycQcpRjzFNoDizoPFfKVS7w=;
        b=rLw0R1GyRb3OSNx+yjCVSSyHOicZ7shGmnaX9ROMJAdwyt2VoNuVyOLelukNusJMUX
         iF1f/KhAnpRksURMd4OF5z8SCdWliB+kkNBjGNXIU6gDulAVUzIS7BkPWNpbn0ONJ0Xo
         p0v9NgrCI3pzLOP7HYsnQeYpSmHjJWDIOsQmjK8fPSUOgwRgt7UMVbUCkivAzDfdL5un
         dAdOqUc5D427CLYdZyO5bVjI8QaNTeuTMziOUkzBQvn9cHuECBgFaKwdU5HY2/BM4b/U
         H9jdc7RIG5Q3sR9H2UQLEdamjs6+OPMwPgtS47gCW7NCX1jBHlSlTIQcq3O96CBb0IOz
         SXrw==
X-Gm-Message-State: AOJu0YwWhM7wZs43OnhBg/2yQc6ho1zGeFFPNAydnAx0wVSIPiywtvo4
        qpaC0VkcS+Eank6WjHsMyUq1dW5urKNUmw==
X-Google-Smtp-Source: AGHT+IHk2+K9DFaK6j6ySf+n7PkIMJ2kJogNlrqFGXF5qE48FgCiuk38fu0QXAoBjLVNmL+YOyS7LA==
X-Received: by 2002:a5d:64a9:0:b0:333:538a:af0f with SMTP id m9-20020a5d64a9000000b00333538aaf0fmr1724090wrp.6.1701893040168;
        Wed, 06 Dec 2023 12:04:00 -0800 (PST)
Received: from ?IPV6:2a01:4b00:d20e:7300:ce19:4f96:2025:1db5? ([2a01:4b00:d20e:7300:ce19:4f96:2025:1db5])
        by smtp.gmail.com with ESMTPSA id n1-20020a05600c4f8100b0040b45356b72sm687231wmq.33.2023.12.06.12.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 12:03:59 -0800 (PST)
Message-ID: <d2534c1b-b654-42a3-9edb-3041ed6bfe01@gmail.com>
Date:   Wed, 6 Dec 2023 20:03:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ALSA: pcmtest: stop timer in the hw_free callback
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, perex@perex.cz, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231206151046.25773-1-ivan.orlov0322@gmail.com>
 <871qbz2rn9.wl-tiwai@suse.de>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <871qbz2rn9.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/23 16:59, Takashi Iwai wrote:
> On Wed, 06 Dec 2023 16:10:46 +0100,
> Ivan Orlov wrote:
>>
>> Stop timer in the 'hw_free' callback instead of the 'close' callback
>> since we want the timer to be stopped before the DMA buffer is released.
>> Otherwise, it could trigger a kernel panic in some circumstances, for
>> instance when the DMA buffer is already released but the timer callback
>> is still running.
> 
> You can't call timer_shutdown_sync() at hw_free.  The PCM stream is
> still there and you can re-setup via hw_params without closing.  But,
> after timer_shutdown_sync(), the timer instance must not be used any
> longer.
> 
> A more proper way would be to call timer_delete() (no sync) at trigger
> STOP, then call timer_delete_sync() at sync_stop op in addition.  This
> assures the immediate stop and the sync before changing to another PCM
> state.
> 
> timer_shutdown_sync() can be kept at the close op to be sure.
> 
> 
> thanks,
> 
> Takashi
> 

Hi Takashi,

Thanks a lot for the review, sounds reasonable, I'll make suggested 
changes and send the version 3 :)

--
Kind regards,
Ivan Orlov

