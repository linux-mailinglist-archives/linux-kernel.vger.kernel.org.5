Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865F97A2F54
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 12:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbjIPKwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 06:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbjIPKwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 06:52:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F51E3;
        Sat, 16 Sep 2023 03:52:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401da71b83cso33726305e9.2;
        Sat, 16 Sep 2023 03:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694861548; x=1695466348; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkaN8cKyKQ/v2N4UZS/i+2Cr3FWbQdqVVYD1cTsC53I=;
        b=gkVornrABpv7L4C/LUuZGrwrY0vm5AG3V1Y1MW7zwNnhRZREOYjXAjLQBQlJJADKX3
         vpaZsOeQs/88zNIBuVfmEWpAj+91c7A+x3jutu2v/MKnoKMibFtYSbou9Lv+90nZ0hjt
         9vpwYE5AxtakBUnsfBYIi0UIh7YT4D7ZGXedlZnfHG2nj6pAP2lylyVQiQP+Rf45efJd
         M0n5DM4f+pCQf42EBElSKQF66WL2IdoAnGltovNGwpqWywi0GpNhxAvOfSEE2MAXTJVZ
         HUFKLliqzwaMkpywwrgZi+gCw8dA7EEvvo6ycQnx/qOJ8YxdGjKeNQNoC5QSLXAkMlx0
         awEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694861548; x=1695466348;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NkaN8cKyKQ/v2N4UZS/i+2Cr3FWbQdqVVYD1cTsC53I=;
        b=BPNPVo6BUu3EbLLMMK8AP5AmNqk7pKarXtrQR+lC6pin1wI2NriyNwDo/PCpsIteqh
         HtKjuee+T3frRmcAtzUqXPq/iMwHeYV20UsGr7/EXQHM3XE9gij9JZZJJ0c/nkid4AEM
         LJbdQTQDeJ6tONySm2oSFrYFpUp1OcYg2aVcqICo3CHHDTrJuS0g5FXHQCaVdfordIEg
         9VNqeacqa1NuhFBQSFNeCn9S2BEMf82MLyk6V8GoDEgyl3/Tj9KU6x6yW8ZydABwmLW1
         plbkcFkcWALRZXSz5Xl/kOtLg+NDDSxp9R1TFmURLZxeMnvQMDleOj+xutGdm9n8lFBE
         MJzQ==
X-Gm-Message-State: AOJu0Yy0seffabv7t3hVyGASh0tShigCQZARX8p4dCuyJufZv/7q9s6i
        guiVDfd4ltqcXB1PMmzpJcc=
X-Google-Smtp-Source: AGHT+IFdjBX4VSeBZn0JpdO85JrcBe0bVVpLDZ4NtoJf3Oru0QM0aSmeH6zWGbp6bEW3eVbBqI27SA==
X-Received: by 2002:a1c:7203:0:b0:3fe:15f0:dfbc with SMTP id n3-20020a1c7203000000b003fe15f0dfbcmr3689181wmc.12.1694861548123;
        Sat, 16 Sep 2023 03:52:28 -0700 (PDT)
Received: from localhost ([45.134.213.210])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d470f000000b0031981c500aasm6838175wrq.25.2023.09.16.03.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 03:52:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 16 Sep 2023 12:52:26 +0200
Message-Id: <CVKA9XPFB9BF.2UL40PGKDJ00P@vincent-arch>
Subject: Re: [PATCH 1/2] MAINTAINERS: update Rust webpage
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Alex Gaynor" <alex.gaynor@gmail.com>
Cc:     "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Andreas Hindborg" <a.hindborg@samsung.com>,
        "Alice Ryhl" <aliceryhl@google.com>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230830165949.127475-1-ojeda@kernel.org>
In-Reply-To: <20230830165949.127475-1-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
