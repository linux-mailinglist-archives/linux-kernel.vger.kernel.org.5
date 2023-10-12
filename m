Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A047C7878
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442861AbjJLVRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442824AbjJLVRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:17:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A0EA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:17:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so2505041a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697145458; x=1697750258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vq2DHHNgN1ay7Fwdp3I5ZMWfUBUlatwsBWWqlLrDB9s=;
        b=MLRBPaM7BX5Hdbg2iij5zYMlth+9hzHEJM0LoD9nxjKlkE3irwmPu3OPJha6FsDeMx
         otbrg1J2ZN/mRCU0MYczc0l5NpQK6Oq2LsfMTkBm5L7Z4z4FY+QCpI1MT34CDQGPAJJd
         zyKETRB3KJlfThXqAl1TZudPFW52pjpAOQ6q+EDVIzSEMsCsM/hiW4wKHoWDLq/6ML4r
         h/HklOSUk85cw+mEl7sJIOq+ipYOMBxUge9o0xdX+qShNJaSvPQ5pLiCrJUDMFkKosYk
         Rq2if7V9so+qlyN5+N4/gZ8B0aH/6oYghzkOo52CmY3RDVAve2C3LIGOUMXMPKhZ59jG
         V35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697145458; x=1697750258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vq2DHHNgN1ay7Fwdp3I5ZMWfUBUlatwsBWWqlLrDB9s=;
        b=JEiO0twGTlX+/7QhkxWYOAfBT2fakd6Ihw/ZF13Xunoz1ewfilRhIbF4Pipyql1sUG
         5qIo5IDRRagQaPmrvJkHfKW3Lnf8mBJzNdUYD24PSARzPm5zlt5ACjEVYugNeZOcxnCX
         g6O3nBkZve0hkWGq0ojBcnKu6OmDPMyVC6Teml56SEUcr5ik7tGcYvVHoEF14/zwHv4+
         KvIFeq16ESoj/rNn+C3mBkBaQhk7V08OhC5W7MyXOvEztmuYX8Nh2j7J2YtqvxGwO/ad
         7LR2JirvZP2jZlKO0D2AHReV/Ac1fFJtXbn0DNFaMI5VIDUkOyyGvLNoIKJkIDwwVGFq
         hiGQ==
X-Gm-Message-State: AOJu0YyDPOK8I6BYtZ918iJFy0c74AON+1bt8RFkZWBxeRhvKZwz19AX
        wu1pmU8OKG3QnmL77WPly768QrIiAMY0HM5N2sU=
X-Google-Smtp-Source: AGHT+IFkk5bm0z+SbkCdj2ZECqmt8Zf7B2iGxvVYgN8WfLbpYYBKrqqKimZjM9pWxssXaEAMfUi+zM2eBiUJQ12DqNw=
X-Received: by 2002:aa7:c909:0:b0:530:97b5:49ce with SMTP id
 b9-20020aa7c909000000b0053097b549cemr23858410edt.10.1697145457834; Thu, 12
 Oct 2023 14:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231012201743.292149-1-ubizjak@gmail.com> <3af8dcec-66ec-4bd4-b7bf-4bc6f5f3c70f@intel.com>
 <CAFULd4byzHyoz4xM1gL_T1wFkNE-ab8K4upXfPirxM9PdX5JWg@mail.gmail.com> <5722e74b-6fc6-4d6e-be25-069ea6385990@zytor.com>
In-Reply-To: <5722e74b-6fc6-4d6e-be25-069ea6385990@zytor.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 12 Oct 2023 23:17:26 +0200
Message-ID: <CAFULd4afhj-kJwneh7wz0sExWqOmPicG4fcfF++_fUMHpoNbXA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce %rip-relative addressing to PER_CPU_VAR macro
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
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

On Thu, Oct 12, 2023 at 11:08=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On 10/12/23 13:59, Uros Bizjak wrote:
> > On Thu, Oct 12, 2023 at 10:53=E2=80=AFPM Dave Hansen <dave.hansen@intel=
.com> wrote:
> >>
> >> On 10/12/23 13:12, Uros Bizjak wrote:
> >>> The last patch introduces (%rip) suffix and uses it for x86_64 target=
,
> >>> resulting in a small code size decrease: text data bss dec hex filena=
me
> >>> 25510677 4386685 808388 30705750 1d48856 vmlinux-new.o 25510629 43866=
85
> >>> 808388 30705702 1d48826 vmlinux-old.o
> >>
> >> I feel like I'm missing some of the motivation here.
> >>
> >> 50 bytes is great and all, but it isn't without the cost of changing
> >> some rules and introducing potential PER_CPU_ARG() vs. PER_CPU_VAR()
> >> confusion.
> >>
> >> Are there some other side benefits?  What else does this enable?
> >
> > These changes are necessary to build the kernel as Position
> > Independent Executable (PIE) on x86_64 [1]. And since I was working in
> > percpu area I thought that it was worth implementing them.
> >
> > [1] https://lore.kernel.org/lkml/cover.1682673542.git.houwenlong.hwl@an=
tgroup.com/
> >
>
> Are you PIC-adjusting the percpu variables as well?

After this patch (and after fixing percpu_stable_op to use "a" operand
modifier on GCC), the only *one* remaining absolute reference to
percpu variable remain in xen-head.S, where:

    movq    $INIT_PER_CPU_VAR(fixed_percpu_data),%rax

should be changed to use leaq.

All others should then be (%rip)-relative.

Uros.
