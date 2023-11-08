Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CAD7E538C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344348AbjKHKm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344335AbjKHKmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:42:24 -0500
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1E11BD8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:42:22 -0800 (PST)
Received: by mail-lf1-x149.google.com with SMTP id 2adb3069b0e04-50985abb63eso1066708e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699440141; x=1700044941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQH+j/QSCCrpDgYqCyOzAk5c+h/nVFiuOw7/pOXGj/Q=;
        b=KlP4Ae/uQHoe/jWuQz/73BpkF9kLYRY5TcP+fmx7OqmzbJiRtQRiHlXb6EKKryje4j
         kC8iAtLha4agWtCtbnKaaTkzb+sjWniWXhZW1PZGz/8ofks2Cs3mjDUtHV6eYUS3lxUg
         uAJ4AJ2sKW3ckZ7Iqy+B/OgQ+ntkOexpq/Hl8wvipYyaHnfg7vnXcQY0SaqBTBZzbKyv
         SxnEymlOfgFzOpGi6zpOvux341+dNkkEtrzgu+3dHvG0cVbk34P0+afrNTyqpznjvLBK
         OhxnWNph2bIyx9Hu7ibCFx0MD9Vo8eFUzhHg+iHnqmjNGvADNkKPgJkcspLWsbchkxsC
         1vCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440141; x=1700044941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQH+j/QSCCrpDgYqCyOzAk5c+h/nVFiuOw7/pOXGj/Q=;
        b=mHQ0T5G+yB32aamXJK0CC+Og729co6rnSJMFbW+PcBYaIZPco309irBw2xeCqk8O0d
         4nYFRhu75O6NOAQrLbfOfLB/9HdrII4Fs1j6hSWZpa1OXa0+9Sir/cjHvhTDoGPgiBRe
         c5ujcLPOFrwX/NT5o0bxSe1B5zfQbjMEH3vkk8BADk7olFLW5k0uaIUCGjnkwe61v1EF
         AxB44XMTHleJb99Pabx4L7/1kXjgd/qIL0Y7Gsa1aVRkcU9FN+DUovfcLIL+KJO52TTu
         5z9W2TU+GmYY+UXXsVQel2By/+2QLOdpqHQgsx70z4kO3vgxyahgcGskrGe8Imb1/P0B
         eJXQ==
X-Gm-Message-State: AOJu0Yw+UbE0GeuJPW076jVLTS+ZGfw2fD8cfryhXy/l4PA87b22XtDf
        KXx9jhbpGag30M9MwTxgh+hbmXI9woyIEA0=
X-Google-Smtp-Source: AGHT+IFGFmAQ6/yq8JKqx80lksqY1Gqdf4HF789jU/G56yLAr/6PJvXS68fpeR9Vi4z2+6Kyiv6nXxA57tdMqbk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:2036:b0:509:4ad6:95f6 with SMTP
 id s22-20020a056512203600b005094ad695f6mr6988lfs.9.1699440140861; Wed, 08 Nov
 2023 02:42:20 -0800 (PST)
Date:   Wed,  8 Nov 2023 10:42:18 +0000
In-Reply-To: <2023110124-enunciate-hypnotize-2ae9@gregkh>
Mime-Version: 1.0
References: <2023110124-enunciate-hypnotize-2ae9@gregkh>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108104218.527321-1-aliceryhl@google.com>
Subject: Re: [PATCH RFC 02/20] rust_binder: add binderfs support to Rust binder
From:   Alice Ryhl <aliceryhl@google.com>
To:     gregkh@linuxfoundation.org
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org,
        cmllamas@google.com, gary@garyguo.net, jeffv@google.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        maco@android.com, mattgilbride@google.com, mmaurer@google.com,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        surenb@google.com, tkjos@android.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Wed, Nov 01, 2023 at 06:01:32PM +0000, Alice Ryhl wrote:
>> +config ANDROID_BINDERFS_RUST
>> +	bool "Android Binderfs filesystem in Rust"
>> +	depends on ANDROID_BINDER_IPC_RUST
>> +	default n
> 
> Nit, the default is always 'n', so no need for this line.

Got it. I'll remove it.

> Also, it's the middle of the merge window, many of us are busy with
> other things and can't review new code until a few weeks from now,
> sorry.

That's fine. I had hoped to send it earlier to avoid this, but we wanted
performance numbers from real hardware instead of just from an emulator,
which delayed it.

Alice

