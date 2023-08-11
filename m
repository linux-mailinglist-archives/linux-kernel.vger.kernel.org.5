Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8837779B70
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbjHKXiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbjHKXiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:38:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCDF26B6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:38:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so4034854e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691797081; x=1692401881;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:references:cc:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJngVVHHScAmtRuoP8NPIKPHyba7C4nesv8wJtBqOxg=;
        b=fNWxuyT+H354GYkZHqgf6Th5aqorwBc7M5O4VxKBW0Yi5qYyaFRnl87sZEIJn1Xyon
         FI95SrX/5Uhn2sKa/A7Ua9ol+kNA3oXoOWAr+M4svBtjsHe/h/eL6FBHqrByd0tl5S+J
         fcg66NrhIJHJ3mmYVlIRt1zkm/+JjQJXiJhw381BfhTgxl3g8U/wAPG+hJsndIC5S4x4
         HvJXgt6n8r0Mtk2xi5goS7KULq/07mtXnB+r8SfozXWtrqFHKYAGLyhKom+PCH13gm6O
         Sxa4Tg1BRcmy5EzsZOi8/hJL5ciby4/+24dPFHldAhUwxE4+KOqyzEbkRDYS6y9IAOHX
         slMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691797081; x=1692401881;
        h=content-transfer-encoding:in-reply-to:disposition-notification-to
         :from:references:cc:to:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iJngVVHHScAmtRuoP8NPIKPHyba7C4nesv8wJtBqOxg=;
        b=e8RrH4U3z/V/7PzYFkafu82JJJz97AyG5WHuiRv6NvkGIUSlrXTIt3wnUq/F7e07ko
         LuqPBvFI7kdl//vIVE3KRZlkuRiNaDj8rFI/3ewTgcIeVWpPKjbp/WZgTZjD9vPjNMt5
         1NYuzWW/CqyzBWJuTsE8HRa1G/IU6L/kN3vSD+1melD+vRS9KBrpKQHNGZMelRIAnW/E
         IcnycMI5EXHIk4k4sXAR/nrAZZLGnqYnCX/iDf6sR1t+MzePs8k+dU2BHEJUjmvD7qDH
         tsEeDF6PGHTSZWFwwdcZsUBy1YnwdgXXxFNkXD5d7GDmXBJR79v2TRVV5xLE5xzsggpT
         Czgw==
X-Gm-Message-State: AOJu0Yzi/xNyQmF6ZNVVRvUIEdsqRPVuzB82ElZb7zo0xra6/EhPBQ2i
        sH0XO06MrBXD8r6F87TcoUc=
X-Google-Smtp-Source: AGHT+IEQ3DhPNaIfIjUmc7a1BpcF2EtM7D6JZXBuMk7hkKwyHtAhbgSgq+Q/roY4+t6nSWOegmVsWg==
X-Received: by 2002:a2e:9842:0:b0:2b7:4169:fcf5 with SMTP id e2-20020a2e9842000000b002b74169fcf5mr2572422ljj.37.1691797080940;
        Fri, 11 Aug 2023 16:38:00 -0700 (PDT)
Received: from ?IPV6:2001:1ae9:2f0:fa00:546f:93fc:49cd:cae3? (2001-1ae9-2f0-fa00-546f-93fc-49cd-cae3.ip6.tmcz.cz. [2001:1ae9:2f0:fa00:546f:93fc:49cd:cae3])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906868b00b0099bca8b9a31sm2770706ejx.100.2023.08.11.16.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 16:38:00 -0700 (PDT)
Message-ID: <bbea3292-df02-4f6b-5ffa-9cfc9681facc@gmail.com>
Date:   Sat, 12 Aug 2023 01:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/1] *** Fix kill(-1,s) returning 0 on 0 kills ***
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
References: <20221122161240.137570-1-pskocik@gmail.com>
 <202211220913.AF86992@keescook>
 <d2d508b7-f267-0fe6-1b56-4292c95355a7@gmail.com>
 <878rai7u0l.fsf@email.froward.int.ebiederm.org>
 <336ae9be-c66c-d87f-61fe-b916e9f04ffc@gmail.com>
 <87pm3t2rvl.fsf@email.froward.int.ebiederm.org>
From:   Petr Skocik <pskocik@gmail.com>
In-Reply-To: <87pm3t2rvl.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        GB_FREEMAIL_DISPTO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. I appreciate your patch and your researching of this.

I still think returning -EPERM for kill(-1,s) (unlike for kill(-pgrp,s), 
where it *can* make sense) is nonsensical because of how POSIX specifies 
kill(-1,sig) specifically ("sig shall be sent to all processes 
(excluding an unspecified set of system processes) for which the process 
has permission to send that signal"). But as I said, any error will do 
for me, so I am still grateful for your patch.

(The way I see it, the POSIX-mentioned possible hiding of processes via 
ESRCH is a completely different matter. In kill(-1,sig) specifically, 
targets that would return -EPERM are excluded/hidden by virtue of the 
definition of kill(-1,sig), which makes it different from other types of 
kills for which there's no generic need to hide EPERMs (only optional 
specific need, hence the paragraph in the POSIX spec on processes with a 
different security label)).

Best regards, Petr Skocik
