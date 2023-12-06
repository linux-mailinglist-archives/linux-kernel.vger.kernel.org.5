Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C26807083
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378393AbjLFNFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbjLFNFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:05:43 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E7CAC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:05:49 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1f060e059a3so3789208fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 05:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1701867949; x=1702472749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzgbFdAZtuGUcSvqWCnnqwHA8w3xAQKY5QSWn1ivO1Q=;
        b=0jGVZKjJMkR4k3SzhwUcmsr1ARpdtEuHE5otTODLVzyQWKIMd/b+gbSP2urj2UbuD5
         44lqgzcofE+vH/7OioWTzJ3ZfVIkCLB7J6oeEnBJz0JIzLtLNlpnWDOmRn3uqTww4sNo
         GZWebmKeRCV4oYnPSdQavq+c2XYkQoq2HJ0/+rGwxfkdRVY95zZd7Lb/vIeKnqX+rF4B
         a/YBqba9L8RgtkB7UtlvE0yCG3H/M7OR3Q1o32v6f6PqBK6whJ83IpjNYHtyNDV1huml
         QBdvokDAbwrhWjMic0/AwZp157Zbw1skcuxTyaSeu0mF75xFBZJInrlV42Y8BCKdOP0l
         JdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701867949; x=1702472749;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzgbFdAZtuGUcSvqWCnnqwHA8w3xAQKY5QSWn1ivO1Q=;
        b=Do/Q9GgIsl17iEffsjxTqAcxik3HwG6ETE3noIHuadAAR93xSwEZUueqxGfpt6wnDw
         Gt3iLKWNTgxfp/KNWH7QOqO1dKZ6nY4SMc7oaW3xeHHz738IgOWJMQ/HHSrbNDo6XKia
         QAqT7pOYeFn/068xs8GnaXGbiiKV6SmgPYwhhA0oRl09SK7fdUd9IJ19BaRs60YCFZUt
         ZSkmJZQm0fNeSyi40OVPmd5DE6fVdCBlFwuwRhYOJ1CZAjawbDK+Pceb2u9gRyN14J+p
         WH1izNNHaGJl/PENVW0ADdhbP7N5WenFNMEutrJ98feN2rifpBU9r3HQjeSrdJGkge6G
         i/nA==
X-Gm-Message-State: AOJu0YxjrLl0/2o7dyVB0GGINZOAURV8Y4jE6sEMoKegPJdxkaGt3jPW
        3HduVPeg0c4UvncjY7z14yhIgA==
X-Google-Smtp-Source: AGHT+IEhjyYkjdko17Yv1eA2AphNCktXFKRI2cyiBKG8GmugvSo4jvEZ3+HFE5q1wXyxbk+tyJpYhw==
X-Received: by 2002:a05:6870:9e82:b0:1fa:df52:beb4 with SMTP id pu2-20020a0568709e8200b001fadf52beb4mr1148224oab.32.1701867949085;
        Wed, 06 Dec 2023 05:05:49 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id gy26-20020a056870289a00b001fb3240116bsm2094303oab.7.2023.12.06.05.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:05:48 -0800 (PST)
Date:   Wed, 06 Dec 2023 05:05:48 -0800 (PST)
X-Google-Original-Date: Wed, 06 Dec 2023 05:05:46 PST (-0800)
Subject:     Re: [PATCH 2/2] membarrier: riscv: Provide core serializing command
In-Reply-To: <ZWe+ljzCUQQVu7oD@andrea>
CC:     mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     parri.andrea@gmail.com
Message-ID: <mhng-40f43849-e610-410b-92b5-7571838ce9f5@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 14:43:34 PST (-0800), parri.andrea@gmail.com wrote:
>> > So I should probably stick to 93917ad50972, which apparently selected
>> > CONFIG_MEMBARRIER on RISC-V, for the Fixes: tag in question.
>>
>> I think it goes further than that, because you can explicitly
>> CONFIG_MEMBARRIER=y, see init/Kconfig:
>>
>> config MEMBARRIER
>>         bool "Enable membarrier() system call" if EXPERT
>>         default y
>>         help
>>           Enable the membarrier() system call that allows issuing memory
>>           barriers across all running threads, which can be used to distribute
>>           the cost of user-space memory barriers asymmetrically by transforming
>>           pairs of memory barriers into pairs consisting of membarrier() and a
>>           compiler barrier.
>>
>>           If unsure, say Y.
>>
>> Before 1464d00b27b2, riscv just happened to set it to =n in the defconfig.
>>
>> I suspect the initial port of riscv merged after v4.14 was already broken.
>
> I see.  Oh well, guess I'll have to leave this up to the maintainers then
> (I believe I've never managed to build riscv that far), Palmer?

I see

$ git grep "config MEMBARRIER" fab957c11efe2f405e08b9f0d080524bc2631428
fab957c11efe2f405e08b9f0d080524bc2631428:init/Kconfig:config MEMBARRIER

so IMO this is just one of those forever bugs.  So I'd lean towards

    Fixes: fab957c11efe ("RISC-V: Atomic and Locking Code")

(or anything in that original patch set).  It's not that big of a 
backport, so I think it's safe enough?

>> > I'll look into adding the membarrier feature you mention (as a final/
>> > follow-up patch), unless you or someone else want to take care of it.
>>
>> I'll be happy to review it :)
>
> Sweet!  :-)
>
>   Andrea
