Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856C37B2721
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjI1VHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjI1VHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:07:45 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B93A19E;
        Thu, 28 Sep 2023 14:07:44 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bf04263dc8so7666554a34.3;
        Thu, 28 Sep 2023 14:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695935263; x=1696540063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/2XE1ERbc/dACG6Uv6uTgRZE37rXS3zS8VijvpisxI=;
        b=NSEN3xEv0aZVNws9+FSkJxugjyPrv7PMWlG6byvOSjt1+oIc5yf/EagHPFmn8dJXH5
         lJm7XytZSi1nfKdMPCZXP3Bjl5vNTsSBJjavm2sTgfe0C+TFIynmYNbZFtEvoA4R0dpM
         hnFLF8xaAxET98tV1XjUbcsJGmCXDdcEtL3d1ihMgvC9yjfMG9keYnkDNVwqgze3iz+1
         3093zsmKJ5x7h3F4gUFgsW/IKyyeCK7J3plCcLyY2H9KCZV6XssgbUqZCiDrmVdPEIYi
         nt19wbl1hslAzxxCcBRZGSG9+Xm7MWQLC85TnGOLavVLIlzPmH1VAb1XSexoWFQiBx//
         aJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935263; x=1696540063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/2XE1ERbc/dACG6Uv6uTgRZE37rXS3zS8VijvpisxI=;
        b=qnIgu+wFj6qQy6Aezb+lsW7gPkRnfW/jPy3CHO3iC3o/3Ybq2ehsp3SSIQjxTY9d76
         o+rAJy/cZIrHWKQSp65J+oRvO92XUqx+We0Cz6NkIGQtJXYpPlMuTE6pHuxWZuPHAgHW
         cVu+AzuuUOORIIDx+5js5PS3GVnmOu57MkmbYlbG0h0rYzWRq/R7JVdzg7GPVI3nG9wy
         P4RQ0Ljpq8X+h6ialBvlArcRciwjhlqE94ZRIIypKMrO6OkQbl5Bab/deeqK0lHhFhhY
         HowVuoksMC+KNDoRSEtsg7ARtJJby/U+DxwuPHWySxm6Y20rhsynzJLkY2vOwbd3MYkM
         EzXQ==
X-Gm-Message-State: AOJu0YxLbF4qL/uD2klUFQnE3DVQMrRy8JdYjJ0fCXd1v+RagV27sngD
        rJWQFBqCOyiq4BIwVRzYamgZhDp4tRE=
X-Google-Smtp-Source: AGHT+IGzCMAS+68g9gFQkLHI2lQC4uFip8tjHzHlm3qCxM9DjpTb/fMJP/vM2fPYYBYlxckQCzZLIQ==
X-Received: by 2002:a9d:74d9:0:b0:6c4:fab9:1ad6 with SMTP id a25-20020a9d74d9000000b006c4fab91ad6mr2503261otl.28.1695935263421;
        Thu, 28 Sep 2023 14:07:43 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7820c000000b0068fda1db80bsm13766692pfi.75.2023.09.28.14.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 14:07:42 -0700 (PDT)
Message-ID: <0c2f2805-cb8f-4f03-b569-669197e481a9@gmail.com>
Date:   Thu, 28 Sep 2023 18:06:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: Use awk instead of recent xargs
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
References: <20230928205045.2375899-1-mmaurer@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230928205045.2375899-1-mmaurer@google.com>
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

On 9/28/23 17:49, Matthew Maurer wrote:
> `awk` is already required by the kernel build, and the `xargs` feature
> used in current Rust detection is not present in all `xargs` (notably,
> toybox based xargs, used in the Android kernel build).
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
