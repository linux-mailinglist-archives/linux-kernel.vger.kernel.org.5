Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F088008E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378413AbjLAKsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378395AbjLAKs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:48:29 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9214610FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:48:35 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-50bc961b435so1927110e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 02:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701427714; x=1702032514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3BDjvfSfgdlHtcZ8hZz7EmYheIAAA3/9++NHU5PhyfI=;
        b=sxA3i1Chktm3tCfmpZuR6EOYjQm3xstwFoUilO54Kl/cjp7pWByFTIijDNMQuF4Y+5
         rGy778iYi8e5UnoZPTD6doM2FB9rEL07USlqL0S8iQ/gut0+soyY7ocQkbLxZow1YRDd
         dCCUxnX1FMF2mch+eKJblwTjtSp54fF/eiX+fycLdzDpHf7JlLUgK25lkAqtQmJdQCMq
         g0PA7ObPTdWlf6YeDAJ3Itys63Gi8Hy8lYRhPJUi/8ewQ+WLEkW36+0Na3jUe4AkJQ5w
         c921+6+Fs9vLHZGnBKBXCdAz631n0M7OaCkDhhzarZcMatqSbcLMgOXdlH6KCmtXRf43
         EVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701427714; x=1702032514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BDjvfSfgdlHtcZ8hZz7EmYheIAAA3/9++NHU5PhyfI=;
        b=rOkPgGjqsMlsK5ijmoyVdinf9ZMIivWkZ7kvDxYfVlvPiTFJ0Cs3FUrc4SoEpwrmlK
         ACT2X6GUgbhZ1XV9VncIev+IN5/bbytgQ3SMEXMxEA8dRmVNylWAQZKTMJzvQRuEE9E5
         hSEXhEUkcI/4D+4aupLL8wtTVBiHrxzTBESQmxuXjVVHe193vpf/rLlyN746KbWLxDdN
         TH1xmldF8ZJPlBeNSM46/Je4g6RK2Ve0dTtQbAWzN1CGDNIhRK/Tmmp7OWOpI5KdVmKs
         cAQZ3t6rgN+PF5+ibN/LQQK3KhUxsuSK4g3BouhaTkz5hfeyFcdI7Iztw0Gwj/2XUOyL
         96yA==
X-Gm-Message-State: AOJu0YyfDiPpH3NLFO0egb06uwlbnkCbLGrxpC18XE1fqIjZ7UrSXCdq
        SiPXFBjLub+dZsHWKwogeun2wLWVeydHO00=
X-Google-Smtp-Source: AGHT+IEzi61X/M3D+na0c/GNtZpLFB3jhENpvRbleN1ckp3ofjr0vhqRpfSfnFgflMyTtYcH8dFy9dp2febKZio=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:15a6:b0:505:7ae3:182f with SMTP
 id bp38-20020a05651215a600b005057ae3182fmr37944lfb.12.1701427713791; Fri, 01
 Dec 2023 02:48:33 -0800 (PST)
Date:   Fri,  1 Dec 2023 10:48:31 +0000
In-Reply-To: <qwxqEq_l1jj3cAKSEh7gBZCUyBGCDmThdz6JJIQiFVl94ASI4yyNB6956XLrsQXnE4ulo48QRMaKPjgt7JZoolisVEiGOUP7IyRdecdhXqw=@proton.me>
Mime-Version: 1.0
References: <qwxqEq_l1jj3cAKSEh7gBZCUyBGCDmThdz6JJIQiFVl94ASI4yyNB6956XLrsQXnE4ulo48QRMaKPjgt7JZoolisVEiGOUP7IyRdecdhXqw=@proton.me>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201104831.2195715-1-aliceryhl@google.com>
Subject: Re: [PATCH 3/7] rust: security: add abstraction for secctx
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com,
        dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org,
        peterz@infradead.org, rust-for-linux@vger.kernel.org,
        surenb@google.com, tglx@linutronix.de, tkjos@android.com,
        viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
> On 11/29/23 14:11, Alice Ryhl wrote:
>> +    /// Returns the bytes for this security context.
>> +    pub fn as_bytes(&self) -> &[u8] {
>> +        let mut ptr = self.secdata;
>> +        if ptr.is_null() {
>> +            // Many C APIs will use null pointers for strings of length zero, but
> 
> I would just write that the secctx API uses null pointers to denote a
> string of length zero.

I don't actually know whether it can ever be null, I just wanted to stay
on the safe side.

>> +            // `slice::from_raw_parts` doesn't allow the pointer to be null even if the length is
>> +            // zero. Replace the pointer with a dangling but non-null pointer in this case.
>> +            debug_assert_eq!(self.seclen, 0);
> 
> I am feeling a bit uncomfortable with this, why can't we just return
> an empty slice in this case?

I can do that, but to be clear, what I'm doing here is also definitely
okay.

Alice
