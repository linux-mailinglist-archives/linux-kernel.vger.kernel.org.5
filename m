Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943C37511FD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjGLUql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjGLUqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:46:37 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E8AA2;
        Wed, 12 Jul 2023 13:46:37 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b75637076eso6422038a34.2;
        Wed, 12 Jul 2023 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689194796; x=1691786796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ht8m3JpnPLfdwbNyu/YR+stFiN46jyoA/rcch4tcqlw=;
        b=HZXLcni+Ow6q1V7U79jBQqg0mozLSVlS6mIrhsdQmulgIfFLAdOsMw3OCvtE9j6n9g
         xH2PjYF51TyP7XNrNxU3yDxwvNQzjOsMjvuDkQHmXZ7Q96oug+DkHrScUgyTNv6ZhFdO
         G0KFbq4czeMUJYlQKitJCxF3defmyjmEQzkL9kdoS10Gzz9boFFoIGyCfKvGXrbA10sk
         n1SjeXZo2aCu8hQTjHNKRSGDoi0Ep6GMdE4dTHsejss1GK8jp79rjauA8igLbmncrk5D
         h/c8dC8Tr2CF0fwCnd3FDGOjzTXGXoxroqXxSPZ/LbpVKOOgQ6nZbs9DyW4EOxgvTjlp
         0Ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689194796; x=1691786796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ht8m3JpnPLfdwbNyu/YR+stFiN46jyoA/rcch4tcqlw=;
        b=SzrsOz1H/W6/1fPZhIN8ol0neg0rVvGZMYlP6dUNqOWb3VGXWYetAwMuNqTSQQRFTt
         TOmEDMnxLME3xTty6XcqKbksQgJfvO0tUuzvoQPC/Ytaa3EJG+ptEwnR60XZIk8aOIQ9
         sW7hfaU3kyDjjen1fHEdAcwBMO6pfrMi/0uPcTVujmkJUhn1etXAcRrwXnH10nwktWNo
         EYb1uz/g6fcfx5Ez/zAm7YXDY5wvsNmbMjnlwyZ64tqqPa6kffqX7KhLcsXOot7eu26H
         awIPzXRRFdWif5sQ+Io3nx/ookC6jI1it+7PUd/wPqFdq9l0iBmOYw+Vj3SCG+4vtFdm
         rzLg==
X-Gm-Message-State: ABy/qLaEqXlRxuBOtnDO/Fea5aptuF5N/tQ7A8mbHWnWqtWsHA36PjDd
        lU4JX27e0pXaiPGlhADwe+k=
X-Google-Smtp-Source: APBJJlFBh4EdX43Vi87ClYbGGo4lYoKVRn9LizgIGpKhDitwpjeftap6gzZh0cnr7cXL7OMdDTMRQA==
X-Received: by 2002:a9d:638e:0:b0:6b9:8feb:4930 with SMTP id w14-20020a9d638e000000b006b98feb4930mr5498091otk.35.1689194796305;
        Wed, 12 Jul 2023 13:46:36 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id n9-20020a0568301e8900b006b9aa110e0esm125344otr.76.2023.07.12.13.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 13:46:35 -0700 (PDT)
Message-ID: <449f81fc-42fd-bd8b-6929-8cd2659d8ea0@gmail.com>
Date:   Wed, 12 Jul 2023 17:34:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/9] workqueue: introduce `__INIT_WORK_WITH_KEY`
Content-Language: en-US
To:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
References: <20230711093303.1433770-1-aliceryhl@google.com>
 <20230711093303.1433770-4-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230711093303.1433770-4-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/23 06:32, Alice Ryhl wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> A Rust helper (introduced in a later patch) needs to call
> `__INIT_WORK` with a passed key, rather than define one in place.
> 
> In order to do that, this moves the initialization code from
> the `__INIT_WORK` macro into a new `__INIT_WORK_WITH_KEY` macro
> which takes the key as an extra parameter.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
