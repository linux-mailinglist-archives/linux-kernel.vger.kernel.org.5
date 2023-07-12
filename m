Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41641750EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjGLQhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjGLQhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:37:21 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734E01BF2;
        Wed, 12 Jul 2023 09:37:09 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b8b6f7399aso6177024a34.1;
        Wed, 12 Jul 2023 09:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689179828; x=1691771828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmKyOnNmUTgEJLuCWcdcYvSh4JHTJkDxRam3/lA8n28=;
        b=sq9fjSOdWsLlfQWyRmcEifnlqGQn9TpJbxNtbNHmAgHbMAEvEy9Zxfc84ukbvefysE
         Sg+7pFP5xIeg1me6sGQEx0SSFScQc85gl2kLGOqKCEkch3sZnfuR9rWwxvQ/mSuDZMmt
         1vBfSU2Tk1ttFA8Vgvs3NAaZa0itPPJXiwkiDupi76msNB/rBE5ozMXbr/tJDYu0ajo2
         OPw5O9KMZLY0EPnmV+a7J2dMPeVWnlw0gR5baIyR8vpthW3yzHTtbjJtprZD6Iq7MJLU
         9HDUfGDWrj0zX5vcQzFQyJCG5Z2AAf8ITRMC/cpqc6i6dTWq0nbwxcxlsrv5EFAZDzzR
         TdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689179828; x=1691771828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmKyOnNmUTgEJLuCWcdcYvSh4JHTJkDxRam3/lA8n28=;
        b=eLGCb5uubLkOnEDaWgdYCTGtOIHqI0qU8JyVvWQw6AX4dkk8u6c2cNWn2wmogKtN8i
         YMv0tO5EoTcLb4vczxZoVetUdt4NJeR24clWj5LYk3B6onqq9qQ4b4gUqGD+/kyUYPtF
         9exTrgfo4VPMDnuM0tRIC0NJD+ztsqAT5DU9uO6X1sM78+YTYR3DN6pZAYl+uDXJ9ggH
         /r2e3YFlucCVZkFPFSQVGlqYIUR53D/3pu106l5sQWNPWgFqpwi88iW0XjBjQwfFRTu6
         3WoxMhFZ1d4QfG7yQuwLE+xgh1RKqC4a9fkM7LVCGRA/8AK8MBHOHTXTDotv1I6FXeUi
         1+Hg==
X-Gm-Message-State: ABy/qLbITUBjptZXP2tXxGkRFpCUG6wnRsfc1fBm895LUfaC3ku4hid+
        dYCVwNaSKZAV9NmQma5Q/LFVL0ZRt+G/43j1mYU=
X-Google-Smtp-Source: APBJJlEX/fKsBhslCfhWuK6jrdf/dbfJerv3ymjaUsU9DvA6tIoxIM2iPjeZ42d/Pudpe5i/v77731CUHtnc3RNt8WY=
X-Received: by 2002:a9d:7445:0:b0:6b9:a399:85b3 with SMTP id
 p5-20020a9d7445000000b006b9a39985b3mr1764729otk.34.1689179828673; Wed, 12 Jul
 2023 09:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230711093303.1433770-1-aliceryhl@google.com>
 <ZK3VEPeBEyErmerR@slm.duckdns.org> <CANiq72nktgf_j-+S7snysQgwqeqB12sfjc-vrLsnOUKiZZ5WJw@mail.gmail.com>
 <ZK3zj4xPBD0NfaxM@slm.duckdns.org>
In-Reply-To: <ZK3zj4xPBD0NfaxM@slm.duckdns.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 12 Jul 2023 18:36:57 +0200
Message-ID: <CANiq72mBNS7Vswn+3oLEB_Lj_TrWLY2HK2z9va-OBDpztywjeQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] rust: workqueue: add bindings for the workqueue
To:     Tejun Heo <tj@kernel.org>
Cc:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

On Wed, Jul 12, 2023 at 2:28=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> It's not a lot of overhead for me but I'm also not sure whether I can be
> actually useful. Once folks are happy with it, I can create a separate
> branch for this series in the wq tree so that others can easily pull from
> it. Let's see how that goes and if my involvement turns out to be pointle=
ss
> we can route future changes through the rust tree.

Sounds good, thanks! (and the branch would indeed be very good, in
case we/someone need it in the Rust tree this cycle too).

Cheers,
Miguel
