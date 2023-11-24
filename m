Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3C47F71F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbjKXKql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345375AbjKXKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:46:38 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375BC84
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:46:45 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32f9baca5bcso402974f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700822803; x=1701427603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44pJYG7VrtXx5lOTjT3hEDyjUe6m6/HlDjLNzhiVO6M=;
        b=R7Uwm5xnTaRRP6dmtMK6PFurEFbGb2bxslC7w4+TRZ5rTowsNJkhkcaLJwHTKnA9zc
         j7EpSAA540Af1ouR4/BLTpC3tlTg57wF6KG2VY3Enz4PuplGNBQWScq/54iowVkusszK
         rupk+W4BJN4qT5uAVYmHpxvIZI3Fh/8I1co/9ZiTrLTYEdFXWzkX2i0zbH49BXNcVBvE
         AUvzeEXVqZ9kSEDSlgad6gRt5EyzQZEqaLttmv75KhGxpTABKUKjrvIoOb3Ur7pcfd1W
         pHJ0n7Xx6IGmEhQuk9OWCOLj4egE0bLa8RrQakjfbsTJEUxFyaTms/sbGUq26HNp60ew
         ykyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700822803; x=1701427603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44pJYG7VrtXx5lOTjT3hEDyjUe6m6/HlDjLNzhiVO6M=;
        b=FbF7SDHjngVh1TySp3HXa4DhxWoJFSRGrCjAsHp3ccI2jYlZhPUfmsxWzWLHLkUKzK
         i1sCgptSKCnmNhjLMM6fPyjj6/skd5sI2FLhommNJrKHXNIUk7vRih+GDAWkcAyOBBiM
         ko2QL+67nUgpe3m2qhAegaMQ30Uq2h/lEm4NvuX6wup49i7irE871D7KgzpiwpIbm+Qb
         r2/EWQjt58BNPDZGkmPPLj7U4Zm4LoiR6iTs+3I71WC6FquFpLQNyq7pcggx1xuQ/WN7
         YsShatXfZURXdqMTrjscVOpTdJo14BU49qoYsf4AVkkjV06V7eoWmbq6pNQROyNJJqp1
         wnxA==
X-Gm-Message-State: AOJu0YwuuglRwYGfYm5ug3BO/s2KMj7IJZ3YZSeUfVBJWG1e0EOmVxb5
        vwTTd2RrXSt2Ez6T4hBal6RG5R24PUygG/jb2c0=
X-Google-Smtp-Source: AGHT+IHoZucoU3rr3MCXHd26VKz8Du9qGoZZpci75PKfi9pjdstzMQQZg2fA6S9qpau453e3PuUKjA==
X-Received: by 2002:a7b:cc87:0:b0:404:72f9:d59a with SMTP id p7-20020a7bcc87000000b0040472f9d59amr1832150wma.0.1700822803693;
        Fri, 24 Nov 2023 02:46:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:3471:930b:671b:cf77? ([2a01:e0a:999:a3a0:3471:930b:671b:cf77])
        by smtp.gmail.com with ESMTPSA id y16-20020a5d4ad0000000b0032d9f32b96csm3975301wrs.62.2023.11.24.02.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 02:46:43 -0800 (PST)
Message-ID: <de9c1287-9be0-40bf-8dbd-717c56ea0d7e@rivosinc.com>
Date:   Fri, 24 Nov 2023 11:46:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: fix __user annotation in traps_misaligned.c
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
References: <20231123141617.259591-1-ben.dooks@codethink.co.uk>
 <ZWA9HwUNHDFIw0wP@infradead.org>
 <7232f08e-dfe3-43d6-a4f7-abf8360bbfc1@rivosinc.com>
 <ZWB+rPU4nm+Zxd7d@infradead.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <ZWB+rPU4nm+Zxd7d@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/11/2023 11:45, Christoph Hellwig wrote:
> On Fri, Nov 24, 2023 at 11:28:08AM +0100, Clément Léger wrote:
>> I sent a similar patch two days ago with the same modification. I'm not
>> sure to get it. Why is it better to pass the "unsigned long" type from
>> the caller ? I mean, the resulting code would look like this right ?
> 
> Because you're legimitizing casting between address_space, which is a
> horrible idea.  By casting either from the unsigned long you make it
> very clear that deep magic is coming in and you make an informed
> decisions based on the user_mode() predicate.  Witht a blind cast
> to add/remove a __user you don't.

Makes sense indeed, thanks !

Clément

> 
> I'm actually surprised sparse even allows __user casts without __force.
