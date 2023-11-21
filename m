Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4347F3546
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjKURtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbjKURtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:49:07 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8458718E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:49:04 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cbb71c3020so1183059b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700588944; x=1701193744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MXJqaP9n8CjgzoiH5n3pTHCDJy51tKrsEtKUZtGKn0o=;
        b=Kymjc8eQJqFB+1WawZGFmm5rwkRudVpD7yLbFpTDpcEFDfQBpBPuNUWbTY78Q9Oxyf
         09W0ev46NEZ91N458AfCzgP4cEjBRfi//qjT0KuivPzsXZ3WVLKnek8NhuAyIoPQXAvV
         xfNhesRazd2w8oT6Z8euPB8+VF8xnhO0ecus0eNziAG1r6neS5u5pYJuECc9qRyhstIZ
         8gBFRQf7pRNINu+Yf7sSRSCiAufAAu9OqDl6qvINZwOv6QV0oEYK6cARGM0xZTlMAkmr
         YlBUueG5VY9madjq9lwN0Jw7kYxmLV7SluyBiCe2FAbojIGJgri79N0zeE7svWyfOGJN
         tFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700588944; x=1701193744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXJqaP9n8CjgzoiH5n3pTHCDJy51tKrsEtKUZtGKn0o=;
        b=Vxq+MIEdHQ9+Ce9bG1Y4KTVEZB0qmFhiFPlXyQ+bG6b9KjxHzGeRPtun04dZpzOq23
         JsRZQkMEH+/9J4nPjCOFZ69km36eGFJ2GgdTBszWsiPlBqgdBGcDlGorFCfAhlr8Mnrf
         T69not/zvLmdIro++xyCe2UdyCqjC7P6F773t6YBaDxYHCALuPorSA+SdtS5ugz2XNUm
         sT9RUJnMLrr9POvTlNmuXhLPE38epFzCFX7aRfi7lJ2EQ0hoQ1mssXOZVJXwedlRES7T
         Zxvt8VSYLlX3I9uBbiS+g2mvkndKQGZOBva1NdSko/zZa/Q8rY7tz0ztldcdtkMQx2d0
         O4Xw==
X-Gm-Message-State: AOJu0Yx1gkxQZhJwVDpK1yjb0QOCzA/9bgkhZR/FDbUSaUzj9H1r41m1
        XZZkIOLlH8VAi9NFRxqfPVDOaQ==
X-Google-Smtp-Source: AGHT+IHZYKUmQPsAZKyzIXXSlFSXyQH3BXp0aXl+SLqo3aQCcXZjl7XFH6/OhEzsyY7tAE9b5eduug==
X-Received: by 2002:a05:6a20:1593:b0:185:d125:ea70 with SMTP id h19-20020a056a20159300b00185d125ea70mr69343pzj.19.1700588943997;
        Tue, 21 Nov 2023 09:49:03 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
        by smtp.gmail.com with ESMTPSA id b11-20020a056a000ccb00b006cb69ff0444sm5547127pfv.151.2023.11.21.09.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:49:03 -0800 (PST)
Message-ID: <b8dc336f-06c6-43eb-974b-7af251532d10@linaro.org>
Date:   Tue, 21 Nov 2023 11:49:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] tty: srmcons: switch need_cr to bool
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
References: <20231121092258.9334-1-jirislaby@kernel.org>
 <20231121092258.9334-17-jirislaby@kernel.org>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231121092258.9334-17-jirislaby@kernel.org>
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
> 'need_cr' is a flag, so type it properly to be a 'bool'. Move the
> declaration into the loop too. That ensures the variable is initialized
> properly even if the code was moved somehow.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> ---
>   arch/alpha/kernel/srmcons.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
