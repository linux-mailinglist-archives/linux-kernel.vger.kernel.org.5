Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF257903B8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbjIAWsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjIAWsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:48:40 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4ABCC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:48:37 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5735282d713so1468452eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 15:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693608516; x=1694213316; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eONqcjJk6d5/5qOWzNU6WGhoVewodjNEM3WP2cqp3kM=;
        b=WWIjP54X9v7GkpbaRO2X2Gt437DdypQ7DlGj7r72kkTbLon5PVR//jMN2bFSt1R2G7
         19sxoUPD2I5xfQ2cLj6iPaAOv13ewlwg77A3vJlo6bFOA0ve7WcE9S+Cp2s01lwZTZ5r
         q+pXVdSawonSRiTz562HRTzVZnrk/C7Bl/2UzUER3CL7oddH3dH+k57l6LsxTwMCpQfh
         ECPai/s/v/KdakvcSzwKCVlckO6/6DcKNe5d3BvObMmaR73kE+DzEM4h3WbOtUNqRzvo
         dlYQQ9MP+q1q1I5WV2MlPGcbZ5eD9yXcwW2dbuOE8lKSD6gzUE5sKbcmwt6Ltj+voehz
         uTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693608516; x=1694213316;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eONqcjJk6d5/5qOWzNU6WGhoVewodjNEM3WP2cqp3kM=;
        b=lE9lpDYjA0PyImfUJ6qxy5guTOWxktRibDXiDrOPtxSUENwdNXlc/J2IUS0IPu5HCQ
         YyIjyw0fg3lcxo3KJvbsWtq11QATD/qW8zd0k3288v5GrY08rwQwqGV/TrkbeHINyBfw
         nXOUWWDvINkWzgXhETXQ9YFA/qddxWOVeep0s8gtiqPiDQiXdY4HoD4mNeprejeH+Q48
         xWaIz3xOnLdGnlIhuu29CyRWd2LYwO1DCTyaJ3xrOqAXfpIUD9tfNVBy6JGzPxQXw0Sc
         +QDW9GCTo0QbBCHCprzEC1oK05WHJc9WKIr4oCNrqOirlyuFkTtHfEjdo4OHDCdM7FYz
         ZNkQ==
X-Gm-Message-State: AOJu0YwAag7edZd/UlZukRgN11KvsDoJgmJbF/tke1gBz5uPoAienopo
        gBCWi9ng2RgRfCCLBPNaW1r68A==
X-Google-Smtp-Source: AGHT+IHIRsnpNF/YhT6AjUk2xXQfDzfvwC68NkNoXY8yFOH/ftGxUh9fhjMkLdg6gqKRvn70ENI6Ew==
X-Received: by 2002:a05:6358:5207:b0:13a:a85b:c373 with SMTP id b7-20020a056358520700b0013aa85bc373mr4551287rwa.18.1693608516272;
        Fri, 01 Sep 2023 15:48:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i193-20020a0ddfca000000b00583d1fa1fccsm1332554ywe.0.2023.09.01.15.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 15:48:35 -0700 (PDT)
Date:   Fri, 1 Sep 2023 15:48:26 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        regressions@lists.linux.dev
Subject: Re: 6.6/regression/bisected - after commit a349d72fd9efc87c8fd1d16d3164752d84a7275b
 system stopped booting
In-Reply-To: <CABXGCsOPcu8R9rpdihNR5r822FAHBZ42wBa5XUa5RDVierD_tg@mail.gmail.com>
Message-ID: <5e4d50d4-978-ce54-e1ae-40f7117dbf3d@google.com>
References: <CABXGCsNi8Tiv5zUPNXr6UJw6qV1VdaBEfGqEAMkkXE3QPvZuAQ@mail.gmail.com> <3548ca67-ce58-3bc6-fef5-348b98d7678b@google.com> <CABXGCsOyamBvQ=Y-M9HQBTfEDfaRwGqzXqayBm7L259Q+t+gJQ@mail.gmail.com> <98eb1ba4-5bd3-ee7-1a88-47b054dc938@google.com>
 <CABXGCsOPcu8R9rpdihNR5r822FAHBZ42wBa5XUa5RDVierD_tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-45710664-1693608515=:22700"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-45710664-1693608515=:22700
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 1 Sep 2023, Mikhail Gavrilov wrote:
> On Fri, Sep 1, 2023 at 2:08=E2=80=AFPM Hugh Dickins <hughd@google.com> wr=
ote:
> >
> >
> > Sorry about that, please try this instead, adds EXPORT_SYMBOL(pte_unmap=
).
> >
>=20
> Thanks, now I have a working kernel builded at commit a349d72fd9ef.
>=20
> > I've never used stackdepot before, but I've tried this out in good and
> > bad cases, and expect it to work for you, shedding light on where is
> > going wrong - machine should boot up fine, and in dmesg you'll find one
> > stacktrace between "WARNING: pte_map..." and "End of pte_map..." lines.
>=20
> Interesting, I checked twice but I didn't find any entry with
> "pte_map" in the kernel log after applying your patch.

That was very disappointing: I found it hard to explain, but was thinking
of sending you a similar patch, doing the same check on all your 32 CPUs -
maybe the stall being on CPU 0 in your photo was accidental.

But now I think I have the shameful answer (which studying your dmesg,
and the 82328 jiffies at 86 seconds in your photo, did help me towards).

That mm/pagewalk fix I put into 6.5 has a grievous oversight (and a
video of your failing 6.6 bootup would likely have shown a WARN_ON_ONCE
from the underflow in __rcu_read_unlock()).

Please revert the debug patch I sent yesterday (or earlier today), please
try booting with this one on top of a349d72fd9ef; and if that's successful,
then please go back to your original Rawhide tree and apply this on top of
that, to confirm that boots to a working system too - thanks.

With my apologies,

[PATCH] mm/pagewalk: fix bootstopping regression from extra pte_unmap()

[ Commit message yet to be written: it's actually something to go to
6.5 stable, to correct i386 CONFIG_HIGHPTE there - though we know of
no case where it is actually hit. ]

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 2022333805d3..9e7d0276c38a 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -58,7 +58,7 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr,=
 unsigned long end,
 =09=09=09pte =3D pte_offset_map(pmd, addr);
 =09=09if (pte) {
 =09=09=09err =3D walk_pte_range_inner(pte, addr, end, walk);
-=09=09=09if (walk->mm !=3D &init_mm)
+=09=09=09if (walk->mm !=3D &init_mm && addr < TASK_SIZE)
 =09=09=09=09pte_unmap(pte);
 =09=09}
 =09} else {
--=20
2.35.3
---1463760895-45710664-1693608515=:22700--
