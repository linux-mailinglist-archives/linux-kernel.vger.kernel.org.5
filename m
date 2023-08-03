Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F8476F0B5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbjHCReS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjHCReP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:34:15 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125EE10B;
        Thu,  3 Aug 2023 10:34:15 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-44799de68f3so1534419137.1;
        Thu, 03 Aug 2023 10:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691084054; x=1691688854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8Xa9pYsN9q26Cy2OfWksmVuBviyVuvzRMdasYi4RPE=;
        b=ieYA6bVxf1lbXkgHAn+hXhVfxzKe711nmI2r+8a2Pkje45GQmKLftZmaLt0qar82gg
         SFBl/K1845mX6+FAqPkGcjyrpBXYikncS74nQOppvoyKSHXe0rCclfsEAXrPauDBdjLV
         e25KI/Uu6/whFSVJCUzOwGJkV3uYaP9OmOzDMNjjkk1ts8gnSQW1ex6gNo+0kzwO65XL
         HyypX83EJT7/21befwOJ9uRlgd3lhXqtj1LN6iNBdvKWKSCrS9QQZFXiZGxHkCMMLy82
         +seRRUC93Y1mRKPJn8r746QD8Gi1bfCC2+B+iopA0nXA09o5X8xylmqFAP/A/rLnnA0P
         /oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691084054; x=1691688854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8Xa9pYsN9q26Cy2OfWksmVuBviyVuvzRMdasYi4RPE=;
        b=Khj1CqU68ZW5JL7jvi+pAiIgubbQcSdOSioCHUAfRRrEK3wEQEOBOXhiHNa782xOK0
         UPqwiB2NmMmM+twM72bGE9FgzVc86HK7WqMXgv2w2QuRxYGJss8qW1y6++gwGcDCifNl
         NAV3m7xO/s3fyfEcrgTatPMe9m95tBFPB1vErPL0r+tQnVzkgRPuL4sGeI6HkUbr9cAv
         j1cu7XVp3wBaRjUz0qXRSN0X1OTpbe4G8n/iqzjOvLdESagGXKE+Q5TDU8WgkdB69xhd
         N9l72PSsrm+EPi9hScYKgRe44/8Et89Jy2gZlyHu6T+Mpc5AYt/8GRAlAKE3sxDoXJ/w
         J9QQ==
X-Gm-Message-State: ABy/qLbF3wRyFXbaDCQ1CE+Hrhe1CxHK2awnp4p/B09UvgIkaA7y0xCK
        ktLpTVM4KCBwMeU/FIXCz435PMTD55CY+t0AsoU=
X-Google-Smtp-Source: APBJJlG6pjOoG0q6RAsawh+9qeUBUHt8XE1GKbQlIBPYmQFLRffHoU6WGPDLy5lU6fh2CQ1SS4cFWeU/BvylteONzOI=
X-Received: by 2002:a05:6102:d8a:b0:443:5524:8f8b with SMTP id
 d10-20020a0561020d8a00b0044355248f8bmr4828038vst.4.1691084054017; Thu, 03 Aug
 2023 10:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <1690598115-26287-1-git-send-email-quic_pintu@quicinc.com>
 <20230731112155.GA3662@lst.de> <CAOuPNLjnfq1JefngtNrg0Q+JdMTSRz+eEqxGQJFfx9+af+k9WA@mail.gmail.com>
 <20230801171838.GA14599@lst.de> <CANDhNCq+3OEosUcQJ5GFgk+5OyG+JqXKM43UAo0aPz-V27OgAA@mail.gmail.com>
 <20230802094725.GA28241@lst.de>
In-Reply-To: <20230802094725.GA28241@lst.de>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 3 Aug 2023 23:04:02 +0530
Message-ID: <CAOuPNLjAOk0BOXDcjbY+evX_uxbZyptrJXMf0ULhReECzEX0CQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2 Aug 2023 at 15:17, Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Aug 01, 2023 at 10:39:04PM -0700, John Stultz wrote:
> > So, forgive me, I've not had a chance to look into this, but my
> > recollection was "reserved" is the name we see on x86, but other names
> > are possibly provided via the dts node?
>
No, I think "reserved" is the name hard-coded (for all arch) in Kernel
for global-cma.
So, I don't think this is x86 specific. I am checking on arm32 itself.
When we can dma_alloc_coherent we see these in the logs (if dts region
is not present).
cma: cma_alloc(cma (ptrval), name: reserved, count 64, align 6)
Now, with this change we will see this:
cma: cma_alloc(cma (ptrval), name: global-cma-region, count 64, align 6)

> Indeed, dma_contiguous_default_area can also be set through
> rmem_cma_setup, which then takes the name from DT.
>
I think this is a different case. If DT entry is present we get this:
Reserved memory: created CMA memory pool at 0x98000000, name: name:
linux,cma, size 128 MiB
cma: cma_alloc(cma (ptrval), name: linux,cma, count 64, align 6)

Here we are talking about the default hard-coded name in Kernel code
if DT is not defined.
So, in one of the boards, this DT entry was not present and it shows
as "reserved".

> > I believe on the hikey board its "linux,cma" is the name, so forcing
> > it to reserved would break that.
> >
Yes, everywhere in the DT it's defined as "linux,cma".
You mean this also should be changed to "linux,cma-global-region"
everywhere with this change ?

> > Maybe instead add a compat config option to force the cma name (so x86
> > can set it to "default" if needed)?
>
Yes, having it in config is also a good option instead of hard-coding in Ke=
rnel.
>
> I think we'll just need to leave it as-is.  I with dma-heaps had never
> exposed the name to userspace, but we'll have to l=D1=96ve with it now.

Can you point me to the userspace utility we are talking about here ?
I think we should not worry much about userspace name exposure.
I guess it should fetch whatever is declared in Kernel or DTS, right ?
