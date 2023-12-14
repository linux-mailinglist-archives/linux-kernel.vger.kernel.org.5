Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AA58125CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443084AbjLNDN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443090AbjLNDNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:13:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29038109;
        Wed, 13 Dec 2023 19:14:02 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d098b87eeeso69113535ad.0;
        Wed, 13 Dec 2023 19:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702523641; x=1703128441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6Gh9YX7DZUKT9k3pgoHzM/D5vHJqCG1MyJlh3Mml2I=;
        b=I7gLG+vGl5KPxK1bCR4DQWKSfqZOEyRAdENw3sZpDj9WbUFjHCiJuecgI+FabIoFbp
         QJrij+OJjo0cm8bviOtGgS5kY6TXIgCZr/mbQEZ/QM+CT8MlmK+uPBsZlDcYzByatjAX
         wuIvj1zBhyx7ctDBgYg6L95xKuN+vdl8/wG+5DkYAUlRIBXemCxWXg7HAjDrg6fXrKFn
         p8H+65BKC8OrjuaiPKG8yQ4dA2aM7/VS0ui7viXZ7ayIS8ZtyuDCHG8DvDMEU+Kfaxq6
         /O5k81TVtuxLKCSUDYBMJd2TD5Rqixabn3wteEZlaFNQcARilZyGqYUlNzCzaWcNtqs3
         s2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702523641; x=1703128441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6Gh9YX7DZUKT9k3pgoHzM/D5vHJqCG1MyJlh3Mml2I=;
        b=lveOvWf/hMt9wUNzQ9lPx7odTl9+3OOhOaQRNXz1siEstfsomaRYPG9Qnm7A4L3NE+
         EL0wCMY6ptzbGvPia1jm+cPeBHHSDpBlP3jCTodery/Lw2hMupzasKiIqMyq79m+HVEb
         tlgmHHxLDz2CZtwV3As8FyWXv4FboauouriROsw4BMD+upq7YTIwUQwOgkavRiv4ZrvZ
         qib0B/QFJz2lY5P/HxTkmgzZPHztz4HV48Iw/nHtPFUtPHv2EArL53l6hQISVbnNwMO4
         +VkiXBcLk3/i7lc6j63XNFxgEvHHZ+oVkdhdP5LMx6wgWdvmvOjTsqlA4LEJU5zGbc7H
         BbtQ==
X-Gm-Message-State: AOJu0YzF9K99EOCqXgDWM6EjihDugiYdpR3R7g62YDoFQ3JFlYKX3tnZ
        ikFHPrvmn79JyjRzlTQD8xc=
X-Google-Smtp-Source: AGHT+IEjnq+E/UH8vGe5iggdqxhM2myFCKO3gTBcOYGYcdv3fG3i0HE1cWXaTj7JkwedKlbj3YTUOA==
X-Received: by 2002:a17:902:f546:b0:1d3:6238:a528 with SMTP id h6-20020a170902f54600b001d36238a528mr1274410plf.23.1702523641586;
        Wed, 13 Dec 2023 19:14:01 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e80e00b001d0c37a9ccfsm11199832plg.303.2023.12.13.19.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 19:14:01 -0800 (PST)
Message-ID: <05fa58f3-f351-4119-9c07-1f5bb04503d2@gmail.com>
Date:   Thu, 14 Dec 2023 00:13:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] rust: workqueue: add `#[pin_data]` to `Work`
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>, Tejun Heo <tj@kernel.org>
Cc:     Wedson Almeida Filho <walmeida@microsoft.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213220447.3613500-1-benno.lossin@proton.me>
 <20231213220447.3613500-3-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231213220447.3613500-3-benno.lossin@proton.me>
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

On 12/13/23 19:09, Benno Lossin wrote:
> The previous two patches made it possible to add `#[pin_data]` on
> structs with default generic parameter values.
> This patch makes `Work` use `#[pin_data]` and removes an invocation of
> `pin_init_from_closure`. This function is intended as a low level manual
> escape hatch, so it is better to rely on the safe `pin_init!` macro.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]
