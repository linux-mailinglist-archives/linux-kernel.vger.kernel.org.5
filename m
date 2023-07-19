Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505A5759F21
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGST74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGST7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:59:54 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDE492;
        Wed, 19 Jul 2023 12:59:53 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-c5e76dfcc36so20131276.2;
        Wed, 19 Jul 2023 12:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689796792; x=1690401592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhGkLnb0BHzR8ifaS0iX+zOZwyIqP+vtxrbbFoMqW0Q=;
        b=JKNSYXI1/54IBNNsNlecAisVFUPbQNj7KIHpnOriDx4zEwls2e1hEUeHIgWHU8IMf4
         uoz+y0jxyh69tAJGsYAVSaIjBm5ySEi5HFvHKe9jLvygu8tDS35IP8AMt9quMma0VPsA
         /LodK2D7LhqdG+KJgi4Epi+3sm2FVQCtkfjfd0/H+iT3Jn9tJ6VWiSCyShCSkoFIsQ8T
         Au2DNNyQ2Av42cuJD7LyHqcOSNra3OVzAhiFEQ/+X5oFz3y5zBMzI0aQm5dXJAW7atuT
         eP3UCeQ4hwDy1S4NrReQsppcySf8Kkl+yIC3Ods2I5TxXwMKBkNs1Yr4r8N6pQX+L5US
         /Qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689796792; x=1690401592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhGkLnb0BHzR8ifaS0iX+zOZwyIqP+vtxrbbFoMqW0Q=;
        b=RwTe6gWB2gMFxhos1KLj6allos1jcKMsn4v8mqSYeKvyNQ9i/+k6KOFJztLdfKQQcj
         fQXSIn8flDNG0yfyo19pPSkxZS2Lf4F7icIshPgCopBJCawAinUjiBJpM0fOilCe3MTU
         f39uw6cMQvJJlU0q4/CiZDQwki1E+iBN378s6/gOWibbp8FouwAsroIdzUNZ5ggUzxFm
         DCpnHFShhjRgIusv8rcx5uIn/u3tT9NjtXgkzVdnMrTwxP4W/9mc3TR4Xs7WVwVjbJ9w
         VUTLa8mBEH+QqpX/fcHjGzyjUQ9vmbVuCvnKiptya+Y6Gry6xRdPHG1ny+Zx+3qaGiL2
         y+LQ==
X-Gm-Message-State: ABy/qLYZTs2DbzZ+BFVQWEAZmOl/1yOjQN0RVRicQ7N58I/M+QbFPJS6
        vzKo4l9kMVK8iGeTK3dL97Oii8LDAgKWmeDQzn8=
X-Google-Smtp-Source: APBJJlFOmtt+UYtMLCKHck2hcCmEs584GfZZQ772aqCwtf6V0ROgYZ4W6k8zkNiMCSHIQN2IP08Z/Ar01WRDgTXL7Zo=
X-Received: by 2002:a25:694f:0:b0:bfe:a882:c8ce with SMTP id
 e76-20020a25694f000000b00bfea882c8cemr3340740ybc.5.1689796792566; Wed, 19 Jul
 2023 12:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72n-swO1L1zsPNDz=ZMMm=Ox5MOJHzXBbxgX0f_vWFWDmg@mail.gmail.com>
 <20230509202314.8248-1-ben.gooding.dev@gmail.com>
In-Reply-To: <20230509202314.8248-1-ben.gooding.dev@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 19 Jul 2023 21:59:41 +0200
Message-ID: <CANiq72n=xpvTd-mxN30hb36WXyQJ=dRkKk7-LrM_Htsvpr-59A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: lock: Add intra-doc links to the Backend trait
To:     Ben Gooding <ben.gooding.dev@gmail.com>
Cc:     alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        yakoyoku@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 10:24=E2=80=AFPM Ben Gooding <ben.gooding.dev@gmail.=
com> wrote:
>
> Add missing intra-doc links to the Backend trait to make navigating the
> documentation easier.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/94625fe6-b87a-a8f0-5b2a-a815=
2d5f7436@proton.me/
> Link: https://github.com/Rust-for-Linux/linux/issues/1001
> Signed-off-by: Ben Gooding <ben.gooding.dev@gmail.com>

Applied to `rust-next` -- thanks!

Cheers,
Miguel
