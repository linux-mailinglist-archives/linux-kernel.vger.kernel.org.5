Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A629757E13
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjGRNrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjGRNqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:46:52 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFFD124
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:46:27 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63588812c7aso25038766d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689687986; x=1692279986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5gDeWaSeLpSSmm/E8qPIij+tO48vpZFmnMjNa47DSU=;
        b=fgQxFQm80HjUt8ykOXh/bprQWsULUuDuQXvsgRomxjBN71NgyX4eFyR50GKFtF+3Fj
         d/P1DVxCOePJHTk1y3eciUa2a6/ahctJsncy1S/k/gCCCLTwOi2yIXwb3ntLYXX8TmxC
         DiiGnyXZx3hnbDfQDT2nuLzzfmbXZkfheZO8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689687986; x=1692279986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5gDeWaSeLpSSmm/E8qPIij+tO48vpZFmnMjNa47DSU=;
        b=UzM7itTtOVdtDAw++LDz5iJ7AX2BdaMpRcXD7+3mEH7cX99BCZSiBASBHzm61zHAQS
         nND9A++C54wFUTzPjK1mNRUZVlz/BL3Y/0dgr9qsIOPTu/erunydOaT6qjFwRpzHYu1o
         jmL2CO5DY0UbjO8pXn7qu11KAJCF2MCh/KT9kS4ShsS4vZ7moaPe/k4ePNzsy9fIfaRv
         QnbXh1KnObB0yRDV2ux0tOIPuUIQ4SWtEnMJFNTgW+qEoHLMQIMERFNgclGu4i4sz1Xj
         8LuZZDffCIAumB+6vB8WKVg6wT0PkIzt5pCvxVWDUZV0xr9AN/mD9e2CRYwUTRi9Oca5
         SZIg==
X-Gm-Message-State: ABy/qLaMUvjxfvijKf7bXEgISvg4bbx/etE2QvInaNejnITXlWR0mXvm
        pUrngoRdsBxllzbqVEliCLzd+Q==
X-Google-Smtp-Source: APBJJlGSfPIcEdlW4LkiisGeLuk2NGMuBA7JnbuYHT3/uLBJ72nuFA5/x2aJpeUpPEKOX1vWK0g2dQ==
X-Received: by 2002:a05:6214:260c:b0:635:e041:71c6 with SMTP id gu12-20020a056214260c00b00635e04171c6mr15072873qvb.17.1689687986032;
        Tue, 18 Jul 2023 06:46:26 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id b6-20020a0cb3c6000000b00631fc149a19sm725092qvf.110.2023.07.18.06.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 06:46:25 -0700 (PDT)
Message-ID: <3586af97-e9bc-341f-4a81-678b5e1e96f8@joelfernandes.org>
Date:   Tue, 18 Jul 2023 09:46:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rcu 5/6] rcu: Make the rcu_nocb_poll boot parameter usable
 via boot config
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-5-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20230717180317.1097590-5-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 14:03, Paul E. McKenney wrote:
> The rcu_nocb_poll kernel boot parameter is defined via early_param(),
> whose parsing functions are invoked from parse_early_param() which
> is in turn invoked by setup_arch(), which is very early indeed.  It
> is invoked so early that the console output timestamps read 0.000000,
> in other words, before time begins.
> 
> This use of early_param() means that the rcu_nocb_poll kernel boot
> parameter cannot usefully be embedded into the kernel image.  Yes, you
> can embed it, but setup_boot_config() is invoked from start_kernel()
> too late for it to be parsed.
> 
> But it makes no sense to parse this parameter so early.  After all,
> it cannot do anything until the rcuog kthreads are created, which is
> long after rcu_init() time, let alone setup_boot_config() time. >
> This commit therefore switches the rcu_nocb_poll kernel boot parameter
> from early_param() to __setup(), which allows boot-config parsing of
> this parameter, in turn allowing it to be embedded into the kernel image.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   kernel/rcu/tree_nocb.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 43229d2b0c44..5598212d1f27 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -77,9 +77,9 @@ __setup("rcu_nocbs", rcu_nocb_setup);
>   static int __init parse_rcu_nocb_poll(char *arg)
>   {
>   	rcu_nocb_poll = true;
> -	return 0;
> +	return 1;
>   }
> -early_param("rcu_nocb_poll", parse_rcu_nocb_poll);
> +__setup("rcu_nocb_poll", parse_rcu_nocb_poll);

I was trying to see if core_param() could be used. But I am not sure if the RCU 
offload threads are spawned too early for that.

I am Ok with it:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

  -Joel


>   /*
>    * Don't bother bypassing ->cblist if the call_rcu() rate is low.

