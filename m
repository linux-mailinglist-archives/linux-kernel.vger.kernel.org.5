Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E113D79072D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 11:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351952AbjIBJwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 05:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjIBJwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 05:52:10 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDE910E0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 02:52:07 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64f4043dd38so2114456d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 02:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693648327; x=1694253127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjdWtHgsDTB4R4Jq1soVJcM9QWTddW8JRmrExPBXbIU=;
        b=RuOu5IfQ3hF6aJ93s/olzOqnFWzc33jJNcQBRnu17e1qXy7W3MdscsuYsfdhJCCUmP
         gjJysLE1Jgz4OyL8cDexSUrFOtBB8fjrq7fGaL+p74+riVzIz80dSut3MRLqMFhCnl42
         EKcXJDPkKfEsdE0OqipF/NNc02MC8/VL9d4ebfxITJky5nrSfziykVjY0cttH9s2Fk41
         XtoZt8Yo+pM3OLb61SMqMpSv+0YAsPEbR9hO/w/yhnGWQ7SKD5GMoh8sWZz1eeZNPpNT
         iyJvABmEGVhhOvfaMik8w/ovNJRJ82rWwLxa2GZMlZ4CdN9T14Ri76v2YzvmI2GT74zj
         oPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693648327; x=1694253127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjdWtHgsDTB4R4Jq1soVJcM9QWTddW8JRmrExPBXbIU=;
        b=AY38KFEGj0yk/tzXr80Epl4Ny3aBxrMkQA73X0ulH2wLK982VLm6YsEeBLPUh7a8gY
         jKHpdN6gB2rMa60zIn2vm7x/mch0KZtAD2+YhMtRSjK1cJrZetmtRQzpgCC98VcfpHwC
         cbLswySLrZT/Hiq+RLmf/hJcpHiJL4vGiPM9NIRqVkcW3uDjir5XQCKrvFiSwLwyOg+R
         urC0aUp9G5mPoKLOhHRC2uc6x5QBC4GUKULLSAZ0lrP/DorRzcVhUqA0IttjXMG2JJHn
         f1zv8rcPwdH9/Y5ldJElUZjrpCVWESo343QKrILUEDy1pbRC4GBZtXb1f+jyx02Zik15
         cUiw==
X-Gm-Message-State: AOJu0YyYkoTLYNykbf44fdd/pJh1BPGB2LDihF0wkNQQlACbznyw1ytw
        JmlVmUcTlsvbpLQqiTzNlGzhlE8my8b48nzXI7A=
X-Google-Smtp-Source: AGHT+IE3L2Pns1+lhVfe9SzdXHBx2qDiPbdxS5Iukb3V4eViqvyqRuX63PI3CMe4Qyd/74RfpRpqlmOCsBaldezjBWU=
X-Received: by 2002:a05:6214:f2e:b0:63c:7427:e7e9 with SMTP id
 iw14-20020a0562140f2e00b0063c7427e7e9mr5628283qvb.6.1693648326776; Sat, 02
 Sep 2023 02:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNi8Tiv5zUPNXr6UJw6qV1VdaBEfGqEAMkkXE3QPvZuAQ@mail.gmail.com>
 <3548ca67-ce58-3bc6-fef5-348b98d7678b@google.com> <CABXGCsOyamBvQ=Y-M9HQBTfEDfaRwGqzXqayBm7L259Q+t+gJQ@mail.gmail.com>
 <98eb1ba4-5bd3-ee7-1a88-47b054dc938@google.com> <CABXGCsOPcu8R9rpdihNR5r822FAHBZ42wBa5XUa5RDVierD_tg@mail.gmail.com>
 <5e4d50d4-978-ce54-e1ae-40f7117dbf3d@google.com>
In-Reply-To: <5e4d50d4-978-ce54-e1ae-40f7117dbf3d@google.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 2 Sep 2023 14:51:55 +0500
Message-ID: <CABXGCsOM0j7ME4iUDbf5fpLMxZicXHwT9aBGWXCNWUVSPUO0Sw@mail.gmail.com>
Subject: Re: 6.6/regression/bisected - after commit a349d72fd9efc87c8fd1d16d3164752d84a7275b
 system stopped booting
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        regressions@lists.linux.dev
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

On Sat, Sep 2, 2023 at 3:48=E2=80=AFAM Hugh Dickins <hughd@google.com> wrot=
e:
> That was very disappointing: I found it hard to explain, but was thinking
> of sending you a similar patch, doing the same check on all your 32 CPUs =
-
> maybe the stall being on CPU 0 in your photo was accidental.
>
> But now I think I have the shameful answer (which studying your dmesg,
> and the 82328 jiffies at 86 seconds in your photo, did help me towards).
>
> That mm/pagewalk fix I put into 6.5 has a grievous oversight (and a
> video of your failing 6.6 bootup would likely have shown a WARN_ON_ONCE
> from the underflow in __rcu_read_unlock()).
>
> Please revert the debug patch I sent yesterday (or earlier today), please
> try booting with this one on top of a349d72fd9ef; and if that's successfu=
l,
> then please go back to your original Rawhide tree and apply this on top o=
f
> that, to confirm that boots to a working system too - thanks.
>
> With my apologies,
>
> [PATCH] mm/pagewalk: fix bootstopping regression from extra pte_unmap()
>
> [ Commit message yet to be written: it's actually something to go to
> 6.5 stable, to correct i386 CONFIG_HIGHPTE there - though we know of
> no case where it is actually hit. ]
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/pagewalk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 2022333805d3..9e7d0276c38a 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -58,7 +58,7 @@ static int walk_pte_range(pmd_t *pmd, unsigned long add=
r, unsigned long end,
>                         pte =3D pte_offset_map(pmd, addr);
>                 if (pte) {
>                         err =3D walk_pte_range_inner(pte, addr, end, walk=
);
> -                       if (walk->mm !=3D &init_mm)
> +                       if (walk->mm !=3D &init_mm && addr < TASK_SIZE)
>                                 pte_unmap(pte);
>                 }
>         } else {
> --
> 2.35.3

Great, this is the right patch.
Both build a349d72fd9ef and latest in Rawhide (now it is 99d99825fc07)
works fine after applying this patch.
So thank you a lot.
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.
