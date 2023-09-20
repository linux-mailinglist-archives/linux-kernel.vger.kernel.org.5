Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536837A8CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjITTUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjITTUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:20:42 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CCBC6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:20:36 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1dc6198196aso109733fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237636; x=1695842436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=If46QP9d8l381wsF7wC31HKGx8UjNCO5MTSh1mx6aNQ=;
        b=F9zalqoUesNuqC+uY/KdZXnoE17Je1tIkbGivKPXULOaG6mLWXrvOU9NZvMcsoTYIC
         gIi3s5N6qLtxAey6KF0s15QQ9uyV0WfygkAAPwO2cL6d9DKSZJv+iuvOmbypeXqIUfjB
         8aZOz9fw5QgzFVAe+ODMt7UIBfkvV5/I/JxAbJd6yztGVP9mqmDJyGD+jtOLqnhF90ZK
         O55ek6P4n4/7qi9nQsXQcEBza/sAiRdJGpiM7QiMrIgyOhfMZ8fQNyWtIOnrniqEQDJ5
         om+3r2OkEoAfVt9/qCiFA1lOx9R81XRerQLhS22xwuXK9tSgdUmQjzf4oEDTHAts4gbf
         ARgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237636; x=1695842436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=If46QP9d8l381wsF7wC31HKGx8UjNCO5MTSh1mx6aNQ=;
        b=ugPCd92VEoV98lq9mqLML2lgLNoMTeEzmz9CF9cIXW4xIN4Pb3XFk0PHYXaCQZ55rO
         IebGH15gB1XjV2n27WWgOPSfd+hZ3sZ1Otbq/bGJjhZ5Xuj8H5Ddw+qV9uz1EgfTZ/sD
         mAk0mpsJAewbVFXPuWLcSxdMAkvuLkg0k1f9dz3ScnzBLi+oIENno5iqrFPzHbaZZafz
         Jrv9izQ1vJMG8yGV6KA5TpNwXJr6LbIzcjfAa6WMjPO/9Daj09P9OtA54ZTj7Qw+lQHS
         1TmqZ7GvsgSiqifmyLT+I7QHEcbOddhvl90H1Aoidk3b8a0qATR9Vnr5iI4alcBNno+n
         Bzyg==
X-Gm-Message-State: AOJu0YzsUQy+wFqCZrf57IKI9rzzIO4BxAwX1qrQLHx28CPOnGHZlif+
        O827tp8ZxoLhrDdDOiwpinrXUcyYXSvtJTDSU4KBMS23
X-Google-Smtp-Source: AGHT+IFdpQwfHOBS6j2C3EYu7vt6NoGAQOM3IsyewUBEL+Yw6mhYdbCnMZ1y3reIG6SXwIO+FcNhrwB0wMvRSs52rBk=
X-Received: by 2002:a05:6871:588:b0:1d5:21f9:7272 with SMTP id
 u8-20020a056871058800b001d521f97272mr3616289oan.23.1695237635746; Wed, 20 Sep
 2023 12:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230628020657.957880-1-goldstein.w.n@gmail.com>
 <20230901222100.1027371-1-goldstein.w.n@gmail.com> <d4c6e6274bd14391a1e59f84f9ebce7a@AcuMS.aculab.com>
In-Reply-To: <d4c6e6274bd14391a1e59f84f9ebce7a@AcuMS.aculab.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 20 Sep 2023 14:20:24 -0500
Message-ID: <CAFUsyfLPLQBs2gQwLDUZHudQrkHSXCcV=Wi0=Znb3gChDZvX2Q@mail.gmail.com>
Subject: Re: x86/csum: Remove unnecessary odd handling
To:     David Laight <David.Laight@aculab.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 9:38=E2=80=AFAM David Laight <David.Laight@aculab.co=
m> wrote:
>
> From: Noah Goldstein
> > Sent: 01 September 2023 23:21
> ...
> > +     return add32_with_carry(temp64 >> 32, temp64 & 0xffffffff);
>
> The generic C alternative:
>         return (temp64 + ror64(temp64, 32)) >> 32;
> is the same number of instructions but might get
> better scheduling.
>
Sorry, I missed this.
Bright idea :)
Adding in new version + you reviewed by tag. Then hopefully this can
get in...

> The C version of csum_fold() from arc/include/asm/checksum.h
> is also better than the x86 asm version.
> (And also pretty much all the other architecture dependant
> copies.)
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>
