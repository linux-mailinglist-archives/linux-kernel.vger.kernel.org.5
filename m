Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0351F75BB83
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjGUA0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjGUA0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:26:20 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF4E2737;
        Thu, 20 Jul 2023 17:25:56 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b91ad1f9c1so1148338a34.3;
        Thu, 20 Jul 2023 17:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689899136; x=1690503936;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2niGN2PVKhWwi61t1ZZ9duJRgHrZrzr7FjKHjUs2s8c=;
        b=eJUvD8Z3gTaM6Zf8R4TxfjLAlZm+rlqxHFYWwbuYdsHqsS+LDEFpT8Js1nbv43e10b
         toO7+t/2W/bYWwZX93qTCYigpYVGCXPZFhS+jOsbGcPUYLd9Fy940eUhmPEbZWmmVgq7
         uk3w4SDJD1TR2je1aTQ4GnohaFvJ3881ZSqkcbelIxPTGza1ysjVho80YgUcAJvzYS9T
         HIhzA/LMWYgJI6vmHNcc20NtX0DfeAMa4lB5iCk/gTGY1+dayVxZlviOGnc2OS3q/k3G
         cqMQwEx2jXNNdWBwlettqd6CNT3v/8RQVh7mU6b+P4ecwg3z0yHGlyATg5e5zhkwBPbK
         WH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689899136; x=1690503936;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2niGN2PVKhWwi61t1ZZ9duJRgHrZrzr7FjKHjUs2s8c=;
        b=VJc99oZv9043WJf4UyNygi3POnN9fWzCggf8822VWDFH3fdAX2BjSaIOGLWsGkHRce
         jUJM2bYIA2m7zA7bom7RgL1FlHt2K5w0/jsen1jJj3g9LYVzm7MlaQTHQ5z7IgArxSp+
         CHnZp7nYsdTwWJRlpxOmz5cCGkCQbSHOP+JXh5OISWV/vAPuP2MD4ylYmLrLaQ3YvWeq
         aqzjg71KWmqljCrHXx0ZGRDQVNQ6zuvW8piK7A9VD8Ak977rK7+QM8N7eynTvEe9kgII
         NkFp4VVKBKGevaRkd5DJU9WVYpihq/wa57HiFt3q7xEqHc/ET6BTyCy7Gym8CTcsMOfV
         0r9g==
X-Gm-Message-State: ABy/qLZA4kYUTAqTNj005KNotNbdzCk2g6ijRowPJKHVECi15r8de27c
        95/gg6r3bMLRl4hV6Jk81qo=
X-Google-Smtp-Source: APBJJlHvhpjIGQKiH/pGBPGLqt+Y+4pWTHqjcpzhQSpoZKAS6DNFNcjNa6afZ5G5TnWuY6BwDbYIhA==
X-Received: by 2002:a05:6808:1996:b0:3a3:ac49:77dc with SMTP id bj22-20020a056808199600b003a3ac4977dcmr598304oib.1.1689899136241;
        Thu, 20 Jul 2023 17:25:36 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t25-20020a056808159900b0039ee1de4e6esm928210oiw.38.2023.07.20.17.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 17:25:35 -0700 (PDT)
Message-ID: <6c0800fa-d1b0-011b-026a-66000777888e@gmail.com>
Date:   Thu, 20 Jul 2023 11:03:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] rust: init: implement Zeroable for Opaque<T>
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
 <20230719141918.543938-10-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230719141918.543938-10-benno.lossin@proton.me>
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

On 7/19/23 11:21, Benno Lossin wrote:
> Since `Opaque<T>` contains a `MaybeUninit<T>`, all bytes zero is a valid
> bit pattern for that type.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
