Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE397BA2E3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbjJEPsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjJEPsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:48:06 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235A826A43;
        Thu,  5 Oct 2023 05:31:52 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59e88a28b98so8503987b3.1;
        Thu, 05 Oct 2023 05:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696509111; x=1697113911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xn7VVCSDyOglaO22IolgEibFcmi33m0Re01Fsy79xeo=;
        b=I4FsilavmmCTpDCTgMfF3p/yMtgDuM18war9y2ZCNHLBDNedp/jd2G8KVKMVlk5wJt
         St4DNN8IMBb565E/+uirxP7I8teQJIaSDE2SXr3xagN/8jjOJeLPMjEhAPm9zk25evHd
         CoZfuQPI/ffIVnj/FODudWrUFmBdB1ygs63cTxot4IjadSMHGnK+N4po4K3qnXv5GsZM
         5vri5tgKZWr154reT80xHyVts8NrfKxUD3qwnDXXy/niTXSEuHzxc2uuwbWFvW1bH0+8
         7PtQwjrLtbmbJ+KT56PQf0IY8mAKoWtqie4IS2zcp+w7OY6NpvQVglbJoUCSsV5xwoa/
         4jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696509111; x=1697113911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xn7VVCSDyOglaO22IolgEibFcmi33m0Re01Fsy79xeo=;
        b=YDx9pOMZ4Hb4vxWr5LHHcosKS02mE5pGkUgOrRUy3LaGOOXUpvxjg2ehmAiJ7NmvBj
         bpnhPDhsfQ0QqabFjeC4q5mrHgV7V1frvCWJlAz+m+I5B3Y6a5WAZ2vHyei1+pgoWeSW
         ERaa357m/DIfed16XGUpZjtOWVHAgBvqEePx2IzKtxjUBQsJW98jAXUQjbTYHdtm6kdc
         R5LX74KK9RvN1VLOh6CIzwObakwcQ51RohJm19PMDbsbv4OHFz2J93RGw9fPWz65GH+c
         CKrVDrC5xLTSpaJGmrFk6cIhrlrIvrtUcivDCHlpbyX7BVQTiUc4qr/oG33SuG0eKI08
         WQEQ==
X-Gm-Message-State: AOJu0YxgERUuII/LBnOLPWi53TRDmGUKZrNixxdKWls2qxLZQqARPtTn
        VkTUo8E9j5LKN91pjdjhlpiGUhSoilmytOWMBGwLH5alLZGK5A==
X-Google-Smtp-Source: AGHT+IFJBlZvtG/mUg81VTlKsyGpl8FT/mxlBMcyuccmpQZtTUd9bGVCv1OiYr8WCRX2hzrEA3yQd327RdEJHO9bJQg=
X-Received: by 2002:a81:6dd1:0:b0:5a5:740:1f8b with SMTP id
 i200-20020a816dd1000000b005a507401f8bmr2066155ywc.16.1696509111311; Thu, 05
 Oct 2023 05:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230823160244.188033-1-ojeda@kernel.org>
In-Reply-To: <20230823160244.188033-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 5 Oct 2023 14:31:40 +0200
Message-ID: <CANiq72=XFeyfS11KxVj8hJA80nQJixUm_diMcKAY9i6NBkBVng@mail.gmail.com>
Subject: Re: [PATCH 0/2] Rust 1.72.0 upgrade
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 6:02=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> This is the third upgrade to the Rust toolchain since the initial Rust
> merge, from 1.71.1 to 1.72.0 (i.e. the latest, to be released tomorrow).
>
> Please see the main patch message for a long explanation of the upgrade,
> the policy for future upgrades and some indications on how to easily
> review this.
>
> The series is based on `rust-next`.

Applied to `rust-next`, using 1.72.1 instead of .0 (no changes
otherwise, i.e. in `alloc`) and reworded to mention that we were
hitting the bug with debug assertions enabled.

Thanks everyone!

Cheers,
Miguel
