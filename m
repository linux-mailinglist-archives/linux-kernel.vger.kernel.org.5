Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4175BB86
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGUA0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjGUA01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:26:27 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2EE2D7C;
        Thu, 20 Jul 2023 17:26:08 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a3efee1d44so947777b6e.3;
        Thu, 20 Jul 2023 17:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689899149; x=1690503949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rClwftpBLgEaJEei7S23VjbBcs3P/FayHAf01oqa4Lw=;
        b=a8Ew3Gkq+PVvwkViqlUL24XJ9VHf2B099MkL1a/NXjpV69PoWt2T7lVecwoq1hpmPU
         xn0IZTtZsZ7G9tvanIipfJak/DcaeTrRdw+SZch9LnoPm7WnEY+fe5946PX5MgEXwhxe
         IPoMqQvA6OBtUIjYN/6SlI8C/napoiOs9sup1Dl7yKckFUVs9arQ9yFjZLzutLhBFf5P
         tjFH+dq2qeCW4MRgwHR4SbMMWECOCUWaJfC539Rfg7cxzJtQqnZ7VugQxDfUPhLrsJgS
         k9xVeyqGwsaCDuVpiVAsKEVU1nlJ4Ls8khRlUqZKLKEBMHvcGe1RYPX7PYTpYZ7XUaIP
         FJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689899149; x=1690503949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rClwftpBLgEaJEei7S23VjbBcs3P/FayHAf01oqa4Lw=;
        b=CwPMbrRnF2Z/J026GjVEj+lkijMWX/v1d/BXDnJ3gYKX066H4ddjxxk1+yXgL/+Qw8
         +y/Gc/3rEuPft7B9yagwP1S3/oMYZpSQt3dcpoDvqafYGP8CR3h+L64f+ju2vLGmAEmn
         0R9epuGD+x4L3MujPnYFu0uNWhEGYgSc+RYL+ukX2D+yVbQoMz0J6YKof5ibXOR3P97g
         5uurwZ33fQYmYRPJ1pFmj+jfehnjcZaJ4cn/SjodkIZIPXCj32zBTgIvjFwDLqIB52Sh
         rHN2ivPi3MIaevmiowHwlCTqiS08EvAwNtvUpkHaZKTCRtT8eq6nXuSevBF4Zk4y9Ej0
         /nhw==
X-Gm-Message-State: ABy/qLYXQB08Qi+/Opxm06x392t44VS7zMlJ63BA6JGULuOMjJD6uHlV
        sEVWijpzKSShvr0ajzNspg0=
X-Google-Smtp-Source: APBJJlEvgHwzJ39qoLfLU0H/0XPjwAt50e7oNlf7pKDiCBpHEO9EAnhnpafQ+zBIAJaCMnZjw4LWvw==
X-Received: by 2002:a05:6808:698:b0:3a4:3072:e597 with SMTP id k24-20020a056808069800b003a43072e597mr393611oig.54.1689899149515;
        Thu, 20 Jul 2023 17:25:49 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t25-20020a056808159900b0039ee1de4e6esm928210oiw.38.2023.07.20.17.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 17:25:49 -0700 (PDT)
Message-ID: <77019afe-663a-341d-d25a-efe626ffd353@gmail.com>
Date:   Thu, 20 Jul 2023 21:24:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] rust: init: update expanded macro explanation
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
 <20230719141918.543938-13-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230719141918.543938-13-benno.lossin@proton.me>
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

On 7/19/23 11:21, Benno Lossin wrote:
> The previous patches changed the internals of the macros resulting in
> the example expanded code being outdated. This patch updates the example
> and only changes documentation.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
