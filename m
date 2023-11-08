Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89217E5364
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344193AbjKHKbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjKHKbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:31:10 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FDA1BD9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:31:08 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2c50cec5d29so56504831fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699439466; x=1700044266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkbdBisJ/PG8hxDlR5ZTMvNYc0Onf1/wmRPSUcltkmk=;
        b=MhCPuiUTLIZN3/OohpOZYQS2TAfVZkSxpgJO1bwPgAk6jXusf9S8IshTewsSbHnHMr
         o5Qepf2wi8GpcZC57HM5lalPtnWFtNjvPOSqcyFtqEMgE7ghr4oGab/drnS9LTpruDYC
         RTkyONK4f5SwA/l5JW3N4qo0SiTmgdEl3md0MPsENkEhyeH0sFNCHvcgxavdOm2NjORd
         lub4AQHrTtEkaGR42YYpmoHjnLfj3k32ATQF6fH/3Nqhe8ck7N/eyuRx6udawTzcv/Ff
         MG2kYNNOkFtF1vfYr2SGenaQ6BdqdGnKXQ0C6IxA03lGpRFaroO3P0HjUY0qpCoN1lqs
         O2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699439466; x=1700044266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkbdBisJ/PG8hxDlR5ZTMvNYc0Onf1/wmRPSUcltkmk=;
        b=f7Uc022pCvZEQL9t+pF5waHvTI8J2tHvy6rNP8Fnu0y6uun6ZHjyJc1NsObmHXtj4x
         30eWFzJdpZH23phZmbWoKfueqzUCpp9wZuZySoPcBh+2JFEwMnM6UXtjA2G7vNP6FfrJ
         +BxlNqQP2p4D06qN3RNI7y0dAQMwgYyN5e6Vo1Iy/aWoxFdoCUjrnAjcQ9YCvytqaOFv
         QtLCtrPRsGI8YHDlq9lzowBscCxy476m5cqV7ZSfUZqamtZ3nCH4umWSulqRZ3YfGOV9
         3hy5kwChFRSlPNBdBVGspp91Vp3cFCD96vt659e0Pdl5DFffueZxGr4fHPkY1ZH/aVi1
         bo4g==
X-Gm-Message-State: AOJu0YzFKKkyw6/VHE6RdXzeKuhv9WQH8JwQMd+bRpomoAktVr0B/F1u
        9SwhCH4RS1M9npLllCOB3mdv2ATe+O3QoEU=
X-Google-Smtp-Source: AGHT+IHiOejIJB4j/kMYXEAKBS0CqfRXqP6xxVZUu/o248ye6eosevondyHOb53GUXWo9jGNKcFm8W9c1/Efo7o=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:b011:0:b0:2bc:b74e:b4a1 with SMTP id
 y17-20020a2eb011000000b002bcb74eb4a1mr10314ljk.7.1699439466457; Wed, 08 Nov
 2023 02:31:06 -0800 (PST)
Date:   Wed,  8 Nov 2023 10:31:03 +0000
In-Reply-To: <B4D1A3E2-1AD9-434A-90AC-8D33532D4A1B@kloenk.de>
Mime-Version: 1.0
References: <B4D1A3E2-1AD9-434A-90AC-8D33532D4A1B@kloenk.de>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108103103.524922-1-aliceryhl@google.com>
Subject: Re: [PATCH RFC 02/20] rust_binder: add binderfs support to Rust binder
From:   Alice Ryhl <aliceryhl@google.com>
To:     me@kloenk.de
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org,
        cmllamas@google.com, gary@garyguo.net, gregkh@linuxfoundation.org,
        jeffv@google.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com,
        mattgilbride@google.com, mmaurer@google.com, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tkjos@android.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finn Behrens <finn@kloenk.de> writes:
> On 1 Nov 2023, at 19:01, Alice Ryhl wrote:
>> +macro_rules! decl_wrapper {
>> +    ($newname:ident, $wrapped:ty) => {
>> +        #[derive(Copy, Clone, Default)]
>> +        #[repr(transparent)]
>> +        pub(crate) struct $newname($wrapped);
>> +        // SAFETY: This macro is only used with types where this is ok.
> 
> Would it make sense so also annotade this safety requirement on the
> macro itself?
> 
> It is only file private, but could help not overlook it, when using for
> something new in the same file.

Sure, I can move the comment.

Alice

