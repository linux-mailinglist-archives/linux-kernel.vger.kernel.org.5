Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83754770D46
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 04:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjHECEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 22:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHECEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 22:04:50 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73DD10EA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 19:04:45 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d0b597e7ac1so3006704276.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 19:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691201085; x=1691805885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCKRnUI8FwQWRwJ/8hlrDSlOySzgfMsCiiXmu+Rh1a4=;
        b=v7Qfm2wetpMH45IrUUaGhK0/J1vWSMrz292g2jfHm8p/djn5SST2E3F26gtQuLzFcH
         C+UH+iziHqsmkOZfdli3NMRxtLjOCWR8vhcHjWx1I9e8zCSAFCXN1rhtiN0lk/ytmddC
         6An8vg5fxhRUzs3IYiEl4G2MzYLTkmNPHzM9TzBNhGFf0QpK20l2gaZnbgpeHxhVcXXY
         RHMor5pp59gRQteJeLtrwR8Gq4Ir16snZKe4ILmmcumrSxBjpWctH+9I4oj18ZYXN+sI
         FoXf4LDSh2eifBssCkP+cxxfez3JIQIVQTbtQNJUet2Sp83wY3r0oFiPepAcTsagEMiB
         sWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691201085; x=1691805885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCKRnUI8FwQWRwJ/8hlrDSlOySzgfMsCiiXmu+Rh1a4=;
        b=lyaX++fqL7V6lFsba44zCogIPPb0RmifgXA4WFTW2IN9B14tCiXCf+YM0dB+EJ51AC
         xRI/mCerJNx0Di9KRab5KIJ3PJeKWBuRH8eJJUQaZbGoNFf5s+wgJOe+5hZ8BQI0/4vv
         s9McZQJsgebqFUt3aVFoQtPrqShk8/H9mcIoctpYknPhZ89sMoOb8dlhYkj91PeAK1Gd
         XHpaRCBlFsxqnY/i0yvzsuRcQXAg8s6vUI9ixqXKG6xpopJmXWqdWuQIUBddjl7OMX2A
         6POXrYEK/m+bllNGoJCQQUg7YA4qhWJBD1zDcesYQWiOdElpvXHxkcZTAJOIMoNMFS+G
         njDw==
X-Gm-Message-State: AOJu0YycFmcLF67ozf88EA8frDVVeypoyUC23mV3bBue1Rx9YvogrVhv
        Pd/RcpdADmsMjZ9eUzhTruKz/kBK+lv1fERy96MX34kxKgsLSQv8vGo=
X-Google-Smtp-Source: AGHT+IGnrrb1f0om6BEHSRmt+VdLfQfpBCe1Ehqiq+ISyIxQ7SrfdSpKt+84xzD1EQ9qLw6r0nlnHwBHdH9uOkpHIdA=
X-Received: by 2002:a25:f81c:0:b0:d22:4547:39d8 with SMTP id
 u28-20020a25f81c000000b00d22454739d8mr3413208ybd.63.1691201084766; Fri, 04
 Aug 2023 19:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230805014055.1280320-1-mjguzik@gmail.com>
In-Reply-To: <20230805014055.1280320-1-mjguzik@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 4 Aug 2023 19:04:32 -0700
Message-ID: <CAJuCfpH5pDetC7wz25YC9PptLm1T0r09F+QP616BJ+4VNaNv-A@mail.gmail.com>
Subject: Re: [PATCH] mm: move dummy_vm_ops out of a header
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 6:41=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> Otherwise the kernel ends up with multiple copies:
> $ nm vmlinux | grep dummy_vm_ops
> ffffffff81e4ea00 d dummy_vm_ops.2
> ffffffff81e11760 d dummy_vm_ops.254
> ffffffff81e406e0 d dummy_vm_ops.4
> ffffffff81e3c780 d dummy_vm_ops.7
>
> [if someone has better ideas where to put it, please move it]
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Thanks for the patch and it looks fine to me but why is it sent to me
and not to the mm maintainer? Also nobody else is CC'ed...
AFAIKT this code has been there long before per-vma locks got
introduced. Did my patchset somehow cause additional side-effects?

> ---
>  include/linux/mm.h | 6 +++---
>  mm/init-mm.c       | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 406ab9ea818f..14898e76bbf1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -756,17 +756,17 @@ static inline void vma_mark_detached(struct vm_area=
_struct *vma,
>
>  #endif /* CONFIG_PER_VMA_LOCK */
>
> +extern const struct vm_operations_struct vma_dummy_vm_ops;
> +
>  /*
>   * WARNING: vma_init does not initialize vma->vm_lock.
>   * Use vm_area_alloc()/vm_area_free() if vma needs locking.
>   */
>  static inline void vma_init(struct vm_area_struct *vma, struct mm_struct=
 *mm)
>  {
> -       static const struct vm_operations_struct dummy_vm_ops =3D {};
> -
>         memset(vma, 0, sizeof(*vma));
>         vma->vm_mm =3D mm;
> -       vma->vm_ops =3D &dummy_vm_ops;
> +       vma->vm_ops =3D &vma_dummy_vm_ops;
>         INIT_LIST_HEAD(&vma->anon_vma_chain);
>         vma_mark_detached(vma, false);
>         vma_numab_state_init(vma);
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index efa97b57acfd..cfd367822cdd 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -17,6 +17,8 @@
>  #define INIT_MM_CONTEXT(name)
>  #endif
>
> +const struct vm_operations_struct vma_dummy_vm_ops;
> +
>  /*
>   * For dynamically allocated mm_structs, there is a dynamically sized cp=
umask
>   * at the end of the structure, the size of which depends on the maximum=
 CPU
> --
> 2.39.2
>
