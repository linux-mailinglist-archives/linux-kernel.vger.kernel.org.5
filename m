Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1409784C23
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjHVVhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjHVVhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:37:17 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F85CE8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:37:16 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bb8a12e819so77309261fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692740234; x=1693345034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWG+u89MMAHtiBm7y83iu0g0+SiXpFk+lzAlRc4AybQ=;
        b=NYxZXtGFfl4kr/DbeQO9NS4V0Q5C7O6vUyG27wCl1RHj5+GeB50prkqHQglhjBKi65
         X4Mj5wFqzRWyFX9TuKOpBsX0KRldI0+dW70K/b7HbK1w2VIgbLkcvfZZIuogCpOWuNnB
         O7YvhvyTRL+wA+XibMUf0pbXbK8YSgmGN++SrDb0neiXcJzU6CkVGwCEcDDKwBDcAeOv
         BLA4RusqWxapjJvYe6hijnB01BnmtXJlHFOhBi+4EEm9bmT/ii6miMwiGTzpUtp3vc8h
         TFPcwfxLlYX7EmlKH8Po5JdoFuq0w2lbslMSjrO6qE8rcARSEWVuQ2mA6ggyVmvwzo9v
         cF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692740234; x=1693345034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWG+u89MMAHtiBm7y83iu0g0+SiXpFk+lzAlRc4AybQ=;
        b=hI1MFzEXxNTk6CMBG048pQgDOOdX2P0gEPp4Y+NlR85L7OKiq3xmNqVsup2DI85Zrk
         5kU8L9NMdx5JgvAtE94dJY/aVTRUTirBVzU73kK6C0W5J0dds/uaPJkdMbJkAYTJlz01
         zQVRvnoTIt8a5SVDcw9zxhYuaf7FfQWDGENEREccECzgjYnPVJWvqOp5i4wirM5oCB9s
         YH1yGtQzV4NUliOIqcsLfsprMVtIfJBecrAtKyq20RpKPaq39V57vm5Tn+NYG65siOEP
         Y4Po4Rb37ELl8jlxcNfetSYt1cpLNzPHRY9azIaE4gV6JWEsBzAT9F5wcTIV011gG2Qf
         uHYA==
X-Gm-Message-State: AOJu0Yyxj4dC9ne+8x1uQzEp+eB4FgohgS1cqJf21eb+ye8TTUxgf3qg
        3Bmcy9bKYNcfxejBDT9RUouRG5znf6CjeX51mz0=
X-Google-Smtp-Source: AGHT+IGb0jKdWeAqMVlM3HYthIMgASULPBvl5ZUOhUVtxxb/idwG08vSd/5OB0hFPemdM0Nd/Z+x1d/pk3PI+QEAQak=
X-Received: by 2002:a2e:3001:0:b0:2bc:d567:bdbd with SMTP id
 w1-20020a2e3001000000b002bcd567bdbdmr1817825ljw.15.1692740234253; Tue, 22 Aug
 2023 14:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
 <20230821103225.qntnsotdzuthxn2y@techsingularity.net> <CAF8kJuOsWo5RfDcfnWZfnqYXjf6bkkxdXG1JCwjaEZ1nn29AaA@mail.gmail.com>
 <CAADnVQKzzj4f-FPPqmnvMttc=_v7ZXmitc2wgNM0bJpm9FcpsQ@mail.gmail.com> <CAF8kJuOFcVsAWt_sMKvSgw_vpikX0-+T4388pJn_F2-2sW_4Kg@mail.gmail.com>
In-Reply-To: <CAF8kJuOFcVsAWt_sMKvSgw_vpikX0-+T4388pJn_F2-2sW_4Kg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 22 Aug 2023 14:37:02 -0700
Message-ID: <CAADnVQ+e6C4OpWxXu5NAb-kNT0gOyDu6aqUNZ35ZOsa2+s9d7A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] mm/page_alloc: free_pcppages_bulk safeguard
To:     Chris Li <chrisl@kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        baolin.wang@linux.alibaba.com, Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Namhyung Kim <namhyung@google.com>,
        Greg Thelen <gthelen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Sperbeck <jsperbeck@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 2:34=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Alexei,
>
> On Tue, Aug 22, 2023 at 11:57=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Aug 22, 2023 at 10:48=E2=80=AFAM Chris Li <chrisl@kernel.org> w=
rote:
> > >
> > > Hi Mel,
> > >
> > > Adding Alexei to the discussion.
> > >
> > > On Mon, Aug 21, 2023 at 3:32=E2=80=AFAM Mel Gorman <mgorman@techsingu=
larity.net> wrote:
> > > >
> > > > On Thu, Aug 17, 2023 at 11:05:22PM -0700, Chris Li wrote:
> > > > > In this patch series I want to safeguard
> > > > > the free_pcppage_bulk against change in the
> > > > > pcp->count outside of this function. e.g.
> > > > > by BPF program inject on the function tracepoint.
> > > > >
> > > > > I break up the patches into two seperate patches
> > > > > for the safeguard and clean up.
> > > > >
> > > > > Hopefully that is easier to review.
> > > > >
> > > > > Signed-off-by: Chris Li <chrisl@kernel.org>
> > > >
> > > > This sounds like a maintenance nightmare if internal state can be a=
rbitrary
> > > > modified by a BPF program and still expected to work properly in al=
l cases.
> > > > Every review would have to take into account "what if a BPF script =
modifies
> > > > state behind our back?"
> >
> > Where did this concern come from?
> > Since when BPF can modify arbitrary state?
> >
> > But I wasn't cc-ed on the original patch, so not sure what it attempts =
to do.
> > Maybe concern is valid.
>
> Sorry I did not CC you on the original patch submission.  I should.
>
> Here is the link for the 1/2 patch, which has the step to reproduce.
>
> https://lore.kernel.org/linux-mm/20230817-free_pcppages_bulk-v1-1-c14574a=
9f80c@kernel.org/
>
> It is using an older version of the BPF program. That spinlock
> allocation was fixed
> in  commit c66a36af7ba3a628.

No. It was a temp workaround. It was fixed on bpf local storage side later.
