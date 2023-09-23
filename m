Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCEC7AC19C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjIWMB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjIWMB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:01:26 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F98199;
        Sat, 23 Sep 2023 05:01:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c43b4b02c1so27448885ad.3;
        Sat, 23 Sep 2023 05:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695470480; x=1696075280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJWHJJeLFmU6KDncYm3wKtsS+KVAxGKhS7/lOBgShv4=;
        b=i8Qz1bVJZ+I7xuKSetG8za08TB4zxMxGb0yWdbVKwLvCh9YRpxb6zzrfcNl9ku7hc5
         NL8fEtdy2d9OnzZhxhMNhC/4bC3M2kuCzc5ggC3sTqmdzi2sqsjUtyM29jXg64/Ntudg
         dLy3a6LGCDrKkTM7nzG+AHpFLAn73xtSLHA5PkBwde7/b9La9VlfeIlKS63zwgzA2OEy
         Qezno5fnYZXG+YvdysCu5ek/VE0BtliSgBP44ZDl59scEFSPB06yNeXS+dTpA4dH1BJc
         GlFmkDpT/WBpmJdlgdi4oIJDq5/vxlU0kSzpFZOWKIK8fVFwupHvvvNU7OnQKlyY3Yf7
         EOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695470480; x=1696075280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJWHJJeLFmU6KDncYm3wKtsS+KVAxGKhS7/lOBgShv4=;
        b=b11/pL08COpjnWWE8I1vGoCd9WkBVZU2PKIuCnbNLKfJv/d63yEcdxzQocmHdBQmzk
         iKDcJzbjWYhHJ497dxET/iiabbc1AzXlFyN0jnPk7jVe2s9PbjbY3184gFzKqhC0X3lz
         Zsp0DqoMucLJRlEbv62Wq8GDFGe8fXw547X0sKXhrt+/byu/kVs/GDXVYFy4a9OJVgIG
         n7e5rLOhZ2ClnDfvoSB3NpT3s1p9KGZRuMthwtBv609xt0uyibZUrkXG9eCe6GtKmjtZ
         EwHckTYRAaxTDgKiKFp6ZA6NwxWP6wu4cC8UIQ29mWM8d64Vu3p/Znj7zgyDjneKmade
         ++7w==
X-Gm-Message-State: AOJu0YxuM3+ZnUPhnyKrjjXelVmzNe9rctRlLHAVRUwgbDKArZMC8Je3
        kfgevsunmJtHnQi/sHtS1nw=
X-Google-Smtp-Source: AGHT+IG4jyw87UMOFg4woBJBSopS7D4Xf3N48wJmixTGXy858/8LwVZ5fwfyAr30EHXBI1uWA29z0Q==
X-Received: by 2002:a17:902:e84d:b0:1c4:50fd:7cd1 with SMTP id t13-20020a170902e84d00b001c450fd7cd1mr1545907plg.11.1695470479727;
        Sat, 23 Sep 2023 05:01:19 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id y18-20020a1709029b9200b001b8a897cd26sm5154518plp.195.2023.09.23.05.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 05:01:19 -0700 (PDT)
Message-ID: <7690993b-f130-4e18-9c5e-ce955fe00b2a@gmail.com>
Date:   Sat, 23 Sep 2023 09:01:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: remove ignores for `clippy::new_ret_no_self`
Content-Language: en-US
To:     Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Ben Gooding <ben.gooding.dev@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230923024707.47610-1-gary@garyguo.net>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230923024707.47610-1-gary@garyguo.net>
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

On 9/22/23 23:46, Gary Guo wrote:
> The clippy false positive triggering `new_ret_no_self` lint when using
> `pin_init!` macro is fixed in 1.67, so remove all `#[allow]`s ignoring
> the lint.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
