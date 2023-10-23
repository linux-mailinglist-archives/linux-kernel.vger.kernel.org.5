Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10DD7D3DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjJWRj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJWRjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:39:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631ED83
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:39:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so54524421fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698082791; x=1698687591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kNQwyaGuIu7F+p1B5DfVkuQ0+sVIXi1xDTFxBww6HMA=;
        b=xtjytsbA95msPyo7nVmtcboi3OOTLSfzrYxFRMTxtVpcEL0GBIw9mX4CfxOpuGTRbW
         Jsn3+jBGAt4NYgMezVRzt2O7N+PuwfgdqKqe/GQkIc7DV+Or24kl08aO3OEYJmAMW16/
         ITDI/WrA1hc3cCbuH4doBxDj5ID8NcHQZvcJcUmXaRHMx0JsDf43PtJ+VOIaMW5ovZFP
         H2G/hFAhgxzlc6kMWOzY90OSQNxflXGvkm+ycUV8MJVCTc7jIG2lHGG4BIq50u2h7mHG
         T0ENJRHq3mQymexePM34nrbXaxaWn6OgWmIml/edi1lYD67etNMxT/CfFm5TH8Mas8eX
         3U+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082791; x=1698687591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNQwyaGuIu7F+p1B5DfVkuQ0+sVIXi1xDTFxBww6HMA=;
        b=Cl83XEtjCeJN8sYEAx19GxKwxnKy/C1+GmRKwuQ0FjG0nFT1a8odX51GrMvnGZX8uf
         mJEaT1zr9rJf9IDaojcuQ//oSk0D3iktsH/szroXTD1Z+B/5zjTBiQ8/glKLhfEE9auV
         XJ/gxZhTFp/8aqakDNtDrIMpTlkP/ZkxsBdwZwyirUj8FA2fSGJ5O1ZjvWyTg338+CIz
         JE66YrIwxC6brT+SjbJNiX5Mkl+MnIvwXj93qSeb0T99nVpz0uIScjtsPEqguMQJ4kAg
         tp14zN8dwEB9ZtSAArfNUGjyKinpwy/7usZl4vBuM/A/kvET/o35Sf38WoxOqi6xJ8Qt
         IvDA==
X-Gm-Message-State: AOJu0YzPXMvrjBbRYge4XIJUUTbzN84dnyn9OAq8I/pGAKDEZ7+mOv1Q
        Oi/spFanETgFACqJoKNTmhpXoJ0kqW1BMl6A9waEJQ==
X-Google-Smtp-Source: AGHT+IE2Gp3uEgKdpVzP2c8Nh09UF311aX6kJy+WK6Ue579tldWifxjRJ+DxmRdC5cBR70cy9iTb6w==
X-Received: by 2002:a2e:7a0d:0:b0:2c5:40a:5d92 with SMTP id v13-20020a2e7a0d000000b002c5040a5d92mr6557526ljc.28.1698082791553;
        Mon, 23 Oct 2023 10:39:51 -0700 (PDT)
Received: from [192.168.198.23] ([37.166.25.68])
        by smtp.googlemail.com with ESMTPSA id n35-20020a05600c3ba300b003fef5e76f2csm4485092wms.0.2023.10.23.10.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 10:39:51 -0700 (PDT)
Message-ID: <6786c91e-12ce-a9dd-12fe-bc02c6d782b8@linaro.org>
Date:   Mon, 23 Oct 2023 19:39:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 04/18] PM: EM: Refactor em_pd_get_efficient_state() to
 be more flexible
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-5-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230925081139.1305766-5-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2023 10:11, Lukasz Luba wrote:
> The Energy Model (EM) is going to support runtime modification. There
> are going to be 2 EM tables which store information. This patch aims
> to prepare the code to be generic and use one of the tables. The function
> will no longer get a pointer to 'struct em_perf_domain' (the EM) but
> instead a pointer to 'struct em_perf_state' (which is one of the EM's
> tables).
> 
> Prepare em_pd_get_efficient_state() for the upcoming changes and
> make it possible to re-use. Return an index for the best performance
> state for a given EM table. The function arguments that are introduced
> should allow to work on different performance state arrays. The caller of
> em_pd_get_efficient_state() should be able to use the index either
> on the default or the modifiable EM table.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---

[ ... ]

> @@ -251,7 +253,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>   	 * Find the lowest performance state of the Energy Model above the
>   	 * requested frequency.
>   	 */
> -	ps = em_pd_get_efficient_state(pd, freq);
> +	i = em_pd_get_efficient_state(pd->table, pd->nr_perf_states, freq,
> +				      pd->flags);

nitpicking but s/i/state/

Other than that:

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> +	ps = &pd->table[i];
>   
>   	/*
>   	 * The capacity of a CPU in the domain at the performance state (ps)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

