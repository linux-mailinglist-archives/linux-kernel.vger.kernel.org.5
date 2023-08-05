Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201B5770CA7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 02:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjHEA0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 20:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHEA0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 20:26:48 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4DE4ED3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 17:26:47 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-cfd4ea89978so2647935276.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 17:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691195206; x=1691800006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxe81u7udmo92GKvP+siVLCAkn/wI0aAvKtL6yx1U3g=;
        b=IDYaS2Jlq4whyIHc7JhRYfrcrAbZnELtmh2woo/KuYYzAzsbayvQ4sj8qrACxQTt3E
         lYDAcPv0oqswtU0a+8JiNOxwSOMnlBuWRX/kUju4NfI2bkeIEoUd+hpoIymCGCrg+HOd
         rOReOu27oMxzSRZka0CWgiWvfvyFOK0RrE0oxXSXuHZ/6hvL8HbaMJh2bTXme5gHpVfp
         p1jGS/SX43x7wyiaKixT6DLKPsA1RnNYoqMQNguxmupUlnDjz4f6JHVu8pmLvpu1YxU+
         2jSfSQVlNRKHZayvnNhSQsr4CW9cqxboPyMOci7lrIrxoLjF91f9DZPkkFJiVd1YSI5t
         wB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691195206; x=1691800006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxe81u7udmo92GKvP+siVLCAkn/wI0aAvKtL6yx1U3g=;
        b=fLvQXWtLWOwQuyem2hPsYvpcNpX4LQ/GMdoFP3x+DOR4igzwT+viNc7vukWxM+E3C+
         k9vfHLkgc20yN0BTwQ1A/Ze67/n4+Wf3bYTjIDKVBrhz8iA0/i9SlY002ftbf6pkCm7d
         FvHiXHuqAXuzWragjxsfZpDIZuzJ7HSHANxdU5H7+Hv2E9msbh3X4sBYlp/9zqKtuilB
         v0EDKticrOd2NPQxJDOp550hNPnbc5dXT9JPibMJJ4tGgSxslsQuTNzkEMGyG2jHidDK
         hdpsFRuwzrGXg0urG3nLiQi6klUiia1/hXr9GahL+Je0DS55XZvg/v/jiIXCwZDg3mMN
         wpsA==
X-Gm-Message-State: AOJu0YyuxyMO47v5sVrd3ydy8u27PeBbEZpnJ1iprkade8gPRkTeEU3w
        Gt/tO4tyYStEpu8/LbUvZfKKK4Sw3glzoB7x4aIGfg==
X-Google-Smtp-Source: AGHT+IFV5JuRf10Of18+lGhJEPb7ELh0VS/HhAfs0nhr73hV/LaKvg8puQls+izXLadWiO6FQO7JuYQNY8dwcMbQzOg=
X-Received: by 2002:a25:361b:0:b0:d0f:846c:ef7b with SMTP id
 d27-20020a25361b000000b00d0f846cef7bmr3175751yba.17.1691195206375; Fri, 04
 Aug 2023 17:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
 <20230804214620.btgwhsszsd7rh6nf@f> <CAHk-=wiy125k1dBmQFTGpHwiOqEyrD6xnd4xKWfe97H_HodgDA@mail.gmail.com>
 <CAGudoHFsAU_BDCOuz8UgDBLGEM8xg=aUGjaVoqkM_Zvxo2Re_g@mail.gmail.com> <CAHk-=wiG9xaVvBJXHqTxtop0=mW9KxPS9C54ED23p59VNEKdWg@mail.gmail.com>
In-Reply-To: <CAHk-=wiG9xaVvBJXHqTxtop0=mW9KxPS9C54ED23p59VNEKdWg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 4 Aug 2023 17:26:33 -0700
Message-ID: <CAJuCfpGWGsh2BRgwcJ7oVHnqZfrtiesvhzomK0ZmxE_KK=R7FA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, akpm@linux-foundation.org,
        regressions@leemhuis.info, bagasdotme@gmail.com,
        jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Aug 4, 2023 at 5:15=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 4 Aug 2023 at 16:25, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > I know of these guys, I think they are excluded as is -- they go
> > through access_remote_vm, starting with:
> >         if (mmap_read_lock_killable(mm))
> >                 return 0;
> >
> > while dup_mmap already write locks the parent's mm.
>
> Oh, you're only worried about vma_start_write()?
>
> That's a non-issue. It doesn't take the lock normally, since it starts of=
f with
>
>         if (__is_vma_write_locked(vma, &mm_lock_seq))
>                 return;
>
> which catches on the lock sequence number already being set.

That check will prevent re-locking but if vma is not already locked
then the call will proceed with obtaining the lock and setting
vma->vm_lock_seq to mm->mm_lock_seq.

>
> So no extra locking there.
>
> Well, technically there's extra locking because the code stupidly
> doesn't initialize new vma allocations to the right sequence number,
> but that was talked about here:
>
>     https://lore.kernel.org/all/CAHk-=3DwiCrWAoEesBuoGoqqufvesicbGp3cX0Ly=
KgEvsFaZNpDA@mail.gmail.com/
>
> and it's a separate issue.
>
>           Linus
