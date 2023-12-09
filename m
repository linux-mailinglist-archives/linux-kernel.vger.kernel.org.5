Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3A780B417
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjLIL55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 06:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIL5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 06:57:55 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AF6137
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 03:58:01 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9fa2714e828so381121766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 03:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702123080; x=1702727880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxvYWbM0GztVORxWQCRKtFGI3P1vjafrMQXLrc8bXsU=;
        b=ekfKrsEp60iQDB80zAjyWsOnOerNrpjVtGmFIqdnqZuyc+/+t3IfYAEFZYeIcB/sx+
         GKhpvVFr6WenmEyWPA8c5Xhe6jIfvII7uIl/pmkSgOYDPP4PkagYoz6saXff0J7YEU9m
         MJS/MhK3NxH/ej3yA744hooHlTVEizUlFzJqTQG7tCV0cECD7vQFyfAXlEGL91e5aRIb
         Mr3Y3kE/rpCs1OarP13u+VwCgUzOLx1fIXz+ushU/4UztNzfivNw6lL54ZiF99Nv7Etk
         DQYASzUQlsJI58il4OfeojUFz3gnDpdQrGgb8lfA++dgKZXQb434P07K/jYyWeee2BTt
         W3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702123080; x=1702727880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxvYWbM0GztVORxWQCRKtFGI3P1vjafrMQXLrc8bXsU=;
        b=rPWBzA9Z5l4BlOL/ytoGoJQe1HVXVewOtFp+9nnsdyIpF5C5vg4ptQvmfkkuYGXdJA
         74sla84Z6c3BV5AyDy10EOLGZnbUjwIc2j0m8AVOpfZWIvEBksevMHMHs4+0svvyoCjR
         3Iil3tU6fsX1dwC6VrLmWAyO1tMhgkWIMIsewKo4Q60QA7y1aww6NOWzH0mQXAixnI1n
         G15zPkdsNnMmh2ElUIbhEMPeBIku0PZ5d/Nq9SjhM+Ne2fxeaoR5JE5iSsCTPkGcvi2z
         4+hhJnP3Jg0Ei3sNtNYaKqE9e5LHYNuXozq+xQCwQufjeinQ1c2dpnlD6VZ4IcKu+F0l
         kdhg==
X-Gm-Message-State: AOJu0YyPBTfmiFyBG3Y7cNVeK2IS5kpBKgScUoP+cpEteTYzpufWYfpW
        Ic7Z5N4LqaC9O38YCsGTWaZVuQ==
X-Google-Smtp-Source: AGHT+IH4nCKaVYLKMFZ8qImJzJYlbXcBHMs9wKrrNxbnEPBuO4YaD1OwSWZij8RLR5R+Nexd3aG0dw==
X-Received: by 2002:a17:907:7203:b0:a19:a19b:55e3 with SMTP id dr3-20020a170907720300b00a19a19b55e3mr889980ejc.115.1702123080035;
        Sat, 09 Dec 2023 03:58:00 -0800 (PST)
Received: from ?IPV6:2a10:bac0:b000:731f:e6b0:e567:aab6:1db2? ([2a10:bac0:b000:731f:e6b0:e567:aab6:1db2])
        by smtp.gmail.com with ESMTPSA id mn6-20020a1709077b0600b00a18374ade6bsm2129793ejc.67.2023.12.09.03.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 03:57:59 -0800 (PST)
Message-ID: <301cd2d8-e798-41ff-9ae1-814566fe5a19@suse.com>
Date:   Sat, 9 Dec 2023 13:57:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Remove reference to syscall trampoline in PTI
Content-Language: en-US
To:     corbet@lwn.net
Cc:     tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231102130204.41043-1-nik.borisov@suse.com>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231102130204.41043-1-nik.borisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.11.23 г. 15:02 ч., Nikolay Borisov wrote:
> Commit bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")
> removed the syscall trampoline and instead opted to enable using the
> default syscall64 entry point by mapping the percpu TSS. Unfortunately
> the PTI documentation wasn't updated when the respective changes were
> made, so let's bring the doc up to speed.
> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>

Ping?
