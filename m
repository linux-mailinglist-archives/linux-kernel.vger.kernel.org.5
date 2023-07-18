Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D575729E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjGRD7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGRD7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:59:49 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BB518C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:59:48 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-401d1d967beso181751cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689652787; x=1692244787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZy+3C6mOMWOW7moS6HsZ2wLW5MTawFWpL+Xb5Xm0qI=;
        b=lI7o23HgvGwDw1BJ7r5Xx+5/ec2IahtIdXqhwQI79R8IodStn72Gl3qWSqIn3lMd9p
         o6QFnZ2ZHdPWHhVC6Y0eQihFOzZ1rDcHJi9sa4t1uYjxSq/+EbDdOKY1Mkl8708+Gyvh
         SjllvQ/Bw0W+OEbMoqHta7tvOMfAq49nVFtp7HWKahEsvO3HeMWLHDAFmlvSlAH7C6Hz
         f0yqipLrft9P6a3peKj8s92ZL7XXKaS01wvfYoOJUHcXztLAL72sFDCzd7ZTe+SKm2Sf
         oE3e5qR2gt/gtctTTewbYvL2KgpEzUa/fDOfdXsPG0jaG//UcjpimMNRMLVZdrzCEs9y
         xyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689652787; x=1692244787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZy+3C6mOMWOW7moS6HsZ2wLW5MTawFWpL+Xb5Xm0qI=;
        b=M9YeuLSK1SJQR/5rA+S8dyxP7perKxo/NgGGMkzeDvL+XHsqR1OgjBwgdw+/tpi07m
         IrjNwJSI97KVdP2ebZPd9S7cnLJFaKJ8P8Fe2l9lNTvOeGvYMH1NczyGF2OMGUe86DOF
         YG/VyCEzCu9aI6+YCpqKOWSd/S2xOaXtbH6bLAAMj9YvliPdQSJgAvVrqyJxPumLC6U6
         xppjJ7Px1TWZh9gTRqKpAiD4yKeLE0YZCgtz9J0bR5vHMEos0Z/91LlHrmQb+5nFa4Un
         LpsORgqXI72eSFeASluLKk32BZ2VDXk6V1b13snV/g2OqX0nzzw3pSO4pLmQXwuRjivm
         06Zw==
X-Gm-Message-State: ABy/qLaHyQwZ4GNBPTSXw8qSbj06y5rKOj8leLn76ng4D7l2vVCGj/cR
        kxpWZ6WF5zctkO1jOilf3nnxDKhCZi5uQt5mHag7dw==
X-Google-Smtp-Source: APBJJlEh2dgSeIVYrgL83p5LtaliE8RCLJNH/Q8iNQYL1ddj4/ZYbdeCCmlt3cp1zbJkx8qzxCaS4Ytq4JRBdOyhQWE=
X-Received: by 2002:a05:622a:180b:b0:403:b6ff:c0b with SMTP id
 t11-20020a05622a180b00b00403b6ff0c0bmr165387qtc.6.1689652787486; Mon, 17 Jul
 2023 20:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <20230712060144.3006358-4-fengwei.yin@intel.com> <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com> <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
 <d93030e9-938e-f394-8067-a7307f6acd30@intel.com> <045fe36e-ed5b-2b02-a40d-c185796464b2@intel.com>
In-Reply-To: <045fe36e-ed5b-2b02-a40d-c185796464b2@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 17 Jul 2023 21:59:11 -0600
Message-ID: <CAOUHufa63EfXu_5pi8Rs2BQSdfv-x56foH1p8ZtBm5YJTVNBVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 8:07=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
> On 7/17/23 16:12, Yin Fengwei wrote:
> >
> > On 7/17/23 08:35, Yu Zhao wrote:
> >> On Sun, Jul 16, 2023 at 6:00=E2=80=AFPM Yin, Fengwei <fengwei.yin@inte=
l.com> wrote:
> >>>
> >>> On 7/15/2023 2:06 PM, Yu Zhao wrote:
> >>>> There is a problem here that I didn't have the time to elaborate: we
> >>>> can't mlock() a folio that is within the range but not fully mapped
> >>>> because this folio can be on the deferred split queue. When the spli=
t
> >>>> happens, those unmapped folios (not mapped by this vma but are mappe=
d
> >>>> into other vmas) will be stranded on the unevictable lru.
> >>>
> >>> This should be fine unless I missed something. During large folio spl=
it,
> >>> the unmap_folio() will be migrate(anon)/unmap(file) folio. Folio will=
 be
> >>> munlocked in unmap_folio(). So the head/tail pages will be evictable =
always.
> >>
> >> It's close but not entirely accurate: munlock can fail on isolated fol=
ios.
> >
> > I suppose normal 4K page can hit this problem also and following patch =
could
> > fix it:
> No. This patch is not necessary as unevictable folio will not be picked u=
p by
> page reclaim. It's not possible to munlock the isolated folio from lru li=
st.
>
> The possible cases I am ware are: page_migrate, madvise and damon_pa_page=
out and
> lru_gen_look_around. The first three already handle this case correctly b=
y call
>   folio_putback_lru().
>
> If folio is isolated, the split_folio() will just fail. So looks we are f=
ine
> for this corner case. Let me know if I miss something here.

The race is between isolation and munlock -- split_folio() only fails
if a folio is still isolated when it tries to freeze its refcnt, e.g.,
cpu 1      cpu 2
           split_folio()
isolation  unmap_folio()
putback
           freeze refcnt
