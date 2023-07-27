Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ABB765B62
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjG0Sba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjG0SbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:31:19 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DE33588
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:31:17 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso1135395276.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690482676; x=1691087476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cuix17oN1As2F9cKjO6qI0WP+i+QUzfFJXKaqWcIw5U=;
        b=klIm4XDlEQx1Pzosih1WqdpHLfAmSKX62qjoQHiHKdm+IY4QJq0VjANoi/XLz4fjTS
         qYGCP+29ONX0IMFjdxiE6hpggNps5K757mi54oKznztzhxPMVWygjTH9zbjBTpPsDiRQ
         x71n2g4qdwfGRgBlrtUs1lTdrAM2sIJAmTX/CN8W5X9dvFV/LIMKqd3wy2HaAz6U21hf
         LS6njBjCJtA8GZ9DC94dDKEeco3SkwpnrjvOvx13K6xwnbzzGFm7Cwhf1fR/2VqXl+DL
         jxczcuYm0SCWn+wEeM/lBti94iuLtqgMrPNXZoWGN0bN10ukCE8yFEOuyHd/omH4OeAx
         1pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690482676; x=1691087476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cuix17oN1As2F9cKjO6qI0WP+i+QUzfFJXKaqWcIw5U=;
        b=cz7vlqO2ZymMRet6MHzmlaIoM7jKSsY9c5iaE9iLiCmrYCHQGFMwINpy9g0w4IXXRu
         iLmg1cz6IsJuijZCgp1S1iKo8ZuJeKNBGPaQKuDU8kx1LoiX+xbSjcFKiLAZkiD8LFbb
         ofkSaRRHK0Cu74rmJmrBBP9aAVx76mAnzxZ+RuFTXk+53aP2wJBA/pwuTnlK06qyPAS7
         kB5FhUTzAvj4xH8B3mKaaNxvvdeDgpQRl96Iz9Q7tA7dIlyd+GVYMtBj7lxN6NTbglmQ
         ikSa7Ff/Eb/0Ohc4+ff9ZbcwBTgmw+BwJMSbpmlrMlFNo5fC2g2rSaCfD6cPmFtdZ017
         H6RA==
X-Gm-Message-State: ABy/qLb8N0Sgah2B3N0Fla3U0A0kQPa2G1v3lZo5hAes/D2Jpamz992q
        uQJq1ARx5iaK2/CCNfpjfCBqeZXi308xTH2JtmP3zQ==
X-Google-Smtp-Source: APBJJlG1OjtjMH5KGWRrsqvdl4t6T4NYpi8HpLoGO/Tola0XsUYaeZ4dPZgLeAQjbKKyoE5a2e/EamCpo6Riyly9Lc8=
X-Received: by 2002:a25:c508:0:b0:d00:cc5b:8a9f with SMTP id
 v8-20020a25c508000000b00d00cc5b8a9fmr221127ybe.16.1690482676162; Thu, 27 Jul
 2023 11:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000607ff905ffc8e477@google.com> <0000000000000aeb7f06015e5cbd@google.com>
 <20230727164757.e2di75xjybxncohn@revolver> <CAJuCfpEyE18kbH84FfmfzUnar2dxgzpi=FOYPbU8MOpz-SbVjg@mail.gmail.com>
 <CAG48ez1yg7m=aNsjNiGt_s0_tEBEmEXXx0-vijuN9MBmoxL7PQ@mail.gmail.com> <ZMK0ony0LG2SL2Ha@casper.infradead.org>
In-Reply-To: <ZMK0ony0LG2SL2Ha@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 27 Jul 2023 11:31:01 -0700
Message-ID: <CAJuCfpEWfFY_JXoXDnK0X+rY6Qf==RBpLzSSJhEtgU50HHp4-A@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 11:17=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Jul 27, 2023 at 07:59:33PM +0200, Jann Horn wrote:
> > On Thu, Jul 27, 2023 at 7:22=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > Hmm. lock_vma_under_rcu() specifically checks for vma->anon_vma=3D=3D=
NULL
> > > condition (see [1]) to avoid going into find_mergeable_anon_vma() (a
> > > check inside anon_vma_prepare() should prevent that). So, it should
> > > fall back to mmap_lock'ing.
> >
> > This syzkaller report applies to a tree with Willy's in-progress patch
> > series, where lock_vma_under_rcu() only checks for vma->anon_vma if
> > vma_is_anonymous() is true - it permits private non-anonymous VMAs
> > (which require an anon_vma for handling write faults)  even if they
> > don't have an anon_vma.
> >
> > The commit bisected by syzkaller
> > (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/co=
mmit/?id=3Da52f58b34afe095ebc5823684eb264404dad6f7b)
> > removes the vma_is_anonymous() check in handle_pte_fault(), so it lets
> > us reach do_wp_page() with a non-anonymous private VMA without
> > anon_vma, even though that requires allocation of an anon_vma.
> >
> > So I think this is pretty clearly an issue with Willy's in-progress
> > patch series that syzkaller blamed correctly.

A comment for __anon_vma_prepare() says "This must be called with the
mmap_lock held for reading."
I think adding an explicit mmap_assert_locked() in this function would
help catch such issues.

>
> Agreed.  What do we think the right solution is?
>
> Option 1:
>
> +++ b/mm/memory.c
> @@ -3197,6 +3197,12 @@ static vm_fault_t wp_page_copy(struct vm_fault *vm=
f)
>         struct mmu_notifier_range range;
>         int ret;
>
> +       if (!vma->anon_vma) {
> +               // check if there are other things to undo here
> +               vma_end_read(vmf->vma);
> +               return VM_FAULT_RETRY;
> +       }
> +

This one bails out later but if the path is not taken too often I
think it's cleaner.


>         delayacct_wpcopy_start();
>
> Option 2:
>
> @@ -5581,7 +5587,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm=
_struct *mm,
>                 goto inval;
>
>         /* find_mergeable_anon_vma uses adjacent vmas which are not locke=
d */
> -       if (vma_is_anonymous(vma) && !vma->anon_vma)
> +       if ((vma_is_anonymous(vma) ||
> +            vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) && !vma->anon_vma=
)
>                 goto inval;
>
> The problem with option 2 is that we don't know whether this is a write
> fault or not, so we'll handle read faults on private file
> mappings under the mmap_lock UNTIL somebody writes to the mapping, which
> might be never.  That seems like a bad idea.
>
> We could pass FAULT_FLAG_WRITE into lock_vma_under_rcu(), but that also
> seems like a bad idea.  I dunno.  Three bad ideas.  Anyone think of a
> good one?
