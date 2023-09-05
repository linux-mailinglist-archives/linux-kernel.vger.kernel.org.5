Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AB17929CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353498AbjIEQ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243767AbjIEA7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 20:59:09 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BB11B8;
        Mon,  4 Sep 2023 17:59:06 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1ccb6a69b13so1698007fac.2;
        Mon, 04 Sep 2023 17:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693875545; x=1694480345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dLrGwF7Q9t7xxwB/U+vDJLJpUVQoRU/i+CxEAvmTOTw=;
        b=E2u9KhGcAfvxrF2r7sV2sWj7iamEWCvTwcHpTJzlVImae9Rnj8wmCF1dc2wic0zzUz
         KTpPgqvrTZPCvtqJkSgWmt/3KGnkezcwgoHpobDUrpfIIG73JleFSsVMN+UjbGRqysN/
         EEH4bFvswOt9FA1PcvD7nH9dpANWb/CDegG7hQuVXAZ2qFlFNzel3pWTBgsALgaIAO45
         Y+RUu8hLQkOxx2FkVamep22T0IdN0vFAEilXXnJCy2k0bQISgzneeCsLa1iHYm/EDTG5
         inbtkF4+iXn2WfRXJDvWmGtAKwq5tbQrfopNuLpaaeFu+/rDmDtPo2LCOKHXDDMvqWUg
         kVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693875545; x=1694480345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLrGwF7Q9t7xxwB/U+vDJLJpUVQoRU/i+CxEAvmTOTw=;
        b=QklooEgy0ikG0R3la6oelBcHzr7fVPjyysVlUOtGGisJ0bPgqQd4Atgv207IzeTbTq
         zkmB4dGnUl0kbYmPrNNgV3u75UbQ9+ctf8uRLJzLmiXVjz40ca53dMYhRJ/ImgS1jfTs
         p/l12RrbIWpJKtXoLU8CiJKTsa98iYJY4Ke6shuoUm5f+p/ALKGuKX2K84DTAwwzKxiA
         fGzhccqG13zEl7QCRIL3BCFjjlhTHoek9meYAXtXQ+db5HfT/rXWFO25J1Vqr2csyL+7
         2xNQf5/BCl73PY1X9XoK2BP7Gs99PUdhY5tr/s9GvpaQNpsILcM3BghhX4BaDkn7d+TQ
         14pg==
X-Gm-Message-State: AOJu0YzhruR7hbf95T4e2sBf9sb0zYkGHbomDqd+udTwgJPjf1XQ/5+p
        d72YRlra/TQH7p2ftZk0VQc=
X-Google-Smtp-Source: AGHT+IECbTnQOZgaDbcCVxBK4jnwwMyne108aX195E7LvljvfjUH31XW+BzLrh9JNzRTvDoQM844Ag==
X-Received: by 2002:a05:6870:220b:b0:1cd:249a:690c with SMTP id i11-20020a056870220b00b001cd249a690cmr14771662oaf.20.1693875545135;
        Mon, 04 Sep 2023 17:59:05 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id t9-20020a4aadc9000000b0055975f57993sm4965632oon.42.2023.09.04.17.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 17:59:04 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <96eb9ff2-a687-bbd5-9cb1-4b044f7deae3@lwfinger.net>
Date:   Mon, 4 Sep 2023 19:59:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] ssb: Fix division by zero issue in ssb_calc_clock_rate
To:     Rand Deeb <rand.sec96@gmail.com>, Michael Buesch <m@bues.ch>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     deeb.rand@confident.ru, lvc-project@linuxtesting.org,
        voskresenski.stanislav@confident.ru
References: <20230904232346.34991-1-rand.sec96@gmail.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230904232346.34991-1-rand.sec96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/23 18:23, Rand Deeb wrote:
> In ssb_calc_clock_rate(), there is a potential issue where the value of
> m1 could be zero due to initialization using clkfactor_f6_resolv(). This
> situation raised concerns about the possibility of a division by zero
> error.
> 
> We fixed it by following the suggestions provided by Larry Finger
> <Larry.Finger@lwfinger.net> and Michael Büsch <m@bues.ch>. The fix
> involves returning a value of 1 instead of 0 in clkfactor_f6_resolv().
> This modification ensures the proper functioning of the code and
> eliminates the risk of division by zero errors.
> 
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> ---
>   drivers/ssb/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
> index 0a26984acb2c..9e54bc7eec66 100644
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -835,7 +835,7 @@ static u32 clkfactor_f6_resolve(u32 v)
>   	case SSB_CHIPCO_CLK_F6_7:
>   		return 7;
>   	}
> -	return 0;
> +	return 1;
>   }
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry

>   
>   /* Calculate the speed the backplane would run at a given set of clockcontrol values */

