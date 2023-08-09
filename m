Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1DF776345
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjHIPFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjHIPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:05:00 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA9391;
        Wed,  9 Aug 2023 08:04:59 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-584243f84eeso79344977b3.0;
        Wed, 09 Aug 2023 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691593499; x=1692198299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUNHA5k0oc4UJ3HPv3ruu/iAAkeeULdAZcTUmh4s50w=;
        b=cmUWaPIpgABWq6VhUwPcsQcIqckeGYwWCLHIzh5SmxxbhhwMNyabD5AclGPeSIGVeo
         VCv9i7pvL24DbcuKO4E0QcbZUCbZeKKoclw3CTwYtNZiHPTrLahEgvYyOPF71bWryO+X
         6d3G2ZHh11Eqn7D9jOKgyfpS/vqgITvWge1EKdRUvmWOxHD9Uz+J4AZu1Z7JzoTrDAxx
         WcTfzxLA3xKZJo6/uqFlRbNg3cjcKoLA8ewR92yRqvZ4P0scq0vdk8hsrYC7QXiTy6t9
         o4H30LSpSif7NeTq/cvVU5YDRHtLc4BGw9iF3+iCFAbfvR33CqyyahnTZ8qTAOIcy6vZ
         ieng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691593499; x=1692198299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUNHA5k0oc4UJ3HPv3ruu/iAAkeeULdAZcTUmh4s50w=;
        b=bCvZ5lp3854Dm71xBa7vo74oXJDUHNL/Ti8yI+mNkO82AY5B7x/eCpJFjf39HVkofc
         lObgdo/czIR6/4e9KReQAFTm1YsqXNjBPqyWNX8RB1qkGVNSmnmebAu7eT4oxTZXA4pW
         YQvNGhQJfB6N6Zo4igUBRtDrCcyTGkE1lroVNVnansOrcRJkrKXwqYfL+3POGjDiEBo8
         hGSbySxlLUTXw6zacdfbJxAnLPhVAFDII1nGCdjCOFFMhqKX1TyHWSjrrntJeEfdY7FK
         rPDZoDEjVoHLzVKZJBOshRYCdDJyUKN+UR84MbzmgBAK+0bvMQ9zlpe1vJb/2n0GKYr1
         Ehcg==
X-Gm-Message-State: AOJu0Yxtqh9kqN5ce5HOV8LNF+vcbziwpqXxDg4nsl298c+XTPPLLbzZ
        +XBK/tzth1PjTH1fs/oFDH5IfQ3I0oc9rrAOi/Y=
X-Google-Smtp-Source: AGHT+IGth0evnpBrLoCbQ/NjZeXG4/FKNjvMlrH8Pg4TU4y/1LSVl+3ahRRiojLkI+Z8Rb+JOAS+jkie9I21KObZ3x8=
X-Received: by 2002:a81:a107:0:b0:583:9018:29ec with SMTP id
 y7-20020a81a107000000b00583901829ecmr2934644ywg.32.1691593498807; Wed, 09 Aug
 2023 08:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <1690598115-26287-1-git-send-email-quic_pintu@quicinc.com>
 <20230731112155.GA3662@lst.de> <CAOuPNLjnfq1JefngtNrg0Q+JdMTSRz+eEqxGQJFfx9+af+k9WA@mail.gmail.com>
 <20230801171838.GA14599@lst.de> <CANDhNCq+3OEosUcQJ5GFgk+5OyG+JqXKM43UAo0aPz-V27OgAA@mail.gmail.com>
 <20230802094725.GA28241@lst.de> <CAOuPNLjAOk0BOXDcjbY+evX_uxbZyptrJXMf0ULhReECzEX0CQ@mail.gmail.com>
In-Reply-To: <CAOuPNLjAOk0BOXDcjbY+evX_uxbZyptrJXMf0ULhReECzEX0CQ@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 9 Aug 2023 20:34:47 +0530
Message-ID: <CAOuPNLjn3b3YSgy=ObnF+cE7kj-9vdZ+6fFzMp-bJYLFq3MgWw@mail.gmail.com>
Subject: Re: [PATCH v2] dma-contiguous: define proper name for global cma region
To:     Christoph Hellwig <hch@lst.de>
Cc:     John Stultz <jstultz@google.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux.dev, Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
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

Hi,

On Thu, 3 Aug 2023 at 23:04, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi,
>
> On Wed, 2 Aug 2023 at 15:17, Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Aug 01, 2023 at 10:39:04PM -0700, John Stultz wrote:
> > > So, forgive me, I've not had a chance to look into this, but my
> > > recollection was "reserved" is the name we see on x86, but other name=
s
> > > are possibly provided via the dts node?
> >
> No, I think "reserved" is the name hard-coded (for all arch) in Kernel
> for global-cma.
> So, I don't think this is x86 specific. I am checking on arm32 itself.
> When we can dma_alloc_coherent we see these in the logs (if dts region
> is not present).
> cma: cma_alloc(cma (ptrval), name: reserved, count 64, align 6)
> Now, with this change we will see this:
> cma: cma_alloc(cma (ptrval), name: global-cma-region, count 64, align 6)
>
> > Indeed, dma_contiguous_default_area can also be set through
> > rmem_cma_setup, which then takes the name from DT.
> >
> I think this is a different case. If DT entry is present we get this:
> Reserved memory: created CMA memory pool at 0x98000000, name: name:
> linux,cma, size 128 MiB
> cma: cma_alloc(cma (ptrval), name: linux,cma, count 64, align 6)
>
> Here we are talking about the default hard-coded name in Kernel code
> if DT is not defined.
> So, in one of the boards, this DT entry was not present and it shows
> as "reserved".
>
> > > I believe on the hikey board its "linux,cma" is the name, so forcing
> > > it to reserved would break that.
> > >
> Yes, everywhere in the DT it's defined as "linux,cma".
> You mean this also should be changed to "linux,cma-global-region"
> everywhere with this change ?
>
> > > Maybe instead add a compat config option to force the cma name (so x8=
6
> > > can set it to "default" if needed)?
> >
> Yes, having it in config is also a good option instead of hard-coding in =
Kernel.
> >
> > I think we'll just need to leave it as-is.  I with dma-heaps had never
> > exposed the name to userspace, but we'll have to l=D1=96ve with it now.
>
> Can you point me to the userspace utility we are talking about here ?
> I think we should not worry much about userspace name exposure.
> I guess it should fetch whatever is declared in Kernel or DTS, right ?

Just to follow-up on this.
For now, can we change the Kernel hard-coded value from "reserved" to
"global-cma-region" ?
Later, for the DTS defined name let it be "linux,cma" or change that
also to "linux,global-cma-region" ?

Will this make sense ?
