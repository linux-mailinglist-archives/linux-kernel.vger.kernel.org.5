Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458B3757C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjGRM7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjGRM72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:59:28 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0D61B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:59:26 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4039f7e1d3aso46987451cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689685166; x=1692277166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5tt9zeLQ2+OjFi48j9FEVf0rh+9eU5vhKKJxQtews0=;
        b=micTBVpm101CT2ld66mNBx1Untcd57oicFHLWr+1pRSRAr10iA6mnsKePo8SwbMu/9
         QfYj7peQd/ZXjHarnUwV57tPXAsZTwrRbvZkFTJtQndf2jWQWNKOPZz1b+LsqBA6V6rN
         LzLOdXxzRBT8m/oKr5vGFIxE4i1J9YfA9wVFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689685166; x=1692277166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5tt9zeLQ2+OjFi48j9FEVf0rh+9eU5vhKKJxQtews0=;
        b=FuI/mKW+iGbSc8Mmva05AAMbHwgh8hL3FBy1EETrywsK4w/cO/kzLWIW9nQsbrBtFc
         mgsPwFAXxH15ChakaHbRDV4dVHjbxFm08N1wDG9LX4DBAQT2HTvSWAXv7pTvtgI2QxN6
         brCROpVu7noOPtJ2Gc0phDk437XmOLGiiGcSRCUo87J0JiYsX4VsffG8vTU40akgCjRQ
         qZVPpLdubHFApLWBDsYq/EBeVF9HnLCcduN2P+UoQnzhZkOW7/URLBy908sasFoC3PfP
         XjQFT+AnQa0c8hr0fymR1hXW9gDHipDe0MEr1vxvbKxIynLE9wwONhuJUV06sBYVH45M
         iGIw==
X-Gm-Message-State: ABy/qLbdGJSaS5Jgfb/11zI2P/DiwhbYH2s6rxGAtKXxtRgXeUY1pFnw
        wtMYtZogc5v0B5F81zX4bhuHug==
X-Google-Smtp-Source: APBJJlEKkEI93fkUaO7eGvqCh1NR0xKX97RJyb9wB2iBrJqsMrY/hnaXb20JZ68zoLZiEiIj0P3M/w==
X-Received: by 2002:ac8:580f:0:b0:403:ebb2:dd4f with SMTP id g15-20020ac8580f000000b00403ebb2dd4fmr9621394qtg.59.1689685166040;
        Tue, 18 Jul 2023 05:59:26 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id gd25-20020a05622a5c1900b004033992e2dbsm625884qtb.45.2023.07.18.05.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 05:59:25 -0700 (PDT)
Message-ID: <e6ba1856-f54b-943e-d01d-097e88900846@joelfernandes.org>
Date:   Tue, 18 Jul 2023 08:59:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rcu 1/6] rcu: Update synchronize_rcu_mult() comment for
 call_rcu_hurry()
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
References: <6127192c-da9b-4599-9738-6e8f92e6c75c@paulmck-laptop>
 <20230717180317.1097590-1-paulmck@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20230717180317.1097590-1-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 14:03, Paul E. McKenney wrote:
> Those who have worked with RCU for some time will naturally think in
> terms of the long-standing call_rcu() API rather than the much newer
> call_rcu_hurry() API.  But it is call_rcu_hurry() that you should normally
> pass to synchronize_rcu_mult().  This commit therefore updates the header
> comment to point this out.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>   include/linux/rcupdate_wait.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> index 699b938358bf..5e0f74f2f8ca 100644
> --- a/include/linux/rcupdate_wait.h
> +++ b/include/linux/rcupdate_wait.h
> @@ -42,6 +42,11 @@ do {									\
>    * call_srcu() function, with this wrapper supplying the pointer to the
>    * corresponding srcu_struct.
>    *
> + * Note that call_rcu_hurry() should be used instead of call_rcu()
> + * because in kernels built with CONFIG_RCU_LAZY=y the delay between the
> + * invocation of call_rcu() and that of the corresponding RCU callback
> + * can be multiple seconds.
> + *
>    * The first argument tells Tiny RCU's _wait_rcu_gp() not to
>    * bother waiting for RCU.  The reason for this is because anywhere
>    * synchronize_rcu_mult() can be called is automatically already a full

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

  - Joel

