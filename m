Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8907BD24B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 05:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345096AbjJIDEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 23:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345042AbjJIDEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 23:04:05 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED30A6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 20:04:03 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a1ec43870cso49935987b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 20:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696820642; x=1697425442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2a553ugT14gjtyNjW9GJo1PsSp2t+o25j6K104CIqPk=;
        b=R8xGukhiMZktIpz3teLsPIKTYDkTUYQj9ED/wpW+aOON8FXB+l88h931MxYjQEI/rr
         uuU3x+DuU2unty9tFbFqhc7bFhefZmPQ+4FB7y9F70LMa7YBAc/OGpPQO9jUKJTCtfsv
         WMKDemxbBQht4NDOqDK4ZGTlV/mqVh8/6sAKDbcFhEGOFMGqbsaxB1/ChzGdhvcCSk4z
         tQTtIqlM6SBarJ4MwmCwyJybormHIc1ldTT2CBtkReD7vl8mwLgMNki2uG0s2AsNPjm9
         dynpQ85r57T1iD00I/R2IAjTrqKfVeNc5q+rZTI7s684BgJTSco2ZTvF24/XahcYGST+
         8pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696820642; x=1697425442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2a553ugT14gjtyNjW9GJo1PsSp2t+o25j6K104CIqPk=;
        b=CGV8LMB8Eb9K5rMnWLmt+h0pVpOEqtRE0+lQLyhVNAuxwM2qPCoKe47tWQs8kDN8U9
         inFR3MwTP5DXIms9aXsugWtyNyHiQb5H2Jmk2dZXpnkuLR0NcJKlxpZfU2mxwy00ZMX+
         1hulgzkicW9B8NKsAL/tm3Dw1NIDFX99kP2lXYQBOFHp0/a4I4MhdHYwcDC6tsOw2gLe
         j8o2/WUH3UgsJwB7112Nd0pMiCiokGa/zMSQpkYIDFq0IqUm0TZfKIkYLEnPQcXrKti5
         KeMyaeSsOh0FO8XYGv1nH8Y/B3YWerP2DYmq8dFTtg4WJBDQhTJyYqUKqSwGDdbIdLjH
         Qi6A==
X-Gm-Message-State: AOJu0YxHk4ARWJmSzXHD+/IPRDA1Ya86h8eC7J4EbNBFLltCsRicbnAk
        cwZDlAlu32a783yTzijwehBCyljn3Tk0s+HciGhwWA==
X-Google-Smtp-Source: AGHT+IGm38cgjsXeOz4waMlzo48yKVI+uickgE8vzurAuKu/TBgRk0fD1VLhqMfXvURX1bzd3NFVtl8FN3kY3OGaNHg=
X-Received: by 2002:a05:690c:460e:b0:5a5:eb:f51f with SMTP id
 gw14-20020a05690c460e00b005a500ebf51fmr11554915ywb.29.1696820642761; Sun, 08
 Oct 2023 20:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231008094816.320424-1-tmgross@umich.edu> <8a6a2133-92a0-4478-8f3a-e1c7ba38ff18@gmail.com>
In-Reply-To: <8a6a2133-92a0-4478-8f3a-e1c7ba38ff18@gmail.com>
From:   Trevor Gross <tmgross@umich.edu>
Date:   Sun, 8 Oct 2023 23:03:50 -0400
Message-ID: <CALNs47vj=whnF1FcmmXHz=msB2j=GAnrnwx-OKHciW6iR+GUMw@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: update 'paste!' macro to accept string literals
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 8:27=E2=80=AFAM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> Next time I think you should put this in `Fixes:`.
>
> > [...]
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
>

Good point, thanks! I'll add that if there is a v2 (or Miguel can
probably add it if not)
