Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC87790F5A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 02:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbjIDA3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 20:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjIDA3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 20:29:31 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E91CFB;
        Sun,  3 Sep 2023 17:29:28 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1d4db7959f6so350520fac.0;
        Sun, 03 Sep 2023 17:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693787367; x=1694392167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gy5Sjqdfk2V0r51PCTu3C9haVoBFcraAmneb4UVU19U=;
        b=U2HgYdZ92FaSWhJWYup3XY7Dr3uZ8GLsGiq2+pnX4m0cAVoWtVusgRTp04SD0MzD6j
         xjARBm4YwA7C9GatwHz52TBjmREPhI44obDeT+YIxqLWjG4K3gbxdVwEj1u/U9CzOBTn
         2lU6w437kxjowR82iCZLI6nDxyx4KJDQDmAugLpmZv4CRbhmyWtBZ2kkPUtAxwTKuHxs
         q6V1SS9dwtbERMoDbR0wcneC3pm2vOfEqAf5w2N9RVdNhXAg3c8Xb6vlCfsWjrVNElF5
         K2PDyTaJPDL9lEw4Sd3qgnMOGmxIAmPJIw0DS06kfuImYD5NQt7CXDMuATTc6ZP9qAK4
         C2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693787367; x=1694392167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gy5Sjqdfk2V0r51PCTu3C9haVoBFcraAmneb4UVU19U=;
        b=OKMNVbRI2KsUdqLlzSsaAfPz4BXOyNxgTnfgTP4m7knS6KADPCufd+OpJuMjQOMp/X
         Dq5zL8MsbwrU41aDFnoqpuKGmertMJT4THE4bzW8MzLZsQV4OFvITJVuxwaUgx67DRuB
         jNJgxUdjPDHQ6jzG/SQ01NwXy5iUCnVN+anxjJpBTEq8Ph6uKPOoxPfmGkrHIfb1DqtY
         mKdQofvCazX2ulIi3CisMMzxb4a7qDrPD036PSWiZK5XvmIZhWENnBYhNoBNMrpgXFTI
         YvcK/8sKBu4OEWErfZLrb2/lAhhPyHMLsqGCL5Wrvva1NZa1wFCdhJaz+/xzh1VkZtJ3
         nejw==
X-Gm-Message-State: AOJu0YymmeAhmNcAgSeBZ+1LbqfWlqmIwvz40QmEwcVjYJhlTUPwTNVO
        ccvLVfjMcinYYnD6844CvZ4=
X-Google-Smtp-Source: AGHT+IGCDuOU6ZKDHAMJN3qwCQh0SSLDaW3mcfd+gdvDCLJaKZCieOBaxDqBhoVMKwSfvXgOteXNeQ==
X-Received: by 2002:a05:6871:720:b0:1b3:9e41:de07 with SMTP id f32-20020a056871072000b001b39e41de07mr11773582oap.36.1693787367366;
        Sun, 03 Sep 2023 17:29:27 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id eb49-20020a056870a8b100b001c4d922b4fasm4860255oab.8.2023.09.03.17.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 17:29:26 -0700 (PDT)
Message-ID: <8de45c09-cb53-4a18-a6f3-56a16553ae32@gmail.com>
Date:   Sun, 3 Sep 2023 21:29:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] rust: workqueue: add helper for defining
 work_struct fields
To:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230828104807.1581592-1-aliceryhl@google.com>
 <20230828104807.1581592-5-aliceryhl@google.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230828104807.1581592-5-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/23 07:48, Alice Ryhl wrote:
> The main challenge with defining `work_struct` fields is making sure
> that the function pointer stored in the `work_struct` is appropriate for
> the work item type it is embedded in. It needs to know the offset of the
> `work_struct` field being used (even if there are several!) so that it
> can do a `container_of`, and it needs to know the type of the work item
> so that it can call into the right user-provided code. All of this needs
> to happen in a way that provides a safe API to the user, so that users
> of the workqueue cannot mix up the function pointers.
> 
> There are three important pieces that are relevant when doing this:
> 
>   * The pointer type.
>   * The work item struct. This is what the pointer points at.
>   * The `work_struct` field. This is a field of the work item struct.
> 
> This patch introduces a separate trait for each piece. The pointer type
> is given a `WorkItemPointer` trait, which pointer types need to
> implement to be usable with the workqueue. This trait will be
> implemented for `Arc` and `Box` in a later patch in this patchset.
> Implementing this trait is unsafe because this is where the
> `container_of` operation happens, but user-code will not need to
> implement it themselves.
> 
> The work item struct should then implement the `WorkItem` trait. This
> trait is where user-code specifies what they want to happen when a work
> item is executed. It also specifies what the correct pointer type is.
> 
> Finally, to make the work item struct know the offset of its
> `work_struct` field, we use a trait called `HasWork<T, ID>`. If a type
> implements this trait, then the type declares that, at the given offset,
> there is a field of type `Work<T, ID>`. The trait is marked unsafe
> because the OFFSET constant must be correct, but we provide an
> `impl_has_work!` macro that can safely implement `HasWork<T>` on a type.
> The macro expands to something that only compiles if the specified field
> really has the type `Work<T>`. It is used like this:
> 
> ```
> struct MyWorkItem {
>      work_field: Work<MyWorkItem, 1>,
> }
> 
> impl_has_work! {
>      impl HasWork<MyWorkItem, 1> for MyWorkItem { self.work_field }
> }
> ```
> 
> Note that since the `Work` type is annotated with an id, you can have
> several `work_struct` fields by using a different id for each one.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
