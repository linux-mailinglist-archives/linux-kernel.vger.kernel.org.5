Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C52580E73D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346234AbjLLJT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346233AbjLLJTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:19:22 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9D1D5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:19:27 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4649daf0dd4so1483825137.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702372767; x=1702977567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1+sprVV2T7W4J6YbeGw0M4DLw9yLV+04VHxcEgbiHE=;
        b=VF6MStIi4ne9C5OIscvkHbVrlu2pO8w22M+lO9Whw+alY9qC+AvpQb1GV5w0ETBfLO
         zvBJlC+7uDFdiwv2QHZ6pDztMu+OEJhUIOP3+C5CcIVMhjPOXJByhtM+wFTYmIAVzXWe
         AnqOfhNr0vxPUa4csT5LoUDIqZjbwWs4yBWWA+rRyN1wEgxVn6pcJFS7wt4GkT3ORaRO
         bcV1cxlcQxCgF0Ywk83fIB0ZZ+zanmWesREVqrITIx9j8CWhGNdJjDoyVXzP0DOLR1j1
         RhsOSb6RiP/TU7VUD8hYva/b4FC1Vy4YOxOlPl7TPgl9m0vU6WK397MuGFWkY1ANptn9
         pG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702372767; x=1702977567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1+sprVV2T7W4J6YbeGw0M4DLw9yLV+04VHxcEgbiHE=;
        b=WsGFgx/4TjZ/g7U8T3oM+E5RLga9EUIuAnh3f8TB7+fBKB2q6ObfpUAb3qnoFt85vB
         tt0uMKE6B/o1ntvUHFGrTEBuDsUEQOqmVVZYPK+RbicymvUGigIkc4kbexqNzd33F5eU
         EmgoPU7qPBz+KGLH3K80Y7tQhTtvLFZoM/afXYGweNKpbQiRKndyGP/dLRj0KNtFNxl0
         2e7KUPiN5IVHRF68Twdq2kR0DpMsL5K8Lpc9EnVQNwC8q/42CEHbgcreDhDEQzXJdOgE
         Ow0UDPwm6A9y2LJKXZvqeBV6R2A0Jpr97pz/CBadD+fu5E9m5Tpbvpst/QrAGIEkpXU+
         nQyQ==
X-Gm-Message-State: AOJu0YxX5AEfDEYIiDvmb8agecQllC6eTJHZZeElN0wrYh9pixfDh9Pn
        4gaWtSAMiKguNbM0ONvTyF4sKqUYuntjI1z2usjjW4YUQn2DHTutxMJG5Q==
X-Google-Smtp-Source: AGHT+IFqJB+r/gsMDbV2/WNS19JFr7F48BtZl+nyDy6AprTKQgrh4j3tEOIOJLL8ULgjzuUOsYiiDE0CKLWUr5C+7vQ=
X-Received: by 2002:a05:6102:4429:b0:462:e85b:b812 with SMTP id
 df41-20020a056102442900b00462e85bb812mr3950134vsb.24.1702372765514; Tue, 12
 Dec 2023 01:19:25 -0800 (PST)
MIME-Version: 1.0
References: <e2b943eca92abebbf035447b3569f09a7176c770.1702366951.git.viresh.kumar@linaro.org>
In-Reply-To: <e2b943eca92abebbf035447b3569f09a7176c770.1702366951.git.viresh.kumar@linaro.org>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Tue, 12 Dec 2023 10:19:14 +0100
Message-ID: <CAH5fLggpyxJfPFvtYuShKnT0mjcHViv7NQcBS7M--EK4jJHHRQ@mail.gmail.com>
Subject: Re: [PATCH V2] docs: rust: Clarify that 'rustup override' applies to
 build directory
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 8:43=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Rustup override is required to be set for the build directory and not
> necessarily the kernel source tree (unless the build directory is its
> subdir).
>
> Clarify the same in quick-start guide.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
