Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6177DFF6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbjHPLEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244382AbjHPLDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:03:40 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F742D45;
        Wed, 16 Aug 2023 04:03:11 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9923833737eso847694566b.3;
        Wed, 16 Aug 2023 04:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692183733; x=1692788533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJU6KQ3PJKsFFkSrCzSUBY4MjtuY9BbjYXsDhDJBkXg=;
        b=Wv1ChWiNhjbIBBSZSqlKABdFM9/5ox5WJ/Gnnf0WIM/Z8M0FoIfW4+1373dMmrYAip
         F5n+f7Szp0J8ShDmfnV/6/jS9c3H9RwMoCkCaABipLperyLVCzbaPk78xeKGq6wR8tbE
         wAXjmz1xOD69JqVHSciTvrBMFPPCPuc6UhmDqV4Q4U2W6P+TtlR+monNS9QWmIFVpJ9M
         jOznVXEOHS2qACiL1lYt4xR5EsLrNgPXivygy8iA7RR1ZC9MGI+gVY5luviMmKke6J12
         kF4KGSurGj+FDEAcv+J23hAjDgGmyFrDS//OhXj+7WeGL9pdS4urq3bZAvmiwRBwm0D3
         6rCg==
X-Gm-Message-State: AOJu0Yyg9n09nAOh79msJPOmiLk4M5cUHFgWEbzG/gxqA9Wdq5wEAcMC
        LAfuQl7ZgvZW6c6IAaRqeKEBXQsRNg7Kpw==
X-Google-Smtp-Source: AGHT+IFAQGmIJBKVXeFZIjDADVrbgYhoaJ3OX9d1+JK1G4mWPysrluNt+z2cbPv0Qc6lUD2Ph/vUPg==
X-Received: by 2002:a17:906:b009:b0:99d:101b:8403 with SMTP id v9-20020a170906b00900b0099d101b8403mr1158873ejy.36.1692183732740;
        Wed, 16 Aug 2023 04:02:12 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id z24-20020a170906241800b009934b1eb577sm8433429eja.77.2023.08.16.04.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 04:02:12 -0700 (PDT)
Message-ID: <1882495c-b16b-10f0-2acf-ee86cf4e031b@kernel.org>
Date:   Wed, 16 Aug 2023 13:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 00/14] tty: n_tty: cleanup
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816105822.3685-1-jirislaby@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230816105822.3685-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bah, this series intermixed with old patches in one dir.

Patches 1/4 2/4 3/4 4/4 are to be ignored.

OTOH, 01/14 ... 04/14 are a correct part of this series.

Do you want me to resend?

On 16. 08. 23, 12:58, Jiri Slaby (SUSE) wrote:
> This is another part (say part III.) of the previous type unification
> across the tty layer[1]. This time, in n_tty line discipline. Apart from
> type changes, this series contains a larger set of refactoring of the
> code. Namely, separating hairy code into single functions for better
> readability.
> 
> [1] https://lore.kernel.org/all/20230810091510.13006-1-jirislaby@kernel.org/
> 
> Note this is completely independent on "part II." (tty_buffer cleanup),
> so those two can be applied in any order.
> 
> Jiri Slaby (SUSE) (14):
>    tty: n_tty: make flow of n_tty_receive_buf_common() a bool
>    tty: n_tty: use output character directly
>    tty: n_tty: use 'retval' for writes' retvals
>    tty: n_tty: use time_is_before_jiffies() in n_tty_receive_overrun()
>    tty: n_tty: make n_tty_data::num_overrun unsigned
>    tty: n_tty: use MASK() for masking out size bits
>    tty: n_tty: move canon handling to a separate function
>    tty: n_tty: move newline handling to a separate function
>    tty: n_tty: remove unsigned char casts from character constants
>    tty: n_tty: simplify chars_in_buffer()
>    tty: n_tty: use u8 for chars and flags
>    tty: n_tty: unify counts to size_t
>    tty: n_tty: extract ECHO_OP processing to a separate function
>    tty: n_tty: deduplicate copy code in n_tty_receive_buf_real_raw()
> 
>   drivers/tty/n_tty.c | 551 +++++++++++++++++++++++---------------------
>   1 file changed, 284 insertions(+), 267 deletions(-)
> 

-- 
js
suse labs

