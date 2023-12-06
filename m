Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B6E807402
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379430AbjLFPxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379121AbjLFPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:53:28 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60DCDC;
        Wed,  6 Dec 2023 07:53:34 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce72faf1e8so1452600b3a.0;
        Wed, 06 Dec 2023 07:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701878014; x=1702482814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5KolgmnbLoN+iIAli39wtVpgTK8f/3jIF8chaSrw98=;
        b=EGJDVeI5s7gYocI3+2YE031HShUb6b5YSNARWohJFBfB2j+z9+LgARxpcATXs2C77z
         sVXFUGXJdu7nj0G06A/Geu1SiN2d8z9DmrojDcEyohWkCFNSiJZ36jrRTfuNWr+ooMd2
         UxQjfAcxHGiPlnFFkKq417YlgBvWmoBNsNynS96O6ahkWYKjMoP2oW5vT7eTR/OWtD7L
         3aSdItHPnANWTBH9ilV+scWsZd2vEwi5racO9zcJWbJioXg8d3LNUjkUZaE3Pqf2f402
         l+AHkZxjMSGltEKteqGi2/1aiWVArbAEP22FQm3rTCrDxZcoIr031D7Qgm5F/TpvnE9f
         Jf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701878014; x=1702482814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5KolgmnbLoN+iIAli39wtVpgTK8f/3jIF8chaSrw98=;
        b=OpJ9SrUl0UhiUfxp19N0nN1xV59CcVX8BuqPpGMJcVwMFU91YY60YSBQzmQDzEl3zP
         QAfxga9jd8lZ0xQtXLCmGRC56b/vBJj0Uixx+nNDgFdMFJ/3MthWe7HwwxAHBQK1hqmX
         qxNr7AdkKiPBI8g2vemd6w9d6CLxuELmoinzRBT2toZlYacUx/nu0U2z9pZyL8hqcULR
         7PBZOwSNS5QWuvAp0h0Ngs9TQz0QjEX79vFjvF3AIBkdHRA9Upn4oq37qOepLjIQ6on+
         4Zmdu9vxUQiuvZKiuVMHDS5bis/xQZWUbuO3seImQ5qGMy7VOfBW34BK/f/G+FXX3rWt
         XKZw==
X-Gm-Message-State: AOJu0YxJynBsr0fR0lo29YbDr/A1MUjA/K3kS99y9enF/zMNJ0pAb9+n
        GSzdPlHem4pBzW8la3fuB0o=
X-Google-Smtp-Source: AGHT+IG79ACydag/93BziGOU/TT7gfZeUiO6TAW0w9r3G8JSWu42uzdl24C7CyZxfZYReRgKdhOD7w==
X-Received: by 2002:a05:6a00:1807:b0:6ce:6837:4fcd with SMTP id y7-20020a056a00180700b006ce68374fcdmr892035pfa.52.1701878014248;
        Wed, 06 Dec 2023 07:53:34 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id k205-20020a6284d6000000b006cea1db00cbsm132610pfd.204.2023.12.06.07.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 07:53:33 -0800 (PST)
Message-ID: <0e8605d4-3be2-481f-86d7-1d3d4a8386c4@gmail.com>
Date:   Wed, 6 Dec 2023 12:49:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: sync: add `CondVar::notify_sync`
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
 <20231206-rb-new-condvar-methods-v1-1-33a4cab7fdaa@google.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231206-rb-new-condvar-methods-v1-1-33a4cab7fdaa@google.com>
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
> Wake up another thread synchronously.
> 
> This method behaves like `notify_one`, except that it hints to the
> scheduler that the current thread is about to go to sleep, so it should
> schedule the target thread on the same CPU.
> 
> This is used by Rust Binder as a performance optimization. When sending
> a transaction to a different process, we usually know which thread will
> handle it, so we can schedule that thread for execution next on this
> CPU for better cache locality.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
