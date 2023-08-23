Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144BE785D45
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbjHWQ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbjHWQ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:29:21 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C662ECEE;
        Wed, 23 Aug 2023 09:29:19 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d71dd633f33so5717100276.2;
        Wed, 23 Aug 2023 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692808159; x=1693412959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYOBkiXt2eTfIYJjQM0YgBF2khTdFohVIOXVErVihjk=;
        b=CYJ4DSKFDevnRI443Wprq8v35etUqs07CW4zCEijN6edW3TBzE9Cyn+1+EoPumh9qy
         uAgro5CdS78mEOoSzvOdD3f3OVZKV4hc86kUPWliDDF9QeDtVfLx/smp8Q7YKppeRUhW
         sy+VQltLckxedMqrbr+288rJHy7EVj1y0V92+onlVmH99UlKtReznFmFatwAzIeNPebT
         wIFNgGqVNPpIKtSp/WpnPLhCKzHLtx0/JQeuSZ9/mUIUtgIuZ1UutKrnsg+deRUeJBPo
         5zZMLgYorJbfk2A7XxjuLSl57D78Kx8Yyn3ntsg/3/gP9hhj8wQPR8eX/ODV35jrMN4D
         StdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692808159; x=1693412959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYOBkiXt2eTfIYJjQM0YgBF2khTdFohVIOXVErVihjk=;
        b=ZuC9Gkvm8UpKjMfBpxGSYcA6YrrWNvioQYKhpxbiBw0g4eUvC8I2MZjNbjonpos/52
         uda18hsFWbKOPGYYHkpAZIMYoY/6Ay0FBrcvURtDK8sMZG50vmhRrB3TzA8Laz4vmgy0
         N7qCU66qSmmfoIPvGNSaWMcheDAHFS5Dm9/7zriQ40QRSylCULUoUY939YxlUhmfxJ0X
         54UxFLLaNhv6OfMmfah9JgERjmGKEhZSoadDlgtXNMeLd3+ea1Q7AMak2Sfq74NE0Rqv
         I4kw3cNhVPweVybuszkbKAf1AAY1kVUaVDIjSeYXoHgeH0s9sI6FlIa0XzwMjWDDB8k2
         e2yQ==
X-Gm-Message-State: AOJu0YyJKbHlpjFNvllpdxb2Rpb5EF5hNoC+MFg/IBn1Hw1AoPGAr9Jg
        fOabW297WPSHHp+IRLNeemMG+H88hnkbYKwoduc=
X-Google-Smtp-Source: AGHT+IE2shNFYWKN/z4YchTyTYDs8mGsssOz2BWJme5F8dMbpkchWuz4syBMX58lmUkV9QFQFHTa5bhZmjMv+KPFyHA=
X-Received: by 2002:a25:abeb:0:b0:d3f:2f1f:d34a with SMTP id
 v98-20020a25abeb000000b00d3f2f1fd34amr12872511ybi.26.1692808158953; Wed, 23
 Aug 2023 09:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230822162333.752217fa@canb.auug.org.au> <CANiq72=DA1A5YyrWAPHEr+by_pac4R0-GemurbLWYNrSAUNSzw@mail.gmail.com>
 <20230822222036.3462aa57@canb.auug.org.au> <CANiq72nvbkYQ0bPb0aRs0jNZGgFwg8TMek4b0n3jrgxd2X4h3A@mail.gmail.com>
 <c954b4aa-9bf7-9583-0b9d-05f33bb0a595@linuxfoundation.org>
In-Reply-To: <c954b4aa-9bf7-9583-0b9d-05f33bb0a595@linuxfoundation.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 23 Aug 2023 18:29:07 +0200
Message-ID: <CANiq72kwPbHDrR13EWdmWTevU4r9wJzp4exV5rS1x-tD0gh9DA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the kunit-next tree
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

Hi Shuah,

On Wed, Aug 23, 2023 at 6:08=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> Is there anything I need to do on my end when I send kunit pull
> request?

On our pull I will let Linus know about the conflict -- perhaps you
can point him to our PR if yours goes out later (when are you sending
it? I was planning to send mine tomorrow) and/or you can tell him the
expected resolution or to look into `linux-next`'s resolution, which
looks good to me:

    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tre=
e/rust/kernel/init.rs?h=3Dnext-20230823#n529

Cheers,
Miguel
