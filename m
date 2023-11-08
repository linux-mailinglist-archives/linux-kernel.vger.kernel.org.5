Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482097E5352
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbjKHK2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbjKHK2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:28:08 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34EA1BE1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:28:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso8085078276.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699439285; x=1700044085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dmEF9KgvpntqTBvjCTWhDldYUYFHQAMggDdqztH2Wc=;
        b=TQAor+XEv2LFsn339Lcs7LWSwQKyP7gnH2I/k09rWqFC5tNgCVgutBrxOj7scKiv9w
         +57TWEJqNPbnLwhGiFyBpwFAhk2DVwMNQodPplPFafvfToyM/94AS6YsLsPrDw4/NXy2
         GmNm8a+eHJkmhoFEKUbQJpXdCDVWiIsRA4yKWt4cMArG717yxVt7DixcI8RItr2Raltd
         95xXJeMVNKWYDzNciuwhG7fUZC7xqMUEzX9OVd/WU8wmJa3rvA0aALqJYH5R8TKsFFO+
         qZo4l0r7GjaL+ARHfdhLaVHB5Dn6fwDjOOK7HDsJJlzSuEypncYwtJRsvY9nFnD1qSGU
         GLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699439285; x=1700044085;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4dmEF9KgvpntqTBvjCTWhDldYUYFHQAMggDdqztH2Wc=;
        b=Scq7Vuqz3wNGc2Upc9CCEIyjQYF6ry3zn1xm0WDzM91xQI6SkRbRr+JbLqIq81MmhX
         2O1fGHGbykevVvtNkm7jPRiuAIpa2IhSTzY58unuWJublrrZMC/PXT4gJYQi+MSl55x3
         zGCHl/v8GzTpBb5tDxy83Axhv6CDozMpxxEma94p4BsEmy1CETSwCVoD5UeG+Wu6jAq/
         nvA4VV1leECfGa/WNNTGZpP29O0PRcL0+JQNVpcOd2MjdKwlX84XZgGnf77HX+ei3jkx
         2blJYXdXc76TCO1nTCiV4oCsne2UnHY5n11ds+fp58k4+ImgWQooNuutjTmrzkCkHMr1
         PaAg==
X-Gm-Message-State: AOJu0YzFPIIhIhU4GAj3crYfbq//yvXiLgAe5oB2d7CTZAEKKVGwMSar
        DPn9k3GGVndfc0BCs8WtdZQiogz456+ojts=
X-Google-Smtp-Source: AGHT+IHt5WjeCeluDG1SOFpGWvs5KwA+RL4PbrKOZxBxBzTct7ckZ/yTqt7rDoR7F4KiNF+lnIGbFLM9+gIveO0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:292:b0:dae:292e:68de with SMTP
 id v18-20020a056902029200b00dae292e68demr22560ybh.6.1699439284903; Wed, 08
 Nov 2023 02:28:04 -0800 (PST)
Date:   Wed,  8 Nov 2023 10:27:59 +0000
In-Reply-To: <62F430CC-9980-4779-9D43-7D561D322C9B@kloenk.de>
Mime-Version: 1.0
References: <62F430CC-9980-4779-9D43-7D561D322C9B@kloenk.de>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108102802.524151-1-aliceryhl@google.com>
Subject: Re: [PATCH RFC 03/20] rust_binder: add threading support
From:   Alice Ryhl <aliceryhl@google.com>
To:     finn@kloenk.de
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finn Behrens <finn@kloenk.de> writes:
> On 1 Nov 2023, at 19:01, Alice Ryhl wrote:
>> diff --git a/drivers/android/error.rs b/drivers/android/error.rs
>> new file mode 100644
>> index 000000000000..41fc4347ab55
>> --- /dev/null
>> +++ b/drivers/android/error.rs
>> +
>> +impl core::fmt::Debug for BinderError {
>> +    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Resul=
t {
>> +        match self.reply {
>> +            BR_FAILED_REPLY =3D> match self.source.as_ref() {
>> +                Some(source) =3D> f
>> +                    .debug_struct("BR_FAILED_REPLY")
>> +                    .field("source", source)
>> +                    .finish(),
>> +                None =3D> f.pad("BR_FAILED_REPLY"),
>> +            },
>> +            BR_DEAD_REPLY =3D> f.pad("BR_DEAD_REPLY"),
>> +            BR_TRANSACTION_COMPLETE =3D> f.pad("BR_TRANSACTION_COMPLETE=
"),
>> +            _ =3D> f
>> +                .debug_struct("BinderError")
>> +                .field("reply", &self.reply)
>> +                .finish(),
>> +        }
>> +    }
>> +}
>=20
> Renaming the debug_struct itself feels like it will make it harder to
> find later, as I would expect that a debug implementation names the
> struct its from.
>=20
> Also this has the fallback in CamelCase and all defined cases as
> SCREAMING_SNAKE_CASE. Maybe rather in the defined cases something like
> f.debug_struct(=E2=80=98BinderError=E2=80=99).field(=E2=80=98reply=E2=80=
=99, =E2=80=9Cname=E2=80=9D)?

Yeah, you're right. I'll improve the debug formatting. Thanks for the
suggestion.

Alice

