Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A1B75AF6C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjGTNOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjGTNOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:14:09 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBD526A9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:14:08 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-98df34aa83aso227027066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689858846; x=1690463646;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhMVjqtIwF2Tg40Izhr6gVwHnvMnwEbvE1+ZYX4vm9k=;
        b=sG6iy6fk6l2JO5DIdNc9RKdBW7jkSQxC7vSIrItBwcUnSxvtReT2zFivjJESsG9U0Q
         +KoQUi9jWIuLo3y8blSy98nyF2TybbWPfYOZltpAkLnC2t339/ie3RigSxRTUqrnpVeX
         EjfE57s6bi0/lPDTm2J5H7Z4BRUAlATqYVlOCXG/c4JaqE3cI0Qkq8Dc2dGax7AiNlPf
         hJXBwXIoQjvpcraNFU80OKL4NQljnlUcaov9f412TG1GHzOUIdn84goT6AhF8oucxSOc
         tAS7CmjQJwIrYAaUe/kYjRr71K6VYRRhWzZ+Uap0ymxhI5YJmxO9J0PLgG4fOXjwPnU/
         ROfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689858846; x=1690463646;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JhMVjqtIwF2Tg40Izhr6gVwHnvMnwEbvE1+ZYX4vm9k=;
        b=DZ8YDU9pkqPBXjWXagPEnQUwj5nh1nsk9GKhzYtlJc9wKqdOqLghDuekHFglV/Tmtm
         NUhZPLS2P8oIVdeAtmKOEkGuwaCo98UXfz/gHC9TYyvXLCVT8NSaYaTasKzeKrKl3FWq
         Ll0x5svTxpiMorqwJEO08/O9lRYzCb3SzF/hYUJvannmqYxSuRye3ggLpAtAXZNBsP8O
         MIeN5CwtubNryOKxNqF3PJQt5q9JynsFvADJ/72mzblGNvnEpfma+AnxsMgcC7bagv4m
         F6XJILDhdizfimrbwmchCv3BXFYhY2q5mlUzAxejnRulCGdhghzLP4RGlm4qTSguClNO
         V8sQ==
X-Gm-Message-State: ABy/qLbGXZs+TJYbg3NGtbYBJdDy84vi2uxjtjChyw4iigQ5dGVD5QDy
        JsuwZbXR3PHyV502waQPXQCgezXEPbmYKMc=
X-Google-Smtp-Source: APBJJlFMYNs//wSeObOIq0zfhDnRSXJFZWaBMFtWrzro+oOu4bIgh3FqmmRSGo+395olj8nuUcbLhixsyOAwAFk=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:2da6:b0:99b:5a23:fbad with SMTP
 id gt38-20020a1709072da600b0099b5a23fbadmr4009ejc.4.1689858846507; Thu, 20
 Jul 2023 06:14:06 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:13:27 +0000
In-Reply-To: <20230719141918.543938-3-benno.lossin@proton.me>
Mime-Version: 1.0
References: <20230719141918.543938-3-benno.lossin@proton.me>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720131332.3541151-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 02/12] rust: add derive macro for `Zeroable`
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        lina@asahilina.net, linux-kernel@vger.kernel.org, nmi@metaspace.dk,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
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
> Add a derive proc-macro for the `Zeroable` trait. The macro supports
> structs where every field implements the `Zeroable` trait. This way
> `unsafe` implementations can be avoided.
>=20
> The macro is split into two parts:
> - a proc-macro to parse generics into impl and ty generics,
> - a declarative macro that expands to the impl block.
>=20
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
