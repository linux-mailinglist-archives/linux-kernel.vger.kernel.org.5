Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FF5807403
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442513AbjLFPxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379433AbjLFPxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:53:34 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6CD112;
        Wed,  6 Dec 2023 07:53:39 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5c66bbb3d77so2477057a12.0;
        Wed, 06 Dec 2023 07:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701878019; x=1702482819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsNtGVpWWgWvu089WLkafuyfmubTvJRak1UCCx0p4cU=;
        b=U/JZd4RLEWJXf+DBgju6pp1KiHhSUtYSJEeg9ttF5gVwETlNRRuIZPz7BzPQYVfI4G
         JURercWyhxbcTpmB+WOExAYkEgjYh/zgteE0BEei+V6wKSYk6kqAes95FHzyItZBGXQ6
         53Qgke86RZjQvF/6uvY6NBKpa12E5VGhHb2qpMv4OCXaVa9xmiK9jMQEEs+V0iD59ETz
         0egOkTCusRJATP918Nq4tzObcEwsTFMRAUxN44Um3g1jZ6luwv6TXzgrrJT3Vdmq3kD5
         F0oomlHG2N32Yc+Amdx+pGM7RqNTZTQSmF3u4Pvghl/I0fEls45QHflR1nHB7jon+bxB
         ycmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701878019; x=1702482819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AsNtGVpWWgWvu089WLkafuyfmubTvJRak1UCCx0p4cU=;
        b=Sr02vduRaBgnf262bqVADsE0GZ7qptCqF/DFNutwfqcCW2Vd9hcn2iTnKeFj71o3Y7
         cICWzgIv7e+uWpXm3lbSn0fntp8k2Jcw+SK6LqYT8hpBxNKqirNDP2q0IJFfTJeYQOdW
         FvVR97WJZgbUTSOUdYijbBJ3ZMwC3NfBxOww0AV6bbNj4c1QlnALSCRqgnp1DB+sd6H7
         +8uSfCGxJLj3Vxs+wxURou4XhxmCbLY6iYS3w3t7EyH0i/TII8y1ejdLKcxcdjBwOtjT
         cwLSKXnpP2GE/4MMM8KD+47WcCr8oAVAo8qUUhLLou0NjXNVY7IkZIuL06UFseTzKmpc
         /YDA==
X-Gm-Message-State: AOJu0YxMp+9GMm0Af5Y4zQH9e0Wa30213QoFvWE0zkQ2pN7uo0mqMQRC
        G+duAb3x5/CtbDlO1ZQSLoI=
X-Google-Smtp-Source: AGHT+IGP+tsKjE6FYbGbUmmhVV1FFnk6Arv4YhnHUW4vtwp3OS+M0ZjK8Q+VxstOKUJmeo1bQb+AaQ==
X-Received: by 2002:a05:6a20:440c:b0:18f:97c:823b with SMTP id ce12-20020a056a20440c00b0018f097c823bmr1217084pzb.69.1701878018961;
        Wed, 06 Dec 2023 07:53:38 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id k205-20020a6284d6000000b006cea1db00cbsm132610pfd.204.2023.12.06.07.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 07:53:38 -0800 (PST)
Message-ID: <096b7406-b57c-4daa-9a12-38338dbd91ef@gmail.com>
Date:   Wed, 6 Dec 2023 12:53:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: sync: add `CondVar::wait_timeout`
Content-Language: en-US
To:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com>
 <20231206-rb-new-condvar-methods-v1-2-33a4cab7fdaa@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231206-rb-new-condvar-methods-v1-2-33a4cab7fdaa@google.com>
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

On 12/6/23 07:09, Alice Ryhl wrote:
> Sleep on a condition variable with a timeout.
> 
> This is used by Rust Binder for process freezing. There, we want to
> sleep until the freeze operation completes, but we want to be able to
> abort the process freezing if it doesn't complete within some timeout.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]
>   
> +    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
> +    /// thread to sleep. It wakes up when notified by [`CondVar::notify_one`] or
> +    /// [`CondVar::notify_all`], or when the thread receives a signal.
> +    ///
> +    /// Returns whether there is a signal pending.

Remaining jiffies or zero on timeout?

> +    fn wait_internal_timeout<T, B>(
> +        &self,
> +        wait_state: u32,
> +        guard: &mut Guard<'_, T, B>,
> +        timeout: u64,
> +    ) -> u64
> [...]
> +
> +    /// Releases the lock and waits for a notification in interruptible mode.
> +    ///
> +    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
> +    /// thread to sleep. It wakes up when notified by [`CondVar::notify_one`] or
> +    /// [`CondVar::notify_all`], or when a timeout occurs, or when the thread receives a signal.
> +    ///
> +    /// Returns whether there is a signal pending.

This one is correct.

> +    #[must_use = "wait_timeout returns if a signal is pending, so the caller must check the return value"]
> +    pub fn wait_timeout<T: ?Sized, B: Backend>(
> +        &self,
> +        guard: &mut Guard<'_, T, B>,
> +        jiffies: u64,
> +    ) -> CondVarTimeoutResult {
> [...]
