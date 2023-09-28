Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B50A7B2720
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjI1VHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjI1VHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:07:42 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B165B19E;
        Thu, 28 Sep 2023 14:07:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-692ada71d79so9505397b3a.1;
        Thu, 28 Sep 2023 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695935259; x=1696540059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/JgCDvL4cTN//gomBsMCRt9yDQu7HdW6HJo7loOWOQ=;
        b=BqHBz5ywqCUgxRSi7fQ8u8BwzcpSSB4uKzRS5+6qGHhiyNq0zXCifzeZTGzBLkFduh
         wub7KGK1VrSHWZPTrvNHCE5YHeIgtruBaC6btUkAdoVGuSu3+XVbUcYqV6kM1EcKrZIk
         tsnyLCWNuHEqVPU5UIk6op3vS8PaOSabwT8H++w+T5comXFV+EbHhEH9rtz1f07J+gAu
         z/wgK3kExx5cM5+SYe3Op1JgqEh9CvwfD9zm3o/HW/tQzxieetJClNIg458Xvze3uy6X
         q+zA1kzqcm9DnERka3bo+pTsWBWS08c5tyPFbce/sIaqRwJkKjxfKJ8QajLvpwJYNLjP
         oi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935259; x=1696540059;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/JgCDvL4cTN//gomBsMCRt9yDQu7HdW6HJo7loOWOQ=;
        b=rc0A3ZK/JdTx3W7gm+nAtpnKmuZ+S4UKqNzirz/Dx1i/agBhTg3yjCsobIQUtBd5LQ
         If1k2RkgNq2ivbRaSsptJLuzhloopQxWlxGN6L+1JIS2G1x+wxb3zQBu3kG5o2KOVzrH
         YL9l/JCaIhY37PNYKNGHdfQKqpRniX4l5bUq+HEoByyRCuDvdMQ/P0+BOjFkJgleYVQi
         hZ8vHzlsP5U6SwqkDkAk4A/LHFvlDzzfN3qrXvxrv6xHM+2GNkwinMUErQshUG54aXWh
         TtCWDCu+H/t8qyhxiqc4G1Xx43GF6OG8Q8PdxoG43+xPjaSsyDL5RZNQ7lgaOpytz5CR
         A+7A==
X-Gm-Message-State: AOJu0Yx3cLKGRr+RN8taT1/HP7+qydp0L24tJ3jcLiDV4WBVLehLDg0r
        /Ou3J8OOCLig7HeRmnaUSXQ=
X-Google-Smtp-Source: AGHT+IFFs6U8W6jkUYBh4GlltimkUb3hwkKsyE+x1ztQgT1CKdt45v5Q1p8JkhHNxcMIy5aOhvgaXQ==
X-Received: by 2002:a05:6a20:104e:b0:159:1bd8:fc7a with SMTP id gt14-20020a056a20104e00b001591bd8fc7amr1810753pzc.40.1695935258707;
        Thu, 28 Sep 2023 14:07:38 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7820c000000b0068fda1db80bsm13766692pfi.75.2023.09.28.14.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 14:07:37 -0700 (PDT)
Message-ID: <3e719461-d53c-4c54-86d3-ecb2eac4e9bd@gmail.com>
Date:   Thu, 28 Sep 2023 18:04:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: Use grep -Ev rather than relying on GNU grep
Content-Language: en-US
To:     Matthew Maurer <mmaurer@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230928201421.2296518-1-mmaurer@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230928201421.2296518-1-mmaurer@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 17:14, Matthew Maurer wrote:
> While GNU grep supports '\|' when in basic regular expression mode, not
> all grep implementations do (notably toybox grep, used to build the
> Android kernel, does not). Switching to grep -Ev enables extended
> regular expresions which includes support for the '|' operator.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
