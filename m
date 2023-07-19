Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5920E75BB7A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGUAZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUAZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:25:01 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD33F270D;
        Thu, 20 Jul 2023 17:25:00 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a36b52b4a4so896903b6e.1;
        Thu, 20 Jul 2023 17:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689899100; x=1690503900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aGnwCQHIk14nq04vsYycTNcRKlcwdnAMCYE+vJJxd8=;
        b=gua5P85x7N8S9ZuzM9iGv8p0L5I3/NhFhu5rIC57RTd2OaA7Ligtz8ochAqwtiqMR5
         5SDwMiYItyx+rpF1wAAw1LXxc+FFA9TKsF7wxqgEa27gkZ4S2d/f5q452vFjrpiel5ln
         /ubzrw6JRbek925oi+GOG/IIVAOtbqN2t8mlqwcM9q72lPMzvac9l6eQPelK4j5POaFl
         n5vWBUewRBrcqJutcxBWwXufq7KI2uhPU8L5AWawfEbd6w6kiyyu5ynUD70q/SYwb/hu
         fFRedKF5XeMGq8ZJPcq8qhG3rsMw0gdQQG7iQ6S/9NibiFU95fnSX41fSdBNL31EZhBU
         A5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689899100; x=1690503900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aGnwCQHIk14nq04vsYycTNcRKlcwdnAMCYE+vJJxd8=;
        b=SyP7MAVgmdtc0W5OsV+PelxQmGrinkhuOxFSPRs8XMcAyQHgf6LZrNBB4tQZN8o3TC
         LDZx7j70XAFmNEP7VKo5By6LgcPGqXrtCEJgu071nr9kFVfsGM1m/zEU2IjtUvxCXQ6t
         KYGIPmXzlLlw0MGlV3kFSccG4PBg8vlZK+hxjp8OtIQo/AOFFOMdKLg5O6p6YwAN2tnV
         UawCDAqFs6ot6SQP0G0t5SPjkstixl6JScQ/phY4oY/CgENH3VQjo0CpS+XJHG5ocNS+
         YsDq5hlXONUxjKMWCr8070IL3omydSE4dLYCxrnwM5esnDVrBSmJgdI99y07qkxcLx4D
         nxRw==
X-Gm-Message-State: ABy/qLZE0PoZ2csYofcw7QdJbl+kJpoxAwQ+ec1JtycUdUijp6ZaLyoO
        0XyQm3gYSlz432Cc5SQHD1w=
X-Google-Smtp-Source: APBJJlEh9c/kQzxPjHbVrfQNHrqIxhlrxv3iPueOhYyz/CIbuUHkL6qmzkTMXEscczBc5Lw+NF7SMg==
X-Received: by 2002:a05:6808:4d2:b0:3a4:1531:70b4 with SMTP id a18-20020a05680804d200b003a4153170b4mr303821oie.15.1689899100081;
        Thu, 20 Jul 2023 17:25:00 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t25-20020a056808159900b0039ee1de4e6esm928210oiw.38.2023.07.20.17.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 17:24:59 -0700 (PDT)
Message-ID: <f9b06056-ea24-c19b-def7-c84c3c089732@gmail.com>
Date:   Wed, 19 Jul 2023 15:37:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] rust: init: consolidate init macros
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230719141918.543938-1-benno.lossin@proton.me>
 <20230719141918.543938-2-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230719141918.543938-2-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 11:20, Benno Lossin wrote:
> Merges the implementations of `try_init!` and `try_pin_init!`. These two
> macros are very similar, but use different traits. The new macro
> `__init_internal!` that is now the implementation for both takes these
> traits as parameters.
> 
> This change does not affect any users, as no public API has been
> changed, but it should simplify maintaining the init macros.
> 
> Reviewed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
