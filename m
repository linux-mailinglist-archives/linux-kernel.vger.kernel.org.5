Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE9E7AC4DC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 21:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjIWTdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 15:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjIWTdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 15:33:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785D7FB;
        Sat, 23 Sep 2023 12:33:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-692b43bd804so1676856b3a.1;
        Sat, 23 Sep 2023 12:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695497613; x=1696102413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2uhQYW0dA/MmHO+MVwE4AWGk/2906LanaDbbQRTzq8=;
        b=dWICs9SzszukHq2ezCzjq2uXSBxdul0u/zp32c7RIW8rAx+Mnc6Ndm5qrB/6J1roXG
         Q+XVHk6Sdnwn9v5vZp/EyMChMCnH2Hta6zA0ZTQLFaS6LOfsipG/pwydqpUyn7ewCLzI
         ZSxE05U1eu5zP/2NT9c4GZGDNh6TfVAEY4GBjfmNcMHuh6Vk7KogWkktb2mpdzVIusE1
         bo4TjqAm4QsaDJV0Dcn5Bj/wtkVHVn62myu9uotpfekR98aMV/LsFdVHS8x2PiMHrpWj
         TFfYRuOvMN6VyZaK0P91dRPrkZD8+FvUIng2kVrapnhwxG5lu5pkjs+L6IX8Y9aMStE0
         6oEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695497613; x=1696102413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2uhQYW0dA/MmHO+MVwE4AWGk/2906LanaDbbQRTzq8=;
        b=etWENF1VMf65ibi8JpPxtZOPhaK07YE5FEYqvIesL4xJh+xVS2nFZ/3dAKh0Eqc5HO
         UwcDxRKGBH/u7FFhbrQruC5kPc71vZVFd43k/CpYUzVPWXrBsHcOoRo8eTK/0ACgsHxL
         MpOlZYmVFFHYKpI9BRs9xijngTqVbJBXaoOLcV9D259IbD5x/RUDZd04WPqGjUeWET1R
         7y06fLlMEqlvxXYE5AOIgQimib8yZ5bQzer+ZnbrG3eXZCFjS5KDSwhk1ZFC/9HRwLtd
         YUUyIn2GpbUHoooxe8IA+/cBuGbQm/O4L39n3OJZAI4d2sj0Ynyhfzh4XsyTwSqV5Aci
         V1DA==
X-Gm-Message-State: AOJu0Yzm0IuzXVnPGj/MebjiA+xWfPyjbCNCoeoZVCv1H4R9rpXU3cmZ
        r5KjWYhcjYWvLoC/h4VZztE=
X-Google-Smtp-Source: AGHT+IH63fxYdv4NUEWQREcnUWlg7lC1Pejc1RlForkJPuVlLNWZcUashfYmlqFGFS33mFPo21LU/Q==
X-Received: by 2002:a05:6a20:3caa:b0:135:110c:c6e1 with SMTP id b42-20020a056a203caa00b00135110cc6e1mr2606684pzj.7.1695497612884;
        Sat, 23 Sep 2023 12:33:32 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902d2cb00b001c06dcd453csm5685740plc.236.2023.09.23.12.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 12:33:32 -0700 (PDT)
Message-ID: <9b8aaa7a-55e0-4696-a0f1-c4f7af0e46b0@gmail.com>
Date:   Sat, 23 Sep 2023 16:31:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rust: arc: rename `ArcInner` to `WithRef`
Content-Language: en-US
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
References: <20230923144938.219517-1-wedsonaf@gmail.com>
 <20230923144938.219517-2-wedsonaf@gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230923144938.219517-2-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/23 11:49, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This is in preparation for removing `ArcBorrow` and making `WithRef`
> public.
> 
> This is a pure name change with no functional changes intended.
> 
> Suggested-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
