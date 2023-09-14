Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D5D7A0B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbjINRDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbjINRC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:02:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12511FE1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:02:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3C6C433C9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694710974;
        bh=dNvKVExAcL/+xsVdm/JTZl0sH/+jDBgpCJN7oIJgWk0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eTLrZoBvHzLb8opyX5RDTUJinZWC67A/h8gxiaS9PNNpqzuxUyiS/OhPBMkjy6ja/
         8BHaxNQdoj5KHkoyhcctU3pUxXxpSb/GtktJ/QqnESdvnLxO6FelK5cISxm7tLC1LU
         7gJA2VY2/RjNDCURlQ6OyRmCz6WzXcQiYTER10qtSsK7nU6ewRlOZB4k4QvzUbbEuG
         S+jCpyBJLwgrsvAgSSjQ/rV8elqtmVcGqjr/4fGv1+zzlKjGsTXvNeg17lURvgMGEu
         HJtt719KF/mrNPsHNcMYSLK51TFJdHQwYnus2/f3hr7uWNRJJtjbuRwGiR8QSF0OhM
         TnfQWfsTjoUhQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-502a4f33440so2017385e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:02:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YySkGLwxlli0JUEVuumgAO/ZWUDvwkqpDKubUhxwAR5oplQ/C4+
        ASnyLbfTMZqZPqiMFWWYnfccjYTcqEWtNqYT5yI=
X-Google-Smtp-Source: AGHT+IGw/eFibdqS75bKWCpJa37gsnsnifCwsJlCyAp5V7GZQe8BhXNYzITpDpDqdeTGQTy8AIuHJ7b5Z0M2SEojNyo=
X-Received: by 2002:a19:ca43:0:b0:4ff:aeef:b582 with SMTP id
 h3-20020a19ca43000000b004ffaeefb582mr4611968lfj.66.1694710972568; Thu, 14 Sep
 2023 10:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230908231244.1092614-1-song@kernel.org> <CAPhsuW5Xy_K=6u4s=pNAZ8+eGBtX8v16Fr+9quL-FftEu+DWOA@mail.gmail.com>
 <CAKwvOdk6FeQjbh7b5K4pps50HZa6Riw6o7huGKzYcHFk_R8MLg@mail.gmail.com>
In-Reply-To: <CAKwvOdk6FeQjbh7b5K4pps50HZa6Riw6o7huGKzYcHFk_R8MLg@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 14 Sep 2023 10:02:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5niOZwfc=aZcHNeWMU8OJnf9pcOgyXZpm289dQXfmOUA@mail.gmail.com>
Message-ID: <CAPhsuW5niOZwfc=aZcHNeWMU8OJnf9pcOgyXZpm289dQXfmOUA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/purgatory: Remove LTO flags
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        kexec@lists.infradead.org, x86@kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 9:34=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Sep 14, 2023 at 9:31=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> >
> > What would be the next step for this work? We hope to back port it
> > to our production kernel soon.
>
> Please send a v3 with the fixes tag updated.  I wouldn't mind if you
> added a comment to the commit message to the effect of:
>
> We could also add the use of an explicit linker script to rejoin
> .text.* sections back into .text.  Simply disable the production of
> more .text.* sections for now; -flto* implies -ffunction-sections.

Got it. I just sent v3 with these changes.

Thanks,
Song
