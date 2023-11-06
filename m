Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0365E7E2F1C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjKFVsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjKFVsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:48:23 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B7311F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:48:20 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40806e4106dso30524605e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 13:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1699307299; x=1699912099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=az7ExxO94n7Tzege6R79RlIuC0dJHugUw3dOV0fKG+I=;
        b=MXQj+08NoMF0P0C5A49vtHDtDrdkx6m+IkUM84MQnBdcIrIf49OHvxw9XOL2p+exTQ
         48bbLGruV3UR61+fH4zwv3rUeMtFU41Q69rs3ztwq8Q66vlGG3qAcTJQ9Bz5NQZQYLH0
         Cxfm8NKc/4NEgChzjRdG7KzsIbsclhKnE20Smvp9q2pKj3Tq/cTwRUcnT3CYunDPM8uw
         p/msOAfYl40OLdZozyZ9onDd336M+wAZ7bHzBDhZ/P8Aclc1tiEG3vVYx0Yv10NjRHmq
         KtXoZ0oQ1sZ3qnfplOYq3hO0hM5ulC7SUVjIsuhvu0Jl61nd1cw2F1XuhWXvt2n+71GN
         m5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699307299; x=1699912099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=az7ExxO94n7Tzege6R79RlIuC0dJHugUw3dOV0fKG+I=;
        b=ChgQH3KuV3oUdOIK6fnenJ6F3th05Z/2hXiNxglS2gB9r5A3HQtMiie0in1DCqTY1I
         kBWKtJ+fZM0xM3K83dB/hE4KpcYo5my22lGhUN5esc0IWRuli+u+1/hTiIANwWoPYeLI
         MZaZPKBNf5o2dM5n5LIg3bQgyI61rZp5F7G2X7HVXkA+WCO2p5KC4OmFzkSdtPe+4JpJ
         cdnLrNoglU3AV4tEfJimKC88mBsdCtIkfm/53j+mxqQP06nsgzcF2GFXF1CANI/JYKgL
         vuh8dmCRfxCzKs2reeRm0W1o8oC5t34iHw3qOWnSLHQ2b/zZK4lrKJTdExZq1BOSx0q+
         XanA==
X-Gm-Message-State: AOJu0YzG9/8rV0kScF8puo+STZ3Zsvbn7S55l2mROoi3wY+CnqOUDTn4
        sLw2emlnTZDNBbq+SbZfb1Wmqfq6ProlqI/L6CQ=
X-Google-Smtp-Source: AGHT+IEF4p80QoTLDD4KV3JQ2AnS0F8rRoHPd1/kCN+tYAzVUsjYELpEmJ4GHmO0V+YDLmjBPSTWBw==
X-Received: by 2002:a05:600c:2483:b0:407:73fc:6818 with SMTP id 3-20020a05600c248300b0040773fc6818mr1095597wms.2.1699307299346;
        Mon, 06 Nov 2023 13:48:19 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u3-20020adfed43000000b003140f47224csm617514wro.15.2023.11.06.13.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 13:48:18 -0800 (PST)
Message-ID: <7be96bfd-7e79-4b13-87fa-0e3d06ead30b@arista.com>
Date:   Mon, 6 Nov 2023 21:48:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] tcp: Fix -Wc23-extensions in tcp_options_write()
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     ndesaulniers@google.com, trix@redhat.com, noureddine@arista.com,
        hch@infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, edumazet@google.com, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com
References: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v3-1-b54a64602a85@kernel.org>
 <a8cc305d-0ab8-4ff7-b11a-94f51f33ec92@arista.com>
 <20231106213408.GA1841794@dev-arch.thelio-3990X>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <20231106213408.GA1841794@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 21:34, Nathan Chancellor wrote:
> On Mon, Nov 06, 2023 at 09:26:48PM +0000, Dmitry Safonov wrote:
>> Seems like exactly the fix that my git testing tree had, with an
>> exception to naming the helper tcp_ao_options_write().
> 
> Heh, not sure why I never considered that as an option... I am guessing
> it does not matter enough for a v4 at this point but I could send a
> net-next change later to update it if you so desire!

It doesn't matter really, not worth another patch :-)

>> But then I found* your patch-v1 and decided not to send an alternative
>> patch.
>>
>> Thanks for fixing this,
> 
> Thanks for taking a look!
> 
>> Reviewed-by: Dmitry Safonov <dima@arista.com>
>>
>> *had to fix my Gmail lkml filter to label not only emails with cc/to my
>> name, but also the raw email address (usually, I got them to/cc "Dmitry
>> Safonov", but this one didn't have the name and got lost in the lkml pile).
> 
> Sorry about that, b4 used to have some interesting behavior around names
> at one point (don't remember the details at the moment) and just using
> emails avoided those issues. Maybe I should go back to names and emails
> to see if I notice any problems again.

No worries, should be fixed now. I preferred previously filtering by
full name, rather than email address as I send patches from both work
and home emails, but also sometimes people send patches/questions to
emails from the companies I previously worked for, regardless .mailmap
entries.

Probably, they look for author in lkml/mail archive, rather than use git
to get the current/proper email address.

Thanks,
             Dmitry

