Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9F803BDE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjLDRmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjLDRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:42:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B719D3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:42:22 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c09fcfa9fso15840805e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701711741; x=1702316541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+fpeW75cFZBqvUHhUaPqs/+/3ysyB7NjQ95Y7Hzi7I=;
        b=DZmIx9fArHow03bPVgM9F/FtdrIR4PlyWGO7bR8D76/Upg+2ZnwGE7DM56RJ0BlObJ
         lGGESnVuzRVm1mtDZXZfajiP7LdJSO3zunB0Z7KU2vWRnmOGb9j6nHQdLkP0FUaUK5HN
         RhNQj+BB30iACGoLZhTRxWwGY90PmzBk15IgmN7nqQJxr1VUtnaTWX7vL22giJ8fp588
         QhkcjWeBDkkGHTqlu3FfjbIqGRkg/7BnHWd9cT0PpxLGK9OJHsJQe0/X7NeP2hIqApGU
         EUlQV55DUenm26Ms1IGF5BtODGC2lWpbgwMowcq8fH2JnuvE6TS2gsm/tnV4tIF0nQnS
         SVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711741; x=1702316541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+fpeW75cFZBqvUHhUaPqs/+/3ysyB7NjQ95Y7Hzi7I=;
        b=CT72s7LSgqIupIDw8dQFYRBA36d9kTm9ho18RdMfYFL4aiXIoRw6eEf1SrERZz3nKK
         clE9wzD6tihofDe/hKu59ezw43a2/Fp0FCZUu+BnifBN6/Jj7bO50LcQ4ZKxhbm2V9GR
         wtrEhET2W+Xa74w+O0VXB5QM3MpfYG6ekCIdDTml/mArjq+ArcQTZsIb3m95/itIOs5U
         AE4Z2YSbYRP3sHbGzxHTLk/Bk6z81NxHXVR+mPEDL0Nsr/f1SCzSp4SCy7RYXe0jpcK1
         clr/vcwIm1fvuqGnxuvCaIs9oEh54kHxcctUf0J4IOc7faaFLxxYVdOFaY5IF10cq0Oi
         rDJg==
X-Gm-Message-State: AOJu0YxEcxZhwVt067ukiCee7CMw3iVI3Ufmu2Y7H7OirPZjAVQh8ZXP
        UNwzuG07r9KgRAzjUat3QcYuAiQ69OIPwWIXVMI=
X-Google-Smtp-Source: AGHT+IGhQZZ94dA54Rfw2Y5eYQSc3rlXgIaoo1hyGbcQptAOJkiBtiKTsWlLIk295LwmaGZHBcn+2g==
X-Received: by 2002:a05:600c:5249:b0:40b:5f03:b3ce with SMTP id fc9-20020a05600c524900b0040b5f03b3cemr1468213wmb.240.1701711740721;
        Mon, 04 Dec 2023 09:42:20 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c831:1e47:2:5b96? ([2a05:6e02:1041:c10:c831:1e47:2:5b96])
        by smtp.googlemail.com with ESMTPSA id j11-20020a05600c190b00b0040b47c69d08sm19415061wmq.18.2023.12.04.09.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 09:42:20 -0800 (PST)
Message-ID: <8a71b223-defb-4c30-b34d-d024eccbf86c@linaro.org>
Date:   Mon, 4 Dec 2023 18:42:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: timer-ti-dm: Fix make W=n kerneldoc warnings
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>
References: <20231114072930.40615-1-tony@atomide.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231114072930.40615-1-tony@atomide.com>
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

On 14/11/2023 08:29, Tony Lindgren wrote:
> Kernel test robot reports of kerneldoc related warnings that happen with
> make W=n for "parameter or member not described".
> 
> These were caused by changes to function parameter names with
> earlier commits where the kerneldoc parts were not updated.
> 
> Fixes: 49cd16bb573e ("clocksource/drivers/timer-ti-dm: Simplify register writes with dmtimer_write()")
> Fixes: a6e543f61531 ("clocksource/drivers/timer-ti-dm: Move struct omap_dm_timer fields to driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311040403.DzIiBuwU-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202311040606.XL5OcR9O-lkp@intel.com/
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

