Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9EE7849C7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjHVS5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHVS5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:57:20 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B79810B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:57:18 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b962c226ceso75475901fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692730636; x=1693335436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inlF5gsUho4gYjrYe8/Wo40BCJxua4Uvc+Bdc/N+Rj0=;
        b=HlPe2atTgNZzwdRxZlOrGwQL/yyg6LDet4oCcik9FAKxqjwzyJCbBsY8tjzT1EJ57Q
         xfdurN1gaTPOmglpAPw7dCcIlS/oDxMtVx7BSls4Pf3xyXHQ2HYv153rB2s+Gg9rDI/3
         VJKuigKVdW2YoL6npCNefsq4I0oehA9wWGVK49ZKQNMk1cr6n5cJ5AIH7NbrNTuq1O6u
         zNpqyOYpnqG9Uq/aZSNPRAhH2KZPW+8oRn7/ngNhtlk5JSBzG+fyec5H2B8Yq2KR8pxF
         +SCXV19PkwqTsotwPfjeFnNrVIJs1FXpXmnJzg0q/ArOLJVu51cYgywiU5ACPPxwz+Vh
         klFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692730636; x=1693335436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inlF5gsUho4gYjrYe8/Wo40BCJxua4Uvc+Bdc/N+Rj0=;
        b=XjQGNRLXZMB23BbMpS/bjWUBUmrynyGx5c1PBS3ROkdIM858sMqkvhVoWh/44BLK9+
         182M6SvKmMOeUrU0pNICrmvQrOSgCajQmAUBLVXaSDn79YRxAwb1XENzQ0r5GQEgb7y8
         MBGLeEXld5KktTENaxCnm9nfkdMtV4ANfv5cDB0ZicwX2etPfs/k6UuCbSkxhDr7dB/g
         j8TAx8OtKAwDcK/D4kYQdt8RYpHoRM95NjiXXwEGlepUXgj3qZXlitq1dEcS2mqWUv7W
         q/+vGwSYIlHOX7sUoNuIyHwj9i85JpDhzR0fTSyF/M0bU1qSaLff/TkQmM5QEMGTzr24
         c41Q==
X-Gm-Message-State: AOJu0Yw4f/1FnvWYIeoI72498pWfbdg/fqtc9fUQ/5QaBTaDC3BXsGIL
        w5NvKZFR4ejturP55Yr7evWICgA8yXupQY0C/q4=
X-Google-Smtp-Source: AGHT+IHdBh5X7vWjrrb5BdXW3igkF4/n1lbp/VoSjLD+l2XezlJMUmsz7w9oPAXXkT/8Ct67GRInWJkyfpYkAWv2tT0=
X-Received: by 2002:a2e:2c18:0:b0:2b9:c644:414a with SMTP id
 s24-20020a2e2c18000000b002b9c644414amr7481989ljs.46.1692730635900; Tue, 22
 Aug 2023 11:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
 <20230821103225.qntnsotdzuthxn2y@techsingularity.net> <CAF8kJuOsWo5RfDcfnWZfnqYXjf6bkkxdXG1JCwjaEZ1nn29AaA@mail.gmail.com>
In-Reply-To: <CAF8kJuOsWo5RfDcfnWZfnqYXjf6bkkxdXG1JCwjaEZ1nn29AaA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 22 Aug 2023 11:57:04 -0700
Message-ID: <CAADnVQKzzj4f-FPPqmnvMttc=_v7ZXmitc2wgNM0bJpm9FcpsQ@mail.gmail.com>
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

On Tue, Aug 22, 2023 at 10:48=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> Hi Mel,
>
> Adding Alexei to the discussion.
>
> On Mon, Aug 21, 2023 at 3:32=E2=80=AFAM Mel Gorman <mgorman@techsingulari=
ty.net> wrote:
> >
> > On Thu, Aug 17, 2023 at 11:05:22PM -0700, Chris Li wrote:
> > > In this patch series I want to safeguard
> > > the free_pcppage_bulk against change in the
> > > pcp->count outside of this function. e.g.
> > > by BPF program inject on the function tracepoint.
> > >
> > > I break up the patches into two seperate patches
> > > for the safeguard and clean up.
> > >
> > > Hopefully that is easier to review.
> > >
> > > Signed-off-by: Chris Li <chrisl@kernel.org>
> >
> > This sounds like a maintenance nightmare if internal state can be arbit=
rary
> > modified by a BPF program and still expected to work properly in all ca=
ses.
> > Every review would have to take into account "what if a BPF script modi=
fies
> > state behind our back?"

Where did this concern come from?
Since when BPF can modify arbitrary state?

But I wasn't cc-ed on the original patch, so not sure what it attempts to d=
o.
Maybe concern is valid.

> Thanks for the feedback.
>
> I agree that it is hard to support if we allow BPF to change any internal
> stage as a rule.  That is why it is a RFC. Would you consider it case
> by case basis?
> The kernel panic is bad, the first patch is actually very small. I can
> also change it
> to generate warnings if we detect the inconsistent state.

panic and warns because of bpf prog?!
bpf infra takes all the precaution to make sure that bpf progs
can never cause such damage.

>
> How about the second (clean up) patch or Keming's clean up version? I can=
 modify
> it to take out the pcp->count if the verdict is just not supporting
> BPF changing internal
> state at all. I do wish to get rid of the pindex_min and pindex_max.
>
> Thanks
>
> Chris
