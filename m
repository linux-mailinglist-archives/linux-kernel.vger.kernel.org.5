Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C7E770FC2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 15:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjHENAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 09:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjHENAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 09:00:03 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FA9421E;
        Sat,  5 Aug 2023 06:00:01 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a5ad6087a1so1786120b6e.2;
        Sat, 05 Aug 2023 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691240401; x=1691845201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h5NfH9OsC44kYN2FyhNKjch8VH/C5i+QaDG1Xkj193U=;
        b=BEgNq80EFNCy0dfB/L4SoAJmJyM6fAhm/nvKaSzSoY3hnR+WLgt+oEcpqDRDxgCFSZ
         /wGwgKKyAPStPWCZzRAf4oS05oDQNXGAb5gSWYmQmgv/4MlQYPixH59QwOgN9NnlfX1N
         jY9lL6zTcY0ThGyjg+pee/cx3OKIeyMBJ6Gd8z8KsCrfUYFU3SKtV+i5bKspNhTyqVzv
         J1hd8Y4G93hm9xbgdBKGnd/UPn+UL9h0FSzJ/oGTwBG3ZqhfEjZvjRCzivxD6u2SLA5C
         AlrGODRenM9nYD9h3CZTnz6pukajQoSFHhBvLuq98J93nwB5vCm7B/lXBa4eCZB0cHmu
         6sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691240401; x=1691845201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5NfH9OsC44kYN2FyhNKjch8VH/C5i+QaDG1Xkj193U=;
        b=cdl1SYYeS3R+07moLQU3NSRj5JkGabC0OIWnXQ0LZSeaKbXuuGuQdsMmdlGvlFYItg
         7iOSdhlmiPTXG//SBLWtqjX59HxDHizP/v+UL68uffsBTOP9aRt2+p6mPhOwlOannRCR
         qs3eHiLxBja+X+BnE49OzNjultIIoPuOqkfO6QSsuuMBvMlVf5loLKodLk1y5Ee769EY
         qYKea+2Y9xEPCUDxNjwHsXvXj0hnvbj9eXzBJ6B3kNVDJVFl53lpPDbeo9FyzoX4s7te
         Oaeg7LbLvrM6Q2Nl+2Ao05R570VjhmJd+MmJsq6stIGGq3/MtpdoH85Aw9Wm2mH6dRRc
         pCrw==
X-Gm-Message-State: AOJu0YyDXHDF1B1cjAtVc7C8z+nt1yMKubC9HmD5oW4WvolvV+dITNkV
        uOPwYER96W99Bfba7FukurM=
X-Google-Smtp-Source: AGHT+IHmjQPNyAOzwgDZrOxNpeFJAPSGNldzuoUTCBTUhlzH2RWSvaEiMGzrbkKYqwwar7ghnqlhDQ==
X-Received: by 2002:aca:1012:0:b0:3a4:8a41:c69c with SMTP id 18-20020aca1012000000b003a48a41c69cmr4244750oiq.13.1691240400971;
        Sat, 05 Aug 2023 06:00:00 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id y14-20020a4ad64e000000b00541fbbbcd31sm2149169oos.5.2023.08.05.05.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 06:00:00 -0700 (PDT)
Message-ID: <32944cb3-5c0c-4ca0-97a9-841114c9adc9@gmail.com>
Date:   Sat, 5 Aug 2023 09:59:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scripts: generate_rust_analyzer: provide `cfg`s for
 `core` and `alloc`
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230804171448.54976-1-yakoyoku@gmail.com>
 <CANiq72mkmTRzuYSGveP2xxPbDJELHXoVWVbKF2eyK0DhJ+y7bw@mail.gmail.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CANiq72mkmTRzuYSGveP2xxPbDJELHXoVWVbKF2eyK0DhJ+y7bw@mail.gmail.com>
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

On 8/5/23 07:46, Miguel Ojeda wrote:
> On Fri, Aug 4, 2023 at 7:14 PM Martin Rodriguez Reboredo
> <yakoyoku@gmail.com> wrote:
>>
>> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> 
> Thanks Martin!
> 
> I am a bit confused about the Suggested-by -- did you add it due to
> the suggestion from v1 of passing variables via command-line
> arguments? If so, I appreciate the gesture, but the main idea/report
> (passing the missing `cfg`s for `core` and `alloc`) is yours! :)

Ah, it was because you suggested the commit's text, should have been
more clear about it, I thought that the "Suggested-by" was for any
suggestions in reviews, and in reality it was for suggestions for
the kernel itself. In this case I've got confused. So, because I saw
the issue with the `rust-project.json` I'd like to rescind that
"Suggested-by", though, FWIW you still get credit in the end when you
do the sign-off at merge. 😇

> The patch seems fine, I will test & apply it soon. If someone wants to
> give it a Tested-by with rust-analyzer, that would be great too,
> thanks! (note: it applies on top of `rust-next`).
> 
> Cheers,
> Miguel

If someone wants to test it, just try in your IDE to go into the
definition of some member of `core` and `alloc`, e.g. `Pin` or
`Vector`.
