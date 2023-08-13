Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ACB77AE49
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 00:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjHMWbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 18:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjHMWbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 18:31:04 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A7D19F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 15:31:03 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-64712741d5cso4446506d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691965863; x=1692570663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMVqnKBxPcvgxex5yREEzCdHkXMG/1zXpKWPkS53ozo=;
        b=QBZ4XZ0VjcVjyw0vaFR/4sK3swNaiyF9bDgKxrKNQiylo8rJMey14mK9aRPd3d6K+S
         t2o4iUD7+A+o8m18is+2GbbVxVU4emvpa8LVHTyuLDAXrShWtwfR11AKvZtnebXnhAbc
         nnLmqCeTvfSaIioNhXRWHf92IwRJCKQj6/X4tbEtms5Tbsj/wcLPFpLuJQ3m2JzHfSIU
         b7i0YfZ1ywG/NV5c2urj/en+pHMbSv6hYPvCG7XHn4ba6g1h22dgQJYpNwU2+CGnr9kY
         ky3jWrPGvhxDtHAH84Kp0I/1NlvThvga/3nw9bfaWJOBqejHU3Eqt1sgQ/mfY9O9qyXr
         5ZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691965863; x=1692570663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMVqnKBxPcvgxex5yREEzCdHkXMG/1zXpKWPkS53ozo=;
        b=kEm3W0ijOEMx/4DKmiRmxmBovtyzXdytwiFkWR9dWi3fMk3gqe9jGRi6YO8FI0IoXh
         YVO8hOVcbuf5/p4NsqB0AHFY9lBx8CUiISha0ZePOAyTTowKZkL/+1uCwsquiW2qZ49k
         wpPcg/aGRyFONk3wy6bIKdmnSWK5trSfcRLkdMu3wN7DnVRnTwsCqWF5yc7X7pOYnW5z
         r1yJO1TEX9c0SC5cHChP4xWi0yqMzTUoaVE1eBtAEpwiQi8zkfd+aiM2Moo9MDscERh9
         8lp1cOFadNrkQvDCKCq2erjuM2zaI5Q2CCD//5kLwRcrHbntmOl1fY9bSIcN1AOepod9
         Ti5Q==
X-Gm-Message-State: AOJu0YwDdPaHwv26DFshnL+iHDolJ3Ig/lLfaUGP/fi9N9NClzkFhmRq
        NZejgcEMUEhXcaJFLYFKEhlhq5vm/Z3cT8/8or4=
X-Google-Smtp-Source: AGHT+IFTzsydx6Z2tx8Ii2nlxLIBCG+W/Asu8MK/OZmF0pBgmCLFgGYv3zGI3RfJAHvJ7dnjp7sj93HEnD1SbTa+9l0=
X-Received: by 2002:a05:6214:508d:b0:635:e528:521a with SMTP id
 kk13-20020a056214508d00b00635e528521amr12466762qvb.5.1691965862682; Sun, 13
 Aug 2023 15:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNTaNw3q1OciYq111vdr+-ouaRVmwVqVJH4iT0NqxFAcQ@mail.gmail.com>
 <20230813082413.GAZNiTLaOxUNUHPvlf@fat_crate.local> <CABXGCsNoNaGLsuvHLRA7aG9FCckQpnXaXWoUGvRwzfRKNB4xzA@mail.gmail.com>
 <20230813093502.GBZNijxgueFxBTxWwG@fat_crate.local> <CABXGCsMrNz2SPYN=zLZTT7jU4axSi-XLm4bTm7K3NuWnc=yr9g@mail.gmail.com>
 <20230813111425.GEZNi7EXyHOLQTNzFg@fat_crate.local> <CABXGCsO5=tEB29apcnPRF92yLQR-LD--vSGYPfLWAm0Z+++HRw@mail.gmail.com>
 <20230813141945.GFZNjmgZbHvMhLYtJl@fat_crate.local>
In-Reply-To: <20230813141945.GFZNjmgZbHvMhLYtJl@fat_crate.local>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 14 Aug 2023 03:30:51 +0500
Message-ID: <CABXGCsNSZD8GG1ZbpeNg54rjnsa9HQ3MumTgprLo8n5WE2VCoQ@mail.gmail.com>
Subject: Re: [regression/bisected] Add IBPB decreases performance in two times
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        x86@kernel.org
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

On Sun, Aug 13, 2023 at 7:19=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
> Nah, most people search the net and usually find the documentation, as
> past experience shows. In this case, they will find:
>
> https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html
>
> It will be there next week but here's the source:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/admin-guide/hw-vuln/srso.rst
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

I am figure out why I noticed lage impact of safe RET on my system.
safe-ret + KASAN =3D decrease performance for 50% in all scenarios
I use KASAN on a daily basis to catch bugs.
Is it possible for systems with KASAN to make a more optimal approach of SR=
SO?

--=20
Best Regards,
Mike Gavrilov.
