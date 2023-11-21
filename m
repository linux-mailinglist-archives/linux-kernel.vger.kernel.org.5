Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66427F354E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjKURwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbjKURwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:52:17 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A366193
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:52:13 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cf678043fdso15377885ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700589133; x=1701193933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QB47EGfsEp2zY8aVpZ1yVDhEkhsejg57h9CxYIF9pMY=;
        b=RSU8gWck77NXCZny7Jlx/NGb4kecJIYRWEcnVjBCM/uqXAEoJdHhUR9mc+3fd+3N1+
         4RwXD+FketwnKRl+XE8iQbO7mIRu6fWQYVpKYyHla02fUrAk1gKVCW6D+nBilzQEjlme
         7cx9q0Zx7lRwYlfoPSnUxxlLPnCXR+aUde+b5glcJGWvxgYSbRtLrQLhIglyiJr6EZX6
         T49TaOQSYYzN7PcQ53SeoUfR0rfPInnLNbUOWT8MsZKb98HadmV6Cf0mcUA5YrYiusgZ
         r5ha3+rgR3CXJPtxty45laJGgi7HA7Wh3+MiCfUL9ZIc055H1QL8pjN3BtQcySHANkU4
         7GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700589133; x=1701193933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QB47EGfsEp2zY8aVpZ1yVDhEkhsejg57h9CxYIF9pMY=;
        b=A+7mOsC++I1fEb7tbtBXq21s2YjlvJ44L8gCigEG/CUTWgQdJ8AywVVrmW36HFkWLs
         ZoT2Q5+FeMKZGyb2pDIn/URG+B7pB9QeTKUaPMT8b4g2hevJEF5joIKOU5ogIwRh4f1R
         Orw+sInsMs7BFGeUt133AKNNMXGwyQIXuqlvTfEZgiLeFQVUefk4TBsqeyTcZ0muI1kO
         wA9plsgQHkgcmHRG7ck0PxlIr2dEHrvatdyFMbRfSSkyoDy7Usy0yrMMeHOWGJmppqnv
         RZgKBCIdBKZ0HmuO03HPy07LU1MQT95Ix72rz9i9oLt5iAMSpftb6rsu8X6wK+B+wgX2
         AjCQ==
X-Gm-Message-State: AOJu0YxcwfygF+P4IvJgHbPDozcmnGJJxfoWNv4MUdwf/RQxfxnkezSe
        2pokgggsgcb1qA83mIbJt/0RNA==
X-Google-Smtp-Source: AGHT+IFWYeTkevTsKJFuxiA1n9NmJm/3ZFZkrXCfs5QmtKQPONxovvZR+2Zqk+21Ud++2IVfWkz2tg==
X-Received: by 2002:a17:903:1205:b0:1bb:598a:14e5 with SMTP id l5-20020a170903120500b001bb598a14e5mr14104285plh.43.1700589132895;
        Tue, 21 Nov 2023 09:52:12 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
        by smtp.gmail.com with ESMTPSA id ju4-20020a170903428400b001cc3875e658sm8267124plb.303.2023.11.21.09.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:52:12 -0800 (PST)
Message-ID: <6c37708e-c345-4cad-b002-7cc18c9cb7ed@linaro.org>
Date:   Tue, 21 Nov 2023 11:52:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] tty: srmcons: make 'str_cr' const and non-array
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
References: <20231121092258.9334-1-jirislaby@kernel.org>
 <20231121092258.9334-18-jirislaby@kernel.org>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231121092258.9334-18-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/23 03:22, Jiri Slaby (SUSE) wrote:
> 'str_cr' contains a single character: \n. There is no need to declare it

\r

> as array. Declare it as a variable, make it const and pass a pointer to
> it to callback_puts().
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> ---
>   arch/alpha/kernel/srmcons.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
> index c6b821afbfd3..a6cff61706b5 100644
> --- a/arch/alpha/kernel/srmcons.c
> +++ b/arch/alpha/kernel/srmcons.c
> @@ -91,7 +91,7 @@ srmcons_receive_chars(struct timer_list *t)
>   static void
>   srmcons_do_write(struct tty_port *port, const char *buf, int count)
>   {
> -	static char str_cr[1] = "\r";
> +	static const char str_cr = '\r';

An array of one element is fine -- what's wrong with that?
Adding const is an improvement though.


r~
