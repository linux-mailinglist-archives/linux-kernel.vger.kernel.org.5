Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E70275AF23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjGTNGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGTNG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:06:28 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B89CEC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:06:23 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-51e10990adfso507095a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689858381; x=1690463181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/at4jH27H21CsYZHQRwVsYrLL9KruC5VGWS/DvqAKHA=;
        b=OFaEtpUYyMNFOM0NfFcg7nmMcRS3nqz23n4mURCNglVm571UlAJZEZV6pB6LIaUakF
         o/yI2oUJb6FBAhl3Y55XKklv71Sl3gw7TxlZX7lmPxGHlAmg1dxIf1iQaMHOlN+0NwNr
         qTES668VPErVm21NQS8OUWi3vKlfSFwMF26e3jXz/lEVAoGljJsMZGF9BIWmqvgrecLx
         WyeN1k2916KjQj8OjEIB3OF8mFgjh09x1iYSn8R0s2xoGoliiNWGJYH8eSOOldYbpnaS
         8LTVVW963HandtodZKVTgOMmWWvKzROlqPVliJfPhyVzcnWKRQINGTTE7yObFsJzRElQ
         MeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689858381; x=1690463181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/at4jH27H21CsYZHQRwVsYrLL9KruC5VGWS/DvqAKHA=;
        b=c2ld/EszWemAIQCXhKlUZmh9YbXUa3y2HA+rOhG3sXfS6uQaBw+f1l0NMMurIDRiL0
         zCTgzgdrYjDs5+Mfk4hZeXhLMr3/5SLleH46sqNJ9jaBEZgGiyxTNVXkdyjiV0DCLpZX
         +bGJHd7TYAb0Akk74FUPG+G5NzufV7GNuRV4DBj9U6AQ4TyUj1Rbq6eg20oqKsZNicZN
         JBk+t8kHrAXL4vAi+cVH5QTq9tuZUeCXaHDy27t1fvH0aAIOFIRuHQtT7KilIvMPp0N6
         8sI8JKyxi+BcN3ShfeMI+WyNZ2zJj4fmNpY0k06sOgDaWYvp/vsfg328xoUw+AotVDvW
         ZBlw==
X-Gm-Message-State: ABy/qLaq38L4XPEA0gJvhETCkVJbPIwyUY4ezfJxf0tTwnmB9AsLJeCf
        hILhYGaMz4rgTZxhoPSVEUdJXJiEmpVRWb0=
X-Google-Smtp-Source: APBJJlFaiCJripTrjFUxfCIu9UUdHNJum1sFAyZihhb7NiffEyNZF4VvsIcfcvuWRtqY0P7MYcK+iXDdXQdDWro=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:a454:0:b0:521:822e:2f34 with SMTP id
 v20-20020a50a454000000b00521822e2f34mr24665edb.8.1689858381638; Thu, 20 Jul
 2023 06:06:21 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:06:14 +0000
In-Reply-To: <20230718054521.1048785-1-ojeda@kernel.org>
Mime-Version: 1.0
References: <20230718054521.1048785-1-ojeda@kernel.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720130614.3409059-1-aliceryhl@google.com>
Subject: Re: [PATCH] MAINTAINERS: add Alice Ryhl as Rust reviewer
From:   Alice Ryhl <aliceryhl@google.com>
To:     ojeda@kernel.org
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <ojeda@kernel.org> writes:
> Alice has been involved with the Rust for Linux project for
> almost a year now. She has been primarily working on the
> Android Binder Driver [1].
> 
> In addition, she has been reviewing patches in the mailing
> list for some months and has submitted improvements to the
> core Rust support.
> 
> She is also part of the core maintainer team for the widely
> used library Tokio [2], an asynchronous Rust runtime.
> 
> Her expertise with the language will be very useful to have
> around in the future if Rust grows within the kernel, thus
> add her to the `RUST` entry as reviewer.
> 
> Link: https://rust-for-linux.com/android-binder-driver [1]
> Link: https://tokio.rs [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Alice Ryhl <aliceryhl@google.com>

