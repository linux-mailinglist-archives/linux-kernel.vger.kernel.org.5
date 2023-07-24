Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF24B75F6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjGXMqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGXMqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:46:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97D1126
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:46:51 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6686708c986so4109525b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690202811; x=1690807611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T0sq2Bt2nSIWuT9PvAN9T05t3oE+UOfacoPyr4XHt8Q=;
        b=QNMQ7LEtCmqcDs1mojGcu17XO6RMbFoE2W0a/yikJoQGOfT8ugtltCbppGTulBdHr2
         IXPiQKLpauvPk7nT+L2AKmod02aFH8TzyNmLHZuyuN/p8fpnAyQR/alwNu5/mKhJ8eEm
         GdpNBtfQebaU4qz67SZQ+hhQ8ZRCyQOR8u0bWf5974yUA41q93LyfumxnHr+dyabwSnY
         ItjsPl9gAc5GeDXbABAwhzbfj+JhREhmXuqSA6MihA3FUHnrNYSsDGeGB30xuKdfZiIf
         jGxaCQTILYfZIl5Mi9wwmIIdcP4Rsa9Na+vLZTNJJhYBMyOfHMX4BC7UJwcyKqpmIQZf
         Asww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690202811; x=1690807611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0sq2Bt2nSIWuT9PvAN9T05t3oE+UOfacoPyr4XHt8Q=;
        b=HuNaNZdL+Mn3TbKhLCm1tK5FsHAyz7cWtFf+WyZrOypSSBmAMRos1eu9Cz7HaLnYW2
         e9ZeFeIzOnS4PcnTxJSXkrXnG7HSqxZ9APDfxi6qjBhb3p7yCTUfgpiK2uK5G9dQKZUS
         7bjA35Ldb0wCxUrJebY25TGNwc17J4d6dL5O8FZRtWJnHHfkuk9Bwyn0b6+ZeUO2itkv
         9L3H6I9GdznLmWgef8R3zgeH5+KwViRnbWHq3xFr2tVnGIOxTFRsZ+GE/b/MBoLFy2as
         kPzPrItisQqTWXSdZSK6Rg1TGc4cETzixxWEYkYUhhfLUZCG55c7+DsPRwOp8RNpHY30
         htuA==
X-Gm-Message-State: ABy/qLbl1sGsWS4+7fOTZuUa9sltjFxzdJNOzfDQNIpA6nNRzBOVCw8O
        ZoaBk25e6RTu6/1JLva0wWkAZA==
X-Google-Smtp-Source: APBJJlFjwDGMI02c/R1mVUHI1o4YuX/dZ2GwNYR/owQUCT4/MbNwvR9Co+nPtRXXm6K9bU4rPZshWQ==
X-Received: by 2002:a05:6a00:2191:b0:668:83b6:bfe8 with SMTP id h17-20020a056a00219100b0066883b6bfe8mr10371279pfi.9.1690202811125;
        Mon, 24 Jul 2023 05:46:51 -0700 (PDT)
Received: from [10.254.61.231] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id bn9-20020a056a00324900b00678afd48250sm7603633pfb.218.2023.07.24.05.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 05:46:50 -0700 (PDT)
Message-ID: <f562cf52-6251-25cf-7b33-a2135cdcc313@bytedance.com>
Date:   Mon, 24 Jul 2023 20:46:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] kernfs: add stub helper for kernfs_generic_poll()
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20230724121823.1357562-1-arnd@kernel.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20230724121823.1357562-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/24 20:18, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In some randconfig builds, kernfs ends up being disabled, so there is no prototype
> for kernfs_generic_poll()
> 
> In file included from kernel/sched/build_utility.c:97:
> kernel/sched/psi.c:1479:3: error: implicit declaration of function 'kernfs_generic_poll' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>                 kernfs_generic_poll(t->of, wait);
>                 ^
> 
> Add a stub helper for it, as we have it for other kernfs functions.
> 
> Fixes: aff037078ecae ("sched/psi: use kernfs polling functions for PSI trigger polling")
> Fixes: 147e1a97c4a0b ("fs: kernfs: add poll file operation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> While the stub was always missing, this only caused problems now that sched/psi.c
> calls it unconditionally. The patch that caused it was already merged into v6.5-rc2
> ---
>  include/linux/kernfs.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 73f5c120def88..2a36f3218b510 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -550,6 +550,10 @@ static inline int kernfs_setattr(struct kernfs_node *kn,
>  				 const struct iattr *iattr)
>  { return -ENOSYS; }
>  
> +static inline __poll_t kernfs_generic_poll(struct kernfs_open_file *of,
> +					   struct poll_table_struct *pt)
> +{ return -ENOSYS; }
> +
>  static inline void kernfs_notify(struct kernfs_node *kn) { }
>  
>  static inline int kernfs_xattr_get(struct kernfs_node *kn, const char *name,

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks.
