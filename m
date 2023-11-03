Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A157E0C13
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjKCXRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjKCXRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:17:09 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18302A2;
        Fri,  3 Nov 2023 16:17:07 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5ae143e08b1so30762957b3.1;
        Fri, 03 Nov 2023 16:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699053426; x=1699658226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKvHzkRZX2X3VBhvRihWnoFQA9z7HSth6wpISZ7pu5s=;
        b=darrTK5MY4acESxV4+6tQa3blgCd5Fkag07eCZ+yAD/CSC2AUly1UPmZ/+CAYmE+Bv
         4AWAI+p5A3l117ULzLSDxCciSF/CY86rUMg6fl/B40X9seS5W9nK884de/wjvwoxWHLB
         0GZCtiloXhSw0X0YhJAHGwLXjY8zj1O2N33JJCMXoFz53HZ8AYEdiWdXts2zYu7ISk4f
         M1GAlKDRP8wh6XDB8qOBcPdT64oPV0Sj2b1uxXv2MR0/DhgbNLBnfkVi8dJcz/QQ0qu+
         ZocvFR758q8lFFyfGiRxhyYlzUjeLuNGVSk1cez7VC4om6ZfGJ31IxqBExbw5+NWFFqu
         nozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053426; x=1699658226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKvHzkRZX2X3VBhvRihWnoFQA9z7HSth6wpISZ7pu5s=;
        b=BupG0ccKUmHHa9GUXTjNuF3IK8KNj6VKk7Cpf3inZrknTOXYfOloQnRtlDOqiBpP8s
         ejLgXlwiGSd1A+cXike/5dmkcTSm1AxCEm8B+Qqg4ObR+vrEvgljIrwkrYcUbimoPfgK
         WP88vSTWTOoeIGEVIOVF1JjDDg4xAMjv2uc2qbnOH3GdqYaLO27AKkf6VCFRGBhk4wak
         yPn4dH8XVxCmonmawsCf/yrEkyYysjo02502sPX2cbPgjItKly8lQhRbL8bJPaXvWRus
         3KCPrr7WWw9mDz7eLoQoxpSyqRAP9VgR2j68ojuElNjdD8Lzp2ZJ/HsBemGSx++gCfrr
         gEjA==
X-Gm-Message-State: AOJu0Yw3EpEj6S/srdg2LU+btJjeZqRe++e/no36L3RxDHrtLGWMi7XV
        zoTjC/fPsOHh0PWXvNnC7BI=
X-Google-Smtp-Source: AGHT+IGia3NWALECsqt8+/eQ2wXEvO24FtckYIBNGVTIquCDYr6/VdVZwvZAPt4F7ZkJk6ny7c4ZrQ==
X-Received: by 2002:a0d:d8d7:0:b0:59f:9c08:8f12 with SMTP id a206-20020a0dd8d7000000b0059f9c088f12mr4817824ywe.38.1699053426252;
        Fri, 03 Nov 2023 16:17:06 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id w82-20020a0dd455000000b0059c8387f673sm1511192ywd.51.2023.11.03.16.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 16:17:05 -0700 (PDT)
Message-ID: <1750d6ba-b874-4fca-bb29-b98f94fe94c0@gmail.com>
Date:   Fri, 3 Nov 2023 20:17:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: Ignore preserve-most functions
Content-Language: en-US
To:     Matthew Maurer <mmaurer@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>, Tom Rix <trix@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20231031201945.1412345-1-mmaurer@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231031201945.1412345-1-mmaurer@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 17:19, Matthew Maurer wrote:
> Neither bindgen nor Rust know about the preserve-most calling
> convention, and Clang describes it as unstable. Since we aren't using
> functions with this calling convention from Rust, blocklist them.
> 
> These functions are only added to the build when list hardening is
> enabled, which is likely why others didn't notice this yet.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
