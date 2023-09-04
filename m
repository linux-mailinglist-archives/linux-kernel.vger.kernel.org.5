Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D800791275
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbjIDHoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjIDHoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:44:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5FCE1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:43:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so11031035e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1693813435; x=1694418235; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ifvCGzYZ8dSBZT/icGjJJZKmlvecnEtAo9NWhhlJprI=;
        b=RabA6zB5XWUowHX1AjzAjs540jWwnl4p4lOjBVrQMlJ8zwFCvogTdDDJU3yRMd0KBc
         51GDkir9qjszlZdx99wMIs7soG9jSUM8npo5KebAeFSYVxUs07saSag/+L4Q99Q1Iz8b
         GEVn1l8q1mYgQK0ZqOl8J262GgSG8VJl1Qknyz0vcvOZUYl880inS+dHn2ZtFx3GoQz7
         GEUYjv0/yH+2QKU3uRI9EI+9do+kF/w4RG5lu+aWaYmbOBbSx7qtcjeFlogjbapXx1P2
         1mmiUlmr+4p/IirA5BSlW4TD4A0TJjCzjK+JoEzyKTmQdSkbTh2C5N28XNcylxIzWiI/
         XCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693813435; x=1694418235;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifvCGzYZ8dSBZT/icGjJJZKmlvecnEtAo9NWhhlJprI=;
        b=e9TunAZIpnHetFjWUCbGS1eSMrprYrI0rHV8zZe6Qax0BBvPUu2pTbIj8D+TF3zunH
         QlAXYNBuFIeOd6cGwizCl7iw9J0433CSHYTUcn2mUWj5D5d0B7eiub4c1l2A6YAPdSg+
         ktUsKLuqqzNBl0R60KnabDKevkdc+8nrSOJijXIWeexgRJI3GgCmJabWYA25MU2jgz44
         Ev/LVOCGORuuA5Xcz3L6OXN4DKvIceHVYbSo/jdOHoA6WeR0MtozuR3BJhiB7XgPHgCk
         KtvkhOpwavJTXIT+qEjVhBIrkHF+0QvYGBgo+N0hNRskoHtVw4UPFYoQxCVekUPIeNAF
         zkbA==
X-Gm-Message-State: AOJu0Yw14P7DQRVNpv6VTJTTQgT7zmpER90eCvMN+C8XJqsck0AM1ciU
        Mmt9lnARTJxKFxs+Gm+aPcPaiw==
X-Google-Smtp-Source: AGHT+IF/VhmH8vxSF24dGvyU92yKMeU6tMOo/g5hatDiNDqzAh+m4v5n+Mvz8VKgYQUMhVlad5G9Gw==
X-Received: by 2002:adf:f291:0:b0:313:e88d:e6d3 with SMTP id k17-20020adff291000000b00313e88de6d3mr8760640wro.14.1693813434681;
        Mon, 04 Sep 2023 00:43:54 -0700 (PDT)
Received: from localhost ([147.161.155.99])
        by smtp.gmail.com with ESMTPSA id f9-20020adff989000000b00319756d5b80sm13912160wrr.29.2023.09.04.00.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 00:43:54 -0700 (PDT)
References: <20230830165949.127475-1-ojeda@kernel.org>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 1/2] MAINTAINERS: update Rust webpage
Date:   Mon, 04 Sep 2023 09:43:37 +0200
In-reply-to: <20230830165949.127475-1-ojeda@kernel.org>
Message-ID: <87pm2ytmbq.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Miguel Ojeda <ojeda@kernel.org> writes:

> A few months ago we started a webpage for the Rust subsystem and
> the overall Rust for Linux project [1].
>
> The current `W:` field of the Rust entry points to the GitHub
> repository, since originally we kept information in a `README.md`
> file that got rendered by GitHub when visiting that URL.
>
> That information was moved into the webpage and got expanded.
> The webpage is also nowadays the entry point to the project,
> and we pointed the "Website" GitHub metadata field to it.
>
> Thus update the `W:` field to point to the actual webpage.
>
> Link: https://rust-for-linux.com [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

