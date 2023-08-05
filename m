Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3027E7710D8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjHERQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjHERQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:16:24 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E52AE6E;
        Sat,  5 Aug 2023 10:16:23 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1bb69c0070dso2444256fac.1;
        Sat, 05 Aug 2023 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691255783; x=1691860583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I422yz5yBPOTp7eZr9CHXnL/nKuhVxTFiPC47TfCiKM=;
        b=XGQS1uP++zdbRxCh50uu+rcPzZa7/derqs6Xh5uET7b9h0tTsE0qDtjI0jA0dU+xRE
         szL3FxPS6yNMBckOTza1httWYnHMAo3vIPiCeTQK7IzojELto8lHapE3mq1bkEmPPWjy
         RpiyvX/+STP6aGEdGpXvftAE0kS3Fjl7hoz6zABI2BR4Ys1WTLe8HZs1wcAcFKzbuKmm
         gmlZj9Sdu+cbD6VaMZZPAjEnYB9E1g01EkiclD6I0hrPB5rMmEMMFzJO8gMxGKiMnBnG
         ALsgUNITXFGMf+RpOPSrVlmUhtStR8h/kHd2brWo1ul6pdcu5MC8k1ndhia9duJ+43Iz
         uu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691255783; x=1691860583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I422yz5yBPOTp7eZr9CHXnL/nKuhVxTFiPC47TfCiKM=;
        b=XnYyAjELo4um4IFJJlq5LwJLLE1EoqJ4ITGkTltPQbq2n5vHQL0DstowHOC5zF/C5B
         PKlYuEE2RASgLZgUGVpdrr+s0NYi39g8ioci8JQN5zCfn2rqS8b0uIJGDnUM7DXtESlG
         0f9evXYxLQUTdUUd9A4lnERXvSdc7WYlaZLWMXGt0sQIBQjhqCZEOTZ3dvExyoLMtZSl
         +etUqXdITak379TcctYpQHbsRhDg+11CKS2XYWQW78GOLLcWX+WW9+BP8Pi5K3DM1w8F
         NI/qtWoJEhmclMftHSFAyfHzYbIoJ3tRwnfbP/2eTYJLUkcy2hOT0RvSwmdtqtrrXNah
         PF8g==
X-Gm-Message-State: AOJu0YwL8GKYVSP9BgDZDSoYRm2pLmLLQW6hsJkIZKnHrTPwIhoF0g8m
        sPW6PmJ1axDJbZTGrbJffDE=
X-Google-Smtp-Source: AGHT+IEIq6COB+dhHD4LqQY9xFZgErsNYyVKnQGzoeexEt7GvFdgjQmJiNiqIdAnZZStUxFyfs4rmA==
X-Received: by 2002:a05:6870:f583:b0:1b0:5218:cf07 with SMTP id eh3-20020a056870f58300b001b05218cf07mr6097838oab.5.1691255782928;
        Sat, 05 Aug 2023 10:16:22 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id r7-20020a056830134700b006af9d8af435sm2702963otq.50.2023.08.05.10.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 10:16:19 -0700 (PDT)
Message-ID: <8ea98456-5ba1-4cb9-8cca-e19142bfbba1@gmail.com>
Date:   Sat, 5 Aug 2023 14:04:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] rust: init: make `#[pin_data]` compatible with
 conditional compilation of fields
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
References: <20230729090838.225225-1-benno.lossin@proton.me>
 <20230729090838.225225-3-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230729090838.225225-3-benno.lossin@proton.me>
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

On 7/29/23 06:09, Benno Lossin wrote:
> This patch allows one to write
> ```
> #[pin_data]
> pub struct Foo {
>      #[cfg(CONFIG_BAR)]
>      a: Bar,
>      #[cfg(not(CONFIG_BAR))]
>      a: Baz,
> }
> ```
> Before, this would result in a compile error, because `#[pin_data]`
> would generate two functions named `a` for both fields unconditionally.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
