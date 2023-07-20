Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ED275BB7F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjGUA0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGUA0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:26:03 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034E430DD;
        Thu, 20 Jul 2023 17:25:36 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a36b52b4a4so897051b6e.1;
        Thu, 20 Jul 2023 17:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689899123; x=1690503923;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8jG6YBwKZpxvBs0TQSOPbtCfD3mZr3larkWDWz4jro0=;
        b=DluRJ6ou/WAdyseSUHSQjpcalIDEjVQ4B3ESl8lt8sIeL+GNv498WOCRMNSEM7Kl9e
         KjL1QgF/bB+zTrGW5aAv9II2hmmjPyCLpjYq+pkhORNxLqBc8mi7s5RnI7ez3whkx9wG
         zvN2sN+WkmJVf/Z1zbe0EI0Gi3Lft/itNA8XC0g9Ey2Kem4dxE/AfxGUaQz3kwOFjMqP
         aGSlOzXPadmALLiVkpmsxarQSjUlkneOoWcdYLGoVJKJA68AWJDTJoWbyKnbljSLqpRv
         2D3vwqUDY6lryQbV734FucMuFqjXplgWeC9C2kTSa/lQvAgwPMOobrnFH7ByuDOzg+Ux
         S6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689899123; x=1690503923;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jG6YBwKZpxvBs0TQSOPbtCfD3mZr3larkWDWz4jro0=;
        b=H89UzMtjfOKAmDn0tfyJiXh/sDQIzsdbmp+PU4KG8ZXrruzZ1TrExZUKYPryZEJT8C
         ICW4lzBY+q6qM/a7MGH70jltvZ8QoyOBPVgh6Y1BX5nhDd35MxCm2XXWOryWyV002AtL
         ad/p1vw8C98Mdx14gfpLI4KnDpqtVAyRgIHnBw3JEUIPP6ZQ2cZUV0639JszPdYc8ViQ
         hTz8UUXlGXzBwL+z28u7kHzcjNJXbcjSYL/rYRUJhW9rmfjlVQzKzMo6Kw5wXLrECqvx
         updtOw8qVrKYmoXqX5SmWJP22CYUA790NRKOYNaNW2GyErU9wNSyjrBu19B+RapcMd3x
         846A==
X-Gm-Message-State: ABy/qLY1DQShv84B8NcPyII0JZOKjZXXo5TQYwkM4pzrhjVGXWL94/5/
        iFVnmFHvQksiCLV/jz1W8IY=
X-Google-Smtp-Source: APBJJlEZvcaw3P5YrXGPaBV8I6ji5Qt1wDpcr1n9Ft1Iw4cpPwOLygwCFcyj8n4RzcuIcjsP/xkYZA==
X-Received: by 2002:a05:6808:5d6:b0:3a4:1189:f2a1 with SMTP id d22-20020a05680805d600b003a41189f2a1mr722918oij.25.1689899123008;
        Thu, 20 Jul 2023 17:25:23 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t25-20020a056808159900b0039ee1de4e6esm928210oiw.38.2023.07.20.17.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 17:25:22 -0700 (PDT)
Message-ID: <0add5c9e-503d-e121-fc68-4a0d8f0b81a4@gmail.com>
Date:   Thu, 20 Jul 2023 10:51:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] rust: init: add `..Zeroable::zeroed()` syntax
 for zeroing all missing fields
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Asahi Lina <lina@asahilina.net>
References: <20230719141918.543938-1-benno.lossin@proton.me>
 <20230719141918.543938-7-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230719141918.543938-7-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 11:20, Benno Lossin wrote:
> Add the struct update syntax to the init macros, but only for
> `..Zeroable::zeroed()`. Adding this at the end of the struct initializer
> allows one to omit fields from the initializer, these fields will be
> initialized with 0x00 set to every byte. Only types that implement the
> `Zeroable` trait can utilize this.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
