Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5897F76F8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjKXOyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjKXOyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:54:05 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A5E1FE6;
        Fri, 24 Nov 2023 06:54:06 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c210e34088so1383694a12.2;
        Fri, 24 Nov 2023 06:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700837646; x=1701442446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQniq8g4txVtcq94cNq02mIrdFtNUmCEDb9X0KzX3NI=;
        b=cOmqH9knsNqWHE4yy2Zm9wzazK5A+/nZl4HBDIqNb9h7wm4FKI2SXg5+Xg8j9MoPs0
         hzQqF4Gp2JGmTNN56iTa8LBHXg/QtIGMr1Rsc2zy8FcWo8JEtH1MXMJ4DxT9MY6fTSH2
         E+f9XKlE6kkexT5ujcu+X+9zEpymlBjtxKgiGdAddEP2XEgSNiZzSTc08wT3rNUiRwIz
         R4uUr1pnDCx0hRlgky8ev1BdE/HJ/3dj5D9GACIxwUXmPTV9o9BQKvr6JtKSo5rPQpp9
         GA6F8N94pkD1KJfZyydlvzN1H5169tHmGNTL+6yuwnMJdyMLwx8f4TYyXompClZvYcao
         MIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700837646; x=1701442446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQniq8g4txVtcq94cNq02mIrdFtNUmCEDb9X0KzX3NI=;
        b=rR2iskMsnrm1FOZ2iQ6s6ko0vpe+y93dLd5ApIBTh0eXsoIGYxNbvWYQvx9BfiaNAJ
         DMouDid9sLBBQgnmZ9O5TE1rHZUH3ATMQxs+++P33Hu0d60G7ivlESdT0qLX6qzwy4IL
         xmqzr5HCK//v9y5FgGozLNEua4uiKSHaWXQRgK679IS3sOoy6yJ+TbPfC9p8+lhq9H9d
         lwUvVZnkS++oGK69ztX0YV4NXfZmvz1OlYm7OXRD4pHY5n3B4HFR/mWjMeAl4R90bWL1
         CR8XlIDIwz+rzoKjE02VxwQ+y4YpO0k+xAnQDzLgFcTjZ34g3KEXB49hY1EzHXRJNf5O
         R65A==
X-Gm-Message-State: AOJu0YxfdQX3kEQnm9iEO1/4VZOF2I1Uf0G5mWdpcoE5+zgWzVMzNfeb
        ejmlbQ3TVUW27O044bBiH9FEtqBkY2g=
X-Google-Smtp-Source: AGHT+IEL5aoWPX8uUFD9Qs0LEckYZzhRHb4VXjbKQQX9Ny4aAZ9Go0HDlyCttaFier/su7hu39R7Zw==
X-Received: by 2002:a17:90b:1c0c:b0:280:c0:9d3f with SMTP id oc12-20020a17090b1c0c00b0028000c09d3fmr3504391pjb.34.1700837645983;
        Fri, 24 Nov 2023 06:54:05 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id 102-20020a17090a09ef00b002800e0b4852sm3703646pjo.22.2023.11.24.06.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 06:54:05 -0800 (PST)
Message-ID: <0b224ebc-fcb0-4825-9222-5f0efc61c62a@gmail.com>
Date:   Fri, 24 Nov 2023 11:54:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: replace <linux/module.h> with <linux/export.h> in
 rust/exports.c
To:     Masahiro Yamada <masahiroy@kernel.org>,
        rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Benno Lossin <benno.lossin@proton.me>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
References: <20231124142617.713096-1-masahiroy@kernel.org>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231124142617.713096-1-masahiroy@kernel.org>
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

On 11/24/23 11:26, Masahiro Yamada wrote:
> <linux/export.h> is the right header to include for using
> EXPORT_SYMBOL_GPL. <linux/module.h> includes much more bloat.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> [...]
>   
> -#include <linux/module.h>
> +#include <linux/export.h>
>   
> [...]

I'll use this in my crates patch. Regardless, LGTM.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
