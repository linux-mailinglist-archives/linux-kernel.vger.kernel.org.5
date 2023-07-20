Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D4175AF32
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjGTNJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGTNJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:09:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67310269A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:09:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-579dd7e77f5so7542167b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689858557; x=1690463357;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URfFYme25baLr1pjIuGY05OV9hkL1kZ6iw1B9jJiYbQ=;
        b=F1G3kgAJMRCPvFvLCqBdv+xE6HqvaZGWiFw3zRdSvtXqFJplEV1kUadc60xdVwMnXY
         yg9K5YIzN8VUIXwyGhBPyb58shkiGB5lkFYcoxkfxIhI4RhyeUs5HA5rktribN1cW1x6
         VMUXrmNIKewfokNGJhSGvBnsQAbnUWn5/ryMC5GNNH9kXgbFMHnx0WShS0Uda32PvQ4o
         Ba+93DSCGje/0zbz9tYu2JAglOCpV0FwuuZiEx8ca51okjoiV+trPqjOmEcGdemYTe80
         rX+Jf6iAuWqS177gedZ4hAfQuINeN/RrX5izHYE50h4pbOGf5MktTyY+jpWfQ8ho1VbV
         Y+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689858557; x=1690463357;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=URfFYme25baLr1pjIuGY05OV9hkL1kZ6iw1B9jJiYbQ=;
        b=STl6TMokjK9DuudQ1SunXe8LMbpyShPEKhXBMMxb6U0sihqtuGetfgUp4A5Hq1Q5Pd
         ZuOP+Ym3RfXhUqEQijljEM2dHPQQk3Kkup5ghkBveYMRiCG71scsgT/EnsYhWmDYDwJ+
         xfoYb0RAHZmUhxrVEKF9EnMPeBy1n6I/EZMs7FF56ROKnJepqE4l1SChbPQRhC+7py8Y
         5j41UdZQ/LGn8JI3cRRoGYVG/pKssUgb39fmjr5ZEUqHnxqPLIexNBwq/f5GQ7KUrEgP
         wXfEG8/ndXhkTXkb7Aql5wJqeyjar7Nqc9jplEfnjpm3HjEKp6wX0IeE9WHrkI4AHHuc
         Qe7g==
X-Gm-Message-State: ABy/qLZLftaDNzEhuHz7pkh5uzOdOrzzb9XFkXxnwD383YZ0Av/EZHMr
        jJqWE4JUIrdQ2u7l85VDGGe05DPEsfT13eA=
X-Google-Smtp-Source: APBJJlGHH4ltUoNcMtMERBQVB1eY3JEqao0P6GUXo8NypCt2sNtKFSCkfmV87W2+owVqImszJvp06ud6yEhQ9ls=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:c545:0:b0:576:f3ee:4e67 with SMTP id
 o5-20020a81c545000000b00576f3ee4e67mr58729ywj.8.1689858557661; Thu, 20 Jul
 2023 06:09:17 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:09:01 +0000
In-Reply-To: <20230719141918.543938-2-benno.lossin@proton.me>
Mime-Version: 1.0
References: <20230719141918.543938-2-benno.lossin@proton.me>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720130905.3498563-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 01/12] rust: init: consolidate init macros
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, nmi@metaspace.dk, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
> Merges the implementations of `try_init!` and `try_pin_init!`. These two
> macros are very similar, but use different traits. The new macro
> `__init_internal!` that is now the implementation for both takes these
> traits as parameters.
>=20
> This change does not affect any users, as no public API has been
> changed, but it should simplify maintaining the init macros.
>=20
> Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
