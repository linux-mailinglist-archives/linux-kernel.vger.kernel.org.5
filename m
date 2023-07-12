Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4877511FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjGLUqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjGLUqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:46:47 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEA3211B;
        Wed, 12 Jul 2023 13:46:42 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b71ee710edso5937795a34.2;
        Wed, 12 Jul 2023 13:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689194802; x=1691786802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=628ih5bizlhQ3djgHOKWOH7QgJ53Ou8epa9OfduyY94=;
        b=jyYkh7d66iDiOoNinY9vMAp/bxzbRZw81GvJdhia72FZzkBhljA2jkaP/mqwz56F9E
         aSViKdUxgy+GKPhqS9y01Vy79ouD+hOAzrxRvSfSuvA4/hgXIHGH9Qrjc0qTvSsY8nEr
         QGh+iSOymyfCIWPUaOqOUNzEAGD4xAO12/nqhzkmjF9vYU6p9aTVJC88iPVIos3IXPhk
         LGjksBpCmCA9VuX97WSgJCzFWo+AXERKV7JVZMpc4ZsI2GZ0ajx5s2MNiOAmGhKlU7/+
         f4kXT2iqNI7ndb6NUH6bBewLjHUWU01NCnAvhR6kLU9/BS+V2VPJLdQfkZRTlWeLr599
         t9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689194802; x=1691786802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=628ih5bizlhQ3djgHOKWOH7QgJ53Ou8epa9OfduyY94=;
        b=dm0traprhmAJMpJFywAhzSYzuz3ZXUNwJGKmR0y18PbJSoq9iViH6XWnA3lyOxUzFu
         ceSUwMfMsjpyhVaiUtBq1yYnB96bqlfnF+enGGd0L+/LAeGSs21GNODXoDJtF1kxtbRR
         FnNDOvz55ShSG+TXOeidiaJKVSDfOZzV0u2iEpEelIO6ITflortc5nV9l9yGR0CIpvEu
         hbdlLjQNe0JQAHE79LoQpZ8K/ZPzs8G/i0QVBSiJPBC8owx7z/pJmv8phJSUFyMHnFWg
         m/zmDtctPLvb5ecmF/D3IwFcxjwnxmlyrMLlWSJyu2BV1j4DhHA9oVeKsExL/VUk9/mi
         EKKw==
X-Gm-Message-State: ABy/qLY93jdu9eN4KK0jvGYaar5utr5oQJOKL8NdFcOdEFrx/KFr/eFi
        90e8749OoREMNpg7SapFYDg=
X-Google-Smtp-Source: APBJJlG1uHbLqMfVb85NEIj1Bl6NRHhL8/eOnkWCEyQcR9u/VwVtBHUGVivuTMxiDc9KCGtrjmfvHw==
X-Received: by 2002:a05:6870:46a6:b0:1b0:649f:e68a with SMTP id a38-20020a05687046a600b001b0649fe68amr20993394oap.25.1689194802123;
        Wed, 12 Jul 2023 13:46:42 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870c38400b001b36699bd5fsm2387257oao.35.2023.07.12.13.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 13:46:41 -0700 (PDT)
Message-ID: <75a9f4cb-662c-bf8d-3b92-e9c54bc9882e@gmail.com>
Date:   Wed, 12 Jul 2023 17:43:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 6/9] rust: workqueue: add helper for defining
 work_struct fields
Content-Language: en-US
To:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230711093303.1433770-1-aliceryhl@google.com>
 <20230711093303.1433770-7-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230711093303.1433770-7-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/23 06:33, Alice Ryhl wrote:
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
